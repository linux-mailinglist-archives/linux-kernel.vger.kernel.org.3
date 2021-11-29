Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0110C462125
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351782AbhK2T7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhK2T5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:57:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6C0C0698CB;
        Mon, 29 Nov 2021 08:25:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B8B615A3;
        Mon, 29 Nov 2021 16:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848CDC53FC7;
        Mon, 29 Nov 2021 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638203127;
        bh=E9Gp+P2/fj8SXqkg1/fO6Q5h7cq96o56OHJEMlCdHi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNq1FOXJE8qvnLtnCeSWd4Zx68X+LuM8K+YCMbZlOLBhgCZxO9aLx2WyvPyKMni0O
         p70mFxDjCekUSy6hu6PqtomydQlNwdvxXIRedzNg4pUNK1jYw8+kyiUeIpve7MGYga
         zqOXCcaWua7R3Ixgbo/eypRjyQki/HxtspqCFOp8=
Date:   Mon, 29 Nov 2021 17:25:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephan Mueller <smueller@chronox.de>
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
Message-ID: <YaT+9MueQIa5p8xr@kroah.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
 <22137816.pfsBpAd9cS@tauon.chronox.de>
 <YaEJtv4A6SoDFYjc@kroah.com>
 <9311513.S0ZZtNTvxh@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9311513.S0ZZtNTvxh@tauon.chronox.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 04:31:59PM +0100, Stephan Mueller wrote:
> Am Freitag, 26. November 2021, 17:22:14 CET schrieb Greg Kroah-Hartman:
> 
> Hi Greg,
> 
> > On Fri, Nov 26, 2021 at 05:15:59PM +0100, Stephan Mueller wrote:
> > > Am Freitag, 26. November 2021, 16:44:17 CET schrieb Greg Kroah-Hartman:
> > > 
> > > Hi Greg,
> > > 
> > > > On Mon, Nov 22, 2021 at 09:59:01AM -0500, Simo Sorce wrote:
> > > > > Jason,
> > > > > have you previously produced a list of reasoned concerns with this
> > > > > patchset and direction?
> > > > > 
> > > > > This specific email is not really useful to me to understand the
> > > > > concerns as it does not contain actionable suggestion or critique.
> > > > > 
> > > > > I personally find the direction fine, and with my distribution hat on
> > > > > I
> > > > > can say that FIPS is essential for us and any design must include an
> > > > > option to be FIPS certifiable.
> > > > > 
> > > > > As NIST keeps improving their testing capabilities and rigorous
> > > > > cryptographic design of the CSPRNGs as well as entropy sources the
> > > > > kernel must also adapt.
> > > > > 
> > > > > Stephan is providing a path forward, and I haven't seen any other
> > > > > proposal, let alone code, that provide improvements in this area.
> > > > > I am pretty sure the design can be improved if there is detailed and
> > > > > actionable feedback on what to change.
> > > > > 
> > > > > I hope the path forward can be one of collaboration rather then mere
> > > > > opposition.
> > > > 
> > > > Replacement of the existing code to cut over to the new one is not
> > > > collaboration, it's the exact opposite.
> > > > 
> > > > Submitting patches to the existing codebase to implement the
> > > > "requirements" is the proper way forward, why has that never been done.
> > > 
> > > It has been attempted by Nikolai Stange without avail - no comments were
> > > received, let alone it was integrated.
> > 
> > Links to the patches and discussion please?
> 
> Please consider https://lkml.org/lkml/2020/9/21/157

That's a load of patches, some of them seem sane, what ever happened to
them?  Seems like the conversation got derailed by people with email
server issues that prevented them from participating in public :(

But that patch set is a nice way to do this, incremental changes working
with the existing codebase, not trying to ignore the current code and
create a separate implementation.

Also, minor note, please use lore.kernel.org links, we don't have any
control over lkml.org, nor can we take patches out of that site with any
of our normal tools.

> One side note: the LRNG patch set does not replace random.c, but provides an 
> additional implementation that can be selected at compile time. I am under the 
> impression that is an equal approach considering other areas of the kernel 
> like file systems, memory allocators, and similar.

Sometimes, yes, it is valid to have different implementations for things
that do different things in the same area (like filesystems), but for a
core function of the kernel, so far the existing random maintainer has
not wanted to have multiple implementations.  Same goes for other parts
of the kernel, it's not specific only to this one very tiny driver.

As a counterpoint, we do not allow duplicate drivers that control the
same hardware types in the tree.  We have tried that in the past and it
was a nightmare to support and maintain and just caused massive user
confusion as well.  One can argue that the random driver is in this same
category.

thanks,

greg k-h
