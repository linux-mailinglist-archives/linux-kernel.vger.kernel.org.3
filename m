Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC93E58FE5E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiHKObo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiHKOa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:30:59 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897BD6BD48
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:30:57 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143055euoutp016f9986da626bd1df8c7d908e99f3dc51~KUM1WuEVs2304723047euoutp015
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:30:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220811143055euoutp016f9986da626bd1df8c7d908e99f3dc51~KUM1WuEVs2304723047euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660228255;
        bh=tSSBnG0aDQsGLDWCBqD+ZIZXJV/OR5HHGZmAzSOHsrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8USTs3X6zeQ/nIQcVJ5yHUy7tSjnkzCFNg1sJuJ8UdZXeNciq8eEAOAvZoRnhmyf
         7pFkrvXvTWH/B8P0PWOmmsc4Eunp+cS2WUlJJs0qB0FtDX4Wy+2IpEqNvjS8cy71Jo
         vY9JY6w44nYggn7hoNqwBlZHui74jJfQsiD7wszo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220811143054eucas1p275d5a0a71bb6714726ff4a4187e14189~KUMz_-RZE1005510055eucas1p2H;
        Thu, 11 Aug 2022 14:30:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 46.3A.09664.D9215F26; Thu, 11
        Aug 2022 15:30:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220811143053eucas1p2eda49423b8f18ef71c47583af4855f6b~KUMzZ5MdM1005510055eucas1p2G;
        Thu, 11 Aug 2022 14:30:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220811143053eusmtrp1a08b048090db4872f06982c25c931709~KUMzY-2Q02320623206eusmtrp1m;
        Thu, 11 Aug 2022 14:30:53 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-fc-62f5129db8ef
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 19.10.09038.D9215F26; Thu, 11
        Aug 2022 15:30:53 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220811143053eusmtip29653ad79baf31ba06934a9814941ca96~KUMzErsQ41543015430eusmtip2O;
        Thu, 11 Aug 2022 14:30:53 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v10 08/13] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Date:   Thu, 11 Aug 2022 16:30:38 +0200
