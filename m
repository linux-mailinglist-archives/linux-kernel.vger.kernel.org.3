Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF4052FC9A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243613AbiEUNNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbiEUNNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:13:40 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19AB387B0
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:13:39 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 31so9901556pgp.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXO4BheuhYf/qtVPhrmMyquWayElWld6sjdR5X3gNkE=;
        b=l6xk/kluVQpMuwRXPybjDty5NMjYJs9gDfwu/kLMXMr4MTLCUzBVK+UTLB1/DhB6DT
         APVt63p0+SycjvMMyPyDkq4s7oLVc/7A5RqJTqFTJObilxMMKRNgXz3qULPIgfEJXJQH
         EXSKbjzznlfM9znHRhrHuCdh9jAZ+LkGcJ3+kLn+BToHzbqaK6hzlnUrHuNfs6iOY98+
         RdT14U64yKUa/kvIMQEMA62hJ5WAPU0q4aBSGKc2DmCw6Pdf2KLt21U9vkCctwPwBDpR
         E7jGahl1nzOzqnuqgqJCmBrEwhgvVWeZ0Mv9Da87b5eAWyT1KrSo4LZW5cTigR8P6eR2
         6kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXO4BheuhYf/qtVPhrmMyquWayElWld6sjdR5X3gNkE=;
        b=KpMJFvSyq5JjhOwdl58H/X1J8pkJn3pukJfUra/N92ztcO2JNrXIp03HHghQ4w1LWV
         ZoFYJ94kIODw5vG9RbYVaQvlaMfBCzh6gVrDrMPnBHbKnZ9RYZA1dPuAV3NZGDzQQ/Mm
         jxyNyVHg0O2JR8733ooXX7o2O5qN93zmne8tKvlh4S/7NDcDdWe6yHY+SgLIfw/mGUW1
         nITY1uF6ztkyQZ+1/50W7//Jdd8rWI8JqbsFNuu9CLLyR7AcruFFz3eqNW1bBDogG+lM
         wRhDG8RxKpAGUXPzQBHBxFdJS3Iz3K7o6Bt6DIRYaFF6kpFYR3KbslaXob6NNWQXR0Qb
         kWAg==
X-Gm-Message-State: AOAM5336R9qudsdBdYIKMy7RpFMQzYqlBgh9Z61O1/+s27byxAXwihlv
        BEOb6uusGI+L2KRfBO6JhZfXR8r0gRQ=
X-Google-Smtp-Source: ABdhPJzbNA9d6fiiiDWRXIgbgBoWlld0RwTG6FoUevm82feThooClQUtFgklc9cPjFrLzTaW83B1Yw==
X-Received: by 2002:a63:4846:0:b0:3f2:5f88:e7ab with SMTP id x6-20020a634846000000b003f25f88e7abmr12944774pgk.2.1653138818691;
        Sat, 21 May 2022 06:13:38 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id jb15-20020a170903258f00b0015e8d4eb256sm1564170plb.160.2022.05.21.06.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:13:38 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH v3 01/13] openrisc: Add gcc machine instruction flag configuration
Date:   Sat, 21 May 2022 22:13:11 +0900
Message-Id: <20220521131323.631209-2-shorne@gmail.com>
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

OpenRISC GCC supports flags to enable the backend to output instructions
if they are supported by a target processor.  This patch adds
configuration flags to enable configuring these flags to tune the kernel
for a particular CPU configuration.

In the future we could also enable all of these flags by default and
provide instruction emulation in the kernel to make these choices easier
for users but this is what we provide for now.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig  | 53 ++++++++++++++++++++++++++++++++++++++++++
 arch/openrisc/Makefile | 17 ++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 0d68adf6e02b..37243f023805 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -114,6 +114,59 @@ config OPENRISC_HAVE_INST_DIV
 	default y
 	help
 	  Select this if your implementation has a hardware divide instruction
+
+config OPENRISC_HAVE_INST_CMOV
+	bool "Have instruction l.cmov for conditional move"
+	default n
+	help
+	  This config enables gcc to generate l.cmov instructions when compiling
+	  the kernel which in general will improve performance and reduce the
+	  binary size.
+
+	  Select this if your implementation has support for the Class II
+	  l.cmov conistional move instruction.
+
+	  Say N if you are unsure.
+
+config OPENRISC_HAVE_INST_ROR
+	bool "Have instruction l.ror for rotate right"
+	default n
+	help
+	  This config enables gcc to generate l.ror instructions when compiling
+	  the kernel which in general will improve performance and reduce the
+	  binary size.
+
+	  Select this if your implementation has support for the Class II
+	  l.ror rotate right instruction.
+
+	  Say N if you are unsure.
+
+config OPENRISC_HAVE_INST_RORI
+	bool "Have instruction l.rori for rotate right with immediate"
+	default n
+	help
+	  This config enables gcc to generate l.rori instructions when compiling
+	  the kernel which in general will improve performance and reduce the
+	  binary size.
+
+	  Select this if your implementation has support for the Class II
+	  l.rori rotate right with immediate instruction.
+
+	  Say N if you are unsure.
+
+config OPENRISC_HAVE_INST_SEXT
+	bool "Have instructions l.ext* for sign extension"
+	default n
+	help
+	  This config enables gcc to generate l.ext* instructions when compiling
+	  the kernel which in general will improve performance and reduce the
+	  binary size.
+
+	  Select this if your implementation has support for the Class II
+	  l.exths, l.extbs, l.exthz and l.extbz size extend instructions.
+
+	  Say N if you are unsure.
+
 endmenu
 
 config NR_CPUS
diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index 760b734fb822..b446510173cd 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -21,6 +21,7 @@ OBJCOPYFLAGS    := -O binary -R .note -R .comment -S
 LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 KBUILD_CFLAGS	+= -pipe -ffixed-r10 -D__linux__
+KBUILD_CFLAGS	+= -msfimm -mshftimm
 
 all: vmlinux.bin
 
@@ -38,6 +39,22 @@ else
 	KBUILD_CFLAGS += $(call cc-option,-msoft-div)
 endif
 
+ifeq ($(CONFIG_OPENRISC_HAVE_INST_CMOV),y)
+	KBUILD_CFLAGS += $(call cc-option,-mcmov)
+endif
+
+ifeq ($(CONFIG_OPENRISC_HAVE_INST_ROR),y)
+	KBUILD_CFLAGS += $(call cc-option,-mror)
+endif
+
+ifeq ($(CONFIG_OPENRISC_HAVE_INST_RORI),y)
+	KBUILD_CFLAGS += $(call cc-option,-mrori)
+endif
+
+ifeq ($(CONFIG_OPENRISC_HAVE_INST_SEXT),y)
+	KBUILD_CFLAGS += $(call cc-option,-msext)
+endif
+
 head-y 		:= arch/openrisc/kernel/head.o
 
 libs-y		+= $(LIBGCC)
-- 
2.31.1

