Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56257498418
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243251AbiAXQBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:01:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54546 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243320AbiAXQBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:01:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D92DBB810F3;
        Mon, 24 Jan 2022 16:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB300C340EA;
        Mon, 24 Jan 2022 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643040075;
        bh=Dr/AbgMshBvgbnKnIxBZYt5s22uup9MW9WKG9rVi0DQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jjp+UU5GWsTxEwKbReWanq7e2Qzr/rknQ/Z586rdT8n72u4VEueEvt2eJ3HUF4dbn
         EKHGWx2nRD9LSgC5mF9JOdTMrJjHXUbPiqZDhIPHiFZiDrK5aJpRj3lzr8WjNPe7co
         D3AR9stfSS2LHMuAl0X30BmZgAiSG3v7Xk7RuCTNhhWXUZB09cykPN1og4I2PmGK/F
         T4alnaJTLJwUxB1uUswbHfvl2ZvXJyrvrmeUQJ68Yvu7xzBuKz1kfz4v3BhcCuIBXU
         K88iG/CjIoaTP+5jx4vluYbYmA7tYPI5bf+6lVceM2oLROdTlej4JrEcohCR+r+BRZ
         yUQU6oeOCrRmg==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, arnd@arndb.de, Keith Busch <kbusch@kernel.org>
Subject: [RFC 6/7] block: add pi for nvme enhanced integrity
Date:   Mon, 24 Jan 2022 08:01:06 -0800
Message-Id: <20220124160107.1683901-7-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220124160107.1683901-1-kbusch@kernel.org>
References: <20220124160107.1683901-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVMe specification defines larger data integrity formats beyond the
t10 tuple. Add support for the specification defined CRC64 formats,
assuming the reference tag does not need to be split with the "storage
tag".

Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/Kconfig          |   1 +
 block/t10-pi.c         | 194 +++++++++++++++++++++++++++++++++++++++++
 include/linux/t10-pi.h |  20 +++++
 3 files changed, 215 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index d5d4197b7ed2..78eca050dff7 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -63,6 +63,7 @@ config BLK_DEV_INTEGRITY_T10
 	tristate
 	depends on BLK_DEV_INTEGRITY
 	select CRC_T10DIF
+	select CRC64
 
 config BLK_DEV_ZONED
 	bool "Zoned block device support"
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 758a76518854..7bfefe970bc5 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -7,8 +7,10 @@
 #include <linux/t10-pi.h>
 #include <linux/blk-integrity.h>
 #include <linux/crc-t10dif.h>
+#include <linux/crc64.h>
 #include <linux/module.h>
 #include <net/checksum.h>
+#include <asm/unaligned.h>
 
 typedef __be16 (csum_fn) (void *, unsigned int);
 
@@ -278,4 +280,196 @@ const struct blk_integrity_profile t10_pi_type3_ip = {
 };
 EXPORT_SYMBOL(t10_pi_type3_ip);
 
