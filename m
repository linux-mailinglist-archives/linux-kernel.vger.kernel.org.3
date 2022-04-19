Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20CB50615E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbiDSAzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244065AbiDSAzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:55:32 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C46222BEC;
        Mon, 18 Apr 2022 17:52:50 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i3-20020a056830010300b00605468119c3so4462857otp.11;
        Mon, 18 Apr 2022 17:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RkBcyKke18ZVySJ2ZFAhUkR+Ui0QMtkmvZt8L5YlZg=;
        b=G7QkF9ijzcHFwO7g+F16/1dTAfMTVhz8gPt3pjyPM/3bDBb5UY+sk3x5EJG6QvGR15
         IcNPkdp33+ai0sdIIq5ZwY3r/jUuFnL9w8xHEnNvKZaR0qdHF4WxzMzIjTkcoDP3DAuU
         hqt1xRSYqBCVB3eaoMS2f5l2Fdno2R/u+GmIzr86fikW41wAZ1guuvdbAsim9ltMMD75
         74rsk8uIThVVVBIONkZM0pggSlbVgsaL7AoKVRiLVqEFQSK9TvdCk473W9CxnKWaphDA
         yDXeFDzharC1RMBd9Dc6Q3roOlAJjuYfbr3L+oq/eXXAtC8txGNrpHJhfk1I/7WR4s+s
         a5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RkBcyKke18ZVySJ2ZFAhUkR+Ui0QMtkmvZt8L5YlZg=;
        b=bhlq4fjEDrVQKhL5dxG7DKGk2/z/SHJTk3dqArXTcbY7SL9NM/l1cvkYAa4pRo3IUB
         QbugVGsgn9ywjZ86xOQpyeROncYSyDlr+5mKK/hu9wZdCgNSq/OmEPvwP+AOstMTr7Ai
         sRBfYm5mKidWOq3NZ0fgMumVZgocmfKuGSmhlIW7OgVub0JouDabs5wyypqxdUfXFRYB
         +l8SywAJcC0jYPJYQPKb8MiaLJtUmFYs6qsyg1732kepSDf1LNDW9oW2ZGAdFmegVAgC
         6zzuQTGvK+HqmU+SeJt8gVguNmGxGacxdzmsFOmdd0EAuhfeJa6CZEzQvJU4PrucbOU/
         bPqQ==
X-Gm-Message-State: AOAM532/HT8cFfNSlQ4pyiQHK6ZqZtnGQdx6wsF/ZbjUteqaURBW64T0
        N6V4jSp+TZTHjGKDK/orjtA=
X-Google-Smtp-Source: ABdhPJwKOQDi6GC03u5IbnCnFcpyx+spF2VNzwlbAEJXLTDZcnJIC1ZzD38oKAqAsQzO4VPnCazxCA==
X-Received: by 2002:a9d:518b:0:b0:605:4768:18e3 with SMTP id y11-20020a9d518b000000b00605476818e3mr3999207otg.264.1650329569620;
        Mon, 18 Apr 2022 17:52:49 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:7cac:cda1:c0cf:63b6])
        by smtp.gmail.com with ESMTPSA id l19-20020a05687040d300b000e2f6d3afd1sm4534403oal.19.2022.04.18.17.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 17:52:49 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH v3 1/2] of: overlay: rename variables to be consistent
Date:   Mon, 18 Apr 2022 19:52:40 -0500
Message-Id: <20220419005241.831411-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419005241.831411-1-frowand.list@gmail.com>
References: <20220419005241.831411-1-frowand.list@gmail.com>
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

Variables change name across function calls when there is not a good
reason to do so.  Fix by changing "fdt" to "new_fdt" and "tree" to
"overlay_root".

