Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D5046E60A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhLIKBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhLIKBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:01:43 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35095C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 01:58:10 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso6086950wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 01:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WEDTgzpiltL1NT8/HeGXwilTe74ZNI0f4xOOiwCoVRw=;
        b=LGp39MjftM0OspcLXJkgCqcd7OB1O3sI0SITiKJQs5oOZSnbReKaANYsVcPG3PC07h
         07n3KHntv3+ki7Mfzmpsmvcd5VJXySHAPRKSYchciARew9FRWwgvluFC/+KK+bu/8J6S
         lhojSB7axu7nf7VukWinEvvVjiuMOWnwFLLIEpM7YQ8jqPNBcrBavp6w650QNhcYsPk7
         YVK66ta/J7zfFnZNcutQWMjaLELFlkXBHq2wWwpn4vyfUsVBDNvi8h0kmFCG3+Plt94v
         U4d1EGGssf+AMrQY5XZqbfmYSdH23/BIW6vK/ITqaB9iHPSM+46HMUBN9+9wiTJgdQ3L
         V6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WEDTgzpiltL1NT8/HeGXwilTe74ZNI0f4xOOiwCoVRw=;
        b=bMbcpGRll/LKR3ZWtmMaXGwlu2DtaZfrZl3BUu1ZAwmlRBSmJbSHXRa8I2f/LTBcJ3
         zxjYRVkIYalJ65mB8FrxIwJv367CKRY1z3gnn0IY2I6rXhdHiP02aYKd2A1X3GWajt48
         5jtvc8JkTA1s4lH4BYGPgKDDKMX/4cPyX2FkKMP0ksixixsLoKuNk1NxD64faLOVwrXE
         hINQWjqriMQbHTZm2oMey4ziq1LIR7Z9bVlLxyVHcsbLDzI5DKY+EoevwSQvAYpe7XXt
         J7VZuMaeM6Do7cEsDRt53klUYOjLy9ZHa9lFlaD24FksJUKphqlJmdKu8kgS/wGbyADQ
         gBzA==
X-Gm-Message-State: AOAM531oKtC4pciB9Ji7zscboTwTM7ePxKlrN2zatShokOQtfzMRyy/M
        mljY8C51ouC8YFzQnImK84JjqQ==
X-Google-Smtp-Source: ABdhPJxsgxY5kYS121TEh7VHEfUyE1K0dFFItk6fzDJR4MCdR5mdBamlRuqXOBTWaKs1BMSy2HmzsA==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr5903612wml.105.1639043888649;
        Thu, 09 Dec 2021 01:58:08 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:21de:5a72:cfa8:19ce])
        by smtp.gmail.com with ESMTPSA id f15sm6351289wmg.30.2021.12.09.01.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 01:58:07 -0800 (PST)
Date:   Thu, 9 Dec 2021 10:58:01 +0100
From:   Marco Elver <elver@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-toolchains@vger.kernel.org
Subject: randomize_kstack: To init or not to init?
Message-ID: <YbHTKUjEejZCLyhX@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang supports CONFIG_INIT_STACK_ALL_ZERO, which appears to be the
default since dcb7c0b9461c2, which is why this came on my radar. And
Clang also performs auto-init of allocas when auto-init is on
(https://reviews.llvm.org/D60548), with no way to skip. As far as I'm
aware, GCC 12's upcoming -ftrivial-auto-var-init= doesn't yet auto-init
allocas.

add_random_kstack_offset() uses __builtin_alloca() to add a stack
offset. This means, when CONFIG_INIT_STACK_ALL_{ZERO,PATTERN} is
enabled, add_random_kstack_offset() will auto-init that unused portion
of the stack used to add an offset.

There are several problems with this:

	1. These offsets can be as large as 1023 bytes. Performing
	   memset() on them isn't exactly cheap, and this is done on
	   every syscall entry.

	2. Architectures adding add_random_kstack_offset() to syscall
	   entry implemented in C require them to be 'noinstr' (e.g. see
	   x86 and s390). The potential problem here is that a call to
	   memset may occur, which is not noinstr.

A defconfig kernel with Clang 11 and CONFIG_VMLINUX_VALIDATION shows:

 | vmlinux.o: warning: objtool: do_syscall_64()+0x9d: call to memset() leaves .noinstr.text section
 | vmlinux.o: warning: objtool: do_int80_syscall_32()+0xab: call to memset() leaves .noinstr.text section
 | vmlinux.o: warning: objtool: __do_fast_syscall_32()+0xe2: call to memset() leaves .noinstr.text section
 | vmlinux.o: warning: objtool: fixup_bad_iret()+0x2f: call to memset() leaves .noinstr.text section

Switching to INIT_STACK_ALL_NONE resolves the warnings as expected.

To figure out what the right solution is, the first thing to figure out
is, do we actually want that offset portion of the stack to be
auto-init'd?

There are several options:

	A. Make memset (and probably all other mem-transfer functions)
	   noinstr compatible, if that is even possible. This only solves
	   problem #2.

	B. A workaround could be using a VLA with
	   __attribute__((uninitialized)), but requires some restructuring
	   to make sure the VLA remains in scope and other trickery to
	   convince the compiler to not give up that stack space.

	C. Introduce a new __builtin_alloca_uninitialized().

I think #C would be the most robust solution, but means this would
remain as-is for a while.

Preferences?

Thanks,
-- Marco
