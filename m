Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790184F17B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354862AbiDDPAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbiDDPAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:00:40 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF27643;
        Mon,  4 Apr 2022 07:58:43 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id z8so10337059oix.3;
        Mon, 04 Apr 2022 07:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJuWYKltsebJlR+iYJcx+89VT3YSFELwZ66eJZ0td+A=;
        b=j8Kbnj3qezRYYx7QeiOxqOtlO8yxYreSIyFo1K2KDdtvEm01FpZuVzrEEeDxQSmDNu
         o47jDBvVc1Fqo6WYlW+dUZZFRo5IsJPaxcMkkN6HWtONKbOFgx7TrtCvXU3pKfUBqhD2
         FBCL5odOxiyyghW/398cgP9V8fiIGBT/7XvXXUDb8j+pxQYtJNAaawT+8eP5wGIeVJ6J
         PZ3qrW2O3xk1G4aJeCjltI+cfoimkON6nsI+awwK6m9FRNogSlSnlJC3yeztfPSBRMSY
         OM/7euEUh5DqiZkUAwKaTt/1T/pNZWCBRNmvix9vhLEPdmBxkjnag4L5lT5qMC7qiVCV
         B5zw==
X-Gm-Message-State: AOAM531OdE0g7l9ibaglgnLIwYpzAXbtLJ3DxzRzS1npjBuAuuZssPRG
        fUJcrrECOXi45l8BKHrUow==
X-Google-Smtp-Source: ABdhPJy+knYz0FpBD+B/XqYTFDDly0IFKpeHzcuI/2tbLzaMUlojyFct1PO94CJWC8ERoCh+9DpPUQ==
X-Received: by 2002:a05:6808:2024:b0:2f9:6119:d6ec with SMTP id q36-20020a056808202400b002f96119d6ecmr97312oiw.203.1649084323010;
        Mon, 04 Apr 2022 07:58:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q83-20020aca5c56000000b002f94910a053sm4260942oib.56.2022.04.04.07.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 07:58:42 -0700 (PDT)
Received: (nullmailer pid 1315218 invoked by uid 1000);
        Mon, 04 Apr 2022 14:58:41 -0000
Date:   Mon, 4 Apr 2022 09:58:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] soc: apple: Add SART driver
Message-ID: <YksHoQvDqXOK70EX@robh.at.kernel.org>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-5-sven@svenpeter.dev>
 <CAK8P3a19F8K0MvZV_R6HrmmR+WBsDge+u6U3iEVEjZ74i6+nEg@mail.gmail.com>
 <f06576c8-76c6-41ae-874d-81ea0b5b5603@www.fastmail.com>
 <CAK8P3a3xioqJDb7hQ3dvxQyHPg2hgJbeJywEP+N4cDzpo=8VhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3xioqJDb7hQ3dvxQyHPg2hgJbeJywEP+N4cDzpo=8VhQ@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 09:07:17PM +0200, Arnd Bergmann wrote:
> On Sat, Apr 2, 2022 at 2:38 PM Sven Peter <sven@svenpeter.dev> wrote:
> > On Mon, Mar 21, 2022, at 18:07, Arnd Bergmann wrote:
> > > On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
> > >> The NVMe co-processor on the Apple M1 uses a DMA address filter called
> > >> SART for some DMA transactions. This adds a simple driver used to
> > >> configure the memory regions from which DMA transactions are allowed.
> > >>
> > >> Co-developed-by: Hector Martin <marcan@marcan.st>
> > >> Signed-off-by: Hector Martin <marcan@marcan.st>
> > >> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > >
> > > Can you add some explanation about why this uses a custom interface
> > > instead of hooking into the dma_map_ops?
> >
> > Sure.
> > In a perfect world this would just be an IOMMU implementation but since
> > SART can't create any real IOVA space using pagetables it doesn't fit
> > inside that subsytem.
> >
> > In a slightly less perfect world I could just implement dma_map_ops here
> > but that won't work either because not all DMA buffers of the NVMe
> > device have to go through SART and those allocations happen
> > inside the same device and would use the same dma_map_ops.
> >
> > The NVMe controller has two separate DMA filters:
> >
> >    - NVMMU, which must be set up for any command that uses PRPs and
> >      ensures that the DMA transactions only touch the pages listed
> >      inside the PRP structure. NVMMU itself is tightly coupled
> >      to the NVMe controller: The list of allowed pages is configured
> >      based on command's tag id and even commands that require no DMA
> >      transactions must be listed inside NVMMU before they are started.
> >    - SART, which must be set up for some shared memory buffers (e.g.
> >      log messages from the NVMe firmware) and for some NVMe debug
> >      commands that don't use PRPs.
> >      SART is only loosely coupled to the NVMe controller and could
> >      also be used together with other devices. It's also the only
> >      thing that changed between M1 and M1 Pro/Max/Ultra and that's
> >      why I decided to separate it from the NVMe driver.
> >
> > I'll add this explanation to the commit message.
> 
> Ok, thanks.
> 
> > >> +static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
> > >> +                           phys_addr_t *paddr, size_t *size)
> > >> +{
> > >> +       u32 cfg = readl_relaxed(sart->regs + APPLE_SART2_CONFIG(index));
> > >> +       u32 paddr_ = readl_relaxed(sart->regs + APPLE_SART2_PADDR(index));
> > >
> > > Why do you use the _relaxed() accessors here and elsewhere in the driver?
> >
> > This device itself doesn't do any DMA transactions so it needs no memory
> > synchronization barriers. Only the consumer (i.e. rtkit and nvme) read/write
> > from/to these buffers (multiple times) and they have the required barriers
> > in place whenever they are used.
> >
> > These buffers so far are only allocated at probe time though so even using
> > the normal writel/readl here won't hurt performance at all. I can just use
> > those if you prefer or alternatively add a comment why _relaxed is fine here.
> >
> > This is a bit similar to the discussion for the pinctrl series last year [1].
> 
> I think it's better to only use the _relaxed version where it actually helps,
> with a comment about it, and use the normal version elsewhere, in
> particular in functions that you have copied from the normal nvme driver.
> I had tried to compare some of your code with the other version and
> was rather confused by that.

Oh good, I tell folks the opposite (and others do too). We don't accept 
random explicit barriers without explanation, but implicit ones are 
okay? The resulting code on arm32 is also pretty horrible with the L2x0 
and OMAP sync hooks not that that matters here.

I don't really care too much which way we go, but we should document one 
rule and follow that.

Rob
