Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE3A463DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245547AbhK3SnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:43:03 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43652 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhK3SnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:43:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CD490CE1AFF;
        Tue, 30 Nov 2021 18:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0E5C53FCF;
        Tue, 30 Nov 2021 18:39:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O5ZPJYmP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638297574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WCoEJFsmjkrCrbXHjmh4SpxFM7rNSkrSOQwoA0wrSlg=;
        b=O5ZPJYmP619ae/2A+AT1eJ8XfddgoQAEYrvpMDwmKAKTEZkat04GsS1tf52a+wcPpwoIjO
        tQz1ouaBPQwz8k9vo219SG4KukuN89BXrcFUjlogYPQm1iphhn0fFSJaX97BYuZs/qYUly
        8u+roXhNJOsAMIYf7RpKQk0Io80B7Gs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4518ea8e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 30 Nov 2021 18:39:34 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id d10so55476178ybe.3;
        Tue, 30 Nov 2021 10:39:33 -0800 (PST)
X-Gm-Message-State: AOAM532P+QtnpZAuOsyAabDTv6FnlulqliyNrr7MVfBSmoacP9S0bS6u
        9S7Scs/Zob1KVcHMWFOpzacYe3ZxJKS5Qk4k1iU=
X-Google-Smtp-Source: ABdhPJzw9kTAlbNg3rrNPlczsyvFRCgkriZ+B/y7W0n1PWSmLYX8REuNa7dYjzcTTno/oHM9M46LeMy/tkPHbcXE41I=
X-Received: by 2002:a25:9781:: with SMTP id i1mr1003847ybo.638.1638297570686;
 Tue, 30 Nov 2021 10:39:30 -0800 (PST)
MIME-Version: 1.0
References: <2036923.9o76ZdvQCi@positron.chronox.de> <22137816.pfsBpAd9cS@tauon.chronox.de>
 <YaEJtv4A6SoDFYjc@kroah.com> <9311513.S0ZZtNTvxh@tauon.chronox.de>
 <YaT+9MueQIa5p8xr@kroah.com> <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com> <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com> <YaZqVxI1C8RByq+w@gmail.com>
In-Reply-To: <YaZqVxI1C8RByq+w@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 30 Nov 2021 13:39:19 -0500
X-Gmail-Original-Message-ID: <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
Message-ID: <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simo Sorce <simo@redhat.com>,
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

On Tue, Nov 30, 2021 at 1:16 PM Eric Biggers <ebiggers@kernel.org> wrote:
> So unfortunately, as far as I can tell, Ted is not maintaining random.c anymore.

I am happy to step up here. Feel free to CC me on random.c fixes and
I'll review them promptly.

Jason
