Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923E551C153
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380103AbiEENxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380150AbiEENx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:53:26 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78AA59942
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:49:43 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220505134936euoutp01f1242df7c72a958e8ac344523e6afae5~sOayHdtto2733027330euoutp01X
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:49:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220505134936euoutp01f1242df7c72a958e8ac344523e6afae5~sOayHdtto2733027330euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651758576;
        bh=FgRquCUlTM96nfBunGHxef/LSdqBZ3l0TN68Q/0AcX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyR5R4cSgpoUXLDIeuACGrtgFGHgSZLsRBkOm2wd44VD2jLtIN4Cr39xkskECGdna
         i+pyHUlwkm9ykzBx3RD9u33vlsBT6jdgcPKTzdDqT35Dq4QAZn2+ftoFSMgY+RPIDy
         7ooQKNH/CqSKImIaJsSC5y8WcFuomVvzBHGaWVR4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220505134934eucas1p1b9ba4e2f969ea7b600781ac79335c649~sOawerQ8H2600826008eucas1p1y;
        Thu,  5 May 2022 13:49:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3B.6C.09887.EE5D3726; Thu,  5
        May 2022 14:49:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220505134934eucas1p2de726a86c47310171425a17a7ce2858b~sOav3grtd2878928789eucas1p2F;
        Thu,  5 May 2022 13:49:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220505134934eusmtrp22744208461eabef54595df6fbd598287~sOav2mgZr2604426044eusmtrp24;
        Thu,  5 May 2022 13:49:34 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-b9-6273d5eec455
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 72.2A.09404.DE5D3726; Thu,  5
        May 2022 14:49:33 +0100 (BST)
