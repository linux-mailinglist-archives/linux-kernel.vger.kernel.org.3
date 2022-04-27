Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46598510DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356711AbiD0BdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356696AbiD0BdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:33:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0EA85951;
        Tue, 26 Apr 2022 18:29:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBE6261B00;
        Wed, 27 Apr 2022 01:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A544C385A4;
        Wed, 27 Apr 2022 01:29:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CGbbkflC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651022993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MANIJ4dySSmqaJTF4fSL00Mb6tX9r5q9w+jDvanNPvI=;
        b=CGbbkflC5ZOzObHN/pdheOjw12c696PG/stwJDnJ2opClpVC2rdF/VqP/+S8K2GTOHyrws
        ORbm0zVxO6c+JToIF7Q+aq/0WTICrDr69w+iPJc/lX3sjmm3q9bbjAxlI13b6jukR2syR4
        JX3AQvo+0WFiMT1u3rI8eNYT1pXMm7Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83d69ec3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 27 Apr 2022 01:29:52 +0000 (UTC)
Date:   Wed, 27 Apr 2022 03:29:49 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v6 09/17] mips: use fallback for random_get_entropy()
 instead of just c0 random
Message-ID: <YmicjVbkcppfzE1E@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-10-Jason@zx2c4.com>
 <alpine.DEB.2.21.2204250113440.9383@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2204250113440.9383@angie.orcam.me.uk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Maciej,

On Tue, Apr 26, 2022 at 09:28:39PM +0100, Maciej W. Rozycki wrote:
> On Sat, 23 Apr 2022, Jason A. Donenfeld wrote:
> 
> > diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
> > index b05bb70a2e46..8cfa485d19e6 100644
> > --- a/arch/mips/include/asm/timex.h
> > +++ b/arch/mips/include/asm/timex.h
> [...]
> > +	if (cpu_has_3kex)
> > +		c0_random = (read_c0_random() >> 8) & 0x3f;
> 
>  Hmm, I wonder whether we do need to mask the contents of the register out 
> here given that known implementations return zeros in reserved bits.  Even 
> though R3000 documentation I have access to makes no guarantee as to the 
> values of the reserved bits here I think we can safely proceed according 
> to what systems we do actually support do (even though it only saves one 
> instruction).
> 
> >  	else
> > -		return 0;	/* no usable register */
> > +		c0_random = read_c0_random() & 0x3f;
> 
>  Here the architecture guarantees unused bits to be zero, but the number 
> of them varies between implementations.  However we'll only ever use this 
> leg for the R4000/R4400 processors, which have 48 TLB entries, and for the 
> Ingenic XBurst cores, which I have now verified in documentation (which 
> user-reported dumps from /proc/cpuinfo are consistent with) that have 32 
> TLB entries.  So I think this mask operation can go as well.
> 
>  I guess these updates can be made with a follow-up change though.

There is lots of optimization potential on a few fronts we've identified
in this thread. Let's save these for a follow-up. I'd rather this
initial one be at least somewhat simple, so that as it gets optimized,
it'll be easy to handle regressions. Also, it probably makes sense for
you to send the patches for these, since you have both the hardware
chops and the hardware itself to assess these ideas. I am interested in
the topic though, so please do CC me.

Jason
