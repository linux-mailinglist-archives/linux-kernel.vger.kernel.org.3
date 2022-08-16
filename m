Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7085B5956A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiHPJgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiHPJgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:36:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D1C79639
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:58:51 -0700 (PDT)
X-UUID: 8be3416577b24019a4e64a0c05ee6e4a-20220816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=0rfrDY0ew2VMjQjsOZ1u2MHFXAegfu4ILXAlANJbEH8=;
        b=bM0ngYYPpoFQ4L/WsNEiHjJrRmhnCyRD00Ih2UugKhNJ8PibvmnDfEH9FrKu+C48n7yi4zdKvyN6p0ltnRH9uPfvuwwOxzNBhR8Uouq3fRs3qpNr6EFZ0MXuuhcOssKJcMQYdA21g0a8zSczQHPgUY45L/q582nbMEYrgSbcrZU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:9c873005-3cb4-4752-80c0-566e40e43566,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:0
X-CID-META: VersionHash:3d8acc9,CLOUDID:538ccc9c-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8be3416577b24019a4e64a0c05ee6e4a-20220816
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 825081248; Tue, 16 Aug 2022 15:58:21 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 16 Aug 2022 15:58:19 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 16 Aug 2022 15:58:19 +0800
Message-ID: <e9943d0fb9aca562afe1ca11372392883d2b6d5a.camel@mediatek.com>
Subject: Re: [RFC PATCH] phy: phy-mtk-tphy: Make USB PHY work on MT6735
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Yassine Oudjana <y.oudjana@protonmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 16 Aug 2022 15:58:19 +0800
In-Reply-To: <20220815215859.253962-1-y.oudjana@protonmail.com>
References: <20220815215859.253962-1-y.oudjana@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-15 at 22:58 +0100, Yassine Oudjana wrote:
> The USB PHY on MT6735 seems to be a TPHY V1, but the FMREG base
> here is 0xf00 rather than 0x100. Since it is definitely not a V2
> or later as it has shared registers, would this mean that it is
> an even earlier revision, or one between V1 and V2? Or is the
> address used currently in this driver wrong?
> 
> Furthermore, there is one additional step needed in the power on
> sequence to make USB work on MT6735, which is to set the 10th bit
> of U3P_U2PHYDTM1. This was found through trial and error by adding
> the power on sequence from the downstream driver then stripping
> parts of it until a critical part is found. This specific part[1]
> was found under a comment saying "force enter device mode", but
> there are other bits that are cleared/set under the same comment,
> some of which are set in the same write as this bit, so it is
> unclear whether this bit is the one (or the only one) responsible
> for "forcing enter device mode". There is no documentation on this
> register (or any port registers for that matter) so this bit's
> name and function are unknown. Does anyone have more information
> on this? And if no information were to be found, would leaving
> this as a magic value, or with the placeholder name currently used
> (P2C_FORCE_ENTER_DEVICE_MODE) be acceptable?

Can't use force mode, there is side-effect with dual-role controller.

> 
> [1] 
> https://urldefense.com/v3/__https://gitlab.com/Tooniis/linux-samsung-grandpplte/-/blob/master/drivers/misc/mediatek/usb20/mt6735/usb20_phy.c*L404__;Iw!!CTRNKA9wMg0ARbw!26SfFWZy9e7D178mgOIWZ6iv4hM4OCTq4cndOspiaTxIQgvATHYlMsPCd4YiWq3S3Fal$
>  
> ---
>  drivers/phy/mediatek/phy-mtk-tphy.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c
> b/drivers/phy/mediatek/phy-mtk-tphy.c
> index 8ee7682b8e93..f54b8a9872bf 100644
> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> @@ -23,7 +23,7 @@
>  /* version V1 sub-banks offset base address */
>  /* banks shared by multiple phys */
>  #define SSUSB_SIFSLV_V1_SPLLC		0x000	/* shared by
> u3 phys */
> -#define SSUSB_SIFSLV_V1_U2FREQ		0x100	/* shared by
> u2 phys */
> +#define SSUSB_SIFSLV_V1_U2FREQ		0xf00	/* shared by
> u2 phys */
>  #define SSUSB_SIFSLV_V1_CHIP		0x300	/* shared by u3 phys
> */
>  /* u2 phy bank */
>  #define SSUSB_SIFSLV_V1_U2PHY_COM	0x000
> @@ -119,6 +119,7 @@
>  
>  #define U3P_U2PHYDTM1		0x06C
>  #define P2C_RG_UART_EN			BIT(16)
> +#define P2C_FORCE_ENTER_DEVICE_MODE	BIT(10)
>  #define P2C_FORCE_IDDIG		BIT(9)
>  #define P2C_RG_VBUSVALID		BIT(5)
>  #define P2C_RG_SESSEND			BIT(4)
> @@ -579,6 +580,8 @@ static void u2_phy_instance_power_on(struct
> mtk_tphy *tphy,
>  		mtk_phy_set_bits(com + U3P_U2PHYDTM0, P2C_RG_SUSPENDM |
> P2C_FORCE_SUSPENDM);
>  	}
>  	dev_dbg(tphy->dev, "%s(%d)\n", __func__, index);
> +
> +	mtk_phy_set_bits(com + U3P_U2PHYDTM1,
> P2C_FORCE_ENTER_DEVICE_MODE);
>  }
>  
>  static void u2_phy_instance_power_off(struct mtk_tphy *tphy,

