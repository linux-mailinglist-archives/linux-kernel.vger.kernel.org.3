Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90284493B25
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350255AbiASNes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiASNer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:34:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC01C061574;
        Wed, 19 Jan 2022 05:34:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F974B8189A;
        Wed, 19 Jan 2022 13:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B128C340E9;
        Wed, 19 Jan 2022 13:34:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lo/qsE3O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642599280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KZuC6TmXhJQVSeFuSv1mMMFPmjV47Ffvc9/epCoTyMw=;
        b=lo/qsE3OdM57p2UPmTM4vhgsJTwEd33zm6WXgphvGllfKgyMDMYAL/ekg+CEXfP4YXyYY6
        etdTZ/wfi5hqt1w9QzeK76g8zOqVnVlqs9ATDpWRgNPoTvm89wvC/T6qXWD6iOH6npuQGi
        bjRJctbJQH6hIDE37t1E6Rfmu4qT9TE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d4afa98c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 19 Jan 2022 13:34:40 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id m1so7467250ybo.5;
        Wed, 19 Jan 2022 05:34:40 -0800 (PST)
X-Gm-Message-State: AOAM530FrciVPFIeptolOo40eZbvW2d9OWsxNCvGTVpcDTYc1Zi78lNP
        cygai3szlc/ZVqnlJaUgwphmib81FCBXLRx0MSg=
X-Google-Smtp-Source: ABdhPJwl2oYebyTcjJJzYEcQx1P0FnZ8TEkLTKOLecv3UE1gMShS+rFpjiSNu6UvcQ2d9xR0yhRTcFuoVyPulYXQV48=
X-Received: by 2002:a05:6902:709:: with SMTP id k9mr15518165ybt.113.1642599277841;
 Wed, 19 Jan 2022 05:34:37 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9oX+4Ek81xy0nBOegqABH0xYqyONAqinsu7GZ7AaQaqYQ@mail.gmail.com>
 <20220119100615.5059-1-miles.chen@mediatek.com> <CAHmME9pQcUxs87EwQwBZNDA4ZzqugTggH+uiNPh=mv5zjp3g3A@mail.gmail.com>
 <CAHmME9pPKjRLmR6zpYFZT7rOOfHsG2ESnDi+QQrDJuGLo1X4JQ@mail.gmail.com>
 <CAHmME9oGTPS-gVyHQ4o=AxvMJrGH44_tyQ2KPQcfAKgcqC2SnA@mail.gmail.com> <CAMj1kXEo8kQNeoCdwvBkkW0UeYFQEJwkZ_nj06qjsBDF2Qu2pQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEo8kQNeoCdwvBkkW0UeYFQEJwkZ_nj06qjsBDF2Qu2pQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Jan 2022 14:34:27 +0100
X-Gmail-Original-Message-ID: <CAHmME9qVMomgb53rABKsucCoEhwsk+=KzDdEcGKtecOXuahTZw@mail.gmail.com>
Message-ID: <CAHmME9qVMomgb53rABKsucCoEhwsk+=KzDdEcGKtecOXuahTZw@mail.gmail.com>
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

On Wed, Jan 19, 2022 at 1:19 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> I'd prefer it if we could avoid magic #define's like this.

I'll send something that just replaces it with a simple bool.
