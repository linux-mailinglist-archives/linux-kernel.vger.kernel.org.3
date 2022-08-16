Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B12595D06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbiHPNQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiHPNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:15:50 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A45606B1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:15:47 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131546euoutp022a824d1ecf39739c1312f17891acef07~L1ZpXl26P2682726827euoutp02T
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:15:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220816131546euoutp022a824d1ecf39739c1312f17891acef07~L1ZpXl26P2682726827euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660655746;
        bh=hLglEsgs8ISJExGYQKv645MJDunEKMqaZXVaT8ARNsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8wPgQykHSBDfVQ2FnbeDy8kGcXDbZZLNSeoEK2iCUmQNpuLey9dlBwIL3LdpVA0m
         SFDxtiuDM9fPhZgHi630I8mNrYy024RH5mAPdUYRmWhIp4YzSmAlrAHSNIaCZU22Dd
         Xor9tswrDh5Fr7iIle9+KDqa+LuqWhRijX2VfQPo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220816131544eucas1p1c7b76e9abfcb2527a22590b7422d8bd8~L1ZniRo5z0141101411eucas1p1d;
        Tue, 16 Aug 2022 13:15:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7D.B7.10067.0889BF26; Tue, 16
        Aug 2022 14:15:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220816131544eucas1p24ce643970cc92636f9a42d24318ab051~L1ZnFOs7k0840008400eucas1p2D;
        Tue, 16 Aug 2022 13:15:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220816131544eusmtrp2f8b1f32559139fb423d630ae9a462c5b~L1ZnEb6z20621306213eusmtrp2K;
        Tue, 16 Aug 2022 13:15:44 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-17-62fb988086f5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4F.21.09038.F789BF26; Tue, 16
        Aug 2022 14:15:43 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816131543eusmtip13e675433a03a18e2d4a1a377f709840f~L1ZmySYCa2694326943eusmtip1B;
        Tue, 16 Aug 2022 13:15:43 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v11 06/13] null_blk: allow zoned devices with non power-of-2
 zone sizes
Date:   Tue, 16 Aug 2022 15:15:29 +0200
Message-Id: <20220816131536.189406-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7oNM34nGRw+KWWx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK2PW
        7r/MBcelKx7O+8/ewLhcvIuRk0NCwETi9d4PzF2MXBxCAisYJZYsuMoK4XxhlLh+dBkjhPOZ
        UeLJrh3sMC3z5vazQySWM0pMn3UcynnBKDGt5yRLFyMHB5uAlkRjJ1iDiEC6xJSWlywgNcwC
        d5gkTr3byg5SIywQKdF61wWkhkVAVWLn7ftg9bwCVhIbPn5jhlgmLzHz0newOKeAtcS/hlUs
        EDWCEidnPgGzmYFqmrfOBvtBQmA7p8SHGcehLnWReHj0HROELSzx6vgWqLiMxP+d86Hi1RJP
        b/yGam5hlOjfuZ4N5DgJoG19Z3JATGYBTYn1u/Qhoo4SzyZmQph8EjfeCkJcwCcxadt0Zogw
        r0RHmxDEbCWJnT+fQO2UkLjcNIcFwvaQePV1CdMERsVZSH6ZheSXWQhrFzAyr2IUTy0tzk1P
        LTbKSy3XK07MLS7NS9dLzs/dxAhMh6f/Hf+yg3H5q496hxiZOBgPMUpwMCuJ8Aq++JEkxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnDc5c0OikEB6YklqdmpqQWoRTJaJg1OqgUnv7JUZ739+Sdwy
        74n219CkSnvW5UHau6KsrznNWZA+d/1GIcOZTwX+vT9lubXCbAN/gfs9RoPzwRL8jUcE3XQO
        yuq1HTy5QT5io8Fqkb+PS5/bMUlHqLjNYJE+HseX/Pn7A1Gl1IxvN4M/ZHbo75mf2tDNlboh
        /OHdn7r2ml5ztRbPfLeAi/l91xuFdY29hkG6MswFLos57tUsKdocJbTJxdRFxNPceK/VO1sn
        HaOD+36pZG35feS56L//O15Ke95xvGneelhcsY1119uFTl9/NGpVLuFpvM3zaUu60ukzDC7L
        ZLJaFxyf7iHy4b5yfe3aA/s7ryedV9gS+X4/78xJ/6a/+OCkmunayqFQ8FWJpTgj0VCLuag4
        EQA8BTdV9gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7r1M34nGTxcbGGx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PW7r/MBcelKx7O+8/ewLhcvIuR
        k0NCwERi3tx+9i5GLg4hgaWMEstPbWCHSEhI3F7YxAhhC0v8udbFBlH0jFHi1M2fTF2MHBxs
        AloSjZ1g9SICuRKLlnWwgtQwC7xhkvgw/xMTSEJYIFzi9NZfLCA2i4CqxM7b98EaeAWsJDZ8
        /MYMsUBeYual72BxTgFriX8Nq8DqhYBq2o5dZoaoF5Q4OfMJWJwZqL5562zmCYwCs5CkZiFJ
        LWBkWsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYvduO/dyyg3Hlq496hxiZOBgPMUpwMCuJ
        8Aq++JEkxJuSWFmVWpQfX1Sak1p8iNEU6O6JzFKiyfnA9JFXEm9oZmBqaGJmaWBqaWasJM7r
        WdCRKCSQnliSmp2aWpBaBNPHxMEp1cC04pOd+c5Mlx2sK3bqCpoUz7gjt3Bbl3CCIvcXH2V1
        fde0OGata1veWXDJvDhT+lf8ZthT4WA5/rUfzXkcTh0KqBI3/nNQ5fBGV8HqjV9TngnaSIm+
        n7Lsw7Hln+y4qqfqH0vMfSFqPmP3Zj4Xrqs/Da6dbd8qnH1S5MPSgBL/tN41lxJvXtt1pNim
        wzlyWodpadXy2advyTq3ae926V1pL6e2+sdWoZhT+tvdCpkWr2uvczjJk2V/015qtulW05K5
        jjPs84+xnV7lIeV0adYO3eZNNaofO4uFz8x+kZYS3OIVtW9r4U9WnQrxvB4tTvVzggx3r72f
        2ufMHBkyKfLdpYUFygUVf6KEN4fc2avEUpyRaKjFXFScCAB9m4dPZwMAAA==
