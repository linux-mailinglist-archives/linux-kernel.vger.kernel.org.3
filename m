Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42CC585F80
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiGaPhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiGaPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:37:25 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7BCE08A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:37:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r14so9850196ljp.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=BQjoBYdrvkmgbq96aMuVIReKVBshDEV9OFCA7cFNc1M=;
        b=tQY4M9GMZNIrSmoAqqmwqT2VSKU0vLcY1uwsucKmjNWQei/KcUA+cmdJhWHN0i9bu+
         NlrM1hw+FICYy0a21p0JPU/igcYzHVlEuPTkPtLnqV/iAgdHjVTqe45MsEkuTSvdjNj3
         +rTSlYP5iNfkhrn1hjrqjewu7HTGjhEbdFVvdIYy/kCZon3yM270rADqroIoMyv6pNCp
         GYhpghRHIBfAcHsqTRHdHa8EBkcp548y/VH+I3G0jllN/0WWLh5XAVSZRn+oSaOl07qe
         /rzYTPTIVMuT+4aSOuZHCo680h0fSKqs+Yk9BpSznoVqpcZV2gYjAGC8ceOrEuTy4/Ci
         37mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=BQjoBYdrvkmgbq96aMuVIReKVBshDEV9OFCA7cFNc1M=;
        b=k63c99tpEDdmRKgaKIFmIfIXrLk6FMekphkQbWReUdAY5JYb8a+XhIUijx5riveVSU
         LcbVk+I7BINmgTp4SEyPb7NwxovzD/1Wl+ZAbBLh8uMuQjqiJLpBZEHNtcmwcywmoXDj
         GNfwuRz96OZieZnosGZdaYKvZgymn9gDBRvofBFjCBPp0xtlObUkkbNXEcWLKjn3Y7OI
         7Jkj0X2iIJYjYpybv1jalJ5nMDXDwmQmVSAGvUYXQTq9hpHdhab5ixZO/BLEn0jR8RT+
         dZNgrYxvRWdZB58hNtaARFAQkSSUeLfoAri73rHGwS3xw43/5ufa1/JgHOOW1upKKf05
         mHlQ==
X-Gm-Message-State: AJIora9k+KTULSskFX8GSq0BUWooxQKvqBCGUBllYrCo7CWpfPr+LKBP
        vyWIzTHW0z1khWhC1/z5az1Xuw==
X-Google-Smtp-Source: AGRyM1udhsVVTPaa8n+X18JneyADhd57xPjWjo7eNsGywNFpZ7j2XmkpsQjkPdUf2tadqzPMlCZuZw==
X-Received: by 2002:a2e:3109:0:b0:25a:8a0c:40e2 with SMTP id x9-20020a2e3109000000b0025a8a0c40e2mr3713067ljx.26.1659281842217;
        Sun, 31 Jul 2022 08:37:22 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id u6-20020ac251c6000000b0048a97b0373bsm1378816lfm.59.2022.07.31.08.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 08:37:21 -0700 (PDT)
Message-ID: <43433a5f-cfbb-7aa1-5054-08704faabae9@openvz.org>
Date:   Sun, 31 Jul 2022 18:37:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH 1/3] memcg: enable accounting for kernfs nodes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
1   +   96      (simple_xattr_alloc+0x28)	simple_xattr
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
2.25.1

