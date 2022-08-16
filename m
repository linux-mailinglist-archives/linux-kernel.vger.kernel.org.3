Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1C7595CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiHPNOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiHPNOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:14:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC62652478
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:14:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u22so908227plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+6bpur5f95gLUeGx8eRnc/guXK1xDx+MJbTlKkiIbQY=;
        b=cTn1lxNE52N5+LGU8ewWkZ6JvE6RclbO5o+7J6q+/cahY044yQG49mNmY37lHVo7HR
         UcgHOUpJiHqx6vJc7QDXrG7ilNhISGdwwCF1dGW05+IF1VYj1ZVSWKNoBCOhbgMuklFu
         USbOckQ9k9j2reXMlKBS+obCQrbKxOFExMT9P4bFJOpLmyYQA2NQ2Vc3xPMAirgUV6rz
         uquXS3sBwz+s/fB73yGOh/ZL3CjzPlAw9qPqRlAQ+lIbhdZaqdYqUw9yvKFzftHodCSX
         gCX8a4gom7eRp2/VFbGP5dpdY+Ho/fkC/Ee8OdGs24rtVk+7K/QQUFT/fZtdYxP97Rff
         9suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+6bpur5f95gLUeGx8eRnc/guXK1xDx+MJbTlKkiIbQY=;
        b=7+GI9qUZ6noxgLgE4OZwN5zIMRRyy9LDLLxe9RueX8Yt5Isf0VJw7Dqvquy0h/hcGQ
         gmAYVWBnw98KljctQFzg0zyTMQ416/Uo75pqyjLlCGLMs64xjGxt0/A1EeLrKUETde5S
         NUWLWhct6cyYEH0Wgf6RV79jEMO/y75wRwMN5e53NU38tU1H8PzLbNzGTsEVfXSjb6AN
         jUqu7jvSsiArgqPfHT9k+KVbLDR1jZvxZiDyfyIURC4TSKOosSW0dOx5B8gog8v1LWN3
         VE/R3snaRUBSXs2DpFkbVQ7NSXxdfODM+PKPY5TPtX2HamN7/VR8rcriiG+PZ6s8I7Yr
         oIJA==
X-Gm-Message-State: ACgBeo0KWOa3qOLAdXYtwKS06DPRX9bTjwvQfuSduJPFS9qGArJFIY/Z
        fGnfWaBbBBRWzJ4GFA/26CcPTA==
X-Google-Smtp-Source: AA6agR49G5oQ78QysUPRhTfdagUIMGkbxqjjHQs/QsklRHHNYdxcJUPFSqtJKOS0Dmj9rOlfBlGLEw==
X-Received: by 2002:a17:902:7242:b0:171:398d:9e66 with SMTP id c2-20020a170902724200b00171398d9e66mr22477277pll.19.1660655688362;
        Tue, 16 Aug 2022 06:14:48 -0700 (PDT)
Received: from [10.4.196.37] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id s65-20020a625e44000000b0052c87380aebsm8428353pfb.1.2022.08.16.06.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 06:14:47 -0700 (PDT)
Message-ID: <8a38c9aa-8404-e50a-58b1-7a87bf887d06@bytedance.com>
Date:   Tue, 16 Aug 2022 21:14:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v4 7/9] sched/fair: allow changing cgroup of new forked
 task
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220808125745.22566-1-zhouchengming@bytedance.com>
 <20220808125745.22566-8-zhouchengming@bytedance.com>
 <Yvq2ZiQL/iHNAaLh@slm.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Yvq2ZiQL/iHNAaLh@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/16 05:11, Tejun Heo wrote:
> On Mon, Aug 08, 2022 at 08:57:43PM +0800, Chengming Zhou wrote:
>> commit 7dc603c9028e ("sched/fair: Fix PELT integrity for new tasks")
>> introduce a TASK_NEW state and an unnessary limitation that would fail
>> when changing cgroup of new forked task.
>>
>> Because at that time, we can't handle task_change_group_fair() for new
>> forked fair task which hasn't been woken up by wake_up_new_task(),
>> which will cause detach on an unattached task sched_avg problem.
>>
>> This patch delete this unnessary limitation by adding check before do
>> detach or attach in task_change_group_fair().
>>
>> So cpu_cgrp_subsys.can_attach() has nothing to do for fair tasks,
>> only define it in #ifdef CONFIG_RT_GROUP_SCHED.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> I don't know cfs enough to review this but it'd be really great to remove
> this restriction.

Thanks for your reply!

Friendly ping :-)
