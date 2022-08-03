Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062F15889B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbiHCJsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiHCJsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:48:14 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5781CB12
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:48:09 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094805euoutp012bdb4c3fb22346e27bbc50f953d4bf3a~HzLmwPSUq3234332343euoutp01W
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:48:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220803094805euoutp012bdb4c3fb22346e27bbc50f953d4bf3a~HzLmwPSUq3234332343euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659520085;
        bh=eLzgJIL76hbeCQ/acXt4A6bldiyZOzlXimTNTwPHEgU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CAAOlDQ3nt392oyg7AEZddu51s/bkH4b3PDQbk+qsMa0xnKKZLUOxjbHAWY2Ha1ps
         CYR8HAH4KrDoJLnfhP9DROkX4JtfWf6O0Nx7OeAZKEHkMw8Zit+vshVlotHfDm0pso
         /HeTj7LEeyVXSmiPjqA2itOYP1G0yfwrcNCE6nlc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220803094803eucas1p238b48cf882be60fd118e154a111b57b5~HzLk80Uwr1615116151eucas1p2r;
        Wed,  3 Aug 2022 09:48:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F5.F2.09580.3544AE26; Wed,  3
        Aug 2022 10:48:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220803094802eucas1p2052b092c7bd82bea1a0ac4a5d70d7bc9~HzLkOaDXF1531915319eucas1p2F;
        Wed,  3 Aug 2022 09:48:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220803094802eusmtrp21c2bd1e8cb6a5ea177ce9c174f416c40~HzLkNejBu0985709857eusmtrp2i;
        Wed,  3 Aug 2022 09:48:02 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-03-62ea4453d30d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E8.DB.09095.2544AE26; Wed,  3
        Aug 2022 10:48:02 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220803094802eusmtip1c912bfadc180a17bc496e45df646f3f0~HzLj5ZM1t2136621366eusmtip1h;
        Wed,  3 Aug 2022 09:48:02 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v9 00/13] support zoned block devices with non-power-of-2
 zone sizes
