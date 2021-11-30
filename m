Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A0346342A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbhK3M1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhK3M1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:27:46 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE01BC061574;
        Tue, 30 Nov 2021 04:24:27 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h24so15236956pjq.2;
        Tue, 30 Nov 2021 04:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=5WgDImV6rHMtKmWQnOhQ4KAC1ALI9IdBPOj3Sa2yiKk=;
        b=cOkEDc9/kUR+6vRryVjIBFx2VXyWkajRZ7s9V0YejauEgRFbiGjVBjEwHEKsQojUxZ
         voVd6yw3Lb1D4Ier720q3r+wczttifpJYD61/Wq4HfbJjhTQrRTAnP4q/i3tUgssEjQT
         3x60OZ0YjUHrOsxCC4YTC/a4X+L/9gAYKJR0lR4qjJh/veRNsx31VKqMwCZoem+JO509
         s0UFGoFtxfkAMPBtaopZug4zlBf0DUQUFuMU9h0cdlhvl/pWTbThOKfQ+uXwsujFvM0C
         tpTZribKXE6kyDpyVNbKozNW3spB4SLgf462CKODU8q2dJ9+Tv1cTgEmY+0DD4VlRAKi
         jgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=5WgDImV6rHMtKmWQnOhQ4KAC1ALI9IdBPOj3Sa2yiKk=;
        b=LHVE78nOuLlmvYXNYJMyKk9nkXVReQproc7L3TEyigovVsfpA4mVzah00+LV6qa4GK
         wJZmIV+xC3qdhcvJv2OgvUNF6k1QxrQMKrZ+fFaZjxV8Gj6LcX7LvEbur7cfjoV5Ztcn
         u9oqSfw8oPoc8Du/nuhvYkkYgnIcj2BRrXFnbcfHGYkRHHJMyrxHxAS6FFSQfQKCT8gZ
         YekIg/bhHWBdDeHidYTDFPehwg4yyndL1D/g8KExw69/Du9SvH6aiAvTPbGxwNypfEKm
         mcpV0BkcstM45qjyXyybKnLEiN8w0sv7adlE/eLOEDh4aQKcpaWRYAGTqx6W9/BluuNT
         llYA==
X-Gm-Message-State: AOAM53353gdW4nU66BAb0XBxC6P2qvaaT+064NkZf/VxFiKcjQNjqFUs
        lvC/zABVvdpEdOAjbKn/n3LatxhBUEqWsdDL4Qw=
X-Google-Smtp-Source: ABdhPJwuFEBazWnC9hBZfVzu/hrurOmFBj1P6GXb+k8Vn41t34/SXi82nPwgbW3MbljTepMoRtOz1eZzSnF1sF3POSA=
X-Received: by 2002:a17:90b:4f92:: with SMTP id qe18mr5666408pjb.83.1638275067160;
 Tue, 30 Nov 2021 04:24:27 -0800 (PST)
MIME-Version: 1.0
References: <2036923.9o76ZdvQCi@positron.chronox.de> <22137816.pfsBpAd9cS@tauon.chronox.de>
 <YaEJtv4A6SoDFYjc@kroah.com> <9311513.S0ZZtNTvxh@tauon.chronox.de> <YaT+9MueQIa5p8xr@kroah.com>
In-Reply-To: <YaT+9MueQIa5p8xr@kroah.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 30 Nov 2021 07:24:15 -0500
Message-ID: <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 6:07 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> ...
> Sometimes, yes, it is valid to have different implementations for things
> that do different things in the same area (like filesystems), but for a
> core function of the kernel, so far the existing random maintainer has
> not wanted to have multiple implementations.  Same goes for other parts
> of the kernel, it's not specific only to this one very tiny driver.
>
> As a counterpoint, we do not allow duplicate drivers that control the
> same hardware types in the tree.  We have tried that in the past and it
> was a nightmare to support and maintain and just caused massive user
> confusion as well.  One can argue that the random driver is in this same
> category.

I think an argument could be made that they are different drivers
since they have different requirements and security goals. I don't
think it matters where the requirements came from, whether it was ad
hoc from the developer, NIST, KISA, CRYPTREC, NESSIE, or another
organization.

Maybe the problem is with the name of the driver? Perhaps the current
driver should be named random-linux, Stephan's driver should be named
random-nist, and the driver should be wired up based on a user's
selection. That should sidestep the problems associated with the
"duplicate drivers" policy.

Jeff
