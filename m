Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99D53FE10
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbiFGLzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242118AbiFGLzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:55:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57C9B36CE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:55:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C9F6B81F68
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657A0C36AFE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654602949;
        bh=GrhfrL8oUbLgmqruqcpxywys/nnTFpxDadmshYBLbWc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rp5PkDVwKKnb4tnGcD81lXSGyMxm+O8cqFKgbaQqBZp3vd7BbzHubc4KpGL3yAIUh
         OoS6fieaPwYEGxlIwfIoLHD/nSmiwCa0pSACpYGki9To1DkH7agwmv4nvRZkyoREGV
         d5xXH5+QtX9c21+YZkZC/wSjg83o48PBzgx4GH/vmdy+NCI4UcyInH42yFwaKiZCs2
         adNvR5iefJcZNdDlZm0rrEE/AMyVrAo6X8KN6T9U3TZqkrf2T41ZpF8J4EGWFOHLXT
         uoUVgMAdO9baAmYapAVYfUS4Jorp48EwymX/U78vik7uRjNvJdPN1LooJVQmu12qmf
         EmRRrJeYeeWEw==
Received: by mail-oi1-f170.google.com with SMTP id l81so8114615oif.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 04:55:49 -0700 (PDT)
X-Gm-Message-State: AOAM531iOGdM+g7daP2RypB97RkCBelIyB+7qoEsGtrRH5qY4MNjjXjh
        qlGjZOVc3/uytmN2uU+Rb19hinmD32Fc/szc+JA=
X-Google-Smtp-Source: ABdhPJw4Sd5cWP9Qt9imnMfffLiNg+B5Mqxvsm5mTsiUfOqjgnfhC8QDGIQLR6IoygBYSxQJwyN4cN+bZPjZfVukW64=
X-Received: by 2002:a05:6808:f88:b0:32b:d10f:cc6b with SMTP id
 o8-20020a0568080f8800b0032bd10fcc6bmr31908086oiw.228.1654602948533; Tue, 07
 Jun 2022 04:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220607111514.755009-1-Jason@zx2c4.com>
In-Reply-To: <20220607111514.755009-1-Jason@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Jun 2022 13:55:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFDYX3fAdO6hxH9DTFP7+LNYz0fL9Dy8eKsH_xGwXxatQ@mail.gmail.com>
Message-ID: <CAMj1kXFDYX3fAdO6hxH9DTFP7+LNYz0fL9Dy8eKsH_xGwXxatQ@mail.gmail.com>
Subject: Re: [PATCH] random: defer use of bootloader randomness to random_init()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>
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

Hi Jason,

