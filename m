Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2635946E823
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhLIMK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbhLIMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:10:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4982C061353
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:07:04 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t9so9304037wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 04:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ms9M7lrxV9p818nCY/uP95wwcfYdzIsqCNNwjkutMNs=;
        b=KhPaJOHWKtsuX1Ux79gW5bWGf9FESePFylxkcebDNYGuGzEeQYYYAur/S73t/Ja6BN
         +C2JT3vm9l5988vkmbO40/Nc8weXbC3O21sfIlTg5hzIqipYocwmWg7oTcori0E6zONV
         I5slfh7j8vYHtu7dsjRP8/sVuuYg7RhFSVqwEZsI9U4vnCNw+s1JdKw+3V7vA78SJcOY
         tZEUKsmmOuW4ik4nhxhp1PpUzF+nzpm39vnnGtRmG9EPTuu7H4lf2oC8X/L3ahR/N5Ty
         H42YRdIx2IzxEZ4uBkiNDEdIVTkUjfm6JP9ylp1UUb8CZV8pwwC1kx8vWZV0bYTkDszG
         itVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ms9M7lrxV9p818nCY/uP95wwcfYdzIsqCNNwjkutMNs=;
        b=8DT3m2JibUxhkcHDqcozIbKgaWlYIRWvqgnnKXYAFsQBYyX6eBIKQUvUxFbdA+cJn9
         blJDQU0Jz1HptsguFUK/MIQbvxR5pLvp5TwZYJJELJlyiXeC10Tp8A57iv49ih7U+SfG
         6u515OhhuNcyxMzhhoFShLw4rQKInOgoK16vmjsXFDYsquJnVNlbUFQiFPODZumHPjgx
         NTeI47mUNwvHgWMhLzMN3j/5MLxYw/N+x5SnwxTmW/80GmDnj9XS6zIzzCzDRrOcEOTt
         DWDOxKUZbGDS6IjU3z8zH3qicDWLW1+uFRuMUyxnvczL7pmUEvLJ9yG0M7C5t3ZcF89x
         RQQA==
X-Gm-Message-State: AOAM533O4fjE2Xe7nvyfSRfbkm+Rji/MGatiYaogfPpJVRo5ZpgfnnXr
        AVDnAlovskanmekS8DoBMBvyQQ==
X-Google-Smtp-Source: ABdhPJwBvMoaUTSMHZVqFZE99J22NgRJ8NFQv96BPXUT58e90AmprWeHFsncAt4wbFxvlEl6nY9/kQ==
X-Received: by 2002:adf:f207:: with SMTP id p7mr5863713wro.173.1639051623386;
        Thu, 09 Dec 2021 04:07:03 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 4sm7513289wrz.90.2021.12.09.04.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 04:07:02 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        jeyr@codeaurora.org, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 6/8] misc: fastrpc: add secure domain support
Date:   Thu,  9 Dec 2021 12:06:24 +0000
Message-Id: <20211209120626.26373-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
References: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADSP/MDSP/SDSP are by default secured, which means it can only be loaded
with a Signed process.
Where as CDSP can be either be secured/unsecured. non-secured Compute DSP
would allow users to load unsigned process and run hexagon instructions,
but blocking access to secured hardware within the DSP. Where as signed
process with secure CDSP would be allowed to access all the dsp resources.

This patch adds basic code to create device nodes as per device tree property.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 61 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 79fc59caacef..50f8e23b6b04 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -240,12 +240,15 @@ struct fastrpc_channel_ctx {
 	/* Flag if dsp attributes are cached */
 	bool valid_attributes;
 	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
+	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
+	bool secure;
 };
 
 struct fastrpc_device {
 	struct fastrpc_channel_ctx *cctx;
 	struct miscdevice miscdev;
+	bool secure;
 };
 
 struct fastrpc_user {
@@ -1876,7 +1879,7 @@ static struct platform_driver fastrpc_cb_driver = {
 };
 
 static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
-				   const char *domain)
+				   bool is_secured, const char *domain)
 {
 	struct fastrpc_device *fdev;
 	int err;
@@ -1885,15 +1888,21 @@ static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ct
 	if (!fdev)
 		return -ENOMEM;
 
+	fdev->secure = is_secured;
 	fdev->cctx = cctx;
 	fdev->miscdev.minor = MISC_DYNAMIC_MINOR;
 	fdev->miscdev.fops = &fastrpc_fops;
-	fdev->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "fastrpc-%s", domain);
+	fdev->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "fastrpc-%s%s",
+					    domain, is_secured ? "-secure" : "");
 	err = misc_register(&fdev->miscdev);
-	if (err)
+	if (err) {
 		kfree(fdev);
-	else
-		cctx->fdevice = fdev;
+	} else {
+		if (is_secured)
+			cctx->secure_fdevice = fdev;
+		else
+			cctx->fdevice = fdev;
+	}
 
 	return err;
 }
@@ -1904,6 +1913,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	struct fastrpc_channel_ctx *data;
 	int i, err, domain_id = -1;
 	const char *domain;
+	bool secure_dsp = false;
 
 	err = of_property_read_string(rdev->of_node, "label", &domain);
 	if (err) {
@@ -1927,10 +1937,31 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (!data)
 		return -ENOMEM;
 
-	err = fastrpc_device_register(rdev, data, domains[domain_id]);
-	if (err) {
-		kfree(data);
-		return err;
+
+	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
+	data->secure = secure_dsp;
+
+	switch (domain_id) {
+	case ADSP_DOMAIN_ID:
+	case MDSP_DOMAIN_ID:
+	case SDSP_DOMAIN_ID:
+		err = fastrpc_device_register(rdev, data, secure_dsp, domains[domain_id]);
+		if (err)
+			goto fdev_error;
+		break;
+	case CDSP_DOMAIN_ID:
+		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
+		err = fastrpc_device_register(rdev, data, true, domains[domain_id]);
+		if (err)
+			goto fdev_error;
+
+		err = fastrpc_device_register(rdev, data, false, domains[domain_id]);
+		if (err)
+			goto fdev_error;
+		break;
+	default:
+		err = -EINVAL;
+		goto fdev_error;
 	}
 
 	kref_init(&data->refcount);
@@ -1943,7 +1974,14 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
 
-	return of_platform_populate(rdev->of_node, NULL, NULL, rdev);
+	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
+	dev_info(rdev, "%s complete for %s with secure flag(%d) return: %d\n",
+			__func__, domains[domain_id], secure_dsp, err);
+	return err;
+
+fdev_error:
+	kfree(data);
+	return err;
 }
 
 static void fastrpc_notify_users(struct fastrpc_user *user)
@@ -1970,6 +2008,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->fdevice)
 		misc_deregister(&cctx->fdevice->miscdev);
 
+	if (cctx->secure_fdevice)
+		misc_deregister(&cctx->secure_fdevice->miscdev);
+
 	of_platform_depopulate(&rpdev->dev);
 
 	cctx->rpdev = NULL;
-- 
2.21.0

