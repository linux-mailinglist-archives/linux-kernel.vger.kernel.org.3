Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1D44B55B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356226AbiBNQKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:10:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356178AbiBNQKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:10:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599C960A9B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:16 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o24so25023911wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DztJO97aqInKy8RoGrM0GgJtSrEI063H7In9hCcYS4s=;
        b=flRkqFamPhmYMaud+csSjyhpRtWVTtzd/maWjPMBX1M7UrcTP3IOExesNmbK531ck/
         SpqziqteVXZ2HqMHs1yVRyykcwcyzurQH3Qsdpv729NYYMqgOJQCk74qTpneXdbaFnYf
         4uZ/pgGjHbC87Qq7jLmv0PFKiStFvj7StmHoSiqOjVbt60ae9PY2w1XU429468OW+UmJ
         B7cqwxEjw9cBs+8PZ9YImTEDMbWn0OaEaGwfAnnaTMVMh/9UWLfUiDMIPK9EjHd81JQI
         Ii+WET1zWkBJGQ386+yFt96vAg45EDH07hJFpXHPEVsRdctC2b4PP9KdBFOQSnzbkiVt
         uCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DztJO97aqInKy8RoGrM0GgJtSrEI063H7In9hCcYS4s=;
        b=xw7XySciRX236CirhKkQ2dGMlqwLGWxf1QapllL7wkeGmZXXdagFSAglSdhq1EvX6i
         7+dS06VsPlH8u71DGB0u/neYVQGNjKmgW8XxMEE4R6X/uiYKuSwzHeR3bdUaZmaQGmUO
         BjsC495O7dR67Ls0/V6DqH0zR/T8fV8eJl5F9zZFRs/MFI/aAmf7C1upXzuHVWTjbUh0
         DTDYAjgZkP8SgAKPd3EB7j8Y/Eutdp7ALm2iTa3s3EnUzL3fVV1aaXg6sqFcQ39dTJJc
         oRPqm88T3xCquJPjN5O2LQfOdPww4w1M0z0oOVcTi/1eNys+kCOsZs9ZOGZZkgnyJgLV
         plgg==
X-Gm-Message-State: AOAM530HdH1KI3XCjfbCV+hhqtn4PRfwvA/FrAI/xCNyhM/0PJZtNFtY
        z0VdE+ph+e7gGSO7qdPYXAAoRA==
X-Google-Smtp-Source: ABdhPJzubkBt7KoUK7d67Yx5Ymj6KZ2kx2SuQIBLIGpvkWH1Qdp6TBXYAsov4LOb3rpkHaVtrebGKg==
X-Received: by 2002:adf:e0c3:: with SMTP id m3mr279545wri.216.1644855014909;
        Mon, 14 Feb 2022 08:10:14 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id k28sm13677022wms.23.2022.02.14.08.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:10:14 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, Jeya R <jeyr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 06/12] misc: fastrpc: check before loading process to the DSP
Date:   Mon, 14 Feb 2022 16:09:56 +0000
Message-Id: <20220214161002.6831-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220214161002.6831-1-srinivas.kandagatla@linaro.org>
References: <20220214161002.6831-1-srinivas.kandagatla@linaro.org>
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

From: Jeya R <jeyr@codeaurora.org>

Reject session if DSP domain is secure, device node is non-secure and signed
PD is requested. Secure device node can access DSP without any restriction.

Unsigned PD offload is only allowed for the DSP domain that can support
unsigned offloading.

Signed-off-by: Jeya R <jeyr@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c      | 33 +++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h | 17 +++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index af8bb4bd0cb3..5329d69ecd38 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -244,6 +244,7 @@ struct fastrpc_channel_ctx {
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
 	bool secure;
+	bool unsigned_support;
 };
 
 struct fastrpc_device {
@@ -264,6 +265,7 @@ struct fastrpc_user {
 
 	int tgid;
 	int pd;
+	bool is_secure_dev;
 	/* Lock for lists */
 	spinlock_t lock;
 	/* lock for allocations */
@@ -1052,6 +1054,24 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	return err;
 }
 
+static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_request)
+{
+	/* Check if the device node is non-secure and channel is secure*/
+	if (!fl->is_secure_dev && fl->cctx->secure) {
+		/*
+		 * Allow untrusted applications to offload only to Unsigned PD when
+		 * channel is configured as secure and block untrusted apps on channel
+		 * that does not support unsigned PD offload
+		 */
+		if (!fl->cctx->unsigned_support || !unsigned_pd_request) {
+			dev_err(&fl->cctx->rpdev->dev, "Error: Untrusted application trying to offload to signed PD");
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static int fastrpc_init_create_process(struct fastrpc_user *fl,
 					char __user *argp)
 {
@@ -1071,6 +1091,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		u32 siglen;
 	} inbuf;
 	u32 sc;
+	bool unsigned_module = false;
 
 	args = kcalloc(FASTRPC_CREATE_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
 	if (!args)
@@ -1081,6 +1102,14 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		goto err;
 	}
 
+	if (init.attrs & FASTRPC_MODE_UNSIGNED_MODULE)
+		unsigned_module = true;
+
+	if (is_session_rejected(fl, unsigned_module)) {
+		err = -ECONNREFUSED;
+		goto err;
+	}
+
 	if (init.filelen > INIT_FILELEN_MAX) {
 		err = -EINVAL;
 		goto err;
@@ -1280,6 +1309,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	INIT_LIST_HEAD(&fl->user);
 	fl->tgid = current->tgid;
 	fl->cctx = cctx;
+	fl->is_secure_dev = fdevice->secure;
 
 	fl->sctx = fastrpc_session_alloc(cctx);
 	if (!fl->sctx) {
@@ -1951,11 +1981,14 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	case ADSP_DOMAIN_ID:
 	case MDSP_DOMAIN_ID:
 	case SDSP_DOMAIN_ID:
+		/* Unsigned PD offloading is only supported on CDSP*/
+		data->unsigned_support = false;
 		err = fastrpc_device_register(rdev, data, secure_dsp, domains[domain_id]);
 		if (err)
 			goto fdev_error;
 		break;
 	case CDSP_DOMAIN_ID:
+		data->unsigned_support = true;
 		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
 		err = fastrpc_device_register(rdev, data, true, domains[domain_id]);
 		if (err)
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 7cc9d342078a..f39edac20305 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -46,6 +46,23 @@ enum fastrpc_map_flags {
 	FASTRPC_MAP_MAX,
 };
 
+enum fastrpc_proc_attr {
+	/* Macro for Debug attr */
+	FASTRPC_MODE_DEBUG		= (1 << 0),
+	/* Macro for Ptrace */
+	FASTRPC_MODE_PTRACE		= (1 << 1),
+	/* Macro for CRC Check */
+	FASTRPC_MODE_CRC		= (1 << 2),
+	/* Macro for Unsigned PD */
+	FASTRPC_MODE_UNSIGNED_MODULE	= (1 << 3),
+	/* Macro for Adaptive QoS */
+	FASTRPC_MODE_ADAPTIVE_QOS	= (1 << 4),
+	/* Macro for System Process */
+	FASTRPC_MODE_SYSTEM_PROCESS	= (1 << 5),
+	/* Macro for Prvileged Process */
+	FASTRPC_MODE_PRIVILEGED		= (1 << 6),
+};
+
 struct fastrpc_invoke_args {
 	__u64 ptr;
 	__u64 length;
-- 
2.21.0

