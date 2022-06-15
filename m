Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B4054C5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347656AbiFOKUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347245AbiFOKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:20:14 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C94A4CD7B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:20:05 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220615102004euoutp028ef02006650993328bd4d2855bcb6a49~4xAiKzaiD2915629156euoutp02e
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:20:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220615102004euoutp028ef02006650993328bd4d2855bcb6a49~4xAiKzaiD2915629156euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655288404;
        bh=unj+wNyhFPITbvGE3viUqmlATeoyeQTs0Irz7fIV/Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTf5qxvvFEe70XZczzOJPcM6VytcO72qPzUt76sNS2kb0/FVGpNt781h+zud9DRGy
         nS+Vo/Za85Xz/VIl4pOQR5i/AAhGxKgSIm24N/sXufkV31+23GoNsl8ghiqPhR9OtH
         a1Jy6HrlEsgDd65pmkOtPnYA56/+x5JSeSzYiAh0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220615102001eucas1p14900ffba109adf1d6ad58fb31b6d3662~4xAgLQcWb1438314383eucas1p1Q;
        Wed, 15 Jun 2022 10:20:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0F.77.10067.152B9A26; Wed, 15
        Jun 2022 11:20:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220615102000eucas1p27720aaa3c309327b2b9a33c5f840f498~4xAfSu7uw2162921629eucas1p2v;
        Wed, 15 Jun 2022 10:20:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615102000eusmtrp2756cf6a4b8bd2122ff7819f99032710c~4xAfRraCL0349503495eusmtrp2N;
        Wed, 15 Jun 2022 10:20:00 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-ba-62a9b251a009
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EF.24.09038.052B9A26; Wed, 15
        Jun 2022 11:20:00 +0100 (BST)
