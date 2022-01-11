Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B602C48BAC4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346405AbiAKW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:27:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35490 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346361AbiAKW1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:27:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3283B6117C;
        Tue, 11 Jan 2022 22:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C1DC36AF3;
        Tue, 11 Jan 2022 22:27:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CAk4dElx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641940064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r78yUE86VeSEcEQHbZgg8GsRYOzwteaxdnAYUe54E0I=;
        b=CAk4dElxTseA/3oFOzYSOgCp/o0cpJC1IuT981xJhW8pStwJOpMuK8ETWIwcSg5Tm+ugOc
        WIMVABU890FzX71mYzWuZ2SvDVqbKchnbjMwe4h1o6C+1b/WAdwy1gc3/cex7h8up2RgTt
        jjQL2Fn5qO9Sxl1vtpZ0qbxBjRuDp7o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 956c42ae (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 11 Jan 2022 22:27:43 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id m6so1085894ybc.9;
        Tue, 11 Jan 2022 14:27:43 -0800 (PST)
X-Gm-Message-State: AOAM530dxygQsXZLVSNKuDwj2Xr3YjFrFlOVp8bs9FxNboeJg7IXbBlO
        agXzGAEyiH3Dzm/9ns/z209ajkblABemODoTJxM=
X-Google-Smtp-Source: ABdhPJwCu3UPYlqKxdrI+7803IlPMhLJyWH7dBKChGznL9HvDTLRhzsQ1WE5pFWgVNCUS97er4tDrVBNKuNTxlbsOtE=
X-Received: by 2002:a25:8c4:: with SMTP id 187mr8748453ybi.245.1641940062163;
 Tue, 11 Jan 2022 14:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20220111195309.634965-1-jforbes@fedoraproject.org>
 <CAHmME9pi1Y7urg1VQeCi7L6MxHRUk5g4wc6VKDywo4yPh9h_6w@mail.gmail.com> <CAMj1kXH24ubv7yAqmbnzqe22cGh1L0-N8J6fiCT2NgU2HmeBJw@mail.gmail.com>
In-Reply-To: <CAMj1kXH24ubv7yAqmbnzqe22cGh1L0-N8J6fiCT2NgU2HmeBJw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Jan 2022 23:27:31 +0100
X-Gmail-Original-Message-ID: <CAHmME9qXg3_HdnDwN-LOBJQhxz4acYCjgQhXRovQ6-9TWwHwWQ@mail.gmail.com>
Message-ID: <CAHmME9qXg3_HdnDwN-LOBJQhxz4acYCjgQhXRovQ6-9TWwHwWQ@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: add prompts back to crypto libraries
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, jmforbes@linuxtx.org,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:25 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 11 Jan 2022 at 23:12, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Justin,
> >
> > These are library variables, which means they really have no sense in
> > being user selectable. Internal things to the kernel depend on them,
> > or they don't. They're always only dependencies.
> >
>
> But what does any of this have to do with blake2s? These are unrelated
> changes that are not even described in the commit log of the original
> patch, so let's just revert them now. If changes are needed here, we
> can discuss them on the linux-crypto mailing list after the merge
> window.

The lib crypto stuff moved outside of `if CRYPTO`, so if you add those
titles back, the root menu is going to be filled with things. I'm
working on some patches now moving lib/crypto/ things into lib
strictly, so the dependency is one way. I can try adding back the
labels there if you want.

Jason
