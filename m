Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B346B572374
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiGLStf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiGLStD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:49:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D64C5;
        Tue, 12 Jul 2022 11:43:44 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 704D46601A26;
        Tue, 12 Jul 2022 19:43:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657651406;
        bh=qUGRCn6UpE/o1SkvdtBSvtKj3sIvs0psrS8jO3RhEcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/nHGPcpyZjMRNZ1UqpsdS9ftClviYiSaaeSH+m/yORDCxrVOdOq1BpiORVKPrMLL
         MrXkhQ0DJvx0CRZJ7nfakNnXNYw1ydt0MeLr+LwbcSb9WUosZBTnqa1uyn/znWBfDd
         n+29jWhAQYtqc9f0EiMUk5isO34uG+r/Z3qS+dwzHNj6sui5EXcWWJnO7p8Bru8pen
         2ACnvYqWgSZMCS1pPJeMVGUMr7NWm4Fal1qNrgWr3+IBvLj4Y/j50O1DF5u+04QpUa
         NkMjFApNQFYooBj462gS6e1aZdpwDKFhSvF1ugs+jcGvkOMvuZR/u/ls1u2GD4CfWq
         G8ZEs+hQxu+Qg==
Date:   Tue, 12 Jul 2022 14:43:21 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate
 ops
Message-ID: <20220712184321.f4p2esbfayhdut4y@notapiano>
References: <20220712113402.871838-1-wenst@chromium.org>
 <20220712113402.871838-2-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220712113402.871838-2-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

