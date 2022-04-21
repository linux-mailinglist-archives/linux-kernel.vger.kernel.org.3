Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C8450A749
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390856AbiDURnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390858AbiDURmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:42:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677414A3E7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:39:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s17so5517719plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQ4tGevrN4xgfqJr3MXv3Xa9RxM20hPP4zbxzdXNtnU=;
        b=OdSBDJTt9GRx5dFvx2oT8Tip+hnnqHZ1h7Ik1IQ/hbXSwk6iw8bzcSIn5RmOOG+nuP
         mnWaN6vQTqVk4+b7j0U4efE/njOd7QPQjRkMXNi28gxTQ5EPZ+lqo6bdbf+G2z1jB5q0
         So9+t9GsrY6HHdLSWqhqI1GnhnXE3SmgnPi6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQ4tGevrN4xgfqJr3MXv3Xa9RxM20hPP4zbxzdXNtnU=;
        b=lj/ejvwkaZokJsHR4d0tL/ypMe70JwemDeDbNOhFnmLX7DyEOPMrNF0q2YQf89pBne
         fu1LjqJutKbf0vI/AmxyJnpZnLhaBM5uCscnsyaXr2NHZ2FyVXTfXXYlzkifFRoIrAqc
         8POi8lMQ10ywnn7vCb90SsDAojtz6KEOJiplXNBw7SKdEsUBNojQwfwFssQObF/rinEL
         FiQo6vooknY0OPNDlyl4JFnT87epLi2jxdCUvku/6+TCQ5NROyvrGku3Ckdb1LZZl1Po
         mNodD3sdQwF1vxcwhLXJDZHtGa32ZiCfe+K+tv6yZxShGoijADJ3Mv+OJRbuc5X5zJ60
         u+Og==
X-Gm-Message-State: AOAM5321q0WaOMXc/I5s/TZXpROuDR16Whb8UeCH2j9ZiqZacGOc0p2o
        Lkc4uyCvZgur9A79HGgTDuAhgg==
X-Google-Smtp-Source: ABdhPJyzE2mVhtCPNj/gXz3zxdM6YFcgQJI8mbFf0Pc6aJajgSm+xW9K94/HTOnUhbHMxOvN3qd8Bw==
X-Received: by 2002:a17:903:2487:b0:159:bce:4e1a with SMTP id p7-20020a170903248700b001590bce4e1amr648959plw.4.1650562783767;
        Thu, 21 Apr 2022 10:39:43 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.47.98.87])
        by smtp.gmail.com with ESMTPSA id j6-20020a63b606000000b003808b0ea96fsm23237023pgf.66.2022.04.21.10.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:39:43 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@chromium.org>,
        Oliver Neukum <oneukum@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Evan Green <evgreen@chromium.org>,
        Razvan Heghedus <heghedus.razvan@gmail.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v3 1/2] USB: core: Disable remote wakeup for freeze/quiesce
Date:   Thu, 21 Apr 2022 10:39:26 -0700
Message-Id: <20220421103751.v3.1.I2c636c4decc358f5e6c27b810748904cc69beada@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220421173927.2845967-1-evgreen@chromium.org>
References: <20220421173927.2845967-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM_EVENT_FREEZE and PM_EVENT_QUIESCE messages should cause the
device to stop generating interrupts. USB core was previously allowing
devices that were already runtime suspended to keep remote wakeup
enabled if they had gone down that way. This violates the contract with
pm, and can potentially cause MSI interrupts to be lost.

Change that so that if a device is runtime suspended with remote wakeups
enabled, it will be resumed to ensure remote wakeup is always disabled
across a freeze.

Signed-off-by: Evan Green <evgreen@chromium.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>

---

Changes in v3:
 - Fix comment formatting and line wrap

Changes in v2:
 - Introduced the patch to always disable remote wakeups

 drivers/usb/core/driver.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 355ed33a21792b..b87452e228353d 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1533,22 +1533,23 @@ static void choose_wakeup(struct usb_device *udev, pm_message_t msg)
 {
 	int	w;
 
-	/* Remote wakeup is needed only when we actually go to sleep.
-	 * For things like FREEZE and QUIESCE, if the device is already
-	 * autosuspended then its current wakeup setting is okay.
+	/*
+	 * For FREEZE/QUIESCE, disable remote wakeups so no interrupts get
+	 * generated.
 	 */
 	if (msg.event == PM_EVENT_FREEZE || msg.event == PM_EVENT_QUIESCE) {
-		if (udev->state != USB_STATE_SUSPENDED)
-			udev->do_remote_wakeup = 0;
-		return;
-	}
+		w = 0;
 
-	/* Enable remote wakeup if it is allowed, even if no interface drivers
-	 * actually want it.
-	 */
-	w = device_may_wakeup(&udev->dev);
+	} else {
+		/*
+		 * Enable remote wakeup if it is allowed, even if no interface
+		 * drivers actually want it.
+		 */
+		w = device_may_wakeup(&udev->dev);
+	}
 
-	/* If the device is autosuspended with the wrong wakeup setting,
+	/*
+	 * If the device is autosuspended with the wrong wakeup setting,
 	 * autoresume now so the setting can be changed.
 	 */
 	if (udev->state == USB_STATE_SUSPENDED && w != udev->do_remote_wakeup)
-- 
2.31.0

