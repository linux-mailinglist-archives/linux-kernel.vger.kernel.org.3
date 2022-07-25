Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7202457FB29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiGYIUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiGYIUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:20:00 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828BA14000
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:19:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b34so7024323ljr.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmOvJ7TU2aN0pPelGFvgzHlfOMqchEtVeIWJWu5ZWWo=;
        b=wrLELC1Lp2J9RVXZS2/Y9yRyzDgMkYxS0bL2c/WhzXXuK0afzTlK6kNm7feVZU+NOM
         LD+xh3/nB1RHSpxPnkONeWBWODxGSNeyD55LKaLMsQoLACT4LT+zh9DC7/MQlrefcMeG
         cHJL/nWIJzyboz+fOLZPo6Plzuihr0ThkovE2z8127+hQ5XjAgJU9dTWH85AnmOEWcLo
         Pltfa8kx4Wvp97vggiqF26aW5ex127fds447DR14DRnb84xNhFjQgalWbOKMmrk83eIl
         GwQAlgq/wMAjYG3a4ottshxoUonRKRXTY4PjUfKhl+Vrwx7gAjb33kY6jFHL+46mqCod
         LQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmOvJ7TU2aN0pPelGFvgzHlfOMqchEtVeIWJWu5ZWWo=;
        b=vVCp3iASxyumCEFpbcBVdo0GdgTPH2FMkg8wlx2OJzTldVXrV8RQhia+54DOw1gfkq
         uSUwnHMlZ592Wz4KMQAMMxRLLGgyJGHcGN+XdfdrkQKgX/XE70z1GF8Iy2Wma7F3rb20
         /EnVOBXAQa5VSC4ojsQ2B7pkJe+MGJGploymlUeBSgcc/1eazJV4hpYFsR7fPNhcBguo
         IeNxxnTJ1c4t9wf4QVxtS2zGk3kqlDxGg/3hPnAb+Ww3qpCaGV2PveG6/Q5Vsc2MvFyp
         duZ/CSlQ14kY6AHRwCut1vG1fuoVbKHjRdyL19CJD7qJOMw5t32D45xOE9RDTP+YK+zL
         MdaQ==
X-Gm-Message-State: AJIora92rvEyUpD9xCfLQdy1Og9EPYeOIUDn/4yJA0ER+tw/ojzWDlTp
        qA/29Xm79ysZwscoesnXPYnhfCJQJJsZ+xlNSEEUIbzNLGTAFQ==
X-Google-Smtp-Source: AGRyM1skOJAtrNlhLRJESyARVRT4D/k8IPfz9+YixQQuEa14gbwdBis2vBDSp4aycNT8mf7K32GjHdZmqua7HkDzqas=
X-Received: by 2002:a2e:895a:0:b0:25d:6815:98ff with SMTP id
 b26-20020a2e895a000000b0025d681598ffmr3667468ljk.189.1658737187589; Mon, 25
 Jul 2022 01:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220704081149.16797-1-mike.leach@linaro.org> <0b493b49-2657-ad5d-465e-d80b62820613@arm.com>
 <CAJ9a7VhXMn+DJ+qgeYRbqgGDm3jV_xNeBGKP=q7eiSe03_7eJw@mail.gmail.com> <393c8470-6538-cebe-1c49-cf22ac51e3c5@arm.com>
In-Reply-To: <393c8470-6538-cebe-1c49-cf22ac51e3c5@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 25 Jul 2022 09:19:36 +0100
Message-ID: <CAJ9a7VicZW0z9fgMObmRKGeNOiW=cjDKG1GHwh3_nLuLd87G-g@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] coresight: Add new API to allocate trace source
 ID values
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        quic_jinlmao@quicinc.com, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Al Grant <Al.Grant@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

