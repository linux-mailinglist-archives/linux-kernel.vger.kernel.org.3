Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26241461B15
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345139AbhK2PjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:39:10 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:34046 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244985AbhK2PhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638199921;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=v6c6Xn6Fs31Rf3Z7IjbdhYoA5Fgm3xF8Nq3u6kz0t6s=;
    b=PVA+Fg3lwJX6Jc3bKWgSVBYwLDL4eKa0zOfxy+Q5Od9SHRkvlTd04n/0tFb7MCB5f2
    VEsWFyZ0jQhB6OWiF7Yr0r6e+uI70REz/RexfFCUNiE9UhEN9eBJqE2CtZIY5nRsHX5c
    U9HOSu8mcvSAp0QFc9j/qK+60ffC6BXkTAKYHEij8RJSH0aDWPYPuW2HP7lcCTzNkeWr
    lyANtSdVJOofgfjG4EiAXUqHDVuM7IJhOqSyZuuA3HLxnSk1dO1TZeFd6yFlVvS4u8TJ
    TKK2MceZe2VeWk0vcQC2nKZrA/IddBl7ts5YpMagxeZqqbz28zHVw9hiIIvnumqGHoKi
    ae/g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbIvSX5lo="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id 006230xATFVxR5f
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 Nov 2021 16:31:59 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Simo Sorce <simo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Tso Ted <tytso@mit.edu>,
        linux-crypto@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Nicolai Stange <nstange@suse.de>,
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
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Date:   Mon, 29 Nov 2021 16:31:59 +0100
Message-ID: <9311513.S0ZZtNTvxh@tauon.chronox.de>
In-Reply-To: <YaEJtv4A6SoDFYjc@kroah.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de> <22137816.pfsBpAd9cS@tauon.chronox.de> <YaEJtv4A6SoDFYjc@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 26. November 2021, 17:22:14 CET schrieb Greg Kroah-Hartman:

Hi Greg,

> On Fri, Nov 26, 2021 at 05:15:59PM +0100, Stephan Mueller wrote:
> > Am Freitag, 26. November 2021, 16:44:17 CET schrieb Greg Kroah-Hartman:
> > 
> > Hi Greg,
> > 
> > > On Mon, Nov 22, 2021 at 09:59:01AM -0500, Simo Sorce wrote:
> > > > Jason,
> > > > have you previously produced a list of reasoned concerns with this
> > > > patchset and direction?
> > > > 
> > > > This specific email is not really useful to me to understand the
> > > > concerns as it does not contain actionable suggestion or critique.
> > > > 
> > > > I personally find the direction fine, and with my distribution hat on
> > > > I
> > > > can say that FIPS is essential for us and any design must include an
> > > > option to be FIPS certifiable.
> > > > 
> > > > As NIST keeps improving their testing capabilities and rigorous
> > > > cryptographic design of the CSPRNGs as well as entropy sources the
> > > > kernel must also adapt.
> > > > 
> > > > Stephan is providing a path forward, and I haven't seen any other
> > > > proposal, let alone code, that provide improvements in this area.
> > > > I am pretty sure the design can be improved if there is detailed and
> > > > actionable feedback on what to change.
> > > > 
> > > > I hope the path forward can be one of collaboration rather then mere
> > > > opposition.
> > > 
> > > Replacement of the existing code to cut over to the new one is not
> > > collaboration, it's the exact opposite.
> > > 
> > > Submitting patches to the existing codebase to implement the
> > > "requirements" is the proper way forward, why has that never been done.
> > 
> > It has been attempted by Nikolai Stange without avail - no comments were
> > received, let alone it was integrated.
> 
> Links to the patches and discussion please?

Please consider https://lkml.org/lkml/2020/9/21/157

One side note: the LRNG patch set does not replace random.c, but provides an 
additional implementation that can be selected at compile time. I am under the 
impression that is an equal approach considering other areas of the kernel 
like file systems, memory allocators, and similar.

Thanks
Stephan


