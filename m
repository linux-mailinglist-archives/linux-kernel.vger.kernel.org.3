Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5185AF36C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIFSQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIFSQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:16:00 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D6175B6;
        Tue,  6 Sep 2022 11:15:59 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so8591875otd.12;
        Tue, 06 Sep 2022 11:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hBUXfmibKdlSbtIrqsYrNBA32p96PcJy+wSALtFh9OU=;
        b=Z85negoeWIHJovp9PFLXTYVUweNb9ZWtfe+nROqa6aATaJGZzYyoxm9eSl0UfuGxPl
         0JTGNGI+uw61ilhPlQ7YkEQ8FRlHkKkvqEisrgnI+uK5HJXn1Gq5exImDdyI+FvzmAbK
         0hdqoGieJOsBKb/0+NqATV5bjvBEaRwYFyy26cMESCpkbtiO3E6R4qRGUl7BgzvDWu50
         7ek+Mt7a8H3uk6hFqdRVqOtWNPnuDYUB3Yh8WB0+f6mrBQfmAVMqH7u7Tra8e8/f5yQ6
         wQPUVugrvoRYXYrDuYyFYxnhRY0+zXIOAGSuC+Mf3GJ6sggFx+kHDahYclFqwjMIFASL
         yC1w==
X-Gm-Message-State: ACgBeo23f/K6fkRaI2lD0vQPGY2FjtXpWq1HEPDpjQjlqqCsDZ6lOHtj
        LnYfK/gKm5Pe6agvvPlafjYeH+Z9XEZSn0w4DOU=
X-Google-Smtp-Source: AA6agR6MdKws1lzVrLIGA+Aqnumnskn2/NeYygL21WuU70r6lfB7AcklD4hFIuqPBtNw86wuQfsjvUIKmtvxiTqi7ZA=
X-Received: by 2002:a9d:6f18:0:b0:638:b4aa:a546 with SMTP id
 n24-20020a9d6f18000000b00638b4aaa546mr21367162otq.124.1662488158396; Tue, 06
 Sep 2022 11:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220901184709.2179309-1-robh@kernel.org> <CAM9d7chY6T-EAN3BT487MUK0LbfGp27X+2Dd_+S0azgh2GQn9w@mail.gmail.com>
 <CAL_JsqLmszK=NzD_2nYnZG1dD=tU1fKGUtYL-dUG2a497LkEcg@mail.gmail.com>
In-Reply-To: <CAL_JsqLmszK=NzD_2nYnZG1dD=tU1fKGUtYL-dUG2a497LkEcg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 6 Sep 2022 11:15:47 -0700
Message-ID: <CAM9d7ci0Dn3hAX9dp1UMGK7SN-w1BoRqQz6hk8Oykfaa=LnWwg@mail.gmail.com>
Subject: Re: [PATCH] perf: Ignore format attributes with an unknown
 perf_event_attr field
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 8:25 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Sep 2, 2022 at 1:53 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Thu, Sep 1, 2022 at 11:55 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > If the kernel exposes a new perf_event_attr field in a format attr, perf
> > > will return an error stating the specified PMU can't be found. For
> > > example, a format attr with 'config3:0-63' causes an error if config3 is
> > > unknown to perf. This causes a compatibility issue between a newer
> > > kernel and an older perf tool.
> > >
> > > The addition here makes any attr string up to the ':' ignored, but
> > > still checks the 'bits' portion.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > This is the YACC mud I threw and seems to stick. Maybe there's a better
> > > way to handle this. It doesn't seem like there's a way to do wildcards
> > > (i.e. config.*) in YACC.
> > >
> > > This is needed for this series[1]. Unfortunately the best we do to avoid
> > > the issue is applying this to stable. I think there's some time before
> > > v8.7 h/w is deployed, too.
> >
> > Maybe you could change the format_term rule to take an identifier instead
> > of PP_CONFIG* directly and pass it to perf_pmu__new_format().  Then
> > it could check the string and create an appropriate PERF_PMU_FORMAT_VALUE_*
> > or ignore it according to the PERF_ATTR_SIZE_VER*.
>
> That only moves parsing of configN from YACC to strcmp in C. In doing
> so, we'd be left with just the 'error' token case which seems a bit
> odd (if there's another way to do it, I don't know. yacc is not my
> thing). Is that really better?

I thought we could do more flexible handling and detailed error reporting
in the C code.  But it could be done in the lex/yacc as well..

I think the general idea is that we want to run a more recent version of
perf tools than the kernel.  So if it detects the tool is older, it can show
a warning message like:

"config3 is not in the perf_event_attr.. skipping.
 Maybe you're running on a newer kernel. Please upgrade the perf tool."


> Unless there is some way to retrieve
> the PERF_ATTR_SIZE_VER* from the kernel at runtime?

Even if it can retrieve the info at runtime, perf tool might not know
how to use the new config term.

Thanks,
Namhyung
