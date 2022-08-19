Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20CD59931A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbiHSCl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiHSCl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:41:57 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D93CAC94;
        Thu, 18 Aug 2022 19:41:55 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id x15so2290997pfp.4;
        Thu, 18 Aug 2022 19:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iEvYibckYqkiOpcb2FvjqdgKp5+U37BNBuHFr4poExI=;
        b=40Z60E3HH2tJvQH8L3RQ6xTHSQHM4dfuNQXdWONlHzT+dlNgzBGXrLpDVfxQY0njzV
         Tzim8nWgTfctgg15H+jRMo+2MlesAZf/E8PH0DTeiDaSoDWeRPYb8MRbfPlKv5zZUi98
         y0YshaXT8M07D3Sgr9yGOsLTQGS/O7zrBsmBPmP+UY+LeC6y9aIR+AW5HSbMxaXxiHk/
         moX21ljxoOCqNSkxf9vCUxGx5ix+hl6OfmADQW9b6DRFbuNG1PCUppWArHKRmqSTkkMH
         Fpt/eicaLButAfMG50at4kiG1Cc3XChZlSnz+0spOM49NHJ1UtKP+z/B+o/PYk66BG1b
         AlbA==
X-Gm-Message-State: ACgBeo2+xYFdslI/7XP634EXU7TonO2KPatiQ3hHeQt2YNSMUlhIDygJ
        Zv4d2h18+DxGMzl01Prkg/U=
X-Google-Smtp-Source: AA6agR5cMZfNujfuMOP9Msj2wiR04vcdJE2taxg/YB4G3A8uJwSXZZia10Te8defF2zBZdSSC93WXQ==
X-Received: by 2002:a63:9042:0:b0:41c:cdd4:ae66 with SMTP id a63-20020a639042000000b0041ccdd4ae66mr4568210pge.47.1660876914922;
        Thu, 18 Aug 2022 19:41:54 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id e7-20020a63ee07000000b0041b2f37c571sm1949328pgi.34.2022.08.18.19.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 19:41:53 -0700 (PDT)
Message-ID: <ea877f4f-1acd-2da4-a6f5-10df02dfee74@acm.org>
Date:   Thu, 18 Aug 2022 19:41:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH v2 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, quic_asutoshd@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, mani@kernel.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        jongmin jeong <jjmin.jeong@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1660213984-37793-1-git-send-email-quic_cang@quicinc.com>
 <1660213984-37793-2-git-send-email-quic_cang@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1660213984-37793-2-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 03:33, Can Guo wrote:
> +#define mcq_sqattr_offset(c) \
> +	((((c) >> 16) & MCQ_QCFGPTR_MASK) * MCQ_QCFGPTR_UNIT)

Can the above macro be converted into an inline function? If not, 
consider using uppercase characters for the macro name.

> +#define MCQ_ENTRY_SIZE_IN_DWORD	8
> +#define MCQ_QCFG_SIZE	0x40
> +
> +static unsigned int dev_cmd_queue = 1;
> +static unsigned int read_queues;
> +static unsigned int poll_queues = 1;
> +
> +static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
> +{
> +	unsigned int n;
> +	int ret;
> +
> +	ret = kstrtouint(val, 10, &n);
> +	if (ret)
> +		return ret;
> +	if (n > num_possible_cpus())
> +		return -EINVAL;
> +	return param_set_uint(val, kp);
> +}
> +
> +static const struct kernel_param_ops rw_queue_count_ops = {
> +	.set = rw_queue_count_set,
> +	.get = param_get_uint,
> +};
> +
> +static unsigned int rw_queues = 8;
> +module_param_cb(rw_queues, &rw_queue_count_ops, &rw_queues, 0644);
> +MODULE_PARM_DESC(rw_queues, "Number of queues used for rw. Default value is 8");

The description of this kernel module parameter sounds confusing to me 
since read and write requests may also end up on a poll queue. How about 
the following description?

