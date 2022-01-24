Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E14D49841B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbiAXQBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243317AbiAXQBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:01:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2AEC06173B;
        Mon, 24 Jan 2022 08:01:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DF5614CD;
        Mon, 24 Jan 2022 16:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB7AC340EB;
        Mon, 24 Jan 2022 16:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643040076;
        bh=WfkZALSOx0nEX3qkRMoH2FvIvarEJZb1UKptOmLJyqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OG2xgU5HfWIb63ZcvsiV1XrgajIpkAYZ95cNGijz6Gnt40Iy+nlslYVg0mi5PZU62
         p/IPE2fFVMLSP2BJZCCW/StCfunDWEcfQIKeqZRvc+muSvHIfi7b/pK7bfFxAk/Wbk
         m/n3mjMLD5/zR/85bbRS/09Otn/VWCEq4Ij088KGnSamd6hwXiEt7d3ZfsrXGsxJgT
         IvImm8BepKpmy/PJCDm5meG2b+saH5IsVt3s8+CFPPNMoxZoAKMt8iXjqMakKV6HMY
         nmvCjNIywUx50lbUcXiNQaAzDSgTvwSmuipRNMY5x6uMm73XKOyr60DD9C//v+cfkp
         Ha4MLbte1028w==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, arnd@arndb.de, Keith Busch <kbusch@kernel.org>
Subject: [RFC 7/7] nvme: add support for enhanced metadata
Date:   Mon, 24 Jan 2022 08:01:07 -0800
Message-Id: <20220124160107.1683901-8-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220124160107.1683901-1-kbusch@kernel.org>
References: <20220124160107.1683901-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVM Express ratified TP 4069 defines new protection information formats.
Implement support for the CRC64 guard tags.

Since the block layer doesn't support variable length reference tags,
driver support for the Storage Tag space is not supported at this time.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 164 +++++++++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h |   1 +
 include/linux/nvme.h     |  53 +++++++++++--
 3 files changed, 188 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b3eabf6a08b9..65534ed646e4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -882,6 +882,30 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_STS_OK;
 }
 
+static inline void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
+				    struct request *req)
+{
+	u32 upper, lower;
+	u64 ref48;
+
+	/* both rw and write zeroes share the same reftag format */
+	switch (ns->guard_type) {
+	case NVME_NVM_NS_16B_GUARD:
+		cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
+		break;
+	case NVME_NVM_NS_64B_GUARD:
+		ref48 = nvme_pi_extended_ref_tag(req);
+		lower = lower_32_bits(ref48);
+		upper = upper_32_bits(ref48);
+
+		cmnd->rw.reftag = cpu_to_le32(lower);
+		cmnd->rw.cdw3 = cpu_to_le32(upper);
+		break;
+	default:
+		break;
+	}
+}
+
 static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd)
 {
@@ -903,8 +927,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		switch (ns->pi_type) {
 		case NVME_NS_DPS_PI_TYPE1:
 		case NVME_NS_DPS_PI_TYPE2:
-			cmnd->write_zeroes.reftag =
-				cpu_to_le32(t10_pi_ref_tag(req));
+			nvme_set_ref_tag(ns, cmnd, req);
 			break;
 		}
 	}
@@ -931,7 +954,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	cmnd->rw.opcode = op;
 	cmnd->rw.flags = 0;
 	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
-	cmnd->rw.rsvd2 = 0;
+	cmnd->rw.cdw2 = 0;
+	cmnd->rw.cdw3 = 0;
 	cmnd->rw.metadata = 0;
 	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
@@ -965,7 +989,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 					NVME_RW_PRINFO_PRCHK_REF;
 			if (op == nvme_cmd_zone_append)
 				control |= NVME_RW_APPEND_PIREMAP;
-			cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
+			nvme_set_ref_tag(ns, cmnd, req);
 			break;
 		}
 	}
@@ -1619,33 +1643,58 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
+static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 				u32 max_integrity_segments)
 {
 	struct blk_integrity integrity = { };
 
-	switch (pi_type) {
+	switch (ns->pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
-		integrity.profile = &t10_pi_type3_crc;
-		integrity.tag_size = sizeof(u16) + sizeof(u32);
-		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+		switch (ns->guard_type) {
+		case NVME_NVM_NS_16B_GUARD:
+			integrity.profile = &t10_pi_type3_crc;
+			integrity.tag_size = sizeof(u16) + sizeof(u32);
+			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+			break;
+		case NVME_NVM_NS_64B_GUARD:
+			integrity.profile = &nvme_pi_type1_crc64;
+			integrity.tag_size = sizeof(u16) + 6;
+			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+			break;
+		default:
+			integrity.profile = NULL;
+			break;
+		}
 		break;
 	case NVME_NS_DPS_PI_TYPE1:
 	case NVME_NS_DPS_PI_TYPE2:
-		integrity.profile = &t10_pi_type1_crc;
-		integrity.tag_size = sizeof(u16);
-		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+		switch (ns->guard_type) {
+		case NVME_NVM_NS_16B_GUARD:
+			integrity.profile = &t10_pi_type1_crc;
+			integrity.tag_size = sizeof(u16);
+			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+			break;
+		case NVME_NVM_NS_64B_GUARD:
+			integrity.profile = &nvme_pi_type1_crc64;
+			integrity.tag_size = sizeof(u16);
+			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+			break;
+		default:
+			integrity.profile = NULL;
+			break;
+		}
 		break;
 	default:
 		integrity.profile = NULL;
 		break;
 	}
-	integrity.tuple_size = ms;
+
+	integrity.tuple_size = ns->ms;
 	blk_integrity_register(disk, &integrity);
 	blk_queue_max_integrity_segments(disk->queue, max_integrity_segments);
 }
 #else
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
+static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 				u32 max_integrity_segments)
 {
 }
