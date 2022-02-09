Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F24AF71D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbiBIQpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiBIQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:45:10 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0024DC05CB87;
        Wed,  9 Feb 2022 08:45:07 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k1so5076763wrd.8;
        Wed, 09 Feb 2022 08:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IIKca+pgE+DVR8rhfxr5EKDskUZ9sxowEB3ikdxaCSI=;
        b=BRR/+prTqcPyhKOcNxACxLffWRrU10IAtO7nXjNVk8BQH5ARgPn9oNqrEEbq+EZ8g2
         TAEzzKZBf2AwrP0hBMlRmIuH+AEBm1yq6Iva7Pd/qZd8j8Eli/X5HiGN5V4RedwM1/v2
         0V92ufudv4BZNu21iXM0tlN1ZqWZCSQlFY34Z4BtX+/A/i2521NM61zQjsb3fL/z4F6Y
         /jrobhHCnIz8WE+/VOWqC9mPJfGCuwGB4YVHNEQBbO7o+G8wHxp2DeePQS/f4HFNER0r
         tAJPQkfrkwOPIRTTn2fr0gVqigmPJ2dUV8tOF85Fj9t5feNSQrRjMtgOsKXHuyNY12Fx
         4VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IIKca+pgE+DVR8rhfxr5EKDskUZ9sxowEB3ikdxaCSI=;
        b=m2pY50vukyHaIwqW9fdf5+sbrKIEa+2ZcQ5CGjRSje8KpaRDho+0ILb2P+n6Sy7SJh
         FVnO8jgpTbcTlyFLNqPAYh2M8H0i8u+Rt0EyjZARj6cP47Ke3WE7tKDtC6+CUMUPgDjY
         D7TSAEGUUF59+6osbNQOuhNcGVuKkdlme4gM0k+uTvmCoHy3XZwOm1JuB462akHULQmR
         ydFl3atuWr7Mke4rg2nAq3ewjYveGinN3c0orN5ViHr85UIni2LtmFeFWmJSJqn3OhFP
         cZrBiFfe8eILXuKb/oDVCicuw8Dib5gRSEII4sB0hp1WCkbEV5llQk9O6r7cyTTCMVcU
         5n8Q==
X-Gm-Message-State: AOAM532bq4kTyjcMG5XsTgBel28tcljfTtXkrVpVSxQe6hlyskeisrVP
        z82rWDArHNAeFd91NIruK0U=
X-Google-Smtp-Source: ABdhPJyJhWDwdLFyIBIOyECqRXorSDaAx7tY8q9+77tiisyrSwclQOfW+GFKU0IdaPcdfvfQCR2PAQ==
X-Received: by 2002:a05:6000:38e:: with SMTP id u14mr2766963wrf.638.1644425106542;
        Wed, 09 Feb 2022 08:45:06 -0800 (PST)
Received: from localhost.localdomain (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id u15sm15948056wrs.18.2022.02.09.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:45:05 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
Subject: [PATCH v2] usb: core: Unregister device on component_add() failure
Date:   Wed,  9 Feb 2022 17:45:00 +0100
Message-Id: <20220209164500.8769-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 8c67d06f3fd9 ("usb: Link the ports to the connectors they are
attached to") creates a link to the USB Type-C connector for every new
port that is added when possible. If component_add() fails,
usb_hub_create_port_device() prints a warning but does not unregister
the device and does not return errors to the callers.

Syzbot reported a "WARNING in component_del()".

Fix this issue in usb_hub_create_port_device by calling device_unregister()
and returning the errors from component_add().

Reported-and-tested-by: syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
Fixes: 8c67d06f3fd9 ("usb: Link the ports to the connectors they are attached to")
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Move find_and_link_peer() soon after the 'if' test for "retval", 
	as suggested by Heikki Krogerus with his review of v1.

 drivers/usb/core/port.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index c2bbf97a79be..d5bc36ca5b1f 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -602,11 +602,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 		return retval;
 	}
 
-	find_and_link_peer(hub, port1);
-
 	retval = component_add(&port_dev->dev, &connector_ops);
-	if (retval)
+	if (retval) {
 		dev_warn(&port_dev->dev, "failed to add component\n");
+		device_unregister(&port_dev->dev);
+		return retval;
+	}
+
+	find_and_link_peer(hub, port1);
 
 	/*
 	 * Enable runtime pm and hold a refernce that hub_configure()
-- 
2.34.1