The name disparity was confusing when creating the following commit.
The name changes are in this separate commit to make review of the
following commmit less complex.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
Changes since v2:
  - minor additions

 drivers/of/overlay.c | 94 ++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index d80160cf34bb..0a98e3254a1a 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -57,8 +57,8 @@ struct fragment {
  * struct overlay_changeset
  * @id:			changeset identifier
  * @ovcs_list:		list on which we are located
- * @fdt:		base of memory allocated to hold aligned FDT that was unflattened to create @overlay_tree
- * @overlay_tree:	expanded device tree that contains the fragment nodes
+ * @new_fdt:		Memory allocated to hold unflattened aligned FDT
+ * @overlay_root:	expanded device tree that contains the fragment nodes
  * @count:		count of fragment structures
  * @fragments:		fragment nodes in the overlay expanded device tree
  * @symbols_fragment:	last element of @fragments[] is the  __symbols__ node
@@ -67,8 +67,8 @@ struct fragment {
 struct overlay_changeset {
 	int id;
 	struct list_head ovcs_list;
-	const void *fdt;
-	struct device_node *overlay_tree;
+	const void *new_fdt;
+	struct device_node *overlay_root;
 	int count;
 	struct fragment *fragments;
 	bool symbols_fragment;
@@ -185,7 +185,7 @@ static int overlay_notify(struct overlay_changeset *ovcs,
 
 /*
  * The values of properties in the "/__symbols__" node are paths in
- * the ovcs->overlay_tree.  When duplicating the properties, the paths
+ * the ovcs->overlay_root.  When duplicating the properties, the paths
  * need to be adjusted to be the correct path for the live device tree.
  *
  * The paths refer to a node in the subtree of a fragment node's "__overlay__"
@@ -221,7 +221,7 @@ static struct property *dup_and_fixup_symbol_prop(
 
 	if (path_len < 1)
 		return NULL;
-	fragment_node = __of_find_node_by_path(ovcs->overlay_tree, path + 1);
+	fragment_node = __of_find_node_by_path(ovcs->overlay_root, path + 1);
 	overlay_node = __of_find_node_by_path(fragment_node, "__overlay__/");
 	of_node_put(fragment_node);
 	of_node_put(overlay_node);
@@ -718,19 +718,20 @@ static struct device_node *find_target(struct device_node *info_node)
 
 /**
  * init_overlay_changeset() - initialize overlay changeset from overlay tree
- * @ovcs:	Overlay changeset to build
- * @fdt:	base of memory allocated to hold aligned FDT that was unflattened to create @tree
- * @tree:	Contains the overlay fragments and overlay fixup nodes
+ * @ovcs:		Overlay changeset to build
+ * @new_fdt:		Memory allocated to hold unflattened aligned FDT
+ * @overlay_root:	Contains the overlay fragments and overlay fixup nodes
  *
  * Initialize @ovcs.  Populate @ovcs->fragments with node information from
- * the top level of @tree.  The relevant top level nodes are the fragment
- * nodes and the __symbols__ node.  Any other top level node will be ignored.
+ * the top level of @overlay_root.  The relevant top level nodes are the
+ * fragment nodes and the __symbols__ node.  Any other top level node will
+ * be ignored.
  *
  * Return: 0 on success, -ENOMEM if memory allocation failure, -EINVAL if error
- * detected in @tree, or -ENOSPC if idr_alloc() error.
+ * detected in @overlay_root, or -ENOSPC if idr_alloc() error.
  */
 static int init_overlay_changeset(struct overlay_changeset *ovcs,
-		const void *fdt, struct device_node *tree)
+		const void *new_fdt, struct device_node *overlay_root)
 {
 	struct device_node *node, *overlay_node;
 	struct fragment *fragment;
@@ -741,17 +742,17 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 	 * Warn for some issues.  Can not return -EINVAL for these until
 	 * of_unittest_apply_overlay() is fixed to pass these checks.
 	 */
-	if (!of_node_check_flag(tree, OF_DYNAMIC))
-		pr_debug("%s() tree is not dynamic\n", __func__);
+	if (!of_node_check_flag(overlay_root, OF_DYNAMIC))
+		pr_debug("%s() overlay_root is not dynamic\n", __func__);
 
-	if (!of_node_check_flag(tree, OF_DETACHED))
-		pr_debug("%s() tree is not detached\n", __func__);
+	if (!of_node_check_flag(overlay_root, OF_DETACHED))
+		pr_debug("%s() overlay_root is not detached\n", __func__);
 
-	if (!of_node_is_root(tree))
-		pr_debug("%s() tree is not root\n", __func__);
+	if (!of_node_is_root(overlay_root))
+		pr_debug("%s() overlay_root is not root\n", __func__);
 
-	ovcs->overlay_tree = tree;
-	ovcs->fdt = fdt;
+	ovcs->overlay_root = overlay_root;
+	ovcs->new_fdt = new_fdt;
 
 	INIT_LIST_HEAD(&ovcs->ovcs_list);
 
@@ -764,7 +765,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 	cnt = 0;
 
 	/* fragment nodes */
-	for_each_child_of_node(tree, node) {
+	for_each_child_of_node(overlay_root, node) {
 		overlay_node = of_get_child_by_name(node, "__overlay__");
 		if (overlay_node) {
 			cnt++;
@@ -772,7 +773,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 		}
 	}
 
-	node = of_get_child_by_name(tree, "__symbols__");
+	node = of_get_child_by_name(overlay_root, "__symbols__");
 	if (node) {
 		cnt++;
 		of_node_put(node);
@@ -785,7 +786,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 	}
 
 	cnt = 0;
-	for_each_child_of_node(tree, node) {
+	for_each_child_of_node(overlay_root, node) {
 		overlay_node = of_get_child_by_name(node, "__overlay__");
 		if (!overlay_node)
 			continue;
@@ -807,7 +808,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 	 * if there is a symbols fragment in ovcs->fragments[i] it is
 	 * the final element in the array
 	 */
-	node = of_get_child_by_name(tree, "__symbols__");
+	node = of_get_child_by_name(overlay_root, "__symbols__");
 	if (node) {
 		ovcs->symbols_fragment = 1;
 		fragment = &fragments[cnt];
@@ -861,12 +862,12 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 	}
 	kfree(ovcs->fragments);
 	/*
-	 * There should be no live pointers into ovcs->overlay_tree and
-	 * ovcs->fdt due to the policy that overlay notifiers are not allowed
-	 * to retain pointers into the overlay devicetree.
+	 * There should be no live pointers into ovcs->overlay_root and
+	 * ovcs->new_fdt due to the policy that overlay notifiers are not
+	 * allowed to retain pointers into the overlay devicetree.
 	 */
-	kfree(ovcs->overlay_tree);
-	kfree(ovcs->fdt);
+	kfree(ovcs->overlay_root);
+	kfree(ovcs->new_fdt);
 	kfree(ovcs);
 }
 
@@ -874,16 +875,15 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * internal documentation
  *
  * of_overlay_apply() - Create and apply an overlay changeset
- * @fdt:	base of memory allocated to hold the aligned FDT
- * @tree:	Expanded overlay device tree
- * @ovcs_id:	Pointer to overlay changeset id
+ * @new_fdt:		Memory allocated to hold the aligned FDT
+ * @overlay_root:	Expanded overlay device tree
+ * @ovcs_id:		Pointer to overlay changeset id
  *
  * Creates and applies an overlay changeset.
  *
  * If an error occurs in a pre-apply notifier, then no changes are made
  * to the device tree.
  *
-
  * A non-zero return value will not have created the changeset if error is from:
  *   - parameter checks
  *   - building the changeset
@@ -913,8 +913,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * id is returned to *ovcs_id.
  */
 
-static int of_overlay_apply(const void *fdt, struct device_node *tree,
-		int *ovcs_id)
+static int of_overlay_apply(const void *new_fdt,
+		struct device_node *overlay_root, int *ovcs_id)
 {
 	struct overlay_changeset *ovcs;
 	int ret = 0, ret_revert, ret_tmp;
@@ -926,16 +926,16 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 
 	if (devicetree_corrupt()) {
 		pr_err("devicetree state suspect, refuse to apply overlay\n");
-		kfree(fdt);
-		kfree(tree);
+		kfree(new_fdt);
+		kfree(overlay_root);
 		ret = -EBUSY;
 		goto out;
 	}
 
 	ovcs = kzalloc(sizeof(*ovcs), GFP_KERNEL);
 	if (!ovcs) {
-		kfree(fdt);
-		kfree(tree);
+		kfree(new_fdt);
+		kfree(overlay_root);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -943,20 +943,20 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	of_overlay_mutex_lock();
 	mutex_lock(&of_mutex);
 
-	ret = of_resolve_phandles(tree);
+	ret = of_resolve_phandles(overlay_root);
 	if (ret)
 		goto err_free_tree;
 
-	ret = init_overlay_changeset(ovcs, fdt, tree);
+	ret = init_overlay_changeset(ovcs, new_fdt, overlay_root);
 	if (ret)
 		goto err_free_tree;
 
 	/*
-	 * after overlay_notify(), ovcs->overlay_tree related pointers may have
+	 * After overlay_notify(), ovcs->overlay_root related pointers may have
 	 * leaked to drivers, so can not kfree() tree, aka ovcs->overlay_tree;
 	 * and can not free memory containing aligned fdt.  The aligned fdt
-	 * is contained within the memory at ovcs->fdt, possibly at an offset
-	 * from ovcs->fdt.
+	 * is contained within the memory at ovcs->new_fdt, possibly at an
+	 * offset from ovcs->new_fdt.
 	 */
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
 	if (ret) {
@@ -998,8 +998,8 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	goto out_unlock;
 
 err_free_tree:
-	kfree(fdt);
-	kfree(tree);
+	kfree(new_fdt);
+	kfree(overlay_root);
 
 err_free_overlay_changeset:
 	free_overlay_changeset(ovcs);
-- 
Frank Rowand <frank.rowand@sony.com>

