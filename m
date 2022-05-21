Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B118752F933
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 08:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbiEUGOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 02:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbiEUGOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 02:14:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6040F166696;
        Fri, 20 May 2022 23:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653113685; x=1684649685;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=88h/XalmwpDNbt5yjyOWwQF42/+dZnwpPutE6jurIgQ=;
  b=pmPbP2xduwmAoyr9upRgZ6pqJARGWpFOU95YojDWjVGscpv06uqPLd7r
   qB7AImcbIp4nJTPfUmOjWSp3kHULj7+wMJOBWx61Lcu3Wiha4klc287xZ
   nq70OokbY387Iv7qsej4lFJlz7RqMS2XsbwyPUGfj71Eeohy2G6t8WWWw
   E=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 20 May 2022 23:14:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 23:14:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 23:14:43 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 20 May
 2022 23:14:41 -0700
Subject: Re: [PATCH 2/2 V2] remoteproc: qcom: Add full coredump fallback
 mechanism
To:     Yogesh Lal <quic_ylal@quicinc.com>, <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
References: <1652181930-22212-1-git-send-email-quic_ylal@quicinc.com>
 <1652181930-22212-2-git-send-email-quic_ylal@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <271132da-4a6a-afd9-4509-47035dd18a8e@quicinc.com>
Date:   Sat, 21 May 2022 11:44:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1652181930-22212-2-git-send-email-quic_ylal@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Yogesh,
Looks like you missed adding the patch that uses the exported
rproc_cleanup api.


On 5/10/22 4:55 PM, Yogesh Lal wrote:
> From: Siddharth Gupta <sidgup@codeaurora.org>
> 
> If a remoteproc's firmware does not support minidump but the driver
> adds an ID, the minidump driver does not collect any coredumps when
> the remoteproc crashes. This hinders the purpose of coredump
> collection. This change adds a fallback mechanism in the event of a
> crash.
> 

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
> ---
>   drivers/remoteproc/qcom_common.c   | 7 +++++--
>   drivers/remoteproc/qcom_q6v5_pas.c | 1 +
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 4b91e3c..b3fdc66 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -163,8 +163,11 @@ void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
>   	 */
>   	if (subsystem->regions_baseptr == 0 ||
>   	    le32_to_cpu(subsystem->status) != 1 ||
> -	    le32_to_cpu(subsystem->enabled) != MD_SS_ENABLED ||
> -	    le32_to_cpu(subsystem->encryption_status) != MD_SS_ENCR_DONE) {
> +	    le32_to_cpu(subsystem->enabled) != MD_SS_ENABLED) {
> +		return rproc_coredump(rproc);
> +	}
> +
> +	if (le32_to_cpu(subsystem->encryption_status) != MD_SS_ENCR_DONE) {
>   		dev_err(&rproc->dev, "Minidump not ready, skipping\n");
>   		return;
>   	}
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 401b1ec..6e5cbca 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -274,6 +274,7 @@ static const struct rproc_ops adsp_minidump_ops = {
>   	.start = adsp_start,
>   	.stop = adsp_stop,
>   	.da_to_va = adsp_da_to_va,
> +	.parse_fw = qcom_register_dump_segments,
>   	.load = adsp_load,
>   	.panic = adsp_panic,
>   	.coredump = adsp_minidump,
> 
