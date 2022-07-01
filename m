Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36C95635DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiGAOjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiGAOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:38:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C8656D56F;
        Fri,  1 Jul 2022 07:36:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89713113E;
        Fri,  1 Jul 2022 07:36:19 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03FFE3F792;
        Fri,  1 Jul 2022 07:36:17 -0700 (PDT)
Date:   Fri, 1 Jul 2022 15:36:14 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     herbert@gondor.apana.org.au, hch@lst.de, heiko@sntech.de,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [RFC PATCH] crypto: flush poison data
Message-ID: <20220701153614.0a576f9c@donnerap.cambridge.arm.com>
In-Reply-To: <20220701132735.1594822-1-clabbe@baylibre.com>
References: <20220701132735.1594822-1-clabbe@baylibre.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Jul 2022 13:27:35 +0000
Corentin Labbe <clabbe@baylibre.com> wrote:

Hi,

> On my Allwinner D1 nezha, the sun8i-ce fail self-tests due to:
> alg: skcipher: cbc-des3-sun8i-ce encryption overran dst buffer on test vector 0
> 
> In fact the buffer is not overran by device but by the dma_map_single() operation.
> 
> To prevent any corruption of the poisoned data, simply flush them before
> giving the buffer to the tested driver.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> 
> Hello
> 
> I put this patch as RFC, since this behavour happen only on non yet merged RISCV code.
> (Mostly riscv: implement Zicbom-based CMO instructions + the t-head variant)
> 
> Regards
> 
>  crypto/testmgr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index c59bd9e07978..187163e2e593 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -19,6 +19,7 @@
>  #include <crypto/aead.h>
>  #include <crypto/hash.h>
>  #include <crypto/skcipher.h>
> +#include <linux/cacheflush.h>
>  #include <linux/err.h>
>  #include <linux/fips.h>
>  #include <linux/module.h>
> @@ -205,6 +206,8 @@ static void testmgr_free_buf(char *buf[XBUFSIZE])
>  static inline void testmgr_poison(void *addr, size_t len)
>  {
>  	memset(addr, TESTMGR_POISON_BYTE, len);
> +	/* Be sure data is written to prevent corruption from some DMA sync */
> +	flush_icache_range((unsigned long)addr, (unsigned long)addr + len);

As Ben already mentioned, this looks like having nothing to do with the I
cache. I guess you picked that because it does the required cache cleaning
and doesn't require a vma parameter?

But more importantly: I think drivers shouldn't do explicit cache
maintenance, this is what the DMA API is for.
So if you get DMA corruption, then this points to some flaw in the DMA API
usage: either the buffer belongs to the CPU, then the device must not write
to it. Or the buffer belongs to the device, then the CPU cannot expect to
write to that without that data potentially getting corrupted.

So can you check if that's the case?

Cheers,
Andre

>  }
>  
>  /* Is the memory region still fully poisoned? */

