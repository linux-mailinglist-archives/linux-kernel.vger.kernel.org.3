Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340274C3E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbiBYGwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiBYGwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:52:20 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F7533EAC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:51:48 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d17so3980041pfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L9veUilJjU8BgaFzfFNZAp7aUZ0r2DY2hwo5tY1hj7U=;
        b=jxy6te3sNK33/QPRpNeXR6RoChyv3hj6l/jlhVKPMDcoUgPOgZBUtvnLKgnUqFRgzi
         tLlJmO9DeEIHG631qitRGG2Sdt8WWUdNTX1EGM74XBh5NhS5PqeO10qTXOfu3q7Zy/H5
         Ml4rha7BUAJs84qkZr8HAZaBNXiHHwt79xxzvN8WUhOgY/g252cXWSemlkLFfX4HCQ3n
         29PraZbua/1G/r7+s/yrmuYMKgDcNHEeULnaOPpO6957wpJz29bhNDY44Be2vdQAhaaD
         laGCn+DS3uNQN58Or3gTfgvn3bnkSoKku0bf3siU2mMExZdTQGWyVvII3T60maH4FmJ9
         jS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L9veUilJjU8BgaFzfFNZAp7aUZ0r2DY2hwo5tY1hj7U=;
        b=NFpajVyqYzriZNwmRsE3U4H0ush8xo4aNH249jpwn0g0U3QmF7jTTRDDGEmJOXyc4l
         jHMNVOfu/pqrycASsz25kYbFbr06u/zYaNVq3umtyZZRIOJg28i8eKUAZtkipgNxWiOn
         wvoogh/FjpaeiXbLgBcqagBU1INXPFGtSbyQ3VOv/LzJvWw29JYdhWa1Amk+npli7pTf
         LehZKsMSkKBlnltAwi97xnKEd5sKkBVr08nAj0wR8sJXpdnV0c5sIYW+Zk17940MXSBV
         7MJBaLuRn93Ui2Ycr7/xxKukJfe1rBys7WU91lDm97Z9eRhB9U00NCUUNzao6eBhdhWe
         9AAg==
X-Gm-Message-State: AOAM532GL9yO+tWWMWgUw4RrDvz3XTV7csOnpsg4xDlYsPbOpZeIJaQO
        8EsmiVf9pPf2y57i6/McW9nyug==
X-Google-Smtp-Source: ABdhPJyxnZEK8ubkW17E5lHI4ZuYwMnLpnCO8qPRF2YcCgHBpfbim0uYG2Uqv3F6TJWUHUvhN9utVQ==
X-Received: by 2002:a05:6a00:244d:b0:4e0:1f65:d5da with SMTP id d13-20020a056a00244d00b004e01f65d5damr6203403pfj.6.1645771907999;
        Thu, 24 Feb 2022 22:51:47 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id p128-20020a622986000000b004e1366dd88esm1589111pfp.160.2022.02.24.22.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 22:51:47 -0800 (PST)
Message-ID: <4a457db8-428f-52ac-a864-cd3d2fda705a@bytedance.com>
Date:   Fri, 25 Feb 2022 14:51:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/5] introduce sched-idle balancing
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
 <YheiT2pGNDggdFSu@hirez.programming.kicks-ass.net>
 <CAKfTPtB_GGb2eZqWfmKrY3-Z9spN9wzU4pXMGz38bAZu8ExCMQ@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CAKfTPtB_GGb2eZqWfmKrY3-Z9spN9wzU4pXMGz38bAZu8ExCMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 11:29 PM, Vincent Guittot Wrote:
> On Thu, 24 Feb 2022 at 16:20, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Thu, Feb 17, 2022 at 11:43:56PM +0800, Abel Wu wrote:
>>> Current load balancing is mainly based on cpu capacity
>>> and task util, which makes sense in the POV of overall
>>> throughput. While there still might be some improvement
>>> can be done by reducing number of overloaded cfs rqs if
>>> sched-idle or idle rq exists.
>>
>> I'm much confused, there is an explicit new-idle balancer and a periodic
>> idle balancer already there.
> 
> I agree, You failed to explain why newly_idle and periodic idle load
> balance are not enough and we need this new one

Hi Vincent, sorry for not giving a clearer explanation. Please check
my previous email replying to Peter, thanks.

Best Regards,
	Abel
