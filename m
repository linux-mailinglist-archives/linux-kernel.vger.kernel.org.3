Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7077759E6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244676AbiHWQRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243516AbiHWQQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:16:27 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC09103C66
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:37:45 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220823121911euoutp023b0ecb9c7a988409344aa9ed5ae54137~N_JPqJO4C2224522245euoutp02K
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:19:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220823121911euoutp023b0ecb9c7a988409344aa9ed5ae54137~N_JPqJO4C2224522245euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661257151;
        bh=2l9t4o2MFdGXGYEr9szOD+OY2x6nysmCjdo7iJiFJ2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NyI5iLFTzybD/j3W+KjiAXkY5rh9LAJSDQIiFg5uHrKDzvqH4k0Gob519Zd+k6hPv
         Qu6qpDMIQnPVz4zPGDX92HkeAB4JVlJj9OVZgF+/GBUu4gbjUkjSG6NcnYyykH42gY
         nUCxQZOol1gEpJWh01XQkxK17Vk2s9KWsAMXo5KE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220823121909eucas1p2890b8b0b0d55aa9afc392a2cffc55cfa~N_JNsywfQ2415624156eucas1p2K;
        Tue, 23 Aug 2022 12:19:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5E.71.07817.DB5C4036; Tue, 23
        Aug 2022 13:19:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220823121909eucas1p16b613217afcb29c29d6149c2620c93b4~N_JNIXK_f1881118811eucas1p1L;
        Tue, 23 Aug 2022 12:19:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220823121909eusmtrp22f6243acddad4b04f9f38496fedca76e~N_JNHjxvZ2697126971eusmtrp2j;
        Tue, 23 Aug 2022 12:19:09 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-66-6304c5bd4d76
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 07.12.07473.CB5C4036; Tue, 23
        Aug 2022 13:19:08 +0100 (BST)
Received: from localhost (unknown [106.210.248.52]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220823121908eusmtip1e4f8549b7b6a639b4f98f48c588602e6~N_JMvqvoU0460904609eusmtip1T;
        Tue, 23 Aug 2022 12:19:08 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com, bvanassche@acm.org,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v12 07/13] zonefs: allow non power of 2 zoned devices
Date:   Tue, 23 Aug 2022 14:18:53 +0200
Message-Id: <20220823121859.163903-8-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823121859.163903-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djPc7p7j7IkG6z7pGSx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK+PB
        hMSCFsGKFX+qGxgn8XUxcnJICJhIvH3/h7mLkYtDSGAFo8TDQ5/ZQBJCAl8YJV4vzYNIfGaU
        2Dp5NhNMx7lTSxghEssZJc4t2M0C4bxglPi3sw+oioODTUBLorGTHaRBRCBd4uvXDYwgNrPA
        HSaJb9dzQWxhAVeJL48ngtWwCKhKrGu7xwxi8wpYSbw9/ZINYpm8xMxL38FqOAWsJeYtPcUI
        USMocXLmExaImfISzVtng70gIbCdU+L6iY1Ql7pIbFv+hRHCFpZ4dXwLO4QtI/F/53yommqJ
        pzd+QzW3MEr071zPBvKABNC2vjM5ICazgKbE+l36EOWOEkcb/jNBVPBJ3HgrCHECn8SkbdOZ
        IcK8Eh1tQhDVShI7fz6BWiohcblpDguE7SFxdNsmlgmMirOQPDMLyTOzEPYuYGRexSieWlqc
        m55abJSXWq5XnJhbXJqXrpecn7uJEZgKT/87/mUH4/JXH/UOMTJxMB5ilOBgVhLhrb7IkCzE
        m5JYWZValB9fVJqTWnyIUZqDRUmcNzlzQ6KQQHpiSWp2ampBahFMlomDU6qBSVAkz6Al7uyK
        k7u2ZjFFTM1T83nGoxb//d9nBwvdevnZ+ywjt+680Dox9M9r2ZWb+f73GMw9tS7Y9Wcu2wXT
        0+1nGNMT5jdFqXHmvc94Ivrq/RbOp98m9LblXH5ktdc6d0bh9i2Zy00Pstx+fbqt58SWziOV
        zydNivWe3fnEteBfRfbRpj3OZa4xH82PJc+QDd54wfjk3o/bPavKGKLC7ixhD91h2/u2symu
        efK1zTP7lx1VXcs0u+syc6XTkhALbrcdVU787jcbNVeXi4qttb6vrNXwsuzz6viobbvZZubP
        X7QvkPPZxCJJ/dXperbuSbLBt83mBiV181RwaU+e+K8kZP9hi6kSNgm9t3xvKrEUZyQaajEX
        FScCALSosC/0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xu7p7jrIkG7w7Y2qx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PBhMSCFsGKFX+qGxgn8XUxcnJI
        CJhInDu1hLGLkYtDSGApo0TXk+OsEAkJidsLmxghbGGJP9e62CCKnjFKvOuYxN7FyMHBJqAl
        0djJDlIjIpArcXjzBCaQGmaBN0wSR/+1gA0SFnCV+PJ4IlgRi4CqxLq2e8wgNq+AlcTb0y/Z
        IBbIS8y89B2shlPAWmLe0lNgi4WAaubf+sQGUS8ocXLmExYQmxmovnnrbOYJjAKzkKRmIUkt
        YGRaxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERi524793LyDcd6rj3qHGJk4GA8xSnAwK4nw
        Vl9kSBbiTUmsrEotyo8vKs1JLT7EaAp090RmKdHkfGDqyCuJNzQzMDU0MbM0MLU0M1YS5/Us
        6EgUEkhPLEnNTk0tSC2C6WPi4JRqYJJQl2Dvjrb027OuV9P0Do/t5/9nr+sut+EuubAqSm2r
        OG/g50nGnwNWhjKyeZ3ScFU2ublRkau0bNLHzNCjoi86qrttXUtW/X4tcnW35ovdBzZ9c/i8
        h91T86n+wzNlN28/nPmaV6PmpqYoz2emsm673zdCGc+a/Xz2Luht3azWPTPNli6+EeMd/POj
        lLSLyVb59vjvrrOemS3nf//f6fKc53z7A1dwT2Vq23Qy2/dV51LtaT31OxSkuZzTt24/Eq/8
        wXLjQd1PkjwGDFNOvtq74l5R1f1JxhpfssX3s2+0qHg+r4VHQ+xH97OjPCfSdneHfNwrl926
        41TuZY/vVhKLP7zwZOK4xCsxycBTXEeJpTgj0VCLuag4EQANjWn+ZQMAAA==
X-CMS-MailID: 20220823121909eucas1p16b613217afcb29c29d6149c2620c93b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220823121909eucas1p16b613217afcb29c29d6149c2620c93b4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121909eucas1p16b613217afcb29c29d6149c2620c93b4
References: <20220823121859.163903-1-p.raghav@samsung.com>
        <CGME20220823121909eucas1p16b613217afcb29c29d6149c2620c93b4@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

