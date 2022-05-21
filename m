Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C5652FCAC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354882AbiEUNOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353316AbiEUNN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:13:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D735FF3C
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:13:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso13641284pjj.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URPrkUOTksZy0vkIOlXm6I32VTQjSzL208bMcPxmSHk=;
        b=MxywOSFHz7PZ/XnD//EDP0QUHLfj+as9iHe+yiq4nk06+24WLMwUQcJ27b5V2I/xsL
         tAISylV4H1lBAdvOk9R41xYs6l5RrJfv5iBxwFXtA7wk7oXbPgB/YdVNQ5p6XaB1bEon
         gBx8Yj/1ssUEJsUF4W4RBm0g977FZrkapO1+0Xwv+H9drf/J+lB7gCQbxd+zPdWcSlys
         uClIymNljdApPgJ6zSv2I4GYZP34o1VUqM33Botm50uW4o/7kEH12NsN4fnS4woK3aQI
         7Mi4Ec8pQWSQwgqWFw7DrCTWhBQI8Lfy6OhoS6O72clVydI7yB4fj5CZFakrtgv8OsoM
         lq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URPrkUOTksZy0vkIOlXm6I32VTQjSzL208bMcPxmSHk=;
        b=aokrMdb/H/lyeypS36v9A4TGie7tVbnYjvmyQHAZpDNovyFpbVWAXIPrTKqVGBrn5e
         V3Y0ioF5RHPhhfI/OwXeqdDnbSkSf79PD8spCATXNs8ikf4vwCmUIDzv76E2kT1V9ZWv
         l35xDnXmvC4Xvi9NhGxxZNC7L8UXzLnRbsYwYaU7oAdL1Rzufanb9TOVxltBXVZOrPfD
         rNEmttN21C9pry6DY9zqzuCzfmmzp7JhZzowJH7CPKpvg7AKmUBKx62RXtTx4Pxinm3V
         SdBhxvFRKFJb77PnbmOlnnojJ8BqCkM0xgTWjku/Hz7OF03FOfJkSQn81N9NflHzsg6Q
         mq1Q==
X-Gm-Message-State: AOAM530xnPIzzHMUSHn8nhbs0pGQXamLqYhCHGSfg2lehyFLSvsogfuD
        1/p56trMiXo0rHr7T/x41U/m/Jz28pnwAw==
X-Google-Smtp-Source: ABdhPJycrrEqvaylteUpNBdePlGKsQ4p/h0pFbpeM860AzJGdXaRGgOhQLbqf3o8ZIZTX/pn7UvPPQ==
X-Received: by 2002:a17:902:7c8c:b0:161:f5b4:9aa6 with SMTP id y12-20020a1709027c8c00b00161f5b49aa6mr7028272pll.79.1653138830133;
        Sat, 21 May 2022 06:13:50 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id m5-20020a654385000000b003c14af5062csm1470295pgp.68.2022.05.21.06.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:13:49 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Andrey Bacherov <bandvig@mail.ru>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Chris Down <chris@chrisdown.name>
Subject: [PATCH v3 04/13] openrisc: Add syscall details to emergency syscall debugging
Date:   Sat, 21 May 2022 22:13:14 +0900
Message-Id: <20220521131323.631209-5-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521131323.631209-1-shorne@gmail.com>
References: <20220521131323.631209-1-shorne@gmail.com>
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

