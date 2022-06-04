Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28A353D8D1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 01:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbiFDX2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 19:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239285AbiFDX2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 19:28:01 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Jun 2022 16:27:58 PDT
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434D16335
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 16:27:57 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 29735 invoked from network); 5 Jun 2022 01:21:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1654384875; bh=5+W5QwKb/oQX3qx4qTmH9nnksYIviH9DLf7qcI6p+I4=;
          h=From:To:Cc:Subject;
          b=j8hqzrP72hAJlb7TCjGwOg1IZmDqVtSorra1v5zKeDL0XHuFSWUhJzSeJZoI2V0wp
           uCaI/KuWelwwoll3GBpOdDuTA4gsDh8lblhmGORrSEldlBx0Ym3dbl05MUQeQwvUzh
           4Kb6J8BTLZ6i/rHwtK6DPctGEs4IV8zVQYXgyrAQ=
Received: from public-gprs207966.centertel.pl (HELO mocarz) (deweloper@wp.pl@[46.134.151.159])
          (envelope-sender <deweloper@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <deweloper@wp.pl>; 5 Jun 2022 01:21:15 +0200
Date:   Sun, 5 Jun 2022 01:21:14 +0200
From:   Aleksander Mazur <deweloper@wp.pl>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Aleksander Mazur <deweloper@wp.pl>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (f71882fg) Add support for F71858AD (0x0903)
Message-ID: <20220605012114.3d85a75a@mocarz>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 937c5ef75b2e3d270d89436ace9fe1d1
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [gZM0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Treat F71858AD like F71858FG.

Tested on Igel D220.

Signed-off-by: Aleksander Mazur <deweloper@wp.pl>
---
 drivers/hwmon/f71882fg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 6830e029995d..19b6c643059a 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -49,6 +49,7 @@
 #define SIO_F81768D_ID		0x1210	/* Chipset ID */
 #define SIO_F81865_ID		0x0704	/* Chipset ID */
 #define SIO_F81866_ID		0x1010	/* Chipset ID */
+#define SIO_F71858AD_ID		0x0903	/* Chipset ID */
 #define SIO_F81966_ID		0x1502	/* Chipset ID */
 
 #define REGION_LENGTH		8
@@ -2638,6 +2639,7 @@ static int __init f71882fg_find(int sioaddr, struct f71882fg_sio_data *sio_data)
 		sio_data->type = f71808a;
 		break;
 	case SIO_F71858_ID:
+	case SIO_F71858AD_ID:
 		sio_data->type = f71858fg;
 		break;
 	case SIO_F71862_ID:
-- 
2.36.1

