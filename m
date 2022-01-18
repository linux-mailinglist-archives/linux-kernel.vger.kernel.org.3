Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA660492C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347411AbiARRfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:35:17 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:43689 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiARRfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:35:14 -0500
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 79F94223EF;
        Tue, 18 Jan 2022 18:35:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642527312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7F+whQiSepttEHv2BNHtcV2bSaZxu0JkgufwCRr8Ew=;
        b=K8M10zNns5eMwEZamZslUzCAmJOzg21LOD+LDLUGV7Zfha+mENeV+IGC5P37Q3mTtD8cOn
        JLbgtj/AspWx5nZAPK4w0snbt7vs3/6zctNNEtIiFBqVBxBeUSOL2EpgpIza+4l5NdSAU1
        iESvP570wGJ3NYnArwheIoOJ6nrKJco=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] of: base: make small of_parse_phandle() variants static inline
Date:   Tue, 18 Jan 2022 18:35:02 +0100
Message-Id: <20220118173504.2867523-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220118173504.2867523-1-michael@walle.cc>
References: <20220118173504.2867523-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make all the smaller variants of the of_parse_phandle() static inline.
This also let us remove the empty function stubs if CONFIG_OF is not
defined.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v3:
 - rebased due to now signed index parameter

changes since v2:
 - new patch

 drivers/of/base.c  | 128 ++----------------------------------
 include/linux/of.h | 157 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 135 insertions(+), 150 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8a24d37153b4..b108600b8296 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1420,11 +1420,11 @@ int of_phandle_iterator_args(struct of_phandle_iterator *it,
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
+				 int cell_count, int index,
+				 struct of_phandle_args *out_args)
 {
 	struct of_phandle_iterator it;
 	int rc, cur_index = 0;
@@ -1471,82 +1471,7 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
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
@@ -1732,47 +1657,6 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
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
index ff143a027abc..9106eced1ee1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -364,18 +364,12 @@ extern const struct of_device_id *of_match_node(
 	const struct of_device_id *matches, const struct device_node *node);
 extern int of_modalias_node(struct device_node *node, char *modalias, int len);
 extern void of_print_phandle_args(const char *msg, const struct of_phandle_args *args);
-extern struct device_node *of_parse_phandle(const struct device_node *np,
-					    const char *phandle_name,
-					    int index);
-extern int of_parse_phandle_with_args(const struct device_node *np,
-	const char *list_name, const char *cells_name, int index,
-	struct of_phandle_args *out_args);
+extern int __of_parse_phandle_with_args(const struct device_node *np,
+	const char *list_name, const char *cells_name, int cell_count,
+	int index, struct of_phandle_args *out_args);
 extern int of_parse_phandle_with_args_map(const struct device_node *np,
 	const char *list_name, const char *stem_name, int index,
 	struct of_phandle_args *out_args);
-extern int of_parse_phandle_with_fixed_args(const struct device_node *np,
-	const char *list_name, int cells_count, int index,
-	struct of_phandle_args *out_args);
 extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
 
@@ -865,18 +859,12 @@ static inline int of_property_read_string_helper(const struct device_node *np,
 	return -ENOSYS;
 }
 
-static inline struct device_node *of_parse_phandle(const struct device_node *np,
-						   const char *phandle_name,
-						   int index)
-{
-	return NULL;
-}
-
-static inline int of_parse_phandle_with_args(const struct device_node *np,
-					     const char *list_name,
-					     const char *cells_name,
-					     int index,
-					     struct of_phandle_args *out_args)
+static inline int __of_parse_phandle_with_args(const struct device_node *np,
+					       const char *list_name,
+					       const char *cells_name,
+					       int cell_count,
+					       int index,
+					       struct of_phandle_args *out_args)
 {
 	return -ENOSYS;
 }
@@ -890,13 +878,6 @@ static inline int of_parse_phandle_with_args_map(const struct device_node *np,
 	return -ENOSYS;
 }
 
-static inline int of_parse_phandle_with_fixed_args(const struct device_node *np,
-	const char *list_name, int cells_count, int index,
-	struct of_phandle_args *out_args)
-{
-	return -ENOSYS;
-}
-
 static inline int of_count_phandle_with_args(const struct device_node *np,
 					     const char *list_name,
 					     const char *cells_name)
@@ -1077,6 +1058,126 @@ static inline bool of_node_is_type(const struct device_node *np, const char *typ
 	return np && match && type && !strcmp(match, type);
 }
 
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
+						   int index)
+{
+	struct of_phandle_args args;
+
+	if (index < 0)
+		return NULL;
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
+					     int index,
+					     struct of_phandle_args *out_args)
+{
+	int cell_count = -1;
+
+	if (index < 0)
+		return -EINVAL;
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
+						   int index,
+						   struct of_phandle_args *out_args)
+{
+	if (index < 0)
+		return -EINVAL;
+
+	return __of_parse_phandle_with_args(np, list_name, NULL, cell_count,
+					    index, out_args);
+}
+
 /**
  * of_property_count_u8_elems - Count the number of u8 elements in a property
  *
-- 
2.30.2

