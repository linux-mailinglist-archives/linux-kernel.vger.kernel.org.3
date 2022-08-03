Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A7B5889C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbiHCJtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiHCJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:48:18 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3560B2181A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:48:17 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094815euoutp023a5b3c20fa63a9b875e945ab7bc1eeed~HzLwTLUK-1891118911euoutp02c
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:48:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220803094815euoutp023a5b3c20fa63a9b875e945ab7bc1eeed~HzLwTLUK-1891118911euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659520095;
        bh=LaB+Gcs0Fh5BCcbxlSsyrDjt3gzj6lS2/soveVJgI0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a17qK5++bt00qdxR5RLJgG1drqy2pivmsMPUdcGHOgumS5VZNQB0XKUxDtW+DV6t3
         I9d8lzI0YbjHNqwA3pH5mlo/RQ/PdXrhnykRmqZG++Q3STRJBgw4q96e9DSrNt8eTd
         KhFZB2BVob2Y4x7o5PohQ27N/ElZlfYnubIrWUSI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220803094813eucas1p298cfe017fbfdca6d5c606989f4a95a2e~HzLucPuni2470524705eucas1p2s;
        Wed,  3 Aug 2022 09:48:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 37.03.09580.D544AE26; Wed,  3
        Aug 2022 10:48:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220803094813eucas1p2eab78901e97417ad52be1f8023db3d82~HzLt5TeNj2471024710eucas1p2t;
        Wed,  3 Aug 2022 09:48:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220803094813eusmtrp236987c6f523104e1e5ca3c0b8fa8741c~HzLt4bV-v0985709857eusmtrp2v;
        Wed,  3 Aug 2022 09:48:13 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-2a-62ea445daf58
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 93.EB.09095.D544AE26; Wed,  3
        Aug 2022 10:48:13 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220803094812eusmtip235cf51eca89103da97520a59ca801576~HzLtdCtG01623516235eusmtip2n;
        Wed,  3 Aug 2022 09:48:12 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v9 10/13] dm-table: allow zoned devices with non power-of-2
 zone sizes
