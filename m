Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD153FFDE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244567AbiFGNVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiFGNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:21:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4B76FD25
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:21:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k19so24136701wrd.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=K9vvh0bGJEe0flqUOu0GON2SuJZ4sPNg64f+S8JdTT4=;
        b=aqeOrUucf2HZg2En67DRepHfWuiGA9gPVYQhujJqUmKbndYMF5vH8cW41fayfJll6I
         18ghtCteNBQkNuD7BV3OMiGaD8EBe3xLdKA9Rx9eapgrF8ScqLvHbN3VrNIIbcAQ6Wdp
         H5/gjuw60p0V0IwmO2rkZg4yfNSGJMjOQLKiVvZeoDLXMrdEuHVX17wA85VYfPa0HNIi
         3rwWrKK6CdeDBThpo5owLUymUL5p6xhcXNSvCmtnXh136s30OSp5Fx6r8TGJ+a/UdCG/
         vgv7fE/rKDU+z8hdwusgAAjYSvcLNQvQHUo1uVGA3kScOQZaw8sqpzK23FCk4weQ2v17
         ZQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=K9vvh0bGJEe0flqUOu0GON2SuJZ4sPNg64f+S8JdTT4=;
        b=pmA2q3YkDPZxONCimB8XxARX5u63jUyhZVSjE1UYcc3vhLSrnAkQ06z04R7t1M2s2a
         s2GvPQq0xbeYYIXu8tCM3SzwqJCBMTlRuopgLD6G1RgCQncQa+agoF1M9P9xbWMTkaYS
         wbbbD3rZ1dyJdfsufsecGM/EM7bQT1sNjmAGYFudsLtwaX/G6y9O4hGpTX2/qFfbAHTS
         IOMO79eRamMIEf4GhbZV+wuBxDvkR9O536/1BEfMq193Ezyk+z/52vC/aXVm7Km5SNxd
         PsfzaiwveCijeEGxSjMalYBATege9AbQfl7NUPGXNcdKJFO46UtH2I4MeqFrZLy8+zGk
         K7Zg==
X-Gm-Message-State: AOAM533oo9eYFAbUCL3ru8AkA7HXKjSKRESlbczoxsbWNjM4NbooXjEE
        V6gO3kpWKpKBgIMn6bIZMUn86g==
X-Google-Smtp-Source: ABdhPJzrU+n1erxbfvHdUFyCHei7JnZVMzO5QNaKVJSZ1oIyLFbUaSl51Ptv1NCjGs1HjUn3TCcZvg==
X-Received: by 2002:adf:fb0d:0:b0:20d:97e:17ce with SMTP id c13-20020adffb0d000000b0020d097e17cemr27910518wrr.585.1654608086546;
        Tue, 07 Jun 2022 06:21:26 -0700 (PDT)
Received: from ?IPV6:2a00:1098:3142:14:901f:dbcb:c1e4:e4b8? ([2a00:1098:3142:14:901f:dbcb:c1e4:e4b8])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d504d000000b002100e86319asm9405817wrt.78.2022.06.07.06.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 06:21:26 -0700 (PDT)
Message-ID: <9a5d23ee-06d2-82e3-1e32-00367125990d@raspberrypi.com>
Date:   Tue, 7 Jun 2022 14:21:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] random: defer crediting bootloader randomness to
 random_init()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
References: <Yp9DWT3RttJGZhvu@zx2c4.com>
 <20220607124450.794347-1-Jason@zx2c4.com>
