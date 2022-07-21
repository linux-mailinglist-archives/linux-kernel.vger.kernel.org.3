Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC00357CB8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiGUNLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiGUNLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:11:34 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767E02B607
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:11:24 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2ef5380669cso16459697b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3KJW7Fmbq5f+eNMw6VzguHX0B49FKPw4A5l5sLUXhGo=;
        b=cDDJz93vgcNNLNytxqCbx8V77gcnQB+j09ztN3Q/A3wfSuguHHr5vSGyiDed9ADcd6
         Qu8RozwM8yO7TnX8u91/tggfA68L2JN2YkymYnnjqHMkjhSx+8Y73kM+UE8/hiVaa1Xv
         N9gvNrjJro7Zs83exyXlClnG1UGLhSE5k5vtiC7qEjl6+nITPm1PvNpvnOsAvO7FTTOP
         o7HkYit2MdLNBhbVQ6J99MG+RyRcpRVTLE2ecIuE5B2p82n95kJOVCFpALnohXFpZdXQ
         MR+CqTl70MXZZUY30UZxA8llahXQgVjFk0T38Xz+7+cfOil+jfutmR3l7AVmBo5f+Ktk
         RK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3KJW7Fmbq5f+eNMw6VzguHX0B49FKPw4A5l5sLUXhGo=;
        b=ehWRkCklsNL0nI/ba0Nsp15SHjJW5LbZVaxu7UF7Ll8zNY2BtKshlYkBZ0DnmATUDi
         N2HGzDDuXuRGw0Vju3lBMYvi/0b0G6GjaRMltTESSpZeY5z1+OAXyfSKn/uB/PiUj7oB
         UkrInOEGcuuvfxFoX0NtXDrk3bKptaOJrdG2P6N35qnEFEDQuyPd4OaRgKYGUbGB8f7e
         EZSdyZtMyyXj/gRMQfzqBrUqMiZCynTF2Evjq/sID+xNjvtxuuOSIB+X+mNfInqOB7Hn
         IBIMzOSFdunkAT2uNROTyGgde0zuHTJr+QTUj8qq8dD5vwJ/H6VPKwVPaXyYUp+tC5Tt
         Svhg==
X-Gm-Message-State: AJIora+Vtri/VIIosGjJbfeFcEFhe9cHhBYdRsd/lIzqRkYnq9XwI+uI
        2y4EJPDq9SgfC9W7xTLofHiAYYe2+Js6ILGrrA04ig==
X-Google-Smtp-Source: AGRyM1tLbjkCEhNkeUKj/DUOSL8lYPgWAKfYilQsa2HaMoE1cLwd43UsQsq1xN/a3T6kp4jx0N2DPCYHvCLYCBtYo8I=
X-Received: by 2002:a81:a1ca:0:b0:31e:58d4:e724 with SMTP id
 y193-20020a81a1ca000000b0031e58d4e724mr15075845ywg.486.1658409083510; Thu, 21
 Jul 2022 06:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com> <20220712231328.5294-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220712231328.5294-3-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 21 Jul 2022 15:10:47 +0200
Message-ID: <CAG_fn=U55CSG=xQ8-0Rj9eXrS29n-DiLdCZbqSSRdqiWW9o0fQ@mail.gmail.com>
Subject: Re: [PATCHv5 02/13] x86: CPUID and CR3/CR4 flags for Linear Address Masking
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 1:13 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Enumerate Linear Address Masking and provide defines for CR3 and CR4
> flags.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>


> ---
>  arch/x86/include/asm/cpufeatures.h          | 1 +
>  arch/x86/include/uapi/asm/processor-flags.h | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index 03acc823838a..6ad5841e087f 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -300,6 +300,7 @@
>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 *=
/
>  #define X86_FEATURE_AVX_VNNI           (12*32+ 4) /* AVX VNNI instructio=
ns */
>  #define X86_FEATURE_AVX512_BF16                (12*32+ 5) /* AVX512 BFLO=
AT16 instructions */
> +#define X86_FEATURE_LAM                        (12*32+26) /* Linear Addr=
ess Masking */
>
>  /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
>  #define X86_FEATURE_CLZERO             (13*32+ 0) /* CLZERO instruction =
*/
> diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/inclu=
de/uapi/asm/processor-flags.h
> index c47cc7f2feeb..d898432947ff 100644
> --- a/arch/x86/include/uapi/asm/processor-flags.h
> +++ b/arch/x86/include/uapi/asm/processor-flags.h
> @@ -82,6 +82,10 @@
>  #define X86_CR3_PCID_BITS      12
>  #define X86_CR3_PCID_MASK      (_AC((1UL << X86_CR3_PCID_BITS) - 1, UL))
>
> +#define X86_CR3_LAM_U57_BIT    61 /* Activate LAM for userspace, 62:57 b=
its masked */
> +#define X86_CR3_LAM_U57                _BITULL(X86_CR3_LAM_U57_BIT)
> +#define X86_CR3_LAM_U48_BIT    62 /* Activate LAM for userspace, 62:48 b=
its masked */
> +#define X86_CR3_LAM_U48                _BITULL(X86_CR3_LAM_U48_BIT)
>  #define X86_CR3_PCID_NOFLUSH_BIT 63 /* Preserve old PCID */
>  #define X86_CR3_PCID_NOFLUSH    _BITULL(X86_CR3_PCID_NOFLUSH_BIT)
>
> @@ -132,6 +136,8 @@
>  #define X86_CR4_PKE            _BITUL(X86_CR4_PKE_BIT)
>  #define X86_CR4_CET_BIT                23 /* enable Control-flow Enforce=
ment Technology */
>  #define X86_CR4_CET            _BITUL(X86_CR4_CET_BIT)
> +#define X86_CR4_LAM_SUP_BIT    28 /* LAM for supervisor pointers */
> +#define X86_CR4_LAM_SUP                _BITUL(X86_CR4_LAM_SUP_BIT)
>
>  /*
>   * x86-64 Task Priority Register, CR8
> --
> 2.35.1
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
