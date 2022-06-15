Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C042A54C5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346946AbiFOKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiFOKTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:19:36 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128B33E5E6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:19:30 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220615101926euoutp01e9461380e479ba205deb09be9d65a30a~4w--ZUUH72281922819euoutp01b
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:19:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220615101926euoutp01e9461380e479ba205deb09be9d65a30a~4w--ZUUH72281922819euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655288366;
        bh=eLOiJUoNbnfsZUov2EVpzTumu23358MNUI2L+v8Fc7o=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YpwQGT76Q0wQvEJX2Wp9LDWZxNQNknBArbyn439kxXelV9jvaK322lenTodx9Ei00
         xCJcO2zwv3dBs00VQFQQbdHB8h367Uj9l0NeavqcNf4ggB6svcbsZAYtEcz2maeOb7
         xQ9zV2bgdEeDi7d8dzsnVo7qsytNZcjRlzethaLI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220615101924eucas1p2bfd985105dbde7d99937b28ba581d0cc~4w-9aNVFB1911219112eucas1p2d;
        Wed, 15 Jun 2022 10:19:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 51.69.09580.C22B9A26; Wed, 15
        Jun 2022 11:19:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220615101924eucas1p27fbce623c0e1b3097169bf23dd6266d8~4w-8-ROYS1347713477eucas1p2y;
        Wed, 15 Jun 2022 10:19:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615101924eusmtrp21deac3323e9ad9a545214ba29eb80c7c~4w-8_QOZ40308003080eusmtrp2L;
        Wed, 15 Jun 2022 10:19:24 +0000 (GMT)
X-AuditID: cbfec7f5-1bfc7a800000256c-ed-62a9b22c1929
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 90.45.09095.B22B9A26; Wed, 15
        Jun 2022 11:19:24 +0100 (BST)
Received: from localhost (unknown [106.210.248.244]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220615101922eusmtip2de5ad9ee81cfad14bcb36acabf49fde2~4w-7j7FbM0785907859eusmtip2D;
        Wed, 15 Jun 2022 10:19:22 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hch@lst.de, snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v7 00/13] support non power of 2 zoned device
Date:   Wed, 15 Jun 2022 12:19:07 +0200
Message-Id: <20220615101920.329421-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7djP87o6m1YmGZw5Lmex+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
        aVtc3jWHzWL+sqfsFp+XtrBbrLn5lMWibeNXRgchj8tXvD3+nVjD5rFz1l12j8tnSz02repk
        81jYMJXZY/OSeo/dNxuAcq33WT3e77vK5tG3ZRWjx/otV1k8Np+u9vi8Sc6j/UA3UwB/FJdN
        SmpOZllqkb5dAlfGxe1/mQq+GlVcm3OTqYFxlUYXIyeHhICJxMaeX0xdjFwcQgIrGCVudN2A
        cr4wSuxduYcVwvnMKNF8cTIbTMvUhcdYIBLLGSV2vN3BDOG8ZJRY8eMZUAsHB5uAlkRjJztI
        g4hAuMTRPffAxjILvGCSWHx7LitIQljAVuLXvv/sIPUsAqoSM1v4QExeASuJze06ELvkJWZe
        +g42hldAUOLkzCcsIDYzULx562ywtRIC+zklZvatgjrOReJ27wooW1ji1fEt7BC2jMT/nfOZ
        IOxqiac3fkM1tzBK9O9czwayWELAWqLvTA6IySygKbF+lz5E1FHi/dlsCJNP4sZbQYgL+CQm
        bZvODBHmlehoE4KYrSSx8+cTqJ0SEpeb5rBA2B4SPx88BrtLSCBW4vzUL8wTGBVmIflrFpK/
        ZiGcsICReRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgsjz97/jXHYwrXn3UO8TIxMF4
        iFGCg1lJhNcseGWSEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkm
        Dk6pBqaSxw/dslUj+nU10/M8nT5Zbd3MvUlpvn9Nyfe2bdt2bm+t2lNRZMevmXtFOvfBg5On
        jlwsuBnaYegQlH5ryoT2LVnlZxJe+O1gcthrt/dP/KZS+RIOIX2/ZUUzt9RHFm0su+DGGKzy
        VK1TTUa20XGN/Z9fuz43Pbg8QXPqkpDKWLn2kjm/grfPrmffl73nxYFlS5vvi6+xce/QSmHT
        mdBV/0PKLd3KgHtLOvMhreo/1qlflk+a8nWXpGPlnBMn9yWr2NhaS2rWf1x6XvqhpcHJTc8v
        SpnXpcZ+4kpepL/xVQejZdHbW8un6mqtF2CZ8N1qZaOSadbh5U478x7HH04628h0SnSjxPWa
        pv/5W5RYijMSDbWYi4oTATFKlk0FBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsVy+t/xe7o6m1YmGfTsYLRYfbefzWLah5/M
        Fr/Pnme22PtuNqvFhR+NTBY3D+xkstizaBKTxcrVR5ksnqyfxWzRc+ADi8XfrntAsZaHQMW3
        tC0u75rDZjF/2VN2i89LW9gt1tx8ymLRtvEro4OQx+Ur3h7/Tqxh89g56y67x+WzpR6bVnWy
        eSxsmMrssXlJvcfumw1Audb7rB7v911l8+jbsorRY/2Wqywem09Xe3zeJOfRfqCbKYA/Ss+m
        KL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j4va/TAVf
        jSquzbnJ1MC4SqOLkZNDQsBEYurCYyxdjFwcQgJLGSXOPVvLBpGQkLi9sIkRwhaW+HOtiw2i
        6DmjxNtbc1i7GDk42AS0JBo72UFqRASiJTpvvgerYRb4wSQxYdFasISwgK3Er33/2UHqWQRU
        JWa28IGYvAJWEpvbdSDGy0vMvPQdrIJZQFNi/S59kDCvgKDEyZlPWEBsZqCS5q2zmScw8s9C
        qJqFpGoWkqoFjMyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAqN627Gfm3cwznv1Ue8QIxMH
        4yFGCQ5mJRFes+CVSUK8KYmVValF+fFFpTmpxYcYTYFunsgsJZqcD0wreSXxhmYGpoYmZpYG
        ppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTP2PrylJNAvLWv5hPrPjq3HjxLgMX36n
        G4YG6x5cmOp/98bNS3OCPnLPvMp3ROnkx0mhK05Wv+jJ2vL+p657idASR67LDndTpOzLzPPj
        VQ18uYX8HybcWXfpsth8+2/maf7Wvg/0Fe72zhWc4KEp/jXvskjqUmbdZYfOv53dO/Vmss+F
        uHOzle+ZK33WVT0zxT+r8V3Kb9XKyPTbZjsYpjOoS24Od7NJsL/9Keba2oqyw67lW167bo3w
        et/+ZVuGyukNmerJS5f4/2jL1s4yTav9zf1i0goepqPR3+Wf/sz+kLPgqLH7f7+yB90PmFL/
        nFSoX8fI4Be51urMzWTlPb8/r2v8G74/av2HNCmFl0osxRmJhlrMRcWJADNa+FZzAwAA
