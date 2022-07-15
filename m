Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0BD576354
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbiGOODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiGOODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:03:22 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C478F26AC1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:03:20 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id vS3J2700R4C55Sk01S3JMp; Fri, 15 Jul 2022 16:03:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oCLuY-003gpc-7b; Fri, 15 Jul 2022 16:03:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oCLuX-00EDej-Nj; Fri, 15 Jul 2022 16:03:17 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] of: overlay: Move devicetree_corrupt() check up
Date:   Fri, 15 Jul 2022 16:03:14 +0200
Message-Id: <c91ce7112eb5167ea46a43d8a980e76b920010ba.1657893306.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657893306.git.geert+renesas@glider.be>
References: <cover.1657893306.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in doing several preparatory steps in
of_overlay_fdt_apply(), only to see of_overlay_apply() return early
because of a corrupt device tree.

Move the check for a corrupt device tree from of_overlay_apply() to
of_overlay_fdt_apply(), to check for this as early as possible.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/overlay.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 4044ddcb02c60a58..84a8d402009cb3b2 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -903,12 +903,6 @@ static int of_overlay_apply(struct overlay_changeset *ovcs)
 {
 	int ret = 0, ret_revert, ret_tmp;
 
-	if (devicetree_corrupt()) {
-		pr_err("devicetree state suspect, refuse to apply overlay\n");
-		ret = -EBUSY;
-		goto out;
-	}
-
 	ret = of_resolve_phandles(ovcs->overlay_root);
 	if (ret)
 		goto out;
@@ -983,6 +977,11 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 
 	*ret_ovcs_id = 0;
 
+	if (devicetree_corrupt()) {
+		pr_err("devicetree state suspect, refuse to apply overlay\n");
+		return -EBUSY;
+	}
+
 	if (overlay_fdt_size < sizeof(struct fdt_header) ||
 	    fdt_check_header(overlay_fdt)) {
 		pr_err("Invalid overlay_fdt header\n");
-- 
2.25.1

