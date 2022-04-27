Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E423512156
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiD0Spd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiD0SpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D88F8E66
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E81E061EE0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7CBC385A7;
        Wed, 27 Apr 2022 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651083946;
        bh=J1tEIozWZnbnL5BsEMprNg/cVkWZ2TvAXMo0cddyvWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gvBSPqJTVy+MfmT0rjfw2FSyXvfzYoHc4C+O+9aFHpslDpJU0gE8cHRkoJ2axig2D
         /gLQvrjxshIF3YkdN68KWX4zSo7BCAoU3qAYbYa1h+S7bDh7q/cBl/KwCaBdMG6HJm
         CCzq9RPL0keGAhgX4L/Ys0JHmMBiThWiipcGARgE=
Date:   Wed, 27 Apr 2022 11:25:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/4] mm: ioremap: Add arch_ioremap/iounmap_check()
Message-Id: <20220427112545.3b8b9c46e5e5731b02394ace@linux-foundation.org>
In-Reply-To: <CAK8P3a1E1vP-vS=-aH-XP=5taSTy8EUTfNSpQk9x47WLRMCOzQ@mail.gmail.com>
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
        <20220427121413.168468-3-wangkefeng.wang@huawei.com>
        <CAK8P3a1E1vP-vS=-aH-XP=5taSTy8EUTfNSpQk9x47WLRMCOzQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 20:20:30 +0200 Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Apr 27, 2022 at 2:14 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > @@ -964,6 +964,9 @@ static inline void iounmap(volatile void __iomem *addr)
> >  #elif defined(CONFIG_GENERIC_IOREMAP)
> >  #include <linux/pgtable.h>
> >
> > +bool arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot);
> > +bool arch_iounmap_check(void __iomem *addr);
> > +
> >  void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
> >  void iounmap(volatile void __iomem *addr);
> >
> > diff --git a/mm/ioremap.c b/mm/ioremap.c
> > index 522ef899c35f..d1117005dcc7 100644
> > --- a/mm/ioremap.c
> > +++ b/mm/ioremap.c
> > @@ -11,6 +11,16 @@
> >  #include <linux/io.h>
> >  #include <linux/export.h>
> >
> > +bool __weak arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot)
> > +{
> > +       return true;
> > +}
> > +
> > +bool __weak arch_iounmap_check(void __iomem *addr)
> > +{
> > +       return true;
> > +}
> > +
> 
> I don't really like the weak functions.

How come?  They work quite nicely here?

> The normal way to do this

Is a lot more fuss.
