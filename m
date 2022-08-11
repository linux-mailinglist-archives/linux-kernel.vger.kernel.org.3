Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DCF58FE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiHKObj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbiHKObA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:31:00 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C674E33
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:30:58 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143056euoutp0118bff8dbe907954c55aa8c912cd3d3ad~KUM2adLRC2164821648euoutp01S
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:30:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220811143056euoutp0118bff8dbe907954c55aa8c912cd3d3ad~KUM2adLRC2164821648euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660228256;
        bh=rIbhfxDBpj+Ii51tIIt4kTVb6ZA8NV8eQeaNrvmy2UQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9zUUwI568qVkNe5i6/uPwINDBUowXjf+xysvYJfHj2NweRWsmAq12Ik7aj73bfNH
         F+GcV8ggkZtv01mKwlu8719WprtWCPlstIIFaKcuZ2DdjTuU6lTCmDkuw1OYusit9I
         mKPcgDm6jNu4CbWxz7a56b/B56+Bko/Vqkg8VefY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220811143055eucas1p2d51c4b46b22206be2fa360812fdffb61~KUM08FzKq1001410014eucas1p2E;
        Thu, 11 Aug 2022 14:30:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D1.9C.09580.E9215F26; Thu, 11
        Aug 2022 15:30:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220811143054eucas1p219e5b31b24cca97e2bc563351436543d~KUM0gN7qH2359623596eucas1p2H;
        Thu, 11 Aug 2022 14:30:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220811143054eusmtrp287d06731f2d99f572e10a6e3fb2ba578~KUM0fcGiW0788907889eusmtrp2w;
        Thu, 11 Aug 2022 14:30:54 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-be-62f5129ea721
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 34.9F.09095.E9215F26; Thu, 11
        Aug 2022 15:30:54 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220811143054eusmtip1fd57ba199cdde6dcf3aee0684ec592b4~KUM0IuVmv3243332433eusmtip1C;
        Thu, 11 Aug 2022 14:30:54 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v10 09/13] dm-zone: use generic helpers to calculate offset
 from zone start
