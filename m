Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7545463D82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245399AbhK3STS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbhK3STR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:19:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C6FC061574;
        Tue, 30 Nov 2021 10:15:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 842FBCE1AF9;
        Tue, 30 Nov 2021 18:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56B4C53FC7;
        Tue, 30 Nov 2021 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638296153;
        bh=KszbXaHbfOc2Nhur115bSEzw+sxwzvVpgaoXce0hUeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvoBhd3HTrfwP/+FCfUG763klv8OrF/++24trInXsRoQ+avLpr+z0q/0jj/luWbPJ
         0rwuyx2LhQKj52N5hpDHs4FuXRw11OLjVWunfDFDXoFKTMl5ZzWjK058CYRsNeiPVZ
         E6kbLcPkUQcGKZ+dmTXXE36mkPbphNcNwte52S23AENgBhu3PWjSGZnnORI+p0xqAV
         7qDW+1sPQYqArCNmryQFLq8SzihNEscYcGRTbdtz7gUfwJDZ6ehgie8/HgiFN7z+Qm
         VbUZyboZMswuZFrjPuoYTH1OtgfRf+ZOazEmnfVK4k1Snou75crhMV/36Y3AskKZW1
         VRvHNXSgkJTag==
Date:   Tue, 30 Nov 2021 10:15:51 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Simo Sorce <simo@redhat.com>, Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Tso Ted <tytso@mit.edu>,
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
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <YaZqVxI1C8RByq+w@gmail.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
 <22137816.pfsBpAd9cS@tauon.chronox.de>
 <YaEJtv4A6SoDFYjc@kroah.com>
 <9311513.S0ZZtNTvxh@tauon.chronox.de>
 <YaT+9MueQIa5p8xr@kroah.com>
 <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com>
 <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaZHKHjomEivul6U@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 04:45:44PM +0100, Greg Kroah-Hartman wrote:
> > And the main question here is, how can we get there, in any case, if
> > the maintainer of the random device doesn't even participate in
> > discussions, does not pick obvious bug fixes and is simply not engaging
> > at all?
> 
> What obvious bug fixes have been dropped?
> 

The RNDRESEEDCRNG ioctl was totally broken, and I sent out a patch to fix it
which was ignored for months:
https://lore.kernel.org/linux-crypto/20200916041908.66649-1-ebiggers@kernel.org/

Reminders didn't help:

First ping: https://lore.kernel.org/linux-crypto/20201007035021.GB912@sol.localdomain/
Second ping: https://lore.kernel.org/linux-crypto/20201026163343.GA858@sol.localdomain/
Third ping: https://lore.kernel.org/linux-crypto/X7gQXgoXHHEr6HXC@sol.localdomain/
Fourth ping: https://lore.kernel.org/linux-crypto/X%2FNkrKpaIBTjQzbv@sol.localdomain/
Resent to Andrew Morton: https://lore.kernel.org/linux-crypto/20210112192818.69921-1-ebiggers@kernel.org/
Pinged Andrew: https://lore.kernel.org/linux-crypto/YBiEJ9Md60HjAWJg@sol.localdomain/

Finally *you* took the patch: https://lore.kernel.org/linux-crypto/YBwZ1a0VIdpTDNuD@kroah.com/

Here's another random.c bug fix which was ignored, this one for 6 months before
Herbert Xu finally took it through the crypto tree:
https://lore.kernel.org/linux-crypto/20210322051347.266831-1-ebiggers@kernel.org/

Here's a dead code cleanup which was ignored for 6 months before being taken by
Herbert Xu through the crypto tree:
https://lore.kernel.org/linux-crypto/20200916043652.96640-1-ebiggers@kernel.org/

Here's a patch to random.c which was taken by the arm64 maintainers due to being
ignored by the random.c maintainer:
https://lore.kernel.org/lkml/20201105152944.16953-1-ardb@kernel.org/

So unfortunately, as far as I can tell, Ted is not maintaining random.c anymore.  

- Eric
