Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1860463F48
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbhK3Ud1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbhK3Uc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:32:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A904EC06174A;
        Tue, 30 Nov 2021 12:29:38 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so19168446pjb.5;
        Tue, 30 Nov 2021 12:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3xyw5Tvd1U5KQ1mrFO/+H0KY3EB+w3tzJoI+ZyxYe0=;
        b=hcYDeckMWL2I9E6LZxARadl13u1UWdTvnZPBOovI8S+1QyJN8E62e+MpygBRNRqHfQ
         f+alPqyPTNDGDJFwIjXgHgL87UJTCtgDAXNHIoVQr/YKyWJCZGds6u3Oa31tUhP0usQK
         kT6agYQNuhYbTok53AkXbheEbVMc8fp/rE/wG/27SK1FJcMAqTVc9raSx/NH/qyuROu5
         Cam8TLy5P8cLAat9OfjBfo9FLVQ3lsw8EvjOwGRI93WsR0IWuRguIJ5HddbZhMFhoeda
         JsMWXbHtJ0umYfcW7tux/nHXfxGlV8apHVt7IZn1ZZsTWQIAKF3/NN1JNw8WVUdVDcMs
         KwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3xyw5Tvd1U5KQ1mrFO/+H0KY3EB+w3tzJoI+ZyxYe0=;
        b=d5mnOs3h4vaL6EVhjSCIs8Fr6PXrd1QzBHmzvmvrzzV2p8pAxnpKKtiyggY3VNXcSh
         PgkAK4okH4dMIulTbtbl35OV838X4jUAKes6V7cOAdKoWsrwB4wKbyp8oGrwiak+J7H3
         kkAnDYgyzxJFjY7DxloVkbB/mDwkdDJsDlYmD50xKvGdCDBL//xqugKKfJEW57erWdXU
         X4TEYxUKcA9kUj1xaUqxUryCP4w6CVLv9kR2sdWWGI7zv/wms2ucjKQ8S2tOyVy6fB8L
         imdc6kIii1KUuXIlI7/eQ8E+mi721iZW51nqrVphBz8o4gNLr5VO8YSWtxXUkl4RJ1sj
         na5Q==
X-Gm-Message-State: AOAM532w5RSryWdT/uVlReZ6zDvPSmklakEKp4ytMvl4LOmdUSO8GgSV
        N9QVjgK93CcLETYP3d3VFf/UiJfskMs=
X-Google-Smtp-Source: ABdhPJyYtTdpo2rjgZi99lS/AoAHlX4vLGv42AIN6d50BPIq6v5WKPDZavTsZ+hCgEd7JutN5gtLHg==
X-Received: by 2002:a17:902:b712:b0:143:72b7:4096 with SMTP id d18-20020a170902b71200b0014372b74096mr1716065pls.25.1638304177673;
        Tue, 30 Nov 2021 12:29:37 -0800 (PST)
Received: from 7YHHR73.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id lw1sm3512435pjb.38.2021.11.30.12.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:29:37 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com (supporter:QLOGIC QL41xxx ISCSI
        DRIVER), "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org (open list:QLOGIC QL41xxx ISCSI DRIVER)
Subject: [PATCH 2/2] scsi: qla4xxx: Format SYSFS_FLAG_FW_SEL_BOOT as byte
Date:   Tue, 30 Nov 2021 12:29:34 -0800
Message-Id: <20211130202934.5023-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130202934.5023-1-f.fainelli@gmail.com>
References: <20211130202934.5023-1-f.fainelli@gmail.com>
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
index 8987acc24dac..39b2f833eb26 100644
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
+		rc = sprintf(str, "%hdd\n", (char)SYSFS_FLAG_FW_SEL_BOOT);
 		break;
 	case ISCSI_BOOT_TGT_NIC_ASSOC:
 		rc = sprintf(str, "0\n");
-- 
2.25.1

