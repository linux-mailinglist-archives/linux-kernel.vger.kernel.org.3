Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B0A5322D2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiEXGCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiEXGCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:02:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEC862113
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:02:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c10so21709807edr.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nw23TS5XTec30rhvH0nb9YZUl+vCbv2UU1WiPCiZsMU=;
        b=V8AqDG0hACi4K+uvmcUbHpgEMaTCH7TF5Ex6gWm7j4ZB1rwkDjGO1uMbU7iBYO/Q9e
         CW/5NDyKW10LGRgUeNYfi/WJfqByLjwE1KyZIUtRkwEjIMixRlkwhKJ2Z4GYtLMgApap
         eYOF0bOsnr7/l+V2qtd+5rlVirrfOm2pffEYLjyZMW7A7yTOTAmBj0X1qxKnQQCy5eWr
         2j8TyVz3iS4ewfsOnnKasmBbLGkLEuyE3HpWeZ2KOnboHC3+QvWoKyWDVx0ByZZ/f//r
         5JIAfdPGCsm0zvg9TNpTzkWUKvtygpV+d01vfaSuGUEej5MAdjPrl13Ck1cOkTmXBXBj
         E6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Nw23TS5XTec30rhvH0nb9YZUl+vCbv2UU1WiPCiZsMU=;
        b=7Bscy/ceqxtfxTtGMwBQfnhrHvl7MljgBDe3n8gVeygG5gTAa//EArUiMVWvFHAqmO
         C06Vnzh/WF7bvKwz3Q87CbgR3k4d+UMLyinnr6bMw7oR5/8XYb+PnfSXF1Tsgb8/NUcP
         NcKBoK1qkmzdu+EkihSAWJ/9zIwoxX7YfBkafr7blMn8bTzWTHCqbYdpdLx2qZSrTqEh
         1RX9Kf7vcEpb0x9Y6IZrqsGbtoCttexd+EgtPDPzO5rNzkyeSeeC+MDzfi5Adr8a0jiH
         A3/ch240f0IjbIx07F+ZEkVtLL1VxIZnNl+xwk3Q2ye9cZJXDCFUX4BMRthv/P0QtKsD
         d4Ew==
X-Gm-Message-State: AOAM533+DZkXyZhozRtfB3pfS+XK73BDlZgvzsLHuA7XNb/fQKZERxiX
        ehRUVaoUvg1qZ+En9JRePTY=
X-Google-Smtp-Source: ABdhPJxRTStMwC9RaJeh4Ph3l6z0wF+oEk4fi2gamRfVkSe+JLi+Susi1MvcvXNjaggd6Gzn5i522g==
X-Received: by 2002:a05:6402:75a:b0:42a:bbb9:504c with SMTP id p26-20020a056402075a00b0042abbb9504cmr27522865edy.348.1653372150387;
        Mon, 23 May 2022 23:02:30 -0700 (PDT)
Received: from gmail.com (84-236-113-78.pool.digikabel.hu. [84.236.113.78])
        by smtp.gmail.com with ESMTPSA id d16-20020aa7d690000000b0042617ba63c0sm9323733edr.74.2022.05.23.23.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:02:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 24 May 2022 08:02:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] objtool changes for v5.19
Message-ID: <Yox088fRrhh4grBX@gmail.com>
References: <You3JC/BOIyEnmQj@gmail.com>
 <Yoxucp7aUrCaV9uE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yoxucp7aUrCaV9uE@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

>  34 files changed, 959 insertions(+), 684 deletions(-)

Note that with your latest tree you'll get 3 new conflicts:

  CONFLICT (content): Merge conflict in scripts/link-vmlinux.sh
  CONFLICT (content): Merge conflict in scripts/Makefile.build
  CONFLICT (content): Merge conflict in arch/x86/Kconfig

If you want to double check, you can find our resolution in tip:x86/merge:

  a1df7cc57786 Merge branch 'objtool/core' into x86/merge, to resolve conflicts

At:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge # INTERNAL MERGE TREE, DO NOT PULL

Here's the merge description:

 ===================
 The following commits between objtool/core and various x86 branches conflict:

   968b493173ac x86/mm: Make DMA memory shared for TD guest
   77a512e35db7 x86/boot: Avoid #VE during boot for TDX platforms
   65fab5bc033a x86/tdx: Exclude shared bit from __PHYSICAL_MASK
   41394e33f3a0 x86/tdx: Extend the confidential computing API to support TDX guests
   59bd54a84d15 x86/tdx: Detect running as a TDX guest in early boot
   dbae0a934f09 x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"

 and:

   753da4179d08 objtool: Remove --lto and --vmlinux in favor of --link
   489e355b4225 objtool: Add HAVE_NOINSTR_VALIDATION
   0f620cefd775 objtool: Rename "VMLINUX_VALIDATION" -> "NOINSTR_VALIDATION"
   22102f4559be objtool: Make noinstr hacks optional
   4ab7674f5951 objtool: Make jump label hack optional
   26e176896a5b objtool: Make static call annotation optional
   720644749647 objtool: Make stack validation frame-pointer-specific
   03f16cd020eb objtool: Add CONFIG_OBJTOOL
   7dce62041ac3 objtool: Make stack validation optional
   b51277eb9775 objtool: Ditch subcommands
   2daf7faba7de objtool: Reorganize cmdline options
   4cdfc11b2836 x86/Kconfig: fix the spelling of 'becoming' in X86_KERNEL_IBT config
   4a5de9b76fcb objtool: Enable unreachable warnings for CLANG LTO

 Resolve them:

  - overlapping modifications
  - modifying removed functionality

 Conflicts:
	arch/x86/Kconfig
	scripts/Makefile.build
	scripts/link-vmlinux.sh
 ===================

Thanks,

	Ingo
