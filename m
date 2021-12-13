Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D725B471F45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 03:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhLMCJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 21:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLMCJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:09:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF59C06173F;
        Sun, 12 Dec 2021 18:09:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3F213CE0DDC;
        Mon, 13 Dec 2021 02:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD330C341C5;
        Mon, 13 Dec 2021 02:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639361359;
        bh=kKK5aRuD8GLLmMZ/kg6jCHDmTgm6coyqV/sEujXK4Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vC2ZCkSqA5EHbnQFZDHlkt6v9CQqB5/pQpip2tANZ+ELYhhdP+HizAMhzz6U6EqJs
         0dUuM/EJkyWQNAVOxzP1qudLGo2liyhURyjwxX3b0x1UPtrx15Vg1iozF01WM4lfbS
         Kki5HpdDjkbv34d/+YLby8GeTBylxzzppfgkgMKtFCmC38xlgnJyolJ8hbeGRvKy4S
         8iu8/z4V4qJWs5O6HKFgXVpFbJiL0nRfB/v9LRbmojZVd/Np0+L9DYYVX3CaccIZcV
         GaRanmcXPCB+aq0mGIvCVCuTtSolg3KDZf3HhFldK1WMpWOHta+hg9Q4M5lqMrExHF
         B457Qa3/eoAHw==
Date:   Sun, 12 Dec 2021 19:09:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
Cc:     masahiroy@kernel.org, yangtiezhu@loongson.cn,
        tsbogend@alpha.franken.de, jason@bluehome.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Makefile: Remove "ifdef need-compiler" for
 Kbuild.platforms
Message-ID: <YbarSpe7zhTi+2h4@archlinux-ax161>
References: <1639109105-1545-1-git-send-email-yangtiezhu@loongson.cn>
 <YbN+0NrHmsFKfNWP@archlinux-ax161>
 <CAK7LNAS7=qYs7NdDRY+4Dz5Zt0tLDo-W-EMcx+9TaNazNVcX=Q@mail.gmail.com>
 <20211213.093520.538389512409174784.ryutaroh@ict.e.titech.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213.093520.538389512409174784.ryutaroh@ict.e.titech.ac.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:35:20AM +0900, Ryutaroh Matsumoto wrote:
> From: Masahiro Yamada <masahiroy@kernel.org>
> Subject: Re: [PATCH v2] MIPS: Makefile: Remove "ifdef need-compiler" for Kbuild.platforms
> Date: Sat, 11 Dec 2021 01:39:10 +0900
> > Nathan's patch cleaned up  arch/mips/loognson2ef/Platform,
> > but I still see similar code in arch/mips/sgi-ip22/Platform.
> > 
> > 
> > ifdef CONFIG_SGI_IP28
> >   ifeq ($(call cc-option-yn,-march=r10000 -mr10k-cache-barrier=store), n)
> >       $(error gcc doesn't support needed option -mr10k-cache-barrier=store)
> >   endif
> > endif
> > 
> > 
> > Doesn't this cause a failure of *-pkg builds for sgi-ip22 platform?
> 
> Yes, it does, as reported at
> https://github.com/ClangBuiltLinux/linux/issues/1543

It seems like that section can be removed for the same reason as my
patch (that flag is supported with GCC 5.1.0) then this patch can be
applied without any issues.

Cheers,
Nathan
