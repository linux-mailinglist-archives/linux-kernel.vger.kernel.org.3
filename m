Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8802D5A8AD2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiIABed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiIABea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:34:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C33155D60
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:34:29 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 78so1519189pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=nVosT8kIh+uDUZAUv7ofYilIkaVmBXxsR2Ou6VT/op0=;
        b=SAMWgYg4o0qucWWu0txW11TMrl0e2MH7SRKOq+P2rhHdggVfk0N6GYJ3iSz78waAyB
         5R06aetSj+ZHrNObwoed7nvw+b7FXbywOflrurawVzcZTQ/L/xeFOdA+nbcX5WzZNJV0
         t3GPHjMnqI9Nw6+EUrMChrRjHdeCKieXgp1ybz7nAw84DNHT+Xodu+IVwbKmGtnWTuIq
         XsN3T9s+xjUBLdJSKzMhhnZ+V8P03iIrrLK2wJ8Soc3j3laaKHDUByt/wqRc6//ItzkC
         fFq252ug+eO9ubCTS83GhujJ7xywwSjsZKGYq/uCeuMk63J/aCcOppmL363cP3toe2WS
         BmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nVosT8kIh+uDUZAUv7ofYilIkaVmBXxsR2Ou6VT/op0=;
        b=XVMoDDYPQmiYy1UCZVc9nhS8foS9pmz3ZFs9tO5DzaMfXei3cHHD8NaW6GkHJABFaW
         rIGI9jtogHX1czgacWQ1wOMD3immqEjBbv9TnfMojAIrcgbnrdi85Nxie8SPosslt7Z7
         NojYU+0cVkyio2tE1pZgPZ//hwXT+4FGI/7BUBp2BLineBG7kxUb8E6gYfQMifGcJl2f
         2Dn/qUKCDlGzM1yYR6U5FIoae+vjwmWAxmQcM9Bso7aBhK0K5loERqhPrNYx737USScx
         eg5coWU941an0ZqmMLg4TNioE9jOl6JAhshsTsbbd/IS+iyeD6uqn+XH9/acFKqKiuXF
         1uoQ==
X-Gm-Message-State: ACgBeo2JdN9DsA/asX1IDjBbWzH+jhcRIiArG8EODFyQbwIojj9A7TH1
        Ocd/IK8xqGtW+XYdAj2fmOQtHeeZhleRFQ==
X-Google-Smtp-Source: AA6agR7Vw1FdEThl9LXvfL/lflLyKvmNDfvu+TMGYJ3Wra+yzGD/c2KCL/bQd929gMhoTpXWuGkqlA==
X-Received: by 2002:a63:6683:0:b0:42b:1d69:a0ff with SMTP id a125-20020a636683000000b0042b1d69a0ffmr24522617pgc.475.1661996069042;
        Wed, 31 Aug 2022 18:34:29 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id it6-20020a17090afb0600b001fba4716f11sm1993897pjb.22.2022.08.31.18.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 18:34:27 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, zhangxuezhi1@coolpad.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4] comedi: convert sysfs snprintf to sysfs_emit
Date:   Thu,  1 Sep 2022 09:34:23 +0800
Message-Id: <20220901013423.418464-1-zhangxuezhi3@gmail.com>
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

Follow the advice of the Documentation/filesystems/sysfs.rst
and show() should only use sysfs_emit() or sysfs_emit_at()
when formatting the value to be returned to user space.

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
v2: use a proper name for the Signed-off-by line.
v3: fix From line and Subject line.
v4: change changlog.
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

