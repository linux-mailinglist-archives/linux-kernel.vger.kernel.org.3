Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FCF500292
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbiDMXXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239203AbiDMXW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 242625640C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ykPgi6kXIPquInV89bqGLiN6dgrVRp+D+st6086CdO8=;
        b=FZDvE8N6OHxbVz19AzW6yZbRRfNtJF2BU6/I9wewzqnNAgv9sAVX1S0bH6D9cPE1uRbfIX
        tsDWFUcmfx1mobtNgVle2nJAQh3L3AV7aTHcY56Iy6X7/309QlFVX7pv3w5hi44Awae+3q
        9+VTPXglk52rteQbFqY8zv5FP0aaW10=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-T3Va0v85PI2CQa2T4a802Q-1; Wed, 13 Apr 2022 19:20:26 -0400
X-MC-Unique: T3Va0v85PI2CQa2T4a802Q-1
Received: by mail-qt1-f200.google.com with SMTP id o9-20020ac85549000000b002f1d0c8346eso2191298qtr.21
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykPgi6kXIPquInV89bqGLiN6dgrVRp+D+st6086CdO8=;
        b=JYYgdFNmjj4YwqRAXmgzvB8JkkLrIsjgxnhJHUqESITB+IO/un1BQkJBg4aAbuaakp
         36k6Kj41gcVC34MucTLqaO40n8pk3AqC1PNewfdMMVSz4T8OhlSB5DSC4IbPY8gi6201
         Yk2rONFQ/BmMskw6n09VODOIfLGEGfGHOc576dy651i59HUhWHM4a+F5mNDcYALBNg+j
         lGVT+4BfoipzI1FFg3/xU8wo5CKotZ+/udGV65UjslZW4ZcmMvHj8Nhmauq0/T9va9JM
         yF9r8iag8gXIU9W6DSuW1sUbk77/rhfApYu5lVpc/hnvhGW8B55KdE4+RuYOdE5elDgw
         PY7Q==
X-Gm-Message-State: AOAM533SpINcZNkMK8tu9/oxFKdWCkp3TZSwI2c/k9PsYdnyB2Xh9xvg
        FR41nP20sQRcqZQ8hWNZw7tF1Ob7iiIpEI9Kxs/zVTFkWkCfEi1UNh2YOFeKpc96pkUTVVGGZ+Z
        BCk8PO3byR4c508xECOcYEw+/
X-Received: by 2002:ac8:43cc:0:b0:2eb:dc8a:d5c5 with SMTP id w12-20020ac843cc000000b002ebdc8ad5c5mr9087838qtn.663.1649892025905;
        Wed, 13 Apr 2022 16:20:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo9kd0sfypkmA2cvPjqzNpbO8IsWN9VqVvd6yiEJYpM9GU3JlSRzpLqChHQF7LXnpXhkyhBQ==
X-Received: by 2002:ac8:43cc:0:b0:2eb:dc8a:d5c5 with SMTP id w12-20020ac843cc000000b002ebdc8ad5c5mr9087822qtn.663.1649892025621;
        Wed, 13 Apr 2022 16:20:25 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:25 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 18/18] objtool: Update documentation
Date:   Wed, 13 Apr 2022 16:19:53 -0700
Message-Id: <b24f00f40327d50defa72a125a66100a79b5f716.1649891421.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649891421.git.jpoimboe@redhat.com>
References: <cover.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The objtool documentation is very stack validation centric.  Broaden the
documentation and describe all the features objtool supports.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 .../{stack-validation.txt => objtool.txt}     | 122 +++++++++++++++---
 1 file changed, 102 insertions(+), 20 deletions(-)
 rename tools/objtool/Documentation/{stack-validation.txt => objtool.txt} (80%)

diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/objtool.txt
similarity index 80%
rename from tools/objtool/Documentation/stack-validation.txt
rename to tools/objtool/Documentation/objtool.txt
index 30f38fdc0d56..8a671902a187 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -1,15 +1,103 @@
-Compile-time stack metadata validation
-======================================
+Objtool
+=======
 
+The kernel CONFIG_OBJTOOL option enables a host tool named 'objtool'
+which runs at compile time.  It can do various validations and
+transformations on .o files.
 
-Overview
+Objtool has become an integral part of the x86-64 kernel toolchain.  The
+kernel depends on it for a variety of security and performance features
+(and other types of features as well).
+
+
+Features
 --------
 
