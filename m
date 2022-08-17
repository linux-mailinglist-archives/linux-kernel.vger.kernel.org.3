Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768BF597404
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbiHQQTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiHQQTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:19:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640364DF11;
        Wed, 17 Aug 2022 09:18:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16389B81E35;
        Wed, 17 Aug 2022 16:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1763C433C1;
        Wed, 17 Aug 2022 16:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660753136;
        bh=dZtJQTvvpnveOiEslUcPtFuDI3gXU0VdPtDvQpCzkGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFGzX+meXJzoo7teu6Vc8jOP1yg/wg1fCbYxkfregQPBRXOSwQ0bOXfE6WOl7nnLM
         81XCJ/t4sRrMkppAbcmvRBgUPvPJz0qqhL0J9LQQF4YalrsYJfBYSMnRJg9LR7GTBJ
         QHq0ASaL9N+mvPHmKUfjsTLShJNMoZwcjB3aguYGakvNysZx7KMLE6DFc/uvmEDis8
         WXrLXACUxt46UAleZb9UPAm6Ryexa/+x2bXJljhWuPAmMKQcVYSzUwar5O3Ah/Wr++
         7/b29hv4z99oEOZ//k4tZC81pvMamVtWBCJpkS6JhdZBGLYcCLO/6UBYqVWvyqtttC
         hyttm3FWLJKcw==
Date:   Wed, 17 Aug 2022 09:18:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     ndesaulniers@google.com, llvm@lists.linux.dev,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Daire.McNamara@microchip.com, palmer@dabbelt.com
Subject: Re: [PATCH v2 00/12] PolarFire SoC reset controller & clock cleanups
Message-ID: <Yv0U7reygngXxWzo@dev-arch.thelio-3990X>
References: <20220704121558.2088698-1-conor.dooley@microchip.com>
 <bd14f1a2-750d-2511-df0a-85a9f5925f84@microchip.com>
 <YvP/bjh+wXihlrdG@dev-arch.thelio-3990X>
 <fc470bf4-33bb-d67b-3860-3ac775982f27@microchip.com>
 <YvQHtGObJwyBKGCQ@dev-arch.thelio-3990X>
 <3d2c56fa-8245-4992-2074-cd39677c2b3f@microchip.com>
 <d38d8b9c-45da-c464-264c-bebd084bdb17@microchip.com>
 <42354fef-8ca8-a81d-6af9-f250ecfd1924@microchip.com>
 <62bb08d7-0a14-13e4-5ca2-edb5ef3b9793@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62bb08d7-0a14-13e4-5ca2-edb5ef3b9793@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:17:11PM +0000, Conor.Dooley@microchip.com wrote:
