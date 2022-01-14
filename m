Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCFF48E9A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbiANMHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:07:38 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:34779 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbiANMHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:07:36 -0500
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6DB61223EA;
        Fri, 14 Jan 2022 13:07:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642162053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hOYQ3Rhr2OJYMy8JRGOPffsFIddkEAEwEQPXzbBTth8=;
        b=MAG7j01uP+SvhBcluitb4MmuOaTFi6WWovqpT3F4bEywpxvufi8/ZpIfa9MDChtwSYMNlE
        bIzu/8TRV4qdzvvebXTHn3sxxo94R908Iw8SIFBJ3fet9VyhG1mmS8ydeJ20NquyP6m6BD
        x7t/+vBX1N9J1v81pe7NnkTsM9Xent8=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/5] of: base: convert index to unsigned for of_parse_phandle()
Date:   Fri, 14 Jan 2022 13:07:19 +0100
Message-Id: <20220114120723.326268-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220114120723.326268-1-michael@walle.cc>
References: <20220114120723.326268-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2021bd01ffcc ("of: Remove counting special case from
__of_parse_phandle_with_args()"), the index is >=0, thus convert the
parameter to unsigned of the of_parse_phandle() and all its variants.
This allows us to drop the check for negative index values.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - just change the index to unsigned int, the static inline change
   is now an own patch

 drivers/of/base.c  | 27 ++++++++++-----------------
 include/linux/of.h | 16 ++++++++--------
 2 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8a24d37153b4..704d6353ac3f 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1423,11 +1423,12 @@ int of_phandle_iterator_args(struct of_phandle_iterator *it,
 static int __of_parse_phandle_with_args(const struct device_node *np,
 					const char *list_name,
 					const char *cells_name,
-					int cell_count, int index,
+					int cell_count, unsigned int index,
 					struct of_phandle_args *out_args)
 {
 	struct of_phandle_iterator it;
-	int rc, cur_index = 0;
+	unsigned int cur_index = 0;
+	int rc;
 
 	/* Loop over the phandles until all the requested entry is found */
 	of_for_each_phandle(&it, rc, np, list_name, cells_name, cell_count) {
@@ -1483,13 +1484,11 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
  * of_node_put() on it when done.
  */
 struct device_node *of_parse_phandle(const struct device_node *np,
-				     const char *phandle_name, int index)
+				     const char *phandle_name,
+				     unsigned int index)
 {
 	struct of_phandle_args args;
 
-	if (index < 0)
-		return NULL;
-
 	if (__of_parse_phandle_with_args(np, phandle_name, NULL, 0,
 					 index, &args))
 		return NULL;
@@ -1531,14 +1530,11 @@ EXPORT_SYMBOL(of_parse_phandle);
  * of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
  */
 int of_parse_phandle_with_args(const struct device_node *np, const char *list_name,
-				const char *cells_name, int index,
+				const char *cells_name, unsigned int index,
 				struct of_phandle_args *out_args)
 {
 	int cell_count = -1;
 
-	if (index < 0)
-		return -EINVAL;
-
 	/* If cells_name is NULL we assume a cell count of 0 */
 	if (!cells_name)
 		cell_count = 0;
@@ -1593,7 +1589,8 @@ EXPORT_SYMBOL(of_parse_phandle_with_args);
 int of_parse_phandle_with_args_map(const struct device_node *np,
 				   const char *list_name,
 				   const char *stem_name,
-				   int index, struct of_phandle_args *out_args)
+				   unsigned int index,
+				   struct of_phandle_args *out_args)
 {
 	char *cells_name, *map_name = NULL, *mask_name = NULL;
 	char *pass_name = NULL;
@@ -1606,9 +1603,6 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 	int i, ret, map_len, match;
 	u32 list_size, new_size;
 
-	if (index < 0)
-		return -EINVAL;
-
 	cells_name = kasprintf(GFP_KERNEL, "#%s-cells", stem_name);
 	if (!cells_name)
 		return -ENOMEM;
@@ -1764,10 +1758,9 @@ EXPORT_SYMBOL(of_parse_phandle_with_args_map);
  */
 int of_parse_phandle_with_fixed_args(const struct device_node *np,
 				const char *list_name, int cell_count,
-				int index, struct of_phandle_args *out_args)
+				unsigned int index,
+				struct of_phandle_args *out_args)
 {
-	if (index < 0)
-		return -EINVAL;
 	return __of_parse_phandle_with_args(np, list_name, NULL, cell_count,
 					   index, out_args);
 }
diff --git a/include/linux/of.h b/include/linux/of.h
index ff143a027abc..36ddb4aac722 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -366,15 +366,15 @@ extern int of_modalias_node(struct device_node *node, char *modalias, int len);
 extern void of_print_phandle_args(const char *msg, const struct of_phandle_args *args);
 extern struct device_node *of_parse_phandle(const struct device_node *np,
 					    const char *phandle_name,
-					    int index);
+					    unsigned int index);
 extern int of_parse_phandle_with_args(const struct device_node *np,
-	const char *list_name, const char *cells_name, int index,
+	const char *list_name, const char *cells_name, unsigned int index,
 	struct of_phandle_args *out_args);
 extern int of_parse_phandle_with_args_map(const struct device_node *np,
-	const char *list_name, const char *stem_name, int index,
+	const char *list_name, const char *stem_name, unsigned int index,
 	struct of_phandle_args *out_args);
 extern int of_parse_phandle_with_fixed_args(const struct device_node *np,
-	const char *list_name, int cells_count, int index,
+	const char *list_name, int cells_count, unsigned int index,
 	struct of_phandle_args *out_args);
 extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
@@ -867,7 +867,7 @@ static inline int of_property_read_string_helper(const struct device_node *np,
 
 static inline struct device_node *of_parse_phandle(const struct device_node *np,
 						   const char *phandle_name,
-						   int index)
+						   unsigned int index)
 {
 	return NULL;
 }
@@ -875,7 +875,7 @@ static inline struct device_node *of_parse_phandle(const struct device_node *np,
 static inline int of_parse_phandle_with_args(const struct device_node *np,
 					     const char *list_name,
 					     const char *cells_name,
-					     int index,
+					     unsigned int index,
 					     struct of_phandle_args *out_args)
 {
 	return -ENOSYS;
@@ -884,14 +884,14 @@ static inline int of_parse_phandle_with_args(const struct device_node *np,
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
+	const char *list_name, int cells_count, unsigned int index,
 	struct of_phandle_args *out_args)
 {
 	return -ENOSYS;
-- 
2.30.2

