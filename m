Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D304F671B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbiDFRic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239897AbiDFRiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:38:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE021CFFA5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:46:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso3898739wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7i5fqIjPCuBRPSNQcsQxgqCqyICNl6AH42cdEc+yEQ=;
        b=U7m5Z2u+eJzUk8VkHRb/RwLQIG3AB2s5PYvohe6Ue9KG11lvEbAW2mZLxgkglkrJt6
         4LN+BwOOCd+l/VYLUMKspIvVNcikV6JK5zMytQp0duRlojij67LyJ9Zc5hJjLblNY9Ac
         dtZm/DJfjZYDAhfCSpFsA0ot5nQDdcmN4K5vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7i5fqIjPCuBRPSNQcsQxgqCqyICNl6AH42cdEc+yEQ=;
        b=rRpvIJPkRLw8oA+rrq7B6zdCm5VbO+bbQvYiKeBJIdYKYbpfgt0z8RzlOmNtCmiF7H
         a9kghCxkNaCOJtOY9qRkDxtf3jbkt245/ojszYzUFsmY+a9xvHyr2pjrbITMw3wrTLPN
         I0muA2pDPqf1NekYIYR+zb6SiCsCg38sPRuBcSfmvApRMvhKlF5Basbkcj/vctRd1HC2
         78oNO9j3X/7IrfILn4y2PiayvICldQ8IL1zlpA4i905SrBuwIFT97fYPG2Xkw9m5fvoq
         cg0sVsVyW65ZCojtVWwULUCBFx4/27BiK/ttNVe8PQZoxs33QkJOqQHiotqlTwF5jT3+
         /WCg==
X-Gm-Message-State: AOAM533jewyijGWM493ejzsV4Y5BOuofxzW3pRtfmgx3grcw9DRvamCE
        1iRt89huZImGROEzZ0pekkYkWQ==
X-Google-Smtp-Source: ABdhPJys5Bo9ztdLxydOo5LBEYNo7oHRyJ8vIXN458O2Bw72RWUm15njJG9rhQqFwouzjM6Z4YVPtA==
X-Received: by 2002:a05:600c:3d14:b0:38c:9d85:781d with SMTP id bh20-20020a05600c3d1400b0038c9d85781dmr8056737wmb.191.1649259993019;
        Wed, 06 Apr 2022 08:46:33 -0700 (PDT)
Received: from amarula.amarulasolutions.com (77-32-12-93.dyn.eolo.it. [77.32.12.93])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0038cba2f88c0sm7383922wms.26.2022.04.06.08.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:46:32 -0700 (PDT)
From:   Fabio Aiuto <fabio.aiuto@amarulasolutions.com>
To:     agk@redhat.com, snitzer@kernel.org
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v3] md: dm-init: Wait devices if it's not find on first adpet
Date:   Wed,  6 Apr 2022 17:46:31 +0200
Message-Id: <20220406154631.277107-1-fabio.aiuto@amarulasolutions.com>
X-Mailer: git-send-email 2.30.2
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

From: Michael Trimarchi <michael@amarulasolutions.com>

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

Wait loop is limited to 10 at the moment for our use case showed no
more than 4 loops before successfully find data device.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@amarulasolutions.com>
---
Changes from v1:
        - limit the loop to 10 iterations
        - change variable names
        - check only for -ENODEV failures

Changes from v2:
	- use a limit in seconds (not in retry
	  number)
	- add a parameter
	- update docs

 .../admin-guide/device-mapper/dm-init.rst     | 13 +++++++++++
 drivers/md/dm-init.c                          | 23 +++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/dm-init.rst b/Documentation/admin-guide/device-mapper/dm-init.rst
index e5242ff17e9b..5c2f2bf1db03 100644
--- a/Documentation/admin-guide/device-mapper/dm-init.rst
+++ b/Documentation/admin-guide/device-mapper/dm-init.rst
@@ -123,3 +123,16 @@ Other examples (per target):
     0 1638400 verity 1 8:1 8:2 4096 4096 204800 1 sha256
     fb1a5a0f00deb908d8b53cb270858975e76cf64105d412ce764225d53b8f3cfd
     51934789604d1b92399c52e7cb149d1b3a1b74bbbcb103b2a0aaacbed5c08584
+
+Delay for waiting deferred probes of block devices
+==================================================
+
+Sometimes the late initcall starting the early creation of mapped
+devices, starts too early. A loop waiting for probing of block
+devices has been added; the default maximum delay is 1 second but
+it can be set through the following kernel command::
+
+  dm-mod.delay=<seconds>
+
+This allows the procedure to retry the creation of a mapped device
+after a short wait (5 msecs).
diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index b0c45c6ebe0b..f4c5b4a46001 100644
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
@@ -18,8 +20,10 @@
 #define DM_MAX_DEVICES 256
 #define DM_MAX_TARGETS 256
 #define DM_MAX_STR_SIZE 4096
+#define DM_DEFAULT_MAX_PROBE_DELAY 1
 
 static char *create;
+static int delay = DM_DEFAULT_MAX_PROBE_DELAY;
 
 /*
  * Format: dm-mod.create=<name>,<uuid>,<minor>,<flags>,<table>[,<table>+][;<name>,<uuid>,<minor>,<flags>,<table>[,<table>+]+]
@@ -267,6 +271,8 @@ static int __init dm_init_init(void)
 	LIST_HEAD(devices);
 	char *str;
 	int r;
+	int loopcnt = delay * 1000 / 5;
+	bool devnotfound = false;
 
 	if (!create)
 		return 0;
@@ -275,6 +281,7 @@ static int __init dm_init_init(void)
 		DMERR("Argument is too big. Limit is %d", DM_MAX_STR_SIZE);
 		return -EINVAL;
 	}
+retry:
 	str = kstrndup(create, DM_MAX_STR_SIZE, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
@@ -287,13 +294,23 @@ static int __init dm_init_init(void)
 	wait_for_device_probe();
 
 	list_for_each_entry(dev, &devices, list) {
-		if (dm_early_create(&dev->dmi, dev->table,
-				    dev->target_args_array))
+		r = dm_early_create(&dev->dmi, dev->table, dev->target_args_array);
+		if (r == -ENODEV) {
+			devnotfound = true;
 			break;
+		}
 	}
+
 out:
 	kfree(str);
 	dm_setup_cleanup(&devices);
+	if (devnotfound && loopcnt) {
+		msleep(5);
+		devnotfound = false;
+		loopcnt--;
+		goto retry;
+	}
+
 	return r;
 }
 
@@ -301,3 +318,5 @@ late_initcall(dm_init_init);
 
 module_param(create, charp, 0);
 MODULE_PARM_DESC(create, "Create a mapped device in early boot");
+module_param(delay, int, 0);
+MODULE_PARM_DESC(delay, "Max delay to wait for data/hash device probe in seconds");
-- 
2.30.2

