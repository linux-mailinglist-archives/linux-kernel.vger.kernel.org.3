Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2394B2D37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbiBKS7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:59:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiBKS7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:59:47 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E251CD8;
        Fri, 11 Feb 2022 10:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644605986; x=1676141986;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=10MNTyWKrFElxhMmkbbRa8eHQjuoljFrhQU1QJPnd58=;
  b=JKr3XVndKeATPGzOtQLIpr+M7xnWoUVRJXFyjvCiFeghuHJAaLzR/ZVd
   0PUxViCZ5PelSnkwPr49PhNn8Q3OYrosumZkCpGTb3zZ4HkDcDStFLkHW
   k89f6lHBbfIMx9Z3X4+KnJR3s/uThcLYj28M8Vu+FH/lMYO35XEylM08o
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Feb 2022 10:59:46 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 10:59:44 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 10:59:44 -0800
Received: from [10.38.246.233] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 11 Feb
 2022 10:59:41 -0800
Message-ID: <654d620b-9e14-c47f-b48c-762dc0bd32a1@quicinc.com>
Date:   Fri, 11 Feb 2022 10:59:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <johannes@sipsolutions.net>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <robdclark@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <nganji@codeaurora.org>,
        <aravindh@codeaurora.org>, <khsieh@codeaurora.org>,
        <daniel@ffwll.ch>, <dmitry.baryshkov@linaro.org>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
 <YgZD8vPqB7ISpRpZ@kroah.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <YgZD8vPqB7ISpRpZ@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Greg

Thanks for the response.

On 2/11/2022 3:09 AM, Greg KH wrote:
> On Tue, Feb 08, 2022 at 11:44:32AM -0800, Abhinav Kumar wrote:
>> There are cases where depending on the size of the devcoredump and the speed
>> at which the usermode reads the dump, it can take longer than the current 5 mins
>> timeout.
>>
>> This can lead to incomplete dumps as the device is deleted once the timeout expires.
>>
>> One example is below where it took 6 mins for the devcoredump to be completely read.
>>
>> 04:22:24.668 23916 23994 I HWDeviceDRM::DumpDebugData: Opening /sys/class/devcoredump/devcd6/data
>> 04:28:35.377 23916 23994 W HWDeviceDRM::DumpDebugData: Freeing devcoredump node
> 
> What makes this so slow?  Reading from the kernel shouldn't be the
> limit, is it where the data is being sent to?

We are still checking this. We are seeing better read times when we bump 
up the thread priority of the thread which was reading this.
We are also trying to check if bumping up CPU speed is helping.
But, results have not been consistently good enough. So we thought we 
should also increase the timeout to be safe.


> 
>> Increase the timeout to 10 mins to accommodate system delays and large coredump
>> sizes.
> 
> Nit, please wrap your changelog texts at 72 columns.
> 
Yes, i will fix this when I re-post.

> And what is "large"?

We are seeing devcoredumps in the range of 2.5MB-3MB. I can also mention 
this in the commit text in the next post.

Thanks

Abhinav

> 
> thanks,
> 
> greg k-h
