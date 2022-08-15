Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DA8593E01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbiHOUeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346145AbiHOUad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:30:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FEA3D70
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:04:36 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x10so8512852ljq.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ul8IHw4RrluaYwczzAKxTYGxJ51uPLM0qDTfe069M8Y=;
        b=jC407XRH9JG9f3FPdW1khnxw1sRd6sA0ltG/8LqR7aYsypz0GGDc2TQ6wPFUBULScI
         wXaHQBHoKdDs4fsr7oc/H0pg/+7MGv4d1AtaTDNWf7NJrD7GLMj5GagL5jO8GfOyRiqK
         NbBXK9uVxjWazbaM9CVau0oG5Hm9Snz87eWClNKnZh5QBwDqkvQ6Px4Tl5VqCRt4N0g+
         ku8y2p0Hwg7O5T/tmejGQA38Q/Dvxg8MOzSbVjmjI2Um8IwfakpoYvXagc01zJQ0fVLw
         Y0pMotsVtR09VXwPWHQflEhYe3C4u7UVuLGEqpiRX/LtbLoMExRvXQP0LG1Man6uycGr
         9Ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ul8IHw4RrluaYwczzAKxTYGxJ51uPLM0qDTfe069M8Y=;
        b=eVXifyAhq8iaYd6Da20mG3fXKKyM7oZYNjnKjOB+No19EZl8iBDIz7Oqr9KgT02fm4
         K+X5Q87PHjR/T4cQFeD8T1qyEBiG0o4O0MM2tCbanQIMvFxXaw/QtsEMWNpFSIHGmnCd
         U0c1QIzjTXLLlKG8QWDnBOW5XBmDRcRlEMJW0kGmNlCxvvfG81t3kXAD+KTaIylEipa7
         sdafn7eORcaFT3z5AQBBv1JAjyw+9GmGGnRD5xdTiV5oeaEPG6xcjMapRVpTGXDt1HEY
         1p2pT5+/LoXOk+/G0DTpT4NM/Oyq4IxttFcYBYe1kbpyFkSwmS09iS2Hn+n+9DY931j0
         Js7w==
X-Gm-Message-State: ACgBeo0dIAc9mo8tshVun7IQDQX4+dxI2vKFukH6aT3Ej7sZISunZpFI
        800cZtcnaVdvSL56wEGcEX91reUHvXSkvlJ321Rb4w==
X-Google-Smtp-Source: AA6agR4jPuoXOrAbdtUck3G5EGFGiezlZT4chWtrkQI+p+otQEHTReDzEae+kLibqiW73pDCK6p8NesdrqCzRD4ZMK4=
X-Received: by 2002:a05:651c:903:b0:25d:e732:6409 with SMTP id
 e3-20020a05651c090300b0025de7326409mr5349254ljq.314.1660590273952; Mon, 15
 Aug 2022 12:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220809223401.24599-1-mike.leach@linaro.org> <YvavAqZfO2nFg3LF@kernel.org>
In-Reply-To: <YvavAqZfO2nFg3LF@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 15 Aug 2022 20:04:22 +0100
Message-ID: <CAJ9a7VhmdEN14NfTfw8ioU=eZrGedhOdenFN85rbMur_OGAEZg@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] coresight: Add new API to allocate trace source
 ID values
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, 12 Aug 2022 at 20:50, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Tue, Aug 09, 2022 at 11:33:48PM +0100, Mike Leach escreveu:
> > The current method for allocating trace source ID values to sources is
> > to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
> > The STM is allocated ID 0x1.
>
> So I'll wait for the kernel bits to get into the ARM architecture tree
> to then process the userspace bits.
>
> Would be great to have Tested-by/Reviewed-by from pehole actually
> testing these patches on the hardware where these features are
> available.
>
Agreed, although the issue is not hardware - this is a fix of a
software issue that just happens to manifest on more modern hardware,
though can be tested on anything.

That said, you should wait for v4 as the kernel test bot has picked
something up that requires attention.

Thanks

Mike

