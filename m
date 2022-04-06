Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89594F5ED4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiDFM7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiDFM6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:58:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE674DA2AC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:17:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q19so2226481wrc.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWBaEVUBDDNzpQMGgXvkac5bmwT4s5z5HH47ILBsXb0=;
        b=RxetGelaZZ7ZUEEeV5nytpcskubzwxsgDty9AJXC+B0OTbdeDKekZa3qXPdIAIEdNE
         ZkZlBPYROqWZU6t8udq3he9KU2Hr7xkWhoBrc5Newf9y0DASztyzCdvYO6Sn3P0WeGT8
         euWq50kaGLk1+SW08L39mJqfZ/Kvue7D5GNAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWBaEVUBDDNzpQMGgXvkac5bmwT4s5z5HH47ILBsXb0=;
        b=Iwg4pQe122VkrxtKokU7PnI9opVozh6EzBkxTShIeiP9l3yjg03hNFm8KGDBaDNwJc
         voC5YwhquLWePTjNXqpNJnNyE7QIVBvowiwPF41RL6R+mFWdepNfr/GgWUdaWOsiojp8
         qLRbdGFSK1ZGyWAXYuCqv36TE6QeuL/7OGeq2/YBzR/4+5sAPkXIsS9NjY2Gnoj+iGoq
         xIsudKwwfIgCT3keFYZnB3jyH8AzDaIeZ2cL0y+Xvl6CkOrGGCyN5lqRty3dUjXwMIF7
         NyYjTA3inj9h831+KIkMyrOUDTsbJhhrnpvW1R7Wsy869CSP8gwqpdi4B9VeJnQLgSNd
         WYKA==
X-Gm-Message-State: AOAM5330GaOcMcuoT+VCbx3x3Zq+avnlIT4DU0a+oRiPdDKVqek/KvCi
        mDVUmHm3UjVlFgPfQZ6nhZW6kw==
X-Google-Smtp-Source: ABdhPJwDgH3Ersfo1tIYfKaPiwVX9/l0yqpMIld8lDNPvdNNHQkDoNONRo/USEuKs0NqlkTeN3vN7w==
X-Received: by 2002:a05:6000:243:b0:206:964:d7d1 with SMTP id m3-20020a056000024300b002060964d7d1mr5664875wrz.433.1649236644179;
        Wed, 06 Apr 2022 02:17:24 -0700 (PDT)
Received: from amarula.amarulasolutions.com (77-32-12-209.dyn.eolo.it. [77.32.12.209])
        by smtp.gmail.com with ESMTPSA id s12-20020a7bc38c000000b0038e708d163dsm3609569wmj.0.2022.04.06.02.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 02:17:23 -0700 (PDT)
From:   Fabio Aiuto <fabio.aiuto@amarulasolutions.com>
To:     agk@redhat.com, snitzer@kernel.org
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2] md: dm-init: Wait devices if it's not find on first adpet
Date:   Wed,  6 Apr 2022 11:17:22 +0200
Message-Id: <20220406091722.314590-1-fabio.aiuto@amarulasolutions.com>
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
more than 4 loops before succesfully find data device.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@amarulasolutions.com>
---

Changes from v1:
	- limit the loop to 10 iterations
	- change variable names
	- check only for -ENODEV failures

 drivers/md/dm-init.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index b0c45c6ebe0b..406a9f92723d 100644
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
@@ -18,6 +20,7 @@
 #define DM_MAX_DEVICES 256
 #define DM_MAX_TARGETS 256
 #define DM_MAX_STR_SIZE 4096
+#define DM_MAX_PROBE_WAIT_RETRY 10
 
 static char *create;
 
@@ -267,6 +270,8 @@ static int __init dm_init_init(void)
 	LIST_HEAD(devices);
 	char *str;
 	int r;
+	int loopcnt = DM_MAX_PROBE_WAIT_RETRY;
+	bool devnotfound = false;
 
 	if (!create)
 		return 0;
@@ -275,6 +280,7 @@ static int __init dm_init_init(void)
 		DMERR("Argument is too big. Limit is %d", DM_MAX_STR_SIZE);
 		return -EINVAL;
 	}
+retry:
 	str = kstrndup(create, DM_MAX_STR_SIZE, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
@@ -287,13 +293,23 @@ static int __init dm_init_init(void)
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
 
-- 
2.30.2

