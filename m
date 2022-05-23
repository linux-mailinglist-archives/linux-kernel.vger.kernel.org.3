Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3983C5312EF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbiEWOwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237284AbiEWOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:52:01 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2A728E0E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:51:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653317516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PDuBGpkT9ArerlP1XBDcRGRfZ28TAQhMJtn5mwFKc7M=;
        b=pT6NCGz1IFsXBIrDvwCoik1ZV8eldYrPZNWLkNKH+lo2SU9YYNuxj+hKHhZzXVUuMbNE7n
        ZF4FDr2WOm/hifRLWsWleJR17juhKvG0QhW1QsaM8mahfr7jYAM/cXWMiE1g2eigcue0lZ
        MzJ4QmeUBjvLQqZBs4OSwm+Y//LCyxU=
From:   andrey.konovalov@linux.dev
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 2/2] arm64: stacktrace: use non-atomic __set_bit
Date:   Mon, 23 May 2022 16:51:52 +0200
Message-Id: <23dfa36d1cc91e4a1059945b7834eac22fb9854d.1653317461.git.andreyknvl@google.com>
In-Reply-To: <c4c944a2a905e949760fbeb29258185087171708.1653317461.git.andreyknvl@google.com>
References: <c4c944a2a905e949760fbeb29258185087171708.1653317461.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Use the non-atomic version of set_bit() in arch/arm64/kernel/stacktrace.c,
as there is no concurrent accesses to frame->prev_type.

This speeds up stack trace collection and improves the boot time of
Generic KASAN by 2-5%.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 33e96ae4b15f..03593d451b0a 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -103,7 +103,7 @@ static int notrace unwind_frame(struct task_struct *tsk,
 		if (fp <= frame->prev_fp)
 			return -EINVAL;
 	} else {
-		set_bit(frame->prev_type, frame->stacks_done);
+		__set_bit(frame->prev_type, frame->stacks_done);
 	}
 
 	/*
-- 
2.25.1

