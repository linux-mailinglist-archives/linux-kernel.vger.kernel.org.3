Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8AF480656
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 06:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhL1FUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 00:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhL1FUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 00:20:20 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B92C061401
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 21:20:19 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id v6so28334515oib.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 21:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3stWgwR81eKAKJ3RKJ0P1Br/fRUp2N80q2Nu0F389M=;
        b=PZcs1kJvAVVjSw3EUh7l1rDY0itzHA9onaPisle11HEnrVaazjHTi1CxdWUwagpjQW
         n2CVG3RO+ZGjdz7Fsipsrm8uPVhv9V7ZAKcqyCDGYXY2T5cK3raa59hms1D4S9Y7RdPK
         BZh1ZjvPKsxFFEK+0m8YIPOIOrjOrfPz9PdRR1WsHcC91uzkKQNZnA/Uzp1bM4GZ6oVM
         Www+zB/6YyjaXcEqwElhL/2EtYRL5s0+/JFKEc6KK+/lE6V/CikHS2suOwMqJxXE6laj
         eqzqMZcy/Xkh8QS/QubOoweciY4aTIsJY9Nlmkjk6gEGmhQjAvxJjVdkjFpslkyeejZK
         EqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3stWgwR81eKAKJ3RKJ0P1Br/fRUp2N80q2Nu0F389M=;
        b=vDLZJoqQlyub9X7ekxRvbIqPmUMRk1yy81YElUufeucRPfEJqdFSAsho4DnudRvfoy
         bINR8X0iv0rlpucC3/v44VFB/irdLKtgHvys9ldRpCOErkWQW0JqToUsOZc6jB7C1I71
         DdeYPx/uKL1bg6zX9beh5w5/qyaHMyMnJqENnLTr4fUeFUH3IjCR+BT+bnE4Cji4fDap
         zuxEdD2HUWqyjGYu3J3VbSX5BO+xYOHSBaL+kVbpuAb0OXj6l472Nyrld3OgC9tGlUCd
         ZcvH+ZAspZlfifcNfLAtaC2XdDEgNNnOlw7zZkqW4MSmSrH1OINXJf4fSUacyk/6L+7F
         nRWw==
X-Gm-Message-State: AOAM531q6r5yaYburcLHI7IuQ35/y0LVlMIPOOuzcs/ZLQxEko7wZgl6
        TG6g6H5DfWQmp0iP8K8vChs5/w==
X-Google-Smtp-Source: ABdhPJxSBeV78ThLbYNQ0MD+2nECmaipYI67MZ3x5j68rujaK2cOl0sAvFwLxoMhYWe2DsYxcsKoAA==
X-Received: by 2002:a05:6808:11c5:: with SMTP id p5mr15416930oiv.51.1640668818992;
        Mon, 27 Dec 2021 21:20:18 -0800 (PST)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j5sm3002277oou.23.2021.12.27.21.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 21:20:18 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 3/8] device property: Helper to match multiple connections
Date:   Mon, 27 Dec 2021 21:21:11 -0800
Message-Id: <20211228052116.1748443-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
References: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases multiple connections with the same connection id
needs to be resolved from a fwnode graph.

One such example is when separate hardware is used for performing muxing and/or
orientation switching of the SuperSpeed and SBU lines in a USB-C
connector. In this case the connector needs to belong to a graph with
multiple matching remote endpoints, and the TypeC controller needs to be
able to resolve them both.

Add a new API that allows this kind of lookup.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/base/property.c  | 94 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  5 +++
 2 files changed, 99 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index cbe4fa298413..0aa0296fd991 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1180,6 +1180,36 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
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
+		if (count >= matches_len) {
+			fwnode_handle_put(ep);
+			return count;
+		}
+
+		node = fwnode_graph_get_remote_port_parent(ep);
+		if (!fwnode_device_is_available(node))
+			continue;
+
+		ret = match(node, con_id, data);
+		fwnode_handle_put(node);
+
+		if (ret)
+			matches[count++] = ret;
+	}
+	return count;
+}
+
 static void *
 fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 		    void *data, devcon_match_fn_t match)
@@ -1202,6 +1232,35 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
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
+	void *ret;
+	int i;
+
+	for (i = 0; ; i++) {
+		if (count >= matches_len)
+			return count;
+
+		node = fwnode_find_reference(fwnode, con_id, i);
+		if (IS_ERR(node))
+			break;
+
+		ret = match(node, NULL, data);
+		fwnode_handle_put(node);
+
+		if (ret)
+			matches[count++] = ret;
+	}
+
+	return count;
+}
+
 /**
  * fwnode_connection_find_match - Find connection from a device node
  * @fwnode: Device node with the connection
@@ -1229,3 +1288,38 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
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
+ *
+ * Return: Number of matches resolved, of negative errno.
+ */
+int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
+				   const char *con_id, void *data,
+				   devcon_match_fn_t match,
+				   void **matches, unsigned int matches_len)
+{
+	unsigned int count;
+
+	if (!fwnode || !match || !matches)
+		return -EINVAL;
+
+	count = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
+					    matches, matches_len);
+
+	return count + fwnode_devcon_matches(fwnode, con_id, data, match,
+					     matches + count,
+					     matches_len - count);
+}
+EXPORT_SYMBOL_GPL(fwnode_connection_find_matches);
diff --git a/include/linux/property.h b/include/linux/property.h
index 16f736c698a2..59484ccb260e 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -444,6 +444,11 @@ static inline void *device_connection_find_match(struct device *dev,
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

