Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1204C4B368C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbiBLQlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:41:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiBLQlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:41:39 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84652B0B;
        Sat, 12 Feb 2022 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1644684094;
        bh=R3T0cPN40hlhc+uEFOnFn93H8zi9jt0XNiexXM9tl8k=;
        h=Message-ID:Subject:From:To:Date:From;
        b=kSzK7wUjfXdRH/ZSD7l2P8jLnlOFOyKa73ZwyzIbQp6qffAjrCIdHSh3CQckHKrd+
         ozTuEcpChR8uReRFUSBSA06Djl3/Br1hQKyk1i54KARJ/tHr0sWvyuILr4PVxnPbIo
         uY3Z8MF8sV5Q/JBe19eh/QiKxCZYRJjeBdJQPxtM=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 20615128075D;
        Sat, 12 Feb 2022 11:41:34 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1VXmR3mxNcNu; Sat, 12 Feb 2022 11:41:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1644684093;
        bh=R3T0cPN40hlhc+uEFOnFn93H8zi9jt0XNiexXM9tl8k=;
        h=Message-ID:Subject:From:To:Date:From;
        b=YGGYbus5beWNugGxToAWwihIyWe466KU302yAyjV2kWLGUmkgkGbiQ0ewsTxDGUmY
         xxxWwgNwEuLfu2TF4LdrTDr5zERmIy2etvBgkdQgQT3Ujmbk1jqrLp7dHTo4MPoF04
         l0V7+CAy/QnF9KFOE0lD+jiNfhRskzgAsuZ7f2KA=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 86D611280695;
        Sat, 12 Feb 2022 11:41:33 -0500 (EST)
Message-ID: <0da592e3664041ce007c287391cdb40fda2d535e.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.17-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 12 Feb 2022 11:41:32 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two minor fixes in the lpfc driver.  One changing the classification of
trace messages and the other fixing a build issue when NVME_FC is
disabled.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

James Smart (2):
      scsi: lpfc: Reduce log messages seen after firmware download
      scsi: lpfc: Remove NVMe support if kernel has NVME_FC disabled

And the diffstat:

 drivers/scsi/lpfc/lpfc.h      | 13 ++++++++++---
 drivers/scsi/lpfc/lpfc_attr.c |  4 ++--
 drivers/scsi/lpfc/lpfc_init.c |  2 +-
 drivers/scsi/lpfc/lpfc_sli.c  |  8 +++++++-
 4 files changed, 20 insertions(+), 7 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 4878c94761f9..a1e0a106c132 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1161,6 +1161,16 @@ struct lpfc_hba {
 	uint32_t cfg_hostmem_hgp;
 	uint32_t cfg_log_verbose;
 	uint32_t cfg_enable_fc4_type;
+#define LPFC_ENABLE_FCP  1
+#define LPFC_ENABLE_NVME 2
+#define LPFC_ENABLE_BOTH 3
+#if (IS_ENABLED(CONFIG_NVME_FC))
+#define LPFC_MAX_ENBL_FC4_TYPE LPFC_ENABLE_BOTH
+#define LPFC_DEF_ENBL_FC4_TYPE LPFC_ENABLE_BOTH
+#else
+#define LPFC_MAX_ENBL_FC4_TYPE LPFC_ENABLE_FCP
+#define LPFC_DEF_ENBL_FC4_TYPE LPFC_ENABLE_FCP
+#endif
 	uint32_t cfg_aer_support;
 	uint32_t cfg_sriov_nr_virtfn;
 	uint32_t cfg_request_firmware_upgrade;
@@ -1182,9 +1192,6 @@ struct lpfc_hba {
 	uint32_t cfg_ras_fwlog_func;
 	uint32_t cfg_enable_bbcr;	/* Enable BB Credit Recovery */
 	uint32_t cfg_enable_dpp;	/* Enable Direct Packet Push */
-#define LPFC_ENABLE_FCP  1
-#define LPFC_ENABLE_NVME 2
-#define LPFC_ENABLE_BOTH 3
 	uint32_t cfg_enable_pbde;
 	uint32_t cfg_enable_mi;
 	struct nvmet_fc_target_port *targetport;
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 7a7f17d71811..bac78fbce8d6 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -3978,8 +3978,8 @@ LPFC_ATTR_R(nvmet_mrq_post,
  *                    3 - register both FCP and NVME
  * Supported values are [1,3]. Default value is 3
  */
-LPFC_ATTR_R(enable_fc4_type, LPFC_ENABLE_BOTH,
-	    LPFC_ENABLE_FCP, LPFC_ENABLE_BOTH,
+LPFC_ATTR_R(enable_fc4_type, LPFC_DEF_ENBL_FC4_TYPE,
+	    LPFC_ENABLE_FCP, LPFC_MAX_ENBL_FC4_TYPE,
 	    "Enable FC4 Protocol support - FCP / NVME");
 
 /*
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index a56f01f659f8..558f7d2559c4 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -2104,7 +2104,7 @@ lpfc_handle_eratt_s4(struct lpfc_hba *phba)
 		}
 		if (reg_err1 == SLIPORT_ERR1_REG_ERR_CODE_2 &&
 		    reg_err2 == SLIPORT_ERR2_REG_FW_RESTART) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
 					"3143 Port Down: Firmware Update "
 					"Detected\n");
 			en_rn_msg = false;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 1bc0db572d9e..430abebf99f1 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -13363,6 +13363,7 @@ lpfc_sli4_eratt_read(struct lpfc_hba *phba)
 	uint32_t uerr_sta_hi, uerr_sta_lo;
 	uint32_t if_type, portsmphr;
 	struct lpfc_register portstat_reg;
+	u32 logmask;
 
 	/*
 	 * For now, use the SLI4 device internal unrecoverable error
@@ -13413,7 +13414,12 @@ lpfc_sli4_eratt_read(struct lpfc_hba *phba)
 				readl(phba->sli4_hba.u.if_type2.ERR1regaddr);
 			phba->work_status[1] =
 				readl(phba->sli4_hba.u.if_type2.ERR2regaddr);
-			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+			logmask = LOG_TRACE_EVENT;
+			if (phba->work_status[0] ==
+				SLIPORT_ERR1_REG_ERR_CODE_2 &&
+			    phba->work_status[1] == SLIPORT_ERR2_REG_FW_RESTART)
+				logmask = LOG_SLI;
+			lpfc_printf_log(phba, KERN_ERR, logmask,
 					"2885 Port Status Event: "
 					"port status reg 0x%x, "
 					"port smphr reg 0x%x, "

