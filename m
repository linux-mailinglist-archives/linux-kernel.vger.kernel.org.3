Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E084573AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbiGMQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbiGMQCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:02:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32AF50714
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:02:11 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o7so19796240lfq.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWhhvtNedj35MafqKUgxobbUIMg+S+RFU2eVuxPt0V0=;
        b=saXm/2DYYz98lsTnnnC4cZtzYwilQkVPbJz+Nt8IPEgjczMyht2rA9hFXIPsqWNa6W
         jI+4KGQifKOciJaWQpa3wxOyh1iDQ3qOjrX7waH11xADUvW1AIhG1JvMAeDQ7DctNFhe
         6hyWOeo/UxxgdDqONL085MaflbXekwYgcWtnVe0XQnbhXnqNnuH3+u1igyds3nyyU+ec
         Bmk6o8eQhP+6F3ls5V7k0sXqT1WMSCC5s4lUxMiIeEvk53wyARe/cqu9v+G3jDWEmEHk
         7ZiVFOQK0Fhy21v6o7n+Mmt8F/NHkiTMTH2vNkK13sxtrvtnVYPzIpjYY7y5VC9zOosC
         QkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWhhvtNedj35MafqKUgxobbUIMg+S+RFU2eVuxPt0V0=;
        b=Zw0uTWUs1t/KZhwgExRmglTwoL2AQX+vz3HH9AtYt51cTROuO74iAywMEoE6giEiew
         T+bDU1DcoOUYp1TNdab4HNrINJPFNhohLY5UcyVBLg9c0gjY218x/wtlcFZ8Fe0xh5J5
         qkyuOdRza9SxAf99hwz8AtMepbjolme7bAFd9hcEuH3Vwkukq77smGd+7detenNm21m2
         XGk1WxpZHnRg1i+GCmryPEghFmgu8d9WPHAXAkJgseEAV300mUAm9RrWaXdCB1+Hgg+9
         QSbigEwFmWf70E/7mp3xDn9CbbIBMVgHMaK7pLQqVjyvbKq0q3NEgH0R0PojSJ2T0Bqk
         i3Vw==
X-Gm-Message-State: AJIora8lAn4uMOTe/P0PH61EklcX6doMmhoQxEINeFCGuQiP4l6wI1kf
        u2yzM0VBcY2TpbmGH3+tWmuimvgIFWWL/vcEqRugIQ==
X-Google-Smtp-Source: AGRyM1tEeAU8wQ+I9NLXcaCNWF3OMoEcj9swPCub58eFdu/CXAS2vrblZpMhD6UCziXF3nb8vHjaU/FZqJjyD96sp1k=
X-Received: by 2002:ac2:4c46:0:b0:489:e93c:69b with SMTP id
 o6-20020ac24c46000000b00489e93c069bmr2291049lfk.403.1657728129923; Wed, 13
 Jul 2022 09:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <Ys7pLq+tQk5xEa/B@dev-arch.thelio-3990X>
In-Reply-To: <Ys7pLq+tQk5xEa/B@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Jul 2022 09:01:58 -0700
Message-ID: <CAKwvOd=kqfAZoywsOFbvvzUJD+zVgFgmDAAcb7h0U8LGzfG33A@mail.gmail.com>
Subject: Re: objtool "'naked' return found in RETHUNK build" with clang + CONFIG_K{A,C}SAN=y
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Wed, Jul 13, 2022 at 8:48 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Josh and Peter,
>
> After commit 9bb2ec608a20 ("objtool: Update Retpoline validation") and
> commit f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs"), I
> see a spew of objtool warnings when building certain configurations with
> clang. Examples below, they appear to trigger in every single file.
>
> With x86_64_defconfig + CONFIG_KASAN=y:
>
> arch/x86/ia32/audit.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> arch/x86/ia32/audit.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> init/version.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> init/version.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> arch/x86/kernel/platform-quirks.o: warning: objtool: asan.module_ctor+0x0: 'naked' return found in RETHUNK build
> init/calibrate.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> init/calibrate.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
>
> With x86_64_defconfig + CONFIG_KCSAN=y:
>
> arch/x86/ia32/audit.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> init/calibrate.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> init/version.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> arch/x86/kernel/fpu/bugs.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> arch/x86/kernel/cpu/rdrand.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> arch/x86/events/probe.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> arch/x86/kernel/apic/ipi.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build

Thanks for the report. I wonder if this might be a compiler bug; it
seems like the {a|t}san.module_{c|d}tor functions are being emitted
with ret instructions?

If you have one of these builds lying around still, can you provide:

$ llvm-objdump -dr --disassemble-symbols=tsan.module_ctor
arch/x86/kernel/fpu/bugs.o

(I'm about to head into a bunch of meetings now, but can check more
this afternoon; see you at Noon)

If Peter and Josh are bored, feel free to stop by
https://meet.google.com/yjf-jyqk-iaz
at Noon PDT / 19:00 UTV today.

>
> If there is any additional information I can provide or patches I can
> test, I am happy to do so!
>
> Cheers,
> Nathan
>


-- 
Thanks,
~Nick Desaulniers
