Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450CD4A718B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbiBBN24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:28:56 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58812 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiBBN2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:28:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0B39421102;
        Wed,  2 Feb 2022 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643808534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9XXKwvO24uMBewNpHPFTTO8vC3ThEEYknt9VQhf7zc=;
        b=panfiLd3pE3lvM74jfkQcq32ueoWnfhWSDyFpAWLm6LbYxYjqrBKj8KsZ2v+ihOVwrQkQ8
        W2ULOW8Fy85/k8YCvNsILQDg77A35H3K0/nLR2VULwhiOAXGdTsXmWR7ctG1i1Slg2h4T3
        G1zuX2CIzu/RwbE2PzJqmqcX2QOJQLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643808534;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9XXKwvO24uMBewNpHPFTTO8vC3ThEEYknt9VQhf7zc=;
        b=5og7yd6fKpXswHyNUsIDOEWoAv7YOJCYyjUe3YdLj5ATHR3ZKegbOKWXGW9c3TgKo5pADf
        J36Arpt+zlnYtDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE48E13E48;
        Wed,  2 Feb 2022 13:28:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u2bmORWH+mHBSAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 13:28:53 +0000
Message-ID: <aaf56d4b-8554-e677-119e-9d23c921fe0a@suse.de>
Date:   Wed, 2 Feb 2022 14:28:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-8-kbusch@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2 7/7] nvme: add support for enhanced metadata
In-Reply-To: <20220201190128.3075065-8-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 20:01, Keith Busch wrote:
> NVM Express ratified TP 4069 defines new protection information formats.
> Implement support for the CRC64 guard tags.
> 
> Since the block layer doesn't support variable length reference tags,
> driver support for the Storage Tag space is not supported at this time.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>    Added support for PRACT
> 
>    Fixed endian conversion
> 
>   drivers/nvme/host/core.c | 164 +++++++++++++++++++++++++++++++++------
>   drivers/nvme/host/nvme.h |   4 +-
>   include/linux/nvme.h     |  53 +++++++++++--
>   3 files changed, 190 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b3eabf6a08b9..0f2ea2a4c718 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -882,6 +882,30 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>   	return BLK_STS_OK;
>   }
>   
> +static inline void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
> +				    struct request *req)
> +{
> +	u32 upper, lower;
> +	u64 ref48;
> +
> +	/* both rw and write zeroes share the same reftag format */
> +	switch (ns->guard_type) {
> +	case NVME_NVM_NS_16B_GUARD:
> +		cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
> +		break;
> +	case NVME_NVM_NS_64B_GUARD:
> +		ref48 = nvme_pi_extended_ref_tag(req);
> +		lower = lower_32_bits(ref48);
> +		upper = upper_32_bits(ref48);
> +
> +		cmnd->rw.reftag = cpu_to_le32(lower);
> +		cmnd->rw.cdw3 = cpu_to_le32(upper);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>   static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
>   		struct request *req, struct nvme_command *cmnd)
>   {
> @@ -903,8 +927,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
>   		switch (ns->pi_type) {
>   		case NVME_NS_DPS_PI_TYPE1:
>   		case NVME_NS_DPS_PI_TYPE2:
> -			cmnd->write_zeroes.reftag =
> -				cpu_to_le32(t10_pi_ref_tag(req));
> +			nvme_set_ref_tag(ns, cmnd, req);
>   			break;
>   		}
>   	}
> @@ -931,7 +954,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>   	cmnd->rw.opcode = op;
>   	cmnd->rw.flags = 0;
>   	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
> -	cmnd->rw.rsvd2 = 0;
> +	cmnd->rw.cdw2 = 0;
> +	cmnd->rw.cdw3 = 0;
>   	cmnd->rw.metadata = 0;
>   	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
>   	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
> @@ -965,7 +989,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>   					NVME_RW_PRINFO_PRCHK_REF;
>   			if (op == nvme_cmd_zone_append)
>   				control |= NVME_RW_APPEND_PIREMAP;
> -			cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
> +			nvme_set_ref_tag(ns, cmnd, req);
>   			break;
>   		}
>   	}
> @@ -1619,33 +1643,58 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>   }
>   
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
> -static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
> +static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
>   				u32 max_integrity_segments)
>   {
>   	struct blk_integrity integrity = { };
>   
> -	switch (pi_type) {
> +	switch (ns->pi_type) {
>   	case NVME_NS_DPS_PI_TYPE3:
> -		integrity.profile = &t10_pi_type3_crc;
> -		integrity.tag_size = sizeof(u16) + sizeof(u32);
> -		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> +		switch (ns->guard_type) {
> +		case NVME_NVM_NS_16B_GUARD:
> +			integrity.profile = &t10_pi_type3_crc;
> +			integrity.tag_size = sizeof(u16) + sizeof(u32);
> +			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> +			break;
> +		case NVME_NVM_NS_64B_GUARD:
> +			integrity.profile = &nvme_pi_type1_crc64;
> +			integrity.tag_size = sizeof(u16) + 6;
> +			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> +			break;
> +		default:
> +			integrity.profile = NULL;
> +			break;
> +		}
>   		break;
>   	case NVME_NS_DPS_PI_TYPE1:
>   	case NVME_NS_DPS_PI_TYPE2:
> -		integrity.profile = &t10_pi_type1_crc;
> -		integrity.tag_size = sizeof(u16);
> -		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> +		switch (ns->guard_type) {
> +		case NVME_NVM_NS_16B_GUARD:
> +			integrity.profile = &t10_pi_type1_crc;
> +			integrity.tag_size = sizeof(u16);
> +			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> +			break;
> +		case NVME_NVM_NS_64B_GUARD:
> +			integrity.profile = &nvme_pi_type1_crc64;
> +			integrity.tag_size = sizeof(u16);

Is that correct? Shouldn't it be '8' like in the above case?

> +			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> +			break;
> +		default:
> +			integrity.profile = NULL;
> +			break;
> +		}
>   		break;
>   	default:
>   		integrity.profile = NULL;
>   		break;
>   	}
> -	integrity.tuple_size = ms;
> +
> +	integrity.tuple_size = ns->ms;
>   	blk_integrity_register(disk, &integrity);
>   	blk_queue_max_integrity_segments(disk->queue, max_integrity_segments);
>   }
>   #else
> -static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
> +static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
>   				u32 max_integrity_segments)
>   {
>   }
> @@ -1722,17 +1771,75 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>   	return 0;
>   }
>   
> -static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
> +static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
>   {
> +	bool first = id->dps & NVME_NS_DPS_PI_FIRST;
> +	unsigned lbaf = nvme_lbaf_index(id->flbas);
>   	struct nvme_ctrl *ctrl = ns->ctrl;
> +	struct nvme_command c = { };
> +	struct nvme_id_ns_nvm *nvm;
> +	int ret = 0;
> +	u32 elbaf;
> +
> +	ns->pi_size = 0;
> +	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
> +	if (!(ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
> +		ns->pi_size = sizeof(struct t10_pi_tuple);
> +		ns->guard_type = NVME_NVM_NS_16B_GUARD;
> +		goto set_pi;
> +	}
>   
> -	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
> -	if (id->dps & NVME_NS_DPS_PI_FIRST ||
> -	    ns->ms == sizeof(struct t10_pi_tuple))
> +	nvm = kzalloc(sizeof(*nvm), GFP_KERNEL);
> +	if (!nvm)
> +		return -ENOMEM;
> +
> +	c.identify.opcode = nvme_admin_identify;
> +	c.identify.nsid = cpu_to_le32(ns->head->ns_id);
> +	c.identify.cns = NVME_ID_CNS_CS_NS;
> +	c.identify.csi = NVME_CSI_NVM;
> +
> +	ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, nvm, sizeof(*nvm));
> +	if (ret)
> +		goto free_data;
> +
> +	elbaf = le32_to_cpu(nvm->elbaf[lbaf]);
> +
> +	/* no support for storage tag formats right now */
> +	if (nvme_elbaf_sts(elbaf))
> +		goto free_data;
> +
> +	ns->guard_type = nvme_elbaf_guard_type(elbaf);
> +	switch (ns->guard_type) {
> +	case NVME_NVM_NS_64B_GUARD:
> +		ns->pi_size = sizeof(struct nvme_crc64_pi_tuple);
> +		break;
> +	case NVME_NVM_NS_16B_GUARD:
> +		ns->pi_size = sizeof(struct t10_pi_tuple);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +free_data:
> +	kfree(nvm);
> +set_pi:
> +	if (ns->pi_size && (first || ns->ms == ns->pi_size))
>   		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
>   	else
>   		ns->pi_type = 0;
>   
> +	return ret;
> +}
> +
> +static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
> +{
> +	struct nvme_ctrl *ctrl = ns->ctrl;
> +	int ret;
> +
> +	ret = nvme_init_ms(ns, id);
> +	if (ret)
> +		return ret;
> +
>   	ns->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
>   	if (!ns->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
>   		return 0;
> @@ -1850,7 +1957,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   	if (ns->ms) {
>   		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
>   		    (ns->features & NVME_NS_METADATA_SUPPORTED))
> -			nvme_init_integrity(disk, ns->ms, ns->pi_type,
> +			nvme_init_integrity(disk, ns,
>   					    ns->ctrl->max_integrity_segments);
>   		else if (!nvme_ns_has_pi(ns))
>   			capacity = 0;
> @@ -1905,7 +2012,7 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
>   
>   static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>   {
> -	unsigned lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
> +	unsigned lbaf = nvme_lbaf_index(id->flbas);
>   	int ret;
>   
>   	blk_mq_freeze_queue(ns->disk->queue);
> @@ -2252,20 +2359,27 @@ static int nvme_configure_timestamp(struct nvme_ctrl *ctrl)
>   	return ret;
>   }
>   
> -static int nvme_configure_acre(struct nvme_ctrl *ctrl)
> +static int nvme_configure_host_options(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_feat_host_behavior *host;
> +	u8 acre = 0, lbafee = 0;
>   	int ret;
>   
>   	/* Don't bother enabling the feature if retry delay is not reported */
> -	if (!ctrl->crdt[0])
> +	if (ctrl->crdt[0])
> +		acre = NVME_ENABLE_ACRE;
> +	if (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)
> +		lbafee = NVME_ENABLE_LBAFEE;
> +
> +	if (!acre && !lbafee)
>   		return 0;
>   
>   	host = kzalloc(sizeof(*host), GFP_KERNEL);
>   	if (!host)
>   		return 0;
>   
> -	host->acre = NVME_ENABLE_ACRE;
> +	host->acre = acre;
> +	host->lbafee = lbafee;
>   	ret = nvme_set_features(ctrl, NVME_FEAT_HOST_BEHAVIOR, 0,
>   				host, sizeof(*host), NULL);
>   	kfree(host);
> @@ -3104,7 +3218,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = nvme_configure_acre(ctrl);
> +	ret = nvme_configure_host_options(ctrl);
>   	if (ret < 0)
>   		return ret;
>   

This could be made into a separate patch, is it's not directly related 
to PI support.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
