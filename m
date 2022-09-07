Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7A05B0362
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiIGLuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIGLuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:50:10 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1F743333;
        Wed,  7 Sep 2022 04:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662551408; x=1694087408;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=06p9u6TStsH4fYNvlmCtOOyHSftCsaQeP5xPJW5zEIQ=;
  b=cqJ5jFy8M7C7u9BwZRVdR9SLEqkz8Q+umC4d1axXyRokcOI5JWsD9Hoq
   3tugq7Cxok0X8KhBYzmRAqNrIknLwYtqpm+nX5nioo+QWcm6f4YjdYVAm
   mHlsiQ2Auz8Y6uBfAQeEM5VC8cw7FRy0edFyes/fsFA60AYzkuy69TTGM
   AKX8D0uCU+jnuo6Wst4V70xxSFAs3E8XQKi0IsTaFzgdHFAKnHIOihesf
   pRaGgBXViKrZe3wO2P3F+U6Sq/x/ptN7vyh6IP+vHrhzS/+UIesbrBJv8
   oTHI5BDyV0gFUmgHpnkaF4vm6eaaMctRUS3FkAGXAMIU+v0C6YrXLWAdx
   g==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654552800"; 
   d="scan'208";a="26042678"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Sep 2022 13:50:05 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 07 Sep 2022 13:50:05 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 07 Sep 2022 13:50:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662551405; x=1694087405;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=06p9u6TStsH4fYNvlmCtOOyHSftCsaQeP5xPJW5zEIQ=;
  b=ZqMKYEZDwnfA6+8qg+I80sVXY4buzKir17F99y0ykopU+0heuz7B3xF3
   zl52LLJx9gfOWYSXM39+goSKUg7nDpofognN2nzFgH93j74X3N052mzLm
   N8Q02sArqNjwf1DrPQmDStktDrZpv33hA7Ymp/aJEB+mvOZ5MxR419/i7
   hVB6aA/jGoXDmWmswu0s6akEjtEoWfIDKx2gYLCPuUDBJ5tHUB5TPCJTi
   FdyKw2SnjqEQ+r6stZS7NWQ8vkHTZyZja0MrWd1awrtCahZcHSArFcWx8
   Kss/JM3jdWqL0pmyq7hQQG/cB2J5uNKK+Y/WztGz4SYOvY7TBXkUIIixU
   A==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654552800"; 
   d="scan'208";a="26042677"
Subject: Re: Re: [PATCH V5 5/8] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV_MWR
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Sep 2022 13:50:05 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id D597A280056;
        Wed,  7 Sep 2022 13:50:04 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Date:   Wed, 07 Sep 2022 13:50:02 +0200
