Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5809D48B2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243278AbiAKRLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243128AbiAKRLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:11:00 -0500
Received: from cavan.codon.org.uk (cavan.codon.org.uk [IPv6:2a00:1098:84:22e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C05AC06173F;
        Tue, 11 Jan 2022 09:11:00 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 0C042424F9; Tue, 11 Jan 2022 17:10:59 +0000 (GMT)
Date:   Tue, 11 Jan 2022 17:10:59 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     "Alexander E. Patrakov" <patrakov@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Simo Sorce <simo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <20220111171059.GA10674@srcf.ucam.org>
References: <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu>
 <Ydx7D3H0PS0Zs9/B@sol.localdomain>
 <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
 <YdyNxJzdBmSSEtDC@mit.edu>
 <CAHmME9rmWBA02SyeFiiGZ8=kydYJSJwcYPscBrTBzoXMEPH9sQ@mail.gmail.com>
 <e6fac6ab-07eb-4d8c-9206-bacf6660a7cf@www.fastmail.com>
 <Ydz1F/AqB1oO/qHF@mit.edu>
 <20220111041349.GA5542@srcf.ucam.org>
 <CAN_LGv0CTDi9k=t=TGHvaHZz5YVT+OUEBaRXjP=Xv=kousHY1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN_LGv0CTDi9k=t=TGHvaHZz5YVT+OUEBaRXjP=Xv=kousHY1w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 02:57:54PM +0500, Alexander E. Patrakov wrote:

> LD_PRELOAD is not a solution because of containers and statically-linked
> binaries.

No, it doesn't solve all problems, but the question is whether it needs 
to. We're talking about the scenario where:

a) a customer requires FIPS compliance, and
b) the customer has an app that calls getrandom() and doesn't fallback, 
and
c) they're doing so with statically linked binaries or container 
infrastructure that doesn't allow injection of other libraries

How common is this? Does the kernel need to solve this scenario?
