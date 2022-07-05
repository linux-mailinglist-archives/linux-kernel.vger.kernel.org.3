Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849BA5677E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiGETgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiGETgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:36:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5FE13FB2;
        Tue,  5 Jul 2022 12:36:30 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff625329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f625:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE0E71EC0628;
        Tue,  5 Jul 2022 21:36:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657049785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=s8J8d5ZD1NtUU5JRSS/ItcYuS6F4P47XpllivMzf87o=;
        b=CYAJFqLPSx1ehm7wcUphSX9EWalTFYzy2s5e2vW1knuJ2MgMxhOyXFZiKJxRnn65i1LTXx
        z6QxxfrgCmuNCUqEFoukAoKTL/2V6JEeQCCX4HCRrDpCeDWCRbeLyIZPGE82Hs3kg+czu+
        9EUDiQHULEW8UFb3P8zZIkSHwIX4AB8=
Date:   Tue, 5 Jul 2022 21:36:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] random: remove CONFIG_ARCH_RANDOM and "nordrand"
Message-ID: <YsSStCQQf008hF2F@zn.tnic>
References: <20220705190121.293703-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220705190121.293703-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 09:01:21PM +0200, Jason A. Donenfeld wrote:
> @@ -26,7 +18,6 @@ __setup("nordrand", x86_rdrand_setup);
>   */
>  #define SANITY_CHECK_LOOPS 8
>  
> -#ifdef CONFIG_ARCH_RANDOM
>  void x86_init_rdrand(struct cpuinfo_x86 *c)
>  {
>  	unsigned int changed = 0;
> @@ -59,8 +50,6 @@ void x86_init_rdrand(struct cpuinfo_x86 *c)
>  	}
>  
>  	if (WARN_ON_ONCE(!changed))
> -		pr_emerg(
> -"RDRAND gives funky smelling output, might consider not using it by booting with \"nordrand\"");
> +		pr_emerg("RDRAND gives funky smelling output; update microcode or firmware.");

It is highly unlikely to get a BIOS or microcode update for that matter,
for old systems:

7879fc4bdc75 ("x86/rdrand: Sanity-check RDRAND output")

so I guess here you're better off saying that the kernel simply disables
rdrand support and do

	clear_cpu_cap(c, X86_FEATURE_RDRAND);

here too.

If I read the commit message above correctly, it sounds like RDRAND
output is not that important anyway...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
