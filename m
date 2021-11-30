Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45489462ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbhK3IuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239749AbhK3IuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:50:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF8C061574;
        Tue, 30 Nov 2021 00:46:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CFBCBCE1805;
        Tue, 30 Nov 2021 08:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF43C53FC1;
        Tue, 30 Nov 2021 08:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638262016;
        bh=kHcvZf2LKMC1CCKubVLXC337NilFhltDlE9u9PHeGBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVhGORj3qCUI1QHNLmUoyKAhEDbetMkpn56CtK3FeuDjsqhtMO7vR9cY2+p2qAUdm
         xEVyNx+LY8jrEbYfZlzojPn1aYgAANN681WNd5HqAwp+gAjXCDZUhoCWFRnYj/YvD2
         HWHzQtyYOO9qG5jO3nTffdC3v+H3dNT/zEstYJjU=
Date:   Tue, 30 Nov 2021 08:55:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     Simo Sorce <simo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Tso Ted <tytso@mit.edu>,
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
        Eric Biggers <ebiggers@kernel.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>,
        John Kelsey <crypto.jmk@gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <YaXZCdtyylHMa29o@kroah.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
 <4641592.OV4Wx5bFTl@positron.chronox.de>
 <CAHmME9oaS4TOpk7rQ73BRKeVLjMUNyt6EFyeOX=hZSkFBPDu0g@mail.gmail.com>
 <56d2da397bb53f71c0354b102c3b40940e9b4eda.camel@redhat.com>
 <CACXcFmntNAWYCwQ6CmH5c3pn3fXbxKh=j75GZUeLkuqi3QdS+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACXcFmntNAWYCwQ6CmH5c3pn3fXbxKh=j75GZUeLkuqi3QdS+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 03:32:38PM +0800, Sandy Harris wrote:
> I think we should eliminate add_disk_randomness() since it does
> not work well on current hardware. Also, FIPS requires that
> entropy sources be independent & add_interrupt_randomness()
> depends on the same disk events so these sources may not be.

This whole "may not be" guessing game when it comes to FIPS
certification is a huge problem.  I have heard of different vendors
getting different feedback and different implementations "passing" in
different ways that totally contradict each other.  It seems that there
is a whole certification industry built up that you can use to try to
pass these tests, but those tests are different depending on the vendor
you use for this, making a total mess.

So perhaps getting solid answers, and having the FIPS people actually
implement (or at least review) the changes and submit them (this is all
open for everyone to see and work on), would be the best thing as that
would at least let us know that this is what they require.

Otherwise, it's a total guess as you state many times in this email, and
that is going to get us nowhere fast as the "requirements" end up
contradicting themselves all the time.

Also, why does any of this have to be in the kernel at all?  If FIPS
requires a deterministic random number generator that will not allow
entropy to be acquired from hardware or external inputs, why does the
kernel care at all?  Just write a fips_random.so library and get it
certified and have any userspace code that cares about such a crazy
thing to use that instead.

thanks,

greg k-h
