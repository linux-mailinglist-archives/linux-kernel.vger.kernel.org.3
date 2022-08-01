Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF6758655F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiHAGsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiHAGro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:47:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5AD6391
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 23:46:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 23so8892867pgc.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=JAtDb2BzsZbrhrNn0Iwjw4diHPiR7j2cRNNJMQMKcFo=;
        b=adGHt2GNY2NtBhIvrMdkPDf1jxWGv0quQnTqqjQPc9ipa/ZVFndMnnqjwVmsY5bMXW
         nZdkTHoZXHXwlVWAW2sdxwW38NWkLicK8pK37a3GzwDFkqoZfmZ00um6maNoTV9PnCYr
         4G8FXomYnMVRjaNU+PfOMwp27mM+zpRj6ZN6uqIpC9XgMSmW/dUW3IzphA94q46CxQwR
         cXbsrR3HXG92aIt5r/25JNDzEH5YuLE3h1iFxFOUGGX2xA1t4rI614WJnELvXU+HpcJl
         3+c8fOEMZRcQqiQHWbzYEMfK8C5GF8YF9eVVwPRv9vMVHDQuq7sKIMAJpP8YPN1aieCc
         bv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JAtDb2BzsZbrhrNn0Iwjw4diHPiR7j2cRNNJMQMKcFo=;
        b=ahj2zwC0AMkudKdMtrFfZ8zr5zLTXan7C9bFnUtfWq0OftBCPvfR9Y5PqM7ok91J8Q
         HphCPARoFCa/V7i5CHMAes3EuPVJF3gjiw8mMqU52zXRBcoCEZ4yAcofujh6lZjBnv8C
         bKEmx1emEcf+XSfIftkUd494Iw6oYKDYR2g6vDnBOjx3bwEyYk5kR/df6hwmEMwbV6Ct
         4tlRUlRSK1LYwgKm4/ppXF9vrwoMmOD9x69fXovOrHfDKTt3GgsA/QdgHZ9phTUt1MJJ
         2q+AxgoyMlz8lVi4bpfTEOxbXHtWX/A2rQW733EHIwmtTx3ErYv9d2zsOLaDgmPRbf3l
         RDBg==
X-Gm-Message-State: AJIora/mfx2FP5rXCDnQ6+LhlPJA3K/K8ysSyuDMwfXBCKp6qcNYMVDX
        IsJmndX3CHRZIm2lNuvFfM4gag==
X-Google-Smtp-Source: AGRyM1vrF9MftH4pfwtuio+gHfJvK0ADlPo2skMM2GtEl+P10maUNds+goB13nmWHd6y9dqepW6lhg==
X-Received: by 2002:a63:1324:0:b0:419:afb2:af7b with SMTP id i36-20020a631324000000b00419afb2af7bmr12010926pgl.367.1659336410259;
        Sun, 31 Jul 2022 23:46:50 -0700 (PDT)
Received: from localhost.localdomain ([63.222.17.38])
        by smtp.gmail.com with ESMTPSA id x22-20020aa78f16000000b0052cec54e3b8sm4766853pfr.215.2022.07.31.23.46.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jul 2022 23:46:49 -0700 (PDT)
From:   margeyang <marge.yang@synaptics.corp-partner.google.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     marge.yang@tw.synaptics.com, derek.chegn@tw.synaptcs.com,
        vincent.huang@tw.synaptics.com,
        Marge Yang <marge.yang@synaptics.corp-partner.google.com>
Subject: [PATCH] Input: HID-rmi - ignore to rmi_hid_read_block after system resumes.
Date:   Mon,  1 Aug 2022 14:46:43 +0800
Message-Id: <1659336403-2546-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>

ignore to rmi_hid_read_block function once after system resumes.
Because

Signed-off-by: Marge Yang<marge.yang@synaptics.corp-partner.google.com>
---
 drivers/hid/hid-rmi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 311eee599ce9..1b038f3db0f1 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -101,7 +101,7 @@ struct rmi_data {
 };
 
 #define RMI_PAGE(addr) (((addr) >> 8) & 0xff)
-
+int ignoreonce;
 static int rmi_write_report(struct hid_device *hdev, u8 *report, int len);
 
 /**
@@ -203,7 +203,13 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 		if (ret < 0)
 			goto exit;
 	}
-
+	if (ignoreonce == 1) {
+		dev_err(&hdev->dev,
+			"ignoreonce (%d)\n",
+			ignoreonce);
+		ignoreonce = 0;
+		goto exit;
+	}
 	for (retries = 5; retries > 0; retries--) {
 		data->writeReport[0] = RMI_READ_ADDR_REPORT_ID;
 		data->writeReport[1] = 0; /* old 1 byte read count */
@@ -468,7 +474,10 @@ static int rmi_post_resume(struct hid_device *hdev)
 	ret = hid_hw_open(hdev);
 	if (ret)
 		return ret;
-
+	// Avoid to read rmi_hid_read_block once after system resumes.
+	// The interrupt will be pulled down
+	// after RMI Read command(Report ID:0x0A).
+	ignoreonce = 1;
 	ret = rmi_reset_attn_mode(hdev);
 	if (ret)
 		goto out;
-- 
2.22.0.windows.1

