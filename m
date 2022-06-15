Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6EF54C04D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbiFODts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238480AbiFODtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:49:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF54FC62;
        Tue, 14 Jun 2022 20:49:44 -0700 (PDT)
X-UUID: a77d42a160e64db18aa03c97b8d5332e-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:cce0f3d9-6be8-452a-8982-c6588450fee4,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:cce0f3d9-6be8-452a-8982-c6588450fee4,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:732342f6-e099-41ba-a32c-13b8bfe63214,C
        OID:91aab2dd5763,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: a77d42a160e64db18aa03c97b8d5332e-20220615
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1614482523; Wed, 15 Jun 2022 11:49:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 15 Jun 2022 11:49:38 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Jun 2022 11:49:38 +0800
Message-ID: <24af9009a288f4bd0ee01f2250a0d746564136ed.camel@mediatek.com>
Subject: Re: [PATCH v3 03/10] scsi: ufs-mediatek: Introduce workaround for
 power mode change
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Bart Van Assche <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>
CC:     <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <powen.kao@mediatek.com>,
        <mason.zhang@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <eddie.huang@mediatek.com>,
        <tun-yu.yu@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
        Peter Wang <peter.want@medaitek.com>
Date:   Wed, 15 Jun 2022 11:49:38 +0800
In-Reply-To: <386bfd16-e7be-7f80-cbaa-f55e01d3b070@acm.org>
References: <20220614141655.14409-1-stanley.chu@mediatek.com>
         <20220614141655.14409-4-stanley.chu@mediatek.com>
         <386bfd16-e7be-7f80-cbaa-f55e01d3b070@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 09:46 -0700, Bart Van Assche wrote:
> On 6/14/22 07:16, Stanley Chu wrote:
> > +	if ((dev_req_params->pwr_tx != FAST_MODE) &&
> > +		(dev_req_params->gear_tx < UFS_HS_G4))
> > +		return false;
> > +
> > +	if ((dev_req_params->pwr_rx != FAST_MODE) &&
> > +		(dev_req_params->gear_rx < UFS_HS_G4))
> > +		return false;
> 
> Please do not use more parentheses than needed. I think 8
> parentheses 
> can be left out from the above code.

Thanks! fixed in v4.

> 
> Thanks,
> 
> Bart.

