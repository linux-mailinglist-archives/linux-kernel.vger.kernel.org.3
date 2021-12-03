Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8187046715C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349188AbhLCFOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245643AbhLCFOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:14:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7FC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 21:10:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41B5FB825B7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3BCC53FAD;
        Fri,  3 Dec 2021 05:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638508236;
        bh=Z9O0bsmRr34zqnd3Uvp4s5rM+blcuSgXDGFFVFUQkew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mr8jPQDEGXl+QN1k4OfnoglcVkDl2396AfCef8Jh2ewQWSdAg9Z7TRd9Tk1RZ8UnU
         EMyg9YIbn8xq7RapjYOw9sOyUfhffUG6DI6RmFkzPPR6dEiCiA2XkZtFAiQr8Mx9+k
         qQgnAHE5qPyVSfrt/mCW4IctFnd4eNH/gC6XW59lKLuIoS7V0R6RD8JPNX4mwyo1di
         fk1XWRg2MJ7vFQMp6+kFTNF8Ynk6FkcXdgLcOgPpjqE9vyAub2wUXLJgje40Pp1lwQ
         IaEY5uoWja9oar1QWrzVMjtl7TVd/Jb2vCwjltneZdVD9hGRjPwZoZk783qJeGZF8J
         WXDPZcq95/BJA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] riscv: mm: init: remove _pt_ops and use pt_ops directly
Date:   Fri,  3 Dec 2021 13:03:15 +0800
Message-Id: <20211203050317.2102-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203050317.2102-1-jszhang@kernel.org>
References: <20211203050317.2102-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except "pt_ops", other global vars when CONFIG_XIP_KERNEL=y is defined
as below:

|foo_type foo;
|#ifdef CONFIG_XIP_KERNEL
|#define foo	(*(foo_type *)XIP_FIXUP(&foo))
|#endif

Follow the same way for pt_ops to unify the style and to simplify code.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index bd445ac778a8..4d4fcd7ef1a9 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -227,12 +227,10 @@ static void __init setup_bootmem(void)
 }
 
 #ifdef CONFIG_MMU
-static struct pt_alloc_ops _pt_ops __initdata;
+static struct pt_alloc_ops pt_ops __initdata;
 
 #ifdef CONFIG_XIP_KERNEL
-#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&_pt_ops))
-#else
-#define pt_ops _pt_ops
+#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&pt_ops))
 #endif
 
 unsigned long riscv_pfn_base __ro_after_init;
-- 
2.34.1

