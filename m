Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06A3529FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344604AbiEQKqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344616AbiEQKpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:45:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDA8326D8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:45:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v191-20020a1cacc8000000b00397001398c0so1120708wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbqWA0ma3Gj0jvWCSxtRNJBD3Bf6tu8RmToQD/S/1tA=;
        b=DbFwuJQo294/gbHi6rpEOZU7Bz8G1bkjIMoiFErEualQSecRSwmKf1I2+jZW9Z2kpu
         zBVu9cWLVGg/qgCYtp5WtCi23R9+i/eukUmUrAjhKuuHzpuiVzKj67SBAKNQTmStarsG
         cji3nj6EAMJWiT1Zh/7be54brEwpGjD5HPbEz2Wd3onKo0e8XxXp9IqAmVwqCb3Vq6+e
         CgAYJ4j1MuC+KdFWv3ABusFIBQ0l1g39ZCx6YtNXwVH0Sa5wvaC3V/2UUGF6Rj9e0A5b
         L/nnlvt5EB0IhTt3AJWuQqGZL9frRl1iSdijBdq9iBvdtf6BmnTUPndhbOw2PJom5nr3
         UlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbqWA0ma3Gj0jvWCSxtRNJBD3Bf6tu8RmToQD/S/1tA=;
        b=S2BPn2H3k54+UZmqHwAzYhqMOFW6mvbo3GtrONZKUR7/yl2VXjfTkYcU/30k2HtexJ
         fMwJZuv+DfUrVZjY1Y970LLQCWiB2J7eq07/AzK0SqdWGju/J6hU8U/J0Bwdk5WgIl2R
         sPLgNwspJbrkdf5/gBjozFr1zQ9OnIal2WCW/Hex9+s6QCwQxgCQxVmC/Sg4fXPjUXkm
         jLllTljIQhfq5VBVv9+XguUPG1KNr/u0F3mRRWALzeW760j3lwuyLccndMI0TGe7WtMA
         oEK4ve/6ULPGmlUq4X4FLYFKICDGzlmcio+zk00Ji6a/+lIhzagHjZwTCtNM+OI0xE7O
         XQMQ==
X-Gm-Message-State: AOAM530EEBL77oKBuFKKTGjhhPXg/cZKoEfgSKXJOGsg0qM7QGOTHMe+
        nOrO3fa+h9tdx8WGzGDZH4pyKwwADIg=
X-Google-Smtp-Source: ABdhPJyrKgC4/kWiVatQEZYepXXoDCRN9um/5NtYnhfJ1Yi7jh8UaBOqub6l8zKFfl2CnzbkDj3Nag==
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id v16-20020a1cf710000000b003941960e8a1mr20749622wmh.154.1652784309472;
        Tue, 17 May 2022 03:45:09 -0700 (PDT)
Received: from octofox.metropolis ([178.134.210.144])
        by smtp.gmail.com with ESMTPSA id r5-20020adfbb05000000b0020d00174eabsm8612218wrg.94.2022.05.17.03.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:45:09 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 1/3] xtensa: add trap handler for division by zero
Date:   Tue, 17 May 2022 03:44:56 -0700
Message-Id: <20220517104458.257799-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517104458.257799-1-jcmvbkbc@gmail.com>
References: <20220517104458.257799-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add c-level handler for the division by zero exception and kill the task
if it was thrown from the kernel space or send SIGFPE otherwise.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/traps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 138a86fbe9d7..24d11b44fa57 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -49,6 +49,7 @@
  */
 
 static void do_illegal_instruction(struct pt_regs *regs);
+static void do_div0(struct pt_regs *regs);
 static void do_interrupt(struct pt_regs *regs);
 #if XTENSA_FAKE_NMI
 static void do_nmi(struct pt_regs *regs);
@@ -95,7 +96,7 @@ static dispatch_init_table_t __initdata dispatch_init_table[] = {
 #ifdef SUPPORT_WINDOWED
 { EXCCAUSE_ALLOCA,		USER|KRNL, fast_alloca },
 #endif
-/* EXCCAUSE_INTEGER_DIVIDE_BY_ZERO unhandled */
+{ EXCCAUSE_INTEGER_DIVIDE_BY_ZERO, 0,	   do_div0 },
 /* EXCCAUSE_PRIVILEGED unhandled */
 #if XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION
 #ifdef CONFIG_XTENSA_UNALIGNED_USER
@@ -307,6 +308,11 @@ static void do_illegal_instruction(struct pt_regs *regs)
 	force_sig(SIGILL);
 }
 
+static void do_div0(struct pt_regs *regs)
+{
+	__die_if_kernel("Unhandled division by 0 in kernel", regs, SIGKILL);
+	force_sig_fault(SIGFPE, FPE_INTDIV, (void __user *)regs->pc);
+}
 
 /*
  * Handle unaligned memory accesses from user space. Kill task.
-- 
2.30.2

