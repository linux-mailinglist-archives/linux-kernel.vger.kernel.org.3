Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2020B467FEE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 23:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383340AbhLCWhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 17:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbhLCWhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 17:37:19 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE43FC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 14:33:54 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so3667108pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 14:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxn3E5FIZrGG1Dek5TMCFjZeoamV2W9EP0jmGacPohA=;
        b=McDPtM9zZvo+F5JE9K+RkNtlp5CDtBqgXSmfQQDk0O9NCPxxo63BAs0bWfybRqyxve
         m0KamXXLSvq066I2Thy3ztetrACxknOpSLQGPQqIYIOKSCKStWDkbRu13K/nFW0VRQtY
         KR/wygMBw0bm9/bVGZm5bgwQYTHvVg53fd8G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxn3E5FIZrGG1Dek5TMCFjZeoamV2W9EP0jmGacPohA=;
        b=LygsAR5pFSzz9JufdiZJGCgSQ93LLTx8OwIEmKd2AesInV38TpQP8Mm/7bAd0FHE2E
         omKngMlT9bX7nFrOg659CQTbjkpXLmAQRwLt6o+af7/OaDoVxG5ZKwcFg1rrdOrbQBPK
         avjjxFIP7FdUD8usLg56toA1/P67CfFN3wcjMS0Bc7vEge+4ZJhZgCSyrOX8g0/XkHpD
         068CVBtsoEHhsd8sXGfoICbAT4EZ9M6JVYwH5rCkkvoFZFtZN+hxsMoKqQBAFARltmFY
         jQADPMMT5ZQHOHf3RbqRxy1jNJ2fiszF8aeopbPQLAtCemrZHhAk8Id6atoswl2Tqgq0
         PU7A==
X-Gm-Message-State: AOAM531im/hR7GtZh5SZBbq1qwF9Lu4sTLm/a1Hwua0ByLGOP9UoXJes
        md+B0NKAZPhtZxAhnplhPht/3A==
X-Google-Smtp-Source: ABdhPJx+5dMhzqSKbSCTXdtrBIbYG1TjgBmVrqJ39tkxMQfbp9lexskmG+JM+fqN8uuKe4B6mAbOhA==
X-Received: by 2002:a17:90a:c58f:: with SMTP id l15mr17401146pjt.168.1638570834131;
        Fri, 03 Dec 2021 14:33:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o2sm4325544pfu.206.2021.12.03.14.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:33:53 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     James Smart <james.smart@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: lpfc: Use struct_group to isolate cast to larger object
Date:   Fri,  3 Dec 2021 14:33:51 -0800
Message-Id: <20211203223351.107323-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4935; h=from:subject; bh=3ujeJ853GEHrNwcPROcKZGxG4bNcGgUY38A0ST8Z0Q8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhqptPDw5GHAHawCc3G5drUz/gYi6RXd5eODsGaYJq LFHLDrGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYaqbTwAKCRCJcvTf3G3AJnlgD/ wK0qWSUalSbhJNesL0o31XLqpdq6zXARTcteXsknu6QgrUbVQgbH9ir7fvt+ZJMlZ3gh6kuktYqVHt n5e0lRg3Z3+IdzAf78JyJCfGOEtSAT7i3ZzY3POreqORI89IZoDKatZSglw5r8JDwcXGteYUtKhHDW 9AtAWFwqfdTUTXqY6icRDvNoEDg0c/KShS1yx7aeZc2GmMTT4YF70ffRe3yqQ9JVjtqRHPKjK4YLXp 8AooLfkj/nOHkRSNzXzZNZ8zpbIo79Gpg4px4Lrxr4fkPwhU0vtSQJhVqlpaR65PcVVVCl6NWZWOc4 efntlxoCcMiWLxfO2x2jYQmTZCR4FPWjYc1uGiZklT3WJ3NKXoKBeR7hsnYDqRX4OQe+3n1abN663+ 7yZpbm/EsWEjXbKjC1E6nODSNHiZx9lkQ5hau1E95eYnrG9+Mv10o2QGY0h2Akeh0Ipidlh37blv0c cj84UtCqT5tvZS7bwUQSQGTJkTN/YRKGHs7hQOhRSDoHGg+qw17ONoLYPVagogRsoXRY+KrNYtynQ2 cZQESquYcvHR4xsLEhTi/lAtHY8hiayp22D3bdTejWyPDjF9FQFk/ATt5JNMZoH3SOByNI9zgYdgrb hQGHLMZaZByseQEz8NNYB6RxlBhIrUTTxngAUlLxDi8cmiBvNRhIkjQJDpHw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building under -Warray-bounds, a warning is generated when casting
a u32 into MAILBOX_t (which is larger). This warning is conservative, but
it's not an unreasonable change to make to improve future robustness. Use
a tagged struct_group that can refer to either the specific fields or
the first u32 separately, silencing this warning:

drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_reset_barrier':
drivers/scsi/lpfc/lpfc_sli.c:4787:29: error: array subscript 'MAILBOX_t[0]' is partly outside array bounds of 'volatile uint32_t[1]' {aka 'volatile unsigned int[1]'} [-Werror=array-bounds]
 4787 |         ((MAILBOX_t *)&mbox)->mbxCommand = MBX_KILL_BOARD;
      |                             ^~
drivers/scsi/lpfc/lpfc_sli.c:4752:27: note: while referencing 'mbox'
 4752 |         volatile uint32_t mbox;
      |                           ^~~~

