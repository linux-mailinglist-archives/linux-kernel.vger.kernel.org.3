Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438E6597B50
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbiHRCGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbiHRCGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EE29411B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660788389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8EZQ6LfQmKmAB5jPHLe4PeC2hfnbLD8bDMonjWHQtRI=;
        b=Gmq9ImnC5tq9wvJ2yVYCvXAu6xCjiBmBJvhb2Nq5n7/bC6XdIwZEFUOric83bYlMDto299
        hgD2nHswnMztj4HmuowHi7JxWbOzzxPsTKxjMqxk1bEUA9hafnoC5rV58IJ8xcliLGVOQH
        /i3zYM1mC5LBldCS7DZFLKMQl1jHW8g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-Zej0hiXKMyqYXFz0E6MCdA-1; Wed, 17 Aug 2022 22:06:26 -0400
X-MC-Unique: Zej0hiXKMyqYXFz0E6MCdA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3766529DD9B3;
        Thu, 18 Aug 2022 02:06:26 +0000 (UTC)
Received: from rtux.redhat.com (unknown [10.33.36.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DD87492C3B;
        Thu, 18 Aug 2022 02:06:25 +0000 (UTC)
From:   Alexey Klimov <aklimov@redhat.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, klimov.linux@gmail.com
Subject: [PATCH REVIEW 1/2] watchdog: extend the mutex-protected section in watchdog_cdev_unregister()
Date:   Thu, 18 Aug 2022 03:06:23 +0100
Message-Id: <20220818020624.2386475-1-aklimov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

watchdog_stop() should be called with wd_data->lock mutex locked.
Updates to wdd->status also occur under this look throughout the
watchdog_dev.c as well as functions that deal with pretimeout hrtimer
like watchdog_hrtimer_pretimeout_stop() here.

Signed-off-by: Alexey Klimov <aklimov@redhat.com>
---
 drivers/watchdog/watchdog_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 54903f3c851e..804236a094f6 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1095,6 +1095,8 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 		old_wd_data = NULL;
 	}
 
+	mutex_lock(&wd_data->lock);
+
 	if (watchdog_active(wdd) &&
 	    test_bit(WDOG_STOP_ON_UNREGISTER, &wdd->status)) {
 		watchdog_stop(wdd);
@@ -1102,7 +1104,6 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 
 	watchdog_hrtimer_pretimeout_stop(wdd);
 
-	mutex_lock(&wd_data->lock);
 	wd_data->wdd = NULL;
 	wdd->wd_data = NULL;
 	mutex_unlock(&wd_data->lock);
-- 
2.37.2

