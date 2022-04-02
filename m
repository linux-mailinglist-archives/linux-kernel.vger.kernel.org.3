Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5CF4EFF7E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244564AbiDBHvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiDBHvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD84F3586B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 00:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 290C86104D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 07:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DAFC340EC;
        Sat,  2 Apr 2022 07:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648885766;
        bh=n5LErFXRESNWybe75JSAh5NCeQt0jrP61FM5XFBKGkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kNtFpBeSmonWdZyVB6qCDjlQOeTN4J2lVP1d924C8kEH+x0gZ9rrTOCIhhBAE5frI
         jq8GQp/qz7U+ld7ULy5Ki9RyDRH2LQeT+XQexFGVlcBkUvx54z7bcznFTJiJ0tX+P6
         yhrLGNogbVGHWmRKIQQ5fM/p0ftHGcdUtnyx2uHs=
Date:   Sat, 2 Apr 2022 09:49:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Ohad Sharabi <osharabi@habana.ai>
Subject: Re: [PATCH] habanalabs: Elide a warning on 32-bit targets
Message-ID: <YkgAAqAb+9UKDEtn@kroah.com>
References: <20220401163909.20343-1-palmer@rivosinc.com>
 <CAFCwf13-o=kUR61xjWt=F-Q-Vfy=kF6fpMP7iB+83Gfqw7+2HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFCwf13-o=kUR61xjWt=F-Q-Vfy=kF6fpMP7iB+83Gfqw7+2HA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 09:13:48PM +0300, Oded Gabbay wrote:
> On Fri, Apr 1, 2022 at 7:41 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> >
> > From: Palmer Dabbelt <palmer@rivosinc.com>
> >
> > This double-cast pattern looks a bit awkward, but it already exists
> > elsewhere in the driver.  Without this patch I get
> >
> > drivers/misc/habanalabs/common/memory.c: In function ‘alloc_device_memory’:
> > drivers/misc/habanalabs/common/memory.c:153:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> >   153 |                                                 (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> >       |                                                 ^
> >
> > which ends up promoted to a build error in my test setup.
> >
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> >
> > ---
> >
> > I don't know anything about this driver, I'm just pattern-matching the
> > warning away.
> > ---
> >  drivers/misc/habanalabs/common/memory.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
> > index e008d82e4ba3..f1fc79c1fc10 100644
> > --- a/drivers/misc/habanalabs/common/memory.c
> > +++ b/drivers/misc/habanalabs/common/memory.c
> > @@ -150,12 +150,12 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> >                 for (i = 0 ; i < num_pgs ; i++) {
> >                         if (is_power_of_2(page_size))
> >                                 phys_pg_pack->pages[i] =
> > -                                               (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > -                                                                               page_size, NULL,
> > -                                                                               page_size);
> > +                                               (u64) (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > +                                                                                          page_size, NULL,
> > +                                                                                          page_size);
> >                         else
> > -                               phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
> > -                                                                               page_size);
> > +                               phys_pg_pack->pages[i] = (u64) (uintptr_t) gen_pool_alloc(vm->dram_pg_pool,
> > +                                                                                         page_size);
> >                         if (!phys_pg_pack->pages[i]) {
> >                                 dev_err(hdev->dev,
> >                                         "Failed to allocate device memory (out of memory)\n");
> > --
> > 2.34.1
> >
> 
> This patch is:
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> 
> Greg,
> Could you please apply this directly to your misc tree and send it to
> Linus at your next pull request ?

So ignore https://lore.kernel.org/r/20220401041615.3296387-1-jcmvbkbc@gmail.com ?

> I don't have any other fixes pending for 5.18.

Yes, I will queue this up after -rc1 is out.

thanks,

greg k-h
