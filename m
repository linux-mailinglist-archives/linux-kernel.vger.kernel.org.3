Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102694F1788
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378371AbiDDOuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378332AbiDDOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:49:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63682433A0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A17BBCE1919
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94A3C340EE;
        Mon,  4 Apr 2022 14:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649083567;
        bh=6BjvLqLK5huibZiMoA91irs5s+j40MAVQWToi9BRA/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HgXCvny8tJRaJ5WGxlkCkfAPfj502Er7VT25588NLB9RGD1E5W5i+p08W1inYpWBm
         6lD6gb6gKx4yu+52uXSuauG7FPeCaFgBJlYxSjMCoBPjPK9VoLW5KDVcysQhi2x+bh
         1ytgoX6n8dDcqoYcj4EINC1a5A5hLqOvLf12Ur3w=
Date:   Mon, 4 Apr 2022 16:46:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Ohad Sharabi <osharabi@habana.ai>
Subject: Re: [PATCH v2] habanalabs: Fix test build failures
Message-ID: <YksErB5hwrQGIiIO@kroah.com>
References: <20220404134859.3278599-1-linux@roeck-us.net>
 <CAFCwf10Nbpr1H1-qTx4kSyC6YFdeAb=xOfq6uKzejJKLuyKw5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf10Nbpr1H1-qTx4kSyC6YFdeAb=xOfq6uKzejJKLuyKw5A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 05:38:29PM +0300, Oded Gabbay wrote:
> On Mon, Apr 4, 2022 at 4:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > allmodconfig builds on 32-bit architectures fail with the following error.
> >
> > drivers/misc/habanalabs/common/memory.c: In function 'alloc_device_memory':
> > drivers/misc/habanalabs/common/memory.c:153:49: error:
> >         cast from pointer to integer of different size
> >
> > Fix the typecast. While at it, drop other unnecessary typecasts associated
> > with the same commit.
> >
> > Fixes: e8458e20e0a3c ("habanalabs: make sure device mem alloc is page aligned")
> > Cc: Ohad Sharabi <osharabi@habana.ai>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: Drop unnecessary (u64) typecasts
> >
> >  drivers/misc/habanalabs/common/memory.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
> > index e008d82e4ba3..a13506dd8119 100644
> > --- a/drivers/misc/habanalabs/common/memory.c
> > +++ b/drivers/misc/habanalabs/common/memory.c
> > @@ -111,10 +111,10 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> >
> >         if (contiguous) {
> >                 if (is_power_of_2(page_size))
> > -                       paddr = (u64) (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > -                                                               total_size, NULL, page_size);
> > +                       paddr = (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > +                                                                    total_size, NULL, page_size);
> >                 else
> > -                       paddr = (u64) (uintptr_t) gen_pool_alloc(vm->dram_pg_pool, total_size);
> > +                       paddr = gen_pool_alloc(vm->dram_pg_pool, total_size);
> >                 if (!paddr) {
> >                         dev_err(hdev->dev,
> >                                 "failed to allocate %llu contiguous pages with total size of %llu\n",
> > @@ -150,12 +150,12 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> >                 for (i = 0 ; i < num_pgs ; i++) {
> >                         if (is_power_of_2(page_size))
> >                                 phys_pg_pack->pages[i] =
> > -                                               (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > -                                                                               page_size, NULL,
> > -                                                                               page_size);
> > +                                       (uintptr_t)gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > +                                                                           page_size, NULL,
> > +                                                                           page_size);
> >                         else
> > -                               phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
> > -                                                                               page_size);
> > +                               phys_pg_pack->pages[i] = gen_pool_alloc(vm->dram_pg_pool,
> > +                                                                       page_size);
> >                         if (!phys_pg_pack->pages[i]) {
> >                                 dev_err(hdev->dev,
> >                                         "Failed to allocate device memory (out of memory)\n");
> > --
> > 2.35.1
> >
> 
> Hi Guenter,
> Thanks for the patch, but Greg already merged a patch that was sent to him.

I did?  Where?
