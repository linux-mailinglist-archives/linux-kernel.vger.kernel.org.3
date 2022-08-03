Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7635889CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiHCJtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiHCJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:48:25 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0598A5A16F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:48:19 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094818euoutp026c79d1b69a23a7ac19412a2368bde96b~HzLy470AS2007720077euoutp024
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:48:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220803094818euoutp026c79d1b69a23a7ac19412a2368bde96b~HzLy470AS2007720077euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659520098;
        bh=JRlwZvMkYHtnL6i9fUcNW6Rx0AlYf3L8pef0SqIDL+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpn7SprunHmvg0K2JkszwA8zERuPieu2z7YdfKpovUYMS4iGKCuRM7RDJKL/3iwPi
         73sFpX5WpV93cWeiaMeNAKXylBT+WKlOiiyFODIMlA3popdh6ToWOepcnIFjdOBNCh
         bRxqg+ogB4mY55Q0IQtQIlDXvaZxLERhR6rcuFAw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220803094816eucas1p1b2947b917caf6601922bdaac476f6824~HzLxRR4Ef3109731097eucas1p1g;
        Wed,  3 Aug 2022 09:48:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4F.06.10067.0644AE26; Wed,  3
        Aug 2022 10:48:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672~HzLwzq_rx1902519025eucas1p1R;
        Wed,  3 Aug 2022 09:48:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220803094816eusmtrp269f6b61586e288f08181b7c336900f37~HzLwy1l8g0972009720eusmtrp2i;
        Wed,  3 Aug 2022 09:48:16 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-6f-62ea446098ad
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.EB.09095.0644AE26; Wed,  3
        Aug 2022 10:48:16 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220803094816eusmtip261e6159d7d5bba642bb130f09846acf0~HzLwcNAPi1679316793eusmtip2f;
        Wed,  3 Aug 2022 09:48:16 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v9 13/13] dm: add power-of-2 target for zoned devices with
 non power-of-2 zone sizes
