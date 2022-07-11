Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45745700DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiGKLlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiGKLl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:41:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1524505E;
        Mon, 11 Jul 2022 04:29:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z25so8180601lfr.2;
        Mon, 11 Jul 2022 04:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O1FNPLaG9NFlJDuG+4/3W9wLSHM1Vz8aeMpNL4EwiUM=;
        b=e2vvgPOhuXO6K48NqJf6zHlpISR8A/yaQNv5mCoDzwxyh14IS3yEljYXcltV4C3jzO
         ZmJkNKGPEjXdH05ZjWDSVBYAMOYkbcLNUNXf6N3pJ2JwCjq26tAB00MfAk8OZzMrMygg
         dXEE4KnaOq6oGwGSFQHUi7fNI5JOkYhtos1TZXO8QyRcSgLY+Gs1R0LBMMJnh/LV+UQr
         t4Vv7maNgSz3+IpMeX/6hb1GjPZ+8iTSBm2eSRS7ZvpWSg4wsgIFBJVSQo2Zaox15nWC
         W0db/T53uqmu9EGTV1QqtqxnQ9tMWVlpR8vtByAJGDQR5NR/qE0/vNuxoP0pizup1opo
         umYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O1FNPLaG9NFlJDuG+4/3W9wLSHM1Vz8aeMpNL4EwiUM=;
        b=REdOzatv4l9KbSljYHcL2cvqrkkD6QaMFpP36Wi/CWUA34Og2RnL5Yw2jo6H6mSzf0
         Y7VzsZIkL6s21J8z2hB5kJMVve1TWA2vi2SnOiVevJV7g5z+U8blH3gWe8h6V7RSH+xt
         Zt5RBlqOc934ibVn0jyVNuLAn0JOpofjjyQ3opHuyJI6f7ooElLcbxEol7cPCPNLkEZT
         3g5h7Mh4nBqtMmnGynhfyNG6SnUGgw4UavM5MSBOtamsqHXuYgbZwJGt96odcS4bift0
         /Y9MRxL1IyMAg83Rs+ldzwfFHMyLePl/lgRHyIhvbJ7w7dBtvT+Nstvm48Ybw9T9v1Qu
         V3Yw==
X-Gm-Message-State: AJIora9EJ++e8OgLygQXdk/g6fMnuMNPWP7zn7xZSr0C8dzPhKpQbVmp
        wSQ5f6liaOuMBVFbwpfU2/w=
X-Google-Smtp-Source: AGRyM1sJzf4j17uYzWYuVwU8llwDlZhY339OzABkZB1cSfx0ylvVdAden/48mdUvjXx/O8MyVar6bQ==
X-Received: by 2002:a05:6512:1595:b0:489:da32:ec68 with SMTP id bp21-20020a056512159500b00489da32ec68mr4242226lfb.573.1657538995787;
        Mon, 11 Jul 2022 04:29:55 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id q23-20020a056512211700b00489daae997asm831916lfr.1.2022.07.11.04.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:29:55 -0700 (PDT)
Date:   Mon, 11 Jul 2022 14:29:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@vger.kernel.org, gerg@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fixed __debug_virt_addr_valid()
Message-ID: <20220711112953.j4dwany3i77df4xe@mobilestation>
References: <20220707215237.1730283-1-f.fainelli@gmail.com>
 <20220711083848.GE6084@alpha.franken.de>
 <20220711104052.ddefbgd34xbbjykg@mobilestation>
 <20220711112740.GA12918@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711112740.GA12918@alpha.franken.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 01:27:40PM +0200, Thomas Bogendoerfer wrote:
> On Mon, Jul 11, 2022 at 01:40:52PM +0300, Serge Semin wrote:
> > On Mon, Jul 11, 2022 at 10:38:48AM +0200, Thomas Bogendoerfer wrote:
> > > On Thu, Jul 07, 2022 at 02:52:36PM -0700, Florian Fainelli wrote:
> > > > It is permissible for kernel code to call virt_to_phys() against virtual
> > > > addresses that are in KSEG0 or KSEG1 and we need to be dealing with both
> > > > types. Add a final condition that ensures that the virtual address is
> > > > below KSEG2.
> > > > 
> > > > Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
> > > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > > ---
> > > >  arch/mips/mm/physaddr.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
> > > > index a1ced5e44951..a82f8f57a652 100644
> > > > --- a/arch/mips/mm/physaddr.c
> > > > +++ b/arch/mips/mm/physaddr.c
> > > > @@ -5,6 +5,7 @@
> > > >  #include <linux/mmdebug.h>
> > > >  #include <linux/mm.h>
> > > >  
> > > > +#include <asm/addrspace.h>
> > > >  #include <asm/sections.h>
> > > >  #include <asm/io.h>
> > > >  #include <asm/page.h>
> > > > @@ -30,7 +31,7 @@ static inline bool __debug_virt_addr_valid(unsigned long x)
> > > >  	if (x == MAX_DMA_ADDRESS)
> > > >  		return true;
> > > >  
> > > > -	return false;
> > > > +	return KSEGX(x) < KSEG2;
> > > >  }
> > > >  
> > > >  phys_addr_t __virt_to_phys(volatile const void *x)
> > > > -- 
> > > > 2.25.1
> > > 
> > 
> > > applied to mips-next.
> > 
> > Are you sure it was ready to be applied?
> > Link: https://lore.kernel.org/linux-mips/20220708115851.ejsooiilxcopkoei@mobilestation/
> 

> your comment sounded like optimizing, which can be done later on, so
> I assumed it ready.

What about Malta and EVA?

-Sergey

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
