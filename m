Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FD651A456
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352628AbiEDPpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352281AbiEDPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:45:43 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6C018366;
        Wed,  4 May 2022 08:42:06 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8DEA440007;
        Wed,  4 May 2022 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651678924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmqzHg+nLgBRemjIW3lNzV3pSBBaY49ErNMMa/e8tLQ=;
        b=PhUpM53tbZtMWJGrm+4iEQAgfeYhHsOTCGMCt2OtvAbNoqiI7Nu43nuiKw2hxUsl8AKYMF
        BacEpfvIH7dtRAXxUL1PPofJlQlho0tVJEEDt5P5KEA8lDw0b8ZsLHIYjN3zmwJYFwuV3S
        5n6GBecdolsiH871iOevPvakUvAXKEoRzJxY4XiOJ/HSqOp+v+fj+6+WD/i6SEshWhaoio
        Zuns8KG/SBKAkhSVVoSt42XtRRyEhs/Qi9OBsuad/MTSd9ibPuooBLEA+cWpl804bgKF2/
        23GMQrhJTPcz8Way9E/BYiMdnd9mkDgZQBMPtf3HvDOZjLy7UXlgrCNEel81nQ==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/3] of: dynamic: add of_node_alloc() and of_node_free()
Date:   Wed,  4 May 2022 17:40:32 +0200
Message-Id: <20220504154033.750511-3-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220504154033.750511-1-clement.leger@bootlin.com>
References: <20220504154033.750511-1-clement.leger@bootlin.com>
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

Add functions which allows to create and free nodes.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/of/dynamic.c | 59 ++++++++++++++++++++++++++++++++++++--------
 include/linux/of.h   |  9 +++++++
 2 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index e8700e509d2e..ec28e5ba2969 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -455,6 +455,54 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
 				 prop->length, allocflags);
 }
 
+/**
+ * of_node_free - Free a node allocated dynamically.
+ * @node:	Node to be freed
+ */
+void of_node_free(const struct device_node *node)
+{
+	kfree(node->full_name);
+	kfree(node->data);
+	kfree(node);
+}
+EXPORT_SYMBOL(of_node_free);
+
+/**
+ * of_node_alloc - Allocate a node dynamically.
+ * @name:	Node name
+ * @allocflags:	Allocation flags (typically pass GFP_KERNEL)
+ *
+ * Create a node by dynamically allocating the memory of both the
+ * node structure and the node name & contents. The node's
+ * flags have the OF_DYNAMIC & OF_DETACHED bit set so that we can
+ * differentiate between dynamically allocated nodes and not.
+ *
+ * Return: The newly allocated node or NULL on out of memory error.
+ */
+struct device_node *of_node_alloc(const char *name, gfp_t allocflags)
+{
+	struct device_node *node;
+
+	node = kzalloc(sizeof(*node), allocflags);
+	if (!node)
+		return NULL;
+
+	if (name) {
+		node->full_name = kstrdup(name, allocflags);
+		if (!node->full_name) {
+			kfree(node);
+			return NULL;
+		}
+	}
+
+	of_node_set_flag(node, OF_DYNAMIC);
+	of_node_set_flag(node, OF_DETACHED);
+	of_node_init(node);
+
+	return node;
+}
+EXPORT_SYMBOL(of_node_alloc);
+
 /**
  * __of_node_dup() - Duplicate or create an empty device node dynamically.
  * @np:		if not NULL, contains properties to be duplicated in new node
@@ -471,18 +519,9 @@ struct device_node *__of_node_dup(const struct device_node *np,
 {
 	struct device_node *node;
 
-	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	node = of_node_alloc(NULL, GFP_KERNEL);
 	if (!node)
 		return NULL;
-	node->full_name = kstrdup(full_name, GFP_KERNEL);
-	if (!node->full_name) {
-		kfree(node);
-		return NULL;
-	}
-
-	of_node_set_flag(node, OF_DYNAMIC);
-	of_node_set_flag(node, OF_DETACHED);
-	of_node_init(node);
 
 	/* Iterate over and duplicate all properties */
 	if (np) {
diff --git a/include/linux/of.h b/include/linux/of.h
index 6b345eb71c19..749ac07f4960 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1463,6 +1463,8 @@ enum of_reconfig_change {
 };
 
 #ifdef CONFIG_OF_DYNAMIC
+extern struct device_node *of_node_alloc(const char *name, gfp_t allocflags);
+extern void of_node_free(const struct device_node *node);
 extern struct property *of_property_alloc(const char *name, const void *value,
 					  int value_len, int len,
 					  gfp_t allocflags);
@@ -1512,6 +1514,13 @@ static inline int of_changeset_update_property(struct of_changeset *ocs,
 	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
 }
 #else /* CONFIG_OF_DYNAMIC */
+static inline struct device_node *of_node_alloc(const char *name,
+						gfp_t allocflags)
+{
+	return NULL;
+}
+
+static inline void of_node_free(const struct device_node *node) {}
 
 static inline struct property *of_property_alloc(const char *name,
 						 const void *value,
-- 
2.34.1

