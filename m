Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560C75A7E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiHaNJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiHaNJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:09:25 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14251C123F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:09:25 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id b196so3772577pga.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kp1PmfqF0t5rCL2pbKIeox0k0hYhF9ugcgZt5plxr1Y=;
        b=iAyVaBUPi2LQe9XP1c9uFWbiBrc9ngXycMzYbemaKEhzEAmUi9fHu5bqiWurmmmNd6
         xY7BEjvM5GFleXIEGWNFPSM83Nnp8+IFSq7ao5amlGDjOzTkpqGrjzrrXNO6GwMFy1tr
         IvV2hf4UGa+sjkZnFB+dnHYsd7fewwBuKhcm4oH2t65JOc0bX4ARcvRRpnorlaD/MphQ
         mOdvbLCqvKhGbYMNEwiKCVRj2MfCldLfzFzz4Gy+n3oiWfKxWiFWkQu5pKTKe4sEk8JO
         jLGPnpczkzjgYszfWGz/QtSbcFXnt9/p8LEMADRZkZCUGKfAmTpLLwoxH13IBqiEhyl1
         Tw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kp1PmfqF0t5rCL2pbKIeox0k0hYhF9ugcgZt5plxr1Y=;
        b=tY89t00yS4lNHpcyoB0bIvSELqPdIiCXoPU8UEg4pUJ7heAjkWVCRims7OWkoCRCk3
         +7kTQIPJA9/2SNMEd86bHHkGl5RzCWIA8HgR69gaMkpxtT4zqWQP4U/XQZsPHQQ1OQF3
         YFylg6yzTWEKShubHNui/rQSjJexnjpi363eKTOG8mO7cMTp/dF3UwNfsDxWxAnfypZR
         88iQIEfNnA/W5nf0fU/m9KwnTxowJFL4Wfr7CZXjcPakWxygqvXPjisIrVsD1SgYcLsb
         +cjEVnpKF/2e9x7+qZfipIrEFeuQnQi3eotwob+POlUXVphE+lsqYCN8XQP8GvugWwkn
         Vpyg==
X-Gm-Message-State: ACgBeo2Aflljz8riD/Cl+9eghkSoshZtK7EVAdhXzDnLmc3VjycqQ3xI
        BypBxbgHBvXU82oU6TNwikybHdGe+sM=
X-Google-Smtp-Source: AA6agR6OfznML0q5aDOJ4u2DeM2nV78m/uMh/OYYw9aa/gQunB3hl238zUAnvtRfR66MCG/d5EzzMw==
X-Received: by 2002:a63:da13:0:b0:42a:7f03:a00e with SMTP id c19-20020a63da13000000b0042a7f03a00emr21906625pgh.332.1661951364547;
        Wed, 31 Aug 2022 06:09:24 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id o18-20020a63e352000000b0042c4d257083sm3285010pgj.25.2022.08.31.06.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 06:09:21 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, zhangxuezhi1@coolpad.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] comedi: convert sysfs snprintf to sysfs_emit
Date:   Wed, 31 Aug 2022 21:09:16 +0800
Message-Id: <20220831130916.239870-1-zhangxuezhi3@gmail.com>
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
v2: use a proper name for the Signed-off-by line.
v3: fix From line and Subject line.
---
 drivers/comedi/comedi_fops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 55a0cae04b8d..e2114bcf815a 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -396,7 +396,7 @@ static ssize_t max_read_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t max_read_buffer_kb_store(struct device *csdev,
@@ -452,7 +452,7 @@ static ssize_t read_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t read_buffer_kb_store(struct device *csdev,
@@ -509,7 +509,7 @@ static ssize_t max_write_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t max_write_buffer_kb_store(struct device *csdev,
@@ -565,7 +565,7 @@ static ssize_t write_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t write_buffer_kb_store(struct device *csdev,
-- 
2.25.1

