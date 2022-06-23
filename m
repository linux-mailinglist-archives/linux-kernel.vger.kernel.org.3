Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF4C557E34
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiFWOvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiFWOvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:51:07 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE6146CA9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:51:05 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w20so33753143lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=buhJIxm8AqBO3bD99fC3A2PxIb9sSGllubXvwSLnjxI=;
        b=i/p1o/M8klz+95et0bgwJpltVKqCgK9M54afMq5vmjuCLAEfL2lvisExr0IgdMekvu
         tf1cimXjbPEFVWhzrSItzE1007SR0q12B7VZHtXazaQnKiyuWs4PSjAymxaW1j4O4P5d
         H3Jwm2v+2F+Bhhn5f1R8Q7OuwGM/ffLuUOy62bmulvutMKsnJhX/4NJnD4FRSVZQ/oZB
         R21gnYF30vDTNsNNc7Zri6ut8pZGbuCIKB51DHmUPpayYIR3ZTeU9z7xYQqjQ8TxdE1T
         UT5uMmYOuNDiJaGtg0ApIfWOb4pLIKsf7jLnMytt0GlIYkqXy4hVbvifv+enr8R0hnOM
         JuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=buhJIxm8AqBO3bD99fC3A2PxIb9sSGllubXvwSLnjxI=;
        b=ooavryFFdV7JF9tZCP+h5KoaVXP8jEpe5acR0aTbIQO1rDVF+/KqNokotUoeM1GssZ
         zYAXCs+icAt+8sWAPqlbybwl2HoOZeKONk1nOzn0LTMU/EMfXrI+dNL0d1EH09jG0IZR
         WXYPOJjBF9/ipZlnSE7FY6PY/x1IRMn7Bhk1MKlDYDJkUAP+05NvsveCXTJPUQmJZmeq
         x2Lkj0wyK8aZsoUEX/WGG75y6fTihc+YYZ9Di/nQUCA3fL+axKubSw2aD2HXlH1x+vcq
         FYYVat48szHNnCdBLWDDIFj/GQVK3hz/TEvAb+uzVYc//8A3mcW1sQP18fmK3ziHRPOa
         QG4w==
X-Gm-Message-State: AJIora9E8kfm3TYMoWqyHtQ6fGpiLTB2XDWntbIj2nSsuP5abev6sgFU
        2q6O/VleRU76SQaLH2TuKSt5Gw==
X-Google-Smtp-Source: AGRyM1s9nRJMZXHQY6aNsU9CgmRfXjPefvAMOQyBH3yS4iOM/J39zAOpv9yr4y+2zq9TSeoa52DsCg==
X-Received: by 2002:a05:6512:2811:b0:47f:6d20:6a71 with SMTP id cf17-20020a056512281100b0047f6d206a71mr5674081lfb.60.1655995863995;
        Thu, 23 Jun 2022 07:51:03 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id s19-20020a2e2c13000000b002558e1bec75sm2827343ljs.5.2022.06.23.07.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 07:51:03 -0700 (PDT)
Message-ID: <acff178a-ea80-6fd5-e3f9-fdb2060d23d5@openvz.org>
Date:   Thu, 23 Jun 2022 17:51:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v5 3/9] memcg: enable accounting for kernfs iattrs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
Content-Language: en-US
In-Reply-To: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
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

