Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE4E5B2A18
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIHXWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIHXWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:22:01 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF6CEA63D;
        Thu,  8 Sep 2022 16:21:59 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id o4so19229473pjp.4;
        Thu, 08 Sep 2022 16:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IcIdx+NSvtXOd2u1FXhN/9FgEH3qxdrtu1Uy/JavQ+U=;
        b=193Y/1MHotF176kGuvfLJu9RF5xVdSEibBR8zKyjeAYZm0+36FThzIBzz+tymlvO/I
         dTARKS1BeMfPBqZf7S592AadMlH2FmpInxhT/NcL56GTq4j2ujOMYjdgb3eClfTNeex1
         kJWvLLP/pw1IPL7t993sENed6nwCziukkS+IYOr1I+7gbscAzLIfxFRI3qMdM5IrajnU
         UHwpuwFyk/Rd5Dt1e6urZ4AheT7lfxojPYHI03FHzHRcfp7cJXEuX6WB2c5sUWjHslG0
         QLbYh9r2nn0erQqweZVuRP0Z+/9+p7YlQ6u5YkRSwD5buy75ljR66/5pUd0W1nH0TNTx
         firw==
X-Gm-Message-State: ACgBeo1MWtkHYcOdibVR/LjGPMKTvyDPh5qmok3jlRF16fMc4SchOk4O
        RY5mlifQv/kGH+K14ze6rCTDLuInT5c=
X-Google-Smtp-Source: AA6agR6ptNBrkGSVDx1xoBYlxei8Js+quhxB2DSCO5HcywYLYGHOFV9xoV6KwzfniH7AvbtrzPysDw==
X-Received: by 2002:a17:90b:3a8c:b0:1fd:e8a7:165 with SMTP id om12-20020a17090b3a8c00b001fde8a70165mr6487041pjb.179.1662679318451;
        Thu, 08 Sep 2022 16:21:58 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c18a:7410:112c:aa7c? ([2620:15c:211:201:c18a:7410:112c:aa7c])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e74200b00176a2d23d1asm76536plf.56.2022.09.08.16.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 16:21:57 -0700 (PDT)
Message-ID: <e9fdb47c-3378-8571-d5cf-dcbcd148e5a6@acm.org>
Date:   Thu, 8 Sep 2022 16:21:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH v3 2/4] ufs: core: mcq: Adds Multi-Circular Queue
 support
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, avri.altman@wdc.com, mani@kernel.org,
        quic_cang@quicinc.com, beanhuo@micron.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
 <04f4949e4dea991a93bdf6727bf12948ecc586be.1662157846.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <04f4949e4dea991a93bdf6727bf12948ecc586be.1662157846.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 15:41, Asutosh Das wrote:
> In v4.0, UFSHCI specification has added Multi-Circular Queue
> support to enhance performance. It is backward compatible to
> the legacy Single Doorbell mode.

The above may be confusing for someone who is not familiar with the 
UFSHCI 4.0 specification. Consider changing the above text into the 
following: "The UFSHCI 4.0 register interface defines two modes: (1) a 
legacy mode that is compatible with UFSHCI 3.0 and (2) an MCQ mode in 
which multiple submission and completion queues are supported. A 
capability register indicates whether (1) and/or (2) are supported."

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
> +MODULE_PARM_DESC(rw_queues,
> +		 "Number of interrupt driven I/O queues used for rw. Default value is 8");

rw_queues should be >= 1 and <= 32. However, rw_queue_count_set() allows 
to set this variable to zero and also to values above 32. I think this 
needs to be improved.

> +/* resources */
> +static const struct ufshcd_res_info_t ufshcd_res_info[RES_MAX] = {
> +	{"ufs_mem", NULL, NULL},
> +	{"mcq", NULL, NULL},
> +	{"mcq_sqd", NULL, NULL},
> +	{"mcq_sqis", NULL, NULL},
> +	{"mcq_cqd", NULL, NULL},
> +	{"mcq_cqis", NULL, NULL},
> +	{"mcq_vs", NULL, NULL},
> +};

Please make the above easier to verify by using designated initializers 
([RES_MEM] = { .name = "ufs_mem" }, ...).

> +
> +/**
> + * ufshcd_mcq_decide_queue_depth - decide the queue depth
> + * @hba - per adapter instance
> + *
> + * MAC - Max. Active Command of the Host Controller (HC)
> + * HC wouldn't send more than this commands to the device.

wouldn't -> won't

> +	/*  MAC is a 0 based value. */
> +	mac += 1;
> +	qd = min_t(u32, mac, hba->dev_info.bqueuedepth);
> +	if (!qd)
> +		qd = mac;

Please use min_not_zero instead of open-coding it.

> +}
> +
> +/**
> + * ufshcd_mcq_config_mac - Set the #Max Activ Cmds.
> + * @hba - per adpater instance

adpater -> adapter

> + * @max_active_cmds - maximum # of active commands to the device at any time.
> + *
> + * The controller wouldn't send more than the max_active_cmds to the device at

wouldn't -> won't

> +/* ROP - Runtime and operation registers configuration */