@@ -1722,17 +1771,75 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return 0;
 }
 
-static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
+static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
+	bool first = id->dps & NVME_NS_DPS_PI_FIRST;
+	unsigned lbaf = nvme_lbaf_index(id->flbas);
 	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct nvme_command c = { };
+	struct nvme_id_ns_nvm *nvm;
+	u8 pi_size = 0;
+	int ret = 0;
+	u32 elbaf;
+
+	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	if (!(ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
+		pi_size = sizeof(struct t10_pi_tuple);
+		ns->guard_type = NVME_NVM_NS_16B_GUARD;
+		goto set_pi;
+	}
+
+	nvm = kzalloc(sizeof(*nvm), GFP_KERNEL);
+	if (!nvm)
+		return -ENOMEM;
 
-	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
-	if (id->dps & NVME_NS_DPS_PI_FIRST ||
-	    ns->ms == sizeof(struct t10_pi_tuple))
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.nsid = cpu_to_le32(ns->head->ns_id);
+	c.identify.cns = NVME_ID_CNS_CS_NS;
+	c.identify.csi = NVME_CSI_NVM;
+
+	ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, nvm, sizeof(*nvm));
+	if (ret)
+		goto free_data;
+
+	elbaf = cpu_to_le32(nvm->elbaf[lbaf]);
+
+	/* no support for storage tag formats right now */
+	if (nvme_elbaf_sts(elbaf))
+		goto free_data;
+
+	ns->guard_type = nvme_elbaf_guard_type(elbaf);
+	switch (ns->guard_type) {
+	case NVME_NVM_NS_64B_GUARD:
+		pi_size = sizeof(struct nvme_crc64_pi_tuple);
+		break;
+	case NVME_NVM_NS_16B_GUARD:
+		pi_size = sizeof(struct t10_pi_tuple);
+		break;
+	default:
+		break;
+	}
+
+free_data:
+	kfree(nvm);
+set_pi:
+	if (pi_size && (first || ns->ms == pi_size))
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
 	else
 		ns->pi_type = 0;
 
