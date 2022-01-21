Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F167549660F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiAUTyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiAUTyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:54:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B05DC06173B;
        Fri, 21 Jan 2022 11:54:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CB2B61707;
        Fri, 21 Jan 2022 19:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DD7C340E1;
        Fri, 21 Jan 2022 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642794876;
        bh=C7b5I+hDM3u7jSdl9XELS34WhxUJsTVhZpt6j4FOljY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ku+dDBqU5FvjVhQAUwJ24NyoqaB9BmTN50WqAoLXPhIDErCUpb6iXh0yhnNIj1ML9
         pne49JGIv7tFU/QDlVdMMeVRipgZWMnd67hUneYHAB57k5YHJ9nhEbQebIibrEMUrq
         h8gyKdCrl7wHd+xg7irdV2DOEkgCo+ZTsMeuuK6IuU6VQDGAEGlLtpzuDxMSWlEXrU
         UsUMsl7LTdkehHltiyy2bF3I0QiEk0N7Pe52UrgefBw7FnSihS9nZ1jEw31z8T/SLv
         rXov9H2AOhSV/kjJsLS308OGUhGcii4PEYeTLgZAwd/Utk7M0zBCOWIx4oMEnDtJ3a
         34u/wpZwmRtWQ==
Date:   Fri, 21 Jan 2022 11:54:34 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] lib/crypto: blake2s: avoid indirect calls to compression
 function for Clang CFI
Message-ID: <YesPesOhftSzp2ft@sol.localdomain>
References: <CAHmME9qVMomgb53rABKsucCoEhwsk+=KzDdEcGKtecOXuahTZw@mail.gmail.com>
 <20220119135450.564115-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119135450.564115-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 02:54:50PM +0100, Jason A. Donenfeld wrote:
> blake2s_compress_generic is weakly aliased to blake2s_generic. The
> current harness for function selection uses a function pointer, which is
> ordinarily inlined and resolved at compile time. But when Clang's CFI is
> enabled, CFI still triggers when making an indirect call via a weak
> symbol. This seems like a bug in Clang's CFI, as though it's bucketing
> weak symbols and strong symbols differently. It also only seems to
> trigger when "full LTO" mode is used, rather than "thin LTO".
> 
> [    0.000000][    T0] Kernel panic - not syncing: CFI failure (target: blake2s_compress_generic+0x0/0x1444)
> [    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-mainline-06981-g076c855b846e #1
> [    0.000000][    T0] Hardware name: MT6873 (DT)
> [    0.000000][    T0] Call trace:
> [    0.000000][    T0]  dump_backtrace+0xfc/0x1dc
> [    0.000000][    T0]  dump_stack_lvl+0xa8/0x11c
> [    0.000000][    T0]  panic+0x194/0x464
> [    0.000000][    T0]  __cfi_check_fail+0x54/0x58
> [    0.000000][    T0]  __cfi_slowpath_diag+0x354/0x4b0
> [    0.000000][    T0]  blake2s_update+0x14c/0x178
> [    0.000000][    T0]  _extract_entropy+0xf4/0x29c
> [    0.000000][    T0]  crng_initialize_primary+0x24/0x94
> [    0.000000][    T0]  rand_initialize+0x2c/0x6c
> [    0.000000][    T0]  start_kernel+0x2f8/0x65c
> [    0.000000][    T0]  __primary_switched+0xc4/0x7be4
> [    0.000000][    T0] Rebooting in 5 seconds..
> 
> Nonetheless, the function pointer method isn't so terrific anyway, so
> this patch replaces it with a simple boolean, which also gets inlined
> away. This successfully works around the Clang bug.
> 
> In general, I'm not too keen on all of the indirection involved here; it
> clearly does more harm than good. Hopefully the whole thing can get
> cleaned up down the road when lib/crypto is overhauled more
> comprehensively. But for now, we go with a simple bandaid.
> 
> Fixes: 6048fdcc5f26 ("lib/crypto: blake2s: include as built-in")
> Reported-by: Miles Chen <miles.chen@mediatek.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/arm/crypto/blake2s-shash.c   |  4 ++--
>  arch/x86/crypto/blake2s-shash.c   |  4 ++--
>  crypto/blake2s_generic.c          |  4 ++--
>  include/crypto/internal/blake2s.h | 36 ++++++++++++++++++-------------
>  lib/crypto/blake2s.c              |  4 ++--
>  5 files changed, 29 insertions(+), 23 deletions(-)

There are some lines over 80 columns in this patch.

Otherwise this looks fine.  It would be really nice to fix this in clang,
though.

- Eric
