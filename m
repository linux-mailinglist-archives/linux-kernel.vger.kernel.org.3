Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36A49D78D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiA0Bnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiA0Bnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:43:39 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE086C06161C;
        Wed, 26 Jan 2022 17:43:38 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id e16so1303254qtq.6;
        Wed, 26 Jan 2022 17:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vpuhvi+iwwE/QJLCqCMW57HZ6sTt2qlVnR80Ji3vsVM=;
        b=goZbK1lgMDEt1j8STF+5AIilnYJGmN8M5PRSuGiZxNDKtwuoeOLQArA75Yt1RerKQf
         /dODKUbUuQ5QLDeunk3yleLlxCZk/NeF/SNOFSrvOJYK6AKrSlQJAZamgdjEdmHxj7IQ
         2kNKQd77WGspvToW3glpY3xblvJUZkxAOMtMsJnHgmI3ksnAGXFMnbFMm+ayBl+Co5Ke
         qTuaa40rNxXs+j4PMYuS6HspjQiC5TlIAINxLNslos5syh29pufftwvhQOsctWaLwQsv
         HzdVbCFi7oKdhXS4X/TS2sWkEkcT2zuV3bypDRqHtm6YPi3lcDuaz5GVV8kJjif4kfjg
         GAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vpuhvi+iwwE/QJLCqCMW57HZ6sTt2qlVnR80Ji3vsVM=;
        b=Sd+GwC51Qa616WHlLIwY2L79kYkVo1bNP99JGAo6+8D/SIVQctMPetXTDu7F/YaYES
         yx/SLUUlESaIe+bGGoQGN4+Rwl9O77A1JNuFALipJnnglYTLNCb7Ti9Cc5N2IZ+EF1GV
         PTs/VujlG1ZfUd9DsV42fhVFJPyTq4gpNvoSIMdd1XNrFmNnsnPHiM6WEdtiyAGP43qx
         JlIjam1bZVc7V2Lqi8TVkeIcqDddBNsuWmdKZOr53f36fGGuHrZvb/ApPpYmHkofYLkj
         YxNSkL3JAK5aRjRz5peDKakDCgQscl3S+jnYaQFMKmzAw9h/vJUq2sjb2gQ7ASaUKgqH
         fbLA==
X-Gm-Message-State: AOAM530CbipcDWGMTZhJ231CNdCRwWB9tXlyapMJXW42JrfX90MTH3vK
        DbhUWZ0fKHaNuAld2sOnOQM=
X-Google-Smtp-Source: ABdhPJxOAWhoCeLNQFvSN1hTBE8eXYygB8AK17n3axEFf2rtfBDS8Cd0TDDOCIlCl5hYFxAJlKQCZg==
X-Received: by 2002:a05:622a:164a:: with SMTP id y10mr1115976qtj.629.1643247818138;
        Wed, 26 Jan 2022 17:43:38 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h189sm597574qkc.35.2022.01.26.17.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:43:37 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     james.smart@broadcom.com
Cc:     dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] lpfc: Remove redundant 'flush_workqueue()' calls
Date:   Thu, 27 Jan 2022 01:43:30 +0000
Message-Id: <20220127014330.1185114-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>

'destroy_workqueue()' already drains the queue before destroying it,
so there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index a56f01f659f8..f49ff18cb252 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -8546,7 +8546,6 @@ static void
 lpfc_unset_driver_resource_phase2(struct lpfc_hba *phba)
 {
 	if (phba->wq) {
-		flush_workqueue(phba->wq);
 		destroy_workqueue(phba->wq);
 		phba->wq = NULL;
 	}
-- 
2.25.1

