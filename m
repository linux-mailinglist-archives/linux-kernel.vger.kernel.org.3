Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00CF4DE19F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 20:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbiCRTNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiCRTNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:13:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E47D0247C2C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:11:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DB2111FB;
        Fri, 18 Mar 2022 12:11:46 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 716A13F766;
        Fri, 18 Mar 2022 12:11:44 -0700 (PDT)
Message-ID: <3b9cedd6-a084-5d87-2fdd-0da10146827b@arm.com>
Date:   Fri, 18 Mar 2022 19:11:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: fix clang warning about TRAMP_VALIAS
Content-Language: en-GB
To:     Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Morse <james.morse@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220316183833.1563139-1-arnd@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220316183833.1563139-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-16 18:38, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly introduced TRAMP_VALIAS definition causes a build warning
> with clang-14:
> 
> arch/arm64/include/asm/vectors.h:66:31: error: arithmetic on a null pointer treated as a cast from integer to pointer is a GNU extension [-Werror,-Wnull-pointer-arithmetic]

Tangentially, all the other GNU extensions we depend on throughout Linux 
are also GNU extensions. Do we know what's special about this one?

Robin.

>                  return (char *)TRAMP_VALIAS + SZ_2K * slot;
> 
> Change the addition to something clang does not complain about.
> 
> Fixes: bd09128d16fa ("arm64: Add percpu vectors for EL1")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm64/include/asm/vectors.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> I see this warning on 5.17-rc8, but did not test it on linux-next,
> which may already have a fix.
> 
> diff --git a/arch/arm64/include/asm/vectors.h b/arch/arm64/include/asm/vectors.h
> index f64613a96d53..bc9a2145f419 100644
> --- a/arch/arm64/include/asm/vectors.h
> +++ b/arch/arm64/include/asm/vectors.h
> @@ -56,14 +56,14 @@ enum arm64_bp_harden_el1_vectors {
>   DECLARE_PER_CPU_READ_MOSTLY(const char *, this_cpu_vector);
>   
>   #ifndef CONFIG_UNMAP_KERNEL_AT_EL0
> -#define TRAMP_VALIAS	0
> +#define TRAMP_VALIAS	0ul
>   #endif
>   
>   static inline const char *
>   arm64_get_bp_hardening_vector(enum arm64_bp_harden_el1_vectors slot)
>   {
>   	if (arm64_kernel_unmapped_at_el0())
> -		return (char *)TRAMP_VALIAS + SZ_2K * slot;
> +		return (char *)(TRAMP_VALIAS + SZ_2K * slot);
>   
>   	WARN_ON_ONCE(slot == EL1_VECTOR_KPTI);
>   
