Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE10B5696C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiGGAMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiGGAMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:12:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58832D1E5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 17:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=lSe/iP0QD8qo0z9KUZ6UmOi1Xb7MUaPoZVMNvIdi5Tc=; b=0o/o3w1l2f4fllZ23q9+NWMO3v
        d2kSlheeUlLvK7pW2MYnt5zIoy3FgD1Ftu+WdH2eMKcD5COGhkz2RqDckFcH//O9jgrydeW9UNW/n
        lUjjiUgQwEtI4qfDpAdZSUha7zkWnwkkFT+AUN4lMnlpt3nC8WaqIgOSZKllmYmKvKdQ2lTZwfWg0
        CwkxUbv2+EETN5KtzIsUFLVqszQq9dWp9bdhqs2CRai4nD3gL4fCFKQaSxRuDsHL+n6033dXnR3Pw
        fRqiTPqEZEUfmfOj5++S1y2JpfR+wTfx414vctOUM+PvJb4pcuVqZUDelnsl3eC07UJI6IBeoc+fM
        OGyR15tQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9F7u-00Cq40-NJ; Thu, 07 Jul 2022 00:12:14 +0000
Message-ID: <2603a1c4-ef5d-7719-b458-e70da180b878@infradead.org>
Date:   Wed, 6 Jul 2022 17:12:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] random: remove "nordrand" flag in favor of
 "random.trust_cpu"
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Theodore Ts'o <tytso@mit.edu>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>
References: <20220707000021.504308-1-Jason@zx2c4.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220707000021.504308-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 7/6/22 17:00, Jason A. Donenfeld wrote:
> The decision of whether or not to trust RDRAND is controlled by the
> "random.trust_cpu" boot time parameter or the CONFIG_RANDOM_TRUST_CPU
> compile time default. The "nordrand" flag was added during the early
> days of RDRAND, when there were worries that merely using its values
> could compromise the RNG. However, these days, RDRAND values are not
> used directly but always go through the RNG's hash function, making
> "nordrand" no longer useful.
> 
> Rather, the correct switch is "random.trust_cpu", which not only handles
> the relevant trust issue directly, but also is general to multiple CPU
> types, not just x86.
> 
> However, x86 RDRAND does have a history of being occassionally

                                                   occasionally

> problematic. Prior, when the kernel would notice something strange, it'd
> warn in dmesg and suggest enabling "nordrand". We can improve on that by
> making the test a little bit better and then taking the step of
> automatically disabling "nordrand" if we detect it's problematic.

                enabling
?  I.e., disabling RDRAND and RDSEED.


> 
> Also extend the basic sanity test to RDSEED in addition to RDRAND, and
> disable both if either one fails.
> 
> Cc: x86@kernel.org
> Cc: Theodore Ts'o <tytso@mit.edu>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> This patch builds on top of v4 of "random: remove CONFIG_ARCH_RANDOM":
> https://lore.kernel.org/lkml/20220706143521.459565-1-Jason@zx2c4.com/
> 
>  .../admin-guide/kernel-parameters.txt         |  5 --
>  arch/x86/kernel/cpu/amd.c                     |  2 +-
>  arch/x86/kernel/cpu/rdrand.c                  | 73 +++++++++----------
>  3 files changed, 36 insertions(+), 44 deletions(-)

> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 0c0b09796ced..216fc2f53cbe 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -808,7 +808,7 @@ static void clear_rdrand_cpuid_bit(struct cpuinfo_x86 *c)
>  		return;
>  
>  	/*
> -	 * The nordrand option can clear X86_FEATURE_RDRAND, so check for
> +	 * The self test can clear X86_FEATURE_RDRAND, so check for

Preferably:    self-test

>  	 * RDRAND support using the CPUID function directly.
>  	 */
>  	if (!(cpuid_ecx(1) & BIT(30)) || rdrand_force)


-- 
~Randy
