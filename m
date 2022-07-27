Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC39582AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiG0Q0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbiG0QY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:24:26 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F200F4E604
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:23:19 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220727162259euoutp0226fb7004a55577458d39d7ce69c21601~FvDZu10xx1245112451euoutp02s
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:22:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220727162259euoutp0226fb7004a55577458d39d7ce69c21601~FvDZu10xx1245112451euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658938979;
        bh=BDysFYNk87Sy+iH2ATaUwA/CYoqH1bPuiKpwIv4PNH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1FC8joZBs9tULMFGdL9Ltz7W21raE/rNqGHEOWXYMNwJ68Ynvg6rwUugydf9GrTY
         GBCzwzoG7swv6IG9PLA1gcj6ULYYH1GegcYK5knN3IeVjDutu8JUF09dhw/RzoiL2c
         rxAUX201grV/N8/Vwaz3GGJznSJkjxSm0gS/+8e8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220727162258eucas1p217e6f4283b34ae7aa09a8668412c0d1f~FvDYUb_zX0838408384eucas1p2G;
        Wed, 27 Jul 2022 16:22:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F5.C3.09664.26661E26; Wed, 27
        Jul 2022 17:22:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220727162257eucas1p2848a75c4aa7e559abb5d9ae0fbd374c1~FvDX8AmGA2220522205eucas1p2B;
        Wed, 27 Jul 2022 16:22:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220727162257eusmtrp1b431db91f9d620ddc563d89d431e4200~FvDX7Mt3d0298902989eusmtrp1R;
        Wed, 27 Jul 2022 16:22:57 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-f6-62e16662e688
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CB.8D.09038.16661E26; Wed, 27
        Jul 2022 17:22:57 +0100 (BST)
Received: from localhost (unknown [106.210.248.8]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220727162257eusmtip1df9def4b055afa74f07522657e052479~FvDXkL73Z0050700507eusmtip1j;
        Wed, 27 Jul 2022 16:22:57 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v8 11/11] dm: add power-of-2 zoned target for non-power-of-2
 zoned devices
