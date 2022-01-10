Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9C5489B67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiAJOi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiAJOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:38:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90B6C06173F;
        Mon, 10 Jan 2022 06:38:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 719EB612C6;
        Mon, 10 Jan 2022 14:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2EDC36AE3;
        Mon, 10 Jan 2022 14:38:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RdzY8XzR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641825502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fj87LGZRVKioDw38JcFWbJUZepTo25h+z4GP4g1/lpY=;
        b=RdzY8XzRLTrmvn+OF0Beh4lVhNR+AizsclXjUqPwQmIwKyzRSdt9092egvzLsDJ5iQT+/q
        sAt1G5JTYqTddMJCDvKGL1JlaYlMxu+ZzB2+KvpupO68yLu412iWKG4QmQYtZ0ctEZ9HST
        TEJuWaUuwqnyQTmnvIDjFrdnzajKH6E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6e111bf2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 10 Jan 2022 14:38:22 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id j83so38632912ybg.2;
        Mon, 10 Jan 2022 06:38:20 -0800 (PST)
X-Gm-Message-State: AOAM531Wf6v9sdVxc91TnESNk2XllIVC2qVnlXQkI9CRhnLi/I2w8E0z
        KLIauwYWGRB+4QnjS95uxwp/aLaZGwIhUPGwBgg=
X-Google-Smtp-Source: ABdhPJxaoaaDGrTL8h6SSYsKz+5bFpcy+FLDkAY5VDMTgOLzsMGlo5RqdGPbPPUqwluUa/ljiwcHMAVYT/gNGcQHyt4=
X-Received: by 2002:a25:854f:: with SMTP id f15mr87109175ybn.121.1641825499354;
 Mon, 10 Jan 2022 06:38:19 -0800 (PST)
MIME-Version: 1.0
References: <YaYvYdnSaAvS8MAk@kroah.com> <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com> <YaZqVxI1C8RByq+w@gmail.com> <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor> <20220110132349.siplwka7yhe2tmwc@valinor>
 <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com> <YdxCsI3atPILABYe@mit.edu>
In-Reply-To: <YdxCsI3atPILABYe@mit.edu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 10 Jan 2022 15:38:08 +0100
X-Gmail-Original-Message-ID: <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
Message-ID: <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Simo Sorce <simo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>,
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

Hi Ted,

On Mon, Jan 10, 2022 at 3:31 PM Theodore Ts'o <tytso@mit.edu> wrote:
> There might be some FIPS certification labs that might be willing to
> be taken in by the jitterentropy story, but when I've had private
> communications from people who are familiar with the Intel
> microarchitecture saying that jitterentropy is mostly "security by
> obscurity", I'd be strongly opposed to replacing the current scheme
> with something which is purely jitteretropy.
>
> Perhaps an build-time option where one of the seeds into the CRNG is
> "jitterentropy", but we keep everything else.  That way, jitterentropy
> can still be TSA-style "security theatre", but we're not utterly
> dependant on the "the CPU microarchitecture is SOOOOOOO complicated,
> it *must* be unpredictable".

Yea, I'm not really compelled by it as something real that we'd
actually want to have for something serious. Keep in mind: this thread
isn't really about cryptography, but just about compliance nonsense.
BUT, if it turns out that the path to these people getting their green
compliance checkbox stamp isn't actually thousands of lines of new
code, but rather some glue bridging the /dev/urandom / getrandom(2)
API into the blah cryptoapi thing, that's... interesting news to me.
I'm not even saying, at this stage anyhow, that I want to do this, but
I do find it a very interesting data point. As I wrote in [1]:

> Specifically, I think that if you change your perspective from, "how can we
> change the algorithms of the RNG to be FIPS" to "how can we bend FIPS within
> its limits so that having what customers want would minimally impact the
> quality of the RNG implementation or introduce undue maintenance burdens."

We're now starting to get some idea about how this FIPS stuff bends.

Jason

[1] https://lore.kernel.org/lkml/CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com/
