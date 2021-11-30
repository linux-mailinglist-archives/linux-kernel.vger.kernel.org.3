Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37F3463600
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbhK3OHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:07:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52428 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhK3OHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:07:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC117B819DB;
        Tue, 30 Nov 2021 14:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E5EC53FC7;
        Tue, 30 Nov 2021 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638281060;
        bh=oe3XkB16a3Gybt5hvrU9tgXLxmdReINcDIDKTusZFQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUyZEdxmRylx/iHwE2zDwhUbhYYHSLCBl5fbYke1/XzM21j5dW9i9b/U6/LcdDep3
         drUbh/Q1YzLidZGo2wsybKPto+Pl21X2zLhF7QXMvmESY1iuE6+z5n+I3hsrMQx3mZ
         0PDjliQcReXkSWUYmq6JOU8NF6M7n/ep36Or8g7c=
Date:   Tue, 30 Nov 2021 15:04:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Stephan Mueller <smueller@chronox.de>,
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
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <YaYvYdnSaAvS8MAk@kroah.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
 <22137816.pfsBpAd9cS@tauon.chronox.de>
 <YaEJtv4A6SoDFYjc@kroah.com>
 <9311513.S0ZZtNTvxh@tauon.chronox.de>
 <YaT+9MueQIa5p8xr@kroah.com>
 <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 07:24:15AM -0500, Jeffrey Walton wrote:
> On Mon, Nov 29, 2021 at 6:07 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > ...
> > Sometimes, yes, it is valid to have different implementations for things
> > that do different things in the same area (like filesystems), but for a
> > core function of the kernel, so far the existing random maintainer has
> > not wanted to have multiple implementations.  Same goes for other parts
> > of the kernel, it's not specific only to this one very tiny driver.
> >
> > As a counterpoint, we do not allow duplicate drivers that control the
> > same hardware types in the tree.  We have tried that in the past and it
> > was a nightmare to support and maintain and just caused massive user
> > confusion as well.  One can argue that the random driver is in this same
> > category.
> 
> I think an argument could be made that they are different drivers
> since they have different requirements and security goals. I don't
> think it matters where the requirements came from, whether it was ad
> hoc from the developer, NIST, KISA, CRYPTREC, NESSIE, or another
> organization.
> 
> Maybe the problem is with the name of the driver? Perhaps the current
> driver should be named random-linux, Stephan's driver should be named
> random-nist, and the driver should be wired up based on a user's
> selection. That should sidestep the problems associated with the
> "duplicate drivers" policy.

The "problem" here is that the drivers/char/random.c file has three users,
the userspace /dev/random and syscall api, the in-kernel "here's some
entropy for the random core to use" api, and the in-kernel "give me some
random data" api.

Odds are, you REALLY do not want the in-kernel calls to be pulling from
the "random-government-crippled-specification" implementation, right?

Again, just try evolving the existing code to meet the needs that you
all have, stop trying to do wholesale reimplementations.  Those never
succeed, and it's pretty obvious that no one wants a "plugin a random
random driver" interface, right?

thanks,

greg k-h
