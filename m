Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EA54CA4B6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbiCBMVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241727AbiCBMVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:21:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968AA5BE7E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:20:52 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso1276937pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 04:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vplKU+u5BNo996K8f2xPSiatclDH2lB4T12dOrQIivE=;
        b=K/EOiYcscZwk3AZTAYctKgHa6T/X/HoWmn9P6qtPVpTOHWomoZPugyFqWlNtT5kieI
         HQcEBb1VhOJMe0W0MgHN6Ivz2w6n0mg9WRL+EJ8h67RwbWxhEEuAvXeE9rXb+xSsAS2g
         3xjTB5a5QowTYHuXZvULaTS/PyOq1IdzVVPIeamSowW0bB2daY+6Y6/CpJ4kfluPeTzL
         zRr7XYUdXQX5hgNqVZ8MFwxm5aULRW2tczjOtLmK3hHu0naFEi8ecYlBl0pVxrpt3+AE
         oJXqSaDDMOtzBsO9TEg1n7VlqCwjCNUNaQvFp/UOjBBmW5F6Lzbh6+s5oJtGVma42uUi
         YaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vplKU+u5BNo996K8f2xPSiatclDH2lB4T12dOrQIivE=;
        b=FWzIf9F8pVfbjIZBPwabLi7fTF6jcypPvxPjD0G4qHCTg7P2B2BYcxtr+Fw5d464Bd
         0clJtEIVKIJjDSFaj0u9VZvbHv4cbBOveSck14JaT0VJfXwJhVKwS97leWk6WQVCWBIr
         Shhh/tCavskRaIYY/ayRYGmEs/2C6ycNUI4yKJ6lVHexUMhVgtSH/ln+FReqiCgK5eRe
         zJDWRDC2yc3pX7iRIxM4qCdT0U/RngFiQOtnAykEWBtenKpxkKCMa9RuQD6KQESl634q
         BwmT9mG1awqAL1OHee/OXJpVqJxoJQcJZ/c76NU4v64JEMx0oxuWoqSPTFvNCU6rC5Lb
         Dxlg==
X-Gm-Message-State: AOAM5316GTmg6GLYbWuTXLWH0ds+wUNfQg6OZI2TroKd7UFk0d+E3tdj
        YlZ/XHV2qEc9gOUjEALBrFGbKO+oG4Ns9w==
X-Google-Smtp-Source: ABdhPJwHEKTP96y89UWO+7Wjwb22ouIUUzzweveRMnfLvYDw4WP9tBJO4AhiwPELre3xgi00gpjx0g==
X-Received: by 2002:a17:902:c111:b0:14f:c841:66e2 with SMTP id 17-20020a170902c11100b0014fc84166e2mr30558022pli.92.1646223651814;
        Wed, 02 Mar 2022 04:20:51 -0800 (PST)
Received: from localhost.localdomain (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id na5-20020a17090b4c0500b001bc9301f316sm5046887pjb.42.2022.03.02.04.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:20:51 -0800 (PST)
From:   Nguyen Dinh Phi <phind.uet@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Nguyen Dinh Phi <phind.uet@gmail.com>
Subject: [PATCH RESEND] samples/kobject: Use sysfs_emit instead of snprintf
Date:   Wed,  2 Mar 2022 20:07:59 +0800
Message-Id: <20220302120759.380932-1-phind.uet@gmail.com>
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

Convert sprintf() to sysfs_emit() in order to check buffer overrun on sysfs
outputs.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 samples/kobject/kobject-example.c | 4 ++--
 samples/kobject/kset-example.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/kobject/kobject-example.c b/samples/kobject/kobject-example.c
index 9e383fdbaa00..96678ed73216 100644
--- a/samples/kobject/kobject-example.c
+++ b/samples/kobject/kobject-example.c
@@ -28,7 +28,7 @@ static int bar;
 static ssize_t foo_show(struct kobject *kobj, struct kobj_attribute *attr,
 			char *buf)
 {
-	return sprintf(buf, "%d\n", foo);
+	return sysfs_emit(buf, "%d\n", foo);
 }
 
 static ssize_t foo_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -60,7 +60,7 @@ static ssize_t b_show(struct kobject *kobj, struct kobj_attribute *attr,
 		var = baz;
 	else
 		var = bar;
-	return sprintf(buf, "%d\n", var);
+	return sysfs_emit(buf, "%d\n", var);
 }
 
 static ssize_t b_store(struct kobject *kobj, struct kobj_attribute *attr,
diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index c8010f126808..52f1acabd479 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -112,7 +112,7 @@ static void foo_release(struct kobject *kobj)
 static ssize_t foo_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
 			char *buf)
 {
-	return sprintf(buf, "%d\n", foo_obj->foo);
+	return sysfs_emit(buf, "%d\n", foo_obj->foo);
 }
 
 static ssize_t foo_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
@@ -144,7 +144,7 @@ static ssize_t b_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
 		var = foo_obj->baz;
 	else
 		var = foo_obj->bar;
-	return sprintf(buf, "%d\n", var);
+	return sysfs_emit(buf, "%d\n", var);
 }
 
 static ssize_t b_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
-- 
2.25.1

