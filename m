Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCF1544CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbiFIM5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244596AbiFIM5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:57:39 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9125C140F8;
        Thu,  9 Jun 2022 05:57:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id BB8ACDFD85;
        Thu,  9 Jun 2022 05:57:36 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L-manq4K8c1y; Thu,  9 Jun 2022 05:57:35 -0700 (PDT)
Message-ID: <9ca308543e0acf401b465499217393091b6dad22.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1654779455; bh=eCZUkhocmgpPxm9Ts4u3z74JV2AnwXB5e1uOjwQO9K8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LAsX7M6B23ydB8VQ7AaryzY/cl/ZS2PUUFU+St9W4BswFHjiTJ45LxwTewQ6bOH9P
         UbfEzMGYkzKgF9MJ/z7l92kP5yvVdEj1cuarpbjVJcqEyYjICe2DzC5R+3FWxvY12F
         mVsOdRSibG9x0e0oF9k24WwNXdf7UwZfU0+BgMj4GnhdIneaZZ8nuNOywV1Sjj0/ol
         3+Zp2ofb52c5vimxacfzdincewdQGVICj/Jo4ku6YO4vt9MEb/iEu5c7u9R7eCVTub
         T+bn1Dab2Y1UlNRkIsTGDEmjJzugn9yzx97RVok72ze5se2te0t9WflGtiTIgAjoeL
         Pg0k+WcVbgfLg==
Subject: Re: soc: imx: gpcv2: regulator issue with system suspend on imx8mq
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, peng.fan@nxp.com,
        festevam@gmail.com, lgirdwood@gmail.com
Cc:     linux-media <linux-media@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        kernel@puri.sm
Date:   Thu, 09 Jun 2022 14:57:28 +0200
In-Reply-To: <2d5d3bbec443742506e39488dbfbf724bb4ca93f.camel@puri.sm>
References: <2d5d3bbec443742506e39488dbfbf724bb4ca93f.camel@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 09.06.2022 um 11:41 +0200 schrieb Martin Kepplinger:
> hi Lucas and all interested in suspend to ram on imx8mq,
> 
> This is slighly repeating my previous observations that still apply,
> but summarizing the situation:
> 
> s2idle should work on mainline when looking at the implementations of
> platform drivers. With the missing bits
> https://source.codeaurora.org/external/imx/linux-imx/commit/?h=imx_5.10.35_2.0.0_imx8ulp_er&id=ab850d655c22df562c27c9d6775a26b6df6865b5
> and
> https://lore.kernel.org/linux-arm-kernel/1631554694-9599-7-git-send-email-abel.vesa@nxp.com/
> suspend to ram should work too,
> and it does for me, except when a power domain is using a board-
> regulator as power-supply that is not always-on, but controlled by a
> driver. (when I describe these as "always-on", things are fine
> (except
> for unrelated edgecases)) here's the example I'm running where I
> don't
> describe "buck3" as always-on, but etnaviv runtime pm is controlling
> it:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi#n1161
> When starting to resume, the following happens:
> 
> [  139.985440] Enabling non-boot CPUs ...
> [  139.990363] Detected VIPT I-cache on CPU1
> [  139.990413] GICv3: CPU1: found redistributor 1 region
> 0:0x00000000388a0000
> [  139.990487] CPU1: Booted secondary processor 0x0000000001
> [0x410fd034]
> [  139.991445] CPU1 is up
> [  140.011836] Detected VIPT I-cache on CPU2
> [  140.011852] GICv3: CPU2: found redistributor 2 region
> 0:0x00000000388c0000
> [  140.011876] CPU2: Booted secondary processor 0x0000000002
> [0x410fd034]
> [  140.012284] CPU2 is up
> [  140.032739] Detected VIPT I-cache on CPU3
> [  140.032756] GICv3: CPU3: found redistributor 3 region
> 0:0x00000000388e0000
> [  140.032780] CPU3: Booted secondary processor 0x0000000003
> [0x410fd034]
> [  140.033310] CPU3 is up
> [  140.158791] imx-pgc imx-pgc-domain.5: failed to enable regulator:
> -
> 110

the call trace here is

[  901.637677]  imx_pgc_power_up+0x2e0/0x330
[  901.641696]  _genpd_power_on+0x80/0x16c
[  901.645540]  genpd_sync_power_on.part.0+0xac/0xe0
[  901.650248]  genpd_resume_noirq+0x70/0x120
[  901.654347]  dpm_run_callback+0x60/0x1f0
[  901.658271]  device_resume_noirq+0x108/0x230
[  901.662542]  dpm_noirq_resume_devices+0x12c/0x334
[  901.667248]  dpm_resume_noirq+0x1c/0x30
[  901.671085]  suspend_devices_and_enter+0x31c/0x894
[  901.675884]  pm_suspend+0x3a0/0x41c
[  901.679374]  state_store+0x98/0x120
[  901.682864]  kobj_attr_store+0x1c/0x30
[  901.686621]  sysfs_kf_write+0x50/0x60

> 
> trying runtime-resume in system-suspend for i2c busses didn't help me
> here for example. What's your idea for solving this? (regulator
> always-
> on is not an acceptable workaround :) I'm always happy to test
> concrete
> ideas and would like to know from anyone who uses system suspend on
> imx8mq.
> 
> history
> -------
> last time this came to my attention via the mainling lists was the
> VPU
> addition:
> https://lore.kernel.org/linux-arm-kernel/8ed3a28d59b442b531e68e95d83b187bb3392940.camel@puri.sm/
> but for the above logs and all current tests, I ignore the VPU (set
> the
> power-supply always-on) simply because the the driver is in staging
> and
> seems to create a different problem when suspending, and the GPU
> power-
> supply example is very well suited to highlight the problem.
> 
> but before that, "gpcv2: support systemd suspend/resume"
> ( 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=da4112230f86
> ) didn't work for me, see:
> https://lore.kernel.org/all/a20ecd639f8e8b7fa4a9bed7a8e9590225262784.camel@puri.sm/
> 
> thanks a lot,
> 
>                                martin
> 
> 


