Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0405664F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiGEIVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiGEIVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:21:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97523CC0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:21:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so7502821wmr.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 01:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wfqoXVK+YfH3izkn1ZIOXk7M9UJ/gOHJBL54VlMil1E=;
        b=xUkNuB6sThZg8/L+TCfTHvgqmve+3X2XTscpzPB8Tdd347qOEdLnpGh+mxdoEih7j+
         LWCL7OdboRbOwv0QIsWPxwLkyW60r6irie07Mr+8PkDgDPCIjcWUhcM+RlBKaOlzwpiL
         I9oZqLzvc1EQwqvJkJygFu1TJthBVJpGZQo0/Xe8hUr8QpCPFrsHLL6F/ySU1L6krew6
         KDXsXBtTB9BWPKMq81vsoGDHHMUFq1YO/k86zB55BlddKyc4GChaRZ8aTpAIERpcpLcE
         1WndJcUi28Js1hwgiup05QRq/MZn02FUl9eX0YYVgkR7sZW3++szGVyA8qXWoGF0PzuR
         st7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wfqoXVK+YfH3izkn1ZIOXk7M9UJ/gOHJBL54VlMil1E=;
        b=MErhwAa6njHC/XXMCIMJfkMDYeB3uM+6KEstWil98Z5qDe7dGy/KBr0h4Hqqc8hFEl
         h6JjL5qyeqa8dYdgiP2K/5wvuUOR1MXbuG3qnyp9/O7ZP0BheC5OvgODCX/Ms+Osl4o2
         VFD86km/foS9c3PACmhUsUlgSN9jZpSI7flk1miWxgQDyKXrpMvfccv8u+1bFLiPNOE7
         uHrvvZMz9mqE9MmbIy7q9/fthV+DNJ2KZy61DTUVoB4d6Mb9HdYZwvlcynugbghH312/
         4aVuFLg1/S90/ZvjoDlsP5MXvuZ3TQuxDx4rh+O+QPPQbJsA7c41GkNXsvicy7uGxBSh
         zMKQ==
X-Gm-Message-State: AJIora/QdsKFPrrdNdgwUBMNDDS1AGWsWYtLh++0rwJ4FQBYSKho9QJO
        qkmh54MOST8FQnpG93VIVYT7/A==
X-Google-Smtp-Source: AGRyM1tr6rhGjC+OjSy5qUIGsdXXqW+hoadeDxw4So3EyQixfHxlPvRR/BsUHVmT5zqFTafMEYVfUw==
X-Received: by 2002:a05:600c:4ece:b0:3a1:7816:31a9 with SMTP id g14-20020a05600c4ece00b003a1781631a9mr30790692wmq.100.1657009277148;
        Tue, 05 Jul 2022 01:21:17 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id m123-20020a1ca381000000b003942a244f47sm19512608wme.32.2022.07.05.01.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 01:21:16 -0700 (PDT)
Date:   Tue, 5 Jul 2022 10:21:13 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     herbert@gondor.apana.org.au, hch@lst.de, heiko@sntech.de,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [RFC PATCH] crypto: flush poison data
Message-ID: <YsP0eekTthD4jWGV@Red>
References: <20220701132735.1594822-1-clabbe@baylibre.com>
 <4570f6d8-251f-2cdb-1ea6-c3a8d6bb9fcf@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4570f6d8-251f-2cdb-1ea6-c3a8d6bb9fcf@codethink.co.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Jul 01, 2022 at 02:35:41PM +0100, Ben Dooks a écrit :
> On 01/07/2022 14:27, Corentin Labbe wrote:
> > On my Allwinner D1 nezha, the sun8i-ce fail self-tests due to:
> > alg: skcipher: cbc-des3-sun8i-ce encryption overran dst buffer on test vector 0
> > 
> > In fact the buffer is not overran by device but by the dma_map_single() operation.
> > 
> > To prevent any corruption of the poisoned data, simply flush them before
> > giving the buffer to the tested driver.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> > 
> > Hello
> > 
> > I put this patch as RFC, since this behavour happen only on non yet merged RISCV code.
> > (Mostly riscv: implement Zicbom-based CMO instructions + the t-head variant)
> > 
> > Regards
> > 
> >   crypto/testmgr.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> > index c59bd9e07978..187163e2e593 100644
> > --- a/crypto/testmgr.c
> > +++ b/crypto/testmgr.c
> > @@ -19,6 +19,7 @@
> >   #include <crypto/aead.h>
> >   #include <crypto/hash.h>
> >   #include <crypto/skcipher.h>
> > +#include <linux/cacheflush.h>
> >   #include <linux/err.h>
> >   #include <linux/fips.h>
> >   #include <linux/module.h>
> > @@ -205,6 +206,8 @@ static void testmgr_free_buf(char *buf[XBUFSIZE])
> >   static inline void testmgr_poison(void *addr, size_t len)
> >   {
> >   	memset(addr, TESTMGR_POISON_BYTE, len);
> > +	/* Be sure data is written to prevent corruption from some DMA sync */
> > +	flush_icache_range((unsigned long)addr, (unsigned long)addr + len);
> >   }
> >   
> >   /* Is the memory region still fully poisoned? */
> 
> why are you flushing the instruction cache and not the data-cache?
> 

I just copied what did drivers/crypto/xilinx/zynqmp-sha.c.
I tried to do flush_dcache_range() but it seems to not be implemented on riscV.
And flush_dcache_page(virt_to_page(addr), len) produce a kernel panic.

Any advice on how to go further ?