Date:   Wed,  3 Aug 2022 11:48:01 +0200
Message-Id: <20220803094801.177490-14-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djP87oJLq+SDN5M1LNYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWtw8sJPJYs+iSUwWK1cfZbJ4sn4Ws8XfrntA2VvaFpd3
        zWGzmL/sKbvFhLavzBafl7awW6y5+ZTF4sQtaQchj8tXvD12zrrL7nH5bKnHplWdbB6bl9R7
        7L7ZwOaxs/U+q8f7fVfZPPq2rGL02Hy62uPzJjmP9gPdTAE8UVw2Kak5mWWpRfp2CVwZh3/u
        YSw4V1hxveUHewPj5qguRk4OCQETialvuli7GLk4hARWMEo8X7eQESQhJPCFUaLtoCtE4jOj
        xNem7YwwHYebvzJBJJYzSsy4eo8ZwnnJKHF2WgvQLA4ONgEticZOdpC4iEAzo8Tdvz1gO5gF
        PjNJrNg3kxlklLBAmsTNvoNgNouAqsTSI5/AbF4Ba4kpD04yQ6yTl5h56Ts7iM0JEv/3D6pG
        UOLkzCcsIDYzUE3z1tlQ9ds5JZoXhEHYLhIvTi1mgrCFJV4d38IOYctI/N85HypeLfH0xm+w
        DyQEWhgl+neuZwP5QAJoWd+ZHBCTWUBTYv0ufYhyR4mFp3vZISr4JG68FYS4gE9i0rbpzBBh
        XomONiGIaiWJnT+fQC2VkLjcNIcFwvaQmPa4l30Co+IsJL/MQvLLLIS9CxiZVzGKp5YW56an
        FhvlpZbrFSfmFpfmpesl5+duYgQmxNP/jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeO+4PE8S4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzpucuSFRSCA9sSQ1OzW1ILUIJsvEwSnVwFSzd8+6v//cbvA+
        vNURfVY8MKtUQub2H9V4sVOsoRy397HWWtZ9nLM+lvtK+9fSGIt17ELa71a+2Be1v/WsJb/+
        BzuhdVUymuKcj6fuPvL4zppsX+E7rg8EAybU+j/zd2HfMGdae9/+mCihhrcH7n4zeb5Y4dLj
        pbMKGDTuZXWKWSg8mnTn0Z2/nxpmSzD9brnKerhF3HW2jPNhMWvR3XUqfno2qyZZZ/VqWyRl
        TvoZ4L9e7cH8s68YU26VfmCevIlfzbRQJfGTm89SRudmi5kH9q/rPvV8xTMX04bZcw/1sH9x
        OZ2nsqVEx85Qx7PmV+gknscfOuW3l1coOhsvEks44qzJzTBx6+MHp/g2HlFiKc5INNRiLipO
        BABKFLBX9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7oJLq+SDF5OFbRYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWtw8sJPJYs+iSUwWK1cfZbJ4sn4Ws8XfrntA2VvaFpd3
        zWGzmL/sKbvFhLavzBafl7awW6y5+ZTF4sQtaQchj8tXvD12zrrL7nH5bKnHplWdbB6bl9R7
        7L7ZwOaxs/U+q8f7fVfZPPq2rGL02Hy62uPzJjmP9gPdTAE8UXo2RfmlJakKGfnFJbZK0YYW
        RnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZh3/uYSw4V1hxveUHewPj5qguRk4O
        CQETicPNX5m6GLk4hASWMkq82biMGSIhIXF7YRMjhC0s8edaFxtE0XNGibvt71m7GDk42AS0
        JBo72UHiIgLdjBKXz5xjBXGYBZqZJV617GYD6RYWSJF4+m4B2CQWAVWJpUc+gW3gFbCWmPLg
        JNQ2eYmZl76zg9icIPF//8DiQgJWEuv+zmKFqBeUODnzCQuIzQxU37x1NvMERoFZSFKzkKQW
        MDKtYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzfbcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4
        77g8TxLiTUmsrEotyo8vKs1JLT7EaAp090RmKdHkfGACySuJNzQzMDU0MbM0MLU0M1YS5/Us
        6EgUEkhPLEnNTk0tSC2C6WPi4JRqYIqcxXm2SFZr77Nsf8fEWsmXS66y+S3cWPU1Rmpth+mN
        a4cFRVeq3OLRykhYvN8xtiHikdnR77NDYjoE7/78se0k3+evQRvLJv51vphnd/Ry9Fs7PZ1y
        JtdytyIZpoN7eFJ4+gTV/fdVHj/91XIRz4HDP0sKP8ssDeet/hlfvFHFy68yrP3UpNaXd8K/
        3/g2/+6pGx/2PuoNijLcv91r5+/Le5ZUqe2a9v1+xH0roRfvdh6XTvcVkJlx8/uN3jO+naXz
        X+y3Z9q3UrOSd6Fe63kOA8fJ6x5PS2w7q+5o11H9YPeG5qMbZDS3yN2ct2War9L6nZP/nTu8
        sHsXi7SkqPsLnVsXDu/p+1Kz9kled1S1EktxRqKhFnNRcSIAsAmZAGgDAAA=
X-CMS-MailID: 20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672
References: <20220803094801.177490-1-p.raghav@samsung.com>
        <CGME20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only zoned devices with power-of-2(po2) zone sizes were supported in linux
but now non power-of-2(npo2) zone sizes support has been added to the
block layer.

Filesystems such as F2FS and btrfs have support for zoned devices with
po2 zone size assumption. Before adding native support for npo2 zone
sizes, it was suggested to create a dm target for npo2 zone size device to
appear as a po2 size zoned target so that file systems can initially work
without any explicit changes by using this target.

The design of this target is very simple: remap the device zone size to
the zone capacity and change the zone size to be the nearest power of 2
number of sectors.

