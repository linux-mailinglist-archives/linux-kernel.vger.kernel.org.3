Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE3D4D00EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbiCGOR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243088AbiCGORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:17:15 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A962F8EB4F;
        Mon,  7 Mar 2022 06:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646662579;
  x=1678198579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XwkuwfxcIAxG2OjtkRXL4sW9IDd7MqSywi8/nrfWITE=;
  b=ns1x7N6GvDJWfbvUD54HiqfawDmEVk3K9K1C3lwc0dBfKmbr1BwO+hGw
   PzUSd7lJdQRbANo8UyD8LznhzgNX+dZ1GE523fHhsJcIpMRnr+8VsD2KR
   AyV6zDCaDWpPtHLzfsK5dlOrITp9Et0/2g1QvUBL2WcLcOmoH/ENf9bGE
   XKdoJkoPPONDR1h+v72YbuJiVkl38dJDdJKOyimRtotmkmG5pGfcJdahK
   99WsHQHN4c1Xu0br8o5DM8FJOHJOuBCTGGWl/UOJHLlgreeCOKA7kaQDf
   iN0P1AX57vdMOxHu5rJn3z41bmUvxRNCGumBe995e6uCyxQcFn2MVdXH8
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <vigneshr@ti.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <joern@lazybastard.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <frowand.list@gmail.com>, <krzysztof.kozlowski@canonical.com>,
        <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 1/4] mtd: core: Check devicetree alias for index
Date:   Mon, 7 Mar 2022 15:15:46 +0100
Message-ID: <20220307141549.2732179-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307141549.2732179-1-vincent.whitchurch@axis.com>
References: <20220307141549.2732179-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the MTD index to be specified via a devicetree alias, so that the
number does not just depend on probe order.  This is useful to allow
pseudo-devices like phram to be optionally used on systems, without
having this affect the numbering of the real hardware MTD devices.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mtd/mtdcore.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index bd4b31023c82..37c8b1b5db26 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -590,9 +590,10 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 
 int add_mtd_device(struct mtd_info *mtd)
 {
+	struct device_node *np = mtd_get_of_node(mtd);
 	struct mtd_info *master = mtd_get_master(mtd);
 	struct mtd_notifier *not;
-	int i, error;
+	int i, error, ofidx;
 
 	/*
 	 * May occur, for instance, on buggy drivers which call
@@ -631,7 +632,13 @@ int add_mtd_device(struct mtd_info *mtd)
 
 	mutex_lock(&mtd_table_mutex);
 
-	i = idr_alloc(&mtd_idr, mtd, 0, 0, GFP_KERNEL);
+	ofidx = -1;
+	if (np)
+		ofidx = of_alias_get_id(np, "mtd");
+	if (ofidx >= 0)
+		i = idr_alloc(&mtd_idr, mtd, ofidx, ofidx + 1, GFP_KERNEL);
+	else
+		i = idr_alloc(&mtd_idr, mtd, 0, 0, GFP_KERNEL);
 	if (i < 0) {
 		error = i;
 		goto fail_locked;
-- 
2.34.1