X-CMS-MailID: 20220615101924eucas1p27fbce623c0e1b3097169bf23dd6266d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615101924eucas1p27fbce623c0e1b3097169bf23dd6266d8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615101924eucas1p27fbce623c0e1b3097169bf23dd6266d8
References: <CGME20220615101924eucas1p27fbce623c0e1b3097169bf23dd6266d8@eucas1p2.samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
naturally align to po2. In these devices, zone cap is not the same as the
po2 zone size. When the zone cap != zone size, then unmapped LBAs are
introduced to cover the space between the zone cap and zone size. po2
requirement does not make sense for these type of zone storage devices.
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
layer and a new dm target is added: dm-zoned-npo2-target. This new
target will be initially used for filesystems such as btrfs and
f2fs that does not have native npo2 zone support.

- Patchset description:
Patches 1-2 deals with removing the po2 constraint from the
block layer.

Patches 3-4 deals with removing the constraint from nvme zns.

Patch 5-6 removes the po2 contraint in null blk

Patch 7 adds npo2 support to zonefs

Patches 8-13 adds support for npo2 zoned devices in the DM layer and
adds a new target dm-zoned-npo2-target

The patch series is based on linux-next tag: next-20220615

Testing:
The new target was tested with fio, xfstests with btrfs and zonefs test
suite. No new regression was found during the testing.

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

Luis Chamberlain (1):
  dm-zoned: ensure only power of 2 zone sizes are allowed

Pankaj Raghav (12):
  block: make blkdev_nr_zones and blk_queue_zone_no generic for npo2
    zsze
  block: allow blk-zoned devices to have non-power-of-2 zone size
  nvme: zns: Allow ZNS drives that have non-power_of_2 zone size
  nvmet: Allow ZNS target to support non-power_of_2 zone sizes
  null_blk: allow non power of 2 zoned devices
  null_blk: use zone_size_sects_shift for power of 2 zoned devices
  zonefs: allow non power of 2 zoned devices
  dm-zone: use generic helpers to calculate offset from zone start
  dm-table: use bdev_is_zone_start helper in device_area_is_invalid()
  dm-table: allow non po2 zoned devices
  dm: call dm_zone_endio after the target endio callback for zoned
    devices
  dm: add non power of 2 zoned target

 block/blk-core.c                  |   3 +-
 block/blk-zoned.c                 |  37 ++++-
 drivers/block/null_blk/main.c     |   5 +-
 drivers/block/null_blk/null_blk.h |   6 +
 drivers/block/null_blk/zoned.c    |  18 +-
 drivers/md/Kconfig                |   9 +
 drivers/md/Makefile               |   2 +
 drivers/md/dm-table.c             |   6 +-
 drivers/md/dm-zone.c              |  16 +-
 drivers/md/dm-zoned-npo2-target.c | 268 ++++++++++++++++++++++++++++++
 drivers/md/dm-zoned-target.c      |   8 +
 drivers/md/dm.c                   |   8 +-
 drivers/nvme/host/zns.c           |  21 ++-
 drivers/nvme/target/zns.c         |   2 +-
 fs/zonefs/super.c                 |   6 +-
 fs/zonefs/zonefs.h                |   1 -
 include/linux/blkdev.h            |  48 +++++-
 17 files changed, 416 insertions(+), 48 deletions(-)
 create mode 100644 drivers/md/dm-zoned-npo2-target.c

-- 
2.25.1

