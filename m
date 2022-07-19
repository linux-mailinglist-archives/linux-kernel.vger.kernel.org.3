Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9910B57AA1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbiGSXB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiGSXBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:01:45 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFF248CA7;
        Tue, 19 Jul 2022 16:01:44 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id g17so13336565plh.2;
        Tue, 19 Jul 2022 16:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xhDEhI9W3r0tgS4vuGg41F4c9mOtcP/mRh6bWKLOHZU=;
        b=pLIRWzm+5Yg7C6HY77dLj0ozs60zaLArnMajh+fMzEK67tGOf6MbyhC+4EsQDm8gs7
         kaw1QeeN2e/J9UUKyiP5gk8PMQgrAKVGqPCthg39tpiHLhAi2xTxKqsH86V9Xxoyp9eI
         eFqgpWjHKw298No/QQejL8d3sNf0Q2QmFmKu4HfetCZKuM/v79/5lhmYFznAp+VQu4wF
         56xyhokrsHjZrnEAZDMmWtWiNg6ncK0e0/rx6v/pSktNyAKrlK/PUH9gOowmpfMsSYEQ
         IBaacXPydHgjNzYKxkpOqZ056iSyKPllDARGakHSocoq2owGQoi1cBopGCXNEcF1tBgX
         QOmw==
X-Gm-Message-State: AJIora/or5ff1rhPpckvFBl1SOhfNVKvhNpEgT54rsi6YJPzt7qhL8ej
        3rFJRaEsqYKsdcPX9KwfrVQ=
X-Google-Smtp-Source: AGRyM1v2B1M9tKYL+w1mNjlzY3/AsOX8asMlyHHcHTAPuUEv0J02qTIHe1E//c6ej3BYytEGYxQXYA==
X-Received: by 2002:a17:902:7c04:b0:16c:2e00:395a with SMTP id x4-20020a1709027c0400b0016c2e00395amr36045275pll.123.1658271704067;
        Tue, 19 Jul 2022 16:01:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a7e0:78fc:9269:215b? ([2620:15c:211:201:a7e0:78fc:9269:215b])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902b70e00b0016d0b6a20adsm2188219pls.230.2022.07.19.16.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 16:01:43 -0700 (PDT)
Message-ID: <bb9ceab1-e90d-acab-ae5a-70aa225f723c@acm.org>
Date:   Tue, 19 Jul 2022 16:01:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, beanhuo@micron.com, quic_asutoshd@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        linux-scsi@vger.kernel.org, kernel-team@android.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 00:01, Can Guo wrote:
> +/**
> + * @ucdl_base_addr: UFS Command Descriptor base address
> + * @sqe_base_addr: submission queue entry base address
> + * @sqe_shadow_addr: submission queue entry shadow address
> + * @ucdl_dma_addr: UFS Command Descriptor DMA address
> + * @sqe_dma_addr: submission queue dma address
> + * @cqe_base_addr: completion queue base address
> + * @cqe_dma_addr: completion queue dma address
> + * @lrb: array of lrb for this hardware queue
> + * @max_entries: max number of slots in this hardware queue
> + * @sq_tp_slot: current slot to which SQ tail pointer is pointing
> + * @sq_hp_slot: current slot to which SQ head pointer is pointing
> + * @cq_tp_slot: current slot to which CQ tail pointer is pointing
> + * @cq_hp_slot: current slot to which CQ head pointer is pointing
> + */
> +struct ufs_hw_queue {
> +	struct utp_transfer_cmd_desc *ucdl_base_addr;
> +	void *sqe_base_addr;
> +	struct utp_transfer_req_desc *sqe_shadow_addr;
> +	dma_addr_t ucdl_dma_addr;
> +	dma_addr_t sqe_dma_addr;
> +	struct cq_entry *cqe_base_addr;
> +	dma_addr_t cqe_dma_addr;
> +	struct ufshcd_lrb *lrb;
> +	u32 max_entries;
> +	u32 id;
> +
> +	void __iomem *mcq_sq_hp;
> +	void __iomem *mcq_sq_tp;
> +	void __iomem *mcq_cq_hp;
> +	void __iomem *mcq_cq_tp;
> +
> +	spinlock_t sq_lock;
> +	u32 sq_tp_slot;
> +	u32 sq_hp_slot;
> +	spinlock_t cq_lock;
> +	u32 cq_tp_slot;
> +	u32 cq_hp_slot;
>   };
>   

Please move all new data structures into a private header that can be 
moved into a private header. I think the above data structure can be 
moved from a public into a private header (a header that is not shared 
with the host drivers).

> +#define for_each_hw_queue(hba, i) \
> +	for ((i) = 0; (i) < (hba)->nr_hw_queues; (i) ++)

A macro like the above reduces code readability. Please remove this 
macro definition.

> +static inline bool is_mcq_enabled(struct ufs_hba *hba)
> +{
> +	return hba->use_mcq;
> +}
> +
> +static inline bool is_mcq_supported(struct ufs_hba *hba)
> +{
> +	return hba->mcq_sup;
> +}

The names of the two above functions are longer than their 
implementation so it's probably better to remove these function definitions.

> -#define ufshcd_writel(hba, val, reg)	\
> +#define ufshcd_writel(hba, val, reg)		\
>   	writel((val), (hba)->mmio_base + (reg))

Is this a whitespace-only change? If so, should that change be in this 
patch?

Thanks,

Bart.
