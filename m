Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472225379D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbiE3L0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiE3L0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:26:05 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB37CDFD
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:26:03 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l11so600869ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=gx5BulmdWVt1E6J23Q6sWTUkZpDqVLFQzvPT6hFPLlw=;
        b=HI2S3D2LaM+CpJncitps90D3zTHWFeNVbRo1proDv/epa86UIsO3B+emCKjHD05m4E
         qaz6ChKh6pu6uXKvY4S+1hqcRalF7rqVye6N2mRkVsZBcCOfpslnrDjEWUzDp+5aaXyk
         tX2/q17/WDl//b5r1mGa7Tq3zVSZPou91Tp/ZcFweUHcJ2JUTj+EhVRNwd5zDCtSX0FG
         7cSJ76MxlShzeRJ6K2QGxobnEb8yF6DKMGiaLkKYKeKo38m8hCPfsMYL2Hm+58LsRZDB
         drNrbEsCzPbVlFCfAbrszHoJLFdt1COVb1PrGklTomSfK6+fAnL5CpYezD9s7NiYDo8P
         IWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=gx5BulmdWVt1E6J23Q6sWTUkZpDqVLFQzvPT6hFPLlw=;
        b=Lx2eofhlRlauc4pq4XyqUQYAC83XmXdJtqxz2r7EFOB5YAlOuLIcgyA7nblB48yA3T
         OPBKZbninq2RtKUT5Nn03vFAJJJ1sEyToVGljPwA9aOMkKpmcBi1YSnmCYYzD/SIwpFn
         ufQd8PjxoKjlKGjqx06nuglxxt8SHjxPXx6iLNaqopUSTNmu7R7NC+5kaVHlwcSMIYDy
         Na1yMqBJC9mpx03D1tYz2gA1eP3ck9u8dYPxoJMd2J7NmIxuf8ir7y3ydx7yrt690PHh
         KUmCxh8UGU5PU7iRmix43deCHt8nM1pITr1aTWKqa28ZpjntG1NVatm0iIwQldYUCpHL
         MWzw==
X-Gm-Message-State: AOAM531NQHnhvZ5YTdTokrp16FlhW6DdUZ8uD6BcQWFJ7O7VxMNoK4ql
        JAXMBFLn4MU8sPc2eES+Sj2dJw==
X-Google-Smtp-Source: ABdhPJwD9LSfSBRnWiwlpIefSTvogQriUgx1hTSg0IhVk8GLzaUQIgiJC9ckHwGLQaN1U8YmUtU/eQ==
X-Received: by 2002:a05:651c:556:b0:255:5125:309 with SMTP id q22-20020a05651c055600b0025551250309mr1693556ljp.201.1653909961957;
        Mon, 30 May 2022 04:26:01 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id d16-20020ac244d0000000b0047255d21188sm2255883lfm.183.2022.05.30.04.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:26:01 -0700 (PDT)
Message-ID: <aeb2adf8-04ad-2f7a-dc03-c1bf0f71450a@openvz.org>
Date:   Mon, 30 May 2022 14:26:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v3 2/9] memcg: enable accounting for kernfs nodes
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

Allocs  Alloc   Allocation
number  size
--------------------------------------------
1   +  128      (__kernfs_new_node+0x4d)	kernfs node
1   +   88      (__kernfs_iattrs+0x57)		kernfs iattrs
1   +   96      (simple_xattr_alloc+0x28)	simple_xattr, can grow over 4Kb
1       32      (simple_xattr_set+0x59)
1       8       (__kernfs_new_node+0x30)

'+' -- to be accounted

This patch enables accounting for kernfs nodes slab cache.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/kernfs/mount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index cfa79715fc1a..3ac4191b1c40 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -391,7 +391,8 @@ void __init kernfs_init(void)
 {
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
 					      sizeof(struct kernfs_node),
-					      0, SLAB_PANIC, NULL);
+					      0, SLAB_PANIC | SLAB_ACCOUNT,
+					      NULL);
 
 	/* Creates slab cache for kernfs inode attributes */
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
-- 
2.36.1

