Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8F54545E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345130AbiFISrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiFISr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:47:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D93127A923;
        Thu,  9 Jun 2022 11:47:24 -0700 (PDT)
Received: from notapiano (unknown [169.150.201.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7ADF466016B4;
        Thu,  9 Jun 2022 19:47:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654800442;
        bh=aknJKR7Ftvy4v3R2aNCT4mve3DvBgpYe0YV5fLQ083Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxTwEAaM2HKXvIGZtkUQzXq2mn7sCYaUeOXoqReyDJ3VELeR0JCywScxXWYmLLm3y
         4aA+Md+Tq90MAlOLY8lFoxt7IQrzebnfEqjZtMi+Cu72C6Zlkpd9qOfMAgHDVaP57A
         wgS27pWNtXzOX29SBGrw8z9uGd1zJbLpfFUdbr3RdAyGuO6z+Yg6miXoA13LYH5jVp
         RS/BC18zv4IRhRhQYDqtXA2fcftgX/9OVbFKzU8aqJ3MDS/9GbB3XzqhYTeidiyo87
         Tbz025jHz6fU/MBL7fD9B0PyeMjx1PLosIxgu0WIKlHpf0sDQjbS/+RHb74uSbwMXi
         cpMHyAki8ZVIQ==
Date:   Thu, 9 Jun 2022 14:47:16 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 3/4] pinctrl: mediatek: add rsel setting on mt8192
Message-ID: <20220609184716.mlu5j3m5i6jdraw4@notapiano>
References: <20220608053909.1252-1-guodong.liu@mediatek.com>
 <20220608053909.1252-4-guodong.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220608053909.1252-4-guodong.liu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guodong,

thank you for the patch. Please see some suggestions below.

On Wed, Jun 08, 2022 at 01:39:08PM +0800, Guodong Liu wrote:
> I2C pins's resistance value can be controlled by rsel register.
> This patch provides rsel (resistance selection) setting on mt8192

Please mention that you're also adding the pull_type array in this commit,
something like: "Also add the missing pull type array for mt8192 to document the
pull type of each pin and prevent invalid pull type settings".

> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mt8192.c | 204 ++++++++++++++--------
>  1 file changed, 134 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> index d11ff5519e1e..1486c141ee8c 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> @@ -1285,73 +1285,140 @@ static const struct mtk_pin_field_calc mt8192_pin_drv_adv_range[] = {
>  	PIN_FIELD_BASE(205, 205, 8, 0x0010, 0x10, 6, 3),
>  };
>  
> -static const struct mtk_pin_field_calc mt8192_pin_e1e0en_range[] = {
> -	PIN_FIELD_BASE(118, 118, 4, 0x0040, 0x10, 0, 1),
> -	PIN_FIELD_BASE(119, 119, 4, 0x0040, 0x10, 18, 1),
> -	PIN_FIELD_BASE(120, 120, 4, 0x0040, 0x10, 15, 1),
> -	PIN_FIELD_BASE(121, 121, 4, 0x0050, 0x10, 3, 1),
> -	PIN_FIELD_BASE(122, 122, 4, 0x0040, 0x10, 12, 1),
> -	PIN_FIELD_BASE(123, 123, 4, 0x0050, 0x10, 0, 1),
> -	PIN_FIELD_BASE(124, 124, 4, 0x0040, 0x10, 9, 1),
> -	PIN_FIELD_BASE(125, 125, 4, 0x0040, 0x10, 27, 1),
> -	PIN_FIELD_BASE(139, 139, 4, 0x0040, 0x10, 6, 1),
> -	PIN_FIELD_BASE(140, 140, 4, 0x0040, 0x10, 24, 1),
> -	PIN_FIELD_BASE(141, 141, 4, 0x0040, 0x10, 3, 1),
> -	PIN_FIELD_BASE(142, 142, 4, 0x0040, 0x10, 21, 1),
> -	PIN_FIELD_BASE(160, 160, 7, 0x0030, 0x10, 0, 1),
> -	PIN_FIELD_BASE(161, 161, 7, 0x0030, 0x10, 3, 1),
> -	PIN_FIELD_BASE(200, 200, 8, 0x0010, 0x10, 3, 1),
> -	PIN_FIELD_BASE(201, 201, 8, 0x0010, 0x10, 9, 1),
> -	PIN_FIELD_BASE(202, 202, 5, 0x0020, 0x10, 0, 1),
> -	PIN_FIELD_BASE(203, 203, 5, 0x0020, 0x10, 3, 1),
> -	PIN_FIELD_BASE(204, 204, 8, 0x0010, 0x10, 0, 1),
> -	PIN_FIELD_BASE(205, 205, 8, 0x0010, 0x10, 6, 1),

You're dropping E1, E0, and EN arrays here, but these were used by the original
advanced drive configuration, so they should've been dropped in the previous
patch, not in this one.

> +static const struct mtk_pin_field_calc mt8192_pin_rsel_range[] = {
> +	PIN_FIELD_BASE(118, 118, 4, 0x00e0, 0x10, 0, 2),
> +	PIN_FIELD_BASE(119, 119, 4, 0x00e0, 0x10, 12, 2),
> +	PIN_FIELD_BASE(120, 120, 4, 0x00e0, 0x10, 10, 2),
> +	PIN_FIELD_BASE(121, 121, 4, 0x00e0, 0x10, 22, 2),
> +	PIN_FIELD_BASE(122, 122, 4, 0x00e0, 0x10, 8, 2),
> +	PIN_FIELD_BASE(123, 123, 4, 0x00e0, 0x10, 20, 2),
> +	PIN_FIELD_BASE(124, 124, 4, 0x00e0, 0x10, 6, 2),
> +	PIN_FIELD_BASE(125, 125, 4, 0x00e0, 0x10, 18, 2),
> +	PIN_FIELD_BASE(139, 139, 4, 0x00e0, 0x10, 4, 2),
> +	PIN_FIELD_BASE(140, 140, 4, 0x00e0, 0x10, 16, 2),
> +	PIN_FIELD_BASE(141, 141, 4, 0x00e0, 0x10, 2, 2),
> +	PIN_FIELD_BASE(142, 142, 4, 0x00e0, 0x10, 14, 2),
> +	PIN_FIELD_BASE(160, 160, 7, 0x00f0, 0x10, 0, 2),
> +	PIN_FIELD_BASE(161, 161, 7, 0x00f0, 0x10, 2, 2),
> +	PIN_FIELD_BASE(200, 200, 8, 0x0070, 0x10, 2, 2),
> +	PIN_FIELD_BASE(201, 201, 8, 0x0070, 0x10, 6, 2),
> +	PIN_FIELD_BASE(202, 202, 5, 0x0070, 0x10, 0, 2),
> +	PIN_FIELD_BASE(203, 203, 5, 0x0070, 0x10, 2, 2),
> +	PIN_FIELD_BASE(204, 204, 8, 0x0070, 0x10, 0, 2),
> +	PIN_FIELD_BASE(205, 205, 8, 0x0070, 0x10, 4, 2),
>  };
>  
> -static const struct mtk_pin_field_calc mt8192_pin_e0_range[] = {
> -	PIN_FIELD_BASE(118, 118, 4, 0x0040, 0x10, 1, 1),
> -	PIN_FIELD_BASE(119, 119, 4, 0x0040, 0x10, 19, 1),
> -	PIN_FIELD_BASE(120, 120, 4, 0x0040, 0x10, 16, 1),
> -	PIN_FIELD_BASE(121, 121, 4, 0x0050, 0x10, 4, 1),
> -	PIN_FIELD_BASE(122, 122, 4, 0x0040, 0x10, 13, 1),
> -	PIN_FIELD_BASE(123, 123, 4, 0x0050, 0x10, 1, 1),
> -	PIN_FIELD_BASE(124, 124, 4, 0x0040, 0x10, 10, 1),
> -	PIN_FIELD_BASE(125, 125, 4, 0x0040, 0x10, 28, 1),
> -	PIN_FIELD_BASE(139, 139, 4, 0x0040, 0x10, 7, 1),
> -	PIN_FIELD_BASE(140, 140, 4, 0x0040, 0x10, 25, 1),
> -	PIN_FIELD_BASE(141, 141, 4, 0x0040, 0x10, 4, 1),
> -	PIN_FIELD_BASE(142, 142, 4, 0x0040, 0x10, 22, 1),
> -	PIN_FIELD_BASE(160, 160, 7, 0x0030, 0x10, 1, 1),
> -	PIN_FIELD_BASE(161, 161, 7, 0x0030, 0x10, 4, 1),
> -	PIN_FIELD_BASE(200, 200, 8, 0x0010, 0x10, 4, 1),
> -	PIN_FIELD_BASE(201, 201, 8, 0x0010, 0x10, 10, 1),
> -	PIN_FIELD_BASE(202, 202, 5, 0x0020, 0x10, 1, 1),
> -	PIN_FIELD_BASE(203, 203, 5, 0x0020, 0x10, 4, 1),
> -	PIN_FIELD_BASE(204, 204, 8, 0x0010, 0x10, 1, 1),
> -	PIN_FIELD_BASE(205, 205, 8, 0x0010, 0x10, 7, 1),
> -};
> -
> -static const struct mtk_pin_field_calc mt8192_pin_e1_range[] = {
> -	PIN_FIELD_BASE(118, 118, 4, 0x0040, 0x10, 2, 1),
> -	PIN_FIELD_BASE(119, 119, 4, 0x0040, 0x10, 20, 1),
> -	PIN_FIELD_BASE(120, 120, 4, 0x0040, 0x10, 17, 1),
> -	PIN_FIELD_BASE(121, 121, 4, 0x0050, 0x10, 5, 1),
> -	PIN_FIELD_BASE(122, 122, 4, 0x0040, 0x10, 14, 1),
> -	PIN_FIELD_BASE(123, 123, 4, 0x0050, 0x10, 2, 1),
> -	PIN_FIELD_BASE(124, 124, 4, 0x0040, 0x10, 11, 1),
> -	PIN_FIELD_BASE(125, 125, 4, 0x0040, 0x10, 29, 1),
> -	PIN_FIELD_BASE(139, 139, 4, 0x0040, 0x10, 8, 1),
> -	PIN_FIELD_BASE(140, 140, 4, 0x0040, 0x10, 26, 1),
> -	PIN_FIELD_BASE(141, 141, 4, 0x0040, 0x10, 5, 1),
> -	PIN_FIELD_BASE(142, 142, 4, 0x0040, 0x10, 23, 1),
> -	PIN_FIELD_BASE(160, 160, 7, 0x0030, 0x10, 2, 1),
> -	PIN_FIELD_BASE(161, 161, 7, 0x0030, 0x10, 5, 1),
> -	PIN_FIELD_BASE(200, 200, 8, 0x0010, 0x10, 5, 1),
> -	PIN_FIELD_BASE(201, 201, 8, 0x0010, 0x10, 11, 1),
> -	PIN_FIELD_BASE(202, 202, 5, 0x0020, 0x10, 2, 1),
> -	PIN_FIELD_BASE(203, 203, 5, 0x0020, 0x10, 5, 1),
> -	PIN_FIELD_BASE(204, 204, 8, 0x0010, 0x10, 2, 1),
> -	PIN_FIELD_BASE(205, 205, 8, 0x0010, 0x10, 8, 1),
> +static const unsigned int mt8192_pull_type[] = {
> +	MTK_PULL_PU_PD_TYPE,/*0*/		MTK_PULL_PU_PD_TYPE,/*1*/
> +	MTK_PULL_PU_PD_TYPE,/*2*/		MTK_PULL_PU_PD_TYPE,/*3*/
> +	MTK_PULL_PU_PD_TYPE,/*4*/		MTK_PULL_PU_PD_TYPE,/*5*/
> +	MTK_PULL_PU_PD_TYPE,/*6*/		MTK_PULL_PU_PD_TYPE,/*7*/
> +	MTK_PULL_PU_PD_TYPE,/*8*/		MTK_PULL_PU_PD_TYPE,/*9*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*10*/	MTK_PULL_PUPD_R1R0_TYPE,/*11*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*12*/	MTK_PULL_PUPD_R1R0_TYPE,/*13*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*14*/	MTK_PULL_PUPD_R1R0_TYPE,/*15*/
> +	MTK_PULL_PU_PD_TYPE,/*16*/		MTK_PULL_PU_PD_TYPE,/*17*/
> +	MTK_PULL_PU_PD_TYPE,/*18*/		MTK_PULL_PU_PD_TYPE,/*19*/
> +	MTK_PULL_PU_PD_TYPE,/*20*/		MTK_PULL_PU_PD_TYPE,/*21*/
> +	MTK_PULL_PU_PD_TYPE,/*22*/		MTK_PULL_PU_PD_TYPE,/*23*/
> +	MTK_PULL_PU_PD_TYPE,/*24*/		MTK_PULL_PU_PD_TYPE,/*25*/
> +	MTK_PULL_PU_PD_TYPE,/*26*/		MTK_PULL_PU_PD_TYPE,/*27*/
> +	MTK_PULL_PU_PD_TYPE,/*28*/		MTK_PULL_PU_PD_TYPE,/*29*/
> +	MTK_PULL_PU_PD_TYPE,/*30*/		MTK_PULL_PU_PD_TYPE,/*31*/
> +	MTK_PULL_PU_PD_TYPE,/*32*/		MTK_PULL_PU_PD_TYPE,/*33*/
> +	MTK_PULL_PU_PD_TYPE,/*34*/		MTK_PULL_PU_PD_TYPE,/*35*/
> +	MTK_PULL_PU_PD_TYPE,/*36*/		MTK_PULL_PU_PD_TYPE,/*37*/
> +	MTK_PULL_PU_PD_TYPE,/*38*/		MTK_PULL_PU_PD_TYPE,/*39*/
> +	MTK_PULL_PU_PD_TYPE,/*40*/		MTK_PULL_PU_PD_TYPE,/*41*/
> +	MTK_PULL_PU_PD_TYPE,/*42*/		MTK_PULL_PU_PD_TYPE,/*43*/
> +	MTK_PULL_PU_PD_TYPE,/*44*/		MTK_PULL_PUPD_R1R0_TYPE,/*45*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*46*/	MTK_PULL_PUPD_R1R0_TYPE,/*47*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*48*/	MTK_PULL_PUPD_R1R0_TYPE,/*49*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*50*/	MTK_PULL_PUPD_R1R0_TYPE,/*51*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*52*/	MTK_PULL_PUPD_R1R0_TYPE,/*53*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*54*/	MTK_PULL_PUPD_R1R0_TYPE,/*55*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*56*/	MTK_PULL_PU_PD_TYPE,/*57*/
> +	MTK_PULL_PU_PD_TYPE,/*58*/		MTK_PULL_PU_PD_TYPE,/*59*/
> +	MTK_PULL_PU_PD_TYPE,/*60*/		MTK_PULL_PU_PD_TYPE,/*61*/
> +	MTK_PULL_PU_PD_TYPE,/*62*/		MTK_PULL_PU_PD_TYPE,/*63*/
> +	MTK_PULL_PU_PD_TYPE,/*64*/		MTK_PULL_PU_PD_TYPE,/*65*/
> +	MTK_PULL_PU_PD_TYPE,/*66*/		MTK_PULL_PU_PD_TYPE,/*67*/
> +	MTK_PULL_PU_PD_TYPE,/*68*/		MTK_PULL_PU_PD_TYPE,/*69*/
> +	MTK_PULL_PU_PD_TYPE,/*70*/		MTK_PULL_PU_PD_TYPE,/*71*/
> +	MTK_PULL_PU_PD_TYPE,/*72*/		MTK_PULL_PU_PD_TYPE,/*73*/
> +	MTK_PULL_PU_PD_TYPE,/*74*/		MTK_PULL_PU_PD_TYPE,/*75*/
> +	MTK_PULL_PU_PD_TYPE,/*76*/		MTK_PULL_PU_PD_TYPE,/*77*/
> +	MTK_PULL_PU_PD_TYPE,/*78*/		MTK_PULL_PU_PD_TYPE,/*79*/
> +	MTK_PULL_PU_PD_TYPE,/*80*/		MTK_PULL_PU_PD_TYPE,/*81*/
> +	MTK_PULL_PU_PD_TYPE,/*82*/		MTK_PULL_PU_PD_TYPE,/*83*/
> +	MTK_PULL_PU_PD_TYPE,/*84*/		MTK_PULL_PU_PD_TYPE,/*85*/
> +	MTK_PULL_PU_PD_TYPE,/*86*/		MTK_PULL_PU_PD_TYPE,/*87*/
> +	MTK_PULL_PU_PD_TYPE,/*88*/		MTK_PULL_PU_PD_TYPE,/*89*/
> +	MTK_PULL_PU_PD_TYPE,/*90*/		MTK_PULL_PU_PD_TYPE,/*91*/
> +	MTK_PULL_PU_PD_TYPE,/*92*/		MTK_PULL_PU_PD_TYPE,/*93*/
> +	MTK_PULL_PU_PD_TYPE,/*94*/		MTK_PULL_PU_PD_TYPE,/*95*/
> +	MTK_PULL_PU_PD_TYPE,/*96*/		MTK_PULL_PU_PD_TYPE,/*97*/
> +	MTK_PULL_PU_PD_TYPE,/*98*/		MTK_PULL_PU_PD_TYPE,/*99*/
> +	MTK_PULL_PU_PD_TYPE,/*100*/		MTK_PULL_PU_PD_TYPE,/*101*/
> +	MTK_PULL_PU_PD_TYPE,/*102*/		MTK_PULL_PU_PD_TYPE,/*103*/
> +	MTK_PULL_PU_PD_TYPE,/*104*/		MTK_PULL_PU_PD_TYPE,/*105*/
> +	MTK_PULL_PU_PD_TYPE,/*106*/		MTK_PULL_PU_PD_TYPE,/*107*/
> +	MTK_PULL_PU_PD_TYPE,/*108*/		MTK_PULL_PU_PD_TYPE,/*109*/
> +	MTK_PULL_PU_PD_TYPE,/*110*/		MTK_PULL_PU_PD_TYPE,/*111*/
> +	MTK_PULL_PU_PD_TYPE,/*112*/		MTK_PULL_PU_PD_TYPE,/*113*/
> +	MTK_PULL_PU_PD_TYPE,/*114*/		MTK_PULL_PU_PD_TYPE,/*115*/
> +	MTK_PULL_PU_PD_TYPE,/*116*/		MTK_PULL_PU_PD_TYPE,/*117*/
> +	MTK_PULL_PU_PD_RSEL_TYPE,/*118*/	MTK_PULL_PU_PD_RSEL_TYPE,/*119*/
> +	MTK_PULL_PU_PD_RSEL_TYPE,/*120*/	MTK_PULL_PU_PD_RSEL_TYPE,/*121*/
> +	MTK_PULL_PU_PD_RSEL_TYPE,/*122*/	MTK_PULL_PU_PD_RSEL_TYPE,/*123*/
> +	MTK_PULL_PU_PD_RSEL_TYPE,/*124*/	MTK_PULL_PU_PD_RSEL_TYPE,/*125*/
> +	MTK_PULL_PU_PD_TYPE,/*126*/		MTK_PULL_PU_PD_TYPE,/*127*/
> +	MTK_PULL_PU_PD_TYPE,/*128*/		MTK_PULL_PU_PD_TYPE,/*129*/
> +	MTK_PULL_PU_PD_TYPE,/*130*/		MTK_PULL_PU_PD_TYPE,/*131*/
> +	MTK_PULL_PU_PD_TYPE,/*132*/		MTK_PULL_PU_PD_TYPE,/*133*/
> +	MTK_PULL_PU_PD_TYPE,/*134*/		MTK_PULL_PU_PD_TYPE,/*135*/
> +	MTK_PULL_PU_PD_TYPE,/*136*/		MTK_PULL_PU_PD_TYPE,/*137*/
> +	MTK_PULL_PU_PD_TYPE,/*138*/		MTK_PULL_PU_PD_RSEL_TYPE,/*139*/
> +	MTK_PULL_PU_PD_RSEL_TYPE,/*140*/	MTK_PULL_PU_PD_RSEL_TYPE,/*141*/
> +	MTK_PULL_PU_PD_RSEL_TYPE,/*142*/	MTK_PULL_PU_PD_TYPE,/*143*/
> +	MTK_PULL_PU_PD_TYPE,/*144*/		MTK_PULL_PU_PD_TYPE,/*145*/
> +	MTK_PULL_PU_PD_TYPE,/*146*/		MTK_PULL_PU_PD_TYPE,/*147*/
> +	MTK_PULL_PU_PD_TYPE,/*148*/		MTK_PULL_PU_PD_TYPE,/*149*/
> +	MTK_PULL_PU_PD_TYPE,/*150*/		MTK_PULL_PU_PD_TYPE,/*151*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*152*/	MTK_PULL_PUPD_R1R0_TYPE,/*153*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*154*/	MTK_PULL_PUPD_R1R0_TYPE,/*155*/
> +	MTK_PULL_PU_PD_TYPE,/*156*/		MTK_PULL_PU_PD_TYPE,/*157*/
> +	MTK_PULL_PU_PD_TYPE,/*158*/		MTK_PULL_PU_PD_TYPE,/*159*/
> +	MTK_PULL_PU_PD_RSEL_TYPE,/*160*/	MTK_PULL_PU_PD_RSEL_TYPE,/*161*/
> +	MTK_PULL_PU_PD_TYPE,/*162*/		MTK_PULL_PU_PD_TYPE,/*163*/
> +	MTK_PULL_PU_PD_TYPE,/*164*/		MTK_PULL_PU_PD_TYPE,/*165*/
> +	MTK_PULL_PU_PD_TYPE,/*166*/		MTK_PULL_PU_PD_TYPE,/*167*/
> +	MTK_PULL_PU_PD_TYPE,/*168*/		MTK_PULL_PU_PD_TYPE,/*169*/
> +	MTK_PULL_PU_PD_TYPE,/*170*/		MTK_PULL_PU_PD_TYPE,/*171*/
> +	MTK_PULL_PU_PD_TYPE,/*172*/		MTK_PULL_PU_PD_TYPE,/*173*/
> +	MTK_PULL_PU_PD_TYPE,/*174*/		MTK_PULL_PU_PD_TYPE,/*175*/
> +	MTK_PULL_PU_PD_TYPE,/*176*/		MTK_PULL_PU_PD_TYPE,/*177*/
> +	MTK_PULL_PU_PD_TYPE,/*178*/		MTK_PULL_PU_PD_TYPE,/*179*/
> +	MTK_PULL_PU_PD_TYPE,/*180*/		MTK_PULL_PU_PD_TYPE,/*181*/
> +	MTK_PULL_PU_PD_TYPE,/*182*/		MTK_PULL_PUPD_R1R0_TYPE,/*183*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*184*/	MTK_PULL_PUPD_R1R0_TYPE,/*185*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*186*/	MTK_PULL_PUPD_R1R0_TYPE,/*187*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*188*/	MTK_PULL_PUPD_R1R0_TYPE,/*189*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*190*/	MTK_PULL_PUPD_R1R0_TYPE,/*191*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*192*/	MTK_PULL_PUPD_R1R0_TYPE,/*193*/
> +	MTK_PULL_PUPD_R1R0_TYPE,/*194*/	MTK_PULL_PU_PD_TYPE,/*195*/
> +	MTK_PULL_PU_PD_TYPE,/*196*/		MTK_PULL_PU_PD_TYPE,/*197*/
> +	MTK_PULL_PU_PD_TYPE,/*198*/		MTK_PULL_PU_PD_TYPE,/*199*/
> +	MTK_PULL_PU_PD_RSEL_TYPE,/*200*/	MTK_PULL_PU_PD_RSEL_TYPE,/*201*/
> +	MTK_PULL_PU_PD_RSEL_TYPE,/*202*/	MTK_PULL_PU_PD_RSEL_TYPE,/*203*/
> +	MTK_PULL_PU_PD_RSEL_TYPE,/*204*/	MTK_PULL_PU_PD_RSEL_TYPE,/*205*/
> +	MTK_PULL_PU_PD_TYPE,/*206*/		MTK_PULL_PU_PD_TYPE,/*207*/
> +	MTK_PULL_PU_PD_TYPE,/*208*/		MTK_PULL_PU_PD_TYPE,/*209*/
> +	MTK_PULL_PU_PD_TYPE,/*210*/		MTK_PULL_PU_PD_TYPE,/*211*/
> +	MTK_PULL_PU_PD_TYPE,/*212*/		MTK_PULL_PU_PD_TYPE,/*213*/
> +	MTK_PULL_PU_PD_TYPE,/*214*/		MTK_PULL_PU_PD_TYPE,/*215*/
> +	MTK_PULL_PU_PD_TYPE,/*216*/		MTK_PULL_PU_PD_TYPE,/*217*/
> +	MTK_PULL_PU_PD_TYPE,/*218*/		MTK_PULL_PU_PD_TYPE,/*219*/
>  };
>  
>  
> @@ -1381,10 +1448,8 @@ static const struct mtk_pin_reg_calc mt8192_reg_cals[PINCTRL_PIN_REG_MAX] = {
>  	[PINCTRL_PIN_REG_PUPD] = MTK_RANGE(mt8192_pin_pupd_range),
>  	[PINCTRL_PIN_REG_R0] = MTK_RANGE(mt8192_pin_r0_range),
>  	[PINCTRL_PIN_REG_R1] = MTK_RANGE(mt8192_pin_r1_range),
> -	[PINCTRL_PIN_REG_DRV_EN] = MTK_RANGE(mt8192_pin_e1e0en_range),
> -	[PINCTRL_PIN_REG_DRV_E0] = MTK_RANGE(mt8192_pin_e0_range),
>  	[PINCTRL_PIN_REG_DRV_ADV]	= MTK_RANGE(mt8192_pin_drv_adv_range),
> -	[PINCTRL_PIN_REG_DRV_E1] = MTK_RANGE(mt8192_pin_e1_range),
> +	[PINCTRL_PIN_REG_RSEL]	= MTK_RANGE(mt8192_pin_rsel_range),
>  };
>  
>  static const struct mtk_pin_soc mt8192_data = {
> @@ -1394,6 +1459,7 @@ static const struct mtk_pin_soc mt8192_data = {
>  	.ngrps = ARRAY_SIZE(mtk_pins_mt8192),
>  	.base_names = mt8192_pinctrl_register_base_names,
>  	.nbase_names = ARRAY_SIZE(mt8192_pinctrl_register_base_names),
> +	.pull_type = mt8192_pull_type,
>  	.eint_hw = &mt8192_eint_hw,
>  	.nfuncs = 8,
>  	.gpio_m = 0,
> @@ -1401,8 +1467,6 @@ static const struct mtk_pin_soc mt8192_data = {
>  	.bias_get_combo = mtk_pinconf_bias_get_combo,
>  	.drive_set	= mtk_pinconf_drive_set_rev1,
>  	.drive_get	= mtk_pinconf_drive_get_rev1,
> -	.adv_pull_get = mtk_pinconf_adv_pull_get,
> -	.adv_pull_set = mtk_pinconf_adv_pull_set,

I understand you're dropping this because the bias_combo getter/setters already
handle all cases, but still this isn't really related to adding rsel, so I think
it'd make more sense in a separate commit. At the very least it should be
mentioned in the commit message.

Thanks,
Nícolas

>  	.adv_drive_get	= mtk_pinconf_adv_drive_get_raw,
>  	.adv_drive_set	= mtk_pinconf_adv_drive_set_raw,
>  };
> -- 
> 2.25.5
> 
