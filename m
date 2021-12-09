Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697E246E819
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbhLIMKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbhLIMKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:10:36 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA56EC061D7E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:07:02 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so3894266wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 04:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l37GbIhfzE3UARSVu8FEWtv/j/qpKbhIE/iWmT1In28=;
        b=Dgsl40n9wUj8OsJbKWLeZ2ivr+SErRrgEGVTZxn3t2+N7X/7gly7mDg8SgNV+s1Jta
         Vv3YMKXlD3R0aAlrlHfwTImyRuslm7zjMA5IEqzJAAZMJCVaMfTD/INqr8hd7yEzyb+d
         iRvVqtt6Y43ZNaXf0iCvZnUGXxHkN8adleHrZTEAIH45U3IngH5X4rxC/nmPiGQTC8X3
         r6zT7yD1QuxPKN4xI+nDVQ10sLAwS2OBsnwdInvqV1CsPYLywWG6gnKH0K+dSSqF0bW7
         Or0sr460Ufwns2GsVj0Sh28I9lngPgFSSPP2tezSdv2NY+yutQHXH0o2Fh05LILpDdbV
         Lz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l37GbIhfzE3UARSVu8FEWtv/j/qpKbhIE/iWmT1In28=;
        b=3toyPoJzYREhaM53zSHUs7QKWZwwsUr84gOsWieTAutPDJmiNwevRqInHR2W5J5eiM
         0Hf1QTWh2ftV8jZIT2KJJh0tQqgMg4YT/HkSwiqIRO9n7TEQjd6vRnW7t/6pxnXPeU/j
         wx41tItIXsgUo8UE76y559Rp8uZsZNzgv6r5hoXH10vWkjbqLdv3cRy2YnRiun1vh7Aw
         0gs+hL7nrAnuj0fLUy2pkcQlWyXGAyf9oEjVSy1ao5ml42vfVq2+wLv1gnK5ahIRTL+E
         xFF+kbILdisEgE0IUnXhXhcmhyG09MPW/T+myo0EudmqIQQWl2oYqin6V+GI27/JzlwC
         Qnow==
X-Gm-Message-State: AOAM532RHs30ax7sag9AwzVcUhrCwDy7BIjKbqnMQwu4ID3kQvYvg8Jd
        Mbq32tbSmLIVFrw3oZZsbIEjgA==
X-Google-Smtp-Source: ABdhPJyWwpuHzWShd5h7ziVtsyZmi7O/J8/9pLmrcVOzVrI8Id4ifuTJ6/d5Z4WzB5yKbdWRKRifsA==
X-Received: by 2002:a1c:1dd6:: with SMTP id d205mr6404046wmd.77.1639051620823;
        Thu, 09 Dec 2021 04:07:00 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 4sm7513289wrz.90.2021.12.09.04.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 04:07:00 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        jeyr@codeaurora.org, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/8] misc: fastrpc: Add support to get DSP capabilities
Date:   Thu,  9 Dec 2021 12:06:22 +0000
Message-Id: <20211209120626.26373-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
References: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
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
index c2f194dc0e66..79fc59caacef 100644
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
 
@@ -1369,6 +1376,101 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
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
@@ -1675,6 +1777,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
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
index 2308650e4a6e..f39edac20305 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -15,6 +15,7 @@
 #define FASTRPC_IOCTL_INIT_ATTACH_SNS	_IO('R', 8)
 #define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
 #define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)
+#define FASTRPC_IOCTL_GET_DSP_INFO	_IOWR('R', 13, struct fastrpc_ioctl_capability)
 
 /**
  * enum fastrpc_map_flags - control flags for mapping memory on DSP user process
@@ -122,4 +123,11 @@ struct fastrpc_mem_unmap {
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

