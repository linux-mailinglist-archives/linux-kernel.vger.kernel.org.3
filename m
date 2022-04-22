Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7756A50C3AA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiDVW6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiDVW5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:57:41 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A96343E6B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:21:52 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 12so10542156oix.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XENFSBCAxirOMSvN5P45H1Vvs6fWH0AA/S+LYBu5Oow=;
        b=bACNTkVaiUGXihYZDcQV9PLoJAjDwUaKU0nJbvLHLSp9EtlSmlIOcdlRlODArPFKE4
         6dTDsPDnHZ3Ufdg74nOFzASENI2z+QVfy254paHTUJrIPVmKsvFSqeOKwY3mrfJU6gil
         5iDO9pn3xe/hy9WtI0nfvFh/jt00HXQggQPPtjtj5VQ6uU3DUdi4CqCyIeCP1DcXQm3i
         jHsmBr79i5kdSdgf72LxJpOiQv9Mo7/2UIXm3oHMpNwpTXjwNPP0y07l6kIceye/fjnI
         8c41lBph9vfCBfv+YSMIpJWeDHUtdXAbQep3lfDzHtN+Y6dIwg69llcmwsNiQpcq8gec
         f58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XENFSBCAxirOMSvN5P45H1Vvs6fWH0AA/S+LYBu5Oow=;
        b=jIsjfPoNcvEhuO5SAzpL4t26v77TDNXSxvlrh85M49oXVY7ZiSxHmNYckVrdDFDEwr
         7DzSJq9nJj2lvPTlDy6E001rlsEnK81X/qZKgUTRUU2n5rvVwil15aDgW1jcfayiQpCC
         L13ooZ/qYsCucEpsTMHfmKFPz71TW4Qu+hE0iyx5Q7A+HrQwUJFWgX0mEBjXtADDLa8u
         a1bIzQa4RPs7+xaL3oAPg7Nmgw/gYv/bmCrVkdnwI1kh3miZbiw1PCGIQX8Xl92g25LL
         G1klhPgh7tzat2wwmWa2i//rfl89QHxJyRDzi+OwRTmDDZ46bwAy24yFpQGdRi34C+jI
         9cGw==
X-Gm-Message-State: AOAM533ygtdcOiijDTnIUyKi8TghrsAMj6PpEWfIja9AD4ACsUQhhX1y
        1LE0tcinA0c0LbAv6puO67C52w==
X-Google-Smtp-Source: ABdhPJxUu+TIzAagwVAFL737HsQohEi6OYw8fsVfAEoixHQTgXTXln0yE3HNaoph719hM+yRvhkKkw==
X-Received: by 2002:a05:6808:124b:b0:2da:38f0:945f with SMTP id o11-20020a056808124b00b002da38f0945fmr7623223oiv.171.1650666111443;
        Fri, 22 Apr 2022 15:21:51 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id js4-20020a056870bac400b000e687cdf5adsm1049224oab.55.2022.04.22.15.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 15:21:50 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v5 1/7] device property: Add helper to match multiple connections
Date:   Fri, 22 Apr 2022 15:23:45 -0700
Message-Id: <20220422222351.1297276-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422222351.1297276-1-bjorn.andersson@linaro.org>
References: <20220422222351.1297276-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Changes since v4:
- Added "Add" to patch subject
- Added "(Optional)" kernel-doc of fwnode_connection_find_matches()

 drivers/base/property.c  | 109 +++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |   5 ++
 2 files changed, 114 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 36401cfe432c..babab8cec7a0 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1201,6 +1201,40 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
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
@@ -1223,6 +1257,37 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
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
@@ -1250,3 +1315,47 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
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
+ * @matches: (Optional) array of pointers to fill with matches
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
index fc24d45632eb..a5b429d623f6 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -451,6 +451,11 @@ static inline void *device_connection_find_match(struct device *dev,
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
2.35.1

