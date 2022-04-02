Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524E84EFFA8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbiDBIXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiDBIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:23:51 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED682228C;
        Sat,  2 Apr 2022 01:22:00 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 85so3847141qkm.9;
        Sat, 02 Apr 2022 01:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2doMNH7ifB03QblJV2sV07sq+r0A6Mdk0Jlzv/ArvaY=;
        b=VYxrlKcmGbTkEwUnHLtwCXXpdE5IDbdZvAYkotfFzWNxkJhSun2epO3gjmkx6giYv8
         mNzcTkHe9iLzOBy2WYpd2+KmWpydubR3yi7pwYxBS39yUrR5HZRJhBUhUOaSW2r2+P1D
         cJPzupk0ygyM8IgmK1mxbjjrT0lD1Q7vTipeJUSEJR9ZTqo3ajTj8Y2h0fTaFNFIws5d
         NETWJb5ept2dh27vEId5jCg5o3bmg58eHk6NUCVbiF+4eApZ11A2eQo+NsdvvF7xF59G
         0JywIlxOsBvz3Ymb5QG0cigbXh2x3aJlUyMtwh89sJjVmQbLox2jQxd2p6sCMZwf5W7e
         y9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2doMNH7ifB03QblJV2sV07sq+r0A6Mdk0Jlzv/ArvaY=;
        b=aeWco5zRepXIzbjGY4oZYazWJAMhp1m8VGsg7kuazaeG8mABXCeCmbxFRPUi8fgtl6
         LHosAchs9IkdIQqON/CmzojJdfJ8H2aI2qvN9RFnP300+B7BjzzgY/2G9oJnoY9h+C/i
         n+Q1+elCw2WLd/N5zZUrNutt+zTo8K4cecZ9oX/YRb3zAZaGkgDF0pBO5WxvVAfXN//z
         +TibR+EtCAdmpRFQs7Tab7j2O54JR0phWRRr5Hgt8sPsYS5nmyUBo6YySPIs9HnfKRcZ
         HeFxtf6S5gdZs2xZR7PF05kZav0oTNpggxs8g2rOw7wwJHsM8Cc1/kLED+v8WwhHdAAY
         /2zA==
X-Gm-Message-State: AOAM531/WXvEpNWjwUV/GQYtZORaEDJJ83bCPyzJqTM2GFTpW2WPpYcd
        2ypsWPOEZQ2qLrwyEQbEz5d0vgxiKsc=
X-Google-Smtp-Source: ABdhPJw8uQonUkmYuQ1OnU2jT+kjlBm6GiA0ePZAhHb50b+9u8cemwQFvTzQsUr5NUrlY1sBm8+3KQ==
X-Received: by 2002:ae9:f00c:0:b0:67f:329e:9700 with SMTP id l12-20020ae9f00c000000b0067f329e9700mr8748032qkg.421.1648887719464;
        Sat, 02 Apr 2022 01:21:59 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 186-20020a370cc3000000b0067d36e3481dsm2552823qkm.17.2022.04.02.01.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 01:21:58 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     mattst88@gmail.com, masahiroy@kernel.org, hch@lst.de,
        keescook@chromium.org, tglx@linutronix.de, mark.rutland@arm.com
Cc:     rostedt@goodmis.org, mingo@redhat.com, yang.yang29@zte.com.cn,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] alpha: replace NR_SYSCALLS by NR_syscalls
Date:   Sat,  2 Apr 2022 08:21:42 +0000
Message-Id: <20220402082142.2413088-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Yang Yang <yang.yang29@zte.com.cn>

Reference to other arch likes x86_64 or arm64 to do this replacement.
To solve compile error when using NR_syscalls in kernel[1].

[1] https://lore.kernel.org/all/202203270449.WBYQF9X3-lkp@intel.com/

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 arch/alpha/include/asm/unistd.h | 2 +-
 arch/alpha/kernel/entry.S       | 4 ++--
 kernel/trace/trace.h            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 986f5da9b7d8..caabd92ea709 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/unistd.h>
 
-#define NR_SYSCALLS	__NR_syscalls
+#define NR_syscalls	__NR_syscalls
 
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index e227f3a29a43..966400b925a5 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -454,7 +454,7 @@ entSys:
 	SAVE_ALL
 	lda	$8, 0x3fff
 	bic	$sp, $8, $8
-	lda	$4, NR_SYSCALLS($31)
+	lda	$4, NR_syscalls($31)
 	stq	$16, SP_OFF+24($sp)
 	lda	$5, sys_call_table
 	lda	$27, sys_ni_syscall
@@ -585,7 +585,7 @@ strace:
 	ldq	$21, 88($sp)
 
 	/* get the system call pointer.. */
-	lda	$1, NR_SYSCALLS($31)
+	lda	$1, NR_syscalls($31)
 	lda	$2, sys_call_table
 	lda	$27, sys_ni_syscall
 	cmpult	$0, $1, $1
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 07d990270e2a..7ad8324db192 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -25,7 +25,7 @@
 #include "pid_list.h"
 
 #ifdef CONFIG_FTRACE_SYSCALLS
-#include <asm/unistd.h>		/* For NR_SYSCALLS	     */
+#include <asm/unistd.h>		/* For NR_syscalls	     */
 #include <asm/syscall.h>	/* some archs define it here */
 #endif
 
-- 
2.25.1