X-CMS-MailID: 20220816131544eucas1p24ce643970cc92636f9a42d24318ab051
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131544eucas1p24ce643970cc92636f9a42d24318ab051
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131544eucas1p24ce643970cc92636f9a42d24318ab051
References: <20220816131536.189406-1-p.raghav@samsung.com>
        <CGME20220816131544eucas1p24ce643970cc92636f9a42d24318ab051@eucas1p2.samsung.com>
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

Convert the power-of-2(po2) based calculation with zone size to be generic
in null_zone_no with optimization for po2 zone sizes.

The nr_zones calculation in null_init_zoned_dev has been replaced with a
division without special handling for po2 zone sizes as this function is
called only during the initialization and will not be invoked in the hot
path.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/null_blk/main.c     |  5 ++---
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/block/null_blk/zoned.c    | 18 +++++++++++-------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c451c477978f..f1e0605dee94 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1976,9 +1976,8 @@ static int null_validate_conf(struct nullb_device *dev)
 	if (dev->queue_mode == NULL_Q_BIO)
 		dev->mbps = 0;
 
-	if (dev->zoned &&
-	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
-		pr_err("zone_size must be power-of-two\n");
+	if (dev->zoned && !dev->zone_size) {
+		pr_err("Invalid zero zone size\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 94ff68052b1e..f63b6bed1bb3 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -83,6 +83,7 @@ struct nullb_device {
 	unsigned int imp_close_zone_no;
 	struct nullb_zone *zones;
 	sector_t zone_size_sects;
+	unsigned int zone_size_sects_shift;
 	bool need_zone_res_mgmt;
 	spinlock_t zone_res_lock;
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 55a69e48ef8b..015f6823706c 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -16,7 +16,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
-	return sect >> ilog2(dev->zone_size_sects);
+	if (dev->zone_size_sects_shift)
+		return sect >> dev->zone_size_sects_shift;
+
+	return div64_u64(sect, dev->zone_size_sects);
 }
 
 static inline void null_lock_zone_res(struct nullb_device *dev)
@@ -65,10 +68,6 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	sector_t sector = 0;
 	unsigned int i;
 
-	if (!is_power_of_2(dev->zone_size)) {
-		pr_err("zone_size must be power-of-two\n");
-		return -EINVAL;
-	}
 	if (dev->zone_size > dev->size) {
 		pr_err("Zone size larger than device capacity\n");
 		return -EINVAL;
@@ -86,9 +85,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
-	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
-		>> ilog2(dev->zone_size_sects);
 
+	if (is_power_of_2(dev->zone_size_sects))
+		dev->zone_size_sects_shift = ilog2(dev->zone_size_sects);
+	else
+		dev->zone_size_sects_shift = 0;
+
+	dev->nr_zones =	DIV_ROUND_UP_SECTOR_T(dev_capacity_sects,
+					      dev->zone_size_sects);
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
 				    GFP_KERNEL | __GFP_ZERO);
 	if (!dev->zones)
-- 
2.25.1

