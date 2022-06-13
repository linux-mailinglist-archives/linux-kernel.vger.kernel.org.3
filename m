Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8450547F06
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiFMFf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiFMFfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:35:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF88713D70
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:34:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s6so7071642lfo.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=vVFg1kFJ1ZrAuYqNU+G4M2YG4vffoF6tfug6s1kVYgc=;
        b=Tu0ulCRi9G/dXEAfgaijmX0Oo+JHLmSXnmrJ+MEuxOIvzY3vhXf0LacSOeN87REMdt
         0EqL9howlhfqHTYOCyGIVa5yxvuBcSAQ+J5glfRzw1ieygNZvfqcNJp/hQEadqGHIoBk
         cVwK70e7kA/PCPZ5d4ZK0wPzt33x/rXcNf75GLCkQJ4/9yah+076fyA0Mwtpd4DFVtTE
         OEe7Av8QYdWetO9Jfkjje1xVuCyvJXcNowOmDKUgUK2/xylEl0nTMyJoPhlRkQlkUliw
         H6ZJSkmEBCbS2XIUcoiGJCr8kg+4ug0gZ3OfnLNzV6l/B7ci7LgBuBznFgJr3hgP3NQw
         hYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=vVFg1kFJ1ZrAuYqNU+G4M2YG4vffoF6tfug6s1kVYgc=;
        b=pbi/rpIIlXyJw5tgqdYjznyXtuAtwmrNionhWyHrwbBcro4LuatLE5RCHWRdkEnBP1
         SlSRRtaRn0FpS3FJXwakWcLQ6usB1vYvdQqiu8HshkT58y6ceslIpiPesB1w//KH2eO8
         0MgaPyO7cvdRRCO3GIIk8T7q+gdcXTxN0KlYYOTAhR9drVAA4KC9SppJ7cIuS4l+uabB
         6l1/SNXgYQGO3n57ZDHLOXNBnNerjJOgZNB1P2P8frMc4ZnzQ1wzczYHGfwoYkFh9riP
         IsKYF2IUqB/V7iR+gu2mJecLBPFtzApRiLRHx74pWVZ9CRhC+iHqzH3OwPnvQiWE8Ji2
         JzgA==
X-Gm-Message-State: AOAM533anyUiay8xiiHbiO2uT0R9QghCVfy3phzr4cI/vSUwtomFFtcr
        cVtc1pQFRQaej3CYu/VXi5QWrg==
X-Google-Smtp-Source: ABdhPJz9g22UtbqUqRQrAPjssQkh/JLrsa/hrQftvJymHjpwcOduOutW0vw/76d3RMB9I39vIXRfzw==
X-Received: by 2002:a19:5f1d:0:b0:478:f072:8dc9 with SMTP id t29-20020a195f1d000000b00478f0728dc9mr35072871lfb.440.1655098483186;
        Sun, 12 Jun 2022 22:34:43 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id p13-20020ac246cd000000b0047db8b30670sm845259lfo.136.2022.06.12.22.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 22:34:42 -0700 (PDT)
Message-ID: <4c393a46-f6cf-ce8a-7771-81cbbc9ca278@openvz.org>
Date:   Mon, 13 Jun 2022 08:34:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v4 1/9] memcg: enable accounting for struct cgroup
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating each new cgroup allocates 4Kb for struct cgroup. This is the
largest memory allocation in this scenario and is epecially important
for small VMs with 1-2 CPUs.

Common part of the cgroup creation:
Allocs  Alloc   $1*$2   Sum     Allocation
number  size
--------------------------------------------
16  ~   352     5632    5632    KERNFS
1   +   4096    4096    9728    (cgroup_mkdir+0xe4)
1       584     584     10312   (radix_tree_node_alloc.constprop.0+0x89)
1       192     192     10504   (__d_alloc+0x29)
2       72      144     10648   (avc_alloc_node+0x27)
2       64      128     10776   (percpu_ref_init+0x6a)
1       64      64      10840   (memcg_list_lru_alloc+0x21a)
percpu:
1   +   192     192     192     call_site=psi_cgroup_alloc+0x1e
1   +   96      96      288     call_site=cgroup_rstat_init+0x5f
2       12      24      312     call_site=percpu_ref_init+0x23
1       6       6       318     call_site=__percpu_counter_init+0x22

 '+' -- to be accounted,
 '~' -- partially accounted

Accounting of this memory helps to avoid misuse inside memcg-limited
containers.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 90a654cb8a1e..9adf4ad4b623 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5353,7 +5353,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 
 	/* allocate the cgroup and its ID, 0 is reserved for the root */
 	cgrp = kzalloc(struct_size(cgrp, ancestor_ids, (level + 1)),
-		       GFP_KERNEL);
+		       GFP_KERNEL_ACCOUNT);
 	if (!cgrp)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.36.1

