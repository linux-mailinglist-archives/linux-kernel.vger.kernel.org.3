Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C687B4B9949
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiBQGdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:33:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiBQGdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:33:43 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF5923810C;
        Wed, 16 Feb 2022 22:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645079609; x=1676615609;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8QN5Fsnwq/FedpzXHFNnaDO/buloQJ+CuQmqKeQPikk=;
  b=tv8khUOdZaV0C/A6MDsGknQSyyQIZnDm2VIzdfBVy1+ZYjmaIUQDShLA
   VCp6mR8HBoWxWQ7HaB7ykvabuBvNh/+2zwM41YwhttUcN7f9VJyY2bHMM
   EOVzGrJPxwmZZTLm3xDqKEX4kbw8+O06CIopos2yht+eUf57WrWOQVHeH
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Feb 2022 22:33:29 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 22:33:28 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 22:33:28 -0800
Received: from [10.111.174.92] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 16 Feb
 2022 22:33:25 -0800
Message-ID: <4b89f5fe-0752-3c6a-3fb0-192f1f2e7b9e@quicinc.com>
Date:   Wed, 16 Feb 2022 22:33:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [REPOST PATCH v4 08/13] drm/msm/disp/dpu1: Don't use DSC with
 mode_3d
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     Rob Clark <robdclark@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-9-vkoul@kernel.org>
 <67006cc4-3385-fe03-bb4d-58623729a8a8@quicinc.com> <Yg3mvEvqYs89dJWI@matsya>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <Yg3mvEvqYs89dJWI@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/2022 10:10 PM, Vinod Koul wrote:
> On 16-02-22, 19:11, Abhinav Kumar wrote:
>>
>>
>> On 2/10/2022 2:34 AM, Vinod Koul wrote:
>>> We cannot enable mode_3d when we are using the DSC. So pass
>>> configuration to detect DSC is enabled and not enable mode_3d
>>> when we are using DSC
>>>
>>> We add a helper dpu_encoder_helper_get_dsc() to detect dsc
>>> enabled and pass this to .setup_intf_cfg()
>>>
>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>
>> We should not use 3D mux only when we use DSC merge topology.
>> I agree that today we use only 2-2-1 topology for DSC which means its using
>> DSC merge.
>>
>> But generalizing that 3D mux should not be used for DSC is not right.
>>
>> You can detect DSC merge by checking if there are two encoders and one
>> interface in the topology and if so, you can disable 3D mux.
> 
> Right now with DSC we disable that as suggested by Dmitry last time.
> Whenever we introduce merge we should revisit this, for now this should
> suffice
> 

Sorry I didnt follow.

The topology which you are supporting today IS DSC merge 2-2-1. I didnt 
get what you mean by "whenever we introduce".

I didnt follow Dmitry's comment either.

"anybody adding support for SDE_RM_TOPOLOGY_DUALPIPE_3DMERGE_DSC handle 
this."

3D mux shouldnt be used when DSC merge is used.

The topology Dmitry is referring to will not use DSC merge but you are 
using it here and thats why you had to make this patch in the first 
place. So I am not sure why would someone who uses 3D merge topology 
worry about DSC merge. Your patch is the one which deals with the 
topology in question.

What I am suggesting is a small but necessary improvement to this patch.

All that you have to do is in query whether DSC merge is used from the 
topology. You can do it in multiple ways:

1) Either query this from the encoder
2) Store a bool "dsc_merge" in the intf_cfg

