Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05A651B1AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359668AbiEDWRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbiEDWRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:17:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9631850E0E;
        Wed,  4 May 2022 15:13:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AAF4B826F8;
        Wed,  4 May 2022 22:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C696C385A4;
        Wed,  4 May 2022 22:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651702436;
        bh=Z2tSaZrwxJdGM/PH98zWJwOlYlglk+upXiDWoU5+9P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0ZVFeB4FUBdMDhw+EDxfnLOhx4oP8xjSR03tZX6ol9/MIL1yuy2ss2cHCMYUwxIA
         WnVXH/b1CjgFxYS8bkPgjUIQJmZyJxYCDv6oXqdv+Jc5qxWTQBw5JMz7dGX1x7PidI
         osli/jubK0/pOQnCQOg3ngEvur8GBDBk5GbIBz9+Ui0ujOCjZFPgXlyXFDqKb9Rdwd
         RQHOvTqwMGgzfl+KkyHiV+4c7z3SJaZCI7RELX0JbnSsK7yphCP1durfEpW8zNa1qd
         /fvkx4/Kl0SqWtlgaHIu5amSlvgorctE8TbyTdBNjytUPzbCoW2AcdoguYs4kUNW3J
         XMbCA5ddAieNg==
Date:   Wed, 4 May 2022 15:13:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v3] random: use first 128 bits of input as fast init
Message-ID: <YnL6ouh5xxZIJqeN@dev-arch.thelio-3990X>
References: <20220503131204.571547-1-Jason@zx2c4.com>
 <20220504111644.284927-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504111644.284927-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, May 04, 2022 at 01:16:44PM +0200, Jason A. Donenfeld wrote:
> Before, the first 64 bytes of input, regardless of how entropic it was,
> would be used to mutate the crng base key directly, and none of those
> bytes would be credited as having entropy. Then 256 bits of credited
> input would be accumulated, and only then would the rng transition from
> the earlier "fast init" phase into being actually initialized.
> 
> The thinking was that by mixing and matching fast init and real init, an
> attacker who compromised the fast init state, considered easy to do
> given how little entropy might be in those first 64 bytes, would then be
> able to bruteforce bits from the actual initialization. By keeping these
> separate, bruteforcing became impossible.
> 
> However, by not crediting potentially creditable bits from those first 64
> bytes of input, we delay initialization, and actually make the problem
> worse, because it means the user is drawing worse random numbers for a
> longer period of time.
> 
> Instead, we can take the first 128 bits as fast init, and allow them to
> be credited, and then hold off on the next 128 bits until they've
> accumulated. This is still a wide enough margin to prevent bruteforcing
> the rng state, while still initializing much faster.
> 
> Then, rather than trying to piecemeal inject into the base crng key at
> various points, instead just extract from the pool when we need it, for
> the crng_init==0 phase. Performance may even be better for the various
> inputs here, since there are likely more calls to mix_pool_bytes() then
> there are to get_random_bytes() during this phase of system execution.
> 
> Since the preinit injection code is gone, bootloader randomness can then
> do something significantly more straight forward, removing the weird
> system_wq hack in hwgenerator randomness.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Apologies if this has already been reported or noticed, I did not see
anything on lore.kernel.org.

I bisected a QEMU boot failure with ARCH=arm aspeed_g5_defconfig to this
change in -next, initially noticed by our continuous integration:

https://github.com/ClangBuiltLinux/continuous-integration2/runs/6292038704?check_suite_focus=true

