Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E376595D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbiHPNQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiHPNPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:15:49 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D89A5FF7A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:15:47 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131545euoutp01d2caece1aebbc484efc198081ef4523e~L1Zo0z0Q00135401354euoutp01M
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:15:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220816131545euoutp01d2caece1aebbc484efc198081ef4523e~L1Zo0z0Q00135401354euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660655745;
        bh=EO928PFpmrq5sHaWlnNhp7CZXI/51IcH8DoHTWAcRM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+LjqtUaKQJ3mJLaXx06eFzSyrMT+xxCcdQ9SNPrLQQfy2OXCz4XaAdy9ix/Stsgt
         Cs9VxAdNg+viOpydOZh2z7t808qlySuEDUtgm85iS8gM4z0IMz26MPK4awM6gS6uQQ
         +THHJ02wNl1cr4AULcyhdCKipQsv1n8f4vT0FSdA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220816131544eucas1p13471fe76b92999809feb4dc6e73873ce~L1ZnEDab70549005490eucas1p19;
        Tue, 16 Aug 2022 13:15:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2C.B7.10067.F789BF26; Tue, 16
        Aug 2022 14:15:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220816131543eucas1p12fd75be0a752006267bbe2c5b3b1a444~L1ZmbG4zH0141101411eucas1p1c;
        Tue, 16 Aug 2022 13:15:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220816131543eusmtrp1ce374e143ed40b3fb8b3ad4feda88a32~L1ZmJw05K0149801498eusmtrp1F;
        Tue, 16 Aug 2022 13:15:42 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-15-62fb987f0dfc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id ED.A0.09095.E789BF26; Tue, 16
        Aug 2022 14:15:42 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816131542eusmtip1c4d8f6d05922324c8e9962539b0974ed~L1ZlxxJ302645326453eusmtip1d;
        Tue, 16 Aug 2022 13:15:42 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v11 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Date:   Tue, 16 Aug 2022 15:15:28 +0200
