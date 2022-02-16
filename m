Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB694B86BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiBPLeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:34:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiBPLeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:34:07 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7631E1FAA37
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645011234; x=1676547234;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pmRMfrAsDFhdvjzY4uN2DGJiavIZ2kryDsFQYGeBUyQ=;
  b=Yl7hGw8QAGcGdMV7WPQwYK3UEfESy0XjDGkX36gNa7DUuQM9TOQpj7d0
   MpYRXn8k2v0aeK/oABN3tMA7D1lmdSyNBHVnWDtKspIXtPSWFk/GCXNtI
   7p4BLbX6yWPrOUVwFi0qtH0vu0DGqES/eRnRPx3h44haK1shMb7AjRhoT
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 16 Feb 2022 03:33:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 03:33:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 03:33:53 -0800
Received: from [10.216.55.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 16 Feb
 2022 03:33:50 -0800
Subject: Re: [PATCH -next] ASoC: codec: wcd938x: Fix NULL but dereferenced
 coccicheck error
To:     Yang Li <yang.lee@linux.alibaba.com>, <perex@perex.cz>
CC:     <tiwai@suse.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220216021116.94384-1-yang.lee@linux.alibaba.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <6c021509-e29f-2946-b411-64242535a370@quicinc.com>
Date:   Wed, 16 Feb 2022 17:03:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220216021116.94384-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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


On 2/16/2022 7:41 AM, Yang Li wrote:
Thanks for Fix Yang!!!
We are going to post complete cleaned patch. Shall we ignore this patch 
for now?
> Eliminate the following coccicheck warning:
> ./sound/soc/codecs/wcd938x.c:4210:21-24: ERROR: component is NULL but
> dereferenced.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 013cc2aea0f6 ("ASoC: codec: wcd938x: Add switch control for selecting CTIA/OMTP Headset")
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   sound/soc/codecs/wcd938x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index 2663fe0bf64f..c46c4bfd84f2 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -4207,7 +4207,7 @@ static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component, bool activ
>   	struct wcd938x_priv *wcd938x;
>   
>   	if (!component) {
> -		dev_err(component->dev, "%s component is NULL\n", __func__);
> +		pr_err("The snd_soc_component is NULL\n");
>   		return false;
>   	}
>   
