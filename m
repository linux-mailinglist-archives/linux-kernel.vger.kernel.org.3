Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EB9578F30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiGSAUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiGSAUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:20:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D473A4BF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:20:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q5so10506636plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O4T2VQDxAWCrJIF9JXck1NEHm4y5ISvV3hD9xQiPuAk=;
        b=jHJtw10vDryNboN4iS1vTEDcw4++rsAMT+oMpC4qCdktpwfJXav5atwlQxJUQlAlUt
         WkrprZ+wNT5qddGI+8++AcfEe7GtK7aMNOtCSRqWmp5bzm2S+AwgyFmatEA+Bi7ns53V
         u2S4UeWl/z22mWLYSEgXP17ktwllvML1VWN3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O4T2VQDxAWCrJIF9JXck1NEHm4y5ISvV3hD9xQiPuAk=;
        b=Za8j1iRbQdRGnCRaihRRl5DWMIKQmUtNaYGSA+OLMFi9nyoTExjkjODI92YSW8OMgf
         2rrtkY+w3kQeTaxOjroiNaEYiPdXr+D2q/coGNLTv9Q8MKhzBtdpClBtTQ2RgdEyXgbS
         fZpN4rUdqzhQESb8/AitiyeYF4rGbupORe4s1V/y0WoPj2C0O14pUcl5KAU+KUjhJ3F1
         DG5Mb54YoS+hnKh/093dNug4VCYkMK3s4QJ4ZVuGTqBV1dxAyMO0BbgiM3MG1kmK3AxI
         +MtOxGyYK0zQEsXFQCgOrKNwJYe8leMtJc8CG7FxWpCzJ+Z/QUmw6Sx937oFhHZU5HfL
         Lfaw==
X-Gm-Message-State: AJIora/ZTOfMob0jc3XfgyiRPf4c5tU9tfW8MUjbDsRAPOdFF0ndCjI8
        +PJjekJbzbqi/CUaJwr0L1K0Dg==
X-Google-Smtp-Source: AGRyM1vF7G9VIj7hNbh/uQX4M+nAU6jRINRgeMGqfALml7DCCkNmCtqF4Gk9efWCuSb0ZblQJ/RjNw==
X-Received: by 2002:a17:90a:f404:b0:1f1:fd63:281a with SMTP id ch4-20020a17090af40400b001f1fd63281amr705772pjb.158.1658190005301;
        Mon, 18 Jul 2022 17:20:05 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027e4800b0016cbb46806asm9075813pln.278.2022.07.18.17.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 17:20:04 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Daniil Lunev <dlunev@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH v2] scsi: ufs: ufs-pci: Correct check for RESET DSM
Date:   Tue, 19 Jul 2022 10:19:54 +1000
Message-Id: <20220719101903.v2.1.I22460c4f4a9ccf2c96c3f9bb392b409926d80b2f@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v2:
* Make __INTEL_DSM_SUPPORTED a function
* use `1u` instead of `1` in shift operator

 drivers/ufs/host/ufshcd-pci.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 04166bda41daa..c13c31c2ae793 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -24,7 +24,7 @@ struct ufs_host {
 	void (*late_init)(struct ufs_hba *hba);
 };
 
-enum {
+enum intel_ufs_dsm_func_id {
 	INTEL_DSM_FNS		=  0,
 	INTEL_DSM_RESET		=  1,
 };
@@ -42,6 +42,15 @@ static const guid_t intel_dsm_guid =
 	GUID_INIT(0x1A4832A0, 0x7D03, 0x43CA,
 		  0xB0, 0x20, 0xF6, 0xDC, 0xD1, 0x2A, 0x19, 0x50);
 
+static bool __intel_dsm_supported(struct intel_host *host,
+				   enum intel_ufs_dsm_func_id fn)
+{
+	return fn < 32 && fn >= 0 && (host->dsm_fns & (1u << fn));
+}
+
+#define INTEL_DSM_SUPPORTED(host, name) \
+	__intel_dsm_supported(host, INTEL_DSM_##name)
+
 static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
 		       unsigned int fn, u32 *result)
 {
@@ -71,7 +80,7 @@ static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
 static int intel_dsm(struct intel_host *intel_host, struct device *dev,
 		     unsigned int fn, u32 *result)
 {
-	if (fn > 31 || !(intel_host->dsm_fns & (1 << fn)))
+	if (!__intel_dsm_supported(intel_host, fn))
 		return -EOPNOTSUPP;
 
 	return __intel_dsm(intel_host, dev, fn, result);
@@ -300,7 +309,7 @@ static int ufs_intel_device_reset(struct ufs_hba *hba)
 {
 	struct intel_host *host = ufshcd_get_variant(hba);
 
-	if (host->dsm_fns & INTEL_DSM_RESET) {
+	if (INTEL_DSM_SUPPORTED(host, RESET)) {
 		u32 result = 0;
 		int err;
 
@@ -342,7 +351,7 @@ static int ufs_intel_common_init(struct ufs_hba *hba)
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