# bad: [bb6ee10133faa3c4742ab8343b5e488cdb29445e] Add linux-next specific files for 20220504
# good: [ef8e4d3c2ab1f47f63b6c7e578266b7e5cc9cd1b] Merge tag 'hwmon-for-v5.18-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
git bisect start 'bb6ee10133faa3c4742ab8343b5e488cdb29445e' 'ef8e4d3c2ab1f47f63b6c7e578266b7e5cc9cd1b'
# good: [fc346f9c7d4404797b1e22e70b10367cfcb65973] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good fc346f9c7d4404797b1e22e70b10367cfcb65973
# good: [31ae19714d8019a433c632c8bbc55a8ed51b4dc0] Merge branch 'timers/drivers/next' of git://git.linaro.org/people/daniel.lezcano/linux.git
git bisect good 31ae19714d8019a433c632c8bbc55a8ed51b4dc0
# good: [0a1f00e86626c074bd8b0b4fc4e425ed2cdf182e] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
git bisect good 0a1f00e86626c074bd8b0b4fc4e425ed2cdf182e
# bad: [64208983cb783cf86d310b713dca86cc48a92e21] Merge branch 'rust-next' of https://github.com/Rust-for-Linux/linux.git
git bisect bad 64208983cb783cf86d310b713dca86cc48a92e21
# good: [c5fab14b25743e24900bbc46c1d674ae085556a3] Merge branch 'renesas-pinctrl' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
git bisect good c5fab14b25743e24900bbc46c1d674ae085556a3
# good: [6657c54d345821bec0ababf5566117074e9365e8] Merge branch 'hyperv-next' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
git bisect good 6657c54d345821bec0ababf5566117074e9365e8
# good: [49ff8dd832746466d8ee736fd2ac17468d96c2c8] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
git bisect good 49ff8dd832746466d8ee736fd2ac17468d96c2c8
# good: [0c0f471ec568bb005ea8ca2660df03841f63b30d] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
git bisect good 0c0f471ec568bb005ea8ca2660df03841f63b30d
# bad: [fee7def4f22dadc01fbb89fc5bf69986b4f7d7a7] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
git bisect bad fee7def4f22dadc01fbb89fc5bf69986b4f7d7a7
# good: [675ba39e73c5cd58fca0a7efc39c22efc557aadd] nios2: use fallback for random_get_entropy() instead of zero
git bisect good 675ba39e73c5cd58fca0a7efc39c22efc557aadd
# good: [2334ae282252f27ccd44a65be6e36d251936175f] random: vary jitter iterations based on cycle counter speed
git bisect good 2334ae282252f27ccd44a65be6e36d251936175f
# bad: [fbc14042a7fa7820dd7ffdd27d97064edd09d2ea] random: use first 128 bits of input as fast init
git bisect bad fbc14042a7fa7820dd7ffdd27d97064edd09d2ea
# good: [99e2ecc9855eab30603275aeaa34ac7a7ff919b2] random: do not use batches when !crng_ready()
git bisect good 99e2ecc9855eab30603275aeaa34ac7a7ff919b2
# first bad commit: [fbc14042a7fa7820dd7ffdd27d97064edd09d2ea] random: use first 128 bits of input as fast init

It can be reproduced with:

$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper aspeed_g5_defconfig all

