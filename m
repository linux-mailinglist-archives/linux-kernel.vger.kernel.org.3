Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965175906D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbiHKTIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHKTH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:07:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03173A0339
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:07:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s15-20020a5b044f000000b00680c4eb89f1so1559406ybp.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=S2tTmK1verVW5cijR9/dcxEFnFGeoisUmDHet7HEmdk=;
        b=s9VwmykC9MYigWNRSVeTljf3OQwjjm3VFuOODDEPlboyniZlFP1/O1jKAm+bScO/77
         TZX/Uk6KMzqSmnwvrQw/V+c/3yUzhsTJHY09PUpK8wMcH8AlLnCz583RZWpICPM2MzR8
         5YdrpiA4JWGz9deibNjg5hZKvFFUz3MLz7ntAYze0eT7URxoPmQOByhZrfD4sJzpXeZ+
         zrlD8pWNNyGUa1P5bZ5j2EviAFK6LZHCiJJuH64I3tc2vDVnQ/Uwt5E0Y2sSmHTlwOCd
         dmvcriXjYYUPDZglkfLofezxRnbAnwP+YY7aKPlS2y9bvQs1N3sghfxL4DJ2K7n2/rSa
         4qkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=S2tTmK1verVW5cijR9/dcxEFnFGeoisUmDHet7HEmdk=;
        b=bQVfi0kMOMoJdutGsjZlmr9i0D/CrhhKXFrg0QU7vTaviNLGeQTSKAr4vVQRoDAvkt
         pU6izx7TRy5qOm9VgdjdrDul2BdJ/h4lKF4LfT6cV3kRazAgzawBK6KxPhSrYH0uJdL5
         P6FGC/DW1xlhZt9S7vCjkRWy3+wF8Gelj09RcdieVfHd2d02mFn6Vt015J/tkYCm3JpW
         6sdD03jlcXAf6VvGDqfibAJb3JcjfDDy3YoADCTyFbQWhdJjS5+oafj6fnb8ODcQb7Kt
         T7+30CGpDbvq8NK/1FBJc2IlkCooz8v7zL+jdCwvsrvPL667bIr71+zhADdyBTFkPd/X
         PfaA==
X-Gm-Message-State: ACgBeo1e+8GZxNxfyNG2U/gpijcAIawkBQGCZoHG7x0H036zOsyLgFQ9
        3aXBIvyuTGUdXKvAMrtJGEwjcdAu9h6eq0StfmrX3w==
X-Google-Smtp-Source: AA6agR5Q+a6oNbxYvB2KmRjQIApbOkDll5Du72cSIOw2sPMRwRDeDTbidOj/10bDwM0/E9mG8VzoDOlq/oS/tp6eO+MOWg==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:4fcd:efd6:e25b:bec9])
 (user=isaacmanjarres job=sendgmr) by 2002:a81:59d6:0:b0:320:163a:ca82 with
 SMTP id n205-20020a8159d6000000b00320163aca82mr670369ywb.181.1660244877284;
 Thu, 11 Aug 2022 12:07:57 -0700 (PDT)
Date:   Thu, 11 Aug 2022 12:07:47 -0700
Message-Id: <20220811190747.797081-1-isaacmanjarres@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v1] driver core: Don't probe devices after bus_type.match()
 probe deferral
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
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
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/base/dd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)


Guenter,

Thanks for testing this patch out. Can you please add your "Tested-by"?

--Isaac

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 70f79fc71539..90b31fb141a5 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -881,6 +881,11 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 		dev_dbg(dev, "Device match requests probe deferral\n");
 		dev->can_match = true;
 		driver_deferred_probe_add(dev);
+		/*
+		 * Device can't match with a driver right now, so don't attempt
+		 * to match or bind with other drivers on the bus.
+		 */
+		return ret;
 	} else if (ret < 0) {
 		dev_dbg(dev, "Bus failed to match device: %d\n", ret);
 		return ret;
@@ -1120,6 +1125,11 @@ static int __driver_attach(struct device *dev, void *data)
 		dev_dbg(dev, "Device match requests probe deferral\n");
 		dev->can_match = true;
 		driver_deferred_probe_add(dev);
+		/*
+		 * Driver could not match with device, but may match with
+		 * another device on the bus.
+		 */
+		return 0;
 	} else if (ret < 0) {
 		dev_dbg(dev, "Bus failed to match device: %d\n", ret);
 		return ret;
-- 
2.37.1.559.g78731f0fdb-goog

