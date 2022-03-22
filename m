Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452CF4E39F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiCVH4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCVH4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:56:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52C52E52
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:54:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qx21so34343203ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mB55UEg7vRE0QnmtVfNpsCp6pv59/BZgQeh/tPR6naQ=;
        b=BIvjlSNYbwLvRdtWWOAHPapGwr2N6ocS4BvmcRp5cYszwlYrctj8kR3MnC+biwsPkt
         zcvs3WltilULn3e9acV6uSWAhOB2ym3etzzw0e8BR37RBkznveucF2PXNQL1rsGHtJE1
         iULd9jtn2rO2B4lD1YZjEBNDE37vXqnGFprSURA4+IbIFzESmYsZwJcyDoSGPb06DkkW
         17aBmdlPvf+x4giRLgso082ipBsAHrZMBkl1RaVZia4H5cT9CmnOOCXARv+gcQkaU8jE
         2NkwqJp1E0hstrhqnBb2jzTwiYEMbjfftTCY/cwPJnF5roiJUzLWQ9ymbq+DZWnXcvRn
         Cwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mB55UEg7vRE0QnmtVfNpsCp6pv59/BZgQeh/tPR6naQ=;
        b=qzULPZLv92xrdf6xzIO+j8vAafh/C/DmQm6X/qo62CUs4p5yjgFGtVZ6g07x3msWd6
         d2X4u9nBdDzXwtdPC0sT2JRK9Z7Be3j03Z1TPLq8aZ0pd2eeIZAfquU0PTePKcjn7wxN
         ge92kv2SI1VIPCAjd0OLwIeRDcrerr1mQKNZG4lSmXmB98ptW5NQ0i27SqX/+R25Df/E
         W4bFIi8b8bFQVeInFT1rmccG6I0/YFZaNeu5ewCEGKhl9Yo1RLoNqAzbOsDiUY6XI5O5
         1xBiAtZYTm9nwtzVLKUpJ4Y1h1HOW5+2Tde6c9rY/ql9cXVxJYCypOnI4vsXx5MIum/5
         5NEg==
X-Gm-Message-State: AOAM533kUSt+AND48eT4l0EOWguuYYHUHeKqgdVia8CmZnF8JnLerN0L
        M12YYCCVKDcAn6ri4bXKSBI=
X-Google-Smtp-Source: ABdhPJxsOduDcoIJJpiQulSLDOjEwlJlCvpoHEEJw+BTKYNL134KTaNYfCzWQlMKIWbU5kgZCXaJzA==
X-Received: by 2002:a17:907:3f91:b0:6d7:16c0:ae1b with SMTP id hr17-20020a1709073f9100b006d716c0ae1bmr24098673ejc.74.1647935696138;
        Tue, 22 Mar 2022 00:54:56 -0700 (PDT)
Received: from gmail.com (0526ECD0.dsl.pool.telekom.hu. [5.38.236.208])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709060e8300b006d0e8ada804sm7718310ejf.127.2022.03.22.00.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:54:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 22 Mar 2022 08:54:53 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] scheduler updates for v5.18
Message-ID: <YjmAzX9kSeSjumKd@gmail.com>
References: <YjhZUezhnamHAl0H@gmail.com>
 <YjiddAnoCCz7Tbt3@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjiddAnoCCz7Tbt3@dev-arch.thelio-3990X>
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


* Nathan Chancellor <nathan@kernel.org> wrote:

> Hi Ingo,
> 
> On Mon, Mar 21, 2022 at 11:54:09AM +0100, Ingo Molnar wrote:
> > Ingo Molnar (17):
> >       sched/headers: Fix header to build standalone: <linux/sched_clock.h>
> >       sched/headers: Add header guard to kernel/sched/sched.h
> >       sched/headers: Add header guard to kernel/sched/stats.h and kernel/sched/autogroup.h
> >       sched/headers: sched/clock: Mark all functions 'notrace', remove CC_FLAGS_FTRACE build asymmetry
> >       sched/headers: Add initial new headers as identity mappings
> >       sched/headers: Fix comment typo in kernel/sched/cpudeadline.c
> >       sched/headers: Make the <linux/sched/deadline.h> header build standalone
> >       sched/headers: Introduce kernel/sched/build_utility.c and build multiple .c files there
> >       sched/headers: Introduce kernel/sched/build_policy.c and build multiple .c files there
> >       sched/headers: Standardize kernel/sched/sched.h header dependencies
> >       sched/headers: Reorganize, clean up and optimize kernel/sched/core.c dependencies
> >       sched/headers: Reorganize, clean up and optimize kernel/sched/fair.c dependencies
> >       sched/headers: Reorganize, clean up and optimize kernel/sched/build_policy.c dependencies
> >       sched/headers: Reorganize, clean up and optimize kernel/sched/build_utility.c dependencies
> >       sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
> >       sched/headers: Only include <linux/entry-common.h> when CONFIG_GENERIC_ENTRY=y
> >       headers/prep: Fix header to build standalone: <linux/psi.h>
> 
> This series regresses ARCH=arm allmodconfig:
> 
> $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper allmodconfig kernel/sched/
> In file included from kernel/sched/fair.c:52:
> kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
>    87 | # include <asm/paravirt_api_clock.h>
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:288: kernel/sched/fair.o] Error 1
> In file included from kernel/sched/core.c:81:
> kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
>    87 | # include <asm/paravirt_api_clock.h>
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:288: kernel/sched/core.o] Error 1
> In file included from kernel/sched/build_policy.c:33:
> kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
>    87 | # include <asm/paravirt_api_clock.h>
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:288: kernel/sched/build_policy.o] Error 1
> In file included from kernel/sched/build_utility.c:52:
> kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
>    87 | # include <asm/paravirt_api_clock.h>
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:288: kernel/sched/build_utility.o] Error 1
> make[3]: Target '__build' not remade because of errors.
> make[2]: *** [scripts/Makefile.build:550: kernel/sched] Error 2
> 
> Randy Dunlap has sent a patch that fixes it, which I just reviewed:
> 
> https://lore.kernel.org/r/20220316204146.14000-1-rdunlap@infradead.org/

Applied, thanks Nathan!

> It would be nice if this could be taken with the pull (or submitted with
> the pull in a v2 as I see Qian's comment) to avoid regressing the build.

Will do.

Thanks,

	Ingo
