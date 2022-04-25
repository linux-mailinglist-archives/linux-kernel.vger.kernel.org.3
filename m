Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1B050DF8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbiDYMA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbiDYL7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:59:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 078E56422
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:56:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8A04113E;
        Mon, 25 Apr 2022 04:56:22 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7120A3F73B;
        Mon, 25 Apr 2022 04:56:21 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-arm-kernel@lists.infradead.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH 6/8] stackleak: remove redundant check
Date:   Mon, 25 Apr 2022 12:56:01 +0100
Message-Id: <20220425115603.781311-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425115603.781311-1-mark.rutland@arm.com>
References: <20220425115603.781311-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __stackleak_erase() we check that the `erase_low` value derived from
`current->lowest_stack` is above the lowest legitimate stack pointer
value, but this is already enforced by stackleak_track_stack() when
recording the lowest stack value.

Remove the redundant check.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 kernel/stackleak.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index f597d3323729d..ba346d46218f5 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -79,10 +79,6 @@ static __always_inline void __stackleak_erase(void)
 	unsigned int poison_count = 0;
 	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
 
-	/* Check that 'lowest_stack' value is sane */
-	if (unlikely(erase_low - task_stack_low >= THREAD_SIZE))
-		erase_low = task_stack_low;
-
 	/* Search for the poison value in the kernel stack */
 	while (erase_low > task_stack_low && poison_count <= depth) {
 		if (*(unsigned long *)erase_low == STACKLEAK_POISON)
-- 
2.30.2

