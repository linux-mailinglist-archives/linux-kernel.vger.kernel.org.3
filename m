Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5F500ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbiDNKPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiDNKPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:15:09 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66886C927;
        Thu, 14 Apr 2022 03:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=upqcvBN0c/2twwWoHUne//eX4ki0XQTMtmfsi6ArAXU=; b=HjGPsWLJY1Ur/Qd9SaLg0YiKnR
        95tjp26+YgI/HwEOdRqvSlAROO2sO63Z/uXu1t6/V5/PtASP1IW3k8kj55+7tgoHxaUyNfpLnuymj
        G+Nuireb4o2uAs9tgNLn8PCnmIvfeYm/3imhJXibehEvAyy2bcpTUxyuVWUQ0H1lRVoogDYJt+XGn
        +JXGGLKSFLPO1NgiG/h6Ou0ERgDMxxK3z39Afa9Ihp7G2oki6nDRlwzM4i7qfs+r/iBEJYNjoTAgZ
        nYexjH0hGr4I1XQ6yy/K0FsGtjU27thDPBNsh2vJZf5a5imdfgQbx4As5XreqUcbwl+Pi+VE00syg
        bbEnVKOQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58256)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1newSp-0004M9-DZ; Thu, 14 Apr 2022 11:12:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1newSh-0004Du-6v; Thu, 14 Apr 2022 11:12:27 +0100
Date:   Thu, 14 Apr 2022 11:12:27 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v4 01/11] timekeeping: add raw clock fallback for
 random_get_entropy()
Message-ID: <Ylfzi1lNWTH1wjLA@shell.armlinux.org.uk>
References: <20220413115411.21489-1-Jason@zx2c4.com>
 <20220413115411.21489-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413115411.21489-2-Jason@zx2c4.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 01:54:01PM +0200, Jason A. Donenfeld wrote:
> The addition of random_get_entropy_fallback() provides access to
> whichever time source has the highest frequency, which is useful for
> gathering entropy on platforms without available cycle counters. It's
> not necessarily as good as being able to quickly access a cycle counter
> that the CPU has, but it's still something, even when it falls back to
> being jiffies-based.
> 
> In the event that a given arch does not define get_cycles(), falling
> back to the get_cycles() default implementation that returns 0 is really
> not the best we can do. Instead, at least calling
> random_get_entropy_fallback() would be preferable, because that always
> needs to return _something_, even falling back to jiffies eventually.
> It's not as though random_get_entropy_fallback() is super high precision
> or guaranteed to be entropic, but basically anything that's not zero all
> the time is better than returning zero all the time.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  include/linux/timex.h     |  8 ++++++++
>  kernel/time/timekeeping.c | 10 ++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/include/linux/timex.h b/include/linux/timex.h
> index 5745c90c8800..fbbe34226044 100644
> --- a/include/linux/timex.h
> +++ b/include/linux/timex.h
> @@ -62,6 +62,8 @@
>  #include <linux/types.h>
>  #include <linux/param.h>
>  
> +extern unsigned long random_get_entropy_fallback(void);

Hi

I'm surprised this didn't trigger checkpatch to warn. From
coding-style:

6.1) Function prototypes
Do not use the ``extern`` keyword with function declarations as this makes
lines longer and isn't strictly necessary.

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