On Fri, 22 Jul 2022 at 13:10, James Clark <james.clark@arm.com> wrote:
>
>
>
> On 21/07/2022 14:54, Mike Leach wrote:
> > Hi James,
> >
> > Thanks for looking at this.
> >
> > On Thu, 21 Jul 2022 at 11:27, James Clark <james.clark@arm.com> wrote:
> >>
> >>
> >>
> >> On 04/07/2022 09:11, Mike Leach wrote:
> >>> The current method for allocating trace source ID values to sources is
> >>> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
> >>> The STM is allocated ID 0x1.
> >>>
> >>> This fixed algorithm is used in both the CoreSight driver code, and by
> >>> perf when writing the trace metadata in the AUXTRACE_INFO record.
> >>>
> >>> The method needs replacing as currently:-
> >>> 1. It is inefficient in using available IDs.
> >>> 2. Does not scale to larger systems with many cores and the algorithm
> >>> has no limits so will generate invalid trace IDs for cpu number > 44.
> >>>
> >>> Additionally requirements to allocate additional system IDs on some
> >>> systems have been seen.
> >>>
> >>> This patch set  introduces an API that allows the allocation of trace IDs
> >>> in a dynamic manner.
> >>
> >> I've tested this with various commands like with per-thread mode, attaching,
> >> running the tests and also Carsten's new tests. Apart from the possible
> >> backwards compatibility issue and the minor code comments it looks good to
> >> me.
> >>
> >
> > I've looked at the backwards compatibility issue. At present with the
> > current set
> > (K = kernel drivers, P-rec = perf record, P-rep = perf report)
> > ::
> >
> > K-v1-ids  + P-rec-v1-ids => P-rep-v1 (OK)  P-rep-v2 (OK)
> > K-v1-ids  + P-rec-v2-ids => P-rep-v1 (error message)  P-rep-v2 (fail)
> > K-v2-ids  + P-rec-v1-ids => P-rep-v1 (fail)  P-rep-v2 (fail)
> > K-v2-ids  + P-rec-v2-ids => P-rep-v1 (error message)  P-rep-v2 (OK)
> >
> > So, with a P-rec generating v2 metadata, P rep will cleanly error out.
> > Where the Kernel ID version and the perf report ID version differ,
> > even the P rep v2 will fail, due to the IDs being different in the
> > file and actual drivers. These fails will simply look like no data
> > present.
> >
> > There are two possible fixes that improve this:-
> > A) if the v2 kernel uses a sysfs flag to indicate new ID usage, then
> > if this is missing the new perf record can degrade to using the old
> > algorithm to put IDs directly into metadata as it assumes it is
> > running on a v1 kernel.
> > This fixes things then for the P-rep v2 that can look for this & we
> > know there will be no incoming ID packets.
> > B) P-rep v2 can look for new packets irrespective of incoming metadata
> > version, and if it sees them, override them
> >
> > Compatibility matrix then looks like::
> > K-v1-ids  + P-rec-v1-ids => P-rep-v1 (OK)  P-rep-v2 (OK)
> > K-v1-ids  + P-rec-v2-ids => P-rep-v1 (error message)  P-rep-v2 (OK)
> > K-v2-ids  + P-rec-v1-ids => P-rep-v1 (fail)  P-rep-v2 (OK)
> > K-v2-ids  + P-rec-v2-ids => P-rep-v1 (error message)  P-rep-v2 (OK)
> >
> > There is no solution to using an old version of perf record on a new
> > kernel and getting the old version of perf report to correctly decode
> > the file.
> >
>
> We had a discussion about this last point on the Friday AutoFDO call.

Sorry I missed that - I was on holiday.

> Do you think it's possible to keep the old static ID allocations if
> num_possible_cpus() < Max Trace ID? This is especially important for
> simple perf because Android doesn't even have the more than 128 CPUs
> issue, so technically shouldn't have to have any changes made to it.
>

If android never runs high core count hardware, then that could work.
The actual CPU limit is in fact 47, after which point the static
algorithm fails.

The question arises what do the kernel drivers do then?

The old perf -record will not realise things are about to go wrong,
and continue to blindly allocate incorrect trace IDs.
Realistically the new drivers will then switch to use the previously
unused IDs, whereby they will mismatch with the blindly allocated perf
IDs and the old perf decode process will silently fail to decode any
data with IDs that do not match.

If we also removed the metadata version update that goes alongside the
ID changes, then old perf-reports would continue to try to decode
newer files - again silently failing once the static algorithm has
failed.
Legacy ID allocation support must be added as a kernel CONFIG option -
so that it is up front an obvious to users what is being selected. And
we can output appropriate error messages.

This would be a temporary solution at best as there are upcoming
issues that will need attention:-
1 ) We need to deal with the fact that customers are adding new CS
compatible hardware to their systems, some of which they have
hardcoded trace IDs. These hardware allocations will become
reservations in the dynamic allocator, with no guarantee they will not
clash with the static algorithm.

2) There may be a point in the future where we need to use per Sink ID
allocation.

3) We have an outstanding perf issue with ETE + TRBE which never use
trace IDs - at present decode works here because all the ETE
capabilities on the current systems are identical. Once that changes,
perf will need updating to look at the trace metadata on a CPU number
basis, not on a trace ID basis.

4) Future architecture updates will render newer trace un-decodable by
old perf versions.

The question here is why would Android build an up to date kernel
version with the updated CoreSight drivers, but insist on using an
outdated perf / simpleperf version?

Regards

Mike


