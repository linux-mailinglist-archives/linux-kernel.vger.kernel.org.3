Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27E3559866
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiFXLT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXLT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:19:26 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94F660F3D;
        Fri, 24 Jun 2022 04:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656069564; x=1687605564;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hxKeGBCoNVcsY4jmdcJC/1WgkWmF0rNxgTj2EqBC0PU=;
  b=pAdq59qVWyU2tmeXB25qnUVP5SekkytBICBzqmFj/E8VQps1UhV4nWpM
   ecYEYyrPIjBE12KquVZO0eELZ2rR+8mPCmUpc9dfdtXgYiFUJF5H5MK7i
   F3xdYrel0l9FeEbFhFMjeOZoC8EDfkSe1G7o2fuuQlwOiMeJNWj3oz5kH
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Jun 2022 04:19:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 04:19:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 04:19:23 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 24 Jun
 2022 04:19:21 -0700
Subject: Re: [PATCH] remoteproc: qcom: pas: Adjust the phys addr wrt the mem
 region
To:     Yogesh Lal <quic_ylal@quicinc.com>, <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1654200007-5453-1-git-send-email-quic_ylal@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <ed665e94-dab9-9d6c-87d7-aa1efd157755@quicinc.com>
Date:   Fri, 24 Jun 2022 16:49:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1654200007-5453-1-git-send-email-quic_ylal@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Yogesh,
Thanks for the patch.

On 6/3/22 1:30 AM, Yogesh Lal wrote:
> The minidump table in the toc contains physical addresses that may lie
> before the physical address of the first elf segment in relocatable

doesn't this apply to full coredumps as well? Do you plan to address
that in a separate patch?

> images. This change adds a custom dump function for minidumps which
> calculates the offset into the carveout region using the start of
> the physical address instead of the start of the first elf segment.
> 
> Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
> ---
>   drivers/remoteproc/qcom_common.c   |  9 +++++----
>   drivers/remoteproc/qcom_common.h   |  5 ++++-
>   drivers/remoteproc/qcom_q6v5_pas.c | 21 ++++++++++++++++++++-
>   3 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 246e716..503326b 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -101,7 +101,8 @@ static void qcom_minidump_cleanup(struct rproc *rproc)
>   	}
>   }
>   
> -static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem)
> +static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem,
> +									rproc_dumpfn_t dumpfn)
>   {
>   	struct minidump_region __iomem *ptr;
>   	struct minidump_region region;
> @@ -131,7 +132,7 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
>   			}
>   			da = le64_to_cpu(region.address);
>   			size = le32_to_cpu(region.size);
> -			rproc_coredump_add_custom_segment(rproc, da, size, NULL, name);
> +			rproc_coredump_add_custom_segment(rproc, da, size, dumpfn, name);
>   		}
>   	}
>   
> @@ -139,7 +140,7 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
>   	return 0;
>   }
>   
> -void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
> +void qcom_minidump(struct rproc *rproc, unsigned int minidump_id, rproc_dumpfn_t dumpfn)
>   {
>   	int ret;
>   	struct minidump_subsystem *subsystem;
> @@ -179,7 +180,7 @@ void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
>   
>   	rproc_coredump_cleanup(rproc);
>   
> -	ret = qcom_add_minidump_segments(rproc, subsystem);
> +	ret = qcom_add_minidump_segments(rproc, subsystem, dumpfn);
>   	if (ret) {
>   		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
>   		goto clean_minidump;
> diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
> index c35adf7..29e528b 100644
> --- a/drivers/remoteproc/qcom_common.h
> +++ b/drivers/remoteproc/qcom_common.h
> @@ -33,7 +33,10 @@ struct qcom_rproc_ssr {
>   	struct qcom_ssr_subsystem *info;
>   };
>   
> -void qcom_minidump(struct rproc *rproc, unsigned int minidump_id);
> +typedef void (*rproc_dumpfn_t)(struct rproc *rproc, struct rproc_dump_segment *segment,
> +			void *dest, size_t offset, size_t size);

you can perhaps stick with not using typedef like how it is handled in
remoteproc_coredump.

> +
> +void qcom_minidump(struct rproc *rproc, unsigned int minidump_id, rproc_dumpfn_t dumpfn);
>   
>   void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink,
>   			   const char *ssr_name);
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 6e5cbca..9c6cb0b 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -83,11 +83,30 @@ struct qcom_adsp {
>   	struct qcom_sysmon *sysmon;
>   };
>   
> +void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
> +						void *dest, size_t offset, size_t size)
> +{
> +	struct qcom_adsp *adsp = rproc->priv;
> +	int total_offset;
> +
> +	total_offset = segment->da + segment->offset + offset - adsp->mem_phys;
> +	if (total_offset < 0 || total_offset + size > adsp->mem_size) {
> +		dev_err(adsp->dev,
> +			"invalid copy request for segment %pad with offset %zu and size %zu)\n",
> +			&segment->da, offset, size);
> +		memset(dest, 0xff, size);
> +		return;
> +	}
> +
> +	memcpy_fromio(dest, adsp->mem_region + total_offset, size);
> +}
> +
> +
remove additional empty line.

>   static void adsp_minidump(struct rproc *rproc)
>   {
>   	struct qcom_adsp *adsp = rproc->priv;
>   
> -	qcom_minidump(rproc, adsp->minidump_id);
> +	qcom_minidump(rproc, adsp->minidump_id, adsp_segment_dump);
>   }
>   
>   static int adsp_pds_enable(struct qcom_adsp *adsp, struct device **pds,
> 
