Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E91D527E61
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240936AbiEPHOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240911AbiEPHOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:14:10 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A513E005;
        Mon, 16 May 2022 00:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652685249; x=1684221249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xEsIPosUyXoJAygrBVu27eU3Ktiq+RnmcB1ep7xCiDc=;
  b=NWxSHPlMs81b+juhMDnP4sUCcnpbhEeh8UWXwDe+/mJjVhHs8hgitoz8
   rMWmWPo27To9NQzQ++mC/SZzP8uHanzcmpIQIFy6Fqgzl92GBcLXkOvCO
   eA0fGHux0+hEukrElWrRkUiN3aLswyduNBYBxlsT33GLr55O3OnjzRniH
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 16 May 2022 00:14:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 00:14:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 16 May 2022 00:14:08 -0700
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 16 May
 2022 00:14:05 -0700
Message-ID: <61028345-234b-6e5e-6bd5-e10165dbdf52@quicinc.com>
Date:   Mon, 16 May 2022 15:14:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] stm class: Fix double add issue when store source_link
Content-Language: en-US
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20220418114658.6491-1-quic_jinlmao@quicinc.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <20220418114658.6491-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reviewers,

Could you please help to review this patch ?

Thanks

Jinlong Mao

On 4/18/2022 7:46 PM, Mao Jinlong wrote:
> If two threads store the same stm device to stm_source_link
> at the same time when stm->link_list is empty, it is possible
> that stm_source_link_add will be called for both of these two
> threads. Then double add issue below will happen. Add mutex
> lock for stm_source_link drop and stm_source_link add to avoid
> this race condition.
>
> [ 12.386579][ T1024] list_add double add: new=ffffff87b73ebd90,
> prev=ffffff87b73ebd90, next=ffffffc012737700.
> [ 12.386657][ T1024] -----------[ cut here ]-----------
> [ 12.386671][ T1024] kernel BUG at lib/list_debug.c:31!
> [ 12.388845][ T1024] CPU: 2 PID: 1024 Comm: sh
> [ 12.389162][ T1024] Call trace:
> [ 12.389174][ T1024] __list_add_valid+0x68/0x98
> [ 12.389199][ T1024] stm_source_link_store+0xcc/0x314 [stm_core]
> [ 12.389213][ T1024] dev_attr_store+0x38/0x8c
> [ 12.389228][ T1024] sysfs_kf_write+0xa0/0x100
> [ 12.389239][ T1024] kernfs_fop_write_iter+0x1b0/0x2f8
> [ 12.389253][ T1024] vfs_write+0x300/0x37c
> [ 12.389264][ T1024] ksys_write+0x84/0x12c
>
> Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/stm/core.c | 7 ++++++-
>   drivers/hwtracing/stm/stm.h  | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index 2712e699ba08..e73ac961acb2 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -1171,11 +1171,14 @@ static ssize_t stm_source_link_store(struct device *dev,
>   	struct stm_device *link;
>   	int err;
>   
> +	mutex_lock(&src->link_mutex);
>   	stm_source_link_drop(src);
>   
>   	link = stm_find_device(buf);
> -	if (!link)
> +	if (!link) {
> +		mutex_lock(&src->link_mutex);
>   		return -EINVAL;
> +	}
>   
>   	pm_runtime_get(&link->dev);
>   
> @@ -1185,6 +1188,7 @@ static ssize_t stm_source_link_store(struct device *dev,
>   		/* matches the stm_find_device() above */
>   		stm_put_device(link);
>   	}
> +	mutex_unlock(&src->link_mutex);
>   
>   	return err ? : count;
>   }
> @@ -1251,6 +1255,7 @@ int stm_source_register_device(struct device *parent,
>   
>   	stm_output_init(&src->output);
>   	spin_lock_init(&src->link_lock);
> +	mutex_init(&src->link_mutex);
>   	INIT_LIST_HEAD(&src->link_entry);
>   	src->data = data;
>   	data->src = src;
> diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
> index a9be49fc7a6b..60b814cc00e0 100644
> --- a/drivers/hwtracing/stm/stm.h
> +++ b/drivers/hwtracing/stm/stm.h
> @@ -79,6 +79,7 @@ void stm_put_device(struct stm_device *stm);
>   struct stm_source_device {
>   	struct device		dev;
>   	struct stm_source_data	*data;
> +	struct mutex		link_mutex;
>   	spinlock_t		link_lock;
>   	struct stm_device __rcu	*link;
>   	struct list_head	link_entry;
