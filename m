Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEEE4AF6AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbiBIQ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiBIQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:29:56 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63328C0612BE;
        Wed,  9 Feb 2022 08:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644424199; x=1675960199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3K3kwcm0v2sEPmr5KNseEzwNQ4I1DuBKAWIfngEmkfM=;
  b=kX2SrBfAMXaR0RFKGL7Y86WNYg5rBzA19NLRT/JER0f5f4f9UMw3f6EM
   eizTnsvgt6ynxiSm2bwCj5LAmwSbPrMzvEMUSZYl9CMBoWLsklrGVHY9q
   WR9vaKoLuZHw3l/+DiIP/h8gI3+oiGdSlF+IfEnZLyARmkU7l6rXrYALU
   k=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Feb 2022 08:29:58 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:29:58 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 08:29:57 -0800
Received: from [10.111.162.111] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 9 Feb 2022
 08:29:55 -0800
Message-ID: <21477063-bbc7-8af8-f613-e1fe014f6515@quicinc.com>
Date:   Wed, 9 Feb 2022 08:29:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <swboyd@chromium.org>,
        <khsieh@codeaurora.org>, <nganji@codeaurora.org>,
        <seanpaul@chromium.org>, <gregkh@linuxfoundation.org>,
        <dmitry.baryshkov@linaro.org>, <aravindh@codeaurora.org>,
        <freedreno@lists.freedesktop.org>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
 <8d67484c7e4b9fb4560d2eca1f71c75fde8bae0d.camel@sipsolutions.net>
 <ebd340e4-2a02-d484-2ed0-9ee738d5b5c5@quicinc.com>
 <c59bc1af9974484075091333a3c98a2088251321.camel@sipsolutions.net>
 <a280fec2-754a-88ec-acc7-337e069e9148@quicinc.com>
 <c2a6e29063793eecc5c65d32af9d826544404ecc.camel@sipsolutions.net>
 <b60d30cf-e435-49c4-a251-b910bc2e94ae@quicinc.com>
 <2d71a9c0d2cd0b0c82a627b0585040c81a4523fa.camel@sipsolutions.net>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <2d71a9c0d2cd0b0c82a627b0585040c81a4523fa.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Hi Johannes

On 2/8/2022 11:50 PM, Johannes Berg wrote:
> On Tue, 2022-02-08 at 17:55 -0800, Abhinav Kumar wrote:
>>
>> Are you suggesting something like below?
>>
>> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
>> index 42dcf96..14203d0 100644
>> --- a/fs/sysfs/file.c
>>
> 
> No, for sure not, but I guess from the looks of this patch there's no
> way to do something like that for just an individual attribute...
> 
> Oh well.
> 
> johannes

In that case, I was not clear on the previous solution you suggested.
Are you suggesting then we can go ahead with the timeout increase?
If so, can I please get your ack?

Thanks

Abhinav