For e.g., a device with a zone size/capacity of 3M will have an equivalent
target layout as follows:

Device layout :-
zone capacity = 3M
zone size = 3M

|--------------|-------------|
0             3M            6M

Target layout :-
zone capacity=3M
zone size = 4M

|--------------|---|--------------|---|
0             3M  4M             7M  8M

The area between target's zone capacity and zone size will be emulated
in the target.
The read IOs that fall in the emulated gap area will return 0 filled
bio and all the other IOs in that area will result in an error.
If a read IO span across the emulated area boundary, then the IOs are
split across them. All other IO operations that span across the emulated
area boundary will result in an error.

The target can be easily created as follows:
dmsetup create <label> --table '0 <size_sects> po2zone /dev/nvme<id>'

Note that the target does not support partial mapping of the underlying
device.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
Suggested-by: Hannes Reinecke <hare@suse.de>
---
 .../admin-guide/device-mapper/dm-po2zone.rst  |  71 ++++++
 .../admin-guide/device-mapper/index.rst       |   1 +
 drivers/md/Kconfig                            |  10 +
 drivers/md/Makefile                           |   2 +
 drivers/md/dm-po2zone-target.c                | 240 ++++++++++++++++++
 5 files changed, 324 insertions(+)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-po2zone.rst
 create mode 100644 drivers/md/dm-po2zone-target.c

diff --git a/Documentation/admin-guide/device-mapper/dm-po2zone.rst b/Documentation/admin-guide/device-mapper/dm-po2zone.rst
new file mode 100644
index 000000000000..b2c240697e00
--- /dev/null
+++ b/Documentation/admin-guide/device-mapper/dm-po2zone.rst
@@ -0,0 +1,71 @@
+==========
+dm-po2zone
+==========
+The dm-po2zone device mapper target exposes a zoned block device with a
+non-power-of-2(npo2) zone number of sectors as a power-of-2(po2) zone number
+of sectors.
+The filesystems that support zoned block devices such as F2FS and BTRFS
+assume po2 zone size sectors as the kernel has traditionally only supported
+those devices. However, as the kernel now supports zoned block devices with
+npo2 zone size sectors, the dm-po2zone target can be used by the filesystems
+before adding native support.
+
+Partial mapping of the underlying device is not supported by this target.
+
+Algorithm
+=========
+The device mapper target maps the underlying device's zone size to the
+zone capacity and changes the zone size to the nearest po2 number of sectors.
+The gap between the zone capacity and the zone size is emulated in the target.
+E.g., a zoned block device with a zone size (and capacity) of 3M will have an
+equivalent target layout with mapping as follows:
+
+::
+
+  0M           3M  4M        6M 8M
+  |             |  |          |  |
+  +x------------+--+x---------+--+x-------  Target
+  |x            |  |x         |  |x
+   x               x             x
+   x               x             x
+   x              x             x
+   x             x             x
+  |x            |x            |x
+  +x------------+x------------+x----------  Device
+  |             |             |
+  0M           3M            6M
+
+A simple remap is performed for all the BIOs that do not cross the
+emulation gap area, i.e., the area between the zone capacity and size.
+
+If a BIO crosses the emulation gap area, the following operations are performed:
+
+	Read:
+		- If the BIO lies entirely in the emulation gap area, then zero out the BIO and complete it.
+		- If the BIO spans the emulation gap area, split the BIO across the zone capacity boundary
+                  and remap only the BIO within the zone capacity boundary. The other part of the split BIO
+                  will be zeroed out.
+
+	Other operations:
+                - Return an error
+
+Table parameters
+================
+
+::
+
+  <dev path>
+
+Mandatory parameters:
+
+    <dev path>:
+        Full pathname to the underlying block-device, or a
+        "major:minor" device-number.
+
+Examples
+========
+
+::
+
+  #!/bin/sh
+  echo "0 `blockdev --getsz $1` po2zone $1" | dmsetup create po2z
diff --git a/Documentation/admin-guide/device-mapper/index.rst b/Documentation/admin-guide/device-mapper/index.rst
index cde52cc09645..1fd04b5b0565 100644
--- a/Documentation/admin-guide/device-mapper/index.rst
+++ b/Documentation/admin-guide/device-mapper/index.rst
@@ -23,6 +23,7 @@ Device Mapper
     dm-service-time
     dm-uevent
     dm-zoned
