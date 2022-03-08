Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68B54D0F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245484AbiCHFiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245429AbiCHFiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:38:19 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A213BA53
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 21:37:23 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id u3so35579880ybh.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 21:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKcElPkVErIkA0FRVRebvYFiTDdWU+fRqLr3tn1gxSY=;
        b=cX6lPwX9mMHV1MBA07XrS+btXSYVH9mlHa5mMczBv+K7XGuDqqSZHTdhDZYFCOtlwZ
         9LCHB7MgqaGHNEoC+oLwSaQ5MFBmTYjgH7yG5FP5guLFzt0bg7aWwSfyHjwnd+ml8QqB
         ayjk80CQ047OpShJqgA50vwTA0nMtHeruL5vpM0n9u4opIKATDKNgpEi9RLoLIfb0Jib
         KgsQQP2wVMoe2z6vWiqrXwq6PeHqFc1VImovo2qOAbH6aAVE/mzbtU9LdB8jZ4DXC1lt
         kysbJJEKk6GPrqGy+wNryIR2eNvnTRT5ZEPLisLP4sPm6csyQiEEHDZifVBpVX2rzMA5
         SQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKcElPkVErIkA0FRVRebvYFiTDdWU+fRqLr3tn1gxSY=;
        b=22F/iPm5MlGcp8pQJHhfaLG+CGn5qiy+U24alGKULBDhSwDy87OxWE6YWjeJYLbdAt
         F+zW+IrpnvK5CISM+C3bT/oBIXcNXUkRWFs4vmYLwP+LYmYQAiQPBtPX48W5IItSecFo
         mjpwd9O/w6Sd+NLPkgZwBZi0AKw3Z5ctDD7tl6aWalTXT9bYOhBjJGX854h3+Uvv1xO5
         acnN93EyjVWHeSBIrpji0tuul66KeDSdsJbMErS/yGdEXan9phYKzVzmPNia7cC8BjKc
         WCynrD/F81J6R2WdfQDMRVPP0jypDu8llmszSU/oJ5Puqhbx69YSCfcFZY9z4GEZVR84
         UtZg==
X-Gm-Message-State: AOAM531buSIrhzbcD14ZOTV4EokJG8xaVTwQ0ZXYO5JLy3dyujC4V2Y3
        flQ/oSCV4rYdy1gTUbh4PjdPJSidliY15H7OlgrxMA==
X-Google-Smtp-Source: ABdhPJydLO0dZEb/7C0x5NzZ+qV42tYJelOwsqOkANUZ2a9e0FiqlBYKWWgrKryjOkwP19cbRbjRYY5GEhQOuk9/crs=
X-Received: by 2002:a25:778b:0:b0:628:919f:7088 with SMTP id
 s133-20020a25778b000000b00628919f7088mr11076462ybc.282.1646717842770; Mon, 07
 Mar 2022 21:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20220128131006.67712-1-michel@lespinasse.org> <20220223161141.GG4423@techsingularity.net>
In-Reply-To: <20220223161141.GG4423@techsingularity.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 7 Mar 2022 21:37:11 -0800
Message-ID: <CAJuCfpE10y78SNPQ+LRY5EonDFhOG=1XjZ9FUUDiyhfhjZ54NA@mail.gmail.com>
Subject: Re: [PATCH v2 00/35] Speculative page faults
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>
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

