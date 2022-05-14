Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EBC526E85
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiENDfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 23:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiENDe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 23:34:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC58C93458
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 20:34:55 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so13546446wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 20:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbqWA0ma3Gj0jvWCSxtRNJBD3Bf6tu8RmToQD/S/1tA=;
        b=gtq9z1Gj/PCfH+6jFgOvMnLRXGDONoKZuJaDEtvtAB+Pm/dztH9DvgrU6IAK4GHSvx
         2QVOEMjMwI/eT5uc3gxko0aNgtLwRLxBEXKz950r/3llvBuFiuS54qlX3ymMogGVyUaC
         6wcgTEom4pnkmhKZ39vK8KU1a7C/3oSZ4r8M61A05BaJLLEILmITjPQaOLc7nFsuywfr
         cuzbLh8GYTS9+50CUcFm/f953Evh84EpYvwInJlyRBVsB8/U1l2Vz/rrjsh2OlCKsIN+
         YLiFJcUe7wVFO5O93J41chW+UnzT8KscgSDdJ5bLFAjA2toRqCggSV8FKgzHoQGfLv/+
         9EhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbqWA0ma3Gj0jvWCSxtRNJBD3Bf6tu8RmToQD/S/1tA=;
        b=jU99lYWMoK+iAGHVe0kNieJffxzYeVMML/SDvlguVoc1n82UWl8LAtz3lGUPh2enSt
         M5XYZfVWAKTUJse9zGRLURzQxtEDMTPIupmhZSxx+zMt41xcdP/ZswaSLt0jcnXyXSwk
         TeJLXygHUqSzlZqL8YqoKVs4fw+pRAjF3HPvfn4H/wZWTbfMSecp204nRKO+dWTWEBEZ
         TK3lqOGM/qbnmpD8AY8H2MgP/1ZWXnqSY8lXvUVXuxI23vB4iqQEYe6qwB+Fqm8bZQhl
         18tQWMEEvHRQiRs+M8YRBpDKbreFbzHy+DpwaxXalIZ3qK35a/k2r1JphsggBreC5v3c
         diJg==
X-Gm-Message-State: AOAM532y2bwJY73WBpoFJHnjkRXNHuMphOXKeXgDJVElYmvAwANILdF0
        nKroQ8iA1hlUik3LUuTI6er5MlBT8xGsAQ==
X-Google-Smtp-Source: ABdhPJwb0OdUi32hRVoqlssaZ0HnR6jJ93O92ZO68kKEPXG+siOvohkKiv+j+dUCZ71ZdIGSCqzcfQ==
X-Received: by 2002:adf:f691:0:b0:20c:d5a4:79f1 with SMTP id v17-20020adff691000000b0020cd5a479f1mr6368906wrp.380.1652499294508;
        Fri, 13 May 2022 20:34:54 -0700 (PDT)
Received: from octofox.metropolis ([178.134.103.46])
        by smtp.gmail.com with ESMTPSA id h1-20020adfaa81000000b0020c66310845sm3542638wrc.55.2022.05.13.20.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 20:34:54 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 1/3] xtensa: add trap handler for division by zero
Date:   Fri, 13 May 2022 20:34:35 -0700
Message-Id: <20220514033437.4182899-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220514033437.4182899-1-jcmvbkbc@gmail.com>
References: <20220514033437.4182899-1-jcmvbkbc@gmail.com>
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

