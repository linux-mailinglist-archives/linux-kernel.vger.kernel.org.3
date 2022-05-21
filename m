Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB2B52FE2A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbiEUQiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245753AbiEUQiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:38:03 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0DC62A19
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:38:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s5so12624564ljd.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=WXL0Kr6NJlPCFE6AkYnbXRqpsriCeDIrboyr2mKYIIo=;
        b=azl0IXyBsAkxqX4vnBtqgFslhmNTs6lzDHtxK88VAXLucBey8Th1FgJxUa7U3KmkKX
         a2cSakrrd3z88D0GZSsfoNCi+sxTt7Cs1SfxFhkIEMrifezGXM/r9N8lfLaGjdnMrnbS
         lxJ6kBnqXJk8dTeheK+GNRV0GcO697RcNQXy8Rh1czDZ+fZQV/SnLAWYNvakQ6NNyqxI
         2mqNYy+/djuO3FLdUA/Qtk90HJNw/IseTJqpAm8vYbpT8jO1zHtXLaI1SjfUbas0SsY+
         sHpo/9jWTXqp52j71o/GX18cDRYXA9Q4eqP/cXswFRq2wO9pAWMI6JaDPuxCUeyCjq7E
         0ROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=WXL0Kr6NJlPCFE6AkYnbXRqpsriCeDIrboyr2mKYIIo=;
        b=TGE9RQzN9iaAoXj4j1hYY52WiJTLI+fN4wEuQ3DA/paDjm5GUoasD+ztIwNU3Gmmpw
         v6rwOHlZO7IS5X5x3U4L5b1hW36+Xn0ngwDhXyjWS+8COoM51+kRHNh8mQ+Fzo0L0wUe
         0bWG3hXHw5OEDoFLjofNn4E8vcqwPyyD9jtoFtlrV5gBpSOj+N88hd1b+Y94McKLywUO
         xCACEYO3K+VNcfQlIMjyCf4znDiReBNYsM5HqGDk0SurMw0axt4ba0AEtiwaEvit1m5d
         djSffHLFL+rsA2SegwuapBB0IQWqyMwuwYRNGUsyhRnUdfPUNuDxzGstKWjXqbPTsIv2
         /HmQ==
X-Gm-Message-State: AOAM531RWKoxoRIk/yuP20h6jlFKgxIVWfXPcS58y0m+vMDQtY5XNBV/
        5+iAtaxwUetzH8vPCffD3/sItQ==
X-Google-Smtp-Source: ABdhPJz9guAKE14vLO2t185SB1774V0K9APnw2MBpEnkasC6qr9TkZkPhtlY2NCcTThOGAH/Yv6RAQ==
X-Received: by 2002:a05:651c:890:b0:248:5819:b949 with SMTP id d16-20020a05651c089000b002485819b949mr8442007ljq.476.1653151080713;
        Sat, 21 May 2022 09:38:00 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id d19-20020a2e3313000000b0024b14fa6061sm772690ljc.1.2022.05.21.09.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:38:00 -0700 (PDT)
Message-ID: <e5a8bbc2-3d97-d016-f2ba-4b2b3073a9d3@openvz.org>
Date:   Sat, 21 May 2022 19:37:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v2 3/9] memcg: enable accounting for kernfs iattrs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
References: <Yn6aL3cO7VdrmHHp@carbon>
Content-Language: en-US
In-Reply-To: <Yn6aL3cO7VdrmHHp@carbon>
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