> - Arnaldo
>
> > This fixed algorithm is used in both the CoreSight driver code, and by
> > perf when writing the trace metadata in the AUXTRACE_INFO record.
> >
> > The method needs replacing as currently:-
> > 1. It is inefficient in using available IDs.
> > 2. Does not scale to larger systems with many cores and the algorithm
> > has no limits so will generate invalid trace IDs for cpu number > 44.
> >
> > Additionally requirements to allocate additional system IDs on some
> > systems have been seen.
> >
> > This patch set  introduces an API that allows the allocation of trace IDs
> > in a dynamic manner.
> >
> > Architecturally reserved IDs are never allocated, and the system is
> > limited to allocating only valid IDs.
> >
> > Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
> > the new API.
> >
> > For the ETMx.x devices IDs are allocated on certain events
> > a) When using sysfs, an ID will be allocated on hardware enable, or a read of
> > sysfs TRCTRACEID register and freed when the sysfs reset is written.
> >
> > b) When using perf, ID is allocated on during setup AUX event, and freed on
> > event free. IDs are communicated using the AUX_OUTPUT_HW_ID packet.
> > The ID allocator is notified when perf sessions start and stop
> > so CPU based IDs are kept constant throughout any perf session.
> >
> >
> > Note: This patchset breaks some backward compatibility for perf record and
> > perf report.
> >
> > The version of the AUXTRACE_INFO has been updated to reflect the fact that
> > the trace source IDs are generated differently. This will
> > mean older versions of perf report cannot decode the newer file.
> >
> > Applies to coresight/next [4d45bc82df66]
> > Tested on DB410c
> >
> > Changes since v2:
> > 1) Improved backward compatibility: (requested by James)
> >
> > Using the new version of perf on an old kernel will generate a usable file
> > legacy metadata values are set by the new perf and will be used if mew
> > ID packets are not present in the file.
> >
> > Using an older version of perf / simpleperf on an updated kernel may still
> > work. The trace ID allocator has been updated to use the legacy ID values
> > where possible, so generated file and used trace IDs will match up to the
> > point where the legacy algorithm is broken anyway.
> >
> > 2) Various changes to the ID allocator and ID packet format.
> > (suggested by Suzuki)
> >
> > 3) per CPU ID info in allocator now stored as atomic type to allow a passive read
> > without taking the allocator spinlock. perf flow now allocates and releases ID
> > values in setup_aux / free_event. Device enable and event enable use the passive
> > read to set the allocated values. This simplifies the locking mechanisms on the
> > perf run and fixes issues that arose with locking dependencies.
> >
> > Changes since v1:
> > (after feedback & discussion with Mathieu & Suzuki).
> >
> > 1) API has changed. The global trace ID map is managed internally, so it
> > is no longer passed in to the API functions.
> >
> > 2) perf record does not use sysfs to find the trace IDs. These are now
> > output as AUX_OUTPUT_HW_ID events. The drivers, perf record, and perf report
> > have been updated accordingly to generate and handle these events.
> >
> > Mike Leach (13):
> >   coresight: trace-id: Add API to dynamically assign Trace ID values
> >   coresight: Remove obsolete Trace ID unniqueness checks
> >   coresight: stm: Update STM driver to use Trace ID API
> >   coresight: etm4x: Update ETM4 driver to use Trace ID API
> >   coresight: etm3x: Update ETM3 driver to use Trace ID API
> >   coresight: etmX.X: stm: Remove trace_id() callback
> >   coresight: perf: traceid: Add perf notifiers for Trace ID
> >   perf: cs-etm: Move mapping of Trace ID and cpu into helper function
> >   perf: cs-etm: Update record event to use new Trace ID protocol
> >   kernel: events: Export perf_report_aux_output_id()
> >   perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
> >   coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
> >   coresight: trace-id: Add debug & test macros to Trace ID allocation
> >
> >  drivers/hwtracing/coresight/Makefile          |   2 +-
> >  drivers/hwtracing/coresight/coresight-core.c  |  49 +--
> >  .../hwtracing/coresight/coresight-etm-perf.c  |  23 ++
> >  drivers/hwtracing/coresight/coresight-etm.h   |   3 +-
> >  .../coresight/coresight-etm3x-core.c          |  92 +++--
> >  .../coresight/coresight-etm3x-sysfs.c         |  27 +-
> >  .../coresight/coresight-etm4x-core.c          |  79 ++++-
> >  .../coresight/coresight-etm4x-sysfs.c         |  27 +-
> >  drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
> >  drivers/hwtracing/coresight/coresight-stm.c   |  49 +--
> >  .../hwtracing/coresight/coresight-trace-id.c  | 266 ++++++++++++++
> >  .../hwtracing/coresight/coresight-trace-id.h  |  78 +++++
> >  include/linux/coresight-pmu.h                 |  35 +-
> >  include/linux/coresight.h                     |   3 -
> >  kernel/events/core.c                          |   1 +
> >  tools/include/linux/coresight-pmu.h           |  48 ++-
> >  tools/perf/arch/arm/util/cs-etm.c             |  21 +-
> >  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +
> >  tools/perf/util/cs-etm.c                      | 331 +++++++++++++++---
> >  tools/perf/util/cs-etm.h                      |  14 +-
> >  20 files changed, 933 insertions(+), 225 deletions(-)
> >  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
> >  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> >
> > --
> > 2.17.1
>
> --
>
> - Arnaldo



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
