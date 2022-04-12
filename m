Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294CC4FE327
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356422AbiDLNzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356372AbiDLNz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:55:29 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2944E5716E;
        Tue, 12 Apr 2022 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649771589;
  x=1681307589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7cRqrzsYNIRfiAOotHa409y/Hl5ia/NeruEwkXktTvU=;
  b=a0Q4bD4xe9Vgk7lswM/brL3FPWhU9ZFmXjJ7Ve2idfSJzVx+4jK1YGNV
   VPXcD7srccXyED6vDy9W3LOJQbcTZ+w7V/xjfY3vmvMC/y5hhtiwEGCGj
   GkqCM77pTGJm0aMNIeCfjKg/z6XDssmuZBLEpYZDdkbOH/NImbuUbYeG3
   QaCcMO9a2k4Oq1RnlIqyy9kxo+LP+UaKtLqCARPhTIkQUpJmevN1CUt2h
   fjrNIemSGWrvlR7eweH22s8UQKO6zt46bf3LfGp9JmMnCfGYpWB4ahQEK
   BXb8kw+OGX2Mz5nkBKAF27HjU2MyAYk5ZTLOxefV7VhPbY24nfwhrDgLF
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <vigneshr@ti.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <joern@lazybastard.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <frowand.list@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] mtd: core: Check devicetree alias for index
Date:   Tue, 12 Apr 2022 15:52:59 +0200
Message-ID: <20220412135302.1682890-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220412135302.1682890-1-vincent.whitchurch@axis.com>
References: <20220412135302.1682890-1-vincent.whitchurch@axis.com>
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
index 7731796024e0..9eb0680db312 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -557,9 +557,10 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 
 int add_mtd_device(struct mtd_info *mtd)
 {
+	struct device_node *np = mtd_get_of_node(mtd);
 	struct mtd_info *master = mtd_get_master(mtd);
 	struct mtd_notifier *not;
-	int i, error;
+	int i, error, ofidx;
 
 	/*
 	 * May occur, for instance, on buggy drivers which call
@@ -598,7 +599,13 @@ int add_mtd_device(struct mtd_info *mtd)
 
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

