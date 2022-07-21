Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87B857CCBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiGUNzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGUNy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:54:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB2027CE7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:54:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a13so1735455ljr.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Svh48ykFz6FZPDaJbvr0X3QSVsa1sHd8+kMWlEiIAc=;
        b=xx+rHMyP4qPgY9HXMXMjJoMr4m8zjaLGA5pkqOlRz9/E4CprEqUp7wnTEkEwqC7jRf
         Rm6vMlKGPQHp1qQsgmLb4AzzH27nKUyxSPUPNIEaJM/z79tNBlxVvxKzployPgqEG/sp
         szA2oLqalVPZIXBdTCnRe/Z2zKzqhEQARyd7anY/FxP3Pod0oYOzKkkO0IapXvQ6Es0j
         vkG3YDf42d0pX1a0wzt23Zpn9XDTlIl/+5Nvk0Sk7ktAyDzMqWvlFiA2netx+ViQBQyo
         KaLa7FtVB0XIvR6tQrwWEFYjJNDliApoezriVyrRMoqliL12Lia3jNY0DwILaVuDDY5t
         2rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Svh48ykFz6FZPDaJbvr0X3QSVsa1sHd8+kMWlEiIAc=;
        b=1Qmnu3p6rZZqB5toOe8zCizEmZsnZtavlcKI11bvwk7iWXfZmSWTAQI0GaO2dfeoc5
         XUsUjy6tcF5H6c/99IH4bB6k1KnE29nnMu9jKa5KmD04XN6gLbq6EOcUu0Hi5ytu4ZqH
         1AGOT+Afky58d5NP8fBTONWh3N2nB69fRRMPLp8IEUqhbI6qI+kaUbbWKaACwdnTxro6
         SzfjDKly1mBipUJDp1sv6YPUR7BqcQLS8+2oXs7Fw0UNde7QL8yxwBu4G/fqUjMmxH7K
         sXrh2DT4VWFb4STLvBTqR6PBvK8mR1R6ML580c82iDCqxIr0ZQFYwNaaN4xHUOSEuZ95
         vvBg==
X-Gm-Message-State: AJIora8PB8lOlLkuSxmtHABFjK7xVCuHoNYlfy2nFRYz0s0qBF2skJXh
        z4CGWLHKg7ZQtJocA4FZhKidycohuN4bEG6IJ7rSww==
X-Google-Smtp-Source: AGRyM1vSkGgyIiZxk3eGrerbp2z+/RiOJTriDdXdltxBDPXUwqJLfvQ32oO4Brfu6P2UqeUw/3u9C22AuLJZUo6eHPo=
X-Received: by 2002:a2e:895a:0:b0:25d:6815:98ff with SMTP id
 b26-20020a2e895a000000b0025d681598ffmr18164174ljk.189.1658411695787; Thu, 21
 Jul 2022 06:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220704081149.16797-1-mike.leach@linaro.org> <0b493b49-2657-ad5d-465e-d80b62820613@arm.com>
In-Reply-To: <0b493b49-2657-ad5d-465e-d80b62820613@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 21 Jul 2022 14:54:44 +0100
Message-ID: <CAJ9a7VhXMn+DJ+qgeYRbqgGDm3jV_xNeBGKP=q7eiSe03_7eJw@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] coresight: Add new API to allocate trace source
 ID values
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        quic_jinlmao@quicinc.com, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thanks for looking at this.

On Thu, 21 Jul 2022 at 11:27, James Clark <james.clark@arm.com> wrote:
>
>
>
> On 04/07/2022 09:11, Mike Leach wrote:
> > The current method for allocating trace source ID values to sources is
> > to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
> > The STM is allocated ID 0x1.
> >
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
>
> I've tested this with various commands like with per-thread mode, attaching,
> running the tests and also Carsten's new tests. Apart from the possible
> backwards compatibility issue and the minor code comments it looks good to
> me.
>

I've looked at the backwards compatibility issue. At present with the
current set
(K = kernel drivers, P-rec = perf record, P-rep = perf report)
::

K-v1-ids  + P-rec-v1-ids => P-rep-v1 (OK)  P-rep-v2 (OK)
K-v1-ids  + P-rec-v2-ids => P-rep-v1 (error message)  P-rep-v2 (fail)
K-v2-ids  + P-rec-v1-ids => P-rep-v1 (fail)  P-rep-v2 (fail)
K-v2-ids  + P-rec-v2-ids => P-rep-v1 (error message)  P-rep-v2 (OK)

