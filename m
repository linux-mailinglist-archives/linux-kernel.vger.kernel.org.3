Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE9948064B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 06:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhL1FU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 00:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhL1FUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 00:20:20 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6207C06175B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 21:20:20 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so23035205otl.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 21:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZa4EhWfNkRpMwcvywpqM2AywO8tV56PCaorCk5JGsI=;
        b=hUcS1GmTWBNeI82qv2MUBR1csBy1hTrQCV2Q5WTDF555O7gVJgP0YUIULBx6U/lw++
         7R53/o01jIyA59wOa8ktH2PmYQGZpi9sYfsnpS0yYEJyIp53LKyJz9YgUr6/rR9INCc7
         pvlmADnC/Xd4n1guF1zpaxS2aSPntl7IHKZBpEDX+h/yxbbzWr04MlIeXcK8pkGkVhVD
         U2YyW/KdUp32MoBs1p1lqE/JKeAuk4Oc29m2YHple1kfGEfn0oFMLFtG7hyM1cIu0Evh
         Nbx5VhpoTfl1i3x6qnU6qg0y+liXvlDN1whJxOQs4W9Wq2FYSkofItYnuMMlXvi0T3HW
         oXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZa4EhWfNkRpMwcvywpqM2AywO8tV56PCaorCk5JGsI=;
        b=PwyVSH0KsH5vHj+T5iIML28FaiqcDdKVHw/Ci79vlHnXjdQgxxucPiZ2AQ95PStpvl
         gtFk9z/vxiWHapB/8JfNeuodVQQDIbaEdmmqqkRb4FvBS/hEPdHOroUDPrxQjR2Qe/2l
         LwoLsO8BSW7P4r69X/ZqfHN9ixRXByGGBNBwEZiBpK71hYdtRepxzRC9XTv2z2o/3OsJ
         DHQlWLwCx0NhIt9RG/eyjGSl+CSkZ8q9yMrlYSN8OefoC8aFoMXfdStWtAzpeYQampDj
         sgD9Al3OTYTotPWmkXodZJWe7W/m4Tde/GNFDe9PfIqs09uaVgvpTyDJ8ekrN4uFplcd
         FugA==
X-Gm-Message-State: AOAM533LtYDCQiZ2JnHUOhI0CiaKqgfRhE/ZZL90EeO0AU2YmonySiPq
        hDErtSZkyXfRRllYnVWlIXX+Nw==
X-Google-Smtp-Source: ABdhPJyBuovnSgiRJ9m+z8PQ+bRYoRJRWCruggSPY+l8ust4yU1NF2wsT+E+hzUPNnbsB8C5hGKPUQ==
X-Received: by 2002:a05:6830:244c:: with SMTP id x12mr10806941otr.197.1640668819873;
        Mon, 27 Dec 2021 21:20:19 -0800 (PST)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j5sm3002277oou.23.2021.12.27.21.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 21:20:19 -0800 (PST)
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
Subject: [PATCH 4/8] device property: Use multi-connection matchers for single case
Date:   Mon, 27 Dec 2021 21:21:12 -0800
Message-Id: <20211228052116.1748443-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
References: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced helpers for searching for matches in the case of
multiple connections can be resused by the single-connection case, so do
this to save some duplication.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/base/property.c | 53 ++++-------------------------------------
 1 file changed, 5 insertions(+), 48 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 0aa0296fd991..213612f7113a 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1157,29 +1157,6 @@ const void *device_get_match_data(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_match_data);
 
-static void *
-fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
-			  void *data, devcon_match_fn_t match)
-{
-	struct fwnode_handle *node;
-	struct fwnode_handle *ep;
-	void *ret;
-
-	fwnode_graph_for_each_endpoint(fwnode, ep) {
-		node = fwnode_graph_get_remote_port_parent(ep);
-		if (!fwnode_device_is_available(node))
-			continue;
-
-		ret = match(node, con_id, data);
-		fwnode_handle_put(node);
-		if (ret) {
-			fwnode_handle_put(ep);
-			return ret;
-		}
-	}
-	return NULL;
-}
-
 static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
 						const char *con_id, void *data,
 						devcon_match_fn_t match,
@@ -1210,28 +1187,6 @@ static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
 	return count;
 }
 
-static void *
-fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
-		    void *data, devcon_match_fn_t match)
-{
-	struct fwnode_handle *node;
-	void *ret;
-	int i;
-
-	for (i = 0; ; i++) {
-		node = fwnode_find_reference(fwnode, con_id, i);
-		if (IS_ERR(node))
-			break;
-
-		ret = match(node, NULL, data);
-		fwnode_handle_put(node);
-		if (ret)
-			return ret;
-	}
-
-	return NULL;
-}
-
 static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
 					  const char *con_id, void *data,
 					  devcon_match_fn_t match,
@@ -1276,16 +1231,18 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
 				   const char *con_id, void *data,
 				   devcon_match_fn_t match)
 {
+	unsigned int count;
 	void *ret;
 
 	if (!fwnode || !match)
 		return NULL;
 
-	ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
-	if (ret)
+	count = fwnode_graph_devcon_matches(fwnode, con_id, data, match, &ret, 1);
+	if (count)
 		return ret;
 
-	return fwnode_devcon_match(fwnode, con_id, data, match);
+	count = fwnode_devcon_matches(fwnode, con_id, data, match, &ret, 1);
+	return count ? ret : NULL;
 }
 EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
 
-- 
2.33.1

