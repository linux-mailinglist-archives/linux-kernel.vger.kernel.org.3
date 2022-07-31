Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86240585F82
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiGaPhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGaPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:37:19 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEABE03B
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:37:18 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id v7so2174124ljh.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=d3NHds5lzXK7NHkcod+ymb0h8umHcOGP3SkofwVAu4Q=;
        b=k+FWW/1VqT0nWUIa0PiwIyrU2K3YeXMa6VyDd4BOy5YRWnuhwDDhtmvZouDABS8t18
         LLJ1E1cj2fV376HDCUG14Ith0NDfAhWuMCinEcmqYZWdKJQl4+eNSLQpw5sRjnTGPBnp
         Jnnqi2oMBY8E5U9DnWwbu4vI+dFw9HDYJwA/hFwUZxZSOc6uzf9LM9LMDY6xIN1B7bx7
         cEctz38nxQXE3LUPSdpLj/4INvGemJZq2LINraXT3vKLNjtzxPrYtVbR4UTxaq1V13c8
         00XH75QZeLTf2bT4/KyXiRBtiFKJDfWDE+Ckn//RYtA8KEYXoWNty/q7hec3D38lgAf8
         wwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=d3NHds5lzXK7NHkcod+ymb0h8umHcOGP3SkofwVAu4Q=;
        b=sfW7mSL2c0ZNkZ0EF45vG9JCdqpuxR4dUuMuNqdJZ3M529/g++xibW/6mahnJmZadz
         fi9Z+SJiTWVtbIkqwxFFm6uqTAa5klT53jLyfm5t2Cw3aPDgPg4S1E1IJq15T40hcN7Y
         Ja4xqKbyeaw0NSNAtLr43yZNAPS0fvowtADQDYdDi23+yMXMtcE9oPiJIUAx246C6Vt+
         OaW1dXRK5/y++B5DydKtLb1ObB3RJ9c58K8eqwUKQ+mqL6vPuj3DGSs5zk7CQ2b+Kj5F
         RADiPhpP93ghUem5Ues9fogbJV+y2mzzQySUhWYOdLo66/CnMY9ACzSwqZ1nkLu95GN/
         wgQQ==
X-Gm-Message-State: AJIora81tINihz5ynsuGPCXksKR/8OEBRWeniWjRaLYLwhZoFQeIpYHT
        I/ra/Ay+U+31bv74BK3bh+wSCQ==
X-Google-Smtp-Source: AGRyM1uefqOKHY5WbtRLjQHooerIE+RAMrKZ8lk3sGdvqaqGUbyxpKpt5FJdNdi8IZM0lIicjzkA8Q==
X-Received: by 2002:a2e:9e1a:0:b0:25d:f9db:92f7 with SMTP id e26-20020a2e9e1a000000b0025df9db92f7mr4087738ljk.243.1659281836362;
        Sun, 31 Jul 2022 08:37:16 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id a28-20020ac25e7c000000b0048a8c783aabsm1371931lfr.74.2022.07.31.08.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 08:37:15 -0700 (PDT)
Message-ID: <0414cab3-32d6-c60a-d3c8-96fc72064ba0@openvz.org>
Date:   Sun, 31 Jul 2022 18:37:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH 0/3] enable memcg accounting for kernfs objects
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
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set enables memcg accounting for kernfs-related objects.

Originally it was a part of patch set
"memcg: accounting for objects allocated by mkdir cgroup"
https://lore.kernel.org/all/0fe836b4-5c0f-0e32-d511-db816d359748@openvz.org/

The patches have received approval from several developers, 
however respected Michal Hocko pointed out that, if neccesary,
cgroups consumption can be restricted via cgroup.max.descendants
limit without additional accounting of allocated memory.
I still disagree with him, I think that memory limits works better,
but I could not give any new substantial arguments, so discussion
was stalled and patches was frozen in limbo until better times.

However 3 of these patches affect not only cgroups, and I hope
to get help from kernfs maintainers.

Kernfs nodes are quite small kernel objects, however there are few
scenarios where it consumes significant piece of all allocated memory.
I am aware of the following cases, but I am sure there are many other
ones.

1) creating a new netdevice allocates ~50Kb of memory, where ~10Kb
   was allocated for 80+ kernfs nodes.

2) cgroupv2 mkdir allocates ~60Kb of memory, ~10Kb of them are kernfs
   structures.

3) Shakeel Butt reports that Google has workloads which create 100s
   of subcontainers and they have observed high system overhead
   without memcg accounting of kernfs.

My experimets with LXC conrainer on Fedora node show that
usually new kernfs node creates few other objects:

Allocs  Alloc   Allocation
number  size
--------------------------------------------
1   +  128      (__kernfs_new_node+0x4d)        kernfs node
1   +   88      (__kernfs_iattrs+0x57)          kernfs iattrs
1   +   96      (simple_xattr_alloc+0x28)       simple_xattr(*)
1       32      (simple_xattr_set+0x59)
1       8       (__kernfs_new_node+0x30)

'+' -- to be accounted

(*) simple_xattr in this scenaro was allocated directly during
kernfs creation for selinux label. Even here it consumes noticeable
part of newly allocated object.
However please keep in mind that xattr can be allocated later,
via setxattr system calls, its size is controlled by userspace
and can reach 64Kb per call. kernfs objects lives in memory,
so it is improtant to account it.

Originally the patches was splitted to simplify their rewiev,
however if required I can merge them together.

Vasily Averin (3):
  memcg: enable accounting for kernfs nodes
  memcg: enable accounting for kernfs iattrs
  memcg: enable accounting for struct simple_xattr

 fs/kernfs/mount.c | 6 ++++--
 fs/xattr.c        | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.25.1

