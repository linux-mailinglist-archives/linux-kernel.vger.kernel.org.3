Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A8A5889C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbiHCJtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbiHCJsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:48:17 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BFF28701
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:48:15 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094814euoutp020cc076644ffd2d7c16fbd8e3f8281a0b~HzLvGFAG61921619216euoutp02R
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:48:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220803094814euoutp020cc076644ffd2d7c16fbd8e3f8281a0b~HzLvGFAG61921619216euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659520094;
        bh=U+KX/7RkSecAPwIXzvtRwzm9pxQhhVpd7PMWcY0qTgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=siqU5EGJaOXw8Z1NVqsiQzR5MZdcpT/P2zOKwTi249r3wjddiNJ9O2zkp6iHhfg5K
         puF4MtpNJPIJQ7zYNyxlNgfBUTQjWQooUYa8B6zK1GLbNKgV93CfnI+xbx+XMpitnf
         1zO8nvYHdlGBRLEUOxlNOGnSdWSx3bgcgTCkSUDY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220803094812eucas1p2bd850e62b8b1e5b102ce5cf367481d37~HzLti7ILc2471124711eucas1p2q;
        Wed,  3 Aug 2022 09:48:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.03.09580.C544AE26; Wed,  3
        Aug 2022 10:48:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220803094812eucas1p271cea804453d9dd379b919067fe5b154~HzLs1fMOB1615116151eucas1p26;
        Wed,  3 Aug 2022 09:48:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220803094812eusmtrp1a4c85857281fce3a66bd62cdfdd094cf~HzLs0miIg2000320003eusmtrp1c;
        Wed,  3 Aug 2022 09:48:12 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-27-62ea445c55ce
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A8.9B.09038.C544AE26; Wed,  3
        Aug 2022 10:48:12 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220803094811eusmtip2c6b37f361d28822a8c01f5e0fb4f3c34~HzLsg0_a31632116321eusmtip2w;
        Wed,  3 Aug 2022 09:48:11 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v9 09/13] dm-zone: use generic helpers to calculate offset
 from zone start
