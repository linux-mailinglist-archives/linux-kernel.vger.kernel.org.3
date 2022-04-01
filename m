Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FA44EFC93
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348250AbiDAWJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiDAWJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:09:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F241B8FDC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 15:07:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bh17so8604881ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 15:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nm4/IXTEhukbK1qhvdT6cx0MGt+4gXe0siNI2njLEvE=;
        b=XEbiqYRiX0UPtfD80iUEpEHKC1IaxtDCsBogJ3ndZo5COUVxm7N2lMBRs9cWmdZXVO
         rkc2KvvA0GMPko8i1Okx2XmJYC2zijrd+pQKyW3hD/EiwuY/Cte769UQqE8yzFX+ycM2
         J4TYOny7jbBVRgzZgev3F3EBoW8HU0K3VEhZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nm4/IXTEhukbK1qhvdT6cx0MGt+4gXe0siNI2njLEvE=;
        b=cre5qAHcJ9eQy8zTkV+C4HRul8zK0/ChjTafkHCsox1A08zQjKVW8CbecaU0XICkf9
         cGCRjVf/EwR7tYGCDnOmyCtF2Jg1u7EoxO2aOBua1Gb2dic60og1MS20sy6oaQ673jIl
         upAf3fWDqb4bUVj+FzUqM/WP5RPqsycboeDgx7YXN7SPnkWfAxA4BIDYl4s9F14xvB13
         KTkXy+HoYPKlsLYmR9lHpA25WXx6K1YtGoGMBtZ/yCHQ/+0Zt2HcE+348+inJKOesXW7
         w6677cjFWyxQ8CZuPm2+p2fI0xVBlIs182ZkaR3RG2NLdfhdk5l7qFWglTFye4TV3ZI/
         BOHg==
X-Gm-Message-State: AOAM5302B6BwEhFy2C3bPliEDKUwAvd6bOPGH+PAKwNfsaaoAoz1H3Ca
        pUGoUXf+dpfZkbMzKYUnR9oE1hqKzmueabVv
X-Google-Smtp-Source: ABdhPJy089jCiaKOTUXZv8xWaU8CK2ptzqILHk1BadP6mEIgFQaD+8+rQ2r/GQizJBqCQLFCzxcXuQ==
X-Received: by 2002:a17:907:3ea9:b0:6df:f197:81ae with SMTP id hs41-20020a1709073ea900b006dff19781aemr1659511ejc.402.1648850828864;
        Fri, 01 Apr 2022 15:07:08 -0700 (PDT)
Received: from localhost.localdomain ([78.44.231.212])
        by smtp.gmail.com with ESMTPSA id by4-20020a0564021b0400b00418fc410299sm1642324edb.62.2022.04.01.15.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 15:07:07 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabio.aiuto@amarulasolutions.com>
Subject: [RFC PATCH] md: dm-init: Wait devices if it's not find on first adpet
Date:   Sat,  2 Apr 2022 00:07:05 +0200
Message-Id: <20220401220705.82077-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device driver can be deferrable and can be a race during
the dm-init early. We need to wait all the probe are really finished
in a loop as is done in do_mounts. This is was tested on kernel 5.4
but code seems was not changed since that time

003: imx8mq-usb-phy 381f0040.usb-phy: 381f0040.usb-phy supply vbus not found, using dummy regulator
003: imx8mq-usb-phy 382f0040.usb-phy: 382f0040.usb-phy supply vbus not found, using dummy regulator
003: imx-cpufreq-dt imx-cpufreq-dt: cpu speed grade 5 mkt segment 0 supported-hw 0x20 0x1
003: caam-dma caam-dma: caam dma support with 2 job rings
000: hctosys: unable to open rtc device (rtc0)
000: device-mapper: init: waiting for all devices to be available before creating mapped devices
002: device-mapper: table: 254:0: verity: Data device lookup failed
002: device-mapper: ioctl: error adding target to table
002: crng init done
003: of_cfs_init
003: of_cfs_init: OK
003: Waiting for root device /dev/dm-0...
001: mmc2: new HS400 Enhanced strobe MMC card at address 0001
001: mmcblk2: mmc2:0001 IB2916 14.6 GiB
001: mmcblk2boot0: mmc2:0001 IB2916 partition 1 4.00 MiB
001: mmcblk2boot1: mmc2:0001 IB2916 partition 2 4.00 MiB
001: mmcblk2rpmb: mmc2:0001 IB2916 partition 3 4.00 MiB, chardev (249:0)
001:  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11
001: VSD_3V3: disabling

with the patch

003: device-mapper: init: waiting for all devices to be available before creating mapped devices

000: device-mapper: table: 254:0: verity: Data device lookup failed
000: device-mapper: ioctl: error adding target to table
002: crng init done
003: device-mapper: init: waiting for all devices to be available before creating mapped devices
003: device-mapper: table: 254:0: verity: Data device lookup failed
003: device-mapper: ioctl: error adding target to table
003: device-mapper: init: waiting for all devices to be available before creating mapped devices
000: device-mapper: table: 254:0: verity: Data device lookup failed
000: device-mapper: ioctl: error adding target to table
002: device-mapper: init: waiting for all devices to be available before creating mapped devices
002: device-mapper: table: 254:0: verity: Data device lookup failed
002: device-mapper: ioctl: error adding target to table
000: device-mapper: init: waiting for all devices to be available before creating mapped devices
000: device-mapper: table: 254:0: verity: Data device lookup failed
000: device-mapper: ioctl: error adding target to table
003: mmc2: new HS400 Enhanced strobe MMC card at address 0001
003: mmcblk2: mmc2:0001 DG4016 14.7 GiB
003: mmcblk2boot0: mmc2:0001 DG4016 partition 1 4.00 MiB
003: mmcblk2boot1: mmc2:0001 DG4016 partition 2 4.00 MiB
003: mmcblk2rpmb: mmc2:0001 DG4016 partition 3 4.00 MiB, chardev (249:0)
003:  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11
002: device-mapper: init: waiting for all devices to be available before creating mapped devices
003: device-mapper: verity: sha256 using implementation "sha256-caam"
000: device-mapper: ioctl: dm-0 (rootfs) is ready

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/md/dm-init.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index b0c45c6ebe0b..d3b754036484 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -7,7 +7,9 @@
  * This file is released under the GPLv2.
  */
 
+#include <linux/async.h>
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/device-mapper.h>
 #include <linux/init.h>
@@ -267,6 +269,7 @@ static int __init dm_init_init(void)
 	LIST_HEAD(devices);
 	char *str;
 	int r;
+	bool fail = false;
 
 	if (!create)
 		return 0;
@@ -275,6 +278,7 @@ static int __init dm_init_init(void)
 		DMERR("Argument is too big. Limit is %d", DM_MAX_STR_SIZE);
 		return -EINVAL;
 	}
+retry:
 	str = kstrndup(create, DM_MAX_STR_SIZE, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
@@ -288,12 +292,21 @@ static int __init dm_init_init(void)
 
 	list_for_each_entry(dev, &devices, list) {
 		if (dm_early_create(&dev->dmi, dev->table,
-				    dev->target_args_array))
+				    dev->target_args_array)) {
+			fail = true;
 			break;
+		}
 	}
+
 out:
 	kfree(str);
 	dm_setup_cleanup(&devices);
+	if (fail) {
+		msleep(5);
+		fail = false;
+		goto retry;
+	}
+
 	return r;
 }
 
-- 
2.25.1

