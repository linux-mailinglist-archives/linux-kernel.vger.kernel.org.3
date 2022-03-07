Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716D34CF060
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiCGDjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiCGDjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:39:49 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841674EA00
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:38:56 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so12058802otl.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 19:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/MCt7zD+7NRGZpCFHWN5u6MfVVdOsK3kPJmdcKk1zQ=;
        b=xs+/oH+0Xa8WaEhc0k7mUrN1ZnIjpHcFI0chw+wvfFTHgL5riPW7Eex0SEJjpPjVU2
         hE5lYmneAB8/zqrH2EkhPMaJDzMRocgrsnUaco7P2Jzo3MjpNc1jKzdZczrM5XR25u8u
         OAUdjRZeM4BuvQ0eh0mTkdV2/a7NtxJHF92yVxCPUSKnIAEDDx5KkDBJhJH2ZxDv8vG5
         Q45qvU0IADXxDQUszZNd2eUQjnXIqbBl5LPAqzKBZC7+djR6FGzHHKUrzh5VPVxyuAKD
         LVLnwvoM9YULHqNJLe3CGRt4E8/6WpPme2K7FtmSLKoTaK5EXtSfsC2HPMSLeG8bOtEG
         K0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/MCt7zD+7NRGZpCFHWN5u6MfVVdOsK3kPJmdcKk1zQ=;
        b=6Ks6jbnm/yYSgGlo+tIkbM+uk57pb5YGx/9sFkh/RhZcnnQ9oBvq0EYUMB1mbXsg4D
         c10sCQLDxO7g6qXOgV3wHlki49bDCK8CrCtXGCoK4Omn8/rhk7Yi4BTx5ulZtrYg+oUJ
         7POeZN70v7S/IobhNm895/yg0bRXAxIWS+jfcl8OCl8ZsL4Qbke8X3aT55Ndnk6J4tqa
         1OKy+A479EKyBIuPGUTVX3l6ENxj3rxu1gmbLaDpU4xV5W4rdDL7aDV8EPwriJ1ylpX4
         VehS9hvHSxZyhi1WqXmVBJguvwnKImF9O3bV/bYGRzzoVnOOymP/7dR4eXyEVTBTtsws
         bmEg==
X-Gm-Message-State: AOAM533R/xT2G8SOaTTJxF/TauiWitnAl4PYkIcm39Om/YAiQDY2vzYW
        DiPpuChRZFBw5/artblKQEZPBg==
X-Google-Smtp-Source: ABdhPJy9PAFepwg+UDYAwdRLD2axOA/9QjaQ4bB0YxN+ILEGjicdR2M3oqKZlVqHcp4RumfEUM3MSg==
X-Received: by 2002:a9d:2da5:0:b0:5ad:fa9:832 with SMTP id g34-20020a9d2da5000000b005ad0fa90832mr4873882otb.250.1646624335886;
        Sun, 06 Mar 2022 19:38:55 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id o2-20020a05687072c200b000d9ae3e1fabsm5005172oak.12.2022.03.06.19.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 19:38:55 -0800 (PST)
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
Subject: [PATCH v4 2/7] device property: Use multi-connection matchers for single case
Date:   Sun,  6 Mar 2022 19:40:35 -0800
Message-Id: <20220307034040.1111107-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
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

The newly introduced helpers for searching for matches in the case of
multiple connections can be resused by the single-connection case, so do
this to save some duplication.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Picked up Andy's r-b

Changes since v2:
- None

Changes since v1:
- None

 drivers/base/property.c | 55 ++++-------------------------------------
 1 file changed, 5 insertions(+), 50 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 7fccb0587855..ead8d4dd1ae2 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1193,31 +1193,6 @@ const void *device_get_match_data(struct device *dev)
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
-		if (!fwnode_device_is_available(node)) {
-			fwnode_handle_put(node);
-			continue;
-		}
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
@@ -1252,28 +1227,6 @@ static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
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
@@ -1320,16 +1273,18 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
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

