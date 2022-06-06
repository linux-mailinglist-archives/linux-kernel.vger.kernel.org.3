Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3428953E7B8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiFFLdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiFFLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5593E658B;
        Mon,  6 Jun 2022 04:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E631F60F68;
        Mon,  6 Jun 2022 11:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BDFC36AFF;
        Mon,  6 Jun 2022 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654515190;
        bh=iiHNaIjolgNWshGx0VtNmsA0HuKQk5oAzR6lMEd02pg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tX0kNYhUWVebw7BaoCvOxIgBoVz97p9WcJSrK/rav9YCv3zXpWntNOOsD4aPV4AsR
         92qjAyq3pGZcxplkRHVsh0AMc9nCVmdAUhTHbxFvg3XuNF04honpZzwtKT2TOVZFNU
         MNXjTr33HLkbDvyMQu6pevt3xRo2ryuyvpDLm2FbBkzz3tvTsbp/R6zY4NxlFiaCre
         Nj4AqVsBmT+6fpgbAwdG/f+a17owY+5HZ78NrP8uIMsQv25BGdq6wj7z0E8GtPWfs+
         CCxwVxuRnBpLHxHIEDODfeZ7H8KZjRMTS+624eu2k1756nKil7QVf3Vuvu2gWcfaMW
         BjwRWxE0+Pz8Q==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-edeb6c3642so18785535fac.3;
        Mon, 06 Jun 2022 04:33:10 -0700 (PDT)
X-Gm-Message-State: AOAM533DHBMnRdJkILdThIHM0Wo6Uw8SRTWCI/iwwiQwhHbenHbvMHhg
        qSInfVPxhXGgvFCxu2HcN6t6hvtaBp1MoWtq1ig=
X-Google-Smtp-Source: ABdhPJxkPMRLNT+MTO3Q8aX8f+k5qyqSTig6K1iiC0fhz+UWJMNIVSQnRVFraSOL8K8EUJ9YKe2/Z8cv0K81X4PMHE0=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr31497119oap.228.1654515189352; Mon, 06
 Jun 2022 04:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220605171539.417872-1-Jason@zx2c4.com>
In-Reply-To: <20220605171539.417872-1-Jason@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Jun 2022 13:32:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGi+ieviFjXv9zQBSaGyyzeGW_VpMpTLJK8PJb2QHEQ-w@mail.gmail.com>
Message-ID: <CAMj1kXGi+ieviFjXv9zQBSaGyyzeGW_VpMpTLJK8PJb2QHEQ-w@mail.gmail.com>
Subject: Re: [PATCH] random: credit cpu and bootloader seeds by default
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jun 2022 at 19:16, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> This commit changes the default Kconfig values of RANDOM_TRUST_CPU and
> RANDOM_TRUST_BOOTLOADER to be Y by default. It does not change any
> existing configs or change any kernel behavior. The reason for this is
> several fold.
>
> As background, I recently had an email thread with the kernel
> maintainers of Fedora/RHEL, Debian, Ubuntu, Gentoo, Arch, NixOS, Alpine,
> SUSE, and Void as recipients. I noted that some distros trust RDRAND,
> some trust EFI, and some trust both, and I asked why or why not. There
> wasn't really much of a "debate" but rather an interesting discussion of
> what the historical reasons have been for this, and it came up that some
> distros just missed the introduction of the bootloader Kconfig knob,
> while another didn't want to enable it until there was a boot time
> switch to turn it off for more concerned users (which has since been
> added). The result of the rather uneventful discussion is that every
> major Linux distro enables these two options by default.
>
> While I didn't have really too strong of an opinion going into this
> thread -- and I mostly wanted to learn what the distros' thinking was
> one way or another -- ultimately I think their choice was a decent
> enough one for a default option (which can be disabled at boot time).
> I'll try to summarize the pros and cons:
>
> Pros:
>
> - The RNG machinery gets initialized super quickly, and there's no
>   messing around with subsequent blocking behavior.
>
> - The bootloader mechanism is used by kexec in order for the prior
>   kernel to initialize the RNG of the next kernel, which increases
>   the entropy available to early boot daemons of the next kernel.
>
> - Previous objections related to backdoors centered around
>   Dual_EC_DRBG-like kleptographic systems, in which observing some
>   amount of the output stream enables an adversary holding the right key
>   to determine the entire output stream.
>
>   This used to be a partially justified concern, because RDRAND output
>   was mixed into the output stream in varying ways, some of which may
>   have lacked pre-image resistance (e.g. XOR or an LFSR).
>
>   But this is no longer the case. Now, all usage of RDRAND and
>   bootloader seeds go through a cryptographic hash function. This means
>   that the CPU would have to compute a hash pre-image, which is not
>   considered to be feasible (otherwise the hash function would be
>   terribly broken).
>
> - More generally, if the CPU is backdoored, the RNG is probably not the
>   realistic vector of choice for an attacker.
>
> - These CPU or bootloader seeds are far from being the only source of
>   entropy. Rather, there is generally a pretty huge amount of entropy,
>   not all of which is credited, especially on CPUs that support
>   instructions like RDRAND. In other words, assuming RDRAND outputs all
>   zeros, an attacker would *still* have to accurately model every single
>   other entropy source also in use.
>
> - The RNG now reseeds itself quite rapidly during boot, starting at 2
>   seconds, then 4, then 8, then 16, and so forth, so that other sources
>   of entropy get used without much delay.
>
> - Paranoid users can set random.trust_{cpu,bootloader}=no in the kernel
>   command line, and paranoid system builders can set the Kconfig options
>   to N, so there's no reduction or restriction of optionality.
>
> - It's a practical default.
>
> - All the distros have it set this way. Microsoft and Apple trust it
>   too. Bandwagon.
>
> Cons:
>
> - RDRAND *could* still be backdoored with something like a fixed key or
>   limited space serial number seed or another indexable scheme like
>   that. (However, it's hard to imagine threat models where the CPU is
>   backdoored like this, yet people are still okay making *any*
>   computations with it or connecting it to networks, etc.)
>
> - RDRAND *could* be defective, rather than backdoored, and produce
>   garbage that is in one way or another insufficient for crypto.
>
> - Suggesting a *reduction* in paranoia, as this commit effectively does,
>   may cause some to question my personal integrity as a "security
>   person".
>
> - Bootloader seeds and RDRAND are generally very difficult if not all
>   together impossible to audit.
>
> Keep in mind that this doesn't actually change any behavior. This
> is just a change in the default Kconfig value. The distros already are
> shipping kernels that set things this way.
>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

