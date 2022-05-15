Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5367B527777
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 14:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiEOMm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 08:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbiEOMmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 08:42:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756141208F
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n8so12029731plh.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2M3w87N8EOgC0/E1kAJwjCB00j3VlGn1SiaTA0GCI4=;
        b=EYf+o3rbH2eW5IncWe6cMBP0B6uHWzKwOKWro70z/747jg3zJZyrOV142C6BB8aU3W
         1B6LNQX5Ih2MJuYXjGEgJ4kFwezLdm6OVmil8HLgZRheIjanZNG/TNasOLfaS1o1oyGT
         xSFdT/LV+t2WLsWc2ceBXUJWgoihZO1vgLtw7+qca4Y3EPMZU8RPT3ODmzy0H8sXtTpa
         jkzue1yPoAdd51LwBu0KkJ1gD3lkiPER3SFFKTmyxQT32kKz4f1P+rRP1Yh4hB3qoXBc
         a+BYtZo63lM9v8Mj6qZgGHlwblgIJ3xIcQ0oAbMcH1Njt4ox6d7VxBiQUFovUALOnoQs
         2znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2M3w87N8EOgC0/E1kAJwjCB00j3VlGn1SiaTA0GCI4=;
        b=l1kXzCzDc1oHk2MxPWXoWu6mDH8q5wMkb9npuisfqTp7De3G7QEiSeHtK83JdhEoEL
         P/J6WWNZO1Yv8Ab+hIjZS9IfpgXyrcY/UYIs9CkAfOvPv3k0jK5QgAUDYqLO3Pm1COHi
         0X1AEZnhxCXoPldsdwCnGxkmLPMWh2BNVVBp9ugvf6bct1GEJT15iuLCVxcs7cNRm/wV
         UdWDlPfXKCfjNXvvwtgOnvPwaNdxZmJ7V1EGqvQL19KuS4SLFG9WoVBVBI+yB/Cq9QsA
         MPGhmK25KT0gvJJnk0uxLd8F+WJ5revn1TWfIqf7m4dAs0OBSSZiOVXgIQ4iJhQ1QXBQ
         4f3w==
X-Gm-Message-State: AOAM532oPQl/5QFMBRmqbVEfFaZnNQnUUOif4tsoCPGv/FSmxn397VrF
        QF9rviHSRUd0eFbm7I37aCE3y/ZQucU=
X-Google-Smtp-Source: ABdhPJzxBhwVV+BdYvtR01oKfFqfWOB27LkD5kc+uhejdXzN4Ws0fe09+84sGHS105erznma5LCd/Q==
X-Received: by 2002:a17:902:8487:b0:15f:b2c:435 with SMTP id c7-20020a170902848700b0015f0b2c0435mr13365405plo.33.1652618530476;
        Sun, 15 May 2022 05:42:10 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902e94d00b0015e8d4eb208sm5054498pll.82.2022.05.15.05.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 05:42:09 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH 01/13] openrisc: Add gcc machine instruction flag configuration
Date:   Sun, 15 May 2022 21:41:46 +0900
Message-Id: <20220515124158.3167452-2-shorne@gmail.com>
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
index 0d68adf6e02b..ea7eac20911a 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -114,6 +114,59 @@ config OPENRISC_HAVE_INST_DIV
 	default y
 	help
 	  Select this if your implementation has a hardware divide instruction
+
+config OPENRISC_HAVE_INST_CMOV
+	bool "Have instruction l.cmov for conditional move"
+	default y
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
+	default y
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
+	default y
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
+	default y
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

