Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8915889BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbiHCJsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbiHCJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:48:16 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00082A24F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:48:14 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094812euoutp0115a1ae785b078c71c0f10fbb39068869~HzLtjCxRp3207932079euoutp01m
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:48:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220803094812euoutp0115a1ae785b078c71c0f10fbb39068869~HzLtjCxRp3207932079euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659520092;
        bh=2l9t4o2MFdGXGYEr9szOD+OY2x6nysmCjdo7iJiFJ2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oygDXWXdhS5//5n2wO4kaUTElYy+b38a8qHOU23nThmJMR9cq/3X8k1Kz57eWzmsW
         iu+b9ApTpHw/EDpdjn4X5Z8HGHM/Zi+5a1F+UwU/TTj2D8UlhT87sVoZPEAQzVotw3
         NJrLRn77cxVh2Rortwa4kZvN4/CTzQOnyuOB8W4g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220803094810eucas1p13ef520e51d3ca7b5822a11e2d1d1af1b~HzLrqKrSc1447714477eucas1p1G;
        Wed,  3 Aug 2022 09:48:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 11.06.10067.A544AE26; Wed,  3
        Aug 2022 10:48:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220803094810eucas1p1304a82ba94d0265c3f6a8a371e5127a7~HzLq8-nPY3109731097eucas1p1S;
        Wed,  3 Aug 2022 09:48:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220803094810eusmtrp2d87915093087080592522be7fa4346e1~HzLq8LrDT0972009720eusmtrp2d;
        Wed,  3 Aug 2022 09:48:10 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-4c-62ea445afc23
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 10.EB.09095.9544AE26; Wed,  3
        Aug 2022 10:48:09 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220803094809eusmtip1d73b9053f698e1f43a7bd40d4f7d177b~HzLqlR4Nk2555925559eusmtip1j;
        Wed,  3 Aug 2022 09:48:09 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v9 07/13] zonefs: allow non power of 2 zoned devices
Date:   Wed,  3 Aug 2022 11:47:55 +0200
Message-Id: <20220803094801.177490-8-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7pRLq+SDA6c0LVYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlfFg
        QmJBi2DFij/VDYyT+LoYOTkkBEwkjq34xdrFyMUhJLCCUeLY34VQzhdGiZf/PzFBOJ8ZJT71
        rmeFabnz6jUzRGI5o8TN7n0sIAkhgZeMEl3zKrsYOTjYBLQkGjvZQWpEBJoZJe7+7QEbyyxw
        gEni5pZbTCANwgIuEn+2/WAEsVkEVCUeTnkJNohXwEri8aVfjBDb5CVmXvrODmJzClhLTPn3
        jxmiRlDi5MwnYPXMQDXNW2eDXSQhsJ1T4u2OdWwQzS4SXSueQdnCEq+Ob2GHsGUk/u+czwRh
        V0s8vfEbqrmFUaJ/53o2kBckgLb1nckBMZkFNCXW79KHKHeUWD77HhNEBZ/EjbeCECfwSUza
        Np0ZIswr0dEmBFGtJLHz5xOopRISl5vmsEDYHhKdv/6zTGBUnIXkmVlInpmFsHcBI/MqRvHU
        0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwHR4+t/xLzsYl7/6qHeIkYmD8RCjBAezkgjvHZfn
        SUK8KYmVValF+fFFpTmpxYcYpTlYlMR5kzM3JAoJpCeWpGanphakFsFkmTg4pRqYmnd1eUTu
        2+z6Tq2totb4/C8P7+6Af7NmzOsoY3SR5Crrj7L72dCnbqAa2OVQvM1tnsUp/X/hlqF/Xm6T
        ORrgE6x/rHWHNreHRueKxYn8mktCt1xoz1Y9xrqwWqJz1+pL91jXn1u/UmB2uaWpWfUFa7lF
        ma91jOZu/5524dPWxe6HezfM+NTNmsZat+jnjL9RRRG7rmstvuZcZxulXyKflKihUn/ywI77
        k58uWLCqeGn8ElZm+w2q/MVF3qaTfs75cdC3dybjJEuPyL+5B9st/VzO1GVrMXydbMSR2vOL
        j+0Zy7OI9w+ELnnvMA7bKv9MOW/zkq3Gz+7M9j3C3823JkQ+UaKaK+G2Rahynr0SS3FGoqEW
        c1FxIgA9FYvp9gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7qRLq+SDJ5csLFYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/FgQmJBi2DFij/VDYyT+LoYOTkk
        BEwk7rx6zdzFyMUhJLCUUWLr4elsEAkJidsLmxghbGGJP9e62CCKnjNKXO/fBNTBwcEmoCXR
        2MkOEhcR6GaUuHzmHCuIwyxwjkliztMHYJOEBVwk/mz7ATaJRUBV4uGUlywgNq+AlcTjS7+g
        NshLzLz0nR3E5hSwlpjy7x8ziC0EVLPu7yxWiHpBiZMzn4D1MgPVN2+dzTyBUWAWktQsJKkF
        jEyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAmN327Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRHe
        Oy7Pk4R4UxIrq1KL8uOLSnNSiw8xmgLdPZFZSjQ5H5g88kriDc0MTA1NzCwNTC3NjJXEeT0L
        OhKFBNITS1KzU1MLUotg+pg4OKUamGKr9Wa18c/aqVT53lNYiv2J/k6Pdub/U6MuhG9fpddu
        cXvW1+O787ZEn16pvysqhzHBpnOhdFBW1vVzi40eMRn4bo2I1DLfdEPv4FPfxdrzTXpKt5+L
        qLOKqz8189mLROUwdelniXO53iqs89h8L+S6u/qZTPUMhcLw/Qzaq02n/wtOO3X5tPGFuPTZ
        9zSnsrl929M82XfWtB+3+/p69/1fGDIv5a3OrXm+bFbvNLiUllbKb//Q8/WayKscsY0fhW0y
        gxKuM3BJWPOxVqocn7cgeZfQdhOO4w9lt0SueRb6K2mRWc+u+LI/XGxmoremL2hzCpihvGfn
        6wPrXWfN4VgkPfHb7ScPf6fOsT+lma7EUpyRaKjFXFScCAAFxu0AZgMAAA==
