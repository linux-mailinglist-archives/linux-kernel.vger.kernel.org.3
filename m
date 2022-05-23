Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336D35313F3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbiEWQQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiEWQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:16:13 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6972B253
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:16:11 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220523161609euoutp01376fd4641debd8b349992678cc656cb5~xyB4iYOjH2128421284euoutp01M
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:16:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220523161609euoutp01376fd4641debd8b349992678cc656cb5~xyB4iYOjH2128421284euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653322570;
        bh=6J0Iplh4tce831c/jnAAFO2oDxaRYKcCTdK8i5OmHgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qDckSIGa/cFlamUbv5vQrGQOvCgQze8GvQNpREhc5AlZ5F/xqVK/ar9RB5eBqDBEY
         Z3rAy7mSp0ZPwbuwODfe7/X2MMf/HzWLzRHpRpDPLnt4ut0tnuConQO5pU7vrDkemB
         1p218aFCPtge7ADmARfEo+YkVTA6VP037MflH4Ko=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220523161608eucas1p143166bad2bfc87c8a63cae98d3176bc9~xyB2_9lVd1546315463eucas1p1P;
        Mon, 23 May 2022 16:16:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 37.7E.09887.843BB826; Mon, 23
        May 2022 17:16:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220523161607eucas1p2b6245eafb81dee3e2efbec3ab86a854d~xyB2jZFqS0957009570eucas1p2Y;
        Mon, 23 May 2022 16:16:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220523161607eusmtrp233ab159abe41b38a4d3ff39500eb5828~xyB2inzO30219402194eusmtrp2F;
        Mon, 23 May 2022 16:16:07 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-16-628bb3482653
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FA.92.09522.743BB826; Mon, 23
        May 2022 17:16:07 +0100 (BST)
Received: from localhost (unknown [106.210.248.20]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220523161607eusmtip2323c9d601f46486d915afc977081c585~xyB2MHWoU0812708127eusmtip2M;
        Mon, 23 May 2022 16:16:07 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, snitzer@redhat.com,
        damien.lemoal@opensource.wdc.com, hare@suse.de,
        Johannes.Thumshirn@wdc.com
Cc:     linux-nvme@lists.infradead.org, dm-devel@redhat.com,
        dsterba@suse.com, jiangbo.365@bytedance.com,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org, jaegeuk@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v5 3/7] nvme: zns: Allow ZNS drives that have non-power_of_2
 zone size
