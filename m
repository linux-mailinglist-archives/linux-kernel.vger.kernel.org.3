Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6122B46E81F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbhLIMKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbhLIMKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:10:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2FEC0617A2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:07:06 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so5113830wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 04:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GVy3kw2MsX9UWqnGpqrMN8vYulNw+SaMrz5nhq885Z4=;
        b=WTnDB7HzmrgOQ7DpSpH5AwOAzSsWvNuZGEGwak5JdtOFXTIkDfwmvE4xwqUkLfHL6Y
         hn7RadDuArs4m9U6g6eoHrpIT1h4CZXJ5PK0mTB/+GpVwluRxvpaJvOLFsToitcqTU0i
         rwmrYqTX+fC6TDEfwKUcMJ3TsEdMSk25Pcxrq97vhrjI8dcl1BehGsvXdVEanZKw1fv8
         Ld5gT5FuhvflHi505poG39/kNhwzKKHacUwmyvn24EN035SKY20XE5Cy+OZPBuWrh1/j
         2K5Dv+fY00YSWUR8qk26+ChWfbHUYdAFhcPEjoKHoKQiiUOYfTuWzDDwQsdELZ/Ps2ld
         O+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GVy3kw2MsX9UWqnGpqrMN8vYulNw+SaMrz5nhq885Z4=;
        b=smKNr23kUbmL6cQOUv/abk5C4aqEckPABS3tzjiq6cVM0bN97OF1qrDd+33sSYZNp0
         GCDrAIQ5dj+qVn62D0yxTzdqrcTZoMr73EWg1VTBpAPrRqxJUZPxs9Mjskg6aglfnts3
         htKPWrz0VdtAO9UZJMPMvAOYN96aV53k4KdSFp9InQDtlXbliNAN0oxfQ4MZP4mcDLUc
         pdem5N3c3rRpvjWzGkyLdMT3DT23PT8aFOP+ROEJvPw/2k1TIkFlNeyy93hTXR3yxXlp
         yFcSADDDSEsEI66SHo0LIeRz7LQPiWuHzKMYF1potQY+JeQmTa5VxCSTiw23qHt/ZGSd
         E2Rg==
X-Gm-Message-State: AOAM532CV/5JuujGoBPZjZouuebGQj7vLGQFCIUJLvnU8Ep6tm0z3cuC
        skZtfCKZ9x3EHKtkj9K8Lc6NfA==
X-Google-Smtp-Source: ABdhPJyTCI4j782eQfJAjJLFQ/WeEnMZ/efy0KxRCPHDwXbqrvs96tML1sTy4UmCtPPeShDwJgtqxA==
X-Received: by 2002:a1c:3546:: with SMTP id c67mr6509373wma.43.1639051624409;
        Thu, 09 Dec 2021 04:07:04 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 4sm7513289wrz.90.2021.12.09.04.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 04:07:03 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        jeyr@codeaurora.org, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 7/8] misc: fastrpc: check before loading process to the DSP
Date:   Thu,  9 Dec 2021 12:06:25 +0000
Message-Id: <20211209120626.26373-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
References: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/misc/fastrpc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 50f8e23b6b04..898c30a60902 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -243,6 +243,7 @@ struct fastrpc_channel_ctx {
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
 	bool secure;
+	bool unsigned_support;
 };
 
 struct fastrpc_device {
@@ -263,6 +264,7 @@ struct fastrpc_user {
 
 	int tgid;
 	int pd;
+	bool is_secure_dev;
 	/* Lock for lists */
 	spinlock_t lock;
 	/* lock for allocations */
@@ -1049,6 +1051,24 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
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
@@ -1068,6 +1088,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		u32 siglen;
 	} inbuf;
 	u32 sc;
+	bool unsigned_module = false;
 
 	args = kcalloc(FASTRPC_CREATE_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
 	if (!args)
@@ -1078,6 +1099,14 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
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
@@ -1277,6 +1306,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	INIT_LIST_HEAD(&fl->user);
 	fl->tgid = current->tgid;
 	fl->cctx = cctx;
+	fl->is_secure_dev = fdevice->secure;
 
 	fl->sctx = fastrpc_session_alloc(cctx);
 	if (!fl->sctx) {
@@ -1945,11 +1975,14 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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
-- 
2.21.0

