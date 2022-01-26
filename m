Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5770D49D5BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiAZWwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiAZWwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:52:04 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFA4C061748;
        Wed, 26 Jan 2022 14:52:04 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e8so955900ilm.13;
        Wed, 26 Jan 2022 14:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbX/CA9rx3VdoijI1jnik093tt/YSMZq2p12OY56GJE=;
        b=FDvaV/SVpssUS1kX5dDZFCvk8MRpwyvPx0Z+IIgr78SYs83UY/9cNwv7wxVU1y71zf
         YFn/8hqfrl1wpKm+qrMwLTtYLgFwIHRyIQvqaO8hmWCF3/DT0nR2VJbNPIhsV+2792di
         Ndq/uKMuB8daKf19+dT1VHwKgYjzr9DN4aHQKfqjtxDYXvNa4EFjA5GxA22vTDUcn4JF
         6jMRF8eZyCPe0ilfZBvCGqBHNsU8fABVwF6U63Hq6deKhB72TpkZyGtaZvdCyfVw8icq
         cbAnBwyH1JDD81+4HRRQ5b+NL34bUnHL/pxfxb1FCI+VZh3/OMe0W+NyRVlJWZqseDyF
         +ZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbX/CA9rx3VdoijI1jnik093tt/YSMZq2p12OY56GJE=;
        b=MzHU2+FiqXoXktfOO9hrCVfkAEoFrTQCtLWWd3YAj3o9u2ZgPekMZSlvlqQi2J9C8t
         Y4khvDno/bslm94o6kMw8XqmQTxDLDE4HpRTa49oRlMp6nLKxJP9tdTA3X4CDIw4nCe3
         FZf7Xqc+IJePYU2mPPxski9+X1VnwpF8aO94zkXPy93qDQz4pOthW7Ucx4BHtKP4Ji3r
         O8ZsOV/3AO+NiK0MNUAv4mU5+18wUaYwQxzjEW9bfIaDm4ZFCGZ5HHF345nQaWF+MFOt
         llWbIyY90wy66nYOB7JwFUdXXXcuitarwWxh7EyPA6dyjk135JF2MaR9FzX+VQW0khYX
         X/fg==
X-Gm-Message-State: AOAM531ynjfs7XUBHx07MvqJyVa7b8DgE4PEmQ+sxJhwYtOH7mE3hLQY
        FCYbgmcf527StMvN5AFRf4dKZjBoe2fJz/XewUs=
X-Google-Smtp-Source: ABdhPJz7GBY/JMkN6SYLj8sxtQBg5EJtrS4PlUVpZ/JYCUtK5E7iqpZDgUjlCM2KZJxqGEF7BOK/ADklNvpBSQT7mZ4=
X-Received: by 2002:a05:6e02:158a:: with SMTP id m10mr925657ilu.59.1643237523612;
 Wed, 26 Jan 2022 14:52:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qVMomgb53rABKsucCoEhwsk+=KzDdEcGKtecOXuahTZw@mail.gmail.com>
 <20220119135450.564115-1-Jason@zx2c4.com>
In-Reply-To: <20220119135450.564115-1-Jason@zx2c4.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 26 Jan 2022 14:51:52 -0800
Message-ID: <CANcMJZABKTdwU8455pLfBjMjgsDO7BNjNWTvwx0sP+3TcJw_XA@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: avoid indirect calls to compression
 function for Clang CFI
To:     "Jason A. Donenfeld" <jason@zx2c4.com>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        YongQin Liu <yongqin.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 11:17 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
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

YongQin also reported hitting this issue(also, only in the LTO=full
case) on the db845c dev board. Sami pointed me to this patch and I
just wanted to confirm it gets things booting again.

Reported-by: YongQin Liu <yongqin.liu@linaro.org>
Tested-by: John Stultz <john.stultz@linaro.org>

Thanks so much for the quick analysis and fix!
-john
