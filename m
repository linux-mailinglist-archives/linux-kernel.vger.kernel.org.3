Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7A5B28C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiIHVzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiIHVzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F83857883
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f3-20020a056902038300b00696588a0e87so27589ybs.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=++1/qtdOmwUSaxqgiZQTBSEYvAxbI4XHV6GATm9VhUE=;
        b=DAxdaA/TeHYFNkGxc72IwSwNKQuOykXTJDQORvATjh5oTgcXipGkVmqfycb+PUS8Wp
         SXGLVEnuzt4Ps6Cp3jiSeQ9/bxkrOwHccGPNwXMZ4cOSpTui8APRzBdyggwyYN3bpUBU
         csqHhnCeJ1j65G97AeYq/khlWiDGhXIxKGbBc5NpejjSwqU8L1EmcqUWr8+5Rvz54bQa
         6fjvp8eKwXpdwITxvySX9EurH7B9DSaYc1UZa4+fZqlKfV788bJDzyLxtjPFogWibp84
         y3PzkRHda3kd1F0KGkBO4FaaSRROQQWwIa2Op7LMzexNluxxyA67slpTBOHo/cuaH5Xk
         CKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=++1/qtdOmwUSaxqgiZQTBSEYvAxbI4XHV6GATm9VhUE=;
        b=LbYjW8+JOTUjS/neDHeYZng6vKKfV39r5pM0TLyLM8PMJjIHgHI55WIyoKdki7PzNr
         cgkiOPujvSAP19iM2N3cvC5MVTNf1jgKOlF3IGRMKbh90VlhW5ktLXyxTuop5tDbei7P
         k28z53Il+tAMGDhl/18q4bOI2Du51+MP9WEtD+k+7TWnF8SNxa33Z0MgKEveDLV50zFp
         CHYMsfM3Ra2JMldZVGmVU9k0urxpBhO2Zu5gK+Zom7DNtdMrUEFHx4c5Ev2z23R3WsmW
         dI9dP2GHmdzYPzu7Gg6H7rLyGyLz6HGsIgtxM5DC/PcX1xaGHOvxTYcYl0Wae/39cjFN
         fAMA==
X-Gm-Message-State: ACgBeo0LcXYUxDl+Kikbx+3ZJKhKDFSyo/vR/V1uqygW99VCD6VidQ2P
        7LNa7dZnZsOamps49BJVrXfwaUrCEgkOgfiAZMLDTBUmB5mv4z8v4liyzveDbKzzb0i7w5/oqL1
        Tl6Al75iaetUQVJ5MWUj8o/ajbSghOcWqDQzExCPsBNZIVTCqO38Z13fM4cvF1jRxhhO1JXhB2T
        sTWM4GthPGEw==
X-Google-Smtp-Source: AA6agR7Urz8mEtWhFvoUwvvdWySJPZQ7jqpog2D5kyDc+2eNo1L58ipOybnpuwS7VRcYjJKRoWU3GYlVidDt0EeoNs0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a0d:f904:0:b0:345:4639:8253 with SMTP
 id j4-20020a0df904000000b0034546398253mr9771674ywf.438.1662674109557; Thu, 08
 Sep 2022 14:55:09 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:43 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3048; i=samitolvanen@google.com;
 h=from:subject; bh=NqOg6IoR6gX09sXAr0B0cPUiAt3ZJYmbQkr2LJPJNus=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmSyAhdY+c0yuGLwUcRxL94Fo3kpoLG9gssQn6xK
 0NRN0dKJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpksgAKCRBMtfaEi7xW7snLC/
 4kqxfaphRvYnLEvON3wLCWq1o1yoypBX3QcocACz45p22AS2T5hfosvQm9Qoq55kO7fEf6uzqBQuMQ
 kGIPv/gs/+9O5Id/51exiQCxLR2ReTQngCFQ10xRIwfcsM/z45xAQ4nusTdRGj0bHv2gAdmNAXFZ+R
 oJkA10VfP80fqUgAUn0+WpEv6rnxzPuorF9bqiXWBrChAAtoLY5p41e3AExfZGMMh7qKArwCJMFqFB
 y/qs9kY9bk7UdIiNxvzvQmkkzRuNJHtI+Sea40LsKjqkiJ7eQQfMAeEbh2ArJDRu/sBdGkzhU2zhS1
 Y5SHy5RY9gHiNRwadqeXZhe5TTujjTecKJG/HZPk8XNU1EizECc1s+y10rNiGBUlVhI0MRI1NL24fK
 qE0JNaiWlsv2WhYZN6SZ32uY130fpB+FjtHg+/0bVXbfmrvraFK+7dE4e8P3E6F3RvBWXa0RdHztpF
 730W9Oi74vsIeysCfW1gRdtm+goTa2x0/ontLouoIJkP4=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 01/22] treewide: Filter out CC_FLAGS_CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing CC_FLAGS_CFI from CC_FLAGS_LTO, explicitly
filter out CC_FLAGS_CFI in all the makefiles where we currently filter
out CC_FLAGS_LTO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm64/kernel/vdso/Makefile       | 3 ++-
 arch/x86/entry/vdso/Makefile          | 3 ++-
 drivers/firmware/efi/libstub/Makefile | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index bafbf78fab77..619e2dc7ee14 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -40,7 +40,8 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 # kernel with CONFIG_WERROR enabled.
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
 				$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
-				$(CC_FLAGS_LTO) -Wmissing-prototypes -Wmissing-declarations
+				$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
+				-Wmissing-prototypes -Wmissing-declarations
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 12f6c4d714cd..381d3333b996 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -91,7 +91,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 $(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO
 
 #
@@ -153,6 +153,7 @@ KBUILD_CFLAGS_32 := $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_CFI),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 2c67f71f2375..b43fdb319fd4 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -46,6 +46,8 @@ KBUILD_CFLAGS := $(filter-out $(RANDSTRUCT_CFLAGS), $(KBUILD_CFLAGS))
 
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable CFI
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
 # disable LTO
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
-- 
2.37.2.789.g6183377224-goog

