Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F8355B409
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiFZUXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 16:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiFZUXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:23:05 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B574C7C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:23:04 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 184so7229242pga.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4OJRktS48/0rG6k8YY0xWCcBZOBBbOWsnd9nXtcIDLg=;
        b=dTD3qSwZT/PIgwqCXoipscq+hWjyB3oEWYlyXWq9ZELHGY51nxszHF4JK7BKYQFULY
         nPsx4fHosoN1DsxHVNNu6YUMPl6ozH7lnIrSZKMrxg0Zg6PaZUiyDNVkUz9zIMj6aw7P
         rXko6rodGjPg2okTLby2WBUR8weA+Lftwt7J54vOC/fSw8ltTGhhw5pDRzKXXJlgp9/S
         1IEVMhYQ0XTjj2N9sucryPdqK/9Oss9IcU2I5w5NxZMORUX94R4v/VH51lJIs43y9gry
         jhplQJOOieSVyMYjyQHS4QHHorZhWa6hISGn4fcfrQq7q6UpHWJ5hjgx9Zz5AEjZEWvm
         TlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4OJRktS48/0rG6k8YY0xWCcBZOBBbOWsnd9nXtcIDLg=;
        b=dBCEgpdbXbx/FKiV+EMHAyiPhygxU4KUUaa/icDnnFmmTfF2Zeua1ldAoFrkld7Zx8
         u87YNiovuEANohfxF4Mr4K8KZlJVQK/nuHKO7th2/hx3V3l0wlgQxuGHlrjTkOtfQ4kp
         ziI2KtKDyW9gXmvyaDxzJiDpka9yUhUt0uY9kVdtrE1+gLlmYHipShtfR0DkVdH6THDM
         8ctCECIn7YN1dq9SSPrgzRMFKICHUmGTqtaXgqPD8j6b2UN3ZzGEjv4UN5l5P4/+N056
         GuLraVci0eOKjEOjvaPQr57uxhJgH5rwG/Xoo+ly55Khnm4aPE0IMn7Fqz/fCoq4DFNb
         RK3A==
X-Gm-Message-State: AJIora9E9Wi/OImb7hO5CuvLSbF+AwuDk78jPpuvJ5b5YW39Ux9br2iZ
        /Cr1BHXYOwmW33ixI1Z+gLg=
X-Google-Smtp-Source: AGRyM1t6AHP3N/ZRq0BcjrdwIkV3/V2SP5wP7QKPopin4Fj5f63GiynMRX/ZSD6QpfO0fMhdyn/bTQ==
X-Received: by 2002:a63:2055:0:b0:404:3941:e05e with SMTP id r21-20020a632055000000b004043941e05emr9590553pgm.66.1656274983991;
        Sun, 26 Jun 2022 13:23:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1820])
        by smtp.gmail.com with ESMTPSA id a8-20020a656048000000b003db7de758besm5608676pgp.5.2022.06.26.13.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 13:23:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 27 Jun 2022 05:23:00 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 3/3] kthread: Stop abusing TASK_UNINTERRUPTIBLE
 (INCOMPLETE)
Message-ID: <YrjAJN7dDJ9R7Ocu@mtj.duckdns.org>
References: <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <874k0863x8.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
 <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
 <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>
 <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Jun 26, 2022 at 12:59:09PM -0700, Linus Torvalds wrote:
> And I think *that* should be the change - add a "setup()" function
> pointer to the whole kthread infrastructure. Allow it to return an
> error, which will then just kill the new thread again without ever
> even starting it up.
> 
> I'd really prefer to avoid having random drivers and subsystems know
> about the *very* magical "wake_up_new_task()" thing.  Yes, it's a real
> thing, but it's a thing that normal code should not ever use.
> 
> The whole "wake_up_process()" model for kthread creation was wrong.
> But moving existing users of a bad interface to using the even more
> special "wake_up_new_task()" thing is not the solution, I feel.

This is a bit of bike-shedding but there are inherent downsides to
callback based interface in terms of write/readability. Now you have
to move the init code out of line, and if the context that needs to be
passing doesn't fit in a single pointer, you gotta define a struct to
carry it adding to the boilerplate.

Having separate create and run steps makes sense as a pattern and
wake_up_new_task() is less error prone in one sense - if the caller
doesn't call it, the new kthread actually won't start running making
the bug obvious. The fact that the function blindly trusts the caller
to be handing in an actual new task is scary and we likely don't wanna
proliferate its use across the code base.

Would it be a reasonable tradeoff to have a kthread wrapper -
kthread_start() or whatever - which ensures that it is actually called
once on a new task? That way, we can keep the init code inline and
bugs on both sides (not starting and starting incorrectly) are
obvious.

Thanks.

-- 
tejun
