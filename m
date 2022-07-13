Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F32D572EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiGMHBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiGMHBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:01:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063D6E0F58;
        Wed, 13 Jul 2022 00:01:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu42so17654619lfb.0;
        Wed, 13 Jul 2022 00:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vliNERNywb3iwRIItRAhoA2xAjfhrab9oJ+vM898EyQ=;
        b=AdgzODjZzQcchhHjCeipY5ZyiX13i6VTG3vcg6/W8bh+XtLSMyQyUQDC4TyKYUEkj7
         vk0UyVWIhVnPLHRsql6U4nMLhKSTOJsTFuTE0gc16gEZvyHxEsE8s5UXjhE/J5M5+EhX
         s6p8w5CIHc83IL/FCH9NTd47e/NqarpT/3q8fqDiawIbhfnWfTR3FE7ydksIDiDvHS3I
         Z0te9i3aLIAqVcny6U5zc3BVBFHnWPeRKUtHdp1ayvqqWxDYhoCUSj+F1Y8L18tZb5US
         Gv3Jh0lI5hST41ux0r9T+Pv9nYQ+3qRWPN9wMClXa8+1w4Y+KOedB6Su+mOxot+rCYJR
         o0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vliNERNywb3iwRIItRAhoA2xAjfhrab9oJ+vM898EyQ=;
        b=Ihlyr9raaEFhd9NntnuAZqMikFB2ueGpUfw8QwLGBNSDzsDz0FoKlGAOoCW/ktSF+g
         WxfinWBm7d2TVx6/GIk/zSC5yO46M0AvBr2dKGmkJURaDMZzBehDkZwonchouUL3CaxZ
         HQf4vaLxgwukVf1ML4H4Krruhj8JlSe2oqZkvo8kp1nz0hqw7wtbLRpDdtNla9U62tUq
         uNuAcf47aYX8SnWGtnLvHceYLgzDa4+VWYBfACQ/R6obUPfEIbehtjL09/Zrd/WfqY/o
         vrob44rvZcg5EKvJANEEoyWUErW9avYtSQX7f1qwoFw/eGrOOqguDcPqBofkHVogjt+H
         fvXw==
X-Gm-Message-State: AJIora9qImO6aVoBub4GJ+Dm1c/w/0aPslDTNkKPdAbG4oaOb7MW26TM
        LmB7UPpc85NIbnQ2Kq0SfXA=
X-Google-Smtp-Source: AGRyM1slomrYLGbn8zYKsp6aV+ffH2Ud1E+iIVGRjPVls2bS7fk93IpkCwnskUOh+sgFIfP8PHmznw==
X-Received: by 2002:a05:6512:3c3:b0:47d:ab07:50e7 with SMTP id w3-20020a05651203c300b0047dab0750e7mr1022115lfp.261.1657695691229;
        Wed, 13 Jul 2022 00:01:31 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id e20-20020a05651236d400b00489e0df379dsm1579000lfs.108.2022.07.13.00.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:01:30 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:01:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@vger.kernel.org, gerg@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fixed __debug_virt_addr_valid()
Message-ID: <20220713070128.lzcwgimruq7xjadi@mobilestation>
References: <20220707215237.1730283-1-f.fainelli@gmail.com>
 <20220708115851.ejsooiilxcopkoei@mobilestation>
 <a6d8fc0f-38bd-6afe-ef45-42ce3ee6c136@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6d8fc0f-38bd-6afe-ef45-42ce3ee6c136@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 09:28:02AM -0700, Florian Fainelli wrote:
> On 7/8/22 04:58, Serge Semin wrote:
> > On Thu, Jul 07, 2022 at 02:52:36PM -0700, Florian Fainelli wrote:
> > > It is permissible for kernel code to call virt_to_phys() against virtual
> > > addresses that are in KSEG0 or KSEG1 and we need to be dealing with both
> > > types. Add a final condition that ensures that the virtual address is
> > > below KSEG2.
> > > 
> > > Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > ---
> > >   arch/mips/mm/physaddr.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
> > > index a1ced5e44951..a82f8f57a652 100644
> > > --- a/arch/mips/mm/physaddr.c
> > > +++ b/arch/mips/mm/physaddr.c
> > > @@ -5,6 +5,7 @@
> > >   #include <linux/mmdebug.h>
> > >   #include <linux/mm.h>
> > > +#include <asm/addrspace.h>
> > >   #include <asm/sections.h>
> > >   #include <asm/io.h>
> > >   #include <asm/page.h>
> > > @@ -30,7 +31,7 @@ static inline bool __debug_virt_addr_valid(unsigned long x)
> > >   	if (x == MAX_DMA_ADDRESS)
> > >   		return true;
> > 
> > > -	return false;
> > > +	return KSEGX(x) < KSEG2;
> > 
> > With this do we really need the high_memory-based conditionals in this
> > method?
> > 
> > If the line above is the only way to take the uncached segment into
> > account then can we reduce the whole method to:
> > static inline bool __debug_virt_addr_valid {
> > 	return x >= PAGE_OFFSET && KSEGX(x) < KSEG2;
> > }
> > ?
> > 
> > Though this still may be invalid for EVA systems, like malta (see
> > arch/mips/include/asm/mach-malta/spaces.h).
> > 
> > Note AFAICS if EVA is enabled, highmem is implied to be disabled (see
> > the CPU_MIPS32_3_5_EVA config utilization and HIGHMEM config
> > dependencies). Thus all the memory is supposed to be linearly mapped
> > in that case.
> 

> OK, so if all of the memory is linearly mapped, then I am not too sure what
> we will be able to check, which is in essence pretty similar to what happens
> on MIPS64, right?

Essence is right, but in general situation is more complicated.
Basically EVA (seems like a Bible reference...) provides a way to
change the traditional MIPS memory address space to pretty much any
within 4GB virtual-to-physical address mapping. Most importantly it
can be used to eliminate the limitation of having just 512MB of the
directly mapped memory in kernel.

Anyway neither MIPS HIGHMEM kernel config nor the Malta's EVA mode
don't imply having high-memory enabled in case of EVAs. Most likely
the constraint has been set due to the MIPS arch code too much relying
on the traditional address space mapping. So the high-memory part just
wasn't fixed to be properly working in that case, while the CPU
MMU-type segments can still be defined for EVA. As the comment in the
Malta spaces.h header file says HIGHMEM_START is preserved just for
the correct high-mem macros arithmetics.

Just to note. Lack of high-memory in case of EVA is a big drawback
because some physical memory gets to be unavailable. At the very least
512MB segment must be preserved for the uncached kernel region for
MMIOs. Not to say that XPA won't work without high-memory. So it's
either XPA (greater than 4GB physical memory) or EVA (up to 3.5GB
directly mapped kernel memory). So annoying.

> 
> Maybe DEBUG_VIRTUAL should depend on !EVA as well?

In that case the debug-version of __phys_addr_symbol() will be
unavailable too. I would rather suggest to fix the
__debug_virt_addr_valid() method implementation to at least returning
always true in case of EVA or !HIGHMEM.

-Sergey

> -- 
> Florian
