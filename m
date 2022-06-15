Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4989454C5EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348120AbiFOKVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347519AbiFOKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:20:16 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06114A3F0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:20:10 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220615102009euoutp029228a755df2aa2c66ee44ba58f87b97e~4xAnfSTx32943629436euoutp02R
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:20:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220615102009euoutp029228a755df2aa2c66ee44ba58f87b97e~4xAnfSTx32943629436euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655288409;
        bh=kqhXofjv7uMNz96r4u8PvIfIck7OqraAvR3Oyb3bfow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJ3t1W+eNQfrvwZKzB6amYZi431qe/H6WRpU+W9ElOALAawJ5yDpLXfRQjYIhr2zP
         mDt7e+itcSQfQDlNqS/miA2ohP5oOlXdwVIXsdyKZua1/I8QddU5nK4OGfhY4T7WJP
         j1nwLVSDhUA3OXNPwoDcF04QunxliyHRoG7AOm4w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220615102008eucas1p2e85d5e1cf2fc269992852614bac65244~4xAl5vWjX0710507105eucas1p2n;
        Wed, 15 Jun 2022 10:20:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DD.4B.09664.752B9A26; Wed, 15
        Jun 2022 11:20:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220615102007eucas1p1106f9520e2a86beb3792107dffd8071b~4xAlg-xfo0963309633eucas1p1M;
        Wed, 15 Jun 2022 10:20:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615102007eusmtrp2669d4daff88954051642382b44d5908f~4xAlgN9xL0361403614eusmtrp2O;
        Wed, 15 Jun 2022 10:20:07 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-42-62a9b2577ce6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 96.34.09038.752B9A26; Wed, 15
        Jun 2022 11:20:07 +0100 (BST)
