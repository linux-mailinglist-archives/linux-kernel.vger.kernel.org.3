Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4D592815
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiHODYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHODYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:24:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0617913F07
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:24:10 -0700 (PDT)
X-UUID: 551313bde9db42a68761a7a0f6c0d5c2-20220815
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=iBzk1r0qfWFWFO9fv+i28eGbwC7q2nSc0bcZjmqYIrI=;
        b=fElHIYYVGgsllFuXKQXF2hBEtv93P0O2fPw7wuXNJkK/rgMEkQDDuKXhs0EKjOdgBUIBevXa+aK12m7keAqg5mNFBIIrBviqFbVGJ49GLk+YhHcLWf/yX9PScKKowTQR8T6yY1TIo8y8swt/qe5SfFkoGO2CtF7tws2qV12DJ7M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:83b3666a-1665-4f63-8ad6-1b2c810d90dd,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:46
X-CID-INFO: VERSION:1.1.9,REQID:83b3666a-1665-4f63-8ad6-1b2c810d90dd,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:46
X-CID-META: VersionHash:3d8acc9,CLOUDID:f34ecdae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:cbc6cb69c86f,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 551313bde9db42a68761a7a0f6c0d5c2-20220815
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1685142612; Mon, 15 Aug 2022 11:24:08 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 15 Aug 2022 11:24:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Aug 2022 11:24:07 +0800
Message-ID: <59b7b695b781b583fff8236c5d37cf26016efce2.camel@mediatek.com>
Subject: Re: [PATCH v1, 0/1] fix gce timeout issue
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 15 Aug 2022 11:24:07 +0800
In-Reply-To: <20220815030740.28899-1-yongqiang.niu@mediatek.com>
References: <20220815030740.28899-1-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yongqiang,

Please don't send cover letters for single patches, thanks.

https://lore.kernel.org/all/YuJsDI8rqkHuysIT@sirena.org.uk/

BRs,
Allen

On Mon, 2022-08-15 at 11:07 +0800, Yongqiang Niu wrote:
> base linux v5.17-rc1
> 
> Yongqiang Niu (1):
>   mailbox: mtk-cmdq: fix gce timeout issue
> 
>  drivers/mailbox/mtk-cmdq-mailbox.c | 57 ++++++++++++++++++++++++++
> ----
>  1 file changed, 51 insertions(+), 6 deletions(-)
> 

