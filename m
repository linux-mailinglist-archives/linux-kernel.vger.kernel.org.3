Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA1357FF5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiGYMzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiGYMzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:55:14 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8576D1E6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:55:10 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h16so5633510ila.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3b1v6Mgf7ucnDr/oMrJlG8tjEQ/ANlrgzIFnlkN8kLM=;
        b=doWIbhSFyCtiiI4N1Cx8+iT6a//VvEss4vVJnKiTZr9DnqaVLlfT5qWvONZl/zvlqq
         ySpANVja0ZFf0zreJzIPc4ln00o5uQCZ1bfGznHa09MiTxbf/++U4ox+I4xcHEg242cc
         WRTr+3qyNQyMyWI53IEKJeX18qJ5+jUpc9ZkKugENjfDajNh2MIgMBPspBwILb/hLr3p
         keKtO56m3njzgfdhbif7EZm1v7Uia69yQOr6uMa1nrDouxrse5sUGlghAu+ROYRmSuFR
         UQUXDU995xGTSTVa+tpjuBlKgHzUA7z1RBSIgO1eZAXt2nagUZ1z3QbWRrCWNADZbdnn
         AZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=3b1v6Mgf7ucnDr/oMrJlG8tjEQ/ANlrgzIFnlkN8kLM=;
        b=pNwLE/rfUfqA0+/pbRsc0I9MoZLJuFsRRm1QXx63utDlFs+f7En5/xXTJUAmJTHiE2
         hx5EogfRrEnwJSi3ru2aEPSJLVf6NJRzUdaSTYpz8h1A68LcZ1P3LvVcJ2vH6AMfr41o
         DboAsDISjLPKCLETKgxHNs9OuRFVjImVhB9bb5wHaJVsF779TIbVo8zsoLwPs+al6+tB
         r2sAN93wP6KZM7MF1w4t6p9UMZMvcpvWeXI/jJvJr9Dx4d9xgTnbY5w6AEqDDe7+w8JL
         M2c9XN3BIURCqyJ4VrCeSnLPrm5AVy7B/fy2hiZeJOuR5VjE6hLVVgbhr19wKtX7CKTo
         ElGg==
X-Gm-Message-State: AJIora+5/3H2mT2NYUJNrJNUn6uBGPjaEHjcbIyuVMsaxV2MAYT/GFuf
        e8SGTfChJ0zrrzzlM6WeW1qT3k1gAVKd8vc49ELAkoUVgGo=
X-Google-Smtp-Source: AGRyM1s10l/jKpsn+lcbyVLm+gjD09xoefAFTRJFRlEbwpxxW0zs6idof08n5XjVNpLnGIJcCNM/LNbo43I88zCn6Vw=
X-Received: by 2002:a05:6e02:1e04:b0:2dd:46f6:87ae with SMTP id
 g4-20020a056e021e0400b002dd46f687aemr2397357ila.36.1658753709680; Mon, 25 Jul
 2022 05:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
In-Reply-To: <20220725083904.56552-1-huangjie.albert@bytedance.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 25 Jul 2022 20:54:58 +0800
Message-ID: <CABKxMyOMY9sqh8yqiRs0s3-RPf3caLPJvJeFWDqDZTqy6QJKAA@mail.gmail.com>
Subject: Fwd: [PATCH 0/4] faster kexec reboot
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Albert Huang <huangjie.albert@bytedanc=
e.com>
Date: 2022=E5=B9=B47=E6=9C=8825=E6=97=A5=E5=91=A8=E4=B8=80 16:39
Subject: [PATCH 0/4] faster kexec reboot
To:
Cc: huangjie.albert <huangjie.albert@bytedance.com>, Thomas Gleixner
<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
<x86@kernel.org>, H. Peter Anvin <hpa@zytor.com>, Eric Biederman
<ebiederm@xmission.com>, Masahiro Yamada <masahiroy@kernel.org>,
Michal Marek <michal.lkml@markovi.net>, Nick Desaulniers
<ndesaulniers@google.com>, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com>, Michael Roth
<michael.roth@amd.com>, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com>, Nathan Chancellor
<nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sean
Christopherson <seanjc@google.com>, Joerg Roedel <jroedel@suse.de>,
Mark Rutland <mark.rutland@arm.com>, Kees Cook
<keescook@chromium.org>, <linux-kernel@vger.kernel.org>,
<kexec@lists.infradead.org>, <linux-kbuild@vger.kernel.org>


From: "huangjie.albert" <huangjie.albert@bytedance.com>

In many time-sensitive scenarios, we need a shorter time to restart
the kernel. However, in the current kexec fast restart code, there
are many places in the memory copy operation, verification operation
and decompression operation, which take more time than 500ms. Through
the following patch series. machine_kexec-->start_kernel only takes 15ms

How to measure time:

c code:
uint64_t current_cycles(void)
{
    uint32_t low, high;
    asm volatile("rdtsc" : "=3Da"(low), "=3Dd"(high));
    return ((uint64_t)low) | ((uint64_t)high << 32);
}
assembly code:
       pushq %rax
       pushq %rdx
       rdtsc
       mov   %eax,%eax
       shl   $0x20,%rdx
       or    %rax,%rdx
       movq  %rdx,0x840(%r14)
       popq  %rdx
       popq  %rax
the timestamp may store in boot_params or kexec control page, so we can
get the all timestamp after kernel boot up.

huangjie.albert (4):
  kexec: reuse crash kernel reserved memory for normal kexec
  kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
  x86: Support the uncompressed kernel to speed up booting
  x86: boot: avoid memory copy if kernel is uncompressed

 arch/x86/Kconfig                   | 10 +++++++++
 arch/x86/boot/compressed/Makefile  |  5 ++++-
 arch/x86/boot/compressed/head_64.S |  8 +++++--
 arch/x86/boot/compressed/misc.c    | 35 +++++++++++++++++++++++++-----
 arch/x86/purgatory/purgatory.c     |  7 ++++++
 include/linux/kexec.h              |  9 ++++----
 include/uapi/linux/kexec.h         |  2 ++
 kernel/kexec.c                     | 19 +++++++++++++++-
 kernel/kexec_core.c                | 16 ++++++++------
 kernel/kexec_file.c                | 20 +++++++++++++++--
 scripts/Makefile.lib               |  5 +++++
 11 files changed, 114 insertions(+), 22 deletions(-)

--
2.31.1
