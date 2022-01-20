Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C6E4951D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376798AbiATP42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiATP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:56:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA616C061574;
        Thu, 20 Jan 2022 07:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 794A461419;
        Thu, 20 Jan 2022 15:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12FFC340E0;
        Thu, 20 Jan 2022 15:56:23 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: atomics: lse: Dereference matching size
Date:   Thu, 20 Jan 2022 15:56:21 +0000
Message-Id: <164269417315.2457156.6204086542906520057.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220112202259.3950286-1-keescook@chromium.org>
References: <20220112202259.3950286-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 12:22:59 -0800, Kees Cook wrote:
> When building with -Warray-bounds, the following warning is generated:
> 
> In file included from ./arch/arm64/include/asm/lse.h:16,
>                  from ./arch/arm64/include/asm/cmpxchg.h:14,
>                  from ./arch/arm64/include/asm/atomic.h:16,
>                  from ./include/linux/atomic.h:7,
>                  from ./include/asm-generic/bitops/atomic.h:5,
>                  from ./arch/arm64/include/asm/bitops.h:25,
>                  from ./include/linux/bitops.h:33,
>                  from ./include/linux/kernel.h:22,
>                  from kernel/printk/printk.c:22:
> ./arch/arm64/include/asm/atomic_lse.h:247:9: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'atomic_t[1]' [-Warray-bounds]
>   247 |         asm volatile(                                                   \
>       |         ^~~
> ./arch/arm64/include/asm/atomic_lse.h:266:1: note: in expansion of macro '__CMPXCHG_CASE'
>   266 | __CMPXCHG_CASE(w,  , acq_, 32,  a, "memory")
>       | ^~~~~~~~~~~~~~
> kernel/printk/printk.c:3606:17: note: while referencing 'printk_cpulock_owner'
>  3606 | static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
>       |                 ^~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: atomics: lse: Dereference matching size
      https://git.kernel.org/arm64/c/3364c6ce23c6

-- 
Catalin

