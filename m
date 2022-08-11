Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1259D58FC91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiHKMmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiHKMmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:42:06 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C97E61D46
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:42:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d7so16983751pgc.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=0NMhQVuhzXkwwEud1IyNm6hvZaVuRoUuPkQoEp6AaTY=;
        b=U2AwqSzPv6fO8PpGUCaF2AQotw7T7X2O6thhEuTk1KEihDUucDVJe5ziLoUa6E6d0y
         BqnXd6O76kRCk6OFQ5nFGHiwaWZIFk/ANu5Zzfd40OwXF64SLcPX1MlHJeU5agYRo0EN
         VHMo9ynMC0Zyal7n4+ERV5Zh4E33sJfM7rOQHgDF3N/YlQ5Izl5Ui0TmaSO8hZStkOEW
         jQ19UPY/Ji+zJMlUVPAanUybYLK58sjcPqDTKh51IVFHGKXEB8A+UglgWADRqwb6qsav
         ZWZtJtH5nNWJOR0TV59ioeKcoZOe9riuBAKvQP/9w7DhyOj0o1eqWr02yEDDCQY1fBIJ
         d5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=0NMhQVuhzXkwwEud1IyNm6hvZaVuRoUuPkQoEp6AaTY=;
        b=o4H3wphRFsM9FR3SKDW1+3BS/MXkRG2xMYg/tWdQ0Ba6RLZXWPy8uhtEevJ4qdAVf2
         6R8iZYh85OQzYxPF0rnuYf2nTy4d35NkHCqe9Jb82o1p3JR0hnAhOhGoXIA8EB7mDcDF
         MrHXWPEfywIJ7MVqQ8rjRqjAdxfgqfSjCX73xGrl5QDOM9xybqxbkoxTnOUQK1VDVuyj
         +62QVoZMwjPyIO6aP2MJlQaQjziynja10lRCzyH/BfBTxk/jKiRmrIZjk2gjIfaSYiY4
         shGXD+BkloiiRTCpw53Vu97euNPMme7eO2Yn6/E3YIKWkcbeV12EtCP0ESArWInet82w
         ErUw==
X-Gm-Message-State: ACgBeo0CY/ojKyLdrULxdXi5Qcq6OJRPF/WOsq0Oe/wfXP16PtPjnHI4
        0SGkkOVnbfKJi4wgKgFF1vNKEw==
X-Google-Smtp-Source: AA6agR4/HxN7yvc3GgDrwV/AysM6JnJrKGknSriYDYyiEe9VplJgKHrc61lciSxG6nIdfeLuw0i9qg==
X-Received: by 2002:a63:43c2:0:b0:41a:9dea:5dac with SMTP id q185-20020a6343c2000000b0041a9dea5dacmr26052449pga.585.1660221725016;
        Thu, 11 Aug 2022 05:42:05 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id w2-20020a62c702000000b0052f0a404fa7sm4056949pfg.146.2022.08.11.05.42.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2022 05:42:04 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v2] mm/mempolicy: fix lock contention on mems_allowed
Date:   Thu, 11 Aug 2022 20:41:57 +0800
Message-Id: <20220811124157.74888-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mems_allowed field can be modified by other tasks, so it isn't
safe to access it with alloc_lock unlocked even in the current
process context.

Say there are two tasks: A from cpusetA is performing set_mempolicy(2),
and B is changing cpusetA's cpuset.mems:

  A (set_mempolicy)		B (echo xx > cpuset.mems)
  -------------------------------------------------------
  pol = mpol_new();
				update_tasks_nodemask(cpusetA) {
				  foreach t in cpusetA {
				    cpuset_change_task_nodemask(t) {
  mpol_set_nodemask(pol) {
				      task_lock(t); // t could be A
    new = f(A->mems_allowed);
				      update t->mems_allowed;
    pol.create(pol, new);
				      task_unlock(t);
  }
				    }
				  }
				}
  task_lock(A);
  A->mempolicy = pol;
  task_unlock(A);

In this case A's pol->nodes is computed by old mems_allowed, and could
be inconsistent with A's new mems_allowed.

While it is different when replacing vmas' policy: the pol->nodes is
gone wild only when current_cpuset_is_being_rebound():

  A (mbind)			B (echo xx > cpuset.mems)
  -------------------------------------------------------
  pol = mpol_new();
  mmap_write_lock(A->mm);
				cpuset_being_rebound = cpusetA;
				update_tasks_nodemask(cpusetA) {
				  foreach t in cpusetA {
				    cpuset_change_task_nodemask(t) {
  mpol_set_nodemask(pol) {
				      task_lock(t); // t could be A
    mask = f(A->mems_allowed);
				      update t->mems_allowed;
    pol.create(pol, mask);
				      task_unlock(t);
  }
				    }
  foreach v in A->mm {
    if (cpuset_being_rebound == cpusetA)
      pol.rebind(pol, cpuset.mems);
    v->vma_policy = pol;
  }
  mmap_write_unlock(A->mm);
				    mmap_write_lock(t->mm);
				    mpol_rebind_mm(t->mm);
				    mmap_write_unlock(t->mm);
				  }
				}
				cpuset_being_rebound = NULL;

In this case, the cpuset.mems, which has already done updating, is
finally used for calculating pol->nodes, rather than A->mems_allowed.
So it is OK to call mpol_set_nodemask() with alloc_lock unlocked when
doing mbind(2).

Fixes: 78b132e9bae9 ("mm/mempolicy: remove or narrow the lock on current")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 mm/mempolicy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d39b01fd52fe..61e4e6f5cfe8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -855,12 +855,14 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 		goto out;
 	}
 
+	task_lock(current);
 	ret = mpol_set_nodemask(new, nodes, scratch);
 	if (ret) {
+		task_unlock(current);
 		mpol_put(new);
 		goto out;
 	}
-	task_lock(current);
+
 	old = current->mempolicy;
 	current->mempolicy = new;
 	if (new && new->mode == MPOL_INTERLEAVE)
-- 
2.31.1

