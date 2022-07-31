Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B03C585F81
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiGaPhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiGaPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:37:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1273E09F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:37:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t1so13733634lft.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=dLMU8cfmeXOwQMYX1yaqh+nDmpJAlXyyoWjpPIJaK14=;
        b=OQ2T1gW7fN1KfFahpZTiAWfAs4+oCZLhNsarKrbHuKmufzCF6hW51D7gw+YizPxEDa
         rH9pMctJBxhxvVXjuvaDpb6VQMzWRE3Cc2sR5lQIv1X+M740XjS0g4CQg7R4JYM8c+3l
         ukk1EQmxl6kS/PdNYyHmDjvbPLTV5RpHAR+e2TeA+6zxqYx0EZQFFXaOVr2A+TRYGolG
         SuQMr7CnmreNgHzxWeHPHxq06WAYI70gjRVsbbr7DJXTDN/6x+Tj/drXK8ZfoZ0Q4+4G
         CNERPMHwdoSjnSUhCwWRD64Lo02nVasYItdI9UHvpa7h/Oxi1MbsoE/Zr0bzdOBz9+pS
         5HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=dLMU8cfmeXOwQMYX1yaqh+nDmpJAlXyyoWjpPIJaK14=;
        b=eWgmSYgsHgj9W8fe1spSVW4qU43EiU2AOEbS/Durn8htwNfQc1J6xoyMUSqeSXpnLp
         UwR6HgNpAJ2b8er1Tq8nBd6dW6keqLGDF9ogIOXRQP8VhTxCavA9upLPkcWhloACZ+oz
         9Ka6X3nAnqcxsOji7VHmnUUQ/XA82ITio7pqMFGtvsTg2wPbSUUI5k1MOTJIkEClntuG
         mg+RdrKkkDquGeQv3DbcVaLIV/EW3SN+TgZ4HoX/AF7aoB6g5hMjqlBYTfwAhgggxyrF
         UAFABgU/U9Yt5SrUk8MwYoqwCHKakuaO4FvFdg42ablEe4VI3xfhOko0csu4VdHkvcoW
         jFeA==
X-Gm-Message-State: AJIora+K73PHbg/3NEVcPjEEXMueEaMIKEzbRFAYoa+PxzgyHlJc33+s
        Cz7Df43Xsmg1jMYrNRpRH9U5Ag==
X-Google-Smtp-Source: AGRyM1uqWXdI3C7Cev7bHhTf3NUpmb7jEo5Sv1FueCkh2m+bR0OF2F8w4rmUBRxXfwpJeKxT2Sx23g==
X-Received: by 2002:a19:dc4d:0:b0:489:63cb:20c7 with SMTP id f13-20020a19dc4d000000b0048963cb20c7mr4018567lfj.101.1659281848701;
        Sun, 31 Jul 2022 08:37:28 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id r10-20020a2e8e2a000000b0025e42f8e771sm714084ljk.34.2022.07.31.08.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 08:37:28 -0700 (PDT)
Message-ID: <c15d6710-b9e6-9451-ac19-444f392c1cc0@openvz.org>
Date:   Sun, 31 Jul 2022 18:37:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH 2/3] memcg: enable accounting for kernfs iattrs
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

Allocs  Alloc    Allocation
number  size
--------------------------------------------
1   +  128      (__kernfs_new_node+0x4d)        kernfs node
1   +   88      (__kernfs_iattrs+0x57)          kernfs iattrs
1   +   96      (simple_xattr_alloc+0x28)       simple_xattr
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
2.25.1

