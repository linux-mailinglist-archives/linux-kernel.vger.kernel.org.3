Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A50558F459
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiHJWYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiHJWYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:24:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A838C474
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:24:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j144-20020a25d296000000b0067ba828624fso11414600ybg.16
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=SfdBfi7Mx5CiwtaCrFt88m0cxW+5UTO23z89f2bNn7U=;
        b=lFVVLrMHSHntzCbJbyph7o0sN9PiQWnco1EwL5WqfpRf91tH8qslTCY2g6b5jCOk0Y
         ylmBq8ftUplOQdBpBqkp3ThkH4lxxi/CVL77eItkBxjPdQuWw83xFeIVqr7U9p17oTkf
         RuX//pcNkDSuZxN9B4v0bwdy5sxlS409E/UzfLDDS4qa94yMtoSW2wynFs9xpXd+cEe3
         xgSxkLLZB4x8JIDxwsOOwGJg9eXFqXi3+wwN4DSkMjzJloEX1g1jkMyPMG2Tl59W0Cht
         YWY1kwvmssEbmYUYUB1IpOkepodDZTcEealsM8/s47LAOtxjmj1zX5RolaHtaZtjjexX
         CUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=SfdBfi7Mx5CiwtaCrFt88m0cxW+5UTO23z89f2bNn7U=;
        b=tcCPrNn0xAJpV620UGdFadRuaU+JlPRx+ARIzqYzUNLTTila68v1yhOARrsP+Sum4G
         dkMi+aiHBJkj/9+lqWi1p5RK+hEKnQaJWcPwO4scGs3Nl+aj+ti2UDyjXctmdpPcjKHC
         gtOGGdy9eBvlYAiL1rH9410FrFDn9p3G9W2rfy9BXcS1i9FSaKQHG3uN2rrHYi00Mst7
         PTXu1KKyY3D18WMyoBcokFSlg9mYoVZLBbxs6aS5fa0pk7j5fhoMKFVHXmajRLkdc9dj
         wSL0BHCgDLLGbvRq+YJwVtU4kVXaoBDdmqYUeXP1SI/M+m+HUWXUTsIbPOyp7unLXhaV
         q3gQ==
X-Gm-Message-State: ACgBeo1JF5lpae8NhdXkzPTfeFPdnBS/Tpp3J/pHNdAXbWwOTI/Drxsi
        3Si8zaAVtOQHNSTtnQlB1EUYPAPF/0R2UfuMf6I=
X-Google-Smtp-Source: AA6agR4QjOycVp/Hc0eH+Ub7N3pwJKBVI05zs+zNFYtKuxseil48HLi4FC6N8tMyPjHVz3IabbpGdRcPn9GV4DRM+Iw=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:88ad:cd41:8dd7:539])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:102d:b0:676:d624:ee91 with
 SMTP id x13-20020a056902102d00b00676d624ee91mr26116199ybt.10.1660170289777;
 Wed, 10 Aug 2022 15:24:49 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:24:40 -0700
In-Reply-To: <20220809013653.xtmeekefwkbo46vk@google.com>
Message-Id: <20220810222442.2296651-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220809013653.xtmeekefwkbo46vk@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1660170281; l=2213;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=NinzIQmJcVXIzZMcPO+2uxtDhfBTzMzImrwCDVtvkFI=;
 b=KwgbZQliMALRYCIiUtuswI2ERGyH/jroMTb2yxtIvxH5YrYQgqdkc82NBm+3bqWUsKHABcX+vMgf
 ou2NSWLDDw2gBtN4XOxLwNlbbjGhaKdIrRpkZSYVD5Ow5Td6GGTM
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 1/2] Makefile: link with -z noexecstack --no-warn-rwx-segments
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Fangrui Song <maskray@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Clifton <nickc@redhat.com>, axboe@kernel.dk,
        brijesh.singh@amd.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, michael.roth@amd.com, n.schier@avm.de,
        nathan@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        trix@redhat.com, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users of GNU ld (BFD) from binutils 2.39+ will observe multiple
instances of a new warning when linking kernels in the form:

  ld: warning: vmlinux: missing .note.GNU-stack
  section implies executable stack
  ld: NOTE: This behaviour is deprecated and will be removed in a future
  version of the linker
  ld: warning: vmlinux has a LOAD segment with RWX permissions

Generally, we would like to avoid the stack being executable. Because
there could be a need for the stack to be executable, assembler sources
have to opt-in to this security feature via explicit creation of the
.note.GNU-stack feature (which compilers create by default) or command
line flag --noexecstack. Or we can simply tell the linker the production
of such sections is irrelevant and to link the stack as --noexecstack.

LLVM's LLD linker defaults to -z noexecstack, so this flag isn't
strictly necessary when linking with LLD, only BFD, but it doesn't hurt
to be explicit here for all linkers IMO. --no-warn-rwx-segments is
currently BFD specific and only available in the current latest release,
so it's wrapped in an ld-option check.

While the kernel makes extensive usage of ELF sections, it doesn't use
permissions from ELF segments.

Link: https://lore.kernel.org/linux-block/3af4127a-f453-4cf7-f133-a181cce06f73@kernel.dk/
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ba951afb99912da01a6e8434126b8fac7aa75107
Link: https://github.com/llvm/llvm-project/issues/57009
Reported-by: Jens Axboe <axboe@kernel.dk>
Suggested-by: Fangrui Song <maskray@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index dc6295f91263..230e6e7679f9 100644
--- a/Makefile
+++ b/Makefile
@@ -1033,6 +1033,11 @@ KBUILD_CFLAGS   += $(KCFLAGS)
 KBUILD_LDFLAGS_MODULE += --build-id=sha1
 LDFLAGS_vmlinux += --build-id=sha1
 
+KBUILD_LDFLAGS	+= -z noexecstack
+ifeq ($(CONFIG_LD_IS_BFD),y)
+KBUILD_LDFLAGS	+= $(call ld-option,--no-warn-rwx-segments)
+endif
+
 ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
 LDFLAGS_vmlinux	+= $(call ld-option, -X,)
 endif
-- 
2.37.1.559.g78731f0fdb-goog

