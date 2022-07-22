Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BC257DAF7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiGVHO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiGVHOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:14:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFC193C1D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:14:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x1so2122671plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Gts6QjrIoCSOBmG3jGbKb3eul2uSF3MTCws6wh5quBU=;
        b=mJWWyyMIyJtter05K23sBP49ExJhHuakrSmup0Lyp7fFs/JwZdkZTej6SwtGfLSlbw
         7IBUSpZuil8/hRSDzqTvcBb0D7j1YdwogYL82PQWEGpIoIzqQUhR0Po/is6TFlr2Cqu2
         5NiWDIbUEDBkLP83ixN1UYyRaHSz2ZFs9i8m3uYbL0KLomP2Zo1YrctY4jYMWm8S4toY
         uTZeuognAbH/dQYexucHsav7T2qcO5sS1ZwIiBvM6BxpN6+CobP0ez5a35e3rQ9KAElV
         oULecPO8ft5qj+rajgCyb4B4pHFCQ0PV7tCvcl9tMGOCnEy3/1R59RIsGvF3hRIVYj2B
         fQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gts6QjrIoCSOBmG3jGbKb3eul2uSF3MTCws6wh5quBU=;
        b=qrV9EUgX8f3NpobMjKv44aVAQZ/9EScHqb5UhpYKhTFayibzNt+9iDEiOJyZs48XR2
         gtAuxSntL3qCuhEezD2abgzYiPCtk310CkwCjuCyCN0kmqjoW2msPb8O9+VRxcPrcTWr
         GAkhMr2acV2w9h3RdE9GTfESxwgRgpQOQt7NVuO9wvnqkuTq+96ZyFJJFrxUJVSNc+MB
         7e2ekgqgpV3tRtVoQxaLvadJpibGonzfgk8cv88qwQOoTPWclWgh0HT7oJSxXjPpM2/4
         88czMuCo/hLsf18DSIWPMxaR17u/zEsWlxtc4UkzzzhSn+ADmpCplyvv/ic8ROZy8bsu
         GgVg==
X-Gm-Message-State: AJIora9RoVVj+cI2VkLwcNDly6gPM4ox4sKH/jNQHPT4QU5JK5URtZ74
        ZSj94zZ62yx+qXQsKcLsNQgTVw==
X-Google-Smtp-Source: AGRyM1sJABApEVKk+Q/4KqF+AE/7rMwDeOGGmltspwiEckie8nFl5z667v74WZyz3cKRmw1kjBDbuw==
X-Received: by 2002:a17:902:ef48:b0:16a:1d4b:22ca with SMTP id e8-20020a170902ef4800b0016a1d4b22camr2071711plx.6.1658474049296;
        Fri, 22 Jul 2022 00:14:09 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e80800b0016d303f266dsm2930934plg.276.2022.07.22.00.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 00:14:08 -0700 (PDT)
Message-ID: <5e5d41e2-5f89-8c52-11e5-0c55c5595a88@bytedance.com>
Date:   Fri, 22 Jul 2022 15:14:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 9/9] sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, hannes@cmpxchg.org,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-10-zhouchengming@bytedance.com>
 <65d9f79b-be9b-e21e-0624-5c9f2cc0c0b2@bytedance.com>
 <ce22fa9d-aad0-fc23-d304-14fdd27130f4@bytedance.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ce22fa9d-aad0-fc23-d304-14fdd27130f4@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/22 2:13 PM, Chengming Zhou Wrote:
> On 2022/7/22 11:30, Abel Wu wrote:
>> Hi Chengming,
>>
>> On 7/21/22 12:04 PM, Chengming Zhou Wrote:
>>> Now PSI already tracked workload pressure stall information for
>>> CPU, memory and IO. Apart from these, IRQ/SOFTIRQ could have
>>> obvious impact on some workload productivity, such as web service
>>> workload.
>>>
>>> When CONFIG_IRQ_TIME_ACCOUNTING, we can get IRQ/SOFTIRQ delta time
>>> from update_rq_clock_task(), in which we can record that delta
>>> to CPU curr task's cgroups as PSI_IRQ_FULL status.
>>
>> The {soft,}irq affection should be equal to all the runnable tasks
>> on that cpu, not only rq->curr. Further I think irqstall is per-cpu
>> rather than per-cgroup.
> 
> Although IRQ/SOFTIRQ is per-cpu, it's the rq->curr who own the CPU at the time
> and pay for it, meanwhile other groups would be thought as PSI_CPU_FULL.

I don't think rq->curr pays for it if you mean consuming quota here.
And it doesn't seem appropriate to let other groups treat it as cpu
stall because the rq->curr is also the victim rather than the one
causes stall (so it's different from rq->curr causing memstall and
observed as cpustall by others).

> 
> So I think it's reasonable to account this IRQ/SOFTIRQ delta to rq->curr's groups
> as PSI_IRQ_FULL pressure stall. And per-cpu IRQ stall can also get from psi_system.
> 

