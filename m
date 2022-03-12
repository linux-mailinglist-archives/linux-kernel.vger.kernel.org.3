Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304F04D6FE3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiCLP4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiCLP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:56:00 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE9C4C7B5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 07:54:43 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id n18so7438618plg.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 07:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t5hRVqsCZQix2UY1u0pXX2LoR2L7u3LZkbnGzh3aN1w=;
        b=x0vGbkjA4ZMve+h8aOuwoEFFDAiZeBsbsA3hLtcw48KN9IQYfrMOTSjVdXlMrQnKBS
         8Pwra4IFKSvVJ7Zt9WOkyAxXekH5VxgwAbUiGPnQts8mijCZPi32wSr4q+z4bd/D8bA3
         +vkG0ULgFnefCGx4rC/cP48IvQxQRNbEkqmrBeos2QSV9kv1DjRNrDWfiy+wFQajqd21
         ZCK7Fxtj8+vRYo1YPEUJIDkk/RxafJVAtcSR1YvG7fjOHDwBMYLzdjLJJ1wqoTGoEet7
         eA/6JG+NFqYfX+sFUwTBd9AxJlkC6fcFE/qJnPfOxThHvA/g0LZLKsJ8zLLl5LnlXFZb
         LEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t5hRVqsCZQix2UY1u0pXX2LoR2L7u3LZkbnGzh3aN1w=;
        b=hOjn8DkKGuUwc00lBOFJqi5TZS1ryRuSVGHU9/vG4sMqTvkkEwHw0/QuAJr7EEMFAn
         oNw6uXpf/VTr6WDcQFWtpSAg1RoiyR5R2yqbTWVl/xZP6MjuoE4l9UnaIjKccGWhvY4C
         Euu/oaybGNck+C9Hzzt6HkB/lAztHgPEcAD37nhy0p5nc52H5A42lG9161WfUqMb10Ru
         A0IDNm3FlkZrLl4J1wMZjUSld28Kk3bzDnrNUmQGL/ycwRbA2CK+w99111ZLT5205xTo
         lo3y0isuju+MxKwT6lnm5n9cjoWkAp/bbgUmVKPEqXhoz+GGiilHxXarYQStf0Id4Di1
         eg4w==
X-Gm-Message-State: AOAM532stY7eVYIdY8k1PZvIev6CZTUj2jWz4/3ghM2Ts8M9JCIYYFF6
        aDrkOHm5mUTbJMrpM72BlsCQ0w==
X-Google-Smtp-Source: ABdhPJzbBuMDHYekO71zH/12ZUMBSiExAeT2pcaVAIBCekydBo2b5sk1jhS5LRJk83QpoPcwYb1d7w==
X-Received: by 2002:a17:902:f605:b0:14d:bd53:e2cd with SMTP id n5-20020a170902f60500b0014dbd53e2cdmr15938322plg.164.1647100482533;
        Sat, 12 Mar 2022 07:54:42 -0800 (PST)
Received: from ?IPV6:2409:8a28:e63:f230:50dc:173d:c83a:7b2? ([2409:8a28:e63:f230:50dc:173d:c83a:7b2])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00170d00b004f757a795fesm14685911pfc.219.2022.03.12.07.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 07:54:42 -0800 (PST)
Message-ID: <bde81f0b-4b30-1b10-aa2c-bed969675c42@bytedance.com>
Date:   Sat, 12 Mar 2022 23:54:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [External] Re: [PATCH linux-next] cgroup: fix suspicious
 rcu_dereference_check() usage warning
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
References: <20220305034103.57123-1-zhouchengming@bytedance.com>
 <20220312121913.GA28057@worktop.programming.kicks-ass.net>
 <20220312133445.GA28086@worktop.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220312133445.GA28086@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/12 9:34 下午, Peter Zijlstra wrote:
> On Sat, Mar 12, 2022 at 01:19:13PM +0100, Peter Zijlstra wrote:
>> On Sat, Mar 05, 2022 at 11:41:03AM +0800, Chengming Zhou wrote:
>>> task_css_set_check() will use rcu_dereference_check() to check for
>>> rcu_read_lock_held() on the read-side, which is not true after commit
>>> dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock"). This
>>> commit drop explicit rcu_read_lock(), change to RCU-sched read-side
>>> critical section. So fix the RCU warning by adding check for
>>> rcu_read_lock_sched_held().
>>>
>>> Fixes: dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock")
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>> Reported-by: syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com
>>> Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Thanks, I'll go stick this in sched/core so it's in the same branch that
>> caused the problem.
> 
> FWIW I never saw this patch because it doesn't instantly look like a
> patch I should be interested in. It's classified as 'for-next' and I
> don't run -next, sfr does that. Then it's tagged as cgroup, which I also
> don't do.

Oh, sorry for this.. I should've add "cpuacct" in the subject. The
"linux-next" prefix was added because I thought any patch based on
the linux-next branch should add this prefix.

> 
> Nowhere does that look like a patch that wants to go in sched/core and
> fixes a cpuacct issue.
> 
> On top of that, I still don't agree with this, I really think
> rcu_dereference_check() itself should be changed.

Yes, I think so too. This patch is workaround to fix the warning to
follow the usage in RCU Documentation.

Maybe changes should be made in RCU code to make rcu_dereference_check()
more flexible as you expressed in the conversation with Paul.

Thanks.
