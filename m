Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4FE5AB1E7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbiIBNo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbiIBNoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:44:30 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F05CE486
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:20:49 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so3322563wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+dqtA1vC5bbu7+19eRzEcb3GPd6mCeJ5uJ0I2dFRg1s=;
        b=QBMPARjxuSFYr4rlCJC3iBEX6OolvdebZ7bi1B64NgzQgYcSoyXWcxa2Yksze5Oo+3
         to8AbiMwCqApS7ijj38F20R8G1oIVwuW+oydeQHzJ9GmHirioZ271fsKRSUmS5SczfNR
         Ttq2/guTH0rn4TTtIghQjQkpt0CaIFa4nbv65UEWhg4N4lUlAHNkb7CHbvdIbjT8cTjM
         c+2AKV4YZn7e6NHEIn2o7K6ayt3Imhq17IEuowSRbnWHrpap2eB1ZoKUkJrFncLox+Uk
         kUd4NsSkn8Wot3aW2vGCVge8kQ25YrpXbdmRsNhNo1l7Fh98O1KnlCNdA0wOd1667ocI
         FT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+dqtA1vC5bbu7+19eRzEcb3GPd6mCeJ5uJ0I2dFRg1s=;
        b=4As0qS5VlW7bUL1llSmVVN9KJZV4EL2Eh6+WXSyNRK/+F9kMsI+Coe3CdT1ekQndD5
         Lwwf+UqhEy2kciWAFuqrT1dRwXYseokNzLb1dUmKp3YHXJZqj4QwmgK21PPJOiKxvBhy
         PG6pKsMj/g4Ekkvmg7xtBi5GbiFu1CT+PjjV+Xz798FXQuk0GlUf6oMFjY9tJitcMSwf
         FrseHAXpO3FvcN1pLBrU3k3ocKcY72xKGx/CcXSUR5pYOHaiEEN7DPwmU4C2gvmaDLuM
         hiqoZ4KhF27n2WQwM3IRltVzp2KYzxegQGrap5CBJs9CWCdfRAh/b8PE3j0wzPzRqRqA
         mpeQ==
X-Gm-Message-State: ACgBeo2P/UkpZ6aIGALb/KOQ9l8V20vOdA0mBVHL8G5DHcRNHknod9cF
        XZNICdDCJpB7/nhpueiDoWQ5kA==
X-Google-Smtp-Source: AA6agR5Nz5S9Ybqg0GPy/k7BTb2Rrf+PXdlDuY6zxWSuJ4VN/lLB1tl8BsOVV93tuPLawi389z0E0Q==
X-Received: by 2002:a05:600c:3d05:b0:3a5:dd21:e201 with SMTP id bh5-20020a05600c3d0500b003a5dd21e201mr2831703wmb.132.1662124476833;
        Fri, 02 Sep 2022 06:14:36 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d43ce000000b002253fd19a6asm1766253wrr.18.2022.09.02.06.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 06:14:36 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorande@qti.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/14] misc: fastrpc: Safekeep mmaps on interrupted invoke
Date:   Fri,  2 Sep 2022 16:13:41 +0300
Message-Id: <20220902131344.3029826-12-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902131344.3029826-1-abel.vesa@linaro.org>
References: <20220902131344.3029826-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the userspace daemon is killed in the middle of an invoke (e.g.
audiopd listerner invoke), we need to skip the unmapping on device
release, otherwise the DSP will crash. So lets safekeep all the maps
only if there is in invoke interrupted, by attaching them to the channel
context (which is resident until RPMSG driver is removed), and restore
them back to the fastrpc user on the next device open call.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 2c656da4ca5e..41eabdf0a256 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -275,6 +275,7 @@ struct fastrpc_channel_ctx {
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
 	struct fastrpc_buf *remote_heap;
+	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
 };
@@ -1114,6 +1115,26 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 
 }
 
+static void fastrpc_invoke_interrupted_restore_mmaps(struct fastrpc_user *fl)
+{
+	struct fastrpc_buf *buf, *b;
+
+	list_for_each_entry_safe(buf, b, &fl->cctx->invoke_interrupted_mmaps, node) {
+		list_del(&buf->node);
+		list_add(&buf->node, &fl->mmaps);
+	}
+}
+
+static void fastrpc_invoke_interrupted_save_mmaps(struct fastrpc_user *fl)
+{
+	struct fastrpc_buf *buf, *b;
+
+	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
+		list_del(&buf->node);
+		list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
+	}
+}
+
 static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   u32 handle, u32 sc,
 				   struct fastrpc_invoke_args *args)
@@ -1182,6 +1203,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		fastrpc_context_put(ctx);
 	}
 
+	if (err == -ERESTARTSYS)
+		fastrpc_invoke_interrupted_save_mmaps(fl);
+
 	if (err)
 		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
 
@@ -1551,6 +1575,8 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 		return -EBUSY;
 	}
 
+	fastrpc_invoke_interrupted_restore_mmaps(fl);
+
 	spin_lock_irqsave(&cctx->lock, flags);
 	list_add_tail(&fl->user, &cctx->users);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -2268,6 +2294,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	dev_set_drvdata(&rpdev->dev, data);
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
+	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
 	spin_lock_init(&data->lock);
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
@@ -2292,6 +2319,7 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
+	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
 
@@ -2306,6 +2334,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->secure_fdevice)
 		misc_deregister(&cctx->secure_fdevice->miscdev);
 
+	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
+		list_del(&buf->node);
+
 	if (cctx->remote_heap)
 		fastrpc_buf_free(cctx->remote_heap);
 
-- 
2.34.1