Received: from localhost (unknown [106.210.248.244]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220615102006eusmtip2a812fe6e28f7649ef0489c27adfb5e9f~4xAkoisYR0472904729eusmtip2d;
        Wed, 15 Jun 2022 10:20:06 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hch@lst.de, snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v7 12/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Date:   Wed, 15 Jun 2022 12:19:19 +0200
Message-Id: <20220615101920.329421-13-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615101920.329421-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7djP87rhm1YmGXTvMLdYfbefzWLah5/M
        Fr/Pnme22PtuNqvFhR+NTBY3D+xkstizaBKTxcrVR5ksnqyfxWzRc+ADi8XfrntAsZaHQMW3
        tC0u75rDZjF/2VN2i89LW9gt1tx8ymLRtvEro4OQx+Ur3h7/Tqxh89g56y67x+WzpR6bVnWy
        eSxsmMrssXlJvcfumw1Audb7rB7v911l8+jbsorRY/2Wqywem09Xe3zeJOfRfqCbKYA/issm
        JTUnsyy1SN8ugStj0d925oK/vBWr2neyNTDu4O5i5OSQEDCR6J+/lLmLkYtDSGAFo8SpXcvY
        IJwvjBJzpi1kgXA+M0psObycHabl372/rBCJ5YwSM/5eh+p/CVT1fxFQPwcHm4CWRGMnWIOI
        QLjE0T33mEBqmAVeMEksvj2XFSQhLJAicXXhHyYQm0VAVaJjYgczSC+vgLXE/Wd1EMvkJWZe
        +g42hxMovGN2D1grr4CgxMmZT1hAbGagmuats8FukBA4xSmxtesBE0Szi8T3N9PYIGxhiVfH
        t0B9ICPxf+d8qJpqiac3fkM1tzBK9O9cD/aABNC2vjM5ICazgKbE+l36EOWOEgtP9jJDVPBJ
        3HgrCHECn8SkbdOhwrwSHW1CENVKEjt/PoFaKiFxuWkOC4TtIdE0/QXLBEbFWUiemYXkmVkI
        excwMq9iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITJin/x3/tINx7quPeocYmTgYDzFK
        cDArifCaBa9MEuJNSaysSi3Kjy8qzUktPsQozcGiJM6bnLkhUUggPbEkNTs1tSC1CCbLxMEp
        1cAk53D78Q5e9lOP5svpTrEoLRTfKP1uUnquzel76cGbZJPCw2+kCr2veqH898GS8Cbdr982
        KJ1Rbvq0YsGOj4cCF/YX/Kor3W2QrD9rxo63vGLd+a8nL+mRzow6N/fhrTuhmy2UHIyd5XVP
        P3tyyqJ0YkVKC1uO8RSXF5u37WF8VLNacepc8wO1KevkSud6iZ+v1nB5LBf9MCRgQaF3hdy+
        b3x7FhirXhGb2Ga73KWG5cNUho1z1TKPlsrFHCl+eVTvUMUMAf/i+cfciycuO8uqazArw1Sg
        7NY2k4L+hC0zFFcf0/024Xvw+dUKs8+v4VDIUep//65f8sPjGQxP3Ov9Vktb3T/+//CvU8z/
        F7S7KLEUZyQaajEXFScCABH8nUgHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xe7rhm1YmGbycqmCx+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
        aVtc3jWHzWL+sqfsFp+XtrBbrLn5lMWibeNXRgchj8tXvD3+nVjD5rFz1l12j8tnSz02repk
        81jYMJXZY/OSeo/dNxuAcq33WT3e77vK5tG3ZRWjx/otV1k8Np+u9vi8Sc6j/UA3UwB/lJ5N
        UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gor/tzAV/
        eStWte9ka2Dcwd3FyMkhIWAi8e/eX9YuRi4OIYGljBKb/jxlhEhISNxe2ARlC0v8udbFBlH0
        nFGit/kuSxcjBwebgJZEYyc7SI2IQLRE5833YDXMAj+YJCYsWguWEBZIkvgx9xmYzSKgKtEx
        sYMZpJdXwFri/rM6iPnyEjMvfQcr4QQK75jdwwpSIiRgJbHrXTxImFdAUOLkzCcsIDYzUHnz
        1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwsrcd+7llB+PKVx/1
        DjEycTAeYpTgYFYS4TULXpkkxJuSWFmVWpQfX1Sak1p8iNEU6OqJzFKiyfnA1JJXEm9oZmBq
        aGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cAk9VNiWqrwemXl45Prs6r3zCi/
        u2pPkuiEiS/l9xbuuGrAxaya+vtrdPAH3ob8qxN6b8TV214164gM+cuaJal97Ozs6o2NHaZV
        e45+Ws6qEfztqm78dGVfj2OfDaepH5kjfauE836TGuPppa8uuLS0n5mxQ0+wZOWh3qjHnFf+
        NEp5Lo1czx+6N0nA7N+Eh7eu7E/5bJFYrRL5/6AFm7b3weZ7OUuvFS7znqNdavDqyrM3ZZOa
        f/Cqfu5LrowynrF0zuKbkwN4FgbZuJx5d8Phdeb0nV17AwVWPl38/Puh2Upd5ZPNPBbVPc+V
        SKk7Et3+RVLaYMdTpvtMH6f0uJRNs/0XPmMrb7TuPMPfm7YHKrEUZyQaajEXFScCAJiYyIR1
        AwAA
X-CMS-MailID: 20220615102007eucas1p1106f9520e2a86beb3792107dffd8071b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615102007eucas1p1106f9520e2a86beb3792107dffd8071b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615102007eucas1p1106f9520e2a86beb3792107dffd8071b
References: <20220615101920.329421-1-p.raghav@samsung.com>
        <CGME20220615102007eucas1p1106f9520e2a86beb3792107dffd8071b@eucas1p1.samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
uses either native append or append emulation and it is called before the
endio of the target. But target endio can still update the clone bio
after dm_zone_endio is called, thereby, the orig bio does not contain
the updated information anymore. Call dm_zone_endio for zoned devices
after calling the target's endio function

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
@Damien and @Hannes: I couldn't come up with a testcase that uses endio callback and
zone append or append emulation for zoned devices to test for
regression in this change. It would be great if you can suggest
something. This change is required for the npo2 target as we update the
clone bio sector in the endio callback function and the orig bio should
be updated only after the endio callback for zone appends.

 drivers/md/dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3f17fe1de..3a74e1038 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1025,10 +1025,6 @@ static void clone_endio(struct bio *bio)
 			disable_write_zeroes(md);
 	}
 
-	if (static_branch_unlikely(&zoned_enabled) &&
-	    unlikely(blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))))
-		dm_zone_endio(io, bio);
-
 	if (endio) {
 		int r = endio(ti, bio, &error);
 		switch (r) {
@@ -1057,6 +1053,10 @@ static void clone_endio(struct bio *bio)
 		}
 	}
 
+	if (static_branch_unlikely(&zoned_enabled) &&
+	    unlikely(blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))))
+		dm_zone_endio(io, bio);
+
 	if (static_branch_unlikely(&swap_bios_enabled) &&
 	    unlikely(swap_bios_limit(ti, bio)))
 		up(&md->swap_bios_semaphore);
-- 
2.25.1

