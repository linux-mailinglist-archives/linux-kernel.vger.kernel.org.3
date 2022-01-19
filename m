Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4045493844
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345490AbiASKU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:20:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38746 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240254AbiASKUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:20:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C95DB81910;
        Wed, 19 Jan 2022 10:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CD4C340E1;
        Wed, 19 Jan 2022 10:20:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pzCb1EEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642587621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AB3FPF0PWILNkb7gaXOI95vEqUZ5994CRNrN/w78cI8=;
        b=pzCb1EEQcFUzN9yRu8u5sT2Be6L9JiPSihgpKwRzMiqSjjCWSiEyfmKxTsVnURi1V+xo+L
        YcSP0+/S+QLlbBJ/vaM1HactjenuvmSnS2VPJVx/uRGShzP9rIIqslr9C+dwbc0gYNnnIO
        Za0l+EvdKKltVcjNRAPkmnz5FaUv/dg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 72bb5f91 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 19 Jan 2022 10:20:21 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id k31so4307339ybj.4;
        Wed, 19 Jan 2022 02:20:21 -0800 (PST)
X-Gm-Message-State: AOAM530SuiMDY+o7+zPmlgJSMs9uZUYtrXRobW5yGqgtQ9FxaYzlwxgm
        /KmIcApSKG8npy9D0eeOSZ4InIeBovVMT7jzFac=
X-Google-Smtp-Source: ABdhPJxkL+8NhfTkbWqgVwGhaqfAeaKm7FaIYTp91pt11kI9EDshoZkY5I8wsKGSuxuQlLcEkQvSDynZCQV+wge/lWk=
X-Received: by 2002:a25:bc52:: with SMTP id d18mr9483510ybk.255.1642587619663;
 Wed, 19 Jan 2022 02:20:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:209:b0:11c:1b85:d007 with HTTP; Wed, 19 Jan 2022
 02:20:19 -0800 (PST)
In-Reply-To: <CAMj1kXE_6WboUK0VPbTwzTbMNxv8b4XUp7USQUp=YqcCRMTZig@mail.gmail.com>
References: <CAHmME9oX+4Ek81xy0nBOegqABH0xYqyONAqinsu7GZ7AaQaqYQ@mail.gmail.com>
 <20220119100615.5059-1-miles.chen@mediatek.com> <CAMj1kXE_6WboUK0VPbTwzTbMNxv8b4XUp7USQUp=YqcCRMTZig@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Jan 2022 11:20:19 +0100
X-Gmail-Original-Message-ID: <CAHmME9o-=q6jT6mF3XsfoA17756YVEWdXGHukP=rxWS1gs5irg@mail.gmail.com>
Message-ID: <CAHmME9o-=q6jT6mF3XsfoA17756YVEWdXGHukP=rxWS1gs5irg@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22, Ard Biesheuvel <ardb@kernel.org> wrote:
> On Wed, 19 Jan 2022 at 11:06, Miles Chen <miles.chen@mediatek.com> wrote:
>>
>> Hi,
>>
>> >Hi Miles,
>> >
>> >I'm actually not able to reproduce your oops. I'm using vanilla clang
>> >13, cross compiling for arm64, with thin LTO enabled and CFI enabled.
>> >Kernel seems to run fine.
>> >
>> >
>> >Are there other settings that are needed to trigger this? Do you see
>> >it in upstream clang or just the Android fork of clang?
>> >
>> I will try another clang (the previous version I use).
>> I am using Android fork of clang and there is a clang upgrade in this
>> merge.
>>
>
> One thing that could be worth a try is to make __blake2s_update() and
> __blake2s_final() __always_inline rather than just inline, which by
> itself does not appear to be sufficient for the code to get inlined.
> (If it were, the indirect call should have disappeared as well)
>
> Given that indirect calls suck on x86, we should probably apply that
> change in any case, regardless of CFI.
>

Had the same thought at first, but then looking at the original stack
trace, it looks like the __ function is inlined:

[    0.000000][    T0]  __cfi_slowpath_diag+0x354/0x4b0
[    0.000000][    T0]  blake2s_update+0x14c/0x178
[    0.000000][    T0]  _extract_entropy+0xf4/0x29c

So that makes me think that the issue really does involve calling
through the weak alias. But why should weak alias calling trigger CFI?
Compiler bug? Some other subtlety we're missing?

Jason
