Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ABA4D3D16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbiCIWhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiCIWhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:37:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FDB1216B9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:36:11 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so6582678pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KaZ7UiCMXi8qMFjPqiV4xU9nDrqqMiEGUN4hXGJXHL0=;
        b=f1Vc4QOkkBXv6009fjawNvWMX9OxrPebOlqoDZEQhDLnw1gEwD14g81AO62Vc7PZSM
         0iUzd91hEUZhS3UI0SmnX5hGatAnQKj7z52vrmX9o+qdBDkPUNoKaAeC/GcOm6q8vJel
         Y6wwFooGD3tTJpth4TUXsPLxLc5l2TEewJTu8J1oywVo4m7NRv+/ucWEgDn2C9iXl5vL
         i6y5BReYAhUiEHPwojq307v1ALmQ+QoXaD1bJS2QpqJPJs7fbDzdjillX1xuPVOViKfI
         sgCFjbKq19VXiVd3eTk8UiJqCaSkb9L/im9cUALFc1QHRFlr7I/yIoyoyLtq4A25KUTP
         200Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KaZ7UiCMXi8qMFjPqiV4xU9nDrqqMiEGUN4hXGJXHL0=;
        b=C9wiKp3BLOqzd6dQopw2C4fBjM1J0CJIWHcRYKAPEJGsvZCGvFRaF1qS/yrCzymXIn
         RWUkX5ejZXNCiLSjCVkoJJ9duRDxMBwzWsUMK76zioQjq8ZOoXsGzwaHf7OsXE8bt1Ub
         xmGhI7ZA45wRCwXAEDhBnD5ELVuQttlR+HVyU2ydHoVGahF7p+ssYuzY2ytLyMHp09uK
         yz9o7HR578/zWeDxBWbhbg8GUZWcYZy9Tu+SReso+el6X1YFUzVduS2LKvOPzkrRsIk4
         uIn1SJyFNA+aXt0Oi/CN+cTpeRe4LN4uxmVd5osYPGBIqpTLNYHpFqj3WZavdSFATp7N
         lCHQ==
X-Gm-Message-State: AOAM5326KBH3z7O+wWP/4VXXwDIgqTuOdMx2oEHrlLF8RAIiKdgTQyk5
        IweoWIxgt1Pe4oshMLlaVPc=
X-Google-Smtp-Source: ABdhPJweOMbhERmw1l+0POpTBXvnE5YjxPi6T3FchbPLhWMokyMkH/qrladgyIE5jlyra7QRpDmbpA==
X-Received: by 2002:a17:90b:4d8a:b0:1be:f5f1:89d3 with SMTP id oj10-20020a17090b4d8a00b001bef5f189d3mr1794464pjb.79.1646865370688;
        Wed, 09 Mar 2022 14:36:10 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:6f34:be93:349a:f478])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm4023446pfh.174.2022.03.09.14.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:36:09 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: add kernel ABI selection to Kconfig
Date:   Wed,  9 Mar 2022 14:35:57 -0800
Message-Id: <20220309223557.1253417-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Add choice to use default or call0 ABI for the kernel code. If call0 ABI
is chosen add '-mabi=call0' to the flags. The toolchain support for this
option is rather new so only enable it when the compiler supports it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig  | 35 +++++++++++++++++++++++++++++++++++
 arch/xtensa/Makefile |  4 ++++
 2 files changed, 39 insertions(+)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index b324f6743073..cf03ed54c8f0 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -92,6 +92,9 @@ config CPU_BIG_ENDIAN
 config CPU_LITTLE_ENDIAN
 	def_bool !CPU_BIG_ENDIAN
 
+config CC_HAVE_CALL0_ABI
+	def_bool $(success,test "$(shell,echo __XTENSA_CALL0_ABI__ | $(CC) -mabi=call0 -E -P - 2>/dev/null)" = 1)
+
 menu "Processor type and features"
 
 choice
@@ -250,6 +253,38 @@ config FAST_SYSCALL_SPILL_REGISTERS
 
 	  If unsure, say N.
 
+choice
+	prompt "Kernel ABI"
+	default KERNEL_ABI_DEFAULT
+	help
+	  Select ABI for the kernel code. This ABI is independent of the
+	  supported userspace ABI and any combination of the
+	  kernel/userspace ABI is possible and should work.
+
+	  In case both kernel and userspace support only call0 ABI
+	  all register windows support code will be omitted from the
+	  build.
+
+	  If unsure, choose the default ABI.
+
+config KERNEL_ABI_DEFAULT
+	bool "Default ABI"
+	help
+	  Select this option to compile kernel code with the default ABI
+	  selected for the toolchain.
+	  Normally cores with windowed registers option use windowed ABI and
+	  cores without it use call0 ABI.
+
+config KERNEL_ABI_CALL0
+	bool "Call0 ABI" if CC_HAVE_CALL0_ABI
+	help
+	  Select this option to compile kernel code with call0 ABI even with
+	  toolchain that defaults to windowed ABI.
+	  When this option is not selected the default toolchain ABI will
+	  be used for the kernel code.
+
+endchoice
+
 config USER_ABI_CALL0
 	bool
 
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 725cd4cd8b30..5097caa7bf0c 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -35,6 +35,10 @@ KBUILD_CFLAGS += -ffreestanding -D__linux__
 KBUILD_CFLAGS += -pipe -mlongcalls -mtext-section-literals
 KBUILD_CFLAGS += $(call cc-option,-mforce-no-pic,)
 KBUILD_CFLAGS += $(call cc-option,-mno-serialize-volatile,)
+ifneq ($(CONFIG_KERNEL_ABI_CALL0),)
+KBUILD_CFLAGS += -mabi=call0
+KBUILD_AFLAGS += -mabi=call0
+endif
 
 KBUILD_AFLAGS += -mlongcalls -mtext-section-literals
 
-- 
2.30.2