The above comment seems misleading to me. In the UFSHCI 4.0 
specification the operation and runtime registers start with IS - 
Interrupt Status while the definitions below are for the MCQ submission 
and completion queue registers.

> +#define MCQ_CFG_n(r, i) \
> +	((r) + MCQ_QCFG_SIZE * (i))

Please add a clear comment above this macro that explains its role and 
also the meaning of its arguments. I assume that 'i' is the queue index?

> +#define MCQ_ROP_OFFSET_n(p, i) \
> +	(hba->mcq_rop[(p)].offset + hba->mcq_rop[(p)].stride * (i))

Also for this macro, please explain its role. I assume that MCQ_CFG_n() 
is used to calculate offsets of registers defined in the UFSHCI 4.0 
specification and that MCQ_ROP_OFFSET_n() is used to calculate offsets 
in the data structure with submission and completion queues?

> +		/* Sbmission Qqueue Doorbell Address Offset */

Sbmission -> Submission
Qqueue -> Queue

> +		/* Save the base addresses for quicker access */

base -> head and tail?

> +		/*
> +		 * Submission Qeueue Enable|Size|Completion Queue ID to
> +		 * Submission Queue Attribute
> +		 */
> +		ufsmcq_writel(hba, (1 << 31) | qsize | (i << 16),
> +			      MCQ_CFG_n(REG_SQATTR, i));

Qeueue -> Queue

> +static void ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
> +{
> +	int i, rem;
> +	u32 hbaq_cap, cmp;
> +	struct Scsi_Host *host = hba->host;
> +
> +	hbaq_cap = hba->mcq_capabilities & 0xff;
> +
> +	rem = hbaq_cap - dev_cmd_queue;

Please handle the case dev_cmd_queue > hbaq_cap (rem < 0) explicitly.

> +	/* min() compares variables of same type */

Please remove this comment. Every kernel developer should know this.

> +	hba->nr_queues[HCTX_TYPE_DEFAULT] = min(hbaq_cap - dev_cmd_queue,
> +						num_possible_cpus());
> +	rem -= hba->nr_queues[HCTX_TYPE_DEFAULT];
> +	if (rem <= 0)
> +		goto out;
> +	cmp = rem;
> +	hba->nr_queues[HCTX_TYPE_POLL] = min(cmp, poll_queues);
> +	rem -= hba->nr_queues[HCTX_TYPE_POLL];
> +	if (rem <= 0)
> +		goto out;
> +	cmp = rem;
> +	hba->nr_queues[HCTX_TYPE_READ] = min(cmp, read_queues);
> +
> +out:
> +	for (i = 0; i < HCTX_MAX_TYPES; i++)
> +		host->nr_hw_queues += hba->nr_queues[i];
> +
> +	hba->nr_hw_queues = host->nr_hw_queues + dev_cmd_queue;

I think there are code paths in this function that can result in 
host->nr_hw_queues becoming larger than the number of submission queues 
supported by the controller. Please fix.

> +static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
> +				     struct ufs_hw_queue *hwq,
> +				     struct cq_entry *cqe)
> +{
> +	dma_addr_t dma_addr;
> +
> +	/* Bits 31:7 UCD base address, 6:5 are reserved, 4:0 is SQ ID */
> +	dma_addr = ((u64)le32_to_cpu(cqe->command_desc_base_addr_hi) << 32) |
> +		   (le32_to_cpu(cqe->command_desc_base_addr_lo) & CQE_UCD_BA);

The above code would become faster if command_desc_base_addr_hi and 
command_desc_base_addr_lo would be combined into a single __le64 member 
variable. Has this been considered?

> +static inline void ufshcd_inc_tp(struct ufs_hw_queue *q)
> +{
> +	u32 mask = q->max_entries - 1;
> +	u32 val;
> +
> +	q->sq_tp_slot = (q->sq_tp_slot + 1) & mask;
> +	val = q->sq_tp_slot * sizeof(struct utp_transfer_req_desc);
> +	writel(val, q->mcq_sq_tp);
> +}

Please consider changing "tp" into "tail" or "tail_pointer" and "hp" 
into "head" or "head_pointer" to improve code readability.

> +EXPORT_SYMBOL_GPL(ufshcd_transfer_req_compl);

Why has this function been exported?

> +enum ufshcd_res {
> +	RES_MEM,
> +	RES_MCQ,
> +	RES_MCQ_SQD,
> +	RES_MCQ_SQIS,
> +	RES_MCQ_CQD,
> +	RES_MCQ_CQIS,
> +	RES_MCQ_VS,
> +	RES_MAX,
> +};

Please add a comment that explains the SQD, SQIS etc. acronyms.

> +/* MCQ Runtime Operation Pointer info structure */
> +struct ufshcd_mcq_rop_info_t {
> +	unsigned long offset;
> +	unsigned long stride;
> +	void __iomem *base;
> +};

Please document the role of the members of this data structure.

Thanks,

Bart.
