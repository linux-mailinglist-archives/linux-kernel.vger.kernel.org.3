Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA2A5B2655
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiIHS4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiIHS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:56:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F8F103012
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:56:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v5-20020a2583c5000000b006964324be8cso14241808ybm.14
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=DfW7Ir9+WQmyTVzhm1gHklyle9zrgzIRVd1ekvZC7CA=;
        b=YZlecdlO47qUQNaOMtSKNTiIPStKS1fKX3wZJZpjcUQYeva7WWrJe+56JQfveBLrNn
         tYsFb1Fv+9yYbFW1rgsXDxQ1uz/Z1k77RSLkHWxQ7k3lSEA4JCjtYinax4CuioLFqz99
         2DeqE/AfmKVWrEMIgL9n59oamLmbJDLN1v5C1s6SQynu/SB75BwVt5FqGG9F4g3CLmCu
         UfgTbQUeQMzSvBQHLSvf1j1LamHNZ6koiF2MsJBvu+tDMsa7bUZ1+p/9vdb332cepz8t
         c40f5CQElmp4osWWN2p0uVU67uSwlvFcogFJTBfCNeZqceILZnWMXwNAkzDyz/YfdDEu
         piSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=DfW7Ir9+WQmyTVzhm1gHklyle9zrgzIRVd1ekvZC7CA=;
        b=LZe3u9r4/uMiNYF8dlqy3c0R5knjgBh9A3TxRi9cD8sbDMiNtOm8rYnSlWr+bX2DOR
         OYC7cm3b+geZlw8JXjhqCuTF+RopuzDN2KH5hdZXtQeXnhJlj+SGHd1W52C297br9vio
         jtPIoGR+oRwi3/D0sniqBMzgwmnV4d/H9pmhgOns3scb1+I05OC455NYpyO+ZGlOu1Zn
         yq8CO/B+SvFmRd3ElH92FJap20gkDaXfXHe8/WiGUHJB7b6wcIzyfrqO3bC8WnkriHFV
         p/3bcXEvZsNbMjfSvj07futVjXIasr4869aTeeKBpfCG1wPsf990afJlllqFUcpJ+Ja5
         YgUw==
X-Gm-Message-State: ACgBeo26LL4IEzYrm4LmupyqNPH674SACrQ9wnNEsXJClkVJT+r/Hnyj
        JcGI5YHLjW/GnLZj7RJlOXWgFiN6dv8uvB3LVxYFMA==
X-Google-Smtp-Source: AA6agR6gzaLqzOpRYQHI54Aj1+Zbxlvro56PlSplt5RM04nM9tJebeNTZSm/cZtRkkVVUCysFlG0cVUY+wd7xmBLHYjk6w==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:66bd:4175:b3a6:1479])
 (user=isaacmanjarres job=sendgmr) by 2002:a81:7cd7:0:b0:345:221c:5671 with
 SMTP id x206-20020a817cd7000000b00345221c5671mr8824096ywc.297.1662663391626;
 Thu, 08 Sep 2022 11:56:31 -0700 (PDT)
Date:   Thu,  8 Sep 2022 11:56:25 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220908185625.3729874-1-isaacmanjarres@google.com>
Subject: [PATCH stable-4.9] driver core: Don't probe devices after
 bus_type.match() probe deferral
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index ff59a1851cb4..faaa0440b294 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -590,6 +590,11 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
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
@@ -732,6 +737,11 @@ static int __driver_attach(struct device *dev, void *data)
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

