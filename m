Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD765212DA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbiEJK5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240392AbiEJKzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:55:02 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A42B24C2;
        Tue, 10 May 2022 03:50:10 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t13so14318679pgn.8;
        Tue, 10 May 2022 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sclbHhVCpytXbP5B6C6SSIufZdheKQomWRC+pnC/oHY=;
        b=J83OMZaGsO5W6zKvuiaTqIx0nBsfHdG04fjk39gFIltlniK/KSRu1IMnkW3MaA1fnM
         lxQm00q9pF2NFBTvX9nslTJqF5qeojReu//XMLTgkJhEFSCXG1Q/TlVTbGZ5Pb1Qxxti
         NVsQfQ97X1VQTy1MJkTahp4HYv4XESVLxq135JTE+pKkc9HU0QxtPlHudp7kCm9W8yL0
         C2Bhvn9+mpZUGIOv62qCR6oH4DZWJOwgYxITmo0mBD1bHcqLqLzl6rbr5NGG4YjqWSzT
         aD+JlD/YafSn7b/hxhd4OhTrQw7L4nr7NGMEzdnidDeBIIlu7OOvcGl4M9Y+koIAnM4V
         K5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sclbHhVCpytXbP5B6C6SSIufZdheKQomWRC+pnC/oHY=;
        b=fgiBOicBJFxbxCTL9+2T2cyCI1TzmE46dq+0Fx63PLZO6bAH3aRbICQwFk8C0iFLfk
         uQvbu9mU/qlOJxxO2mICimuR1htDh/ZU/X+IQcLILlk3xBTw5YWbSndGW5Xoc4AxZUfO
         wbK1o7WRJyPFDyiLbg0qi9UcjuuLQu8Z9f6oahVFTymXfHmm8hB45SVxfwK4hMhTqXc1
         qEsRdNDBNpiL7uAXB/PmSX22oo6UMjrWDQA/pfvybp/n14w6E2Ra8arYEgsnYC0naP3A
         jBsvULZ4rv/nUnrK3mrb47KtPppzlRFcX/XvLgkpbKOpiMvYKVu0RlnzPRToDkHPNu7Y
         CAhg==
X-Gm-Message-State: AOAM532J79h6a61ktzQKWh1Sc+tvsqrhgMN2P71zzCikQfa8ph+xo6Iu
        MlVa6Y4LjGbcGF26dFM/lzQ=
X-Google-Smtp-Source: ABdhPJwCTtqekQA/FsLVdM36s38qq5EgyEfuY54L17XXT0Rd/L7KC9PL819Tdhgw9IMBR9aTRjoQLA==
X-Received: by 2002:a63:2114:0:b0:3c4:995c:344a with SMTP id h20-20020a632114000000b003c4995c344amr16459225pgh.125.1652179810344;
        Tue, 10 May 2022 03:50:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id hv8-20020a17090ae40800b001d9927ef1desm1499917pjb.34.2022.05.10.03.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:50:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     aradford@gmail.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] [SCSI] 3w-sas: use kobj_to_dev()
Date:   Tue, 10 May 2022 10:50:05 +0000
Message-Id: <20220510105005.1351587-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/scsi/3w-sas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index 3ebe66151dcb..8d63e642715d 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -99,7 +99,7 @@ static ssize_t twl_sysfs_aen_read(struct file *filp, struct kobject *kobj,
 				  struct bin_attribute *bin_attr,
 				  char *outbuf, loff_t offset, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host *shost = class_to_shost(dev);
 	TW_Device_Extension *tw_dev = (TW_Device_Extension *)shost->hostdata;
 	unsigned long flags = 0;
@@ -130,7 +130,7 @@ static ssize_t twl_sysfs_compat_info(struct file *filp, struct kobject *kobj,
 				     struct bin_attribute *bin_attr,
 				     char *outbuf, loff_t offset, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host *shost = class_to_shost(dev);
 	TW_Device_Extension *tw_dev = (TW_Device_Extension *)shost->hostdata;
 	unsigned long flags = 0;
-- 
2.25.1


