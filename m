Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19EC59E5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbiHWPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbiHWPHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:07:34 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2FB32A6AB
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:36:25 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220823121904euoutp014fb1601a2d50457e9012e05aa858ab9e~N_JIvnnMh1598215982euoutp01a
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:19:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220823121904euoutp014fb1601a2d50457e9012e05aa858ab9e~N_JIvnnMh1598215982euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661257144;
        bh=Jh6Mj+uv6zJCFphL4I/nw3mJpl4ybd9uO5w2zTt7/IE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=U58fc+5gdB3JN6wtHGWljwTJiKXqHpgLG3qyIxT9mFMNapH88heuWdsubk3WzMq4g
         8CHUe1+g7qj2fL/SNSoJciO0XTEVw8iLf+vZFsWj7p5U8LAFqiwp8F/UFZyDQ67A8y
         kGTFZ/VHhtNTP843GlORZ228RtI2O15rvrWVotec=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220823121901eucas1p19e31f872a7c222fdf6ee995d29270f45~N_JGghk5b1886418864eucas1p1E;
        Tue, 23 Aug 2022 12:19:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 84.71.07817.5B5C4036; Tue, 23
        Aug 2022 13:19:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220823121901eucas1p1d8ec2e0d3d6be63b9d4338f70dd717fe~N_JFwFbZ31175311753eucas1p1A;
        Tue, 23 Aug 2022 12:19:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220823121901eusmtrp290a9a2dda6cb94226718ce8de23cdce0~N_JFvHqbT2723427234eusmtrp2W;
        Tue, 23 Aug 2022 12:19:01 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-48-6304c5b5a530
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9F.02.07473.4B5C4036; Tue, 23
        Aug 2022 13:19:00 +0100 (BST)
Received: from localhost (unknown [106.210.248.52]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220823121900eusmtip2dcdb76fd8320f34e3ccc35811cfc2134~N_JFa_4xm2209522095eusmtip22;
        Tue, 23 Aug 2022 12:19:00 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com, bvanassche@acm.org,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v12 00/13] support zoned block devices with non-power-of-2
 zone sizes
Date:   Tue, 23 Aug 2022 14:18:46 +0200
Message-Id: <20220823121859.163903-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djPc7pbj7IkG0x4ZWix/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGVcXV5SMC+0
        4vmTDqYGxtWOXYycHBICJhJX9sxi7GLk4hASWMEo8W/RNVYI5wujRO+kH1CZz4wSz4+fYOti
        5ABraVwJFV/OKHHtdhdUxwtGiQUnNzGDFLEJaEk0drKDrBARSJf4+nUDWAOzwDYmiV93L7GA
        1AgLhEvMXF4HUsMioCpx/Vk/G4jNK2AlcXvLTmaI8+QlZl76zg4RF5Q4OfMJC4jNDBRv3jqb
        GWSmhMByTonOuQ9ZIRpcJN5s3M4CYQtLvDq+hR3ClpH4v3M+E4RdLfH0xm+o5hZGif6d66E+
        s5boO5MDYjILaEqs36UPUe4oceZ2BytEBZ/EjbeCECfwSUzaNp0ZIswr0dEmBFGtJLHz5xOo
        pRISl5vmQB3jIXH2+DSwKUICsRI7HptOYFSYheSvWUj+moVwwgJG5lWM4qmlxbnpqcVGeanl
        esWJucWleel6yfm5mxiBCfD0v+NfdjAuf/VR7xAjEwfjIUYJDmYlEd7qiwzJQrwpiZVVqUX5
        8UWlOanFhxilOViUxHmTMzckCgmkJ5akZqemFqQWwWSZODilGphWC6zXnOqTfFfxRGJu45me
        wmvCzZ+aCq9fMZ7/zSA8ZOUer535r559FitOXMC6beqXFufvl5ZfKnr9z9jXdLoqg72Km3/S
        w0e3pzi2ZKS07nqeWs1wN0Je4eMCN86Oa3sjD7CmW3y2q5myieFq2KQd5f17ZeWr70jd6t29
        bvvs4Gibsz+Mtu/fq7xzx/edn1iUksVmvrb16/JMYtB/ZWcgMOO5ik2NRXRW5YdFKys8z1k1
        8db+mDb/pKTOY17nE+9r7svKHmKPVo4oFLx475LOZpeGmC+1jiXeBzcflWLUYfh8av+bGf4f
        KqULv0QfTyny//LHqPi2/OGQZg7FmD6nOQuYyqOXri7fp/WobJISS3FGoqEWc1FxIgDjfnKX
        7wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7pbj7IkG2wwslh/6hizxeq7/WwW
        0z78ZLb4ffY8s8Xed7NZLW4e2MlksWfRJCaLlauPMlk8WT+L2eJv1z0mi723tC0u75rDZjF/
        2VN2iwltX5ktPi9tYbdYc/Mpi8WJW9IOgh6Xr3h77Jx1l93j8tlSj02rOtk8Ni+p99h9s4HN
        Y2frfVaP9/uusnn0bVnF6LH5dLXH501yHu0HupkCeKL0bIryS0tSFTLyi0tslaINLYz0DC0t
        9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mq4uLymYF1rx/EkHUwPjascuRg4OCQETicaV
        jF2MXBxCAksZJf49eQDkcALFJSRuL2yCsoUl/lzrYoMoesYosWXbS3aQZjYBLYnGTnaQGhGB
        XInDmycwgdQwCxxhkljduJYVJCEsECpx5Pp0FhCbRUBV4vqzfjYQm1fASuL2lp3MEAvkJWZe
        +g42k1lAU2L9Ln2IEkGJkzOfgLUyA5U0b53NPIGRfxZC1SwkVbOQVC1gZF7FKJJaWpybnlts
        qFecmFtcmpeul5yfu4kRGKnbjv3cvINx3quPeocYmTgYDzFKcDArifBWX2RIFuJNSaysSi3K
        jy8qzUktPsRoCnT1RGYp0eR8YKrIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1I
        LYLpY+LglGpg6j7Ba9KU2rjAjOkL1wGeNfOqH8Rwb2iSyc7zZNUzlEz+un+6bHD7zCcvleOU
        TB5cbFSRnaX2P/KSkX/moqNLdm1YfejlmaOXlt9bw1J+49zxlWJJz3QKz/54avnzaV/6yz2F
        jPuUHgiez5WwDOjwvmXW+u33n5n65fMzn2zsmVOWn7rl5X7fRyJKl1hOPuF79YI9ed+HX9Pc
        d15+xbarYcVOtodf5O8/d3jd+dluOdu9O0tlb803eviboUNsuWK0+IaLGoxTA88WnN7fyL5i
        K7fFeXPuRqFSt+o783xv794VffjZgT3LF12UdmG9ycmwxKHNpN/GPOGwb8yRzGeN8vznlVbp
        cjyYmrHQw1XF7o8SS3FGoqEWc1FxIgBqnq2HXQMAAA==
X-CMS-MailID: 20220823121901eucas1p1d8ec2e0d3d6be63b9d4338f70dd717fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220823121901eucas1p1d8ec2e0d3d6be63b9d4338f70dd717fe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121901eucas1p1d8ec2e0d3d6be63b9d4338f70dd717fe
References: <CGME20220823121901eucas1p1d8ec2e0d3d6be63b9d4338f70dd717fe@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

The patch series is based on linux-next tag: next-20220823

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

Changes since v11:
- Rename bio_in_emulated_zone_area and some formatting adjustments
  (Damien)

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

