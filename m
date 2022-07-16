Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A635B577258
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiGPXXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiGPXXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:23:01 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1751D303
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:22:05 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so7553182pgb.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pernos.co; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+p7VBoIu+rN42R7PZDCKsDCbEeNsD8gVtwYGmVdHSCs=;
        b=DDx0lJMz+s7Xrx3Hz7Kp9FaVoh5/r9+9HEegjLZoFdCvBxUVLBXWzo9A6auoiI9xWN
         hkn/kMYh29CGW2pq+YP9NLN2PryEtEiKUylb53S3gtNu+3krS6nkqPKLJe2n01mGS0g9
         hk7QdFwJqo7fBoKerdpVhYyWdRms+fvoZWZ1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+p7VBoIu+rN42R7PZDCKsDCbEeNsD8gVtwYGmVdHSCs=;
        b=gM5t5PIY+af0W/roWnvMab6k3EJ3Kg5p6bvyDaAGukOf3/Tajz7wHIQOXpEXTlOVo4
         CheoccYfvvfe+D7t9hZRrFFQxj253sscjw7nIlCZJWWe5sLqxs95tSKD28WJIBGuqBjs
         OaCeWRXdoEc3kBI7Qp5FckdR5PHPM66ZWpdnGVh/vnQvHyyiqDz4+zg/X6wdtbE+8bKn
         NIvaR7qKCuIXTwRORHoeIqhUGRIp+OTHNRpkUHLkiMCTxNB7Oopq6glrp+ZD7w82SOcD
         k3ZwGZJ5V0OtMclcw/GXpZqDCz46aAH9uXwtwenN1uorqZyLePxCbGi/xhCQFhTYXmZM
         qEyg==
X-Gm-Message-State: AJIora8VVhmCgZ8FC5sadgYjoGEQ9F0M4OpAKdm8YdbildFjRIUGtC/h
        5idUzTBepFkSGKukHROFC4/zMtftGNkf4wGoCyyijw==
X-Google-Smtp-Source: AGRyM1txg7DbUa6tmxdDiyGLkK0xuTspY0VqjP64dM0R2ERhrbjlV//l9WX+hm2ejdnaQfhzGRmzkrl7b1FcyCdw8ok=
X-Received: by 2002:a62:79d7:0:b0:52a:b557:2796 with SMTP id
 u206-20020a6279d7000000b0052ab5572796mr20898846pfc.34.1658013724699; Sat, 16
 Jul 2022 16:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220421150248.667412396@infradead.org> <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org> <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org> <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org> <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>
 <87edyvgs2s.fsf@email.froward.int.ebiederm.org> <CABV8kRxQNPUzLaJ1tFF8H-E_iqCkz0+Ac5rPBurnmA3GcofMmQ@mail.gmail.com>
 <875yk22j5z.fsf@email.froward.int.ebiederm.org> <87pmi4ycdu.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87pmi4ycdu.fsf@email.froward.int.ebiederm.org>
From:   Kyle Huey <khuey@pernos.co>
Date:   Sat, 16 Jul 2022 16:21:50 -0700
Message-ID: <CALWUPBeS7sgu+F_49HsDkR+3r7aaC+++mOpb9bKHuytkdsVxbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ptrace: Stop supporting SIGKILL for PTRACE_EVENT_EXIT
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Robert O'Callahan" <roc@pernos.co>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 2:31 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>
> > Keno Fischer <keno@juliacomputing.com> writes:
> >
> >> Hi Eric,
> >>
> >> On Fri, Jul 8, 2022 at 6:25 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>> > Recently I had a conversation where it was pointed out to me that
> >>> > SIGKILL sent to a tracee stropped in PTRACE_EVENT_EXIT is quite
> >>> > difficult for a tracer to handle.
> >>> >
> >>>
> >>> RR folks any comments?
> >>>
> >>> Did I properly understand what Keno Fischer was asking for when we
> >>> talked in person?
> >>
> >> Yes, this is indeed what I had in mind. I have not yet had the opportunity
> >> to try out your patch series (sorry), but from visual inspection, it does indeed
> >> do what I wanted, which is to make sure that a tracee stays in
> >> PTRACE_EVENT_EXIT for the tracer to inspect, even if there is another
> >> SIGKILL incoming simultaneously (since otherwise it may be impossible
> >> for the tracer to observe the PTRACE_EVENT_EXIT if two SIGKILLs
> >> come in rapid succession). I will try to take this series for a proper spin
> >> shortly.
> >
> > Thanks,
> >
> > I haven't yet figured out how to get the rr test suite to run
> > successfully.  Something about my test machine and lack of perf counters
> > seems to be causing problems.  So if you can perform the testing on your
> > side that would be fantastic.
>
> Ok.  I finally found a machine where I can run rr and the rr test suite.
>
> It looks like there are a couple of the rr 5.5.0 test that fail on
> Linus's lastest kernel simply because of changes in kernel behavior.  In
> particular clone_cleartid_coredump, and fcntl_rw_hints.  The
> clone_cleartid_coredump appears to fail because SIGSEGV no longer kills
> all processes that share an mm.  Which was a deliberate change.

Yeah, we changed to handle this in
https://github.com/rr-debugger/rr/commit/04bbacdbaba1cc496e92060014442bd1fd26b41d
and https://github.com/rr-debugger/rr/commit/1a3b389c2956e1844c0d07bf4297398bb6c561ea.

> With the lastest development version of rr, only detach_sigkill appears
> to be failing on Linus's latest.  That failure appears to be independent
> of the patches in question as well.  When run manually the
> detach_sigkill test succeeds so I am not quite certain what is going on,
> any thoughts?

If it fails before your changes I wouldn't worry about it too much,
there's been some other failures in that test lately.

- Kyle

> As for my patchset it looks like it does not cause any new test failures
> for rr so I will plan on getting it into linux-next shortly.
>
> Eric
>
