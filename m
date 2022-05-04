Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBC551A457
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352643AbiEDPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352614AbiEDPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:45:45 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E801BE86;
        Wed,  4 May 2022 08:42:07 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 092EC40003;
        Wed,  4 May 2022 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651678926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syVh6bmaMn5ntdtGN7GpyAnxiKbIllExQJN9dKGkNJ0=;
        b=c6C+7W6XFAo/WW8FtCv6SSTsY/cs+sDCqpqwwTuow7Lz0ga7x4bSWSHJOLdnPyiHyfHhDI
        vOeXRsUNeXFEJTswTiSC+HliR3Y0CF/L6v0eqC1vT9WlWO61Vq2+4T4xvK4oUaRhrgysqw
        nrO/ooCzJJvXJzZr+/vF3Dpwfa9cUmTeJWqLBL1ydy6/qNM8u6IqQPyEAeDkk7LQvKfF5I
        wX9BNb9qbwfUSDvBpVg+S90rtW5Y2N75WrIsr4fF0wKBGYlfxNJqzbgL0HLZdM9CtB5RSA
        PuclVajdpob5X8Yg/J/Wc+M3clTTtw/WpRde9qzfG9MDLG1Dm4m82/0hNrPI7g==
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
Subject: [PATCH 3/3] powerpc/pseries: use of_property_*() and of_node_*() functions
Date:   Wed,  4 May 2022 17:40:33 +0200
Message-Id: <20220504154033.750511-4-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220504154033.750511-1-clement.leger@bootlin.com>
References: <20220504154033.750511-1-clement.leger@bootlin.com>
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

Use of_property_alloc/free() and of_node_alloc/free() to create and free
device-tree nodes and properties.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 arch/powerpc/platforms/pseries/dlpar.c        | 51 +++----------------
 .../platforms/pseries/hotplug-memory.c        | 27 +---------
 arch/powerpc/platforms/pseries/reconfig.c     | 44 ++++------------
 3 files changed, 20 insertions(+), 102 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index b1f01ac0c29e..ebecde6c7256 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -39,61 +39,25 @@ struct cc_workarea {
 	__be32	prop_offset;
 };
 
-void dlpar_free_cc_property(struct property *prop)
-{
-	kfree(prop->name);
-	kfree(prop->value);
-	kfree(prop);
-}
-
 static struct property *dlpar_parse_cc_property(struct cc_workarea *ccwa)
 {
-	struct property *prop;
-	char *name;
-	char *value;
-
-	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
-	if (!prop)
-		return NULL;
+	int length;
+	char *name, *value;
 
 	name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
-	prop->name = kstrdup(name, GFP_KERNEL);
-	if (!prop->name) {
-		dlpar_free_cc_property(prop);
-		return NULL;
-	}
-
-	prop->length = be32_to_cpu(ccwa->prop_length);
+	length = be32_to_cpu(ccwa->prop_length);
 	value = (char *)ccwa + be32_to_cpu(ccwa->prop_offset);
-	prop->value = kmemdup(value, prop->length, GFP_KERNEL);
-	if (!prop->value) {
-		dlpar_free_cc_property(prop);
-		return NULL;
-	}
 
-	return prop;
+	return of_property_alloc(name, value, length, length, GFP_KERNEL);
 }
 
 static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa)
 {
-	struct device_node *dn;
 	const char *name;
 
-	dn = kzalloc(sizeof(*dn), GFP_KERNEL);
-	if (!dn)
-		return NULL;
-
 	name = (const char *)ccwa + be32_to_cpu(ccwa->name_offset);
-	dn->full_name = kstrdup(name, GFP_KERNEL);
-	if (!dn->full_name) {
-		kfree(dn);
-		return NULL;
-	}
-
-	of_node_set_flag(dn, OF_DYNAMIC);
-	of_node_init(dn);
 
-	return dn;
+	return of_node_alloc(name, GFP_KERNEL);
 }
 
 static void dlpar_free_one_cc_node(struct device_node *dn)
