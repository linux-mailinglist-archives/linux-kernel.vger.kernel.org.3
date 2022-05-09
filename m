Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0EB520583
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbiEITyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbiEITyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:54:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132301D5033
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 12:50:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t25so25637051lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUw4VaKIzxrbYNwvojWVRe8W2wHxEMMJeCH5HQ+Oo5w=;
        b=RjU5sRMW3dnGEQjLoVoh4aJgCLuyLKWdPccKJsojGEtVqmZdIWkuXQWc9cF7Ej/2zB
         HHBnEjo99v2jfWA+f/P7jQnzyexM6xakAs3aIrOnzRgfKtuGeHzQS3SbhFzdm7S50A3n
         CCt1j4XXaSI71WLPsEoU+4V1qUNuSDxf0GOQG3PMYwyljAmf5EHaLuATgVBaCvoKesTp
         oKSRvrU6Cu287E6FaG2f6Z4zpZnAJM+BixQ0Ttko8R8KvNTVwvRnaH9bPHU3fbH0HU95
         guFNGhyt9baLgCmsZ781fRIugm3e8RB6RjXGultZMfiuIG3cf/X8T+7P/8p+jI6gfCNF
         GTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUw4VaKIzxrbYNwvojWVRe8W2wHxEMMJeCH5HQ+Oo5w=;
        b=DdlBMJ9ijEotqZPGsAW4kDH3JIdVECjTxHp2+ti0nBOfnug2bs2cFepRpTdvzp+MPO
         Ca5kmh6c6KHFcjRxl6q/ar5NcI+TxVScuf8ENRsGZIvsBdyQL2iHWV8odEGyuf2tA4rh
         PwFdY6Ymo+RDj2WBx38DpHyoCN1VBqAVoO3OGYCXYl6DM4bEnVTfvxw7kaMPuqHCExtD
         vL5TWBMfunV+Qow9A9s3B9jkVZW1TQKDihIjXUmbCKXvvrmzG4Ar7BLqFiYUY5nU5k+f
         7CF3vN+85qkeGwHtDl/wnLc7AuJNnd0HnYjPgT521Izqmqe7KkXKgQLh8SVPSBz9BgsL
         ACPg==
X-Gm-Message-State: AOAM531YPCq5stvRL3LEJP3nzYDRTXX602CfB4S11uQ51mkuzylZAUAa
        AVUlcJXpyW9sy9tvc2kCodRDGsaOwETSYJ1g3G2HCA==
X-Google-Smtp-Source: ABdhPJywhFfJnbeomWArH6XEZjkjyPnKkE+73BynU3wttwwSJWub8YJXqwbxg5a4RUAhdOQKKz5bS9lQAR0Di7Rvhzg=
X-Received: by 2002:a05:6512:48f:b0:472:3c47:94a0 with SMTP id
 v15-20020a056512048f00b004723c4794a0mr13708380lfq.579.1652125814206; Mon, 09
 May 2022 12:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220306171009.1973074-1-mailhol.vincent@wanadoo.fr>
 <20220508100907.61231-1-mailhol.vincent@wanadoo.fr> <CAK8P3a3Fw2T0WSkxv4DiTG2wGkKcs24StPx-BG_vi=ffa9OLVA@mail.gmail.com>
 <CAMZ6RqK9d0hFwYebaArKjod4LJVGQgfDygpbGdBu-4BCDUR_SA@mail.gmail.com>
 <YnhXgzhghfi17vMX@dev-arch.thelio-3990X> <CAMZ6RqL7543LFU7ywbr-FV9A3n+m7zNy-J00j=ZrNMkDonq2aw@mail.gmail.com>
In-Reply-To: <CAMZ6RqL7543LFU7ywbr-FV9A3n+m7zNy-J00j=ZrNMkDonq2aw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 May 2022 12:50:01 -0700
Message-ID: <CAKwvOdniSVMOwkBke2EcgONn_Vmv88M+B2FTYL_BKtWawCSLAw@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] x86/build: add -fno-builtin flag to prevent shadowing
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 8:01 AM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
>
> Instead, I am thinking of just using -fno-builtin-ffs to remove
> the annoying -Wshadow warning. Would that make more sense?

Perhaps a pragma would be the best tool to silence this instance of
-Wshadow?  I understand what GCC is trying to express, but the kernel
does straddle a weird place between -ffreestanding and a "hosted" env.
-- 
Thanks,
~Nick Desaulniers
