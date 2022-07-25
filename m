Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE3B57F9AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiGYGyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiGYGxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:53:23 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969E311167
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:53:17 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220725065312epoutp0317aec46d73a2d20350fd8496bb91753d~E--Vgku4H1883918839epoutp03H
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:53:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220725065312epoutp0317aec46d73a2d20350fd8496bb91753d~E--Vgku4H1883918839epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658731992;
        bh=H0+wVrmWLntwjNtL4TI+cL/Qy+oVhUN3pKVTaOgaK/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1xtSjq6MnvtI+2Ak2sQaZF8ZE9lrZ0q5FjFb1+wjPH//DkOpTjMAHArkzw3/qUWS
         xVWTv3UcnpvjysOSqy5vIVcToi9Rw4/dXnjuidbqGBYcP8oklJHrIjWne+a8wZKgU1
         PKgBfP7BCtS0DqGGXtHp56UhBlJun/5ROwlfbH4w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220725065311epcas1p1368da281c2a7efb2497abc989952a257~E--VL_pOQ1456714567epcas1p19;
        Mon, 25 Jul 2022 06:53:11 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.231]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LrrN63Dglz4x9Px; Mon, 25 Jul
        2022 06:53:10 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.29.09657.6DD3ED26; Mon, 25 Jul 2022 15:53:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220725065310epcas1p2ae58294d9cf44e622ed8cc7e5a8b988c~E--TqyH120114001140epcas1p2k;
        Mon, 25 Jul 2022 06:53:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220725065310epsmtrp22a939915071a0aef8b18134a35176fb6~E--Tpvu0x0777907779epsmtrp2R;
        Mon, 25 Jul 2022 06:53:10 +0000 (GMT)
X-AuditID: b6c32a35-f4312a80000025b9-ca-62de3dd60405
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.C2.08905.6DD3ED26; Mon, 25 Jul 2022 15:53:10 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220725065309epsmtip2a871b1d3fe3e2b4dc2a6aacd3f0a6516~E--TZNC5U2537425374epsmtip2W;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     yelini.jeong@samsung.com, myungjoo.ham@samsung.com,
        Jiho Chu <jiho.chu@samsung.com>
Subject: [PATCH 7/9] trinity: Add profile module
Date:   Mon, 25 Jul 2022 15:53:06 +0900
Message-Id: <20220725065308.2457024-8-jiho.chu@samsung.com>
In-Reply-To: <20220725065308.2457024-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmnu4123tJBvcfSFj8nXSM3aJ58Xo2
        i/fdu5ktLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixf+4ado++LasYPT5vkgtgicq2yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fLSy2xMjQwMDIFKkzIzrj9opGlYNVe
        xooFL7IaGOfPZuxi5OCQEDCR2HutqIuRi0NIYAejxM2mV0wQzidGic6nc6Gcb4wSj2YcBHI4
        wTrOHfrBApHYyyhx/vYNqKrPjBJT216zglSxCahKzJyxhh3EFhHwlpjf2sUEso9ZIFLi2ooq
        kLCwgIHE5XvT2EBsFqDyd4cngLXyClhL7Jk6nwXE5hSwkVjwYzczRFxQ4uTMJ2BxZgF5ieat
        s5lB9koInGOXaHr8HOo6F4kJj9ayQ9jCEq+Ob4GypSQ+v9vLBmFnS0zpWMQCYRdInHu+lRkS
        FsYSF1ekQJypKbF+lz5EhaLEzt9zGSHW8km8+9rDClHNK9HRJgRRoiSx5M9hqEUSElNnfIM6
        xkNiyqnT0KDqZ5Ro2jeHeQKj/Cwk38xC8s0shM0LGJlXMYqlFhTnpqcWGxYYwiM1OT93EyM4
        /WmZ7mCc+PaD3iFGJg7GQ4wSHMxKIrxdabeThHhTEiurUovy44tKc1KLDzGaAsN3IrOUaHI+
        MAHnlcQbmlgamJgZGZtYGJoZKonzrpp2OlFIID2xJDU7NbUgtQimj4mDU6qBaaG022LnKtvJ
        fZe/uE4XLC+rvnv82uycC0/vXN7f/rfsSuf+vywHROYcSpz6KSXpl+9cwW5RHcWIn9Ju2y5P
        jJ/5YVfutLA5h3Knhvx1TCsp4d01O/D7/Q02qc/bcldUp6mbHbR5PD1LsSZgwfL9spM2O/57
        sXzKtl97uM4WsDKdXM3z/Tb73zv32EpeFfO9/XbSR2mp7pnQz7HPy+cWMna0TlMx/DTzb8aE
        7yGC/w4lTSx7wHT0xXKd5z8z7TaYrzi0j4l1uS3blIop5xYF7L1hW/hljdCG/pXbVvXtVWh6
        HWq77BlDGofgu8nZV5f9MJ7ep23a9/LugVT5zr+zq76u+XYxZv9k+aROu83pW/4nKLEUZyQa
        ajEXFScCAGJoXVcIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvO4123tJBpPXMlv8nXSM3aJ58Xo2
        i/fdu5ktLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixf+4ado++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKuP2ikaVg1V7GigUvshoY589m7GLk5JAQMJE4d+gHSxcjF4eQwG5GieM7VrNBJCQk
        Nt1bztzFyAFkC0scPlwMUfORUeJ+10JmkBo2AVWJmTPWsIPYIgL+En8/HWMFsZkFoiVWb7vP
        AmILCxhIXL43DWwmC1D9u8MTwGp4Bawl9kydD1bDKWAjseDHbrCZQkDx/q4TUDWCEidnPmGB
        mCkv0bx1NvMERv5ZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDlUt
        zR2M21d90DvEyMTBeIhRgoNZSYS3K+12khBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE
        0hNLUrNTUwtSi2CyTBycUg1MC7dNkRXmU5suKFB6oibq35TuL20B3h4rA1+eiPc47XPWSMGW
        e3Vp6OPrjQvkXMoKPiw7OflTsF1nU2Z+2Nno9QctJlYVp7SZ8f5qmMdq8GbN1AkPZ660nv1+
        ftH3+0vP2L+6vPF/R9qS0xPnd6zbxRtuI7OI59Si0wlbgtwFm9MYpgQ07JgTx3BG5KLSZUZB
        n/P/uG81FB9j2LIqSC0kaM+jVXdnCytlftN8elSYR1/6fp9oxYm6s40La1X2Nec9OGjENjPD
        JFvM7bZhyZuXn6vTZ91fFXq0eJ6AvUX2AuHYsLuNJ1J80pelfPt3kM2tN1HzponG7Bd770ra
        XDut/fhXm8/ORtNvh5LsdD1eKbEUZyQaajEXFScCAN+lWpDEAgAA
