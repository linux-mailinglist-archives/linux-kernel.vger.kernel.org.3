Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294B74B55B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356195AbiBNQK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:10:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356159AbiBNQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:10:22 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DD560A9B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:12 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o24so25023524wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x9uRKtqCvCxuePfYK0JAx8QeSBxwo9Y+7tq8m7yx3w0=;
        b=WlvCopevW8b5o/72zfeOhvEXYQ8rB+v5AzHGOpdqFflewuoDHhb29my/5AhgSyQCqk
         i5R3HjMlwDwhaYbR1USnLuYHZCtDQlv8Yq3T/MgoLSg81GOu33i/ALbHZkJkLnA3Od6h
         XeRB6kUdTAhP/D4f1lYRrEwjV2NCgS/QuuLRr99dKP8qCxdaNI2S6IW2WB1BzC2HGP2B
         aM+iPnRuHyJPW23QEd3/n7Zt1/ISKusWbvSnmjbn/v6Hkdb7fd43LjBHXiNTCyiej8TI
         nhDlEeWfn8BifSRv5hpZPGCncCMvUEEnIJPWIV9AYken23zBh6wcn/4hXq81Y3B2bJGw
         SxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9uRKtqCvCxuePfYK0JAx8QeSBxwo9Y+7tq8m7yx3w0=;
        b=RKbDbpx6q8VHsq4wstConW95D91DtvVEl8axz5ffXlI33JmA8JtED7e6rLLxGN+fpk
         W4DTpZhGwCQoEYyLYI9a2BnWCVoMsJRR6Kab7mcKSRnheJvSEo2Q2yRQvDmE0q28e1ht
         rzI/X98IRRPjJT9afrpVnlFcsCEP4H23sx9tPy7/1YNt+epHz/kThTY2/b0Pdp19TKUz
         XUGGdND0SqpoDiI6wJM/E1ku3vtXdpBCirrRTlBBLXgmu8VNSaA2SWEQZcErIGA2eM9P
         5ZKp+59PnwuBjoW0kJB4iRbHdpItPrdbzB+ESKPxopO/WdJLzJOn5n6484sVNyVF6kaH
         T/ig==
X-Gm-Message-State: AOAM532ztdCJehnUSSKhBAUOL44VpEMzY4LNDYRSgm7Bbalfphtq0fDC
        sz34xKgrLio7xAxZT52pa3wnNg==
X-Google-Smtp-Source: ABdhPJzV6UXmlK51RlmkwjmvZg1JdPBiVJub4IcAUfCRgceQL+C/VWFByLWMgo28GVrtc0aVjMvKkA==
X-Received: by 2002:adf:ff82:: with SMTP id j2mr281369wrr.242.1644855010903;
        Mon, 14 Feb 2022 08:10:10 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id k28sm13677022wms.23.2022.02.14.08.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:10:10 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, Jeya R <jeyr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 03/12] misc: fastrpc: Add support to get DSP capabilities
Date:   Mon, 14 Feb 2022 16:09:53 +0000
Message-Id: <20220214161002.6831-4-srinivas.kandagatla@linaro.org>
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

From: Jeya R <jeyr@codeaurora.org>

Add support to get DSP capabilities. The capability information is cached
on driver.

Signed-off-by: Jeya R <jeyr@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c      | 112 ++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h |   8 +++
 2 files changed, 120 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index e3253daba0f9..528ae5777586 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -31,10 +31,15 @@
 #define FASTRPC_PHYS(p)	((p) & 0xffffffff)
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
+#define FASTRPC_DSP_UTILITIES_HANDLE	2
 #define FASTRPC_CTXID_MASK (0xFF0)
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
 #define ADSP_MMAP_ADD_PAGES 0x1000
+#define DSP_UNSUPPORTED_API (0x80000414)
+/* MAX NUMBER of DSP ATTRIBUTES SUPPORTED */
+#define FASTRPC_MAX_DSP_ATTRIBUTES (256)
+#define FASTRPC_MAX_DSP_ATTRIBUTES_LEN (sizeof(u32) * FASTRPC_MAX_DSP_ATTRIBUTES)
 
 /* Retrives number of input buffers from the scalars parameter */
 #define REMOTE_SCALARS_INBUFS(sc)	(((sc) >> 16) & 0x0ff)
@@ -233,6 +238,9 @@ struct fastrpc_channel_ctx {
 	struct idr ctx_idr;
 	struct list_head users;
 	struct kref refcount;
+	/* Flag if dsp attributes are cached */
+	bool valid_attributes;
+	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *fdevice;
 };
 
@@ -1371,6 +1379,107 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 	return err;
 }
 
