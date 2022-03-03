Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE14C4CC6F0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiCCUOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbiCCUOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:14:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C35DE338B;
        Thu,  3 Mar 2022 12:13:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10CD2B826D6;
        Thu,  3 Mar 2022 20:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A20FC340F0;
        Thu,  3 Mar 2022 20:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646338402;
        bh=dZHO/p8m6MQnWypS2pJPnPpbeNRInxd98s66q6Un0f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pcno6l7yPs0otaY3tm21UOlhns4o7maAmvxOt9E1LJxsPRViirUV8P0a432upgcgE
         mHblwxgFIl9n9DVXlGHcJ0DbHZb/M+JcfYvcpmEVWN5mvDtyt0cbsBdCzA4eUyi17G
         JplsI285PZyzzbRusy9ryZInrUpBlpVjdTJ/iMfhjJfnf3vvTJzM4YNVQ8byHhiIuu
         ypwUc+SNu+2Uc81KqxyYm8Lmes4K2U7rH6xprgjHHahSo07+pnab1hdZQEXMN+Y14/
         NJw1EoJaScx/kK3T+FPh+zb4sYuy2D3lQ9rKZiVs58gP5i2Wn9mUQ/0QVDb80Pis1c
         JkFqeUb3eOsvg==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4 7/8] block: add pi for extended integrity
Date:   Thu,  3 Mar 2022 12:13:11 -0800
Message-Id: <20220303201312.3255347-8-kbusch@kernel.org>
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

The NVMe specification defines new data integrity formats beyond the
t10 tuple. Add support for the specification defined CRC64 formats,
assuming the reference tag does not need to be split with the "storage
tag".

Cc: Hannes Reinecke <hare@suse.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v3->v4:

  Renamed nvme_ prefixes with ext_ for extended protection information.

  Use _GPL for EXPORT_SYMBOL

 block/Kconfig          |   1 +
 block/t10-pi.c         | 194 +++++++++++++++++++++++++++++++++++++++++
 include/linux/t10-pi.h |  20 +++++
 3 files changed, 215 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 7eb5d6d53b3f..50b17e260fa2 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -73,6 +73,7 @@ config BLK_DEV_INTEGRITY_T10
 	tristate
 	depends on BLK_DEV_INTEGRITY
 	select CRC_T10DIF
+	select CRC64_ROCKSOFT
 
 config BLK_DEV_ZONED
 	bool "Zoned block device support"
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 758a76518854..3c35266edb66 100644
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
 
