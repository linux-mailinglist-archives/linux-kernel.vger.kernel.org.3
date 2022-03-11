Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CC54D66FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347356AbiCKRBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiCKRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:01:32 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7315266239
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:00:27 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n2so8164844plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=uyogg3EITvNDbcMhB98sICz37uKoHpxrlJ00H656sok=;
        b=1QTh1VVAysYbusZtQvZnvS1uPDJ6UlW/q2rXouJaFlj2LfOlJkQJmUXDkVwN+n91WR
         fb5HQohWhJ4+39XTBP33I8eCdQChPnCjuKYkTJxqpDT9FHhMSXEUNM0LmFU9yjw3aLgy
         wSfzU4U2yPAdn4DBO1OmkU6EmoO5yyZ4wLr526/wnaJAbhrHb39Bx7gbi2GJ5C5JD1Ey
         4Ta6iD6aPT7DyE3No7DqzMX881T2uLkD+llW3FihXEFFNDH8bJwRBv481ocYkT4lf5m+
         JWDDf6umfO3t59FLm0WJXX6JfbW6lzKRZz+9VK9XoR46HPLmGt3cbWwn+IfMoQ09sxlN
         WGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=uyogg3EITvNDbcMhB98sICz37uKoHpxrlJ00H656sok=;
        b=VhMlycj51wnCOxrVdbP/1JVT09s0oRZwAOXLf4AEgcwXSdpNX0Vl4JcOkWT0PrTThB
         PlkDGMgaeJneobhZMHyFt5kUA7EN+GMPZ8apkrrr6X5B9JvDBPUjfw1OhJvoTURMt6lT
         mewQH3FPI6IdS4shCqbKxmPzOULH/aSzxIhFKbEL+7sZ0AYSixHLCJ8FlRbE9EYd7JhL
         Gh3YgwRCGt5GHo8hDhMK+9U5Dupj30E8kvQLxPYyjSEqv6YOe8tV9RYvR4mVggOBw9LZ
         fHwCy6ol1cnVs9P9gBtmo/L31z9tozfv09VGiHmMsmGTNuZ4OtAU1UTDyCiGJeCjzTL8
         RXPA==
X-Gm-Message-State: AOAM5318pVOr8YNRNuHGaE6BAh+bjW7+MAU3qNBpuOVn3UmftciUhsIV
        DEz0jtp7XkfgxzeH0Juprr4dbw==
X-Google-Smtp-Source: ABdhPJx9JM9P1TWOsem86I4wVFjtzG0TMU9JZaMNtnIWx4L8zMBicbk6CBIzFDaHi4fXzvW7syUBqw==
X-Received: by 2002:a17:90b:1d84:b0:1bf:674d:2db5 with SMTP id pf4-20020a17090b1d8400b001bf674d2db5mr11706345pjb.8.1647018026779;
        Fri, 11 Mar 2022 09:00:26 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id l4-20020a639844000000b003806f93fd57sm8988340pgo.42.2022.03.11.09.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:00:25 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:00:25 -0800 (PST)
X-Google-Original-Date: Thu, 10 Mar 2022 20:45:07 PST (-0800)
Subject:     Re: [PATCH] riscv: Fix auipc+jalr relocation range checks
In-Reply-To: <20220223191257.143694-1-kernel@esmil.dk>
CC:     linux-riscv@lists.infradead.org, kernel@esmil.dk,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     kernel@esmil.dk
Message-ID: <mhng-5e2f04e5-f721-4ef6-a51d-ddd4611bfa5f@palmer-ri-x1c9>
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

On Wed, 23 Feb 2022 11:12:57 PST (-0800), kernel@esmil.dk wrote:
> RISC-V can do PC-relative jumps with a 32bit range using the following
> two instructions:
>
> 	auipc	t0, imm20	; t0 = PC + imm20 * 2^12
> 	jalr	ra, t0, imm12	; ra = PC + 4, PC = t0 + imm12
>
> Crucially both the 20bit immediate imm20 and the 12bit immediate imm12
> are treated as two's-complement signed values. For this reason the
> immediates are usually calculated like this:
>
> 	imm20 = (offset + 0x800) >> 12
> 	imm12 = offset & 0xfff
>
> ..where offset is the signed offset from the auipc instruction. When
> the 11th bit of offset is 0 the addition of 0x800 doesn't change the top
> 20 bits and imm12 considered positive. When the 11th bit is 1 the carry
> of the addition by 0x800 means imm20 is one higher, but since imm12 is
> then considered negative the two's complement representation means it
> all cancels out nicely.
>
> However, this addition by 0x800 (2^11) means an offset greater than or
> equal to 2^31 - 2^11 would overflow so imm20 is considered negative and
> result in a backwards jump. Similarly the lower range of offset is also
> moved down by 2^11 and hence the true 32bit range is
>
> 	[-2^31 - 2^11, 2^31 - 2^11)
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  arch/riscv/kernel/module.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 68a9e3d1fe16..4a48287513c3 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -13,6 +13,19 @@
>  #include <linux/pgtable.h>
>  #include <asm/sections.h>
>
> +/*
> + * The auipc+jalr instruction pair can reach any PC-relative offset
> + * in the range [-2^31 - 2^11, 2^31 - 2^11)
> + */
> +static bool riscv_insn_valid_32bit_offset(ptrdiff_t val)
> +{
> +#ifdef CONFIG_32BIT
> +	return true;
> +#else
> +	return (-(1L << 31) - (1L << 11)) <= val && val < ((1L << 31) - (1L << 11));
> +#endif
> +}
> +
>  static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
>  {
>  	if (v != (u32)v) {
> @@ -95,7 +108,7 @@ static int apply_r_riscv_pcrel_hi20_rela(struct module *me, u32 *location,
>  	ptrdiff_t offset = (void *)v - (void *)location;
>  	s32 hi20;
>
> -	if (offset != (s32)offset) {
> +	if (!riscv_insn_valid_32bit_offset(offset)) {
>  		pr_err(
>  		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
>  		  me->name, (long long)v, location);
> @@ -197,10 +210,9 @@ static int apply_r_riscv_call_plt_rela(struct module *me, u32 *location,
>  				       Elf_Addr v)
>  {
>  	ptrdiff_t offset = (void *)v - (void *)location;
> -	s32 fill_v = offset;
>  	u32 hi20, lo12;
>
> -	if (offset != fill_v) {
> +	if (!riscv_insn_valid_32bit_offset(offset)) {
>  		/* Only emit the plt entry if offset over 32-bit range */
>  		if (IS_ENABLED(CONFIG_MODULE_SECTIONS)) {
>  			offset = module_emit_plt_entry(me, v);
> @@ -224,10 +236,9 @@ static int apply_r_riscv_call_rela(struct module *me, u32 *location,
>  				   Elf_Addr v)
>  {
>  	ptrdiff_t offset = (void *)v - (void *)location;
> -	s32 fill_v = offset;
>  	u32 hi20, lo12;
>
> -	if (offset != fill_v) {
> +	if (!riscv_insn_valid_32bit_offset(offset)) {
>  		pr_err(
>  		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
>  		  me->name, (long long)v, location);

Thanks, this is on fixes.
