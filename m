Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576F34CE6B7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiCEUKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiCEUKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:10:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8E33FBCB;
        Sat,  5 Mar 2022 12:09:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4865260B87;
        Sat,  5 Mar 2022 20:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2014C004E1;
        Sat,  5 Mar 2022 20:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646510984;
        bh=Z797Y7dPt9dgaRbnjf5KloG1BlL0Aq4hMvRukaJ3WzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SB4IoPKCSfquWYvbGqOw7m2BfjhC/gtGoYuzF6LlvjV13gi2qqsTlvFDHkusMnRqg
         Hp6AmtuK8EhZ/p4LcX7t5ArqcPyfubPVtrMDYZLF9mO4OzTfMnUPGaikkJFYb6Zrwa
         Z9TwLMZ38drrWErJA9eWhtDUONUDyf72iROl+pq5CyP+qmNIAQU2Kff51cIa3l1tkI
         8tNUAPptys7h0rJzvK+JqEayWxRgK2paebrvHqXuRXF55onMAST5n9Ez4gfMd96poV
         MHZcOZnFV7ZQnjdcihtdjCJ7sV+Z565h1j4bIRi4JOksacLDyz0rBm/5mKFko6Cng4
         LOQBCMV6mzM3A==
Date:   Sat, 5 Mar 2022 22:09:34 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
Message-ID: <YiPDfhfwYUQy9Pfd@kernel.org>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
 <Yh3tgr+g/6IElq0P@kernel.org>
 <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn>
 <Yh4uUoYT+YS5Jxsv@kernel.org>
 <8956c625-c18d-846e-3e65-7920776b27f3@loongson.cn>
 <alpine.DEB.2.21.2203041627150.47558@angie.orcam.me.uk>
 <4e10d7a4-3b3e-a220-8cd2-565614288950@loongson.cn>
 <YiNlDxF9WppxbkiX@kernel.org>
 <alpine.DEB.2.21.2203051837280.47558@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2203051837280.47558@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 07:21:15PM +0000, Maciej W. Rozycki wrote:
> On Sat, 5 Mar 2022, Mike Rapoport wrote:
> 
> > > >  For example I have an x86 system that Linux does not how to interrogate
> > > > for RAM beyond 64MiB, so I do use `memmap=128M@0' (for legacy reasons the
> > > > x86 platform has a special exception to always exclude area between 640K
> > > > and 1M from being used even if not explicitly specified, but we do not
> > > > have a need for such legacy such legacy concerns with the MIPS port).  I
> > > > consider it an interim measure however until the kernel has been fixed.
> > > > 
> > > >   Maciej
> > > > 
> > > 
> > > Hi Mike, Thomas and Maciej,
> > > 
> > > Thank you very much for your feedbacks and discussions.
> > > 
> > > To be frank, I think mem= and memmap= are used for debugging and testing
> > > in most cases, the intention of this patchset is to refactor the related
> > > code to make them work well on mips.
> > 
> > mem= works fine on mips and there is no need to change it.
> > 
> > If you must supply complex memory layout on the command line, consider
> > implementing support for memmap=exact and multiple memmap= parameters on
> > the kernel command line, like x86 does.
> 
>  There's nothing to implement as the MIPS port has supported arbitrary 
> memory maps since Dec 11th, 2000; that's almost 22 years now.  C.f.: 
> <https://lore.kernel.org/linux-mips/Pine.GSO.3.96.1000814133957.7256S-100000@delta.ds2.pg.gda.pl/>, 
> <https://git.kernel.org/pub/scm/linux/kernel/git/ralf/linux.git/commit/?id=97b7ae4257ef>.

You are right, and providing mem=X@Y for each contiguous memory range
should work even after 22 years.
I missed the fact that mem= can be repeated several times.
 
>  Sadly commit a09fc446fb6d ("[MIPS] setup.c: use early_param() for early 
> command line parsing") removed last pieces of inline documentation; I 
> don't know why things like that get approved, but neither I can take 
> responsibility.

This is sad indeed, but we still can update the kernel-parameters.txt with
a MIPS paragraph.
 
>   Maciej

-- 
Sincerely yours,
Mike.
