Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE58850D14C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiDXKva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbiDXKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:51:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C71E17D496
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:48:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dk23so1099006ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ifhTT6RWFXDH8HUEGtKLOt2yTklDAIxczpprS6iV9sg=;
        b=n55X0jCN3rd+35JSwnUSgh9WdYBxyYC0C/eVbUYHLd6G/I6dl3R66sgt7bEARIfGPa
         U92qMQviohsxEm8dzT6VPNZAOWPWPkmkagUDnTXNEahjzw0aG1oXAZvj+PL5VLH+k6W7
         Raogl5ajpBl4qazS8tw3BSG+K91ZsMchhewqdP2+R4NlVa+C3SEM1/7YXBrVsbW1cDpw
         G7ofklYP3B9U9CJKYXyNZXllYXfe1t7SSugAFpFbyF9PtSXVrOmlCArrgfsDbksCPs6p
         Q5G1HXk+YyEETVU2m7kWdTuzlcU4En35jAd5km5GeX1MOwcdWcCKqQuS7eCU+xYpnE04
         hlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ifhTT6RWFXDH8HUEGtKLOt2yTklDAIxczpprS6iV9sg=;
        b=iXpMTJuPU1zVhx+C/Zewr8KaC5hafUw8BBiLoZx7jpgGU6/o76bETiQCSJV1+PZXxP
         xehlA7ec49MkxPAVXPOUmg8wkSPiEWzMbBbj15B/lSb/kKZ1QjCbRi8OGa7JZCFxp2Qv
         cZjTYC+99ufeKMcjPTKA5ZXGfAMKE4WLWcYp3Ml00NXjoKLIP1r8EhNdoOuzG4zOaiyV
         /eqelOYS5YGwFdsKWj9fN2+AbIZvkfl5d2yR1J+2GQCNU9QTZPNK3oGyJcCvXzCYhjUl
         E/rvOExd7meGMXd66aB/KqLUD137WHN0JAd6vHxSlMOC6vQplkrj65m1k7enJCubHpWg
         3Cew==
X-Gm-Message-State: AOAM533ZOkl0rBLBsLKI7b8Q4glvuM5msuTpWm1OOKRwD18GyevLD7ul
        18cqvJhquVY3/rtlkEZH4f8=
X-Google-Smtp-Source: ABdhPJyLnX5s8GUwwVixgNEumHfZfhOyeKA+Mb3i/nZlf3WAx/M2bsxGm8F1BOaIVNiAJKwj/PVt9A==
X-Received: by 2002:a17:906:c116:b0:6f3:832f:3c8 with SMTP id do22-20020a170906c11600b006f3832f03c8mr3765451ejc.235.1650797291042;
        Sun, 24 Apr 2022 03:48:11 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709066d8800b006e09a49a713sm2488133ejt.159.2022.04.24.03.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 03:48:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [RFC PATCH] mm/highmem: VM_BUG_ON() if offset + len > PAGE_SIZE
Date:   Sun, 24 Apr 2022 12:48:06 +0200
Message-Id: <20220424104806.25396-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call VM_BUG_ON() if offset + len > PAGE_SIZE.

This is an RFC patch because I'm not sure if we actually need to BUG_ON(),
so I'd like to know what Maintainers and other developers think about this
proposal.

Please note that memset_page() uses VM_BUG_ON() to prevent the same issue.

Furthermore, I also cannot understand why memset_page() does not call
flush_dcache_page() after memset() but I suppose that the different
implementations of these two functions should be addressed in another RFC.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index c3d562b5f0c1..bdb16d5f8148 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -349,6 +349,8 @@ static inline void memcpy_to_page(struct page *page, size_t offset,
 static inline void memzero_page(struct page *page, size_t offset, size_t len)
 {
 	char *addr = kmap_local_page(page);
+
+	VM_BUG_ON(offset + len > PAGE_SIZE);
 	memset(addr + offset, 0, len);
 	flush_dcache_page(page);
 	kunmap_local(addr);
-- 
2.34.1

