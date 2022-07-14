Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8BC574D56
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiGNMWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiGNMWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:22:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B30D32BA1;
        Thu, 14 Jul 2022 05:22:38 -0700 (PDT)
X-UUID: de906403d5f54b8d96c5cb8eae9dcb4c-20220714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:bb8aa357-990a-44d1-980f-e560e5eccd36,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:ba907fd7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: de906403d5f54b8d96c5cb8eae9dcb4c-20220714
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 592939605; Thu, 14 Jul 2022 20:22:32 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 14 Jul 2022 20:22:30 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 14 Jul 2022 20:22:30 +0800
Message-ID: <e7d28a927044e47ad8018c71d511754dda9ae7d7.camel@mediatek.com>
Subject: Re: [PATCH v1 03/16] dt-bindings: power: mediatek: Refine multiple
 level power domain nodes
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 14 Jul 2022 20:22:30 +0800
In-Reply-To: <20220712192119.GK1823936-robh@kernel.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
         <20220704100028.19932-4-tinghan.shen@mediatek.com>
         <20220705205739.GA2599256-robh@kernel.org>
         <b5667c052447d1b3c3498131af98d80a07ed4767.camel@mediatek.com>
         <20220712192119.GK1823936-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
> 
> Okay, I think you need something more like this that doesn't recurse 
> infinitely:
> 
> patternProperties:
>   "^power-domain@[0-9a-f]+$":
>     $ref: #/$defs/power-domain-node
> 
>     unevaluatedProperties:
>       $ref: #/$defs/power-domain-node
> 
> If you need a 3rd level of nodes:
>       unevaluatedProperties:
>         $ref: #/$defs/power-domain-node
> 
> 
> Rob

After some test, your 1st suggestion works.

The infinite error is introduced from my changes and affect the result of power/renesas,sysc-
rmobile.yaml. The 'additionalProperties' being defined as a DT property is the root of this error.
After fix the indentation, the error is gone.

I'll update the yaml as your 1st suggestion in next version.

Thanks,
TingHan



