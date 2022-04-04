Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DD54F17AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378268AbiDDO6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378335AbiDDO55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:57:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0803B193F3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95161615AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E920EC340F2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649084160;
        bh=zOaEohMocPRZjz4SrjV5VD9w6fPL+8cdZ8qFzCkzmoM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EghdGgPM3QZjCPafHTOnmgQM7RrpDQyP+KBZjO0rR9PwZyj7qbT4o/XDLQxUMO9y2
         +1c1isJy8yNf42ix3EJmRxCb+q8pNBfFZIBEzRDZKtSWJmZDm/NwBwSqOGWxKK7tNT
         RhP3Z7r5/EZ4606fqADexZk4RoLHPcx7LYe6QxkXuyDbGFvkCf+LYyOFaBPkjH8hyM
         HS5Ur9khYQRHLMkcgy4gZNX6T94867FrEldqcbXCnSzrunMe3ssuTu1XPKyKZBDIat
         gNuVsmHMK6EMM7OKRW+p1emT0BlQgMgq6ogfl9SVCbouvQ1wMU921lRqO3bhWO2AYu
         G5Am/ISgBlrVw==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2eb9412f11dso6508707b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 07:55:59 -0700 (PDT)
X-Gm-Message-State: AOAM5329lH/pZR28UEK3vyyGe5lx8daemuHxtRhCHOQNq0znl+QX2qk3
        LYJhS9a1+DqUrU3hlIyv93qLoDEVK04ZLYKxrJQ=
X-Google-Smtp-Source: ABdhPJw5dP2vbY4lRjX2yF/fLmKm3CcjVf1zRTCohBQjtcJKuZCCqUM/85vYUZ4izwYwlIiVFCZdPP731zDNpt6T7HY=
X-Received: by 2002:a0d:c583:0:b0:2e6:b1e7:a6b with SMTP id
 h125-20020a0dc583000000b002e6b1e70a6bmr303020ywd.424.1649084158976; Mon, 04
 Apr 2022 07:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220404134859.3278599-1-linux@roeck-us.net> <CAFCwf10Nbpr1H1-qTx4kSyC6YFdeAb=xOfq6uKzejJKLuyKw5A@mail.gmail.com>
 <YksErB5hwrQGIiIO@kroah.com> <YksGmW0S7rSJJkDC@kroah.com>
In-Reply-To: <YksGmW0S7rSJJkDC@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 4 Apr 2022 17:55:32 +0300
X-Gmail-Original-Message-ID: <CAFCwf11OK8VKzbSMqwWPhFT2jkcMemqTQWEskH2TEGtth=P3Xg@mail.gmail.com>
Message-ID: <CAFCwf11OK8VKzbSMqwWPhFT2jkcMemqTQWEskH2TEGtth=P3Xg@mail.gmail.com>
Subject: Re: [PATCH v2] habanalabs: Fix test build failures
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Ohad Sharabi <osharabi@habana.ai>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 5:54 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Apr 04, 2022 at 04:46:04PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 04, 2022 at 05:38:29PM +0300, Oded Gabbay wrote:
> > > On Mon, Apr 4, 2022 at 4:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > allmodconfig builds on 32-bit architectures fail with the following error.
> > > >
> > > > drivers/misc/habanalabs/common/memory.c: In function 'alloc_device_memory':
> > > > drivers/misc/habanalabs/common/memory.c:153:49: error:
> > > >         cast from pointer to integer of different size
> > > >
> > > > Fix the typecast. While at it, drop other unnecessary typecasts associated
> > > > with the same commit.
> > > >
> > > > Fixes: e8458e20e0a3c ("habanalabs: make sure device mem alloc is page aligned")
> > > > Cc: Ohad Sharabi <osharabi@habana.ai>
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > > ---
> > > > v2: Drop unnecessary (u64) typecasts
> > > >
> > > >  drivers/misc/habanalabs/common/memory.c | 16 ++++++++--------
> > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
> > > > index e008d82e4ba3..a13506dd8119 100644
> > > > --- a/drivers/misc/habanalabs/common/memory.c
> > > > +++ b/drivers/misc/habanalabs/common/memory.c
> > > > @@ -111,10 +111,10 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> > > >
> > > >         if (contiguous) {
> > > >                 if (is_power_of_2(page_size))
> > > > -                       paddr = (u64) (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > > > -                                                               total_size, NULL, page_size);
> > > > +                       paddr = (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > > > +                                                                    total_size, NULL, page_size);
> > > >                 else
> > > > -                       paddr = (u64) (uintptr_t) gen_pool_alloc(vm->dram_pg_pool, total_size);
> > > > +                       paddr = gen_pool_alloc(vm->dram_pg_pool, total_size);
> > > >                 if (!paddr) {
> > > >                         dev_err(hdev->dev,
> > > >                                 "failed to allocate %llu contiguous pages with total size of %llu\n",
> > > > @@ -150,12 +150,12 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> > > >                 for (i = 0 ; i < num_pgs ; i++) {
> > > >                         if (is_power_of_2(page_size))
> > > >                                 phys_pg_pack->pages[i] =
> > > > -                                               (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > > > -                                                                               page_size, NULL,
> > > > -                                                                               page_size);
> > > > +                                       (uintptr_t)gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > > > +                                                                           page_size, NULL,
> > > > +                                                                           page_size);
> > > >                         else
> > > > -                               phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
> > > > -                                                                               page_size);
> > > > +                               phys_pg_pack->pages[i] = gen_pool_alloc(vm->dram_pg_pool,
> > > > +                                                                       page_size);
> > > >                         if (!phys_pg_pack->pages[i]) {
> > > >                                 dev_err(hdev->dev,
> > > >                                         "Failed to allocate device memory (out of memory)\n");
> > > > --
> > > > 2.35.1
> > > >
> > >
> > > Hi Guenter,
> > > Thanks for the patch, but Greg already merged a patch that was sent to him.
> >
> > I did?  Where?
>
> This fix looks more "correct" than Palmer's, so I'll go queue this one
> up now.
>
> thanks,
>
> greg k-h

Great
Thanks,
Oded
