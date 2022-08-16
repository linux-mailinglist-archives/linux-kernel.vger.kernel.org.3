Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D50595CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiHPNPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiHPNPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:15:45 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584635C343
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:15:41 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131539euoutp0161c6d52e62513a8df656490c272016a2~L1ZjQJC9k2881628816euoutp01c
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:15:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220816131539euoutp0161c6d52e62513a8df656490c272016a2~L1ZjQJC9k2881628816euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660655739;
        bh=lC96vEoyysVA/z1i+lGoBvPAXfHiezzPBcVa+np9fgc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TgA9Il3lFd2ygtvCCFrJJZS3yZNUZU5LKpv8OJsVgbkp5wzVMLmZkgGU2PHoko1Mc
         atRfzumh/CJUzPI9AZM/ZNqVZ3DHPvmNvhx94ZxATpFz6LdeFdGrs+1dn+RRCnsXd3
         HpKMofT9zMaVlh7ak/V7CfATUqt0Gk+e4hVHytTQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220816131538eucas1p1b7cc2c2f55d2fa428cefe704b8b5c1e6~L1ZhqTk3K1501515015eucas1p17;
        Tue, 16 Aug 2022 13:15:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B8.B7.10067.A789BF26; Tue, 16
        Aug 2022 14:15:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220816131537eucas1p2e8f3faef3eaf7d77ecccb6043f74c171~L1ZhBQrVi0372203722eucas1p2u;
        Tue, 16 Aug 2022 13:15:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220816131537eusmtrp1b49087365eaddc9308a2c4822b260450~L1ZhAOfM80149801498eusmtrp17;
        Tue, 16 Aug 2022 13:15:37 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-04-62fb987a4d40
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 48.A0.09095.9789BF26; Tue, 16
        Aug 2022 14:15:37 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816131537eusmtip26983e836aa6f42dd5519f10223b02600~L1ZgmWGde1196811968eusmtip2Y;
        Tue, 16 Aug 2022 13:15:37 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v11 00/13]  support zoned block devices with non-power-of-2
 zone sizes
