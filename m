Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CF957068E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiGKPEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGKPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135EC1F2F7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F1B66158E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F079FC34115;
        Mon, 11 Jul 2022 15:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657551867;
        bh=j4qQMw/sM7y7phwzdA4CGQKgj7hvSPMR5J++DJHhS50=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=uJ9N1fi9KuP1iYsVzBh7WnT0RLUUbPFPrfzfoDvK3Sfibm97PW72Xb5Tcygz55W4p
         6aWJ/GpYyjxQxuci4KiNcP1mVfAM17FX7EPeAjLEEB9yfsPDUWy51ASeEPI3o7GwH+
         wLWCNg0lCRvQsxFDIY8vH+EtxxsvJ6zDkhjupBOXV+QCnRlBqMhLRqVmQWUSzO/uUo
         oPlqTLRf80pX0n3bTdGsnu8FdNoCvK7tlTvkeNzImadWhAU0bL5wme0VhADtBw0830
         QemRIoRJ2Xm6sS/s2a9U0exX4kkk8uE0trq7R2s0677ywIzVoFi0kV9KvVdod3voe7
         JucoFp5BAUjYA==
From:   Mark Brown <broonie@kernel.org>
To:     alexandru.elisei@arm.com, linux-rockchip@lists.infradead.org,
        lgirdwood@gmail.com, tiwai@suse.com, alsa-devel@alsa-project.org,
        judyhsiao@chromium.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220711130522.401551-1-alexandru.elisei@arm.com>
References: <20220711130522.401551-1-alexandru.elisei@arm.com>
Subject: Re: [PATCH] ASoC: rockchip: i2s: Fix NULL pointer dereference when pinctrl is not found
Message-Id: <165755186571.461155.936395477737950981.b4-ty@kernel.org>
Date:   Mon, 11 Jul 2022 16:04:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 14:05:22 +0100, Alexandru Elisei wrote:
> Commit a5450aba737d ("ASoC: rockchip: i2s: switch BCLK to GPIO") switched
> BCLK to GPIO functions when probing the i2s bus interface, but missed
> adding a check for when devm_pinctrl_get() returns an error.  This can lead
> to the following NULL pointer dereference on a rockpro64-v2 if there are no
> "pinctrl" properties in the i2s device tree node:
> 
> [    0.658381] rockchip-i2s ff880000.i2s: failed to find i2s default state
> [    0.658993] rockchip-i2s ff880000.i2s: failed to find i2s gpio state
> [    0.660072] rockchip-i2s ff890000.i2s: failed to find i2s default state
> [    0.660670] rockchip-i2s ff890000.i2s: failed to find i2s gpio state
> [    0.661716] rockchip-i2s ff8a0000.i2s: failed to find i2s pinctrl
> [    0.662276] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000005
> [    0.663061] Mem abort info:
> [    0.663317]   ESR = 0x0000000096000004
> [    0.663658]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.664136]   SET = 0, FnV = 0
> [    0.664171] mmc2: SDHCI controller on fe330000.mmc [fe330000.mmc] using ADMA
> [    0.664409]   EA = 0, S1PTW = 0
> [    0.664415]   FSC = 0x04: level 0 translation fault
> [    0.664421] Data abort info:
> [    0.666050]   ISV = 0, ISS = 0x00000004
> [    0.666399]   CM = 0, WnR = 0
> [    0.666671] [0000000000000005] user address but active_mm is swapper
> [    0.667240] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    0.667742] Modules linked in:
> [    0.668028] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc6 #300
> [    0.668608] Hardware name: Pine64 RockPro64 v2.0 (DT)
> [    0.669062] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.669689] pc : pinctrl_lookup_state+0x20/0xc0
> [    0.670110] lr : rockchip_i2s_probe+0x1a8/0x54c
> [    0.670527] sp : ffff80000a17bb30
> [    0.670829] x29: ffff80000a17bb30 x28: 0000000000000000 x27: ffff8000097c04c8
> [    0.671480] x26: ffff800009871060 x25: ffff800009871078 x24: ffff000001c11368
> [    0.672129] x23: ffff8000092dc850 x22: ffffffffffffffed x21: ffff8000096f7e98
> [    0.672776] x20: ffffffffffffffed x19: ffff000001d92480 x18: ffffffffffffffff
> [    0.673423] x17: 000000040044ffff x16: ffff0000f77db2d0 x15: 0764076e07690766
> [    0.674070] x14: 0720076f07740720 x13: ffff800009e129f0 x12: 000000000000038d
> [    0.674717] x11: 000000000000012f x10: ffff800009e6a9f0 x9 : ffff800009e129f0
> [    0.675364] x8 : 00000000ffffefff x7 : ffff800009e6a9f0 x6 : 80000000fffff000
> [    0.676011] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
> [    0.676657] x2 : 0000000000000000 x1 : ffff8000096f7e98 x0 : ffffffffffffffed
> [    0.677304] Call trace:
> [    0.677531]  pinctrl_lookup_state+0x20/0xc0
> [    0.677914]  rockchip_i2s_probe+0x1a8/0x54c
> [    0.678297]  platform_probe+0x68/0xc0
> [    0.678638]  really_probe.part.0+0x9c/0x2ac
> [    0.679027]  __driver_probe_device+0x98/0x144
> [    0.679429]  driver_probe_device+0xac/0x140
> [    0.679814]  __driver_attach+0xf8/0x184
> [    0.680169]  bus_for_each_dev+0x70/0xd0
> [    0.680524]  driver_attach+0x24/0x30
> [    0.680856]  bus_add_driver+0x150/0x200
> [    0.681210]  driver_register+0x78/0x130
> [    0.681560]  __platform_driver_register+0x28/0x34
> [    0.681988]  rockchip_i2s_driver_init+0x1c/0x28
> [    0.682407]  do_one_initcall+0x50/0x1c0
> [    0.682760]  kernel_init_freeable+0x204/0x288
> [    0.683160]  kernel_init+0x28/0x13c
> [    0.683482]  ret_from_fork+0x10/0x20
> [    0.683816] Code: aa0003f4 a9025bf5 aa0003f6 aa0103f5 (f8418e93)
> [    0.684365] ---[ end trace 0000000000000000 ]---
> [    0.684813] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    0.685500] SMP: stopping secondary CPUs
> [    0.685995] Kernel Offset: disabled
> [    0.686310] CPU features: 0x800,00105811,00001086
> [    0.686736] Memory Limit: none
> [    0.687021] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: i2s: Fix NULL pointer dereference when pinctrl is not found
      commit: 26b9f2fa7b1c6aba6fa9b83274a3e54868f69562

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
