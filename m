Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD85B46EC2B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbhLIPwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:52:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234325AbhLIPww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639064958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vE3X5PcC2Z2O022xsm2IPMV0azzJRXIn3o/0Te950Do=;
        b=OtPbYnV03gL61O/FDqHQ1DnJq2zWyP/rltPFvz8zngwUfE9Y1gs82/gO6M4ic4DmsXbcLl
        WUbBurPlKT5mMx01h0vFbsgsS5pTqs4DL31oHMDBN+Xgh161HotyUVjX8pmYutW90iFx5J
        /JvTXWcSdZfb2+uGS6AiwQ7yIrX9+fo=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-DLSb36gbOi6qAcD8TVA76w-1; Thu, 09 Dec 2021 10:49:17 -0500
X-MC-Unique: DLSb36gbOi6qAcD8TVA76w-1
Received: by mail-ua1-f70.google.com with SMTP id v16-20020a9f2d90000000b002e18753e8afso4086123uaj.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 07:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vE3X5PcC2Z2O022xsm2IPMV0azzJRXIn3o/0Te950Do=;
        b=qnMIk3jtpvwAF2cbug3SDt1+2rt0fa+o6YbjTD5gEdElm2qQUsjzzVMwhKGvAMghpa
         RW6Cje7Wg7QPnrAaqq8Puh3S3koLCLmobSQ21U2oFXMIpycgOMUm8+cv6O4ztxCRG91X
         Yn6U/17hM3bYo1Kp2Qv7AoGqn7VnNDreYsF3mHtdpwALJzW8ov87QlIifm0nBzNGIAEg
         Ff18/PhqoP6izNZhBZn2q0Nt0B3XzEd8c7PuIxXgoRBoCXf9qEDb1IiDxBHzBPXEJFqD
         2aJMi0cnDeJZPthm7xb61BCN+UD2lYO1lkXVAXxghDC1xkTuR4UOY5WESUFE3LFBxB0X
         JNow==
X-Gm-Message-State: AOAM5324Kgqm8jFQzavUHq6RQFWsUSYxAT+kBmAvfpWhGbDFEvVb9jwV
        lMQi4Qljrkd2TwrjtKB8qzDhDo97YDXlTA3pWDWAqyHZLpEdUL0tp87YQ67RKQY0TwdzZK18FHc
        X+TA1aZd5Mq1pcTWjB2sJ48HpA9OP35Umu//SfiWO
X-Received: by 2002:ab0:7c7a:: with SMTP id h26mr19971085uax.103.1639064957168;
        Thu, 09 Dec 2021 07:49:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4wuiX9hG4fcizCLh5b8/IBZgxmPJD9LNvpo3V+fGeBIqyXBqv7E3265Vjgr7wZY3XOUM/6M/snrmEXgtRaWo=
X-Received: by 2002:ab0:7c7a:: with SMTP id h26mr19971056uax.103.1639064956957;
 Thu, 09 Dec 2021 07:49:16 -0800 (PST)
MIME-Version: 1.0
References: <163697618022.414.12673958553611696646.tip-bot2@tip-bot2>
 <20211209143810.452527-1-jdorminy@redhat.com> <YbIeYIM6JEBgO3tG@zn.tnic>
In-Reply-To: <YbIeYIM6JEBgO3tG@zn.tnic>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Thu, 9 Dec 2021 10:49:06 -0500
Message-ID: <CAMeeMh_Huv-XAx4WHRDvTNoZb3J76y0jft05u18uGAfVCrj96w@mail.gmail.com>
Subject: Re: [tip: x86/urgent] x86/boot: Pull up cmdline preparation and early
 param parsing
To:     Borislav Petkov <bp@alien8.de>
Cc:     tip-bot2@linutronix.de, anjaneya.chagam@intel.com,
        dan.j.williams@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org, stable@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>,
        "Patrick J. Volkerding" <volkerdi@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 10:19 AM Borislav Petkov <bp@alien8.de> wrote:
>
> + Hugh and Patrick.
>
> On Thu, Dec 09, 2021 at 09:38:10AM -0500, John Dorminy wrote:
> > Greetings;
> >
> > It seems that this patch causes a mem=3D parameter to the kernel to hav=
e no effect, unfortunately...
> >
> > As far as I understand, the x86 mem parameter handler parse_memopt() (c=
alled by parse_early_param()) relies on being called after e820__memory_set=
up(): it simply removes any memory above the specified limit at that moment=
, allowing memory to later be hotplugged without regard for the initial lim=
it. However, the initial non-hotplugged memory must already have been set u=
p, in e820__memory_setup(), so that it can be removed in parse_memopt(); if=
 parse_early_param() is called before e820__memory_setup(), as this change =
does, the parameter ends up having no effect.
> >
> > I apologize that I don't know how to fix this, but I'm happy to test pa=
tches.
>
> Yeah, people have been reporting boot failures with mem=3D on the cmdline=
.
>
> I think I see why, can you try this one:
>
> ---
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 6a190c7f4d71..6db971e61e4b 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -862,6 +862,8 @@ void __init setup_arch(char **cmdline_p)
>          */
>         x86_configure_nx();
>
> +       e820__memory_setup();
> +
>         /*
>          * This parses early params and it needs to run before
>          * early_reserve_memory() because latter relies on such settings
> @@ -884,7 +886,6 @@ void __init setup_arch(char **cmdline_p)
>         early_reserve_memory();
>
>         iomem_resource.end =3D (1ULL << boot_cpu_data.x86_phys_bits) - 1;
> -       e820__memory_setup();
>         parse_setup_data();
>
>         copy_edd();
> ---
>
Confirmed that that patch makes mem=3D work again:

[    0.000000] Command line:
BOOT_IMAGE=3D(hd0,msdos1)/boot/vmlinuz-5.16.0-rc4+ root=3DUUID=3D0e
750e61-b92e-4708-a974-c50a3fb7e969 ro net.ifnames=3D0 crashkernel=3D128M me=
m=3D4G
...
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009abff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009ac00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007dd3afff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000007dd3b000-0x000000007deeffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007def0000-0x000000007e0d3fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007e0d4000-0x000000007f367fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007f368000-0x000000007f7fffff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000080000000-0x000000008fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed3ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000207fffffff] usabl=
e
[    0.000000] e820: remove [mem 0x100000000-0xfffffffffffffffe] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] user-defined physical RAM map:
[    0.000000] user: [mem 0x0000000000000000-0x000000000009abff] usable
[    0.000000] user: [mem 0x000000000009ac00-0x000000000009ffff] reserved
[    0.000000] user: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] user: [mem 0x0000000000100000-0x000000007dd3afff] usable
[    0.000000] user: [mem 0x000000007dd3b000-0x000000007deeffff] reserved
[    0.000000] user: [mem 0x000000007def0000-0x000000007e0d3fff] ACPI NVS
[    0.000000] user: [mem 0x000000007e0d4000-0x000000007f367fff] reserved
[    0.000000] user: [mem 0x000000007f368000-0x000000007f7fffff] ACPI NVS
[    0.000000] user: [mem 0x0000000080000000-0x000000008fffffff] reserved
[    0.000000] user: [mem 0x00000000fed1c000-0x00000000fed3ffff] reserved
[    0.000000] user: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
...
[    0.025520] Memory: 1762976K/2061136K available (16394K kernel
code, 3568K rwdata, 10328K rodata, 2676K init, 4924K bss, 297900K
reserved, 0K cma-reserved)