+static __be64 nvme_pi_crc64(void *data, unsigned int len)
+{
+	return cpu_to_be64(crc64_rocksoft(~0ULL, data, len));
+}
+
+static blk_status_t nvme_crc64_generate(struct blk_integrity_iter *iter,
+					enum t10_dif_type type)
+{
+	unsigned int i;
+
+	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
+		struct nvme_crc64_pi_tuple *pi = iter->prot_buf;
+
+		pi->guard_tag = nvme_pi_crc64(iter->data_buf, iter->interval);
+		pi->app_tag = 0;
+
+		if (type == T10_PI_TYPE1_PROTECTION)
+			put_unaligned_be48(iter->seed, pi->ref_tag);
+		else
+			put_unaligned_be48(0ULL, pi->ref_tag);
+
+		iter->data_buf += iter->interval;
+		iter->prot_buf += iter->tuple_size;
+		iter->seed++;
+	}
+
+	return BLK_STS_OK;
+}
+
+static bool nvme_crc64_ref_escape(u8 *ref_tag)
+{
+	static u8 ref_escape[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+
+	return memcmp(ref_tag, ref_escape, sizeof(ref_escape)) == 0;
+}
+
+static blk_status_t nvme_crc64_verify(struct blk_integrity_iter *iter,
+				      enum t10_dif_type type)
+{
+	unsigned int i;
+
+	for (i = 0; i < iter->data_size; i += iter->interval) {
+		struct nvme_crc64_pi_tuple *pi = iter->prot_buf;
+		u64 ref, seed;
+		__be64 csum;
+
+		if (type == T10_PI_TYPE1_PROTECTION) {
+			if (pi->app_tag == T10_PI_APP_ESCAPE)
+				goto next;
+
+			ref = get_unaligned_be48(pi->ref_tag);
+			seed = iter->seed & 0xffffffffffffull;
+			if (ref != seed) {
+				pr_err("%s: ref tag error at location %llu (rcvd %llu)\n",
+					iter->disk_name, seed, ref);
+				return BLK_STS_PROTECTION;
+			}
+		} else if (type == T10_PI_TYPE3_PROTECTION) {
+			if (pi->app_tag == T10_PI_APP_ESCAPE &&
+			    nvme_crc64_ref_escape(pi->ref_tag))
+				goto next;
+		}
+
+		csum = nvme_pi_crc64(iter->data_buf, iter->interval);
+		if (pi->guard_tag != csum) {
+			pr_err("%s: guard tag error at sector %llu " \
+			       "(rcvd %016llx, want %016llx)\n",
+				iter->disk_name, (unsigned long long)iter->seed,
+				be64_to_cpu(pi->guard_tag), be64_to_cpu(csum));
+			return BLK_STS_PROTECTION;
+		}
+
+next:
+		iter->data_buf += iter->interval;
+		iter->prot_buf += iter->tuple_size;
+		iter->seed++;
+	}
+
+	return BLK_STS_OK;
+}
+
+static blk_status_t nvme_pi_type1_verify_crc(struct blk_integrity_iter *iter)
+{
+	return nvme_crc64_verify(iter, T10_PI_TYPE1_PROTECTION);
+}
+
+static blk_status_t nvme_pi_type1_generate_crc(struct blk_integrity_iter *iter)
+{
+	return nvme_crc64_generate(iter, T10_PI_TYPE1_PROTECTION);
+}
+
+static void nvme_pi_type1_prepare(struct request *rq)
+{
+	const int tuple_sz = rq->q->integrity.tuple_size;
+	u64 ref_tag = nvme_pi_extended_ref_tag(rq);
+	struct bio *bio;
+
+	__rq_for_each_bio(bio, rq) {
+		struct bio_integrity_payload *bip = bio_integrity(bio);
+		u64 virt = bip_get_seed(bip) & 0xffffffffffffull;
+		struct bio_vec iv;
+		struct bvec_iter iter;
+
+		/* Already remapped? */
+		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
+			break;
+
+		bip_for_each_vec(iv, bip, iter) {
+			unsigned int j;
+			void *p;
+
+			p = bvec_kmap_local(&iv);
+			for (j = 0; j < iv.bv_len; j += tuple_sz) {
+				struct nvme_crc64_pi_tuple *pi = p;
+				u64 ref = get_unaligned_be48(pi->ref_tag);
+
+				if (ref == virt)
+					put_unaligned_be48(ref_tag, pi->ref_tag);
+				virt++;
+				ref_tag++;
+				p += tuple_sz;
+			}
+			kunmap_local(p);
+		}
+
+		bip->bip_flags |= BIP_MAPPED_INTEGRITY;
+	}
+}
+
+static void nvme_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
+{
+	unsigned intervals = nr_bytes >> rq->q->integrity.interval_exp;
+	const int tuple_sz = rq->q->integrity.tuple_size;
+	u64 ref_tag = nvme_pi_extended_ref_tag(rq);
+	struct bio *bio;
+
+	__rq_for_each_bio(bio, rq) {
+		struct bio_integrity_payload *bip = bio_integrity(bio);
+		u64 virt = bip_get_seed(bip) & 0xffffffffffffull;
+		struct bio_vec iv;
+		struct bvec_iter iter;
+
+		bip_for_each_vec(iv, bip, iter) {
+			unsigned int j;
+			void *p;
+
+			p = bvec_kmap_local(&iv);
+			for (j = 0; j < iv.bv_len && intervals; j += tuple_sz) {
+				struct nvme_crc64_pi_tuple *pi = p;
+				u64 ref = get_unaligned_be48(pi->ref_tag);
+
+				if (ref == ref_tag)
+					put_unaligned_be48(virt, pi->ref_tag);
+				virt++;
+				ref_tag++;
+				intervals--;
+				p += tuple_sz;
+			}
+			kunmap_local(p);
+		}
+	}
+}
+
+static blk_status_t nvme_pi_type3_verify_crc(struct blk_integrity_iter *iter)
+{
+	return nvme_crc64_verify(iter, T10_PI_TYPE3_PROTECTION);
+}
+
+static blk_status_t nvme_pi_type3_generate_crc(struct blk_integrity_iter *iter)
+{
+	return nvme_crc64_generate(iter, T10_PI_TYPE3_PROTECTION);
+}
+
+const struct blk_integrity_profile nvme_pi_type1_crc64 = {
+	.name			= "NVME-DIF-TYPE1-CRC64",
+	.generate_fn		= nvme_pi_type1_generate_crc,
+	.verify_fn		= nvme_pi_type1_verify_crc,
+	.prepare_fn		= nvme_pi_type1_prepare,
+	.complete_fn		= nvme_pi_type1_complete,
+};
+EXPORT_SYMBOL(nvme_pi_type1_crc64);
+
+const struct blk_integrity_profile nvme_pi_type3_crc64 = {
+	.name			= "NVME-DIF-TYPE3-CRC64",
+	.generate_fn		= nvme_pi_type3_generate_crc,
+	.verify_fn		= nvme_pi_type3_verify_crc,
+	.prepare_fn		= t10_pi_type3_prepare,
+	.complete_fn		= t10_pi_type3_complete,
+};
+EXPORT_SYMBOL(nvme_pi_type3_crc64);
+
+MODULE_LICENSE("GPL");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index c635c2e014e3..86bc8713ca09 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -53,4 +53,24 @@ extern const struct blk_integrity_profile t10_pi_type1_ip;
 extern const struct blk_integrity_profile t10_pi_type3_crc;
 extern const struct blk_integrity_profile t10_pi_type3_ip;
 
+struct nvme_crc64_pi_tuple {
+	__be64 guard_tag;
+	__be16 app_tag;
+	__u8   ref_tag[6];
+};
+
+static inline u64 nvme_pi_extended_ref_tag(struct request *rq)
+{
+	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
+
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	if (rq->q->integrity.interval_exp)
+		shift = rq->q->integrity.interval_exp;
+#endif
+	return blk_rq_pos(rq) >> (shift - SECTOR_SHIFT) & 0xffffffffffffull;
+}
+
+extern const struct blk_integrity_profile nvme_pi_type1_crc64;
+extern const struct blk_integrity_profile nvme_pi_type3_crc64;
+
 #endif
-- 
2.25.4

