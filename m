Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F0E50AE8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 05:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443779AbiDVDiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 23:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443759AbiDVDiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 23:38:11 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1642813D4E;
        Thu, 21 Apr 2022 20:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650598519; x=1682134519;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LsvxuyiURN/Ofy9GA7OFSkaCtTxd5ha4hcARkgV8w8A=;
  b=T/ceD57mcIGHyK2LZA0JWkY5VWQStDXw1CnItfemCCP0Adx4IgMzQc1N
   7bcyFzTR+k7X7mAjdTOYji3cshX30Daa50i3DgaY67h62bionevVA6Vk7
   f7vty8tSUMnA20c++yTQPS+ehKioLh+wqP6rvptn+OVm1OQODT3CB1zOC
   k=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Apr 2022 20:35:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 20:35:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Apr 2022 20:35:18 -0700
Received: from [10.111.175.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 21 Apr
 2022 20:35:16 -0700
Message-ID: <e54e4abe-d0af-4a27-63c4-e0deb855c741@quicinc.com>
Date:   Thu, 21 Apr 2022 20:35:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/hdmi: check return value after calling
 platform_get_resource_byname()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>
CC:     <jilaiw@codeaurora.org>
References: <20220422032227.2991553-1-yangyingliang@huawei.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220422032227.2991553-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2022 8:22 PM, Yang Yingliang wrote:
> It will cause null-ptr-deref if platform_get_resource_byname() returns NULL,
> we need check the return value.
> 
> Fixes: c6a57a50ad56 ("drm/msm/hdmi: add hdmi hdcp support (V3)")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/hdmi/hdmi.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
> index ec324352e862..07e2ad527af9 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
> @@ -142,6 +142,10 @@ static struct hdmi *msm_hdmi_init(struct platform_device *pdev)
>   	/* HDCP needs physical address of hdmi register */
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>   		config->mmio_name);
> +	if (!res) {
> +		ret = -EINVAL;
> +		goto fail;
> +	}
>   	hdmi->mmio_phy_addr = res->start;
>   
>   	hdmi->qfprom_mmio = msm_ioremap(pdev, config->qfprom_mmio_name);
