Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB1958FE5D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbiHKOcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiHKObE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:31:04 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0661D647FA
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:31:03 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143101euoutp0129ee32f3284a04645e6d94faef252017~KUM7Tw3UA2629226292euoutp01C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:31:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220811143101euoutp0129ee32f3284a04645e6d94faef252017~KUM7Tw3UA2629226292euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660228261;
        bh=IUoyViCkp3U4Q2I4KlB9fJBiLbxoRuZRmvXdr8vBKuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5mnu1ZU8jhMXs7D+vSKNJsr68tpM3M8oXucQZ2iQUMgbQXrVnAHwTeyU3sYCkuFW
         EFxt6sGPcLduFfkNG6GLwcSZoVBF4aB9SOTkFcmXz5EW+17lP2qTeDlZ2agio1oo4J
         bQGtLGHVi/q62pNljs+JGU58AGMDq+fPmKzFZ8yw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220811143059eucas1p1e317135f18477c5d913e987c19bcbcbe~KUM5Yg33T1847718477eucas1p1N;
        Thu, 11 Aug 2022 14:30:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3D.3A.09664.3A215F26; Thu, 11
        Aug 2022 15:30:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220811143058eucas1p247291685ffff7a75186947fd30b5c13f~KUM4hWTb42359623596eucas1p2O;
        Thu, 11 Aug 2022 14:30:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220811143058eusmtrp28f9fb8f8a36160410731318772fa88f6~KUM4gZwt30788907889eusmtrp22;
        Thu, 11 Aug 2022 14:30:58 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-15-62f512a3e869
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 89.9F.09095.2A215F26; Thu, 11
        Aug 2022 15:30:58 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220811143058eusmtip172ed3770e81c435d3d628314002e940f~KUM4IHz2d1917919179eusmtip1b;
        Thu, 11 Aug 2022 14:30:58 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v10 13/13] dm: add power-of-2 target for zoned devices with
 non power-of-2 zone sizes
