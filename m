Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40C05AF2BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiIFRe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240078AbiIFReM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:34:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A751A1C932
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:29:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i194-20020a253bcb000000b00676d86fc5d7so8923934yba.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=kiOrB5yWFxCLoNxe+9LT00TIOWI2BPkFlWeuOIoCnH0=;
        b=D7wUnaukzGksmUg3rCY79VHdeMa6j7UOfHsOqV2yuo7aHI/jmAwDDTmEpmMGngTrZ+
         +W8b5/x5OiSmoyAWh2YTrFFZ7AOWRgrbpa7ZZcN+IYHUj8AinkQreG4wMRJAVuiYhBs4
         BNhbS1npw+86kYMSnnn7EdkQS951AW5evheBAx3C+YWbCMcfiZsyCaIhOshoj/MbHJgL
         XI112cvhbsj0p9fQ8ckBAuEfMhM4erj/aEQquw/UpIJKWlUnF6txko3uxgP4iICk7i3B
         d+RioD0OlCTPaAC1erm6uCRJ2tO2q/oZ8OBEklUWTZ7Vq4diU8FD2vLa0CyxJruG36Fa
         h5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=kiOrB5yWFxCLoNxe+9LT00TIOWI2BPkFlWeuOIoCnH0=;
        b=qP2F56kO7bMAb342hRJ1lWAA6CN1lV1C6701cgcaXNAgH5cqPycWdi7CHfW3mcvIg8
         mPEweVd49PwyV+7uKVcyvpQEp7LV9nYJXIBmI5SzyqSiT7Qqnqpi4kvss5yMP9PxK+qQ
         hBjIuTrPuMH6+XEiNtF6RUKb/awGen9z2vv0Po6w9I9JCcVklG/DxY/C94YWaTUgUzXm
         zZINA5IisDHGvpRJoe9tvh2F2xy50GBuo6KCebO3mrsr13LWfYiG0M1bagBgWABdRGVu
         knGUBlvrdRo61dY96OGbpCHY3nSE9xvtGJOYxnVaNZTvSk9zCrI+Khvsy3YnBX6EWo6T
         8smA==
X-Gm-Message-State: ACgBeo0/S9NWsx1Gk2IKbGmUTyvn0r7Y4ZyB2++Hgyd+A7VsdhzlizcL
        XmsTVnxAoJTKMGWKKrHr/YqcZULk8HEo+9+kUSsCQg==
X-Google-Smtp-Source: AA6agR6g8n5FIE5HRy5n8m5MNBxDTfEelEAVRECD1wsrGQA7m2kQlteRDHIhgST4uqLOWlel4EKGOZ11NE16U7UFd67Z8Q==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:96d9:b0ea:9ff9:ee9f])
 (user=isaacmanjarres job=sendgmr) by 2002:a5b:a0f:0:b0:691:6fea:deda with
 SMTP id k15-20020a5b0a0f000000b006916feadedamr37037278ybq.377.1662485377308;
 Tue, 06 Sep 2022 10:29:37 -0700 (PDT)
Date:   Tue,  6 Sep 2022 10:29:33 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220906172933.410698-1-isaacmanjarres@google.com>
Subject: [PATCH stable-4.19/4.14/4.9] driver core: Don't probe devices after
 bus_type.match() probe deferral
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 25e9fbf0fd38868a429feabc38abebfc6dbf6542 upstream.

Both __device_attach_driver() and __driver_attach() check the return
code of the bus_type.match() function to see if the device needs to be
added to the deferred probe list. After adding the device to the list,
the logic attempts to bind the device to the driver anyway, as if the
device had matched with the driver, which is not correct.

If __device_attach_driver() detects that the device in question is not
ready to match with a driver on the bus, then it doesn't make sense for
the device to attempt to bind with the current driver or continue
attempting to match with any of the other drivers on the bus. So, update
the logic in __device_attach_driver() to reflect this.

If __driver_attach() detects that a driver tried to match with a device
that is not ready to match yet, then the driver should not attempt to bind
with the device. However, the driver can still attempt to match and bind
with other devices on the bus, as drivers can be bound to multiple
devices. So, update the logic in __driver_attach() to reflect this.

Fixes: 656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from bus_type.match()")
Cc: stable@vger.kernel.org
Cc: Saravana Kannan <saravanak@google.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/base/dd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 26ba7a99b7d5..63390a416b44 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -738,6 +738,11 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 	} else if (ret == -EPROBE_DEFER) {
 		dev_dbg(dev, "Device match requests probe deferral\n");
 		driver_deferred_probe_add(dev);
+		/*
+		 * Device can't match with a driver right now, so don't attempt
+		 * to match or bind with other drivers on the bus.
+		 */
+		return ret;
 	} else if (ret < 0) {
 		dev_dbg(dev, "Bus failed to match device: %d", ret);
 		return ret;
@@ -891,6 +896,11 @@ static int __driver_attach(struct device *dev, void *data)
 	} else if (ret == -EPROBE_DEFER) {
 		dev_dbg(dev, "Device match requests probe deferral\n");
 		driver_deferred_probe_add(dev);
+		/*
+		 * Driver could not match with device, but may match with
+		 * another device on the bus.
+		 */
+		return 0;
 	} else if (ret < 0) {
 		dev_dbg(dev, "Bus failed to match device: %d", ret);
 		return ret;
-- 
2.37.2.789.g6183377224-goog

