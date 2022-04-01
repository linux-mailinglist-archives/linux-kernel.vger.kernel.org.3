Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9494EEC67
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbiDALdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238883AbiDALda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:33:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0FA1C60C9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5108B618EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6107C3410F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648812699;
        bh=Hs3Tehj/N7oWQ/xiZpxU7YwL3ngaZKwnUSjmR/zi7zQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G+kyVyZ3mCbZ/Z2dGf5r+9trJFH7blhrKO38mcDxnOgOkRosj2O+uS3vA78nYDSHn
         SCok+7XA6nJ/EHep2nwH/dQbgr0vCHqgbzLkZ1KCSv8EYMnWdOqGn/qmE3MC2TUBek
         gRWdoA9NI1mMGILaU6erINmgej+/X7gSkJXliQnNykuPhthozjXOE3o2ctPmMk1PhF
         t1epRb2DMFNfA8rUzk7gY4Dampvz08TtdaUxoxvw6vW6B06XGMQKBVQwB6j2KpHPqL
         HU3hDyH1iASa8N/Veb74mEBTLu3G62xPH9CpnFM+kfYua8oca3FPBQ0F2qfG5d/Djk
         n+a+Hhe08UZgg==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2e6650cde1bso28702607b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 04:31:39 -0700 (PDT)
X-Gm-Message-State: AOAM530z+oV04Q6GC+4w1EdENxZhM5qUUdrB7MYMqQLnrrrwnG4YEvZi
        SJeDA9Gv+3ZxJJ4PoRLj4RfW3qDxTP55YG/k3Z8=
X-Google-Smtp-Source: ABdhPJxHGAvuRkZEK0Xb5cZqvzTuuebzQrA13U2i8XGyqYUjaST2HR+ZEDnGj2yfa8TeH8Iwtxz7Z7ZVJaKcVDybNdo=
X-Received: by 2002:a81:1b11:0:b0:2e6:a60b:2d6f with SMTP id
 b17-20020a811b11000000b002e6a60b2d6fmr9494996ywb.3.1648812698659; Fri, 01 Apr
 2022 04:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220401041615.3296387-1-jcmvbkbc@gmail.com> <CAK8P3a19-qtAg8GD8a9nG4ZPuyoDi3n39+zvHcRV-YdPJbJfKA@mail.gmail.com>
 <CAFCwf10hm4+WOa9JTNLTnEGtOGScOVu+PAXbk2=r+14u8d68VA@mail.gmail.com> <CAK8P3a05=J6-utHZ682bVGb8bEZczLDEcFXsK7yXcbER5CRTDA@mail.gmail.com>
In-Reply-To: <CAK8P3a05=J6-utHZ682bVGb8bEZczLDEcFXsK7yXcbER5CRTDA@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Fri, 1 Apr 2022 14:31:12 +0300
X-Gmail-Original-Message-ID: <CAFCwf13yiJ=Ap7Rv7g1ef2pDF6F+4PJ=UkpBRkJf1q+aEGdTyg@mail.gmail.com>
Message-ID: <CAFCwf13yiJ=Ap7Rv7g1ef2pDF6F+4PJ=UkpBRkJf1q+aEGdTyg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: fix build warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Ohad Sharabi <osharabi@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Apr 1, 2022 at 10:53 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Apr 1, 2022 at 8:55 AM Oded Gabbay <ogabbay@kernel.org> wrote:
> > On Fri, Apr 1, 2022 at 9:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Apr 1, 2022 at 6:16 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
> >
> > We use gen_pool in this function to manage our device memory
> > allocations (this is why it is called alloc_device_memory).
>
> Ok, so it's none of the three I listed ;-)
>
> > Basically, we initialize the genpool with the total size of the device memory,
> > and each bit represents a page according to a fixed page size, which
> > is dependent on asic type.
> > The addresses represent the physical address of the device memory, as
> > our device sees them.
> > As these addresses are not accessible from the host, it is appropriate
> > to hold them in u64, imo.
> >
> > For future asics which will support multiple page sizes, we need to
> > use the gen_pool_dma_alloc_align() variant,
> > because then we need the allocation to be aligned to the page size as
> > requested by the user per allocation.
> >
> > We ignore the DMA address because this is device memory, not host memory.
> > Therefore, our device's dma engine addresses the memory using the
> > virtual memory addresses we assign to it in our device's MMU.
> >
> > Having said that, I'm wondering whether gen_pool_first_fit_align() can
> > also work here, which might be less confusing.
>
> Thank you for the explanation. I think the best way to make this less
> confusing and to avoid the type casts would be to define your own
> typedef for a device-internal address, and then wrap the allocator
> functions such as gen_pool_dma_alloc_align() in helper functions that
> do the type conversion safely.
>
>        Arnd

Thanks for the advice, we will prepare a patch accordingly.
Oded
