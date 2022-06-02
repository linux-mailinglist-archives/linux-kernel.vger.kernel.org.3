Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0491C53B19C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiFBCIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 22:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiFBCIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 22:08:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF81F24851B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 19:08:37 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d129so3497602pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 19:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xYNTX2mpCMe8a0CcUXMvFebxOL0u5asl+aYsJ5XYMjw=;
        b=cfhjd+GFR3CD1LDDxAUy4k5bHPl45dgK9L/vFFk6dWbmx/2IC9t23TxgwOX8opDZRM
         q8PIsJmZe3IzZlTUIRJmdNQjMwjQ3gIuIV6REDqvDFlT7pcN28g2yQNraBLTXnwXjwnD
         OpDiVQec+JceZfIOIsKZPuETylI6T/gGahTY1z9K3QFzFxR3E8DI7zIi8DiFU2BhPYzu
         n4S/nURC3V6Kmfalq9dV6/Bfp6b6AdypUUOSZ8fJGXDVThTLGLlALsQLa7jKgw6An6O8
         jQ9qj4UyEVKijpALfnEctLkGitft0iaWZXJIo3FgGvL1ZIUoufO7zb6RpUC0kTmgN52g
         PlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xYNTX2mpCMe8a0CcUXMvFebxOL0u5asl+aYsJ5XYMjw=;
        b=DdiVEMBnKm8wn6/gHPoecHYa7Xy+/BHrXRB1mqK8ZOxwYT3xGTKuVFic5wnIPWtbJr
         ReF+ATkJzzVkzWMvUgZfHarlEVXtNk9SLFfmY7/54DxNBviJBw6FGKlzK8QuTBA+ClS6
         46SL174s/BG6hOJuMDAj4FhIIeO3+tko1853tPdwN0okGVhQnjKCqNjUBJjFFfeeciYC
         RrGAE8N4bRJOkvn83fO1EbC3RSbJxga9J/nB1xKBGRsMslfPpekQRchYN6IHNgJVRrks
         y8q/rqAqfOlMrsfgIoFwp/s2eAdUFekwJYMdvttSba3Swbt1lQYpDcp+l/Ye8axL9Yvi
         2Txg==
X-Gm-Message-State: AOAM5326DFHnw1Sivh7mR2QgBwnLU1s0HUbPFMVBHVCC2XGJuWWSE4So
        /UEIRmk+53ybFzTP7/IlaRAp4g==
X-Google-Smtp-Source: ABdhPJwM6jMU+4HQhS5HV0eRbtnoUKzXjjqPmMTyZ9hNeBb7jNsAtYwRg5OlZ99Zx1IQ9DKrdMFlDQ==
X-Received: by 2002:a05:6a00:1a44:b0:510:a043:3b09 with SMTP id h4-20020a056a001a4400b00510a0433b09mr69073282pfv.62.1654135716389;
        Wed, 01 Jun 2022 19:08:36 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b0016641a37e71sm156846plb.225.2022.06.01.19.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 19:08:36 -0700 (PDT)
Date:   Wed, 01 Jun 2022 19:08:36 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Jun 2022 19:08:34 PDT (-0700)
Subject:     Re: [PATCH v1] RISC-V: Only default to spinwait on SBI-0.1 and M-mode
In-Reply-To: <20220421170354.10555-1-palmer@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        atishp@atishpatra.org, anup@brainfault.org,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-riscv@lists.infradead.org
Message-ID: <mhng-5203a5dd-c960-4c13-827d-9512d4c1374b@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 10:03:55 PDT (-0700), Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> The spinwait boot method has been superseeded by the SBI HSM extension
> for some time now, but it still enabled by default.  This causes some
> issues on large hart count systems, which will hang if a physical hart
> exists that is larger than NR_CPUS.
>
> Users on modern SBI implemenation don't need spinwait, and while it's
> probably possible to deal with some of the spinwait issues let's just
> restrict the default to systems that are likely to actually use it.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> This seems to be the source of many of my new hangs when trying to test
> the NR_CPUS=512 support.  It's not really related, just fallout from
> testing different setups.
> ---
>  arch/riscv/Kconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 00fd9c548f26..dd5e975abe37 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -359,7 +359,7 @@ config RISCV_SBI_V01
>  config RISCV_BOOT_SPINWAIT
>  	bool "Spinwait booting method"
>  	depends on SMP
> -	default y
> +	default y if RISCV_SBI_V01 || RISCV_M_MODE
>  	help
>  	  This enables support for booting Linux via spinwait method. In the
>  	  spinwait method, all cores randomly jump to Linux. One of the cores
> @@ -370,6 +370,12 @@ config RISCV_BOOT_SPINWAIT
>  	  rely on ordered booting via SBI HSM extension which gets chosen
>  	  dynamically at runtime if the firmware supports it.
>
> +	  Since spinwait is incompatible with sparse hart IDs, it requires
> +	  NR_CPUS be large enough to contain the physical hart ID of the first
> +	  hart to enter Linux.
> +
> +	  If unsure what to do here, say N.
> +
>  config KEXEC
>  	bool "Kexec system call"
>  	select KEXEC_CORE

This is on for-next, with some typos fixed.
