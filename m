Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206BF4CC904
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiCCWc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbiCCWct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:32:49 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8C513858E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:32:02 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso7431568ooi.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXj+JJPwfsy1TPTyievdzxMaMQ1HgahsIy1fHCecuJ8=;
        b=s5oo+ymjcJWqfAiP1BwjR3idcGDdOwaFb2X8H+Z/c3G5sY1UtDiv3Fv7vjncR7nFMO
         wA8UYS+eLiiZUeb9Rrgal3IJ+vrQnXJmt3tiaP67Qu+bpO+I1pKc9eYWPE82v9mAuy0a
         zf0JzaDYQVuA41giUxuz7reKLPok3cCf431Pr/tlhu8wiiki7ajXlfmw9DWYkqIP9KPA
         MexWfe2ty+nGrQ/qkN0EQ00ztZard0NnaFwi6x9CO5pb5xycrzQoIxbN5A4zHkhBQrm+
         vSeWTJEqXUe38QHMrC0SrFuUr9O+0Ik1aqwc8yImJ4BdGByk5nVux5cKyLQ/gTzC2JRh
         J2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXj+JJPwfsy1TPTyievdzxMaMQ1HgahsIy1fHCecuJ8=;
        b=P7ChTsqf/WI328odS89B5qvYZbTJJe/Ts1kPG5UOBIBZ659ICKmaZoboCgpz4aINj8
         Z9z/rJpApI2hK/kSnVPWjFnnXLfVF9elEfXgIsDUd7a8uxG7wWl6yNBRv0X1lEXbXRts
         W4oOQ/Q57eM1DNmEsYtZYVNpuNQUxr5h+JoOeVrx3aZjMjiHgVDL6/eFDhIvGB7aw5Gh
         FHvDteRK92c8lPegFQYAS8uhG2d6Nz0KscVvafVXOaRFjNIUwDRIMslB9R3t3HElTtuX
         h5o52qPhITh81pNjGAtrve5bt4ZVbAGGzNB2RwFlzM08ixxGzZr/BTIB+X2+Tk+868Pe
         44EQ==
X-Gm-Message-State: AOAM530mlQB8iChKUT2+G3rJIcGg5SgZYMk5JdxOzxnj34F4NhO8H0+V
        b/gH8M2u1ikKXMkUpkLlYRbS4A==
X-Google-Smtp-Source: ABdhPJzkhWKivVU8Vch0wuh08xQA/XMkkCLJf277FgVKCZMd2uuRFKuuha1IbHcDRlai/7h6StF3NQ==
X-Received: by 2002:a4a:d21b:0:b0:2e2:113:db90 with SMTP id c27-20020a4ad21b000000b002e20113db90mr19603967oos.50.1646346721308;
        Thu, 03 Mar 2022 14:32:01 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id fq14-20020a0568710b0e00b000d4492531a2sm1764777oab.17.2022.03.03.14.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:32:00 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 1/6] device property: Helper to match multiple connections
Date:   Thu,  3 Mar 2022 14:33:46 -0800
Message-Id: <20220303223351.141238-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases multiple connections with the same connection id
needs to be resolved from a fwnode graph.

One such example is when separate hardware is used for performing muxing
and/or orientation switching of the SuperSpeed and SBU lines in a USB
Type-C connector. In this case the connector needs to belong to a graph
with multiple matching remote endpoints, and the Type-C controller needs
to be able to resolve them both.

Add a new API that allows this kind of lookup.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Allow the caller of the new api to pass a matches of NULL, to count possible
  matches. I previously argued that this will cause memory leaks, but Andy
  pointed out that this depends on the caller and the match function.
- Fixed spelling mistakes in commit message and kernel-doc.
- Use two "count" variables to make the math clearer.

Changes since v1:
- Iterator in fwnode_devcon_matches() is now unsigned.
- fwnode_handle_put() node for unavailable nodes.
- Extended commit message on the subject of supporting dynamically sized
  "matches" array.

 drivers/base/property.c  | 107 +++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |   5 ++
 2 files changed, 112 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c0e94cce9c29..5cda205136f6 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1218,6 +1218,40 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 	return NULL;
 }
 
