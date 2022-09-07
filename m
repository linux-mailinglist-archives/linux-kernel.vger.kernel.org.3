Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E98B5B05AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIGNtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiIGNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:49:52 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD2E18B24;
        Wed,  7 Sep 2022 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662558589; x=1694094589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UcyXTc1qBaJiw5hSVGQ80RPVBU9Q/6eQBMk1GKk8gdU=;
  b=OF9Usb8TLT/J7ncLCMGXJb4p4JhlKjO1PxxGISnj5+e1iNffT+sqLhBU
   QeEtxSLwPNmk/ibmK65sX3K8UJEJ9XoFPJQhVGAKoQKKNmdVtHgBuKQWZ
   Y4yDJLDRoWCqDxQq+GszzILXmpjj3DF7kccQtvXnaD0STIe/g/+szssg5
   FYodA3Dsygu5mazur8P+NSM8Zjy6le1tGIHzeVXpwa1xGul2v/PnmpHA4
   qyvz+EZIWeSBNaCbO3QZ4c35aQZjkcUH5yWvzDt0+zk+li3xXbO9yXHu4
   izY0A+Y7G5TXiusuRJ85Zbu6dLWPFcYVceJ8JFpgHLXxr+9ZutJTFJwzR
   g==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654552800"; 
   d="scan'208";a="26045951"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Sep 2022 15:49:45 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 07 Sep 2022 15:49:45 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 07 Sep 2022 15:49:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662558585; x=1694094585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UcyXTc1qBaJiw5hSVGQ80RPVBU9Q/6eQBMk1GKk8gdU=;
  b=nBrewpJ4X7pfXg4MF+u36SusZYZzrAOpg/I30esLw2WRRDMpdFDy4Ft1
   cAPZmXynGZmSHXXhaMR2bGUALHPIQKAusS3VM7NHvz1nzhxWjRlEf0Z65
   WwTsxjyzQS+rxQk33uJICVCmTHP+iLWYdDkec3d9zIXOdO3gGzbB+Aujg
   N31+xDP48++7/+TkWrCfTPAJsL5aDN1wO78CjTQheV8zptNcs3GiZbd6a
   xsswrEpo+XkBI5hWiJ5CSKyqtS44Q34rLhyRvh6pC76I2hZVKFEJuEOTL
   Xpf/xEgaN2DIUu8BYVHUVT858heOjlcQ42ZNr/ACy74z431rfcF5F9bUy
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654552800"; 
   d="scan'208";a="26045950"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Sep 2022 15:49:45 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 5C6A6280056;
        Wed,  7 Sep 2022 15:49:45 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH V5 5/8] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV_MWR
Date:   Wed, 07 Sep 2022 15:49:43 +0200
Message-ID: <1909851.PYKUYFuaPT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <DU0PR04MB9417419FC095F8B1C525041F88419@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220822064536.3947512-1-peng.fan@oss.nxp.com> <3198688.44csPzL39Z@steina-w> <DU0PR04MB9417419FC095F8B1C525041F88419@DU0PR04MB9417.eurprd04.prod.outlook.com>
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

Hi,