From:   Phil Elwell <phil@raspberrypi.com>
In-Reply-To: <20220607124450.794347-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 07/06/2022 13:44, Jason A. Donenfeld wrote:
> Stephen reported that a static key warning splat appears during early
> boot on systems that credit randomness from device trees that contain an
> "rng-seed" property, because because setup_machine_fdt() is called
> before jump_label_init() during setup_arch():
> 
>   static_key_enable_cpuslocked(): static key '0xffffffe51c6fcfc0' used before call to jump_label_init()
>   WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:166 static_key_enable_cpuslocked+0xb0/0xb8
>   Modules linked in:
>   CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0+ #224 44b43e377bfc84bc99bb5ab885ff694984ee09ff
>   pstate: 600001c9 (nZCv dAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : static_key_enable_cpuslocked+0xb0/0xb8
>   lr : static_key_enable_cpuslocked+0xb0/0xb8
>   sp : ffffffe51c393cf0
>   x29: ffffffe51c393cf0 x28: 000000008185054c x27: 00000000f1042f10
>   x26: 0000000000000000 x25: 00000000f10302b2 x24: 0000002513200000
>   x23: 0000002513200000 x22: ffffffe51c1c9000 x21: fffffffdfdc00000
>   x20: ffffffe51c2f0831 x19: ffffffe51c6fcfc0 x18: 00000000ffff1020
>   x17: 00000000e1e2ac90 x16: 00000000000000e0 x15: ffffffe51b710708
>   x14: 0000000000000066 x13: 0000000000000018 x12: 0000000000000000
>   x11: 0000000000000000 x10: 00000000ffffffff x9 : 0000000000000000
>   x8 : 0000000000000000 x7 : 61632065726f6665 x6 : 6220646573752027
>   x5 : ffffffe51c641d25 x4 : ffffffe51c13142c x3 : ffff0a00ffffff05
>   x2 : 40000000ffffe003 x1 : 00000000000001c0 x0 : 0000000000000065
>   Call trace:
>    static_key_enable_cpuslocked+0xb0/0xb8
>    static_key_enable+0x2c/0x40
>    crng_set_ready+0x24/0x30
>    execute_in_process_context+0x80/0x90
>    _credit_init_bits+0x100/0x154
>    add_bootloader_randomness+0x64/0x78
>    early_init_dt_scan_chosen+0x140/0x184
>    early_init_dt_scan_nodes+0x28/0x4c
>    early_init_dt_scan+0x40/0x44
>    setup_machine_fdt+0x7c/0x120
>    setup_arch+0x74/0x1d8
>    start_kernel+0x84/0x44c
>    __primary_switched+0xc0/0xc8
>   ---[ end trace 0000000000000000 ]---
>   random: crng init done
>   Machine model: Google Lazor (rev1 - 2) with LTE
> 
> A trivial fix went in to address this on arm64, 73e2d827a501 ("arm64:
> Initialize jump labels before setup_machine_fdt()"). But it appears that
> fixing it on other platforms might not be so trivial. And in the past
> there have been problems related to add_bootloader_randomness() being
> called too early in boot for what it needed.
> 
> This patch defers all entropy crediting until random_init(), where we
> can be sure that all facilities we need are up and running. It still
> mixes the actual seed immediately, so that it's maximally useful, but
> the crediting doesn't happen until later.
> 
> This also has the positive effect of allowing rng_has_arch_random() to
> reflect bootloader randomness.
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
>   drivers/char/random.c  | 29 +++++++++++++----------------
>   include/linux/random.h |  2 +-
>   2 files changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 4862d4d3ec49..ebfec7cbd5e1 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -725,8 +725,9 @@ static void __cold _credit_init_bits(size_t bits)
>    **********************************************************************/
>   
>   static bool used_arch_random;
> -static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
> -static bool trust_bootloader __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER);
> +static bool trust_cpu __initdata = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
> +static bool trust_bootloader __initdata = IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER);
> +static size_t bootloader_seed_bits __initdata;
>   static int __init parse_trust_cpu(char *arg)
>   {
>   	return kstrtobool(arg, &trust_cpu);
> @@ -776,7 +777,7 @@ static struct notifier_block pm_notifier = { .notifier_call = random_pm_notifica
>   int __init random_init(const char *command_line)
>   {
>   	ktime_t now = ktime_get_real();
> -	unsigned int i, arch_bytes;
> +	unsigned int i, arch_bits;
>   	unsigned long entropy;
>   
>   #if defined(LATENT_ENTROPY_PLUGIN)
> @@ -784,12 +785,12 @@ int __init random_init(const char *command_line)
>   	_mix_pool_bytes(compiletime_seed, sizeof(compiletime_seed));
>   #endif
>   
> -	for (i = 0, arch_bytes = BLAKE2S_BLOCK_SIZE;
> +	for (i = 0, arch_bits = BLAKE2S_BLOCK_SIZE * 8;
>   	     i < BLAKE2S_BLOCK_SIZE; i += sizeof(entropy)) {
>   		if (!arch_get_random_seed_long_early(&entropy) &&
>   		    !arch_get_random_long_early(&entropy)) {
>   			entropy = random_get_entropy();
> -			arch_bytes -= sizeof(entropy);
> +			arch_bits -= sizeof(entropy) * 8;
>   		}
>   		_mix_pool_bytes(&entropy, sizeof(entropy));
>   	}
> @@ -800,9 +801,10 @@ int __init random_init(const char *command_line)
>   
>   	if (crng_ready())
>   		crng_reseed();
> -	else if (trust_cpu)
> -		_credit_init_bits(arch_bytes * 8);
> -	used_arch_random = arch_bytes * 8 >= POOL_READY_BITS;
> +	else
> +		_credit_init_bits((trust_cpu ? arch_bits : 0) +
> +				  (trust_bootloader ? bootloader_seed_bits : 0));
> +	used_arch_random = arch_bits + bootloader_seed_bits >= POOL_READY_BITS;
>   
>   	WARN_ON(register_pm_notifier(&pm_notifier));
>   
> @@ -861,17 +863,12 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
>   }
>   EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
>   
> -/*
> - * Handle random seed passed by bootloader, and credit it if
> - * CONFIG_RANDOM_TRUST_BOOTLOADER is set.
> - */
> -void __cold add_bootloader_randomness(const void *buf, size_t len)
> +/*  Handle random seed passed by bootloader during init. */
> +void __init add_bootloader_randomness(const void *buf, size_t len)
>   {
>   	mix_pool_bytes(buf, len);
> -	if (trust_bootloader)
> -		credit_init_bits(len * 8);
> +	bootloader_seed_bits = len * 8;
>   }
> -EXPORT_SYMBOL_GPL(add_bootloader_randomness);
>   
>   #if IS_ENABLED(CONFIG_VMGENID)
>   static BLOCKING_NOTIFIER_HEAD(vmfork_chain);
> diff --git a/include/linux/random.h b/include/linux/random.h
> index fae0c84027fd..223b4bd584e7 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -13,7 +13,7 @@
>   struct notifier_block;
>   
>   void add_device_randomness(const void *buf, size_t len);
> -void add_bootloader_randomness(const void *buf, size_t len);
> +void __init add_bootloader_randomness(const void *buf, size_t len);
>   void add_input_randomness(unsigned int type, unsigned int code,
>   			  unsigned int value) __latent_entropy;
>   void add_interrupt_randomness(int irq) __latent_entropy;

v3 boots cleanly and with the firmware-provided entropy available from much earlier:

[    0.056431] random: crng init done
[    1.991312] bcm2835-rng 3f104000.rng: hwrng registered

For what it's worth, on rpi-5.15.y and 5.15.45:

     Tested-by: Phil Elwell <phil@raspberrypi.com>

Note that the patch needs some adjustment for 5.15.

Phil
