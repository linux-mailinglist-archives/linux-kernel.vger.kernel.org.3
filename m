Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE695B262D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiIHSu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiIHSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:50:20 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0197EE512
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:50:12 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l5so13631035qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uAG7ulv3u8Y25koSZZsiniMQVBTMhkhOscGn2ifRLkY=;
        b=8WoRFZkMD3Ij/8DnQt4Z7AsLmwPoBQy64SVQIrUpqVI+xI5Dl5BiIL0Bi3/ZrqQlxe
         Ka+9wW8bkGx0BRbTK1551bdLodCTt4Uh6JykjgnuQrr7WA1JSXjuMtGZOo4rMWPXncTH
         mmin5qOTQVgJI77mZUg8qPQsbiyT6JNe5yicOqFc2ffckMiNVfozy1CSZNV9+VueuFjE
         YoqgkapQAWXqTkIIJ+e4c609h52nE4RPgrYdzdndBlDp7rJPheFY9VO/z04NnuBaV69S
         Id0p0PT7FfU9P2kq6uuv2zWGoO/dJ0g0pSOsKXgd/00n/OsyRU79xqiAIy9VUtRbk1GD
         s90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uAG7ulv3u8Y25koSZZsiniMQVBTMhkhOscGn2ifRLkY=;
        b=IEkuSP9BL1+1om8Fk6G7ddhPEJbu6PZZ+XuTIyyJBfMyI+/qUmYPGFVUzXXi5CsJVn
         +VDDVX+bOzcPVTin7HPGZTQS6OwPqPcWYFLOdXEuYhqdKWBL0GT+SepFUPVOsS5i7bw0
         hJizI263MnOJ6F7ul0kxTprRz6GRIiqjUD8h8LkHvlDUpQNTIAHZUj46jI92yjQBJtB4
         k+VTnW5LeFSStLD6n7avzo7nLawSxyFezRcnDpsXqwuqCLs5cse0FlMw9EiAn7NSz+xZ
         sbe7b1rCdKFKKSwPn8qlgF97NVsLZlVA2qCmxaL/mUk776BLFD/Zj4I95GhXly8VixcY
         0U1w==
X-Gm-Message-State: ACgBeo3zl/vQ/19hiAgkOJc7tfD09itESA6VF3exWhhioKcATe7dB6px
        K2XIY+xlwUbAX+SPCphh8VnG7Q==
X-Google-Smtp-Source: AA6agR46EWg/wwqjKx2a7Lq2jf5/fruCQbQ+V5iY3CMI11uCyd0j42+GeFE9aSfjGyYeUih5L+r/Zw==
X-Received: by 2002:a05:622a:11c6:b0:344:54b8:6382 with SMTP id n6-20020a05622a11c600b0034454b86382mr8762938qtk.571.1662663011004;
        Thu, 08 Sep 2022 11:50:11 -0700 (PDT)
Received: from abrestic-xps.ba.rivosinc.com (pool-71-105-112-35.nycmny.fios.verizon.net. [71.105.112.35])
        by smtp.gmail.com with ESMTPSA id z4-20020ac84544000000b00343057845f7sm14304453qtn.20.2022.09.08.11.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:50:10 -0700 (PDT)
From:   Andrew Bresticker <abrestic@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH v2] riscv: Make mmap() with PROT_WRITE imply PROT_READ
Date:   Thu,  8 Sep 2022 14:50:06 -0400
Message-Id: <20220908185006.1212126-1-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908170133.1159747-1-abrestic@rivosinc.com>
References: <20220908170133.1159747-1-abrestic@rivosinc.com>
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

Note that this also allows PROT_WRITE|PROT_EXEC mappings which were
disallowed prior to the aforementioned commit; PROT_READ is implied in
such mappings as well.

Fixes: 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is invalid")
Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
v1 -> v2: Update access_error() to account for write-implies-read
---
 arch/riscv/kernel/sys_riscv.c | 3 ---
 arch/riscv/mm/fault.c         | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

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
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index f2fbd1400b7c..d86f7cebd4a7 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -184,7 +184,8 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
 		}
 		break;
 	case EXC_LOAD_PAGE_FAULT:
-		if (!(vma->vm_flags & VM_READ)) {
+		/* Write implies read */
+		if (!(vma->vm_flags & (VM_READ | VM_WRITE))) {
 			return true;
 		}
 		break;
-- 
2.25.1

