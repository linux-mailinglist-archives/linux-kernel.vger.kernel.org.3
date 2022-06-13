Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3DD547F15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiFMFgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiFMFfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:35:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771F61261E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:35:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a15so7097461lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=k8OfFf3zteeGV4NoXsW7mYQBRm/UT3jxMOm3SilJFI0=;
        b=QCCq2RzIkfRwteIiJbTj0Zzj5B4WLYxGewaFjiLQoUpyY6C9/Jm2Kois2pCwI52eRl
         UWOOFNQGDLwx1lliCTUM0VlyS1cfr43JGICQoEtjpMgxRtJrEiG+o2Aer69l3xQbvAMO
         17aLlEwsCfIfrW9BO251dX2yEKDMW4oh9hb6fWYUavQ77/aSKnjKqBFskE9d7rWE3tRX
         f8vJkhfg1+am5rI9o/1tQmSF0l6xMThUXR/eOThEQ0riKpRPQhouMRKgLTnMtRUS5vGF
         b7jkhFk1BQHlwczmyMTCNI2SUCBYRAdsDib0POvKjJEOl2kbFpgAMhR4/4VnYLmAp7Bh
         bz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=k8OfFf3zteeGV4NoXsW7mYQBRm/UT3jxMOm3SilJFI0=;
        b=6rF1GCHAvAL16WSRvHPpVaiLFRzjiyZUAhyBD9+P27myMKuYGkG+yygVoExtVrj/BI
         a9MFNzk1eOiiPaJnxbMF/e7M1awab8xJtvQ/jP9aWc/WtH4/51KYP3ZtJJRGSJT5ZAT4
         SJv4x7H/RYkyCvvSN1Fj+x9nDUgvkiFhDJcfsl7q1RkScBMk5EbDicUMIwSAmxOjI6cR
         M9NPI80zV4UdOc6P4FGm27bRO2OxDP+Zae77jXev1ZilJP1RbSVUKJjjyufgO80c/MvD
         8Ki9E7FcpjFh4Z3CHUEs2A376WUpuB3m99g79uSRDsPION/ZWPR/oqyOoXb+SjYJksR4
         1Zfw==
X-Gm-Message-State: AOAM531r9iMbxtw/kdY0dIFJ6i2cjhMGh99QUU2Hwi3KeaLDU77m0Dek
        IiD3q2czGCbYxIl1fV1df34Puw==
X-Google-Smtp-Source: ABdhPJxlklyclOFDaFEDttumwb5rFLdd5oyZnDa4Qw5e8gcdQoX+swRc3jh5ZNuvaf2KIiJcxFlz/g==
X-Received: by 2002:a05:6512:2252:b0:479:4fc9:f651 with SMTP id i18-20020a056512225200b004794fc9f651mr21452200lfu.247.1655098509032;
        Sun, 12 Jun 2022 22:35:09 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id i20-20020a056512341400b0047255d211c2sm849476lfr.241.2022.06.12.22.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 22:35:08 -0700 (PDT)
Message-ID: <82caac31-1dbb-d3af-185a-6469c93f7a48@openvz.org>
Date:   Mon, 13 Jun 2022 08:35:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v4 4/9] memcg: enable accounting for struct simple_xattr
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