Date:   Wed, 27 Jul 2022 18:22:45 +0200
Message-Id: <20220727162245.209794-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727162245.209794-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djP87pJaQ+TDCY8Y7NYfbefzWLah5/M
        Fr/Pnme2aG3/xmSx991sVoubB3YyWexZNInJYuXqo0wWT9bPYrb423UPKHtL2+LyrjlsFvOX
        PWW3mND2ldni89IWdos1N5+yWJy4Je0g6HH5irfHzll32T0uny312LSqk81j85J6j903G9g8
        drbeZ/V4v+8qm0ffllWMHptPV3t83iTn0X6gmymAJ4rLJiU1J7MstUjfLoErY9XTI8wFm/Ir
        Dk7sYW9g3BjdxcjJISFgIjG/cQFrFyMXh5DACkaJl53d7BDOF0aJ7t6tjCBVQgKfGSU2bbSF
        6Tg2cwlU0XJGiRmvJ7FAOM8ZJa5cusTWxcjBwSagJdHYyQ7SICJQLPHwXStYDbPAVyaJzX3v
        WUASwgIxEn1/ZjOC1LMIqEr8u5oCEuYVsJbYPXc6C8QyeYmZl76DzeEEim+eMo8JokZQ4uTM
        J2A1zEA1zVtnM4PMlxBYzSnxbMpPZohmF4lDZz8zQdjCEq+Ob2GHsGUkTk/ugVpQLfH0xm+o
        5hZGif6d68EekADa1ncmB8RkFtCUWL9LH6LcUaK99zQzRAWfxI23ghAn8ElM2jYdKswr0dEm
        BFGtJLHz5xOopRISl5vmQC31kHiy9CfLBEbFWUiemYXkmVkIexcwMq9iFE8tLc5NTy02zEst
        1ytOzC0uzUvXS87P3cQITIKn/x3/tINx7quPeocYmTgYDzFKcDArifAmRN9PEuJNSaysSi3K
        jy8qzUktPsQozcGiJM6bnLkhUUggPbEkNTs1tSC1CCbLxMEp1cBkLOG+z+D2holX91lduar3
        +djPhjJN/9tPVn5PVKx+3dGWfDwm1DFmZsT9MLOq7f/e3q78xaS8L1bnvvu74inzY+Mu3P+z
        7tldOfuZWqoNFz2YHt/b/bVjxbo9tydM+lH89fGNwBWd3qKnv/+KaWAIk+Pji5C+2/W49eW+
        a6nZj7dFOi9Vbo3esYhXf8/2m9pWsdOU3cNniFYocERfOHVKx6IjJ8s5Le3L97OuR5dUBGkp
        6S03WqF1tyPUJFalusSG4YHRVnHpR7t0juWbNzY739aa1HVt8o5r27cFd26dE7JmJXfr1YOC
        Xdvum3a/uC8nU7xznuaTP282nxM8FCm5SzcxNI/Px/Tul02RkhPnKbEUZyQaajEXFScCAMPx
        +kTxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7qJaQ+TDG53aFqsvtvPZjHtw09m
        i99nzzNbtLZ/Y7LY+242q8XNAzuZLPYsmsRksXL1USaLJ+tnMVv87boHlL2lbXF51xw2i/nL
        nrJbTGj7ymzxeWkLu8Wam09ZLE7cknYQ9Lh8xdtj56y77B6Xz5Z6bFrVyeaxeUm9x+6bDWwe
        O1vvs3q833eVzaNvyypGj82nqz0+b5LzaD/QzRTAE6VnU5RfWpKqkJFfXGKrFG1oYaRnaGmh
        Z2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXserpEeaCTfkVByf2sDcwbozuYuTkkBAwkTg2
        cwl7FyMXh5DAUkaJJ7c2skEkJCRuL2xihLCFJf5c62KDKHrKKDH9bQtQBwcHm4CWRGMnmCki
        UClx9ossSAmzQDOzxIIN95lA4sICURJtUwNATBYBVYl/V1NAJvIKWEvsnjudBWK6vMTMS9/Z
        QWxOoPjmKfOYQGwhASuJZw8+skHUC0qcnPkErJ4ZqL5562zmCYwCs5CkZiFJLWBkWsUoklpa
        nJueW2ykV5yYW1yal66XnJ+7iREYrduO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8CZE308S4k1J
        rKxKLcqPLyrNSS0+xGgKdPZEZinR5HxgusgriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJ
        zU5NLUgtgulj4uCUamCy3xz058yTv53JV0wdOh5s5PbfGyD1q0HaYtJj3lNPf7L3CgbNZtv1
        MfaPh6XK0Q8lmTc/rAqou5lm72l5c7Zz5iuHl3cM+gLiD8fNMPe3XbDCJm+vg0pD0r5bZ6ct
        YbSa2BRzPfjMuq5TPr6nk9+u2W/2kpVf2uDynf1nHVzzLKdNMLXTFLb0+1Bqabr891TmjLD6
        K9/v7uDe9+f60y2dGzPmK09sPnLXMTdEfr2ObXkc3/qJDm5T/qa80/L47R7M1uV990Ylq2Lm
        Xkvmlqqzi5dOCvJS3+5xUru4sK3rfQLLBz0Hptb2LJ6uJWnzz6uHdt7427j/xBc9HVlXv3v2
        SfxtkVcXdr1xivrYKqfEUpyRaKjFXFScCAA5ZpvlXwMAAA==
X-CMS-MailID: 20220727162257eucas1p2848a75c4aa7e559abb5d9ae0fbd374c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220727162257eucas1p2848a75c4aa7e559abb5d9ae0fbd374c1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162257eucas1p2848a75c4aa7e559abb5d9ae0fbd374c1
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162257eucas1p2848a75c4aa7e559abb5d9ae0fbd374c1@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only power-of-2(po2) zoned devices were supported in linux but now non
power-of-2(npo2) zoned device support has been added to the block layer.

Filesystems such as F2FS and btrfs have support for zoned devices with
po2 zone size assumption. Before adding native support for npo2 zoned
devices, it was suggested to create a dm target for npo2 zoned device to
appear as a po2 target so that file systems can initially work without any
explicit changes by using this target.

The design of this target is very simple: introduce gaps between the
underlying device's zone size and the nearest po2 device zone size.
Device's actual zone size becomes the zone capacity of the target and
device's nearest po2 zone size becomes the target's zone size.

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

All IOs will be remapped from target to the actual device location.

The area between target's zone capacity and zone size will be emulated
in the target.
The read IOs that fall in the emulated gap area will return 0 filled
bio and all the other IOs in that area will result in an error.
If a read IO span across the emulated area boundary, then the IOs are
split across them. All other IO operations that span across the emulated
area boundary will result in an error.

The target can be easily created as follows:
dmsetup create <label> --table '0 <size_sects> po2z /dev/nvme<id>'

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
Suggested-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/Kconfig            |   9 ++
 drivers/md/Makefile           |   2 +
 drivers/md/dm-po2z-target.c   | 261 ++++++++++++++++++++++++++++++++++
 drivers/md/dm-table.c         |  13 +-
 drivers/md/dm-zone.c          |   1 +
 include/linux/device-mapper.h |   9 ++
 6 files changed, 292 insertions(+), 3 deletions(-)
 create mode 100644 drivers/md/dm-po2z-target.c

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 998a5cfdbc4e..d58ccfee765b 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -518,6 +518,15 @@ config DM_FLAKEY
 	help
 	 A target that intermittently fails I/O for debugging purposes.
 
