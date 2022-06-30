Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C827D56206D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbiF3QhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbiF3QhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:37:00 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6941F3B559;
        Thu, 30 Jun 2022 09:36:59 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UDw2pc015110;
        Thu, 30 Jun 2022 18:36:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=PPK7NJXmodZO2xtaWKpT2ki8JN6en9ktaebVlvJYU0M=;
 b=tElMf53uO4MQd5obAVU2EXwhBYahEIvAisQM0Jlz1WtsxJBdK8k8qZDjfaDPugJPUMcg
 rCY0TP934ffw3jfgUIYvehxRwjm0j4/svm9Kcukj2it2QtF2rxLUNRl1ZwKNZoEeJh5R
 1Tm1KSP2R20ADF77XYtEWtyH1GSxpX4lqs6M+wwLbzFDJwXur5XCTY58pl7cGZ4MjXXR
 BRPVPlp9pjJKaa/UoRROkPMHrpQr89gsDKf03kq8DvjAJ6tgac4KL1Byo9fmeYerhe8t
 BwWF6i1qaYPOTEEXctjvkAK5id7fWZF4HLJJv+8l34q7kjvHof2IzOaXxLPOLfceEWTz tA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h1d648y1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 18:36:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 05CC610002A;
        Thu, 30 Jun 2022 18:36:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 012DC226FC5;
        Thu, 30 Jun 2022 18:36:49 +0200 (CEST)
Received: from [10.252.24.34] (10.75.127.44) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 30 Jun
 2022 18:36:45 +0200
Message-ID: <7881ee36-89f6-3ba9-f4ac-7c4e614728dd@foss.st.com>
Date:   Thu, 30 Jun 2022 18:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] remoteproc: core: Introduce rproc_del_carveout
Content-Language: en-US
To:     Chris Lew <quic_clew@quicinc.com>, <bjorn.andersson@linaro.org>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1654888985-3846-1-git-send-email-quic_clew@quicinc.com>
 <1654888985-3846-2-git-send-email-quic_clew@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <1654888985-3846-2-git-send-email-quic_clew@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_12,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/10/22 21:23, Chris Lew wrote:
> To mirror the exported rproc_add_carveout(), add a rproc_del_carveout()
> so memory carveout resources added by devices outside of remoteproc can
> manage the resource lifetime more accurately.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 20 ++++++++++++++++++++
>  include/linux/remoteproc.h           |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 02a04ab34a23..ee71fccae970 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1001,6 +1001,26 @@ void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
>  EXPORT_SYMBOL(rproc_add_carveout);
>  
>  /**
> + * rproc_del_carveout() - remove an allocated carveout region
> + * @rproc: rproc handle
> + * @mem: memory entry to register
> + *
> + * This function removes specified memory entry in @rproc carveouts list.
> + */
> +void rproc_del_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
> +{
> +	struct rproc_mem_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &rproc->carveouts, node) {
> +		if (entry == mem) {
> +			list_del(&mem->node);
> +			return;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(rproc_del_carveout);

This API seems to me quite dangerous because it can be called while carveouts are in use.
At least some checks should be added...

What about using rproc_resource_cleanup instead?

Regards,
Arnaud

> +
> +/**
>   * rproc_mem_entry_init() - allocate and initialize rproc_mem_entry struct
>   * @dev: pointer on device struct
>   * @va: virtual address
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 7c943f0a2fc4..43112aa78ffe 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -658,6 +658,7 @@ struct rproc *devm_rproc_alloc(struct device *dev, const char *name,
>  int devm_rproc_add(struct device *dev, struct rproc *rproc);
>  
>  void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
> +void rproc_del_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
>  
>  struct rproc_mem_entry *
>  rproc_mem_entry_init(struct device *dev,
