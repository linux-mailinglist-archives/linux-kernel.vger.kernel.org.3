Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1BE562074
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiF3Qi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiF3QiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:38:22 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32FDBE;
        Thu, 30 Jun 2022 09:38:21 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UDoHCu022718;
        Thu, 30 Jun 2022 18:38:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=FrQeBHR6fqzTGcaG15KwsehVgR6R2e3NuHEqyCZdBOk=;
 b=K55UqAeegWzDo9W1lrolxuhwWSsHjKz5OkV37sTf0hFrdsYz70xU1fnP7UuxRqE/09VD
 8xFumWPmhvph8fzMuEFdDcoCWtYPaz2MDbVJhPd23Gl6nzc5t+GGUMKHGQJSfmhb9SrL
 SHuxW6bdj7ihYn8Y7vGy0nnfmIhDxAww+h72jvTQpsl08sYj6Aor9/mms8BWBwNsL+73
 T8Rv6mjFbM4j7SI2OrqtcxCa/A3sZzqE9XjfmaGzAACmw4VYt3R3lnyN9lFUi1KVr/EX
 fe8d2VLx43nutwuyEBH/Z3T2GEuypJJqnhwxOaKbatsTqZ7DTXf+EonBhUwYkqhB8+vp gQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h1d2mh4jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 18:38:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E6DF10002A;
        Thu, 30 Jun 2022 18:38:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3956E226FC5;
        Thu, 30 Jun 2022 18:38:13 +0200 (CEST)
Received: from [10.252.24.34] (10.75.127.47) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 30 Jun
 2022 18:38:12 +0200
Message-ID: <1afe75e1-ab57-a321-d319-2d1b8d2b199d@foss.st.com>
Date:   Thu, 30 Jun 2022 18:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] remoteproc: core: Introduce rproc_mem_entry_free
Content-Language: en-US
To:     Chris Lew <quic_clew@quicinc.com>, <bjorn.andersson@linaro.org>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1654888985-3846-1-git-send-email-quic_clew@quicinc.com>
 <1654888985-3846-3-git-send-email-quic_clew@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <1654888985-3846-3-git-send-email-quic_clew@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
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



On 6/10/22 21:23, Chris Lew wrote:
> Introduce a helper to free the rproc_mem_entry allocated by
> rproc_mem_entry_init(). This helper is to help manage rproc carveouts
> added to an rproc outside of remoteproc.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 13 +++++++++++++
>  include/linux/remoteproc.h           |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index ee71fccae970..161691fd2e96 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1069,6 +1069,19 @@ rproc_mem_entry_init(struct device *dev,
>  EXPORT_SYMBOL(rproc_mem_entry_init);
>  
>  /**
> + * rproc_mem_entry_free() - free a rproc_mem_entry struct
> + * @mem: rproc_mem_entry allocated by rproc_mem_entry_init()
> + *
> + * This function frees a rproc_mem_entry_struct that was allocated by
> + * rproc_mem_entry_init().
> + */
> +void rproc_mem_entry_free(struct rproc_mem_entry *mem)
> +{
> +	kfree(mem);
> +}
> +EXPORT_SYMBOL(rproc_mem_entry_free);

Same concerns for this one.

> +
> +/**
>   * rproc_of_resm_mem_entry_init() - allocate and initialize rproc_mem_entry struct
>   * from a reserved memory phandle
>   * @dev: pointer on device struct
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 43112aa78ffe..9b039f37da12 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -666,6 +666,7 @@ rproc_mem_entry_init(struct device *dev,
>  		     int (*alloc)(struct rproc *, struct rproc_mem_entry *),
>  		     int (*release)(struct rproc *, struct rproc_mem_entry *),
>  		     const char *name, ...);
> +void rproc_mem_entry_free(struct rproc_mem_entry *mem);
>  
>  struct rproc_mem_entry *
>  rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, size_t len,