+	return ret;
+}
+
+static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	int ret;
+
+	ret = nvme_init_ms(ns, id);
+	if (ret)
+		return ret;
+
 	ns->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
 	if (!ns->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		return 0;
@@ -1850,7 +1957,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	if (ns->ms) {
 		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 		    (ns->features & NVME_NS_METADATA_SUPPORTED))
-			nvme_init_integrity(disk, ns->ms, ns->pi_type,
+			nvme_init_integrity(disk, ns,
 					    ns->ctrl->max_integrity_segments);
 		else if (!nvme_ns_has_pi(ns))
 			capacity = 0;
@@ -1905,7 +2012,7 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
-	unsigned lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
+	unsigned lbaf = nvme_lbaf_index(id->flbas);
 	int ret;
 
 	blk_mq_freeze_queue(ns->disk->queue);
@@ -2252,20 +2359,27 @@ static int nvme_configure_timestamp(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
-static int nvme_configure_acre(struct nvme_ctrl *ctrl)
+static int nvme_configure_host_options(struct nvme_ctrl *ctrl)
 {
 	struct nvme_feat_host_behavior *host;
+	u8 acre = 0, lbafee = 0;
 	int ret;
 
 	/* Don't bother enabling the feature if retry delay is not reported */
-	if (!ctrl->crdt[0])
+	if (ctrl->crdt[0])
+		acre = NVME_ENABLE_ACRE;
+	if (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)
+		lbafee = NVME_ENABLE_LBAFEE;
+
+	if (!acre && !lbafee)
 		return 0;
 
 	host = kzalloc(sizeof(*host), GFP_KERNEL);
 	if (!host)
 		return 0;
 
-	host->acre = NVME_ENABLE_ACRE;
+	host->acre = acre;
+	host->lbafee = lbafee;
 	ret = nvme_set_features(ctrl, NVME_FEAT_HOST_BEHAVIOR, 0,
 				host, sizeof(*host), NULL);
 	kfree(host);
@@ -3104,7 +3218,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
-	ret = nvme_configure_acre(ctrl);
+	ret = nvme_configure_host_options(ctrl);
 	if (ret < 0)
 		return ret;
 
@@ -4725,12 +4839,14 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns_zns) != NVME_IDENTIFY_DATA_SIZE);
+	BUILD_BUG_ON(sizeof(struct nvme_id_ns_nvm) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_zns) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_nvm) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_feat_host_behavior) != 512);
 }
 
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a162f6c6da6e..175a2a5fbd73 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -455,6 +455,7 @@ struct nvme_ns {
 	u16 sgs;
 	u32 sws;
 	u8 pi_type;
+	u8 guard_type;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64 zsze;
 #endif
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 855dd9b3e84b..4342b7eed3e2 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -238,6 +238,7 @@ enum {
 enum nvme_ctrl_attr {
 	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
 	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
+	NVME_CTRL_ATTR_ELBAS		= (1 << 15),
 };
 
 struct nvme_id_ctrl {
@@ -391,8 +392,7 @@ struct nvme_id_ns {
 	__le16			endgid;
 	__u8			nguid[16];
 	__u8			eui64[8];
-	struct nvme_lbaf	lbaf[16];
-	__u8			rsvd192[192];
+	struct nvme_lbaf	lbaf[64];
 	__u8			vs[3712];
 };
 
@@ -410,8 +410,7 @@ struct nvme_id_ns_zns {
 	__le32			rrl;
 	__le32			frl;
 	__u8			rsvd20[2796];
-	struct nvme_zns_lbafe	lbafe[16];
-	__u8			rsvd3072[768];
+	struct nvme_zns_lbafe	lbafe[64];
 	__u8			vs[256];
 };
 
@@ -420,6 +419,30 @@ struct nvme_id_ctrl_zns {
 	__u8	rsvd1[4095];
 };
 
+struct nvme_id_ns_nvm {
+	__le64	lbstm;
+	__u8	pic;
+	__u8	rsvd9[3];
+	__le32	elbaf[64];
+	__u8	rsvd268[3828];
+};
+
+enum {
+	NVME_ID_NS_NVM_STS_MASK		= 0x3f,
+	NVME_ID_NS_NVM_GUARD_SHIFT	= 7,
+	NVME_ID_NS_NVM_GUARD_MASK	= 0x3,
+};
+
+static inline __u8 nvme_elbaf_sts(__u32 elbaf)
+{
+	return elbaf & NVME_ID_NS_NVM_STS_MASK;
+}
+
+static inline __u8 nvme_elbaf_guard_type(__u32 elbaf)
+{
+	return (elbaf >> NVME_ID_NS_NVM_GUARD_SHIFT) & NVME_ID_NS_NVM_GUARD_MASK;
+}
+
 struct nvme_id_ctrl_nvm {
 	__u8	vsl;
 	__u8	wzsl;
@@ -470,6 +493,8 @@ enum {
 	NVME_NS_FEAT_IO_OPT	= 1 << 4,
 	NVME_NS_ATTR_RO		= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
+	NVME_NS_FLBAS_LBA_UMASK	= 0x60,
+	NVME_NS_FLBAS_LBA_SHIFT	= 1,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
 	NVME_NS_NMIC_SHARED	= 1 << 0,
 	NVME_LBAF_RP_BEST	= 0,
@@ -488,6 +513,18 @@ enum {
 	NVME_NS_DPS_PI_TYPE3	= 3,
 };
 
+enum {
+	NVME_NVM_NS_16B_GUARD	= 0,
+	NVME_NVM_NS_32B_GUARD	= 1,
+	NVME_NVM_NS_64B_GUARD	= 2,
+};
+
+static inline __u8 nvme_lbaf_index(__u8 flbas)
+{
+	return (flbas & NVME_NS_FLBAS_LBA_MASK) |
+		((flbas & NVME_NS_FLBAS_LBA_UMASK) >> NVME_NS_FLBAS_LBA_SHIFT);
+}
+
 /* Identify Namespace Metadata Capabilities (MC): */
 enum {
 	NVME_MC_EXTENDED_LBA	= (1 << 0),
@@ -834,7 +871,8 @@ struct nvme_rw_command {
 	__u8			flags;
 	__u16			command_id;
 	__le32			nsid;
-	__u64			rsvd2;
+	__le32			cdw2;
+	__le32			cdw3;
 	__le64			metadata;
 	union nvme_data_ptr	dptr;
 	__le64			slba;
@@ -988,11 +1026,14 @@ enum {
 
 struct nvme_feat_host_behavior {
 	__u8 acre;
-	__u8 resv1[511];
+	__u8 etdas;
+	__u8 lbafee;
+	__u8 resv1[509];
 };
 
 enum {
 	NVME_ENABLE_ACRE	= 1,
+	NVME_ENABLE_LBAFEE	= 1,
 };
 
 /* Admin commands */
-- 
2.25.4