-The kernel CONFIG_STACK_VALIDATION option enables a host tool named
-objtool which runs at compile time.  It has a "check" subcommand which
-analyzes every .o file and ensures the validity of its stack metadata.
-It enforces a set of rules on asm code and C inline assembly code so
-that stack traces can be reliable.
+Objtool has the following features:
+
+- Stack unwinding metadata validation -- useful for helping to ensure
+  stack traces are reliable for live patching
+
+- ORC unwinder metadata generation -- a faster and more precise
+  alternative to frame pointer based unwinding
+
+- Retpoline validation -- ensures that all indirect calls go through
+  retpoline thunks, for Spectre v2 mitigations
+
+- Retpoline call site annotation -- annotates all retpoline thunk call
+  sites, enabling the kernel to patch them inline, to prevent "thunk
+  funneling" for both security and performance reasons
+
+- Non-instrumentation validation -- validates non-instrumentable
+  ("noinstr") code rules, preventing instrumentation in low-level C
+  entry code
+
+- Static call annotation -- annotates static call sites, enabling the
+  kernel to implement inline static calls, a faster alternative to some
+  indirect branches
+
+- Uaccess validation -- validates uaccess rules for a proper
+  implementation of Supervisor Mode Access Protection (SMAP)
+
+- Straight Line Speculation validation -- validates certain SLS
+  mitigations
+
+- Indirect Branch Tracking validation -- validates Intel CET IBT rules
+  to ensure that all functions referenced by function pointers have
+  corresponding ENDBR instructions
+
+- Indirect Branch Tracking annotation -- annotates unused ENDBR
+  instruction sites, enabling the kernel to "seal" them (replace them
+  with NOPs) to further harden IBT
+
+- Function entry annotation -- annotates function entries, enabling
+  kernel function tracing
+
+- Other toolchain hacks which will go unmentioned at this time...
+
+Each feature can be enabled individually or in combination using the
+objtool cmdline.
+
+
+Objects
+-------
+
+Typically, objtool runs on every translation unit (TU, aka ".o file") in
+the kernel.  If a TU is part of a kernel module, the '--module' option
+is added.
+
+However:
+
+- If noinstr validation is enabled, it also runs on vmlinux.o, with all
+  options removed and '--noinstr' added.
+
+- If IBT or LTO is enabled, it doesn't run on TUs at all.  Instead it
+  runs on vmlinux.o and linked modules, with all options.
+
+In summary:
+
+  A) Legacy mode:
+             TU: objtool [--module] <options>
+        vmlinux: N/A
+         module: N/A
+
+  B) CONFIG_NOINSTR_VALIDATION=y && !(CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y):
+             TU: objtool [--module] <options>	// no --noinstr
+        vmlinux: objtool --noinstr		// other options removed
+         module: N/A
+
+  C) CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y:
+             TU: N/A
+        vmlinux: objtool --noinstr <options>
+         module: objtool --module --noinstr <options>
+
+
+Stack validation
+----------------
+
+Objtool's stack validation feature analyzes every .o file and ensures
+the validity of its stack metadata.  It enforces a set of rules on asm
+code and C inline assembly code so that stack traces can be reliable.
 
 For each function, it recursively follows all possible code paths and
 validates the correct frame pointer state at each instruction.
@@ -20,14 +108,6 @@ alternative execution paths to a given instruction (or set of
 instructions).  Similarly, it knows how to follow switch statements, for
 which gcc sometimes uses jump tables.
 
-(Objtool also has an 'orc generate' subcommand which generates debuginfo
-for the ORC unwinder.  See Documentation/x86/orc-unwinder.rst in the
-kernel tree for more details.)
-
-
-Why do we need stack metadata validation?
------------------------------------------
-
 Here are some of the benefits of validating stack metadata:
 
 a) More reliable stack traces for frame pointer enabled kernels
@@ -113,9 +193,6 @@ c) Higher live patching compatibility rate
    For more details, see the livepatch documentation in the Linux kernel
    source tree at Documentation/livepatch/livepatch.rst.
 
-Rules
------
-
 To achieve the validation, objtool enforces the following rules:
 
 1. Each callable function must be annotated as such with the ELF
@@ -177,7 +254,8 @@ Another possible cause for errors in C code is if the Makefile removes
 -fno-omit-frame-pointer or adds -fomit-frame-pointer to the gcc options.
 
 Here are some examples of common warnings reported by objtool, what
-they mean, and suggestions for how to fix them.
+they mean, and suggestions for how to fix them.  When in doubt, ping
+the objtool maintainers.
 
 
 1. file.o: warning: objtool: func()+0x128: call without frame pointer save/setup
@@ -358,3 +436,7 @@ ignore it:
     OBJECT_FILES_NON_STANDARD := y
 
   to the Makefile.
+
+NOTE: OBJECT_FILES_NON_STANDARD doesn't work for link time validation of
+vmlinux.o or a linked module.  So it should only be used for files which
+aren't linked into vmlinux or a module.
-- 
2.34.1

