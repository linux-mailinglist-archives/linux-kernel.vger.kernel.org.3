Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D9D5379D8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiE3L1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbiE3L1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:27:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C094C7B6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:27:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id l13so16185341lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=ZH9yvId2NMAw4oN1iqMKqU61/DZ/rIDZexlE6dKv8SU=;
        b=qSiaNr2ftUqSRvmOy75IJeNCKAVgq/jO6yIuIwj9lTeotjFVJ4+oMFaIk5uft9Qvbs
         l+4EitDawXs9/hDAY1ZW4DMfHukqi6UArXkOO1Fsh++NpRhYgntK5BVNeajvyod0xNbd
         /yEKhndXFUITINHf3AsuCHklX308rL2W0TxU0lyGgS31a7Um1/qC8RkNmyIWqmdjEZqv
         sBD3tvK7pX9DrDUQh/vJKdquM5bFHwtxZMMOdowmUVGdozFLqM96xAnlkIXWMx6XY71P
         q0W2yFeBw4MsVyY5vKggC//seES0ntiWnGoRO7EkwhlnsldeBMzNk5fW75QX3HKgwNYo
         7OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=ZH9yvId2NMAw4oN1iqMKqU61/DZ/rIDZexlE6dKv8SU=;
        b=QpqNlYHmJP9+AUptGqkMk9Yr2tbs1Lu5Hbzn7GKewDKIGq5xU9FZIoCaMlhn5RZw8h
         ihTushcYMp9+T/hUAZ2Wu73FJjMNoQSFsL0kWjc2CEVX0C3hsM42/k/NAQvFFbSXjKAt
         anc3NKAR7e46i2FAe4GdlqanRux3ipYkwdEZeskUhqS0eH0nnW1pzzHL3zWIS+bttACk
         EYGv6nMZfG3lV8AhJQEN6V3blk3mFsKNQTzVDru2k35lx2Ey13Cp4PLGzOT/f2yJ7vdu
         sBFMQ7mN67mopcdRNu0Yc5VVc2c7fq+Qi7RmxZYq+nFlJavG04OECrMD2mBx4yUdpEt1
         Q81g==
X-Gm-Message-State: AOAM533W/mlB6BkWNLxGElAmzSugTSYWy1hZhTRRz0/yVzh1jcUmxpEl
        K95dBsm1YebjX0KuvBWlYY3IJg==
X-Google-Smtp-Source: ABdhPJxWZqPdDmaExmQ+szJPGiMjUbrO/s6wpfxiy7JGg6o16TpJ95IhHVKm74g0zXeSMO1rmg/5jg==
X-Received: by 2002:a05:6512:22cb:b0:478:d66d:f750 with SMTP id g11-20020a05651222cb00b00478d66df750mr5768811lfu.291.1653910028823;
        Mon, 30 May 2022 04:27:08 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id a2-20020a19e302000000b0047255d211bfsm2253577lfh.238.2022.05.30.04.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:27:08 -0700 (PDT)
Message-ID: <a1fcdab2-a208-0fad-3f4e-233317ab828f@openvz.org>
Date:   Mon, 30 May 2022 14:27:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v3 9/9] memcg: enable accounting for perpu allocation of
 struct rt_rq
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <06505918-3b8a-0ad5-5951-89ecb510138e@openvz.org>
 <cover.1653899364.git.vvs@openvz.org>
Content-Language: en-US
In-Reply-To: <cover.1653899364.git.vvs@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If enabled in config, alloc_rt_sched_group() is called for each new
cpu cgroup and allocates a huge (~1700 bytes) percpu struct rt_rq.
This significantly exceeds the size of the percpu allocation in the
common part of cgroup creation.

Memory allocated during new cpu cgroup creation
(with enabled RT_GROUP_SCHED):
common part:    ~11Kb   +   318 bytes percpu
cpu cgroup:     ~2.5Kb  + ~2800 bytes percpu

Accounting for this memory helps to avoid misuse inside memcg-limited
containers.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8c9ed9664840..44a8fc096e33 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -256,7 +256,7 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 
 	for_each_possible_cpu(i) {
 		rt_rq = kzalloc_node(sizeof(struct rt_rq),
-				     GFP_KERNEL, cpu_to_node(i));
+				     GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!rt_rq)
 			goto err;
 
-- 
2.36.1

