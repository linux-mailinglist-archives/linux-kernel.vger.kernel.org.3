Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A61353D5D3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 08:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiFDGfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 02:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiFDGfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 02:35:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED1015730
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 23:35:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7B4C60C3B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 06:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A87FC385B8;
        Sat,  4 Jun 2022 06:35:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jWqnFpzn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654324534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tpJWzwngsNVV+AemIsdXlOzVaecqFNTk6LE17WckmtA=;
        b=jWqnFpznLw1T82pnA3SizMJwOVFVAT4thBw1FtplrAJNg5kigFnohKlUnSW+HTowyekTP0
        VxUTh61t/Gi9nqSSImvs2r1c8FgLrhvpeOt0blNu1i55nDULjqkNXrDcA9D7H53aOl9Mx6
        D/fwG/iBmzYsS+qujC3k26jbablEgQE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5b4ed355 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 4 Jun 2022 06:35:33 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     chenhuacai@kernel.org, kernel@xen0n.name,
        linux-kernel@vger.kernel.org, arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] LoongArch: Remove MIPS comment about cycle counter
Date:   Sat,  4 Jun 2022 08:35:25 +0200
Message-Id: <20220604063525.397826-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This comment block was taken originally from the MIPS architecture code,
where indeed there are particular assumptions one can make regarding SMP
and !SMP and cycle counters. On LoongArch, however, the rdtime family of
functions is always available. As Xuerui wrote:

    The rdtime family of instructions is in fact guaranteed to be
    available on LoongArch; LoongArch's subsets all contain them, even
    the 32-bit "Primary" subset intended for university teaching -- they
    provide the rdtimeh.w and rdtimel.w pair of instructions that access
    the same 64-bit counter.

So this commit simply removes the incorrect comment block.

Link: https://lore.kernel.org/lkml/e78940bc-9be2-2fe7-026f-9e64a1416c9f@xen0n.name/
Fixes: b738c106f735 ("LoongArch: Add other common headers")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/loongarch/include/asm/timex.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/loongarch/include/asm/timex.h b/arch/loongarch/include/asm/timex.h
index d3ed99a4fdbd..fb41e9e7a222 100644
--- a/arch/loongarch/include/asm/timex.h
+++ b/arch/loongarch/include/asm/timex.h
@@ -12,13 +12,6 @@
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
 
-/*
- * Standard way to access the cycle counter.
- * Currently only used on SMP for scheduling.
- *
- * We know that all SMP capable CPUs have cycle counters.
- */
-
 typedef unsigned long cycles_t;
 
 #define get_cycles get_cycles
-- 
2.35.1

