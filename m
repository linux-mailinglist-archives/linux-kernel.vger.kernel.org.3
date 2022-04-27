Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2A5510E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357103AbiD0CQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357105AbiD0CQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:16:38 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350DF473A3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:13:28 -0700 (PDT)
X-UUID: 2282832e28514f0a9b6b8bc582bcfb2e-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:5fad9234-5f94-4589-b8fb-d942025f39e9,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:faefae9,CLOUDID:dd2c99c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 2282832e28514f0a9b6b8bc582bcfb2e-20220427
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1230499426; Wed, 27 Apr 2022 10:13:24 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Apr 2022 10:13:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Apr
 2022 10:13:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 10:13:21 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <yong.wu@mediatek.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <hverkuil-cisco@xs4all.nl>, <iommu@lists.linux-foundation.org>,
        <joro@8bytes.org>, <jroedel@suse.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mchehab@kernel.org>, <miles.chen@mediatek.com>,
        <robin.murphy@arm.com>, <will@kernel.org>
Subject: Re: [PATCH v2] iommu/mediatek: fix NULL pointer dereference when printing dev_name
Date:   Wed, 27 Apr 2022 10:13:21 +0800
Message-ID: <20220427021321.22899-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <4ff4246cd5d567a3fa8124800f5d75be0034621c.camel@mediatek.com>
References: <4ff4246cd5d567a3fa8124800f5d75be0034621c.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong,

>On Mon, 2022-04-25 at 11:03 +0100, Robin Murphy wrote:
>> On 2022-04-25 09:24, Miles Chen via iommu wrote:
>> > When larbdev is NULL (in the case I hit, the node is incorrectly
>> > set
>> > iommus = <&iommu NUM>), it will cause device_link_add() fail and
>> 
>> Until the MT8195 infra MMU support lands, is there ever a case where 
>> it's actually valid for larbdev to be NULL? If not, I think it would
>> be 
>> a lot clearer to explicitly fail the probe here, rather than
>> silently 
>> continue and risk fatal errors, hangs, or other weird behaviour if 
>> there's no guarantee that the correct LARB is powered up (plus then
>> the 
>> release callbacks wouldn't need to worry about it either).
>
>Yes. It should return fail for this case. This issue only happens when
>the dts parameters doesn't respect the definition from the binding[1].
>
>Locally Miles tested with a internal definition that have not send
>upstream to get this KE. In this case, I'm not sure if we should
>request the user use the right ID in dts. Anyway I have no objection to
>modifying this, then something like this: (Avoid invalid input from
>dtb)
>
>@@ -790,6 +790,8 @@ static struct iommu_device
>*mtk_iommu_probe_device(struct device *dev)
> 	 * All the ports in each a device should be in the same larbs.
> 	 */
> 	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
>+	if (larbid >= MTK_LARB_NR_MAX)
>+		return ERR_PTR(-EINVAL);
> 	for (i = 1; i < fwspec->num_ids; i++) {
> 		larbidx = MTK_M4U_TO_LARB(fwspec->ids[i]);
> 		if (larbid != larbidx) {
>@@ -799,6 +801,8 @@ static struct iommu_device
>*mtk_iommu_probe_device(struct device *dev)
> 		}
> 	}
> 	larbdev = data->larb_imu[larbid].dev;
>+	if (!larbdev)
>+		return ERR_PTR(-EINVAL);
> 	link = device_link_add(dev, larbdev,
> 			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> 	if (!link)

Thanks for guilding me, I will put this in patch v2.

Thanks,
Miles

>
>
>[1] 
>https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml#L116

