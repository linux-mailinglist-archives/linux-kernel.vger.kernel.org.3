Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037B6547F34
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiFMFgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiFMFgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:36:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A0712ABC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:35:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w20so7081867lfa.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=hqvRcJBRW/zXn9o8PLaPnPcK1byd11F8xwtbZSlj240=;
        b=58aW1GKW2Xnc6hX7c4ajeoo5cdVM2VXNCWYj3+RmWPIsMMcEya9nceDLXfxdDuL1RJ
         vFqjZjdUplMMnXO+GoNqLVSBeyv2codJ/Cdo/0P+m25U99sRmLSf87r3bRpz2KtogSHX
         nDg2iKGP1amPG4uJ/PV6KCiE/RHnOr64u2KfbnAupwelgVto6u2iX/YRnr6ea52wfDQH
         egQipz1wqYLmRlmNtCWxWVXO8L3KKQV9Wzlt3vZADHi8YHEB9nJ8HJIkn9dp8H0u3tl4
         qFMxNsnU970ET5KhuiG5uGtXVrTkrI5+kltSmMicveonR3WCCFzn2uyzFuOg4dK17cO6
         zlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=hqvRcJBRW/zXn9o8PLaPnPcK1byd11F8xwtbZSlj240=;
        b=QqU3PTFGCmhuOEeAE6RPUqOzHl1/XDo1KFqbPeJp6CD+k83yV/7/517L+2r3nmLaw+
         juryJNNniMYkwUAapRgO0aC7RhlaRZX6fbj7iOEEs/ofZ4iJIx+8xcjXHiptpzYPBYyH
         IcKLWcU0kBv4x+Q/+nFEwSAbYJyaAp7qWPrMm4c2rf8VdEM+3BWMI5r5Ef2Ch7U4lEJg
         25ommTI6+/k4gIXm3t43tOh4HiOXwjI+zTdahZ1FjlAodZ7eW7/xZPJ8t6fi986pMSYp
         HurDeCUn8bc2cQsxeW/bxpMee2tKpFV+34KX+0WwSDr2ocblexT6RiLFjU6hhC9FgqAy
         XS4g==
X-Gm-Message-State: AOAM533ZuLqy6NJUZDoWosQQ4uVc53eWYUBnySxX8wTMHcRZgYM5yk0T
        GZ3i0Mdo5146Ux4iQYbcYwQYYw==
X-Google-Smtp-Source: ABdhPJxQBfYbPYKPzP4lAQx/hX3LHay0XfcAyKL3ncwHVwjrbKjWRsBcyYWQd752Gw7d8lUuqHGnaQ==
X-Received: by 2002:a05:6512:3b07:b0:479:1535:b6e9 with SMTP id f7-20020a0565123b0700b004791535b6e9mr33502212lfv.494.1655098542761;
        Sun, 12 Jun 2022 22:35:42 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id w26-20020a05651204da00b0047863382e3dsm844618lfq.215.2022.06.12.22.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 22:35:42 -0700 (PDT)
Message-ID: <813662e2-bb99-2339-04f2-48cfa0d385db@openvz.org>
Date:   Mon, 13 Jun 2022 08:35:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v4 8/9] memcg: enable accounting for allocations in
 alloc_fair_sched_group
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <3e1d6eab-57c7-ba3d-67e1-c45aa0dfa2ab@openvz.org>
Content-Language: en-US
In-Reply-To: <3e1d6eab-57c7-ba3d-67e1-c45aa0dfa2ab@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating of each new cpu cgroup allocates two 512-bytes kernel objects
per CPU. This is especially important for cgroups shared parent memory
cgroup. In this scenario, on nodes with multiple processors, these
allocations become one of the main memory consumers.

Memory allocated during new cpu cgroup creation:
common part: 	~11Kb	+  318 bytes percpu
cpu cgroup:	~2.5Kb	+ 1036 bytes percpu

Accounting for this memory helps to avoid misuse inside memcg-limited
contianers.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e8202b5cd3d5..71161be1e783 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11503,12 +11503,12 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 	for_each_possible_cpu(i) {
 		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
-				      GFP_KERNEL, cpu_to_node(i));
+				      GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!cfs_rq)
 			goto err;
 
 		se = kzalloc_node(sizeof(struct sched_entity_stats),
-				  GFP_KERNEL, cpu_to_node(i));
+				  GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!se)
 			goto err_free_rq;
 
-- 
2.36.1

