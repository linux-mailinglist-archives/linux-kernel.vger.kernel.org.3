Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C475379D0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiE3L0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiE3L0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:26:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963C77E1C6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:26:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c19so16281753lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=buhJIxm8AqBO3bD99fC3A2PxIb9sSGllubXvwSLnjxI=;
        b=VleSeEOpRENeXIkb3VS63vsilwSdU8qMSP4avGdnDh5rwRnYa2jz2RVYenqeO3pM0E
         DHnSyyUm/QZ5EmzHYl3Jb+ZfcIpTLRDZmxkC/M0yZtrJnPBT7FMzovaP80spNmx1AGfC
         YeM+BMD+j8eeiwA3YZgXNeSwjCueUasrWx79lcZTTgD3by9/hKVr+WE8TfaHyDrWDjY7
         fvLW1OqA44WVwKYAS5KnteFlnEFDxA/qb7HSBCHdOyxAeCZJXY07V5g1Ad8JgbV1T1LH
         9yVcRSF1uk10P9ADPpKBifUv+jJk3ErpO+yVNp/RCuMrSeI9wAh2n2OFB9aEnkWJPam2
         Yg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=buhJIxm8AqBO3bD99fC3A2PxIb9sSGllubXvwSLnjxI=;
        b=fiMpUh2iRRyWZi4g6XdNhQ5p94DgHNc/e48J5iWQRsrWcWBDLw5PY2lCEOATbPHVkm
         X8j/G8YnOJeRySWj78vmvHtTo4RCX8MR3vuG4TQseJe8Rg2K/147pXEZ5/+HzCPqs3EX
         rvLETheGQabvR/cEjz6LUhzbZxbiZpc0OIr9tBV0k9j8k2qGQIPUPmBH4ACHn4aUb4BY
         fyeLSLCq2CO6gkRVbThYd5PRQnmRJahjk8CRCaL2Gym1DdvgfcarsxKDjGTStHHrZc9H
         2Tq9J8CBF4ueIMxxt1T57WWENFnGAB/lDJ1JHecbJJoxFqgNh166eJM/exNp/mBRQH/A
         ahlg==
X-Gm-Message-State: AOAM533WNVNaUD2Pe1C4w0qYQOkKOKZt6PGRZ2MKvsvI/Zrxt/rnBQoD
        geqDkkWUpQ9J4EJNYBLkf+++sw==
X-Google-Smtp-Source: ABdhPJzpWuEoQbBQ6wQAD00lTrkjyUo0hR77U+wtdpC11GHVbqf2v9hXGKCM5qrHCA7Zd3LVUwl52w==
X-Received: by 2002:a05:6512:3403:b0:475:afe3:740b with SMTP id i3-20020a056512340300b00475afe3740bmr39209070lfr.436.1653909969542;
        Mon, 30 May 2022 04:26:09 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id x20-20020a056512079400b0047255d21158sm2253567lfr.135.2022.05.30.04.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:26:09 -0700 (PDT)
Message-ID: <8bb350bb-4109-0065-d95d-bb6777e4391e@openvz.org>
Date:   Mon, 30 May 2022 14:26:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v3 3/9] memcg: enable accounting for kernfs iattrs
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernfs nodes are quite small kernel objects, however there are few
scenarios where it consumes significant piece of all allocated memory:

1) creating a new netdevice allocates ~50Kb of memory, where ~10Kb
   was allocated for 80+ kernfs nodes.

2) cgroupv2 mkdir allocates ~60Kb of memory, ~10Kb of them are kernfs
   structures.

3) Shakeel Butt reports that Google has workloads which create 100s
   of subcontainers and they have observed high system overhead
   without memcg accounting of kernfs.

Usually new kernfs node creates few other objects:

Allocs  Alloc    Allocation
number  size
--------------------------------------------
1   +  128      (__kernfs_new_node+0x4d)        kernfs node
1   +   88      (__kernfs_iattrs+0x57)          kernfs iattrs
1   +   96      (simple_xattr_alloc+0x28)       simple_xattr, can grow over 4Kb
1       32      (simple_xattr_set+0x59)
1       8       (__kernfs_new_node+0x30)

'+' -- to be accounted

This patch enables accounting for kernfs_iattrs_cache slab cache

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/kernfs/mount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 3ac4191b1c40..40e896c7c86b 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -397,5 +397,6 @@ void __init kernfs_init(void)
 	/* Creates slab cache for kernfs inode attributes */
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
 					      sizeof(struct kernfs_iattrs),
-					      0, SLAB_PANIC, NULL);
+					      0, SLAB_PANIC | SLAB_ACCOUNT,
+					      NULL);
 }
-- 
2.36.1

