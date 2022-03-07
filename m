Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AC04CF05A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiCGDju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiCGDjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:39:49 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3664DF5A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:38:55 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id o64so413706oib.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 19:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Hb2fy5aM3CLZPd7X+iwsFgBJV1+qHX9cGiXpSHCLcg=;
        b=hhVTqHkWvsVvvadoRnp1Mq41Qbf56aBlwOxFSBs0c/fwZSjwZtJwV6YB1q0Avf2Uhg
         sFZQvwJcKQwKpOJTNdjfbQz8BfZm3IeO36U2KZsl4uRP2rYJs1CGP/YF8BCPcAlthDjp
         niNkQ5BygacKk77Jp1SQM1d3R7GvpUElS/fuPHmFcblvtb/CGsyFxSy2mkMfN1G8KTDx
         sVITXwF+iRIgsW0al20T9xum66wXDYBx82KbVt4iGWOWH57eCu1oMk6kHZcQNgqYocGO
         xec8tc50PX1ZkpLLkoEO/MKXs4cUqb5CRu7i6/LOVFRY/lFhqPFBzxmXxEID1l84S6au
         PxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Hb2fy5aM3CLZPd7X+iwsFgBJV1+qHX9cGiXpSHCLcg=;
        b=6quWOQGVrbMaW0tbAI8YilUVMbP46T9F29Ee8De3w/I+9FyuNgj4j7iiMlKCmFNusV
         rAof2VB1yBxf7+VoaIt/0C/7rTJ/WxvQNMzDkzEevr3aFn6+ARZI3mNsTl5rJkxwZs1x
         raTpuZDxgIYY6JF5cgp29OvlubPwvQ4T9pXkzdC8kdgN/1EthulQb9zjg5kp1ZBwPfIz
         bJ5gHOOzkmtSEYi2A2ZdKVJBRqVAmfKVUYxl84rUbe/mRZZTxGXxleUODh3N4iP8Q7aD
         olGh1BsThN3vWFgPaTMV0KD3cQPvbwL5/jaHLchO+uGNJgI4w9q73MJxKZXTm3lYCPx5
         RfHQ==
X-Gm-Message-State: AOAM532OiJkUsvYrwhCkGG7ZI9XxBuKuO4fWBURpvgyp7nmJ3/Yt/iHC
        Mfw7uymp/Yk7/kQsoAkNCknrcg==
X-Google-Smtp-Source: ABdhPJy1mPqKhYPjb76XiNvksuVVYByp/vOKe46VZy3KjbU6OruWLUMP10F6P6FHw0Gs+/LqdVPHFw==
X-Received: by 2002:a05:6808:b10:b0:2d9:a01a:4bfa with SMTP id s16-20020a0568080b1000b002d9a01a4bfamr5841916oij.289.1646624334985;
        Sun, 06 Mar 2022 19:38:54 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id o2-20020a05687072c200b000d9ae3e1fabsm5005172oak.12.2022.03.06.19.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 19:38:54 -0800 (PST)
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
Subject: [PATCH v4 1/7] device property: Helper to match multiple connections
Date:   Sun,  6 Mar 2022 19:40:34 -0800
Message-Id: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Changes since v3:
- fwnode_connection_find_matches() should not adjust matches before calling
  fwnode_devcon_matches()
- Replaced return from within the loops with break
- Changed "count >= matches_len && matches" to "matches && count >=
  matches_len", to denote the significance of "matches"

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

 drivers/base/property.c  | 109 +++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |   5 ++
 2 files changed, 114 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c0e94cce9c29..7fccb0587855 100644
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
+		if (matches && count >= matches_len) {
+			fwnode_handle_put(ep);
+			break;
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
+		if (matches && count >= matches_len)
+			break;
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
@@ -1267,3 +1332,47 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
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
+	if (matches) {
+		matches += count_graph;
+		matches_len -= count_graph;
+	}
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