Date:   Tue, 16 Aug 2022 15:15:23 +0200
Message-Id: <20220816131536.189406-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djPc7pVM34nGTy5zGqx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGVMuzKHvWBH
        SMXR96+ZGxivO3QxcnJICJhIfFy8kqWLkYtDSGAFo0TH5wXsEM4XRol37ycxQzifGSVevNzE
        CNNyrfMNI0RiOaPEv5ProFpeMEpcufkMKMPBwSagJdHYyQ7SICKQLjGl5SXYDmaBbUwSby5N
        AJskLBAhMWX5SXaQehYBVYkjv7JBwrwCVhIrdp5jg1gmLzHz0nd2iLigxMmZT1hAbGagePPW
        2WDXSQis5pT4uO4eVIOLxPefL1khbGGJV8e3sEPYMhKnJ/ewQNjVEk9v/IZqbmGU6N+5ng3k
        CAkBa4m+MzkgJrOApsT6XfoQ5Y4SG34tY4eo4JO48VYQ4gQ+iUnbpjNDhHklOtqEIKqVJHb+
        fAK1VELictMcqKUeEpMeb2AGsYUEYiVu/Z7KNoFRYRaSx2YheWwWwg0LGJlXMYqnlhbnpqcW
        G+WllusVJ+YWl+al6yXn525iBKbB0/+Of9nBuPzVR71DjEwcjIcYJTiYlUR4BV/8SBLiTUms
        rEotyo8vKs1JLT7EKM3BoiTOm5y5IVFIID2xJDU7NbUgtQgmy8TBKdXApPty0nXbxxr8beeP
        2kwsF8tVus90zqts3b8otekm5g8cJlpP/7rr7hxzlthEPe3Hf1qijFSVok5fEnGUCpM7scP8
        7+vjm2o02LRYXurMPWegt9otta75dN+DJwYPa95cX+jHfLbj5bHp3fECeVJ7vrB7vfIM9ll6
        4unDVSz6Gw1fcvXnccbofL117vsJ35JjJZ+KuCzu3Ax8V+r3TYD3Z8DE4urTBhrOV//OCtn7
        wfzgk5XWf6L/GzzybP09a1VH7AmtBsa7DW8vGSnHvLY9t67Em/njEennlldPVbG2qL/T8yrx
        XV56fb7pDatLQrq3ti2/vurqHF099yenP0yPW9k+3/CskavUV4mj07imzldiKc5INNRiLipO
        BAC/saHR8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7qVM34nGfxaLWqx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVMuzKHvWBHSMXR96+ZGxivO3QxcnJICJhI
        XOt8w9jFyMUhJLCUUWLT7ImMEAkJidsLm6BsYYk/17rYIIqeMUq8/3CAuYuRg4NNQEuisZMd
        pEZEIFdi0bIOVpAaZoEjTBILpi9nBkkIC4RJLDp2lgmknkVAVeLIr2yQMK+AlcSKnefYIObL
        S8y89J0dpIRZQFNi/S59iBJBiZMzn7CA2MxAJc1bZzNPYOSfhVA1C0nVLCRVCxiZVzGKpJYW
        56bnFhvqFSfmFpfmpesl5+duYgRG67ZjPzfvYJz36qPeIUYmDsZDjBIczEoivIIvfiQJ8aYk
        VlalFuXHF5XmpBYfYjQFOnois5Rocj4wXeSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5ak
        ZqemFqQWwfQxcXBKNTBldx2aVsJ6iumanoW0/VlNbbOnp9vv/Pdz2M7S8E0mt2HKXpn00p9v
        zIxYAl/HxypHNLJMvcr+XkBJ7+8CjtRAvcl2Ev4nV8TMnul7wMqiYEnyz017DE1XRDFeVnva
        wnZb7LK2eVTfhKtTp7F9/8NrtXlS1/311spFnpvqb25a9SygTKjvx5UorYNdorKnhHc5Ok2o
        cP/ULHtSLDHULHMu++I2Xsd269/MiUv5bLV4w7p3/t+wXujIx6/ekfwTSmfHHOKxr7br3lC+
        4/35RbMZ7u3k2F706j/DX65lPuxeCRN0kqNSDiWt4VgZ+TXD+tvOm6tXXVh8e56i5f6U4ltr
        7KfwvHf7FXiHPYtNqlyJpTgj0VCLuag4EQB/Dt3RXwMAAA==
X-CMS-MailID: 20220816131537eucas1p2e8f3faef3eaf7d77ecccb6043f74c171
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131537eucas1p2e8f3faef3eaf7d77ecccb6043f74c171
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131537eucas1p2e8f3faef3eaf7d77ecccb6043f74c171
References: <CGME20220816131537eucas1p2e8f3faef3eaf7d77ecccb6043f74c171@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Background and Motivation:

The zone storage implementation in Linux, introduced since v4.10, first
targetted SMR drives which have a power of 2 (po2) zone size alignment
requirement. The po2 zone size was further imposed implicitly by the
block layer's blk_queue_chunk_sectors(), used to prevent IO merging
across chunks beyond the specified size, since v3.16 through commit
762380ad9322 ("block: add notion of a chunk size for request merging").
But this same general block layer po2 requirement for blk_queue_chunk_sectors()
was removed on v5.10 through commit 07d098e6bbad ("block: allow 'chunk_sectors'
to be non-power-of-2").

NAND, which is the media used in newer zoned storage devices, does not
naturally align to po2. In these devices, zone capacity(cap) is not the
same as the po2 zone size. When the zone cap != zone size, then unmapped
LBAs are introduced to cover the space between the zone cap and zone size.
po2 requirement does not make sense for these type of zone storage devices.
This patch series aims to remove these unmapped LBAs for zoned devices when
zone cap is npo2. This is done by relaxing the po2 zone size constraint
in the kernel and allowing zoned device with npo2 zone sizes if zone cap
== zone size.

Removing the po2 requirement from zone storage should be possible
now provided that no userspace regression and no performance regressions are
introduced. Stop-gap patches have been already merged into f2fs-tools to
proactively not allow npo2 zone sizes until proper support is added [1].

There were two efforts previously to add support to npo2 devices: 1) via
device level emulation [2] but that was rejected with a final conclusion
to add support for non po2 zoned device in the complete stack[3] 2)
adding support to the complete stack by removing the constraint in the
block layer and NVMe layer with support to btrfs, zonefs, etc which was
rejected with a conclusion to add a dm target for FS support [0]
to reduce the regression impact.

