Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405C04C4A46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbiBYQPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242709AbiBYQPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:15:11 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A921A8CBD;
        Fri, 25 Feb 2022 08:14:34 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 56E4D68AA6; Fri, 25 Feb 2022 17:14:31 +0100 (CET)
Date:   Fri, 25 Feb 2022 17:14:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv3 08/10] block: add pi for nvme enhanced integrity
Message-ID: <20220225161430.GB13845@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org> <20220222163144.1782447-9-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-9-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:31:42AM -0800, Keith Busch wrote:
> +static __be64 nvme_pi_crc64(void *data, unsigned int len)
> +{
> +	return cpu_to_be64(crc64_rocksoft(data, len));
> +}
> +
> +static blk_status_t nvme_crc64_generate(struct blk_integrity_iter *iter,
> +					enum t10_dif_type type)

Shouldn't the naming be something more like ext_pi_*?  For one thing
I kinda hate having the nvme prefix here in block layer code, but also
nvme supports the normal 8 byte PI tuples, so this is a bit confusing.

> +{
> +	unsigned int i;
> +
> +	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
> +		struct nvme_crc64_pi_tuple *pi = iter->prot_buf;
> +
> +		pi->guard_tag = nvme_pi_crc64(iter->data_buf, iter->interval);
> +		pi->app_tag = 0;
> +
> +		if (type == T10_PI_TYPE1_PROTECTION)
> +			put_unaligned_be48(iter->seed, pi->ref_tag);
> +		else
> +			put_unaligned_be48(0ULL, pi->ref_tag);
> +
> +		iter->data_buf += iter->interval;
> +		iter->prot_buf += iter->tuple_size;
> +		iter->seed++;
> +	}
> +
> +	return BLK_STS_OK;
> +}
> +
> +static bool nvme_crc64_ref_escape(u8 *ref_tag)
> +{
> +	static u8 ref_escape[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
> +
> +	return memcmp(ref_tag, ref_escape, sizeof(ref_escape)) == 0;
> +}
> +
> +static blk_status_t nvme_crc64_verify(struct blk_integrity_iter *iter,
> +				      enum t10_dif_type type)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < iter->data_size; i += iter->interval) {
> +		struct nvme_crc64_pi_tuple *pi = iter->prot_buf;
> +		u64 ref, seed;
> +		__be64 csum;
> +
> +		if (type == T10_PI_TYPE1_PROTECTION) {
> +			if (pi->app_tag == T10_PI_APP_ESCAPE)
> +				goto next;
> +
> +			ref = get_unaligned_be48(pi->ref_tag);
> +			seed = lower_48_bits(iter->seed);
> +			if (ref != seed) {
> +				pr_err("%s: ref tag error at location %llu (rcvd %llu)\n",
> +					iter->disk_name, seed, ref);
> +				return BLK_STS_PROTECTION;
> +			}
> +		} else if (type == T10_PI_TYPE3_PROTECTION) {
> +			if (pi->app_tag == T10_PI_APP_ESCAPE &&
> +			    nvme_crc64_ref_escape(pi->ref_tag))
> +				goto next;
> +		}
> +
> +		csum = nvme_pi_crc64(iter->data_buf, iter->interval);
> +		if (pi->guard_tag != csum) {
> +			pr_err("%s: guard tag error at sector %llu " \
> +			       "(rcvd %016llx, want %016llx)\n",
> +				iter->disk_name, (unsigned long long)iter->seed,
> +				be64_to_cpu(pi->guard_tag), be64_to_cpu(csum));
> +			return BLK_STS_PROTECTION;
> +		}
> +
> +next:
> +		iter->data_buf += iter->interval;
> +		iter->prot_buf += iter->tuple_size;
> +		iter->seed++;
> +	}
> +
> +	return BLK_STS_OK;
> +}
> +
> +static blk_status_t nvme_pi_type1_verify_crc(struct blk_integrity_iter *iter)
> +{
> +	return nvme_crc64_verify(iter, T10_PI_TYPE1_PROTECTION);
> +}
> +
> +static blk_status_t nvme_pi_type1_generate_crc(struct blk_integrity_iter *iter)
> +{
> +	return nvme_crc64_generate(iter, T10_PI_TYPE1_PROTECTION);
> +}
> +
> +static void nvme_pi_type1_prepare(struct request *rq)
> +{
> +	const int tuple_sz = rq->q->integrity.tuple_size;
> +	u64 ref_tag = nvme_pi_extended_ref_tag(rq);
> +	struct bio *bio;
> +
> +	__rq_for_each_bio(bio, rq) {
> +		struct bio_integrity_payload *bip = bio_integrity(bio);
> +		u64 virt = lower_48_bits(bip_get_seed(bip));
> +		struct bio_vec iv;
> +		struct bvec_iter iter;
> +
> +		/* Already remapped? */
> +		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
> +			break;
> +
> +		bip_for_each_vec(iv, bip, iter) {
> +			unsigned int j;
> +			void *p;
> +
> +			p = bvec_kmap_local(&iv);
> +			for (j = 0; j < iv.bv_len; j += tuple_sz) {
> +				struct nvme_crc64_pi_tuple *pi = p;
> +				u64 ref = get_unaligned_be48(pi->ref_tag);
> +
> +				if (ref == virt)
> +					put_unaligned_be48(ref_tag, pi->ref_tag);
> +				virt++;
> +				ref_tag++;
> +				p += tuple_sz;
> +			}
> +			kunmap_local(p);
> +		}
> +
> +		bip->bip_flags |= BIP_MAPPED_INTEGRITY;
> +	}
> +}
> +
> +static void nvme_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
> +{
> +	unsigned intervals = nr_bytes >> rq->q->integrity.interval_exp;
> +	const int tuple_sz = rq->q->integrity.tuple_size;
> +	u64 ref_tag = nvme_pi_extended_ref_tag(rq);
> +	struct bio *bio;
> +
> +	__rq_for_each_bio(bio, rq) {
> +		struct bio_integrity_payload *bip = bio_integrity(bio);
> +		u64 virt = lower_48_bits(bip_get_seed(bip));
> +		struct bio_vec iv;
> +		struct bvec_iter iter;
> +
> +		bip_for_each_vec(iv, bip, iter) {
> +			unsigned int j;
> +			void *p;
> +
> +			p = bvec_kmap_local(&iv);
> +			for (j = 0; j < iv.bv_len && intervals; j += tuple_sz) {
> +				struct nvme_crc64_pi_tuple *pi = p;
> +				u64 ref = get_unaligned_be48(pi->ref_tag);
> +
> +				if (ref == ref_tag)
> +					put_unaligned_be48(virt, pi->ref_tag);
> +				virt++;
> +				ref_tag++;
> +				intervals--;
> +				p += tuple_sz;
> +			}
> +			kunmap_local(p);
> +		}
> +	}
> +}
> +
> +static blk_status_t nvme_pi_type3_verify_crc(struct blk_integrity_iter *iter)
> +{
> +	return nvme_crc64_verify(iter, T10_PI_TYPE3_PROTECTION);
> +}
> +
> +static blk_status_t nvme_pi_type3_generate_crc(struct blk_integrity_iter *iter)
> +{
> +	return nvme_crc64_generate(iter, T10_PI_TYPE3_PROTECTION);
> +}
> +
> +const struct blk_integrity_profile nvme_pi_type1_crc64 = {
> +	.name			= "NVME-DIF-TYPE1-CRC64",
> +	.generate_fn		= nvme_pi_type1_generate_crc,
> +	.verify_fn		= nvme_pi_type1_verify_crc,
> +	.prepare_fn		= nvme_pi_type1_prepare,
> +	.complete_fn		= nvme_pi_type1_complete,
> +};
> +EXPORT_SYMBOL(nvme_pi_type1_crc64);

All this should probably be EXPORT_SYMBOL_GPL (and I have a series
pending that would remove the exports of the profiles entirely,
but that will need some major rework after your series goes in).

The actual code looks fine to me.
