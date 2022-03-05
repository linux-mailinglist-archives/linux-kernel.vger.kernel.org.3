Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9FD4CE4F5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 14:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiCENO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 08:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiCENOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 08:14:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B5EB6D3A;
        Sat,  5 Mar 2022 05:14:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D8E7B80BE7;
        Sat,  5 Mar 2022 13:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15F4C004E1;
        Sat,  5 Mar 2022 13:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646486042;
        bh=AOS5Hc26yUdN2q3VcU3wpupvzKmzfbhIgzFaCkVc7aE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLoGsRC5Uv+FOxo0IthzzF9n3x3zm8FfELIh8lIUGkruGz7xywD8XFVKziSSuPYPg
         uXgnQPdOLD9Y2DyEkFjhBSptVYSj3Ck8AcYVjWl8qq1mKkM3pBPy8SKFF/ZJoMyKns
         GDc6QejZArGAqbQDKyQbKPitJLiq4WBFag0gHsRvJ5DvDCkL6lw2dM3AKkd+eD5P5y
         du8J9w9EA+jSTmFl9XvvG0t/Uup/F7OqdWB6umBT9XR3kzMuV8XyrwasIDIR3oO73w
         cI+Ysi0s6+KOtvDArKMt1+ogesT4nBuxXCzaQYMMoVVSfXD94xeXaXC5ZYDInxlOB4
         +GM80JCTJ4xvg==
Date:   Sat, 5 Mar 2022 15:13:54 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] MIPS: Refactor early_parse_mem() to fix mem=
 parameter
Message-ID: <YiNiEqC294xQ6PXD@kernel.org>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
 <1646108941-27919-2-git-send-email-yangtiezhu@loongson.cn>
 <20220304151052.GA27642@alpha.franken.de>
 <20220304153517.GA28487@alpha.franken.de>
 <alpine.DEB.2.21.2203041634040.47558@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2203041634040.47558@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 05:11:44PM +0000, Maciej W. Rozycki wrote:
> On Fri, 4 Mar 2022, Thomas Bogendoerfer wrote:
> 
> > > > With this patch, when add "mem=3G" to the command-line, the
> > > > kernel boots successfully, we can see the following messages:
> > > 
> > > unfortunately this patch would break platforms without memory detection,
> > > which simply use mem=32M for memory configuration. Not sure how many
> > > rely on this mechanism. If we can make sure nobody uses it, I'm fine
> > > with your patch.
> > 
> > maybe we could add a CONFIG option, which will be selected by
> > platforms, which don't need/want this usermem thing.
> 
>  FWIW I don't understand what the issue is here beyond that we have a bug 
> that causes a system to hang when "mem=3G" is passed on the kernel command 
> line.  That is assuming that system does have contiguous RAM available for 
> the kernel to use from address 0 up to 3GiB; otherwise it's a user error 
> to tell the kernel it has that memory available (I did get bitten by that 
> myself too): garbage in, garbage out.

This is exactly the case here because the system does not have contiguous
RAM:

  [    0.000000] Early memory node ranges
  [    0.000000]   node   0: [mem 0x0000000004000000-0x000000000effffff]
  [    0.000000]   node   0: [mem 0x0000000090200000-0x00000000ffffffff]
  [    0.000000]   node   0: [mem 0x0000000120000000-0x00000001653fffff]

(from patch 3/4 in this series)

I don't see what "bug" this patch is trying to fix. Is indeed possible to
make MIPS' mem= behave like it does not arm64 and ppc, but that would break
systems that use current semantics and I recall seeing some of OpenWRT
machines using mem= to override memory map supplied by firmware. 
 
>   Maciej

-- 
Sincerely yours,
Mike.