+    dm-po2zone
     era
     kcopyd
     linear
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 998a5cfdbc4e..7cdd2d03ba7d 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -518,6 +518,16 @@ config DM_FLAKEY
 	help
 	 A target that intermittently fails I/O for debugging purposes.
 
+config DM_PO2ZONE
+	tristate "Power-of-2 zone number of sectors target for zoned block devices"
+	depends on BLK_DEV_DM
+	depends on BLK_DEV_ZONED
+	help
+	  A target that converts a zoned block device with non-power-of-2(npo2) zone
+	  number of sectors to be power-of-2(po2). Use this target for zoned block
+	  devices with npo2 zone number of sectors until native support is added to
+	  the filesystems and applications.
+
 config DM_VERITY
 	tristate "Verity target support"
 	depends on BLK_DEV_DM
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 84291e38dca8..c23f81cc8789 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -26,6 +26,7 @@ dm-era-y	+= dm-era-target.o
 dm-clone-y	+= dm-clone-target.o dm-clone-metadata.o
 dm-verity-y	+= dm-verity-target.o
 dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
+dm-po2zone-y	+= dm-po2zone-target.o
 
 md-mod-y	+= md.o md-bitmap.o
 raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
@@ -60,6 +61,7 @@ obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
 obj-$(CONFIG_DM_DELAY)		+= dm-delay.o
 obj-$(CONFIG_DM_DUST)		+= dm-dust.o
 obj-$(CONFIG_DM_FLAKEY)		+= dm-flakey.o
+obj-$(CONFIG_DM_PO2ZONE)	+= dm-po2zone.o
 obj-$(CONFIG_DM_MULTIPATH)	+= dm-multipath.o dm-round-robin.o
 obj-$(CONFIG_DM_MULTIPATH_QL)	+= dm-queue-length.o
 obj-$(CONFIG_DM_MULTIPATH_ST)	+= dm-service-time.o
