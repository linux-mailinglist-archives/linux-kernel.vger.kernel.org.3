Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B764F0D15
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 01:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376740AbiDCXyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 19:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiDCXyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 19:54:11 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304853878E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 16:52:17 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c2so6933249pga.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 16:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnxVFLHekOunLtWoWlKj8zJBbrok1zNY71HOhIA5VLo=;
        b=h1wuTbzfBbOsaQ8zE5QA8LCpBtZ1Hce3UXsIXzo1B/3iG/5mu/rQF1Ik3zyIbg9MiG
         6K01wodbxSsbULqeK0a+idZPqasVp5/mTTU8jzeghj7zCpFv8912e+2bkwQP4xjfJajO
         Fbxtujqq3nMtIbwPf5p7g9/h8zlMz11LmyKuUt1BGZJWQSf2DwxX+/NchFm2ZEp80LQU
         gtNt+4i5Dp2mDmB/LUGUwXxPeJqObJfXT5i77TbHjvUseu5XHRRV5C8d95nQVGYeO5M3
         gVBNGEjvMqOMNl9Dqxp7UDCEQtJw44sOhwNJ0DBLt9jwj+Hz3qyB4havcHY5bMin7u27
         KBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnxVFLHekOunLtWoWlKj8zJBbrok1zNY71HOhIA5VLo=;
        b=78BW7huem8eTt6vJdpszcBxewMHpadhoE+b7bfM67k8xEt92yQebkBn6vOtnG7Yi+y
         T3xsaqq43YYQnnUyWt5haeEazHgTaeZDXHJ4MM1p6jWjNA4mjQx3ki6GoxY8LOEmpGia
         TAfRynJKC0JB+LzX0bWvFCkIICPBl9dnS39zMpuoYCImeLStOnd8VkYmhcRGYfRBorbj
         ifUs7rvisEuVJJfYdSSH3Hc1z8QpxJBm2h1LLbRO1I69kctAq5dHe2LTOgDEITf1ow+Y
         dt+AXXXV4UkYoMrvllHtGvJyHOR7xsgMpwORiwF0gE1gT6NcvcdwNmBempl8/wZBrkm+
         osBA==
X-Gm-Message-State: AOAM532EChprSqCN+vZcgL9NJb5R3IOAXkDah7aPXfgRXtoCJ7Wmujz9
        973XKsydmnmoU8/1s/jx7kyVR2OA+yk=
X-Google-Smtp-Source: ABdhPJx0X1oiRABWDciIM9Dn/oUkVnyHhiYKy0/X8Aw3CetecnyuaBA+wneyVoZkDN9jqQvT9ahY0A==
X-Received: by 2002:a05:6a00:1581:b0:4fa:e6d4:c3e6 with SMTP id u1-20020a056a00158100b004fae6d4c3e6mr21063889pfk.84.1649029936590;
        Sun, 03 Apr 2022 16:52:16 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:98f7:b9d3:817b:7621])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b004faef351ebcsm9789697pfk.45.2022.04.03.16.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 16:52:15 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] highmem: fix checks in __kmap_local_sched_{in,out}
Date:   Sun,  3 Apr 2022 16:51:59 -0700
Message-Id: <20220403235159.3498065-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DEBUG_KMAP_LOCAL is enabled __kmap_local_sched_{in,out}
check that even slots in the tsk->kmap_ctrl.pteval are unmapped. The
slots are initialized with 0 value, but the check is done with pte_none.
0 pte however does not necessarily mean that pte_none will return true.
e.g. on xtensa it returns false, resulting in the following runtime
warnings:

 WARNING: CPU: 0 PID: 101 at mm/highmem.c:627 __kmap_local_sched_out+0x51/0x108
 CPU: 0 PID: 101 Comm: touch Not tainted 5.17.0-rc7-00010-gd3a1cdde80d2-dirty #13
 Call Trace:
   dump_stack+0xc/0x40
   __warn+0x8f/0x174
   warn_slowpath_fmt+0x48/0xac
   __kmap_local_sched_out+0x51/0x108
   __schedule+0x71a/0x9c4
   preempt_schedule_irq+0xa0/0xe0
   common_exception_return+0x5c/0x93
   do_wp_page+0x30e/0x330
   handle_mm_fault+0xa70/0xc3c
   do_page_fault+0x1d8/0x3c4
   common_exception+0x7f/0x7f

 WARNING: CPU: 0 PID: 101 at mm/highmem.c:664 __kmap_local_sched_in+0x50/0xe0
 CPU: 0 PID: 101 Comm: touch Tainted: G        W         5.17.0-rc7-00010-gd3a1cdde80d2-dirty #13
 Call Trace:
   dump_stack+0xc/0x40
   __warn+0x8f/0x174
   warn_slowpath_fmt+0x48/0xac
   __kmap_local_sched_in+0x50/0xe0
   finish_task_switch$isra$0+0x1ce/0x2f8
   __schedule+0x86e/0x9c4
   preempt_schedule_irq+0xa0/0xe0
   common_exception_return+0x5c/0x93
   do_wp_page+0x30e/0x330
   handle_mm_fault+0xa70/0xc3c
   do_page_fault+0x1d8/0x3c4
   common_exception+0x7f/0x7f

Fix it by replacing !pte_none(pteval) with pte_val(pteval) != 0.

Fixes: 5fbda3ecd14a ("sched: highmem: Store local kmaps in task struct")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 mm/highmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index 762679050c9a..916b66e0776c 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -624,7 +624,7 @@ void __kmap_local_sched_out(void)
 
 		/* With debug all even slots are unmapped and act as guard */
 		if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL) && !(i & 0x01)) {
-			WARN_ON_ONCE(!pte_none(pteval));
+			WARN_ON_ONCE(pte_val(pteval) != 0);
 			continue;
 		}
 		if (WARN_ON_ONCE(pte_none(pteval)))
@@ -661,7 +661,7 @@ void __kmap_local_sched_in(void)
 
 		/* With debug all even slots are unmapped and act as guard */
 		if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL) && !(i & 0x01)) {
-			WARN_ON_ONCE(!pte_none(pteval));
+			WARN_ON_ONCE(pte_val(pteval) != 0);
 			continue;
 		}
 		if (WARN_ON_ONCE(pte_none(pteval)))
-- 
2.30.2

