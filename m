Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5E34F5059
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbiDFBWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443784AbiDEPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAB27F229
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:59:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gt4so6100758pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4shTZ7PU5hramHKN4NECwmFPWcXFMMpb2aPfmy33HgE=;
        b=DBngnlgrKnnIqGtxBXRFwa2pOrKGDqz9XBeZwnXfWodXDNrPRvHiHSWuHtqsN/GBPL
         rNnfcI9ueN7+p+IdLJQBho+rOUKDL6qDsSkuyO/OrtGqfiAAmpR/AoRTORibwOwTby+V
         MxIbbh2TQon5UytrGUKWxaRlszy5VCndkvq+c2F4CRZeE0PVOPS5SUo5aTJaQL1KnLcr
         xycx5Y6xGIDoqKSXWkCY2YF/O67J7VFHLV9EsLroc/0jMpFhMG/Tk2djb9xP2frOgPiu
         QhIHoUk8NvQ9u31nq/QcZj6fpvateKRackzCZ9EAVzT7JQs8rtvrnUcsB8kP/QxUf7eM
         Rmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4shTZ7PU5hramHKN4NECwmFPWcXFMMpb2aPfmy33HgE=;
        b=EQaAyOLDvWINu4/s1GhuyhxcsDndCcDkp4RHE4Jbd1zzqMA5i8dOucDk2UJXfxkOuc
         YSx94dvyJ0AQyFtvavHSRODM/31utToocfwOCnG1LhOczrMnDZgvWxosy+4po/F50yj9
         7rHRb+SqkLX3G/wHMwQTyKh4v8Qb1CNrmiRmbfgmDdpIIUrZulicGScO5h5mU55/DjCu
         gfbnY9FFL2ACEatrwYFs3ZurxG8C8N9fDlj+QqY8RLRh8no7dTBdFUhBjzClIufFMjf2
         A498I/ZXfEfV6pEHA6ROLLvXynxafOtsdTOfdTMP/aElD4/ahQ07gUMhS4zGSmyfo4zv
         2GrA==
X-Gm-Message-State: AOAM531Yk2Vh84gK+iiJkN1k162LV2ADDMkhj3buAhgI+71tEh/s3gsj
        K8bF8STLoxIokkaNLZv3jR36I2sCI4aW
X-Google-Smtp-Source: ABdhPJzw7quCHFDDc4DPZq4sEUm4pWI0FejBk2vFIMRckx5DZbeqgonEYwGkd2Ezr2v8MX1AcwT2mA==
X-Received: by 2002:a17:90b:1994:b0:1ca:9b45:405e with SMTP id mv20-20020a17090b199400b001ca9b45405emr4238607pjb.22.1649167176659;
        Tue, 05 Apr 2022 06:59:36 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.98])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm16785402pfi.149.2022.04.05.06.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:59:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        elder@linaro.org, mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 18/18] bus: mhi: ep: Add uevent support for module autoloading
Date:   Tue,  5 Apr 2022 19:27:54 +0530
Message-Id: <20220405135754.6622-19-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220405135754.6622-1-manivannan.sadhasivam@linaro.org>
References: <20220405135754.6622-1-manivannan.sadhasivam@linaro.org>
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

Add uevent support to MHI endpoint bus so that the client drivers can be
autoloaded by udev when the MHI endpoint devices gets created. The client
drivers are expected to provide MODULE_DEVICE_TABLE with the MHI id_table
struct so that the alias can be exported.

The MHI endpoint reused the mhi_device_id structure of the MHI bus.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c       |  9 +++++++++
 include/linux/mod_devicetable.h |  2 ++
 scripts/mod/file2alias.c        | 10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index bae5f40ec15e..40109a79017a 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1536,6 +1536,14 @@ void mhi_ep_driver_unregister(struct mhi_ep_driver *mhi_drv)
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
@@ -1562,6 +1570,7 @@ struct bus_type mhi_ep_bus_type = {
 	.name = "mhi_ep",
 	.dev_name = "mhi_ep",
 	.match = mhi_ep_match,
+	.uevent = mhi_ep_uevent,
 };
 
 static int __init mhi_ep_init(void)
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 5da5d990ff58..549590e9c644 100644
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
index 5258247d78ac..d9d6a31446ea 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1391,6 +1391,15 @@ static int do_mhi_entry(const char *filename, void *symval, char *alias)
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
 /* Looks like: ishtp:{guid} */
 static int do_ishtp_entry(const char *filename, void *symval, char *alias)
 {
@@ -1519,6 +1528,7 @@ static const struct devtable devtable[] = {
 	{"tee", SIZE_tee_client_device_id, do_tee_entry},
 	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
 	{"mhi", SIZE_mhi_device_id, do_mhi_entry},
+	{"mhi_ep", SIZE_mhi_device_id, do_mhi_ep_entry},
 	{"auxiliary", SIZE_auxiliary_device_id, do_auxiliary_entry},
 	{"ssam", SIZE_ssam_device_id, do_ssam_entry},
 	{"dfl", SIZE_dfl_device_id, do_dfl_entry},
-- 
2.25.1

