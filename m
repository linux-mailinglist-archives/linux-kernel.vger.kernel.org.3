Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10E658FE51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiHKObI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbiHKOa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:30:56 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC9C6CD02
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:30:51 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143047euoutp02572da2d3c6ed10e4422e8943469f2c6b~KUMtl0Jg01911919119euoutp02C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:30:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220811143047euoutp02572da2d3c6ed10e4422e8943469f2c6b~KUMtl0Jg01911919119euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660228247;
        bh=GGO7ZRnzvxUtw8ITRo7XPEiQbAv2zE+PzgBQqHVi8xo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QGczf34mNl6+pynuqXor2F0foJ9wlCo0pJWMTYLE2mbD+eAlmo48kAvyVpjj2DeAc
         ogxhlMBw9ePPVVt0T2pmI5uCM9J9pB/XrjyFrYiTtGcqbO1wq3HrcAurj9ubd5lL1L
         j3HAnNS70z3feCLArvdefaeVbYi9YmWULHSR+nwA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220811143045eucas1p20b6ddcea93a580b6e6d6c06754da50fb~KUMr6i4m21002610026eucas1p2L;
        Thu, 11 Aug 2022 14:30:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 46.8C.09580.59215F26; Thu, 11
        Aug 2022 15:30:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220811143044eucas1p2cb35a5c247788689aeebf2bc8eb9f5df~KUMrc0JDd1001410014eucas1p2p;
        Thu, 11 Aug 2022 14:30:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220811143044eusmtrp242135b43b9d239de8d8dbd706b41d14f~KUMrbuzPF0788907889eusmtrp2g;
        Thu, 11 Aug 2022 14:30:44 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-98-62f51295a40e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0A.00.09038.49215F26; Thu, 11
        Aug 2022 15:30:44 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220811143044eusmtip265836de2f249fcce15235de2377c94d3~KUMrDatD81032210322eusmtip2I;
        Thu, 11 Aug 2022 14:30:44 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v10 00/13] support zoned block devices with non-power-of-2
 zone sizes
Date:   Thu, 11 Aug 2022 16:30:30 +0200
Message-Id: <20220811143043.126029-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djP87pThb4mGTw4JWix/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGVcfHmCueB7
        cMXsp+/YGhgXOXQxcnJICJhIbHq8ha2LkYtDSGAFo8Sd58sYQRJCAl8YJe6+t4FIfGaU2Lbz
        CRNMx/9pN1ghEssZJSZ838II4bxglNgy/wV7FyMHB5uAlkRjJztIg4hAusT6BctZQGxmgW1M
        ElseCIPYwgLhEgfaLoHFWQRUJU42LwGr5xWwkjiz7zLUMnmJmZe+Q8UFJU7OfAI1R16ieets
        ZpC9EgKLOSU62n5BNbhIvL7yhBXCFpZ4dXwLO4QtI/F/53yommqJpzd+QzW3MEr071zPBnK0
        hIC1RN+ZHBCTWUBTYv0ufYhyR4mOU1+ZISr4JG68FYQ4gU9i0rbpUGFeoAuEIKqVJHb+fAK1
        VELictMcFgjbQ2Lb161MkLCNlbi48CzTBEaFWUgem4XksVkINyxgZF7FKJ5aWpybnlpsnJda
        rlecmFtcmpeul5yfu4kRmARP/zv+dQfjilcf9Q4xMnEwHmKU4GBWEuEtW/Q5SYg3JbGyKrUo
        P76oNCe1+BCjNAeLkjhvcuaGRCGB9MSS1OzU1ILUIpgsEwenVANTRonrWy/fNPtAn7nrIhd+
        8E+f+vYXo8NltVPhh/2uLD8VLDvx2odjoiqcPx1tnybnsW9ZI5gxdeWhGwnbGHd3pHlxuaxf
        H/DbXonvq2L33O0/16+++f91WUqXxXVjp/3yW8+6dEUvithey18n88/mvp7i8V9BHKyz/i3I
        mswqrq01/7bO3y/Z9/MkH5QwCrjOKWw8dNf26uK61yf3pbftLKn+d27fddeZy082Nop1nfFf
        7BtrkGE0t32568lDBb7v9l28/O1j57Lz284rnQkSSdVjtnvQqPduz0yjRGEF76Pbnja9juxv
        kTAyva3EPJP7KGOpXXlhYOrO2UeSlET6ps9T1uJf/u/DIQmGS6vmKrEUZyQaajEXFScCAMWc
        ghvxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7pThL4mGbxZq22x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVcfHmCueB7cMXsp+/YGhgXOXQxcnJICJhI
        /J92gxXEFhJYyiix7KE+RFxC4vbCJkYIW1jiz7Uuti5GLqCaZ4wS7w/OAkpwcLAJaEk0drKD
        mCICuRIHjwSClDALHGGSaH67iwWkV1ggVKL/3hV2EJtFQFXiZPMSMJtXwErizL7LTBDz5SVm
        XvoONodZQFNi/S59iBJBiZMzn4CNYQYqad46m3kCI/8shKpZSKpmIalawMi8ilEktbQ4Nz23
        2EivODG3uDQvXS85P3cTIzBWtx37uWUH48pXH/UOMTJxMB5ilOBgVhLhLVv0OUmINyWxsiq1
        KD++qDQntfgQoynQ1ROZpUST84HJIq8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1
        ILUIpo+Jg1OqgSlF9qJmdcsc+3zVox8PH3ywZGbRD7EN184HfffcmcRXe/+VstYSzVvxj5k2
        O18KnLDPVP9Hfl+onILU29xzoi3icbf/TW5gufnFpU7e8VmCyvy6PisuoXNV3y3X9v0Kvt3f
        xSvN9Lwi0okzOIiLe5Yc5+ycP/Jat1PvXH1tsFEu6cPU/97G83e9vZIS+V9ITzQhs/1P/LHJ
        85PmbmGTv6/69YCsulrc4+115dv2TtHrNxFrZTu9rNBCp+iJrEtch+c5zZArQh112SeEr1mW
        5K/6IfDOwSKTi2W71su0Cb3nXaze7nwbsH+T6NRfm4MvBym3se3vP5XxWqLBd/nnVfqT31xa
        nCmYOW/OZva6C0osxRmJhlrMRcWJABZBLnReAwAA
X-CMS-MailID: 20220811143044eucas1p2cb35a5c247788689aeebf2bc8eb9f5df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143044eucas1p2cb35a5c247788689aeebf2bc8eb9f5df
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143044eucas1p2cb35a5c247788689aeebf2bc8eb9f5df
References: <CGME20220811143044eucas1p2cb35a5c247788689aeebf2bc8eb9f5df@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The patch series is based on linux-next tag: next-20220809

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
 drivers/md/dm-po2zone-target.c                | 245 ++++++++++++++++++
 drivers/md/dm-table.c                         |  20 +-
 drivers/md/dm-zone.c                          |   8 +-
 drivers/md/dm-zoned-target.c                  |   8 +
 drivers/md/dm.c                               |   8 +-
 drivers/nvme/host/zns.c                       |  16 +-
 drivers/nvme/target/zns.c                     |   3 +-
 fs/zonefs/super.c                             |   6 +-
 fs/zonefs/zonefs.h                            |   1 -
 include/linux/blkdev.h                        |  80 ++++--
 include/linux/device-mapper.h                 |   9 +
 20 files changed, 476 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-po2zone.rst
 create mode 100644 drivers/md/dm-po2zone-target.c

-- 
2.25.1