@@ -103,11 +67,10 @@ static void dlpar_free_one_cc_node(struct device_node *dn)
 	while (dn->properties) {
 		prop = dn->properties;
 		dn->properties = prop->next;
-		dlpar_free_cc_property(prop);
+		of_property_free(prop);
 	}
 
-	kfree(dn->full_name);
-	kfree(dn);
+	of_node_free(dn);
 }
 
 void dlpar_free_cc_nodes(struct device_node *dn)
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 91cf23495ccb..591727b05f36 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -70,34 +70,11 @@ unsigned long pseries_memory_block_size(void)
 	return memblock_size;
 }
 
-static void dlpar_free_property(struct property *prop)
-{
-	kfree(prop->name);
-	kfree(prop->value);
-	kfree(prop);
-}
-
 static struct property *dlpar_clone_property(struct property *prop,
 					     u32 prop_size)
 {
-	struct property *new_prop;
-
-	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
-	if (!new_prop)
-		return NULL;
-
-	new_prop->name = kstrdup(prop->name, GFP_KERNEL);
-	new_prop->value = kzalloc(prop_size, GFP_KERNEL);
-	if (!new_prop->name || !new_prop->value) {
-		dlpar_free_property(new_prop);
-		return NULL;
-	}
-
-	memcpy(new_prop->value, prop->value, prop->length);
-	new_prop->length = prop_size;
-
-	of_property_set_flag(new_prop, OF_DYNAMIC);
-	return new_prop;
+	return of_property_alloc(prop->name, prop->value, prop->length,
+				 prop_size, GFP_KERNEL);
 }
 
 static bool find_aa_index(struct device_node *dr_node,
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 7f7369fec46b..08c2f9088537 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -25,17 +25,9 @@ static int pSeries_reconfig_add_node(const char *path, struct property *proplist
 	struct device_node *np;
 	int err = -ENOMEM;
 
-	np = kzalloc(sizeof(*np), GFP_KERNEL);
+	np = of_node_alloc(kbasename(path), GFP_KERNEL);
 	if (!np)
-		goto out_err;
-
-	np->full_name = kstrdup(kbasename(path), GFP_KERNEL);
-	if (!np->full_name)
-		goto out_err;
-
-	np->properties = proplist;
-	of_node_set_flag(np, OF_DYNAMIC);
-	of_node_init(np);
+		return -ENOMEM;
 
 	np->parent = pseries_of_derive_parent(path);
 	if (IS_ERR(np->parent)) {
@@ -56,8 +48,7 @@ static int pSeries_reconfig_add_node(const char *path, struct property *proplist
 out_err:
 	if (np) {
 		of_node_put(np->parent);
-		kfree(np->full_name);
-		kfree(np);
+		of_node_free(np);
 	}
 	return err;
 }
@@ -92,9 +83,7 @@ static void release_prop_list(const struct property *prop)
 	struct property *next;
 	for (; prop; prop = next) {
 		next = prop->next;
-		kfree(prop->name);
-		kfree(prop->value);
-		kfree(prop);
+		of_property_free(prop);
 	}
 
 }
@@ -168,27 +157,16 @@ static char * parse_next_property(char *buf, char *end, char **name, int *length
 static struct property *new_property(const char *name, const int length,
 				     const unsigned char *value, struct property *last)
 {
-	struct property *new = kzalloc(sizeof(*new), GFP_KERNEL);
+	struct property *prop;
 
-	if (!new)
+	prop = of_property_alloc(name, value, length, length + 1, GFP_KERNEL);
+	if (!prop)
 		return NULL;
 
-	if (!(new->name = kstrdup(name, GFP_KERNEL)))
-		goto cleanup;
-	if (!(new->value = kmalloc(length + 1, GFP_KERNEL)))
-		goto cleanup;
-
-	memcpy(new->value, value, length);
-	*(((char *)new->value) + length) = 0;
-	new->length = length;
-	new->next = last;
-	return new;
-
-cleanup:
-	kfree(new->name);
-	kfree(new->value);
-	kfree(new);
-	return NULL;
+	*(((char *)prop->value) + length) = 0;
+	prop->next = last;
+
+	return prop;
 }
 
 static int do_add_node(char *buf, size_t bufsize)
-- 
2.34.1

