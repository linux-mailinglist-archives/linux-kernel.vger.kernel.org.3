Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9048758FE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiHKOb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbiHKOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:30:57 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E696D57E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:30:56 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143054euoutp01428d72f895b5b511e3130c5ff4d252b8~KUM0iaQbN2304723047euoutp013
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:30:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220811143054euoutp01428d72f895b5b511e3130c5ff4d252b8~KUM0iaQbN2304723047euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660228254;
        bh=2l9t4o2MFdGXGYEr9szOD+OY2x6nysmCjdo7iJiFJ2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rL6jnRl1RMdh3/OcTJNYgtkjrKa/B5ReWGPLRdxP4VNAdBgv4P/lS3zr7paoVy+LW
         SsXL8DRqqQ2ru+0GEbn1E5YA00ajFP+MwMl9zXgYN8fjChKkyD7nV9EMguXe0sv1bH
         Vz0UJp8mCla8OZZe1ifiyBh5GstDQLy6sNc0veZc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220811143052eucas1p2c80d56c33b4de812a99a8a809f90fe79~KUMy-4N311006010060eucas1p24;
        Thu, 11 Aug 2022 14:30:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0F.8C.09580.C9215F26; Thu, 11
        Aug 2022 15:30:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220811143052eucas1p1426fad3e5fd52fb93243e5daaf06ce7d~KUMydxxFi1847718477eucas1p1G;
        Thu, 11 Aug 2022 14:30:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220811143052eusmtrp193c0c83557bdec3951e0c1358968aa6b~KUMydATEu2320623206eusmtrp1i;
        Thu, 11 Aug 2022 14:30:52 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-b8-62f5129ca67a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 96.10.09038.C9215F26; Thu, 11
        Aug 2022 15:30:52 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220811143052eusmtip1613c100c3ae3a1505b311b2c49a57eae~KUMyHr7H62339723397eusmtip1I;
        Thu, 11 Aug 2022 14:30:52 +0000 (GMT)
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
Subject: [PATCH v10 07/13] zonefs: allow non power of 2 zoned devices
Date:   Thu, 11 Aug 2022 16:30:37 +0200
Message-Id: <20220811143043.126029-8-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811143043.126029-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djP87pzhL4mGVw7aW6x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK+PB
        hMSCFsGKFX+qGxgn8XUxcnJICJhIvO9YxgRiCwmsYJT4u4eni5ELyP7CKPH58iVmCOczo8Ss
        5qvsMB1vL65hgUgsZ5RYNHc+VNULRolHZx4wdjFycLAJaEk0doI1iAikS6xfsBysgVngDpPE
        93s9bCAJYQFXiZsTTjCD2CwCqhK//i1nBbF5Bawk3h66zAqxTV5i5qXvYIM4BawlJiy6yARR
        IyhxcuYTFhCbGaimeetssCMkBLZzStw/tJEZotlFYt+sK4wQtrDEq+NboF6QkTg9uYcFwq6W
        eHrjN1RzC6NE/871bCAfSABt6zuTA2IyC2hKrN+lD1HuKPFy4TkmiAo+iRtvBSFO4JOYtG06
        M0SYV6KjTQiiWkli588nUEslJC43zYFa6iFxrf0p4wRGxVlInpmF5JlZCHsXMDKvYhRPLS3O
        TU8tNs5LLdcrTswtLs1L10vOz93ECEyGp/8d/7qDccWrj3qHGJk4GA8xSnAwK4nwli36nCTE
        m5JYWZValB9fVJqTWnyIUZqDRUmcNzlzQ6KQQHpiSWp2ampBahFMlomDU6qBiUt0sdjV2BNF
        QvMce/inztmkWmawPqa4TnKzdmn11ILDH/8mMc/Yul/o3trC9q45k2bZT5ap5/muvfM333ox
        7dy8j/NbOlbq/f7Lsak27sJb/0+Clscn1dszK307uXXepdtZWUGWojtzjQ9ICTxReakjqLd+
        95m6eNfoOJcFJt0rvh+zDKjPFUtZLcmS+sRNuUF8sk/Qqw/XGHpEYoUXns9sqc18daS85fEN
        zcX7wnZPPbWDv882yDxp+9Vd96TiCzboGJuwVE9MMq/Kfi/f2PH6YtTOW+lri/dX2lxtL5W9
        /WfaTR3mJz4LfZcqevzk+8x/i70w2eg174d+ccfcX5d23rQyU342OfVf3KdPSizFGYmGWsxF
        xYkAt0m9F/UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7pzhL4mGRx5yGex/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PBhMSCFsGKFX+qGxgn8XUxcnJI
        CJhIvL24hqWLkYtDSGApo8TbX1PZIBISErcXNjFC2MISf651sUEUPWOUeDd/JnsXIwcHm4CW
        RGMnmCkikCtx8EggSAmzwBsmic7re1hAeoUFXCVuTjjBDGKzCKhK/Pq3nBXE5hWwknh76DIr
        xHx5iZmXvrOD2JwC1hITFl1kArGFgGomdBxjh6gXlDg58wnYTGag+uats5knMArMQpKahSS1
        gJFpFaNIamlxbnpusZFecWJucWleul5yfu4mRmDcbjv2c8sOxpWvPuodYmTiYDzEKMHBrCTC
        W7boc5IQb0piZVVqUX58UWlOavEhRlOguycyS4km5wMTR15JvKGZgamhiZmlgamlmbGSOK9n
        QUeikEB6YklqdmpqQWoRTB8TB6dUA5N+c0e8vsDd/Tm690oEH85fNSdTUYwj7Dur67KG5Txu
        RpwpScGWp1S312mVnFlnn604eVlEyIsdzzZ+aPms1aXseuOmU2HeO/3n/EH7LGsy1ZL3ea3O
        r9jx7oXQZXv/wIl+GnP98k58DbIMWyi2p5V9xen83DirxbvO6bzc3adzuWHZg/2iAWlS3/UL
        X6yYmGsvaZV5489iaeneVY3Wj+5MTZDSEWNj//NuYuinLyL/J5RIdb/5ebnYNTcj9PDS9Wf/
        LBRfnpk56Y/4rfLHtxonJB4Q0juvf/vPkj3dBteibPLMuMWMm69eONX+tPOIxnu5iYwy8ZOq
        5/TaXC84o52yYrr5XuGiCvb7xzrf9yixFGckGmoxFxUnAgCnnBacZAMAAA==
X-CMS-MailID: 20220811143052eucas1p1426fad3e5fd52fb93243e5daaf06ce7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143052eucas1p1426fad3e5fd52fb93243e5daaf06ce7d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143052eucas1p1426fad3e5fd52fb93243e5daaf06ce7d
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143052eucas1p1426fad3e5fd52fb93243e5daaf06ce7d@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

