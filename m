Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEFC59E5AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiHWPHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbiHWPHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:07:11 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E2732A6B0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:36:25 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220823121909euoutp01b519e5648455800776e2ad1df7eeed91~N_JNfnUrL1942519425euoutp01X
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:19:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220823121909euoutp01b519e5648455800776e2ad1df7eeed91~N_JNfnUrL1942519425euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661257149;
        bh=EO928PFpmrq5sHaWlnNhp7CZXI/51IcH8DoHTWAcRM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ia63CiDKII4dFSDK9H+vUejRmPRm0jpSLl5X/B+1yN4sh22DPrf8CAXcyYRJrbIp5
         rgX3i72StLt2CGCC+RjFbRAz9I2XtPbWdBWTWasyTyVRXrTaO1GvDzA2tCrnhquwUt
         EdyEddVOPtKlCA/mTavDoJIquFOQgPFBbTWxAROE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220823121907eucas1p2205c8409cc44a7330a0e6b218a1a4a78~N_JLpL7y81813818138eucas1p24;
        Tue, 23 Aug 2022 12:19:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A2.60.19378.BB5C4036; Tue, 23
        Aug 2022 13:19:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220823121907eucas1p295c375935b556729864dce39534c2579~N_JLQa5Nx2019620196eucas1p2k;
        Tue, 23 Aug 2022 12:19:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220823121906eusmtrp1ba8ef30911d7a797f02b5c86363194f4~N_JLPgFy01042010420eusmtrp1B;
        Tue, 23 Aug 2022 12:19:06 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-02-6304c5bb69ba
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 73.81.10862.AB5C4036; Tue, 23
        Aug 2022 13:19:06 +0100 (BST)
Received: from localhost (unknown [106.210.248.52]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220823121906eusmtip1292e5a0e3c051bc58f5eef5ec71f6b6b~N_JK7Qi_c0901809018eusmtip1G;
        Tue, 23 Aug 2022 12:19:06 +0000 (GMT)
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
Subject: [PATCH v12 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Date:   Tue, 23 Aug 2022 14:18:51 +0200
Message-Id: <20220823121859.163903-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823121859.163903-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTGee+93N6SlV0qW19hk9BM42oGY9blzTSgcyF38Y+ZxSxGE+Wm
        XD4GLa6FKbBlOBBKIVLdglA654goFF0VECxYonW2VcoYLY0UhH3YZpuKYzIgWCtSLmb+9zvn
        PM/7nJO8FC6+GxlH5aoKObWKzZeSUUS3fWHorb4bhOLty14JMt+y46h9oo5E9dMLOAoODuHI
        +rApEvmuWjB0pfk4htrab2DIbzbgKKSbxJB1bAPy9BpJ9P2ZgADpK2dxNKoPADTTUiFA53wB
        AjnH4reKGc/IDsZimBAwnsEipsNUTTKdp79i+nxlJGM58msk80+/l2SOdpkA0zlQysx0rGGq
        rtZgO1/aE7Ulk8vP/ZxTJ6dmROXUfWvFDhyOPTTV4MbKgIvWASEFaTl0PhnHwiymWwH0tafr
        QNQS/wfgTe0xAV/MANhf34M/d0yd/4HgB2cBHLHPY3zxF4DXR7ykDlAUScvg4WpB2BBLZ8PZ
        2QsgzDh9B4Nzt5VhXkXvhWNPXMsagl4Ly+1hq5AS0e/BuXPlGB+WABvd88saIb0Znmy5BXhN
        DLzZ6Cf4NxNg+aUmPLwDpHuEMPjzpIA3fwB7W7WRPK+C9xxdK/3X4MA3tQTPpTAwGlwxVwBY
        ZzEvHwCX0o668sOI029Cc28yL98G5zwnCF4RDUenYvgVouHx7hM43xZBbaWYV0uhZcG/Egqh
        52vjSigD/abvBHqQaHjhGMMLxxj+zz0FcBOQcEUaZTan2ajiDiZpWKWmSJWdpChQdoClfzjw
        1DF7GbTe+zfJBjAK2ACkcGmsqHQ4QiEWZbLFJZy6YL+6KJ/T2EA8RUglIkXuBVZMZ7OFXB7H
        HeDUz6cYJYwrw9JEO+dDP1oTD5HFj3frPrW/YX1FiuoNcUFHgmLSWbpwSS+fv3tKcl9OKR92
        RUvwi76hLwer1qZ3b9+YOn6MubZtWPJ7LuEwiYhB2RfW+w3dCrp5uj2ZfF2tzWl0JgpdGTVn
        6F2F64vXV53UL1qdoXd2/Nm277e08xHsPs1Fb3NFZ+D67VcbvIRxl2vTY9uDgyXy4KYxNGB7
        V/LRo4KUTMPqz7Jk/XlVw0JHXyhQwxpV9b/UpsT2ZFjMi0/L4l3Ff/dXr9vu/8n4fpM7tNqd
        7rBVaOU9w4ws7+OXPzw7XVsynpXVhyYiPnFvSdw/GfNgzR/RbXdaHiXLqgNtp7duviYlNDls
        igxXa9hn9iN1E/YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7q7jrIkG7y/Zmqx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL6N/yl6mgkaRirczLjE1MJ4R6GLk
        5JAQMJF4u3YhSxcjF4eQwFJGie9/5rNAJCQkbi9sYoSwhSX+XOtigyh6xijx+8M3pi5GDg42
        AS2Jxk52kBoRgVyJw5snMIHUMAu8YZI4+q+FFSQhLBApse34SrChLAKqEs3HrrKB2LwCVhLf
        1jQzQSyQl5h56TvYIE4Ba4l5S0+BLRYCqpl/6xNUvaDEyZlPwOYwA9U3b53NPIFRYBaS1Cwk
        qQWMTKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECo3fbsZ9bdjCufPVR7xAjEwfjIUYJDmYl
        Ed7qiwzJQrwpiZVVqUX58UWlOanFhxhNge6eyCwlmpwPTB95JfGGZgamhiZmlgamlmbGSuK8
        ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MTI/Lci6onPxyYS/nFUunlJw/b5u6eCfO2W3/4eGC
        JYbK9/+s22z0VlNs0rV48TNTt+pt26uXNq/Hse2QY2q9/aIDDPVOFmby/N23+afkTX+37Os6
        v7tbtFdnXjp3YtqpipCOveEvixYLil5RnXDB4dfLTRVfd6dqvMkq5Fv2YG3uy+xzkm7511nu
        J3QH+dvmftk98Tq7bkPSxS4r3bwv6dlxKWUa3nM6i3+b2zmzBXDFnJjc0u66qkYuo7A0PyT1
        wJsdH3+f/LWC/XarV1KFhELEpy0eB01n3qu9lcEhe9Rgg5rbqj8cU655eR0N/fz16T2faSpH
        958+b2FxPt9pgcvblyEL3vn3zP0rsHfTUyWW4oxEQy3mouJEAMz2gKxnAwAA
X-CMS-MailID: 20220823121907eucas1p295c375935b556729864dce39534c2579
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220823121907eucas1p295c375935b556729864dce39534c2579
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121907eucas1p295c375935b556729864dce39534c2579
References: <20220823121859.163903-1-p.raghav@samsung.com>
        <CGME20220823121907eucas1p295c375935b556729864dce39534c2579@eucas1p2.samsung.com>
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

