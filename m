Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE0B47AA9F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhLTNsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:48:47 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30151 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbhLTNsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:48:25 -0500
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JHgpj2XCVz8vyk;
        Mon, 20 Dec 2021 21:46:05 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 21:48:23 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 20 Dec
 2021 21:48:23 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH v5 11/14] ubi: fastmap: Return error code if memory allocation fails in add_aeb()
Date:   Mon, 20 Dec 2021 21:59:48 +0800
Message-ID: <20211220135951.4075801-12-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211220135951.4075801-1-chengzhihao1@huawei.com>
References: <20211220135951.4075801-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abort fastmap scanning and return error code if memory allocation fails
in add_aeb(). Otherwise ubi will get wrong peb statistics information
after scanning.

Fixes: dbb7d2a88d2a7b ("UBI: Add fastmap core")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/fastmap.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 022af59906aa..6b5f1ffd961b 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -468,7 +468,9 @@ static int scan_pool(struct ubi_device *ubi, struct ubi_attach_info *ai,
 			if (err == UBI_IO_FF_BITFLIPS)
 				scrub = 1;
 
-			add_aeb(ai, free, pnum, ec, scrub);
+			ret = add_aeb(ai, free, pnum, ec, scrub);
+			if (ret)
+				goto out;
 			continue;
 		} else if (err == 0 || err == UBI_IO_BITFLIPS) {
 			dbg_bld("Found non empty PEB:%i in pool", pnum);
@@ -638,8 +640,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &ai->free, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 0);
+		ret = add_aeb(ai, &ai->free, be32_to_cpu(fmec->pnum),
+			      be32_to_cpu(fmec->ec), 0);
+		if (ret)
+			goto fail;
 	}
 
 	/* read EC values from used list */
@@ -649,8 +653,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 0);
+		ret = add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
+			      be32_to_cpu(fmec->ec), 0);
+		if (ret)
+			goto fail;
 	}
 
 	/* read EC values from scrub list */
@@ -660,8 +666,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 1);
+		ret = add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
+			      be32_to_cpu(fmec->ec), 1);
+		if (ret)
+			goto fail;
 	}
 
 	/* read EC values from erase list */
@@ -671,8 +679,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &ai->erase, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 1);
+		ret = add_aeb(ai, &ai->erase, be32_to_cpu(fmec->pnum),
+			      be32_to_cpu(fmec->ec), 1);
+		if (ret)
+			goto fail;
 	}
 
 	ai->mean_ec = div_u64(ai->ec_sum, ai->ec_count);
-- 
2.31.1

