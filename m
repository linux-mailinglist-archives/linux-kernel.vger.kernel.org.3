Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD35B465555
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352340AbhLAS2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:28:30 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55248 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhLAS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:28:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 300D4CE2056;
        Wed,  1 Dec 2021 18:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D3CC53FCD;
        Wed,  1 Dec 2021 18:25:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="V4XmrUPQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638383100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ieeo+489Wz5tzPtoA6+8qXaEQcW7DSRUaKOjLRu8YOw=;
        b=V4XmrUPQr2LiEXbsQBIvvO+T3+dvLbUr8/+WrdSkaFxpHuT1o06adj4g2nyNxmGeIsIqXy
        NJe5SXXgwHQ1YtEPZIfUgXFoDoicRzzxPVA2r1mTNLLE6LjinYfPnrNTUuuLVbLmKVyp62
        PnhJZCuu8j0gBnDlErN0DDJnsmhfZQo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e67e746f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 1 Dec 2021 18:24:59 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id f186so66018398ybg.2;
        Wed, 01 Dec 2021 10:24:58 -0800 (PST)
X-Gm-Message-State: AOAM5308xoRvXg2cC+P/60OGDRMQ7NLXdjbiet2fzWe4QV/3kOy//64X
        ItDB0mRJut6fSIMfGVdwRj2ZzttaNGvmZpzPNfY=
X-Google-Smtp-Source: ABdhPJy3Bjvv9lwuTiURT+8sdQ3ZdgyJqSR5T2hbEdwpzxDsICxg0akiXfDv040pmxdd9l7D84PH3daVcAWVQgyubdU=
X-Received: by 2002:a25:b8c7:: with SMTP id g7mr9349799ybm.115.1638383096150;
 Wed, 01 Dec 2021 10:24:56 -0800 (PST)
MIME-Version: 1.0
References: <2036923.9o76ZdvQCi@positron.chronox.de> <22137816.pfsBpAd9cS@tauon.chronox.de>
 <YaEJtv4A6SoDFYjc@kroah.com> <9311513.S0ZZtNTvxh@tauon.chronox.de>
 <YaT+9MueQIa5p8xr@kroah.com> <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com> <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com> <YaZqVxI1C8RByq+w@gmail.com> <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com> <49d6091e571e24efff7bc4dc70c4c62628eb0782.camel@redhat.com>
In-Reply-To: <49d6091e571e24efff7bc4dc70c4c62628eb0782.camel@redhat.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 1 Dec 2021 13:24:44 -0500
X-Gmail-Original-Message-ID: <CAHmME9q-WUGQ7NUO7oafUBkGBNtWePGXHGfEd2rTmZMUA49+DQ@mail.gmail.com>
Message-ID: <CAHmME9q-WUGQ7NUO7oafUBkGBNtWePGXHGfEd2rTmZMUA49+DQ@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     Simo Sorce <simo@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>, Tso Ted <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 12:19 PM Simo Sorce <simo@redhat.com> wrote:
> that much it is, and it is a required one. However having worked a lot
> on this I can tell you there is actually real cryptographic value in
> the requirements FIPS introduced over the years
> Well I think most of the requirements are sane practices, hopefully
> controversial stuff will be minimal.
> I happen to think quite a few of the requirements are actually good
> ideas to implement to improve the guarantees of randomness

If you think there are good ways to improve the RNG, of course send
patches for this, justifying why, taking into account recent research
into the topic you wish to patch, etc. Don't write, "because FIPS";
instead argue rationale for each patch. And if you _do_ feel the need
to appeal to authority, perhaps links to the various eprint papers you
consulted would be worthwhile. Preferably you're able to do this in a
small, incremental way, with small standalone patchsets, instead of
gigantic series.