On Tue, Jul 12, 2022 at 07:34:01PM +0800, Chen-Yu Tsai wrote:
> In the previous commits that added CLK_OPS_PARENT_ENABLE, support for
> this flag was only added to rate change operations (rate setting and
> reparent) and disabling unused subtree. It was not added to the
> clock gate related operations. Any hardware driver that needs it for
> these operations will either see bogus results, or worse, hang.
> 
> This has been seen on MT8192 and MT8195, where the imp_ii2_* clk
> drivers set this, but dumping debugfs clk_summary would cause it
> to hang.
> 
> Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enable (part 2)")
> Fixes: a4b3518d146f ("clk: core: support clocks which requires parents enable (part 1)")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> 
> I'm guessing Stephen might have some things to say about adding forward
> declarations. Moving code around would make the patch larger though.
> 
>  drivers/clk/clk.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 7fc191c15507..b3de636eec84 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
[..]
> +static int clk_core_enable(struct clk_core *core);
> +static void clk_core_disable(struct clk_core *core);
> +
>  static void clk_core_unprepare(struct clk_core *core)
>  {
>  	lockdep_assert_held(&prepare_lock);
> @@ -835,6 +847,9 @@ static void clk_core_unprepare(struct clk_core *core)
>  
>  	WARN(core->enable_count > 0, "Unpreparing enabled %s\n", core->name);
>  
> +	if (core->flags & CLK_OPS_PARENT_ENABLE)
> +		clk_core_enable(core->parent);

Shouldn't it be clk_core_enable_lock ? Otherwise you're calling into
clk_core_enable without the enable_lock, which causes a lot of lockdep warnings
during boot [1]. Same thing for other enable/disable calls below.

Thanks,
Nícolas

[1] Warnings:

<4>[    5.781843] ------------[ cut here ]------------
<4>[    5.786823] WARNING: CPU: 5 PID: 1 at drivers/clk/clk.c:982 clk_core_disable+0x6c/0x2a0
<4>[    5.795258] Modules linked in:
<4>[    5.798652] CPU: 5 PID: 1 Comm: swapper/0 Tainted: G        W          5.19.0-rc5-next-20220707+ #214
<4>[    5.808318] Hardware name: Google Spherion (rev0 - 3) (DT)
<4>[    5.814179] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
<4>[    5.821548] pc : clk_core_disable+0x6c/0x2a0
<4>[    5.826176] lr : clk_core_disable+0x68/0x2a0
<4>[    5.830805] sp : ffff80000808ba50
<4>[    5.834458] x29: ffff80000808ba50 x28: 0000000000061a80 x27: 00000000000f4240
<4>[    5.842022] x26: 0000000000000020 x25: ffff23db40f86890 x24: 0000000000000001
<4>[    5.849587] x23: ffffb70fcbcba008 x22: ffffb70fcc3e1eb8 x21: ffff23db40f86890
<4>[    5.857152] x20: 0000000000000000 x19: ffff23db40d59d00 x18: 0000000000000028
<4>[    5.864717] x17: 00000000ffffffff x16: ffffb70fcb632518 x15: 000000000000100a
<4>[    5.872282] x14: 0000000000000040 x13: 0000000000000040 x12: 0000000000000400
<4>[    5.879847] x11: 0000000000000080 x10: 000000006a1a6693 x9 : ffffb70fcac15014
<4>[    5.887412] x8 : 00000000b7258824 x7 : ffffb70fcc6fc7b0 x6 : 0000000000000000
<4>[    5.894976] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000000000c0
<4>[    5.902540] x2 : ffff23db40258000 x1 : 0000000000000080 x0 : 0000000000000000
<4>[    5.910105] Call trace:
<4>[    5.912872]  clk_core_disable+0x6c/0x2a0
<4>[    5.917148]  clk_core_prepare+0x1f4/0x430
<4>[    5.921513]  clk_prepare+0x30/0x50
<4>[    5.925259]  clk_bulk_prepare+0x40/0xc0
<4>[    5.929447]  mtk_i2c_probe+0x3b8/0x610
<4>[    5.933546]  platform_probe+0x70/0xe0
<4>[    5.937558]  really_probe+0xc8/0x3b0
<4>[    5.941479]  __driver_probe_device+0x84/0x190
<4>[    5.946197]  driver_probe_device+0x44/0xf8
<4>[    5.950648]  __driver_attach+0xc8/0x1c8
<4>[    5.954834]  bus_for_each_dev+0x78/0xc8
<4>[    5.959020]  driver_attach+0x2c/0x38
<4>[    5.962941]  bus_add_driver+0x184/0x240
<4>[    5.967127]  driver_register+0x6c/0x128
<4>[    5.971314]  __platform_driver_register+0x30/0x40
<4>[    5.976386]  mtk_i2c_driver_init+0x24/0x30
<4>[    5.980840]  do_one_initcall+0x80/0x408
<4>[    5.985025]  kernel_init_freeable+0x2d0/0x358
<4>[    5.989739]  kernel_init+0x2c/0x138
<4>[    5.993572]  ret_from_fork+0x10/0x20
<4>[    5.997493] irq event stamp: 280038
<4>[    6.001322] hardirqs last  enabled at (280037): [<ffffb70fcb429490>] _raw_spin_unlock_irqrestore+0x80/0xa0
<4>[    6.011435] hardirqs last disabled at (280038): [<ffffb70fcb415838>] el1_dbg+0x28/0xa0
<4>[    6.019780] softirqs last  enabled at (280028): [<ffffb70fca410698>] __do_softirq+0x488/0x64c
<4>[    6.028739] softirqs last disabled at (280021): [<ffffb70fca4ab114>] irq_exit_rcu+0x1bc/0x1e8
<4>[    6.037704] ---[ end trace 0000000000000000 ]---


<4>[    4.962132] ------------[ cut here ]------------
<4>[    4.967111] WARNING: CPU: 5 PID: 1 at drivers/clk/clk.c:1041 clk_core_enable+0x74/0x2b8
<4>[    4.975546] Modules linked in:
<4>[    4.978940] CPU: 5 PID: 1 Comm: swapper/0 Tainted: G        W          5.19.0-rc5-next-20220707+ #214
<4>[    4.988606] Hardware name: Google Spherion (rev0 - 3) (DT)
<4>[    4.994468] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
<4>[    5.001838] pc : clk_core_enable+0x74/0x2b8
<4>[    5.006378] lr : clk_core_enable+0x70/0x2b8
<4>[    5.010918] sp : ffff80000808b9c0
<4>[    5.014571] x29: ffff80000808b9c0 x28: 0000000000061a80 x27: 00000000000f4240
<4>[    5.022136] x26: 0000000000000020 x25: ffff23db40f86890 x24: 0000000000000001
<4>[    5.029701] x23: ffff23db40f86890 x22: 0000000000000004 x21: ffff23db40f86890
<4>[    5.037266] x20: 0000000000000000 x19: ffff23db40d4fc00 x18: 0000000000000028
<4>[    5.044830] x17: 00000000ffffffff x16: ffffb70fcb632518 x15: 000000000000100a
<4>[    5.052395] x14: 0000000000000040 x13: 0000000000000040 x12: 0000000000000400
<4>[    5.059960] x11: 0000000000000080 x10: 000000006a1a6693 x9 : ffffb70fcac146e4
<4>[    5.067525] x8 : 00000000b7258824 x7 : ffffb70fcc6fc7b0 x6 : 0000000000000000
<4>[    5.075089] x5 : 0000000000000002 x4 : 0000000000000000 x3 : 00000000000000c0
<4>[    5.082655] x2 : ffff23db40258000 x1 : 0000000000000080 x0 : 0000000000000000
<4>[    5.090220] Call trace:
<4>[    5.092988]  clk_core_enable+0x74/0x2b8
<4>[    5.097175]  clk_core_enable+0x9c/0x2b8
<4>[    5.101363]  clk_core_enable+0x9c/0x2b8
<4>[    5.105550]  clk_core_prepare+0x1e4/0x430
<4>[    5.109914]  clk_prepare+0x30/0x50
<4>[    5.113660]  clk_bulk_prepare+0x40/0xc0
<4>[    5.117849]  mtk_i2c_probe+0x3b8/0x610
<4>[    5.121948]  platform_probe+0x70/0xe0
<4>[    5.125959]  really_probe+0xc8/0x3b0
<4>[    5.129881]  __driver_probe_device+0x84/0x190
<4>[    5.134597]  driver_probe_device+0x44/0xf8
<4>[    5.139048]  __driver_attach+0xc8/0x1c8
<4>[    5.143235]  bus_for_each_dev+0x78/0xc8
<4>[    5.147420]  driver_attach+0x2c/0x38
<4>[    5.151341]  bus_add_driver+0x184/0x240
<4>[    5.155527]  driver_register+0x6c/0x128
<4>[    5.159714]  __platform_driver_register+0x30/0x40
<4>[    5.164787]  mtk_i2c_driver_init+0x24/0x30
<4>[    5.169241]  do_one_initcall+0x80/0x408
<4>[    5.173426]  kernel_init_freeable+0x2d0/0x358
<4>[    5.178142]  kernel_init+0x2c/0x138
<4>[    5.181974]  ret_from_fork+0x10/0x20
<4>[    5.185895] irq event stamp: 279998
<4>[    5.189724] hardirqs last  enabled at (279997): [<ffffb70fcb416a9c>] exit_to_kernel_mode.isra.0+0x34/0x128
<4>[    5.199833] hardirqs last disabled at (279998): [<ffffb70fcb415838>] el1_dbg+0x28/0xa0
<4>[    5.208180] softirqs last  enabled at (279996): [<ffffb70fca410698>] __do_softirq+0x488/0x64c
<4>[    5.217139] softirqs last disabled at (279991): [<ffffb70fca4ab114>] irq_exit_rcu+0x1bc/0x1e8
<4>[    5.226103] ---[ end trace 0000000000000000 ]---


> +
>  	trace_clk_unprepare(core);
>  
>  	if (core->ops->unprepare)
> @@ -843,6 +858,9 @@ static void clk_core_unprepare(struct clk_core *core)
>  	clk_pm_runtime_put(core);
>  
>  	trace_clk_unprepare_complete(core);
> +
> +	if (core->flags & CLK_OPS_PARENT_ENABLE)
> +		clk_core_disable(core->parent);
>  	clk_core_unprepare(core->parent);
>  }
>  
> @@ -891,6 +909,9 @@ static int clk_core_prepare(struct clk_core *core)
>  		if (ret)
>  			goto runtime_put;
>  
> +		if (core->flags & CLK_OPS_PARENT_ENABLE)
> +			clk_core_enable(core->parent);
> +
>  		trace_clk_prepare(core);
>  
>  		if (core->ops->prepare)
> @@ -898,6 +919,9 @@ static int clk_core_prepare(struct clk_core *core)
>  
>  		trace_clk_prepare_complete(core);
>  
> +		if (core->flags & CLK_OPS_PARENT_ENABLE)
> +			clk_core_disable(core->parent);
> +
>  		if (ret)
>  			goto unprepare;
>  	}
> -- 
> 2.37.0.144.g8ac04bfd2-goog
> 
