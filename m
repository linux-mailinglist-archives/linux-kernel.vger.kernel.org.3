Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659A7576212
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiGOMsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGOMsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:48:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B0D6C129
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:48:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso5957107pjk.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WobHjGnXEstvgY9WdzvQAd+zN5fEdHbmcar/6NVFvmg=;
        b=CGnX2SotKISaTXX/p06h0MAF5ZCZ0iIvMuo3YLy6PMGAeaRm1xyMHrMbWOZkn+nUbN
         4PA7evUzpLDzIavz/6M9ygc79bzabOHCcBrKX9YhW2vY0DL7w3aTBj1vWESoeR8rk5nC
         Yk3WFs3hBq4LTpMWms8ZQOAtuLwtWKL4g5skI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WobHjGnXEstvgY9WdzvQAd+zN5fEdHbmcar/6NVFvmg=;
        b=T8QuYP3KaYvU+85TvlxADjWiZVhhC3JMKe6dLZJoBi6hIE/VDRxClNoX0KDpv6y8XB
         8gH4tXfeOq530Z9QTlZyY7T6XSjtBuAM6mg/oOXQdSXINvSb5MID/QPmC8O1XYCDVHln
         8J2WuOWhStWSHI7jVN6g78n07MuMUcVC1MTmoDNZbi3229SfoZqGB6N5YUEHqNmN8GB+
         pqDBN0CDGHKW0sqmdkegaP9QGQBCroX3dF1G6a2/tBzBRWRZZEpqqq3ZG3FvBGUMmkHB
         tkPuhVPO/Piuws1enlp0W94XbMtP2mwmpiDZnrszfduQx4elTuWAXPhTKD/JgR8GjqI6
         dFiA==
X-Gm-Message-State: AJIora/FKLkq/NFYMDY4FgfaMM8QyMquFOtoA1g9YsiyGoMQ9qtJLW4Y
        VGFw3W5P/p0vesrQGyscrJZAcQ==
X-Google-Smtp-Source: AGRyM1uujm85L0CQUZcgqAYRbsZtc+sjUu6h8mrLFguMbPMHGLQstpqScMdP7AHPirNmcMiLV/A7zQ==
X-Received: by 2002:a17:902:988b:b0:16b:fae3:fcd5 with SMTP id s11-20020a170902988b00b0016bfae3fcd5mr14026480plp.109.1657889294789;
        Fri, 15 Jul 2022 05:48:14 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id u16-20020a170903125000b001690d398401sm3530730plh.88.2022.07.15.05.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 05:48:14 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Daniil Lunev <dlunev@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: ufs: ufs-pci: Correct check for RESET DSM
Date:   Fri, 15 Jul 2022 22:48:07 +1000
Message-Id: <20220715224722.1.I22460c4f4a9ccf2c96c3f9bb392b409926d80b2f@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dsm_fns is a bitmap, and it is 0-indexed according to the check in
__intel_dsm funciton. But common initialization was checking it as if it
was 1-indexed. The CL corrects the discrepancy. This change won't break
any existing calls to the function, since before the change both bits 0
and 1 were checked and needed to be set.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>

---

 drivers/ufs/host/ufshcd-pci.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 04166bda41daa..e54a49e64acad 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -20,6 +20,12 @@
 #include <linux/acpi.h>
 #include <linux/gpio/consumer.h>
 
+#define __INTEL_DSM_SUPPORTED(host, fn) \
+	((fn) < 32 && (fn) >= 0 && ((host)->dsm_fns & (1 << (fn))))
+
+#define INTEL_DSM_SUPPORTED(host, name) \
+	__INTEL_DSM_SUPPORTED(host, INTEL_DSM_##name)
+
 struct ufs_host {
 	void (*late_init)(struct ufs_hba *hba);
 };
@@ -71,7 +77,7 @@ static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
 static int intel_dsm(struct intel_host *intel_host, struct device *dev,
 		     unsigned int fn, u32 *result)
 {
-	if (fn > 31 || !(intel_host->dsm_fns & (1 << fn)))
+	if (!__INTEL_DSM_SUPPORTED(intel_host, fn))
 		return -EOPNOTSUPP;
 
 	return __intel_dsm(intel_host, dev, fn, result);
@@ -300,7 +306,7 @@ static int ufs_intel_device_reset(struct ufs_hba *hba)
 {
 	struct intel_host *host = ufshcd_get_variant(hba);
 
-	if (host->dsm_fns & INTEL_DSM_RESET) {
+	if (INTEL_DSM_SUPPORTED(host, RESET)) {
 		u32 result = 0;
 		int err;
 
@@ -342,7 +348,7 @@ static int ufs_intel_common_init(struct ufs_hba *hba)
 		return -ENOMEM;
 	ufshcd_set_variant(hba, host);
 	intel_dsm_init(host, hba->dev);
-	if (host->dsm_fns & INTEL_DSM_RESET) {
+	if (INTEL_DSM_SUPPORTED(host, RESET)) {
 		if (hba->vops->device_reset)
 			hba->caps |= UFSHCD_CAP_DEEPSLEEP;
 	} else {
-- 
2.31.0