+static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr_buf,
+				     uint32_t dsp_attr_buf_len)
+{
+	struct fastrpc_invoke_args args[2] = { 0 };
+
+	/* Capability filled in userspace */
+	dsp_attr_buf[0] = 0;
+
+	args[0].ptr = (u64)(uintptr_t)&dsp_attr_buf_len;
+	args[0].length = sizeof(dsp_attr_buf_len);
+	args[0].fd = -1;
+	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
+	args[1].length = dsp_attr_buf_len;
+	args[1].fd = -1;
+	fl->pd = 1;
+
+	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
+				       FASTRPC_SCALARS(0, 1, 1), args);
+}
+
+static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
+					struct fastrpc_user *fl)
+{
+	struct fastrpc_channel_ctx *cctx = fl->cctx;
+	uint32_t attribute_id = cap->attribute_id;
+	uint32_t *dsp_attributes;
+	unsigned long flags;
+	uint32_t domain = cap->domain;
+	int err;
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	/* check if we already have queried dsp for attributes */
+	if (cctx->valid_attributes) {
+		spin_unlock_irqrestore(&cctx->lock, flags);
+		goto done;
+	}
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
+	dsp_attributes = kzalloc(FASTRPC_MAX_DSP_ATTRIBUTES_LEN, GFP_KERNEL);
+	if (!dsp_attributes)
+		return -ENOMEM;
+
+	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES_LEN);
+	if (err == DSP_UNSUPPORTED_API) {
+		dev_info(&cctx->rpdev->dev,
+			 "Warning: DSP capabilities not supported on domain: %d\n", domain);
+		kfree(dsp_attributes);
+		return -EOPNOTSUPP;
+	} else if (err) {
+		dev_err(&cctx->rpdev->dev, "Error: dsp information is incorrect err: %d\n", err);
+		kfree(dsp_attributes);
+		return err;
+	}
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	memcpy(cctx->dsp_attributes, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES_LEN);
+	cctx->valid_attributes = true;
+	spin_unlock_irqrestore(&cctx->lock, flags);
+	kfree(dsp_attributes);
+done:
+	cap->capability = cctx->dsp_attributes[attribute_id];
+	return 0;
+}
+
+static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
+{
+	struct fastrpc_ioctl_capability cap = {0};
+	int err = 0;
+
+	if (copy_from_user(&cap, argp, sizeof(cap)))
+		return  -EFAULT;
+
+	cap.capability = 0;
+	if (cap.domain >= FASTRPC_DEV_MAX) {
+		dev_err(&fl->cctx->rpdev->dev, "Error: Invalid domain id:%d, err:%d\n",
+			cap.domain, err);
+		return -ECHRNG;
+	}
+
+	/* Fastrpc Capablities does not support modem domain */
+	if (cap.domain == MDSP_DOMAIN_ID) {
+		dev_err(&fl->cctx->rpdev->dev, "Error: modem not supported %d\n", err);
+		return -ECHRNG;
+	}
+
+	if (cap.attribute_id >= FASTRPC_MAX_DSP_ATTRIBUTES) {
+		dev_err(&fl->cctx->rpdev->dev, "Error: invalid attribute: %d, err: %d\n",
+			cap.attribute_id, err);
+		return -EOVERFLOW;
+	}
+
+	err = fastrpc_get_info_from_kernel(&cap, fl);
+	if (err)
+		return err;
+
+	if (copy_to_user(argp, &cap.capability, sizeof(cap.capability)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int fastrpc_req_munmap_impl(struct fastrpc_user *fl,
 				   struct fastrpc_req_munmap *req)
 {
@@ -1676,6 +1785,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	case FASTRPC_IOCTL_MEM_UNMAP:
 		err = fastrpc_req_mem_unmap(fl, argp);
 		break;
+	case FASTRPC_IOCTL_GET_DSP_INFO:
+		err = fastrpc_get_dsp_info(fl, argp);
+		break;
 	default:
 		err = -ENOTTY;
 		break;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index d248eeb20e67..7cc9d342078a 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -15,6 +15,7 @@
 #define FASTRPC_IOCTL_INIT_ATTACH_SNS	_IO('R', 8)
 #define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
 #define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)
+#define FASTRPC_IOCTL_GET_DSP_INFO	_IOWR('R', 13, struct fastrpc_ioctl_capability)
 
 /**
  * enum fastrpc_map_flags - control flags for mapping memory on DSP user process
@@ -105,4 +106,11 @@ struct fastrpc_mem_unmap {
 	__s32 reserved[5];
 };
 
+struct fastrpc_ioctl_capability {
+	__u32 domain;
+	__u32 attribute_id;
+	__u32 capability;   /* dsp capability */
+	__u32 reserved[4];
+};
+
 #endif /* __QCOM_FASTRPC_H__ */
-- 
2.21.0

