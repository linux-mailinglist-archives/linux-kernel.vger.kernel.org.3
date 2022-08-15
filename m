Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7075951B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiHPFLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiHPFKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:10:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25638E0FF5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:19:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f4b76446aso75787327b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=LOkyn7PSl9VNfxbrkFrp1Zs0OjGnH/EZENNKaRxsWdY=;
        b=MU5A+HB4wdr7GIyVcau6nqAobtEEqycwd8KAw5KvDd3N1+i5hDFyyJ46cEyPabate+
         AnqPpnpik+ncj0Woj6Sx1NvCBVzKApORW7BpmCLD9y7Lh5bf1IeVrBebFHYUiWwVl4YZ
         w9PLVYb+oCvO94EGSzMwA7koXSyRN2vwn1eb3cpQexODkYLXByTvc7lxyvT26CFIxid8
         47YtlrG9QlRUUpAAGwHyx7eyb1rJDNQpJRzZdEj8DvXKq5fSAmBhRMFxdZn/6jJGv6/+
         iJgHVfjf/G9L9n/gSST78Zhgi4L6ADSRMCNJAC1zsjOWYUfLGy2Qxf1bSb8dg6hIfnBQ
         okLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=LOkyn7PSl9VNfxbrkFrp1Zs0OjGnH/EZENNKaRxsWdY=;
        b=u5UT5DEq6dxyINTdvlk+HOP3kBAWlY4oKQbqYWwswqRaWmnD0kJNfkoD3CFigeRIZ+
         h4d3YOlN1wdRSY9m+0FAntKaJ+D0wSpWmlwHnOCktJb8cxMk8B/rlHd62/SrzLWmYUzH
         4OjhRT1exHlM067Y7fP5yDXdd7oKuYdpXP9cimWB+c7fG7Ihc+ryKFrfMdfWFuYHA3Vt
         ewyjMW8dOogqSHYEbWC3K4OXrRkQgGMGV6g5kajCAY+AWwGg/RTAY5N5O2sf1QL4skgY
         jPLjlIAcb4x19LBXphjLOuP3qEEf6kim6euNYbY3qoZu6rXUUWUUjPm/c/9suTmX7AfL
         R10w==
X-Gm-Message-State: ACgBeo2pgIUKrY1Zw1PjIM/cB3b2h4ZLCb/1FILh514w3bHv2gMacsuM
        nVGLQC0bbqxt00xIn2kZcqIGFx7H+5MPeHFhm2HOag==
X-Google-Smtp-Source: AA6agR4YB6dvvrQOFHcxTeTKZGbrsO2eNVsnH88lts67cmBXM6uAXKL0w54d1ChowwCqpp7JRFbJragsbkltQPjMzqG04w==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:2e7e:eaac:df8:6465])
 (user=isaacmanjarres job=sendgmr) by 2002:a81:250d:0:b0:32f:e7d0:6fd with
 SMTP id l13-20020a81250d000000b0032fe7d006fdmr7861867ywl.298.1660598364115;
 Mon, 15 Aug 2022 14:19:24 -0700 (PDT)
Date:   Mon, 15 Aug 2022 14:19:18 -0700
Message-Id: <20220815211919.2028890-1-isaacmanjarres@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2] driver core: Fix bus_type.match() error handling
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
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
and that results in any error, then the driver should not attempt to bind
with the device. However, the driver can still attempt to match and bind
with other devices on the bus, as drivers can be bound to multiple
devices. So, update the logic in __driver_attach() to reflect this.

Cc: Saravana Kannan <saravanak@google.com>
Cc: stable@kernel.org
Fixes: 656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from bus_type.match()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/base/dd.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

v1 -> v2:
- Fixed the logic in __driver_attach() to allow a driver to continue
  attempting to match and bind with devices in case of any error, not
  just probe deferral.

Guenter,

Can you please give test this patch to make sure it still works for you?

Thanks,
Isaac

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 70f79fc71539..453eb19a9a27 100644
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
@@ -1120,9 +1125,18 @@ static int __driver_attach(struct device *dev, void *data)
 		dev_dbg(dev, "Device match requests probe deferral\n");
 		dev->can_match = true;
 		driver_deferred_probe_add(dev);
+		/*
+		 * Driver could not match with device right now, but may match
+		 * with another device on the bus.
+		 */
+		return 0;
 	} else if (ret < 0) {
 		dev_dbg(dev, "Bus failed to match device: %d\n", ret);
-		return ret;
+		/*
+		 * Driver could not match with device, but may match with
+		 * another device on the bus.
+		 */
+		return 0;
 	} /* ret > 0 means positive match */
 
 	if (driver_allows_async_probing(drv)) {
-- 
2.37.1.595.g718a3a8f04-goog

