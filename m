Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815994D9608
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbiCOITw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiCOITr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:19:47 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207D8220D1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:18:34 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso909557wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hXZZIj5GGF89bKERKNRPiIP8jHa9C2nb6Ml2eNi4tC0=;
        b=VYNqbeoyAv1OkVHEDNmsKPH2WYwlQpGoj7xhTwlOxgoXxhcoOab27PqYrDz6xgawkn
         AKsV9myRcI/g8389ufMlluWkpauIhcb8ZAaiVZolVwY8Al8OkK+HPjD4RfuDevCNdx07
         4gI6htZGS/4BpKwKiXPPgDWjjnHwrpXyfvFEzUL+/z+Za5Vzjyzyx5RTCxKyxCqQXpV0
         Wjdsdv67/jVwfFhqlHtL0ECUGDx9S1/+9ThXamA4IHSCVxruskU0YVfi2sa975RJcmTP
         evRxLQRFd+X9in5hgYUNqK8LuEXdu7Fy3ZY//PBQdfNhjfEMoV1Kw1fEtsgJUQ/3XCCD
         fgjw==
X-Gm-Message-State: AOAM530DAJFd+OqvwAnzaLFTo0N/CTuO3Fr1mf7KZHogah+/HNE7pT2c
        cWCurZicaDdLMMrGe8nLC1o=
X-Google-Smtp-Source: ABdhPJzhBqHFCnc/vLb1M/+hAqNASlFjgOVhWwlsOLFSfrovFe62ZRWVJxl27DajRdvmdPl71X60Ug==
X-Received: by 2002:a05:600c:19ce:b0:389:cd98:415e with SMTP id u14-20020a05600c19ce00b00389cd98415emr2263494wmq.23.1647332312717;
        Tue, 15 Mar 2022 01:18:32 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y2-20020a056000108200b001f078fc13a7sm15351506wrw.73.2022.03.15.01.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 01:18:32 -0700 (PDT)
Message-ID: <a3051d85-c08e-a273-c7cc-2eb3e21df717@grimberg.me>
Date:   Tue, 15 Mar 2022 10:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] driver/nvme/host: Support duplicated nsid for the
 private ns
Content-Language: en-US
To:     "hch@lst.de" <hch@lst.de>, Sungup Moon <sungup.moon@samsung.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220315071230.GA2069@lst.de> <20220315071926.GA2137@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315071926.GA2137@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/22 09:19, hch@lst.de wrote:
> On Tue, Mar 15, 2022 at 08:12:30AM +0100, hch@lst.de wrote:
>> I looked at this a bit more and found two issues:
>>
>>   - nvme_init_ns_head will now leak the ns_head for the private namespaces
>>     with potentially duplicate IDs case.
>>   - nvme_mpath_set_disk_name still needs to use the subsystem-wide IDA
>>     for the nvme instance name as the subsystem and controller ones
>>     could otherwise clash.
>>
>> Let me know what you think of this version:
> 
> Except that this had the parts to actually make it compile uncommited,
> so here is the proper one:
> 
> ---
>  From c6deed0b18d66460b090d22ee18f37d631d0fd12 Mon Sep 17 00:00:00 2001
> From: Sungup Moon <sungup.moon@samsung.com>
> Date: Mon, 14 Mar 2022 20:05:45 +0900
> Subject: nvme: allow duplicated NSIDs for the private namespaces
> 
> A NVMe subsystem with multiple controller can have private namespaces
> that use the same NSID under some conditions:
> 
>   "If Namespace Management, ANA Reporting, or NVM Sets are supported, the
>    NSIDs shall be unique within the NVM subsystem. If the Namespace
>    Management, ANA Reporting, and NVM Sets are not supported, then NSIDs:
>     a) for shared namespace shall be unique; and
>     b) for private namespace are not required to be unique."
> 
> Reference: Section 6.1.6 NSID and Namespace Usage; NVM Express 1.4c spec.
> 
> Make sure this specific setup is supported in Linux.
> 
> Signed-off-by: Sungup Moon <sungup.moon@samsung.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c      | 12 +++++++++---
>   drivers/nvme/host/multipath.c |  7 ++++---
>   drivers/nvme/host/nvme.h      | 19 +++++++++++++++++++
>   include/linux/nvme.h          |  1 +
>   4 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f8084ded69e50..31f7a479fa08d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3649,15 +3649,21 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
>   	NULL,
>   };
>   
> -static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
> +static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
>   		unsigned nsid)
>   {
> +	struct nvme_subsystem *subsys = ctrl->subsys;
>   	struct nvme_ns_head *h;
>   
>   	lockdep_assert_held(&subsys->lock);

IMO it is a bit strange that we now don't pass in the subsystem but
require that the subsys->lock is taken...

>   
>   	list_for_each_entry(h, &subsys->nsheads, entry) {
> -		if (h->ns_id != nsid)
> +		/*
> +		 * Private namespaces can share NSIDs under some conditions.
> +		 * In that case we can't use the same ns_head for namespaces
> +		 * with the same NSID.
> +		 */
> +		if (h->ns_id != nsid || !nvme_is_uniqueue_nsid(ctrl, h))
>   			continue;
>   		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
>   			return h;
> @@ -3851,7 +3857,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>   	}
>   
>   	mutex_lock(&ctrl->subsys->lock);
> -	head = nvme_find_ns_head(ctrl->subsys, nsid);
> +	head = nvme_find_ns_head(ctrl, nsid);
>   	if (!head) {
>   		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, ids);
>   		if (ret) {
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index d13b81cd6225c..6b6df1016cb91 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -504,10 +504,11 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   
>   	/*
>   	 * Add a multipath node if the subsystems supports multiple controllers.
> -	 * We also do this for private namespaces as the namespace sharing data could
> -	 * change after a rescan.
> +	 * We also do this for private namespaces as the namespace sharing flag
> +	 * could change after a rescan.

What happens in this case? we now have non-unique shared namespaces?

>   	 */
> -	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) || !multipath)
> +	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
> +	    !nvme_is_uniqueue_nsid(ctrl, head) || !multipath)
>   		return 0;
>   
>   	head->disk = blk_alloc_disk(ctrl->numa_node);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 587d92df118b7..9add586434929 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -718,6 +718,25 @@ static inline bool nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   		return queue_live;
>   	return __nvme_check_ready(ctrl, rq, queue_live);
>   }
> +
> +/*
> + * NSID shall be unique for all shared namespaces, or if at least one of the
> + * following conditions is met:
> + *   1. Namespace Management is supported by the controller
> + *   2. ANA is supported by the controller
> + *   3. NVM Set are supported by the controller
> + *
> + * In other case, private namespace are not required to report a unique NSID.
> + */
> +static inline bool nvme_is_uniqueue_nsid(struct nvme_ctrl *ctrl,
> +		struct nvme_ns_head *head)
> +{
> +	return head->shared ||
> +		(ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP) ||
> +		(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA) ||
> +		(ctrl->ctratt & NVME_CTRL_CTRATT_NVM_SETS);
> +}
> +
>   int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>   		void *buf, unsigned bufflen);
>   int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 9dbc3ef4daf7c..2dcee34d467d6 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -345,6 +345,7 @@ enum {
>   	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
>   	NVME_CTRL_VWC_PRESENT			= 1 << 0,
>   	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
> +	NVME_CTRL_OACS_NS_MNGT_SUPP		= 1 << 3,
>   	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
>   	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
>   	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
