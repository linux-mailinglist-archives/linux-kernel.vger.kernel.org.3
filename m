Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327C754C5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346933AbiFOKUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346840AbiFOKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:20:10 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8B84BFCB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:19:51 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220615101950euoutp02add5dd92f691c04357a34a295e3750a2~4xAV3yQ3K2915729157euoutp02V
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:19:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220615101950euoutp02add5dd92f691c04357a34a295e3750a2~4xAV3yQ3K2915729157euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655288390;
        bh=zCtvccOkeF161CZuc2mF7+nuN0EZElrN97XeueFslLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1hduzeUsFJ+qq5V9gzUEOZ6PWjuD/4fWegw7Gf89yGB2p5QL1xoS3r1sxjBoTNdf
         Cl4q6TcJjp5k0CYIksrLWtTtX6OVSl5t3dl3mvwug6Ap57of/F4p2ccUo/OWOa15Q5
         RFop/cBO21RgjxB9JRU3mNzSsVnisxEM2rWpBxng=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220615101948eucas1p2db62e1a1d72812c89f83ad4da9df0d80~4xAUIacym1910819108eucas1p2s;
        Wed, 15 Jun 2022 10:19:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C4.77.10067.442B9A26; Wed, 15
        Jun 2022 11:19:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220615101948eucas1p2d8d801735c39b25256a019134adb0c6f~4xATjX3Rj2114221142eucas1p2W;
        Wed, 15 Jun 2022 10:19:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615101948eusmtrp2a7a7cca347d91d529dfe7e6734f73b3f~4xATiefYB0361403614eusmtrp2f;
        Wed, 15 Jun 2022 10:19:48 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-93-62a9b2444355
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 58.55.09095.442B9A26; Wed, 15
        Jun 2022 11:19:48 +0100 (BST)
Received: from localhost (unknown [106.210.248.244]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220615101947eusmtip13c89af2230fa641d50955a11bfcf71c9~4xASsSOCP1144211442eusmtip1M;
        Wed, 15 Jun 2022 10:19:47 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hch@lst.de, snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v7 07/13] zonefs: allow non power of 2 zoned devices
