Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE60E505F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347918AbiDRVEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347912AbiDRVEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:04:13 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5F62A25D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:01:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t4so21044400pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PsqaX0mMaHgNt26YkuFONS0WzSqOE6FUG9W4KvOufeg=;
        b=L/5wlo3XuKXWeDlWiHccl1mrvHuQMGk71l2/UJiNbukNtW8sBFk7L3voXHaL1t1x7c
         eW1iVPH/smzcAB2Fs+jUjbqUB8Mj4kNYfnfVIZZfxmdUiFjEulFXt8j/x67YiugvzWOW
         v6JEMH8hXeaeGAZWdVhp+rdshOfKJ9kBZSgeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PsqaX0mMaHgNt26YkuFONS0WzSqOE6FUG9W4KvOufeg=;
        b=WqOw1sUj5qOBpAL6lHIyiaMwU6a6jUkWX1879UceXhwsxzhiiLGV4MhHebWkpy/lqw
         S0D6eKI1abjvdeHix+1UOYqI+rP+PIUPA37sHh0epZp5M3bDwaRO7uk+IdfYJ/hq8t3F
         G5UmJ6cR6FVr+Di5A1VosYFDFXJ1EQ/tRjoqaOJzdy2IrkTbdCDGS6zIbDc0xmB1aAu7
         Kum86tlk5ZGl5Jp9q8xZMSR3qGZkDsTEAawBUIVTnbEbkvmxzAOJl1QytIfFIkhRr+M2
         NP9KER8wB3QyoTRBW7owF5PK8aKw88KLBSOn9wmATBPuqCEaDcF8zophloyT68jnUqC3
         M+cA==
X-Gm-Message-State: AOAM532YeC/0fwRarPsYqqtM614iDzd503DxN9j4aSAQocheGgCWei76
        3aR7OsJYaJ2gbCtr/H7O2fRW2w==
X-Google-Smtp-Source: ABdhPJwWOGfdHF8dSOAUX+DIhWuMiCqrVT2iOcCFMnP0KBpLaFVSiKpts6tYslAe1hVJ14dNE1ac1w==
X-Received: by 2002:a05:6a00:2496:b0:50a:6778:b8c1 with SMTP id c22-20020a056a00249600b0050a6778b8c1mr9247086pfv.47.1650315691606;
        Mon, 18 Apr 2022 14:01:31 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.47.98.87])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b001c7ecaf9e13sm14047973pjy.35.2022.04.18.14.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 14:01:31 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Razvan Heghedus <heghedus.razvan@gmail.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 1/2] USB: core: Disable remote wakeup for freeze/quiesce
Date:   Mon, 18 Apr 2022 14:00:45 -0700
Message-Id: <20220418135819.v2.1.I2c636c4decc358f5e6c27b810748904cc69beada@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220418210046.2060937-1-evgreen@chromium.org>
References: <20220418210046.2060937-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
---

(no changes since v1)

 drivers/usb/core/driver.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 355ed33a21792b..93c8cf66adccec 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1533,20 +1533,18 @@ static void choose_wakeup(struct usb_device *udev, pm_message_t msg)
 {
 	int	w;
 
-	/* Remote wakeup is needed only when we actually go to sleep.
-	 * For things like FREEZE and QUIESCE, if the device is already
-	 * autosuspended then its current wakeup setting is okay.
+	/* For FREEZE/QUIESCE, disable remote wakeups so no interrupts get generated
+	 * by the device.
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
+		/* Enable remote wakeup if it is allowed, even if no interface drivers
+		 * actually want it.
+		 */
+		w = device_may_wakeup(&udev->dev);
+	}
 
 	/* If the device is autosuspended with the wrong wakeup setting,
 	 * autoresume now so the setting can be changed.
-- 
2.31.0

