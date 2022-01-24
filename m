Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D321498400
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243260AbiAXQBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:01:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43806 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbiAXQBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:01:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE7F4614D1;
        Mon, 24 Jan 2022 16:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81A3C340E8;
        Mon, 24 Jan 2022 16:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643040071;
        bh=Z/Mj7XngyF9X2Wrz/JmIDkKpDKYizMMSNAPpmkgr9zQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WD7Bd5anbjPEer1IHHB/O4SE1/PyUmvY/vNzCB3R0JNLQfUzU4d0ea/9A6e9NN3Ux
         ByvHZMa6WE4cN7XkGQ444NbUT4gm3S4PRm946xTUscEBcNPLvsxLkp1tXPa8GggaI/
         879gNWWKoinfb4GP9Kf/QfMfqORZ27K/GY6Glsul1hmyMFYh3HEkSBtI5k7BRPU/LS
         r+ig3xRDH5qPWpNul7cH2OnbW17jAg/2Fy+xnQHIIXCV28GhXxdCGDHptrCsDqXKNO
         1Ti3iJszcPRL6CAXAVa8IVt+Ovpj4R8C7BZGgqPHFZzpvvyrIwYC43ynvf27ifJsRZ
         jDQsXZfXk4hwA==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, arnd@arndb.de, Keith Busch <kbusch@kernel.org>
Subject: [RFC 1/7] block: support pi with extended metadata
Date:   Mon, 24 Jan 2022 08:01:01 -0800
Message-Id: <20220124160107.1683901-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220124160107.1683901-1-kbusch@kernel.org>
References: <20220124160107.1683901-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvme spec allows protection information formats with metadata
extending beyond the pi field. Use the actual size of the metadata field
for incrementing the protection buffer.

Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c         | 1 +
 block/t10-pi.c                | 4 ++--
 include/linux/blk-integrity.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index d25114715459..e40b1f965960 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -165,6 +165,7 @@ static blk_status_t bio_integrity_process(struct bio *bio,
 
 	iter.disk_name = bio->bi_bdev->bd_disk->disk_name;
 	iter.interval = 1 << bi->interval_exp;
+	iter.tuple_size = bi->tuple_size;
 	iter.seed = proc_iter->bi_sector;
 	iter.prot_buf = bvec_virt(bip->bip_vec);
 
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 25a52a2a09a8..758a76518854 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -44,7 +44,7 @@ static blk_status_t t10_pi_generate(struct blk_integrity_iter *iter,
 			pi->ref_tag = 0;
 
 		iter->data_buf += iter->interval;
-		iter->prot_buf += sizeof(struct t10_pi_tuple);
+		iter->prot_buf += iter->tuple_size;
 		iter->seed++;
 	}
 
@@ -93,7 +93,7 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 
 next:
 		iter->data_buf += iter->interval;
-		iter->prot_buf += sizeof(struct t10_pi_tuple);
+		iter->prot_buf += iter->tuple_size;
 		iter->seed++;
 	}
 
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 8a038ea0717e..378b2459efe2 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -19,6 +19,7 @@ struct blk_integrity_iter {
 	sector_t		seed;
 	unsigned int		data_size;
 	unsigned short		interval;
+	unsigned char		tuple_size;
 	const char		*disk_name;
 };
 
-- 
2.25.4

