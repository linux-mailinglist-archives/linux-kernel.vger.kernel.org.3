Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C8C5AD075
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbiIEKpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIEKpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:45:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D34531EEEF;
        Mon,  5 Sep 2022 03:44:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D87CAD6E;
        Mon,  5 Sep 2022 03:45:04 -0700 (PDT)
Received: from [10.57.16.151] (unknown [10.57.16.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 365873F7B4;
        Mon,  5 Sep 2022 03:44:57 -0700 (PDT)
Message-ID: <37ad0c68-55ad-2bac-b401-2dc26ad9ca3a@arm.com>
Date:   Mon, 5 Sep 2022 11:44:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 00/13] coresight: Add new API to allocate trace source
 ID values
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        quic_jinlmao@quicinc.com
References: <20220823091009.14121-1-mike.leach@linaro.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220823091009.14121-1-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2022 10:09, Mike Leach wrote:
> The current method for allocating trace source ID values to sources is
> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
> The STM is allocated ID 0x1.
> 
> This fixed algorithm is used in both the CoreSight driver code, and by
> perf when writing the trace metadata in the AUXTRACE_INFO record.
> 
> The method needs replacing as currently:-
> 1. It is inefficient in using available IDs.
> 2. Does not scale to larger systems with many cores and the algorithm
> has no limits so will generate invalid trace IDs for cpu number > 44.
> 
> Additionally requirements to allocate additional system IDs on some
> systems have been seen.
> 
> This patch set  introduces an API that allows the allocation of trace IDs
> in a dynamic manner.
> 
> Architecturally reserved IDs are never allocated, and the system is
> limited to allocating only valid IDs.
> 
> Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
> the new API.
> 
> For the ETMx.x devices IDs are allocated on certain events
> a) When using sysfs, an ID will be allocated on hardware enable, or a read of
> sysfs TRCTRACEID register and freed when the sysfs reset is written.
> 
> b) When using perf, ID is allocated on during setup AUX event, and freed on
> event free. IDs are communicated using the AUX_OUTPUT_HW_ID packet.
> The ID allocator is notified when perf sessions start and stop
> so CPU based IDs are kept constant throughout any perf session.
> 
> 
> Note: This patchset breaks some backward compatibility for perf record and
> perf report.
> 
> The version of the AUXTRACE_INFO has been updated to reflect the fact that
> the trace source IDs are generated differently. This will
> mean older versions of perf report cannot decode the newer file.
> 
> Applies to coresight/next [4d45bc82df66]
> Tested on DB410c
> 

Tested-by: James Clark <james.clark@arm.com>

Tested on N1SDP. Checked new Perf on new and old kernels. Confirmed that
HW_ID packets are output, decoding still looks good in system-wide,
per-thread modes.

> Changes since v3:
> 1) Fixed aarch32 build error in ETM3.x driver.
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Changes since v2:
> 1) Improved backward compatibility: (requested by James)
> 
> Using the new version of perf on an old kernel will generate a usable file
> legacy metadata values are set by the new perf and will be used if mew
> ID packets are not present in the file.
> 
> Using an older version of perf / simpleperf on an updated kernel may still
> work. The trace ID allocator has been updated to use the legacy ID values
> where possible, so generated file and used trace IDs will match up to the
> point where the legacy algorithm is broken anyway.
> 
> 2) Various changes to the ID allocator and ID packet format.
> (suggested by Suzuki)
> 
> 3) per CPU ID info in allocator now stored as atomic type to allow a passive read
> without taking the allocator spinlock. perf flow now allocates and releases ID
> values in setup_aux / free_event. Device enable and event enable use the passive
> read to set the allocated values. This simplifies the locking mechanisms on the
> perf run and fixes issues that arose with locking dependencies.
> 
> Changes since v1:
> (after feedback & discussion with Mathieu & Suzuki).
> 
> 1) API has changed. The global trace ID map is managed internally, so it
> is no longer passed in to the API functions.
> 
> 2) perf record does not use sysfs to find the trace IDs. These are now
> output as AUX_OUTPUT_HW_ID events. The drivers, perf record, and perf report
> have been updated accordingly to generate and handle these events.
> 
> Mike Leach (13):
>   coresight: trace-id: Add API to dynamically assign Trace ID values
>   coresight: Remove obsolete Trace ID unniqueness checks
>   coresight: stm: Update STM driver to use Trace ID API
>   coresight: etm4x: Update ETM4 driver to use Trace ID API
>   coresight: etm3x: Update ETM3 driver to use Trace ID API
>   coresight: etmX.X: stm: Remove trace_id() callback
>   coresight: perf: traceid: Add perf notifiers for Trace ID
>   perf: cs-etm: Move mapping of Trace ID and cpu into helper function
>   perf: cs-etm: Update record event to use new Trace ID protocol
>   kernel: events: Export perf_report_aux_output_id()
>   perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
>   coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
>   coresight: trace-id: Add debug & test macros to Trace ID allocation
> 
>  drivers/hwtracing/coresight/Makefile          |   2 +-
>  drivers/hwtracing/coresight/coresight-core.c  |  49 +--
>  .../hwtracing/coresight/coresight-etm-perf.c  |  23 ++
>  drivers/hwtracing/coresight/coresight-etm.h   |   3 +-
>  .../coresight/coresight-etm3x-core.c          |  92 +++--
>  .../coresight/coresight-etm3x-sysfs.c         |  27 +-
>  .../coresight/coresight-etm4x-core.c          |  79 ++++-
>  .../coresight/coresight-etm4x-sysfs.c         |  27 +-
>  drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
>  drivers/hwtracing/coresight/coresight-stm.c   |  49 +--
>  .../hwtracing/coresight/coresight-trace-id.c  | 266 ++++++++++++++
>  .../hwtracing/coresight/coresight-trace-id.h  |  78 +++++
>  include/linux/coresight-pmu.h                 |  35 +-
>  include/linux/coresight.h                     |   3 -
>  kernel/events/core.c                          |   1 +
>  tools/include/linux/coresight-pmu.h           |  48 ++-
>  tools/perf/arch/arm/util/cs-etm.c             |  21 +-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +
>  tools/perf/util/cs-etm.c                      | 331 +++++++++++++++---
>  tools/perf/util/cs-etm.h                      |  14 +-
>  20 files changed, 933 insertions(+), 225 deletions(-)
>  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> 
