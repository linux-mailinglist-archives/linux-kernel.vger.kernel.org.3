Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5939595E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiHPOZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiHPOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:25:49 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EB89D8CC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:25:48 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id sc31-20020a1709078a1f00b0073096c2b4e1so1874621ejc.22
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=hy9UEqt4hbmFGdzKrmujqIQhaC8w3Q92dlmS+f+lkQs=;
        b=nQ93mu+9MYBlAVVRshlJ2qiHdIT3FAlp3XTxCxOoApR/HIk3YecCcej73gcqPsmZpC
         Wo1BaRsiZ1VlI05iAjCzu9eC3ih6+EhuFw9Tlk1nbMmJTjI0F2ucwa7n1As53X3vdCZK
         adxnXbmSRHNUgqHpV9yTs/zYPnVLVDnp/L5MtUKqfiMS6eq3XkZnCz+eJmm1jWyHcN70
         oZp5/OvdQWRgGPZkCAMnghcJ6jofS8ZHkL+nbfUde6ukenvSPj7OCdmHo7wvLVP3e8Hf
         UXZpG16wW0EeGksHK2EousEcoTBHPobx3CQheSaTWV5wFSCcTWe2o0w5mEldnFN1Ivxf
         ia6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=hy9UEqt4hbmFGdzKrmujqIQhaC8w3Q92dlmS+f+lkQs=;
        b=X2a2z/qAOw8ezf4daFUc5cYarsgIYtda4DeRdS0osl5fUjzGVodqk3jsuNQflWJqG0
         2GTsN/bYRZzj7hT3JuWD2qHDuDXwCh3cLogsRcnaTAP41YxnmN3CB9sEdHMvXHNhLGau
         26e5fXXrFb2lQx3F819Uv6tAiSQmtwfJYe0PcOplf5d68hULTJ0OgHyoKeGW6KsuOvFE
         UIgizN8x8Sn7LIiLkKPbwKl6ZX0tXLspmN8Ci10KcZtAfyKeGIeqp0lW/04XodqNKHxk
         sn7Su3Demr19ANtDJXHPX+a00MBBWmxxERXPj9brR2wVkvo/cX1+yv8lxvChkQrIx617
         mbsQ==
X-Gm-Message-State: ACgBeo0LFasCYRKzTgqgUCHmp0xgS5YX/o4V8hdmOSYYvqa7pGfYqgy1
        w+t6E7ze4Ss9O+mM+JCBJ9UIw2F/qw==
X-Google-Smtp-Source: AA6agR4NrawCOqPWC6pOdWwNu471s80KRbfcN+j8Jq3jUxNPXYFC7pYpWjcXkV+7PgvXTxeCXJ7gCF+xbA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:b8f6:52b8:6a74:6073])
 (user=elver job=sendgmr) by 2002:a05:6402:428a:b0:42e:8f7e:1638 with SMTP id
 g10-20020a056402428a00b0042e8f7e1638mr19083589edc.228.1660659946902; Tue, 16
 Aug 2022 07:25:46 -0700 (PDT)
Date:   Tue, 16 Aug 2022 16:25:29 +0200
Message-Id: <20220816142529.1919543-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] kfence: free instead of ignore pool from kmemleak
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Max Schulze <max.schulze@online.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yee Lee <yee.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to recent changes to kmemleak and how memblock allocated memory is
stored in the phys object tree of kmemleak, 07313a2b29ed ("mm: kfence:
apply kmemleak_ignore_phys on early allocated pool") tried to fix KFENCE
compatibility.

KFENCE's memory can't simply be ignored, but must be freed completely
due to it being handed out on slab allocations, and the slab post-alloc
hook attempting to insert the object to the kmemleak object tree.

Without this fix, reports like the below will appear during boot, and
kmemleak is effectively rendered useless when KFENCE is enabled:

 | kmemleak: Cannot insert 0xffffff806e24f000 into the object search tree (overlaps existing)
 | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-v8-0815+ #5
 | Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
 | Call trace:
 |  dump_backtrace.part.0+0x1dc/0x1ec
 |  show_stack+0x24/0x80
 |  dump_stack_lvl+0x8c/0xb8
 |  dump_stack+0x1c/0x38
 |  create_object.isra.0+0x490/0x4b0
 |  kmemleak_alloc+0x3c/0x50
 |  kmem_cache_alloc+0x2f8/0x450
 |  __proc_create+0x18c/0x400
 |  proc_create_reg+0x54/0xd0
 |  proc_create_seq_private+0x94/0x120
 |  init_mm_internals+0x1d8/0x248
 |  kernel_init_freeable+0x188/0x388
 |  kernel_init+0x30/0x150
 |  ret_from_fork+0x10/0x20
 | kmemleak: Kernel memory leak detector disabled
 | kmemleak: Object 0xffffff806e24d000 (size 2097152):
 | kmemleak:   comm "swapper", pid 0, jiffies 4294892296
 | kmemleak:   min_count = -1
 | kmemleak:   count = 0
 | kmemleak:   flags = 0x5
 | kmemleak:   checksum = 0
 | kmemleak:   backtrace:
 |      kmemleak_alloc_phys+0x94/0xb0
 |      memblock_alloc_range_nid+0x1c0/0x20c
 |      memblock_alloc_internal+0x88/0x100
 |      memblock_alloc_try_nid+0x148/0x1ac
 |      kfence_alloc_pool+0x44/0x6c
 |      mm_init+0x28/0x98
 |      start_kernel+0x178/0x3e8
 |      __primary_switched+0xc4/0xcc

Reported-by: Max Schulze <max.schulze@online.de>
Fixes: 07313a2b29ed ("mm: kfence: apply kmemleak_ignore_phys on early allocated pool")
Fixes: 0c24e061196c ("mm: kmemleak: add rbtree and store physical address for objects allocated with PA")
Signed-off-by: Marco Elver <elver@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yee Lee <yee.lee@mediatek.com>
---

Note: This easily reproduces on v5.19, but on 6.0-rc1 the issue is
hidden by yet more kmemleak changes, but properly freeing the pool is
the correct thing to do either way, given the post-alloc slab hooks.
---
 mm/kfence/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index c252081b11df..9e52f2b87374 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -617,12 +617,13 @@ static bool __init kfence_init_pool_early(void)
 
 	if (!addr) {
 		/*
-		 * The pool is live and will never be deallocated from this point on.
-		 * Ignore the pool object from the kmemleak phys object tree, as it would
-		 * otherwise overlap with allocations returned by kfence_alloc(), which
-		 * are registered with kmemleak through the slab post-alloc hook.
+		 * The pool is live and will never be deallocated from this
+		 * point on. Remove the pool object from the kmemleak phys
+		 * object tree, as it would otherwise overlap with allocations
+		 * returned by kfence_alloc(), which are registered with
+		 * kmemleak through the slab post-alloc hook.
 		 */
-		kmemleak_ignore_phys(__pa(__kfence_pool));
+		kmemleak_free_part_phys(__pa(__kfence_pool), KFENCE_POOL_SIZE);
 		return true;
 	}
 
-- 
2.37.1.595.g718a3a8f04-goog