There is no change to the resulting executable instruction code.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/lpfc/lpfc_hw.h  | 27 +++++++++++++++++----------
 drivers/scsi/lpfc/lpfc_sli.c | 32 +++++++++++++++-----------------
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_hw.h b/drivers/scsi/lpfc/lpfc_hw.h
index 634f8fff7425..f0ce8404223a 100644
--- a/drivers/scsi/lpfc/lpfc_hw.h
+++ b/drivers/scsi/lpfc/lpfc_hw.h
@@ -3675,19 +3675,26 @@ union sli_var {
 };
 
 typedef struct {
+	struct_group_tagged(MAILBOX_word0, bits,
+		union {
+			struct {
 #ifdef __BIG_ENDIAN_BITFIELD
-	uint16_t mbxStatus;
-	uint8_t mbxCommand;
-	uint8_t mbxReserved:6;
-	uint8_t mbxHc:1;
-	uint8_t mbxOwner:1;	/* Low order bit first word */
+				uint16_t mbxStatus;
+				uint8_t mbxCommand;
+				uint8_t mbxReserved:6;
+				uint8_t mbxHc:1;
+				uint8_t mbxOwner:1;	/* Low order bit first word */
 #else	/*  __LITTLE_ENDIAN_BITFIELD */
-	uint8_t mbxOwner:1;	/* Low order bit first word */
-	uint8_t mbxHc:1;
-	uint8_t mbxReserved:6;
-	uint8_t mbxCommand;
-	uint16_t mbxStatus;
+				uint8_t mbxOwner:1;	/* Low order bit first word */
+				uint8_t mbxHc:1;
+				uint8_t mbxReserved:6;
+				uint8_t mbxCommand;
+				uint16_t mbxStatus;
 #endif
+			};
+			u32 word0;
+		};
+	);
 
 	MAILVARIANTS un;
 	union sli_var us;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 77dfe293bf23..8b3698032570 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -4749,7 +4749,7 @@ void lpfc_reset_barrier(struct lpfc_hba *phba)
 {
 	uint32_t __iomem *resp_buf;
 	uint32_t __iomem *mbox_buf;
-	volatile uint32_t mbox;
+	volatile struct MAILBOX_word0 mbox;
 	uint32_t hc_copy, ha_copy, resp_data;
 	int  i;
 	uint8_t hdrtype;
@@ -4783,13 +4783,13 @@ void lpfc_reset_barrier(struct lpfc_hba *phba)
 		phba->pport->stopped = 1;
 	}
 
-	mbox = 0;
-	((MAILBOX_t *)&mbox)->mbxCommand = MBX_KILL_BOARD;
-	((MAILBOX_t *)&mbox)->mbxOwner = OWN_CHIP;
+	mbox.word0 = 0;
+	mbox.mbxCommand = MBX_KILL_BOARD;
+	mbox.mbxOwner = OWN_CHIP;
 
 	writel(BARRIER_TEST_PATTERN, (resp_buf + 1));
 	mbox_buf = phba->MBslimaddr;
-	writel(mbox, mbox_buf);
+	writel(mbox.word0, mbox_buf);
 
 	for (i = 0; i < 50; i++) {
 		if (lpfc_readl((resp_buf + 1), &resp_data))
@@ -4810,12 +4810,12 @@ void lpfc_reset_barrier(struct lpfc_hba *phba)
 			goto clear_errat;
 	}
 
-	((MAILBOX_t *)&mbox)->mbxOwner = OWN_HOST;
+	mbox.mbxOwner = OWN_HOST;
 	resp_data = 0;
 	for (i = 0; i < 500; i++) {
 		if (lpfc_readl(resp_buf, &resp_data))
 			return;
-		if (resp_data != mbox)
+		if (resp_data != mbox.word0)
 			mdelay(1);
 		else
 			break;
@@ -5091,9 +5091,8 @@ lpfc_sli4_brdreset(struct lpfc_hba *phba)
 static int
 lpfc_sli_brdrestart_s3(struct lpfc_hba *phba)
 {
-	MAILBOX_t *mb;
+	volatile struct MAILBOX_word0 mb;
 	struct lpfc_sli *psli;
-	volatile uint32_t word0;
 	void __iomem *to_slim;
 	uint32_t hba_aer_enabled;
 
@@ -5110,24 +5109,23 @@ lpfc_sli_brdrestart_s3(struct lpfc_hba *phba)
 			(phba->pport) ? phba->pport->port_state : 0,
 			psli->sli_flag);
 
-	word0 = 0;
-	mb = (MAILBOX_t *) &word0;
-	mb->mbxCommand = MBX_RESTART;
-	mb->mbxHc = 1;
+	mb.word0 = 0;
+	mb.mbxCommand = MBX_RESTART;
+	mb.mbxHc = 1;
 
 	lpfc_reset_barrier(phba);
 
 	to_slim = phba->MBslimaddr;
-	writel(*(uint32_t *) mb, to_slim);
+	writel(mb.word0, to_slim);
 	readl(to_slim); /* flush */
 
 	/* Only skip post after fc_ffinit is completed */
 	if (phba->pport && phba->pport->port_state)
-		word0 = 1;	/* This is really setting up word1 */
+		mb.word0 = 1;	/* This is really setting up word1 */
 	else
-		word0 = 0;	/* This is really setting up word1 */
+		mb.word0 = 0;	/* This is really setting up word1 */
 	to_slim = phba->MBslimaddr + sizeof (uint32_t);
-	writel(*(uint32_t *) mb, to_slim);
+	writel(mb.word0, to_slim);
 	readl(to_slim); /* flush */
 
 	lpfc_sli_brdreset(phba);
-- 
2.30.2