On Tue, 7 Jun 2022 at 13:15, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Stephen reported that a static key warning splat appears during early
> boot on systems that credit randomness from device trees that contain an
> "rng-seed" property, because because setup_machine_fdt() is called
> before jump_label_init() during setup_arch():
>
>  static_key_enable_cpuslocked(): static key '0xffffffe51c6fcfc0' used before call to jump_label_init()
>  WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:166 static_key_enable_cpuslocked+0xb0/0xb8
>  Modules linked in:
>  CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0+ #224 44b43e377bfc84bc99bb5ab885ff694984ee09ff
>  pstate: 600001c9 (nZCv dAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : static_key_enable_cpuslocked+0xb0/0xb8
>  lr : static_key_enable_cpuslocked+0xb0/0xb8
>  sp : ffffffe51c393cf0
>  x29: ffffffe51c393cf0 x28: 000000008185054c x27: 00000000f1042f10
>  x26: 0000000000000000 x25: 00000000f10302b2 x24: 0000002513200000
>  x23: 0000002513200000 x22: ffffffe51c1c9000 x21: fffffffdfdc00000
>  x20: ffffffe51c2f0831 x19: ffffffe51c6fcfc0 x18: 00000000ffff1020
>  x17: 00000000e1e2ac90 x16: 00000000000000e0 x15: ffffffe51b710708
>  x14: 0000000000000066 x13: 0000000000000018 x12: 0000000000000000
>  x11: 0000000000000000 x10: 00000000ffffffff x9 : 0000000000000000
>  x8 : 0000000000000000 x7 : 61632065726f6665 x6 : 6220646573752027
>  x5 : ffffffe51c641d25 x4 : ffffffe51c13142c x3 : ffff0a00ffffff05
>  x2 : 40000000ffffe003 x1 : 00000000000001c0 x0 : 0000000000000065
>  Call trace:
>   static_key_enable_cpuslocked+0xb0/0xb8
>   static_key_enable+0x2c/0x40
>   crng_set_ready+0x24/0x30
>   execute_in_process_context+0x80/0x90
>   _credit_init_bits+0x100/0x154
>   add_bootloader_randomness+0x64/0x78
>   early_init_dt_scan_chosen+0x140/0x184
>   early_init_dt_scan_nodes+0x28/0x4c
>   early_init_dt_scan+0x40/0x44
>   setup_machine_fdt+0x7c/0x120
>   setup_arch+0x74/0x1d8
>   start_kernel+0x84/0x44c
>   __primary_switched+0xc0/0xc8
>  ---[ end trace 0000000000000000 ]---
>  random: crng init done
>  Machine model: Google Lazor (rev1 - 2) with LTE
>
> A trivial fix went in to address this on arm64, 73e2d827a501 ("arm64:
> Initialize jump labels before setup_machine_fdt()"). But it appears that
> fixing it on other platforms might not be so trivial. And in the past
> there have been problems related to add_bootloader_randomness() being
> called too early in boot for what it needed.
>
> This patch defers all entropy crediting until random_init(), where we
> can be sure that all facilities we need are up and running. It changes
> the name add_bootloader_randomness() to register_bootloader_seed(), and
> insists that its buffer remain alive during all of __init.
>
> A potential downside is that EFI runs a little bit before random_init(),
> which means we were getting that seed a lot earlier before.
>
> Fixes: f5bda35fba61 ("random: use static branch for crng_ready()")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Phil Elwell <phil@raspberrypi.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Ard - I guess we've got two things to figure out here:
>
> 1) How much we gain by the situation before this patch of EFI supplying
>    its seed before random_init().
> 2) Whether those buffers are guaranteed to live throughout __init, or if
>    this patch introduces a UaF.
>

This is not going to work, I'm afraid - please see below.