X-CMS-MailID: 20220725065310epcas1p2ae58294d9cf44e622ed8cc7e5a8b988c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065310epcas1p2ae58294d9cf44e622ed8cc7e5a8b988c
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
        <CGME20220725065310epcas1p2ae58294d9cf44e622ed8cc7e5a8b988c@epcas1p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for profile module.

The samsung NPU provides internal statistics data,
and it includes memory read/write counts, consumed clock
cycle for each operation. This statistics can be read by
ioctl control command.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/trinity_vision2_drv.c    | 467 +++++++++++++++++-
 .../misc/trinity/trinity_vision2_profile.h    | 324 ++++++++++++
 2 files changed, 771 insertions(+), 20 deletions(-)
 create mode 100644 drivers/misc/trinity/trinity_vision2_profile.h

diff --git a/drivers/misc/trinity/trinity_vision2_drv.c b/drivers/misc/trinity/trinity_vision2_drv.c
index ddc1739afdd8..539eadeca09d 100644
--- a/drivers/misc/trinity/trinity_vision2_drv.c
+++ b/drivers/misc/trinity/trinity_vision2_drv.c
@@ -177,31 +177,154 @@ static int triv2_idu_load(struct trinity_driver *drv, const char *dirpath,
 
 static LIST_HEAD(triv2_driver_list);
 static struct hlist_bl_head triv2_model_node_hlist[TRIV2_MODEL_HASH_SIZE];
+static const char * const triv2_op_names[] = TRIV2_FOREACH_OPNAME(TRIV2_GENERATE_OPNAME);
 
 static struct triv2_profile *
 triv2_find_profile(const struct trinity_driver *drv, int req_id)
 {
-	/* find profile */
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	unsigned long key = TRIV2_PROFILE_HASH_KEY(req_id);
+	struct triv2_profile *profile = NULL;
+
+	hash_for_each_possible(pdata->prof_htable, profile, hlist, key) {
+		if (profile->req_id == req_id)
+			break;
+	}
 
-	return NULL;
+	return profile;
 }
 
 static void triv2_fini_profile(struct trinity_resv_mem *prof_buf)
 {
-	/* finish profile */
+	if (!prof_buf->vaddr)
+		return;
+
+	trinity_free_from_resv_mem(prof_buf, false);
+	memset(prof_buf, '\x00', sizeof(*prof_buf));
 }
 
 static void triv2_init_profile(struct trinity_driver *drv,
 			       unsigned long profile_size)
 {
-	/* init profile */
+	struct device *dev = drv_to_dev_ptr(drv);
+	struct trinity_resv_mem *prof_buf = TRIV2_DRV_GET_PROF_BUF(drv);
+
+	if (profile_size > 0) {
+		/* allocate profile buffer and enable it */
+		struct iommu_domain *domain;
+		phys_addr_t paddr;
+		int status;
+
+		triv2_fini_profile(prof_buf);
+
+		profile_size = PAGE_ALIGN(profile_size);
+		status = trinity_alloc_from_resv_mem(profile_size, prof_buf,
+						     false);
+		if (status < 0) {
+			dev_err(dev,
+				"Couldn't allocate memory for profiling buffer: %d",
+				status);
+			return;
+		}
+
+		domain = iommu_get_domain_for_dev(drv_to_dev_ptr(drv));
+		paddr = trinity_get_paddr(domain, prof_buf->daddr);
+		iowrite32(TRIV2_IDU_ADDR(paddr),
+			  trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						 OFFSET_NPU_PROF_ADDR));
+		iowrite32(prof_buf->size,
+			  trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						 OFFSET_NPU_PROF_SIZE));
+
+		if (drv->verbose)
+			dev_info(dev, "Profiling enabled (%ld bytes)",
+				 profile_size);
+	} else {
+		/* disable profiling */
+		triv2_fini_profile(prof_buf);
+
+		iowrite32(0, trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						    OFFSET_NPU_PROF_ADDR));
+		iowrite32(0, trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						    OFFSET_NPU_PROF_SIZE));
+		if (drv->verbose)
+			dev_info(dev, "Profiling disabled");
+	}
+}
+
+static void triv2_assign_opnames(struct triv2_cmd_profile *cmd)
+{
+	struct triv2_op_profile *ops = cmd->profile_ops;
+	uint32_t i;
+
+	for (i = 0; i < cmd->total_ops; i++)
+		snprintf(ops[i].op_name, TRIV2_MAX_OPNAME, "%s",
+			 triv2_op_names[ops[i].opcode]);
 }
 
 static int32_t triv2_check_profile(struct trinity_driver *drv,
 				   struct trinity_req *req)
 {
-	/* check profile */
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct triv2_req *t_req = TRIV2_GET_REQ(req);
+	struct trinity_resv_mem *profile_buf;
+	struct triv2_cmd_profile *profile_cmd;
+	struct triv2_cmd_profile *profile_cmd_new;
+	struct triv2_profile *profile;
+
+	uint32_t offset = t_req->profile_offset;
+	uint32_t total_ops, total_size;
+
+	profile_buf = TRIV2_DRV_GET_PROF_BUF(drv);
+	if (!profile_buf->vaddr)
+		return 0;
+
+	if (profile_buf->size <= offset) {
+		dev_err(drv_to_dev_ptr(drv),
+			"Invalid profile offset detected: 0x%x", offset);
+		return -EINVAL;
+	}
+
+	profile_cmd = (struct triv2_cmd_profile *)((char *)profile_buf->vaddr +
+						   offset);
+	profile_cmd->total_cycles = t_req->total_cycles;
 
+	total_ops = profile_cmd->total_ops;
+	total_size = sizeof(struct triv2_cmd_profile) +
+		     total_ops * sizeof(struct triv2_op_profile);
+
+	profile_cmd_new = vzalloc(total_size);
+	if (!profile_cmd_new)
+		return -ENOMEM;
+
+	mutex_lock(&pdata->prof_lock);
+
+	profile = req->stat->profile;
+	if (profile) {
+		WARN_ON(!profile->data);
+		vfree(profile->data);
+		profile->data = profile_cmd_new;
+	} else {
+		int req_id = req->input.config.req_id;
+		unsigned long key = TRIV2_PROFILE_HASH_KEY(req_id);
+
+		profile = vzalloc(sizeof(struct triv2_profile));
+		if (!profile) {
+			vfree(profile_cmd_new);
+			mutex_unlock(&pdata->prof_lock);
+			return -ENOMEM;
+		}
+		profile->req_id = req_id;
+		profile->data = profile_cmd_new;
+
+		hash_add(pdata->prof_htable, &profile->hlist, key);
+
+		req->stat->profile = profile;
+	}
+	memcpy(profile_cmd_new, profile_cmd, total_size);
+	triv2_assign_opnames(profile_cmd_new);
+
+	mutex_unlock(&pdata->prof_lock);
 	return 0;
 }
 
