Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3174E5E55
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 06:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346144AbiCXF6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 01:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiCXF6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 01:58:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C48193988;
        Wed, 23 Mar 2022 22:57:06 -0700 (PDT)
X-UUID: eb6e6d1b03e74206b05e4b9be9c1a174-20220324
X-UUID: eb6e6d1b03e74206b05e4b9be9c1a174-20220324
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2025374543; Thu, 24 Mar 2022 13:57:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Mar 2022 13:57:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 13:57:00 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <trevor.wu@mediatek.com>
CC:     <aaronyu@google.com>, <alsa-devel@alsa-project.org>,
        <angelogioacchino.delregno@collabora.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <robh+dt@kernel.org>, <tiwai@suse.com>,
        <tzungbi@google.com>, <yc.hung@mediatek.com>
Subject: Re: [PATCH v4 3/6] ASoC: dt-bindings: mediatek: mt8195: merge mt8195 machine yaml
Date:   Thu, 24 Mar 2022 13:57:00 +0800
Message-ID: <20220324055700.28736-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220324053851.27350-4-trevor.wu@mediatek.com>
References: <20220324053851.27350-4-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Because the same binding components can be shared by all codecs
> combinations, we only reserve one binding file for mt8195 machine driver
> and rename to a generic name.
> 
> We use compatible string to separate different codec combination instead
> of creating a new binding file for new codec combination.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
>---

...snip...

>diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
>similarity index 87%
>rename from Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
>rename to Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
>index 8f177e02ad35..04953f5b44a4 100644
>--- a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
>+++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
>@@ -1,10 +1,10 @@
> # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> %YAML 1.2
> ---
>-$id: http://devicetree.org/schemas/sound/mt8195-mt6359-rt1019-rt5682.yaml#
>+$id: http://devicetree.org/schemas/sound/mt8195-mt6359.yaml#
> $schema: http://devicetree.org/meta-schemas/core.yaml#
> 
>-title: Mediatek MT8195 with MT6359, RT1019 and RT5682 ASoC sound card driver
>+title: MediaTek MT8195 ASoC sound card driver
> 

I also tested:
'make dt_binding_check DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml'
and it wotks fine.

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 

> maintainers:
>   - Trevor Wu <trevor.wu@mediatek.com>
>@@ -14,7 +14,9 @@ description:
> 
> properties:
>   compatible:
>-    const: mediatek,mt8195_mt6359_rt1019_rt5682
>+    enum:
>+      - mediatek,mt8195_mt6359_rt1019_rt5682
>+      - mediatek,mt8195_mt6359_rt1011_rt5682
> 
>   model:
>     $ref: /schemas/types.yaml#/definitions/string
>-- 
>2.18.0
>
>
