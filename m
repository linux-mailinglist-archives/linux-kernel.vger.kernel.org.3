Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BA447805B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbhLPXOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbhLPXOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:14:46 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3508BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:14:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b7so1182021edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=leN4ToUWeqVpg13p/IoYSSc9DyWGdv7mnjoOFy505fA=;
        b=COuDndAPNxF03xXqhgRDDWsGpGVwE98zlgUtoZag+Bvzj95HCbj01dkwIw4vwaq6Ga
         N90PFU8P57pDst3A16Zcjrgo4vCie/DI4eGMjE6d8Yz7eednpxuVTAwOpZT5P4Mm5gtS
         FZasthLCwD2sDJi9uHxz6z7IxY1oGo92UTBL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=leN4ToUWeqVpg13p/IoYSSc9DyWGdv7mnjoOFy505fA=;
        b=q0eWLRzM7MZSgcSIBVy2YHKjGtTsq6hu0//nuI+z9CJiQVp1PgIX2WwGuZ2dmRKByf
         lR3s+ZxujYDg0easm2la+01NKVrFYArDDetWKYTaO8JcmrafRIfLdNj42Pe1oCpnuBzo
         wTDC+v8intqkmTsEnyZB3hkL+XqPnEF5KLjkX+r5yaO2uqdamGA17u9+P3HU1at0OhGF
         zAy/75ln78Pa/yatvCuyFifKKQTHnzmLjSC2e91D1CiBxgjqNaHQJySuq0jK9YLNDNEL
         RZQ5KK1sIjkw6q8c6RTadm4kVvHr0iWEfFaPkbawdWidtnywJIx/VBApkploygRONk10
         lwdQ==
X-Gm-Message-State: AOAM530WKX5uNruofskb9xvC719+25tPcx3+SMzQkohbEyo7/SOWB1pW
        tdWc6nZ3E5QT8nIU6y1X9sX6BxyvEk+EvRahrOg=
X-Google-Smtp-Source: ABdhPJyjFETYhLYXncrRXlNzGKzWrnMsgLBK1N7nF4SJnOldHvIhy3V0+Ng0UEob5xNxoU8FNf3wRQ==
X-Received: by 2002:a17:907:3e22:: with SMTP id hp34mr314054ejc.58.1639696484674;
        Thu, 16 Dec 2021 15:14:44 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id o22sm2847884edw.50.2021.12.16.15.14.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 15:14:44 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso489302wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:14:44 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr157474wms.144.1639696483940;
 Thu, 16 Dec 2021 15:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20211216213207.839017-1-kuba@kernel.org>
In-Reply-To: <20211216213207.839017-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Dec 2021 15:14:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=whayMx6-Z7j7H1eAquy0Svv93Tyt7Wq6Efaogw8W+WpoQ@mail.gmail.com>
Message-ID: <CAHk-=whayMx6-Z7j7H1eAquy0Svv93Tyt7Wq6Efaogw8W+WpoQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 5.16-rc6
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 1:32 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Relatively large batches of fixes from BPF and the WiFi stack,
> calm in general networking.

Hmm. I get a very different diffstat, and also a different shortlog
than the one you quote.

I do get the top commit you claim:

>   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.16-rc6
>
> for you to fetch changes up to 0c3e2474605581375d808bb3b9ce0927ed3eef70:
>
>   Merge https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2021-12-16 13:06:49 -0800)

But your shortlog doesn't contain

  Alexei Starovoitov (3):
        bpf: Fix extable fixup offset.
        bpf: Fix extable address check.
        selftest/bpf: Add a test that reads various addresses.

  Daniel Borkmann (7):
        bpf: Fix kernel address leakage in atomic fetch
        bpf, selftests: Add test case for atomic fetch on spilled pointer
        bpf: Fix kernel address leakage in atomic cmpxchg's r0 aux reg
        bpf, selftests: Update test case for atomic cmpxchg on r0 with pointer
        bpf: Fix signed bounds propagation after mov32
        bpf: Make 32->64 bounds propagation slightly more robust
        bpf, selftests: Add test case trying to taint map value pointer

  Kumar Kartikeya Dwivedi (1):
        selftests/bpf: Fix OOB write in test_verifier

  Magnus Karlsson (1):
        xsk: Do not sleep in poll() when need_wakeup set

  Paul Chaignon (2):
        bpf: Fix incorrect state pruning for <8B spill/fill
        selftests/bpf: Tests for state pruning with u32 spill/fill

and that seems to be the missing diffstat contents also.

It looks like your pull request was done without that last merge, even
though you do mention it as being the top of tree.

I've pulled this, because that last merge looks fine and intentional,
but I'd like you to double-check your workflow to see what happened to
give a stale diffstat and shortlog...

              Linus
