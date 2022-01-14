Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BF248E9AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbiANMHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:07:41 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:33457 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiANMHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:07:36 -0500
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EF913223EF;
        Fri, 14 Jan 2022 13:07:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642162055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n29N5TazNBBIgYElLvDg4ajl+I4aHtwUnHtY1WueoUM=;
        b=UkME7kuqVtQyv8YXjSeO9a0oqwLD/psWmawS/qKCx+ZZN8wnxKWxNL9StkKkPXe1ww6Xm+
        rYkmzpy/FedAnYor0moaNu1fwYo556A6DTXGcfNT1M2PcCRJj10mCG2hED1tRWbfQFm8R7
        DeUrjFiuP2U0GLSewCdoEWd/3IP27cc=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 3/5] of: base: add of_parse_phandle_with_optional_args()
Date:   Fri, 14 Jan 2022 13:07:21 +0100
Message-Id: <20220114120723.326268-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220114120723.326268-1-michael@walle.cc>
References: <20220114120723.326268-1-michael@walle.cc>
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
changes since v1:
 - drop unnecessary empty stub if CONFIG_OF is not set

 include/linux/of.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 279f8d190338..1044d818e144 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1169,6 +1169,26 @@ static inline int of_parse_phandle_with_fixed_args(const struct device_node *np,
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
  * of_property_count_u8_elems - Count the number of u8 elements in a property
  *
-- 
2.30.2

