Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C25E493907
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353602AbiASK4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346911AbiASK4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:56:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF2BC061574;
        Wed, 19 Jan 2022 02:56:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98C8E61564;
        Wed, 19 Jan 2022 10:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89EAC340E8;
        Wed, 19 Jan 2022 10:56:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="clSmDhQ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642589801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c6OIpweiYSlg1CO1oV/4/fX9PmbGWaJgEcK1s5L/UCM=;
        b=clSmDhQ9v6mwT8AqA/7PddiliXjzCnVuKqGHWuRMScEBMvlsnTy8g6e1Y6cMjyqzqjVYOt
        +xUXZMczZX6IXfAgbWAYUOdoJ2GpYjNYh3LGTJpoIkSRLGNNrO6HqGrfX+Sey4uOmMExW0
        8PRRZeAuWLXdS31lzH9DCVM+ZQdLbGg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0f6fc849 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 19 Jan 2022 10:56:41 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id 23so6157072ybf.7;
        Wed, 19 Jan 2022 02:56:40 -0800 (PST)
X-Gm-Message-State: AOAM533OObl2AlyRmlPd3OUOVN8MmQgyuLx2HmsUKJzVpj+jPkxde6OC
        uyc4yl4yjSEkZaL7DlqGmZjE8l8UtYLICdQwuf0=
X-Google-Smtp-Source: ABdhPJwSrhUa6tV1Vuk+5uZ3ov5nQgpookiKOhJa3YUNCmP6fIkNz2Lw1CO4IK9upJuph+xxqIgYgHP4KC7FjLDB5Tw=
X-Received: by 2002:a25:bc52:: with SMTP id d18mr9639032ybk.255.1642589799667;
 Wed, 19 Jan 2022 02:56:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:209:b0:11c:1b85:d007 with HTTP; Wed, 19 Jan 2022
 02:56:39 -0800 (PST)
In-Reply-To: <CAHmME9pQcUxs87EwQwBZNDA4ZzqugTggH+uiNPh=mv5zjp3g3A@mail.gmail.com>
References: <CAHmME9oX+4Ek81xy0nBOegqABH0xYqyONAqinsu7GZ7AaQaqYQ@mail.gmail.com>
 <20220119100615.5059-1-miles.chen@mediatek.com> <CAHmME9pQcUxs87EwQwBZNDA4ZzqugTggH+uiNPh=mv5zjp3g3A@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Jan 2022 11:56:39 +0100
X-Gmail-Original-Message-ID: <CAHmME9pPKjRLmR6zpYFZT7rOOfHsG2ESnDi+QQrDJuGLo1X4JQ@mail.gmail.com>
Message-ID: <CAHmME9pPKjRLmR6zpYFZT7rOOfHsG2ESnDi+QQrDJuGLo1X4JQ@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     ardb@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org,
        herbert@gondor.apana.org.au, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        nathan@kernel.org, ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Miles,
>
> Okay. Keep me posted.
>
> Just FYI, as mentioned, I'm unable to reproduce this, and you haven't
> provided any further minimized guidance on how I might reproduce this,
> so it'll sit in the "not a bug" bin until I have another clue on how
> to reproduce. Alternatively, Nick and Nathan are now on this thread
> and they usually have good luck teasing out compiler issues and such,
> so maybe they'll have an idea. But I'm afraid with the information I
> currently have, I'm at a dead end.
>
> Jason
>

We're back in business! I was able to reproduce this using FullLTO
rather than ThinLTO.
