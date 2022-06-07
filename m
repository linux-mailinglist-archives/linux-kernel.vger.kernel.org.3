Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C184A5379D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiE3L0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbiE3L0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:26:22 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C187E1CE
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:26:20 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p4so16289528lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=k8OfFf3zteeGV4NoXsW7mYQBRm/UT3jxMOm3SilJFI0=;
        b=K/QFxlODFRAVf5bt4Q3P/XNh1C8S/u5UgjkwbSrQRpQsAlAfqwyev+c+gKJa7sqM/E
         oQZSKjl/uojTT/rpHIvx0MAm4K8ZHdoT5kwFjZRwHOZa9yv6Ym6HisUbdsUdy1+BkCLn
         L5peMyjN5TEkxZCi/h1dH+nfo5XsybR/iIDzcJRIdXQ0oMZgtKynvBMNcuWwSJHRivKh
         c/tAJLVDRKtzyZ4IydneAMA8SrsOIVPc4G+J/qRvjIB/Xw7o9KziSEBXV6+2XhpiVWaP
         BiXPrksHoHCXi3svqTtexh4P+jYBn5XvE4noKsvPXrztol0mmqbsUK7ATZjq+fvDxVg4
         DyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=k8OfFf3zteeGV4NoXsW7mYQBRm/UT3jxMOm3SilJFI0=;
        b=60iRsTWfcvD66vf4tKyI9VqTTB7jocK4C3Ow31GbP0TO91AaBGsI0/AWmGol72Hi+X
         6NkWU9U0SaM+7EBVZctLoXNfyHYqb49w2Nxi88WfJ5wDvGTBxgpltPpheUXeCv4aBaiF
         l7nPilBJLteJd0F/IJF6HI9xrwpEYRKM4qTh/+Fapt28fGQmmd8nlt5dMjBp7g8VLgJ+
         dOTTG2H6IIVvPPpMKmCWi5+gbDGluF759rm4sLbLafmaeYllOjydo/tXYQYclX9FH56r
         4aV7UB/Oy8dvQsMlQ57XltJI0I/Vkw8560flhr777vj+F8Mipfs/LIgGLrVecLDG766f
         aK6A==
X-Gm-Message-State: AOAM532cJqm954LLmS4Dk2EQpq5Zug04WiYoFo1nVDCGMMXSsXYdCB8f
        MaAewM8jNQlbPsTp2oBCCWS9Hw==
X-Google-Smtp-Source: ABdhPJzitZ5wwfvVpz+DFbNxCabWi5NGZMe3ykeTBzzkgh7ViTPBzssNCMu6Zq+df5lnnce3Dah3dQ==
X-Received: by 2002:a05:6512:2304:b0:477:a99b:53e4 with SMTP id o4-20020a056512230400b00477a99b53e4mr40004522lfu.445.1653909979299;
        Mon, 30 May 2022 04:26:19 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id bf14-20020a2eaa0e000000b002555232be9asm196311ljb.83.2022.05.30.04.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:26:19 -0700 (PDT)
Message-ID: <ecce42f6-28bf-5d59-e84c-688a6a3b40b8@openvz.org>
Date:   Mon, 30 May 2022 14:26:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v3 4/9] memcg: enable accounting for struct simple_xattr
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
1   +  128      (__kernfs_new_node+0x4d)        kernfs node
1   +   88      (__kernfs_iattrs+0x57)          kernfs iattrs
1   +   96      (simple_xattr_alloc+0x28)       simple_xattr
1       32      (simple_xattr_set+0x59)
1       8       (__kernfs_new_node+0x30)

'+' -- to be accounted

This patch enables accounting for struct simple_xattr. Size of this
structure depends on userspace and can grow over 4Kb.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index e8dd03e4561e..98dcf6600bd9 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1001,7 +1001,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
 	if (len < sizeof(*new_xattr))
 		return NULL;
 
-	new_xattr = kvmalloc(len, GFP_KERNEL);
+	new_xattr = kvmalloc(len, GFP_KERNEL_ACCOUNT);
 	if (!new_xattr)
 		return NULL;
 
-- 
2.36.1

