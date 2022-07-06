Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7402567ECF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiGFGlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiGFGlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:41:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA28B175A1;
        Tue,  5 Jul 2022 23:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6ABBFB810B2;
        Wed,  6 Jul 2022 06:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4558C3411C;
        Wed,  6 Jul 2022 06:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657089676;
        bh=yRGgIJUHXkz2TXJ4J6jNOpjIOkNNlk8+GJwy5fMiZ+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmBMB+TJVrq4Gw9/pfOPUH8FVR53qIvRVpi+/2bZ4Tl0ovU3eWwkhUstZr8i7ntPH
         sWDra3CbZPk7FcieK4NosMw8F7902e+ydwYQXfv07XZQthiCA/VjT5a1qR9aUOe2LN
         7Q6owf5BOUsMUFDooZhriCtR5IVyOMFojtZRxed8=
Date:   Wed, 6 Jul 2022 08:41:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] random: remove CONFIG_ARCH_RANDOM
Message-ID: <YsUuiSP1VW1ok69g@kroah.com>
References: <YsTXI3J+ptkN/vb4@zx2c4.com>
 <20220706003225.335768-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706003225.335768-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 02:32:25AM +0200, Jason A. Donenfeld wrote:
> When RDRAND was introduced, there was much discussion on whether it
> should be trusted and how the kernel should handle that. Initially, two
> mechanisms cropped up, CONFIG_ARCH_RANDOM, a compile time switch, and
> "nordrand", a boot-time switch.
> 
> Later the thinking evolved. With a properly designed RNG, using RDRAND
> values alone won't harm anything, even if the outputs are malicious.
> Rather, the issue is whether those values are being *trusted* to be good
> or not. And so a new set of options were introduced as the real
> ones that people use -- CONFIG_RANDOM_TRUST_CPU and "random.trust_cpu".
> With these options, RDRAND is used, but it's not always credited. So in
> the worst case, it does nothing, and in the best case, maybe it helps.
> 
> Along the way, CONFIG_ARCH_RANDOM's meaning got sort of pulled into the
> center and became something certain platforms force-select.
> 
> The old options don't really help with much, and it's a bit odd to have
> special handling for these instructions when the kernel can deal fine
> with the existence or untrusted existence or broken existence or
> non-existence of that CPU capability.
> 
> So this commit simplifies things down to the two options that are
> actually used, and removes the confusing old ones that aren't used or
> useful. It leaves "nordrand" for now, as the removal of that will take a
> different route.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/arm64/Kconfig                                |  8 --------
>  arch/arm64/include/asm/archrandom.h               | 10 ----------
>  arch/arm64/kernel/cpufeature.c                    |  2 --
>  arch/powerpc/Kconfig                              |  3 ---
>  arch/powerpc/include/asm/archrandom.h             |  3 ---
>  arch/powerpc/include/asm/machdep.h                |  2 --
>  arch/powerpc/platforms/microwatt/Kconfig          |  1 -
>  arch/powerpc/platforms/powernv/Kconfig            |  1 -
>  arch/powerpc/platforms/pseries/Kconfig            |  1 -
>  arch/s390/Kconfig                                 | 15 ---------------
>  arch/s390/configs/zfcpdump_defconfig              |  1 -
>  arch/s390/crypto/Makefile                         |  2 +-
>  arch/s390/include/asm/archrandom.h                |  3 ---
>  arch/x86/Kconfig                                  |  9 ---------
>  arch/x86/include/asm/archrandom.h                 | 10 +---------
>  arch/x86/kernel/cpu/rdrand.c                      |  2 --
>  drivers/char/Kconfig                              |  1 -
>  drivers/char/hw_random/s390-trng.c                |  9 ---------
>  include/linux/random.h                            |  9 +--------
>  .../selftests/wireguard/qemu/kernel.config        |  1 -
>  20 files changed, 3 insertions(+), 90 deletions(-)


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
