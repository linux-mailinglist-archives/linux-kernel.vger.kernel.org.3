Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9130B505A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345215AbiDRPDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345012AbiDRPD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:03:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420F87CDFC;
        Mon, 18 Apr 2022 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650290018; x=1681826018;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RM9HnTMjpUcjGLXbo0LjJ+oM3P7uxlGcEk7ni9MPlK4=;
  b=jDAPpIBusH0CIst4PnLzknjLpVsRw2bcny5vGg1g+L6ytBdCOvUcdkRL
   RADjrxbhj4nJTPhXPPQ5TCwWeR9oJ+9M6TPhZz8JjgE7wp2c1Irexyt0C
   RbaMAi3diHU+6LvTR3TPSqBRMcGZw1bohzuPxRs6BxczveN36LLhIndbP
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 Apr 2022 06:53:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 06:53:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 06:53:26 -0700
Received: from [10.226.58.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Apr
 2022 06:53:25 -0700
Message-ID: <eff55b55-cef0-2931-c8e5-95a9230c9d27@quicinc.com>
Date:   Mon, 18 Apr 2022 07:53:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3] bus: mhi: host: Wait for ready state after reset
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_hemantk@quicinc.com>, <quic_bbhatt@quicinc.com>,
        <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1649875946-32516-1-git-send-email-quic_jhugo@quicinc.com>
 <20220418062645.GI7431@thinkpad>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20220418062645.GI7431@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/2022 12:26 AM, Manivannan Sadhasivam wrote:
> On Wed, Apr 13, 2022 at 12:52:26PM -0600, Jeffrey Hugo wrote:
>> From: Jeffrey Hugo <jhugo@codeaurora.org>
>>
>> After the device has signaled the end of reset by clearing the reset bit,
>> it will automatically reinit MHI and the internal device structures.  Once
>> That is done, the device will signal it has entered the ready state.
>>
>> Signaling the ready state involves sending an interrupt (MSI) to the host
>> which might cause IOMMU faults if it occurs at the wrong time.
>>
>> If the controller is being powered down, and possibly removed, then the
>> reset flow would only wait for the end of reset.  At which point, the host
>> and device would start a race.  The host may complete its reset work, and
>> remove the interrupt handler, which would cause the interrupt to be
>> disabled in the IOMMU.  If that occurs before the device signals the ready
>> state, then the IOMMU will fault since it blocked an interrupt.  While
>> harmless, the fault would appear like a serious issue has occurred so let's
>> silence it by making sure the device hits the ready state before the host
>> completes its reset processing.
>>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> 
> I was about to apply this patch but wanted to check with you on using the
> double signed-off by tags. If the patch get's handed over between multiple
> developers then multiple signed-off by's make sense. But since it is you that
> handled the earlier patch also, I think one tag is enough with your new domain.
> 
> One more thing is, using codeaurora domain will bounce now. So, please use the
> quicinc domain for Hemant also.

I'm aware of the bouncing.  Git send-email however is not, and its 
default behavior can be a bit annoying in this edge case.

I've seen the dual SoB by the same developer elsewhere in the community, 
but if you want things "cleaned up" to the new quic ids, I'll do that.
