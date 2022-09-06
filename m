Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1735AEEB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbiIFP1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbiIFP11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:27:27 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D12A205F9;
        Tue,  6 Sep 2022 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662475117; x=1694011117;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eGlwV1W60OyjywuT+JtyuC8RgGJf3Lk2jwy3im1Vvvw=;
  b=mdTAgDnZpLbB0AlDu9FCas+DViUFFtOrHndgMU8hkZYPKTLpW2pgmZs3
   11ERY8bJPSz/z5GttSqbr6iSY9aWpvgmaoXiMkefsLWl5tJgKqOAwPLDI
   khAQyJsbqELPbTkPs+o720IvdXX6bG+tenxT/QGe0zGAHs1hjArzwjBAX
   Ikg9MhzBOmfWWgKaN8ZqJaUIiAeKHp50LSg+twr4iijw6K/oRgoibHGEC
   tyK4rszX6ZVIrU2GyAP+xZyL2F7JmwxXXDCdMvudagohjfD6uoRjrXahF
   ObRWjURz2fpXnprBKPLSYeYzjtF0hgdlM7KKP+RKB5S23Ok3tIh3f0+n/
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654552800"; 
   d="scan'208";a="26020282"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 Sep 2022 16:37:05 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 06 Sep 2022 16:37:05 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 06 Sep 2022 16:37:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662475025; x=1694011025;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=eGlwV1W60OyjywuT+JtyuC8RgGJf3Lk2jwy3im1Vvvw=;
  b=jDZE/UmLv7ybxoJl9RQd8fPP81ei63EbZ3rrzHjpBL51L3HyviVK1n5C
   rkLYNsw8dt9b9hCVmbS2r0cWZiuWTncpKCIIyWjaQScdmE7gpS/TkQIpd
   nPSIfH23LG15ZaBUkIUky9EKqkw5V87f8sIRmHOuPCRQ6LIyzjRFqPw5U
   T0jv372bqZhENctFcsUSPimZVMtrt0kjLOCz03kAfqqBrL7LhwbUuCJMV
   2N3m5IZ8iqiumMp9HspBnZxViK2TMc4Ow8G/RRDPNv6VcIKDc9VqZ5Lvd
   gtipL6F+JsBllGZj/vRZ/N7VyuLQOHHcOm2emzWDcUUVtD+xJuq9TFbVw
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654552800"; 
   d="scan'208";a="26020281"
Subject: Re: [PATCH V5 5/8] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV_MWR
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Sep 2022 16:37:05 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 27CDA280056;
        Tue,  6 Sep 2022 16:37:04 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Date:   Tue, 06 Sep 2022 16:37:04 +0200
Message-ID: <2849448.e9J7NaK4W3@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220822064536.3947512-6-peng.fan@oss.nxp.com>
References: <20220822064536.3947512-1-peng.fan@oss.nxp.com> <20220822064536.3947512-6-peng.fan@oss.nxp.com>
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

