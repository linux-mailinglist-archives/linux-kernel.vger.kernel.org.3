Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EA456FFE4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiGKLOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiGKLNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:13:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A1721E1D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:28:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 5so4050669plk.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=z1md6F7/3AZxekQ1lEvwzSkQ1K5wYgKixBGsvUPHp7I=;
        b=JIJ3XTnM68C0Y4Afd4noJBz2RXyhX8APgKIgZpFvZq5dKGHy7kI5TEIce0mmiqZ7wL
         9NXIiMXXcljoGTJu1QCEAqnYFbodge9Vw00QeIyfJv0ZGzaH1udAqtDFqmadh67StWrr
         UpIpq7nk8ZNSFP8rjowN3/+t8B6MjUtqvCvXrAsPsqKBwkngKKSG6nfMEJRi8FTV9Ayj
         UBcJaGUHHlxcTEefo6kXrGQlLx3UPqjFDxN4qxqloSs2kSVBpXXFMnbzGe3VnRqEmqSX
         2Z7Jnon7oLKmLMIHjmltAF48io6r0zulyUpHliBr9QBbcLjeotyOlYnDOV/FmFeCfDqE
         xuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z1md6F7/3AZxekQ1lEvwzSkQ1K5wYgKixBGsvUPHp7I=;
        b=MWctfShBjOBs0kr4JISMNb+01KGoLCO4FBRJA+dhHVpkRaG3q4wRsUhhgkXV7HuWPl
         jwKiu16UBLkd/aYTD5t/smvTFByAJxNmmRyVp7GEj+T6y7VUrk3Yssbz+/k4G82bDPBE
         5nL7keULTn9rSq5DfHQy3Z3iqP7lwgT+ctksMG1Jf8uKjwIfWRJExGBCgMtGAK0nlsdt
         gnYScWTbWkern+2iYNPcYHpOA7f91URhZJtrngFzyE2xNkkHRiTCA560DMhRGHLPR1jw
         qwQ/393GbY5whAWR+Ga5S3uZwPtvxVBoBdAVsEHnKqYl5gMYnELyek3IkCeqXmH/pwzT
         u04g==
X-Gm-Message-State: AJIora8OFBz8FuoqT3LlXPKaYoCJZ+IdSJCaiKCFq1tUjsSSuNm1Z2T+
        grVCVMMdbgcUnRLDNSSpskOY2A==
X-Google-Smtp-Source: AGRyM1sEAMwmFyOyStoAuw+D7NFPL4mHlfOyBs+gqABulq7Hn4Anot/yMvedG+G48L2gP94WqYLhKA==
X-Received: by 2002:a17:90a:8413:b0:1ea:ebf4:7079 with SMTP id j19-20020a17090a841300b001eaebf47079mr17496893pjn.48.1657535299897;
        Mon, 11 Jul 2022 03:28:19 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id 6-20020a631446000000b00415fcde23a4sm1799850pgu.27.2022.07.11.03.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:28:19 -0700 (PDT)
Message-ID: <e5eed9c9-afd4-e88c-dbee-7fef2e76043a@bytedance.com>
Date:   Mon, 11 Jul 2022 18:28:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [External] Re: [PATCH] sched/topology: Optimized copy default
 topology in sched_init_numa()
To:     Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220627105349.80715-1-jiahao.os@bytedance.com>
 <xhsmh35fhgcww.mognet@vschneid.remote.csb>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <xhsmh35fhgcww.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/4 Valentin Schneider wrote:
> 
> It's not a very hot path but I guess this lets you shave off a bit of boot
> time... While you're at it, you could add an early
Thanks for your time and suggestion.
> 
>    if (nr_node_ids == 1)
>            return;
> 

This will cause the values of sched_domains_numa_levels and 
sched_max_numa_distance to be different from before, and 
sched_domains_numa_levels may cause the return value of 
sched_numa_find_closest() to be different.
I'm not sure if it will cause problems.

> since !NUMA systems still go through sched_init_numa() if they have a
> kernel with CONFIG_NUMA (which should be most of them nowdays) and IIRC
> they end up with an unused NODE topology level.
> 

I'm confused why most !NUMA systems enable CONFIG_NUMA in the kernel?
Maybe for scalability?


> Regardless:
> 
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> 

How about this?

The size of struct sched_domain_topology_level is 64 bytes.
For NUMA platforms, almost all are multi-core (enable CONFIG_SCHED_MC),
That is to say, the default_topology array has at least 128 bytes that
need to be copied in sched_init_numa(). For most x86 platforms,
CONFIG_SCHED_SMT will be enabled, so more copies will be required.

And memcpy() will be optimized under different architectures.
Fortunately, for platforms with CONFIG_NUMA enabled,
these optimizations are likely to be used.
So, let's use memcpy() to copy default topology in sched_init_numa().

Tests are done in an Intel Xeon(R) Platinum 8260 CPU@2.40GHz machine
with 2 NUMA nodes each of which has 24 cores with SMT2 enabled, so 96
CPUs in total.

Use RDTSC to count time-consuming, and based on 5.19-rc4.

Enable CONFIG_SCHED_SMT && CONFIG_SCHED_CLUSTER && CONFIG_SCHED_MC,
So the default_topology array has 256 bytes that need to be copied
in sched_init_numa().
                      5.19-rc4   5.19-rc4 with patch
average tsc ticks    516.57      85.33   （-83.48%*）

Enable CONFIG_SCHED_MC, So the default_topology array has
128 bytes that need to be copied in sched_init_numa().
                      5.19-rc4   5.19-rc4 with patch
average tsc ticks    65.71       55.00   （-16.30%*）

since !NUMA systems still go through sched_init_numa() if they have a
kernel with CONFIG_NUMA (which should be most of them nowdays) and we
can skip copying and memory allocation of useless default topology.

Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
  kernel/sched/topology.c | 7 +++++--
  1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05b6c2ad90b9..c439e58f22b9 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1907,6 +1907,9 @@ void sched_init_numa(int offline_node)
  	}
  	rcu_assign_pointer(sched_domains_numa_masks, masks);

+	if (nr_node_ids == 1)
+		goto skip;
+
  	/* Compute default topology size */
  	for (i = 0; sched_domain_topology[i].mask; i++);

@@ -1918,8 +1921,7 @@ void sched_init_numa(int offline_node)
  	/*
  	 * Copy the default topology bits..
  	 */
-	for (i = 0; sched_domain_topology[i].mask; i++)
-		tl[i] = sched_domain_topology[i];
+	memcpy(tl, sched_domain_topology, sizeof(struct 
sched_domain_topology_level) * i);

  	/*
  	 * Add the NUMA identity distance, aka single NODE.
@@ -1946,6 +1948,7 @@ void sched_init_numa(int offline_node)
  	sched_domain_topology_saved = sched_domain_topology;
  	sched_domain_topology = tl;

+skip:
  	sched_domains_numa_levels = nr_levels;
  	WRITE_ONCE(sched_max_numa_distance, 
sched_domains_numa_distance[nr_levels - 1]);


thanks,
Hao
