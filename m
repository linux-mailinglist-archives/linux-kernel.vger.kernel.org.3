Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00004462F57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhK3JQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbhK3JQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:16:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD44C061574;
        Tue, 30 Nov 2021 01:12:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7E98BCE1812;
        Tue, 30 Nov 2021 09:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B893C53FC1;
        Tue, 30 Nov 2021 09:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638263568;
        bh=4JcYK/yqU0SL3yp2LRtgP37CCPXprJJvr28ExlWkeAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xcIa+VQtbjb0+teyocx83xsLCtG1mvtLcQcuk9O0YJvK7dIncxSZ96CSSqUv9Gpkp
         Wpr/Oq8MAphjBaKb9FiltQR3ZAKSBi5gpXgwd/+RANyP1cXGD5YFpmjrQUgjr+L7So
         7e8ADHNnCk8c4X6U0ozzM4Hd0b2lwHOnASP6vGw8=
Date:   Tue, 30 Nov 2021 10:12:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Sandy Harris <sandyinchina@gmail.com>,
        Simo Sorce <simo@redhat.com>,
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
        Eric Biggers <ebiggers@kernel.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>,
        John Kelsey <crypto.jmk@gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <YaXrDnsE4+xSGDep@kroah.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
 <CACXcFmntNAWYCwQ6CmH5c3pn3fXbxKh=j75GZUeLkuqi3QdS+A@mail.gmail.com>
 <YaXZCdtyylHMa29o@kroah.com>
 <2288548.vrFIavQkS3@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2288548.vrFIavQkS3@tauon.chronox.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 09:56:41AM +0100, Stephan Mueller wrote:
> Am Dienstag, 30. November 2021, 08:55:53 CET schrieb Greg Kroah-Hartman:
> 
> Hi Greg,
> 
> > On Tue, Nov 30, 2021 at 03:32:38PM +0800, Sandy Harris wrote:
> > > I think we should eliminate add_disk_randomness() since it does
> > > not work well on current hardware. Also, FIPS requires that
> > > entropy sources be independent & add_interrupt_randomness()
> > > depends on the same disk events so these sources may not be.
> > 
> > This whole "may not be" guessing game when it comes to FIPS
> > certification is a huge problem.  I have heard of different vendors
> > getting different feedback and different implementations "passing" in
> > different ways that totally contradict each other.  It seems that there
> > is a whole certification industry built up that you can use to try to
> > pass these tests, but those tests are different depending on the vendor
> > you use for this, making a total mess.
> > 
> > So perhaps getting solid answers, and having the FIPS people actually
> > implement (or at least review) the changes and submit them (this is all
> > open for everyone to see and work on), would be the best thing as that
> > would at least let us know that this is what they require.
> 
> Just as a note: I am working as FIPS tester. I am part of the NIST entropy 
> working group which oversees the entropy related requirements. The LRNG's FIPS 
> compliant implementation is directly based on those requirements. The LRNG was 
> even reviewed by NIST personnel who mentioned that they do not see any 
> contradiction to the specification. Finally, we are pursuing to get a separate 
> ENT validation from NIST for the LRNG which would indicate that the LRNG meets 
> all their requirements.

That's great, so you would be one of the best people to help submit
changes to the existing code to have it be compliant, instead of
replacing it entirely :)

thanks,

greg k-h
