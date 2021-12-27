Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCD847F9E4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 04:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhL0DMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 22:12:31 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29294 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbhL0DMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 22:12:12 -0500
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JMjPW6hs8zbjfJ;
        Mon, 27 Dec 2021 11:11:43 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 11:12:10 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 27 Dec
 2021 11:12:10 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>,
        <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into 'ai->fastmap' when fm->used_blocks>=2
Date:   Mon, 27 Dec 2021 11:22:43 +0800
Message-ID: <20211227032246.2886878-13-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211227032246.2886878-1-chengzhihao1@huawei.com>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com>
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

Fastmap pebs(pnum >= UBI_FM_MAX_START) won't be added into 'ai->fastmap'
while attaching ubi device if 'fm->used_blocks' is greater than 2, which
may cause warning from 'ubi_assert(ubi->good_peb_count == found_pebs)':

  UBI assert failed in ubi_wl_init at 1878 (pid 2409)
  Call Trace:
    ubi_wl_init.cold+0xae/0x2af [ubi]
    ubi_attach+0x1b0/0x780 [ubi]
    ubi_init+0x23a/0x3ad [ubi]
    load_module+0x22d2/0x2430

Reproduce:
  ID="0x20,0x33,0x00,0x00" # 16M 16KB PEB, 512 page
  modprobe nandsim id_bytes=$ID
  modprobe ubi mtd="0,0" fm_autoconvert  # Fastmap takes 2 pebs
  rmmod ubi
  modprobe ubi mtd="0,0" fm_autoconvert  # Attach by fastmap

Add all used fastmap pebs into list 'ai->fastmap' to make sure they can
be counted into 'found_pebs'.

Fixes: fdf10ed710c0aa ("ubi: Rework Fastmap attach base code")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/fastmap.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 6b5f1ffd961b..01dcdd94c9d2 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -828,24 +828,6 @@ static int find_fm_anchor(struct ubi_attach_info *ai)
 	return ret;
 }
 
-static struct ubi_ainf_peb *clone_aeb(struct ubi_attach_info *ai,
-				      struct ubi_ainf_peb *old)
-{
-	struct ubi_ainf_peb *new;
-
-	new = ubi_alloc_aeb(ai, old->pnum, old->ec);
-	if (!new)
-		return NULL;
-
-	new->vol_id = old->vol_id;
-	new->sqnum = old->sqnum;
-	new->lnum = old->lnum;
-	new->scrub = old->scrub;
-	new->copy_flag = old->copy_flag;
-
-	return new;
-}
-
 /**
  * ubi_scan_fastmap - scan the fastmap.
  * @ubi: UBI device object
@@ -865,7 +847,6 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 	struct ubi_vid_hdr *vh;
 	struct ubi_ec_hdr *ech;
 	struct ubi_fastmap_layout *fm;
-	struct ubi_ainf_peb *aeb;
 	int i, used_blocks, pnum, fm_anchor, ret = 0;
 	size_t fm_size;
 	__be32 crc, tmp_crc;
@@ -875,17 +856,6 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 	if (fm_anchor < 0)
 		return UBI_NO_FASTMAP;
 
-	/* Copy all (possible) fastmap blocks into our new attach structure. */
-	list_for_each_entry(aeb, &scan_ai->fastmap, u.list) {
-		struct ubi_ainf_peb *new;
-
-		new = clone_aeb(ai, aeb);
-		if (!new)
-			return -ENOMEM;
-
-		list_add(&new->u.list, &ai->fastmap);
-	}
-
 	down_write(&ubi->fm_protect);
 	memset(ubi->fm_buf, 0, ubi->fm_size);
 
@@ -1029,6 +999,11 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 				"err: %i)", i, pnum, ret);
 			goto free_hdr;
 		}
+
+		/* Add all fastmap blocks into attach structure. */
+		ret = add_aeb(ai, &ai->fastmap, pnum, be64_to_cpu(ech->ec), 0);
+		if (ret)
+			goto free_hdr;
 	}
 
 	kfree(fmsb);
-- 
2.31.1