diff --git a/drivers/md/dm-po2zone-target.c b/drivers/md/dm-po2zone-target.c
new file mode 100644
index 000000000000..64c4c0611ddf
--- /dev/null
+++ b/drivers/md/dm-po2zone-target.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/device-mapper.h>
+
+#define DM_MSG_PREFIX "po2zone"
+
+struct dm_po2z_target {
+	struct dm_dev *dev;
+	sector_t zone_size; /* Actual zone size of the underlying dev*/
+	sector_t zone_size_po2; /* zone_size rounded to the nearest po2 value */
+	unsigned int zone_size_po2_shift;
+	sector_t zone_size_diff; /* diff between zone_size_po2 and zone_size */
+	unsigned int nr_zones;
+};
+
+static inline unsigned int npo2_zone_no(struct dm_po2z_target *dmh,
+					sector_t sect)
+{
+	return div64_u64(sect, dmh->zone_size);
+}
+
+static inline unsigned int po2_zone_no(struct dm_po2z_target *dmh,
+				       sector_t sect)
+{
+	return sect >> dmh->zone_size_po2_shift;
+}
+
+static inline sector_t target_to_device_sect(struct dm_po2z_target *dmh,
+					     sector_t sect)
+{
+	return sect - (po2_zone_no(dmh, sect) * dmh->zone_size_diff);
+}
+
+static inline sector_t device_to_target_sect(struct dm_po2z_target *dmh,
+					     sector_t sect)
+{
+	return sect + (npo2_zone_no(dmh, sect) * dmh->zone_size_diff);
+}
+
+/*
+ * This target works on the complete zoned device. Partial mapping is not
+ * supported.
+ * Construct a zoned po2 logical device: <dev-path>
+ */
+static int dm_po2z_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	struct dm_po2z_target *dmh = NULL;
+	int ret;
+	sector_t zone_size;
+	sector_t dev_capacity;
+
+	if (argc != 1)
+		return -EINVAL;
+
+	dmh = kmalloc(sizeof(*dmh), GFP_KERNEL);
+	if (!dmh)
+		return -ENOMEM;
+
+	ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table),
+			    &dmh->dev);
+
+	if (ret) {
+		ti->error = "Device lookup failed";
+		kfree(dmh);
+		return ret;
+	}
+
+	zone_size = bdev_zone_sectors(dmh->dev->bdev);
+	dev_capacity = get_capacity(dmh->dev->bdev->bd_disk);
+	if (ti->len != dev_capacity || ti->begin) {
+		DMERR("%pg Partial mapping of the target not supported",
+		      dmh->dev->bdev);
+		kfree(dmh);
+		return -EINVAL;
+	}
+
+	if (is_power_of_2(zone_size))
+		DMWARN("%pg:not a useful target for devices with po2 zone number of sectors",
+		       dmh->dev->bdev);
+
+	dmh->zone_size = zone_size;
+	dmh->zone_size_po2 = 1 << get_count_order_long(zone_size);
+	dmh->zone_size_po2_shift = ilog2(dmh->zone_size_po2);
+	dmh->zone_size_diff = dmh->zone_size_po2 - dmh->zone_size;
+	ti->private = dmh;
+	ti->max_io_len = dmh->zone_size_po2;
+	dmh->nr_zones = npo2_zone_no(dmh, ti->len);
+	ti->len = dmh->zone_size_po2 * dmh->nr_zones;
+
+	return 0;
+}
+
+static int dm_po2z_report_zones_cb(struct blk_zone *zone, unsigned int idx,
+				   void *data)
+{
+	struct dm_report_zones_args *args = data;
+	struct dm_po2z_target *dmh = args->tgt->private;
+
+	zone->start = device_to_target_sect(dmh, zone->start);
+	zone->wp = device_to_target_sect(dmh, zone->wp);
+	zone->len = dmh->zone_size_po2;
+	args->next_sector = zone->start + zone->len;
+
+	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
+}
+
+static int dm_po2z_report_zones(struct dm_target *ti,
+				struct dm_report_zones_args *args,
+				unsigned int nr_zones)
+{
+	struct dm_po2z_target *dmh = ti->private;
+	sector_t sect = po2_zone_no(dmh, args->next_sector) * dmh->zone_size;
+
+	return blkdev_report_zones(dmh->dev->bdev, sect, nr_zones,
+				   dm_po2z_report_zones_cb, args);
+}
+
+static int dm_po2z_end_io(struct dm_target *ti, struct bio *bio,
+			  blk_status_t *error)
+{
+	struct dm_po2z_target *dmh = ti->private;
+
+	if (bio->bi_status == BLK_STS_OK && bio_op(bio) == REQ_OP_ZONE_APPEND)
+		bio->bi_iter.bi_sector =
+			device_to_target_sect(dmh, bio->bi_iter.bi_sector);
+
+	return DM_ENDIO_DONE;
+}
+
+static void dm_po2z_io_hints(struct dm_target *ti, struct queue_limits *limits)
+{
+	struct dm_po2z_target *dmh = ti->private;
+
+	limits->chunk_sectors = dmh->zone_size_po2;
+}
+
+static bool bio_across_emulated_zone_area(struct dm_po2z_target *dmh,
+					  struct bio *bio)
+{
+	unsigned int zone_idx = po2_zone_no(dmh, bio->bi_iter.bi_sector);
+	sector_t nr_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+
+	return (bio->bi_iter.bi_sector + nr_sectors) >
+	       (zone_idx * dmh->zone_size_po2) + dmh->zone_size;
+}
+
+static int dm_po2z_map_read_emulated_area(struct dm_po2z_target *dmh,
+					  struct bio *bio)
+{
+	sector_t start_sect = bio->bi_iter.bi_sector;
+	unsigned int zone_idx = po2_zone_no(dmh, start_sect);
+	sector_t relative_sect_in_zone = start_sect - (zone_idx * dmh->zone_size_po2);
+	sector_t split_io_pos;
+
+	/*
+	 * If the starting sector is in the emulated area then fill
+	 * all the bio with zeros. If bio is across emulated zone boundary,
+	 * split the bio across boundaries and fill zeros only for the
+	 * bio that is between the zone capacity and the zone size.
+	 */
+	if (relative_sect_in_zone < dmh->zone_size) {
+		split_io_pos = (zone_idx * dmh->zone_size_po2) + dmh->zone_size;
+		dm_accept_partial_bio(bio, split_io_pos - start_sect);
+		bio->bi_iter.bi_sector = target_to_device_sect(dmh, start_sect);
+
+		return DM_MAPIO_REMAPPED;
+	}
+
+	zero_fill_bio(bio);
+	bio_endio(bio);
+	return DM_MAPIO_SUBMITTED;
+}
+
+static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
+{
+	struct dm_po2z_target *dmh = ti->private;
+
+	bio_set_dev(bio, dmh->dev->bdev);
+	if (bio_sectors(bio) || op_is_zone_mgmt(bio_op(bio))) {
+		if (!bio_across_emulated_zone_area(dmh, bio)) {
+			bio->bi_iter.bi_sector = target_to_device_sect(dmh,
+								       bio->bi_iter.bi_sector);
+			return DM_MAPIO_REMAPPED;
+		}
+		/*
+		 * Read operation on the emulated zone area (between zone capacity
+		 * and zone size) will fill the bio with zeroes. Any other operation
+		 * in the emulated area should return an error.
+		 */
+		if (bio_op(bio) == REQ_OP_READ)
+			return dm_po2z_map_read_emulated_area(dmh, bio);
+
+		return DM_MAPIO_KILL;
+	}
+	return DM_MAPIO_REMAPPED;
+}
+
+static int dm_po2z_iterate_devices(struct dm_target *ti,
+				   iterate_devices_callout_fn fn, void *data)
+{
+	struct dm_po2z_target *dmh = ti->private;
+	sector_t len = dmh->nr_zones * dmh->zone_size;
+
+	return fn(ti, dmh->dev, 0, len, data);
+}
+
+static struct target_type dm_po2z_target = {
+	.name = "po2zone",
+	.version = { 1, 0, 0 },
+	.features = DM_TARGET_ZONED_HM | DM_TARGET_EMULATED_ZONES,
+	.map = dm_po2z_map,
+	.end_io = dm_po2z_end_io,
+	.report_zones = dm_po2z_report_zones,
+	.iterate_devices = dm_po2z_iterate_devices,
+	.module = THIS_MODULE,
+	.io_hints = dm_po2z_io_hints,
+	.ctr = dm_po2z_ctr,
+};
+
+static int __init dm_po2z_init(void)
+{
+	return dm_register_target(&dm_po2z_target);
+}
+
+static void __exit dm_po2z_exit(void)
+{
+	dm_unregister_target(&dm_po2z_target);
+}
+
+/* Module hooks */
+module_init(dm_po2z_init);
+module_exit(dm_po2z_exit);
+
+MODULE_DESCRIPTION(DM_NAME "power-of-2 zoned target");
+MODULE_AUTHOR("Pankaj Raghav <p.raghav@samsung.com>");
+MODULE_LICENSE("GPL");
+
-- 
2.25.1

