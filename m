Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33E45B2425
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiIHRCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiIHRBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:01:52 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16509E125E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:01:47 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id cr9so13358937qtb.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=kCW6OcN0pl+wFvB/FVB267qWfLr3bPZPC77P/PSoNKI=;
        b=qAlOqbpJ7NWTsm9b6eVY+EChiOgfKnMcaIcW07s0VZHLwopF0OLSVYjXmSNsVd31ey
         emvhwfkQHdEQEE1Ys9Xzblma3jKDHFudXhbWPqeGTwb+nWJziyc41YCXOFxd1tlG4Y2+
         cC1J9Pwe8bVUOGW4QaHqePRBP85g3daBVo0vLqmU6+TvdhdHb4k7zUcGviGDc4+CZP2y
         huBB+HbYAkOxyiyYbn9btAMZVx4p2/x1LUuMCmjuBovv3MNNoxSEljXay1UQHORvcRFV
         a2mYWIZVmQIycIOxvzX1HlBEqhBwduYVqzvDkhxE74NDo7FSQyJfBSX2MtQFftqeRs8q
         suQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kCW6OcN0pl+wFvB/FVB267qWfLr3bPZPC77P/PSoNKI=;
        b=0wOolFLiTk41MIG8tdE+5lbNzXTwMA2nE1L/uaV3Ti71MPNHkHeuWoFE0kIlJWwdoU
         cWTxIXQ66pCUWZFnjkofipHSp42dZj//ojP3AVlRHhCr4s/pUim6+IISzjYlxYnt9oOv
         ZiWfF3kGpVzbgvQY8/CDihRpKhLJtwhz/yJp1QcDGpkeWfelRGvZ0AhPvpNkv6lVHLfc
         GYB2jj5X22YF5hs89K6B+heUAwz8QGBfZLprnYnVNY5xF0XL3XJU8OdnHuz+2DcDAWE1
         UyZDGOj8tqwbfo5bx+10hRK+deHB9b26MLroUgcnhff1ct621C4LXrQ9CsL83XCP2JAZ
         Bnsw==
X-Gm-Message-State: ACgBeo2XxIw8/NJ5UVhZqQeZf67RONAzdl9cpuf/MBQ8JbdJs8g1w1up
        x926iSgxG7st3+a32MyCUj3SaA==
X-Google-Smtp-Source: AA6agR72zd1h4G/5DJUMkfaYL57NMZfCX1GCn2mR7eqXWKf0L2XnPoEMFqd7uWJprchY3j4mWP6/2Q==
X-Received: by 2002:ac8:5dcf:0:b0:343:7ded:7b with SMTP id e15-20020ac85dcf000000b003437ded007bmr8601868qtx.492.1662656506059;
        Thu, 08 Sep 2022 10:01:46 -0700 (PDT)
Received: from abrestic-xps.ba.rivosinc.com (pool-71-105-112-35.nycmny.fios.verizon.net. [71.105.112.35])
        by smtp.gmail.com with ESMTPSA id w17-20020a05620a445100b006b8fb2a1145sm17714452qkp.124.2022.09.08.10.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 10:01:45 -0700 (PDT)
From:   Andrew Bresticker <abrestic@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH] riscv: Allow PROT_WRITE-only mmap()
Date:   Thu,  8 Sep 2022 13:01:33 -0400
Message-Id: <20220908170133.1159747-1-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.25.1
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

Commit 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is
invalid") made mmap() return EINVAL if PROT_WRITE was set wihtout
PROT_READ with the justification that a write-only PTE is considered a
reserved PTE permission bit pattern in the privileged spec. This check
is unnecessary since RISC-V defines its protection_map such that PROT_WRITE
maps to the same PTE permissions as PROT_WRITE|PROT_READ, and it is
inconsistent with other architectures that don't support write-only PTEs,
creating a potential software portability issue. Just remove the check
altogether and let PROT_WRITE imply PROT_READ as is the case on other
architectures.

Fixes: 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is invalid")
Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
 arch/riscv/kernel/sys_riscv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 571556bb9261..5d3f2fbeb33c 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -18,9 +18,6 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
-	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
-		return -EINVAL;
-
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
 }
-- 
2.25.1