+config DM_PO2Z
+	tristate "Power-of-2 target for non power-of-2 zoned devices"
+	depends on BLK_DEV_DM
+	depends on BLK_DEV_ZONED
+	help
+	  A target that converts a zoned device with non power-of-2 zone size to
+	  be power of 2. This is done by introducing gaps in between the zone
+	  capacity and the power of 2 zone size.
+
 config DM_VERITY
 	tristate "Verity target support"
 	depends on BLK_DEV_DM
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 270f694850ec..98af4ed98f73 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -26,6 +26,7 @@ dm-era-y	+= dm-era-target.o
 dm-clone-y	+= dm-clone-target.o dm-clone-metadata.o
 dm-verity-y	+= dm-verity-target.o
 dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
+dm-po2z-y       += dm-po2z-target.o
 
 md-mod-y	+= md.o md-bitmap.o
 raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
@@ -60,6 +61,7 @@ obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
 obj-$(CONFIG_DM_DELAY)		+= dm-delay.o
 obj-$(CONFIG_DM_DUST)		+= dm-dust.o
 obj-$(CONFIG_DM_FLAKEY)		+= dm-flakey.o
+obj-$(CONFIG_DM_PO2Z)		+= dm-po2z.o
 obj-$(CONFIG_DM_MULTIPATH)	+= dm-multipath.o dm-round-robin.o
 obj-$(CONFIG_DM_MULTIPATH_QL)	+= dm-queue-length.o
 obj-$(CONFIG_DM_MULTIPATH_ST)	+= dm-service-time.o