On Wed, Feb 23, 2022 at 8:11 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Jan 28, 2022 at 05:09:31AM -0800, Michel Lespinasse wrote:
> > This patchset is my take on speculative page faults (spf).
> > It builds on ideas that have been previously proposed by Laurent Dufour,
> > Peter Zijlstra and others before. While Laurent's previous proposal
> > was rejected around the time of LSF/MM 2019, I am hoping we can revisit
> > this now based on what I think is a simpler and more bisectable approach,
> > much improved scaling numbers in the anonymous vma case, and the Android
> > use case that has since emerged. I will expand on these points towards
> > the end of this message.
> >
> > The patch series applies on top of linux v5.17-rc1;
> > a git tree is also available:
> > git fetch https://github.com/lespinasse/linux.git v5.17-rc1-spf-anon
> >
> > I would like these patches to be considered for inclusion into v5.18.
> > Several android vendors are using Laurent Dufour's previous SPF work into
> > their kernel tree in order to improve application startup performance,
> > want to converge to an upstream accepted solution, and have reported good
> > numbers with previous versions of this patchset. Also, there is a broader
> > interest into reducing mmap lock dependencies in critical MM paths,
> > and I think this patchset would be a good first step in that direction.
> >
>
> I think there is serious lack of performance data here. The only
> performance point offered is the Android Application Startup case.
> Unfortunately, that benefit may be specific to the Zygote process that
> preloads classes that may be required and listens for new applications to
> start. I suspect the benefit wouldn't apply to most Linux distributions
> and even JVM-based workloads are not primarily constrained by the startup
> cost. Improving application start up costs is not great justification
> for this level of code complexity even though I recognise why it is a
> key performance indicator for Android given that startup times affect
> the user experience.
>
> Laurent's original work was partially motivated by the performance of
> a proprietary application. While I cannot replicate a full production
> workload as that can only be done by the company, I could do a basic
> evaluation commonly conducted on standalone systems. It was extremely
> fault intensive with SPF success rates greater than 96% but almost no
> change in actual performance. It's perfectly possible that the application
> has changed since SPF was first proposed. The developers did spend a fair
> amount of effort at making the application NUMA-aware and reusing memory
> more aggressively to avoid faults. It's still very fault intensive but
> does not appear to suffer due to parallel memory operations guessing from
> the data.
>
> On my own tests, the only preliminary test that was a clear winner
> was will-it-scale using threads for the page-fault workloads and
> page-fault-test for threads. To be far, the increases there are dramatic
> with a high success rate of speculative faults.
>
> pft timings
>                                  5.17.0-rc3             5.17.0-rc3
>                                     vanilla        mm-spfault-v2r1
> Amean     elapsed-1        32.66 (   0.00%)       32.77 *  -0.36%*
> Amean     elapsed-4         9.17 (   0.00%)        8.89 *   3.07%*
> Amean     elapsed-7         5.53 (   0.00%)        5.26 *   4.95%*
> Amean     elapsed-12        4.13 (   0.00%)        3.50 *  15.16%*
> Amean     elapsed-21        3.93 (   0.00%)        2.79 *  29.03%*
> Amean     elapsed-30        4.02 (   0.00%)        2.94 *  26.79%*
> Amean     elapsed-48        4.37 (   0.00%)        2.83 *  35.24%*
> Amean     elapsed-79        4.13 (   0.00%)        2.17 *  47.36%*
> Amean     elapsed-80        4.12 (   0.00%)        2.13 *  48.22%*
>
> Ops SPFault Attempt                        0.00  4734439786.00
> Ops SPFault Abort                          0.00     9360014.00
> Ops SPFault Success                        0.00          99.80
>
> This is the ideal case for SPF but not very realistic. Interestingly,
> ebizzy barely benefitted even though it's threaded because it's not
> guaranteed to be address space modification intensive.
>
> Hackbench took a performance hit between 0-5% depending on the exact
> configuration and machine used. It is threaded and had high SPF abort rates
> (up to 50%). It's not a great example but it shows at least one example
> where SPF hurts more than it help and there may be other applications
> that are harmed by having to retry faults.
>
> The scope of SPF is narrow relative to the much older discussion of
> breaking up mmap_sem. The only time SPF benefits is when faults are racing
> against parallel memory address updates holding mmap_sem for write.
> That requires a threaded application that is both intense in terms of
> address space updates and fault intensive. That is much narrower than
> threaded applications that are address space update intensive (e.g.
> using mprotect to avoid accidentally leaking data, mapping data files
> for IO etc). Have we examples of realistic applications that meet all the
> criteria of "threaded", "address-space intensive" and "fault intensive"
> that are common enough to justify the complexity?
>
> Admittedly, I initially just threw this series at a collection of
> workloads that simply stress the allocator because it stresses faults as
> a side-effect but most of them did not match the criteria for "threaded
> application that is both address space update intensive and fault
> intensive". I'm struggling to think of good examples although redis
> is a possibility. HPC workloads like NPB parallelised with OpenMP is a
> possibility but I looked at some old results and while it does trap faults,
> the vast majority are related to NUMA balancing.  The other ones I normally
> consider for scaling purposes are process orientated and not threads.
>
> On the patches themselves, I'm not sure the optimisation for ignoring SPF
> is guaranteed to work as mm_users could be temporarily elevated although
> probably not enough to matter. I also think patch 5 stands on its own and
> could be sent separately. For the others, I didn't read them in sufficient
> depth but noted that the level of similar logic between speculative
> and non-speculative paths could be a maintenance headache to keep the
> speculative and !speculative rules in sync. I didn't see obvious problems
> as such but I still think the complexity is high for a corner case.

Hi Mel,
Thank you for taking your time to analyze SPF effects on different
workloads. Your feedback drove me to look into the reasons Android
benefits from this patchset. What we know is that apps which benefit
the most are the ones with high number of threads (~100) and when I
strace'd one of these apps I can see that each thread mmaps several
areas upon startup (Stack and Thread-local storage (TLS), thread
signal stack, indirect ref table).
So, I created a simple test that spawns a given number of threads,
each thread mmapping and faulting-in a given number of vmas with a
given number of pages in each one. Each thread records the time it
takes to mmap the vmas and fault-in the pages and the test reports the
total and the average times measured. You can find my test program
here: https://github.com/surenbaghdasaryan/spf_test/blob/main/spf_test.c

I ran a number of tests on my Pixel 6 and SPF shows quite positive
results even with a small number of vmas and pages. Couple examples:

100 threads, 2 vmas, 10 pages (cmdline: spf_test 100 2 10)
Baseline avg time: 1,889,398.01ns
SPF avg time: 327,299.36ns
Improvement: 83%

100 threads, 10 vmas, 2 pages (cmdline: spf_test 100 10 2)
Baseline avg time: 1,234,861.48ns
SPF avg time: 800,392.82ns
Improvement: 35%

100 threads, 10 vmas, 10 pages (cmdline: spf_test 100 10 10)
Baseline avg time: 12,199,939.04ns
SPF avg time: 3,223,206.41ns
Improvement: 74%

100 threads, 30 vmas, 30 pages (cmdline: spf_test 100 30 30)
Baseline avg time: 255,827,268.16ns
SPF avg time: 41,538,348.47ns
Improvement: 84%

To minimize the noise, the test setup was to run with the same
parameters for several hundred times and take the average between
runs.
I think this test represents an example of what you were describing as
a "threaded application that is both address space update intensive
and fault intensive" because mmaps modify the address space with
page-faults happening in parallel. We can call it an artificial
workload but it does not strike me as something very unusual. I can
imagine other systems apart from Android which could spawn multiple
threads with each thread mapping some memory area to work with and
using that area immediately.
Thanks,
Suren.


>
> --
> Mel Gorman
> SUSE Labs
