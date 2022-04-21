Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756CF50A08C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiDUNSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiDUNSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:18:46 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6191F61F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:15:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b15so4991690pfm.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=/mo6cEIGGM5UXozNkU5K0IDKas4ymPcSPC7vql1oO7o=;
        b=brmFBBl3Pm09JZM8jGd5FC2W5HvnKY5IAltAjG4sQaEA4jOKCnvYP2Igrw0370BHTr
         pFS8i2BhjH8gqPCNYrvMQDqDZdwNuVEsjRVCLp+xwabx7Aw3qyUWOwWSFnS3N89xxRvX
         l7FzM0qQFmGVKrhJTmLImGi4Oxx2nPFF0BZoY+UDt/9h8ldIH/vIw90IFsQ3HUqs3VbB
         VBEQrlRdjsyKxYQMwgF2cEDOW8ZJP5IKGpIpZp3vPmtgCY95sXl2CHNwrtTXDBrYYhZ/
         sD98y80F1kkoKXfATN2M+O92X9ykMyut/UsxHq9ldIDSeTjLOfxcPSxvusX3vGAccTwk
         pmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/mo6cEIGGM5UXozNkU5K0IDKas4ymPcSPC7vql1oO7o=;
        b=IdG04uRZb57WScZqSh4wmusMP6vDn4gnPiOBEHZdE7EAdyiYMNeNrqxQ4ujR+TImQF
         drnU84zd4yKI69vkGCPKWR7RX8LkXfmvDYEM0qfg1+SlGzoYj5UGfloLWQUktCf7NrzK
         M/aBg2+8po5vwLXo35psHlgTs00t5PLODQ0aUUOuPlkX/lGAJvAKrJl3hEFFKZxTyqQa
         y9j4r+J0usXVN5BeG/23U7rpHglLhFte0pPrTWU9erLBKcbTxqt/0EeTZiza1pEjDIge
         mXfnuHRkUzSlAdNuasOIILW7PA5+qU2hoqw0NrEhBGK+3MngtK5w35gkBtaiTHxe4eit
         PMcA==
X-Gm-Message-State: AOAM532gfivLLov+XQKnnMPHBjaHkVUfKe+yn0iKisoFCmiJLDuchAAc
        d1sUA7kuchqSNYF0fm423qg5Wg==
X-Google-Smtp-Source: ABdhPJzUi93dqhNvRleZow/9V1Z9u/c4KyWFPNwJg8r46k/Zf63VJDMxELIreYaGJh7U2xunTZklHA==
X-Received: by 2002:a05:6a00:140b:b0:4e1:2cbd:30ba with SMTP id l11-20020a056a00140b00b004e12cbd30bamr28839691pfu.46.1650546955179;
        Thu, 21 Apr 2022 06:15:55 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090ab29600b001d287fd3f79sm2670563pjr.46.2022.04.21.06.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 06:15:54 -0700 (PDT)
Message-ID: <5197dbe9-3b2f-16c5-ff41-2aa7698ffd0b@bytedance.com>
Date:   Thu, 21 Apr 2022 21:15:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [External] Re: [PATCH] sched/core: Avoid obvious double
 update_rq_clock warning
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220418090929.54005-1-jiahao.os@bytedance.com>
 <13b9fa7f-7ac9-5c1e-a0ff-6b57cb38f28c@arm.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <13b9fa7f-7ac9-5c1e-a0ff-6b57cb38f28c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/21 Dietmar Eggemann wrote:
> On 18/04/2022 11:09, Hao Jia wrote:
> 
> [...]
> 
>> -	/*
>> -	 * Update the later_rq clock here, because the clock is used
>> -	 * by the cpufreq_update_util() inside __add_running_bw().
>> -	 */
>> -	update_rq_clock(later_rq);
>> -	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
>> +	activate_task(later_rq, next_task, 0);
> 
> IMHO, this change should go in a separate deadline patch.
> 

Thanks again for your review.
I will do it in patch v2.
Thanks.

> The change to call update_rq_clock() before activate_task()
> (840d719604b09) is no longer needed since f4904815f97a removed the
> add_running_bw() before the activate_task().
> 
> [...]