Am Montag, 22. August 2022, 08:45:33 CEST schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP HDMI supports HDCP and HRV_MWR(HDMI RX Video Memory Write Master
> for RXRX validation), so add them.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/imx8mp-blk-ctrl.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c
> b/drivers/soc/imx/imx8mp-blk-ctrl.c index 6f983adcb47c..527d45d12a54 100644
> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> @@ -235,6 +235,13 @@ static void imx8mp_hdmi_blk_ctrl_power_on(struct
> imx8mp_blk_ctrl *bc, regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
> BIT(12));
>  		regmap_clear_bits(bc->regmap, HDMI_TX_CONTROL0, BIT(3));
>  		break;
> +	case IMX8MP_HDMIBLK_PD_HDCP:
> +		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
> +		break;
> +	case IMX8MP_HDMIBLK_PD_HRV:
> +		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) | 
BIT(4) | BIT(5));
> +		regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0, 
BIT(15));
> +		break;
>  	default:
>  		break;
>  	}
> @@ -283,6 +290,13 @@ static void imx8mp_hdmi_blk_ctrl_power_off(struct
> imx8mp_blk_ctrl *bc, regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
> BIT(12));
>  		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(22) 
| BIT(24));
>  		break;
> +	case IMX8MP_HDMIBLK_PD_HDCP:
> +		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL0, 
BIT(11));
> +		break;
> +	case IMX8MP_HDMIBLK_PD_HRV:
> +		regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0, 
BIT(15));
> +		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) 
| BIT(4) |
> BIT(5)); +		break;
>  	default:
>  		break;
>  	}
> @@ -365,6 +379,22 @@ static const struct imx8mp_blk_ctrl_domain_data
> imx8mp_hdmi_domain_data[] = { .num_clks = 2,
>  		.gpc_name = "hdmi-tx-phy",
>  	},
> +	[IMX8MP_HDMIBLK_PD_HRV] = {
> +		.name = "hdmiblk-hrv",
> +		.clk_names = (const char *[]){ "axi", "apb" },
> +		.num_clks = 2,
> +		.gpc_name = "hrv",
> +		.path_names = (const char *[]){"hrv"},
> +		.num_paths = 1,
> +	},
> +	[IMX8MP_HDMIBLK_PD_HDCP] = {
> +		.name = "hdmiblk-hdcp",
> +		.clk_names = (const char *[]){ "axi", "apb" },
> +		.num_clks = 2,
> +		.gpc_name = "hdcp",
> +		.path_names = (const char *[]){"hdcp"},
> +		.num_paths = 1,
> +	},
>  };
> 
>  static const struct imx8mp_blk_ctrl_data imx8mp_hdmi_blk_ctl_dev_data = {

Something is missing here. Iget the following error during boot:
[    0.886211] Unable to handle kernel NULL pointer dereference at virtual 
address 0000000000000000
[    0.895043] Mem abort info:
[    0.897841]   ESR = 0x0000000096000004
[    0.901606]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.906942]   SET = 0, FnV = 0
[    0.910003]   EA = 0, S1PTW = 0
[    0.913159]   FSC = 0x04: level 0 translation fault
[    0.918054] Data abort info:
[    0.920943]   ISV = 0, ISS = 0x00000004
[    0.924791]   CM = 0, WnR = 0
[    0.927761] [0000000000000000] user address but active_mm is swapper
[    0.934157] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    0.939749] Modules linked in:
[    0.942813] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc4-
next-20220906+ #674 2c55fa642ba20b0dbb66c0e78dacc9ca96d5e733
[    0.954099] Hardware name: TQ-Systems i.MX8MPlus TQMa8MPxL on MBa8MPxL (DT)
[    0.961100] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.968099] pc : kobject_set_name_vargs+0x10/0xd0
[    0.972823] lr : dev_set_name+0x58/0x80
[    0.976674] sp : ffff800009c7b860
[    0.979997] x29: ffff800009c7b860 x28: ffff000002d728f8 x27: 
0000000000000150
[    0.987172] x26: 0000000000000009 x25: 0000000000000007 x24: 
ffff800009ab8958
[    0.994347] x23: ffff0000000a0000 x22: ffff800008eb77d8 x21: 
ffff000000225410
[    1.001524] x20: ffff800008eb7808 x19: 0000000000000000 x18: 
0000000000000000
[    1.008697] x17: 702d78742d696d64 x16: 682d6b6c62696d64 x15: 
68203a656d616e3e
[    1.015872] x14: 0000000000000000 x13: 70636468203a656d x12: 
616e5f6370673e2d
[    1.023047] x11: 61746164203a6c72 x10: 74632d6b6c622e30 x9 : 
7274632d6b6c622e
[    1.030222] x8 : 3030303063663233 x7 : 205d353039393738 x6 : 
ffff800009a240e0
[    1.037397] x5 : 00000000ffffffd0 x4 : ffff800009c7b920 x3 : 
00000000ffffffd0
[    1.044572] x2 : ffff800009c7b8d0 x1 : ffff80000936ca78 x0 : 
0000000000000000
[    1.051749] Call trace:
[    1.054199]  kobject_set_name_vargs+0x10/0xd0
[    1.058574]  dev_set_name+0x58/0x80
[    1.062072]  imx8mp_blk_ctrl_probe+0x5c0/0x660
[    1.066534]  platform_probe+0x64/0x100
[    1.070297]  call_driver_probe+0x28/0x140
[    1.074322]  really_probe+0xc0/0x334
[    1.077909]  __driver_probe_device+0x84/0x144
[    1.082284]  driver_probe_device+0x38/0x130
[    1.086486]  __driver_attach+0xac/0x244
[    1.090334]  bus_for_each_dev+0x6c/0xc0
[    1.094184]  driver_attach+0x20/0x30
[    1.097772]  bus_add_driver+0x174/0x244
[    1.101622]  driver_register+0x74/0x120
[    1.105474]  __platform_driver_register+0x24/0x30
[    1.110197]  imx8mp_blk_ctrl_driver_init+0x18/0x20
[    1.115009]  do_one_initcall+0x58/0x200
[    1.118861]  do_initcalls+0x164/0x19c
[    1.122534]  kernel_init_freeable+0x134/0x17c
[    1.126909]  kernel_init+0x2c/0x150
[    1.130411]  ret_from_fork+0x10/0x20
[    1.134003] Code: a9bb7bfd 910003fd a90153f3 aa0003f3 (f9400000) 
[    1.140127] ---[ end trace 0000000000000000 ]---

Adding some debug out shows:
[    0.866795] imx8mp-blk-ctrl 32fc0000.blk-ctrl: domain->power_dev: 0x0
[    0.873257] imx8mp-blk-ctrl 32fc0000.blk-ctrl: data->name: hdmiblk-hdcp
[    0.879905] imx8mp-blk-ctrl 32fc0000.blk-ctrl: data->gpc_name: hdcp

AFAICS the power domains 'hrv' and 'hdcp' are missing in the 'hdmi_blk_ctrl: 
blk-ctrl@32fc0000' node thus resulting in a NULL pointer from calling 
dev_pm_domain_attach_by_name().

Is there a patch I am missing.

Best regards,
Alexander


