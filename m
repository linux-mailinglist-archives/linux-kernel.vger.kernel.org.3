Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1795A59EA3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiHWRu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiHWRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:50:23 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807ECB2D95
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:49:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w196so16361107oiw.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=I+MhWIFw4wylC1ozMc1I6NteP9cQs0GMyFhEeS/9x94=;
        b=ByX9H6uiDkTPWcwJ0OiX4RFt26I4cpIOa9/tKClIslXtzO8ndVu6rmalqMKsehV6U6
         OMXrGiP47fpWkN0zkSQbaTYhFk+ubbOcVjS7s33KiAR7NnziPZ95Ie7cdV84vm9BL2k/
         uLuerYI/aNzaJXAv6ZHVfy6IV9GMOvVyGY+2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=I+MhWIFw4wylC1ozMc1I6NteP9cQs0GMyFhEeS/9x94=;
        b=4zqhlTftSy3toTq6FiSMYkfBUoqcwogKPEFB9r7XsxAwwyLr15QIQ7rLc+AncX/v+Q
         X//W0VadG30lEsyYzCB+MtYtlIT0b+CC8AcTW5xAXDOjzRLZ0QBbyrzJTU2/jkn/O5cF
         CBEMauOxfR4k+mZv8vzp1ToqRdLzDxtbG6V0C0V38bYS0k4qLtE/iYKoWpv6OXKqAIIR
         1LaLAPcLqkbYH0o/a36yftEdeW+XBQmQKUkqoy6a4lh17rDodzhr1QFhBRf42WgyQv6Y
         s6doXHlHHxHXSIKBQL16TOAYpYuGBI4HHVQMgwyDUl6ECe99bY1Fc8Y/V2QOGm7oyI3n
         cYhg==
X-Gm-Message-State: ACgBeo0VydYJEhLOjNTqDXzg40BSD2nHtaVxR40KcVKTxquZJ+N3du8Q
        rmuTBJ4vQ2rmXjelK4DqQi5cTlcEC+R+Lg==
X-Google-Smtp-Source: AA6agR6aNBdfIKwe77ZVGa1KFL2FruRKOkP1dr5cyZzqkTOn9ue2ONEjYbwR9qFtbIZBIMjrhwcDxQ==
X-Received: by 2002:a05:6808:1304:b0:345:52b3:4b42 with SMTP id y4-20020a056808130400b0034552b34b42mr1598590oiv.145.1661269796689;
        Tue, 23 Aug 2022 08:49:56 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id bq7-20020a05680823c700b00339befdfad0sm3440406oib.50.2022.08.23.08.49.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 08:49:56 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so10060630otr.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:49:55 -0700 (PDT)
X-Received: by 2002:a05:6830:58:b0:637:1974:140a with SMTP id
 d24-20020a056830005800b006371974140amr9735586otp.362.1661269795464; Tue, 23
 Aug 2022 08:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220112211258.21115-1-chang.seok.bae@intel.com> <20220112211258.21115-8-chang.seok.bae@intel.com>
In-Reply-To: <20220112211258.21115-8-chang.seok.bae@intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 23 Aug 2022 08:49:18 -0700
X-Gmail-Original-Message-ID: <CAE=gft4P2iGJDiYJccZFR1VnNomQB7Uo522r2gvrfNY9oKz5jg@mail.gmail.com>
Message-ID: <CAE=gft4P2iGJDiYJccZFR1VnNomQB7Uo522r2gvrfNY9oKz5jg@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] x86/cpu/keylocker: Load an internal wrapping key
 at boot-time
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        herbert@gondor.apana.org.au, Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>, bp@suse.de,
        dave.hansen@linux.intel.com, mingo@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        ravi.v.shankar@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 1:21 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> The Internal Wrapping Key (IWKey) is an entity of Key Locker to encode a
