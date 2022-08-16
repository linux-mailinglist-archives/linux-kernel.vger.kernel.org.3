Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B08595D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiHPNQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbiHPNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:15:50 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1CF61734
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:15:48 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131547euoutp02cd8b98753a02dae2caf92eab74196c31~L1ZqZHwO32682526825euoutp02N
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:15:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220816131547euoutp02cd8b98753a02dae2caf92eab74196c31~L1ZqZHwO32682526825euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660655747;
        bh=2l9t4o2MFdGXGYEr9szOD+OY2x6nysmCjdo7iJiFJ2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgMRZtU2DkkDs7kBjuB0y+SrD21UrBtYAk5nAqcR/n7xykNigtyUpt9by5vYXNNEO
         aB4ipyR+zNUmXGr7TxN3kO+5t/U4b63zUdt2AUVUejCt/vIjQGOp1r0xh2LgTXMgNn
         DEcOWLIQ4x23tFXebZAOA+t96iLU2aVqLL5fUAMg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220816131545eucas1p28cf18191fdc6dd8930e5677125a18d3b~L1ZotJ89I1908319083eucas1p2h;
        Tue, 16 Aug 2022 13:15:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8F.65.09580.1889BF26; Tue, 16
        Aug 2022 14:15:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220816131545eucas1p2cc7e6aad76abbe106a695f7396d38344~L1ZoHANYT3098130981eucas1p2D;
        Tue, 16 Aug 2022 13:15:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220816131545eusmtrp2e20876f331f41415549ea0fe23d6a07a~L1ZoGO_zg0621306213eusmtrp2M;
        Tue, 16 Aug 2022 13:15:45 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-e6-62fb98813cd2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.31.09038.0889BF26; Tue, 16
        Aug 2022 14:15:44 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816131544eusmtip1d1134ed1ce5b864a51b18f04079f7d8b~L1ZnuzEBj2502525025eusmtip15;
        Tue, 16 Aug 2022 13:15:44 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v11 07/13] zonefs: allow non power of 2 zoned devices
Date:   Tue, 16 Aug 2022 15:15:30 +0200
Message-Id: <20220816131536.189406-8-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djP87qNM34nGRxdr26x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK+PB
        hMSCFsGKFX+qGxgn8XUxcnJICJhInL57gKWLkYtDSGAFo8TB8+dZQBJCAl8YJVY260MkPjNK
        3J52hwmmY9WDiWwQRcsZJV58c4IoesEo8aP1FlARBwebgJZEYyc7SI2IQLrElJaXYBuYBe4w
        SZx6txUsISzgKnFqz0NmEJtFQFXi9tQXYAt4BawkWs98Z4RYJi8x89J3sHpOAWuJfw2rWCBq
        BCVOznwCZjMD1TRvnc0MskBCYD2nxOW5F1lBjpAQcJG4dlgKYo6wxKvjW9ghbBmJ/zvnQz1T
        LfH0xm+o3hZGif6d69kgeq0l+s7kgJjMApoS63fpQ5Q7Siy+sJcdooJP4sZbQYgL+CQmbZvO
        DBHmlehoE4KoVpLY+fMJ1FIJictNc1ggbA+Jg/8/M01gVJyF5JdZSH6ZhbB3ASPzKkbx1NLi
        3PTUYuO81HK94sTc4tK8dL3k/NxNjMBEePrf8a87GFe8+qh3iJGJg/EQowQHs5IIr+CLH0lC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUamFw9In9dXGG0
        c/rD49H3Fbp2hJwpWXN1XSjDDl6h5EOV3t/j8j5bZD1wSq/nWzVxivj9+3Kzlid9al9v1x1+
        P33j8ZddbZ/Zm5sPSqb9jF0T86s6OT3HjPnHFq7ZMpPK5/6eqc/umHPR43BRzOO3zBcua9y9
        /Umrwv8ih8Bhr2Bhnp313ye2J0v/4dFveTkteXmG94Xuw0ZaFya6rjsS7HZ0XYGnHYeA/7H2
        J3z73U8f3eC0ZU9s5FxX3fn8ZhevfMh4uHfiadf83ROWNXs1xRt0LxNzuOCvuqLw5byqeS4b
        b3DMjn2Q3cmddJ9D5snVzbcOLw1d+k1VN9RDziFd4XrV13NRdjG2fMa1khP2xSixFGckGmox
        FxUnAgB5sQ0d8wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7qNM34nGXyLtVh/6hizxeq7/WwW
        0z78ZLb4ffY8s8Xed7NZLW4e2MlksWfRJCaLlauPMlk8WT+L2eJv1z0mi723tC0u75rDZjF/
        2VN2iwltX5ktbkx4ymjxeWkLu8Wam09ZLE7cknYQ8rh8xdtj56y77B6Xz5Z6bFrVyeaxeUm9
        x+6bDWweO1vvs3q833eVzaNvyypGj82nqz0+b5LzaD/QzRTAE6VnU5RfWpKqkJFfXGKrFG1o
        YaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8WBCYkGLYMWKP9UNjJP4uhg5OSQE
        TCRWPZjI1sXIxSEksJRR4u/pk4wQCQmJ2wuboGxhiT/XuqCKnjFKnPxzAMjh4GAT0JJo7GQH
        qRERyJVYtKyDFaSGWeANk8SH+Z+YQBLCAq4Sp/Y8ZAaxWQRUJW5PfQEW5xWwkmg98x1qgbzE
        zEvfwQZxClhL/GtYxQJiCwHVtB27zAxRLyhxcuYTsDgzUH3z1tnMExgFZiFJzUKSWsDItIpR
        JLW0ODc9t9hIrzgxt7g0L10vOT93EyMwbrcd+7llB+PKVx/1DjEycTAeYpTgYFYS4RV88SNJ
        iDclsbIqtSg/vqg0J7X4EKMp0N0TmaVEk/OBiSOvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUgg
        PbEkNTs1tSC1CKaPiYNTqoHJlmE+87pfaysvek3+oZJi+Oq0ml/oYbG3R0/9VRSqmtJ2elNP
        /6xwxY1rvN5nzAjcrPJpikKUxpZXQmosBvdm73t3e1KJUtyfTIVjvb+t4xpm75xz/eicvNIv
        aa8YoxJZj2b6/H1kdd3HQ/tk9zbtL7mPlQqFteL4Xz5gLe9T+pLWtILjG+v6h7/8Ha8qFIml
        7l3s1xwZuEn7vNFZIbktb0sMWhXmTjgpdLlE58PVhcL7xZoME15O4w9XzRRZ2ZShuW/qtMTN
        BwNlzrjdqf8/s1jmdfH2p0peWzcWRrh7mc1Vf5j4rjl439L9X/Yqp1U+vlLn3cDPfnfW5DeL
        BTijt/y5U3TqWpzaytrXZgZ8SizFGYmGWsxFxYkAbgLaMGQDAAA=
X-CMS-MailID: 20220816131545eucas1p2cc7e6aad76abbe106a695f7396d38344
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131545eucas1p2cc7e6aad76abbe106a695f7396d38344
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131545eucas1p2cc7e6aad76abbe106a695f7396d38344
References: <20220816131536.189406-1-p.raghav@samsung.com>
        <CGME20220816131545eucas1p2cc7e6aad76abbe106a695f7396d38344@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

