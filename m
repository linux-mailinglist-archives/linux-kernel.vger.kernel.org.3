Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209375AB604
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbiIBP5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbiIBPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:55:41 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008BACCD5D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:49:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u17so2856563wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+dqtA1vC5bbu7+19eRzEcb3GPd6mCeJ5uJ0I2dFRg1s=;
        b=daEASc8ioBX227MnsitZVw9FMNnmXF1j5HiSzxM+U58lzF8dXRjdaCXpTPZzn+Q1YD
         KR8+sU5BmJI1ZMgzdtAFblCI4nR3EBW2jfWkCHwNqlbVydvrLrz4kSnmuy/HFAkU9adm
         mUTZPxJnR9cqcrEu61Nr06K5Afrkse1z3hbqd3eWN7t2qyLYQ8qEJaH6hNTkFvau7XRW
         Zxekbb3wVUEA1vNCwCOI5gQx+l/N4tFk+q8Gyz0XQMfk0OlBQgjy9+lIFtzw2R+MZX0v
         mcWZeqlUi2zLUGcdGAmY1xHMUi57v2u855oc2qPOO2cFglT7+5rx6BXZ7gTy5TWIZ9cW
         5OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+dqtA1vC5bbu7+19eRzEcb3GPd6mCeJ5uJ0I2dFRg1s=;
        b=v2KRrBonCSkpL+zfYjItFmRNF73rjZW1utSez6Qg7604Z3HVUHgqYOm8lLLKBFH1hQ
         es5Ex5+mIdUJfhPXknE6U5dHNUj/kugHsJSL6E0TZMIi5nFJLJQCari/1idcxaDF0yyo
         z1sQxB4QYaFLgqhxFf3IHkvWrfBfltH3W9FOU3X462pxP3x1+41Rj8GvtJxX1SYC8+jg
         NsX1axrXRrR3FCAFmg84qiez+TH3UwMwvvMJrtSQoO87vQOcfHas5AlzRPGtV2/rPAq3
         GUYbYA+T5Sbb9Pt8ar5Qq2zwxoGXBxZkpeWKtCxyzgkGw/8u8U12zTCW99ywdWHa8l+b
         kt3Q==
X-Gm-Message-State: ACgBeo3G52w0JlGobvyYWdGEtPa4uUG5lRt1IAyOSPTRChvTgKP0PoBS
        Xu8D2yz1reMXE7idE+Bb0eyTPg==
X-Google-Smtp-Source: AA6agR6d+OW/Kb+f1G1p6/IWipjCrHaUTlHmriTMJZTjpULj4Gq7CkBZGCuPmqRTgsUmbSQd95dYoQ==
X-Received: by 2002:adf:f085:0:b0:226:d6e4:58f5 with SMTP id n5-20020adff085000000b00226d6e458f5mr16219092wro.50.1662133775532;
        Fri, 02 Sep 2022 08:49:35 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600010c100b002250f9abdefsm2046741wrx.117.2022.09.02.08.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:49:35 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ekansh Gupta <quic_ekagupt@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 08/10] misc: fastrpc: Safekeep mmaps on interrupted invoke
Date:   Fri,  2 Sep 2022 18:48:58 +0300
Message-Id: <20220902154900.3404524-9-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902154900.3404524-1-abel.vesa@linaro.org>
References: <20220902154900.3404524-1-abel.vesa@linaro.org>
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

