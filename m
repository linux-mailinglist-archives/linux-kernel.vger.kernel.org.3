Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215C5597BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242654AbiHRCrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbiHRCrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:47:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9CFA344A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:47:03 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s206so251467pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=alPEvxydueQmrF5sLjOKQbzP+nxZ4cu5QX1AAdr+1ko=;
        b=JufshKMurP0UG6Ji0McuN2G/3dA5KU2MBHye8wYeI2VoGuB3ZzvEIm65YT0FJ8ysle
         Udtd/UhzaB9K3eSAijhzzKLyvk2kJvknivAZ5SYuHFxCzuPQxBwqp/9mZS6Ie04Sgg9l
         moEVzhuf2cRb9bfcBzk5U6E2r2/HDq5deoVIsOh6LnD5qL4x+HttsydEwpcW07LebqFc
         zb9n6Ly5j+Amf8FVss+u2ntOJNPwOMi9IzBrziBeNQ6RIL1bWH7ZkrM3Ag9g7IZvsNZi
         a9gY+Vvh7DdM9DGxpmhKbpe5m7YSNqfchXTDBtxyiwbQUmpHpBNuykHYbGwtmicBj5Oh
         bXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=alPEvxydueQmrF5sLjOKQbzP+nxZ4cu5QX1AAdr+1ko=;
        b=nMfRmNMMp00Q6eG0AxfixiA2xLhcIaZyQO4X0g0jWFG/PsfeOJWQkAuYHF4DlwHX9b
         2n9rt9IQ0M8TJTMsDGIrskax2XjKrPFO+NICPvOvrOZmENZhMwzum1q9qmNjIP3whaXh
         JLWuV0ZzA4fCCr1858MCw8WT713XjVV7KatXz7+XJ2XyOrVqkZMzmWAmXAJCnoTKQKOO
         mISxKnmxKIz3lpltDE3fHrYZ6GivcyONJ6nDO9fT1lQWDGYZ25UmT4S0CXY+FA+QBAGL
         wFy9Dh0oO4rV6U4rJrAvdC0AgtWhNJvE+1DjjM8N23jJ8C/BGgFLbKG0vA+4G+PT8ch+
         sCzw==
X-Gm-Message-State: ACgBeo2XNyOOUHQEF9GMkTV23kuwHCadoCuo7IzrWDBzYjVt75QQvIKS
        u2tAdUyIH0UbWpm9PmNjLwWeqw==
X-Google-Smtp-Source: AA6agR7wiN+FMUWQLPNCdCXrA3IGvEbcfkiEj9oeIrmVO37x32QO3/4ssKk/v/A0QwfSQBr6sqyzBQ==
X-Received: by 2002:a63:bd49:0:b0:41b:8a07:a6ed with SMTP id d9-20020a63bd49000000b0041b8a07a6edmr909312pgp.124.1660790822732;
        Wed, 17 Aug 2022 19:47:02 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b00172b0272f1asm154595plh.51.2022.08.17.19.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 19:47:02 -0700 (PDT)
Message-ID: <9a63b371-9940-caee-7fa1-2c230bec0bd1@bytedance.com>
Date:   Thu, 18 Aug 2022 10:46:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2] sched/fair: Introduce priority load balance to reduce
 interference from IDLE tasks
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        "zhangsong (J)" <zhangsong34@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20220810015636.3865248-1-zhangsong34@huawei.com>
 <b62804cb-2b60-a534-5096-56785a1940bd@bytedance.com>
 <e2c9eccc-dd86-16e9-c43e-8415f99f413e@huawei.com>
 <13a7a412-5e2e-6ef8-acd6-a761aad66c3a@bytedance.com>
 <6ae319c0-e6ed-4aad-64b8-d3f6cbea688d@huawei.com>
 <CAKfTPtAcEstoqC+9-y9ubaXDSGbfLdMhFboMPn433QNPD114dQ@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CAKfTPtAcEstoqC+9-y9ubaXDSGbfLdMhFboMPn433QNPD114dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 8:58 PM, Vincent Guittot Wrote:
> On Tue, 16 Aug 2022 at 04:53, zhangsong (J) <zhangsong34@huawei.com> wrote:
>>
>> For co-location with NORMAL and IDLE tasks, when CFS trigger load balance,
>> it is reasonable to prefer migrating NORMAL(Latency Sensitive) tasks from
>> the busy src CPU to dst CPU, and migrating IDLE tasks lastly.
>>
>>
>> Considering the large weight difference between normal and idle tasks,
>> does the re-ordering really change things? It would be helpful if you
>> can offer more detailed info.
>>
>> Please consider the situation that CPU A has several normal tasks and hundreds of idle tasks
>> while CPU B is idle, and CPU B needs to pull some tasks from CPU A, but the cfs_tasks in CPU A
>> are not in order of priority, and the max number of pulling tasks depends on env->loop_max,
>> which value is sysctl_sched_nr_migrate, i.e. 32.
>>
>>
>> The case you elaborated above is really rare, the only possibility I
>> can imagine is that all these tasks are affined to one single cpu and
>> suddenly remove the affinity constrain. Otherwise, the load balancing
>> including wakeup cpu selection logic will make things right.
>>
>>
>> Yes, this is usually a corner case, but suppose that some non-idle tasks bounds to CPU 1-2
>>
>> and idle tasks bounds to CPU 0-1, so CPU 1 may has many idle tasks and some non-idle
>>
>> tasks while idle tasks on CPU 1 can not be pulled to CPU 2, when trigger load balance if
>>
>> CPU 2 should pull some tasks from CPU 1, the bad result is idle tasks of CPU 1 cannot be
>>
>> migrated and non-idle tasks also cannot be migrated in case of env->loop_max constraint.
> 
> env->loop_max adds a break but load_balance will continue with next
> tasks so it also tries to pull your non idle task at the end after
> several breaks.

Loop will be terminated without LBF_NEED_BREAK if exceeds loop_max :)

> 
>>
>> This will cause non-idle  tasks cannot achieve  more CPU utilization.
> 
> Your problem is not linked to IDLE vs NORMAL tasks but to the large
> number of pinned tasks that can't migrate on CPU2. You can end with
> the same behavior without using IDLE tasks but only NORMAL tasks.

I feel the same thing.

Best,
Abel
