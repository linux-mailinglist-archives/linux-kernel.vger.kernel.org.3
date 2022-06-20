Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F9055162D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbiFTKnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbiFTKnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:43:12 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466A211A03;
        Mon, 20 Jun 2022 03:43:11 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AD1C81C0007;
        Mon, 20 Jun 2022 10:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655721789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGXx2eom88ptY7cKPPIRDH5FnUnjq3Iv+rK4OEn7VS8=;
        b=AwN5z3ljiLEMgOCUchkgjgr3BaMWw2b5mz0LuHV4E6/8WHAIjFGBQl7TYT01W1v51zWz6Z
        S6Hh9/dcgD0+EbeIv5Os2L1RFRDhUmpK1RaPgyZ9Pg1ghtY51/vFFnQSf7FRcBOfANUT0y
        ElHvx3nz/NZXf41rsqNrV6Z3duy5cDknxbx9/98NfUuhp0yp6zkM9EzOJX/7Kzzqih6gFi
        lCqm5uG7LamU6SH6ZuysXmA5OmXTqW0etkxSCyP4dn7YDVcMbutrRfqTdZ6Dl0Npz5QbOK
        AuNeN21igSSpjLnKIcCewMOpBIIlR9WULSEW8Rj9vjMS/e0wMoGBsvzEBJPEBQ==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lizhi Hou <lizhi.hou@xilinx.com>
Subject: [PATCH v3 2/5] of: remove __of_node_dup() allocflags parameter
Date:   Mon, 20 Jun 2022 12:41:20 +0200
Message-Id: <20220620104123.341054-3-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620104123.341054-1-clement.leger@bootlin.com>
References: <20220620104123.341054-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alloclags are always set to GFP_KERNEL so remove this specific flag.
Moreover, this function is going to be based on one that does not
provides passing gfp flags, so be prepared for this.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/of/dynamic.c    |  9 ++++-----
 drivers/of/of_private.h |  2 +-
 drivers/of/overlay.c    |  2 +-
 drivers/of/unittest.c   | 16 ++++++++--------
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index cd3821a6444f..5560e501aedf 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -369,7 +369,6 @@ void of_node_release(struct kobject *kobj)
 /**
  * __of_prop_dup - Copy a property dynamically.
  * @prop:	Property to copy
- * @allocflags:	Allocation flags (typically pass GFP_KERNEL)
  *
  * Copy a property by dynamically allocating the memory of both the
  * property structure and the property name & contents. The property's
@@ -378,11 +377,11 @@ void of_node_release(struct kobject *kobj)
  *
  * Return: The newly allocated property or NULL on out of memory error.
  */
-struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
+struct property *__of_prop_dup(const struct property *prop)
 {
 	struct property *new;
 
-	new = kzalloc(sizeof(*new), allocflags);
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
 	if (!new)
 		return NULL;
 
@@ -392,8 +391,8 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
 	 * of zero bytes. We do this to work around the use
 	 * of of_get_property() calls on boolean values.
 	 */
-	new->name = kstrdup(prop->name, allocflags);
-	new->value = kmemdup(prop->value, prop->length, allocflags);
+	new->name = kstrdup(prop->name, GFP_KERNEL);
+	new->value = kmemdup(prop->value, prop->length, GFP_KERNEL);
 	new->length = prop->length;
 	if (!new->name || !new->value)
 		goto err_free;
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 9324483397f6..e319d8c2bf8b 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -115,7 +115,7 @@ extern void *__unflatten_device_tree(const void *blob,
  * without taking node references, so you either have to
  * own the devtree lock or work on detached trees only.
  */
-struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags);
+struct property *__of_prop_dup(const struct property *prop);
 struct device_node *__of_node_dup(const struct device_node *np,
 				  const char *full_name);
 
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 4044ddcb02c6..9c026bcbf6ab 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -339,7 +339,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 			return -EINVAL;
 		new_prop = dup_and_fixup_symbol_prop(ovcs, overlay_prop);
 	} else {
-		new_prop = __of_prop_dup(overlay_prop, GFP_KERNEL);
+		new_prop = __of_prop_dup(overlay_prop);
 	}
 
 	if (!new_prop)
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 7f6bba18c515..23ccb74ef408 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -772,13 +772,13 @@ static void __init of_unittest_property_copy(void)
 	struct property p2 = { .name = "p2", .length = 5, .value = "abcd" };
 	struct property *new;
 
-	new = __of_prop_dup(&p1, GFP_KERNEL);
+	new = __of_prop_dup(&p1);
 	unittest(new && propcmp(&p1, new), "empty property didn't copy correctly\n");
 	kfree(new->value);
 	kfree(new->name);
 	kfree(new);
 
-	new = __of_prop_dup(&p2, GFP_KERNEL);
+	new = __of_prop_dup(&p2);
 	unittest(new && propcmp(&p2, new), "non-empty property didn't copy correctly\n");
 	kfree(new->value);
 	kfree(new->name);
@@ -811,19 +811,19 @@ static void __init of_unittest_changeset(void)
 	nremove = of_get_child_by_name(nchangeset, "node-remove");
 	unittest(nremove, "testcase setup failure\n");
 
-	ppadd = __of_prop_dup(&padd, GFP_KERNEL);
+	ppadd = __of_prop_dup(&padd);
 	unittest(ppadd, "testcase setup failure\n");
 
-	ppname_n1  = __of_prop_dup(&pname_n1, GFP_KERNEL);
+	ppname_n1  = __of_prop_dup(&pname_n1);
 	unittest(ppname_n1, "testcase setup failure\n");
 
-	ppname_n2  = __of_prop_dup(&pname_n2, GFP_KERNEL);
+	ppname_n2  = __of_prop_dup(&pname_n2);
 	unittest(ppname_n2, "testcase setup failure\n");
 
-	ppname_n21 = __of_prop_dup(&pname_n21, GFP_KERNEL);
+	ppname_n21 = __of_prop_dup(&pname_n21);
 	unittest(ppname_n21, "testcase setup failure\n");
 
-	ppupdate = __of_prop_dup(&pupdate, GFP_KERNEL);
+	ppupdate = __of_prop_dup(&pupdate);
 	unittest(ppupdate, "testcase setup failure\n");
 
 	parent = nchangeset;
@@ -3333,7 +3333,7 @@ static __init void of_unittest_overlay_high_level(void)
 		struct property *new_prop;
 		for_each_property_of_node(overlay_base_symbols, prop) {
 
-			new_prop = __of_prop_dup(prop, GFP_KERNEL);
+			new_prop = __of_prop_dup(prop);
 			if (!new_prop) {
 				unittest(0, "__of_prop_dup() of '%s' from overlay_base node __symbols__",
 					 prop->name);
-- 
2.36.1

