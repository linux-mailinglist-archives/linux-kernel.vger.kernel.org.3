Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAEB480844
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhL1KMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhL1KLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:11:51 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF74FC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:50 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q16so37389616wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHOLXaWQQuVn3Qf7fYQiZFpLvUeZKWbm7r3R3sqCc7Y=;
        b=EfNEhmYPDYfRJMzTVmnUk+4T+4YdcsHb6j4U8R1A5SLZ5iZcKWvYVTJrbwjdY0CPBW
         7Djwf7VOnDTVdF2wfhn+m9PQUG/cKPBYGSwiotAPF+ClRD1d7YhAPsfm9nG2TyQ9odZ7
         Og2ot7eDSXx9GVd/QTqXCRkjSkbSfF4fC3jAtXUpRAiBLpWGinMWSeqR7eTvPg9DhGFc
         mB1bG85/gvxBAF5/5ma5UFMASofHiVWf4F4f65cknpje5XuCmg99A86TC6n2Tp7a6EZo
         p3uwwhs8VtolJ1PfbvAVW90EKYje6my6/2JPM9RYQjM8CNLbsHlTXJZB2lkMVuOeQcTV
         BTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NHOLXaWQQuVn3Qf7fYQiZFpLvUeZKWbm7r3R3sqCc7Y=;
        b=z1E9mml37MTD5TkGkDBNhBOf6ygBIMpofqs5CoLYrsukibVWIeUZFfsCFfCus3MsVZ
         kzTBrDiqJ/uaXd+1U+QmB62iXOpBCbOPPvTsC+O0flQVMizBZ1dYaOpdegT49hdvKYJd
         z0dzxQt4h3a83Z5IOVGjWDT5YxZ58TQsWt28q8y2QjEn0NvwRfleX9jwZomXUJw4iFEm
         sKsyX4PkfRkWf5yYwSjBx8QY8RrLBp7NPU51YuT3BLWsHmUgO5LcAFXBkgUep0Kk8j79
         sVwXEk5YT2VXxJyRFwqS7uAHoYVy34/ggUlzV7x9RDkFA2FPzp1KGL3XU9KvcYyhAyD4
         ITiw==
X-Gm-Message-State: AOAM530ciN1tq9SakM61P6K4sU/iI8TknLpeDAxq9ohv4kideIR1tj10
        /9WEVX3f1XulkrBCHrhWXQ0=
X-Google-Smtp-Source: ABdhPJwZ+lqpBiYIB5ZFvjbQJtjep5ZCDkTFZ4edGi4ROMKQ8uo2QERUWbYH2HHO14o+Axo/hHJ85Q==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr15755165wrw.220.1640686309622;
        Tue, 28 Dec 2021 02:11:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id d62sm21160984wmd.3.2021.12.28.02.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:11:49 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/10] staging: r8188eu: RSSI_test is always false
Date:   Tue, 28 Dec 2021 11:11:19 +0100
Message-Id: <20211228101120.9120-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211228101120.9120-1-straube.linux@gmail.com>
References: <20211228101120.9120-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field RSSI_test of struct odm_dm_struct is never set. It stays
at the default value 0. Remove it and remove a related if test that
is always true.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 6 ++----
 drivers/staging/r8188eu/include/odm.h      | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 9de16383cb2d..7509e3c3f418 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -358,10 +358,8 @@ void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
 			struct odm_per_pkt_info *pPktinfo,
 			struct adapter *adapt)
 {
-	odm_RxPhyStatus92CSeries_Parsing(dm_odm, pPhyInfo, pPhyStatus,
-					 pPktinfo, adapt);
-	if (!dm_odm->RSSI_test)
-		odm_Process_RSSIForDM(dm_odm, pPhyInfo, pPktinfo);
+	odm_RxPhyStatus92CSeries_Parsing(dm_odm, pPhyInfo, pPhyStatus, pPktinfo, adapt);
+	odm_Process_RSSIForDM(dm_odm, pPhyInfo, pPktinfo);
 }
 
 enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm,
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index a037d7b863fb..c07dbf763903 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -468,7 +468,6 @@ struct odm_dm_struct {
 	struct rtl_ps	DM_PSTable;
 	struct false_alarm_stats FalseAlmCnt;
 	struct sw_ant_switch DM_SWAT_Table;
-	bool		RSSI_test;
 
 	struct edca_turbo DM_EDCA_Table;
 
-- 
2.34.1

