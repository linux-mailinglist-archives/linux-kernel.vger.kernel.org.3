Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37175927F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiHODH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHODHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:07:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD5CEE07
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:07:52 -0700 (PDT)
X-UUID: 11973f905e044e729646e4fe48146a10-20220815
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qNdD3chj2kYZpz62oAkZWWNj2GtmwS9LzVNRd/CmfQE=;
        b=nZ7YivC59D5miUycSO691Dwknon05Aaif9pPFKF71gBMCGovwi/fmPaWk3EbemoR0l8te2mUCG/7hVwB/CDYNrHCoLbaPzhsU195KqjgJtFOq49vMrgTwwv25M0IGdNm3KARJFXzJhob2c73Ms3xnV+BrMVE0VxF5z4hoLjMQhg=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.9,REQID:13ffe167-c13b-4501-9606-f4ef0e4677d1,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:100,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_
        GS6885AD,ACTION:quarantine,TS:200
X-CID-INFO: VERSION:1.1.9,REQID:13ffe167-c13b-4501-9606-f4ef0e4677d1,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:100,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_HT
        S54396,ACTION:quarantine,TS:200
X-CID-META: VersionHash:3d8acc9,CLOUDID:fd9cccae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:e656150cf9f8,Recheck:0,SF:28|16|19|48|801,TC:nil,Content:3,EDM:-3,IP:n
        il,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 11973f905e044e729646e4fe48146a10-20220815
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1370539506; Mon, 15 Aug 2022 11:07:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 15 Aug 2022 11:07:46 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Aug 2022 11:07:45 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1, 0/1] fix gce timeout issue
Date:   Mon, 15 Aug 2022 11:07:39 +0800
Message-ID: <20220815030740.28899-1-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

base linux v5.17-rc1

Yongqiang Niu (1):
  mailbox: mtk-cmdq: fix gce timeout issue

 drivers/mailbox/mtk-cmdq-mailbox.c | 57 ++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 6 deletions(-)

-- 
2.25.1