Received: from localhost (unknown [106.210.248.170]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220505134933eusmtip2fa887742218995cb0b399247ce86bc53~sOavf3Ojp1531915319eusmtip2N;
        Thu,  5 May 2022 13:49:33 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, damien.lemoal@opensource.wdc.com,
        dsterba@suse.com, jaegeuk@kernel.org, bvanassche@acm.org,
        hare@suse.de
Cc:     jonathan.derrick@linux.dev, jiangbo.365@bytedance.com,
        matias.bjorling@wdc.com, gost.dev@samsung.com, pankydev8@gmail.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Date:   Thu,  5 May 2022 15:47:01 +0200
Message-Id: <20220505134710.132630-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505134710.132630-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7rvrhYnGcxrULdYfbefzWLah5/M
        Fr/Pnme2uPCjkcni5oGdTBZ7Fk1isli5+iiTxZP1s5gteg58YLFY2fKQ2WLvLW2Ly7vmsFlM
        aPvKbHFjwlNGi89LW9gt1tx8yuIg4HH5irfHvxNr2Dx2zrrL7nH5bKnHplWdbB4LG6Yye+y+
        2QAUb73P6tG3ZRWjx/otV1k8Np+u9vi8Sc6j/UA3UwBvFJdNSmpOZllqkb5dAlfGw5k/WArm
        i1Qs/xDRwHhXoIuRk0NCwERi/crXbF2MXBxCAisYJdY/m8EKkhAS+MIo0XLWHCLxmVFi6twD
        jF2M7GAdE3QgwssZJa7vWcIM4bxklNi+ZglQMwcHm4CWRGMnO0hcRKCbUeJs8xsWkKHMAl1M
        ErPf8IDYwgLJEgtX3WUGsVkEVCX2/vrNDmLzClhJvJx5kA3iOnmJmZe+g8U5Bawl5nQ+ZIWo
        EZQ4OfMJ1Ex5ieats8GOkBBYzykx+eVidohmF4mj+0+zQNjCEq+Ob4GKy0j83zmfCcKulnh6
        4zdUcwujRP/O9WwgH0gAbes7kwNiMgtoSqzfpQ9R7iix+s1OZogKPokbbwUhTuCTmLRtOlSY
        V6KjTQiiWkli588nUEslJC43zYE6xkNi3vP37BMYFWcheWYWkmdmIexdwMi8ilE8tbQ4Nz21
        2CgvtVyvODG3uDQvXS85P3cTIzAJnv53/MsOxuWvPuodYmTiYDzEKMHBrCTC67y0IEmINyWx
        siq1KD++qDQntfgQozQHi5I4b3LmhkQhgfTEktTs1NSC1CKYLBMHp1QDk7z6rzub61YuqbG6
        JVoQJX9/DeuV+S+nXX75xXEDJ9OTG6LrjXM5GDk6NkVVzo7b16zPnvzpv+shL+911deO3zi8
        s2MNo6D/sjo7A5NlYs//qqVMXCiXueu7LOdZCeVTuybzi2w/WqdgscxxwcrNrAfST1trNE3N
        yTvE3eJ281ybu8qW7VcEXjas4FON+hQptr5ngoKS1Ba5fZal/AxXhF7HNvds6LrwsT4orrDi
        QNJF30KdbZIdJ94tffnil2r511KJkJQQp49ziybMSlfnfPyWOSbjYthJtcbLif1P437JtnOf
        zf29au+aDwtDOxOcNW5HeC+Y92+93PZLKzdOjRP/dXYNe/Wc43P/lZw0WK/EUpyRaKjFXFSc
        CAASoozq8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7pvrxYnGWzYam2x+m4/m8W0Dz+Z
        LX6fPc9sceFHI5PFzQM7mSz2LJrEZLFy9VEmiyfrZzFb9Bz4wGKxsuUhs8XeW9oWl3fNYbOY
        0PaV2eLGhKeMFp+XtrBbrLn5lMVBwOPyFW+PfyfWsHnsnHWX3ePy2VKPTas62TwWNkxl9th9
        swEo3nqf1aNvyypGj/VbrrJ4bD5d7fF5k5xH+4FupgDeKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MhzN/sBTMF6lY/iGigfGuQBcjO4eEgInE
        BJ0uRi4OIYGljBKTNh1g72LkBApLSNxe2MQIYQtL/LnWxQZR9JxR4tiHFUAJDg42AS2Jxk52
        kLiIwFRGiQvbL7CAOMwCU5gkvlyfwQLSLSyQKNH49yAbiM0ioCqx99dvsA28AlYSL2dCxCUE
        5CVmXvoOFucUsJaY0/mQFcQWAqqZ+PAdG0S9oMTJmU/AZjID1Tdvnc08gVFgFpLULCSpBYxM
        qxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjdtuxn1t2MK589VHvECMTB+MhRgkOZiURXuel
        BUlCvCmJlVWpRfnxRaU5qcWHGE2B7p7ILCWanA9MGnkl8YZmBqaGJmaWBqaWZsZK4ryeBR2J
        QgLpiSWp2ampBalFMH1MHJxSDUztGixZ2zaG/L4RO6FI8Opdjg+BlT/epFT6bfpyUHzjtSdf
        D2eJO95Jmm6eMqm45MrEs6IlAu3sxx//PVausa3Qr9xfTeBO9m2TuIbcdNnWHLHLDxQeRtiK
        LVB+euCQlHFWpXbCj9mWohpFT+5mM+/Re/GI4YFIy5vOtb730o6nnrrW8nvyxkudqfGHTrEG
        1enaxN/TcrqxqVxXsaFTRVHQPmfxanXW2x9mr+qQkxGpOpFlHSZW46wmKOgoIqf0I91JhW/b
        2z3iFz58Zub2YRaP+n90zdr1j5+dEio9Yi68Ri5s5uOs3wuYKlp9qor+KZgtELVWbdjjIlhf
        6VmU4bp5WgvfPNOlR/48y2b4o8RSnJFoqMVcVJwIAHdYjaJiAwAA
X-CMS-MailID: 20220505134934eucas1p2de726a86c47310171425a17a7ce2858b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220505134934eucas1p2de726a86c47310171425a17a7ce2858b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220505134934eucas1p2de726a86c47310171425a17a7ce2858b
References: <20220505134710.132630-1-p.raghav@samsung.com>
        <CGME20220505134934eucas1p2de726a86c47310171425a17a7ce2858b@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
also work for non-power-of-2 zone sizes.

As the existing deployments of zoned devices had power-of-2
assumption, power-of-2 optimized calculation is kept for those devices.

There are no direct hot paths modified and the changes just
introduce one new branch per call.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-zoned.c      | 14 +++++++++++---
 include/linux/blkdev.h |  8 +++++++-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 38cd840d8..a09a2eef9 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -111,16 +111,24 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
  * blkdev_nr_zones - Get number of zones
  * @disk:	Target gendisk
  *
- * Return the total number of zones of a zoned block device.  For a block
- * device without zone capabilities, the number of zones is always 0.
+ * Return the total number of zones of a zoned block device, including the
+ * eventual small last zone if present.
+ * For a block device without zone capabilities, the number of zones
+ * is always 0.
  */
 unsigned int blkdev_nr_zones(struct gendisk *disk)
 {
 	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
+	sector_t capacity = get_capacity(disk);
 
 	if (!blk_queue_is_zoned(disk->queue))
 		return 0;
-	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return (capacity + zone_sectors - 1) >>
+		       ilog2(zone_sectors);
+
+	return div64_u64(capacity + zone_sectors - 1, zone_sectors);
 }
 EXPORT_SYMBOL_GPL(blkdev_nr_zones);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1b24c1fb3..22fe512ee 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -675,9 +675,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
 static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 					     sector_t sector)
 {
+	sector_t zone_sectors = blk_queue_zone_sectors(q);
+
 	if (!blk_queue_is_zoned(q))
 		return 0;
-	return sector >> ilog2(q->limits.chunk_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return sector >> ilog2(zone_sectors);
+
+	return div64_u64(sector, zone_sectors);
 }
 
 static inline bool blk_queue_zone_is_seq(struct request_queue *q,
-- 
2.25.1