+static __be64 ext_pi_crc64(void *data, unsigned int len)
+{
+	return cpu_to_be64(crc64_rocksoft(data, len));
+}
+
+static blk_status_t ext_pi_crc64_generate(struct blk_integrity_iter *iter,
+					enum t10_dif_type type)
+{
+	unsigned int i;
+
+	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
+		struct crc64_pi_tuple *pi = iter->prot_buf;
+
+		pi->guard_tag = ext_pi_crc64(iter->data_buf, iter->interval);
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
+static bool ext_pi_ref_escape(u8 *ref_tag)
+{
+	static u8 ref_escape[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+
+	return memcmp(ref_tag, ref_escape, sizeof(ref_escape)) == 0;
+}
+
+static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
+				      enum t10_dif_type type)
+{
+	unsigned int i;
+
+	for (i = 0; i < iter->data_size; i += iter->interval) {
+		struct crc64_pi_tuple *pi = iter->prot_buf;
+		u64 ref, seed;
+		__be64 csum;
+
+		if (type == T10_PI_TYPE1_PROTECTION) {
+			if (pi->app_tag == T10_PI_APP_ESCAPE)
+				goto next;
+
+			ref = get_unaligned_be48(pi->ref_tag);
+			seed = lower_48_bits(iter->seed);
+			if (ref != seed) {
+				pr_err("%s: ref tag error at location %llu (rcvd %llu)\n",
+					iter->disk_name, seed, ref);
+				return BLK_STS_PROTECTION;
+			}
+		} else if (type == T10_PI_TYPE3_PROTECTION) {
+			if (pi->app_tag == T10_PI_APP_ESCAPE &&
+			    ext_pi_ref_escape(pi->ref_tag))
+				goto next;
+		}
+
+		csum = ext_pi_crc64(iter->data_buf, iter->interval);
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
+static blk_status_t ext_pi_type1_verify_crc64(struct blk_integrity_iter *iter)
+{
+	return ext_pi_crc64_verify(iter, T10_PI_TYPE1_PROTECTION);
+}
+
+static blk_status_t ext_pi_type1_generate_crc64(struct blk_integrity_iter *iter)
+{
+	return ext_pi_crc64_generate(iter, T10_PI_TYPE1_PROTECTION);
+}
+
+static void ext_pi_type1_prepare(struct request *rq)
+{
+	const int tuple_sz = rq->q->integrity.tuple_size;
+	u64 ref_tag = ext_pi_ref_tag(rq);
+	struct bio *bio;
+
+	__rq_for_each_bio(bio, rq) {
+		struct bio_integrity_payload *bip = bio_integrity(bio);
+		u64 virt = lower_48_bits(bip_get_seed(bip));
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
+				struct crc64_pi_tuple *pi = p;
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
+static void ext_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
+{
+	unsigned intervals = nr_bytes >> rq->q->integrity.interval_exp;
+	const int tuple_sz = rq->q->integrity.tuple_size;
+	u64 ref_tag = ext_pi_ref_tag(rq);
+	struct bio *bio;
+
+	__rq_for_each_bio(bio, rq) {
+		struct bio_integrity_payload *bip = bio_integrity(bio);
+		u64 virt = lower_48_bits(bip_get_seed(bip));
+		struct bio_vec iv;
+		struct bvec_iter iter;
+
+		bip_for_each_vec(iv, bip, iter) {
+			unsigned int j;
+			void *p;
+
+			p = bvec_kmap_local(&iv);
+			for (j = 0; j < iv.bv_len && intervals; j += tuple_sz) {
+				struct crc64_pi_tuple *pi = p;
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
+static blk_status_t ext_pi_type3_verify_crc64(struct blk_integrity_iter *iter)
+{
+	return ext_pi_crc64_verify(iter, T10_PI_TYPE3_PROTECTION);
+}
+
+static blk_status_t ext_pi_type3_generate_crc64(struct blk_integrity_iter *iter)
+{
+	return ext_pi_crc64_generate(iter, T10_PI_TYPE3_PROTECTION);
+}
+
+const struct blk_integrity_profile ext_pi_type1_crc64 = {
+	.name			= "EXT-DIF-TYPE1-CRC64",
+	.generate_fn		= ext_pi_type1_generate_crc64,
+	.verify_fn		= ext_pi_type1_verify_crc64,
+	.prepare_fn		= ext_pi_type1_prepare,
+	.complete_fn		= ext_pi_type1_complete,
+};
+EXPORT_SYMBOL_GPL(ext_pi_type1_crc64);
+
+const struct blk_integrity_profile ext_pi_type3_crc64 = {
+	.name			= "EXT-DIF-TYPE3-CRC64",
+	.generate_fn		= ext_pi_type3_generate_crc64,
+	.verify_fn		= ext_pi_type3_verify_crc64,
+	.prepare_fn		= t10_pi_type3_prepare,
+	.complete_fn		= t10_pi_type3_complete,
+};
+EXPORT_SYMBOL_GPL(ext_pi_type3_crc64);
+
+MODULE_LICENSE("GPL");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index c635c2e014e3..bc2c365373b9 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -53,4 +53,24 @@ extern const struct blk_integrity_profile t10_pi_type1_ip;
 extern const struct blk_integrity_profile t10_pi_type3_crc;
 extern const struct blk_integrity_profile t10_pi_type3_ip;
 
+struct crc64_pi_tuple {
+	__be64 guard_tag;
+	__be16 app_tag;
+	__u8   ref_tag[6];
+};
+
+static inline u64 ext_pi_ref_tag(struct request *rq)
+{
+	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
+
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	if (rq->q->integrity.interval_exp)
+		shift = rq->q->integrity.interval_exp;
+#endif
+	return lower_48_bits(blk_rq_pos(rq) >> (shift - SECTOR_SHIFT));
+}
+
+extern const struct blk_integrity_profile ext_pi_type1_crc64;
+extern const struct blk_integrity_profile ext_pi_type3_crc64;
+
 #endif
-- 
2.25.4

