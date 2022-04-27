Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5A0510EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357093AbiD0CQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356867AbiD0CQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:16:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278FC45786
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:13:14 -0700 (PDT)
X-UUID: 4d52bf4950e9408cb2f74b0ba4b4e415-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:cbcf598e-b9c4-4d07-b602-6eb723e8c0d7,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:22
X-CID-INFO: VERSION:1.1.4,REQID:cbcf598e-b9c4-4d07-b602-6eb723e8c0d7,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:22
X-CID-META: VersionHash:faefae9,CLOUDID:ed2999c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:28|100|17|19|48|101,TC:nil,Content:0,EDM:-3,File:
        nil,QS:0,BEC:nil
X-UUID: 4d52bf4950e9408cb2f74b0ba4b4e415-20220427
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 642688658; Wed, 27 Apr 2022 10:13:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Apr 2022 10:13:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 10:13:07 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <robin.murphy@arm.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <hverkuil-cisco@xs4all.nl>, <iommu@lists.linux-foundation.org>,
        <joro@8bytes.org>, <jroedel@suse.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mchehab@kernel.org>, <miles.chen@mediatek.com>, <will@kernel.org>,
        <yong.wu@mediatek.com>
Subject: Re: [PATCH v2] iommu/mediatek: fix NULL pointer dereference when printing dev_name
Date:   Wed, 27 Apr 2022 10:13:08 +0800
Message-ID: <20220427021308.22855-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <9debe3ab-603d-0d30-a6aa-8963b48e83d4@arm.com>
References: <9debe3ab-603d-0d30-a6aa-8963b48e83d4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Robin,

>> -	link = device_link_add(dev, larbdev,
>> -			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
>> -	if (!link)
>> -		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
>> +	if (larbdev) {
>
>Until the MT8195 infra MMU support lands, is there ever a case where 
>it's actually valid for larbdev to be NULL? If not, I think it would be 
>a lot clearer to explicitly fail the probe here, rather than silently 
>continue and risk fatal errors, hangs, or other weird behaviour if 
>there's no guarantee that the correct LARB is powered up (plus then the 
>release callbacks wouldn't need to worry about it either).

Thanks, I will do probe fail in patch v3 and remove the release modification.

thanks,
Miles

>
>Robin.

