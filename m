Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10E9528C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344456AbiEPR5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243687AbiEPR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:57:53 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0AE39BBA
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:57:52 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2fedd26615cso49672067b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L6QoMgtwgL3tJe4GB/Ih7yflwSG3aQ00OepOaXpJEe4=;
        b=Zc6rshDMluaKoextbWcKCqT45DJDCK0JaPZ3RS4WxflJ5a/2R1FtVZTwvZq/ZC+Hvw
         EfTgd2+B7ClPEcqSvU7y+b3GnV3yZWIyV0f1D6fXPWl0YrRfJlN8YBXVUZIakI1yYwgV
         W4b5WxKlmQsSVJR+9wPV9YQIYhgG0gWlW6dezlkbaCdnwmnqx3jrkWESEoyVo3pBP70l
         Qlwl1jFhJ0WQL2n/xxb4UQS1lDEFsNc2shbbjfcRimzgDljTstePWW/JNSIYVgBB78oh
         oE9ddI7QjLL2xzK+HSxXR23YnlhEVDKmwQwb9PS+RBv0cSQTk6RBLlYpJBELdGn4zXxI
         i1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L6QoMgtwgL3tJe4GB/Ih7yflwSG3aQ00OepOaXpJEe4=;
        b=8CnED+wpqfszZU83+DYCb08g/vzmS1R6GlOizoAJ4LTwYercDYG5J2MLxff+HROXgU
         dV0cIEyDrzJGbDwCEPKa8jiIa1DqXGwMkH8+eV5Tfqs1/cNgtVtJgnUO2HhN8pw+bFWF
         MP9nNyfErf24Q6wDQKmrmCT1uwYwuz/zKIIGSGcE7j9BHCnFz1Ou6aCuIRxMuXatZbV+
         UGVqSsFFuq34+668YiogbRgV89XGO/fiWtFbBXOyBynty0yS1JxEcGm2oWxyjcMlpvLa
         UagqdQdFxEjQ4WAgYnzORxVNNPDY4U6N7lwMeGGUaYI9y2lmptEEpdgA+0Bp+ulRCowU
         SXUA==
X-Gm-Message-State: AOAM532F5k8mIWpDnkcLPJSBaIc24HiKjcpPaztfymKLivA9+qXCbZw3
        N4gJre0Mj2SqvwpnZtDfreZqFbC0QqhzSeytDWRDwg==
X-Google-Smtp-Source: ABdhPJyidyZ+9MInh37119ah6yTP6kCC84bdJzFaKW0zxyWyF1nd0YJqkrMB3Pbhc+Z/UFHH1FjJwSyi6hpdSvHXSCM=
X-Received: by 2002:a81:7953:0:b0:2fe:f8a9:7e45 with SMTP id
 u80-20020a817953000000b002fef8a97e45mr6834348ywc.23.1652723871208; Mon, 16
 May 2022 10:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com> <CA+icZUWr+-HjMvY1VZf+nqjTadxSTDciux0Y5Y-+p_j4o7CmXg@mail.gmail.com>
In-Reply-To: <CA+icZUWr+-HjMvY1VZf+nqjTadxSTDciux0Y5Y-+p_j4o7CmXg@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 10:57:15 -0700
Message-ID: <CABCJKueVcwYishxSoEyn9b1vaGTXdoYWF7VyANPm7V=H+yyfhQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] KCFI support
To:     sedat.dilek@gmail.com
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, May 16, 2022 at 10:31 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> Anything Like LLVM cmake Options to be condidered and Set?
>
>
> I activate Clang and LLD ad projects - OK - enough?

Clang and LLD should be sufficient.

>> This series is also available in GitHub:
>>
>>   https://github.com/samitolvanen/linux/commits/kcfi-rfc-v2
>>
>>
>>
>
>> Can you please add a history of what changed?

Oops, I forgot to include that.

Changes in v2:
- Changed the compiler patch to encode arm64 target and type details
in the ESR, and updated the kernel error handling patch accordingly.
- Changed the compiler patch to embed the x86_64 type hash in a valid
instruction to avoid special casing objtool instruction decoding, and
added a __cfi_ symbol for the preamble. Changed the kernel error
handling and manual type annotations to match.
- Dropped the .kcfi_types section as that=E2=80=99s no longer needed by
objtool, and changed the objtool patch to simply ignore the __cfi_
preambles falling through.
- Dropped the .kcfi_traps section on arm64 as it=E2=80=99s no longer needed=
,
and moved the trap look-up code behind CONFIG_ARCH_USES_CFI_TRAPS,
which is selected only for x86_64.
- Dropped __nocfi attributes from arm64 code where CFI was disabled
due to address space confusion issues, and added type annotations to
relevant assembly functions.
- Dropped __nocfi from __init.

> Nathan has a i915 cfi patch in His personal kernel.org Git.
> Is this relevant to kcfi?

It fixes a type mismatch, so in that sense it's relevant.

> To distinguish between clang-cfi we should use different kbuild variables=
 for kcfi.

The plan is to replace the current CFI implementation. Does reusing
the kbuild variable names cause a problem?

Sami
