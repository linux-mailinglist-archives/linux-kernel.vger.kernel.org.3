Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE341535EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349516AbiE0Kr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245161AbiE0Krx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:47:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF71AD
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:47:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v15so2480914edl.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E8hw1YxRdyFQiBunbdOQafA0vLjTqdy9/4gfOonLrFg=;
        b=cMw3nqupRwb9iJ0bAiEPeAgnOBYM1beNn1TObGXfHMIOMS1sTGGaToiA5nWxbTPG23
         7Bz8Tf9v6QAYxGl16dxbYfTSm7cMnx29cgprRiQll1k8U5uaKV9vxmnxwM/ichP5gcNC
         2MhV/Fgj+5yEwdzZBeNIph23msVCY1g5rCZhKgrErykccuFP7ubdDpN+0sMnTjuyAXgD
         WlQzdnKIlZD5ZXUjz2BiatWWlSOPzWc4K+AATgFhBrhSUWAhmb/cxMDw9moE2hFmKj7M
         tL+7T6Ejx28GCXKEAeHuZe351Sitn3HNDzC0SQ+cSYB/9oTan6ZNM36uDM5QH6P2nfo8
         yO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E8hw1YxRdyFQiBunbdOQafA0vLjTqdy9/4gfOonLrFg=;
        b=rSaXEa/CoWZaJxL28cytNr3yNsZbc1RlFG1zbkTCUnGWoyMFKWf6hqB9j05Hz+fdnv
         ZLUq2H8PFPL3zTxG6/NrjvvP4uwWSbYHdTYj4+qX3KKzn7BzSWs/V5m61UxpPx70uvdt
         W88/tVc6SDb2ILOR33/1DoS5VU0smiq9CuP0YZRIvD6yt0I5G3XVuE1A3SO5Jq0+XnZ0
         oveq2+JyFNgnm4Ufr3bWk9q/pGH0+/thhafqPvxMQ3W5hbcHTqgBa8weB5YU+1AwbWoa
         UbRzaz0i5y6xb7bStiq5GXcdJdSQW5YIG57FI2vlSbHxTjSVLRqvBMGv8keFIxD+s1XE
         A9YA==
X-Gm-Message-State: AOAM533QagcjufrFJp3jVhxKt69V9JBg/S3MEeYoFPlaqGniXhHS4sAJ
        bWN9y3LpK5SRE1PqlDl4CyE=
X-Google-Smtp-Source: ABdhPJyTYr0OkS3+nT4wN/g4MnpnJWE858fclOQNBvUdUSBEzGJbKuxqnWjjUb04IleiIrgnKZ+Spw==
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id ds1-20020a0564021cc100b004132b12fc49mr43833744edb.118.1653648471305;
        Fri, 27 May 2022 03:47:51 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id v4-20020a50a444000000b0042ab87ea713sm777389edb.22.2022.05.27.03.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:47:49 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 5148EA0293; Fri, 27 May 2022 12:48:18 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [PATCH 2/2] [PATCH 2/2] mm: add merging after mremap resize
Date:   Fri, 27 May 2022 12:48:10 +0200
Message-Id: <20220527104810.24736-3-matenajakub@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220527104810.24736-1-matenajakub@gmail.com>
References: <20220527104810.24736-1-matenajakub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mremap call results in expansion, it might be possible to merge the
VMA with the next VMA which might become adjacent. This patch adds
vma_merge call after the expansion is done to try and merge.

Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
---
 mm/mremap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 303d3290b938..c41237e62156 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/hugetlb.h>
 #include <linux/shm.h>
 #include <linux/ksm.h>
@@ -1022,8 +1023,11 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 				}
 			}
 
-			if (vma_adjust(vma, vma->vm_start, addr + new_len,
-				       vma->vm_pgoff, NULL)) {
+			vma = vma_merge(mm, vma, addr + old_len, addr + new_len,
+					vma->vm_flags, vma->anon_vma, vma->vm_file,
+					vma->vm_pgoff + (old_len >> PAGE_SHIFT), vma_policy(vma),
+					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			if (!vma) {
 				vm_unacct_memory(pages);
 				ret = -ENOMEM;
 				goto out;
-- 
2.35.1

