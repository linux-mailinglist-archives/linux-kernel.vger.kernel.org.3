Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3544E3433
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiCUXYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiCUXYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:24:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925A0278555
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23837B81A21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 23:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C47C340E8;
        Mon, 21 Mar 2022 23:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647904664;
        bh=y9xXWMwyEANoM6aeY6koZNPCFGb3yUKNDQjuQUtX7JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSY9bXGW0N5W+d2AHsxfL96+yWeLwzTaINMtf3MV3QrW+jcJumSbKNClS66ynent3
         418H0sJ4vy+66ecCKoIusShJ60tw0TeDvizUA9FKtOjcbPA+BwR4PduTg3epP7u33k
         CK8gR8E7K/94OKJs9clkdaDMUjUWVolmAGJcHvP6Hd+gnPFmnWHEJGyfA/zk0krHmn
         QdfIyvybn/y95cB50mZGLdkyFXD8RKAggjwIfKDlGKBHM77dsQWaNi9h0ksyrTgdV8
         xkM5efXRgSetllQDIbWMk5tg9/3Pl4LCmuXbWGBO+w5upjztBcKh3LUY6s8/buQpoy
         FWSx8gZxemBeQ==
Date:   Mon, 21 Mar 2022 16:17:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:sched/core] BUILD SUCCESS
 3387ce4d8a5f2956fab827edf499fe6780e83faa
Message-ID: <YjkHkb7joeu5GCto@dev-arch.thelio-3990X>
References: <6238fde0.Qe5umewxqwiDe2GE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6238fde0.Qe5umewxqwiDe2GE%lkp@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 22, 2022 at 06:36:16AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> branch HEAD: 3387ce4d8a5f2956fab827edf499fe6780e83faa  headers/prep: Fix header to build standalone: <linux/psi.h>
> 
> elapsed time: 730m
> 
> configs tested: 114
> configs skipped: 3
> 
> The following configs have been built successfully.
> More configs may be tested in the coming days.
> 
> gcc tested configs:
...
> arm                              allyesconfig
> arm                              allmodconfig

This caught my eye due to my earlier report:

https://lore.kernel.org/r/YjiddAnoCCz7Tbt3@dev-arch.thelio-3990X/

Are you sure these configurations built sucessfully?


$ git show -s
commit 3387ce4d8a5f2956fab827edf499fe6780e83faa
Author: Ingo Molnar <mingo@kernel.org>
Date:   Mon Mar 21 11:05:50 2022 +0100

    headers/prep: Fix header to build standalone: <linux/psi.h>
    
    Add the <linux/cgroup-defs.h> dependency to <linux/psi.h>, because
    cgroup_move_task() will dereference 'struct css_set'.
    
    ( Only older toolchains are affected, due to variations in
      the implementation of rcu_assign_pointer() et al. )
    
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Reported-by: Sachin Sant <sachinp@linux.ibm.com>
    Reported-by: Andrew Morton <akpm@linux-foundation.org>
    Reported-by: Borislav Petkov <bp@alien8.de>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- allmodconfig kernel/sched/
In file included from kernel/sched/fair.c:52:
kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
   87 | # include <asm/paravirt_api_clock.h>
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:288: kernel/sched/fair.o] Error 1
In file included from kernel/sched/build_utility.c:52:
kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
   87 | # include <asm/paravirt_api_clock.h>
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:288: kernel/sched/build_utility.o] Error 1
In file included from kernel/sched/build_policy.c:33:
kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
   87 | # include <asm/paravirt_api_clock.h>
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:288: kernel/sched/build_policy.o] Error 1
In file included from kernel/sched/core.c:81:
kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
   87 | # include <asm/paravirt_api_clock.h>
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
...

I am curious to know how this error was not caught by these builds?
Perhaps an old .config from a previous allmodconfig is being reused,
rather than just running "make allmodconfig"? If that is the case, it
seems like that methodology will miss out on new configuration options
over time.

Cheers,
Nathan
