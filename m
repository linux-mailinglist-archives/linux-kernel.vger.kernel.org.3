Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2D659161F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiHLTuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbiHLTub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:50:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3473055E;
        Fri, 12 Aug 2022 12:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0A2B60FDE;
        Fri, 12 Aug 2022 19:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7944C433D6;
        Fri, 12 Aug 2022 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660333829;
        bh=Aadwi9ysXgU0mQsdevszz50JIvn2K0rNkzfoHX1HNp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvysOGncr2kSJbxrbvptLoIU7Z3W6Rb7kVH7Rq9cOm+BPOa8map5vJE8nJQIWlO3v
         oCPlTRux0KgZ9kAQ+F0wVA9PYFGo5dWvVQS2h6RHZmnkBWSYcC6CpBnnxIirvAXXH/
         vH2yG5EDWgddqYNxGmKKtFvwAJFxmXiaHUzDodZwo1UtSb6UcWdA6ukWtE5FWUXe47
         J+OqC1V3rva47viuAs5KUvqnN8NvYxqjjGwcQWMycIGiAdU/UBSvSByTuPT+L9c1C7
         i0spJv1wG0eNkEcFfQrWSnE3K1tQl5n6ykBC9AkaIeCy6/3XgXEDH0JLvUcDj0Vv0/
         C/CeeNPWXx2pg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6E114035A; Fri, 12 Aug 2022 16:50:26 -0300 (-03)
Date:   Fri, 12 Aug 2022 16:50:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com
Subject: Re: [PATCH v3 00/13] coresight: Add new API to allocate trace source
 ID values
Message-ID: <YvavAqZfO2nFg3LF@kernel.org>
References: <20220809223401.24599-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809223401.24599-1-mike.leach@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 09, 2022 at 11:33:48PM +0100, Mike Leach escreveu:
> The current method for allocating trace source ID values to sources is
> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
> The STM is allocated ID 0x1.

So I'll wait for the kernel bits to get into the ARM architecture tree
to then process the userspace bits.

Would be great to have Tested-by/Reviewed-by from pehole actually
testing these patches on the hardware where these features are
available.

- Arnaldo
 
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
> -- 
> 2.17.1

-- 

- Arnaldo
