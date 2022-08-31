Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AB55A7E12
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiHaMzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiHaMzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:55:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046C726112
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:55:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l5so10153709pjy.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/w/LSAOeygKxkwT5iHUDM+ilY8owlgJLl7QXytX6Lek=;
        b=dIpT48pmgBtjl+0i37xEn8tB7KY2ue6x1yVm+l3QRhjsNQivcw+wXN0p7t6hmsFWeG
         qR0i/FPSV7jEgkbvjhKSLq4YAZehiYr9w1FOBGBnkGkDYMBJyrlLT4c3JjQbIk5pHUpj
         7bTimAF+2CFtfREcHxgfhf5xKJauALbjjoZk+HtqvgxSYv7zCj4jj/Av6kheooujZeq5
         LniNoLXeDypkQZ8mRw8ca7Wc2KzM+we3GfL7iGiX5uUfZaaSBbNtk8+rjwpUJs4xwk7W
         p5K2f9BwqYlbrkNjHcLSkpNYHM7C5wTVXUK/9NDCSa+obwxnx276Rdl9FrZlWY5nv4oK
         7fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/w/LSAOeygKxkwT5iHUDM+ilY8owlgJLl7QXytX6Lek=;
        b=e9q3sEA5S4oOZo05TffxF5zqttoBfeZthbiyevbDEOoLae6umtezQOe4I8KG0XPfyt
         mF630HhBXy+oQm7rK9CXS/QkwnVSh+7Y/NMztT+b4U6kOgM3AuxNxL+CFYE3y+llXpdt
         tKBSWukVTVPht/+oC+d9HIrXqwWYDtBCZoJ87gC2S95Dkgqu1miazFyG9OHcgCslSnra
         /NCX3G5LwxySG0NACtEUXKYHp8r4Dt9sznNOhdKYdRvFP0j2nST2AmswlOO80z7GKaka
         I3jccAiUd0WWSzERzd2gC6Fg1CDoBKX2bNVkiAukIG5QJf3/A9RQam7hN8U5sx+BpPDq
         qDsQ==
X-Gm-Message-State: ACgBeo2SDgJ/u7HXVNemaMB1NigVIcyl65xdBPHwQznqcyUHfTcShfZx
        cqR3NRO51eR04Pudp/yzU+0=
X-Google-Smtp-Source: AA6agR6/pF6fiV5gNVLQcTcr27Wn3ONrtU71pJ5M3Y60W+fZlLhJ931KVRsJW2AZcpgboIPJ8ZUqKw==
X-Received: by 2002:a17:90a:9907:b0:1f5:2318:ea6d with SMTP id b7-20020a17090a990700b001f52318ea6dmr3224402pjp.163.1661950526166;
        Wed, 31 Aug 2022 05:55:26 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id o4-20020a17090a5b0400b001fe39bda429sm375112pji.38.2022.08.31.05.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:55:25 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, zhangxuezhi1@coolpad.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] comedi: sysfs: convert sysfs snprintf to sysfs_emit
Date:   Wed, 31 Aug 2022 20:55:20 +0800
Message-Id: <20220831125520.239055-1-zhangxuezhi3@gmail.com>
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

From: zhangxuezhi1 <zhangxuezhi1@coolpad.com>

Fix up all sysfs show entries to use sysfs_emit

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
v2: use a proper name for the Signed-off-by line.
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