"Number of I/O queues that use interrupts for reporting completions 
(HCTX_TYPE_DEFAULT)"

> +u32 ufshcd_mcq_find_queue_depth(struct ufs_hba *hba)
> +{
> +	u32 qd, val, mac;
> +
> +	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
> +	mac = ufshcd_mcq_vops_get_hba_mac(hba);
> +	if (mac < 0)
> +		mac = (val & MCQ_CFG_MAC_MASK) >> MCQ_CFG_MAC_OFFSET;

How can mac be negative since it has been declared as u32?

> +	/*  MAC is a 0 based value. */
> +	mac += 1;
> +	qd = min_t(u32, mac, hba->dev_info.bqueuedepth);
> +	if (!qd)
> +		qd = mac;
> +
> +	/* Adjust queue depth based on ext_iid support. */
> +	if (qd > 256 && (!hba->ext_iid_sup || !hba->dev_info.b_ext_iid_en))
> +		qd = 256;
> +	if (qd > 4096 && hba->ext_iid_sup && hba->dev_info.b_ext_iid_en)
> +		qd = 4096;
> +
> +	return qd;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_find_queue_depth);

Since the above function implements a policy, there should be a comment 
above this function that explains which policy has been implemented.

Additionally, consider changing "find" into e.g. "decide" since I think 
the latter verb better reflects what the above function does.

> +void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 set)
> +{
> +	u32 val;
> +
> +	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
> +	val &= ~MCQ_CFG_MAC_MASK;
> +	val |= set << MCQ_CFG_MAC_OFFSET;
> +	ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);

Please add a comment that explains what "MAC" stands for or what this 
function does. Additionally, please choose a better name for the 
function argument "set" (max_active_cmds?).

> +struct ufs_hw_queue *ufshcd_mcq_find_hwq(struct ufs_hba *hba,
> +					 struct request *req)
> +{
> +	u32 utag, hwq;
> +
> +	utag = blk_mq_unique_tag(req);
> +	hwq = blk_mq_unique_tag_to_hwq(utag);
> +
> +	return &hba->uhq[hwq + UFSHCD_MCQ_IO_QUEUE_OFFSET];
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_find_hwq);

Consider renaming this function into ufshcd_req_to_hwq(). I think that 
name better reflects the purpose of this function.

