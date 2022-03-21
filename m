Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F674E2CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350519AbiCUPr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350501AbiCUPrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:47:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B7857B1A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADE936117E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A52DC340F0;
        Mon, 21 Mar 2022 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647877500;
        bh=OJ5Meuvox4FnTDLO6bRR0IED9v6M1ZLzd8Rikjv7omY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPcxCNb7cnBsk+7BbUEUVtPjwQhwneJumn1Zkf28vpgTxb3mb3N9qc7z1We+Ir+ql
         Zg+l+83LPQeumX2ritqk8kLjJrkm+pRGNPbHyTsGGontGfbvfLyqa7f5WJrql6yXp+
         h7SDCmZA37zCwNpYCKpVUM72TI6V/1ePgSG4iYsu4+ZKsyzsSTnRhaNXsY6XQLnCsO
         qqKwNl0JA7WNAd6+WsfmloKFOPIepMYRtz8ojom6qQcVXfNUhP+8AVUzx3Q8vNp75t
         d/mWzy+oI0Q8gtOuAtqBRIMSDYvIeBXCQQOZRkJ54iklW8nH8sQzLoGqQkjEgSnAAK
         uMAJilTkDd1dw==
Date:   Mon, 21 Mar 2022 08:44:52 -0700
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
Message-ID: <YjiddAnoCCz7Tbt3@dev-arch.thelio-3990X>
References: <YjhZUezhnamHAl0H@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjhZUezhnamHAl0H@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Mon, Mar 21, 2022 at 11:54:09AM +0100, Ingo Molnar wrote:
> Ingo Molnar (17):
>       sched/headers: Fix header to build standalone: <linux/sched_clock.h>
>       sched/headers: Add header guard to kernel/sched/sched.h
>       sched/headers: Add header guard to kernel/sched/stats.h and kernel/sched/autogroup.h
>       sched/headers: sched/clock: Mark all functions 'notrace', remove CC_FLAGS_FTRACE build asymmetry
>       sched/headers: Add initial new headers as identity mappings
>       sched/headers: Fix comment typo in kernel/sched/cpudeadline.c
>       sched/headers: Make the <linux/sched/deadline.h> header build standalone
>       sched/headers: Introduce kernel/sched/build_utility.c and build multiple .c files there
>       sched/headers: Introduce kernel/sched/build_policy.c and build multiple .c files there
>       sched/headers: Standardize kernel/sched/sched.h header dependencies
>       sched/headers: Reorganize, clean up and optimize kernel/sched/core.c dependencies
>       sched/headers: Reorganize, clean up and optimize kernel/sched/fair.c dependencies
>       sched/headers: Reorganize, clean up and optimize kernel/sched/build_policy.c dependencies
>       sched/headers: Reorganize, clean up and optimize kernel/sched/build_utility.c dependencies
>       sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
>       sched/headers: Only include <linux/entry-common.h> when CONFIG_GENERIC_ENTRY=y
>       headers/prep: Fix header to build standalone: <linux/psi.h>

This series regresses ARCH=arm allmodconfig:

$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper allmodconfig kernel/sched/
In file included from kernel/sched/fair.c:52:
kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
   87 | # include <asm/paravirt_api_clock.h>
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:288: kernel/sched/fair.o] Error 1
In file included from kernel/sched/core.c:81:
kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
   87 | # include <asm/paravirt_api_clock.h>
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:288: kernel/sched/core.o] Error 1
In file included from kernel/sched/build_policy.c:33:
kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
   87 | # include <asm/paravirt_api_clock.h>
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:288: kernel/sched/build_policy.o] Error 1
In file included from kernel/sched/build_utility.c:52:
kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
   87 | # include <asm/paravirt_api_clock.h>
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:288: kernel/sched/build_utility.o] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [scripts/Makefile.build:550: kernel/sched] Error 2

Randy Dunlap has sent a patch that fixes it, which I just reviewed:

https://lore.kernel.org/r/20220316204146.14000-1-rdunlap@infradead.org/

It would be nice if this could be taken with the pull (or submitted with
the pull in a v2 as I see Qian's comment) to avoid regressing the build.

Cheers,
Nathan
