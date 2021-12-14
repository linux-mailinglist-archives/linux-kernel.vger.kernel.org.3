Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BB7474A83
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhLNSLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:11:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60236 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhLNSLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:11:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91981B816C3;
        Tue, 14 Dec 2021 18:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB656C34604;
        Tue, 14 Dec 2021 18:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639505474;
        bh=npqiSJQC8npMD2xZMDOWUY8IvRks07YDNszBOT2tffE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DkKxvy5k5HIVTn3ULiDE2tqAfwttoqYsxQB82yD4aO3JWTJIHe7wrOMifO7PzhnoU
         xv6UhrG6S8EH/THgtfIc1I1NzJ7pqp0SU/xYdR/tVMcnfyR60mcGRp8kasKe1zGTGE
         +quP60gOcaYH4KSv1s4TfLVC0OWnxRlQuUVDa1JMp59FbCUF3wHEU0XOvd/bmGt55B
         quwetdsEz0mY9jd+9hCIo3a9r1MO1LjpL7jJzt9wj6o06UIAyC5S7RORxJVtsjGxKU
         HsUMnr9kZfTVpNCZMsS32/VW687hhEFJzyH6GXQuh+x2jxOFJAWuUJxnRqzM4QVlHZ
         CONI4Y6jjZluw==
Date:   Tue, 14 Dec 2021 11:11:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        list@opendingux.net, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/3] MIPS: Add support for LTO
Message-ID: <YbjePln35WuOX+31@archlinux-ax161>
References: <20211213224914.1501303-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213224914.1501303-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:49:11PM +0000, Paul Cercueil wrote:
> Hi,
> 
> With this set of patches, it becomes possible to build a LTO'd kernel
> with LLVM/Clang on MIPS.
> 
> This was tested on a Ingenic JZ4770 based system. It requires the
> linking step of the vmlinuz.bin to be done with binutils' LD instead of
> LLVM's ld.lld [1], but the vmlinuz ELF itself can be completely built
> with LLVM.

The patches seem fine to me but it might be nice to have this fixed up
before the series is merged so that everything just works when this
configuration is selected. I have added some thoughts on the GitHub
issue.

> Strangely, the LTO'd kernel is bigger in size (3.6 MiB vs. 3.1 MiB
> without LTO), which might be completely normal and I just have wrong
> expectations.
> 
> Cheers,
> -Paul
> 
> [1]: https://github.com/ClangBuiltLinux/linux/issues/1333
> 
> Paul Cercueil (3):
>   MIPS: boot/compressed: Disable abicalls
>   MIPS: boot/compressed: Build without LTO
>   MIPS: Add support for LTO
> 
>  arch/mips/Kconfig                  | 1 +
>  arch/mips/boot/compressed/Makefile | 7 +++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> -- 
> 2.33.0
> 
> 
