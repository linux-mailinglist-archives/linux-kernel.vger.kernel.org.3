Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F87529639
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbiEQAze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiEQAza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:55:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BAF344F3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w17-20020a17090a529100b001db302efed6so892934pjh.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2M3w87N8EOgC0/E1kAJwjCB00j3VlGn1SiaTA0GCI4=;
        b=oBdS6oGKMONo6W7KiHyC44QKcc6QdwUE0uChA6qKnet4V/Bq5PQUYToWMMltiIqZn8
         D9HOEyqT1XBgJ9tUkWvKLZm4SX2kqk/hbHnlN2kPPDZl5K5OhQPRKGpNoPJoHMs/QKEZ
         zBwnjtGSpv3PebkKGv2D9mBORqNd2lBc1ZR3LeYtKES6PbSzRef0uOOOThSX4Z5QdagE
         mW0iMqK+L0ABtC1NS5Ni/EV+N3vPaUam8aprpyqFTTyBsG21fHhzN/jJWJyw1aRGjute
         SY3zAtmi8iiI9eKWKo9gyeEZxslBu/nRu2GxcEQDY38QEpleGsFUm8EO2DwjXAd2BvyH
         L/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2M3w87N8EOgC0/E1kAJwjCB00j3VlGn1SiaTA0GCI4=;
        b=gB+t5bo9jZMVCutp4UItWZiPN8+QyIiVcvcycwAJf27lvtEWJTtkxKoCrEdNbepXrh
         Pz4k+twaQLoYTZMdNuVO7Za0mKNxraUwXHHSQXDiZ5UjgZ/ZexmgxwlybmW7HVP/Y6Xw
         jHopwK/kvx0jdMAFTtZF0aESBknK/N04LJFGv21FOw+bFOfBhakEhS0+jt1OjcBDFQcV
         nrmtFbGkSQBwfTP4lUoSgduFyJ2XqNlUbWKmi7bXQiemvHCxy6yEltaEdfJVr7mDRtO4
         0r1YsdMyV8RV6FXa5jRH91RXcDFuglfOMovFhT1R43wQFGDaizjR4fLaPuhuRQpzsbVA
         Mtwg==
X-Gm-Message-State: AOAM531Xx0NM2wcZmbCy3PJxDbrY5Bkr1Qsu5J+KdEBc4P1Ad0iQG9ZK
        sEx6mLyEox+bAZ2jVsgimCHcgoNUFMc=
X-Google-Smtp-Source: ABdhPJzricSwjwhsyYUriiO42PXB0BfxYRb3I3qa8uLhZwnsRNsV5LadGCU21WU8vjpqDMrKzBvETw==
X-Received: by 2002:a17:90b:3649:b0:1db:a201:5373 with SMTP id nh9-20020a17090b364900b001dba2015373mr22178032pjb.175.1652748928539;
        Mon, 16 May 2022 17:55:28 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id x9-20020a628609000000b0050dc7628193sm7353806pfd.109.2022.05.16.17.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:55:27 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH v2 01/13] openrisc: Add gcc machine instruction flag configuration
Date:   Tue, 17 May 2022 09:54:58 +0900
Message-Id: <20220517005510.3500105-2-shorne@gmail.com>
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