Date:   Wed,  3 Aug 2022 11:47:57 +0200
Message-Id: <20220803094801.177490-10-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87oxLq+SDI53GVusP3WM2WL13X42
        i2kffjJb/D57ntli77vZrBY3D+xkstizaBKTxcrVR5ksnqyfxWzxt+sek8XeW9oWl3fNYbOY
        v+wpu8WEtq/MFjcmPGW0+Ly0hd1izc2nLBYnbkk7CHlcvuLtsXPWXXaPy2dLPTat6mTz2Lyk
        3mP3zQY2j52t91k93u+7yubRt2UVo8fm09UenzfJebQf6GYK4InisklJzcksSy3St0vgyph9
        t42toJ+74vPL6cwNjBM5uxg5OSQETCQ+rW9l6mLk4hASWMEocWRTJyNIQkjgC6PEjH2xEInP
        jBKT975mhelofnuUESKxnFFi87ImVgjnJaNE/4oWoAwHB5uAlkRjJztIXESgmVHi7t8esCJm
        gQNMEje33GICGSUsECMx+dJJsH0sAqoSsx4vYwGxeQWsJa7Oa4daJy8x89J3dhCbEyg+5d8/
        ZogaQYmTM5+A1TMD1TRvnc0MskBCYDenxPx1cxghml0kuq5dYIewhSVeHd8CZctInJ7cwwJh
        V0s8vfEbqrkF6IWd69lAXpAA2tZ3JgfEZBbQlFi/Sx+i3FFi09kNTBAVfBI33gpCnMAnMWnb
        dGaIMK9ER5sQRLWSxM6fT6CWSkhcbpoDtdRD4uP85SwTGBVnIXlmFpJnZiHsXcDIvIpRPLW0
        ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwJZ7+d/zrDsYVrz7qHWJk4mA8xCjBwawkwnvH5XmS
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBiY/y/o4kfrb
        js2WsuJ8B4MfHfnr1F4vuTpSy+r62ffT1Tx6lzkZ6hxzLakS91oqMe2SfGBL6+eyXq/k3Sc6
        8t77F3oqlsiUxJolzFuwVOO8Vtv0J9XzVH+eEi7f9/5a4okEf7fbKT/mFO47ffSVrvN/ucUX
        Ex9K6r+11OffcfXLLfO3Xfa3drJu6+t34RCte/pj8/FGs7fmlTaVNtcvnj79VS6Ev//jM3sn
        btWYtjqFX4o3mOzuflq0OGDPxpnHpzR4VO29kdr5U2Gf/4YVsZwvt7/u07596PSkOt0ThZW/
        LWb0fqwNnr3xvt9e5vPc7QVCpY0nhYQT5e2yd+w8dNXa+674qd9lzBqiYcobbyuxFGckGmox
        FxUnAgBKj0DI+AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7oxLq+SDNp+M1usP3WM2WL13X42
        i2kffjJb/D57ntli77vZrBY3D+xkstizaBKTxcrVR5ksnqyfxWzxt+sek8XeW9oWl3fNYbOY
        v+wpu8WEtq/MFjcmPGW0+Ly0hd1izc2nLBYnbkk7CHlcvuLtsXPWXXaPy2dLPTat6mTz2Lyk
        3mP3zQY2j52t91k93u+7yubRt2UVo8fm09UenzfJebQf6GYK4InSsynKLy1JVcjILy6xVYo2
        tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy5h9t42toJ+74vPL6cwNjBM5uxg5
        OSQETCSa3x5l7GLk4hASWMooserDSzaIhITE7YVNjBC2sMSfa11sEEXPGSX+PrzH2sXIwcEm
        oCXR2MkOEhcR6GaUuHzmHCuIwyxwjkliztMHYJOEBaIkFj39zQxiswioSsx6vIwFxOYVsJa4
        Oq+dFWKDvMTMS9/ZQWxOoPiUf//A6oUErCTW/Z3FClEvKHFy5hOwXmag+uats5knMArMQpKa
        hSS1gJFpFaNIamlxbnpusZFecWJucWleul5yfu4mRmD8bjv2c8sOxpWvPuodYmTiYDzEKMHB
        rCTCe8fleZIQb0piZVVqUX58UWlOavEhRlOguycyS4km5wMTSF5JvKGZgamhiZmlgamlmbGS
        OK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA5Pj+jXduyYqpYi5BFtr7Nted+21X57+xfnOpnpL
        b02/sWnrAUfRaZcOM10V+HtAt/xpwcyEm1/5uCd/+i6j/bP09O070T/O1//b0XhaOG9FwsPo
        TzlOmpd0L9ucCdOuF33Be3tbR+ryoD3827gvMqw3s+dd0zTr/IRrD9xP9llMUdDkjkm+VChe
        WfJ4kfXSnkjxi8V+W4pM8z5d6Oi4Fel+vrXBI+L55+Xns+6pddff8lrPvfX/psVdPvO3rArf
        d6xP227fNL92xyTfO47Pp6pEzpR+45N8afOdhavPTeh8fUYj/F6c6u2G0/cWulbzTE57ezv+
        2EoJR8813l+tv6n+ONj57WvGOtV1vbxnTU6EKbEUZyQaajEXFScCAPgIuAloAwAA
X-CMS-MailID: 20220803094812eucas1p271cea804453d9dd379b919067fe5b154
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094812eucas1p271cea804453d9dd379b919067fe5b154
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094812eucas1p271cea804453d9dd379b919067fe5b154
References: <20220803094801.177490-1-p.raghav@samsung.com>
        <CGME20220803094812eucas1p271cea804453d9dd379b919067fe5b154@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/md/dm-zone.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 3dafc0e8b7a9..31c16aafdbfc 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -390,7 +390,9 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE:
 		/* Writes must be aligned to the zone write pointer */
-		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
+		if ((bdev_offset_from_zone_start(md->disk->part0,
+						 clone->bi_iter.bi_sector)) != zwp_offset)
+
 			return false;
 		break;
 	case REQ_OP_ZONE_APPEND:
@@ -602,11 +604,8 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
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

