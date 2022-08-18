Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C38E597B53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbiHRCH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242546AbiHRCHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A8695AF5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660788440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YtSA4RBeCXTZTUITj7CouT42a1+0iIHwIDQs+/W3i5k=;
        b=fYmG3XcZ8PwjXbYkFciygtjusMaDCjCG7kA7QDH4sfnNDBuRrIOQ65QvyQ/vZ000SNN2ff
        S4I87bmJBK2QI+6YeOeAGwq8VOXIjRR5ZjL+J1e/gNDlX4E6ZCl/zAtol+RTh9eqcrJZRI
        rg2XlTiTsrnV8y7o5UwizhKo22WSsJE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-Qc6KvA5MNdiRlCtSVrBI_A-1; Wed, 17 Aug 2022 22:06:27 -0400
X-MC-Unique: Qc6KvA5MNdiRlCtSVrBI_A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1132885A586;
        Thu, 18 Aug 2022 02:06:27 +0000 (UTC)
Received: from rtux.redhat.com (unknown [10.33.36.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62875492C3B;
        Thu, 18 Aug 2022 02:06:26 +0000 (UTC)
From:   Alexey Klimov <aklimov@redhat.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, klimov.linux@gmail.com
Subject: [PATCH REVIEW 2/2] watchdog: add wd_data->lock mutex locking to watchdog_open()
Date:   Thu, 18 Aug 2022 03:06:24 +0100
Message-Id: <20220818020624.2386475-2-aklimov@redhat.com>
In-Reply-To: <20220818020624.2386475-1-aklimov@redhat.com>
References: <20220818020624.2386475-1-aklimov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

watchdog_open() does not have wd_data->lock locks at all unlike
the watchdog_release() for instance. Also watchdog_open() calls
watchdog_start() that should be called with wd_data->lock acquired.
The mutex lock should be acquired in the beginning of the function
after getting struct watchdog_core_data wd_data pointer to deal with
different status fields and be able to call watchdog_start(); and
released on exit and on different error paths.

Signed-off-by: Alexey Klimov <aklimov@redhat.com>
---
 drivers/watchdog/watchdog_dev.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 804236a094f6..d07a864036d9 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -836,7 +836,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	struct watchdog_core_data *wd_data;
 	struct watchdog_device *wdd;
 	bool hw_running;
-	int err;
+	int err = -EBUSY;
 
 	/* Get the corresponding watchdog device */
 	if (imajor(inode) == MISC_MAJOR)
@@ -845,9 +845,10 @@ static int watchdog_open(struct inode *inode, struct file *file)
 		wd_data = container_of(inode->i_cdev, struct watchdog_core_data,
 				       cdev);
 
+	mutex_lock(&wd_data->lock);
 	/* the watchdog is single open! */
 	if (test_and_set_bit(_WDOG_DEV_OPEN, &wd_data->status))
-		return -EBUSY;
+		goto out_unlock;
 
 	wdd = wd_data->wdd;
 
@@ -856,10 +857,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	 * to be unloaded.
 	 */
 	hw_running = watchdog_hw_running(wdd);
-	if (!hw_running && !try_module_get(wdd->ops->owner)) {
-		err = -EBUSY;
+	if (!hw_running && !try_module_get(wdd->ops->owner))
 		goto out_clear;
-	}
 
 	err = watchdog_start(wdd);
 	if (err < 0)
@@ -878,6 +877,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	 * applied.
 	 */
 	wd_data->open_deadline = KTIME_MAX;
+	mutex_unlock(&wd_data->lock);
 
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
 	return stream_open(inode, file);
@@ -886,6 +886,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	module_put(wd_data->wdd->ops->owner);
 out_clear:
 	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
+out_unlock:
+	mutex_unlock(&wd_data->lock);
 	return err;
 }
 
-- 
2.37.2

