Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA2058498D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiG2CFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiG2CFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:05:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0028C2654A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:05:29 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso7027682pjo.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQPxhecMMGrqgnvl1RYt1P0R5Uvv2aKASwgCAn7Phe8=;
        b=j5nWXS2yN3xRH2vvBgQIilwdiWeecYwiAszsfvGo+ZmflzeozdenVJVOoJC3cMeVft
         u8Tz3VEhWSLetIg9GQz+LzvknUDQRMDxjFVGfJY/e2dpb2EqATSyuAiRKBaABEYbHjj+
         6LtNUvOF+Q1uVxleFDiUoCe80JQv6a9RO5U9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQPxhecMMGrqgnvl1RYt1P0R5Uvv2aKASwgCAn7Phe8=;
        b=dc9e6ETonSZ3xDMu1sKnKLAb8/nJGHfVb6m4O6kqDVygGOPfn/HqXEjaQs7hKdfeBP
         aTk9ULY8DrMOr08osx5NJGtyN0PaLp9vaO81H+shokLTIhULut/ACNmRLrHGdH09vWhR
         CsjeIp0EA3jwIPzTaDBS0+KH05//rAEyzGdc2GfLrC6pNWWP5PRDq01lmdV7OzJSOAfB
         jItYPXsKfWPhwHFGn/qrATXkDBHmcryO25Hvs74f+yahtGwXqTXaH9TkOWvJYa2nsO7g
         zZzOBjzaqjpyvNXRKjjFpLk5n9zEBdcNvkKXgXhK6X2rJfh551JgH4K2Fi+/TErm6fOJ
         3TjA==
X-Gm-Message-State: ACgBeo0EdHrGrDSy8bOxEHPrFx+Q3WAY/6oZl2a1uBzTAO7W6Cv/DrU/
        aH4ZKc84BWjUlpxheqejXpbipQ==
X-Google-Smtp-Source: AA6agR7BCdlcbu27dD6NFwhWH1isDT1btrN6hUxN8jMKdBhGXsxNwG/13hDnNDx3sjS3iFqZ3ECLwA==
X-Received: by 2002:a17:902:cec1:b0:16d:c4f2:66c5 with SMTP id d1-20020a170902cec100b0016dc4f266c5mr1664693plg.20.1659060329435;
        Thu, 28 Jul 2022 19:05:29 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id y124-20020a62ce82000000b005258df7615bsm1571901pfg.0.2022.07.28.19.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 19:05:29 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniil Lunev <dlunev@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daejun Park <daejun7.park@samsung.com>,
        Eric Biggers <ebiggers@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: [PATCH v3 1/2] ufs: add function to check CRYPTO capability