Message-Id: <20220816131536.189406-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7r1M34nGVzttrJYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAldE/
        ZS9TQaNIxdsZl5gaGM8IdDFyckgImEjcavzG3sXIxSEksIJRYvOKzawgCSGBL4wSnw7xQCQ+
        M0rM2X2GDabj6aa3bBCJ5YwSXY9XMEI4LxglJr3bztTFyMHBJqAl0djJDtIgIpAuMaXlJQtI
        DbPAHSaJU++2giWEBaIlFk/6wQhiswioShzfPQNsNa+AlcSkJ99YILbJS8y89B2snlPAWuJf
        wyoWiBpBiZMzn4DZzEA1zVtnM4MskBDYzCkxd90yRohmF4mfH1dAnS0s8er4FnYIW0bi9OQe
        qAXVEk9v/IZqbmGU6N+5ng3kAwmgbX1nckBMZgFNifW79CHKHSU+td1jhqjgk7jxVhDiBD6J
        SdumQ4V5JTrahCCqlSR2/nwCtVRC4nLTHKilHhJ3d55lmcCoOAvJM7OQPDMLYe8CRuZVjOKp
        pcW56anFRnmp5XrFibnFpXnpesn5uZsYgQnx9L/jX3YwLn/1Ue8QIxMH4yFGCQ5mJRFewRc/
        koR4UxIrq1KL8uOLSnNSiw8xSnOwKInzJmduSBQSSE8sSc1OTS1ILYLJMnFwSjUw1QT4v1c+
        /OOu1JfIh40WCVuqWm4EBuvNmfR9/ef7r8+eiAxj1w+N+XNYboPfCeuF50x+r9s2U1x+oVjy
        U3MvplkxnJa2lwNeP5wfvfbbVP9s1vN3UooyFP5GlaWzPl2XW17rLBJWaLNbes/hNzXa/7tZ
        9bb7+ahq+u883hQbtHDjDO+lDGcKjmXJNce/OP77z/WmaCO9BcoFuit36Sd4hcW88yu5Ys0S
        JWkQp7k+9qmkq8CCC5mRZQIJX9wmFxb1Pk8Ujp/Vfku3eoeG5r3Jd15cO/q3b6nOw0NhSXqc
        mivn9jdJ/PZ799jNjE+U547OjU186S0P9j9WtT85cY2x0QUb94MPZmvLPOAMLL6rxFKckWio
        xVxUnAgA9VnPJ/cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7p1M34nGUyZZm6x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL6N/yl6mgkaRirczLjE1MJ4R6GLk
        5JAQMJF4uuktWxcjF4eQwFJGidUX7rNDJCQkbi9sYoSwhSX+XOuCKnrGKHHr5hygIg4ONgEt
        icZOsHoRgVyJRcs6WEFqmAXeMEl8mP+JCSQhLBAp8bT/HZjNIqAqcXz3DFYQm1fASmLSk28s
        EAvkJWZe+g42iFPAWuJfwyqwuBBQTduxy8wQ9YISJ2c+AYszA9U3b53NPIFRYBaS1CwkqQWM
        TKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECo3fbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEV7B
        Fz+ShHhTEiurUovy44tKc1KLDzGaAt09kVlKNDkfmD7ySuINzQxMDU3MLA1MLc2MlcR5PQs6
        EoUE0hNLUrNTUwtSi2D6mDg4pRqYGM4sWHNlgs+X+Zvd/tcrZ+y7cyTiiPY53byff5N/njx8
        ZdHhez8sq+duPFkcm7qKj2EOZ3PO/1UFvEWR5ek6G/Lm6V4sKV7WLMXvPGspx2brW4drV7lJ
        xqX9eHpwn/X3ngmO1f6Hvn56IhXsP/f8/XpGuQdfLPkvZfSbvGpb/0HPqc7g0VMm2b18zU1M
        Z2rdblz/tHf6Prfyr3x/zY+73AoKT1OXY0/z3XT5lqmR0Ys2mbwCI6vf82531R+4m8OtvKfP
        6Gr86fdP5S+EsFvzvTKwq3A0WLdC9onP9/tHT3Jf/hXIPUN/Q/X9VXbvurM+XwkI7l5b/OpI
        RGjgjQtabRe3WDR9Uqq9+ePbZe54FiWW4oxEQy3mouJEAMmD8ThnAwAA
X-CMS-MailID: 20220816131543eucas1p12fd75be0a752006267bbe2c5b3b1a444
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131543eucas1p12fd75be0a752006267bbe2c5b3b1a444
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131543eucas1p12fd75be0a752006267bbe2c5b3b1a444
References: <20220816131536.189406-1-p.raghav@samsung.com>
        <CGME20220816131543eucas1p12fd75be0a752006267bbe2c5b3b1a444@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/nvme/host/zns.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 12316ab51bda..fe1d715d61cc 100644
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
 
 	disk_set_zoned(ns->disk, BLK_ZONED_HM);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
@@ -129,7 +122,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 				   sizeof(struct nvme_zone_descriptor);
 
 	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(ns->disk) >> ilog2(ns->zsze));
+			 div64_u64(get_capacity(ns->disk), ns->zsze));
 
 	bufsize = sizeof(struct nvme_zone_report) +
 		nr_zones * sizeof(struct nvme_zone_descriptor);
@@ -182,6 +175,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	int ret, zone_idx = 0;
 	unsigned int nz, i;
 	size_t buflen;
+	u64 remainder = 0;
 
 	if (ns->head->ids.csi != NVME_CSI_ZNS)
 		return -EINVAL;
@@ -197,7 +191,9 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
 	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
 
-	sector &= ~(ns->zsze - 1);
+	/* Round down the sector value to the nearest zone start */
+	div64_u64_rem(sector, ns->zsze, &remainder);
+	sector -= remainder;
 	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
 		memset(report, 0, buflen);
 
-- 
2.25.1