Received: from localhost (unknown [106.210.248.244]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220615101959eusmtip1f228020010ced5b70c8bfdd433177605~4xAd8XbKh1152711527eusmtip1L;
        Wed, 15 Jun 2022 10:19:59 +0000 (GMT)
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
Subject: [PATCH v7 10/13] dm-table: use bdev_is_zone_start helper in
 device_area_is_invalid()
Date:   Wed, 15 Jun 2022 12:19:17 +0200
Message-Id: <20220615101920.329421-11-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615101920.329421-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7djPc7qBm1YmGfzar2ux+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
        aVtc3jWHzWL+sqfsFjcmPGW0+Ly0hd1izc2nLBZtG78yOgh7XL7i7fHvxBo2j52z7rJ7XD5b
        6rFpVSebx8KGqcwem5fUe+y+2QCUa73P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZ
        AvijuGxSUnMyy1KL9O0SuDLmNpxjL3jKVXGzbRlrA+Nlji5GTg4JAROJ6w/XsnUxcnEICaxg
        lFj+/BWU84VRYsXlDiYI5zOjxORZXcwwLV0vu5khEssZJXpvfoSqesko8ePfTqAMBwebgJZE
        Yyc7SIOIQLjE0T33mEBsZoE+ZoknL+tAbGGBeIlf61+CDWURUJX43XqfDcTmFbCWmHF0BjvE
        MnmJmZe+g9mcQPEds3tYIWoEJU7OfMICMVNeonnrbLCDJATOcUps3buGFaLZRWJz/xZGCFtY
        4tXxLVBDZST+75zPBGFXSzy98RuquYVRon/nejaQBySAtvWdyQExmQU0Jdbv0ocod5Q42r+H
        BaKCT+LGW0GIE/gkJm2bzgwR5pXoaBOCqFaS2PnzCdRSCYnLTXNYIGwPie9bjrBMYFScheSZ
        WUiemYWwdwEj8ypG8dTS4tz01GKjvNRyveLE3OLSvHS95PzcTYzA1Hn63/EvOxiXv/qod4iR
        iYPxEKMEB7OSCK9Z8MokId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzJmRsShQTSE0tSs1NTC1KL
        YLJMHJxSDUx8xxilJRfY+MUe+NwU9+W2N9O62j0fN2ccEO2Pls81D6k79WlG/uywF00MxvOX
        phXsza8QDKlqPcuSfX9T3/fzsg4+MVMcpF47T2yV2Fuf0dszPepls20a/9sdogFh3Rsn9f2o
        drJXb9RSPcvCX6m09E/U1/dTA3IlN852aXWpL735ICPs8gpWhUvzDz85deRu85rrO5c/6J+j
        vIlp+6ojTn7Bpp/fdFZME2m13rLhRmmhyUWXysLCsk5fo6VtGh8FN3ayq7oVTysUr5Jfm3hA
        58/f5Ttctl3gjnLO3T17h8GhaqOXDGxNhlbVjY5sT/z7/dgMvhcJz2joPvV3s9a+A7t8LRiC
        XZhPVql/VGIpzkg01GIuKk4EAC6w+6IMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xu7oBm1YmGVw8ZGCx+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
        aVtc3jWHzWL+sqfsFjcmPGW0+Ly0hd1izc2nLBZtG78yOgh7XL7i7fHvxBo2j52z7rJ7XD5b
        6rFpVSebx8KGqcwem5fUe+y+2QCUa73P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZ
        Avij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLm
        NpxjL3jKVXGzbRlrA+Nlji5GTg4JAROJrpfdzF2MXBxCAksZJWb27mKGSEhI3F7YxAhhC0v8
        udbFBlH0nFGieepiIIeDg01AS6Kxkx2kRkQgWqLz5nuwGmaBBcwSp+9MAEsIC8RKzN1/GGwo
        i4CqxO/W+2wgNq+AtcSMozPYIRbIS8y89B3M5gSK75jdwwoyX0jASmLXu3iIckGJkzOfsIDY
        zEDlzVtnM09gFJiFJDULSWoBI9MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwCjfduznlh2M
        K1991DvEyMTBeIhRgoNZSYTXLHhlkhBvSmJlVWpRfnxRaU5q8SFGU6CzJzJLiSbnA9NMXkm8
        oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDU8yDuaePFx5PLf7yYZ2m
        rdW2UIOnbKVf/nyvkHAXOcU652TvFIfAtkaD6HAPvw/c03zzdy+s077Dd+DMYtNSY9uZ5w3F
        V01plll91rF354KuK1bn2qL37Dtw4RNf1K7LptMVlGMDy4N5pGKEpJ5NX5PpclO1/vLlE3tt
        p3z/svZxveS6rw4Tm3RWHjPYUnntUFL/mS9OIjGTls5qMP/duEE3cWN4uOgJhh/JwiKJPIrH
        pN4JXOJc0CG05w774omn57zOjnrnsbzJbUIO+41ZNzqSmZ+eyMxizhJwll1rUVAg4mOxWzbw
        ZM2d1slW0X/3z0xfoiF1YF760Ygr0nJZkyTSHkzhVzVZJbz0lZ6HjxJLcUaioRZzUXEiAHgN
        WCd7AwAA
X-CMS-MailID: 20220615102000eucas1p27720aaa3c309327b2b9a33c5f840f498
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615102000eucas1p27720aaa3c309327b2b9a33c5f840f498
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615102000eucas1p27720aaa3c309327b2b9a33c5f840f498
References: <20220615101920.329421-1-p.raghav@samsung.com>
        <CGME20220615102000eucas1p27720aaa3c309327b2b9a33c5f840f498@eucas1p2.samsung.com>
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

Use bdev_is_zone_start() helper that uses generic calculation to check
for zone alignment instead of using po2 based alignment check.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/md/dm-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index bd539afbf..b553cdb6d 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -251,7 +251,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	if (bdev_is_zoned(bdev)) {
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
-		if (start & (zone_sectors - 1)) {
+		if (blk_queue_is_zone_start(bdev_get_queue(bdev), start)) {
 			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)start,
@@ -268,7 +268,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 		 * devices do not end up with a smaller zone in the middle of
 		 * the sector range.
 		 */
-		if (len & (zone_sectors - 1)) {
+		if (blk_queue_is_zone_start(bdev_get_queue(bdev), len)) {
 			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)len,
-- 
2.25.1

