Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3D14F6681
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbiDFQzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiDFQzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7C447DE3D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649256939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=edxkcn/vXTQrPZmEvbrycB6QtSNdKCqqu4nikxfDLOU=;
        b=bUznwvLNFzkvun21+iJsvwufNwztAybzUlGXCyb3R5yXhzpx2gANX2tzOmpkHShidmuGc1
        XPhr9TCAF15rPZyF+THXW4+Ec2WekaYOs4I5/aDboU9l5nb86F4hPQBYBCrpDnKgSowUPK
        QCDu8JWzQgHbrG8qg7gfaz7a/u5xWz8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-yUseNoLDNbGLCUaotm0_tg-1; Wed, 06 Apr 2022 10:55:38 -0400
X-MC-Unique: yUseNoLDNbGLCUaotm0_tg-1
Received: by mail-ed1-f69.google.com with SMTP id w8-20020a50d788000000b00418e6810364so1347834edi.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edxkcn/vXTQrPZmEvbrycB6QtSNdKCqqu4nikxfDLOU=;
        b=WDhxS34PU7fUc64SilTMzDQ0OFI4noCaDUjbvW/sjLux11EUvZaP0OIwIve2KXuNVW
         wCbjyJJIQ+9Rdgt3dsIw7hcXksiEMMde3jBXVtT68Ivc/5S5XSJ7lIytum38pxy/Y8ck
         /sZyUto7fwLk9fFvV8W0TaaYiIThsTv+hY7Vitcj6E4XEIrfjxFnz2woBQLC5+n4lUqN
         hqmjzJa9zF+fT0TiAtQRI1kYs38kgO9xtTswjebkH2U9AOwX3LZJ2OCaJtURAndpHFaQ
         RtL50ZWfCiw9/r20nvqwzDPaN5BhjB+jh3E5YYBfyTNUAVmGw3rCwkL0X6wvK7ax8qOM
         FXZg==
X-Gm-Message-State: AOAM530ZA10Gb4IoMGgtf7ZwKvCUpZuKWPIpXJtqHC2eCRrOmwS2bzQg
        bNbR0M5bOe3jawPLzfa9VYOghr8zsEBMBJeX97hfNejlYjb8G5oggqcYIcBMwqfmEN5Ow241XZ0
        y8cj7GmUPL01sXpJ3173HNdWiLB3E2KvbCAEG43ge
X-Received: by 2002:a17:907:60cf:b0:6db:f0a6:74af with SMTP id hv15-20020a17090760cf00b006dbf0a674afmr8456727ejc.317.1649256937568;
        Wed, 06 Apr 2022 07:55:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy44spcu/fjaFebRMomDblr3Vf4LhpM4BDNXoOgeTB1qaTeaumXtn/ABpPvx8Ki5uzAU6FFObc99m5q+zNA0lM=
X-Received: by 2002:a17:907:60cf:b0:6db:f0a6:74af with SMTP id
 hv15-20020a17090760cf00b006dbf0a674afmr8456713ejc.317.1649256937399; Wed, 06
 Apr 2022 07:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220202140244.1681140-1-neelx@redhat.com> <874k361liu.ffs@tglx>
In-Reply-To: <874k361liu.ffs@tglx>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Wed, 6 Apr 2022 16:54:39 +0200
Message-ID: <CACjP9X_A7aLmvypyOz1UrXM571gx_X5q7=w-1j+G+MSbCteiEw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] apic: fix timer base macro definitions
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 1:56 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Daniel,
>
> On Wed, Feb 02 2022 at 15:02, Daniel Vacek wrote:
> > I was wondering if the aliasing of APIC_TIMER_BASE_TMBASE and
> > APIC_LVT_TIMER_TSCDEADLINE was intentional or we need to << 19?
>
> That's intentional. This is only used for the !lapic_is_integrated()
> case, which is the ancient i82489DX.
>
> Something like the below should make this more clear.

Nah. Makes sense. Thanks for clearing that up. Looks good to me now.

--nX

> Thanks,
>
>         tglx
> ---
> --- a/arch/x86/include/asm/apicdef.h
> +++ b/arch/x86/include/asm/apicdef.h
> @@ -95,12 +95,6 @@
>  #define        APIC_LVTTHMR    0x330
>  #define        APIC_LVTPC      0x340
>  #define        APIC_LVT0       0x350
> -#define                APIC_LVT_TIMER_BASE_MASK        (0x3 << 18)
> -#define                GET_APIC_TIMER_BASE(x)          (((x) >> 18) & 0x3)
> -#define                SET_APIC_TIMER_BASE(x)          (((x) << 18))
> -#define                APIC_TIMER_BASE_CLKIN           0x0
> -#define                APIC_TIMER_BASE_TMBASE          0x1
> -#define                APIC_TIMER_BASE_DIV             0x2
>  #define                APIC_LVT_TIMER_ONESHOT          (0 << 17)
>  #define                APIC_LVT_TIMER_PERIODIC         (1 << 17)
>  #define                APIC_LVT_TIMER_TSCDEADLINE      (2 << 17)
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -320,6 +320,9 @@ int lapic_get_maxlvt(void)
>  #define APIC_DIVISOR 16
>  #define TSC_DIVISOR  8
>
> +/* i82489DX specific */
> +#define                I82489DX_BASE_DIVIDER           (((0x2) << 18))
> +
>  /*
>   * This function sets up the local APIC timer, with a timeout of
>   * 'clocks' APIC bus clock. During calibration we actually call
> @@ -340,8 +343,14 @@ static void __setup_APIC_LVTT(unsigned i
>         else if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
>                 lvtt_value |= APIC_LVT_TIMER_TSCDEADLINE;
>
> +       /*
> +        * The i82489DX APIC uses bit 18 and 19 for the base divider.  This
> +        * overlaps with bit 18 on integrated APICs, but is not documented
> +        * in the SDM. No problem though. i82489DX equipped systems do not
> +        * have TSC deadline timer.
> +        */
>         if (!lapic_is_integrated())
> -               lvtt_value |= SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV);
> +               lvtt_value |= I82489DX_BASE_DIVIDER;
>
>         if (!irqen)
>                 lvtt_value |= APIC_LVT_MASKED;
>

