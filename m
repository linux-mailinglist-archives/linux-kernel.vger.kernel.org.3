Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0015805A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbiGYUbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbiGYUbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:31:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3908C559D;
        Mon, 25 Jul 2022 13:31:36 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C4F616601B06;
        Mon, 25 Jul 2022 21:31:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658781093;
        bh=W9DZSzPqzjJhWL01AORUmAgCTKm7R4Z6jqzXRhJ6p8k=;
        h=From:To:Cc:Subject:Date:From;
        b=mgLtyfjmxYamFkm0NIFFBO3WvTNhryYyRZZRfwEtyhlaBaAtHEiXXp9ZQLoLy81u7
         HrPMgjH3ij0kg5sCxQsN1iwAQhSxRcSd0YvfF1S6e/zhJysobbiqVH1oFwZYZfoBU0
         o3ScnCOQs5eAeIzlvAboZRLo20Go7myIHghXYaMdumMH83Q59E8LqFgY5os84PfVcT
         4XNI5lZh61oNjAZwdCqFnN7/MrU6e+VaksXFUwPQBID47YE8eyjh104PY4pJNN2FPs
         TNSGaHM2lH+UM0VNozY+NEuXlhqr9XWOPEp3RIgw4OncR13x2gs3Yjsbn/ScKeXEHq
         COV/hZR/wCQ1g==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: typec: retimer: Add missing id check in match callback
Date:   Mon, 25 Jul 2022 16:31:29 -0400
Message-Id: <20220725203129.1973260-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fwnode_connection_find_match() function handles two cases: named
references and graph endpoints. In the second case, the match function
passed in is called with the id to check for the match. However, the
match function for the recently added type-c retimer class assumes the
connection has already been matched (which is only true for the first
case).

The result is that with that change, all type-c nodes with graph
endpoints defer probe indefinitely, independently of having a retimer
connection or not.

Add the missing check, like is done by the type-c mux and usb role
switch code, to fix the issue.

Fixes: ddaf8d96f93b ("usb: typec: Add support for retimers")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/usb/typec/retimer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/retimer.c b/drivers/usb/typec/retimer.c
index 051eaa7d2899..2003731f1bee 100644
--- a/drivers/usb/typec/retimer.c
+++ b/drivers/usb/typec/retimer.c
@@ -36,8 +36,13 @@ static int retimer_fwnode_match(struct device *dev, const void *fwnode)
 
 static void *typec_retimer_match(struct fwnode_handle *fwnode, const char *id, void *data)
 {
-	struct device *dev  = class_find_device(&retimer_class, NULL, fwnode,
-						retimer_fwnode_match);
+	struct device *dev;
+
+	if (id && !fwnode_property_present(fwnode, id))
+		return NULL;
+
+	dev = class_find_device(&retimer_class, NULL, fwnode,
+				retimer_fwnode_match);
 
 	return dev ? to_typec_retimer(dev) : ERR_PTR(-EPROBE_DEFER);
 }
-- 
2.37.0