Message-ID: <3198688.44csPzL39Z@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <80ff145c-7f83-6d5f-7c9f-9bae1b6ffb89@oss.nxp.com>
References: <20220822064536.3947512-1-peng.fan@oss.nxp.com> <2849448.e9J7NaK4W3@steina-w> <80ff145c-7f83-6d5f-7c9f-9bae1b6ffb89@oss.nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am Mittwoch, 7. September 2022, 04:41:46 CEST schrieb Peng Fan:
> On 9/6/2022 10:37 PM, Alexander Stein wrote:
> > Hello,
> > 
> > Am Montag, 22. August 2022, 08:45:33 CEST schrieb Peng Fan (OSS):
> >> From: Peng Fan <peng.fan@nxp.com>
> >> 
> >> i.MX8MP HDMI supports HDCP and HRV_MWR(HDMI RX Video Memory Write Master
> >> for RXRX validation), so add them.
> >> 
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >> 
> >>   drivers/soc/imx/imx8mp-blk-ctrl.c | 30 ++++++++++++++++++++++++++++++
> >>   1 file changed, 30 insertions(+)
> >> 
> >> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c
> >> b/drivers/soc/imx/imx8mp-blk-ctrl.c index 6f983adcb47c..527d45d12a54
> >> 100644
> >> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> >> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> >> @@ -235,6 +235,13 @@ static void imx8mp_hdmi_blk_ctrl_power_on(struct
> >> imx8mp_blk_ctrl *bc, regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
> >> BIT(12));
> >> 
> >>   		regmap_clear_bits(bc->regmap, HDMI_TX_CONTROL0, BIT(3));
> >>   		break;
> >> 
> >> +	case IMX8MP_HDMIBLK_PD_HDCP:
> >> +		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
> >> +		break;
> >> +	case IMX8MP_HDMIBLK_PD_HRV:
> >> +		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) |
> > 
> > BIT(4) | BIT(5));
> > 
> >> +		regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
> > 
> > BIT(15));
> > 
> >> +		break;
> >> 
> >>   	default:
> >>   		break;
> >>   	
> >>   	}
> >> 
> >> @@ -283,6 +290,13 @@ static void imx8mp_hdmi_blk_ctrl_power_off(struct
> >> imx8mp_blk_ctrl *bc, regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
> >> BIT(12));
> >> 
> >>   		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(22)
> > | 
> > | BIT(24));
> > | 
> >>   		break;
> >> 
> >> +	case IMX8MP_HDMIBLK_PD_HDCP:
> >> +		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL0,
> > 
> > BIT(11));
> > 
> >> +		break;
> >> +	case IMX8MP_HDMIBLK_PD_HRV:
> >> +		regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
> > 
> > BIT(15));
> > 
> >> +		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3)
> >> 
> > | BIT(4) |
> >> 
> >> BIT(5)); +		break;
> >> 
> >>   	default:
> >>   		break;
> >>   	
> >>   	}
> >> 
> >> @@ -365,6 +379,22 @@ static const struct imx8mp_blk_ctrl_domain_data
> >> imx8mp_hdmi_domain_data[] = { .num_clks = 2,
> >> 
> >>   		.gpc_name = "hdmi-tx-phy",
> >>   	
> >>   	},
> >> 
> >> +	[IMX8MP_HDMIBLK_PD_HRV] = {
> >> +		.name = "hdmiblk-hrv",
> >> +		.clk_names = (const char *[]){ "axi", "apb" },
> >> +		.num_clks = 2,
> >> +		.gpc_name = "hrv",
> >> +		.path_names = (const char *[]){"hrv"},
> >> +		.num_paths = 1,
> >> +	},
> >> +	[IMX8MP_HDMIBLK_PD_HDCP] = {
> >> +		.name = "hdmiblk-hdcp",
> >> +		.clk_names = (const char *[]){ "axi", "apb" },
> >> +		.num_clks = 2,
> >> +		.gpc_name = "hdcp",
> >> +		.path_names = (const char *[]){"hdcp"},
> >> +		.num_paths = 1,
> >> +	},
> >> 
> >>   };
> >>   
> >>   static const struct imx8mp_blk_ctrl_data imx8mp_hdmi_blk_ctl_dev_data =
> >>   {
> > 
> > Something is missing here. Iget the following error during boot:
> > [    0.886211] Unable to handle kernel NULL pointer dereference at virtual
> > address 0000000000000000
> > [    0.895043] Mem abort info:
> > [    0.897841]   ESR = 0x0000000096000004
> > [    0.901606]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    0.906942]   SET = 0, FnV = 0
> > [    0.910003]   EA = 0, S1PTW = 0
> > [    0.913159]   FSC = 0x04: level 0 translation fault
> > [    0.918054] Data abort info:
> > [    0.920943]   ISV = 0, ISS = 0x00000004
> > [    0.924791]   CM = 0, WnR = 0
> > [    0.927761] [0000000000000000] user address but active_mm is swapper
> > [    0.934157] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > [    0.939749] Modules linked in:
> > [    0.942813] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc4-
> > next-20220906+ #674 2c55fa642ba20b0dbb66c0e78dacc9ca96d5e733
> > [    0.954099] Hardware name: TQ-Systems i.MX8MPlus TQMa8MPxL on MBa8MPxL
> > (DT) [    0.961100] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
> > BTYPE=--) [    0.968099] pc : kobject_set_name_vargs+0x10/0xd0
> > [    0.972823] lr : dev_set_name+0x58/0x80
> > [    0.976674] sp : ffff800009c7b860
> > [    0.979997] x29: ffff800009c7b860 x28: ffff000002d728f8 x27:
> > 0000000000000150
> > [    0.987172] x26: 0000000000000009 x25: 0000000000000007 x24:
> > ffff800009ab8958
> > [    0.994347] x23: ffff0000000a0000 x22: ffff800008eb77d8 x21:
> > ffff000000225410
> > [    1.001524] x20: ffff800008eb7808 x19: 0000000000000000 x18:
> > 0000000000000000
> > [    1.008697] x17: 702d78742d696d64 x16: 682d6b6c62696d64 x15:
> > 68203a656d616e3e
> > [    1.015872] x14: 0000000000000000 x13: 70636468203a656d x12:
> > 616e5f6370673e2d
> > [    1.023047] x11: 61746164203a6c72 x10: 74632d6b6c622e30 x9 :
> > 7274632d6b6c622e
> > [    1.030222] x8 : 3030303063663233 x7 : 205d353039393738 x6 :
> > ffff800009a240e0
> > [    1.037397] x5 : 00000000ffffffd0 x4 : ffff800009c7b920 x3 :
> > 00000000ffffffd0
> > [    1.044572] x2 : ffff800009c7b8d0 x1 : ffff80000936ca78 x0 :
> > 0000000000000000
> > [    1.051749] Call trace:
> > [    1.054199]  kobject_set_name_vargs+0x10/0xd0
> > [    1.058574]  dev_set_name+0x58/0x80
> > [    1.062072]  imx8mp_blk_ctrl_probe+0x5c0/0x660
> > [    1.066534]  platform_probe+0x64/0x100
> > [    1.070297]  call_driver_probe+0x28/0x140
> > [    1.074322]  really_probe+0xc0/0x334
> > [    1.077909]  __driver_probe_device+0x84/0x144
> > [    1.082284]  driver_probe_device+0x38/0x130
> > [    1.086486]  __driver_attach+0xac/0x244
> > [    1.090334]  bus_for_each_dev+0x6c/0xc0
> > [    1.094184]  driver_attach+0x20/0x30
> > [    1.097772]  bus_add_driver+0x174/0x244
> > [    1.101622]  driver_register+0x74/0x120
> > [    1.105474]  __platform_driver_register+0x24/0x30
> > [    1.110197]  imx8mp_blk_ctrl_driver_init+0x18/0x20
> > [    1.115009]  do_one_initcall+0x58/0x200
> > [    1.118861]  do_initcalls+0x164/0x19c
> > [    1.122534]  kernel_init_freeable+0x134/0x17c
> > [    1.126909]  kernel_init+0x2c/0x150
> > [    1.130411]  ret_from_fork+0x10/0x20
> > [    1.134003] Code: a9bb7bfd 910003fd a90153f3 aa0003f3 (f9400000)
> > [    1.140127] ---[ end trace 0000000000000000 ]---
> > 
> > Adding some debug out shows:
> > [    0.866795] imx8mp-blk-ctrl 32fc0000.blk-ctrl: domain->power_dev: 0x0
> > [    0.873257] imx8mp-blk-ctrl 32fc0000.blk-ctrl: data->name: hdmiblk-hdcp
> > [    0.879905] imx8mp-blk-ctrl 32fc0000.blk-ctrl: data->gpc_name: hdcp
> > 
> > AFAICS the power domains 'hrv' and 'hdcp' are missing in the
> > 'hdmi_blk_ctrl: blk-ctrl@32fc0000' node thus resulting in a NULL pointer
> > from calling dev_pm_domain_attach_by_name().
> 
> The HDMI blk ctrl dts not landed in Shawn's branch, could you share me
> your dts change?

I don't have any dts changes for this matter. To get a bootable device, for 
now, I just removed the IMX8MP_HDMIBLK_PD_HRV and IMX8MP_HDMIBLK_PD_HDCP power 
domains from imx8mp_hdmi_domain_data.

> And dev_set_name, as I recall, Lucas has a patch to remove that.

Is this removal a fix or just a workaround?

Best regards,
Alexander