So, with a P-rec generating v2 metadata, P rep will cleanly error out.
Where the Kernel ID version and the perf report ID version differ,
even the P rep v2 will fail, due to the IDs being different in the
file and actual drivers. These fails will simply look like no data
present.

There are two possible fixes that improve this:-
A) if the v2 kernel uses a sysfs flag to indicate new ID usage, then
if this is missing the new perf record can degrade to using the old
algorithm to put IDs directly into metadata as it assumes it is
running on a v1 kernel.
This fixes things then for the P-rep v2 that can look for this & we
know there will be no incoming ID packets.
B) P-rep v2 can look for new packets irrespective of incoming metadata
version, and if it sees them, override them

Compatibility matrix then looks like::
K-v1-ids  + P-rec-v1-ids => P-rep-v1 (OK)  P-rep-v2 (OK)
K-v1-ids  + P-rec-v2-ids => P-rep-v1 (error message)  P-rep-v2 (OK)
K-v2-ids  + P-rec-v1-ids => P-rep-v1 (fail)  P-rep-v2 (OK)
K-v2-ids  + P-rec-v2-ids => P-rep-v1 (error message)  P-rep-v2 (OK)

There is no solution to using an old version of perf record on a new
kernel and getting the old version of perf report to correctly decode
the file.

Thoughts?

Mike

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
> > b) When using perf, ID is allocated on hardware enable, and freed on
> > hardware disable. IDs are communicated using the AUX_OUTPUT_HW_ID packet.
> > The ID allocator is notified when perf sessions start and stop
> > so CPU based IDs are kept constant throughout any perf session.
> >
> >
> > Note: This patchset breaks backward compatibility for perf record and
> > perf report.
> >
> > Because the method for generating the AUXTRACE_INFO meta data has
> > changed, using an older perf record will result in metadata that
> > does not match the trace IDs used in the recorded trace data.
> > This mismatch will cause subsequent decode to fail.
> >
> > The version of the AUXTRACE_INFO has been updated to reflect the fact that
> > the trace source IDs are no longer present in the metadata. This will
> > mean older versions of perf report cannot decode the file.
> >
> > Applies to coresight/next [c06475910b52]
> > Tested on DB410c
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
> >   coresight: trace-id: update CoreSight core to use Trace ID API
> >   coresight: stm: Update STM driver to use Trace ID API
> >   coresight: etm4x: Update ETM4 driver to use Trace ID API
> >   coresight: etm3x: Update ETM3 driver to use Trace ID API
> >   coresight: etmX.X: stm: Remove unused legacy source Trace ID ops
> >   coresight: perf: traceid: Add perf notifiers for Trace ID
> >   perf: cs-etm: Move mapping of Trace ID and cpu into helper function
> >   perf: cs-etm: Update record event to use new Trace ID protocol
> >   kernel: events: Export perf_report_aux_output_id()
> >   perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
> >   coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
> >   coresight: trace-id: Add debug & test macros to Trace ID allocation
> >
> >  drivers/hwtracing/coresight/Makefile          |   2 +-
> >  drivers/hwtracing/coresight/coresight-core.c  |  49 +---
> >  .../hwtracing/coresight/coresight-etm-perf.c  |  17 ++
> >  drivers/hwtracing/coresight/coresight-etm.h   |   3 +-
> >  .../coresight/coresight-etm3x-core.c          |  85 +++---
> >  .../coresight/coresight-etm3x-sysfs.c         |  28 +-
> >  .../coresight/coresight-etm4x-core.c          |  65 ++++-
> >  .../coresight/coresight-etm4x-sysfs.c         |  32 ++-
> >  drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
> >  drivers/hwtracing/coresight/coresight-stm.c   |  49 +---
> >  .../hwtracing/coresight/coresight-trace-id.c  | 263 ++++++++++++++++++
> >  .../hwtracing/coresight/coresight-trace-id.h  |  65 +++++
> >  include/linux/coresight-pmu.h                 |  31 ++-
> >  include/linux/coresight.h                     |   3 -
> >  kernel/events/core.c                          |   1 +
> >  tools/include/linux/coresight-pmu.h           |  31 ++-
> >  tools/perf/arch/arm/util/cs-etm.c             |  21 +-
> >  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   9 +
> >  tools/perf/util/cs-etm.c                      | 220 +++++++++++++--
> >  tools/perf/util/cs-etm.h                      |  14 +-
> >  20 files changed, 784 insertions(+), 207 deletions(-)
> >  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
> >  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
