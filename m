Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC424ED638
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiCaIwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiCaIvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:51:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288EF47547
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:49:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3215BB82005
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C72C340F3;
        Thu, 31 Mar 2022 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648716594;
        bh=mhNQddazJ57El0uDfD+vnjahyTMel63pDkcF/sZlYJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUKrG6KbH+d6+/fi/GJcPOEQ04Us+14PmaAuJ1LOSr/dR/AX2stY96oA5srZE7fjC
         M/2JDAssLyDltKcpn+PoFYajJz9u1p6h3ttCjJfTEnkfr6qIojs7SIE0yzY9KVzcB0
         s6cGHyKL80oBdtysj05KGEPVUOjOVAWes8uq5W6ldByvKKBFCZgFwzh4ewPp+ztoqu
         YAfX9on6rUCX1Bmy77iQb1HjToi3XrzCcxQPnyzcxTIJ3dMZSbRRJUnIS83nYcUSd3
         U5vSD29IRUPUHDeNC6N/EW4Y9kN6BAtxhsXH+jy6gHaL62RoVqzVERkeH2G993Vrly
         8rz5OQePku/nQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     andreyknvl@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH for-mm 2/3] arch/arm64/kernel/irq: Include missed header file
Date:   Thu, 31 Mar 2022 08:49:38 +0000
Message-Id: <20220331084939.26749-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220331084939.26749-1-sj@kernel.org>
References: <20220331084939.26749-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit da4561bd9c6b ("arm64, scs: save scs_sp values per-cpu when
switching stacks") of -mm is moving declaration of
irq_shadow_call_stack_ptr to scs.h of arm64 for !SHADOW_CALL_STACK, but
didn't include it in irq.c of arm64.  As a result, we show below build
error when SHADOW_CALL_STACK is unset.

    linux/arch/arm64/kernel/irq.c: In function 'init_irq_scs':
    linux/arch/arm64/kernel/irq.c:44:11: error: 'irq_shadow_call_stack_ptr' undeclared (first use in this function)
       44 |   per_cpu(irq_shadow_call_stack_ptr, cpu) =
          |           ^~~~~~~~~~~~~~~~~~~~~~~~~

This commit fixes the build error by including the header file.

[1] https://lore.kernel.org/all/f75c58b17bfaa419f84286cd174e3a08f971b779.1648049113.git.andreyknvl@google.com/

Fixes: da4561bd9c6b ("arm64, scs: save scs_sp values per-cpu when switching stacks") of -mm
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 arch/arm64/kernel/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 4199f900714a..9f7de9d5ee9b 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -20,6 +20,7 @@
 #include <linux/scs.h>
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
+#include <asm/scs.h>
 #include <asm/daifflags.h>
 #include <asm/vmap_stack.h>
 
-- 
2.17.1

