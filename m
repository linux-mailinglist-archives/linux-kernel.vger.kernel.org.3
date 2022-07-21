Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6F157CB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiGUNL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiGUNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:11:22 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BDCF3D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:10:55 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id l11so2634406ybu.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RVOGJ4M2F0KLKUB3+Z6qV1Rq1i9C5g74W/OO4zDEL58=;
        b=KLOJzkFKxPnIXHld8jK2VUCHPUZoJvCKiT09dgLnq1/mxiLuH9MMgu3jWlmkAoxPpR
         o51pS7EQLLi7R3gSKNltX+brOCmQ7Ld+ShhitqKzhv/+TaTZov/WdLL86rbBITQF31Vr
         qpNdYLpjh0AZuYWIBYiHxTL3yG6v8fLAq73KOKpuqzSTQO+WozUQJL9LkII9qRAci5nk
         AJMifWfn9XpxEupX3LvieaeY5y5WWOAbovKOTqUKmaL6qpP6K4kd3IWO88qxNQabuQ5B
         abwj2R1RwqPEh92fZ1qltngaFkHvMsDKpqEbWgSK4ifcqqrZiCaxIVBsKMwKwnmBvCx/
         IaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RVOGJ4M2F0KLKUB3+Z6qV1Rq1i9C5g74W/OO4zDEL58=;
        b=ZmRUT70wWs8i0pKR+zgbsVBGACtG3XCfb+RosPEP57B30momySKaou97iaKNC4WlkZ
         7awYoje12Ebvaa6QhSDCumauURGKa6ap4pxObh7SbuYA4J/o7hXCAoFXCsi1HdbxF6Ym
         aHS2x+r3chn0az9TjlDgsFcI0tEE8i12ffp9fZaPsDctsuaE9iALO7C63+v6CFJsmVem
         bzh/U7piRZI2SKgm5FqWkDwjFOwi6Pbn22CsnAIeKyuZgRNmviBIRXrhbQefm0fP5obT
         zjKlBIZ1P+8PnMjNLEYv3aEc+JLVFWzgs0gTwLJpX1UKTdqaWiGFdmB+pRtdREAKun1p
         Gizg==
X-Gm-Message-State: AJIora+3S2+f8Ktj2ZKTU5taMhOK5nFZ5oFvDpn0IqEzSk1fm3cQM268
        zK+/klkpMorcQpunHZZUZSK/HnTqLHcStiRi7tDpVg==
X-Google-Smtp-Source: AGRyM1t6VrXpRJKHyM6oUQ81m8QH3nTAlq3cCeOZ/vKxDDxd7aWq0qpq0j54jBAKZJgaUnHNCGEI1s8fSBxgWr0f7RQ=
X-Received: by 2002:a25:d1d7:0:b0:670:7db7:1e88 with SMTP id
 i206-20020a25d1d7000000b006707db71e88mr12516221ybg.363.1658409054750; Thu, 21
 Jul 2022 06:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com> <20220712231328.5294-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220712231328.5294-2-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 21 Jul 2022 15:10:18 +0200
Message-ID: <CAG_fn=WmRsiCtGpYhdt7gqjqpRfp3-jsjCM7qH76GwvE56eT0w@mail.gmail.com>
Subject: Re: [PATCHv5 01/13] x86/mm: Fix CR3_ADDR_MASK
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
> The mask must not include bits above physical address mask. These bits
> are reserved and can be used for other things. Bits 61 and 62 are used
> for Linear Address Masking.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>

> ---
>  arch/x86/include/asm/processor-flags.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/as=
m/processor-flags.h
> index 02c2cbda4a74..a7f3d9100adb 100644
> --- a/arch/x86/include/asm/processor-flags.h
> +++ b/arch/x86/include/asm/processor-flags.h
> @@ -35,7 +35,7 @@
>   */
>  #ifdef CONFIG_X86_64
>  /* Mask off the address space ID and SME encryption bits. */
> -#define CR3_ADDR_MASK  __sme_clr(0x7FFFFFFFFFFFF000ull)
> +#define CR3_ADDR_MASK  __sme_clr(PHYSICAL_PAGE_MASK)
>  #define CR3_PCID_MASK  0xFFFull
>  #define CR3_NOFLUSH    BIT_ULL(63)
>
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