> +int ufshcd_mcq_memory_alloc(struct ufs_hba *hba)
> +{
> +	struct ufs_hw_queue *hwq;
> +	size_t utrdl_size, cqe_size;
> +	int i;
> +
> +	for_each_hw_queue(hba, i) {
> +		hwq = &hba->uhq[i];
> +
> +		utrdl_size = sizeof(struct utp_transfer_req_desc) *
> +			     hwq->max_entries;
> +		hwq->sqe_base_addr = dmam_alloc_coherent(hba->dev, utrdl_size,
> +							 &hwq->sqe_dma_addr,
> +							 GFP_KERNEL);
> +		if (!hwq->sqe_dma_addr || WARN_ON(hwq->sqe_dma_addr &
> +						  (PAGE_SIZE - 1))) {
> +			dev_err(hba->dev, "Alloc SQE failed\n");
> +			return -ENOMEM;
> +		}
> +
> +		cqe_size = sizeof(struct cq_entry) * hwq->max_entries;
> +		hwq->cqe_base_addr = dmam_alloc_coherent(hba->dev, cqe_size,
> +							 &hwq->cqe_dma_addr,
> +							 GFP_KERNEL);
> +		if (!hwq->cqe_dma_addr || WARN_ON(hwq->cqe_dma_addr &
> +						  (PAGE_SIZE - 1))) {
> +			dev_err(hba->dev, "Alloc CQE failed\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_memory_alloc);

Please leave out the dma_addr alignment checks since page alignment is 
guaranteed. From dma-api-howto.rst: "The CPU virtual address and the DMA 
address are both guaranteed to be aligned to the smallest PAGE_SIZE 
order which is greater than or equal to the requested size."

> +#define MCQ_ROP_OFFSET_n(p, i) \
> +	(hba->mcq_rop[(p)].offset + hba->mcq_rop[(p)].stride * (i))
> +
> +static inline void __iomem *mcq_rop_base(struct ufs_hba *hba,
> +					 enum ufshcd_mcq_rop n, int i)
> +{
> +	struct ufshcd_mcq_rop_info_t *rop = &hba->mcq_rop[n];
> +
> +	return rop->base + rop->stride * i;
> +}

Please add a comment that explains what "rop" stands for.

> +void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
> +{
> +	struct ufs_hw_queue *hwq;
> +	u16 qsize;
> +	int i;
> +
> +	for_each_hw_queue(hba, i) {
> +		hwq = &hba->uhq[i];
> +		hwq->id = i;
> +		qsize = hwq->max_entries * MCQ_ENTRY_SIZE_IN_DWORD - 1;
> +
> +		/* SQLBA */
> +		ufsmcq_writel(hba, lower_32_bits(hwq->sqe_dma_addr),
> +			      MCQ_CFG_n(REG_SQLBA, i));
> +		/* SQUBA */
> +		ufsmcq_writel(hba, upper_32_bits(hwq->sqe_dma_addr),
> +			      MCQ_CFG_n(REG_SQUBA, i));
> +		/* SQDAO */
> +		ufsmcq_writel(hba, MCQ_ROP_OFFSET_n(ROP_SQD, i),
> +			      MCQ_CFG_n(REG_SQDAO, i));
> +		/* SQISAO */
> +		ufsmcq_writel(hba, MCQ_ROP_OFFSET_n(ROP_SQIS, i),
> +			      MCQ_CFG_n(REG_SQISAO, i));
> +
> +		/* CQLBA */
> +		ufsmcq_writel(hba, lower_32_bits(hwq->cqe_dma_addr),
> +			      MCQ_CFG_n(REG_CQLBA, i));
> +		/* CQUBA */
> +		ufsmcq_writel(hba, upper_32_bits(hwq->cqe_dma_addr),
> +			      MCQ_CFG_n(REG_CQUBA, i));
> +		/* CQDAO */
> +		ufsmcq_writel(hba, MCQ_ROP_OFFSET_n(ROP_CQD, i),
> +			      MCQ_CFG_n(REG_CQDAO, i));
> +		/* CQISAO */
> +		ufsmcq_writel(hba, MCQ_ROP_OFFSET_n(ROP_CQIS, i),
> +			      MCQ_CFG_n(REG_CQISAO, i));

Mentioning the names of the registers from the spec is great. To make 
the above code easier to read, please add the full names of the 
registers next to the register name acronyms.

> +static void ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
> +{
> +	int i;
> +	u32 hbaq_cap, def_nr_queues, max_nr_queues;
> +	struct Scsi_Host *host = hba->host;
> +
> +	/* default queues will be less than or equal to max_nr_queues */
> +	def_nr_queues = rw_queues + poll_queues + read_queues + dev_cmd_queue;
> +	max_nr_queues = num_possible_cpus() + poll_queues + read_queues +
> +		dev_cmd_queue;
> +	hbaq_cap = hba->mcq_capabilities & 0xff;
> +
> +	if (hbaq_cap >= max_nr_queues)
> +		hba->nr_queues[HCTX_TYPE_DEFAULT] = num_possible_cpus();
> +	else if (hbaq_cap >= def_nr_queues)
> +		hba->nr_queues[HCTX_TYPE_DEFAULT] = rw_queues;
> +	else
> +		hba->nr_queues[HCTX_TYPE_DEFAULT] = hbaq_cap - read_queues -
> +						    poll_queues - dev_cmd_queue;

If hbaq_cap <= 3, read_queues == 1, poll_queues == 1 and dev_cmd_queue 
== 1, will that result in zero or less than zero queues of type 
HCTX_TYPE_DEFAULT?

> +	/* One more reserved for dev_cmd_queue */
> +	hba->nr_hw_queues = host->nr_hw_queues + 1;

Should '1' above perhaps be changed into 'dev_cmd_queue'? Are you sure 
that the comment above is in sync with the code?

> +	ret = ufshcd_mcq_vops_config_rop(hba);
> +	if (ret) {
> +		dev_err(hba->dev, "MCQ Runtime Operation Pointers not configured\n");
> +		goto out_err;
> +	}

I can't find the phrase "runtime operation" in the spec? Since that 
structure only holds submission and completion queues, consider using 
the word "queues" instead of the acronym "rop". The phrase "runtime 
operation" is so generic that it is meaningless.

> +	/* The very first HW queue is to serve dev_cmd */

dev_cmd -> device commands? Please write words in full instead of using 
acronyms in comments.

> +	/* Give dev_cmd_queue the minimal num of entries */

num -> number.

> +	/* Selct MCQ mode */

Selct -> Select.

> +u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i)
> +{
> +	return readl(mcq_rop_base(hba, ROP_CQIS, i) + REG_CQIS);
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_read_cqis);

Please remove all EXPORT_SYMBOL() / EXPORT_SYMBOL_GPL() declarations 
from this source file except for those functions for which patch 2/2 
adds a caller.

Please add a comment above this function that explains what "cqis" 
stands for.

> +	for_each_hw_queue(hba, i) {
> +		/* enable CQIS.TEPS interrupt only for non-poll queues */
> +		if (i >= hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL])
> +			continue;

continue -> break?

> +void ufshcd_mcq_enable_esi(struct ufs_hba *hba)
> +{
> +	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x2,
> +		      REG_UFS_MEM_CFG);
> +}

Please add a comment above this function that explains the meaning of "esi".

> +static inline int ufshcd_mcq_get_tag(struct ufs_hba *hba,
> +				     struct ufs_hw_queue *hwq,
> +				     struct cq_entry *cqe)
> +{
> +	dma_addr_t dma_addr;
> +
> +	dma_addr = ((u64)le32_to_cpu(cqe->command_desc_base_addr_hi) << 32) |
> +		   (le32_to_cpu(cqe->command_desc_base_addr_lo) & 0xffffff80);

Why to mask off the lowest bits of the address? I think that deserves a 
comment.

> +	return (dma_addr - hba->ucdl_dma_addr) /
> +		sizeof_utp_transfer_cmd_desc(hba);
> +}

I can't find sizeof_utp_transfer_cmd_desc() in Linus' master branch?

> +static inline void ufshcd_mcq_process_event(struct ufs_hba *hba,
> +					    struct ufs_hw_queue *hwq)
> +{
> +	struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
> +	int tag;
> +
> +	tag = ufshcd_mcq_get_tag(hba, hwq, cqe);
> +	ufshcd_compl_one_task(hba, tag, cqe);
> +}

Consider changing "process_event" into "process_cqe". Consider renaming 
ufshcd_compl_one_task() into ufshcd_compl_one_cqe().

> +unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
> +				       struct ufs_hw_queue *hwq)
> +{
> +	unsigned long completed_reqs, flags;
> +
> +	spin_lock_irqsave(&hwq->cq_lock, flags);
> +	completed_reqs = ufshcd_mcq_poll_cqe_nolock(hba, hwq);
> +	spin_unlock_irqrestore(&hwq->cq_lock, flags);
> +
> +	return completed_reqs;
> +}

Why are interrupts disabled around ufshcd_mcq_poll_cqe_nolock() calls?

Why are the ufshcd_mcq_poll_cqe_nolock() protected by a spinlock?

> -static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params);
> +static int ufshcd_probe_hba(struct ufs_hba *hba, bool initial_boot);

Since the above change is not related to MCQ, please move it into a 
separate patch.

> -static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba, unsigned int tag,
> +static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba,
> +				      struct ufshcd_lrb *lrbp,
>   				      enum ufs_trace_str_t str_t)

Above I see another change that should be moved into a separate patch.

>   static inline
> -void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
> +void ufshcd_send_command(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
> +			 struct ufs_hw_queue *hwq)
>   {

The above change should also be moved into a separate patch (before the 
MCQ patch).

> +	if (is_mcq_enabled(hba)) {
> +		int utrd_size = sizeof(struct utp_transfer_req_desc);
> +
> +		spin_lock(&hwq->sq_lock);
> +		if (hba->vops && hba->vops->setup_xfer_req)
> +			hba->vops->setup_xfer_req(hba, lrbp->task_tag,
> +						  !!lrbp->cmd);
> +		memcpy(hwq->sqe_base_addr + (hwq->sq_tp_slot * utrd_size),
> +		       lrbp->utr_descriptor_ptr, utrd_size);
> +		ufshcd_inc_tp(hwq);
> +		spin_unlock(&hwq->sq_lock);
> +	} else {
> +		spin_lock_irqsave(&hba->outstanding_lock, flags);
> +		if (hba->vops && hba->vops->setup_xfer_req)
> +			hba->vops->setup_xfer_req(hba, lrbp->task_tag,
> +						  !!lrbp->cmd);
> +		__set_bit(lrbp->task_tag, &hba->outstanding_reqs);
> +		ufshcd_writel(hba, 1 << lrbp->task_tag,
> +			      REG_UTP_TRANSFER_REQ_DOOR_BELL);
> +		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
> +	}

Please leave out the setup_xfer_req() call for the MCQ path since the 
existing setup_xfer_req() calls are not compatible with MCQ.

> @@ -2553,9 +2585,10 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct ufshcd_lrb *lrbp, u8 upiu_flags)
>   	/* command descriptor fields */
>   	ucd_req_ptr->header.dword_0 = UPIU_HEADER_DWORD(
>   				UPIU_TRANSACTION_COMMAND, upiu_flags,
> -				lrbp->lun, lrbp->task_tag);
> +				lrbp->lun, lrbp->task_tag & 0xff);
>   	ucd_req_ptr->header.dword_1 = UPIU_HEADER_DWORD(
> -				UPIU_COMMAND_SET_TYPE_SCSI, 0, 0, 0);
> +				UPIU_COMMAND_SET_TYPE_SCSI, 0, 0,
> +				(lrbp->task_tag & 0xF00) << 4);

