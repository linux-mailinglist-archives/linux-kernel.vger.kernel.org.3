Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FEB4ADED0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383634AbiBHRA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiBHRA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:00:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56019C06157B;
        Tue,  8 Feb 2022 09:00:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s10so29350466wra.5;
        Tue, 08 Feb 2022 09:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nAIz1/0UkKdAPDTKHKeOns6yHvOKA0JCQlBcR74Pb3k=;
        b=W5csElDgt6JXTJvOdrs5kU5s93wTG55Qibu9SaNqHV6lT+82S9BSDQIMkjsazpdn76
         kHrT2+NnE2xX5ol20WsL1Yrffmuc5lX8aXz+fG2B42hMM5Ex1sAGXgry1ny7vgadC1yp
         4NqI8RoDu/i4aBcVS/rH+biSuvJGYTRsMbuGN3MI5k2sGKv3pimTXOmx2KvQnbIlI2jz
         XvjkYtn1LgBtzogS9q9kLFmKXKOKaKEb/vY4wXSGteQTArOzH32IfGcJsie7UD5IlOem
         8nkogYsdOVJgxFWZlX4TcmyaN65XHHzT8wwv6hNKgaKmGcv1jct45EizJhPm1mKWtf1B
         +fnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nAIz1/0UkKdAPDTKHKeOns6yHvOKA0JCQlBcR74Pb3k=;
        b=GImS46J6x2e6rIdFDbYBPNArZDzhHrKiFi2TG5XwxdE/Cu2EjJE2BLnaUAkuItQZPY
         ORlyTrb8ucyCjf7aMCJuq295GIimTUsArNM6msvcC3+MU3coKsdxyTQTRwSelOGe3mHd
         itAuTPPblF4n4lYpwemKLqEwlNBxnSZuBma/iD415WLXjIKw9LfMf5lOuioqlQT0sfQK
         sXXXQh8gFgqMEb1l2ny5D9MrIa/2IKqqYW1o9YJAnH+M5lefNhw2hQfc1VVYa3qw2iSN
         sHMVdGI1UxYaEBXMAJM/XCOjHLaBA4ezO4XGe14YTTIBUNv9gts6BHjNLJRquNZKOB3Z
         VPbw==
X-Gm-Message-State: AOAM533HE8YzlpR6lXxurM8vmsqX/dfE7HpMCKoM++WrLeQkXj7SBXRb
        UFA+9XQiuRp9wnoZKrSfr2E=
X-Google-Smtp-Source: ABdhPJyQEUeQkVA713f2/zi6L6fP6g6lDsJgYcsT6kQfEM4NM3A0u7oAVNc4fbgwpVPJbhBt/N1jdw==
X-Received: by 2002:a5d:591c:: with SMTP id v28mr4150361wrd.257.1644339653804;
        Tue, 08 Feb 2022 09:00:53 -0800 (PST)
Received: from localhost.localdomain (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id p14sm14774829wrr.7.2022.02.08.09.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:00:53 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
Subject: [PATCH] usb: core: Unregister device on component_add() failure
Date:   Tue,  8 Feb 2022 18:00:48 +0100
Message-Id: <20220208170048.24718-1-fmdefrancesco@gmail.com>
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

Reported-by: syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
Fixes: 8c67d06f3fd9 ("usb: Link the ports to the connectors they are attached to")
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/usb/core/port.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index c2bbf97a79be..8455b235976a 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -605,8 +605,11 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	find_and_link_peer(hub, port1);
 
 	retval = component_add(&port_dev->dev, &connector_ops);
-	if (retval)
+	if (retval) {
 		dev_warn(&port_dev->dev, "failed to add component\n");
+		device_unregister(&port_dev->dev);
+		return retval;
+	}
 
 	/*
 	 * Enable runtime pm and hold a refernce that hub_configure()
-- 
2.34.1

