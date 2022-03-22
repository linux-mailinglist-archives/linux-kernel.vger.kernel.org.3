Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF254E4478
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbiCVQqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbiCVQqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:46:37 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D924B873
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:45:09 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id u103so34675062ybi.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEPKdfQLbwPTzKqThQDGwgj7kWss99Dn8po4pyO255s=;
        b=ddWplO2lvUqvqxO14GRhtJiIcIil6ImSCV0lQvOyB6RhwfseAeO/f3MbwjXg0gB2AI
         Y6wK6Z1zurAf8hSxxYyh5aO+O+vxAaoemeucwVmcGyYcyPCo1ko+7oQaiVttX2jLA/Gl
         uABWSRhRigugKLHpvjeYnO1NzwOnJZJmZabgbd9pBfOzTCWhBhUMXEkS8wkosbIx40wn
         7LaVEhfF7lNrRyEifBQcWvpUCYdPxhbyh0kHyJO/LVgH8nw7leDhZUbS8WB52AsELMI5
         P3YeBG8ZJY0h4acRiqBgl5+sR7snJPYaA8UFnAo131KEGnUFAPbVlyKVonkYIZI+09Ie
         Uqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEPKdfQLbwPTzKqThQDGwgj7kWss99Dn8po4pyO255s=;
        b=SbFa8SnBsU+MnJm9+oVkB0DptOanX4eKmzwgTZaBYU8O73+w2WKAjw+NQIKJgy3HVM
         eT4WFKNt3Yc5e2o5/FXUqIF3P8gT5lEQBWhgODv1oGYd5AfuiF41q7+KMttAhjFNDCht
         iaoHaD8lIg7+izAfUEi5gesC/lzWBwmdjZp58BevHeyVeSls6co007kLs1LH0P1lZyfW
         XvG2BoBRRiaSDf7oHX97Ar6TaIMLFpnsy0cJY3KntKun8oWCKBBXqkeqOkRbT5M3TuqL
         u7O1DDRMOhfvnAPfK14MlC8QgFl7VVVhoFHFf71GVdkbALheGqPSn9wDjTmnaMFaYL4T
         EdqA==
X-Gm-Message-State: AOAM533ad/Lz2pPyYsiuC8lsZM2nYi4c72//HRtgZ6N7kn1mQgIGdXqL
        e1NiMRiJVaw94Bs6qAuE05lQejGyK7EdK2yW3t+j5A==
X-Google-Smtp-Source: ABdhPJwNeDSZQOjU+JcF3GBLS/i9yWqJD8C5YRvGxuEpEvBXt9pPTbr55XtMe5XOsWg/E58B8eckCMecpnUUt1ZNU5U=
X-Received: by 2002:a05:6902:203:b0:628:7b6f:2845 with SMTP id
 j3-20020a056902020300b006287b6f2845mr28163313ybs.533.1647967508132; Tue, 22
 Mar 2022 09:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <Yjmn/kVblV3TdoAq@elver.google.com> <87ee2uyr4z.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ee2uyr4z.fsf@email.froward.int.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Tue, 22 Mar 2022 17:44:31 +0100
Message-ID: <CANpmjNN4UjUTB5x6-2T-+b7MY=oAYn37MKvQy-4jYh6JDeJuKg@mail.gmail.com>
Subject: Re: RFC: Use of user space handler vs. SIG_DFL on forced signals
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 at 15:54, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Marco Elver <elver@google.com> writes:
>
> > Hello,
> >
> > Currently force_sig_info_to_task() will always unblock a blocked signal
> > but deliver the signal to SIG_DFL:
> >
> >       [...]
> >        * Note: If we unblock the signal, we always reset it to SIG_DFL,
> >        * since we do not want to have a signal handler that was blocked
> >        * be invoked when user space had explicitly blocked it.
> >       [...]
> >
> > Is this requirement part of the POSIX spec? Or is the intent simply to
> > attempt to do the least-bad thing?
>
> I have not found any POSIX language about this.
>
> The options are either we terminate the application, or the application
> spins forever re-triggering the trap.

Is this in case of things like SEGV? I think this doesn't quite apply
to us. The cause of the signal (perf event) is rather benign, and the
signal handler can deal with recursion.

[...]
> > For SIGTRAP on perf events we found this makes the situation worse,
> > since the cause of the signal wasn't an error condition, but explicitly
> > requested monitoring. In this case, we do in fact want delivery of the
> > signal to user space even if the signal is blocked, i.e.
> > force_sig_perf() should be an unblockable forced synchronous signal to
> > user space!
>
> Which is exactly what we have.  If you block it you get terminated.

Right, however, in this case we want to monitor/trace memory accesses
etc, and some 3rd party code such as a library being traced isn't
under our control.

What we can do instead is to intercept sigprocmask() and work around
the issue, but libc interception is brittle. :-/
We do just want to receive the signal, all the time.

[...]
> I think HANDLER_UNBLOCK is pretty much nonsense.
>
> A block signal very much means that userspace is not prepared to handle
> the signal.  So calling something that is not ready to be called can't
> work.  That is common sense, and I expect in POSIX as well.

The fundamental question is, if we have a valid signal handler, but
sigprocmask() is called, how do we still keep receiving signals for
SIGTRAP despite sigprocmask()?

Perhaps this is impossible without intercepting sigprocmask() in user
space, in which we'll need to find a different solution.

> I expect that either you are looking for something like what ptrace does
> with signal interruptions where another process is notified, and
> userspace does not need to be involved, or that this is a don't do that
> then.
>
> Or possibly you have some weird asynchronous signal thing happening and
> you are calling it synchronous.

Not quite. We need it to be synchronous, because we need to know the
precise instruction and potentially do some other stuff _before_
subsequent instructions.

A compromise might be to deliver synchronously normally, but when
blocked deliver asynchronously. But if the signal was delivered
asynchronously, we need to let the signal handler know delivery was
asynchronous, so that our tracing logic can recover and give up at
that point.

To do this indication if it was asynchronous, we probably need to
extend siginfo_t once more. Would that be reasonable?

Thanks,
-- Marco