Please move this change into a new preparatory patch.

>   		ret = blk_mq_map_queues(map);
> -		WARN_ON_ONCE(ret);
> +
> +		if (ret)
> +			return ret;

Please ignore the blk_mq_map_queues() return value entirely to prevent 
that this patch would cause a merge conflict with the following patch: 
"[PATCH v2 2/2] block: Change the return type of blk_mq_map_queues() 
into void" 
(https://lore.kernel.org/linux-block/CAJpMwyjfn14zN=KUUnJBPswrbWX5zbd6OUrMokuPW1qDTsB4RA@mail.gmail.com/T/#u).

> -		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
> +		dev_err(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
>   			__func__, lrbp->task_tag);

The above change is not related to adding MCQ support so it should be a 
separate patch.

> -	const u32 tag = hba->reserved_slot;
> +	u32 tag = hba->reserved_slot;

What is the motivation of this change?

> +static void ufshcd_release_sdb_queue(struct ufs_hba *hba, int nutrs)
> +{

Please add a comment that explains what "sdb" stands for.

> +	ucdl_size = (sizeof(struct utp_transfer_cmd_desc) * nutrs);

No superfluous parentheses please.

> -static void ufshcd_host_memory_configure(struct ufs_hba *hba)
> +static int ufshcd_host_memory_configure(struct ufs_hba *hba)
>   {
>   	struct utp_transfer_req_desc *utrdlp;
>   	dma_addr_t cmd_desc_dma_addr;
> @@ -3756,6 +3811,8 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
>   
>   		ufshcd_init_lrb(hba, &hba->lrb[i], i);
>   	}
> +
> +	return 0;
>   }

What is the purpose of this change? The above change does not seem 
useful to me.

> -	/* Configure UTRL and UTMRL base address registers */
> +	/* Configure UTRL base address registers */
>   	ufshcd_writel(hba, lower_32_bits(hba->utrdl_dma_addr),
>   			REG_UTP_TRANSFER_REQ_LIST_BASE_L);
>   	ufshcd_writel(hba, upper_32_bits(hba->utrdl_dma_addr),
>   			REG_UTP_TRANSFER_REQ_LIST_BASE_H);
> +
> +	/* Configure UTMRL base address registers */
>   	ufshcd_writel(hba, lower_32_bits(hba->utmrdl_dma_addr),
>   			REG_UTP_TASK_REQ_LIST_BASE_L);

Since the above change is independent of adding MCQ support, consider 
moving it into a separate patch.

> +void ufshcd_compl_one_task(struct ufs_hba *hba, int task_tag,
> +			  struct cq_entry *cqe)
> +{
> +	struct ufshcd_lrb *lrbp;
> +	struct scsi_cmnd *cmd;
> +
> +	lrbp = &hba->lrb[task_tag];
> +	lrbp->compl_time_stamp = ktime_get();
> +	cmd = lrbp->cmd;
> +	if (cmd) {
> +		if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
> +			ufshcd_update_monitor(hba, lrbp);
> +		ufshcd_add_command_trace(hba, lrbp, UFS_CMD_COMP);
> +		cmd->result = ufshcd_transfer_rsp_status(hba, lrbp, cqe);
> +		ufshcd_release_scsi_cmd(hba, lrbp);
> +		/* Do not touch lrbp after scsi done */
> +		scsi_done(cmd);
> +	} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
> +		   lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
> +		if (hba->dev_cmd.complete) {
> +			hba->dev_cmd.cqe = cqe;
> +			ufshcd_add_command_trace(hba, lrbp, UFS_DEV_COMP);
> +			complete(hba->dev_cmd.complete);
> +			ufshcd_clk_scaling_update_busy(hba);
> +		}
> +	}
> +}

