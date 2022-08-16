Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79483595D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiHPNQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiHPNP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:15:58 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C6C61D77
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:15:54 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131553euoutp022a62968de80649566a3bdac9d0e43342~L1ZwFvcxv2682526825euoutp02a
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:15:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220816131553euoutp022a62968de80649566a3bdac9d0e43342~L1ZwFvcxv2682526825euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660655753;
        bh=PvnenMuRv4p19PPEMOW1GA5OXgVclqzULdTF9h0TpXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Chr9StB+BuLCOZziSJvQFNcAbac7bnxFyktdQdTage+kX7iuSqRdEer5fQGfkvFx9
         pvhOrv9jHAgW5+8DdtZUBozaDUQJN+6a8xUdmqsqsi5WgW1mMLCYRp0e7UQ/xXbMa+
         GQbaKc3MDdn8yVdH8Oh4STKolwFhusk0tCQwJx7E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220816131552eucas1p1709a353975f87319714174c850fd7b1d~L1ZunC-aD0140201402eucas1p1f;
        Tue, 16 Aug 2022 13:15:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AC.75.09580.7889BF26; Tue, 16
        Aug 2022 14:15:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220816131551eucas1p218faf35348e78a73aaa87d5477ecdb2e~L1ZuLzZAy2105421054eucas1p2Y;
        Tue, 16 Aug 2022 13:15:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220816131551eusmtrp1815fdc7c94e0639069a8d54ef394dfd4~L1ZuLA3xS0149801498eusmtrp1U;
        Tue, 16 Aug 2022 13:15:51 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-02-62fb98871665
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.B0.09095.7889BF26; Tue, 16
        Aug 2022 14:15:51 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816131551eusmtip2e31148a6f0507b64d252ad661f155c16~L1Zt06k2_1196811968eusmtip2e;
        Tue, 16 Aug 2022 13:15:51 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v11 13/13] dm: add power-of-2 target for zoned devices with
 non power-of-2 zone sizes
Date:   Tue, 16 Aug 2022 15:15:36 +0200
Message-Id: <20220816131536.189406-14-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7odM34nGTSvYrRYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWtw8sJPJYs+iSUwWK1cfZbJ4sn4Ws8XfrntA2VvaFpd3
        zWGzmL/sKbvFhLavzBafl7awW6y5+ZTF4sQtaQchj8tXvD12zrrL7nH5bKnHplWdbB6bl9R7
        7L7ZwOaxs/U+q8f7fVfZPPq2rGL02Hy62uPzJjmP9gPdTAE8UVw2Kak5mWWpRfp2CVwZ1yf0
        MRWsKalYuqGugXF/TBcjJ4eEgIlE1/W5zF2MXBxCAisYJQ4uucwE4XxhlOiYf5QVwvnMKPF/
        9UtGmJbn039BJZYzStxfsoYdwnnBKDFzyjeWLkYODjYBLYnGTnaQBhGBdIkpLS9ZQGxmgYnM
        EtNmpIDYwkDxadc2s4HYLAKqEl0/FoEt4BWwlmj9dIQVYpm8xMxL38HmcALF/zWsYoGoEZQ4
        OfMJ1Ex5ieats8F+kBBYzymx8tcHdohmF4lfn68xQdjCEq+Ob4GKy0icntzDAmFXSzy98Ruq
        uYVRon/nejaQBySAtvWdyQExmQU0Jdbv0ocod5TYcO0LC0QFn8SNt4IQJ/BJTNo2nRkizCvR
        0SYEUa0ksfPnE6ilEhKXm+ZALfWQ+NiwjH0Co+IsJM/MQvLMLIS9CxiZVzGKp5YW56anFhvn
        pZbrFSfmFpfmpesl5+duYgSmw9P/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeAVf/EgS4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkzpucuSFRSCA9sSQ1OzW1ILUIJsvEwSnVwCRWWfR7W/Cr+5nF/qoL
        i4/2xLzZEWL/V9pHunB2g3zduzk8k45+2svYceP5hysWhpN/HSnRks/5eSnzz9Ri+9T3LO6e
        Fv2HcwS2z3V51hX18rCkdpRX6eJOueXss95aOLyc9NEkc5ut5/+s5B9JU3g+7tgyfwdr56bL
        sncftZ0NeRPsY7hohUtdmeqL3QVzzLTXuG2//M932ocTWz4kybh28SleL0uSe2LvnTVDbr9K
        2fc/+v+Xp5dsr5gZ1hdcu2tqFXvoqkVlrX+2fvvCOPniwvx7pcnTFXsFGievX6vjvCv5zdV3
        uzdEvXdSuFGz+H2Kx77u5AdFUTfW2k0QsDZg1tmdX3p8nenqaVH5S+KUWIozEg21mIuKEwG1
        R0hF9gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7rtM34nGdx4I2+x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaL1vZvTBZ7381mtbh5YCeTxZ5Fk5gsVq4+ymTxZP0sZou/XfeAsre0LS7v
        msNmMX/ZU3aLCW1fmS0+L21ht1hz8ymLxYlb0g5CHpeveHvsnHWX3ePy2VKPTas62Tw2L6n3
        2H2zgc1jZ+t9Vo/3+66yefRtWcXosfl0tcfnTXIe7Qe6mQJ4ovRsivJLS1IVMvKLS2yVog0t
        jPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyrk/oYypYU1KxdENdA+P+mC5GTg4J
        AROJ59N/sXYxcnEICSxllNh7eDMbREJC4vbCJkYIW1jiz7UusLiQwDNGieXHZLsYOTjYBLQk
        GjvZQcIiArkSi5Z1gM1hFljILNGw5hVYvbBAqsSqOZ+ZQWwWAVWJrh+LwGbyClhLtH46wgox
        X15i5qXvYIM4geL/GlaxQOyykmg7dpkZol5Q4uTMJ2BxZqD65q2zmScwCsxCkpqFJLWAkWkV
        o0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYORuO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMIr+OJH
        khBvSmJlVWpRfnxRaU5q8SFGU6C7JzJLiSbnA1NHXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQ
        QHpiSWp2ampBahFMHxMHp1QDk1NX+J26WPXiOOvFjMcXrGPg8vFf/7Q/VCe2Sn5HpHrRXNsV
        D2W2+jSVFDdciV1UUuuuHfDi1f4lQTptnPvvLf/qHhoY/DrAdU3gji726Kbz7i9yH+TsTdA0
        b2WsMe9nNpq+L/LUi2O6K0/M+34+zlVvxzGuVof51w7oN0XVhJY0t1VaNc22Kqvi9RT7Zma2
        cP/lectXsXJM6V8nEGUUtWn/MlPbX7s82/cYVsw3Dk3i4/cLcXUV3GPl9C3uRsn6GRNYSwWu
        pQkuvWV24qfOk0mfnRKnxXgZ7D9n2tA1/8cb+633ot3Xh97ZqPTq86sSp0zRhWKXTnAsPLLF
        asHs2/vdE/cEZe3ax/aitJVLiaU4I9FQi7moOBEA7hQFAWUDAAA=