Date:   Wed,  3 Aug 2022 11:47:48 +0200
Message-Id: <20220803094801.177490-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djPc7rBLq+SDLZckbdYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAniiuGxSUnMyy1KL9O0SuDI2b2llL3gf
        VHFny2KmBsZt9l2MnBwSAiYSm380MnUxcnEICaxglFj1bSo7hPOFUeLMsYtQzmdGiRMLfrLB
        tPy7e5cRIrGcUaLx11o2COclo8S71y9Yuhg5ONgEtCQaO8G6RQSaGSXu/u1hBXGYBWYwSXR8
        7GMBGSUsECaxoe0f2FgWAVWJV90bmEBsXgEricuXbjFCrJOXmHnpOztEXFDi5MwnYL3MQPHm
        rbOZIWpWc0psPlkJYbtIXLu6jB3CFpZ4dXwLlC0j8X/nfCYIu1ri6Y3fzCAHSQi0MEr071zP
        BnK1hIC1RN+ZHBCTWUBTYv0ufYhyR4mDO6ewQ1TwSdx4KwhxAZ/EpG3TmSHCvBIdbUIQ1UoS
        O38+gVoqIXG5aQ4LhO0h0fH3EdgBQgKxEkvm3mKbwKgwC8lfs5D8NQvhhgWMzKsYxVNLi3PT
        U4uN81LL9YoTc4tL89L1kvNzNzECE+Hpf8e/7mBc8eqj3iFGJg7GQ4wSHMxKIrx3XJ4nCfGm
        JFZWpRblxxeV5qQWH2KU5mBREudNztyQKCSQnliSmp2aWpBaBJNl4uCUamDK3m70X6Ww+8Pn
        pDCL8LORvzbOq0vYw/bK8ElV5UNT+xVmh5bNUPvWu8JBKf78vi8vi802yiYWPmnc/P3xoykP
        fK+bZuUoWn6SWPeVc59m2+TQSRvzLr1sauPe53Phj47+2Y3NUfuiPjVet3Ut1975w4PNprn0
        r6ndT+8TXp1bE04/nhQlfFqt7Hf05Yprl0pnz/y+Tb8vqsWOgzvepWD9k4bZh++XvBObZhGq
        H/czdqaa7HfBK5uTY/Urtl25HZxg06QQtPFUQPNkBYUXLxsVGvj/2ZYw7E5TufLNvS7Vd1G3
        /MzXe748Fs8N5z22pvSbrSyjecD1mhqOT4ud5xo4up/bXtWa+fWSZVz7l0wlluKMREMt5qLi
        RADasr5R8wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7pBLq+SDL4u17VYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DI2b2llL3gfVHFny2KmBsZt9l2MnBwSAiYS
        /+7eZexi5OIQEljKKPHk4FkWiISExO2FTYwQtrDEn2tdbBBFzxkl5m7ez9rFyMHBJqAl0djJ
        DhIXEehmlLh85hwriMMssIxJounLdTaQbmGBEInnDyYzgdgsAqoSr7o3gNm8AlYSly/dgtog
        LzHz0nd2kKHMApoS63fpQ5QISpyc+QTsIGagkuats5knMPLPQqiahaRqFpKqBYzMqxhFUkuL
        c9Nziw31ihNzi0vz0vWS83M3MQIjdtuxn5t3MM579VHvECMTB+MhRgkOZiUR3jsuz5OEeFMS
        K6tSi/Lji0pzUosPMZoCXT2RWUo0OR+YMvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tS
        s1NTC1KLYPqYODilGpjKXrJv7k6fOLHtZNL9CtGErJV1f6M1a66dYuJObVHKaHN6POERB1Pl
        lt9RAXsvnm/Zf1ZX/9zxYze1P11fxrNv2dEy90eL0qN3t7rxXZqfsWKFwL15kXU2Z700JT+Y
        MOZvuMh5/uT1fcwLpsfU2zatur7zzfol+v7hK3611BVZXnrs/PenneCSG4LrN3KcP/aM4+Xr
        nOD2A+u/VaoniXLrF084m2eqOs3t9jY5xwvn1lyR2qy+wrVNQ2Lao6d3nTLzmMrSQrVM1Nlv
        RpmxM11YqD/1yJku6e1SyzYvuPRr48egiecOV+q/TdiZ+GBekPa7evb2rPo/C+b1sdosnRg3
        dVknv92L4ATOBCOtbzKpSizFGYmGWsxFxYkAIzq/R2EDAAA=
X-CMS-MailID: 20220803094802eucas1p2052b092c7bd82bea1a0ac4a5d70d7bc9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094802eucas1p2052b092c7bd82bea1a0ac4a5d70d7bc9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094802eucas1p2052b092c7bd82bea1a0ac4a5d70d7bc9
References: <CGME20220803094802eucas1p2052b092c7bd82bea1a0ac4a5d70d7bc9@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

The patch series is based on linux-next tag: next-20220802

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

 .../admin-guide/device-mapper/dm-po2zone.rst  |  71 ++++++
 .../admin-guide/device-mapper/index.rst       |   1 +
 block/blk-core.c                              |   2 +-
 block/blk-zoned.c                             |  37 ++-
 drivers/block/null_blk/main.c                 |   5 +-
 drivers/block/null_blk/null_blk.h             |   1 +
 drivers/block/null_blk/zoned.c                |  18 +-
 drivers/md/Kconfig                            |  10 +
 drivers/md/Makefile                           |   2 +
 drivers/md/dm-po2zone-target.c                | 240 ++++++++++++++++++
 drivers/md/dm-table.c                         |  20 +-
 drivers/md/dm-zone.c                          |   9 +-
 drivers/md/dm-zoned-target.c                  |   8 +
 drivers/md/dm.c                               |   8 +-
 drivers/nvme/host/zns.c                       |  16 +-
 drivers/nvme/target/zns.c                     |   3 +-
 fs/zonefs/super.c                             |   6 +-
 fs/zonefs/zonefs.h                            |   1 -
 include/linux/blkdev.h                        |  85 +++++--
 include/linux/device-mapper.h                 |   9 +
 20 files changed, 477 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-po2zone.rst
 create mode 100644 drivers/md/dm-po2zone-target.c

-- 
2.25.1