> Making the dynamic traceID allocation use the same IDs as before
> whenever possible should allow both old Perf and simpleperf to open
> the file as before and ignore the AUX_OUTPUT_HW_ID packets.
>
> James
>
> > Thoughts?
> >
> > Mike
> >
> >>>
> >>> Architecturally reserved IDs are never allocated, and the system is
> >>> limited to allocating only valid IDs.
> >>>
> >>> Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
> >>> the new API.
> >>>
> >>> For the ETMx.x devices IDs are allocated on certain events
> >>> a) When using sysfs, an ID will be allocated on hardware enable, or a read of
> >>> sysfs TRCTRACEID register and freed when the sysfs reset is written.
> >>>
> >>> b) When using perf, ID is allocated on hardware enable, and freed on
> >>> hardware disable. IDs are communicated using the AUX_OUTPUT_HW_ID packet.
> >>> The ID allocator is notified when perf sessions start and stop
> >>> so CPU based IDs are kept constant throughout any perf session.
> >>>
> >>>
> >>> Note: This patchset breaks backward compatibility for perf record and
> >>> perf report.
> >>>
> >>> Because the method for generating the AUXTRACE_INFO meta data has
> >>> changed, using an older perf record will result in metadata that
> >>> does not match the trace IDs used in the recorded trace data.
> >>> This mismatch will cause subsequent decode to fail.
> >>>
> >>> The version of the AUXTRACE_INFO has been updated to reflect the fact that
> >>> the trace source IDs are no longer present in the metadata. This will
> >>> mean older versions of perf report cannot decode the file.
> >>>
> >>> Applies to coresight/next [c06475910b52]
> >>> Tested on DB410c
> >>>
> >>> Changes since v1:
> >>> (after feedback & discussion with Mathieu & Suzuki).
> >>>
> >>> 1) API has changed. The global trace ID map is managed internally, so it
> >>> is no longer passed in to the API functions.
> >>>
> >>> 2) perf record does not use sysfs to find the trace IDs. These are now
> >>> output as AUX_OUTPUT_HW_ID events. The drivers, perf record, and perf report
> >>> have been updated accordingly to generate and handle these events.
> >>>
> >>> Mike Leach (13):
> >>>   coresight: trace-id: Add API to dynamically assign Trace ID values
> >>>   coresight: trace-id: update CoreSight core to use Trace ID API
> >>>   coresight: stm: Update STM driver to use Trace ID API
> >>>   coresight: etm4x: Update ETM4 driver to use Trace ID API
> >>>   coresight: etm3x: Update ETM3 driver to use Trace ID API
> >>>   coresight: etmX.X: stm: Remove unused legacy source Trace ID ops
> >>>   coresight: perf: traceid: Add perf notifiers for Trace ID
> >>>   perf: cs-etm: Move mapping of Trace ID and cpu into helper function
> >>>   perf: cs-etm: Update record event to use new Trace ID protocol
> >>>   kernel: events: Export perf_report_aux_output_id()
> >>>   perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
> >>>   coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
> >>>   coresight: trace-id: Add debug & test macros to Trace ID allocation
> >>>
> >>>  drivers/hwtracing/coresight/Makefile          |   2 +-
> >>>  drivers/hwtracing/coresight/coresight-core.c  |  49 +---
> >>>  .../hwtracing/coresight/coresight-etm-perf.c  |  17 ++
> >>>  drivers/hwtracing/coresight/coresight-etm.h   |   3 +-
> >>>  .../coresight/coresight-etm3x-core.c          |  85 +++---
> >>>  .../coresight/coresight-etm3x-sysfs.c         |  28 +-
> >>>  .../coresight/coresight-etm4x-core.c          |  65 ++++-
> >>>  .../coresight/coresight-etm4x-sysfs.c         |  32 ++-
> >>>  drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
> >>>  drivers/hwtracing/coresight/coresight-stm.c   |  49 +---
> >>>  .../hwtracing/coresight/coresight-trace-id.c  | 263 ++++++++++++++++++
> >>>  .../hwtracing/coresight/coresight-trace-id.h  |  65 +++++
> >>>  include/linux/coresight-pmu.h                 |  31 ++-
> >>>  include/linux/coresight.h                     |   3 -
> >>>  kernel/events/core.c                          |   1 +
> >>>  tools/include/linux/coresight-pmu.h           |  31 ++-
> >>>  tools/perf/arch/arm/util/cs-etm.c             |  21 +-
> >>>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   9 +
> >>>  tools/perf/util/cs-etm.c                      | 220 +++++++++++++--
> >>>  tools/perf/util/cs-etm.h                      |  14 +-
> >>>  20 files changed, 784 insertions(+), 207 deletions(-)
> >>>  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
> >>>  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> >>>
> >
> >
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