X-CMS-MailID: 20220816131551eucas1p218faf35348e78a73aaa87d5477ecdb2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131551eucas1p218faf35348e78a73aaa87d5477ecdb2e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131551eucas1p218faf35348e78a73aaa87d5477ecdb2e
References: <20220816131536.189406-1-p.raghav@samsung.com>
        <CGME20220816131551eucas1p218faf35348e78a73aaa87d5477ecdb2e@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only zoned devices with power-of-2(po2) number of sectors per zone(zone
size) were supported in linux but now non power-of-2(npo2) zone sizes
support has been added to the block layer.

Filesystems such as F2FS and btrfs have support for zoned devices with
po2 zone size assumption. Before adding native support for npo2 zone
sizes, it was suggested to create a dm target for npo2 zone size device to
appear as a po2 zone size target so that file systems can initially
work without any explicit changes by using this target.

The design of this target is very simple: remap the device zone size to
the zone capacity and change the zone size to be the nearest power of 2
value.

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
 .../admin-guide/device-mapper/dm-po2zone.rst  |  71 +++++
 .../admin-guide/device-mapper/index.rst       |   1 +
 drivers/md/Kconfig                            |  10 +
 drivers/md/Makefile                           |   2 +
 drivers/md/dm-po2zone-target.c                | 260 ++++++++++++++++++
 5 files changed, 344 insertions(+)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-po2zone.rst
 create mode 100644 drivers/md/dm-po2zone-target.c