Am Mittwoch, 7. September 2022, 13:53:26 CEST schrieb Peng Fan:
> > Subject: Re: Re: [PATCH V5 5/8] soc: imx: add i.MX8MP HDMI blk ctrl
> > HDCP/HRV_MWR
> > 
> > Hello,
> > 
> > Am Mittwoch, 7. September 2022, 04:41:46 CEST schrieb Peng Fan:
> > > On 9/6/2022 10:37 PM, Alexander Stein wrote:
> > > > Hello,
> > > > 
> > > > Am Montag, 22. August 2022, 08:45:33 CEST schrieb Peng Fan (OSS):
> > > >> From: Peng Fan <peng.fan@nxp.com>
> > > >> 
> > > >> i.MX8MP HDMI supports HDCP and HRV_MWR(HDMI RX Video
> > 
> > Memory Write
> > 
> > > >> Master for RXRX validation), so add them.
> > > >> 
> > > >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > >> ---
> > > >> 
> > > >>   drivers/soc/imx/imx8mp-blk-ctrl.c | 30
> > 
> > ++++++++++++++++++++++++++++++
> > 
> > > >>   1 file changed, 30 insertions(+)
> > > >> 
> > > >> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c
> > > >> b/drivers/soc/imx/imx8mp-blk-ctrl.c index
> > > >> 6f983adcb47c..527d45d12a54
> > > >> 100644
> > > >> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> > > >> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> > > >> @@ -235,6 +235,13 @@ static void
> > > >> imx8mp_hdmi_blk_ctrl_power_on(struct
> > > >> imx8mp_blk_ctrl *bc, regmap_set_bits(bc->regmap,
> > > >> HDMI_RTX_RESET_CTL0, BIT(12));
> > > >> 
> > > >>   		regmap_clear_bits(bc->regmap, 
HDMI_TX_CONTROL0,
> > 
> > BIT(3));
> > 
> > > >>   		break;
> > > >> 
> > > >> +	case IMX8MP_HDMIBLK_PD_HDCP:
> > > >> +		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL0,
> > 
> > BIT(11));
> > 
> > > >> +		break;
> > > >> +	case IMX8MP_HDMIBLK_PD_HRV:
> > > >> +		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3)
> > > > 
> > > > BIT(4) | BIT(5));
> > > > 
> > > >> +		regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
> > > > 
> > > > BIT(15));
> > > > 
> > > >> +		break;
> > > >> 
> > > >>   	default:
> > > >>   		break;
> > > >>   	
> > > >>   	}
> > > >> 
> > > >> @@ -283,6 +290,13 @@ static void
> > > >> imx8mp_hdmi_blk_ctrl_power_off(struct
> > > >> imx8mp_blk_ctrl *bc, regmap_clear_bits(bc->regmap,
> > > >> HDMI_RTX_RESET_CTL0, BIT(12));
> > > >> 
> > > >>   		regmap_clear_bits(bc->regmap, 
HDMI_RTX_CLK_CTL1,
> > 
> > BIT(22)
> > 
> > > > | BIT(24));
> > > > | 
> > > >>   		break;
> > > >> 
> > > >> +	case IMX8MP_HDMIBLK_PD_HDCP:
> > > >> +		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL0,
> > > > 
> > > > BIT(11));
> > > > 
> > > >> +		break;
> > > >> +	case IMX8MP_HDMIBLK_PD_HRV:
> > > >> +		regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
> > > > 
> > > > BIT(15));
> > > > 
> > > >> +		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3)
> > > >> 
> > > > | BIT(4) |
> > > >> 
> > > >> BIT(5)); +		break;
> > > >> 
> > > >>   	default:
> > > >>   		break;
> > > >>   	
> > > >>   	}
> > > >> 
> > > >> @@ -365,6 +379,22 @@ static const struct
> > > >> imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] =
> > 
> > { .num_clks
> > 
> > > >> = 2,
> > > >> 
> > > >>   		.gpc_name = "hdmi-tx-phy",
> > > >>   	
> > > >>   	},
> > > >> 
> > > >> +	[IMX8MP_HDMIBLK_PD_HRV] = {
> > > >> +		.name = "hdmiblk-hrv",
> > > >> +		.clk_names = (const char *[]){ "axi", "apb" },
> > > >> +		.num_clks = 2,
> > > >> +		.gpc_name = "hrv",
> > > >> +		.path_names = (const char *[]){"hrv"},
> > > >> +		.num_paths = 1,
> > > >> +	},
> > > >> +	[IMX8MP_HDMIBLK_PD_HDCP] = {
> > > >> +		.name = "hdmiblk-hdcp",
> > > >> +		.clk_names = (const char *[]){ "axi", "apb" },
> > > >> +		.num_clks = 2,
> > > >> +		.gpc_name = "hdcp",
> > > >> +		.path_names = (const char *[]){"hdcp"},
> > > >> +		.num_paths = 1,
> > > >> +	},
> > > >> 
> > > >>   };
> > > >>   
> > > >>   static const struct imx8mp_blk_ctrl_data
> > 
> > imx8mp_hdmi_blk_ctl_dev_data =
> > 
> > > >>   {
> > > > 
> > > > Something is missing here. Iget the following error during boot:
> > > > [    0.886211] Unable to handle kernel NULL pointer dereference at
> > 
> > virtual
> > 
> > > > address 0000000000000000
> > > > [    0.895043] Mem abort info:
> > > > [    0.897841]   ESR = 0x0000000096000004
> > > > [    0.901606]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > > [    0.906942]   SET = 0, FnV = 0
> > > > [    0.910003]   EA = 0, S1PTW = 0
> > > > [    0.913159]   FSC = 0x04: level 0 translation fault
> > > > [    0.918054] Data abort info:
> > > > [    0.920943]   ISV = 0, ISS = 0x00000004
> > > > [    0.924791]   CM = 0, WnR = 0
> > > > [    0.927761] [0000000000000000] user address but active_mm is
> > 
> > swapper
> > 
> > > > [    0.934157] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > > > [    0.939749] Modules linked in:
> > > > [    0.942813] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc4-
> > > > next-20220906+ #674 2c55fa642ba20b0dbb66c0e78dacc9ca96d5e733
> > > > [    0.954099] Hardware name: TQ-Systems i.MX8MPlus TQMa8MPxL on
> > 
> > MBa8MPxL
> > 
> > > > (DT) [    0.961100] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -
> > 
> > SSBS
> > 
> > > > BTYPE=--) [    0.968099] pc : kobject_set_name_vargs+0x10/0xd0
> > > > [    0.972823] lr : dev_set_name+0x58/0x80
> > > > [    0.976674] sp : ffff800009c7b860
> > > > [    0.979997] x29: ffff800009c7b860 x28: ffff000002d728f8 x27:
> > > > 0000000000000150
> > > > [    0.987172] x26: 0000000000000009 x25: 0000000000000007 x24:
> > > > ffff800009ab8958
> > > > [    0.994347] x23: ffff0000000a0000 x22: ffff800008eb77d8 x21:
> > > > ffff000000225410
> > > > [    1.001524] x20: ffff800008eb7808 x19: 0000000000000000 x18:
> > > > 0000000000000000
> > > > [    1.008697] x17: 702d78742d696d64 x16: 682d6b6c62696d64 x15:
> > > > 68203a656d616e3e
> > > > [    1.015872] x14: 0000000000000000 x13: 70636468203a656d x12:
> > > > 616e5f6370673e2d
> > > > [    1.023047] x11: 61746164203a6c72 x10: 74632d6b6c622e30 x9 :
> > > > 7274632d6b6c622e
> > > > [    1.030222] x8 : 3030303063663233 x7 : 205d353039393738 x6 :
> > > > ffff800009a240e0
> > > > [    1.037397] x5 : 00000000ffffffd0 x4 : ffff800009c7b920 x3 :
> > > > 00000000ffffffd0
> > > > [    1.044572] x2 : ffff800009c7b8d0 x1 : ffff80000936ca78 x0 :
> > > > 0000000000000000
> > > > [    1.051749] Call trace:
> > > > [    1.054199]  kobject_set_name_vargs+0x10/0xd0
> > > > [    1.058574]  dev_set_name+0x58/0x80
> > > > [    1.062072]  imx8mp_blk_ctrl_probe+0x5c0/0x660
> > > > [    1.066534]  platform_probe+0x64/0x100
> > > > [    1.070297]  call_driver_probe+0x28/0x140
> > > > [    1.074322]  really_probe+0xc0/0x334
> > > > [    1.077909]  __driver_probe_device+0x84/0x144
> > > > [    1.082284]  driver_probe_device+0x38/0x130
> > > > [    1.086486]  __driver_attach+0xac/0x244
> > > > [    1.090334]  bus_for_each_dev+0x6c/0xc0
> > > > [    1.094184]  driver_attach+0x20/0x30
> > > > [    1.097772]  bus_add_driver+0x174/0x244
> > > > [    1.101622]  driver_register+0x74/0x120
> > > > [    1.105474]  __platform_driver_register+0x24/0x30
> > > > [    1.110197]  imx8mp_blk_ctrl_driver_init+0x18/0x20
> > > > [    1.115009]  do_one_initcall+0x58/0x200
> > > > [    1.118861]  do_initcalls+0x164/0x19c
> > > > [    1.122534]  kernel_init_freeable+0x134/0x17c
> > > > [    1.126909]  kernel_init+0x2c/0x150
> > > > [    1.130411]  ret_from_fork+0x10/0x20
> > > > [    1.134003] Code: a9bb7bfd 910003fd a90153f3 aa0003f3 (f9400000)
> > > > [    1.140127] ---[ end trace 0000000000000000 ]---
> > > > 
> > > > Adding some debug out shows:
> > 
> > > > [    0.866795] imx8mp-blk-ctrl 32fc0000.blk-ctrl: domain->power_dev:
> > 0x0
> > 
> > > > [    0.873257] imx8mp-blk-ctrl 32fc0000.blk-ctrl: data->name: hdmiblk-
> > 
> > hdcp
> > 
> > > > [    0.879905] imx8mp-blk-ctrl 32fc0000.blk-ctrl: data->gpc_name: hdcp
> > > > 
> > > > AFAICS the power domains 'hrv' and 'hdcp' are missing in the
> > > > 'hdmi_blk_ctrl: blk-ctrl@32fc0000' node thus resulting in a NULL
> > > > pointer from calling dev_pm_domain_attach_by_name().
> > > 
> > > The HDMI blk ctrl dts not landed in Shawn's branch, could you share me
> > > your dts change?
> > 
> > I don't have any dts changes for this matter. To get a bootable device,
> > for
> > now, I just removed the IMX8MP_HDMIBLK_PD_HRV and
> > IMX8MP_HDMIBLK_PD_HDCP power domains from
> > imx8mp_hdmi_domain_data.
> 
> Ah. There is no hdmi-blk-ctrl node in linux/next tree. Anyway, let me
> have a check.

