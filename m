Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B1F5AE90D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbiIFNGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbiIFNGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:06:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC085A2D5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18D13B818B5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA85C433B5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662469570;
        bh=SpJwzV1xxdG6E2zoG7fCWE2FmuhYoDXFoduBgrxJB7o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P9Jkwttt41HrjTVur3ZqETnRMvK58FTsAzgZLcpPZ35bdKjOGFvBScTvkOWJ1Eb3k
         z8Hzmpt8jKHwnZGT57f204iRkETZPzKn+Qzp5hxVzwJNuXteKCXoBbx+NiPdfNXxMK
         Z2UvStBU1e2LEKi5/rSBSEghkyxEpRxs9HAn44ESRK4QOj7BSXbkdRZKDg0NoqXE7V
         d3jKY902T/Dyi+RoCalF93V8QRvjEOJK47uebGefSjC0tJ2BUmdkIsdoWMGG6ohzWy
         hANxH2zRtxXNRNNgs4RNvXu26c80Nnn+2BYFVaeXa15L5GdGeLBzdjOAd68R34JivP
         reC3sJxNLWdLg==
Received: by mail-lf1-f44.google.com with SMTP id bt10so17316839lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:06:10 -0700 (PDT)
X-Gm-Message-State: ACgBeo3qI+gtr9cG1Uf265P4+DqriuOwBiCiy0aITHrpVXXWvvnLJBdC
        7YWR8nY4NTTSoHhO+qSevERwDrSSXJT/5OtObME=
X-Google-Smtp-Source: AA6agR5KiKCBtGu2NBHkajuKIN42XAzBbIS0deO+9CVIZbXoRkhIM737KmO+1cMcIxjM/6nXhMP1jgMcKij1ryQ7XfE=
X-Received: by 2002:a19:9113:0:b0:494:ad39:7d03 with SMTP id
 t19-20020a199113000000b00494ad397d03mr5907458lfd.122.1662469568765; Tue, 06
 Sep 2022 06:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220828005545.94389-1-bhe@redhat.com> <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org> <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
 <YxBeS0G+F+fsBgod@kernel.org> <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
 <YxXPannyTqBZInAt@kernel.org> <YxXmsKYGTd1+/U12@MiWiFi-R3L-srv>
In-Reply-To: <YxXmsKYGTd1+/U12@MiWiFi-R3L-srv>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 6 Sep 2022 15:05:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFDhbMPNcFnogyi7RXATqyHpqJLK9wiz=djRM3g65J8Zg@mail.gmail.com>
Message-ID: <CAMj1kXFDhbMPNcFnogyi7RXATqyHpqJLK9wiz=djRM3g65J8Zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
To:     Baoquan He <bhe@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
        will@kernel.org, linux-mm@kvack.org, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, kexec@lists.infradead.org
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

On Mon, 5 Sept 2022 at 14:08, Baoquan He <bhe@redhat.com> wrote:
>
> On 09/05/22 at 01:28pm, Mike Rapoport wrote:
> > On Thu, Sep 01, 2022 at 08:25:54PM +0800, Baoquan He wrote:
> > > On 09/01/22 at 10:24am, Mike Rapoport wrote:
> > >
> > > max_zone_phys() only handles cases when CONFIG_ZONE_DMA/DMA32 enabled,
> > > the disabledCONFIG_ZONE_DMA/DMA32 case is not included. I can change
> > > it like:
> > >
> > > static phys_addr_t __init crash_addr_low_max(void)
> > > {
> > >         phys_addr_t low_mem_mask = U32_MAX;
> > >         phys_addr_t phys_start = memblock_start_of_DRAM();
> > >
> > >         if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
> > >              (phys_start > U32_MAX))
> > >                 low_mem_mask = PHYS_ADDR_MAX;
> > >
> > >         return low_mem_mast + 1;
> > > }
> > >
> > > or add the disabled CONFIG_ZONE_DMA/DMA32 case into crash_addr_low_max()
> > > as you suggested. Which one do you like better?
> > >
> > > static phys_addr_t __init crash_addr_low_max(void)
> > > {
> > >         if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
> > >             return PHYS_ADDR_MAX + 1;
> > >
> > >         return max_zone_phys(32);
> > > }
> >
> > I like the second variant better.
>
> Sure, will change to use the 2nd one . Thanks.
>

While I appreciate the effort that has gone into solving this problem,
I don't think there is any consensus that an elaborate fix is required
to ensure that the crash kernel can be unmapped from the linear map at
all cost. In fact, I personally think we shouldn't bother, and IIRC,
Will made a remark along the same lines back when the Huawei engineers
were still driving this effort.

So perhaps we could align on that before doing yet another version of this?
