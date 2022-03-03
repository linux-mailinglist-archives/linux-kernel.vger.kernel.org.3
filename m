Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523704CC544
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 19:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiCCShL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiCCShJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:37:09 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6689C198ED3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 10:36:24 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i1so5436295plr.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 10:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJsbkL8siI0lGyboYVPK2VJnEYo3JgwwxvZuUrqhnC8=;
        b=HAncDO5auDJqyLgjRg5xBlKG1T8Bf+NN2CRfwedrLlecXeVLqvtBl9ANQwz6BQSyXF
         jZWWanxu29rgaTdGCFHiFGIBvkIjPXu9bDLKGPiSmStUTI3evIgCoDpBWsxEj6KoH9i3
         3SOLhcSkPRWmCjhGA8v9j+wy3vHtiXeT7Wk0QaA+Wcu3Y9JvOx/CsadtXPXyFEWRdpo1
         5WMrH/9pE06+lWDn1L2Wn6R+Gu7grYNBaqhWy9lnH+wsywcATGtN2CIWnFJD0PH54IhZ
         j2YrIecXWDXsAOX/aV5SqHvu09ubqipOjhamOK8hxP5FD9B1xhOhdQdNCo0WN5BXjs3g
         1cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJsbkL8siI0lGyboYVPK2VJnEYo3JgwwxvZuUrqhnC8=;
        b=FM6efRc/k8MOytH9yvz/icIAl2KtQNP0S6N2D8e95D8AooKpd3AO4TKTZZ4B1dlowt
         RJFcIfPpOXCyHFdmiSXpWEnPrLwUSkVMsM36Nhvmoyy2ckc23haiQsBUS26S4qN3zv7k
         SkbRxMq1K5K65dOxb9yHpBn7ajv/8lV9tb/g1iNFuFeNjKnvHAt0K2tc3Yn4qN94aNwr
         DidQV/13PmAEeYP5R3KVvjcVs8S9HOOB21gmydLP0uJNw4oAUz2nT5mW2MGp2g/tYmSf
         lHmxk5U5fYarTdvVW6tN9L4PGtPWs4Cz5RD6n4f291OviR8dX3tHQx3ps1nDb6JDNvQg
         Q+SQ==
X-Gm-Message-State: AOAM531Wl65Gzm3NUwDgImkKYJP8bkD3XOqAMrPQYaLcF8nKhjKb/W/8
        GNv3CH9HfCt+CFQ+BpqkGZRSYaBn1NEH/A==
X-Google-Smtp-Source: ABdhPJzmiDHx81LaJocnXl854VesK4dBI7+UMKaqLolQhhS4Vkr6neD0QzT5GgBM0sm6QLEQx5VpVQ==
X-Received: by 2002:a17:902:e943:b0:14f:4a2b:203 with SMTP id b3-20020a170902e94300b0014f4a2b0203mr37595022pll.113.1646332583872;
        Thu, 03 Mar 2022 10:36:23 -0800 (PST)
Received: from localhost.localdomain (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id f3-20020a056a00238300b004e0a002ec80sm3372890pfc.10.2022.03.03.10.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 10:36:23 -0800 (PST)
From:   Nguyen Dinh Phi <phind.uet@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Nguyen Dinh Phi <phind.uet@gmail.com>
Subject: [PATCH V2] samples/kobject: Use sysfs_emit instead of sprintf
Date:   Fri,  4 Mar 2022 02:36:18 +0800
Message-Id: <20220303183618.1342358-1-phind.uet@gmail.com>
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

sysfs_emit() is preferred over sprintf() when formatting the value to be
returned to user space in show() functions, because it knows about sysfs
buffer specifics and has sanity checks.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
V2:
	- Fix title
	- Change commit message 
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

