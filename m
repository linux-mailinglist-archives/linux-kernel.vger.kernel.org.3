Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC3B4B33DA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 09:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiBLIfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 03:35:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiBLIfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 03:35:17 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E56213;
        Sat, 12 Feb 2022 00:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644654914; x=1676190914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MeLi2dYMbbNIf6RjIa19QVwgVecV8z/lw2J8bW0VgqA=;
  b=B8Qk5IvWIuVLPOMKuZ01+xFnjeAMJt9tzKBvDotGGYt4wrKxwG/secK8
   sBLipi7oMMQWTrUEztyFHCrHdgMj2gU6ZdzmLE4iuJKtdF/tAYZ5wRmho
   UJwMfWxra6WLRwDWB8VILyGz0ePmDobTT+xXcNIIB93DlXDNIJ5a4r7cx
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 12 Feb 2022 00:35:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 00:35:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 12 Feb 2022 00:35:13 -0800
Received: from [10.38.246.233] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sat, 12 Feb
 2022 00:35:10 -0800
Message-ID: <2add9ba7-7bc8-bd1d-1963-61e8154b0e3c@quicinc.com>
Date:   Sat, 12 Feb 2022 00:35:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <seanpaul@chromium.org>, <swboyd@chromium.org>,
        <nganji@codeaurora.org>, <aravindh@codeaurora.org>,
        <khsieh@codeaurora.org>, <daniel@ffwll.ch>,
        <dmitry.baryshkov@linaro.org>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
 <YgZD8vPqB7ISpRpZ@kroah.com>
 <654d620b-9e14-c47f-b48c-762dc0bd32a1@quicinc.com>
 <Ygdb63FrorUsX/Hg@kroah.com>
 <b9156bde-137c-2fac-19e0-b205ab4d6016@quicinc.com>
 <7db7d01fcf5a3edce61161769c0e6eb1541237bf.camel@sipsolutions.net>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <7db7d01fcf5a3edce61161769c0e6eb1541237bf.camel@sipsolutions.net>
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

Hi Johannes

On 2/12/2022 12:24 AM, Johannes Berg wrote:
> On Fri, 2022-02-11 at 23:52 -0800, Abhinav Kumar wrote:
>>
>> The thread is writing the data to a file in local storage. From our
>> profiling, the read is the one taking the time not the write.
>>
> 
> That seems kind of hard to believe, let's say it's a 4/3 split (4
> minutes reading, 3 minutes writing, to make read > write as you say),
> and 3MiB size, that'd mean you get 12.8KiB/sec? That seems implausibly
> low, unless you're reading with really tiny buffers?
> 
> Can you strace this somehow? (with timestamp info)
> 

Yes, like I have already mentioned in earlier comments, we continue to 
check whats taking that long.

Once we find something from our analysis and also have the trace, will 
update the thread.

>> Just doubling what we have currently. I am not sure how the current 5
>> mins timeout came from.
>>
> 
> To be honest it came out of thin air, and wasn't really meant as a limit
> on how fast you can read (feels like even if it's tens of MiB you should
> read it in milliseconds into userspace), but more of a maximum time that
> we're willing to waste kernel memory if nobody is around to read the
> data.
> 
> I thought it'd be better if we could somehow pin it while the userspace
> is reading it, but OTOH maybe that's actually bad, since that means
> userspace (though suitably privileged) could pin this kernel memory
> indefinitely.
> 
> johannes
