Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B25B576353
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiGOODa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiGOODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:03:22 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F316465
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:03:20 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id vS3K270064C55Sk06S3KUy; Fri, 15 Jul 2022 16:03:19 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oCLuY-003gpg-KX; Fri, 15 Jul 2022 16:03:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oCLuY-00EDeq-5w; Fri, 15 Jul 2022 16:03:18 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] of: overlay: Simplify of_overlay_fdt_apply() tail
Date:   Fri, 15 Jul 2022 16:03:15 +0200
Message-Id: <6a3357a8f7f29704350e3ffae768ee8a462b54d3.1657893306.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657893306.git.geert+renesas@glider.be>
References: <cover.1657893306.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not hurt to fill in the changeset id while the mutex is still
held.  After doing so, the function tails for the success and failure
cases become identical, so they can be unified.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/overlay.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 84a8d402009cb3b2..bd8ff4df723da217 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -1043,20 +1043,15 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 	 * goto err_free_ovcs.  Instead, the caller of of_overlay_fdt_apply()
 	 * can call of_overlay_remove();
 	 */
-
-	mutex_unlock(&of_mutex);
-	of_overlay_mutex_unlock();
-
 	*ret_ovcs_id = ovcs->id;
-
-	return ret;
+	goto out_unlock;
 
 err_free_ovcs:
 	free_overlay_changeset(ovcs);
 
+out_unlock:
 	mutex_unlock(&of_mutex);
 	of_overlay_mutex_unlock();
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(of_overlay_fdt_apply);
-- 
2.25.1

