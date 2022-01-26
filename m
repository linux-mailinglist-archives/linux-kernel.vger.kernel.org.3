Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3E649CB82
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiAZNyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbiAZNya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:54:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3932CC061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:30 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c190-20020a1c9ac7000000b0035081bc722dso4124336wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xCYXvajSPn9motpDNNaOC8f2agY2/ynvhbQJNwf12vc=;
        b=gNq/nBXOBz4Cj9jFVtqfipAeTJ9VWaxPpGJ7hhmyLoDjwo54DMuDgkO1smcDcxqmTG
         +s3ILxzWuYFnhQv/iLS1itrAdZEfetYyLxYDNM9zjP/wVLlJgqvNs29ULba2jhqh/l+M
         fE9Ro+phV/ds1ianxWTn4ZugyrYOuXslH3m2oGlCIe30ubOp2OU4wzs359L4LwGzGaF1
         frQ1BN2RY43K4nv7a2YhySThX6jUyFLh46EJxNajeY5uTKUJn7AFmcXCZWMUEjbPramH
         Wh5UZLzu0MH1q7l+mKHcjvQZyT5BpsQpTBdEgTbwLOTdyMrfihHPviXbHljtwmUJuhQi
         A/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xCYXvajSPn9motpDNNaOC8f2agY2/ynvhbQJNwf12vc=;
        b=mcbug4YBoirVDjSxtSUtItqYeMnX08L1Q471VmolH52+QHS2CH6FvV2BVxpCcPkJsw
         cNmeC4U6pxFXu+0WXkkwQoeo54U6y8VljX/9Trkqrv/xa1JzPKpUlU2SGFt/zCtTyx6+
         7ETSAMlVfY4a710KH9Klfo0hcs5TFJ7h/VpLTx6OL7U0N3zN23g44hVWjySBS3P02XnN
         5Xk9mnk/lFRMw4jYA7JPxNJgpDCuxlJdPw6TFKMxr5IaiCU3dKihNXrGMVRbgneB/+o0
         iZ9XPiJijvjhGOxjP8T9G94mV/WT5oRAwjBnvKTW3LmDoxoZ5dRWWCcDGyF5m7fk6I+R
         Qp1w==
X-Gm-Message-State: AOAM530MJKQHYSMAPrxjcFB+D6T9vmv62rpZAGz6NPHqOJNyJH0aRsVR
        PeA/y+8R5dIoUpP6H4kUbTm29w==
X-Google-Smtp-Source: ABdhPJxuURiygMhaMWKcGSq8WFNpulIgKKlsIOquUzgZhkD1MwBiuquvxU9nrdubxuJXzyvxINSniQ==
X-Received: by 2002:a05:600c:34c6:: with SMTP id d6mr7497064wmq.86.1643205268831;
        Wed, 26 Jan 2022 05:54:28 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n15sm3356593wmr.26.2022.01.26.05.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:54:28 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, Jeya R <jeyr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 03/12] misc: fastrpc: Add support to get DSP capabilities
Date:   Wed, 26 Jan 2022 13:52:55 +0000
Message-Id: <20220126135304.16340-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
References: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeya R <jeyr@codeaurora.org>

Add support to get DSP capabilities. The capability information is cached
on driver.

Signed-off-by: Jeya R <jeyr@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c      | 105 ++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h |   8 +++
 2 files changed, 113 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a840b8dabf0e..d5fafbe3c709 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -31,10 +31,14 @@
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
 
 /* Retrives number of input buffers from the scalars parameter */
 #define REMOTE_SCALARS_INBUFS(sc)	(((sc) >> 16) & 0x0ff)
@@ -233,6 +237,9 @@ struct fastrpc_channel_ctx {
 	struct idr ctx_idr;
 	struct list_head users;
 	struct kref refcount;
+	/* Flag if dsp attributes are cached */
+	bool valid_attributes;
+	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *fdevice;
 };
 
@@ -1371,6 +1378,101 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
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
+	args[1].length = dsp_attr_buf_len * sizeof(uint32_t);
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
+	uint32_t dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
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
+	err = fastrpc_get_info_from_dsp(fl, &dsp_attributes[0], FASTRPC_MAX_DSP_ATTRIBUTES);
+	if (err == DSP_UNSUPPORTED_API) {
+		dev_info(&cctx->rpdev->dev,
+			 "Warning: DSP capabilities not supported on domain: %d\n", domain);
+		return -EOPNOTSUPP;
+	} else if (err) {
+		dev_err(&cctx->rpdev->dev, "Error: dsp information is incorrect err: %d\n", err);
+		return err;
+	}
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	memcpy(cctx->dsp_attributes, dsp_attributes, sizeof(u32) * FASTRPC_MAX_DSP_ATTRIBUTES);
+	cctx->valid_attributes = true;
+	spin_unlock_irqrestore(&cctx->lock, flags);
+done:
+	cap->capability = cctx->dsp_attributes[attribute_id];
+
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
@@ -1677,6 +1779,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
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

