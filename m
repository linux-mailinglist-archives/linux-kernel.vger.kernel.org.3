Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5245C51C169
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380121AbiEENzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380269AbiEENzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:55:06 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBCF2FE52
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:51:14 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220505135113euoutp01f573e6041199889c1538b372aaa88d1d~sOcME4KAF3116431164euoutp011
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:51:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220505135113euoutp01f573e6041199889c1538b372aaa88d1d~sOcME4KAF3116431164euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651758673;
        bh=D05Y2RArrxR/ZcNMh/RJzrqiPuoU2BIWW0WuxZX2YSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVnq6TSnIid+zbL06EOGkBSL2O2TkR13NExMANbNJi+q+cDC0F4SVYMeHkkGmXaso
         jsh698805thBcg3VdtBGAin4C29T5s1PuG6Rv6dUVZseHbBObdreYkrtUpFxJ5rf7i
         pxwqPDEtjMj1WBUiXM0sNQF2Q7fKEmQlzfaC3IYw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220505135111eucas1p11ac926dfc697a45ef23092a11af516e6~sOcKakWSP1070010700eucas1p1H;
        Thu,  5 May 2022 13:51:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 22.0D.10009.F46D3726; Thu,  5
        May 2022 14:51:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220505135110eucas1p1fc49b2574920b9a2a274f9d77feb5d18~sOcJuHBiZ2591125911eucas1p1J;
        Thu,  5 May 2022 13:51:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220505135110eusmtrp165d3f6c9363c20b14b019590934c8c59~sOcJtOm2O1365913659eusmtrp1L;
        Thu,  5 May 2022 13:51:10 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-4f-6273d64f4513
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2C.6A.09404.E46D3726; Thu,  5
        May 2022 14:51:10 +0100 (BST)
Received: from localhost (unknown [106.210.248.170]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220505135110eusmtip2d2bc0b30a6c2752fd7d0ead76cf2177e~sOcJWiFKS1656016560eusmtip2R;
        Thu,  5 May 2022 13:51:10 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, damien.lemoal@opensource.wdc.com,
        dsterba@suse.com, jaegeuk@kernel.org, bvanassche@acm.org,
        hare@suse.de
Cc:     jonathan.derrick@linux.dev, jiangbo.365@bytedance.com,
        matias.bjorling@wdc.com, gost.dev@samsung.com, pankydev8@gmail.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] null_blk: allow non power of 2 zoned devices
Date:   Thu,  5 May 2022 15:47:10 +0200
Message-Id: <20220505134710.132630-11-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505134710.132630-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djPc7r+14qTDK4d47FYfbefzWLah5/M
        Fr/Pnme2uPCjkcni5oGdTBZ7Fk1isli5+iiTxZP1s5gteg58YLFY2fKQ2WLvLW2Ly7vmsFlM
        aPvKbHFjwlNGi89LW9gt1tx8yuIg4HH5irfHvxNr2Dx2zrrL7nH5bKnHplWdbB4LG6Yye+y+
        2QAUb73P6tG3ZRWjx/otV1k8Np+u9vi8Sc6j/UA3UwBvFJdNSmpOZllqkb5dAlfGrrnbmQse
        61acfvWCuYFxvUoXIyeHhICJxIvrTxm7GLk4hARWMEosa1zDBuF8YZSYdvQuE4TzmVFi39fz
        jDAta/oPQrUsB6ra+IIFwnnJKLH2zD0gh4ODTUBLorGTHSQuItDNKHG2+Q0LSDezQBeTxOw3
        PCC2sICbxPSb85lBbBYBVYkZa3azgti8AtYSX/99Z4HYJi8x89J3dhCbEyg+p/MhVI2gxMmZ
        T6Bmyks0b53NDLJMQmAzp8S3a7+hTnWRmNiwkx3CFpZ4dXwLlC0jcXpyD9SCaomnN35DNbcw
        SvTvXM8G8oEE0La+MzkgJrOApsT6XfoQUUeJP0utIUw+iRtvBSEu4JOYtG06M0SYV6KjTQhi
        tpLEzp9PoHZKSFxumgO100NiwdP7LBMYFWch+WUWkl9mIaxdwMi8ilE8tbQ4Nz212DAvtVyv
        ODG3uDQvXS85P3cTIzAVnv53/NMOxrmvPuodYmTiYDzEKMHBrCTC67y0IEmINyWxsiq1KD++
        qDQntfgQozQHi5I4b3LmhkQhgfTEktTs1NSC1CKYLBMHp1QDky9LdUclQ8unTex8q04cXaYc
        EWiQNFvqmUh73IYnbKtP+q5T8nXPe3h+bdfZ6yfaj0jXn9+jlBwhnTjnvcbCPr/vhSd9jfKz
        HknZPNr0g8vvxELhv09uzmNLPSMXa2wtJn/n3Gdx9zkJewWOHNjb0vfY90lgT/0Ej6DtX4+v
        v7V70UaDRl3P2xWpu3xVvZhTFtlf9a6/f/rT639fr12Z/tsx/MqUOxp2Wtw304UPCk48YPor
        d3qbkuaP/d/2fS85cHpm5L8SsY+Gryv2bl0cptvkn+ggG+hWluJcpCf1Ys21ZKP41W1rn57R
        CX9+X/PZ0peC50M0ef9aHJ73sbJ/3XOWUFnjf24ty+1nmtRuM1BiKc5INNRiLipOBAAHrx9M
        9AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xe7p+14qTDE7sk7ZYfbefzWLah5/M
        Fr/Pnme2uPCjkcni5oGdTBZ7Fk1isli5+iiTxZP1s5gteg58YLFY2fKQ2WLvLW2Ly7vmsFlM
        aPvKbHFjwlNGi89LW9gt1tx8yuIg4HH5irfHvxNr2Dx2zrrL7nH5bKnHplWdbB4LG6Yye+y+
        2QAUb73P6tG3ZRWjx/otV1k8Np+u9vi8Sc6j/UA3UwBvlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GrrnbmQse61acfvWCuYFxvUoXIyeHhICJ
        xJr+g4wgtpDAUkaJl+cFIOISErcXNjFC2MISf651sXUxcgHVPGeUWNK8iamLkYODTUBLorGT
        HSQuIjCVUeLC9gssIA6zwBQmiS/XZ7CAdAsLuElMvzmfGcRmEVCVmLFmNyuIzStgLfH133cW
        iA3yEjMvfWcHsTmB4nM6H7JCXGQlMfHhOzaIekGJkzOfgNUzA9U3b53NPIFRYBaS1CwkqQWM
        TKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC43bbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEV7n
        pQVJQrwpiZVVqUX58UWlOanFhxhNge6eyCwlmpwPTBx5JfGGZgamhiZmlgamlmbGSuK8ngUd
        iUIC6YklqdmpqQWpRTB9TBycUg1MOUGlBl+bZOf+0ZtyddGfiBMJJ6avPmyX//xX/fP5l3WD
        FUzS23Rz9ER/1R1eEraraWuCZb/QVdXrKxrCPv+fpFmpu2bytUaW0pQ1FhllG1Z3vfZwtDIL
        25py5D37Q8kP4SsfyJXNv9n7Z1/Ps8iYt893Xa7fIJpdnKp6U/v/gxv1Wtu7nItl9h+qeb9W
        MMY+QGxi1eyMO8wrXQIa1fb4RcpnpM5OOpV9IMLuWW1EzZeDWy8Hpd6rv17TcN132or89/pT
        Et9G2+6tit+Vz7BrZfSxJfMWFB0S2/NTs3/Rwvmn3r+sX+PNp2IvIVVicyhjp8ltuwdndZqu
        P7g6Pf/E3mlblaV0Jjt8+ac08UeBhRJLcUaioRZzUXEiAN+0g3VkAwAA
