Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116BD4981AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbiAXOEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:04:21 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:48014 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiAXOET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643033059; x=1674569059;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hK6Gk5mnXF4IHRICMmepTdEfNCx/EzeL17Dix2QUIaU=;
  b=OGSCboF8Fn9X54gI+CpLoN7tH+gJi/KtdhubT5uyh6/cQiIOGW0KfZBl
   Wtlr8LM/DabWj2unrWbYcf1OBR/D8YO8GPHVR14ZDHZCkFGe/pTFJdp5k
   m5dJzICVsQma+KvLsYIsJX6W/pG4fx8k5sckRk7Dqqoc9A0hOJxhrRvSN
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Jan 2022 06:04:19 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 06:04:19 -0800
Received: from [10.216.45.46] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 24 Jan
 2022 06:04:15 -0800
Message-ID: <49c9611e-f8cd-3a18-19b3-123da5d8d8eb@quicinc.com>
Date:   Mon, 24 Jan 2022 19:34:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] remoteproc: Use unbounded/high priority workqueue for
 recovery work
Content-Language: en-US
To:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1642620644-19297-1-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1642620644-19297-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+linux-arm-msm

Thanks,
-Mukesh

On 1/20/2022 1:00 AM, Mukesh Ojha wrote:
> There could be a scenario where there is too much load(n number
> of tasks which is affined) on a core on which rproc recovery
> is queued. Due to which, it takes number of seconds to complete
> the recovery.
>
> If we make this queue unbounded and move it to high priority worker
> pool then this work can be attempted to finished in less time.
>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   drivers/remoteproc/remoteproc_core.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 69f51ac..efb6316 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -59,6 +59,7 @@ static int rproc_release_carveout(struct rproc *rproc,
>   
>   /* Unique indices for remoteproc devices */
>   static DEFINE_IDA(rproc_dev_index);
> +static struct workqueue_struct *rproc_recovery_wq;
>   
>   static const char * const rproc_crash_names[] = {
>   	[RPROC_MMUFAULT]	= "mmufault",
> @@ -2752,8 +2753,10 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
>   	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
>   		rproc->name, rproc_crash_to_string(type));
>   
> -	/* Have a worker handle the error; ensure system is not suspended */
> -	queue_work(system_freezable_wq, &rproc->crash_handler);
> +	if (rproc_recovery_wq)
> +		queue_work(rproc_recovery_wq, &rproc->crash_handler);
> +	else
> +		queue_work(system_freezable_wq, &rproc->crash_handler);
>   }
>   EXPORT_SYMBOL(rproc_report_crash);
>   
> @@ -2802,6 +2805,11 @@ static void __exit rproc_exit_panic(void)
>   
>   static int __init remoteproc_init(void)
>   {
> +	rproc_recovery_wq = alloc_workqueue("rproc_recovery_wq", WQ_UNBOUND |
> +				WQ_HIGHPRI | WQ_FREEZABLE, 0);
> +	if (!rproc_recovery_wq)
> +		pr_err("remoteproc: creation of rproc_recovery_wq failed\n");
> +
>   	rproc_init_sysfs();
>   	rproc_init_debugfs();
>   	rproc_init_cdev();
> @@ -2818,6 +2826,8 @@ static void __exit remoteproc_exit(void)
>   	rproc_exit_panic();
>   	rproc_exit_debugfs();
>   	rproc_exit_sysfs();
> +	if (rproc_recovery_wq)
> +		destroy_workqueue(rproc_recovery_wq);
>   }
>   module_exit(remoteproc_exit);
>   
