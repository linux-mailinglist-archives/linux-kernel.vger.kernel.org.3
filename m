Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D687512780
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 01:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiD0XaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 19:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiD0XaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ED0186E6;
        Wed, 27 Apr 2022 16:27:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDE4761E68;
        Wed, 27 Apr 2022 23:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF00C385A7;
        Wed, 27 Apr 2022 23:26:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aOdMBmtf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651102015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nWDNbsJItINsLR3yxg8JBi2xoW/BcHeKskSWcq4/k8M=;
        b=aOdMBmtfuF0MGGiSVluZuDIGY65KoF2ta9QbQU0a3Hm+hoDaONoZWS7vc2OhhG29kmvk18
        QfGyIUWoxVVN4SDAKHU3dsAUDECxHgIL1/LHRn+5hnQ+35V538hximU7N9JVimKepPTIIS
        WpXigXH/FTevsDle9NY3UX8lVdVoEUI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 54c7499e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 27 Apr 2022 23:26:54 +0000 (UTC)
Date:   Thu, 28 Apr 2022 01:26:52 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: Re: [PATCH v6 11/17] openrisc: use fallback for random_get_entropy()
 instead of zero
Message-ID: <YmnRPPZOTfGZxDiD@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-12-Jason@zx2c4.com>
 <Ymm4xhRDWjvWS+3X@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ymm4xhRDWjvWS+3X@antec>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

On Thu, Apr 28, 2022 at 06:42:30AM +0900, Stafford Horne wrote:
> On Sat, Apr 23, 2022 at 11:26:17PM +0200, Jason A. Donenfeld wrote:
> > In the event that random_get_entropy() can't access a cycle counter or
> > similar, falling back to returning 0 is really not the best we can do.
> > Instead, at least calling random_get_entropy_fallback() would be
> > preferable, because that always needs to return _something_, even
> > falling back to jiffies eventually. It's not as though
> > random_get_entropy_fallback() is super high precision or guaranteed to
> > be entropic, but basically anything that's not zero all the time is
> > better than returning zero all the time.
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Jonas Bonn <jonas@southpole.se>
> > Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  arch/openrisc/include/asm/timex.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/openrisc/include/asm/timex.h b/arch/openrisc/include/asm/timex.h
> > index d52b4e536e3f..115e89b336cd 100644
> > --- a/arch/openrisc/include/asm/timex.h
> > +++ b/arch/openrisc/include/asm/timex.h
> > @@ -23,6 +23,9 @@ static inline cycles_t get_cycles(void)
> >  {
> >  	return mfspr(SPR_TTCR);
> >  }
> > +#define get_cycles get_cycles
> > +
> > +#define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
> >  
> >  /* This isn't really used any more */
> >  #define CLOCK_TICK_RATE 1000
> > -- 
> > 2.35.1
> 
> Hi Jason,
> 
> This looks OK, but I am wondering why we cannot add this to
> "include/linux/timex.h" as the default implementation of random_get_entropy
> if get_cycles is defined.  I see there are 2 cases:
> 
>    1. architectures that define get_cycles, and random_get_entropy is defined in
>       include/linux/timex.h.
>       (openrisc, sparc*, xtensa*, nios2, um*, arm)
> 
>    2. architectures that define random_get_entropy explicitly
>       (mips, m68k, riscv, x86)
> 
> * Those marked with * just define get_cycles as 0.
> 
> I would think in "include/linux/timex.h" we could define.
> 
>     #ifndef random_get_entropy
>     #ifdef get_cycles
>     #define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
>     #else
>     #define random_get_entropy()   random_get_entropy_fallback()
>     #endif
>     #endif
> 
> For architectures that define get_cycles as 0, they can be cleaned up.
> 
> -Stafford

What you've described is what patch 6 of this series already does.

However, it does it assuming that if get_cycles() exists, it returns a
real value, because most architectures do the right thing by default
when they choose to define that function, and thus there is no purpose
in adding the needless branch.

OpenRISC, however, is a notable outlier in that the code generated by
get_cycles() does not correspond to an actual cycle counter on all CPU
implementations. In particular, the QEMU simulator always returns 0. And
the QEMU simulator is in fact what people are using to test this stuff,
so the kernel code needs to actually work for this prevalent "virtual
silicon", which I assume is much more widely deployed than any real FPGA
running this or that OpenRISC softcore.

So this patch includes the branch as part of its definition, so that we
get the best of both worlds, which seems to me like a pretty acceptable
compromise.

Thanks,
Jason
