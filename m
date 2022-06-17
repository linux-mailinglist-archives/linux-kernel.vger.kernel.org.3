Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F99154F160
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380204AbiFQHGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380330AbiFQHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:06:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B50B6006C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:06:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x4so3438769pfj.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rtNddg8+QR7i3/tqYYzEhkG55nHCGbEucwWJ0AzfxSY=;
        b=Y3Ikp1g3yXZryhp2RN3/d/ZQz2VkG9Sg8fgoWH6JRf2HFKVC6tNNx9Pv7JTbKCWr6r
         0xBJ77YN7pfONa+9Hs/W6SVxVtMEoQ/+9fJZT51QNovBNoK0qeWib1Fu9bKoOBv9Mvgd
         M3RovELRnuXDCp48MIhKVMP2IMn4RUa5a1/4wr+3i3k8J63jJf8O3eHUI9l9q/t7E3dF
         HEORQSEZm2AHlS5MbPd4jho75QGyPwdoMUGRilokh9EpJhHfRSxdrVaHjbuQl2VWqk+J
         y1f7wHrCxJC9h/X9KlBo4ooC3JaFY/58aDIMSkznEBHgZ3AwJQUpD4L7bYvrPIXK22bZ
         Z12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rtNddg8+QR7i3/tqYYzEhkG55nHCGbEucwWJ0AzfxSY=;
        b=MZd71xk1o7enPEWZFACVKQhYEHJWbUqN6mW0rAmoN6T2moBzAqW4Tk90gJ1R1ek2TB
         vKaJdQ+PhtpE+0XoB6e8N27h9bzhjrUxHcodbOMEzYElFJvWkM6VzG774CSajRKYkGdn
         ns+S/B6Afn7HhPfLuoX73WRDFQN7vdQFJchNVP/BPXkM5T0FS9YM3P7RafCGLQcUWaVD
         KwOwNDIQ6rBYaSZwggyYifuf6KJJe0ACbdC8ZcguwFauUu4STCZMhTVHalOxzPF6HaSn
         N7ZCTzBPp82JGuOE3PYqOvLFI2RropZ5DZVxDkg48ApnSVupPuO6Ji1qiVPB5yE7GCbv
         0olw==
X-Gm-Message-State: AJIora+Vi8TKHwt+BiGw1bFtzKa6qtcTFhqaxBGw+EAeWPil9nfFlVHE
        eNJFgbnHZ3F0VO80tODBUfFs6z0B4qZYLF2c
X-Google-Smtp-Source: AGRyM1uh5RH5fUU2TfkQKcXpEKfQHxSECH3JtIM2R0gAvOptpcEOcZuljlHoaBgseEZvPx4NRx+xkA==
X-Received: by 2002:a63:77cc:0:b0:408:e3bc:6294 with SMTP id s195-20020a6377cc000000b00408e3bc6294mr7747507pgc.154.1655449566551;
        Fri, 17 Jun 2022 00:06:06 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902d64b00b00161955fe0d5sm2743670plh.274.2022.06.17.00.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 00:06:06 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, huzhanyuan@oppo.com,
        Barry Song <v-songbaohua@oppo.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Shaohua Li <shli@kernel.org>
Subject: [RFC PATCH] mm: rmap: Don't flush TLB after checking PTE young for page reference
Date:   Fri, 17 Jun 2022 19:05:55 +1200
Message-Id: <20220617070555.344368-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Barry Song <v-songbaohua@oppo.com>

Flushing TLB is usually quite expensive through hardware or software.
Both x86 and arm64 have tried to decrease the overhead by either
removing TLB flush and deferring it in ptep_clear_flush_young().

Removing the tlb flush gives about 20% ~ 30% swapout speedup on x86
according to commit b13b1d2d8692b ("x86/mm: In the PTE swapout page
reclaim case clear the accessed bit instead of flushing the TLB").

Similar result was also reported on arm64 by commit 3403e56b41c1("
arm64: mm: Don't wait for completion of TLB invalidation when page
aging").

While platforms like x86 and arm64 have noticed the problem and
resolved it by modifying ptep_clear_flush_young() to drop flush
by some means, most platforms are still doing TLB flush. In LRU,
it seems pointless to do TLB broadcast simply because of update
access bit.

Dropping flush in general LRU code seems be a proper way than
removing TLB flush in ptep_clear_flush_young() in all kind of
platforms as the name of the function is implying flush should
be included. Removing flush in a function who is named by flush
sounds vague. So this patch moves to ptep_clear_young_notify()
clearly without flush in LRU code.

This will help decrease the cost of TLB broadcast due to access
bit in LRU. The side effect is some minor lose in the accuracy
of PTE young data, but this has been proven to be not harmful
by those mainstream platforms like x86 and arm64.

Cc: Yu Zhao <yuzhao@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: Alex Van Brunt <avanbrunt@nvidia.com>
Cc: Shaohua Li <shli@kernel.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 This RFC is inspired by the discussion in Yu Zhao's MGLRU:
 https://lore.kernel.org/lkml/CAOUHufYvH2LaGyAJZFQNOsGDBKD2++aFnTV6=qaVtcNrKjS_bA@mail.gmail.com/

 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 5bcb334cd6f2..7ce6f0b6c330 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -830,7 +830,7 @@ static bool folio_referenced_one(struct folio *folio,
 		}
 
 		if (pvmw.pte) {
-			if (ptep_clear_flush_young_notify(vma, address,
+			if (ptep_clear_young_notify(vma, address,
 						pvmw.pte)) {
 				/*
 				 * Don't treat a reference through
-- 
2.25.1

