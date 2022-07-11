Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8356D4D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiGKGkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiGKGkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:40:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05311167DE;
        Sun, 10 Jul 2022 23:40:49 -0700 (PDT)
X-UUID: 12fc66ca1e504f8bb75f55c037a26369-20220711
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:39bb711e-7a7c-4051-9e8e-abb8e04bc19e,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:c4ffef63-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 12fc66ca1e504f8bb75f55c037a26369-20220711
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2104970069; Mon, 11 Jul 2022 14:40:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 11 Jul 2022 14:40:45 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jul 2022 14:40:45 +0800
Message-ID: <a5d9c16254b155180ef7e45af69de44257593284.camel@mediatek.com>
Subject: Re: [PATCH] Revert "dt-bindings: usb: mtk-xhci: Make all clocks
 required"
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <kernel@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>
Date:   Mon, 11 Jul 2022 14:40:44 +0800
In-Reply-To: <20220708192605.43351-1-nfraprado@collabora.com>
References: <20220708192605.43351-1-nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-08 at 15:26 -0400, Nícolas F. R. A. Prado wrote:
> This reverts commit ebc4969ae125e65fdb563f66f4bfa7aec95f7eb4. That
> commit was supposed to make the binding better reflect the MediaTek
> XHCI
> hardware block by requiring all clocks to be present. But doing that
> also causes too much noise in the devicetrees, since it requires
> updating old MediaTek DTs to add clock handles for the fixed clocks,
> and
> going forward every new clock added to the binding would require even
> more updates.
> 
> The commit also didn't update the example to match the changes,
> causing
> additional warnings.
> 
> Instead let's keep the clocks optional so that old devicetrees can
> keep
> omitting the fixed clocks, and we'll just add the clocks as required
> on
> new DTs.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 4
> +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> xhci.yaml
> index 1444d18ef9bc..63cbc2b62d18 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -67,6 +67,7 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 1
>      items:
>        - description: Controller clock used by normal mode
>        - description: Reference clock used by low power mode etc
> @@ -75,8 +76,9 @@ properties:
>        - description: controller clock
>  
>    clock-names:
> +    minItems: 1
>      items:
> -      - const: sys_ck
> +      - const: sys_ck  # required, the following ones are optional
>        - const: ref_ck
>        - const: mcu_ck
>        - const: dma_ck

Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks a lot



