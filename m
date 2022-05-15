Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A1A52777F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 14:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiEOMmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 08:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbiEOMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 08:42:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4501712A9A
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so12020876plg.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URPrkUOTksZy0vkIOlXm6I32VTQjSzL208bMcPxmSHk=;
        b=Qf2SFi15nUqunuSsHbUvOLDs9jx8EfYTjiHnmxRleIxk/xBIm5RBYHeYAfO61uuwQz
         Nx7D+WbgMss1gQdJ/eOx5k92CPGxwSXFZ+Y4aZ6ubNX1DJpG3P725ZT4/dpxk/d/kwK7
         woSya6rxwp2rUb7YMhfIcYnLjfERr7ZOzLk8ep6bzDdf5d1WvElKtXVybkityqGG9ROl
         ZoozNwXhbmjbvJeYgkGSR84jbY4x5A4HDFxx2MCjsgc2BMdcmAg1U06pc1LHe3UT/Xgg
         i4oETKM3qSNwABkBbRJ+8bO5YDnwY+xpv+NcJUw5rXqNJPs1ReyB7hgPpCmnRhL9c4bz
         ADPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URPrkUOTksZy0vkIOlXm6I32VTQjSzL208bMcPxmSHk=;
        b=wIXNY38N/Diy1xue6osrzMI3HvR8e/elbjl4WGNtldoZlAQE7VL6kbEOIOE5JyDEk2
         +T8LKmCWhs3DEPq3MGoazid+Vmyot4oLRkZbOzNfPvFCMCtti4a7NxmbA8w2o5qK/IT6
         QPtoQHBTfizECPGmw8Xo/Jr5Bv0XjcTMG0pmTJLAiw2t+16W9nyfGfNuww+OKHzRAaHd
         N3W9kOp5xcjLH3hAJeYYggVhE7ZqMEC5CuwSPHOjWXz/ssACRkqU8LdpFZmxUINaBecV
         vy7yXNSUX+46yiF5/9k0ZPguilnqFQwYA/J5kH3G4tQnBSM2HY8JMPu2JbwGJI6iwN7i
         ciAQ==
X-Gm-Message-State: AOAM531IG5unVsgtkBVWkIyLXh4bOBlOubgogUJoopiL2lSInAL2PMj8
        XPF3bylMQa9fEFjpX3eu/vsRg/mcA/JscQ==
X-Google-Smtp-Source: ABdhPJw6rtgLAlUzww8OqkwRf7uyo9N6Q1iShOza3I7ojiZdLV37sJ8d+/UQ4p0TsSZWLhy2rIHjJw==
X-Received: by 2002:a17:902:d2c6:b0:161:6e0e:c5e1 with SMTP id n6-20020a170902d2c600b001616e0ec5e1mr2329079plc.139.1652618541066;
        Sun, 15 May 2022 05:42:21 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903024f00b0015eee3ab203sm5157820plh.49.2022.05.15.05.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 05:42:20 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Andrey Bacherov <bandvig@mail.ru>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 04/13] openrisc: Add syscall details to emergency syscall debugging
Date:   Sun, 15 May 2022 21:41:49 +0900
Message-Id: <20220515124158.3167452-5-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515124158.3167452-1-shorne@gmail.com>
References: <20220515124158.3167452-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When bringing linux on the or1k Marocchino we ran into issues starting
init.  This patch adds the syscall number and return address to
assist tracing syscalls even before strace is able to be used.

By default this is all disabled but a developer could adjust the ifdef
to enable debugging.

Cc: Andrey Bacherov <bandvig@mail.ru>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 3ca1b1f490b9..54a87bba35ca 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -601,7 +601,7 @@ UNHANDLED_EXCEPTION(_vector_0xb00,0xb00)
  */
 
 _string_syscall_return:
-	.string "syscall return %ld \n\r\0"
+	.string "syscall r9:0x%08x -> syscall(%ld) return %ld\0"
 	.align 4
 
 ENTRY(_sys_call_handler)
@@ -679,15 +679,25 @@ _syscall_return:
 _syscall_debug:
 	l.movhi r3,hi(_string_syscall_return)
 	l.ori   r3,r3,lo(_string_syscall_return)
-	l.ori   r27,r0,1
+	l.ori   r27,r0,2
 	l.sw    -4(r1),r27
 	l.sw    -8(r1),r11
-	l.addi  r1,r1,-8
+	l.lwz	r29,PT_ORIG_GPR11(r1)
+	l.sw    -12(r1),r29
+	l.lwz	r29,PT_GPR9(r1)
+	l.sw    -16(r1),r29
 	l.movhi r27,hi(_printk)
 	l.ori   r27,r27,lo(_printk)
 	l.jalr  r27
-	 l.nop
-	l.addi  r1,r1,8
+	 l.addi  r1,r1,-16
+	l.addi  r1,r1,16
+#endif
+#if 0
+_syscall_show_regs:
+	l.movhi r27,hi(show_registers)
+	l.ori   r27,r27,lo(show_registers)
+	l.jalr  r27
+	 l.or	r3,r1,r1
 #endif
 
 _syscall_check_trace_leave:
-- 
2.31.1

