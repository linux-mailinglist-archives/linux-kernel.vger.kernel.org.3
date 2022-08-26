Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E8D5A21BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245263AbiHZHZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245253AbiHZHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:25:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6AB1B7A0;
        Fri, 26 Aug 2022 00:25:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o4so840167pjp.4;
        Fri, 26 Aug 2022 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=RfyA8eZvryHNH4HN+Dlxrz30HGArxWXNdn8L24r2LTE=;
        b=RA8iQ4VDgIFpZCF/gEPQGHfUhURzT/5vjRgMEh4MRTNfpUC69I1fJkUAlHvdyBwV+4
         paIlRSovzAqMotSqrS3tBexmymggSbxkRo9kxA0QD8/G7jkkV/l+0/+0oVqQtozrR2vc
         RS3jYpgfn3ZuTK0kJEjKbI3afrtJNcWsYkpRRQwgF6LjQozLcM/Dg33i2N88TXjHLqyY
         aZRLVwxksOX0Ypxw0z2jkd+H4HeRfO1x8WUSyIMlthV1uZT7Ebm/1QlOf7iTZejJvLBT
         XXk0kPnUGI9WdOA1+fEisQu2oi7wqQuxFstLtJg5xz8yeYZv2IbUYEmwkcsmJxS5yS1x
         8MQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=RfyA8eZvryHNH4HN+Dlxrz30HGArxWXNdn8L24r2LTE=;
        b=yJFTeVkhOjSIGuT4wGfDlNoSPZFkYk8CQddLIOGrh8bBnKZ6HAm/Ca4Ix22sfK4pja
         ngdWUGa+CT37TjUMQcLFDCSACE6Ry2TreSSAYQC34Hl4Uc1km7l5bT8LWKFAeevdQD0c
         WS6hNiwPIKUKJE6ckVP6SQ9EPt5EdimUQGQ6WHL5q8/ZHMPT3pDs3PJ6chGAsPP/QmAD
         xHQuExu6fsWBYawhj5cUDi21o5L75uX2LUngBMDXu+yRpTIKykS4/m1KFMA3PYTUTlLd
         TA/o2xqJlSKrz4QfiuPjp9WvlUcQBxqfacIs++FLfFZPeTUVr0weCiNHbES5ayVfWgKT
         tgpA==
X-Gm-Message-State: ACgBeo2wfMEhbJ6TvoXq7vdxcqCSY7pxZMzihG+Vfxs2z0E7+vrvl9LA
        vLHInaKa/lrbJQfLcSXPofM=
X-Google-Smtp-Source: AA6agR5+ym2go5XHX7sa8kb6KPUcxRMwrsMssaSyoU+DZowdmhq9FzDE+dSfgcvMAgZPkYf94appsg==
X-Received: by 2002:a17:90a:d90c:b0:1fa:c99f:757d with SMTP id c12-20020a17090ad90c00b001fac99f757dmr3094773pjv.240.1661498724641;
        Fri, 26 Aug 2022 00:25:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b00172b0272f1asm820229pls.51.2022.08.26.00.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 00:25:24 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     martin.petersen@oracle.com
Cc:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, jejb@linux.ibm.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] scsi: mpt3sas: Remove the unneeded result variable
Date:   Fri, 26 Aug 2022 07:25:20 +0000
Message-Id: <20220826072520.252845-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value _base_diag_reset() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 565339a0811d..26f5897a5c7c 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -7170,7 +7170,6 @@ static int
 _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
 {
 	u32 ioc_state;
-	int rc;
 
 	dinitprintk(ioc, ioc_info(ioc, "%s\n", __func__));
 
@@ -7216,8 +7215,7 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
 	}
 
  issue_diag_reset:
-	rc = _base_diag_reset(ioc);
-	return rc;
+	return _base_diag_reset(ioc);
 }
 
 /**
@@ -7879,7 +7877,6 @@ int
 mpt3sas_base_make_ioc_ready(struct MPT3SAS_ADAPTER *ioc, enum reset_type type)
 {
 	u32 ioc_state;
-	int rc;
 	int count;
 
 	dinitprintk(ioc, ioc_info(ioc, "%s\n", __func__));
@@ -7948,8 +7945,7 @@ mpt3sas_base_make_ioc_ready(struct MPT3SAS_ADAPTER *ioc, enum reset_type type)
 	}
 
  issue_diag_reset:
-	rc = _base_diag_reset(ioc);
-	return rc;
+	return _base_diag_reset(ioc);
 }
 
 /**
-- 
2.25.1