We're at the mercy of firmware and micro-architecture anyway, given
that we are also relying on it to ensure that every instruction in the
kernel's executable image has been faithfully copied to memory, and
that the CPU implements those instructions as documented. So I don't
think firmware or ISA bugs related to RNGs deserve special treatment -
if they are broken, we should quirk around them like we usually do.

So enabling these by default is a step in the right direction IMHO.


> ---
> Ted - I'm in particular interested in your opinion here. If you feel
> like this is much too hazmat for your tastes, I have no qualms about
> abandoning it. -Jason
>
>  drivers/char/Kconfig | 50 +++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 69fd31ffb847..0b6c03643ddc 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -429,28 +429,40 @@ config ADI
>           driver include crash and makedumpfile.
>
>  config RANDOM_TRUST_CPU
> -       bool "Trust the CPU manufacturer to initialize Linux's CRNG"
> +       bool "Initialize RNG using CPU RNG instructions"
> +       default y
>         depends on ARCH_RANDOM
> -       default n
>         help
> -       Assume that CPU manufacturer (e.g., Intel or AMD for RDSEED or
> -       RDRAND, IBM for the S390 and Power PC architectures) is trustworthy
> -       for the purposes of initializing Linux's CRNG.  Since this is not
> -       something that can be independently audited, this amounts to trusting
> -       that CPU manufacturer (perhaps with the insistence or mandate
> -       of a Nation State's intelligence or law enforcement agencies)
> -       has not installed a hidden back door to compromise the CPU's
> -       random number generation facilities. This can also be configured
> -       at boot with "random.trust_cpu=on/off".
> +         Initialize the RNG using random numbers supplied by the CPU's
> +         RNG instructions (e.g. RDRAND), if supported and available. These
> +         random numbers are never used directly, but are rather hashed into
> +         the main input pool, and this happens regardless of whether or not
> +         this option is enabled. Instead, this option controls whether the
> +         they are credited and hence can initialize the RNG. Additionally,
> +         other sources of randomness are always used, regardless of this
> +         setting.  Enabling this implies trusting that the CPU can supply high
> +         quality and non-backdoored random numbers.
> +
> +         Say Y here unless you have reason to mistrust your CPU or believe
> +         its RNG facilities may be faulty. This may also be configured at
> +         boot time with "random.trust_cpu=on/off".
>
>  config RANDOM_TRUST_BOOTLOADER
> -       bool "Trust the bootloader to initialize Linux's CRNG"
> -       help
> -       Some bootloaders can provide entropy to increase the kernel's initial
> -       device randomness. Say Y here to assume the entropy provided by the
> -       booloader is trustworthy so it will be added to the kernel's entropy
> -       pool. Otherwise, say N here so it will be regarded as device input that
> -       only mixes the entropy pool. This can also be configured at boot with
> -       "random.trust_bootloader=on/off".
> +       bool "Initialize RNG using bootloader-supplied seed"
> +       default y
> +       help
> +         Initialize the RNG using a seed supplied by the bootloader or boot
> +         environment (e.g. EFI or a bootloader-generated device tree). This
> +         seed is not used directly, but is rather hashed into the main input
> +         pool, and this happens regardless of whether or not this option is
> +         enabled. Instead, this option controls whether the seed is credited
> +         and hence can initialize the RNG. Additionally, other sources of
> +         randomness are always used, regardless of this setting. Enabling
> +         this implies trusting that the bootloader can supply high quality and
> +         non-backdoored seeds.
> +
> +         Say Y here unless you have reason to mistrust your bootloader or
> +         believe its RNG facilities may be faulty. This may also be configured
> +         at boot time with "random.trust_bootloader=on/off".
>
>  endmenu
> --
> 2.35.1
>