diff --git a/drivers/md/dm-po2z-target.c b/drivers/md/dm-po2z-target.c
new file mode 100644
index 000000000000..e9c5b7d00eda
--- /dev/null
+++ b/drivers/md/dm-po2z-target.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/device-mapper.h>
+
+#define DM_MSG_PREFIX "po2z"
+
+struct dm_po2z_target {
+	struct dm_dev *dev;
+	sector_t zone_size; /* Actual zone size of the underlying dev*/
+	sector_t zone_size_po2; /* zone_size rounded to the nearest po2 value */
+	sector_t zone_size_diff; /* diff between zone_size_po2 and zone_size */
+	u32 nr_zones;
+};
+
+static inline u32 npo2_zone_no(struct dm_po2z_target *dmh, sector_t sect)
+{
+	return div64_u64(sect, dmh->zone_size);
+}
+
+static inline u32 po2_zone_no(struct dm_po2z_target *dmh, sector_t sect)
+{
+	return sect >> ilog2(dmh->zone_size_po2);
+}
+
+static inline sector_t target_to_device_sect(struct dm_po2z_target *dmh,
+					     sector_t sect)
+{
+	u32 zone_idx = po2_zone_no(dmh, sect);
+
+	return sect - (zone_idx * dmh->zone_size_diff);
+}
+
+static inline sector_t device_to_target_sect(struct dm_po2z_target *dmh,
+					     sector_t sect)
+{
+	u32 zone_idx = npo2_zone_no(dmh, sect);
+
+	return sect + (zone_idx * dmh->zone_size_diff);
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
+	if (argc < 1)
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
+		return ret;
+	}
+
+	zone_size = bdev_zone_sectors(dmh->dev->bdev);
+	dev_capacity = get_capacity(dmh->dev->bdev->bd_disk);
+	if (ti->len != dev_capacity || ti->begin) {
+		DMERR("%pg Partial mapping of the target not supported",
+		      dmh->dev->bdev);
+		return -EINVAL;
+	}
+
+	if (is_power_of_2(zone_size)) {
+		DMERR("%pg: this target is not useful for power-of-2 zoned devices",
+		      dmh->dev->bdev);
+		return -EINVAL;
+	}
+
+	dmh->zone_size = zone_size;
+	dmh->zone_size_po2 = 1 << get_count_order_long(zone_size);
+	dmh->zone_size_diff = dmh->zone_size_po2 - dmh->zone_size;
+	ti->private = dmh;
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
+	u32 zone_idx = po2_zone_no(dmh, bio->bi_iter.bi_sector);
+	sector_t size = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+
+	return (bio->bi_iter.bi_sector - (zone_idx * dmh->zone_size_po2) +
+		size) > dmh->zone_size;
+}
+
+static int dm_po2z_map_read(struct dm_po2z_target *dmh, struct bio *bio)
+{
+	sector_t start_sect, size, relative_sect_in_zone, split_io_pos;
+	u32 zone_idx;
+
+	/*
+	 * Read does not extend into the emulated zone area (area between
+	 * zone capacity and zone size)
+	 */
+	if (!bio_across_emulated_zone_area(dmh, bio)) {
+		bio->bi_iter.bi_sector =
+			target_to_device_sect(dmh, bio->bi_iter.bi_sector);
+		return DM_MAPIO_REMAPPED;
+	}
+
+	start_sect = bio->bi_iter.bi_sector;
+	size = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+	zone_idx = po2_zone_no(dmh, start_sect);
+	relative_sect_in_zone = start_sect - (zone_idx * dmh->zone_size_po2);
+
+	/*
+	 * If the starting sector is in the emulated area then fill
+	 * all the bio with zeros. If bio is across emulated zone boundary,
+	 * split the bio across boundaries and fill zeros only for the
+	 * bio that is between the zone capacity and the zone size.
+	 */
+	if (relative_sect_in_zone < dmh->zone_size &&
+	    ((relative_sect_in_zone + size) > dmh->zone_size)) {
+		split_io_pos = (zone_idx * dmh->zone_size_po2) + dmh->zone_size;
+		dm_accept_partial_bio(bio, split_io_pos - start_sect);
+		bio->bi_iter.bi_sector = target_to_device_sect(dmh, start_sect);
+
+		return DM_MAPIO_REMAPPED;
+	} else if (relative_sect_in_zone >= dmh->zone_size &&
+		   ((relative_sect_in_zone + size) > dmh->zone_size_po2)) {
+		split_io_pos = (zone_idx + 1) * dmh->zone_size_po2;
+		dm_accept_partial_bio(bio, split_io_pos - start_sect);
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
+		/*
+		 * Read operation on the emulated zone area (between zone capacity
+		 * and zone size) will fill the bio with zeroes. Any other operation
+		 * in the emulated area should return an error.
+		 */
+		if (bio_op(bio) == REQ_OP_READ)
+			return dm_po2z_map_read(dmh, bio);
+
+		if (!bio_across_emulated_zone_area(dmh, bio)) {
+			bio->bi_iter.bi_sector = target_to_device_sect(dmh,
+								       bio->bi_iter.bi_sector);
+			return DM_MAPIO_REMAPPED;
+		}
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
+	.name = "po2z",
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
+	int r = dm_register_target(&dm_po2z_target);
+
+	if (r < 0)
+		DMERR("register failed %d", r);
+
+	return r;
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
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 534fddfc2b42..d77feff124af 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1614,13 +1614,20 @@ static bool dm_table_supports_zoned_model(struct dm_table *t,
 	return true;
 }
 
-static int device_not_matches_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
+/*
+ * Callback function to check for device zone sector across devices. If the
+ * DM_TARGET_EMULATED_ZONES target feature flag is not set, then the target
+ * should have the same zone sector as the underlying devices.
+ */
+static int check_valid_device_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
 					   sector_t start, sector_t len, void *data)
 {
 	unsigned int *zone_sectors = data;
 
-	if (!bdev_is_zoned(dev->bdev))
+	if (!bdev_is_zoned(dev->bdev) ||
+	    dm_target_supports_emulated_zones(ti->type))
 		return 0;
+
 	return bdev_zone_sectors(dev->bdev) != *zone_sectors;
 }
 
@@ -1646,7 +1653,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
 	if (!zone_sectors)
 		return -EINVAL;
 
-	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
+	if (dm_table_any_dev_attr(t, check_valid_device_zone_sectors, &zone_sectors)) {
 		DMERR("%s: zone sectors is not consistent across all zoned devices",
 		      dm_device_name(t->md));
 		return -EINVAL;
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 31c16aafdbfc..2b6b3883471f 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -302,6 +302,7 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
 	if (dm_table_supports_zone_append(t)) {
 		clear_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
 		dm_cleanup_zoned_dev(md);
+
 		return 0;
 	}
 
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 920085dd7f3b..7dbd28b8de01 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -294,6 +294,15 @@ struct target_type {
 #define dm_target_supports_mixed_zoned_model(type) (false)
 #endif
 
+#ifdef CONFIG_BLK_DEV_ZONED
+#define DM_TARGET_EMULATED_ZONES	0x00000400
+#define dm_target_supports_emulated_zones(type) \
+	((type)->features & DM_TARGET_EMULATED_ZONES)
+#else
+#define DM_TARGET_EMULATED_ZONES	0x00000000
+#define dm_target_supports_emulated_zones(type) (false)
+#endif
+
 struct dm_target {
 	struct dm_table *table;
 	struct target_type *type;
-- 
2.25.1

