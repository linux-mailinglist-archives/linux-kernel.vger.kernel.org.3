Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1756463F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbhK3Ulk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbhK3Ulf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:41:35 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4362BC061574;
        Tue, 30 Nov 2021 12:38:16 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u11so15886261plf.3;
        Tue, 30 Nov 2021 12:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adInch71SLEMVkH+ZK5ZoRGHSjRkMo2zTe9ZpiHePds=;
        b=WbTHCokZgY0W+MXKvSmTBvy0WS1KNBp+NfAYwTjpuVaYTtosXObuHiZ01XiWdSiHC9
         brTNv8EzP66HFtVTdI7KUxvbpk2ZQATsLZAxDP89UPQz3/itRFynGrCyZnXC7dhSFCrr
         PdtUuEErKNClqeS89vCgv1T0Aq01cvLZZ919JszwvVleLQljB8Uv9gusUibq4tmQMg/r
         S4CFAjHqQegl9P/LaxBdt2HcGnSVIs5hTtKQqP8ZzSeRXAxd8oWOLRYzOyRxZgt658bq
         Ya/XCjl8Tr55SV/nnVpt8IWAeZQtEW6Xo5hxbVehbemOml0cGxoGMHpCn543MLXZLmnJ
         r2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adInch71SLEMVkH+ZK5ZoRGHSjRkMo2zTe9ZpiHePds=;
        b=tZBAJqCF+pbfmg7PfgKSwGxB4ySlUnbPUEPrdH/ARg/FPDbvRKO2huIJbPObXUVdQr
         ZJWxLU320vdc0f/Oc5pcnUlPWIZ8WzzXD3xPNLp2zN5BElrm2ZbgIkoUI5NeJsmHNsem
         AN+T6/QIzWJvOVIXUA/3tW/ooBxdFLcivxDvW32XRS+MP5L2K/uRCjnS3iuzM+kSj/jx
         piiK2s0O/W8CYnw+cBf8a/zN8mSPrzet0WfPR/aghQ4jJ0SgAgaODOKrTp378Es7qEaU
         SHgEEvaaLu2fgAYGEIt6yiwRDX/ovvxNLNMa03j1U33bhqtavZj4ht3mIFDW6I81F+xX
         RDzQ==
X-Gm-Message-State: AOAM532OEr+FnyutEWVTNsuNaeWISVVY799zAceDdsq+4hCEoD6DPry3
        NDo5j9INJSKngGwxTVq7OltruqnbpuU=
X-Google-Smtp-Source: ABdhPJz9vjrZ4xYePcRD/8BfStCL7fLuE/lAGIre094lVcas8d8WcKi5ZVNGrJExpqfW9CYEU5y8SQ==
X-Received: by 2002:a17:903:2348:b0:141:d60b:ee90 with SMTP id c8-20020a170903234800b00141d60bee90mr1890826plh.15.1638304695415;
        Tue, 30 Nov 2021 12:38:15 -0800 (PST)
Received: from 7YHHR73.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j7sm23071520pfc.74.2021.11.30.12.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:38:14 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com (supporter:QLOGIC QL41xxx ISCSI
        DRIVER), "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org (open list:QLOGIC QL41xxx ISCSI DRIVER)
Subject: [PATCH v2 2/2] scsi: qla4xxx: Format SYSFS_FLAG_FW_SEL_BOOT as byte
Date:   Tue, 30 Nov 2021 12:38:13 -0800
Message-Id: <20211130203813.12138-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130203813.12138-1-f.fainelli@gmail.com>
References: <20211130203813.12138-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qedi formats SYSFS_FLAG_FW_SEL_BOOT as a byte, and the qla4xxx driver
does exactly the same thing, align them for consistency.

Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/scsi/qla4xxx/ql4_os.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 8987acc24dac..8b2aac49782c 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -5734,7 +5734,7 @@ static ssize_t qla4xxx_show_boot_eth_info(void *data, int type, char *buf)
 
 	switch (type) {
 	case ISCSI_BOOT_ETH_FLAGS:
-		rc = sprintf(str, "%d\n", SYSFS_FLAG_FW_SEL_BOOT);
+		rc = sprintf(str, "%hhd\n", (char)SYSFS_FLAG_FW_SEL_BOOT);
 		break;
 	case ISCSI_BOOT_ETH_INDEX:
 		rc = sprintf(str, "0\n");
@@ -5843,7 +5843,7 @@ qla4xxx_show_boot_tgt_info(struct ql4_boot_session_info *boot_sess, int type,
 			     (char *)&boot_conn->chap.intr_secret);
 		break;
 	case ISCSI_BOOT_TGT_FLAGS:
-		rc = sprintf(str, "%d\n", SYSFS_FLAG_FW_SEL_BOOT);
+		rc = sprintf(str, "%hhd\n", (char)SYSFS_FLAG_FW_SEL_BOOT);
 		break;
 	case ISCSI_BOOT_TGT_NIC_ASSOC:
 		rc = sprintf(str, "0\n");
-- 
2.25.1

