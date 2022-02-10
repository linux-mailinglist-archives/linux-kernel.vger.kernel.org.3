Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293064B0494
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 05:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiBJEoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 23:44:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiBJEoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:44:04 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874AD13E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 20:44:06 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id c14so3776969qvl.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 20:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=tykP6A+1QiN/WUxXun1yzu3aSQmRUSLJhXM2phvBN3Q=;
        b=Yhfics8+0BCXVT5QhAMpDcd67wSh80Ctx+hE7SLJh8Yk1NQ8d/ngD2uN1xSu3jdbKq
         GLp7I4iqXbDwkguGDSYwV0dXlUzfvewJ413sHF3cSHVyxxu+OxDnOS9WG+tfQxMjIOH/
         eBX9lpn1ZuP45ozLu0YUovHTZUGKKP4LJT1X1g63uJmIynGIeu+RpfDteCcQo0x0x8WU
         5Roit5DX2FlbImEeOEejzF/oP6/oceWtPOOMguSavzSc5wQROKWPCSDs8N+rdt467kaG
         EskAZLlrFpfG8olc3XZII9MCYk+Nv73jI094G5w95kB9bLCiPs7LLr2eFaDVl7kEraJf
         iOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=tykP6A+1QiN/WUxXun1yzu3aSQmRUSLJhXM2phvBN3Q=;
        b=CQKyoFDyPXPT/zMuuMHTf7OYzk2YEKmc6UZUDXTncVISRPVU9MRZRfqQLVwzvHHq3p
         LbIBq0ZDebPVi9Q9jEIUmlS3RCqqzhKfjPqUi65uGwbtwKUzELqPs6zbnFaf3a5AIV7j
         Fa/J0kSCyGZpXzm4QfKT3jQ+K5slGXYFINY4mMH9rDQW2VDAPeg5zp6zSHbtgsdUUQEx
         nalDdSpaek8VmwG3PiJ9bz04mDOTSVd59zBa6kptefiyhJ5RZnU8sGZ2uCDpMIUJLIJv
         hXBsIzQ3vxhV6y90nEBJ8UAqysdSgNOAw2a/KOnyO+pq8AXf3IfDHgq1AZJ93JAfiSJW
         qxRw==
X-Gm-Message-State: AOAM531wacnQdXxbs03XIOud+VGqpQ9/GnjkVP8fiTUtoOfZOZ2styJm
        2KR5szYRbOB6E1VZacBa/4oddQ==
X-Google-Smtp-Source: ABdhPJxZrrfE2d+GE8taLM2418X4thCCHbiRj+8fI5S001YY8xhXyTOSRsschiao9BsHJSfbQIYs9Q==
X-Received: by 2002:a05:6214:1bc7:: with SMTP id m7mr2415342qvc.37.1644468245514;
        Wed, 09 Feb 2022 20:44:05 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g11sm10299690qtg.49.2022.02.09.20.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 20:44:04 -0800 (PST)
Date:   Wed, 9 Feb 2022 20:44:02 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Hugh Dickins <hughd@google.com>, SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH for-mm 1/2 v2] mm/internal: Implement no-op mlock_page_drain()
 for !CONFIG_MMU
In-Reply-To: <CAMuHMdV7EaHK5zJAbLU9eKwMYxFdAQ0TiS+Ydg56mGkBv09dHA@mail.gmail.com>
Message-ID: <8eae6026-098-befb-92d3-b9ad2ad57776@google.com>
References: <20220209094158.21941-1-sj@kernel.org> <20220209094158.21941-2-sj@kernel.org> <715a8b2e-1048-c098-8b89-bcf3c13cbd75@google.com> <CAMuHMdV7EaHK5zJAbLU9eKwMYxFdAQ0TiS+Ydg56mGkBv09dHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

Commit 4b3b8bd6c8287 ("mm/munlock: mlock_page() munlock_page() batch by
pagevec") in -mm tree[1] implements 'mlock_page_drain()' under
CONFIG_MMU only, but the function is used by 'lru_add_drain_cpu()',
which defined outside of CONFIG_MMU.  As a result, below build error
occurs.

    /linux/mm/swap.c: In function 'lru_add_drain_cpu':
    /linux/mm/swap.c:637:2: error: implicit declaration of function 'mlock_page_drain' [-Werror=implicit-function-declaration]
      637 |  mlock_page_drain(cpu);
          |  ^~~~~~~~~~~~~~~~
    cc1: some warnings being treated as errors
    /linux/scripts/Makefile.build:289: recipe for target 'mm/swap.o' failed

This commit fixes it by implementing no-op 'mlock_page_drain()' for
!CONFIG_MMU case, similar to 'mlock_new_page()'.

[1] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-munlock-mlock_page-munlock_page-batch-by-pagevec.patch

[hughd: add need_mlock_page_drain() stub too]
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Hugh Dickins <hughd@google.com>
---
Andrew, Stephen, please add as fix to
mm-munlock-mlock_page-munlock_page-batch-by-pagevec.patch
Thanks!

 mm/internal.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/internal.h
+++ b/mm/internal.h
@@ -508,6 +508,8 @@ static inline void mlock_vma_page(struct page *page,
 static inline void munlock_vma_page(struct page *page,
 			struct vm_area_struct *vma, bool compound) { }
 static inline void mlock_new_page(struct page *page) { }
+static inline bool need_mlock_page_drain(int cpu) { return false; }
+static inline void mlock_page_drain(int cpu) { }
 static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
 {
 }