Date:   Wed,  3 Aug 2022 11:47:58 +0200
Message-Id: <20220803094801.177490-11-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djPc7qxLq+SDNZ161isP3WM2WL13X42
        i2kffjJb/D57ntli77vZrBY3D+xkstizaBKTxcrVR5ksnqyfxWzxt+sek8XeW9oWl3fNYbOY
        v+wpu8WEtq/MFp+XtrBbrLn5lMXixC1pB0GPy1e8PXbOusvucflsqcemVZ1sHpuX1HvsvtnA
        5rGz9T6rx/t9V9k8+rasYvTYfLra4/MmOY/2A91MATxRXDYpqTmZZalF+nYJXBlfjvSwFFzk
        qXhw6SxbA2MnVxcjJ4eEgInEjnvN7F2MXBxCAisYJRZs74FyvjBKzLjWyArhfGaUWPTxFxNM
        S/u9OUwQieWMEvuOr4aqeskocadtL1sXIwcHm4CWRGMn2CgRgWZGibt/e8CKmAVmMEl0fOxj
        ARklLBAhceP8O7CxLAKqEldnbgSzeQWsJf5M28YGsU5eYual7+wgNidQfMq/f8wQNYISJ2c+
        AZvDDFTTvHU2M8gCCYHNnBIz+p4wQjS7SEz/9YkVwhaWeHV8CzuELSPxf+d8qH+qJZ7e+A3V
        3MIo0b9zPdgLEkDb+s7kgJjMApoS63fpQ5Q7SvycM40VooJP4sZbQYgT+CQmbZvODBHmleho
        E4KoVpLY+fMJ1FIJictNc1ggbA+Jew8ns05gVJyF5JlZSJ6ZhbB3ASPzKkbx1NLi3PTUYuO8
        1HK94sTc4tK8dL3k/NxNjMBUePrf8a87GFe8+qh3iJGJg/EQowQHs5II7x2X50lCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUamPrzZe99EFYvjbD1KHL5
        4LLVcMazPIUbIgoL9mn89jWbfb1kr3m7J5t81E+fjo+fzVs7ZHMWrf+YYRi1yPBlS8K6Px2y
        IQq/3x3KUbtSWfSJTaxgm8PC1Wu0dDWnuImqM29Pm3Li2J/ASfPeq+4qbXjj0f9hYbtWoHpr
        t+89Nv3Evd9XnNWv8mk4Nvt14crgmiPz0254/eaRu/GiTPjrAqE4JrYE4dsZkoppnPK/lU68
        u53AdjH/6Pv6GlGLuPKf2WtnSfxzuCX8reOiyIvz/1nVuX91nA35rnJ0w+uE6vJte+T2/mLb
        /urvKaee6xPXbYq8OEcsVs68+uzOj6fnrP0ep/9p7+b+eTc0f2w326vEUpyRaKjFXFScCABy
        XoX79AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7qxLq+SDNZP57FYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DK+HOlhKbjIU/Hg0lm2BsZOri5GTg4JAROJ
        9ntzmLoYuTiEBJYySsxau5gFIiEhcXthEyOELSzx51oXG0TRc0aJhjsHWLsYOTjYBLQkGjvZ
        QeIiAt2MEpfPnGMFcZgFljFJNH25zgZSJCwQJrH4exXIIBYBVYmrMzcygdi8AtYSf6ZtY4NY
        IC8x89J3dhCbEyg+5d8/ZhBbSMBKYt3fWawQ9YISJ2c+ATuOGai+eets5gmMArOQpGYhSS1g
        ZFrFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGLPbjv3cvINx3quPeocYmTgYDzFKcDArifDe
        cXmeJMSbklhZlVqUH19UmpNafIjRFOjuicxSosn5wKSRVxJvaGZgamhiZmlgamlmrCTO61nQ
        kSgkkJ5YkpqdmlqQWgTTx8TBKdXA1KNx4/0D7+4L58O0d9+y5FIq9Tdf0H5/Uh3XwZyyZ2q+
        F+ytfaevTj0Q/+nofN2QFdK2EbvKpKaUdWh6eQUG6va4HPqylYlv0tsAYPqaf8BY4OX5aRcd
        6hKsJnM9kOdPLjwpNvvoX0HNum3KZRPF63X3TOAM2LW/vO0pe6R46PHWoMdv01jK3OJuhiUk
        SAZ+yz1qpT3BbL7XwnCBw3uO3vteffT++y9Hm+t/VUqvVTz4UfyE448oNg/T6n+czMFrGCKd
        2L3/HnxjlPb18IXZH/IzH/X/W8L+QO3EweW8l48EO04tvGfINKNidtCMw0qbJ8Tvvax3b+5F
        u6lSJRem/mLR/C0dfnlS7JwgRlFpJZbijERDLeai4kQAvr79AmIDAAA=
X-CMS-MailID: 20220803094813eucas1p2eab78901e97417ad52be1f8023db3d82
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094813eucas1p2eab78901e97417ad52be1f8023db3d82
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094813eucas1p2eab78901e97417ad52be1f8023db3d82
References: <20220803094801.177490-1-p.raghav@samsung.com>
        <CGME20220803094813eucas1p2eab78901e97417ad52be1f8023db3d82@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow dm to support zoned devices with non power-of-2(po2) zone sizes as
the block layer now supports it.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-table.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 332f96b58252..31eb1d29d136 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -250,7 +250,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	if (bdev_is_zoned(bdev)) {
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
-		if (start & (zone_sectors - 1)) {
+		if (!bdev_is_zone_start(bdev, start)) {
 			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)start,
@@ -267,7 +267,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 		 * devices do not end up with a smaller zone in the middle of
 		 * the sector range.
 		 */
-		if (len & (zone_sectors - 1)) {
+		if (!bdev_is_zone_start(bdev, len)) {
 			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)len,
@@ -1642,8 +1642,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
 		return -EINVAL;
 	}
 
-	/* Check zone size validity and compatibility */
-	if (!zone_sectors || !is_power_of_2(zone_sectors))
+	if (!zone_sectors)
 		return -EINVAL;
 
 	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
-- 
2.25.1