This is rather important. Without DT nodes, suspend panics with a NULL pointer 
dereference.

[   57.345915] Unable to handle kernel NULL pointer dereference at virtual 
address 0000000000000300
[   57.354823] Mem abort info:
[   57.357633]   ESR = 0x0000000096000004
[   57.361441]   EC = 0x25: DABT (current EL), IL = 32 bits
[   57.366808]   SET = 0, FnV = 0
[   57.369877]   EA = 0, S1PTW = 0
[   57.373066]   FSC = 0x04: level 0 translation fault
[   57.377997] Data abort info:
[   57.380922]   ISV = 0, ISS = 0x00000004
[   57.384811]   CM = 0, WnR = 0
[   57.387827] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000046d55000
[   57.394347] [0000000000000300] pgd=0000000000000000, p4d=0000000000000000
[   57.401394] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   57.406972] Modules linked in: cfg80211 8021q garp stp mrp llc mcp320x 
crct10dif_ce governor_userspace imx_bus snd_soc_tlv320aic32
x4_spi imx_sdma snd_soc_tlv320aic32x4_i2c snd_soc_tlv320aic32x4 flexcan 
can_dev clk_renesas_pcie imx8mm_thermal fuse ipv6
[   57.429303] CPU: 2 PID: 422 Comm: sh Not tainted 6.0.0-rc4-next-20220907+ 
#696 f995e5a57a48e9e1bd6cb136b557c332a85db611
[   57.440089] Hardware name: TQ-Systems i.MX8MPlus TQMa8MPxL on MBa8MPxL (DT)
[   57.447051] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   57.454017] pc : __pm_runtime_resume+0x1c/0xa0
[   57.458470] lr : imx8mp_blk_ctrl_suspend+0x60/0x190
[   57.463354] sp : ffff80000bf13810
[   57.466669] x29: ffff80000bf13810 x28: ffff00000036e010 x27: 
ffff800008972d54
[   57.473814] x26: ffff80000a1196f8 x25: 0000000000000000 x24: 
ffff80000ab9e000
[   57.480958] x23: ffff000003fcc080 x22: 00000000000007e8 x21: 
ffff000003fa37d8
[   57.488104] x20: 0000000000000004 x19: 0000000000000000 x18: 
0000000000000000
[   57.495249] x17: 000000008d822290 x16: 00000000fca00fb3 x15: 
000000007a08336e
[   57.502395] x14: 0000000000000000 x13: 6e776f4420736920 x12: 
6b6e694c203a3068
[   57.509540] x11: 0000000000000002 x10: 0000000000000028 x9 : 
0000000000000001
[   57.516683] x8 : ffff000004486ae0 x7 : ffff80000bf137f0 x6 : 
ffff80000bf13800
[   57.523829] x5 : ffff80000bf14000 x4 : 0000000000000005 x3 : 
00000000000000d6
[   57.530974] x2 : 0000000000000001 x1 : 0000000000000004 x0 : 
0000000000000000
[   57.538119] Call trace:
[   57.540566]  __pm_runtime_resume+0x1c/0xa0
[   57.544665]  imx8mp_blk_ctrl_suspend+0x60/0x190
[   57.549200]  platform_pm_suspend+0x28/0x64
[   57.553306]  dpm_run_callback+0x70/0x140
[   57.557231]  __device_suspend+0x11c/0x3e4
[   57.561244]  dpm_suspend+0x15c/0x270
[   57.564826]  dpm_suspend_start+0xa8/0xcc
[   57.568753]  suspend_devices_and_enter+0x138/0x250
[   57.573547]  enter_state+0xf0/0x3b0
[   57.577038]  pm_suspend+0x5c/0x130
[   57.580442]  state_store+0x2c/0x70
[   57.583852]  kobj_attr_store+0x14/0x2c
[   57.587605]  sysfs_kf_write+0x48/0x70
[   57.591271]  kernfs_fop_write_iter+0x118/0x1ac
[   57.595717]  new_sync_write+0x8c/0xf0
[   57.599384]  vfs_write+0x19c/0x1e4
[   57.602793]  ksys_write+0x68/0xf4
[   57.606112]  __arm64_sys_write+0x18/0x20
[   57.610040]  invoke_syscall+0x6c/0xf0
[   57.613710]  el0_svc_common.constprop.0+0xf0/0x110
[   57.618505]  do_el0_svc+0x24/0x30
[   57.621825]  el0_svc+0x38/0x90
[   57.624883]  el0t_64_sync_handler+0xb0/0xb4
[   57.629070]  el0t_64_sync+0x148/0x14c
[   57.632740] Code: aa0003f3 2a0103f4 f90013f5 37000074 (79460000) 
[   57.638835] ---[ end trace 0000000000000000 ]---

So I currently have to disable these two power domains.

> > > And dev_set_name, as I recall, Lucas has a patch to remove that.
> > 
> > Is this removal a fix or just a workaround?
> 
> Fix:
> https://lore.kernel.org/all/20220826191305.3215706-1-l.stach@pengutronix.de/

Ah, I saw this patch, but I was unsure whether I am affected by this. Thanks 
for the link.

Best regards,
Alexander



