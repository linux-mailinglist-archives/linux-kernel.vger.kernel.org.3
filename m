Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273FE4F9B83
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiDHRXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbiDHRXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:23:17 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5750F10242D;
        Fri,  8 Apr 2022 10:21:12 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z15so1988542qtj.13;
        Fri, 08 Apr 2022 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w53mUy5JVWp+l7UDjfpOdeHtwRO8q8QjeFkHdugkyDA=;
        b=Ch3QMPejiCrhfiPCkc0KlBxrHZ6jo/geYFR746XH3Lhg/AVVBKLLAPsXWicVhUBOUU
         hQnhOfiBD0tP5/rwWhEk4zRQ6SWcPFmJU8ShkV3cdErzb7eKTpOyhh9X19oBDrRNGSbL
         IDh7dUKKotM3Z3VCE43gCYjTAI4gat4PxcKufljZfnbz2Z8k0Fw8MFqnJnekRTsaxfDi
         POuTRINZfI1cxofu5pcQEDi3w4ADZM6f4zN9kmJudH+MNkTGSTjFp+VJPThFlx7v2Ho4
         msR+q3Wv/8el+JlCbfrvolS5ngGlX4fV2x9yQ5B5uriRv7/t5J286rxMr07ntqzG8gHn
         L8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w53mUy5JVWp+l7UDjfpOdeHtwRO8q8QjeFkHdugkyDA=;
        b=Fu3kYaS3lrCjLCDGQ16nI9Ng85q5o1NnmB2tsJIxrewL+GA3kkl1XvTISSWvJDFfOp
         /VZOkGTkhEQxvgZHyp/af0Cm4/wsBIvAx9brQb18nbDn27HF4PkaVaG5xxjIs/utuieO
         h89aReMdCJ3+RZBGTi2YeaAHvvq6T7YWo6M9VfSTd9DFTykhwCz1xL5PM6uAxhbbFHQZ
         WhxvnnEJJhqeAZAqkSghFc1hcjMuWtkb887HRnGvS7CvwNDR01v2gW/DobQvUiZ6cLHZ
         YY34w1SI2JhJ1diAsTTrwsoPV4TVosN7+PVbjH+DJpaV/h8cjgcMktlg/1q1lwNsbn0g
         hUYA==
X-Gm-Message-State: AOAM531Fni7Oz9oRNTdZqhl5/F1lwk/QG0g7w/FilSIVTX242lG8P+Lc
        XLVVpLovQWmAIKnYKCY2nDc=
X-Google-Smtp-Source: ABdhPJzpS+aigGsUmcgHTp7fhO3McjQyQkhz3VbEFkqd6pgLOkv5FWi7HcZ+NnY9b2mmpueFmGT+Wg==
X-Received: by 2002:a05:622a:1a27:b0:2e0:64c2:7469 with SMTP id f39-20020a05622a1a2700b002e064c27469mr17003111qtb.187.1649438471403;
        Fri, 08 Apr 2022 10:21:11 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:db9:563b:eb2c:7a7b])
        by smtp.gmail.com with ESMTPSA id br13-20020a05620a460d00b00680d020b4cbsm13378941qkb.10.2022.04.08.10.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 10:21:10 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 1/1] of: overlay: of_overlay_apply() kfree() errors
Date:   Fri,  8 Apr 2022 12:21:03 -0500
Message-Id: <20220408172103.371637-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Fix various kfree() issues related to of_overlay_apply().
  - Double kfree() of fdt and tree when init_overlay_changeset()
    returns an error.
  - free_overlay_changeset() free of the root of the unflattened
    overlay (variable tree) instead of the memory that contains
    the unflattened overlay.
  - Move similar kfree()s from multiple error locations to a
    common error path (err_free_tree_unlocked:).

