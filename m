Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420BA4B55CF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356156AbiBNQKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:10:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356143AbiBNQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:10:17 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAAE4D27C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:09 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p9so7140838wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OMqER4NRD5Otzp5gHFYzWyzVuvKEBWmPon9W1scP81E=;
        b=cpVlbt9KWDeqAjZQ9dsEuDDaENkntWrDih6e5myV7CH/PSn78t29QejoNwQrGhu51B
         PvdshXgBwg/16Xc82k1qHwLfygCoSQ/ta8FybGfFMUB6MndFvq+LnR0JmM69VAwQi0Pv
         2a6Kwpj/Z4yTwS0BuVzI3DrWkLCKET3ilZ/f03/dRNXQt1I2BD2K7uX5LM3g8lr7uStL
         gQxas/5N38OO5zN/ygia7OUOkhOuoK+zUU7XevKwYhpCQLPE+VXAckEUmtKPiE+vDiNz
         eU123tAxY2XFqcXIp6DHELrJ5laStzwr/NmvV3TnG1/1eZRQriL6y3L+P8qXeQjUM6gX
         RYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMqER4NRD5Otzp5gHFYzWyzVuvKEBWmPon9W1scP81E=;
        b=OkjU9DobsOj2I9g2fw2ZGJLGh2udOuBI35PRTu/jkD43y2hbcyIrQFHvsw2tR7AN8e
         d3OOkdJGf/sm0wJoa9oRN3sM6fMj2fnUtyGEyMBf51/o6rcms4ywmdiV8r6HNQOfoPb3
         Mtb0oUlVwdQXMCSqD7TputkhzXFg42iO8KfPH1soYSVTazFqShpa3SQHSbmabKkVTLkg
         gFVColbz7pSItEHuTTdlB61QAMFSMV4V0LzqozpPLFS14qD9Qw+1C5DxJRiheHpIuhmf
         wy0rPxYo59TxezenmNL5LjF0oR+Ki8IQASKxlTNnNW2gDcS2zCKQsNWye0sXf3Cs3CDO
         2f3w==
X-Gm-Message-State: AOAM532jKWaqaOTpGkp6PqbatbxVUnD6OOyxVbW1ov7B+Gg8BFTMAtpH
        YyJ4iV5y6jUelpAIv47+uAwiYmHTJzrqcg==
X-Google-Smtp-Source: ABdhPJxgDu6sRJNqq8FQUZIphNIUVp7AZu9LzYrSIcz73UMn+/yxFe+lkbJAuQuvaseU+Rn1/vUnUw==
X-Received: by 2002:a5d:4bd1:: with SMTP id l17mr296664wrt.176.1644855008397;
        Mon, 14 Feb 2022 08:10:08 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id k28sm13677022wms.23.2022.02.14.08.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:10:07 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 01/12] misc: fastrpc: separate fastrpc device from channel context
Date:   Mon, 14 Feb 2022 16:09:51 +0000
Message-Id: <20220214161002.6831-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220214161002.6831-1-srinivas.kandagatla@linaro.org>
References: <20220214161002.6831-1-srinivas.kandagatla@linaro.org>
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

Currently fastrpc misc device instance is within channel context struct
with a kref. So we have 2 structs with refcount, both of them managing the
same channel context structure.

Separate fastrpc device from channel context and by adding a dedicated
fastrpc_device structure, this should clean the structures a bit and also help
when adding secure device node support.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 46 +++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4ccbf43e6bfa..7e1c66591716 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -78,7 +78,7 @@
 #define USER_PD		(1)
 #define SENSORS_PD	(2)
 
-#define miscdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, miscdev)
+#define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp"};
@@ -212,8 +212,13 @@ struct fastrpc_channel_ctx {
 	spinlock_t lock;
 	struct idr ctx_idr;
 	struct list_head users;
-	struct miscdevice miscdev;
 	struct kref refcount;
+	struct fastrpc_device *fdevice;
+};
+
+struct fastrpc_device {
+	struct fastrpc_channel_ctx *cctx;
+	struct miscdevice miscdev;
 };
 
 struct fastrpc_user {
@@ -1220,10 +1225,14 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 
 static int fastrpc_device_open(struct inode *inode, struct file *filp)
 {
-	struct fastrpc_channel_ctx *cctx = miscdev_to_cctx(filp->private_data);
+	struct fastrpc_channel_ctx *cctx;
+	struct fastrpc_device *fdevice;
 	struct fastrpc_user *fl = NULL;
 	unsigned long flags;
 
+	fdevice = miscdev_to_fdevice(filp->private_data);
+	cctx = fdevice->cctx;
+
 	fl = kzalloc(sizeof(*fl), GFP_KERNEL);
 	if (!fl)
 		return -ENOMEM;
@@ -1608,6 +1617,27 @@ static struct platform_driver fastrpc_cb_driver = {
 	},
 };
 
+static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
+				   const char *domain)
+{
+	struct fastrpc_device *fdev;
+	int err;
+
+	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
+	if (!fdev)
+		return -ENOMEM;
+
+	fdev->cctx = cctx;
+	fdev->miscdev.minor = MISC_DYNAMIC_MINOR;
+	fdev->miscdev.fops = &fastrpc_fops;
+	fdev->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "fastrpc-%s", domain);
+	err = misc_register(&fdev->miscdev);
+	if (!err)
+		cctx->fdevice = fdev;
+
+	return err;
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -1637,11 +1667,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (!data)
 		return -ENOMEM;
 
-	data->miscdev.minor = MISC_DYNAMIC_MINOR;
-	data->miscdev.name = devm_kasprintf(rdev, GFP_KERNEL, "fastrpc-%s",
-					    domains[domain_id]);
-	data->miscdev.fops = &fastrpc_fops;
-	err = misc_register(&data->miscdev);
+	err = fastrpc_device_register(rdev, data, domains[domain_id]);
 	if (err) {
 		kfree(data);
 		return err;
@@ -1681,7 +1707,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	misc_deregister(&cctx->miscdev);
+	if (cctx->fdevice)
+		misc_deregister(&cctx->fdevice->miscdev);
+
 	of_platform_depopulate(&rpdev->dev);
 
 	cctx->rpdev = NULL;
-- 
2.21.0

