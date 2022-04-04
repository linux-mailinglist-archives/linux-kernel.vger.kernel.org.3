Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9B84F17DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378194AbiDDPEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378393AbiDDPEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:04:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494DA2FE4F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E465BB81807
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0444CC340EE;
        Mon,  4 Apr 2022 15:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649084564;
        bh=DSyr/AuapRImCrjmRCEvAPYtyLzoTPYJz8OafeBekS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=naW15HUkpTiiBzJlkVtO0Zfifg/rwX7VjL5I0XYYjQwKRzdSELAEoyb1vCu9IfsoU
         57VWRv5Qrlx0ICiAVzuCPD/A9yEZAAZv4/VXth5pJmPYkgQjc5+tlu+zce7/ujv972
         uffGmFB/hwk/8I+Pe+IZp6wCtQ1vTYrRA8ityj8s=
Date:   Mon, 4 Apr 2022 17:02:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     ogabbay@kernel.org, linux-riscv@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        osharabi@habana.ai
Subject: Re: [PATCH] habanalabs: Elide a warning on 32-bit targets
Message-ID: <YksIkY0l8k7mmnzJ@kroah.com>
References: <CAFCwf13-o=kUR61xjWt=F-Q-Vfy=kF6fpMP7iB+83Gfqw7+2HA@mail.gmail.com>
 <mhng-89bfa679-14d3-436e-80e1-439ab154beb2@palmer-mbp2014>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhng-89bfa679-14d3-436e-80e1-439ab154beb2@palmer-mbp2014>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 11:36:53AM -0700, Palmer Dabbelt wrote:
> On Fri, 01 Apr 2022 11:13:48 PDT (-0700), ogabbay@kernel.org wrote:
> > On Fri, Apr 1, 2022 at 7:41 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> > > 
> > > From: Palmer Dabbelt <palmer@rivosinc.com>
> > > 
> > > This double-cast pattern looks a bit awkward, but it already exists
> > > elsewhere in the driver.  Without this patch I get
> > > 
> > > drivers/misc/habanalabs/common/memory.c: In function ‘alloc_device_memory’:
> > > drivers/misc/habanalabs/common/memory.c:153:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> > >   153 |                                                 (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > >       |                                                 ^
> > > 
> > > which ends up promoted to a build error in my test setup.
> > > 
> > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > 
> > > ---
> > > 
> > > I don't know anything about this driver, I'm just pattern-matching the
> > > warning away.
> > > ---
> > >  drivers/misc/habanalabs/common/memory.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
> > > index e008d82e4ba3..f1fc79c1fc10 100644
> > > --- a/drivers/misc/habanalabs/common/memory.c
> > > +++ b/drivers/misc/habanalabs/common/memory.c
> > > @@ -150,12 +150,12 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> > >                 for (i = 0 ; i < num_pgs ; i++) {
> > >                         if (is_power_of_2(page_size))
> > >                                 phys_pg_pack->pages[i] =
> > > -                                               (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > > -                                                                               page_size, NULL,
> > > -                                                                               page_size);
> > > +                                               (u64) (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > > +                                                                                          page_size, NULL,
> > > +                                                                                          page_size);
> > >                         else
> > > -                               phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
> > > -                                                                               page_size);
> > > +                               phys_pg_pack->pages[i] = (u64) (uintptr_t) gen_pool_alloc(vm->dram_pg_pool,
> > > +                                                                                         page_size);
> > >                         if (!phys_pg_pack->pages[i]) {
> > >                                 dev_err(hdev->dev,
> > >                                         "Failed to allocate device memory (out of memory)\n");
> > > --
> > > 2.34.1
> > > 
> > 
> > This patch is:
> > Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> > 
> > Greg,
> > Could you please apply this directly to your misc tree and send it to
> > Linus at your next pull request ?
> > I don't have any other fixes pending for 5.18.
> > 
> > For 5.19 we will do a more elegant solution that Arnd has recommended.
> 
> Thanks.
> 
> Assuming this is too late for rc1, would it be possibe to have it in
> something I can take into my fixes/for-next without too much diff?  I put
> this on top of the offending commit with a
> 
> Fixes: e8458e20e0a3 ("habanalabs: make sure device mem alloc is page aligned")
> 
> at kernel.org/palmer/habana , if that helps any.  No big deal if it goes in
> another way, it's just nice to keep allyesconfig building on my branches
> directly.

Looks like Guenter sent in a "more complete" version of this.  I'll
queue it up to my tree and get it to Linus for -rc2.

thanks,
greg k-h