Please add a new patch to this patch series that introduces the 
ufshcd_compl_one_task() and in this patch introduce MCQ support in that 
function.

> +/**
> + * ufshcd_handle_mcq_cq_events - handle MCQ completion queue events
> + * @hba: per adapter instance
> + *
> + * Returns
> + *  IRQ_HANDLED - If interrupt is valid
> + *  IRQ_NONE    - If invalid interrupt
> + */

How could an interrupt be invalid? Please improve these descriptions or 
leave them out. Mentioning that this function either returns IRQ_HANDLED 
or IRQ_NONE should be sufficient.

> +static irqreturn_t ufshcd_handle_mcq_cq_events(struct ufs_hba *hba)
> +{
> +	struct ufs_hw_queue *hwq;
> +	unsigned long outstanding_cqs;
> +	unsigned int nr_queues;
> +	int i, ret;
> +	u32 events;
> +
> +	ret = ufshcd_vops_get_outstanding_cqs(hba, &outstanding_cqs);
> +	if (ret)
> +		outstanding_cqs = (1U << hba->nr_hw_queues) - 1;
> +
> +	/* Exclude the poll queues */
> +	nr_queues = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
> +	for_each_set_bit(i, &outstanding_cqs, nr_queues) {
> +		hwq = &hba->uhq[i];
> +
> +		events = ufshcd_mcq_read_cqis(hba, i);
> +		if (events)
> +			ufshcd_mcq_write_cqis(hba, events, i);
> +
> +		if (events & UFSHCD_MCQ_CQIS_TEPS)
> +			ufshcd_mcq_poll_cqe_nolock(hba, hwq);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

Why the loop over the completion queues? Shouldn't UFSHCI 4.0 compliant 
controllers support one interrupt per completion queue?

> -/* Complete requests that have door-bell cleared */
> +/*
> + * Complete requests that have door-bell cleared and/or pending completion
> + * entries on completion queues if MCQ is enabled
> + */

Since the above comment has been changed, please spell the word doorbell 
correctly (no hyphen).

> @@ -6823,7 +6947,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
>   					enum query_opcode desc_op)
>   {
>   	DECLARE_COMPLETION_ONSTACK(wait);
> -	const u32 tag = hba->reserved_slot;
> +	u32 tag = hba->reserved_slot;

Why has the 'const' keyword been removed?

> +	if (hba->nutrs != old_nutrs) {
> +		ufshcd_release_sdb_queue(hba, old_nutrs);
> +		ret = ufshcd_memory_alloc(hba);
> +		if (ret)
> +			return ret;
> +		ufshcd_host_memory_configure(hba);
> +	}

Can this freeing + reallocating be avoided?

> -static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
> +static int ufshcd_probe_hba(struct ufs_hba *hba, bool initial_boot)

Please move this change into a separate patch.

> +	if (!is_mcq_supported(hba)) {
> +		/* Refer ufshcd_map_queues() */
> +		hba->nr_queues[HCTX_TYPE_DEFAULT] = 1;
> +		hba->nr_queues[HCTX_TYPE_READ] = 0;
> +		hba->nr_queues[HCTX_TYPE_POLL] = 1;
> +		hba->nr_hw_queues = 1;
> +	}

Can the above code be moved into ufshcd_map_queues()?

> @@ -589,6 +591,7 @@ struct ufs_dev_info {
>   	u8	*model;
>   	u16	wspecversion;
>   	u32	clk_gating_wait_us;
> +	u8	bqueuedepth;

Please document the meaning of bqueuedepth.

> +	bool	b_ext_iid_en;

Same comment here.

>   /* clock gating state  */
> @@ -713,6 +723,39 @@ struct ufs_hba_monitor {
>   	bool enabled;
>   };
>   
> +struct ufshcd_res_info_t {
> +	char *name;
> +	struct resource *resource;
> +	bool is_alloc;
> +	void __iomem *base;
> +};

Please document the meaning of this data structure and consider making 
the 'name' pointer const char * instead of char *.

> +#define for_each_hw_queue(hba, i) \
> +	for ((i) = 0; (i) < (hba)->nr_hw_queues; (i)++)

Please remove this macro and open-code this for-loop. I think that will 
improve source code readability.

> +static inline void ufshcd_inc_tp(struct ufs_hw_queue *q)
> +{
> +	u32 next_slot = ((q->sq_tp_slot + 1) % q->max_entries);
> +	u32 val = next_slot * sizeof(struct utp_transfer_req_desc);
> +
> +	q->sq_tp_slot = next_slot;
> +
> +	writel(val, q->mcq_sq_tp);
> +}

Can q->max_entries be made a power of two such that the % above can be 
changed into & (logical and)?

> -#define ufshcd_writel(hba, val, reg)	\
> +#define ufshcd_writel(hba, val, reg)		\

As requested before, please do not make any unnecessary whitespace changes.

> +struct cq_entry {
> +	/* DW 0-1 */
> +	__le32 command_desc_base_addr_lo;
> +	__le32 command_desc_base_addr_hi;

Please use a single __le64 member instead of two __le32 members.

> +	/* DW 2 */
> +	__le16  response_upiu_length;
> +	__le16  response_upiu_offset;
> +
> +	/* DW 3 */
> +	__le16  prd_table_length;
> +	__le16  prd_table_offset;
> +
> +	/* DW 4 */
> +	__le32 status;
> +
> +	/* DW 5-7 */
> +	u32 reserved[3];
> +};

Consider adding a static_assert() that verifies the structure size at 
compile time.

Thanks,

Bart.