Date:   Fri, 29 Jul 2022 12:05:07 +1000
Message-Id: <20220729120216.v3.1.I6b7934b96fff0d5ea22531e57c0a11f0ccd1acd8@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220729020508.4147751-1-dlunev@chromium.org>
References: <20220729020508.4147751-1-dlunev@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To align with other capability check functions.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>

 drivers/ufs/core/ufshcd-crypto.c | 8 ++++----
 drivers/ufs/host/ufs-mediatek.c  | 2 +-
 drivers/ufs/host/ufs-qcom-ice.c  | 4 ++--
 drivers/ufs/host/ufshcd-pci.c    | 2 +-
 include/ufs/ufshcd.h             | 5 +++++
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index 198360fe5e8e1..f819488bbde14 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -118,7 +118,7 @@ static int ufshcd_crypto_keyslot_evict(struct blk_crypto_profile *profile,
 
 bool ufshcd_crypto_enable(struct ufs_hba *hba)
 {
-	if (!(hba->caps & UFSHCD_CAP_CRYPTO))
+	if (!ufshcd_is_crypto_supported(hba))
 		return false;
 
 	/* Reset might clear all keys, so reprogram all the keys. */
@@ -165,7 +165,7 @@ int ufshcd_hba_init_crypto_capabilities(struct ufs_hba *hba)
 	 * hasn't advertised that crypto is supported.
 	 */
 	if (!(hba->capabilities & MASK_CRYPTO_SUPPORT) ||
-	    !(hba->caps & UFSHCD_CAP_CRYPTO))
+	    !ufshcd_is_crypto_supported(hba))
 		goto out;
 
 	hba->crypto_capabilities.reg_val =
@@ -225,7 +225,7 @@ void ufshcd_init_crypto(struct ufs_hba *hba)
 {
 	int slot;
 
-	if (!(hba->caps & UFSHCD_CAP_CRYPTO))
+	if (!ufshcd_is_crypto_supported(hba))
 		return;
 
 	/* Clear all keyslots - the number of keyslots is (CFGC + 1) */
@@ -235,6 +235,6 @@ void ufshcd_init_crypto(struct ufs_hba *hba)
 
 void ufshcd_crypto_register(struct ufs_hba *hba, struct request_queue *q)
 {
-	if (hba->caps & UFSHCD_CAP_CRYPTO)
+	if (ufshcd_is_crypto_supported(hba))
 		blk_crypto_register(&hba->crypto_profile, q);
 }
diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index beabc3ccd30b3..4bdf6a709126d 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -182,7 +182,7 @@ static int ufs_mtk_hce_enable_notify(struct ufs_hba *hba,
 			ufs_mtk_host_reset(hba);
 		}
 
-		if (hba->caps & UFSHCD_CAP_CRYPTO)
+		if (ufshcd_is_crypto_supported(hba))
 			ufs_mtk_crypto_enable(hba);
 
 		if (host->caps & UFS_MTK_CAP_DISABLE_AH8) {
diff --git a/drivers/ufs/host/ufs-qcom-ice.c b/drivers/ufs/host/ufs-qcom-ice.c
index 745e48ec598f8..180a015b6973d 100644
--- a/drivers/ufs/host/ufs-qcom-ice.c
+++ b/drivers/ufs/host/ufs-qcom-ice.c
@@ -161,7 +161,7 @@ static void qcom_ice_optimization_enable(struct ufs_qcom_host *host)
 
 int ufs_qcom_ice_enable(struct ufs_qcom_host *host)
 {
-	if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
+	if (!ufshcd_is_crypto_supported(host->hba))
 		return 0;
 	qcom_ice_low_power_mode_enable(host);
 	qcom_ice_optimization_enable(host);
@@ -189,7 +189,7 @@ int ufs_qcom_ice_resume(struct ufs_qcom_host *host)
 {
 	int err;
 
-	if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
+	if (!ufshcd_is_crypto_supported(host->hba))
 		return 0;
 
 	err = qcom_ice_wait_bist_status(host);
diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 04166bda41daa..c06ccef348065 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -89,7 +89,7 @@ static int ufs_intel_hce_enable_notify(struct ufs_hba *hba,
 				       enum ufs_notify_change_status status)
 {
 	/* Cannot enable ICE until after HC enable */
-	if (status == POST_CHANGE && hba->caps & UFSHCD_CAP_CRYPTO) {
+	if (status == POST_CHANGE && ufshcd_is_crypto_supported(hba)) {
 		u32 hce = ufshcd_readl(hba, REG_CONTROLLER_ENABLE);
 
 		hce |= CRYPTO_GENERAL_ENABLE;
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index a92271421718e..ddbf470f8f455 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1005,6 +1005,11 @@ static inline bool ufshcd_is_wb_allowed(struct ufs_hba *hba)
 	return hba->caps & UFSHCD_CAP_WB_EN;
 }
 
+static inline bool ufshcd_is_crypto_supported(struct ufs_hba *hba)
+{
+	return hba->caps & UFSHCD_CAP_CRYPTO;
+}
+
 #define ufshcd_writel(hba, val, reg)	\
 	writel((val), (hba)->mmio_base + (reg))
 #define ufshcd_readl(hba, reg)	\
-- 
2.31.0

