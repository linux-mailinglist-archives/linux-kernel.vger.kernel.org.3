Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4970550B1B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 16:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiFSOLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 10:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiFSOLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 10:11:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8EAB7EA;
        Sun, 19 Jun 2022 07:11:32 -0700 (PDT)
X-UUID: bc33e73a77e5408d9c6d04967cbc0640-20220619
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:5b7c173a-15d9-480d-914a-cc11bfb68a76,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:5b7c173a-15d9-480d-914a-cc11bfb68a76,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:08491249-4c92-421c-ad91-b806c0f58b2a,C
        OID:8739c87270c6,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: bc33e73a77e5408d9c6d04967cbc0640-20220619
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 162329801; Sun, 19 Jun 2022 22:11:28 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 19 Jun 2022 22:11:27 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Sun, 19 Jun 2022 22:11:27 +0800
Message-ID: <54053ba2b6ca09658a9c360397593a286446c06f.camel@mediatek.com>
Subject: Re: [PATCH -next] scsi: ufs: ufs-mediatek: Fix build error and type
 unmatch
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Ren Zhijie <renzhijie2@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <matthias.bgg@gmail.com>,
        <powen.kao@mediatek.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sun, 19 Jun 2022 22:11:27 +0800
In-Reply-To: <20220619115432.205504-1-renzhijie2@huawei.com>
References: <20220619115432.205504-1-renzhijie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-06-19 at 19:54 +0800, Ren Zhijie wrote:
> If CONFIG_PM_SLEEP is not set.
> 
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-, will be failed,
> like this:
> 
> drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_vreg_fix_vcc’:
> drivers/ufs/host/ufs-mediatek.c:688:46: warning: format ‘%u’ expects
> argument of type ‘unsigned int’, but argument 4 has type ‘long
> unsigned int’ [-Wformat=]
>     snprintf(vcc_name, MAX_VCC_NAME, "vcc-opt%u", res.a1);
>                                              ~^   ~~~~~~
>                                              %lu
> drivers/ufs/host/ufs-mediatek.c: In function
> ‘ufs_mtk_system_suspend’:
> drivers/ufs/host/ufs-mediatek.c:1371:8: error: implicit declaration
> of function ‘ufshcd_system_suspend’; did you mean
> ‘ufs_mtk_system_suspend’? [-Werror=implicit-function-declaration]
>   ret = ufshcd_system_suspend(dev);
>         ^~~~~~~~~~~~~~~~~~~~~
>         ufs_mtk_system_suspend
> drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_system_resume’:
> drivers/ufs/host/ufs-mediatek.c:1386:9: error: implicit declaration
> of function ‘ufshcd_system_resume’; did you mean
> ‘ufs_mtk_system_resume’? [-Werror=implicit-function-declaration]
>   return ufshcd_system_resume(dev);
>          ^~~~~~~~~~~~~~~~~~~~
>          ufs_mtk_system_resume
> cc1: some warnings being treated as errors
> 
> The declaration of func "ufshcd_system_suspend()" is depended on
> CONFIG_PM_SLEEP, so the function wrapper "ufs_mtk_system_suspend()"
> should warpped by CONFIG_PM_SLEEP too.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 3fd23b8dfb54("scsi: ufs: ufs-mediatek: Fix the timing of
> configuring device regulators")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>

Thanks for the fix!

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>


