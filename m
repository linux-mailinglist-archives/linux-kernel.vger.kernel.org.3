Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE221538AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243985AbiEaFel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiEaFej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:34:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95686EC5D;
        Mon, 30 May 2022 22:34:31 -0700 (PDT)
X-UUID: 477be161aee348d3bc290cf2b1c52d83-20220531
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:11eba03c-987f-4e10-81b2-b356a879a8af,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:24,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:24
X-CID-META: VersionHash:2a19b09,CLOUDID:cf0a5714-f88c-475e-badf-d9ee54230b8f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:4,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 477be161aee348d3bc290cf2b1c52d83-20220531
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <qun-wei.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 779116871; Tue, 31 May 2022 13:34:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 31 May 2022 13:34:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 May 2022 13:34:26 +0800
From:   Qun-Wei Lin <qun-wei.lin@mediatek.com>
To:     <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <casper.li@mediatek.com>,
        <chinwen.chang@mediatek.com>, <kuan-ying.lee@mediatek.com>,
        Qun-Wei Lin <qun-wei.lin@mediatek.com>
Subject: [PATCH] scripts: dtc: fix a false alarm for node_name_chars_strict
Date:   Tue, 31 May 2022 13:33:58 +0800
Message-ID: <20220531053358.19003-1-qun-wei.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function check_node_name_chars_strict issues a false alarm when
compiling an overlay dts.

/fragment@0/__overlay__: Character '_' not recommended in node name

This workaround will fix it by skip checking for node named __overlay__.

Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>
---
 scripts/dtc/checks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 781ba1129a8e..6ef4f2cd67b9 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -325,6 +325,11 @@ static void check_node_name_chars_strict(struct check *c, struct dt_info *dti,
 {
 	int n = strspn(node->name, c->data);
 
+	if (streq(node->name, "__overlay__")) {
+		/* HACK: Overlay fragments are a special case */
+		return;
+	}
+
 	if (n < node->basenamelen)
 		FAIL(c, dti, node, "Character '%c' not recommended in node name",
 		     node->name[n]);
-- 
2.18.0

