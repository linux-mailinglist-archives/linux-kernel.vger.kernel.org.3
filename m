Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8105B521E46
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240888AbiEJP1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345813AbiEJP1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:27:30 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBB1DAC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1652195909;
  x=1683731909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L72R/3pl0k6gCMx5L3/WImeqw8/7Ha/qfVw/S09dPtQ=;
  b=gViiMAO+5bLXAeI5jvxXT4YWPU+thGY38nyY16QABfVOaLMg5cTpYIze
   ZVWNl8n/rwc/YyGQ0ZClTvR8n4Vli95YRCWmiejFPYS1P+8LFDLWe5IsL
   +eEmJ1kmsZ70nVi08JHGjHdjRNO236mDtb9PuNhkW8bu2UEI3NLEbNJtJ
   qKZeoYh2hsLAxfCHcWCDVk39f771ZMRZjsGW3EgV4tWhcmbaJ36bf0YsC
   mJJ62QAg1Ph2TTKcq4ZP3e2Jwz5aMR7a9Xeq7qjwKEiqq/ZD/4kZ+A4K7
   V8QPkY3bwvVxjH7LjgrW1P0Mq8U+SZh0l0CcTBchKf8mibTiu3Retja0Z
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] mtd: phram: Allow cached mappings
Date:   Tue, 10 May 2022 17:18:22 +0200
Message-ID: <20220510151822.1809278-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently phram always uses ioremap(), but this is unnecessary when
normal memory is used.  If the reserved-memory node does not specify the
no-map property, indicating it should be mapped as system RAM and
ioremap() cannot be used on it, use a cached mapping using
memremap(MEMREMAP_WB) instead.

On one of my systems this improves read performance by ~70%.

(Note that this driver has always used normal memcpy/memset functions on
memory obtained from ioremap(), which sparse doesn't like.  There is no
memremap() variant which maps exactly to ioremap() on all architectures,
so that behaviour of the driver is not changed to avoid affecting
existing users, but the sparse warnings are suppressed in the moved code
with __force.)

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v4:
    - Split out from "[PATCH v3] mtd: phram: Allow cached mappings"[0] since the
      rest of the patches have been merged to mtd-next.
    - Rebased on mtd-next.
    - Refactored to avoid code duplication, fix sparse warnings in the existing
      code which is moved, and also to avoid SH build problems[1]
    
    [0] https://lore.kernel.org/lkml/20220412135302.1682890-1-vincent.whitchurch@axis.com/"
    [1] https://lore.kernel.org/lkml/CAMuHMdW-8HaQip+DT5W2Owq8M8kbYwHsf8_Zd-5rRfSjSjK0=g@mail.gmail.com/

 drivers/mtd/devices/phram.c | 43 +++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index 506e9edf5c85..208bd4d871f4 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -34,6 +34,7 @@
 struct phram_mtd_list {
 	struct mtd_info mtd;
 	struct list_head list;
+	bool cached;
 };
 
 static LIST_HEAD(phram_list);
@@ -80,13 +81,41 @@ static int phram_write(struct mtd_info *mtd, loff_t to, size_t len,
 	return 0;
 }
 
+static int phram_map(struct phram_mtd_list *phram, phys_addr_t start, size_t len)
+{
+	void *addr = NULL;
+
+	if (phram->cached)
+		addr = memremap(start, len, MEMREMAP_WB);
+	else
+		addr = (void __force *)ioremap(start, len);
+	if (!addr)
+		return -EIO;
+
+	phram->mtd.priv = addr;
+
+	return 0;
+}
+
+static void phram_unmap(struct phram_mtd_list *phram)
+{
+	void *addr = phram->mtd.priv;
+
+	if (phram->cached) {
+		memunmap(addr);
+		return;
+	}
+
+	iounmap((void __iomem *)addr);
+}
+
 static void unregister_devices(void)
 {
 	struct phram_mtd_list *this, *safe;
 
 	list_for_each_entry_safe(this, safe, &phram_list, list) {
 		mtd_device_unregister(&this->mtd);
-		iounmap(this->mtd.priv);
+		phram_unmap(this);
 		kfree(this->mtd.name);
 		kfree(this);
 	}
@@ -96,6 +125,7 @@ static int register_device(struct platform_device *pdev, const char *name,
 			   phys_addr_t start, size_t len, uint32_t erasesize)
 {
 	struct device_node *np = pdev ? pdev->dev.of_node : NULL;
+	bool cached = np ? !of_property_read_bool(np, "no-map") : false;
 	struct phram_mtd_list *new;
 	int ret = -ENOMEM;
 
@@ -103,9 +133,10 @@ static int register_device(struct platform_device *pdev, const char *name,
 	if (!new)
 		goto out0;
 
-	ret = -EIO;
-	new->mtd.priv = ioremap(start, len);
-	if (!new->mtd.priv) {
+	new->cached = cached;
+
+	ret = phram_map(new, start, len);
+	if (ret) {
 		pr_err("ioremap failed\n");
 		goto out1;
 	}
@@ -140,7 +171,7 @@ static int register_device(struct platform_device *pdev, const char *name,
 	return 0;
 
 out2:
-	iounmap(new->mtd.priv);
+	phram_unmap(new);
 out1:
 	kfree(new);
 out0:
@@ -362,7 +393,7 @@ static int phram_remove(struct platform_device *pdev)
 	struct phram_mtd_list *phram = platform_get_drvdata(pdev);
 
 	mtd_device_unregister(&phram->mtd);
-	iounmap(phram->mtd.priv);
+	phram_unmap(phram);
 	kfree(phram);
 
 	return 0;
-- 
2.34.1