Date:   Wed, 15 Jun 2022 12:19:14 +0200
Message-Id: <20220615101920.329421-8-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615101920.329421-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7djP87oum1YmGby7aGKx+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
        aVtc3jWHzWL+sqfsFjcmPGW0+Ly0hd1izc2nLBZtG78yOgh7XL7i7fHvxBo2j52z7rJ7XD5b
        6rFpVSebx8KGqcwem5fUe+y+2QCUa73P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZ
        AvijuGxSUnMyy1KL9O0SuDI+LNjAWLBboOLYmg7GBsbzvF2MnBwSAiYSx2a8ZOti5OIQEljB
        KPFk3ioWCOcLo8SSO/fZIZzPjBLbXx5n7WLkAGs53ysMEV/OKPFu2TKo9peMEmtfnGYBKWIT
        0JJo7GQHWSEiEC5xdM89JhCbWaCPWeLJyzoQW1jAReLN3a1gNSwCqhLnd+1mBrF5Bawkfh37
        yARxnrzEzEvfwWo4BawldszuYYWoEZQ4OfMJC8RMeYnmrbOZQW6QELjEKdF1fgEbRLOLRNus
        f6wQtrDEq+Nb2CFsGYn/O+dDLaiWeHrjN1RzC6NE/871bBBfWkv0nckBMZkFNCXW79KHKHeU
        2DbzFVQFn8SNt4IQJ/BJTNo2nRkizCvR0SYEUa0ksfPnE6ilEhKXm+awQJR4SJxpKZ/AqDgL
        yS+zkPwyC2HtAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIFp8/S/4192MC5/9VHv
        ECMTB+MhRgkOZiURXrPglUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YW
        pBbBZJk4OKUamCo2sG+Z1Xm0J+Dvg81vmUpVbn+rt3z8aXv38401S7zi3DZ/yay8O4tPM/eM
        pu6Gt3reYcFC+Sa9wpFli6t7I/6oTTvO7Xd4+m/ubWlnFfPLF3KlP/vuc2e7I4PopPaCndxp
        qZFt01azGyjsOnqydvvSHMnem8U9P2wfqXjMPLWq8cxUN7Mib+u2qXc9V5zWiPg77a7G7iMz
        Piw4tlDu0ekLWls81j19vGUd57HWOdfSt8RnrfmTfmrO35Sl+YWxOw7L1qw/b/DsUoTY3l0b
        qxeIrBW7xlejd+xVmHzW2bozldO6Z6/Rihc5Od1y1+HrnWUnrn9p6Tnr71U6TYv5mJ+2y8NP
        Mss8us2tjTpq5H8rsRRnJBpqMRcVJwIA1xcFgAoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsVy+t/xu7oum1YmGXQuF7BYfbefzWLah5/M
        Fr/Pnme22PtuNqvFhR+NTBY3D+xkstizaBKTxcrVR5ksnqyfxWzRc+ADi8XfrntAsZaHQMW3
        tC0u75rDZjF/2VN2ixsTnjJafF7awm6x5uZTFou2jV8ZHYQ9Ll/x9vh3Yg2bx85Zd9k9Lp8t
        9di0qpPNY2HDVGaPzUvqPXbfbADKtd5n9Xi/7yqbR9+WVYwe67dcZfHYfLra4/MmOY/2A91M
        AfxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkf
        FmxgLNgtUHFsTQdjA+N53i5GDg4JAROJ873CXYxcHEICSxklVh3bz97FyAkUl5C4vbCJEcIW
        lvhzrYsNoug5o8SHnSuYQJrZBLQkGjvB6kUEoiU6b74Hq2EWWMAscfrOBLCEsICLxJu7W8Fs
        FgFVifO7djOD2LwCVhK/jn1kglggLzHz0newGk4Ba4kds3tYQeYLAdXsehcPUS4ocXLmExYQ
        mxmovHnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERjj24793LyD
        cd6rj3qHGJk4GA8xSnAwK4nwmgWvTBLiTUmsrEotyo8vKs1JLT7EaAp09kRmKdHkfGCSySuJ
        NzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYDp6wkLb9f5ri9yV76b9
        TbxxUqXM4NWmt6aqr/fdSV1wbHWzrv+tqUyBO/+pJSXsuvA+/sAjb+EFL8t6S6sKVspezrr5
        0W5bzosEMwPxMx08q2bfkysXmpnOyPp5xn6r2756F4T3OrzcX894YL9o1IR+LxHhWK60wEf6
        W2VE+2938U7JfqVitk989pqNSjFlrsnlTZ2hzfNmc829/fuaaHKYtZ/n8pqp1wKX81Wfuchh
        t9DT6vlm456WD4cqMw5U/Z48pULVoPGf9jFnthdrqr+v387JvXaBZ2POgh7B+bGTPj6pW6c7
        6aStIbdkgjSPB3fbi949j9ncNTk0z+/7ud0oacb+Bwo7z9jN9cwxaFZiKc5INNRiLipOBAA/
        +S8iegMAAA==
X-CMS-MailID: 20220615101948eucas1p2d8d801735c39b25256a019134adb0c6f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615101948eucas1p2d8d801735c39b25256a019134adb0c6f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615101948eucas1p2d8d801735c39b25256a019134adb0c6f
References: <20220615101920.329421-1-p.raghav@samsung.com>
        <CGME20220615101948eucas1p2d8d801735c39b25256a019134adb0c6f@eucas1p2.samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/zonefs/super.c  | 6 ++----
 fs/zonefs/zonefs.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index cc6d4cf58..0b737c2fb 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -485,10 +485,9 @@ static void __zonefs_io_error(struct inode *inode, bool write)
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
@@ -1410,7 +1409,7 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	int ret = 0;
 
-	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
+	inode->i_ino = bdev_zone_no(sb->s_bdev, zone->start);
 	inode->i_mode = S_IFREG | sbi->s_perm;
 
 	zi->i_ztype = type;
@@ -1787,7 +1786,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	 * interface constraints.
 	 */
 	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
-	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
 	sbi->s_uid = GLOBAL_ROOT_UID;
 	sbi->s_gid = GLOBAL_ROOT_GID;
 	sbi->s_perm = 0640;
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 4b3de66c3..39895195c 100644
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

