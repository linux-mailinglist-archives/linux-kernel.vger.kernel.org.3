Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334A6466299
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357506AbhLBLml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357552AbhLBLmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:42:00 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38162C0613F4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:38:38 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x131so27616456pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e4KnceHWSyh2zZH+Q5Ra1eL2F8m4VYDX4eTKiilrqSA=;
        b=do+Hl0B42RklfGnUs2hZSYbOmsjKoJnjw1NOQsA9pQQPd1/2iFfcp322ICIT1YyoU0
         6xOGXB5NWZdW9siiWHjkMWIhmmEcD1dFfUOVO4WK3xh5jeSfO2JSm7YmyM3vrr+Jv+8H
         DTYPw9WuVfggJyAhasdKI3exFpguGq5+r92l+lWh2+ZICAHAcA5pAERGqvRZQZ2zLIyC
         EeGLURxApmv81TG2T2JCGuRwpVuOha9pbVPmIw8YieWrASs1LPiuaoMFXkrWTPZlcfNx
         AjXMCJhaOnR4RCSaVyP1gs4+uyG5pM9DYkNV8xo+xVpkqajvGNjiUlUNAe21JEjJrm/O
         oHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4KnceHWSyh2zZH+Q5Ra1eL2F8m4VYDX4eTKiilrqSA=;
        b=f8hrOddgrI+5JBRDzQafSz+CrGZBmH1BB/9RYOBmGjt5lMJUS1vmnigOCSE2Ua/3e3
         hGdxt/wyyCR4l8Y/nEI43QBVR8/oGGRotPQIZ2IGdt61xREGsLHl3Doo3AoFroBIThaK
         ZVkoD0/XFZYxQ+snSQO88YcdnQxWpIMqM+sNlFaW9QHZEoUWRYtOqda7jK/9OWrCqKeA
         tbSysZ9DGworlrpEd8UW0C0U9KtfQpJdM2PhvbtQX3Iq/uPGu5FgW2BYhtXyfYYQjkXa
         a9nL15QN4pykdj/g30ShT+iviB0wGIdviW10LqJH9dmxhguZQSZJ9qTQZNNpFuuKoFt5
         P6Yg==
X-Gm-Message-State: AOAM532jHTIkRM2B8y/FHGGvOn46ojR3cPjPPVqIYOlEN7v4NZIJ4m72
        b+CbHUMc/RQFTbFPV2duymSb
X-Google-Smtp-Source: ABdhPJx8BaztlDTuFsvAgCYst3hLcJqR7wBfJuRxnIHZsnq/AHZ+DFbUb7+SAk/kFqPhZANMhxXdBA==
X-Received: by 2002:a65:4381:: with SMTP id m1mr9340248pgp.248.1638445117743;
        Thu, 02 Dec 2021 03:38:37 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:38:37 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 20/20] bus: mhi: ep: Add uevent support for module autoloading
Date:   Thu,  2 Dec 2021 17:05:52 +0530
Message-Id: <20211202113553.238011-21-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uevent support to MHI endpoint bus so that the client drivers can be
autoloaded by udev when the MHI endpoint devices gets created. The client
drivers are expected to provide MODULE_DEVICE_TABLE with the MHI id_table
struct so that the alias can be exported.

The MHI endpoint reused the mhi_device_id structure of the MHI bus.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c       |  9 +++++++++
 include/linux/mod_devicetable.h |  2 ++
 scripts/mod/file2alias.c        | 10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 930b5c2005d0..42470d2a82b8 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1619,6 +1619,14 @@ void mhi_ep_driver_unregister(struct mhi_ep_driver *mhi_drv)
 }
 EXPORT_SYMBOL_GPL(mhi_ep_driver_unregister);
 
+static int mhi_ep_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
+
+	return add_uevent_var(env, "MODALIAS=" MHI_EP_DEVICE_MODALIAS_FMT,
+					mhi_dev->name);
+}
+
 static int mhi_ep_match(struct device *dev, struct device_driver *drv)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
@@ -1645,6 +1653,7 @@ struct bus_type mhi_ep_bus_type = {
 	.name = "mhi_ep",
 	.dev_name = "mhi_ep",
 	.match = mhi_ep_match,
+	.uevent = mhi_ep_uevent,
 };
 
 static int __init mhi_ep_init(void)
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index ae2e75d15b21..a85d453ebf67 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -835,6 +835,8 @@ struct wmi_device_id {
 #define MHI_DEVICE_MODALIAS_FMT "mhi:%s"
 #define MHI_NAME_SIZE 32
 
+#define MHI_EP_DEVICE_MODALIAS_FMT "mhi_ep:%s"
+
 /**
  * struct mhi_device_id - MHI device identification
  * @chan: MHI channel name
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 49aba862073e..90cda36f3159 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1380,6 +1380,15 @@ static int do_mhi_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
+/* Looks like: mhi_ep:S */
+static int do_mhi_ep_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD_ADDR(symval, mhi_device_id, chan);
+	sprintf(alias, MHI_EP_DEVICE_MODALIAS_FMT, *chan);
+
+	return 1;
+}
+
 static int do_auxiliary_entry(const char *filename, void *symval, char *alias)
 {
 	DEF_FIELD_ADDR(symval, auxiliary_device_id, name);
@@ -1496,6 +1505,7 @@ static const struct devtable devtable[] = {
 	{"tee", SIZE_tee_client_device_id, do_tee_entry},
 	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
 	{"mhi", SIZE_mhi_device_id, do_mhi_entry},
+	{"mhi_ep", SIZE_mhi_device_id, do_mhi_ep_entry},
 	{"auxiliary", SIZE_auxiliary_device_id, do_auxiliary_entry},
 	{"ssam", SIZE_ssam_device_id, do_ssam_entry},
 	{"dfl", SIZE_dfl_device_id, do_dfl_entry},
-- 
2.25.1

