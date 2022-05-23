Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A74531084
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbiEWM1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbiEWM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:27:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680F631512;
        Mon, 23 May 2022 05:27:29 -0700 (PDT)
X-UUID: 80521b9d309b45c081ef9ff8d748708d-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:c68145b2-2b3d-40f6-816f-a8913b4ecc56,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:9eb83ce3-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,IP:nil,URL:0,File:ni
        l,QS:0,BEC:nil
X-UUID: 80521b9d309b45c081ef9ff8d748708d-20220523
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 788225916; Mon, 23 May 2022 20:27:24 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 20:27:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 23 May 2022 20:27:23 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <robin.murphy@arm.com>
CC:     <bjorn.andersson@linaro.org>, <hch@lst.de>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <mark-pk.tsai@mediatek.com>, <mathieu.poirier@linaro.org>,
        <matthias.bgg@gmail.com>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH 0/2] dma-mapping, remoteproc: Fix dma_mem leak after rproc_shutdown
Date:   Mon, 23 May 2022 20:27:23 +0800
Message-ID: <20220523122723.32602-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <6f1f48e2-a54d-58d6-8946-853cffeb55df@arm.com>
References: <6f1f48e2-a54d-58d6-8946-853cffeb55df@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Sigh.  In theory drivers should never declare coherent memory like
> >> this, and there has been some work to fix remoteproc in that regard.
> >>
> >> But I guess until that is merged we'll need somthing like this fix.
> > 
> > Hi,
> > 
> > Thanks for your comment.
> > As I didn't see other fix of this issue, should we use this patch
> > before the remoteproc work you mentioned is merged?
> 
> TBH I think it would be better "fixed" with a kmemleak_ignore() and a 
> big comment, rather than adding API cruft for something that isn't a 
> real problem. I'm quite sure that no real-world user is unbinding 
> remoteproc drivers frequently enough that leaking a 48-byte allocation 
> each time has any practical significance.
> 

Actually we stop 2 remote processors using the same remoteproc driver
when system suspend or screen off on our arm64 platform.
And the 48-byte slab allocation will be aligned up to 128 bytes on arm64.
So the leak can be significant in our use case especially
in stress test...

We really don't want to ignore it. Maybe there're other way to fix
it without adding APIs?