Date:   Thu, 11 Aug 2022 16:30:43 +0200
Message-Id: <20220811143043.126029-14-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811143043.126029-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7djPc7qLhb4mGUy5p2ux/tQxZovVd/vZ
        LKZ9+Mls8fvseWaL1vZvTBZ7381mtbh5YCeTxZ5Fk5gsVq4+ymSxdP9DRosn62cxW/ztugdU
        ckvb4vKuOWwW85c9ZbeY0PaV2eLz0hZ2izU3n7JYnLgl7SDscfmKt8fOWXfZPS6fLfXYtKqT
        zWPzknqP3Tcb2Dx2tt5n9Xi/7yqbR9+WVYwem09Xe3zeJOfRfqCbKYAnissmJTUnsyy1SN8u
        gStj0/dJbAXHiyumzlzN3MDYEtPFyMkhIWAi8XFlO1MXIxeHkMAKRok9Ly6xQjhfGCUuntjI
        DOF8ZpQ4v305M0zLkWcX2CESyxkl7nc0s0E4Lxglfm2/C9TPwcEmoCXR2MkO0iAikC6xfsFy
        FpAaZoHdzBKn3zQxgSSEgRKPpjaygNgsAqoSP39vAIvzClhL3Jh2jQlim7zEzEvfwQZxAsUn
        LLoIVSMocXLmE7BeZqCa5q2zwU6VENjNKbFn1WOoU10kVqx4xAZhC0u8Or6FHcKWkfi/cz7U
        gmqJpzd+QzW3MEr071zPBvKBBNC2vjM5ICazgKbE+l36EOWOQHtvQVXwSdx4KwhxAp/EpG3T
        mSHCvBIdbUIQ1UoSO38+gVoqIXG5aQ4LhO0h0bS1nXkCo+IsJM/MQvLMLIS9CxiZVzGKp5YW
        56anFhvmpZbrFSfmFpfmpesl5+duYgQmx9P/jn/awTj31Ue9Q4xMHIyHGCU4mJVEeMsWfU4S
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkzpucuSFRSCA9sSQ1OzW1ILUIJsvEwSnVwKSz6duMzUtr
        t4p/UOJgVD0/gameY+ti6Z9Wwg/bls+ILPaXDVi063rPjZuH039eql8xY963Y2d/RybPFtCN
        6J//J0RLK++huefjR5dqPVbFX7Sc/KFEb4Lj1tk+atMDToUr7L2sobBywd0i9Qu8Bat0/2ts
        lHp979KKRSKCaTttWhsbVkx9tPK6qIbVjMYVW0/s2+Qoo3TZrHZ2HL883/L4LV9eGSq/97nC
        tLvfoSsnp0c7Q1KSb8v/thQP2xdpjXLLPF7yh1pKLo545GNbcXdCJMtTa46GPfmBN0+v7+3N
        8zse7bqgRV44o3f/Q4YMfq53Ugrvp65l4/tdKSYpqZ9d8JPj/pXwpSeSDMxLryuxFGckGmox
        FxUnAgCU4KBt/QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7qLhL4mGWzcr2ux/tQxZovVd/vZ
        LKZ9+Mls8fvseWaL1vZvTBZ7381mtbh5YCeTxZ5Fk5gsVq4+ymSxdP9DRosn62cxW/ztugdU
        ckvb4vKuOWwW85c9ZbeY0PaV2eLz0hZ2izU3n7JYnLgl7SDscfmKt8fOWXfZPS6fLfXYtKqT
        zWPzknqP3Tcb2Dx2tt5n9Xi/7yqbR9+WVYwem09Xe3zeJOfRfqCbKYAnSs+mKL+0JFUhI7+4
        xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j0/dJbAXHiyumzlzN3MDY
        EtPFyMkhIWAiceTZBfYuRi4OIYGljBI3p7SyQSQkJG4vbGKEsIUl/lzrYoMoesYo8fb9EeYu
        Rg4ONgEticZOdhBTRCBX4uCRQJASZoHTzBINPSdYQHqFBVIl3s4+wApiswioSvz8vYEJxOYV
        sJa4Me0aE8R8eYmZl76zg9icQPEJiy6CxYUErCQmdBxjh6gXlDg58wnYTGag+uats5knMArM
        QpKahSS1gJFpFaNIamlxbnpusaFecWJucWleul5yfu4mRmAUbzv2c/MOxnmvPuodYmTiYDzE
        KMHBrCTCW7boc5IQb0piZVVqUX58UWlOavEhRlOguycyS4km5wPTSF5JvKGZgamhiZmlgaml
        mbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA5O2mKLIlXXfDO233PinFl6ySHlnjM2O7Ozf
        K7qPic2pPvdYNlvsSW3PvTNt76vXncjtXW3mv9NePGf/J/XXqbO/Cm1mlJzhHmCw/SRnxYf4
        2LYz3j980i8YvNuVW7anTVG/QL6KkZ8z9tz+lefXsdZ2LLn7RlOc4Wyfl6zP/zhBRU6Vw6VF
        qWeTz2Sw32HoOH9iobxdpF9U81kl0Sp7013cV6wnzdV+cYB9ZpXPKcdW3dfaR/5EqNnN7Zoe
        cOtpx+2EdUt8WW6q8icLCF1OMpUoM711WzdH/f1eBpEEK9afHMGvRPyPtBa/Y23cM+93Xr7e
        5rftJh1frnr9OrhvxZ0M5TUTFnUtfuw3z/F+mhJLcUaioRZzUXEiACsf2JRrAwAA
X-CMS-MailID: 20220811143058eucas1p247291685ffff7a75186947fd30b5c13f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143058eucas1p247291685ffff7a75186947fd30b5c13f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143058eucas1p247291685ffff7a75186947fd30b5c13f
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143058eucas1p247291685ffff7a75186947fd30b5c13f@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Joel Granados <j.granados@samsung.com>
---
 .../admin-guide/device-mapper/dm-po2zone.rst  |  71 +++++
 .../admin-guide/device-mapper/index.rst       |   1 +
 drivers/md/Kconfig                            |  10 +
 drivers/md/Makefile                           |   2 +
 drivers/md/dm-po2zone-target.c                | 245 ++++++++++++++++++
 5 files changed, 329 insertions(+)
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
index 000000000000..d7610463245d
--- /dev/null
+++ b/drivers/md/dm-po2zone-target.c
@@ -0,0 +1,245 @@
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
+static bool bio_across_emulated_zone_area(struct dm_po2z_target *dmh,
+					  struct bio *bio)
+{
+	unsigned int zone_idx = po2_zone_no(dmh, bio->bi_iter.bi_sector);
+	sector_t nr_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+
+	return (bio->bi_iter.bi_sector + nr_sectors) >
+	       (zone_idx << dmh->zone_size_po2_shift) + dmh->zone_size;
+}
+
+static int dm_po2z_map_read_emulated_area(struct dm_po2z_target *dmh,
+					  struct bio *bio)
+{
+	sector_t start_sect = bio->bi_iter.bi_sector;
+	unsigned int zone_idx = po2_zone_no(dmh, start_sect);
+	sector_t relative_sect_in_zone = start_sect - (zone_idx << dmh->zone_size_po2_shift);
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

