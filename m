Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A3E595D38
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiHPNZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbiHPNZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:25:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8D787685
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:25:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso9378320wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PblUwHy5mn8FwoYRh4mjjYaylnUC4/ptH+gU2jHD3ZM=;
        b=l06UJXi0GNQdmRGdCUouJQq/FWDXBbfTCzhaus9QvtDx01UP858Q1+rGbktzjvwXpJ
         ffQ4cEhYksF3XAnRfqn5txyB0dlnHYRcN1dQM95b4oVfArVtIQceqS1eCxvPWLcpnEKu
         m5tCP5KDWFQdflTOYL98sUNWU/EwBrstDBNqK0HXsZajGxJ+I+pG+uSvMXpOYRgzSskh
         42fD/Uzd9f+UFk4reJA1oE4Jh8EzDuBvlnLtimQ5XxtZIU1wgWnkU79NWRe4wpBoGTie
         10NUOTlzc1i4YFHT+1k9SHZeITsWceJR+7ha/oGCmIVurnPinnNfqAAI3j5AYjc3TJb2
         TuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PblUwHy5mn8FwoYRh4mjjYaylnUC4/ptH+gU2jHD3ZM=;
        b=ImElbmKYkthhzWAW6VLMFE9Vcdw+HygOjYs6h8rmKXRvsEq4S+4sT1gONsMn79XSZ7
         PI4Kg7E3OfhlMTDar5u2Lghl8SdXpPK+xutOhu1keZlsF71S4/k+YcDLkBNCFdeakL/l
         Motl9/Sd9WgKqDx0OPaaFdpjfHixcIz2w/9/ayLxgVog26DahnPtRMPV6ZsLD65yLEl4
         PQutgJ6wbcpEXWxzoyfy89MHcLbT931nsT8ghxcL+x276++89lXSynY1OtxxMONQGnBG
         r0lyDfLZtOBMxYCY9UvjoS8QipKnru8UAn8LHOH0Es3chxLqU0vCUBZOcGLe7kn6S2MQ
         4ZBA==
X-Gm-Message-State: ACgBeo3cGs4B0p/a25ouZLEbDTeKHJDWLfZmwgj26epTJwmuEhUaApsg
        fGuLPCwPaH2XWZhIl++lw6dkMHEDf3Ymyk8vdGRpVQ==
X-Google-Smtp-Source: AA6agR7gqSpC9S713yep8IGPS4LS21XT520fYnxOl41VWm6yamI7CxxP4jp6z4g8Z7fIRcQZ7kofpdY5mpw+oIazdy8=
X-Received: by 2002:a05:600c:25ce:b0:3a5:a3b7:bbfe with SMTP id
 14-20020a05600c25ce00b003a5a3b7bbfemr20298781wml.115.1660656341549; Tue, 16
 Aug 2022 06:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
 <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com>
 <CAM9d7cgWXP2s25XUM90=b5Eaojutxi=LobkqrUkRoF5gek4DPQ@mail.gmail.com> <edd637d1-e85c-bc18-a8a2-8aa63d02146f@intel.com>
In-Reply-To: <edd637d1-e85c-bc18-a8a2-8aa63d02146f@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 16 Aug 2022 06:25:28 -0700
Message-ID: <CAP-5=fWRNO+dmrnq_3a-L6Vdfd2i3oEB8y2+7F2ik7Lc35s5Pg@mail.gmail.com>
Subject: Re: perf tools man pages on the web
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 11:05 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 16/08/22 08:07, Namhyung Kim wrote:
> > Hi Ian and Adrian,
> >
> > On Mon, Aug 15, 2022 at 7:56 AM Ian Rogers <irogers@google.com> wrote:
> >>
> >> On Mon, Aug 15, 2022 at 5:05 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>
> >>> Hi
> >>>
> >>> I notice man pages on man7.org e.g.
> >>>
> >>>         https://www.man7.org/linux/man-pages/man1/perf.1.html
> >>>
> >>> do not get updated every release, and I wondered if the perf tools
> >>> man pages should also be under:
> >>>
> >>>         https://docs.kernel.org/tools/index.html
> >>>
> >>> Thoughts?
> >>
> >> Sounds good to me. I'm assuming it would be some kind of build step
> >> that would take the man pages and add them to what linux-doc needs?
> >
> > I guess it's the RST format.  I'm not sure if there's a converter
> > from asciidoc to RST.
>
> Could use the html files that are already generated by:
>
>         make -C perf/tools html

A lot of the man page makefile code comes from git and wasn't in great
shape the last I looked [1]. I believe that would be true for the HTML
output. As there are existing dependencies on rst2man for BPF [2], I
think it'd be cleaner to migrate all the man pages to rst format with
new man page build rules using rst2man. Wdyt?

Thanks,
Ian

[1] https://lore.kernel.org/all/20210715013343.2286699-1-irogers@google.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/linux/bpf.h#n1538

> >                        Anyway having the perf man pages in the
> > tools section looks good.
> >
> >>
> >> Fwiw, there has been some effort to try to improve the wiki:
> >> https://perf.wiki.kernel.org/index.php/Main_Page
> >> For example, the useful links are now broken apart and have more
> >> links, there is a work-in-progress glossary. Perhaps there can be some
> >> guidance on what to capture and where.
> >
> > Thanks for working on this.  I really need to take a look...
> >
> > Thanks,
> > Namhyung
>
