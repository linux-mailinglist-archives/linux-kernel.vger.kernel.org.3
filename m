Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EB75835C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 01:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiG0XrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 19:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiG0XrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 19:47:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515492A244;
        Wed, 27 Jul 2022 16:47:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAAF761736;
        Wed, 27 Jul 2022 23:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501BFC433D6;
        Wed, 27 Jul 2022 23:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658965639;
        bh=lbu5zPdYF9W+kJoFAZzKphWhxdbHEfKvdS1DNBnOYnI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=R/x9nvQSQSU1hdiddXhKn5BkYFHBFZ4RTZ8QlBUzryOuUJ2CPL03lx8qdcXdjin4t
         44DD45N6nP9ooPjHjsgP1mZqmcfreULSW3tmdfKgoqnJ4qW04M4fHXTeYYfucf+7O2
         IGojEBrHPpCJ7eKuLE5kAgQ/DbkkubgxXDb3Otlhbnecw8AUxbs+ERhvv3DqWMS81E
         Tu92L//5zU4Vus7kEHlg3Yl5fwCM0Cz8Uptdzq3u7JZ4dCKalChJkPLN1+T9B6kHfy
         0KPW+VAIxUi9TD98Ig9G9b9IoQCaYQkJVmd1Rqc1ENDBkS0t7RjtxiC8EQKRBPxft6
         ahlGhhIt13ApA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220719183725.2605141-1-jernej.skrabec@gmail.com>
References: <20220719183725.2605141-1-jernej.skrabec@gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: Fix H6 RTC clock definition
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, andre.przywara@arm.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, samuel@sholland.org,
        wens@csie.org
Date:   Wed, 27 Jul 2022 16:47:17 -0700
User-Agent: alot/0.10
Message-Id: <20220727234719.501BFC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jernej Skrabec (2022-07-19 11:37:25)
> While RTC clock was added in H616 ccu_common list, it was not in H6
> list. That caused invalid pointer dereference like this:
>=20
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
0000000020c
> Mem abort info:
>   ESR =3D 0x96000004
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x04: level 0 translation fault
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000004
>   CM =3D 0, WnR =3D 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000004d574000
> [000000000000020c] pgd=3D0000000000000000, p4d=3D0000000000000000
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> CPU: 3 PID: 339 Comm: cat Tainted: G    B             5.18.0-rc1+ #1352
> Hardware name: Tanix TX6 (DT)
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : ccu_gate_is_enabled+0x48/0x74
> lr : ccu_gate_is_enabled+0x40/0x74
> sp : ffff80000c0b76d0
> x29: ffff80000c0b76d0 x28: 00000000016e3600 x27: 0000000000000000
> x26: 0000000000000000 x25: 0000000000000002 x24: ffff00000952fe08
> x23: ffff800009611400 x22: ffff00000952fe79 x21: 0000000000000000
> x20: 0000000000000001 x19: ffff80000aad6f08 x18: 0000000000000000
> x17: 2d2d2d2d2d2d2d2d x16: 2d2d2d2d2d2d2d2d x15: 2d2d2d2d2d2d2d2d
> x14: 0000000000000000 x13: 00000000f2f2f2f2 x12: ffff700001816e89
> x11: 1ffff00001816e88 x10: ffff700001816e88 x9 : dfff800000000000
> x8 : ffff80000c0b7447 x7 : 0000000000000001 x6 : ffff700001816e88
> x5 : ffff80000c0b7440 x4 : 0000000000000001 x3 : ffff800008935c50
> x2 : dfff800000000000 x1 : 0000000000000000 x0 : 000000000000020c
> Call trace:
>  ccu_gate_is_enabled+0x48/0x74
>  clk_core_is_enabled+0x7c/0x1c0
>  clk_summary_show_subtree+0x1dc/0x334
>  clk_summary_show_subtree+0x250/0x334
>  clk_summary_show_subtree+0x250/0x334
>  clk_summary_show_subtree+0x250/0x334
>  clk_summary_show_subtree+0x250/0x334
>  clk_summary_show+0x90/0xdc
>  seq_read_iter+0x248/0x6d4
>  seq_read+0x17c/0x1fc
>  full_proxy_read+0x90/0xf0
>  vfs_read+0xdc/0x28c
>  ksys_read+0xc8/0x174
>  __arm64_sys_read+0x44/0x5c
>  invoke_syscall+0x60/0x190
>  el0_svc_common.constprop.0+0x7c/0x160
>  do_el0_svc+0x38/0xa0
>  el0_svc+0x68/0x160
>  el0t_64_sync_handler+0x10c/0x140
>  el0t_64_sync+0x18c/0x190
> Code: d1006260 97e5c981 785e8260 8b0002a0 (b9400000)
> ---[ end trace 0000000000000000 ]---

Applied to clk-fixes
