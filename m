Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34C14F17A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378043AbiDDO4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiDDO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:56:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F92E165BF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59A16B8171B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA8CC340EE;
        Mon,  4 Apr 2022 14:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649084060;
        bh=jRHy+GXAC3zuNkC3uM1peyEb3H7RENRAgLkCCDpiIsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ui605pWet5IuuA4MRs2Kd3swyBPeo7B4wNGOCpdrk+HHsXTnYHEsLsEuAoilhGAMe
         xajTcskeLAqB5lo8YdrRYMV6fV8ElOFLKcSEA4ZWvpg+KUMq73du0ZDu2D5UCBWY9L
         fVzH9iHRnKK72W93nz5C5TJmhAmGsllWzq5mbDhY=
Date:   Mon, 4 Apr 2022 16:54:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Ohad Sharabi <osharabi@habana.ai>
Subject: Re: [PATCH v2] habanalabs: Fix test build failures
Message-ID: <YksGmW0S7rSJJkDC@kroah.com>
References: <20220404134859.3278599-1-linux@roeck-us.net>
 <CAFCwf10Nbpr1H1-qTx4kSyC6YFdeAb=xOfq6uKzejJKLuyKw5A@mail.gmail.com>
 <YksErB5hwrQGIiIO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YksErB5hwrQGIiIO@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 04:46:04PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 04, 2022 at 05:38:29PM +0300, Oded Gabbay wrote:
> > On Mon, Apr 4, 2022 at 4:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > allmodconfig builds on 32-bit architectures fail with the following error.
> > >
> > > drivers/misc/habanalabs/common/memory.c: In function 'alloc_device_memory':
> > > drivers/misc/habanalabs/common/memory.c:153:49: error:
> > >         cast from pointer to integer of different size
> > >
> > > Fix the typecast. While at it, drop other unnecessary typecasts associated
> > > with the same commit.
> > >
> > > Fixes: e8458e20e0a3c ("habanalabs: make sure device mem alloc is page aligned")
> > > Cc: Ohad Sharabi <osharabi@habana.ai>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > > v2: Drop unnecessary (u64) typecasts
> > >
> > >  drivers/misc/habanalabs/common/memory.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
> > > index e008d82e4ba3..a13506dd8119 100644
> > > --- a/drivers/misc/habanalabs/common/memory.c
> > > +++ b/drivers/misc/habanalabs/common/memory.c
> > > @@ -111,10 +111,10 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> > >
> > >         if (contiguous) {
> > >                 if (is_power_of_2(page_size))
> > > -                       paddr = (u64) (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > > -                                                               total_size, NULL, page_size);
> > > +                       paddr = (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > > +                                                                    total_size, NULL, page_size);
> > >                 else
> > > -                       paddr = (u64) (uintptr_t) gen_pool_alloc(vm->dram_pg_pool, total_size);
> > > +                       paddr = gen_pool_alloc(vm->dram_pg_pool, total_size);
> > >                 if (!paddr) {
> > >                         dev_err(hdev->dev,
> > >                                 "failed to allocate %llu contiguous pages with total size of %llu\n",
> > > @@ -150,12 +150,12 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> > >                 for (i = 0 ; i < num_pgs ; i++) {
> > >                         if (is_power_of_2(page_size))
> > >                                 phys_pg_pack->pages[i] =
> > > -                                               (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > > -                                                                               page_size, NULL,
> > > -                                                                               page_size);
> > > +                                       (uintptr_t)gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > > +                                                                           page_size, NULL,
> > > +                                                                           page_size);
> > >                         else
> > > -                               phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
> > > -                                                                               page_size);
> > > +                               phys_pg_pack->pages[i] = gen_pool_alloc(vm->dram_pg_pool,
> > > +                                                                       page_size);
> > >                         if (!phys_pg_pack->pages[i]) {
> > >                                 dev_err(hdev->dev,
> > >                                         "Failed to allocate device memory (out of memory)\n");
> > > --
> > > 2.35.1
> > >
> > 
> > Hi Guenter,
> > Thanks for the patch, but Greg already merged a patch that was sent to him.
> 
> I did?  Where?

This fix looks more "correct" than Palmer's, so I'll go queue this one
up now.

thanks,

greg k-h
