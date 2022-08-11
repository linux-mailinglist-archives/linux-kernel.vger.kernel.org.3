Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA6058FE53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiHKObV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbiHKOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:30:57 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE8A6C127
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:30:55 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143052euoutp011ad1c2b9f61c62d8e4d8733c81a2e843~KUMyrClNF2260922609euoutp01_
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:30:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220811143052euoutp011ad1c2b9f61c62d8e4d8733c81a2e843~KUMyrClNF2260922609euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660228252;
        bh=E+La7o2Zl30I/sNS3Lx2T739zrulxOvYuda5lE4fWfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+58itCREFNkgY4yVDvsTp6oumwsp/0bIQmrp5p+1QC0x9Ei89VmgZ7VJfRZKFFko
         zI+88bQEe0b+DxO4itmpO3lnZ86bBQ7ZRVFH3ujuPxE5KVeEYDGUH83BDfLht2nSe0
         jLdKLUUTZe1tdFCrsIhAd/RKzNmGxiOB7latB630=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220811143050eucas1p2082dc6853555f1a80ee9994af529d4a9~KUMw84uep1006410064eucas1p2I;
        Thu, 11 Aug 2022 14:30:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D3.EF.10067.A9215F26; Thu, 11
        Aug 2022 15:30:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220811143050eucas1p12321909b1b7f94182708b935b35e4ff9~KUMwdpqRb1846918469eucas1p1F;
        Thu, 11 Aug 2022 14:30:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220811143050eusmtrp2ebea614a3e934204df9673ec6f2405dd~KUMwctMAb0788907889eusmtrp2r;
        Thu, 11 Aug 2022 14:30:50 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-4f-62f5129a6172
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F0.9F.09095.A9215F26; Thu, 11
        Aug 2022 15:30:50 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220811143049eusmtip20b2ace903518564fc96a4d8c6eba6861~KUMwH0_b11037010370eusmtip24;
        Thu, 11 Aug 2022 14:30:49 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v10 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Date:   Thu, 11 Aug 2022 16:30:35 +0200
Message-Id: <20220811143043.126029-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811143043.126029-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djPc7qzhL4mGSy8rGqx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK2Pz
        /q3sBX0iFUc6J7M0MF4S6GLk5JAQMJHoPH2IpYuRi0NIYAWjxJ2ZqxghnC+MElu+zWKHcD4z
        Svx5vYIFpmVRdxNUy3JGif27W6GqXjBKrOj/DdTPwcEmoCXR2MkO0iAikC6xfsFysAZmgTtM
        Et/v9bCBJIQFoiXubZ/LBGKzCKhKrHy8DszmFbCSePJrHzvENnmJmZe+g9mcAtYSExZdhKoR
        lDg58wnYRcxANc1bZzODLJAQ2MwpMfs3yBMgzS4Szy51sELYwhKvjm+BGioj8X/nfCYIu1ri
        6Y3fUM0tjBL9O9ezgXwgAbSt70wOiMksoCmxfpc+RLmjxKyVN6Eq+CRuvBWEOIFPYtK26cwQ
        YV6JjjYhiGoliZ0/n0AtlZC43DQHGoYeEt3XfjBOYFScheSZWUiemYWwdwEj8ypG8dTS4tz0
        1GKjvNRyveLE3OLSvHS95PzcTYzAlHj63/EvOxiXv/qod4iRiYPxEKMEB7OSCG/Zos9JQrwp
        iZVVqUX58UWlOanFhxilOViUxHmTMzckCgmkJ5akZqemFqQWwWSZODilGpi0D2vMWHdp5/29
        Yp7xz7fnSlpVuS3cra/S/FRBJ9qzvqRgH0fi1Z92HLlrG+1KY3SipRfxKl3pXew2NTG9P/xF
        6XYW3yb+gnbBjl9SkkttFp5beJD5/oxFcjPts1Y6WzX8NG1Qn1Z9VbFT4XDGtqUHb8kV6Uel
        Cruu6D2w4UDEn+wH2eb1QdfXLXpzZUZD1EPxv9XC85WfXb8ru/+Ou0550EXTbeZF2xyt2bn+
        G0uXlNbOaOabtL5OZ8mOtXGzDKIF9K5u+VbpzeJ/pd1s8fbE60u8tqgdsyt26KvIPyqnFHIl
        75zTkyLNoytY1F5M1P3AcGyq00/rtz7HM794Hlio0rRKZ/PEc7fP3kw8oqjEUpyRaKjFXFSc
        CAAvqaNr+AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7qzhL4mGTSfY7NYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7F5/1b2gj6RiiOdk1kaGC8JdDFy
        ckgImEgs6m5i6WLk4hASWMoo8eZkEyNEQkLi9kIYW1jiz7UuNoiiZ4wSpxcfZe1i5OBgE9CS
        aOxkBzFFBHIlDh4JBClhFnjDJNF5fQ8LSK+wQKTE1LXv2EBsFgFViZWP1zGB2LwCVhJPfu1j
        h5gvLzHz0ncwm1PAWmLCootgNUJANRM6jrFD1AtKnJz5BGwmM1B989bZzBMYBWYhSc1CklrA
        yLSKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMHa3Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuEt
        W/Q5SYg3JbGyKrUoP76oNCe1+BCjKdDdE5mlRJPzgckjryTe0MzA1NDEzNLA1NLMWEmc17Og
        I1FIID2xJDU7NbUgtQimj4mDU6qBaZ4nW94lV5GDxepc1yarSXMKltaVJ2i/P7HZPaxiAt96
        vSbOr1E6TC+S56wvNmbO/rquW5Df+pZcyLtNU3RnyzXsl8kIOjI59WGdO/PBvy9El+afnzGz
        farE/8L5/+wa1vN4ieqmc7+8GJ6sPvnbdnGfrWs/iK0u5rA9t6bEc68U36XLbs6L+vviT/SL
        zCgtjXsUlqy1aYm73sumxxZM57IDfpztOnT/nGGQdeq3FPb412cqI6PY/30/+pozpP+Z5Jqd
        HUevmX1hNs4yvnXnz6rrXxfxxyVK1ppLvs39/7PsuOL9xE9lywQLLicGXnRzjSlstK46uHyt
        zZnKI2tfHbNWrff3Kf5ovktiu9p3JZbijERDLeai4kQA6RxxWmYDAAA=
X-CMS-MailID: 20220811143050eucas1p12321909b1b7f94182708b935b35e4ff9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143050eucas1p12321909b1b7f94182708b935b35e4ff9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143050eucas1p12321909b1b7f94182708b935b35e4ff9
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143050eucas1p12321909b1b7f94182708b935b35e4ff9@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

