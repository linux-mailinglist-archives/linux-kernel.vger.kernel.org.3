Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C0B4E5AED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345042AbiCWV6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbiCWV6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:58:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E33A8C7E5;
        Wed, 23 Mar 2022 14:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3211616DF;
        Wed, 23 Mar 2022 21:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAFEC340EE;
        Wed, 23 Mar 2022 21:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648072591;
        bh=DV/xwXjMs6yUzKDL7xfk7T0Q7lFV5SMLpVQvsFGK4IE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T+Pp99yb0nkYq7lonLADQdVHW8DZSZo43gBJ0MHaXQDDZ4G3WkpOKmJSGEFhVfNtl
         atgYQSE2/ODqcpKNbDNBi/wW7KqMgNgf0HoVqZ0Pt0eKnJFH9iQMXCEkJ5v/L6W9zR
         VKfXxlIZYWcQp5mqvb/qH8aWLKMbnRy+Bgv5INP2sgpLIIiDZsjTLoS6GZv8KBP+1g
         6ITYL8fvrPV/w+FE9KTF5yxqDgol9OCIUzDJlr9iRhzb0MI9KuFi5mtQ12SQnGQI/m
         WOIUCxd1du0WfiTmM5oZd6Kkz0wO4eke4MXC9Nu644xqE65/mtLgpGEYBgv+E47n8q
         EhvFs0vLZkBVw==
Received: by mail-ot1-f42.google.com with SMTP id o20-20020a9d7194000000b005cb20cf4f1bso2020389otj.7;
        Wed, 23 Mar 2022 14:56:31 -0700 (PDT)
X-Gm-Message-State: AOAM530a/nUurZyiSOVCr1vhGZkgsJBB5bgXnU1mgW86glqWG+yXnMjt
        5obANLTcEQhM7VXl2aaUTsSsBb1Ak1wr60KDDYY=
X-Google-Smtp-Source: ABdhPJxBFOECq+W0CAvLy4JLZ43MKSWBxAXPwrxsM7HvAy7XqjCVq3nwxA2ZdJQsbXYsNxpg+E324YGd18lYNMhGKUs=
X-Received: by 2002:a05:6830:2e7:b0:5b2:68c1:182a with SMTP id
 r7-20020a05683002e700b005b268c1182amr913494ote.71.1648072590332; Wed, 23 Mar
 2022 14:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220323041123.146459-1-Jason@zx2c4.com>
In-Reply-To: <20220323041123.146459-1-Jason@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Mar 2022 22:56:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGL2J65=ZD7mKEheoPjJFfAeAEx57V35htpbjbpgKDV6g@mail.gmail.com>
Message-ID: <CAMj1kXGL2J65=ZD7mKEheoPjJFfAeAEx57V35htpbjbpgKDV6g@mail.gmail.com>
Subject: Re: [PATCH] random: treat bootloader trust toggle the same way as cpu
 trust toggle
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Graham Christensen <graham@grahamc.com>
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

On Wed, 23 Mar 2022 at 05:11, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> If CONFIG_RANDOM_TRUST_CPU is set, the RNG initializes using RDRAND.
> But, the user can disable (or enable) this behavior by setting
> `random.trust_cpu=0/1` on the kernel command line. This allows system
> builders to do reasonable things while avoiding howls from tinfoil
> hatters. (Or vice versa.)
>
> CONFIG_RANDOM_TRUST_BOOTLOADER is basically the same thing, but regards
> the seed passed via EFI or device tree, which might come from RDRAND or
> a TPM or somewhere else. In order to allow distros to more easily enable
> this while avoiding those same howls (or vice versa), this commit adds
> the corresponding `random.trust_bootloader=0/1` toggle.
>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Graham Christensen <graham@grahamc.com>
> Link: https://github.com/NixOS/nixpkgs/pull/165355
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/char/random.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 7b7f5e6596c2..c8974e5f57e1 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -948,11 +948,17 @@ static bool drain_entropy(void *buf, size_t nbytes, bool force)
>   **********************************************************************/
>
>  static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
> +static bool trust_bootloader __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER);
>  static int __init parse_trust_cpu(char *arg)
>  {
>         return kstrtobool(arg, &trust_cpu);
>  }
> +static int __init parse_trust_bootloader(char *arg)
> +{
> +       return kstrtobool(arg, &trust_bootloader);
> +}
>  early_param("random.trust_cpu", parse_trust_cpu);
> +early_param("random.trust_bootloader", parse_trust_bootloader);
>
>  /*
>   * The first collection of entropy occurs at system boot while interrupts
> @@ -1160,7 +1166,7 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
>   */
>  void add_bootloader_randomness(const void *buf, size_t size)
>  {
> -       if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
> +       if (trust_bootloader)
>                 add_hwgenerator_randomness(buf, size, size * 8);
>         else
>                 add_device_randomness(buf, size);
> --
> 2.35.1
>