Message-Id: <20220811143043.126029-9-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811143043.126029-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7pzhb4mGdxpt7ZYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlTGv
        XaJgHk/FnIavLA2MLVxdjJwcEgImErc2XWHsYuTiEBJYwSgx4ek0NgjnC6PE11edrBDOZ0aJ
        puWn2WBaJp6bBNWynFGiY/8bKOcFo8TCvt1AVRwcbAJaEo2d7CANIgLpEusXLGcBqWEWuMMk
        sXzvJUaQhLBAiMSivZfAprIIqEq0vHwE1sArYCXR33iEEWKbvMTMS9/B4pwC1hITFl1kgqgR
        lDg58wkLiM0MVNO8dTYzyAIJgc2cEre/b2aGaHaReNN4DmqQsMSr41vYIWwZidOTe1gg7GqJ
        pzd+QzW3MEr071wP9oEE0La+MzkgJrOApsT6XfoQ5Y4SzQ+PMkNU8EnceCsIcQKfxKRt06HC
        vBIdbUIQ1UoSO38+gVoqIXG5aQ7UUg+JlU+esExgVJyF5JlZSJ6ZhbB3ASPzKkbx1NLi3PTU
        YsO81HK94sTc4tK8dL3k/NxNjMCEePrf8U87GOe++qh3iJGJg/EQowQHs5IIb9miz0lCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUamDJ+3nKQTON84fP2
        3t/ADfLuDueWbi9LuNkb9CL2YOmu1+91wiu9JjRd67jjq5Bhe1z8lQPTQyVO4TP/P93/GuM+
        kZffvbPII2LbvE3q7xXU08+mxAV+PTZBXfM4v+PTK2lTci93TuXq+bnszePT+7+c4/cMt9P9
        d3rm+fJ//katau6CtTx3wzM8He99qj3vVdB1K4Jx5i8pd1P3S5sNl3cvt+KpC3oj13xX7K71
        yx831zV8UCm4LRtx/GBlQrZA2zHut+ulA9K/BVZ4VOvtdu3ifxa6cf0sppbyQ+2Tvn7/d9k7
        aqZu/7PH3Yf8NYQv3vh8+sLyBR7szYEln/Qiu51SNWPfTGSUF199+uwGdSWW4oxEQy3mouJE
        ANlijNj3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7pzhb4mGWxtE7FYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzGvXaJgHk/FnIavLA2MLVxdjJwc
        EgImEhPPTWLsYuTiEBJYyiix8NI5VoiEhMTthU2MELawxJ9rXWwQRc8YJR7e/c7SxcjBwSag
        JdHYyQ5iigjkShw8EghSwizwhknixqu37CC9wgJBEie3zGQBsVkEVCVaXj4Ci/MKWEn0Nx6B
        mi8vMfPSd7A4p4C1xIRFF5lAbCGgmgkdx6DqBSVOznwCNocZqL5562zmCYwCs5CkZiFJLWBk
        WsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYuduO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8JYt
        +pwkxJuSWFmVWpQfX1Sak1p8iNEU6O6JzFKiyfnA1JFXEm9oZmBqaGJmaWBqaWasJM7rWdCR
        KCSQnliSmp2aWpBaBNPHxMEp1cAUrTf/n3huul3/hOeHXWveeJVfjvyZlCfqU9bad/y9tZ3Z
        iUdG0XaP16979zLv8e4NKcxzn526aOq9atPFRRpFpbIsK4viS1STTgjEfHtmr/1m/7umDXca
        VwhWl84WPX7hq/uvp5//fWScuvft9pjVZ2qOrDFfLPyi6+ivwqyYzoR9luZa3mHF7/oePLcX
        LGafHXbeIHTx92t+Kx55b5CI+3T4mGn47RQevlSHCRz+0+ZF89wUK5ycxMlZvD99/uewfkWP
        JyUxS0SV2FR7JgRwVbUHiJ9M7z0+Q7dY20BllfFZtyN7wx7Oi/8j8KTYcqdP/KeOvScXeAk7
        J9+Ocg9IP3vqz5zrU1ufZv1a0S2oxFKckWioxVxUnAgA754+jWUDAAA=
X-CMS-MailID: 20220811143053eucas1p2eda49423b8f18ef71c47583af4855f6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143053eucas1p2eda49423b8f18ef71c47583af4855f6b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143053eucas1p2eda49423b8f18ef71c47583af4855f6b
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143053eucas1p2eda49423b8f18ef71c47583af4855f6b@eucas1p2.samsung.com>
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

From: Luis Chamberlain <mcgrof@kernel.org>

dm-zoned relies on the assumption that the zone size is a
power-of-2(po2) and the zone capacity is same as the zone size.

Ensure only po2 devices can be used as dm-zoned target until a native
support for zoned devices with non-po2 zone size is added.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-zoned-target.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 95b132b52f33..9325bf5dee81 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 				return -EINVAL;
 			}
 			zone_nr_sectors = bdev_zone_sectors(bdev);
+			if (!is_power_of_2(zone_nr_sectors)) {
+				ti->error = "Zone size is not a power-of-2 number of sectors";
+				return -EINVAL;
+			}
 			zoned_dev->zone_nr_sectors = zone_nr_sectors;
 			zoned_dev->nr_zones = bdev_nr_zones(bdev);
 		}
@@ -804,6 +808,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 			return -EINVAL;
 		}
 		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
+		if (!is_power_of_2(zoned_dev->zone_nr_sectors)) {
+			ti->error = "Zone size is not a power-of-2 number of sectors";
+			return -EINVAL;
+		}
 		zoned_dev->nr_zones = bdev_nr_zones(bdev);
 	}
 
-- 
2.25.1

