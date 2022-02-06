Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA1D4AB041
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 16:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbiBFPeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 10:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbiBFPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 10:34:11 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A41C043186;
        Sun,  6 Feb 2022 07:34:11 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id u130so9559674pfc.2;
        Sun, 06 Feb 2022 07:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=14MC9C8IQIKOd8fz9Jlu9bO+FiVmkryy7aHyccyp2Q8=;
        b=faxEA/89KE1KYI/K/OGLxzVmVPbiJPb9wiXjL6ULjkX7OsCZzgz+gQxsz0RLDWZLXB
         lcI8LY+x7wd2wTXX5K95TBnh/y85wyOGaLlhJ+hJhFBrlFytdlWNDKtC1H5DwoSuYFAc
         jb3bHjKzwISbl+Mgs1DVrasl8rSeF8rXvp41qTiuIVIYGgV7YxoOmbRE37ge8Bu9i2ao
         aS/PBYeJQ5sm5MrR1jtnzo3HF/7/yb2dYhkWq2iz1TCcqF8a+aGKcU77UbFH1Ni48P+h
         Qxmua+JkId3vKA4GKTOVW3vLRthKwgCTht81I+N2oVOH7ZQCTa4RH315ibN4Y8C5viqC
         VbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=14MC9C8IQIKOd8fz9Jlu9bO+FiVmkryy7aHyccyp2Q8=;
        b=dkeVzMYUxQZHgWfijrVLQuT8ItuhSokZtyI7hmHhQqxK4L3Zp11mdG11HSMtrPMPF0
         /5+Z9BP7ZZ8oWxuRaSILfqxLBKDToTiiJSiKsG+h8/8hMUYzugBG9fnVEZvMLTomACv6
         2yGBlxqTWPtiV7laMX5c7bAVJzjPSLKPwH5hrQf05Ju604ICLq8ePSWxui7bIJhYt659
         FY1vwpx3oqk+ZMVi9SzcJHH5MeqWmPqovr4dkYMgFGoY5DPTcq1ueSm5hT/DSrlDmuPc
         dZLqOftsd33jvIXyAWZrkCosjbyCvu8nhoUTKbeRp2I0Z4IgYTOkhA6mcjgQF4aAali2
         9d1w==
X-Gm-Message-State: AOAM533XrmsPhLhNd59phYrDYzmEblstun2UrBLYpKxde10amcss8Y1A
        MOG6rM5EJVgqCU7iL2+V3Ps=
X-Google-Smtp-Source: ABdhPJytxa4f/6n6AlxJZBZYfZdIyBQa1ZxD3cJM7PiKuShuVQL7/0cCEbfy1KK6sP57AbqFAsO91A==
X-Received: by 2002:a63:26c1:: with SMTP id m184mr6358920pgm.296.1644161650564;
        Sun, 06 Feb 2022 07:34:10 -0800 (PST)
Received: from [192.168.1.12] ([120.244.202.146])
        by smtp.gmail.com with ESMTPSA id 12sm6195117pgb.71.2022.02.06.07.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 07:34:09 -0800 (PST)
Message-ID: <a2c91d4c-c1f3-4723-e1a4-02ac1742f96c@gmail.com>
Date:   Sun, 6 Feb 2022 23:34:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [BUG] bus: mhi: possible deadlock in mhi_pm_disable_transition()
 and mhi_async_power_up()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     mani@kernel.org, hemantk@codeaurora.org, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d3a94b53-0d77-dafe-ce45-f9ab23278616@gmail.com>
 <20220201171540.2udq3x6r2swctzau@maple.lan>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
In-Reply-To: <20220201171540.2udq3x6r2swctzau@maple.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/2 1:15, Daniel Thompson wrote:
> On Sat, Jan 29, 2022 at 10:56:30AM +0800, Jia-Ju Bai wrote:
>> Hello,
>>
>> My static analysis tool reports a possible deadlock in the mhi driver in
>> Linux 5.10:
>>
>> mhi_async_power_up()
>>    mutex_lock(&mhi_cntrl->pm_mutex); --> Line 933 (Lock A)
>>    wait_event_timeout(mhi_cntrl->state_event, ...) --> Line 985 (Wait X)
>>    mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 1040 (Unlock A)
>>
>> mhi_pm_disable_transition()
>>    mutex_lock(&mhi_cntrl->pm_mutex); --> Line 463 (Lock A)
>>    wake_up_all(&mhi_cntrl->state_event); --> Line 474 (Wake X)
>>    mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 524 (Unlock A)
>>    wake_up_all(&mhi_cntrl->state_event); --> Line 526 (Wake X)
>>
>> When mhi_async_power_up() is executed, "Wait X" is performed by holding
>> "Lock A". If mhi_pm_disable_transition() is concurrently executed at this
>> time, "Wake X" cannot be performed to wake up "Wait X" in
>> mhi_async_power_up(), because "Lock A" is already hold by
>> mhi_async_power_up(), causing a possible deadlock.
>> I find that "Wait X" is performed with a timeout, to relieve the possible
>> deadlock; but I think this timeout can cause inefficient execution.
>>
>> I am not quite sure whether this possible problem is real and how to fix it
>> if it is real.
>> Any feedback would be appreciated, thanks :)
> Interesting find but I think it would be better to run your tool
> against more recent kernels to confirm any problem reports. In this
> case the code you mention looks like it was removed in v5.17-rc1
> (and should eventually make its way to the stable kernels too).

Hi Daniel,

Thanks for your reply :)
I check Linux v5.17-rc1 code, and find that this possible deadlock does 
not exist, due to the changes in commit d651ce8e917f.

However, my tool also reports several other possible deadlocks, which 
are caused by waiting with holding mhi_cntrl->pm_mutex.
There are two examples in Linux v5.17-rc1:

#BUG 1
mhi_pm_sys_error_transition()
   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 572 (Lock A)
   wait_event_timeout(mhi_cntrl->state_event, ...); --> Line 600 (Wait X)
   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 630 (Unlock A)

mhi_pm_disable_transition()
   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 464 (Lock A)
   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 496 (Unlock A)
   wake_up_all(&mhi_cntrl->state_event); --> Line 498 (Wake X)

#BUG 2
mhi_pm_sys_error_transition()
   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 572 (Lock A)
   wait_event_timeout(mhi_cntrl->state_event, ...); --> Line 600 (Wait X)
   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 630 (Unlock A)

mhi_power_down()
   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 1139 (Lock A)
   wake_up_all(&mhi_cntrl->state_event); --> Line 1165 (Wait X)
   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 1168 (Unlock A)

I am not quite sure whether these possible problems are real.
Any feedback would be appreciated, thanks :)


Best wishes,
Jia-Ju Bai

