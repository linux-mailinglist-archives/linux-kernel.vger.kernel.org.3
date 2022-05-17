Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C534E529646
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbiEQAz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbiEQAzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:55:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D39ECE7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id bo5so15533542pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URPrkUOTksZy0vkIOlXm6I32VTQjSzL208bMcPxmSHk=;
        b=UupvaoPH523tK0FTB32h9+ccvRKp5igs/DWMORUUtCOWOso6fYzWmPV+1a1zyTdqcf
         du5DS5q7UYYny+lco4UHxNUe3g5wjcaAjf+2mpilM4MX2LQrmQVChFFq4njBYqqd7aWN
         PS875JvWku0ngw3WBdywFS5kRHOrXvF3wvwqRT+BlF0HTPedbYu8zAMqPXquJCdDm5iN
         Fs1QKOhsrYQAYijAjK9eyaxDeQuad7fkz/TccnfzfSVMZibZpptOdBr7/FR1bvRTJmth
         1D3SPUI66RyKUk23pqzp5FBv5lPmiPsEp9cc1SSCLxuVHYc/NBd/LnoUj6QU33lsSkoi
         e1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URPrkUOTksZy0vkIOlXm6I32VTQjSzL208bMcPxmSHk=;
        b=3gJzYKjjPHLlmc8vdezFmPZIune15Y5gkR2J3kCdd3iX1NgnqCyxqaE+R/gLAualM1
         eMhQebfPbGPAO1Nyoxb1m/lg2/EUkytmRj6xe/VYwjKkGxu5Qrn4hl1Cl5UuQxZuqRAX
         ce1lDjGnyI2c8sXHL4r/ZrimYgyWGSqIKxY2o9xcGGHhl02waHrkIqM29I+NljrL5E2r
         d2PaafSi0K+xSt/7xxSC9su1WBk7s8DPnJMEHRtrkbvI2mijdQLYLo7S1bnA+Ob5RbJd
         3CTca+0mKXS0Xlq6R7wKEvp305R1YKsDtFlDI3rCBSr3+MzaU24l03gjni1WelkhrIji
         63EQ==
X-Gm-Message-State: AOAM5310wqAjsWz3lj55IL3MCNyCX4eeFVsNSCTxjoGw/ITFAGL1ahMs
        dpuRWCLfjXHB9DaiblK9h5ZL+Ppnb0D1PQ==
X-Google-Smtp-Source: ABdhPJyZJpbgtHCnP93HtiV36JN+8M71Eq1x/qZGWWPpnNp/RLPeQVQ7W2jRJDrqPdRD3V8yp3zEzQ==
X-Received: by 2002:a65:6297:0:b0:3db:4820:2867 with SMTP id f23-20020a656297000000b003db48202867mr16938361pgv.503.1652748938816;
        Mon, 16 May 2022 17:55:38 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id cs20-20020a17090af51400b001df5dea7d4bsm282211pjb.43.2022.05.16.17.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:55:38 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Andrey Bacherov <bandvig@mail.ru>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 04/13] openrisc: Add syscall details to emergency syscall debugging
Date:   Tue, 17 May 2022 09:55:01 +0900
Message-Id: <20220517005510.3500105-5-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
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

