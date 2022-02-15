Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0144B75C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243191AbiBOSoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:44:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241980AbiBOSoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:44:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE3527FF6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:43:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29456616C7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C250FC340EC;
        Tue, 15 Feb 2022 18:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644950633;
        bh=jVE2UPwQbGumrX229wqA975K+AttmZ9p0pF/nvpok9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=SRhqgjz47Z9NvbRe3aKfoY+SUjDETfnk4XZJxkkyoh9YYzrgdktOTgRbgfT75inLW
         Pasx0y++4oWIo5MUdNNH+FbuGbMAFsdDLPHxo+sfO1H2RjX9LQKa4dRZusD6SRDEhq
         I7xfG4nUoW/Lq2Ge5F08+EwLr6unbd6cFofQ+Lh2o7Aywm0a7JZEdgX84npyygGkTN
         M3jTDum3/wUjb9BQIGg9EO4TD+io7PxDGaDAmFkTMdjngJjPslzVdfVebCjCD0ytyr
         ljQ2Q9/cymblwFUceu7qvDG8YxyD2s4XnitPHG5M5d/+/ACa2Fa20hD1ylmRp7VLUf
         y1LrBtwqrKcoQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH] mm/page_alloc: Mark pagesets as __maybe_unused
Date:   Tue, 15 Feb 2022 11:43:22 -0700
Message-Id: <20220215184322.440969-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9983a9d577db ("locking/local_lock: Make the empty local_lock_*()
function a macro.") in the -tip tree converted the local_lock_*()
functions into macros, which causes a warning with clang with
CONFIG_PREEMPT_RT=n + CONFIG_DEBUG_LOCK_ALLOC=n:

  mm/page_alloc.c:131:40: error: variable 'pagesets' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
  static DEFINE_PER_CPU(struct pagesets, pagesets) = {
                                         ^
  1 error generated.

Prior to that change, clang was not able to tell that pagesets was
unused in this configuration because it does not perform cross function
analysis in the frontend. After that change, it sees that the macros
just do a typecheck on the lock member of pagesets, which is evaluated
at compile time (so the variable is technically "used"), meaning the
variable is not needed in the final assembly, as the warning states.

Mark the variable as __maybe_unused to make it clear to clang that this
is expected in this configuration so there is no more warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/1593
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7ff1efc84205..406f5d0c610f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -128,7 +128,7 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 struct pagesets {
 	local_lock_t lock;
 };
-static DEFINE_PER_CPU(struct pagesets, pagesets) = {
+static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused = {
 	.lock = INIT_LOCAL_LOCK(lock),
 };
 

base-commit: 10a64d66e319e6ea3a19f9d2e7c4f0dee90ce6e0
-- 
2.35.1

