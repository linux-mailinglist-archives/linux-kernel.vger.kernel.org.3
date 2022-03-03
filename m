Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E011A4CC6E4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbiCCUOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiCCUOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:14:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B711FB2E16;
        Thu,  3 Mar 2022 12:13:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5367E60B43;
        Thu,  3 Mar 2022 20:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0CBC340F0;
        Thu,  3 Mar 2022 20:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646338397;
        bh=j4bn3Ok2EKQOAydHUuzmQf4Ay95OLFsE7viMeoPpcFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gf4Sro46MDphEEUdQtawv5ofp1/rau9MJeM4gRfJy+edP7Y8ULMg5hM+MFGTJA1M6
         Aezt5EMgSlwaiUp1Mpl5zLdKduMassSH/O7WOydgpx4mGsbgoaoWN5rli5Vnhhe2Aq
         vOmHS3ZI2NpfbuE1JszkLGX9kig37r5QtL/U94IT4n4dMxe5oqOBP3TsXIZvqJSo9G
         E3vFjF9pXUtzN0wsxUksQKXlcXKM9tXiwDyVyAtAl3I14wynXvUd5JMZcMQ21PmJl9
         8MTOuBsmGgv+XllfkVGTfW1NooQXS9l1URuCXYl3E1XrcblwcFgKk3tZvXd/rVwO6O
         +n4IsRITWFQhQ==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4 1/8] block: support pi with extended metadata
Date:   Thu,  3 Mar 2022 12:13:05 -0800
Message-Id: <20220303201312.3255347-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220303201312.3255347-1-kbusch@kernel.org>
References: <20220303201312.3255347-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvme spec allows protection information formats with metadata
extending beyond the pi field. Use the actual size of the metadata field
for incrementing the buffer.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c         | 1 +
 block/t10-pi.c                | 4 ++--
 include/linux/blk-integrity.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6996e7bd66e9..32929c89ba8a 100644
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

