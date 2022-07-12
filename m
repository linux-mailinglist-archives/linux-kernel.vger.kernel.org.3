Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700C5571ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiGLNMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiGLNMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:12:45 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863AAB3D7D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:12:40 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31c8a1e9e33so80375657b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBJt/ZY7JUr2TOwBsMYX0RVyZ0ct+EhUSprZZakawl8=;
        b=Ac6aJ8LymDQtz3c/Bhq/2F/pkevtouN0FhnMH20eci3WDinrK4xqnrc6G0GgM60KCT
         pg3r0lYFx3p+/pOEgbZmSki8x1dAeNg1RxxhY2V4NZ1gxqhPlj5XKRjh5oDOLhOwi1Wx
         rf/3MdPLWZZ4f+uRuCxsCadjJZbTL+i2ns//0z31IpMiRchtC9If+DCNDNoevXNEEOlq
         RNzMo+NNEMlcTOdEqV2OnfLDmetEl+IzXY61yDYwAgHrW/nVPZOsEspeQ5Q1Ix8hYZOt
         rxrBGvnThpnknWq2yCBpW0cS3kuvo839ZDc1nK1ydyZ51B2W8C0wGBXvaiHaMgtoXVpN
         sPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBJt/ZY7JUr2TOwBsMYX0RVyZ0ct+EhUSprZZakawl8=;
        b=Ud6RGFHJo76tu91aYQYTqJYrFw/dL3O8VXQlffGrtzWTiQ8i+UVi9NTNAaUtabTxuI
         xQ8/mH4Qtz2p1OguhQOhhCwEQvovJpUS4JaHw9d58Eq26/LUPZDohcRyI20r/H0sQbJb
         A8pP7RjGQensEKr9ouH5sf7OqErzUqOGCrgDo8+k4ZqODVyt+cvfwpE4S1BunbJTMCJA
         ehkhdAp6d0Sdm/7ov0bAHcTbR1FNYyRCeL/geB4TPDLJ7BNg6hTHBpgIfsnTBpl5bIAW
         tAvI1E4QzvTTdnmHJtXx893aUB+y00R47dEeTEqXecwPd2QdJgm6nLNcLAst36A1k3bU
         AHPw==
X-Gm-Message-State: AJIora9p6ZSfurR2gQ2T3S0KlvgCFCf6gxnuTh71vLfFquz4b3vdG8gR
        VTHz9N0acgHYIQsPByz5II+YNlA9au0OOcaxsPzftQ==
X-Google-Smtp-Source: AGRyM1sRIADhc2NCqhuRXWHxMrZcmI73f2iorfJMM2ojLdc4BKcArJh2yO46VZXMeBPCTNxK7WcZ9SF4eKVlGjQcEKg=
X-Received: by 2002:a81:6cf:0:b0:31c:913c:144c with SMTP id
 198-20020a8106cf000000b0031c913c144cmr25626639ywg.437.1657631559629; Tue, 12
 Jul 2022 06:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com> <20220622162230.83474-7-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220622162230.83474-7-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 12 Jul 2022 15:12:01 +0200
Message-ID: <CAG_fn=Uo8E-6r3otLPC9iEfO02=A0=zROO8R8TL=8vXVZVE5Ww@mail.gmail.com>
Subject: Re: [PATCHv4 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and ARCH_ENABLE_TAGGED_ADDR
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Jun 22, 2022 at 6:22 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Add a couple of arch_prctl() handles:
>
>  - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required number
>    of tag bits. It is rounded up to the nearest LAM mode that can
>    provide it. For now only LAM_U57 is supported, with 6 tag bits.
>
>  - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
>    bits located in the address.
>
Am I right that the desired way to detect the presence of LAM without
enabling it is to check that arch_prctl(ARCH_GET_UNTAG_MASK, ...)
returns zero?

Overall, I think these new arch_prctls should be documented following
the spirit of PR_SET_TAGGED_ADDR_CTRL/PR_GET_TAGGED_ADDR_CTRL
somewhere.

> +
> +static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
> +{
> +       int ret = 0;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_LAM))
> +               return -ENODEV;
> +
> +       mutex_lock(&mm->context.lock);
> +
> +       /* Already enabled? */
> +       if (mm->context.lam_cr3_mask) {
> +               ret = -EBUSY;
> +               goto out;
> +       }
> +
> +       if (!nr_bits) {
> +               ret = -EINVAL;

One would expect that `arch_prctl(ARCH_ENABLE_TAGGED_ADDR, 0)`
disables tagging for the current process.
Shouldn't this workflow be supported as well?
