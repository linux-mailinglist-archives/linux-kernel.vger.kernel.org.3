Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83A35956BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiHPJj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiHPJj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:39:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B437A6AA23;
        Tue, 16 Aug 2022 02:09:32 -0700 (PDT)
X-UUID: 6fb4a6f92b5e4a0fbc338d31687428da-20220816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nTDkzXP779v1onwYVpNERKCNAZl7uIj+G6XLFlu+OrI=;
        b=oSWAgMmkVKiZo8o5UR6n0l424do7eFvU9EuczQRw3XA3tB/A5QPReVHH/xQ4LKtw8wajDzpaIHnk9QOLbY6q68m2C2U5cNG3oUgD5p0vdJL3CRixqhgPbeT6WmTg1snvUUNmkQCThpyXRLFyKGQgQ7mFGQxuAu9BdheNY2heBww=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:728d4889-b26d-42fa-ad8c-369e73d472fd,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:-5
X-CID-META: VersionHash:3d8acc9,CLOUDID:badd73fd-9e71-4a0f-ba6b-417998daea35,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6fb4a6f92b5e4a0fbc338d31687428da-20220816
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <will.shiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 388599243; Tue, 16 Aug 2022 17:09:25 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 16 Aug 2022 17:09:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 16 Aug 2022 17:09:24 +0800
From:   Will Shiu <Will.Shiu@mediatek.com>
To:     <stanley.chu@mediatek.com>, <linus.walleij@linaro.org>,
        <matthias.bgg@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Will.Shiu@mediatek.com>
CC:     <wsd_upstream@mediatek.com>
Subject: [PATCH 1/1] Pinctrl: Add in zero check
Date:   Tue, 16 Aug 2022 17:09:03 +0800
Message-ID: <20220816090903.19558-1-Will.Shiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add in check of buffer offset to avoid the exception when input 0 size.

Signed-off-by: Will Shiu <Will.Shiu@mediatek.com>
---
 drivers/pinctrl/pinmux.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index f94d43b082d9..646dff591b21 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -689,6 +689,9 @@ static ssize_t pinmux_select(struct file *file, const char __user *user_buf,
 	if (len > PINMUX_SELECT_MAX)
 		return -ENOMEM;
 
+	if (len <= 0)
+		return -EINVAL;
+
 	buf = kzalloc(PINMUX_SELECT_MAX, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-- 
2.18.0

