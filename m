Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E01567822
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiGET5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiGET5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:57:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205DD12609;
        Tue,  5 Jul 2022 12:57:14 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff625329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f625:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 563241EC0513;
        Tue,  5 Jul 2022 21:57:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657051028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Y0U35vMX74kXxtKME+uItAJHsSwmFddMjvSCpjyQPj8=;
        b=DiwfS7UbthNvF8uPkSvMWijUr+9SR1Oegvu9M94gxrifro3VGXsAzTZgbkkfR+bTkof9CU
        NEcWkSCBrtbKJnT/X+6bhlEH/oXTb9HMZwuAieiM/e3LdzZe/20wFDfVdGBl07ojky6143
        L0dNZFDKdpgatJx+Wz78IitJ+up+C8E=
Date:   Tue, 5 Jul 2022 21:57:04 +0200
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
Message-ID: <YsSXkNBtB6Ciy9iN@zn.tnic>
References: <20220705190121.293703-1-Jason@zx2c4.com>
 <YsSStCQQf008hF2F@zn.tnic>
 <YsSUkapje04MP2a1@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsSUkapje04MP2a1@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 09:44:17PM +0200, Jason A. Donenfeld wrote:
> Oh, huh. Maybe in that case I should adjust the message to say "consider
> using `random.trust_cpu=0`," which is the thing that would actually make
> a security difference.

Why isn't that option documented in
Documentation/admin-guide/kernel-parameters.txt?

> But actually, one thing that wasn't clear to me was: does `nordrand`
> affect what userspace sees? While random.c is okay in lots of
> circumstances, I could imagine `nordrand` playing a role in preventing
> userspace from using it, which might be desirable. Is this the case? If
> so, I can remove the nordrand chunk from this patch for v2. If not, I'll
> adjust the text to mention `random.trust_cpu=0`.

Unfortunately, it doesn't disable the instruction. It would be lovely if
we had a switch like that...

That's why this message is supposed to be noisy so that people can pay
attention at least.

> In the sense that random.c can handle mostly any input without making
> the quality worse. So, you can't accidentally taint it. The only risk is
> if it thinks RDRAND is good and trustable when it isn't, but that's what
> `random.trust_cpu=0` is for.

And that's why I'm saying that if you detect RDRAND returning the
same thing over and over again, you should simply stop using it.
Automatically. Not rely on the user to do anything.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
