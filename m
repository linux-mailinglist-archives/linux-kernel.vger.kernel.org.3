Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C25A585F83
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbiGaPhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiGaPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:37:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CF9E0A8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:37:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u3so10984769lfl.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=m1FqEmtdwDo/E8k9npEgYw8xmzL1lozHYa0iZz0nJrg=;
        b=xOGGLRZjBVG9MxuHaEnLE7iNaHrpRkLGQPZjSBV4roFIkIswSE1sENI/+/Wflo3XDG
         5hLvm3Id2Y52CyZ1XIY7s8Vi/n1OJ0QE+gv5f9P9mxQkNgSiP4zMtSWT6GB5v+fzcB5Y
         EcKkVO4szhQYvd4O/Yamr7m1GuluqLy/eTOs1F4LOJF1jDh7N7UHoVjxzIGd36/jHp97
         KD1gmVg24d6Ryv3glWeIvzzU79J89dpxrWgPah9L5bfjHauG+XzWMyrS91Rm5o+IXsTn
         W5TtjvjOjb7kT5K7mWYVBZDvl5wMR4gv7aDYYRzwmNaYoF91W4DuOBQipv09ELtaM8EL
         yqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=m1FqEmtdwDo/E8k9npEgYw8xmzL1lozHYa0iZz0nJrg=;
        b=jo5s5izUY36sLsoDGwBqxJYbrmoBw8c0YJE998WnU9dfKctXGOCknLT8bpwo7AhanV
         +Ts6SWrUMASNoRq1apFH7P+uVYYs2gTp7/CLioKeQTMIsSJpAdK0dfOq/e+mRxtEHKBb
         nzrYeeZ0WXqQqEkSsKNNxDYTZSidDRxQzjvOwpHqlcUVWqo0fcSazyTilZUDsAZOe1hR
         SCsDn90dGhev3SbkfH3eo8Nco9LUL9eLgBn6DZZTpGxZdzpcJsz2T9GO9TF/FV0JUPPJ
         y635BiXnEKWDolk0Bsfb8EDkQzdtHYQu24RhHG9JpjFBnyJrJ+bDX+01a3d76OGXKAlw
         Oc6Q==
X-Gm-Message-State: ACgBeo19m0I0ZH+K31fM6wUloPRcVdBga6o4niWuw1MUUoRPpP0d3XiI
        ja3ExQW3S+/DBWhdZ7i0Wd196Q==
X-Google-Smtp-Source: AA6agR6NmPx/CBiewAPavDB8AvBK/d0RfDkogqzpftkuTsBEOJVRiIok7zhFMG4ipdfGvQOYvyaFlQ==
X-Received: by 2002:a05:6512:3b84:b0:48a:ea34:1b8f with SMTP id g4-20020a0565123b8400b0048aea341b8fmr2476487lfv.208.1659281858317;
        Sun, 31 Jul 2022 08:37:38 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id k1-20020ac257c1000000b00477c5940bbasm738954lfo.265.2022.07.31.08.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 08:37:38 -0700 (PDT)
Message-ID: <2e1e156f-3e79-9bf4-752e-5de836d1ff54@openvz.org>
Date:   Sun, 31 Jul 2022 18:37:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH 3/3] memcg: enable accounting for struct simple_xattr
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
1   +  128      (__kernfs_new_node+0x4d)        kernfs node
1   +   88      (__kernfs_iattrs+0x57)          kernfs iattrs
1   +   96      (simple_xattr_alloc+0x28)       simple_xattr
1       32      (simple_xattr_set+0x59)
1       8       (__kernfs_new_node+0x30)

'+' -- to be accounted

This patch enables accounting for struct simple_xattr.
In described scenaro this structire was allocated directly during
kernfs creation for selinux label. Even here it consumes noticeable
part of newly allocated object.
However please keep in mind that xattr can be allocated later,
via setxattr system calls, its size is controlled by userspace
and can reach 64Kb per call. kernfs objects lives in memory,
so it is improtant to account it.

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
2.25.1

