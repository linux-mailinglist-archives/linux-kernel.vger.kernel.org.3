Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBFD572EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiGMHDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiGMHDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:03:14 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E26D6E0F5F;
        Wed, 13 Jul 2022 00:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=tWMSY
        4YaH1wvIRkN61jC3EsRnE5d4N+7+2ua4h8gC1g=; b=Majd4FEg6BNOHzuWlRkfN
        UGTvDhaBdq0/EUcYPEB1SH7G/eMbqzb03VFhLGvY/Wf2vU4T8YwBypZH4G6dd1m6
        PfMaGpVLxaljPxYHnC31V/u3w0BaHKGRSaT7XMIpFPFZwNncrJvN06APWXCttL8e
        fUaiTEUR3VmHYzFcfsyCQw=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp11 (Coremail) with SMTP id D8CowAAnAvUPbs5ivRB3Mg--.8833S2;
        Wed, 13 Jul 2022 15:02:46 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] usb: ldusb: replace ternary operator with max_t()
Date:   Wed, 13 Jul 2022 15:02:05 +0800
Message-Id: <20220713070205.3047256-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAAnAvUPbs5ivRB3Mg--.8833S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF13trWfZFW3XFW3Ar43Jrb_yoW8Ar45pr
        W5GFs8Xr4UXF17Jw4DAa45AayrJws8ur93Cr97A395JFnxta9Fqr13Ja43Jry5CryfZw4j
        vrnYy3yUu3yUKrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j46wZUUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbizRY9+1c7NfJz-QAAs4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix the following coccicheck warning:

drivers/usb/misc/ldusb.c:719: WARNING opportunity for max().
drivers/usb/misc/ldusb.c:721: WARNING opportunity for max().

max_t() macro is defined in include/linux/minmax.h. It avoids
multiple evaluations of the arguments when non-constant and performs
strict type-checking.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/usb/misc/ldusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
index dcc88df72df4..7cbef74dfc9a 100644
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -716,9 +716,11 @@ static int ld_usb_probe(struct usb_interface *intf, const struct usb_device_id *
 	dev->interrupt_out_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!dev->interrupt_out_urb)
 		goto error;
-	dev->interrupt_in_interval = min_interrupt_in_interval > dev->interrupt_in_endpoint->bInterval ? min_interrupt_in_interval : dev->interrupt_in_endpoint->bInterval;
+	dev->interrupt_in_interval = max_t(int, min_interrupt_in_interval,
+					   dev->interrupt_in_endpoint->bInterval);
 	if (dev->interrupt_out_endpoint)
-		dev->interrupt_out_interval = min_interrupt_out_interval > dev->interrupt_out_endpoint->bInterval ? min_interrupt_out_interval : dev->interrupt_out_endpoint->bInterval;
+		dev->interrupt_out_interval = max_t(int, min_interrupt_out_interval,
+						    dev->interrupt_out_endpoint->bInterval);
 
 	/* we can register the device now, as it is ready */
 	usb_set_intfdata(intf, dev);
-- 
2.25.1

