Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA856806C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiGFHpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiGFHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:45:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AC422B17;
        Wed,  6 Jul 2022 00:45:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 546B6225A3;
        Wed,  6 Jul 2022 07:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657093502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=u5DoLqKVxyy1WDXsQxYHtUUIzMR4OyQzQ4xHbmmcCFQ=;
        b=rNaEq4xWWdueYwENPpdLRIh66mIPKo8u7X3mlrGsXScRB1SjL6BVWfj7kplm9dTyXYFvQv
        iGKoWLnAULAOT8+u32aXERyjR/75eIKUOa+dc/MYW36Y7OuIt1CT9hd9lQdvzX7vJEGsji
        jtZk1vVnjQrxo20yjUnw+7xsM6uh4IA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EDEF134CF;
        Wed,  6 Jul 2022 07:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5efYBX49xWLJDwAAMHmgww
        (envelope-from <oneukum@suse.com>); Wed, 06 Jul 2022 07:45:02 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     ean@mess.org, mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] ati-remote: remove private err() macro
Date:   Wed,  6 Jul 2022 09:44:59 +0200
Message-Id: <20220706074459.19940-1-oneukum@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers should use dev_err()

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/media/rc/ati_remote.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/media/rc/ati_remote.c b/drivers/media/rc/ati_remote.c
index 3155e876616d..b43ae0580374 100644
--- a/drivers/media/rc/ati_remote.c
+++ b/drivers/media/rc/ati_remote.c
@@ -135,8 +135,6 @@ MODULE_PARM_DESC(mouse, "Enable mouse device, default = yes");
 
 #define dbginfo(dev, format, arg...) \
 	do { if (debug) dev_info(dev , format , ## arg); } while (0)
-#undef err
-#define err(format, arg...) printk(KERN_ERR format , ## arg)
 
 struct ati_receiver_type {
 	/* either default_keymap or get_default_keymap should be set */
@@ -816,11 +814,12 @@ static int ati_remote_probe(struct usb_interface *interface,
 	struct ati_receiver_type *type = (struct ati_receiver_type *)id->driver_info;
 	struct ati_remote *ati_remote;
 	struct input_dev *input_dev;
+	struct device *device = &interface->dev;
 	struct rc_dev *rc_dev;
 	int err = -ENOMEM;
 
 	if (iface_host->desc.bNumEndpoints != 2) {
-		err("%s: Unexpected desc.bNumEndpoints\n", __func__);
+		dev_err(device, "%s: Unexpected desc.bNumEndpoints\n", __func__);
 		return -ENODEV;
 	}
 
@@ -828,15 +827,15 @@ static int ati_remote_probe(struct usb_interface *interface,
 	endpoint_out = &iface_host->endpoint[1].desc;
 
 	if (!usb_endpoint_is_int_in(endpoint_in)) {
-		err("%s: Unexpected endpoint_in\n", __func__);
+		dev_err(device, "%s: Unexpected endpoint_in\n", __func__);
 		return -ENODEV;
 	}
 	if (le16_to_cpu(endpoint_in->wMaxPacketSize) == 0) {
-		err("%s: endpoint_in message size==0? \n", __func__);
+		dev_err(device, "%s: endpoint_in message size==0? \n", __func__);
 		return -ENODEV;
 	}
 	if (!usb_endpoint_is_int_out(endpoint_out)) {
-		err("%s: Unexpected endpoint_out\n", __func__);
+		dev_err(device, "%s: Unexpected endpoint_out\n", __func__);
 		return -ENODEV;
 	}
 
-- 
2.35.3

