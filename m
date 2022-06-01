Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D0E539F39
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350715AbiFAIUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350609AbiFAITj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:19:39 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43068B09F;
        Wed,  1 Jun 2022 01:19:37 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8D20D240002;
        Wed,  1 Jun 2022 08:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654071575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=66sbXOqLZPVknEYGXiL+IiJFbzYM0L821ycNXoLDan0=;
        b=Dty1dson65ZwfKu28f1/gNdvVy0KqeNkZm1Fw+s7V+a07jxBAsrp5sg2/JtSKYJnYQHldm
        BB04Iwjv8Gb9cSMgCv3fxJhnCOQmSDRew0uDeEgZgv9CzBY9WY6n4sYkjZ5JsT7GU2zZTi
        4QAUy1oieKPTA/1j1jsIe8/iR7PQVmiB6OqyKgtxRsbThlaZy5qHFh5VbCwR6GyAHdIcVU
        zAZK2a5h6RpFxPsfbVZtcwleCvbpzTJKnv8jd8dFmtyo+yfP/ZNpk8TTlS/bD8YYeb614Z
        y5fRHoNjqGGq/f97eqN8HjWEsZxugFxefWGva/fbfpM7zKK3L0U/6tnpHdVzsg==
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
Subject: [PATCH v2 2/4] of: dynamic: add of_property_alloc() and of_property_free()
Date:   Wed,  1 Jun 2022 10:17:59 +0200
Message-Id: <20220601081801.348571-3-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220601081801.348571-1-clement.leger@bootlin.com>
References: <20220601081801.348571-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function which allows to dynamically allocate and free properties.
Use this function internally for all code that used the same logic
(mainly __of_prop_dup()).

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/of/dynamic.c    | 82 ++++++++++++++++++++++++-----------------
 drivers/of/of_private.h | 21 ++++++++++-
 include/linux/of.h      | 14 +++++++
 3 files changed, 82 insertions(+), 35 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index cd3821a6444f..c0dcbea31d28 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -313,9 +313,7 @@ static void property_list_free(struct property *prop_list)
 
 	for (prop = prop_list; prop != NULL; prop = next) {
 		next = prop->next;
-		kfree(prop->name);
-		kfree(prop->value);
-		kfree(prop);
+		of_property_free(prop);
 	}
 }
 
@@ -367,48 +365,66 @@ void of_node_release(struct kobject *kobj)
 }
 
 /**
- * __of_prop_dup - Copy a property dynamically.
- * @prop:	Property to copy
+ * of_property_free - Free a property allocated dynamically.
+ * @prop:	Property to be freed
+ */
+void of_property_free(const struct property *prop)
+{
+	if (!of_property_check_flag(prop, OF_DYNAMIC))
+		return;
+
+	if (prop->value != prop + 1)
+		kfree(prop->value);
+
+	kfree(prop->name);
+	kfree(prop);
+}
+EXPORT_SYMBOL(of_property_free);
+
+/**
+ * of_property_alloc - Allocate a property dynamically.
+ * @name:	Name of the new property
+ * @value:	Value that will be copied into the new property value or NULL
+ *		if only @len allocation is needed.
+ * @len:	Length of new property value and if @value is provided, the
+ * 		length of the value to be copied
  * @allocflags:	Allocation flags (typically pass GFP_KERNEL)
  *
- * Copy a property by dynamically allocating the memory of both the
+ * Create a property by dynamically allocating the memory of both the
  * property structure and the property name & contents. The property's
  * flags have the OF_DYNAMIC bit set so that we can differentiate between
  * dynamically allocated properties and not.
  *
  * Return: The newly allocated property or NULL on out of memory error.
  */
-struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
+struct property *of_property_alloc(const char *name, const void *value,
+				   size_t len, gfp_t allocflags)
 {
-	struct property *new;
+	struct property *prop;
 
-	new = kzalloc(sizeof(*new), allocflags);
-	if (!new)
+	prop = kzalloc(sizeof(*prop) + len, allocflags);
+	if (!prop)
 		return NULL;
 
-	/*
-	 * NOTE: There is no check for zero length value.
-	 * In case of a boolean property, this will allocate a value
-	 * of zero bytes. We do this to work around the use
-	 * of of_get_property() calls on boolean values.
-	 */
-	new->name = kstrdup(prop->name, allocflags);
-	new->value = kmemdup(prop->value, prop->length, allocflags);
-	new->length = prop->length;
-	if (!new->name || !new->value)
-		goto err_free;
-
-	/* mark the property as dynamic */
-	of_property_set_flag(new, OF_DYNAMIC);
-
-	return new;
-
- err_free:
-	kfree(new->name);
-	kfree(new->value);
-	kfree(new);
+	prop->name = kstrdup(name, allocflags);
+	if (!prop->name)
+		goto out_err;
+
+	prop->value = prop + 1;
+	if (value)
+		memcpy(prop->value, value, len);
+
+	prop->length = len;
+	of_property_set_flag(prop, OF_DYNAMIC);
+
+	return prop;
+
+out_err:
+	of_property_free(prop);
+
 	return NULL;
 }
+EXPORT_SYMBOL(of_property_alloc);
 
 /**
  * __of_node_dup() - Duplicate or create an empty device node dynamically.
@@ -447,9 +463,7 @@ struct device_node *__of_node_dup(const struct device_node *np,
 			if (!new_pp)
 				goto err_prop;
 			if (__of_add_property(node, new_pp)) {
-				kfree(new_pp->name);
-				kfree(new_pp->value);
-				kfree(new_pp);
+				of_property_free(new_pp);
 				goto err_prop;
 			}
 		}
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 9324483397f6..1d6459bf705d 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -115,7 +115,26 @@ extern void *__unflatten_device_tree(const void *blob,
  * without taking node references, so you either have to
  * own the devtree lock or work on detached trees only.
  */
-struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags);
+
+/**
+ * __of_prop_dup - Copy a property dynamically.
+ * @prop:	Property to copy
+ * @allocflags:	Allocation flags (typically pass GFP_KERNEL)
+ *
+ * Copy a property by dynamically allocating the memory of both the
+ * property structure and the property name & contents. The property's
+ * flags have the OF_DYNAMIC bit set so that we can differentiate between
+ * dynamically allocated properties and not.
+ *
+ * Return: The newly allocated property or NULL on out of memory error.
+ */
+static inline
+struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
+{
+	return of_property_alloc(prop->name, prop->value, prop->length,
+				 allocflags);
+}
+
 struct device_node *__of_node_dup(const struct device_node *np,
 				  const char *full_name);
 
diff --git a/include/linux/of.h b/include/linux/of.h
index d74fd82a6963..f1966f3c3847 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1464,6 +1464,10 @@ enum of_reconfig_change {
 };
 
 #ifdef CONFIG_OF_DYNAMIC
+struct property *of_property_alloc(const char *name, const void *value,
+				   size_t len, gfp_t allocflags);
+void of_property_free(const struct property *prop);
+
 extern int of_reconfig_notifier_register(struct notifier_block *);
 extern int of_reconfig_notifier_unregister(struct notifier_block *);
 extern int of_reconfig_notify(unsigned long, struct of_reconfig_data *rd);
@@ -1508,6 +1512,16 @@ static inline int of_changeset_update_property(struct of_changeset *ocs,
 	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
 }
 #else /* CONFIG_OF_DYNAMIC */
+
+static inline
+struct property *of_property_alloc(const char *name, const void *value,
+				   size_t len, gfp_t allocflags)
+{
+	return NULL;
+}
+
+static inline  void of_property_free(const struct property *prop) {}
+
 static inline int of_reconfig_notifier_register(struct notifier_block *nb)
 {
 	return -EINVAL;
-- 
2.36.0

