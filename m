Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B068547F21
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiFMFgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiFMFfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:35:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86487FD05
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:35:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s6so7071642lfo.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=buhJIxm8AqBO3bD99fC3A2PxIb9sSGllubXvwSLnjxI=;
        b=poLeG6zhCv/e/uvaonfvqyZcWLUQoZKI6x1zrBYzR8yEcLqX5MJjRu0DpBmK0UieGM
         9s8GkMwlIhLIZoQPjVePmWg9+eHaw3B/mxAbv92cla9k0nTwF0/t7OND21vBl/jnCbIU
         IRCipafuU6E/GhmoUqu9xNvZBtbB5Z528WMihwahUcILGFkidaBexjc14Cq8pW8Z7Pvj
         N7AfutKNP8hBX8d3mBRFD1w6M6/KhKiGE+zL5Mh/NHBVYzb1srbsoyGopRzu/uGFFuO0
         9CT6RkUDfugqIiBXyVg6DD3bipqyjO7hrVYqc1/pWq903VKpx9vz96zgU+w6o/ZlFCvC
         9x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=buhJIxm8AqBO3bD99fC3A2PxIb9sSGllubXvwSLnjxI=;
        b=iui6TLodh35ocJ5nQIkwuurKw+RzC1IIhcT9ocHNESEeibOPT+d7e2GS2NS34scHpj
         o30pz1DWZAN4JXlt8jornb2mrUEGKHVmN/UL1CUQJM97D2yG1iDRss6HxfOC5rt5YZbv
         L9Lf5cblf94eJw4rcrnOh0WWaRaeFpe1WXHWCtZ7eWQxWLHbV6m+LOx2fyMt2wtyvhbK
         Sws1Zxfs8QOY4oFfEHecytNPpUuM7rkpTnCPezAq3UQJ2k/Qz3aGn3D33kIZpiIRQEeU
         Ew23r+XWGaQ7Thsfr4V2+zZ2frEvhTSdLBCowvTKqZt2aHT3HVQeHSQwyHeU6Ybs7FO/
         Wo9w==
X-Gm-Message-State: AOAM530EnxqfGm2+J778dr2ZzIdW29B9n/gXeXx81/Lk1p4JU2NP81X7
        hXbzn1/abPxP/PP0iI21DKsgyw==
X-Google-Smtp-Source: ABdhPJz8mC+oy5QTxd+FVDFv22laevGRjje04Lf2wVUa8G+vhmhElanXbHdoiJIbuGw58hKsSQKOWg==
X-Received: by 2002:a05:6512:2249:b0:478:f926:ad7 with SMTP id i9-20020a056512224900b00478f9260ad7mr38742258lfu.511.1655098500094;
        Sun, 12 Jun 2022 22:35:00 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id j2-20020a2e6e02000000b002555c9d5d7fsm894992ljc.11.2022.06.12.22.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 22:34:59 -0700 (PDT)
Message-ID: <647143fa-2521-10ae-2c4d-41dbb74d00cf@openvz.org>
Date:   Mon, 13 Jun 2022 08:34:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v4 3/9] memcg: enable accounting for kernfs iattrs
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

