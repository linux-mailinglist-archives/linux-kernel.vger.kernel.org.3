Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0C849CB87
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241792AbiAZNyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbiAZNyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:54:33 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A26C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e8so24124344wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j5DHw++5tAvddKPWEbwkZrPCz25+eyIcBMQLIaqDR8M=;
        b=QK2qVWjRWqo4582sMfMyTFMmXQAeowdYiAtWbCvyrrJ1qanCjHUYEHiu4tc2OCFmDp
         pwh6MUZIH4MYMlBJSSG5EXdjOhIGzKcYyhVUr2hAs8OMpdXJ0HtNEq1vD4zpyB+RUbhS
         HDADZ4VDqvd5PbHOWd9/wZj7+H3sNomRXTUTuO2UOzDjCUrOQ4jTAZ4kj+SOuzkneFZY
         1uLnfuYjP4IMbdaQtqDHbHNGHNtaAdnRSt3RxkVFTa2acrrzDbB2rbMaq69BDskKd/bz
         eKmJv0GvUUQekLp9G6ppcHqoBEDv7GcQEYNhnZ5uOJS8G6TQny1YPK7fe0vTlHkfC39q
         /Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5DHw++5tAvddKPWEbwkZrPCz25+eyIcBMQLIaqDR8M=;
        b=Tsf5U5ngaIhCDBC2VdMChis+oBOcZBWGxGmxiuHEycmDGoaflNGsVFVQqfUyKCQgX/
         dkrOhqH+mss0+C/EyJMNQCEqDTHs5U7L09JPLwhEKtTQE/JCiaFtWpqYVw9M4Z6w3faw
         u7mp9VrKZGWhTzyPlJwEI55AE4Z8Wo1DeChsbYMmaV+vyAwYVGhuPuQ8+u/9GqH15ZNo
         /aNgEmbGdLV+JoNV+M5nCHOnNy5t3kRStK23UdmK9PXJ+yYU+HArzeILeyCv2lU14Mem
         0xUexJvpFRMCytZfXfh0LvOBnMtFurdmDMaZ+ji7k10Qhee6gbX0ZRyDhkgZQ+5MWYYI
         h0rg==
X-Gm-Message-State: AOAM5311gZrOQfNyzSn6nKtxgIhUb92RyFn6UdiM2yDbPE5xOPH9N/PP
        gjqT3UT1KeW7ImHjPpMZWvJTnA==
X-Google-Smtp-Source: ABdhPJzfSxA2l/rkEBSRpeFoNTwKJgB6mIseDCE+80R4gA9/cEAhWvL+LUgMyWex/xS4dHjA5PF4kw==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr23339777wrw.392.1643205271153;
        Wed, 26 Jan 2022 05:54:31 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n15sm3356593wmr.26.2022.01.26.05.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:54:30 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 05/12] misc: fastrpc: add secure domain support
Date:   Wed, 26 Jan 2022 13:52:57 +0000
Message-Id: <20220126135304.16340-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
References: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
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
 drivers/misc/fastrpc.c | 57 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d5fafbe3c709..9eadbcf451ef 100644
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
@@ -1683,7 +1686,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 		return -EFAULT;
 
 	/* create SMMU mapping */
-	err = fastrpc_map_create(fl, req.fd, req.length, &map);
+	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map);
 	if (err) {
 		dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
 		return err;
@@ -1878,7 +1881,7 @@ static struct platform_driver fastrpc_cb_driver = {
 };
 
 static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
-				   const char *domain)
+				   bool is_secured, const char *domain)
 {
 	struct fastrpc_device *fdev;
 	int err;
@@ -1887,15 +1890,21 @@ static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ct
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
@@ -1906,6 +1915,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	struct fastrpc_channel_ctx *data;
 	int i, err, domain_id = -1;
 	const char *domain;
+	bool secure_dsp;
 
 	err = of_property_read_string(rdev->of_node, "label", &domain);
 	if (err) {
@@ -1929,10 +1939,31 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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
@@ -1946,6 +1977,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->rpdev = rpdev;
 
 	return of_platform_populate(rdev->of_node, NULL, NULL, rdev);
+fdev_error:
+	kfree(data);
+	return err;
 }
 
 static void fastrpc_notify_users(struct fastrpc_user *user)
@@ -1972,6 +2006,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->fdevice)
 		misc_deregister(&cctx->fdevice->miscdev);
 
+	if (cctx->secure_fdevice)
+		misc_deregister(&cctx->secure_fdevice->miscdev);
+
 	of_platform_depopulate(&rpdev->dev);
 
 	cctx->rpdev = NULL;
-- 
2.21.0

