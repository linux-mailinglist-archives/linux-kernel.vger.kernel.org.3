Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBAE4E4312
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbiCVPeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238559AbiCVPee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:34:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928E353B41
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7411B81CD8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E5DC340EC;
        Tue, 22 Mar 2022 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647963181;
        bh=nCxXH4UKeu6WJJkK1TsRbqUD6rSI7uvJcCZ1DUtXMTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tiXeW4T3PrjoxDEYOSdlGSwI5MzWXkvw2pW2Kua0vTUmlcPnSZfFQXZtbsNaRbjzl
         JiDgxWhvAKa7uiGA01ytREW5lkBMqsiFsauB28r3IDUQ8Xb6m/5tB0EXmSu9cEFV+v
         bWL83ojRET3tewxlckFRLVAtxvUCMNbj4+8fmrcno4Xa8j0ceRIdvG08C5a3eaFSwT
         pPlbV6yffj3MZ68y9RAc81BJJjGT3ZZAQNIeC+9ZXeIrkM3xlwx2ycBtkwtfSGxGET
         KRBa+sE2J0n2YAWsa4csWnimZhqsZWOQ8z8QqLrbRRg/0KiRAkFXzbQcmCDk8vx9Z/
         WBt5aRjyYAcAg==
Date:   Tue, 22 Mar 2022 08:32:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
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
Message-ID: <YjnsJkUl5mO22mzg@dev-arch.thelio-3990X>
References: <YjhZUezhnamHAl0H@gmail.com>
 <YjiddAnoCCz7Tbt3@dev-arch.thelio-3990X>
 <YjmAzX9kSeSjumKd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjmAzX9kSeSjumKd@gmail.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 08:54:53AM +0100, Ingo Molnar wrote:
> 
> * Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > Hi Ingo,
> > 
> > On Mon, Mar 21, 2022 at 11:54:09AM +0100, Ingo Molnar wrote:
> > > Ingo Molnar (17):
> > >       sched/headers: Fix header to build standalone: <linux/sched_clock.h>
> > >       sched/headers: Add header guard to kernel/sched/sched.h
> > >       sched/headers: Add header guard to kernel/sched/stats.h and kernel/sched/autogroup.h
> > >       sched/headers: sched/clock: Mark all functions 'notrace', remove CC_FLAGS_FTRACE build asymmetry
> > >       sched/headers: Add initial new headers as identity mappings
> > >       sched/headers: Fix comment typo in kernel/sched/cpudeadline.c
> > >       sched/headers: Make the <linux/sched/deadline.h> header build standalone
> > >       sched/headers: Introduce kernel/sched/build_utility.c and build multiple .c files there
> > >       sched/headers: Introduce kernel/sched/build_policy.c and build multiple .c files there
> > >       sched/headers: Standardize kernel/sched/sched.h header dependencies
> > >       sched/headers: Reorganize, clean up and optimize kernel/sched/core.c dependencies
> > >       sched/headers: Reorganize, clean up and optimize kernel/sched/fair.c dependencies
> > >       sched/headers: Reorganize, clean up and optimize kernel/sched/build_policy.c dependencies
> > >       sched/headers: Reorganize, clean up and optimize kernel/sched/build_utility.c dependencies
> > >       sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
> > >       sched/headers: Only include <linux/entry-common.h> when CONFIG_GENERIC_ENTRY=y
> > >       headers/prep: Fix header to build standalone: <linux/psi.h>
> > 
> > This series regresses ARCH=arm allmodconfig:
> > 
> > $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper allmodconfig kernel/sched/
> > In file included from kernel/sched/fair.c:52:
> > kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
> >    87 | # include <asm/paravirt_api_clock.h>
> >       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make[3]: *** [scripts/Makefile.build:288: kernel/sched/fair.o] Error 1
> > In file included from kernel/sched/core.c:81:
> > kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
> >    87 | # include <asm/paravirt_api_clock.h>
> >       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make[3]: *** [scripts/Makefile.build:288: kernel/sched/core.o] Error 1
> > In file included from kernel/sched/build_policy.c:33:
> > kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
> >    87 | # include <asm/paravirt_api_clock.h>
> >       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make[3]: *** [scripts/Makefile.build:288: kernel/sched/build_policy.o] Error 1
> > In file included from kernel/sched/build_utility.c:52:
> > kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
> >    87 | # include <asm/paravirt_api_clock.h>
> >       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make[3]: *** [scripts/Makefile.build:288: kernel/sched/build_utility.o] Error 1
> > make[3]: Target '__build' not remade because of errors.
> > make[2]: *** [scripts/Makefile.build:550: kernel/sched] Error 2
> > 
> > Randy Dunlap has sent a patch that fixes it, which I just reviewed:
> > 
> > https://lore.kernel.org/r/20220316204146.14000-1-rdunlap@infradead.org/
> 
> Applied, thanks Nathan!
> 
> > It would be nice if this could be taken with the pull (or submitted with
> > the pull in a v2 as I see Qian's comment) to avoid regressing the build.
> 
> Will do.

Thank you a lot for the quick response and fix, I appreciate it!

Cheers,
Nathan
