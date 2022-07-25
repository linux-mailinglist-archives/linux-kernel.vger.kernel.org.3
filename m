Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC3757FC44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiGYJVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiGYJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:21:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5FB15FE2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 893DD6126A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EC6C341C6;
        Mon, 25 Jul 2022 09:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658740863;
        bh=D8Gdb4vd9Oc4rLt5rQgXSMs3fjvOE/7msm8JL614Pmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfAJwnDOAHy2gPKTmusYfwyZlIeu8TmkRgCs3Kc/YUEUtArTmojwxylWp+nATehvg
         GIGEtJa5pDgGTVizqvf1Q+/+CSGONAw89CR8peOR+HHwzIyrSeO3NsJLLlSSiN4Pfq
         fw5fECLySal0J2U1gN9XD9x0CZG7zaui0xK7wuP4QMan3BSF/aUTghBj/NF7R5yNlF
         0+bJ2/VYv/aRxY6S7T3dq+VkdBAcFDkVYqxmp9bPU0zhDplkikegXKQEeR8ASktjRi
         gnP5wWZ1EeTs/UuzqfbP+n1CVhwMajmZThm1cwqSA9+7F9JrB19+QrCqtW/1Ie0ig7
         NiGBA+jJy5Agg==
Date:   Mon, 25 Jul 2022 10:20:58 +0100
From:   Will Deacon <will@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Quentin Perret <qperret@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [sched]  9ae606bc74:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
Message-ID: <20220725092057.GB20370@willie-the-truck>
References: <Yt5Qia3AwDOodKI1@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt5Qia3AwDOodKI1@xsang-OptiPlex-9020>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 04:12:57PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with clang-15):
> 
> commit: 9ae606bc74dd0e58d4de894e3c5cbb9d45599267 ("sched: Introduce task_cpu_possible_mask() to limit fallback rq selection")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: cpuhotplug
> 	torture_type: trivial
> 
> test-description: rcutorture is rcutorture kernel module load/unload test.
> test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-------------------------------------------------------------------------+------------+------------+
> |                                                                         | 304000390f | 9ae606bc74 |
> +-------------------------------------------------------------------------+------------+------------+
> | WARNING:at_kernel/rcu/rcutorture.c:#synchronize_rcu_trivial[rcutorture] | 120        | 120        |
> | RIP:synchronize_rcu_trivial[rcutorture]                                 | 120        | 120        |
> | WARNING:at_kernel/rcu/update.c:#rcutorture_sched_setaffinity            | 120        | 120        |
> | RIP:rcutorture_sched_setaffinity                                        | 120        | 120        |
> | WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture] | 0          | 36         |
> | RIP:rcu_torture_stats_print[rcutorture]                                 | 0          | 36         |
> +-------------------------------------------------------------------------+------------+------------+
> 
> 
> please be noted, since 9ae606bc74 is kind of old, we also tested on a latest
> mainline commit:
> commit 515f71412bb73ebd7f41f90e1684fc80b8730789
> Merge: 301c8949322fe cf5029d5dd7cb
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sat Jul 23 10:22:26 2022 -0700
> 
> and confirmed the
>    WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
> still exists.

I'm not convinced by the bisection -- that commit should't have any effect
on x86.

Will