X-CMS-MailID: 20220505135110eucas1p1fc49b2574920b9a2a274f9d77feb5d18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220505135110eucas1p1fc49b2574920b9a2a274f9d77feb5d18
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220505135110eucas1p1fc49b2574920b9a2a274f9d77feb5d18
References: <20220505134710.132630-1-p.raghav@samsung.com>
        <CGME20220505135110eucas1p1fc49b2574920b9a2a274f9d77feb5d18@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the power of 2 based calculation with zone size to be generic in
null_zone_no with optimization for power of 2 based zone sizes.

The nr_zones calculation in null_init_zoned_dev has been replaced with a
division without special handling for power of 2 based zone sizes as
this function is called only during the initialization and will not
invoked in the hot path.

Performance Measurement:

Device:
zone size = 128M, blocksize=4k

FIO cmd:

fio --name=zbc --filename=/dev/nullb0 --direct=1 --zonemode=zbd  --size=23G
--io_size=<iosize> --ioengine=io_uring --iodepth=<iod> --rw=<mode> --bs=4k
--loops=4

The following results are an average of 4 runs on AMD Ryzen 5 5600X with
32GB of RAM:

Sequential Write:

x-----------------x---------------------------------x---------------------------------x
|     IOdepth     |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  578     |  2257    |   12.80   |  576     |  2248    |   25.78   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  581     |  2268    |   12.74   |  576     |  2248    |   25.85   |
x-----------------x---------------------------------x---------------------------------x

Sequential read:

x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  667     |  2605    |   11.79   |  675     |  2637    |   23.49   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  667     |  2605    |   11.79   |  675     |  2638    |   23.48   |
x-----------------x---------------------------------x---------------------------------x

Random read:

x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  522     |  2038    |   15.05   |  514     |  2006    |   30.87   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  522     |  2039    |   15.04   |  523     |  2042    |   30.33   |
x-----------------x---------------------------------x---------------------------------x

Minor variations are noticed in Sequential write with io depth 8 and
in random read with io depth 16. But overall no noticeable differences
were noticed

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/null_blk/main.c  |  5 ++---
 drivers/block/null_blk/zoned.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 5cb4c92cd..ed9a58201 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1929,9 +1929,8 @@ static int null_validate_conf(struct nullb_device *dev)
 	if (dev->queue_mode == NULL_Q_BIO)
 		dev->mbps = 0;
 
-	if (dev->zoned &&
-	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
-		pr_err("zone_size must be power-of-two\n");
+	if (dev->zoned && !dev->zone_size) {
+		pr_err("zone_size must not be zero\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index dae54dd1a..00c34e65e 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -13,7 +13,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
-	return sect >> ilog2(dev->zone_size_sects);
+	if (is_power_of_2(dev->zone_size_sects))
+		return sect >> ilog2(dev->zone_size_sects);
+
+	return div64_u64(sect, dev->zone_size_sects);
 }
 
 static inline void null_lock_zone_res(struct nullb_device *dev)
@@ -62,10 +65,6 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	sector_t sector = 0;
 	unsigned int i;
 
-	if (!is_power_of_2(dev->zone_size)) {
-		pr_err("zone_size must be power-of-two\n");
-		return -EINVAL;
-	}
 	if (dev->zone_size > dev->size) {
 		pr_err("Zone size larger than device capacity\n");
 		return -EINVAL;
@@ -83,8 +82,9 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
-	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
-		>> ilog2(dev->zone_size_sects);
+	dev->nr_zones =
+		div64_u64(roundup(dev_capacity_sects, dev->zone_size_sects),
+			  dev->zone_size_sects);
 
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
 				    GFP_KERNEL | __GFP_ZERO);
-- 
2.25.1

