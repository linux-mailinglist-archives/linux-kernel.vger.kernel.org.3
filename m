Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3983648D3E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiAMIwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:52:24 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:55213 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiAMIwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:52:20 -0500
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D870E223F6;
        Thu, 13 Jan 2022 09:52:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642063938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5HH92cnxr/GP/X3/R0Qkse9oer6dTHSWGqBRDuZkZT8=;
        b=lItkmULdF8i810LjaBAHr76pKL1LA+CCqWwofu9J1CMl4UP3NKJ13TYfW+QJwCGugONLNo
        uGSllZ5a2LAL8BTRq8VqerQ+wdHqQyly6d1q8rmSSnz2HuHhdf+QFyA+trWII+MvTjjkPQ
        Ynjkp/nfI2nwTbS6Uq3mq+lNDcA+vkI=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 3/3] of: base: add of_parse_phandle_with_optional_args()
Date:   Thu, 13 Jan 2022 09:52:08 +0100
Message-Id: <20220113085208.2636517-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113085208.2636517-1-michael@walle.cc>
References: <20220113085208.2636517-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new variant of the of_parse_phandle_with_args() which treats the
cells name as optional. If it's missing, it is assumed that the phandle
has no arguments.

Up until now, a nvmem node didn't have any arguments, so all the device
trees haven't any '#*-cells' property. But there is a need for an
additional argument for the phandle, for which we need a '#*-cells'
property. Therefore, we need to support nvmem nodes with and without
this property.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 include/linux/of.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index df3af6d3cbe3..f29f18aa95d9 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -521,6 +521,26 @@ static inline int of_parse_phandle_with_fixed_args(const struct device_node *np,
 					    index, out_args);
 }
 
+/**
+ * of_parse_phandle_with_optional_args() - Find a node pointed by phandle in a list
+ *
+ * Same as of_parse_phandle_args() except that if the cells_name property is
+ * not found, cell_count of 0 is assumed.
+ *
+ * This is used to useful, if you have a phandle which didn't have arguments
+ * before and thus doesn't have a '#*-cells' property but is now migrated to
+ * having arguments while retaining backwards compatibility.
+ */
+static inline int of_parse_phandle_with_optional_args(const struct device_node *np,
+						      const char *list_name,
+						      const char *cells_name,
+						      unsigned int index,
+						      struct of_phandle_args *out_args)
+{
+	return __of_parse_phandle_with_args(np, list_name, cells_name,
+					    0, index, out_args);
+}
+
 /**
  * of_property_read_u8_array - Find and read an array of u8 from a property.
  *
@@ -1014,6 +1034,15 @@ static inline int of_parse_phandle_with_fixed_args(const struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_parse_phandle_with_optional_args(const struct device_node *np,
+						      char *list_name,
+						      int cells_count,
+						      unsigned int index,
+						      struct of_phandle_args *out_args)
+{
+	return -ENOSYS;
+}
+
 static inline int of_count_phandle_with_args(const struct device_node *np,
 					     const char *list_name,
 					     const char *cells_name)
-- 
2.30.2

