Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17658F45B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiHJWZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiHJWZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:25:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3388D3CD
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:25:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f46b4759bso135718477b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=/a7ZitxlSP2ap4ZvM+L6M2uGM3eiBd8X/p1jSaTtmzc=;
        b=gvTf7ZWl7bgrQX0FgmznsVlAjRR5g0jVQaFB10FKWShAdbh17YEHiWK30kSMKm0HPw
         HW4wiUSMa9nQJwRMaKtlXUyElrBe6GmMJ1hgUsNeickejjwUxGYskgRD0+iyqusguQfJ
         Glt8iQ5CGmdxgrxqACQg0AyuU6Px9CD5gHWOneonqQ9KgOtTmlvnWEz7Q0/0bLxwJfPK
         RCgqDE50mbP4rSUtlWQMxC+dVHgEISHSji3ZUSz39ak6+g4xUlnpt73P+XiDWYUtIM1N
         OZ66+phcLM635OtS8AmPwDWiij3da51yMtsdGZyC5aW120qyTHfhNctsQT90i/CQeC1+
         NYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=/a7ZitxlSP2ap4ZvM+L6M2uGM3eiBd8X/p1jSaTtmzc=;
        b=Fmr8WjBjjN/qGZmYHrbhZkzca0N4wNNCmNltBQPyUZhOaNb/EllF0y0fCQoqjOsK30
         PziySGPWEYRvNZTJiMtgCf7Hst+7hVKpQCPCrwq7vaTKrMlzpFF7LVRpZxreuotmITPQ
         aZ7gowusUtEf7TwOxRcFyHA6wsW+hzAWZcdjAGrCqZdFEcrL+ePz4K8GNZms+ay1nQBp
         bV82L5ywScSW9qeOh5qqaziQe+tjOEQ34bP2VvxAtbRlQoaoAB2UO0vBo/IuEkhGcOiM
         Qn3D+ygy+bqQbj0vzHU4l2WwSQX5BrdEJrYkX+h5po+8iJ75i9qxOcbGdR3IfM7Aa+s5
         4h0w==
X-Gm-Message-State: ACgBeo3iHvGymjNGJboUXbrVX87zU158WqcGZfKU20oNw/Rur5IjXIoN
        qZTbVNlOAe6yMnHSQlbc6FKvJ6mxiUgIVwQorc0=
X-Google-Smtp-Source: AA6agR6Qx2DutA4B5/VXTeQA7KbB5NrdRwVnd0DdZ3u1U5+FBw3DD1DBKB+bC8qLADZQx4xe6oH7OoSLXsokOOExg6Y=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:88ad:cd41:8dd7:539])
 (user=ndesaulniers job=sendgmr) by 2002:a0d:ea57:0:b0:31f:4ebd:99f7 with SMTP
 id t84-20020a0dea57000000b0031f4ebd99f7mr30093800ywe.280.1660170305693; Wed,
 10 Aug 2022 15:25:05 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:24:42 -0700
In-Reply-To: <20220810222442.2296651-1-ndesaulniers@google.com>
Message-Id: <20220810222442.2296651-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220809013653.xtmeekefwkbo46vk@google.com> <20220810222442.2296651-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1660170282; l=1856;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=bGYj2JeGfjSj7Z1PRgZLMWLsr83doiKmqzZ3eFPwnSE=;
 b=hYwaVIszd2RuykHTL5KdXJ9zfQnjr6aWLj4NwCfF0ol4dJZuHX4vCca4b6BWa2I86izYnA8KvTIP
 OhwpBiIsDbYB19eTJQjEYdIBWKFxXd0VwKn+1GMK+DG5i5t6OKnb
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 0/2] link with -z noexecstack --no-warn-rwx-segments
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
        Nick Desaulniers <ndesaulniers@google.com>
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

Broken up into 2 patches; one for the top level vmlinux, one x86
specific since a few places in the x86 build reset KBUILD_LDFLAGS.

Nick Desaulniers (2):
  Makefile: link with -z noexecstack --no-warn-rwx-segments
  x86: link vdso and boot with -z noexecstack --no-warn-rwx-segments

 Makefile                          | 5 +++++
 arch/x86/boot/Makefile            | 2 +-
 arch/x86/boot/compressed/Makefile | 4 ++++
 arch/x86/entry/vdso/Makefile      | 2 +-
 4 files changed, 11 insertions(+), 2 deletions(-)


base-commit: 15205c2829ca2cbb5ece5ceaafe1171a8470e62b
-- 
2.37.1.559.g78731f0fdb-goog