>  drivers/char/random.c      | 38 ++++++++++++++++++--------------------
>  drivers/firmware/efi/efi.c |  2 +-
>  drivers/of/fdt.c           |  2 +-
>  include/linux/random.h     |  2 +-
>  4 files changed, 21 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 4862d4d3ec49..d9d00143c7c5 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -678,7 +678,6 @@ static void __cold _credit_init_bits(size_t bits)
>   *
>   *     void add_device_randomness(const void *buf, size_t len);
>   *     void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy);
> - *     void add_bootloader_randomness(const void *buf, size_t len);
>   *     void add_vmfork_randomness(const void *unique_vm_id, size_t len);
>   *     void add_interrupt_randomness(int irq);
>   *     void add_input_randomness(unsigned int type, unsigned int code, unsigned int value);
> @@ -696,10 +695,6 @@ static void __cold _credit_init_bits(size_t bits)
>   * entropy as specified by the caller. If the entropy pool is full it will
>   * block until more entropy is needed.
>   *
> - * add_bootloader_randomness() is called by bootloader drivers, such as EFI
> - * and device tree, and credits its input depending on whether or not the
> - * configuration option CONFIG_RANDOM_TRUST_BOOTLOADER is set.
> - *
>   * add_vmfork_randomness() adds a unique (but not necessarily secret) ID
>   * representing the current instance of a VM to the pool, without crediting,
>   * and then force-reseeds the crng so that it takes effect immediately.
> @@ -765,6 +760,18 @@ static int random_pm_notification(struct notifier_block *nb, unsigned long actio
>
>  static struct notifier_block pm_notifier = { .notifier_call = random_pm_notification };
>
> +/*
> + * Handle random seed passed by bootloader. The buf pointer
> + * must remain alive during the kernel's init sequence.
> + */
> +static __initdata const void *bootloader_seed;
> +static __initdata size_t bootloader_seed_bytes;
> +void __init register_bootloader_seed(const void *buf, size_t len)
> +{
> +       bootloader_seed = buf;
> +       bootloader_seed_bytes = len;
> +}
> +
>  /*
>   * The first collection of entropy occurs at system boot while interrupts
>   * are still turned off. Here we push in latent entropy, RDSEED, a timestamp,
> @@ -793,6 +800,8 @@ int __init random_init(const char *command_line)
>                 }
>                 _mix_pool_bytes(&entropy, sizeof(entropy));
>         }
> +       if (bootloader_seed && bootloader_seed_bytes)
> +               _mix_pool_bytes(bootloader_seed, bootloader_seed_bytes);
>         _mix_pool_bytes(&now, sizeof(now));
>         _mix_pool_bytes(utsname(), sizeof(*(utsname())));
>         _mix_pool_bytes(command_line, strlen(command_line));
> @@ -800,9 +809,10 @@ int __init random_init(const char *command_line)
>
>         if (crng_ready())
>                 crng_reseed();
> -       else if (trust_cpu)
> -               _credit_init_bits(arch_bytes * 8);
> -       used_arch_random = arch_bytes * 8 >= POOL_READY_BITS;
> +       else
> +               _credit_init_bits((trust_cpu ? arch_bytes * 8 : 0) +
> +                                 (trust_bootloader ? bootloader_seed_bytes * 8 : 0));
> +       used_arch_random = arch_bytes * 8 + bootloader_seed_bytes * 8 >= POOL_READY_BITS;
>
>         WARN_ON(register_pm_notifier(&pm_notifier));
>
> @@ -861,18 +871,6 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
>  }
>  EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
>
> -/*
> - * Handle random seed passed by bootloader, and credit it if
> - * CONFIG_RANDOM_TRUST_BOOTLOADER is set.
> - */
> -void __cold add_bootloader_randomness(const void *buf, size_t len)
> -{
> -       mix_pool_bytes(buf, len);
> -       if (trust_bootloader)
> -               credit_init_bits(len * 8);
> -}
> -EXPORT_SYMBOL_GPL(add_bootloader_randomness);
> -
>  #if IS_ENABLED(CONFIG_VMGENID)
>  static BLOCKING_NOTIFIER_HEAD(vmfork_chain);
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 860534bcfdac..daf374983012 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -614,7 +614,7 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>                                               sizeof(*seed) + size);
>                         if (seed != NULL) {
>                                 pr_notice("seeding entropy pool\n");
> -                               add_bootloader_randomness(seed->bits, size);
> +                               register_bootloader_seed(seed->bits, size);

The next line says it all, really: the seed is in a firmware table
somewhere, and only gets mapped temporarily here. Note that we cannot
copy it either, as we are running way before we have discovered where
RAM is to begin with.



>                                 early_memunmap(seed, sizeof(*seed) + size);
>                         } else {
>                                 pr_err("Could not map UEFI random seed!\n");
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index a8f5b6532165..389ef0f781c2 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1201,7 +1201,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>
>         rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
>         if (rng_seed && l > 0) {
> -               add_bootloader_randomness(rng_seed, l);
> +               register_bootloader_seed(rng_seed, l);
>
>                 /* try to clear seed so it won't be found. */
>                 fdt_nop_property(initial_boot_params, node, "rng-seed");
> diff --git a/include/linux/random.h b/include/linux/random.h
> index fae0c84027fd..c4fa7ca008df 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -13,7 +13,6 @@
>  struct notifier_block;
>
>  void add_device_randomness(const void *buf, size_t len);
> -void add_bootloader_randomness(const void *buf, size_t len);
>  void add_input_randomness(unsigned int type, unsigned int code,
>                           unsigned int value) __latent_entropy;
>  void add_interrupt_randomness(int irq) __latent_entropy;
> @@ -72,6 +71,7 @@ static inline unsigned long get_random_canary(void)
>         return get_random_long() & CANARY_MASK;
>  }
>
> +void __init register_bootloader_seed(const void *buf, size_t len);
>  int __init random_init(const char *command_line);
>  bool rng_is_initialized(void);
>  bool rng_has_arch_random(void);

More fundamentally, I feel we are losing sight of the actual issue.
This is another patch that makes potentially risky functional changes
to very early boot code, only so that we can manipulate the static key
as early as we think we need to.

So could we please go back to some basic questions here;
- Why do we need/want a static key here to begin with? Is is for performance?
- Why do we need to enable this static key so early?
- Even if very convincing replies can be given to the previous two
points, wouldn't it be betterr to simply revert the -stable backport
that introduces the use of the static key, and find a robust and
portable solution for after v5.19?
