Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE5951C514
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381940AbiEEQ1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiEEQ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:27:45 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3CF5BE50
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:24:04 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2f7bb893309so54185887b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smRiEfnbDo26TwlBRyyocGS+bQqlFH9vecfF+kAEs0s=;
        b=Qchh5LkpHNgVC4oS9Z3uWgrF0tIOlBwLOSM/ue3hd7CJxr3Xz29EiGWTzgXTX2LwGK
         4uq7mH3isrmT1EXJizLeJvJFDf9LhlUWCoaapbPnape0t+PH8AJj+InrnhX20me7M3HY
         0B22flgiAh5eU+2rzqiChpz1dG3nkkfcoA5K4izNjU7LnZI5qiNJ1bES9xbfWS0aiMLn
         FMtUx1jWRGAWdwCFESrmwS5Fc8W+htfQnqj9NZBWJhEW4YYXh4B6Plfp1rs4wwS80kCy
         61wjIvrcCLt+vJmaIMIapWofk3R5LsYlU1VYyQHWZBjyEYCrwX1AeAxL3OazAT1j/diq
         aQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smRiEfnbDo26TwlBRyyocGS+bQqlFH9vecfF+kAEs0s=;
        b=SMY927Gml8Qj8hxc3or4gT0P09VqsrFrnEsOlUXv/by9ihlRcs8J6KeAMg9A4eqRV/
         A4RXQ8xI5q1SxxwjUQgjygTaSkC4xAzpnH1OFremowY4gLUJYVisum29MhNlYf1yRMJ9
         TLNrvYVWxIS2IjLWJAkTFV5rljEeWfvKPXC2vWdtZFZ3a3ePOpLxH++D1utYC57wEHzf
         xnKtAdnEJXMd36yF6f1Hbq7NUdz91rYxV6NPwy4lijq/Aj1EMrNWXL6FMx2gr/jhmNV9
         E6aPU07tmmcbrT5ir18ee8yvbMqzDWtlXtcP3osr/lcNUSrxvbc0G0cLLytnP473qo9p
         LD+g==
X-Gm-Message-State: AOAM531fh3ExLz65GQjdguZZ+0hVCVIPvq3Ra3FzGbHecxtARtwsOBHY
        w4aX7Megp8Tf4X9ZpfRlFEEOrm9x4ZjUoNpk6ERstQ==
X-Google-Smtp-Source: ABdhPJwBW6nLJQllaWjle33ZcjdAaJs8arGj4v4LRwbmOZTByqaTFnO79d1yMOwsSb1JbpmCL3d16OL6yDeASvHtlUs=
X-Received: by 2002:a81:a93:0:b0:2f4:d65a:d44e with SMTP id
 141-20020a810a93000000b002f4d65ad44emr23725228ywk.243.1651767843390; Thu, 05
 May 2022 09:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-10-samitolvanen@google.com> <YnPw+SiY9Ij/b7Yg@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <YnPw+SiY9Ij/b7Yg@FVFF77S0Q05N.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 5 May 2022 09:23:27 -0700
Message-ID: <CABCJKufjVAbSCcoQZzkemvkmMmwb6DoRYNPu3ADHGoRL_zFPtg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/21] arm64: Add CFI error handling
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 8:45 AM Mark Rutland <mark.rutland@arm.com> wrote:
> It would be a bit nicer if we could encode the register index into the BRK
> immediate, i.e. allocate a range of 32 immediates (or 31 given BLR XZR is
> nonsensical), and have:
>
>         BRK #CFI_BRK_IMM + n
>
> ... where `n` is the Xn index.
>
> That way the kernel doesn't need to know the specific code sequence and
> wouldn't have to decode the instruction to find the relevant register -- we
> could determine that from the ESR alone. That would also avoid tying the
> compiler into a specific code sequence, and would allow that to change.
>
> Since the BRK immediate is 16 bits, we have enough space to also encode the
> index of the wB register, which would allow the kernel's BRK handler to recover
> and log the expected type value and the the value at the target of the branch
> (that latter we can recover from xN, so we don't need wA to be encoded into the
> immediate).

Sure, sounds like a good idea.

> ... does the compiler side of that sound possible?

Yes, this should be doable. I'll take a look and change this in the
next version.

Sami
