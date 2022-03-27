Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804454E85E9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 07:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiC0FVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 01:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiC0FVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 01:21:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02507B80
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 22:19:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p17so12092136plo.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 22:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjNFjTqwpOuk0OmVp2LI3cxltEk8fTUHQ4QbOFB4vvk=;
        b=LmvEja9mugbtDUHpUoc6c/SMiY+gvn5CIc1JrYU1LpPlA1fZ/lwx3cDp5g9ZZ0kAX2
         LB7IhD2aeiOjOyVZvhz9yWm/4APxJCmwIzs0bB+wNy4h8PCYWV5KfUKVedXKnl17Ofyf
         4QbMDPTjcj8I6iR2fDXrKf2anSAUUhG3L9gIG/6fJzN67eQSKz80CfpC+CxBov5bF+MZ
         WvQSZhmx/VF155myPPH7p1tUR8goojEfUZDNf+2HbaPB8oU0hMnIekjfN9xc+4DYYGss
         jSZrB0XeBIWi/YXLtJXR0OIn71Ma+xaNpTKTn9ItCnYit2hrW3vE2bBWWpDNFsKlFrCN
         CxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjNFjTqwpOuk0OmVp2LI3cxltEk8fTUHQ4QbOFB4vvk=;
        b=OyWXScceS5VF84Xb0TB5udpqiV1C5PWPg3jxmH42KxfvzOWtWtlTwOEVg69vf67Jcr
         iDRIKxKG4PvD36jxHYp4EsROZ8T4S92NWeVUArc48/3VeR/ZICCUzTIhs+po4Sr/pDsO
         cAnCjLOuICU+jLtwIRHSG7a/JRooquUUpQn4NbB/Fj8OMMeOKi4p05j1yOFUMb03nur/
         +O0h2ZJwhbOJkKAjKusXFybypyHlickXJSPz4bXsUniMRYiqTe1ZWnt3CIIb+OfQg6O4
         06ufIiFzt0Qopf5ZX6UmOSQ2ysGB24Jmui6vWcamZLxVdMyfe8CCAsLbhYG1HobIxvve
         CtEw==
X-Gm-Message-State: AOAM532yOx5mpK4SGxXV8+45ZrkG2Q0W81QbILUQCN+y8CdukBTkFmMU
        xGg8BT+FT+z/2TJi2pMJIQLxnA==
X-Google-Smtp-Source: ABdhPJz2aB98Y3G5VOc6lG3pkMti4Fm7JWuWCF/dRTNBFesRHgg0rKRc2zn7znE6t3o5dBxP3GJudQ==
X-Received: by 2002:a17:902:c94c:b0:154:58e4:6f5a with SMTP id i12-20020a170902c94c00b0015458e46f5amr20586217pla.142.1648358380557;
        Sat, 26 Mar 2022 22:19:40 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id m18-20020a056a00081200b004faeae3a291sm11115940pfk.26.2022.03.26.22.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 22:19:40 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     torvalds@linux-foundation.org, glider@google.com, elver@google.com,
        dvyukov@google.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, roman.gushchin@linux.dev
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com
Subject: [PATCH 1/2] mm: kfence: fix missing objcg housekeeping for SLAB
Date:   Sun, 27 Mar 2022 13:18:52 +0800
Message-Id: <20220327051853.57647-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The objcg is not cleared and put for kfence object when it is freed, which
could lead to memory leak for struct obj_cgroup and wrong statistics of
NR_SLAB_RECLAIMABLE_B or NR_SLAB_UNRECLAIMABLE_B.  Since the last freed
object's objcg is not cleared, mem_cgroup_from_obj() could return the wrong
memcg when this kfence object, which is not charged to any objcgs, is
reallocated to other users.  A real word issue [1] is caused by this bug.

[1] https://groups.google.com/g/syzkaller-bugs/c/BBQFy2QraoY/m/HtBd5gbyAQAJ
Reported-by: syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com
Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/slab.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slab.c b/mm/slab.c
index d9dec7a8fd79..b04e40078bdf 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3422,6 +3422,7 @@ static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
 
 	if (is_kfence_address(objp)) {
 		kmemleak_free_recursive(objp, cachep->flags);
+		memcg_slab_free_hook(cachep, &objp, 1);
 		__kfence_free(objp);
 		return;
 	}
-- 
2.11.0