Double kfree()
Reported-by: Slawomir Stepien <slawomir.stepien@nokia.com>

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 64 ++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index d80160cf34bb..1b9a90d61496 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -58,6 +58,7 @@ struct fragment {
  * @id:			changeset identifier
  * @ovcs_list:		list on which we are located
  * @fdt:		base of memory allocated to hold aligned FDT that was unflattened to create @overlay_tree
+ * @overlay_mem:	the memory chunk that contains @overlay_tree
  * @overlay_tree:	expanded device tree that contains the fragment nodes
  * @count:		count of fragment structures
  * @fragments:		fragment nodes in the overlay expanded device tree
@@ -68,6 +69,7 @@ struct overlay_changeset {
 	int id;
 	struct list_head ovcs_list;
 	const void *fdt;
+	const void *overlay_mem;
 	struct device_node *overlay_tree;
 	int count;
 	struct fragment *fragments;
@@ -720,6 +722,7 @@ static struct device_node *find_target(struct device_node *info_node)
  * init_overlay_changeset() - initialize overlay changeset from overlay tree
  * @ovcs:	Overlay changeset to build
  * @fdt:	base of memory allocated to hold aligned FDT that was unflattened to create @tree
+ * @tree_mem:	Memory that contains @tree
  * @tree:	Contains the overlay fragments and overlay fixup nodes
  *
  * Initialize @ovcs.  Populate @ovcs->fragments with node information from
@@ -730,13 +733,23 @@ static struct device_node *find_target(struct device_node *info_node)
  * detected in @tree, or -ENOSPC if idr_alloc() error.
  */
 static int init_overlay_changeset(struct overlay_changeset *ovcs,
-		const void *fdt, struct device_node *tree)
+		const void *fdt, const void *tree_mem, struct device_node *tree)
 {
 	struct device_node *node, *overlay_node;
 	struct fragment *fragment;
 	struct fragment *fragments;
 	int cnt, id, ret;
 
+	/*
+	 * Must set these fields before any error return. fdt and tree_mem
+	 * will be freed by free_overlay_changeset(), which is called if
+	 * init_overlay_changeset() returns an error.
+	 */
+
+	ovcs->fdt = fdt;
+	ovcs->overlay_mem = tree_mem;
+	ovcs->overlay_tree = tree;
+
 	/*
 	 * Warn for some issues.  Can not return -EINVAL for these until
 	 * of_unittest_apply_overlay() is fixed to pass these checks.
@@ -750,9 +763,6 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 	if (!of_node_is_root(tree))
 		pr_debug("%s() tree is not root\n", __func__);
 
-	ovcs->overlay_tree = tree;
-	ovcs->fdt = fdt;
-
 	INIT_LIST_HEAD(&ovcs->ovcs_list);
 
 	of_changeset_init(&ovcs->cset);
@@ -865,7 +875,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 	 * ovcs->fdt due to the policy that overlay notifiers are not allowed
 	 * to retain pointers into the overlay devicetree.
 	 */
-	kfree(ovcs->overlay_tree);
+	kfree(ovcs->overlay_mem);
 	kfree(ovcs->fdt);
 	kfree(ovcs);
 }
@@ -875,6 +885,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  *
  * of_overlay_apply() - Create and apply an overlay changeset
  * @fdt:	base of memory allocated to hold the aligned FDT
+ * @tree_mem:	Memory that contains @tree
  * @tree:	Expanded overlay device tree
  * @ovcs_id:	Pointer to overlay changeset id
  *
@@ -913,31 +924,27 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * id is returned to *ovcs_id.
  */
 
-static int of_overlay_apply(const void *fdt, struct device_node *tree,
-		int *ovcs_id)
+static int of_overlay_apply(const void *fdt, void *tree_mem,
+		struct device_node *tree, int *ovcs_id)
 {
 	struct overlay_changeset *ovcs;
 	int ret = 0, ret_revert, ret_tmp;
 
 	/*
-	 * As of this point, fdt and tree belong to the overlay changeset.
+	 * As of this point, fdt and tree_mem belong to the overlay changeset.
 	 * overlay changeset code is responsible for freeing them.
 	 */
 
 	if (devicetree_corrupt()) {
 		pr_err("devicetree state suspect, refuse to apply overlay\n");
-		kfree(fdt);
-		kfree(tree);
 		ret = -EBUSY;
-		goto out;
+		goto err_free_tree_unlocked;
 	}
 
 	ovcs = kzalloc(sizeof(*ovcs), GFP_KERNEL);
 	if (!ovcs) {
-		kfree(fdt);
-		kfree(tree);
 		ret = -ENOMEM;
-		goto out;
+		goto err_free_tree_unlocked;
 	}
 
 	of_overlay_mutex_lock();
@@ -947,9 +954,14 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	if (ret)
 		goto err_free_tree;
 
-	ret = init_overlay_changeset(ovcs, fdt, tree);
+	/*
+	 * init_overlay_changeset() promises to add tree_mem and tree to ovcs
+	 * even in the case of an early error return, so they can be freed by
+	 * free_overlay_changeset().
+	 */
+	ret = init_overlay_changeset(ovcs, fdt, tree_mem, tree);
 	if (ret)
-		goto err_free_tree;
+		goto err_free_overlay_changeset;
 
 	/*
 	 * after overlay_notify(), ovcs->overlay_tree related pointers may have
@@ -999,7 +1011,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 
 err_free_tree:
 	kfree(fdt);
-	kfree(tree);
+	kfree(tree_mem);
 
 err_free_overlay_changeset:
 	free_overlay_changeset(ovcs);
@@ -1008,9 +1020,14 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	mutex_unlock(&of_mutex);
 	of_overlay_mutex_unlock();
 
-out:
 	pr_debug("%s() err=%d\n", __func__, ret);
 
+	return ret;
+
+err_free_tree_unlocked:
+	kfree(fdt);
+	kfree(tree_mem);
+
 	return ret;
 }
 
@@ -1019,6 +1036,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 {
 	void *new_fdt;
 	void *new_fdt_align;
+	void *overlay_mem;
 	int ret;
 	u32 size;
 	struct device_node *overlay_root = NULL;
@@ -1046,18 +1064,17 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 	new_fdt_align = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);
 	memcpy(new_fdt_align, overlay_fdt, size);
 
-	of_fdt_unflatten_tree(new_fdt_align, NULL, &overlay_root);
-	if (!overlay_root) {
+	overlay_mem = of_fdt_unflatten_tree(new_fdt_align, NULL, &overlay_root);
+	if (!overlay_mem) {
 		pr_err("unable to unflatten overlay_fdt\n");
 		ret = -EINVAL;
 		goto out_free_new_fdt;
 	}
 
-	ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
+	ret = of_overlay_apply(new_fdt, overlay_mem, overlay_root, ovcs_id);
 	if (ret < 0) {
 		/*
-		 * new_fdt and overlay_root now belong to the overlay
-		 * changeset.
+		 * new_fdt and overlay_mem now belong to the overlay changeset.
 		 * overlay changeset code is responsible for freeing them.
 		 */
 		goto out;
@@ -1067,6 +1084,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 
 
 out_free_new_fdt:
+	kfree(overlay_mem);
 	kfree(new_fdt);
 
 out:
-- 
Frank Rowand <frank.rowand@sony.com>