+static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
+						const char *con_id, void *data,
+						devcon_match_fn_t match,
+						void **matches,
+						unsigned int matches_len)
+{
+	struct fwnode_handle *node;
+	struct fwnode_handle *ep;
+	unsigned int count = 0;
+	void *ret;
+
+	fwnode_graph_for_each_endpoint(fwnode, ep) {
+		if (count >= matches_len && matches) {
+			fwnode_handle_put(ep);
+			return count;
+		}
+
+		node = fwnode_graph_get_remote_port_parent(ep);
+		if (!fwnode_device_is_available(node)) {
+			fwnode_handle_put(node);
+			continue;
+		}
+
+		ret = match(node, con_id, data);
+		fwnode_handle_put(node);
+		if (ret) {
+			if (matches)
+				matches[count] = ret;
+			count++;
+		}
+	}
+	return count;
+}
+
 static void *
 fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 		    void *data, devcon_match_fn_t match)
@@ -1240,6 +1274,37 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 	return NULL;
 }
 
+static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
+					  const char *con_id, void *data,
+					  devcon_match_fn_t match,
+					  void **matches,
+					  unsigned int matches_len)
+{
+	struct fwnode_handle *node;
+	unsigned int count = 0;
+	unsigned int i;
+	void *ret;
+
+	for (i = 0; ; i++) {
+		if (count >= matches_len && matches)
+			return count;
+
+		node = fwnode_find_reference(fwnode, con_id, i);
+		if (IS_ERR(node))
+			break;
+
+		ret = match(node, NULL, data);
+		fwnode_handle_put(node);
+		if (ret) {
+			if (matches)
+				matches[count] = ret;
+			count++;
+		}
+	}
+
+	return count;
+}
+
 /**
  * fwnode_connection_find_match - Find connection from a device node
  * @fwnode: Device node with the connection
@@ -1267,3 +1332,45 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
 	return fwnode_devcon_match(fwnode, con_id, data, match);
 }
 EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
+
+/**
+ * fwnode_connection_find_matches - Find connections from a device node
+ * @fwnode: Device node with the connection
+ * @con_id: Identifier for the connection
+ * @data: Data for the match function
+ * @match: Function to check and convert the connection description
+ * @matches: Array of pointers to fill with matches
+ * @matches_len: Length of @matches
+ *
+ * Find up to @matches_len connections with unique identifier @con_id between
+ * @fwnode and other device nodes. @match will be used to convert the
+ * connection description to data the caller is expecting to be returned
+ * through the @matches array.
+ * If @matches is NULL @matches_len is ignored and the total number of resolved
+ * matches is returned.
+ *
+ * Return: Number of matches resolved, or negative errno.
+ */
+int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
+				   const char *con_id, void *data,
+				   devcon_match_fn_t match,
+				   void **matches, unsigned int matches_len)
+{
+	unsigned int count_graph;
+	unsigned int count_ref;
+
+	if (!fwnode || !match)
+		return -EINVAL;
+
+	count_graph = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
+						  matches, matches_len);
+
+	matches += count_graph;
+	matches_len -= count_graph;
+
+	count_ref = fwnode_devcon_matches(fwnode, con_id, data, match,
+					  matches, matches_len);
+
+	return count_graph + count_ref;
+}
+EXPORT_SYMBOL_GPL(fwnode_connection_find_matches);
diff --git a/include/linux/property.h b/include/linux/property.h
index 4cd4b326941f..de7ff336d2c8 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -447,6 +447,11 @@ static inline void *device_connection_find_match(struct device *dev,
 	return fwnode_connection_find_match(dev_fwnode(dev), con_id, data, match);
 }
 
+int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
+				   const char *con_id, void *data,
+				   devcon_match_fn_t match,
+				   void **matches, unsigned int matches_len);
+
 /* -------------------------------------------------------------------------- */
 /* Software fwnode support - when HW description is incomplete or missing */
 
-- 
2.33.1

