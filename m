Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901E45889BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiHCJs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiHCJsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:48:14 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C49628734
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:48:11 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094810euoutp02113c5efe853cf14a34014ca5b7fe3640~HzLrPbrmH2038420384euoutp02Y
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:48:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220803094810euoutp02113c5efe853cf14a34014ca5b7fe3640~HzLrPbrmH2038420384euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659520090;
        bh=E+La7o2Zl30I/sNS3Lx2T739zrulxOvYuda5lE4fWfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ikltu0wE24mOe3U3dKUOjvM4+VVsDaHNPMPPFGdsi/XXdOGku3WMzxwNQBQK3/S+H
         gaHs8USGWaW7Qr0wHUrT2m0wKzd5+DT6zxxouGah3wZTusWjkUlcR2rkNT0Yz/Ctft
         V24k7phUZEtT81XGVDBBbsLoVqI94ls1GTwTMeYY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220803094808eucas1p20fccdbf39db130f1fcffa078d5c3ffd0~HzLpo-yKd1615116151eucas1p21;
        Wed,  3 Aug 2022 09:48:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2C.F2.09580.8544AE26; Wed,  3
        Aug 2022 10:48:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527~HzLpBPANP1078810788eucas1p1N;
        Wed,  3 Aug 2022 09:48:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220803094808eusmtrp111d241cef0397c0689130cd7d8eb2553~HzLpAXxR92000320003eusmtrp1R;
        Wed,  3 Aug 2022 09:48:08 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-14-62ea4458fe5e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 94.9B.09038.7544AE26; Wed,  3
        Aug 2022 10:48:07 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220803094807eusmtip2c69438db6f11c983d60b36accf56cbb4~HzLosQXnL1679416794eusmtip2n;
        Wed,  3 Aug 2022 09:48:07 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v9 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Date:   Wed,  3 Aug 2022 11:47:53 +0200
Message-Id: <20220803094801.177490-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7djPc7oRLq+SDFZu0LBYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlbF5
        /1b2gj6RiiOdk1kaGC8JdDFyckgImEjcOP6crYuRi0NIYAWjxIKDr1kgnC+MEv8m9jNDOJ8Z
        Jfa9bWOCadmybQEjRGI5o8TsVxtZIZyXjBKtmxcAtXBwsAloSTR2soPERQSaGSXu/u0BK2IW
        OMAkcXPLLbBRwgJREjvunWAGsVkEVCVOr5kCZvMKWElsvTCRHWKdvMTMS9/BbE4Ba4kp//5B
        1QhKnJz5hAXEZgaqad46G+xWCYHtnBJ3l3SzQTS7SHxZuBJqkLDEq+NboGwZidOTe1gg7GqJ
        pzd+QzW3MEr071zPBvKCBNC2vjM5ICazgKbE+l36EOWOEotnzmCFqOCTuPFWEOIEPolJ26Yz
        Q4R5JTrahCCqlSR2/nwCtVRC4nLTHKilHhKXz35lm8CoOAvJM7OQPDMLYe8CRuZVjOKppcW5
        6anFxnmp5XrFibnFpXnpesn5uZsYgUnx9L/jX3cwrnj1Ue8QIxMH4yFGCQ5mJRHeOy7Pk4R4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzJmduSBQSSE8sSc1OTS1ILYLJMnFwSjUwcfXt3pd77WJt
        1Jk7hqvu9u2u6Ok/MnP+z9V3Dv+sSv+y55WR6eyH2y1Dzh7JTI/Y0rbva+gFJieWBFsbJnOR
        vqmG0x0y/kpwd5x63fRJ6MTOmIIP5cLOa411vuR91TzntpGPkbOuOP9GsvqferXUVZrCBzbs
        luGQ0Nwwvf+v+ZGWhpjz3ytdN5eqLkvb/lPlkOKp/f2PrcoyF9zfMGnNguc/lGyeKUWu2+tb
        Ll6hy9jpfo5Fa6pz8zdT+Y3TQkO2mBx84J/atfiA+99TrVfMVESzVDUnvoq+vbpA4bqNdUJU
        96dtsqzi84yO/ufS4HL5d+/gOoudx2ZsWJHofPtzuSprlIWQzawZOlcMpifeU2Ipzkg01GIu
        Kk4EABdgS875AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7rhLq+SDHavs7JYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7F5/1b2gj6RiiOdk1kaGC8JdDFy
        ckgImEhs2baAsYuRi0NIYCmjxKTJC1kgEhIStxc2MULYwhJ/rnWxQRQ9Z5Q43/SfqYuRg4NN
        QEuisZMdJC4i0M0ocfnMOVYQh1ngHJPEnKcP2EC6hQUiJG7u+soOYrMIqEqcXjOFGcTmFbCS
        2HphIjvEBnmJmZe+g9mcAtYSU/79A6sRAqpZ93cWK0S9oMTJmU/ArmMGqm/eOpt5AqPALCSp
        WUhSCxiZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG77ZjP7fsYFz56qPeIUYmDsZDjBIc
        zEoivHdcnicJ8aYkVlalFuXHF5XmpBYfYjQFunsis5Rocj4wgeSVxBuaGZgamphZGphamhkr
        ifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTAl+sp25f3lqDz+RSuO29Y9z3DFlsNdmnpzghR/
        F1u98So+PoH7yo6M2jKWeQK5ObMXsFZx1lYx+BeIBRQZOqvne3LM+6i6iTUtk+H5LqYIhv+z
        JV4qfeWwiNSzn3VH77SJRFTou/j0+PvPrj6SsuF8UqPwKPZ52EPnZJP0KysSPTyj8qbxXO/5
        /6kg8PYqxXO5uoFtu+UZz04Oit02zWqGd9W/+Xuj03kn3UrVmzpX9I3LSc79u/qjozhsdq8t
        WdL/me1q0epZK7Sac+/kXnr4Z47V7b8cRXNsGrw0kmZIrN6p8j6Z1WRjyvujqQbLL/ntiFjk
        PEPlkM1emaiyxvmM3s9Ld245VdHvFXjSSYmlOCPRUIu5qDgRAAllp1doAwAA
X-CMS-MailID: 20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527
References: <20220803094801.177490-1-p.raghav@samsung.com>
        <CGME20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/nvme/host/zns.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 12316ab51bda..73e4ad495ae8 100644
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
@@ -197,7 +191,11 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
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

