Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A7554C5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347383AbiFOKT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347136AbiFOKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:19:41 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF3F4B1F0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:19:38 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220615101937euoutp01a3b022be6e78314bab972f046cc3fbbb~4xAJrOOyQ2526325263euoutp01V
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:19:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220615101937euoutp01a3b022be6e78314bab972f046cc3fbbb~4xAJrOOyQ2526325263euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655288377;
        bh=n7XaZhjVWbFZ2/k/mWYQcCuMTNuq4erdEz+rKfQHKk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwyHqnqlJPQf1nvO27U1gKfsCWpKtuHmx0xz0C97JM3SN5IqTo7KS8ad55jj3Ooyn
         3uM7opMrgnvkznX2Q0vkiRYP7BNcAaa6aRHQ/GxMXpsgjap4Vg5TtefdtdFDBDR2su
         ZkL0e6CLygkBZDEq2FklkdAgLcMSavOV43o67iqY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220615101935eucas1p28855fe6444bf0d736a79f31c7e260f2e~4xAH-GRyc1132211322eucas1p2x;
        Wed, 15 Jun 2022 10:19:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 28.67.10067.732B9A26; Wed, 15
        Jun 2022 11:19:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220615101935eucas1p26a7bc245d88a89312158d7a265f64aef~4xAHQro9O1132211322eucas1p2w;
        Wed, 15 Jun 2022 10:19:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615101935eusmtrp25b8235c373fbcc302cd299295374e82b~4xAHPZ7Ei0361403614eusmtrp2B;
        Wed, 15 Jun 2022 10:19:34 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-6a-62a9b23727ab
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0B.14.09038.632B9A26; Wed, 15
        Jun 2022 11:19:34 +0100 (BST)
Received: from localhost (unknown [106.210.248.244]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220615101934eusmtip1d8b298e6c644ba681b491ec040203480~4xAGNVgnE1144211442eusmtip1H;
        Wed, 15 Jun 2022 10:19:34 +0000 (GMT)
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
Subject: [PATCH v7 03/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Date:   Wed, 15 Jun 2022 12:19:10 +0200
Message-Id: <20220615101920.329421-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615101920.329421-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7djPc7rmm1YmGcztNLJYfbefzWLah5/M
        Fr/Pnme22PtuNqvFhR+NTBY3D+xkstizaBKTxcrVR5ksnqyfxWzRc+ADi8XfrntAsZaHQMW3
        tC0u75rDZjF/2VN2ixsTnjJafF7awm6x5uZTFou2jV8ZHYQ9Ll/x9vh3Yg2bx85Zd9k9Lp8t
        9di0qpPNY2HDVGaPzUvqPXbfbADKtd5n9Xi/7yqbR9+WVYwe67dcZfHYfLra4/MmOY/2A91M
        AfxRXDYpqTmZZalF+nYJXBlzNm5jLfgtWvH4oFQDY4dQFyMnh4SAicSNe6uZuxi5OIQEVjBK
        XNy2iw3C+cIocWzCB3aQKiGBz4wST755wXScPvSGHaJoOaPErWdbWSGKXjJKzG4I7GLk4GAT
        0JJo7ATrFREIlzi65x4TiM0s0Mcs8eRlHYgtLBAl8eP9eTYQm0VAVeLpsXdgY3gFrCQmvVzF
        CLFLXmLmpe9gczgFrCV2zO6BqhGUODnzCQvETHmJ5q2zwT6QELjEKfHo53cmiGYXiaaefqhB
        whKvjm9hh7BlJP7vnA9VUy3x9MZvqOYWRon+nevZQB6QANrWdyYHxGQW0JRYv0sfotxR4vDh
        dmaICj6JG28FIU7gk5i0bTpUmFeiow0atkoSO38+gVoqIXG5aQ4LhO0hsezmdtYJjIqzkDwz
        C8kzsxD2LmBkXsUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYNE//O/5lB+PyVx/1DjEy
        cTAeYpTgYFYS4TULXpkkxJuSWFmVWpQfX1Sak1p8iFGag0VJnDc5c0OikEB6YklqdmpqQWoR
        TJaJg1Oqgcl+e+/CzW82nZp1wjtR0oD9bPg91h2NT3du3Wjy+sius5lqlpsE7+YtP3u74c48
        5jd73PgOGTN88jf48ch1FZPALbXvwhxmaid7W7zVC2w93x+sWsc0v/RMz3YvraLN7OnmjNY2
        RzkZnyurib+cc+npBE3v45XGsXMmHNCR+3FxyaS8rb8WMO1ewsRz4ayD4h8ZhgqjXfXbglSM
        LyhprRefvCMxaF6G0e7YUmOug3wvf2pHrrZ+/PXQLUEeo2uuKilmPNmBu27Wc/jovm3xyL8r
        o2v74PDXxQeXr8z/fFwgpPvwp+uyDxSK77MebP1f3Hvho8pq7ys7tvw8sTfhV/SiDt9dHEke
        7/jrJEzaN05XYinOSDTUYi4qTgQAsawYCQkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xu7pmm1YmGXw5bGax+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
        aVtc3jWHzWL+sqfsFjcmPGW0+Ly0hd1izc2nLBZtG78yOgh7XL7i7fHvxBo2j52z7rJ7XD5b
        6rFpVSebx8KGqcwem5fUe+y+2QCUa73P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZ
        Avij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLm
        bNzGWvBbtOLxQakGxg6hLkZODgkBE4nTh96wdzFycQgJLGWU2Pf9HxtEQkLi9sImRghbWOLP
        tS42iKLnjBI/Dh1j6mLk4GAT0JJo7GQHqRERiJbovPkerIZZYAGzxOk7E9hBaoQFIiT+PjIB
        qWERUJV4euwdK4jNK2AlMenlKqj58hIzL30Hm8MpYC2xY3YPK0irEFDNrnfxEOWCEidnPmEB
        sZmBypu3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIERvu3Yzy07
        GFe++qh3iJGJg/EQowQHs5IIr1nwyiQh3pTEyqrUovz4otKc1OJDjKZAZ09klhJNzgemmLyS
        eEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqaWk6Y35X1bNPc/efzh
        l/Khc1Exm9fl3A19E+h2f9P2jugu8SO/7820OX76z/6HbtvVrS+dT6xet2FD96yNQXltRz8z
        1N6WMXyn+kLaYHtbX0nW4dfaNn432o5aLihoX7ex7PdtuTU/v79fVRmSWRwbZjODq79HheXW
        ApbmxQbdUpNjXJfJsa65wxsYuWlOXLNKf+qu9b/zirJU/0mlqgdHb/a43GX+Oezr1Fv515lE
        H07bxueqvjHb+fQ/gwdunYEm4eJslzm3cpjfUzJb9+Ji4CePq0JzVt/xWrNGe24X4yxTGZ/o
        fYJ70+ND13tEBJxmuCEVVOfQx+S1btWS/qXpb2V2BJkkXs9MuhlU6K7EUpyRaKjFXFScCACL
        +j2SeQMAAA==
X-CMS-MailID: 20220615101935eucas1p26a7bc245d88a89312158d7a265f64aef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615101935eucas1p26a7bc245d88a89312158d7a265f64aef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615101935eucas1p26a7bc245d88a89312158d7a265f64aef
References: <20220615101920.329421-1-p.raghav@samsung.com>
        <CGME20220615101935eucas1p26a7bc245d88a89312158d7a265f64aef@eucas1p2.samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/zns.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9f81beb4d..d92f937d5 100644
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

