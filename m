Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BB148E9AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241038AbiANMHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:07:47 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:39491 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbiANMHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:07:37 -0500
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AC3C2223F6;
        Fri, 14 Jan 2022 13:07:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642162055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DiFyt7qSH30Crpdakxre6pLCJToQcT5gP6X1yyGIa0=;
        b=Gd7XLtbxEoTR5mMC0s9Ypoelbdk81FMJOcwMupf0zDe1njCnm5nEBtfDDahVxJy6XVZkCY
        VOET621b/pUf32oJCY+bJPykMS4+04+B6MSPANggrtS7YGJp8BWFfWCyFNfPPzA+88ZYru
        dAlAAvpO88bIYKoCIIzTRMblSNd8V9U=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 5/5] of: property: use unsigned index for of_link_property()
Date:   Fri, 14 Jan 2022 13:07:23 +0100
Message-Id: <20220114120723.326268-6-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220114120723.326268-1-michael@walle.cc>
References: <20220114120723.326268-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that of_parse_handle() and its variants take an unsigned int,
convert the index used in of_link_property() and its called functions
to unsigned too.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - none

 drivers/of/property.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 8e90071de6ed..e77fb6cda0b7 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1173,7 +1173,8 @@ static int of_link_to_phandle(struct device_node *con_np,
  * - NULL if no phandle found at index
  */
 static struct device_node *parse_prop_cells(struct device_node *np,
-					    const char *prop_name, int index,
+					    const char *prop_name,
+					    unsigned int index,
 					    const char *list_name,
 					    const char *cells_name)
 {
@@ -1191,7 +1192,8 @@ static struct device_node *parse_prop_cells(struct device_node *np,
 
 #define DEFINE_SIMPLE_PROP(fname, name, cells)				  \
 static struct device_node *parse_##fname(struct device_node *np,	  \
-					const char *prop_name, int index) \
+					 const char *prop_name,		  \
+					 unsigned int index)		  \
 {									  \
 	return parse_prop_cells(np, prop_name, index, name, cells);	  \
 }
@@ -1227,7 +1229,8 @@ static int strcmp_suffix(const char *str, const char *suffix)
  * - NULL if no phandle found at index
  */
 static struct device_node *parse_suffix_prop_cells(struct device_node *np,
-					    const char *prop_name, int index,
+					    const char *prop_name,
+					    unsigned int index,
 					    const char *suffix,
 					    const char *cells_name)
 {
@@ -1245,7 +1248,8 @@ static struct device_node *parse_suffix_prop_cells(struct device_node *np,
 
 #define DEFINE_SUFFIX_PROP(fname, suffix, cells)			     \
 static struct device_node *parse_##fname(struct device_node *np,	     \
-					const char *prop_name, int index)    \
+					 const char *prop_name,		     \
+					 unsigned int index)		     \
 {									     \
 	return parse_suffix_prop_cells(np, prop_name, index, suffix, cells); \
 }
@@ -1272,7 +1276,8 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
  */
 struct supplier_bindings {
 	struct device_node *(*parse_prop)(struct device_node *np,
-					  const char *prop_name, int index);
+					  const char *prop_name,
+					  unsigned int index);
 	bool optional;
 	bool node_not_dev;
 };
@@ -1308,7 +1313,8 @@ DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
 static struct device_node *parse_gpios(struct device_node *np,
-				       const char *prop_name, int index)
+				       const char *prop_name,
+				       unsigned int index)
 {
 	if (!strcmp_suffix(prop_name, ",nr-gpios"))
 		return NULL;
@@ -1318,7 +1324,8 @@ static struct device_node *parse_gpios(struct device_node *np,
 }
 
 static struct device_node *parse_iommu_maps(struct device_node *np,
-					    const char *prop_name, int index)
+					    const char *prop_name,
+					    unsigned int index)
 {
 	if (strcmp(prop_name, "iommu-map"))
 		return NULL;
@@ -1327,7 +1334,8 @@ static struct device_node *parse_iommu_maps(struct device_node *np,
 }
 
 static struct device_node *parse_gpio_compat(struct device_node *np,
-					     const char *prop_name, int index)
+					     const char *prop_name,
+					     unsigned int index)
 {
 	struct of_phandle_args sup_args;
 
@@ -1349,7 +1357,8 @@ static struct device_node *parse_gpio_compat(struct device_node *np,
 }
 
 static struct device_node *parse_interrupts(struct device_node *np,
-					    const char *prop_name, int index)
+					    const char *prop_name,
+					    unsigned int index)
 {
 	struct of_phandle_args sup_args;
 
-- 
2.30.2