@@ -400,6 +523,47 @@ static void triv2_reset(struct trinity_driver *drv)
 		mutex_unlock(&pdata->drv->lock);
 }
 
+enum triv2_idu_stage {
+	IDU_STAGE_UNKNOWN = 0,
+	IDU_STAGE_WAITING,
+	IDU_STAGE_GET_CMD,
+	IDU_STAGE_RUN_CMD,
+	IDU_STAGE_SWAP_OUT,
+	IDU_STAGE_SWAP_IN,
+	IDU_STAGE_SEND_IRQ,
+};
+
+/**
+ * triv2_run_trigger() - trigger memory-mapped register for inference running
+ */
+static void triv2_run_trigger(const struct trinity_driver *drv, int slot)
+{
+	struct triv2_cmd_info *cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
+	struct triv2_req *t_req = cmd_info->reqs[slot];
+
+	if (!t_req) {
+		dev_err(drv_to_dev_ptr(drv),
+			"Unable to find the corresponding req");
+		return;
+	}
+
+	if (triv2_sync_segt_entries(drv, t_req) < 0)
+		dev_err(drv_to_dev_ptr(drv),
+			"Unable to sync the segment table");
+
+	/* sync the current bitmap */
+	iowrite32(*cmd_info->bitmap,
+		  trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+					 OFFSET_NPU_CMD_REQ));
+
+	t_req->req.stat->scheduled = ktime_get();
+	t_req->req.stat->completed = 0;
+	t_req->req.scheduled = true;
+
+	/* trigger the event (we do not assume that IDU always accepts this event) */
+	triv2_wakeup_cp(drv);
+}
+
 static void triv2_clear_cmd(struct trinity_driver *drv, struct triv2_req *req,
 			    struct triv2_cmd *cmd)
 {
@@ -458,6 +622,128 @@ static void triv2_handle_cmd_done(struct trinity_driver *drv,
 		complete_all(&req->complete);
 }
 
+/**
+ * triv2_prepare_cmd() - Prepare command info. for the target req before invoking
+ */
+static int32_t triv2_prepare_cmd(struct trinity_driver *drv,
+				 struct trinity_req *req, void *sched_data)
+{
+	struct triv2_cmd_info *cmd_info;
+	struct triv2_cmd cmd = { 0 };
+	struct triv2_req *t;
+
+	const struct trinity_model *model = req->model;
+	const struct trinity_input *input = &req->input;
+
+	int32_t slot;
+	struct iommu_domain *domain;
+	phys_addr_t paddr;
+	unsigned long flags;
+
+	/** Note that the program base is not behind iommu */
+	domain = iommu_get_domain_for_dev(drv_to_dev_ptr(drv));
+
+	paddr = trinity_get_paddr(domain, model->import_info.dma_addr);
+	cmd.prog_addr = TRIV2_IDU_ADDR(paddr);
+	cmd.prog_addr += model->config.program_offset_addr;
+	cmd.prog_size = model->config.program_size;
+
+	paddr = trinity_get_paddr(domain, input->import_info.dma_addr);
+	cmd.segt_addr = TRIV2_IDU_ADDR(paddr);
+	cmd.num_visa = model->config.num_visa_insts;
+
+	cmd.priority = input->config.priority;
+	cmd.input_mode = input->config.input_mode;
+	cmd.output_mode = input->config.output_mode;
+
+	/** Find a empty cmd slot in bitmap (need a spin lock) */
+	cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
+	t = TRIV2_GET_REQ(req);
+
+	spin_lock_irqsave(&cmd_info->lock, flags);
+
+	slot = find_first_zero_bit(cmd_info->bitmap, TRIV2_MAX_CMDSLOTS);
+	if (slot < TRIV2_MAX_CMDSLOTS) {
+		set_bit(slot, cmd_info->bitmap);
+		cmd_info->reqs[slot] = t;
+		t->cmd_slot = slot;
+	}
+
+	spin_unlock_irqrestore(&cmd_info->lock, flags);
+
+	/** Will be retried (rely on platform device's scheduling) */
+	if (slot >= TRIV2_MAX_CMDSLOTS)
+		return -EBUSY;
+
+	cmd.slot = slot;
+	cmd.status = STATUS_CMD_READY;
+
+	memcpy_toio(cmd_info->buf.vaddr + slot * sizeof(struct triv2_cmd), &cmd,
+		    sizeof(struct triv2_cmd));
+
+	return slot;
+}
+
+/**
+ * triv2_invoke_req() - Invoke a req on the device. Note that all configurations
+ * required by running should be done before invocation of this function.
+ */
+static int32_t triv2_invoke_req(struct trinity_driver *drv,
+				struct trinity_req *req, void *sched_data)
+{
+	enum trinity_output_mode mode;
+	int32_t slot;
+
+	mode = req->input.config.output_mode;
+	slot = triv2_prepare_cmd(drv, req, sched_data);
+	if (slot < 0)
+		return slot;
+
+	if (mode == TRINITY_OUTPUT_HW || mode == TRINITY_OUTPUT_CPU_POLL ||
+	    mode == TRINITY_OUTPUT_CPU_INTR) {
+		triv2_run_trigger(drv, slot);
+	} else {
+		dev_err(drv_to_dev_ptr(drv), "Invalid output mode: %d\n", mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct trinity_req *triv2_alloc_req(struct trinity_driver *drv)
+{
+	struct triv2_req *t_req;
+
+	t_req = kzalloc(sizeof(struct triv2_req), GFP_KERNEL);
+	if (!t_req)
+		return NULL;
+
+	t_req->cmd_slot = -1;
+
+	return &(t_req->req);
+}
+
+static void triv2_dealloc_req(struct trinity_driver *drv,
+			struct trinity_req *req)
+{
+	struct triv2_req *t_req = TRIV2_GET_REQ(req);
+
+	if (t_req->seg_import) {
+		struct trinity_hwmem_import *import;
+		uint32_t i;
+
+		for (i = 0; i < req->input.config.num_segments; i++) {
+			import = &(t_req->seg_import[i]);
+			if (import->addr)
+				trinity_hwmem_import_dmabuf_end(import);
+		}
+		kfree(t_req->seg_import);
+	}
+
+	kfree(t_req->kernel);
+	kfree(t_req);
+}
+
 static void triv2_handle_timeout(struct trinity_driver *drv,
 				 struct trinity_req *req)
 {
@@ -494,6 +780,156 @@ static void triv2_stop_reqs(struct work_struct *work)
 	triv2_cancel_reqs(drv);
 }
 
+/**
+ * triv2_get_profile_meta() - get profile metadata for the target req
+ */
+static int32_t triv2_get_profile_meta(const struct trinity_driver *drv,
+				      struct trinity_ioctl_profile_meta *meta)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct triv2_profile *profile;
+	struct triv2_cmd_profile *profile_data;
+	int ret = 0;
+
+	mutex_lock(&pdata->prof_lock);
+
+	profile = triv2_find_profile(drv, meta->req_id);
+	if (!profile) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	profile_data = profile->data;
+	WARN_ON(!profile_data);
+
+	meta->total_cycles = profile_data->total_cycles;
+	meta->total_ops = profile_data->total_ops;
+	meta->profile_size =
+		profile_data->total_ops * sizeof(struct triv2_op_profile);
+	/* unsupported for now */
+	meta->input_footprint = -1;
+	meta->output_footprint = -1;
+
+out:
+	mutex_unlock(&pdata->prof_lock);
+
+	return ret;
+}
+
+/**
+ * triv2_get_profile_buff() - get profile buffer for the target req
+ */
+static int32_t triv2_get_profile_buff(const struct trinity_driver *drv,
+				      struct trinity_ioctl_profile_buff *buff)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct triv2_profile *profile;
+	struct triv2_cmd_profile *profile_data;
+	uint32_t total_size;
+	int ret = 0;
+
+	mutex_lock(&pdata->prof_lock);
+
+	profile = triv2_find_profile(drv, buff->req_id);
+	if (!profile) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	profile_data = profile->data;
+	WARN_ON(!profile_data);
+
+	profile_data = profile->data;
+	total_size = profile_data->total_ops * sizeof(struct triv2_op_profile);
+
+	if (buff->profile_pos + buff->profile_size > total_size) {
+		dev_err(drv_to_dev_ptr(drv),
+			"Profile data out-of-range! pos(%u) size(%u) > total_size(%u)",
+			buff->profile_pos, buff->profile_size, total_size);
+		ret = -ERANGE;
+		goto out;
+	}
+
+	/* consider partial memory copies */
+	if (copy_to_user((char __user *)buff->profile_buf,
+			 (char *)profile_data->profile_ops + buff->profile_pos,
+			 buff->profile_size))
+		ret = -EACCES;
+
+out:
+	mutex_unlock(&pdata->prof_lock);
+
+	return ret;
+}
+
+static void triv2_show_profile(const struct trinity_driver *drv, int req_id)
+{
+	struct device *dev = drv_to_dev_ptr(drv);
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct triv2_profile *profile;
+	struct triv2_cmd_profile *profile_data;
+	uint32_t i;
+
+	mutex_lock(&pdata->prof_lock);
+
+	profile = triv2_find_profile(drv, req_id);
+	if (!profile) {
+		dev_warn(dev, "Unable to find the profile data (req_id %d)",
+			 req_id);
+		goto out;
+	}
+
+	profile_data = profile->data;
+	WARN_ON(!profile_data);
+
+	dev_info(dev, "Total cycles: %lld", profile_data->total_cycles);
+	dev_info(dev, "Total ops: %u", profile_data->total_ops);
+
+	for (i = 0; i < profile_data->total_ops; i++) {
+		struct triv2_op_profile *op = &profile_data->profile_ops[i];
+
+		dev_info(dev, "[%u] opcode: %u name:%s", i, op->opcode,
+			 op->op_name);
+		dev_info(dev, "\tcycles: %lld", op->cycles);
+		dev_info(dev, "\tprog_seq: %lld", op->prog_seq);
+		dev_info(dev, "\texec_seq: %lld", op->exec_seq);
+		if (op->dram_read > 0)
+			dev_info(dev, "\tdram_read: %lld", op->dram_read);
+		if (op->dram_write > 0)
+			dev_info(dev, "\tdram_write: %lld", op->dram_write);
+		if (op->sram_read > 0)
+			dev_info(dev, "\tsram_read: %lld", op->sram_read);
+		if (op->sram_write > 0)
+			dev_info(dev, "\tsram_write: %lld", op->sram_write);
+	}
+out:
+	mutex_unlock(&pdata->prof_lock);
+}
+
+/**
+ * triv2_destroy_profile() - destroy profile data
+ */
+static void triv2_destroy_profile(const struct trinity_driver *drv, void *data)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct triv2_profile *profile = data;
+	struct triv2_cmd_profile *profile_data;
+
+	if (!profile)
+		return;
+
+	mutex_lock(&pdata->prof_lock);
+
+	profile_data = profile->data;
+	WARN_ON(!profile_data);
+	vfree(profile_data);
+
+	hash_del(&profile->hlist);
+	vfree(profile);
+
+	mutex_unlock(&pdata->prof_lock);
+}
+
 static void triv2_handle_irq_cmds(struct trinity_driver *drv)
 {
 	struct triv2_cmd_info *info;
@@ -667,18 +1103,6 @@ static int32_t triv2_prepare_req(struct trinity_driver *drv,
 	return ret;
 }
 
-/**
- * triv2_invoke_req() - Invoke a req on the device. Note that all configurations
- * required by running should be done before invocation of this function.
- */
-static int32_t triv2_invoke_req(struct trinity_driver *drv,
-				struct trinity_req *req, void *sched_data)
-{
-	/* invoke request */
-
-	return 0;
-}
-
 static long triv2_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
 	struct trinity_driver *drv = f->private_data;
@@ -740,13 +1164,16 @@ static void triv2_setup_dsp(struct trinity_driver *drv, phys_addr_t paddr)
 
 static void triv2_init_common(void)
 {
-	static bool done;
+	static bool need_init = true;
+	int i;
 
-	if (done)
+	if (!need_init)
 		return;
 
 	/* init hlists */
-	done = true;
+	for (i = 0; i < TRIV2_MODEL_HASH_SIZE; ++i)
+		INIT_HLIST_BL_HEAD(&triv2_model_node_hlist[i]);
+	need_init = false;
 }
 
 static int triv2_idu_alloc(struct device *dev, struct trinity_resv_mem *mem)
diff --git a/drivers/misc/trinity/trinity_vision2_profile.h b/drivers/misc/trinity/trinity_vision2_profile.h
new file mode 100644
index 000000000000..90b42cf56c54
--- /dev/null
+++ b/drivers/misc/trinity/trinity_vision2_profile.h
@@ -0,0 +1,324 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * Profile header for TRIV2 devices
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __TRINITY_VISION2_PROFILE_H__
+#define __TRINITY_VISION2_PROFILE_H__
+
+#include <linux/types.h>
+
+#define TRIV2_MAX_OPNAME	(128)
+#define TRIV2_MAX_PROFILE_SIZE	(256)
+
+/**
+ * struct triv2_op_profile - A profile data per operation
+ *
+ * @op_name: The physical DMA address of this DMA buffer.
+ * @cycles: total number of cycles
+ * @dram_read: a count for dram read
+ * @dram_write: a count for dram write
+ * @sram_read: a count for sram read
+ * @sram_write: a count for sram write
+ * @start_cycles: a count for starting cycles
+ * @end_cycles: a cont for ending cycles
+ * @opcode: operation code
+ * @prog_seq: program sequence number
+ * @exec_seq: execution sequence number
+ * @reserved: reserved
+ */
+struct triv2_op_profile {
+	union {
+		struct {
+			char op_name[TRIV2_MAX_OPNAME];
+
+			int64_t cycles;
+
+			int64_t dram_read;
+			int64_t dram_write;
+
+			int64_t sram_read;
+			int64_t sram_write;
+
+			int64_t start_cycles;
+			int64_t end_cycles;
+
+			uint32_t opcode;
+			int64_t prog_seq;
+			int64_t exec_seq;
+		} __packed;
+		uint8_t reserved[TRIV2_MAX_PROFILE_SIZE];
+	};
+};
+
+/**
+ * struct triv2_cmd_profile - A profile data per command
+ *
+ * @total_cycles: total number of cycles for a command
+ * @total_ops: total operations of command
+ * @profile_ops: list of profile data for operations
+ */
+struct triv2_cmd_profile {
+	int64_t total_cycles;
+	uint32_t total_ops;
+	/* zero-length array */
+	struct triv2_op_profile profile_ops[];
+} __packed;
+
+/**
+ * struct triv2_profile - A profile data
+ *
+ * @req_id: total number of cycles for a command
+ * @hlist: list of profile data
+ * @data: command profile data
+ */
+struct triv2_profile {
+	int req_id;
+	struct hlist_node hlist;
+	struct triv2_cmd_profile *data;
+};
+
+enum {
+	NOP = 0x00,
+	HALT = 0x01,
+	ADMA_IN = 0x02,
+	ADMA_OUT = 0x03,
+	RESCALE_I8 = 0x04,
+	RESCALE_I16 = 0x05,
+	CONVERT_I16_I8 = 0x06,
+	CONVERT_I8_I16 = 0x07,
+	RELUN_I8 = 0x08,
+	RELUN_I16 = 0x09,
+	PRELU_I8 = 0x0A,
+	PRELU_I16 = 0x0B,
+	ADD_I8 = 0x0C,
+	ADD_I16 = 0x0D,
+	REDUCE_MEAN_I8 = 0x0E,
+	REDUCE_MEAN_I16 = 0x0F,
+	MAX_POOL_I8 = 0x10,
+	MAX_POOL_I16 = 0x11,
+	AVG_POOL_I8 = 0x12,
+	AVG_POOL_I16 = 0x13,
+	CONV_I8 = 0x14,
+	CONV_I16 = 0x15,
+	CONVE_I8 = 0x16,
+	CONVE_I16 = 0x17,
+	TCONV_I8 = 0x18,
+	TCONV_I16 = 0x19,
+	MUL_I8 = 0x1A,
+	MUL_I16 = 0x1B,
+	DCONV_I8 = 0x1C,
+	DCONV_I16 = 0x1D,
+	DCONVE_I8 = 0x1E,
+	DCONVE_I16 = 0x1F,
+	CONV_I8_P = 0x20,
+	CONV_I16_P = 0x21,
+	PDMA_IN = 0x40,
+	PDMA_OUT = 0x41,
+	ARGMAX_I8 = 0x42,
+	ARGMAX_I16 = 0x43,
+	RESHAPE_I8 = 0x44,
+	RESHAPE_I16 = 0x45,
+	TRANSPOSE_I8 = 0x46,
+	TRANSPOSE_I16 = 0x47,
+	CONCAT_I8 = 0x48,
+	CONCAT_I16 = 0x49,
+	PAD_I8 = 0x4A,
+	PAD_I16 = 0x4B,
+	STRIDED_SLICE_I8 = 0x4C,
+	STRIDED_SLICE_I16 = 0x4D,
+	CONVERT_FORMAT_I8 = 0x4E,
+	CONVERT_FORMAT_I16 = 0x4F,
+	SIGMOID_I8 = 0x50,
+	SIGMOID_I16 = 0x51,
+	TANH_I8 = 0x52,
+	TANH_I16 = 0x53,
+	ELU_I8 = 0x54,
+	ELU_I16 = 0x55,
+	FLOOR_I8 = 0x56,
+	FLOOR_I16 = 0x57,
+	RSQRT_I8 = 0x58,
+	RSQRT_I16 = 0x59,
+	SQRT_I8 = 0x5A,
+	SQRT_I16 = 0x5B,
+	SOFTMAX_I8 = 0x5C,
+	SOFTMAX_I16 = 0x5D,
+	DIVIDE_I8 = 0x60,
+	DIVIDE_I16 = 0x61,
+	FLOORDIV_I8 = 0x62,
+	FLOORDIV_I16 = 0x63,
+	LOGICAL_OR_I8 = 0x64,
+	LOGICAL_OR_I16 = 0x65,
+	GREATER_I8 = 0x66,
+	GREATER_I16 = 0x67,
+	GREATER_EQUAL_I8 = 0x68,
+	GREATER_EQUAL_I16 = 0x69,
+	POW_I8 = 0x6A,
+	POW_I16 = 0x6B,
+	EXP_I8 = 0x6C,
+	EXP_I16 = 0x6D,
+	NOT_EQUAL_I8 = 0x6E,
+	NOT_EQUAL_I16 = 0x6F,
+	BATCH_TO_SPACE_I8 = 0x70,
+	BATCH_TO_SPACE_I16 = 0x71,
+	SPACE_TO_BATCH_I8 = 0x72,
+	SPACE_TO_BATCH_I16 = 0x73,
+	DEPTH_TO_SPACE_I8 = 0x74,
+	DEPTH_TO_SPACE_I16 = 0x75,
+	SPACE_TO_DEPTH_I8 = 0x76,
+	SPACE_TO_DEPTH_I16 = 0x77,
+	YUV_TO_RGB_I8 = 0x7A,
+	YUV_TO_RGB_I16 = 0x7B,
+	RESIZE_BILINEAR_I8 = 0x7C,
+	RESIZE_BILINEAR_I16 = 0x7D,
+	RESIZE_NEAREST_NEIGHBOR_I8 = 0x7E,
+	RESIZE_NEAREST_NEIGHBOR_I16 = 0x7F,
+	LOCAL_RESPONSE_NORM_I8 = 0x80,
+	LOCAL_RESPONSE_NORM_I16 = 0x81,
+	INSTANCE_NORM_I8 = 0x82,
+	INSTANCE_NORM_I16 = 0x83,
+	REDUCED_SUM_SSUM_I8 = 0x84,
+	REDUCED_SUM_SSUM_I16 = 0x85,
+	REDUCED_SUM_SSUM_ACC_I8 = 0x86,
+	REDUCED_SUM_SSUM_ACC_I16 = 0x87,
+	REDUCED_SUM_2SUM_I8 = 0x88,
+	REDUCED_SUM_2SUM_I16 = 0x89,
+	REDUCED_MEAN_DEV_WSUM_I8 = 0x8A,
+	REDUCED_MEAN_DEV_WSUM_I16 = 0x8B,
+	REDUCED_MEAN_DEV_I8 = 0x8C,
+	REDUCED_MEAN_DEV_I16 = 0x8D,
+	RESCALE_CW_I8 = 0x8E,
+	RESCALE_CW_I16 = 0x8F,
+	REDUCED_MEAN_SCALE_WSUM_I8 = 0x90,
+	REDUCED_MEAN_SCALE_WSUM_I16 = 0x91,
+	RESCALE_CHANNELWISE_I8 = 0x92,
+	RESCALE_CHANNELWISE_I16 = 0x93,
+};
+
+/** generate opnames */
+#define TRIV2_GENERATE_OPNAME(OPNAME)	\
+	[OPNAME] = #OPNAME,
+
+#define TRIV2_FOREACH_OPNAME(GEN)	{\
+	GEN(NOP) \
+	GEN(HALT) \
+	GEN(ADMA_IN) \
+	GEN(ADMA_OUT) \
+	GEN(RESCALE_I8) \
+	GEN(RESCALE_I16) \
+	GEN(CONVERT_I16_I8) \
+	GEN(CONVERT_I8_I16) \
+	GEN(RELUN_I8) \
+	GEN(RELUN_I16) \
+	GEN(PRELU_I8) \
+	GEN(PRELU_I16) \
+	GEN(ADD_I8) \
+	GEN(ADD_I16) \
+	GEN(REDUCE_MEAN_I8) \
+	GEN(REDUCE_MEAN_I16) \
+	GEN(MAX_POOL_I8) \
+	GEN(MAX_POOL_I16) \
+	GEN(AVG_POOL_I8) \
+	GEN(AVG_POOL_I16) \
+	GEN(CONV_I8) \
+	GEN(CONV_I16) \
+	GEN(CONVE_I8) \
+	GEN(CONVE_I16) \
+	GEN(TCONV_I8) \
+	GEN(TCONV_I16) \
+	GEN(MUL_I8) \
+	GEN(MUL_I16) \
+	GEN(DCONV_I8) \
+	GEN(DCONV_I16) \
+	GEN(DCONVE_I8) \
+	GEN(DCONVE_I16) \
+	GEN(CONV_I8_P) \
+	GEN(CONV_I16_P) \
+	GEN(PDMA_IN) \
+	GEN(PDMA_OUT) \
+	GEN(ARGMAX_I8) \
+	GEN(ARGMAX_I16) \
+	GEN(RESHAPE_I8) \
+	GEN(RESHAPE_I16) \
+	GEN(TRANSPOSE_I8) \
+	GEN(TRANSPOSE_I16) \
+	GEN(CONCAT_I8) \
+	GEN(CONCAT_I16) \
+	GEN(PAD_I8) \
+	GEN(PAD_I16) \
+	GEN(STRIDED_SLICE_I8) \
+	GEN(STRIDED_SLICE_I16) \
+	GEN(CONVERT_FORMAT_I8) \
+	GEN(CONVERT_FORMAT_I16) \
+	GEN(SIGMOID_I8) \
+	GEN(SIGMOID_I16) \
+	GEN(TANH_I8) \
+	GEN(TANH_I16) \
+	GEN(ELU_I8) \
+	GEN(ELU_I16) \
+	GEN(FLOOR_I8) \
+	GEN(FLOOR_I16) \
+	GEN(RSQRT_I8) \
+	GEN(RSQRT_I16) \
+	GEN(SQRT_I8) \
+	GEN(SQRT_I16) \
+	GEN(SOFTMAX_I8) \
+	GEN(SOFTMAX_I16) \
+	GEN(DIVIDE_I8) \
+	GEN(DIVIDE_I16) \
+	GEN(FLOORDIV_I8) \
+	GEN(FLOORDIV_I16) \
+	GEN(LOGICAL_OR_I8) \
+	GEN(LOGICAL_OR_I16) \
+	GEN(GREATER_I8) \
+	GEN(GREATER_I16) \
+	GEN(GREATER_EQUAL_I8) \
+	GEN(GREATER_EQUAL_I16) \
+	GEN(POW_I8) \
+	GEN(POW_I16) \
+	GEN(EXP_I8) \
+	GEN(EXP_I16) \
+	GEN(NOT_EQUAL_I8) \
+	GEN(NOT_EQUAL_I16) \
+	GEN(BATCH_TO_SPACE_I8) \
+	GEN(BATCH_TO_SPACE_I16) \
+	GEN(SPACE_TO_BATCH_I8) \
+	GEN(SPACE_TO_BATCH_I16) \
+	GEN(DEPTH_TO_SPACE_I8) \
+	GEN(DEPTH_TO_SPACE_I16) \
+	GEN(SPACE_TO_DEPTH_I8) \
+	GEN(SPACE_TO_DEPTH_I16) \
+	GEN(YUV_TO_RGB_I8) \
+	GEN(YUV_TO_RGB_I16) \
+	GEN(RESIZE_BILINEAR_I8) \
+	GEN(RESIZE_BILINEAR_I16) \
+	GEN(RESIZE_NEAREST_NEIGHBOR_I8) \
+	GEN(RESIZE_NEAREST_NEIGHBOR_I16) \
+	GEN(LOCAL_RESPONSE_NORM_I8) \
+	GEN(LOCAL_RESPONSE_NORM_I16) \
+	GEN(INSTANCE_NORM_I8) \
+	GEN(INSTANCE_NORM_I16) \
+	GEN(REDUCED_SUM_SSUM_I8) \
+	GEN(REDUCED_SUM_SSUM_I16) \
+	GEN(REDUCED_SUM_SSUM_ACC_I8) \
+	GEN(REDUCED_SUM_SSUM_ACC_I16) \
+	GEN(REDUCED_SUM_2SUM_I8) \
+	GEN(REDUCED_SUM_2SUM_I16) \
+	GEN(REDUCED_MEAN_DEV_WSUM_I8) \
+	GEN(REDUCED_MEAN_DEV_WSUM_I16) \
+	GEN(REDUCED_MEAN_DEV_I8) \
+	GEN(REDUCED_MEAN_DEV_I16) \
+	GEN(RESCALE_CW_I8) \
+	GEN(RESCALE_CW_I16) \
+	GEN(REDUCED_MEAN_SCALE_WSUM_I8) \
+	GEN(REDUCED_MEAN_SCALE_WSUM_I16) \
+	GEN(RESCALE_CHANNELWISE_I8) \
+	GEN(RESCALE_CHANNELWISE_I16) \
+}
+#endif
-- 
2.25.1

