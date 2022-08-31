Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF09D5A7F82
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiHaOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiHaODo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:03:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4724D7584;
        Wed, 31 Aug 2022 07:03:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q3so10985886pjg.3;
        Wed, 31 Aug 2022 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=RKP/ZYjQ5LLZx8BdjnHeUNuUWKQLAOrkHnnLMRbIo6g=;
        b=Q3IkbhY2RfoBmt+qrOm3SlTSGuJw+s5kdmR95OQdDMohpQYqiv0JBaEm51XCr1n8+f
         FxPliqYcGW1IepktBKvaVYfMniyobeP7hi1620AmKrSI4gXaVZDjEO848kMFFsvumPvQ
         yFVnmltYYqsP0pV4OI3rD11kIaBG7XIutAHIgMAiFG11pfw4bfUAvgUIdFusPY0TCsD3
         xeT9Xw7KT91eeDMWwc6LZMXyeTvBFZBx/6/lWHyKcd8qFFfkkWKoHd5fiRed9m6Rc3LL
         UNxJdb40x7tr7FLATfr69ahY4RAjhh5CoaivucoVSzA8PeOpr/oqMdaHRJhS8xUfTtVp
         OVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=RKP/ZYjQ5LLZx8BdjnHeUNuUWKQLAOrkHnnLMRbIo6g=;
        b=GrBvqYeqzOJchxF3e/72xcvM2oUo6aGwCEMRLgiNOy+AxRPZdtET2Y9XU5cmNd7Wtu
         bJeZ1M1JDceMYhKQ83IfqyqtMd1iXC9WI/GfOCfZJk5sKm+KDIZZev47eB1yvyR14DIf
         WjUD3O06AFU0ZI29cTVB6iKRPb24gQi3Q5DoIr43r1/Gxm+3bHp/2VvOemO8AZ6Z9ew6
         77SJ3zfnub/d0VVlEdDHPHxmbVTo/1WwT1xUPCFItF9nWmZTf/hXKQ7XWZLGisXVYES9
         7DsipobAzhjcH1zvGAMdJKcM7KyID3k3fNXpZVAOseHPXVGRW7i5rX5W/wLBt0zVzpC4
         Ngnw==
X-Gm-Message-State: ACgBeo2XW/DxXg91KbrcnSWmh19yIZSFxX0FJbQNpo+W1XrMTDkfrs75
        pR7mSLS8u/IW4nwLlC4FQ88=
X-Google-Smtp-Source: AA6agR64POgYbk5BQ45tnGxc5PZdhejfTcLDwh5aFsNEC2MFKbAKuZN+r97xfhvMBYSEfNNJY0XEjw==
X-Received: by 2002:a17:903:2651:b0:173:3dc3:a19b with SMTP id je17-20020a170903265100b001733dc3a19bmr25616970plb.79.1661954611654;
        Wed, 31 Aug 2022 07:03:31 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id ik21-20020a170902ab1500b0016f057b88c9sm11627936plb.26.2022.08.31.07.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 07:03:31 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhangxuezhi3@gmail.com,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] scsi: megaraid: convert sysfs snprintf to sysfs_emit
Date:   Wed, 31 Aug 2022 22:03:25 +0800
Message-Id: <20220831140325.396295-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Fix up all sysfs show entries to use sysfs_emit

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/scsi/megaraid/megaraid_mbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index 157c3bdb50be..132de68c14e9 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -3979,7 +3979,7 @@ megaraid_mbox_app_hndl_show(struct device *dev, struct device_attribute *attr, c
 
 	app_hndl = mraid_mm_adapter_app_handle(adapter->unique_id);
 
-	return snprintf(buf, 8, "%u\n", app_hndl);
+	return sysfs_emit(buf, "%u\n", app_hndl);
 }
 
 
@@ -4048,7 +4048,7 @@ megaraid_mbox_ld_show(struct device *dev, struct device_attribute *attr, char *b
 		}
 	}
 
-	return snprintf(buf, 36, "%d %d %d %d\n", scsi_id, logical_drv,
+	return sysfs_emit(buf, "%d %d %d %d\n", scsi_id, logical_drv,
 			ldid_map, app_hndl);
 }
 
-- 
2.25.1