$ qemu-system-arm \
-initrd ... \
-machine romulus-bmc \
-no-reboot \
-dtb arch/arm/boot/dts/aspeed-bmc-opp-romulus.dtb \
-display none \
-kernel arch/arm/boot/zImage \
-m 512m \
-nodefaults \
-serial mon:stdio
...
[    0.000000] random: get_random_u32 called from __kmem_cache_create+0x24/0x46c with crng_init=0
[    0.000000] 8<--- cut here ---
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.000000] [00000000] *pgd=00000000
[    0.000000] Internal error: Oops: 5 [#1] SMP ARM
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0-rc5-00021-gfbc14042a7fa #1
[    0.000000] Hardware name: Generic DT based system
[    0.000000] PC is at random_get_entropy_fallback+0x14/0x24
[    0.000000] LR is at extract_entropy.constprop.0+0x4c/0x1bc
[    0.000000] pc : [<8019ea0c>]    lr : [<8055f620>]    psr: a00001d3
[    0.000000] sp : 80e01db8  ip : 00000000  fp : 00000000
[    0.000000] r10: 80e0bb80  r9 : 80eeec94  r8 : 80e01f20
[    0.000000] r7 : 80e01e84  r6 : 80e01dd0  r5 : 80e01df0  r4 : 80e01dd0
[    0.000000] r3 : 80ede0c0  r2 : 80eeec94  r1 : 00000000  r0 : 00000000
[    0.000000] Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
[    0.000000] Control: 00c5387d  Table: 80004008  DAC: 00000051
[    0.000000] Register r0 information: NULL pointer
[    0.000000] Register r1 information: NULL pointer
[    0.000000] Register r2 information: non-slab/vmalloc memory
[    0.000000] Register r3 information: non-slab/vmalloc memory
[    0.000000] Register r4 information: non-slab/vmalloc memory
[    0.000000] Register r5 information: non-slab/vmalloc memory
[    0.000000] Register r6 information: non-slab/vmalloc memory
[    0.000000] Register r7 information: non-slab/vmalloc memory
[    0.000000] Register r8 information: non-slab/vmalloc memory
[    0.000000] Register r9 information: non-slab/vmalloc memory
[    0.000000] Register r10 information: non-slab/vmalloc memory
[    0.000000] Register r11 information: NULL pointer
[    0.000000] Register r12 information: NULL pointer
[    0.000000] Process swapper (pid: 0, stack limit = 0x(ptrval))
[    0.000000] Stack: (0x80e01db8 to 0x80e02000)
[    0.000000] 1da0:                                                       80e01dd0 8055f620
[    0.000000] 1dc0: 80a98ac8 80eeec6c ffffff10 ffff0a01 80e01e68 80ece060 00000056 80e0bb80
[    0.000000] 1de0: 3ffff822 ffffff00 ffff0a01 00000000 80e0bb80 00000056 00000000 00000000
[    0.000000] 1e00: 80ece060 80e0bb80 00000000 80e138d8 80ece060 00000052 80172a4c 80173748
[    0.000000] 1e20: 80e01e74 80173748 00000052 9e9cd435 00000000 00000000 80b711d4 00000004
[    0.000000] 1e40: 800001d3 80eeec64 80e01e84 80e01f20 80eeec94 80b1d474 00000000 8055fc3c
[    0.000000] 1e60: 00000004 80e01f24 80e01e84 00000004 80e0bb80 80d3e0b4 80b1d474 8055fca0
[    0.000000] 1e80: 0000005c 61723501 006f646e 00000000 00000000 00000000 80e05d60 fffffffe
[    0.000000] 1ea0: 00000000 80b711d4 00000000 80b1d474 00000000 8017141c 80e01f14 00000000
[    0.000000] 1ec0: 00000000 00000000 00000000 80e0bb80 801ac33c 801fec4c 00000052 801fecbc
[    0.000000] 1ee0: 00000052 8016e834 00000052 80171c78 80e01f14 808e4360 80e0bb80 808f4438
[    0.000000] 1f00: 80e01f14 00000000 80d3e024 80eeec64 80e0bb80 80ee2914 80e57bf8 80560e44
[    0.000000] 1f20: 80d3e024 00000000 80ee2914 80d3e024 80d3e024 80b3e538 80ee2914 802bfa98
[    0.000000] 1f40: 00000010 00000020 80d3e024 80b3e538 80ee2914 80e57bf8 80d3e0b4 80b1d474
[    0.000000] 1f60: 00000000 80d13370 00000000 80ee7e38 80d3e024 80d16578 00000000 00000000
[    0.000000] 1f80: 00000000 80ec9000 80ec9000 80ec9000 9edffa00 00c0387d 80e05cc0 ffffffff
[    0.000000] 1fa0: 00000000 80d0115c ffffffff ffffffff 00000000 80d00768 00000000 80e0bb80
[    0.000000] 1fc0: 00000000 80d39a5c 00000000 00000000 00000000 80d004bc 00000051 00c0387d
[    0.000000] 1fe0: ffffffff 88392000 410fb767 00c5387d 00000000 00000000 00000000 00000000
[    0.000000]  random_get_entropy_fallback from extract_entropy.constprop.0+0x4c/0x1bc
[    0.000000]  extract_entropy.constprop.0 from crng_make_state+0x184/0x1a4
[    0.000000]  crng_make_state from _get_random_bytes.part.0+0x44/0xe8
[    0.000000]  _get_random_bytes.part.0 from get_random_u32+0xc8/0xe0
[    0.000000]  get_random_u32 from __kmem_cache_create+0x24/0x46c
[    0.000000]  __kmem_cache_create from create_boot_cache+0x94/0xbc
[    0.000000]  create_boot_cache from kmem_cache_init+0x68/0x178
[    0.000000]  kmem_cache_init from start_kernel+0x3b0/0x69c
[    0.000000]  start_kernel from 0x0
[    0.000000] Code: e52de004 ebfdbebb e59f300c e5930148 (e5903000)
[    0.000000] ---[ end trace 0000000000000000 ]---
...

Cheers,
Nathan
