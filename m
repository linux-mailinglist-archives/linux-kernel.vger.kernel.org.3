Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FFE48D3DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiAMIwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:52:21 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:55335 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiAMIwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:52:19 -0500
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 299AD223EF;
        Thu, 13 Jan 2022 09:52:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642063937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3KRrVKTt6D42W3BweWV1BzObpoKdBoZFlw5c0JXUHSk=;
        b=bO3NCZvKmk9Wwab1nA5UjMGtwtrldgoRgzjvLhmWKeSJluEZRuE8EWiTsVdp2aDIsephCq
        bx2/Di85K5fq7mXmxmn1QixKkgugY/Er0hXCULj88vxeYBPlWZreusNgiqSviRA0n/bs7g
        s6jkGaBcd7VqJH0WQPX7K7thWbYZe50=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
Subject: [PATCH 1/3] of: base: convert index to unsigned for of_parse_phandle()
Date:   Thu, 13 Jan 2022 09:52:06 +0100
Message-Id: <20220113085208.2636517-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113085208.2636517-1-michael@walle.cc>
References: <20220113085208.2636517-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2021bd01ffcc ("of: Remove counting special case from
__of_parse_phandle_with_args()"), the index is >=0, thus convert the
paramenter to unsigned of the of_parse_phandle() and all its variants.
Make the smaller variants static inline, too.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/of/base.c  | 137 +++---------------------------------------
 include/linux/of.h | 147 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 142 insertions(+), 142 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8a24d37153b4..58b1b6ffc105 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1420,14 +1420,15 @@ int of_phandle_iterator_args(struct of_phandle_iterator *it,
 	return count;
 }
 
-static int __of_parse_phandle_with_args(const struct device_node *np,
-					const char *list_name,
-					const char *cells_name,
-					int cell_count, int index,
-					struct of_phandle_args *out_args)
+int __of_parse_phandle_with_args(const struct device_node *np,
+				 const char *list_name,
+				 const char *cells_name,
+				 int cell_count, unsigned int index,
+				 struct of_phandle_args *out_args)
 {
 	struct of_phandle_iterator it;
-	int rc, cur_index = 0;
+	unsigned int cur_index = 0;
+	int rc;
 
 	/* Loop over the phandles until all the requested entry is found */
 	of_for_each_phandle(&it, rc, np, list_name, cells_name, cell_count) {
@@ -1471,82 +1472,7 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 	of_node_put(it.node);
 	return rc;
 }
-
-/**
- * of_parse_phandle - Resolve a phandle property to a device_node pointer
- * @np: Pointer to device node holding phandle property
- * @phandle_name: Name of property holding a phandle value
- * @index: For properties holding a table of phandles, this is the index into
- *         the table
- *
- * Return: The device_node pointer with refcount incremented.  Use
- * of_node_put() on it when done.
- */
-struct device_node *of_parse_phandle(const struct device_node *np,
-				     const char *phandle_name, int index)
-{
-	struct of_phandle_args args;
-
-	if (index < 0)
-		return NULL;
-
-	if (__of_parse_phandle_with_args(np, phandle_name, NULL, 0,
-					 index, &args))
-		return NULL;
-
-	return args.np;
-}
-EXPORT_SYMBOL(of_parse_phandle);
-
-/**
- * of_parse_phandle_with_args() - Find a node pointed by phandle in a list
- * @np:		pointer to a device tree node containing a list
- * @list_name:	property name that contains a list
- * @cells_name:	property name that specifies phandles' arguments count
- * @index:	index of a phandle to parse out
- * @out_args:	optional pointer to output arguments structure (will be filled)
- *
- * This function is useful to parse lists of phandles and their arguments.
- * Returns 0 on success and fills out_args, on error returns appropriate
- * errno value.
- *
- * Caller is responsible to call of_node_put() on the returned out_args->np
- * pointer.
- *
- * Example::
- *
- *  phandle1: node1 {
- *	#list-cells = <2>;
- *  };
- *
- *  phandle2: node2 {
- *	#list-cells = <1>;
- *  };
- *
- *  node3 {
- *	list = <&phandle1 1 2 &phandle2 3>;
- *  };
- *
- * To get a device_node of the ``node2`` node you may call this:
- * of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
- */
-int of_parse_phandle_with_args(const struct device_node *np, const char *list_name,
-				const char *cells_name, int index,
-				struct of_phandle_args *out_args)
-{
-	int cell_count = -1;
-
-	if (index < 0)
-		return -EINVAL;
-
-	/* If cells_name is NULL we assume a cell count of 0 */
-	if (!cells_name)
-		cell_count = 0;
-
-	return __of_parse_phandle_with_args(np, list_name, cells_name,
-					    cell_count, index, out_args);
-}
-EXPORT_SYMBOL(of_parse_phandle_with_args);
+EXPORT_SYMBOL(__of_parse_phandle_with_args);
 
 /**
  * of_parse_phandle_with_args_map() - Find a node pointed by phandle in a list and remap it
@@ -1593,7 +1519,8 @@ EXPORT_SYMBOL(of_parse_phandle_with_args);
 int of_parse_phandle_with_args_map(const struct device_node *np,
 				   const char *list_name,
 				   const char *stem_name,
-				   int index, struct of_phandle_args *out_args)
+				   unsigned int index,
+				   struct of_phandle_args *out_args)
 {
 	char *cells_name, *map_name = NULL, *mask_name = NULL;
 	char *pass_name = NULL;
@@ -1606,9 +1533,6 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 	int i, ret, map_len, match;
 	u32 list_size, new_size;
 
-	if (index < 0)
-		return -EINVAL;
-
 	cells_name = kasprintf(GFP_KERNEL, "#%s-cells", stem_name);
 	if (!cells_name)
 		return -ENOMEM;
@@ -1732,47 +1656,6 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 }
 EXPORT_SYMBOL(of_parse_phandle_with_args_map);
 
-/**
- * of_parse_phandle_with_fixed_args() - Find a node pointed by phandle in a list
- * @np:		pointer to a device tree node containing a list
- * @list_name:	property name that contains a list
- * @cell_count: number of argument cells following the phandle
- * @index:	index of a phandle to parse out
- * @out_args:	optional pointer to output arguments structure (will be filled)
- *
- * This function is useful to parse lists of phandles and their arguments.
- * Returns 0 on success and fills out_args, on error returns appropriate
- * errno value.
- *
- * Caller is responsible to call of_node_put() on the returned out_args->np
- * pointer.
- *
- * Example::
- *
- *  phandle1: node1 {
- *  };
- *
- *  phandle2: node2 {
- *  };
- *
- *  node3 {
- *  	list = <&phandle1 0 2 &phandle2 2 3>;
- *  };
- *
- * To get a device_node of the ``node2`` node you may call this:
- * of_parse_phandle_with_fixed_args(node3, "list", 2, 1, &args);
- */
-int of_parse_phandle_with_fixed_args(const struct device_node *np,
-				const char *list_name, int cell_count,
-				int index, struct of_phandle_args *out_args)
-{
-	if (index < 0)
-		return -EINVAL;
-	return __of_parse_phandle_with_args(np, list_name, NULL, cell_count,
-					   index, out_args);
-}
-EXPORT_SYMBOL(of_parse_phandle_with_fixed_args);
-
 /**
  * of_count_phandle_with_args() - Find the number of phandles references in a property
  * @np:		pointer to a device tree node containing a list
diff --git a/include/linux/of.h b/include/linux/of.h
index ff143a027abc..df3af6d3cbe3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -364,17 +364,11 @@ extern const struct of_device_id *of_match_node(
 	const struct of_device_id *matches, const struct device_node *node);
 extern int of_modalias_node(struct device_node *node, char *modalias, int len);
 extern void of_print_phandle_args(const char *msg, const struct of_phandle_args *args);
-extern struct device_node *of_parse_phandle(const struct device_node *np,
-					    const char *phandle_name,
-					    int index);
-extern int of_parse_phandle_with_args(const struct device_node *np,
-	const char *list_name, const char *cells_name, int index,
-	struct of_phandle_args *out_args);
+extern int __of_parse_phandle_with_args(const struct device_node *np, const
+	char *list_name, const char *cells_name, int cell_count,
+	unsigned int index, struct of_phandle_args *out_args);
 extern int of_parse_phandle_with_args_map(const struct device_node *np,
-	const char *list_name, const char *stem_name, int index,
-	struct of_phandle_args *out_args);
-extern int of_parse_phandle_with_fixed_args(const struct device_node *np,
-	const char *list_name, int cells_count, int index,
+	const char *list_name, const char *stem_name, unsigned int index,
 	struct of_phandle_args *out_args);
 extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
@@ -416,6 +410,117 @@ extern int of_detach_node(struct device_node *);
 
 #define of_match_ptr(_ptr)	(_ptr)
 
+/**
+ * of_parse_phandle - Resolve a phandle property to a device_node pointer
+ * @np: Pointer to device node holding phandle property
+ * @phandle_name: Name of property holding a phandle value
+ * @index: For properties holding a table of phandles, this is the index into
+ *         the table
+ *
+ * Return: The device_node pointer with refcount incremented.  Use
+ * of_node_put() on it when done.
+ */
+static inline struct device_node *of_parse_phandle(const struct device_node *np,
+						   const char *phandle_name,
+						   unsigned int index)
+{
+	struct of_phandle_args args;
+
+	if (__of_parse_phandle_with_args(np, phandle_name, NULL, 0,
+					 index, &args))
+		return NULL;
+
+	return args.np;
+}
+
+/**
+ * of_parse_phandle_with_args() - Find a node pointed by phandle in a list
+ * @np:		pointer to a device tree node containing a list
+ * @list_name:	property name that contains a list
+ * @cells_name:	property name that specifies phandles' arguments count
+ * @index:	index of a phandle to parse out
+ * @out_args:	optional pointer to output arguments structure (will be filled)
+ *
+ * This function is useful to parse lists of phandles and their arguments.
+ * Returns 0 on success and fills out_args, on error returns appropriate
+ * errno value.
+ *
+ * Caller is responsible to call of_node_put() on the returned out_args->np
+ * pointer.
+ *
+ * Example::
+ *
+ *  phandle1: node1 {
+ *	#list-cells = <2>;
+ *  };
+ *
+ *  phandle2: node2 {
+ *	#list-cells = <1>;
+ *  };
+ *
+ *  node3 {
+ *	list = <&phandle1 1 2 &phandle2 3>;
+ *  };
+ *
+ * To get a device_node of the ``node2`` node you may call this:
+ * of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
+ */
+static inline int of_parse_phandle_with_args(const struct device_node *np,
+					     const char *list_name,
+					     const char *cells_name,
+					     unsigned int index,
+					     struct of_phandle_args *out_args)
+{
+	int cell_count = -1;
+
+	/* If cells_name is NULL we assume a cell count of 0 */
+	if (!cells_name)
+		cell_count = 0;
+
+	return __of_parse_phandle_with_args(np, list_name, cells_name,
+					    cell_count, index, out_args);
+}
+
+/**
+ * of_parse_phandle_with_fixed_args() - Find a node pointed by phandle in a list
+ * @np:		pointer to a device tree node containing a list
+ * @list_name:	property name that contains a list
+ * @cell_count: number of argument cells following the phandle
+ * @index:	index of a phandle to parse out
+ * @out_args:	optional pointer to output arguments structure (will be filled)
+ *
+ * This function is useful to parse lists of phandles and their arguments.
+ * Returns 0 on success and fills out_args, on error returns appropriate
+ * errno value.
+ *
+ * Caller is responsible to call of_node_put() on the returned out_args->np
+ * pointer.
+ *
+ * Example::
+ *
+ *  phandle1: node1 {
+ *  };
+ *
+ *  phandle2: node2 {
+ *  };
+ *
+ *  node3 {
+ *	list = <&phandle1 0 2 &phandle2 2 3>;
+ *  };
+ *
+ * To get a device_node of the ``node2`` node you may call this:
+ * of_parse_phandle_with_fixed_args(node3, "list", 2, 1, &args);
+ */
+static inline int of_parse_phandle_with_fixed_args(const struct device_node *np,
+						   const char *list_name,
+						   int cell_count,
+						   unsigned int index,
+						   struct of_phandle_args *out_args)
+{
+	return __of_parse_phandle_with_args(np, list_name, NULL, cell_count,
+					    index, out_args);
+}
+
 /**
  * of_property_read_u8_array - Find and read an array of u8 from a property.
  *
@@ -865,9 +970,19 @@ static inline int of_property_read_string_helper(const struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int __of_parse_phandle_with_args(const struct device_node *np,
+					       const char *list_name,
+					       const char *cells_name,
+					       int cell_count,
+					       unsigned int index,
+					       struct of_phandle_args *out_args)
+{
+	return -ENOSYS;
+};
+
 static inline struct device_node *of_parse_phandle(const struct device_node *np,
 						   const char *phandle_name,
-						   int index)
+						   unsigned int index)
 {
 	return NULL;
 }
@@ -875,7 +990,7 @@ static inline struct device_node *of_parse_phandle(const struct device_node *np,
 static inline int of_parse_phandle_with_args(const struct device_node *np,
 					     const char *list_name,
 					     const char *cells_name,
-					     int index,
+					     unsigned int index,
 					     struct of_phandle_args *out_args)
 {
 	return -ENOSYS;
@@ -884,15 +999,17 @@ static inline int of_parse_phandle_with_args(const struct device_node *np,
 static inline int of_parse_phandle_with_args_map(const struct device_node *np,
 						 const char *list_name,
 						 const char *stem_name,
-						 int index,
+						 unsigned int index,
 						 struct of_phandle_args *out_args)
 {
 	return -ENOSYS;
 }
 
 static inline int of_parse_phandle_with_fixed_args(const struct device_node *np,
-	const char *list_name, int cells_count, int index,
-	struct of_phandle_args *out_args)
+						   const char *list_name,
+						   int cells_count,
+						   unsigned int index,
+						   struct of_phandle_args *out_args)
 {
 	return -ENOSYS;
 }
-- 
2.30.2

