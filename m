Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A50F5AFA6E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiIGDKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGDKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:10:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EAC25E87
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 20:10:18 -0700 (PDT)
X-UUID: 16f5a9ab8ad946329790add3a972d1fc-20220907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=t97iS4YcYk2aQLZEbYiw0ExZyEUa2KjpAGNCB69JMoA=;
        b=dipnh0LarnZGzf7pqBEQurTAU4UsDGQ8/jRfJ+aLlVf2y+uUnfbWFmJYBGeN069KgayE9aeudRmM/vQNPyJ3MQTnoQp0WRJydocQGVK/SFYcea5UH3OPFPcw/sjYTBPOlQnFI41OBHe3MTyJ2Kfti6U/ksMDEYIONn7EgFD/MbQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:5f7a3b96-9ae9-4d82-82e1-be9e7bdcebde,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:45
X-CID-INFO: VERSION:1.1.10,REQID:5f7a3b96-9ae9-4d82-82e1-be9e7bdcebde,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:45
X-CID-META: VersionHash:84eae18,CLOUDID:77eaefd0-20bd-4e5e-ace8-00692b7ab380,C
        OID:a58702e4a18d,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 16f5a9ab8ad946329790add3a972d1fc-20220907
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 765625676; Wed, 07 Sep 2022 11:10:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 7 Sep 2022 11:10:12 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 7 Sep 2022 11:10:11 +0800
Message-ID: <bfd6d40474d4d5f589a825b0cc193ae229c42d52.camel@mediatek.com>
Subject: Re: [PATCH v4 3/6] iommu/mediatek: Add error path for loop of
 mm_dts_parse
From:   Yong Wu <yong.wu@mediatek.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, Guenter Roeck <groeck@chromium.org>
Date:   Wed, 7 Sep 2022 11:10:11 +0800
In-Reply-To: <20220830083206.GT2030@kadam>
References: <20220824064306.21495-1-yong.wu@mediatek.com>
         <20220824064306.21495-4-yong.wu@mediatek.com> <20220830083206.GT2030@kadam>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks very much for your review:)

On Tue, 2022-08-30 at 11:32 +0300, Dan Carpenter wrote:
> On Wed, Aug 24, 2022 at 02:43:03PM +0800, Yong Wu wrote:
> > The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if the
> > i+1
> > larb is parsed fail, we should put_device for the 0..i larbs.
> > 
> > There are two places need to comment:
> > 1) The larbid may be not linear mapping, we should loop whole
> >    the array in the error path.
> > 2) I move this line position: "data->larb_imu[id].dev = &plarbdev-
> > >dev;"
> >    That means set data->larb_imu[id].dev before the error path.
> >    then we don't need "platform_device_put(plarbdev)" again while
> >    probe_defer case. All depend on "put_device" in the error path
> > in error
> >    cases.
> 
> I don't understand what you're saying here.  There is still a
> platform_device_put(plarbdev) on the success path after
> component_match_add().
> 
> So if we fail when i == 2 then we do:
> 
> 	put_device(data->larb_imu[2].dev);
> 
> But for the previous iterations has both platform_device_put()
> and put_device() called for them.

Sorry for this. Right! For the goto outside the loop, it did put twice.
I will fix this.

> 
> regards,
> dan carpenter
> 