> On 14/08/2022 12:41, Conor.Dooley@microchip.com wrote:
> >>
> >> Doesn't really matter since thats long enough to get past the switch
> >> out of earlycon which is where the clang built kernel dies.
> 
> I had forgotten something obvious: keep_bootcon. With that, on the sbi
> console I get a nice:
> 
> [    0.581754] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000b1
> [    0.591520] Oops [#1]
> [    0.594045] Modules linked in:
> [    0.597435] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1-00011-g8e1459cf4eca #1
> [    0.606188] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
> [    0.613012] epc : __clk_register+0x4a6/0x85c
> [    0.617759]  ra : __clk_register+0x49e/0x85c
> [    0.622489] epc : ffffffff803faf7c ra : ffffffff803faf74 sp : ffffffc80400b720
> [    0.630466]  gp : ffffffff810e93f8 tp : ffffffe77fe60000 t0 : ffffffe77ffb3800
> [    0.638443]  t1 : 000000000000000a t2 : ffffffffffffffff s0 : ffffffc80400b7c0
> [    0.646420]  s1 : 0000000000000001 a0 : 0000000000000001 a1 : 0000000000000000
> [    0.654396]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : 0000000000000000
> [    0.662373]  a5 : ffffffff803a5810 a6 : 0000000200000022 a7 : 0000000000000006
> [    0.670350]  s2 : ffffffff81099d48 s3 : ffffffff80d6e28e s4 : 0000000000000028
> [    0.678327]  s5 : ffffffff810ed3c8 s6 : ffffffff810ed3d0 s7 : ffffffe77ffbc100
> [    0.686304]  s8 : ffffffe77ffb1540 s9 : ffffffe77ffb1540 s10: 0000000000000008
> [    0.694281]  s11: 0000000000000000 t3 : 00000000000000c6 t4 : 0000000000000007
> [    0.702258]  t5 : ffffffff810c78c0 t6 : ffffffe77ff88cd0
> [    0.708125] status: 0000000200000120 badaddr: 00000000000000b1 cause: 000000000000000d
> [    0.716869] [<ffffffff803fb892>] devm_clk_hw_register+0x62/0xaa
> [    0.723420] [<ffffffff80403412>] mpfs_clk_probe+0x1e0/0x244
> [    0.729592] [<ffffffff80457dea>] platform_probe+0x82/0xa6
> [    0.735581] [<ffffffff8045593c>] call_driver_probe+0x22/0xa4
> [    0.741848] [<ffffffff804557da>] really_probe+0x13a/0x27a
> [    0.747819] [<ffffffff804549f8>] __driver_probe_device+0xc4/0xee
> [    0.754460] [<ffffffff804554d0>] driver_probe_device+0x3c/0x196
> [    0.761013] [<ffffffff804552cc>] __device_attach_driver+0xa2/0x18c
> [    0.767853] [<ffffffff8045284a>] bus_for_each_drv+0x76/0xba
> [    0.774016] [<ffffffff804547ca>] __device_attach+0xa0/0x15a
> [    0.780179] [<ffffffff80454896>] device_initial_probe+0x12/0x1a
> [    0.786732] [<ffffffff804529c6>] bus_probe_device+0x2e/0x7c
> [    0.792895] [<ffffffff8044f290>] device_add+0x21a/0x3aa
> [    0.798693] [<ffffffff805c323a>] of_device_add+0x28/0x32
> [    0.804578] [<ffffffff805c3c54>] of_platform_device_create_pdata+0x88/0xb2
> [    0.812181] [<ffffffff805c3e70>] of_platform_bus_create+0x14a/0x1a8
> [    0.819117] [<ffffffff805c3ea6>] of_platform_bus_create+0x180/0x1a8
> [    0.826053] [<ffffffff805c3f2a>] of_platform_populate+0x5c/0x96
> [    0.832606] [<ffffffff8082bbaa>] of_platform_default_populate_init+0xc2/0xd4
> [    0.840400] [<ffffffff800020e8>] do_one_initcall+0xbc/0x216
> [    0.846563] [<ffffffff8080126c>] do_initcall_level+0x82/0x94
> [    0.852830] [<ffffffff808011ae>] do_initcalls+0x5c/0x98
> [    0.858611] [<ffffffff8080114a>] do_basic_setup+0x20/0x28
> [    0.864583] [<ffffffff808010e0>] kernel_init_freeable+0xba/0x104
> [    0.871223] [<ffffffff80746856>] kernel_init+0x22/0x1ba
> [    0.877013] [<ffffffff80003700>] ret_from_exception+0x0/0xc
> [    0.883218] ---[ end trace 0000000000000000 ]---
> 
> At least I had somewhere to start. Since QEMU repros, I continued there with:
> 	$(QEMU)/qemu-system-riscv64 -s -S -M microchip-icicle-kit \
> 		-m 2G -smp 5 \
> 		-kernel $(vmlinux_bin) \
> 		-dtb $(dtb) \
> 		-initrd $(initramfs) \
> 		-display none -serial null \
> 		-serial stdio
> 
> Dumping the backtrace at the devm_clk_hw_register() callsites shows that
> it passes for:
> - the main pll in mpfs_clk_register_mssplls()
> - the "cfg" clocks in mpfs_clk_register_cfgs()
> - the first 4 periph clocks...
> 
> It fails on "clk_periph_timer" - which uses a different parent, that it
> tries to find using the macro:
> #define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT].cfg.hw)
> 
> If parent is RTCREF, that becomes: &mpfs_cfg_clks[33].cfg.hw
> 
> And yeah, thats well beyond the end of the array!
> 
> Booting with gcc, and looking at the clock summary:
>   mssrefclk                            1        1        0   125000000          0     0  50000         Y
>      clk_rtcref                        0        0        0     1000000          0     0  50000         Y
>         clk_periph_timer               0        0        0     1000000          0     0  50000         N
> 
> This is reported correctly, so how this works for either gcc or clang now, or
> gcc with the patches applied, I am not really too sure..
> 
> On v6.0-rc1, gcc and clang show:
>   mssrefclk                            1        1        0   125000000          0     0  50000         Y
>      clk_rtcref                        0        0        0     1000000          0     0  50000         Y
> 
> I guess this may fail gracefully as the pointer is actually null, but
> the extra level of indirection added by my patch started tripping up
> the error checking. I must just not have noticed because I added RTCREF
> in a bit of a hurry trying to fix a bug in time for 5.18:
> https://lore.kernel.org/linux-clk/986c73df-9634-d18b-eed3-37584fa2ea89@conchuod.ie/#t
> 
> Obviously I've got to fix the bug itself now, but now I am left wondering
> about GCC's behaviour rather than clang/llvm's!
> 
> Thanks Nathan - if even just for being a rubber duck :)

Hey, at least it turned out to be something other than a compiler bug,
those are not very fun :) I am definitely surprised that GCC has no
issues, I wonder if KASAN would have exposed this problem sooner?

Cheers,
Nathan