diff --git a/Documentation/admin-guide/device-mapper/dm-po2zone.rst b/Documentation/admin-guide/device-mapper/dm-po2zone.rst
new file mode 100644
index 000000000000..19dc215fbcca
--- /dev/null
+++ b/Documentation/admin-guide/device-mapper/dm-po2zone.rst
@@ -0,0 +1,71 @@
+==========
+dm-po2zone
+==========
+The dm-po2zone device mapper target exposes a zoned block device with a
+non-power-of-2(npo2) number of sectors per zone as a power-of-2(po2)
+number of sectors per zone(zone size).
+The filesystems that support zoned block devices such as F2FS and BTRFS
+assume po2 zone size as the kernel has traditionally only supported
+those devices. However, as the kernel now supports zoned block devices with
+npo2 zone sizes, the filesystems can run on top of the dm-po2zone target before
+adding native support.
+
+Partial mapping of the underlying device is not supported by this target.
+
+Algorithm
+=========
+The device mapper target maps the underlying device's zone size to the
+zone capacity and changes the zone size to the nearest po2 zone size.
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
index 998a5cfdbc4e..638801b2449a 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -518,6 +518,16 @@ config DM_FLAKEY
 	help
 	 A target that intermittently fails I/O for debugging purposes.
 
+config DM_PO2ZONE
+	tristate "Zoned block devices target emulating a power-of-2 number of sectors per zone"
+	depends on BLK_DEV_DM
+	depends on BLK_DEV_ZONED
+	help
+	  A target that converts a zoned block device with non-power-of-2(npo2)
+	  number of sectors per zone to be power-of-2(po2). Use this target for
+	  zoned block devices with npo2 number of sectors per zone until native
+	  support is added to the filesystems and applications.
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
index 000000000000..15dee7e218f1
--- /dev/null
+++ b/drivers/md/dm-po2zone-target.c
@@ -0,0 +1,260 @@
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
+	if (ret) {
+		ti->error = "Device lookup failed";
+		kfree(dmh);
+		return ret;
+	}
+
+	if (!bdev_is_zoned(dmh->dev->bdev)) {
+		DMERR("%pg is not a zoned device", dmh->dev->bdev);
+		kfree(dmh);
+		return -EINVAL;
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
+		DMWARN("%pg: underlying device has a power-of-2 number of sectors per zone",
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
+/**
+ * bio_in_emulated_zone_area - check if bio is in the emulated zone area
+ * @dmh:	pozone target data
+ * @bio:	bio
+ * @offset:	bio offset to emulated zone boundary
+ *
+ * Check if a @bio is partly or completely in the emulated zone area. If the
+ * @bio is partly in the emulated zone area, @offset can be used to split
+ * the @bio across the emulated zone boundary. @offset
+ * will be negative if the @bio completely lies in the emulated area.
+ *
+ */
+static bool bio_in_emulated_zone_area(struct dm_po2z_target *dmh,
+				      struct bio *bio, int *offset)
+{
+	unsigned int zone_idx = po2_zone_no(dmh, bio->bi_iter.bi_sector);
+	sector_t nr_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+	sector_t sector_offset =
+		bio->bi_iter.bi_sector - (zone_idx << dmh->zone_size_po2_shift);
+
+	*offset = dmh->zone_size - sector_offset;
+
+	return sector_offset + nr_sectors > dmh->zone_size;
+}
+
+static inline int dm_po2z_read_zeroes(struct bio *bio)
+{
+	zero_fill_bio(bio);
+	bio_endio(bio);
+	return DM_MAPIO_SUBMITTED;
+}
+
+static inline int dm_po2z_remap_sector(struct dm_po2z_target *dmh,
+				       struct bio *bio)
+{
+	bio->bi_iter.bi_sector =
+		target_to_device_sect(dmh, bio->bi_iter.bi_sector);
+	return DM_MAPIO_REMAPPED;
+}
+
+static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
+{
+	struct dm_po2z_target *dmh = ti->private;
+	int split_io_pos;
+
+	bio_set_dev(bio, dmh->dev->bdev);
+
+	if (op_is_zone_mgmt(bio_op(bio)))
+		return dm_po2z_remap_sector(dmh, bio);
+
+	if (!bio_sectors(bio))
+		return DM_MAPIO_REMAPPED;
+
+	/*
+	 * Read operation on the emulated zone area (between zone capacity
+	 * and zone size) will fill the bio with zeroes. Any other operation
+	 * in the emulated area should return an error.
+	 */
+	if (!bio_in_emulated_zone_area(dmh, bio, &split_io_pos))
+		return dm_po2z_remap_sector(dmh, bio);
+
+	if (bio_op(bio) == REQ_OP_READ) {
+	/*
+	 * If the bio is across emulated zone boundary, split the bio at
+	 * the boundary.
+	 */
+		if (split_io_pos > 0) {
+			dm_accept_partial_bio(bio, split_io_pos);
+			return dm_po2z_remap_sector(dmh, bio);
+		}
+		return dm_po2z_read_zeroes(bio);
+	}
+
+	return DM_MAPIO_KILL;
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

