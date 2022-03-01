Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA454C957A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiCAUM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCAUMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:12:55 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF87593A8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:12:14 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id s25so23383232lji.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNDp5KXCKeop2yOo8l/8mrZzIPAvGyioW/V2tn2igq8=;
        b=EO9u4Ku7uUzMJhGxZnToQLWVHSB4bnEI2drfTxCzPLe+5ic0u1rMguA3h3bRxU3eoh
         cReVFeLfqv41v3lc3J6nFr4/J+1SwXrqJO18UMmVGOpbxSQmHTbbCyTGYJZ4YXf3+CHs
         6Q7ScdzXZfZmWBKeHWAN1Zbjq5xv2bsu4AH5cQ4cimtfCgojo1pUQQ5M7SgiGwsBydVB
         htmv4EdHl2zD6o3DLHcOUsoVrhimoKH+6sblZoGinbMC61wo3YF6n7Wl94kvm2SRe+Ri
         UwehA2XtceHZx+OtpmA9bfvtnAah569VEqFNIO9b8S3mNUPxDnikkXHpSJk+jSXWArcZ
         +FNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNDp5KXCKeop2yOo8l/8mrZzIPAvGyioW/V2tn2igq8=;
        b=rNWbfFs8qn1PT4K+7hDfs/PjJVVs9iGLBx5cy+ULf1l/qVOfwSQJ+hPyMw9+k18Deq
         BhkG4SEVCq7EH29TbixIDQxO9CcpGnFdbLgD8RWenKu9RdqXzYrlym7lSc0L/Q7n7AO1
         +6s3v0aCltvOIEBvet46zS0TPxAGz90Y2cAk5h8W/JqX4BskkWKsLucNCyAnt/Cv/HLk
         zt36YXjTco+hJYVLhniYQt+QkbV/JJs1VIradzk+NchwVHFQa6HQslur2vDuI0X+xJP+
         TkAuBcmNoSD6fTvb4iuDBvHvqXx/JgdWhPWZ5S797q/oUbS98SIp/RFLBKjRwTc0xZP8
         uJZQ==
X-Gm-Message-State: AOAM532EKQQ9ZMpsM4oArTjom1dnHxrBpLDkD9MoVuD+WReOEcTS1HqP
        7fIXX0iJUGxtnXqvwFjW9CpqfUD2ZQvsL71fGvmjsg==
X-Google-Smtp-Source: ABdhPJxFT25RN4upV+eC9mqObTsE3rwkSU3a9SxEuU0pbBYsUXuPSAtJL86l5x1ByKd9eTwBOET3LqI2vtpo2CE6jm8=
X-Received: by 2002:a05:651c:1791:b0:243:94bd:d94c with SMTP id
 bn17-20020a05651c179100b0024394bdd94cmr17832518ljb.468.1646165531034; Tue, 01
 Mar 2022 12:12:11 -0800 (PST)
MIME-Version: 1.0
References: <20220225032410.25622-1-ashimida@linux.alibaba.com>
 <CANiq72kXoonDYk095XvBwEtRCRNECd1iQOqJHE2cNcgLyUMfcQ@mail.gmail.com>
 <26a0a816-bc3e-2ac0-d773-0819d9f225af@linux.alibaba.com> <CAKwvOdkykPtGTL6ud8qJZHSHKV2eSbpnZE-G4oyymD9BiQKHdg@mail.gmail.com>
 <bf34b523-8477-c18c-e076-e120051cb6a1@linux.alibaba.com>
In-Reply-To: <bf34b523-8477-c18c-e076-e120051cb6a1@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Mar 2022 12:11:59 -0800
Message-ID: <CAKwvOd=6atvH9fJk0jJcqksSQXZ6wFyAvZ1wsZ7UWsEN-soOTg@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v2] AARCH64: Add gcc Shadow Call Stack support
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 4:32 PM Dan Li <ashimida@linux.alibaba.com> wrote:
>
>
>
> On 2/28/22 14:35, Nick Desaulniers wrote:
> > On Sun, Feb 27, 2022 at 11:37 PM Dan Li <ashimida@linux.alibaba.com> wrote:
> >>>> +#ifdef CONFIG_SHADOW_CALL_STACK
> >>>> +#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
> >>>> +#endif
> >>>
> >>> Since both compilers have it, and I guess the `#ifdef` condition would
> >>> work for both, could this be moved into `compiler_types.h` where the
> >>> empty `__noscs` definition is, and remove the one from
> >>> `compiler-clang.h`?
> >>>
> >> In the clang documentation I see __has_feature(shadow_call_stack) is
> >> used to check if -fsanitize=shadow-call-stack is enabled, so I think
> >> maybe it's fine to use "#ifdef CONFIG_SHADOW_CALL_STACK"
> >> instead of "#if __has_attribute(__no_sanitize_address__)" here, then
> >> move it to `compiler_types.h`.
> >
> > Or simply add a #define for __noscs to include/linux/compiler-gcc.h
> > with appropriate guard and leave the existing #ifndef in
> > include/linux/compiler_types.h as is.  I'd prefer that when the
> > compilers differ in terms of feature detection since it's as explicit
> > as possible.
> >
>
> To make sure I understand correctly, that means I should keep
> the current patch unchanged right?

Yes.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
