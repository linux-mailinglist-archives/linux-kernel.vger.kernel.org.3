Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0B3500587
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 07:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbiDNFl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 01:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiDNFlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 01:41:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A3A3CFEA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 22:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A677B82836
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49332C385A5;
        Thu, 14 Apr 2022 05:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649914738;
        bh=EGbkB7EyGIphnUo8cRrJq675aEDUsCnVi4Pkg2u+IpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/5xlB2FGJQ4d9YonjZ1eh/VOSVq/JGZbcaKEVZ/X3gneeL6e+c8n4oWQVEM2nC37
         NUC4dasWX2knhep41oieB/4y70NBWjonRL99uQmXxgCzCTu04LVcoNKtRdt9zuG80Y
         UfyeJhMFJLi5uXjds7FMprNpoWpIZbZFFw7DiC/E=
Date:   Thu, 14 Apr 2022 07:38:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YlezcPbFOkSUygBJ@kroah.com>
References: <Yk/6ts5sVDMDpKj3@arm.com>
 <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com>
 <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
 <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:53:24AM -1000, Linus Torvalds wrote:
> On Tue, Apr 12, 2022 at 10:47 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > I agree. There is also an implicit expectation that the DMA API works on
> > kmalloc'ed buffers and that's what ARCH_DMA_MINALIGN is for (and the
> > dynamic arch_kmalloc_minalign() in this series). But the key point is
> > that the driver doesn't need to know the CPU cache topology, coherency,
> > the DMA API and kmalloc() take care of these.
> 
> Honestly, I think it would probably be worth discussing the "kmalloc
> DMA alignment" issues.
> 
> 99.9% of kmalloc users don't want to do DMA.
> 
> And there's actually a fair amount of small kmalloc for random stuff.
> Right now on my laptop, I have
> 
>     kmalloc-8          16907  18432      8  512    1 : ...
> 
> according to slabinfo, so almost 17 _thousand_ allocations of 8 bytes.
> 
> It's all kinds of sad if those allocations need to be 64 bytes in size
> just because of some silly DMA alignment issue, when none of them want
> it.
> 
> Yeah, yeah, wasting a megabyte of memory is "just a megabyte" these
> days. Which is crazy. It's literally memory that could have been used
> for something much more useful than just pure and utter waste.
> 
> I think we could and should just say "people who actually require DMA
> accesses should say so at kmalloc time". We literally have that
> GFP_DMA and ZOME_DMA for various historical reasons, so we've been
> able to do that before.
> 
> No, that historical GFP_DMA isn't what arm64 wants - it's the old
> crazy "legacy 16MB DMA" thing that ISA DMA used to have.
> 
> But the basic issue was true then, and is true now - DMA allocations
> are fairly special, and should not be that hard to just mark as such.

"fairly special" == "all USB transactions", so it will take a lot of
auditing here.  I think also many SPI controllers require this and maybe
I2C?  Perhaps other bus types do as well.

So please don't make this change without some way of figuring out just
what drivers need to be fixed up, as it's going to be a lot...

thanks,

greg k-h
