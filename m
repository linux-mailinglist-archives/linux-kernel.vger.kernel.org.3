Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A4755730D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiFWGZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiFWGZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:25:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC61D1F2F3;
        Wed, 22 Jun 2022 23:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69A7B6137D;
        Thu, 23 Jun 2022 06:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA3DC341C6;
        Thu, 23 Jun 2022 06:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655965549;
        bh=Uc1u4nvGBp0zbRmsVE5uw1rwOxo9HfInjkxM0gU+KSU=;
        h=From:To:Cc:Subject:Date:From;
        b=HlsV8pVnzF8bDywr+Kjmm1sNyFonVnWkMVscv0XVgivo3Tu0lqiHY0IFGWn6frByi
         qj980znLoTU69zwAhHRDrRCPJOnQSbUpsDAR/+z3G89a73xDGiuXRcimHE7LaYOj8j
         anzbmr5efAbH+UOg0SMP5aLvGbTG5JF8G2xnHWqmKhVO/d931WcfJmusOD3C5gp0TT
         8VIz59j4z3GfydyPC6Y2E2EAopVNZk7CIJZ8L1dwYgAvyHz7g1Ck5BIlxOZJyWOOyH
         58D8d6+Jwyr+5K8QvgmkcZOskKPR0nPoMhjf+5nJzE0oFi3gK9zLmAM1aeY6aanc80
         DfRqVsFN7KmUQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o4GHh-0004Pi-Nh; Thu, 23 Jun 2022 08:25:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2] Input: usbtouchscreen - add driver_info sanity check
Date:   Thu, 23 Jun 2022 08:24:46 +0200
Message-Id: <20220623062446.16944-1-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sanity check on the device id-table driver_info field to make sure
we never access a type structure (and function pointers) outside of the
device info array (e.g. if someone fails to ifdef a device-id entry).

Note that this also suppresses a compiler warning with -Warray-bounds
(gcc-11.3.0) when compile-testing the driver without enabling any of
the device type Kconfig options:

    drivers/input/touchscreen/usbtouchscreen.c: In function 'usbtouch_probe':
    drivers/input/touchscreen/usbtouchscreen.c:1668:16:warning: array subscript <unknown> is outside array bounds of 'struct usbtouch_device_info[0]' [-Warray-bounds]
     1668 |         type = &usbtouch_dev_info[id->driver_info];

Signed-off-by: Johan Hovold <johan@kernel.org>
---

Changes in v2
 - use ARRAY_SIZE() for the sanity check (Dmitry)
 - drop the dummy entry and combine the two patches as the sanity check
   itself is enough to suppress the compiler warning (Dmitry)
 - use -ENODEV instead of -EINVAL even if this means no error will be
   logged in the unlikely event of a future driver bug


 drivers/input/touchscreen/usbtouchscreen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 43c521f50c85..b01d026588c8 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1654,6 +1654,9 @@ static int usbtouch_probe(struct usb_interface *intf,
 	if (id->driver_info == DEVTYPE_IGNORE)
 		return -ENODEV;
 
+	if (id->driver_info >= ARRAY_SIZE(usbtouch_dev_info))
+                return -ENODEV;
+
 	endpoint = usbtouch_get_input_endpoint(intf->cur_altsetting);
 	if (!endpoint)
 		return -ENXIO;
-- 
2.35.1