Date:   Thu, 11 Aug 2022 16:30:39 +0200
Message-Id: <20220811143043.126029-10-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811143043.126029-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTZxjNe+/t7S1acylG3yjqdrWLslE1mOxdZIILW27ij0kiMcOYWfCK
        pC2a1gpKFhjiB98dyUBax9coX7qU0KKtCtPKp6gEK1qIbUnWxlmzAUFkDSi23Jr575znnPOe
        50leCpd4BeuozKxTnDpLrmTICOJ6f2AktlYyl7ajdzEeme734+iqq4JEVdMBHC08HMFR978G
        ARq/Y8PQ7cZKDLVd7cOQ16TH0dtiN4a6Jz5HjptXSFTX7BMi3YU5HDl1PoBmjYVCdG3cR6DB
        ifWJEtbxZB9r07uErOOhlu1sLyJZc1Mee2s8n2Rt5z0CdqpnjGTLLe2ANQ/nsrOdG9mLd0qw
        /StTI+KPcsrM05x6+54jEceb773BT15akTM2xeSDMlExEFGQ3gXLDdNEMYigJHQrgCWGaYwn
        rwGcLB0Mk1kAPf5CwYfIn8U6wAstAL4YmguTvwHUTQwECUWRdAz8uUgYCqymM6CpvmW5A6ef
        Y3DeXUqGhCj6MJx0leEhTNBSGOhzESEspnfDN20NON+2CdY8nl9+SBSc6xpHMd4TCYdqvMt+
        POg512XAQwWQNotgzZA9HE6C874ugsdR0D9gEfI4Gi7Z6jAe50KfcyEcLgSwwmYiQxfAYFv5
        A2UI4vQ2aLq5nbfvhQ09hrBjFXT+E8mvsApWXq/G+bEYXrog4d0MtAW84VIIHQVXwsuw0LDY
        TOjAp/qPjtF/dIz+/956gLeDtZxWo8rgNHFZXLZMI1dptFkZsvQTqk4Q/IjD7wbmrKDVPyOz
        A4wCdgApnFktPt04myYRH5WfOcupT/yo1io5jR2spwhmrTg9s0MuoTPkpzgFx53k1B9UjBKt
        y8eQ8W5D25GtlwcMF1MXlVP/xe6t2sNVvrZ8ZZcx37iM38Ukyf7oTTnozKEnd5d+kV5mmElO
        zrSW/3XYHv29IqljcKHruWLw63Nxv9fFW7s8iupfd9366ZdrVePRLzuSfphpdexcM7I5lYlN
        6Dz07Ybq6MeNx35zx56nDlgLirI/SUM5eW52wTORUN+X8Nmz0d7Ezdlef4HrGVe1KXDXf8PX
        cDtum7qQ6e+W3lActESatzzqqXaO2UbdK63DquSoV4KzO8zHlFu+bG1JqX2q9TQ98JSOPQ1s
        lNZe7qlgjIlbVaqUlLzJjtrct5VLlhJ94qGll1KtuV3alNpslG6Ar/YlWxhCc1y+MwZXa+Tv
        AYVnNuj3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xu7rzhL4mGWxukLVYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7Hs8Dfmgg7uiqvvlRoYezm7GDk5
        JARMJPZ3TWDsYuTiEBJYyihxu28SC0RCQuL2wiZGCFtY4s+1LjaIomeMElvvLmTuYuTgYBPQ
        kmjsZAcxRQRyJQ4eCQQpYRZ4wyTReX0P2BxhgWiJjefnM4HYLAKqEj+P3gWL8wpYS3xbCTIG
        ZL68xMxL39lBbE6g+IRFF8HqhQSsJCZ0HGOHqBeUODnzCVgvM1B989bZzBMYBWYhSc1CklrA
        yLSKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMHK3Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuEt
        W/Q5SYg3JbGyKrUoP76oNCe1+BCjKdDdE5mlRJPzgakjryTe0MzA1NDEzNLA1NLMWEmc17Og
        I1FIID2xJDU7NbUgtQimj4mDU6qBaWp59vMHOZrt9ndrVgjZpGSILijcfvhzdEbglIotBkKR
        2RuXbP516O33uewz2Koa9xRsyvBln5teu3eqn7xU0aMdweEVfS3RW3ZlMiYs6N9iIjtv33We
        TUZWiyQYT5y/qBe+w0qJ+b5ImGGypYtmRfcT8+OiBvKpsxf8vmedHPMyOu3x/S0lO87afyjs
        vCXx5eYdv9mXqt52rbDknHBt76krBrd13dqs96R/Xfmhb787U8HHeZafJxzOrqi+y2IQed7z
        7PP5jS3LTinwX7yYHzz59gWhvs9H0vfekYtJStxSrdu4pf7NT84o/8oOO8UqrT1miiXVr1Mn
        TE0RWL4lLvXSq5nPKj3cNtbE5HduVGIpzkg01GIuKk4EAHvjSxNlAwAA
X-CMS-MailID: 20220811143054eucas1p219e5b31b24cca97e2bc563351436543d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143054eucas1p219e5b31b24cca97e2bc563351436543d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143054eucas1p219e5b31b24cca97e2bc563351436543d
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143054eucas1p219e5b31b24cca97e2bc563351436543d@eucas1p2.samsung.com>
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

Use the bdev_offset_from_zone_start() helper function to calculate
the offset from zone start instead of using power of 2 based
calculation.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/md/dm-zone.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 3dafc0e8b7a9..ac6fc1293d41 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -390,7 +390,8 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE:
 		/* Writes must be aligned to the zone write pointer */
-		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
+		if (bdev_offset_from_zone_start(md->disk->part0,
+						clone->bi_iter.bi_sector) != zwp_offset)
 			return false;
 		break;
 	case REQ_OP_ZONE_APPEND:
@@ -602,11 +603,8 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
 		 */
 		if (clone->bi_status == BLK_STS_OK &&
 		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
-			sector_t mask =
-				(sector_t)bdev_zone_sectors(disk->part0) - 1;
-
 			orig_bio->bi_iter.bi_sector +=
-				clone->bi_iter.bi_sector & mask;
+				bdev_offset_from_zone_start(disk->part0, clone->bi_iter.bi_sector);
 		}
 
 		return;
-- 
2.25.1