X-CMS-MailID: 20220803094810eucas1p1304a82ba94d0265c3f6a8a371e5127a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094810eucas1p1304a82ba94d0265c3f6a8a371e5127a7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094810eucas1p1304a82ba94d0265c3f6a8a371e5127a7
References: <20220803094801.177490-1-p.raghav@samsung.com>
        <CGME20220803094810eucas1p1304a82ba94d0265c3f6a8a371e5127a7@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zone size shift variable is useful only if the zone sizes are known
to be power of 2. Remove that variable and use generic helpers from
block layer to calculate zone index in zonefs.

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/zonefs/super.c  | 6 ++----
 fs/zonefs/zonefs.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 860f0b1032c6..e549ef16738c 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -476,10 +476,9 @@ static void __zonefs_io_error(struct inode *inode, bool write)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
-	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	unsigned int noio_flag;
 	unsigned int nr_zones =
-		zi->i_zone_size >> (sbi->s_zone_sectors_shift + SECTOR_SHIFT);
+		bdev_zone_no(sb->s_bdev, zi->i_zone_size >> SECTOR_SHIFT);
 	struct zonefs_ioerr_data err = {
 		.inode = inode,
 		.write = write,
@@ -1401,7 +1400,7 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	int ret = 0;
 
-	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
+	inode->i_ino = bdev_zone_no(sb->s_bdev, zone->start);
 	inode->i_mode = S_IFREG | sbi->s_perm;
 
 	zi->i_ztype = type;
@@ -1776,7 +1775,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	 * interface constraints.
 	 */
 	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
-	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
 	sbi->s_uid = GLOBAL_ROOT_UID;
 	sbi->s_gid = GLOBAL_ROOT_GID;
 	sbi->s_perm = 0640;
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 4b3de66c3233..39895195cda6 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -177,7 +177,6 @@ struct zonefs_sb_info {
 	kgid_t			s_gid;
 	umode_t			s_perm;
 	uuid_t			s_uuid;
-	unsigned int		s_zone_sectors_shift;
 
 	unsigned int		s_nr_files[ZONEFS_ZTYPE_MAX];
 
-- 
2.25.1