This series adds support to npo2 zoned devices in the block and nvme
layer and a new **dm target** is added: dm-po2z-target. This new
target will be initially used for filesystems such as btrfs and
f2fs until native npo2 zone support is added.

- Patchset description:
Patches 1-3 deals with removing the po2 constraint from the
block layer.

Patches 4-5 deals with removing the constraint from nvme zns.

Patch 5 removes the po2 contraint in null blk

Patch 6 adds npo2 support to zonefs

Patches 7-13 adds support for npo2 zoned devices in the DM layer and
adds a new target dm-po2z-target which converts a zoned device with npo2
zone size into a zoned target with po2 zone size.

The patch series is based on linux-next tag: next-20220816

Testing:
The new target was tested with blktest and zonefs test suite in qemu and
on a real ZNS device with npo2 zone size.

Performance Measurement on a null blk:
Device:
zone size = 128M, blocksize=4k

FIO cmd:
fio --name=zbc --filename=/dev/nullb0 --direct=1 --zonemode=zbd  --size=23G
--io_size=<iosize> --ioengine=io_uring --iodepth=<iod> --rw=<mode> --bs=4k
--loops=4

The following results are an average of 4 runs on AMD Ryzen 5 5600X with
32GB of RAM:

Sequential Write:
x-----------------x---------------------------------x---------------------------------x
|     IOdepth     |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  578     |  2257    |   12.80   |  576     |  2248    |   25.78   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  581     |  2268    |   12.74   |  576     |  2248    |   25.85   |
x-----------------x---------------------------------x---------------------------------x

Sequential read:
x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  667     |  2605    |   11.79   |  675     |  2637    |   23.49   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  667     |  2605    |   11.79   |  675     |  2638    |   23.48   |
x-----------------x---------------------------------x---------------------------------x

Random read:
x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  522     |  2038    |   15.05   |  514     |  2006    |   30.87   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  522     |  2039    |   15.04   |  523     |  2042    |   30.33   |
x-----------------x---------------------------------x---------------------------------x

Minor variations are noticed in Sequential write with io depth 8 and
in random read with io depth 16. But overall no noticeable differences
were noticed

[0] https://lore.kernel.org/lkml/PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=6afcf6493578e77528abe65ab8b12f3e1c16749f
[2] https://lore.kernel.org/all/20220310094725.GA28499@lst.de/T/
[3] https://lore.kernel.org/all/20220315135245.eqf4tqngxxb7ymqa@unifi/

Changes since v1:
- Put the function declaration and its usage in the same commit (Bart)
- Remove bdev_zone_aligned function (Bart)
- Change the name from blk_queue_zone_aligned to blk_queue_is_zone_start
  (Damien)
- q is never null in from bdev_get_queue (Damien)
- Add condition during bringup and check for zsze == zcap for npo2
  drives (Damien)
- Rounddown operation should be made generic to work in 32 bits arch
  (bart)
- Add comments where generic calculation is directly used instead having
  special handling for po2 zone sizes (Hannes)
- Make the minimum zone size alignment requirement for btrfs to be 1M
  instead of BTRFS_STRIPE_LEN(David)

