Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34AF4A8F58
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiBCUrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356640AbiBCUqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:46:33 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5C1C06174E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:46:02 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bu18so8516534lfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 12:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fm6/WM1aXFuwaAFInnacEGjjm7HROSKZyaeunWFy85Q=;
        b=EB+7VDo0oio3AfLjXuLSp6iozLxATOVsRvDCRYSKDC4dRHRa8GuGMgzNBg4tg2Xtaq
         uu3+nm502DKtfpnMjfCLhX47RbFHaPcqZ1Ap/cehsIkyFRU0CD109PV/k2UlXJs84mZk
         7Aft+fARjfKRk60pMw3eyxJoTpD+7y+rf4d478kXyMFZVg54TRtrY8xmylU8MmXJ9gmE
         qIsC8G8P8vgijQ6+XICJ4axatcywgPRfBO4gE8gGWY4b6j/mNfakbxaUe/IEeCuTE3K2
         fDz2vxKnxjagXfbK+K866SRGzKhDCVY9JxQOclVZz1dgNk13Zh0i2G4OkyCCxinuGBQ5
         nVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fm6/WM1aXFuwaAFInnacEGjjm7HROSKZyaeunWFy85Q=;
        b=E9LY2DR24d8xAOiupU4/64qXxSnPDp9FNjN5pTfL0moZBoyKSOo2033bpjDQjFKbAw
         zYyCQTETEsKaFMHTKQAXJ2m1g9Bm9ml3CL/yepbtvseac76ksx8xqoVvIvmKshc/AJ5h
         3t9YFQ1ujizahNNEZLBNee+SB2tTddNgl8pNjSUvICwEBAqXxpSfVoyW/IQTvAb79iyA
         BMr7jMELs6bFYT+Ld0+3/Qyz26jGtZqBkFjSzQBnLatM7p+o0MvLOLF7UWV/feFXBA9m
         vtmni3B7kFsIiQN1xDGtF9A/t4d63/6ZcNVvbHgtlIdQS8OCfso1n7Ne9yPkNecUNfas
         2eVg==
X-Gm-Message-State: AOAM530tgLZsqUf4OZliB1iu5SZUKykaVgNvwrEYxJxR/SlSaAw1zjXZ
        suM45RqU51PwhdHMtJeUcCxBkMz678Vd0UYc8pXz1D50zpV7Zg==
X-Google-Smtp-Source: ABdhPJzordyV/vbntEzNKU3NgMfL1TqdSMWainolMPsf5aYHMJtZbYurIZW+6FnXNlOUlgdQ/qO9YpSPM8DquTXJTP4=
X-Received: by 2002:a19:6449:: with SMTP id b9mr28158247lfj.82.1643921160689;
 Thu, 03 Feb 2022 12:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20220203204025.1153397-1-keescook@chromium.org>
In-Reply-To: <20220203204025.1153397-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 12:45:49 -0800
Message-ID: <CAKwvOd=7ZDMhnX6Da5_ZMM9yLgrnhjwwPhYwO-RT-3yrPy+RLw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/build: don't build CONFIG_X86_32 as -ffreestanding
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 12:40 PM Kees Cook <keescook@chromium.org> wrote:
>
> From: Nick Desaulniers <ndesaulniers@google.com>
>
> -ffreestanding typically inhibits "libcall optimizations" where calls to
> certain library functions can be replaced by the compiler in certain
> cases to calls to other library functions that may be more efficient.
> This can be problematic for embedded targets that don't provide full
> libc implementations.

While the bcmp shenanigans were ultimately resolved by
commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")
(and this popped up again in
commit 1e1b6d63d634 ("lib/string.c: implement stpcpy")
).  I'm still very much in favor of this patch, and should have
pursued it. Thanks for resending!

-- 
Thanks,
~Nick Desaulniers
