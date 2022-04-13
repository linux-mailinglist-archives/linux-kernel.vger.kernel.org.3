Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B0B4FEE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 06:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiDMEs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 00:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiDMEsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 00:48:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C577F25C5B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:46:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 12so937296pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ixwzFBt9E7HuXOI8XQF0vh33XwIlUCbbXRafmnp+24Y=;
        b=LVggo4XJVRaW187fyGpyTH/Q9EdlYrCF6FPME79M5OH4rzn0/Rg6IDLTKBulVCcYzp
         r/elD6GPga+tRqPoptCT7WSh0ASlkrbREVxZPQgIR+i5sSGFv/KHYxNVTsMHGDxr7/Ku
         Kpo3r0I2nDzDYEV5QWebcw0DhEPGCJwRBRn2+LckOz9vT2oLjhxwcCkmDjUihyeMedcY
         nFNibo74pNSuIl4TZ0hGrAWbl1D8W+SelZPzIffNVrcrI92aY92OyPj/X1IWxtDQA07V
         rQwDsRuGG8JalM7KSCAGTs4qZiFu2ejXwuOVhH3uD48jRDyvo0+9ColcFcpVetoGlfpH
         tZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ixwzFBt9E7HuXOI8XQF0vh33XwIlUCbbXRafmnp+24Y=;
        b=qBUqM7d4cfDE++k+SVzv8ccKk7MFOBHD8WzJjRNCE2eyOAT553rRXu0kF5IUS3wUmD
         D624Nn38ZLKvEJdJpgOUyNcB72OWE8sxLloETefZ/0f5mCkuXiuYA6auup5D4etXmLJ7
         ugNBBH6JiL2vjAh5iSLqn659MSRLmvArUDWMfMl1WL5luS9ZrKyq0FWqDMPZgJ5r+1ke
         GlAyP+877KoBLLj9GXeBpf6TNHkWXk6dpe9ahvRyNdU4GSISj2d9SGqDkIyz3zbvGF29
         8c7bRce5APTf+rGL6s0vEOhfz1SPqTq90jNTnf4N8KbOtdQTsnC0FHWOQ6UaNTEQ47jL
         TV7Q==
X-Gm-Message-State: AOAM532K42cM9SRVWE4Jq9P06Ie4RB3/AyEF9uJzr9N1ncYx5ESER4E4
        JjhDqKnZS9o0LCYxhXSSfrm0Tw==
X-Google-Smtp-Source: ABdhPJxTLzqP8aT1b+Rlq4rXdhmHHhz2huzE6eZ+WJqUoWyNN2hgdjFV030csM9yPUKc5Xh/OSpg+w==
X-Received: by 2002:a17:90a:af8f:b0:1ca:7bce:ce3b with SMTP id w15-20020a17090aaf8f00b001ca7bcece3bmr8757021pjq.224.1649825194055;
        Tue, 12 Apr 2022 21:46:34 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:7ffa:5afe:e07f:12e1])
        by smtp.gmail.com with ESMTPSA id j12-20020a056a00234c00b00505deacf78dsm5524208pfj.149.2022.04.12.21.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 21:46:33 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:46:20 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alois Wohlschlager <alwoju@gmx.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Gladkov <legion@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Hildenbrand <david@redhat.com>,
        Rolf Eike Beer <eb@emlix.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid: Allow creation of pidfds to threads
Message-ID: <YlZVnMk39kFHF0Kp@google.com>
References: <3412128.IC5jYiYEAv@genesis>
 <20220401070942.odjbuc5wecfayyok@wittgenstein>
 <5392366.5i5WIIk9Ns@genesis>
 <20220401094225.epianrz3afrhfrqp@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401094225.epianrz3afrhfrqp@wittgenstein>
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

On Fri, Apr 01, 2022 at 11:42:25AM +0200, Christian Brauner wrote:
> On Fri, Apr 01, 2022 at 11:00:27AM +0200, Alois Wohlschlager wrote:
> > Hello Christian,
> > 
> > > We originally blocked this because it is not as easy as simply allowing
> > > pidfds to be created for non-thread-group leaders.
> > > For a start, pidfd_poll() currently doens't work if pidfd_task() isn't a
> > > thread-group leader
> > 
> > I did notice the hang there, that's why my patch changes pidfd_poll to return
> > error on tasks which are not thread-group leaders. IIRC, waiting on specific
> > threads is not supported by Linux at all, so I don't see a problem with not
> > supporting it here either.
> 
> In general, it would be quite neat if we could get notified about thread
> exit through poll though. That'd be pretty useful. But maybe it's indeed
> ok to just not support this (for now at least).
> 
> I know that systemd is using pidfds in their event loop so I'd need to
> see whether they'd want support for this behavior.
> 
> > 
> > > and you'll just hang for CLONE_PIDFD | CLONE_THREAD.
> > 
> > No, CLONE_PIDFD | CLONE_THREAD behavior is unchanged, it will still fail with
> > EINVAL. I actually confirmed this by double-checking right now.
> 
> I just used the two flags as a shorthand for pidfds referring to
> threads. That might've been misleading here.
> 
> > 
> > > So at least that needs to be adapated as well and there's likely a bunch
> > > of other corner-cases I'm forgetting about.
> > 
> > I'd be happy to hear about other corner-cases so I can fix them.
> 
> I need to play with this patch a little and see what current
> expectations we do have in the code.
> 
> There are various consumers of pidfds and they all have been added with
> the assumption that a pidfd refers to a thread-group leader. We should
> go through them and see whether changing them to operate on threads is
> sane before we can just switch the generic helper.
> 
> Bot process_madvise() and process_mrelease() should be fine to operate
> on threads afaict from the discussion when they were added.
> 
> For pidfd_send_signal() we likely want to at least consider adding the
> ability to send a thread-specific signal, i.e. supporting tgkill()
> behavior. As it stands it currently only supports kill()-like behavior
> where the signal that gets sent is thread-group directed.
> 
> I roughly had originally envisioned this to be supportable through the
> addition of a new flag to pidfd_send_signal() so callers would be able
> to select whether to send a thread-specific signal or not. What do
> people think of that?

Sorry, I've been on parental leave for the last couple of months and
I'm now playing catch-up.

For the fanotify API i.e. FAN_REPORT_PIDFD, I don't see there being
any issues with supporting/returning pidfds which belong to
non-thread-group leaders. In saying that, for this to be useful from
the fanotify API POV, I definitely do think we should consider
supporting the ability to send thread-specific signals via
pidfd_send_signal(). Adding this extension through the optional flag
parameter makes sense to me.

> > > Do you have a concrete use-case you want this for?
> > 
> > My use-case is basically making pidfd_getfd actually useful for its intended
> > purpose: there is a seccomp_unotify-based supervisor that wants to obtain a
> > file descriptor from its guest. This currently does not work if the action to
> > be forwarded to the supervisor is performed in a secondary thread, since there
> > is no way to obtain the required pidfd.
> 
> Yeah, I'm well aware of that. I've been working around this limitation
> in our implementation for the seccomp notifier for quite a long time
> when intercepting the bpf()-syscall.

/M
