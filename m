Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B824EB6F5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbiC2Xtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiC2Xts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:49:48 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EE4204AB2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:48:04 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id i63so20854257vsi.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tmKMpracc+vzrKxdsOIMu2LUegKfN68WirpEeCdLMc=;
        b=Jk64ykSS7DXFVmVlpjB6aVtEAQBlhxw2+iwNoVh7qz8XUkJRg6Jy0anx36zMCkM3I4
         O/ds7STTqNKNyFN498alDKXdsNqklwhxHDLBP5jwz4xnLVXV+EwdSBXHrq35KGqNrPR5
         p2o0yg+zuRJIufzptMa41LgNMftIgymSLIVMfUWm43fcw393vrNUCU01RNjtOQ1e2Cgx
         /OBLUvbwE/bJ8YFIBDy82kyPRLPvOI39dJzYo7ywIeNsdeoblm+3CaCORsxD3dTte+F9
         FXuPN4WOQLrQWw1h2nXGrp2j1krYEVK00YOirmfMT7u5tnP8cicgu0TWiKhx8npV0DUu
         PepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tmKMpracc+vzrKxdsOIMu2LUegKfN68WirpEeCdLMc=;
        b=MBZvvli0hUzNMQt/rLbb5YtxkvlLrfEtX8ZQ1meepOQeFWACDWioEc/Y3qfdjsuAky
         m3WB5/rTYFnkWSZWZ5SfZsVfgO78XKUeqEQuFTHJ8NJ+ajsJTYgMez5LUmM9zQbuzyS7
         hmnqOFA9llGf4JXHD3MAwHcwBQpP1KOc9n0rUeow+YylQcsvkM6XSz9IqEXqtYPsPSLS
         FDPDbCSLEWjpFqLb4Sc3zbYCSDWPLdxb+IeBH+riK19edLWgpLCOYnjRr0AcIrUJERlC
         DbsrREMdLH9wpBekBB9eymtrmeNWtOx4NZ6qlVSEG7Gy2OJbmZW58qX+W9+qJ2wlTKGz
         n4PQ==
X-Gm-Message-State: AOAM532MiyNee9msbQ+gAwKztv/iToIZVnRUy6tfYdxe0i9fimzujpaQ
        E5T1G4pm/wsY2swR5dZC/qphHkUueO4g59FLQcm5Yw==
X-Google-Smtp-Source: ABdhPJxq66M7JyuhwG8ca2iZlDoiS3CzQpJn0Rhl7b1jnyzcgwfi9+bkxSiv144NAIarUy8DkJxAGdixygwdgowTwU8=
X-Received: by 2002:a05:6102:3576:b0:325:46eb:fdde with SMTP id
 bh22-20020a056102357600b0032546ebfddemr18709850vsb.11.1648597683115; Tue, 29
 Mar 2022 16:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com> <20220324145902.GG8939@worktop.programming.kicks-ass.net>
 <CABPqkBTVFNOW0Y-suYVRjf07aBC41gEw1m4Ym78sR39BRzLDcQ@mail.gmail.com>
 <20220325082855.GL8939@worktop.programming.kicks-ass.net> <CABPqkBSNG=kLae6dN9iCuyuMVAvt-n+waW9SL4AfNDCOc3px0A@mail.gmail.com>
In-Reply-To: <CABPqkBSNG=kLae6dN9iCuyuMVAvt-n+waW9SL4AfNDCOc3px0A@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 29 Mar 2022 16:47:52 -0700
Message-ID: <CABPqkBQ6ZyqSzQyJeNW5GE22V1sygB3zz5JQ45AT1TxMnwWScg@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        rafael@kernel.org, ravi.bangoria@amd.com, Sandipan.Das@amd.com
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

On Tue, Mar 29, 2022 at 2:58 PM Stephane Eranian <eranian@google.com> wrote:
>
> On Fri, Mar 25, 2022 at 1:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Mar 24, 2022 at 10:31:38PM -0700, Stephane Eranian wrote:
> > > On Thu, Mar 24, 2022 at 7:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Tue, Mar 22, 2022 at 03:15:04PM -0700, Stephane Eranian wrote:
> > > > > V7 makes the following changes:
> > > > >    - rebased to 5.17-rc8
> > > > >    - Restrict BRS to be used only with RETIRED_TAKEN_BRANCH event in order to
> > > > >      avoid adding more skid to other events in case that are monitored
> > > > >      concurrently
> > > > >    - fixed bugs in the perf tool enhanced error handling for IBS and BRS
> > > >
> > > > But afaict you failed to pick up the build fixes I did in my tree :/ Let
> > > > me try and be careful preserving those while munging this in.
> > >
> > > Sorry. I missed that. I can resubmit if you prefer.
> >
> > Nah, fixed it up again.. Even converted to static_call() this time.
> >
> > Could you please test this branch?
>
> Started testing. BRS does not come up so far. Let me debug this.
>
False alarm. I had not forced the config option. With the config
option enabled, it works as expected.
I just found a minor issue in case BRS is not enabled. To be
consistent, we should do:

--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1265,7 +1265,7 @@ static inline s64 amd_brs_adjust_period(s64 period)
 #else
 static inline int amd_brs_init(void)
 {
-       return 0;
+       return -EOPNOTSUPP;
 }

Thanks.

> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/amd
> >
> > I've since done more Changelog edits, and I should do a comment with the
> > static_call_mod() usage, but I think this ought to work.
> >
> > At least it now actually builds...