> clear text key into a key handle. This key is a pivot in protecting user
> keys. So the value has to be randomized before being loaded in the
> software-invisible CPU state.
>
> IWKey needs to be established before the first user. Given that the only
> proposed Linux use case for Key Locker is dm-crypt, the feature could be
> lazily enabled when the first dm-crypt user arrives, but there is no
> precedent for late enabling of CPU features and it adds maintenance burden
> without demonstrative benefit outside of minimizing the visibility of
> Key Locker to userspace.
>
> The kernel generates random bytes and load them at boot time. These bytes
> are flushed out immediately.
>
> Setting the CR4.KL bit does not always enable the feature so ensure the
> dynamic CPU bit (CPUID.AESKLE) is set before loading the key.
>
> Given that the Linux Key Locker support is only intended for bare metal
> dm-crypt consumption, and that switching IWKey per VM is untenable,
> explicitly skip Key Locker setup in the X86_FEATURE_HYPERVISOR case.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes from RFC v2:
> * Make bare metal only.
> * Clean up the code (e.g. dynamically allocate the key cache).
>   (Dan Williams)
> * Massage the changelog.
> * Move out the LOADIWKEY wrapper and the Key Locker CPUID defines.
>
> Note, Dan wonders that given that the only proposed Linux use case for
> Key Locker is dm-crypt, the feature could be lazily enabled when the
> first dm-crypt user arrives, but as Dave notes there is no precedent
> for late enabling of CPU features and it adds maintenance burden
> without demonstrative benefit outside of minimizing the visibility of
> Key Locker to userspace.
> ---
>  arch/x86/include/asm/keylocker.h |  9 ++++
>  arch/x86/kernel/Makefile         |  1 +
>  arch/x86/kernel/cpu/common.c     |  5 +-
>  arch/x86/kernel/keylocker.c      | 79 ++++++++++++++++++++++++++++++++
>  arch/x86/kernel/smpboot.c        |  2 +
>  5 files changed, 95 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/kernel/keylocker.c
>
> diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
> index e85dfb6c1524..820ac29c06d9 100644
> --- a/arch/x86/include/asm/keylocker.h
> +++ b/arch/x86/include/asm/keylocker.h
> @@ -5,6 +5,7 @@
>
>  #ifndef __ASSEMBLY__
>
> +#include <asm/processor.h>
>  #include <linux/bits.h>
>  #include <asm/fpu/types.h>
>
> @@ -28,5 +29,13 @@ struct iwkey {
>  #define KEYLOCKER_CPUID_EBX_WIDE       BIT(2)
>  #define KEYLOCKER_CPUID_EBX_BACKUP     BIT(4)
>
> +#ifdef CONFIG_X86_KEYLOCKER
> +void setup_keylocker(struct cpuinfo_x86 *c);
> +void destroy_keylocker_data(void);
> +#else
> +#define setup_keylocker(c) do { } while (0)
> +#define destroy_keylocker_data() do { } while (0)
> +#endif
> +
>  #endif /*__ASSEMBLY__ */
>  #endif /* _ASM_KEYLOCKER_H */
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 2ff3e600f426..e15efa238497 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -144,6 +144,7 @@ obj-$(CONFIG_PERF_EVENTS)           += perf_regs.o
>  obj-$(CONFIG_TRACING)                  += tracepoint.o
>  obj-$(CONFIG_SCHED_MC_PRIO)            += itmt.o
>  obj-$(CONFIG_X86_UMIP)                 += umip.o
> +obj-$(CONFIG_X86_KEYLOCKER)            += keylocker.o
>
>  obj-$(CONFIG_UNWINDER_ORC)             += unwind_orc.o
>  obj-$(CONFIG_UNWINDER_FRAME_POINTER)   += unwind_frame.o
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 0083464de5e3..23b4aa437c1e 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -57,6 +57,8 @@
>  #include <asm/microcode_intel.h>
>  #include <asm/intel-family.h>
>  #include <asm/cpu_device_id.h>
> +#include <asm/keylocker.h>
> +
>  #include <asm/uv/uv.h>
>  #include <asm/sigframe.h>
>
> @@ -1595,10 +1597,11 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>         /* Disable the PN if appropriate */
>         squash_the_stupid_serial_number(c);
>
> -       /* Set up SMEP/SMAP/UMIP */
> +       /* Setup various Intel-specific CPU security features */
>         setup_smep(c);
>         setup_smap(c);
>         setup_umip(c);
> +       setup_keylocker(c);
>
>         /* Enable FSGSBASE instructions if available. */
>         if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
> diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
> new file mode 100644
> index 000000000000..87d775a65716
> --- /dev/null
> +++ b/arch/x86/kernel/keylocker.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Setup Key Locker feature and support internal wrapping key
> + * management.
> + */
> +
> +#include <linux/random.h>
> +#include <linux/poison.h>
> +
> +#include <asm/fpu/api.h>
> +#include <asm/keylocker.h>
> +#include <asm/tlbflush.h>
> +
> +static __initdata struct keylocker_setup_data {
> +       struct iwkey key;
> +} kl_setup;
> +
> +static void __init generate_keylocker_data(void)
> +{
> +       get_random_bytes(&kl_setup.key.integrity_key,  sizeof(kl_setup.key.integrity_key));
> +       get_random_bytes(&kl_setup.key.encryption_key, sizeof(kl_setup.key.encryption_key));
> +}
> +
> +void __init destroy_keylocker_data(void)
> +{
> +       memset(&kl_setup.key, KEY_DESTROY, sizeof(kl_setup.key));
> +}
> +
> +static void __init load_keylocker(void)

I am late to this party by 6 months, but:
load_keylocker() cannot be __init, as it gets called during SMP core onlining.