Date:   Mon, 23 May 2022 18:15:57 +0200
Message-Id: <20220523161601.58078-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523161601.58078-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djP87oem7uTDF4s5rdYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBZ7Fk1isli5+iiTxZP1s5gteg58YLH423WPyWLvLW2Ly7vmsFnM
        X/aU3eLGhKeMFp+XtrBbtG38yugg4PHvxBo2j8tnSz02repk89i8pN5j980GNo+drfdZPd7v
        u8rm0bdlFaPH+i1XWTw2n672+LxJzqP9QDdTAE8Ul01Kak5mWWqRvl0CV8bXiydYCq6IVly9
        vZ61gfGZYBcjJ4eEgInEupmTmLsYuTiEBFYwShzc9pkFJCEk8IVR4vQ0H4jEZ0aJeTNPscF1
        zJnKApFYzijx80MjG4TzglFiRv8exi5GDg42AS2Jxk52kLiIQCOjxPuj81hBHGaB2UwS5x5c
        YwUZJSwQIfHw0m4wm0VAVaJn1hx2EJtXwFJiYfMPVoh18hIzL30Hi3MKWElcv3qVDaJGUOLk
        zCdgtzID1TRvnQ32hITAak6JM/MvMUM0u0ise3kcapCwxKvjW9ghbBmJ/zvnM0HY1RJPb/yG
        am5hlOjfuZ4N5AUJAWuJvjM5ICazgKbE+l36EOWOEm1PJzNCVPBJ3HgrCHECn8SkbdOZIcK8
        Eh1tQhDVShI7fz6BWiohcblpDguE7SFxuf0j6wRGxVlInpmF5JlZCHsXMDKvYhRPLS3OTU8t
        NspLLdcrTswtLs1L10vOz93ECEyBp/8d/7KDcfmrj3qHGJk4GA8xSnAwK4nwbk/sSBLiTUms
        rEotyo8vKs1JLT7EKM3BoiTOm5y5IVFIID2xJDU7NbUgtQgmy8TBKdXA1CgV+trUNi5xhvIr
        4e0fftSdtNi0S/eg/O8fDzLOLJErizTzC3pgPTF7XmfWWzcB//wlG8/amkxc832a+qYCNcNm
        E/3fi4505y8JLfqZN2F7166DBdkN3UZNxl9vrenmLFntuWOrhZ3YQpPjYY2y/g1LX5r66x1m
        tWLZVsW4rFza5tjUzanLN5Y2b1r5uOrzg4kXS/9/vHunM6Py7GvRXwbVHyXc7wdclNTsuHyn
        dsvR9h6HI+Y+TWJOv+N/3ePY2bnv0RrjeZ1ex+S/TUzUn3lsZYzv1vjXRyN652yUC/j+aPqX
        WsGExu5J84NkX3t8X70vYmvK64f7tM93d8m//7lp/VKZn71zy77kXtbWsFFiKc5INNRiLipO
        BACvjWFD8AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7rum7uTDP7f1rFYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBZ7Fk1isli5+iiTxZP1s5gteg58YLH423WPyWLvLW2Ly7vmsFnM
        X/aU3eLGhKeMFp+XtrBbtG38yugg4PHvxBo2j8tnSz02repk89i8pN5j980GNo+drfdZPd7v
        u8rm0bdlFaPH+i1XWTw2n672+LxJzqP9QDdTAE+Unk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6R
        iaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbXiydYCq6IVly9vZ61gfGZYBcjJ4eEgInEujlT
        WboYuTiEBJYySqxeeoYFIiEhcXthEyOELSzx51oXG0TRM0aJz3snADkcHGwCWhKNnewgcRGB
        TkaJoytOgU1iFljOJPFyzWKwbmGBMIm7k/ezgdgsAqoSPbPmsIPYvAKWEgubf7BCbJCXmHnp
        O1icU8BK4vrVq2D1QkA1p9ZPgKoXlDg58wnYdcxA9c1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi
        3PTcYkO94sTc4tK8dL3k/NxNjMB43Xbs5+YdjPNefdQ7xMjEwXiIUYKDWUmEd3tiR5IQb0pi
        ZVVqUX58UWlOavEhRlOguycyS4km5wMTRl5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6Yklq
        dmpqQWoRTB8TB6dUA1Ou8GyW5w7e4U2MEbvZffiyuzc5c892XjyJWd90PxN3+2quz32Hfqa6
        F/X8+Trl24UnlyT1PE1XbYyZHLAr6pcf2/mr169/77uV8/7QwVe51TsPhpmLCc9afPQrX+Tr
        bVP/PS++ZNN9q7DzTKjhtgefu28V16a+v6viOVG+ceoBnqWreh73z1zXyJl60/Tcwa9q/pUb
        +J705756PVt2m2zPibXPJgsk3fx6zcZVt/2L2Hql5L1FIlPP31KukK9c5a56fZYME39SWW0U
        d/f+1ttrUyQWH364+/vcCB7GfbMdjv4Iz5/p22Ntbup8fdfm3Qevy0d/PaOz6d2l90xKMxOs
        lTb8bQl4tEZ+x4VO7nIOJZbijERDLeai4kQA/5ecNWADAAA=
X-CMS-MailID: 20220523161607eucas1p2b6245eafb81dee3e2efbec3ab86a854d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220523161607eucas1p2b6245eafb81dee3e2efbec3ab86a854d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220523161607eucas1p2b6245eafb81dee3e2efbec3ab86a854d
References: <20220523161601.58078-1-p.raghav@samsung.com>
        <CGME20220523161607eucas1p2b6245eafb81dee3e2efbec3ab86a854d@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the condition which disallows non-power_of_2 zone size ZNS drive
to be updated and use generic method to calculate number of zones
instead of relying on log and shift based calculation on zone size.

The power_of_2 calculation has been replaced directly with generic
calculation without special handling. Both modified functions are not
used in hot paths, they are only used during initialization &
revalidation of the ZNS device.

As rounddown macro from math.h does not work for 32 bit architectures,
round down operation is open coded.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/zns.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9f81beb4df4e..d92f937d5cb9 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	}
 
 	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
-	if (!is_power_of_2(ns->zsze)) {
-		dev_warn(ns->ctrl->device,
-			"invalid zone size:%llu for namespace:%u\n",
-			ns->zsze, ns->head->ns_id);
-		status = -ENODEV;
-		goto free_data;
-	}
 
 	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
@@ -128,8 +121,13 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
 				   sizeof(struct nvme_zone_descriptor);
 
+	/*
+	 * Division is used to calculate nr_zones with no special handling
+	 * for power of 2 zone sizes as this function is not invoked in a
+	 * hot path
+	 */
 	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(ns->disk) >> ilog2(ns->zsze));
+			 div64_u64(get_capacity(ns->disk), ns->zsze));
 
 	bufsize = sizeof(struct nvme_zone_report) +
 		nr_zones * sizeof(struct nvme_zone_descriptor);
@@ -182,6 +180,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	int ret, zone_idx = 0;
 	unsigned int nz, i;
 	size_t buflen;
+	u64 remainder = 0;
 
 	if (ns->head->ids.csi != NVME_CSI_ZNS)
 		return -EINVAL;
@@ -197,7 +196,11 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
 	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
 
-	sector &= ~(ns->zsze - 1);
+	/*
+	 * Round down the sector value to the nearest zone start
+	 */
+	div64_u64_rem(sector, ns->zsze, &remainder);
+	sector -= remainder;
 	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
 		memset(report, 0, buflen);
 
-- 
2.25.1