Changes since v2:
- Minor formatting changes

Changes since v3:
- Make superblock mirror align with the existing superblock log offsets
  (David)
- DM change return value and remove extra newline
- Optimize null blk zone index lookup with shift for po2 zone size

Changes since v4:
- Remove direct filesystems support for npo2 devices (Johannes, Hannes,
  Damien)

Changes since v5:
- Use DIV_ROUND_UP* helper instead of round_up as it breaks 32bit arch
  build in null blk(kernel-test-robot, Nathan)
- Use DIV_ROUND_UP_SECTOR_T also in blkdev_nr_zones function instead of
  open coding it with div64_u64
- Added extra condition in dm-zoned and in dm to reject non power of 2
  zone sizes.

Changes since v6:
- Added a new dm target for non power of 2 devices
- Added support for non power of 2 devices in the DM layer.

Changes since v7:
- Improved dm target for non power of 2 zoned devices with some bug
  fixes and rearrangement
- Removed some unnecessary comments.

Changes since v8:
- Rename dm-po2z to dm-po2zone
- set max_io_len for the target to po2 zone size sector
- Simplify dm-po2zone target by removing some superfluous conditions
- Added documentation for the new dm-po2zone target
- Change pr_warn to pr_err for critical errors
- Split patch 2 and 11 with their corresponding prep patches
- Minor spelling and grammatical improvements

Changes since v9:
- Add a check for a zoned device in dm-po2zone ctr.
- Rephrased some commit messages and documentation for clarity

Changes since v10:
- Simplified dm_poz_map function (Damien)

Luis Chamberlain (1):
  dm-zoned: ensure only power of 2 zone sizes are allowed

Pankaj Raghav (12):
  block: make bdev_nr_zones and disk_zone_no generic for npo2 zone size
  block:rearrange bdev_{is_zoned,zone_sectors,get_queue} helpers in
    blkdev.h
  block: allow blk-zoned devices to have non-power-of-2 zone size
  nvmet: Allow ZNS target to support non-power_of_2 zone sizes
  nvme: zns: Allow ZNS drives that have non-power_of_2 zone size
  null_blk: allow zoned devices with non power-of-2 zone sizes
  zonefs: allow non power of 2 zoned devices
  dm-zone: use generic helpers to calculate offset from zone start
  dm-table: allow zoned devices with non power-of-2 zone sizes
  dm: call dm_zone_endio after the target endio callback for zoned
    devices
  dm: introduce DM_EMULATED_ZONES target type
  dm: add power-of-2 target for zoned devices with non power-of-2 zone
    sizes

 .../admin-guide/device-mapper/dm-po2zone.rst  |  71 +++++
 .../admin-guide/device-mapper/index.rst       |   1 +
 block/blk-core.c                              |   2 +-
 block/blk-zoned.c                             |  37 ++-
 drivers/block/null_blk/main.c                 |   5 +-
 drivers/block/null_blk/null_blk.h             |   1 +
 drivers/block/null_blk/zoned.c                |  18 +-
 drivers/md/Kconfig                            |  10 +
 drivers/md/Makefile                           |   2 +
 drivers/md/dm-po2zone-target.c                | 260 ++++++++++++++++++
 drivers/md/dm-table.c                         |  20 +-
 drivers/md/dm-zone.c                          |   8 +-
 drivers/md/dm-zoned-target.c                  |   8 +
 drivers/md/dm.c                               |   8 +-
 drivers/nvme/host/zns.c                       |  14 +-
 drivers/nvme/target/zns.c                     |   3 +-
 fs/zonefs/super.c                             |   6 +-
 fs/zonefs/zonefs.h                            |   1 -
 include/linux/blkdev.h                        |  80 ++++--
 include/linux/device-mapper.h                 |   9 +
 20 files changed, 489 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-po2zone.rst
 create mode 100644 drivers/md/dm-po2zone-target.c

-- 
2.25.1

