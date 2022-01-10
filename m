Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E1F489F76
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbiAJSow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:44:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50426 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242072AbiAJSoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:44:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAC95B8175A;
        Mon, 10 Jan 2022 18:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72630C36AE9;
        Mon, 10 Jan 2022 18:44:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Av1IVnPG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641840278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GyWLj5/EaUv61VIhefKCE8M8yK1R8B4gDJ2B3ClXFkc=;
        b=Av1IVnPG3akYv8tFAXc/F6rGdEPch6+SuubzrsRRCv/A24k31PwUvFh95VdBBCdy8pzfrL
        tsXt6OzbH0nNOrdnMrS5KKjAI7kWCA2EOg0o8z/jBMjAZHiF4ogWTAbWwCNikzL87IdXSY
        +X2U8qHWBk10hTleUO1qz4DvJMxKM3E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 47a1a059 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 10 Jan 2022 18:44:38 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id v186so31201449ybg.1;
        Mon, 10 Jan 2022 10:44:35 -0800 (PST)
X-Gm-Message-State: AOAM531LyxvH++SNQbZEc07jG8bmW9Rk4FZ+mfDXuExFEuxkY7QYsXC/
        1YHdm7QCFMT6ygA4Psb8N+7ufKmf4HNHTxhSUIA=
X-Google-Smtp-Source: ABdhPJyxOBZvO7ufgXkscYSaL7Xx/j61FicVu+7hLVAxoUXwoLdLSI9k8N3yEn0BKHp6CwQ0etFo0dwakC+SMONxixs=
X-Received: by 2002:a25:8c4:: with SMTP id 187mr1208892ybi.245.1641840274572;
 Mon, 10 Jan 2022 10:44:34 -0800 (PST)
MIME-Version: 1.0
References: <YaZqVxI1C8RByq+w@gmail.com> <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor> <20220110132349.siplwka7yhe2tmwc@valinor>
 <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu> <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu> <Ydx7D3H0PS0Zs9/B@sol.localdomain>
In-Reply-To: <Ydx7D3H0PS0Zs9/B@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 10 Jan 2022 19:44:23 +0100
X-Gmail-Original-Message-ID: <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
Message-ID: <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Simo Sorce <simo@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 4:08 PM Marcelo Henrique Cerri
<marcelo.cerri@canonical.com> wrote:
> > Just to confirm, this little patch here gives you FIPS certification?
> It does

On Mon, Jan 10, 2022 at 7:29 PM Eric Biggers <ebiggers@kernel.org> wrote:
> Now, the idea of certifying the whole kernel as a FIPS cryptographic module is
> stupid

Alright, so if that's the case, then what you ostensibly want is:
a) Some cryptoapi users to use crypto_rng_get_bytes, as they already
do now. (In a private thread with Simo, I pointed out a missing place
and encouraged him to send a patch for that but none has arrived.)
b) Userspace to use some other RNG.

(a) is basically already done.

(b) can be accomplished in userspace by just (i) disabling getrandom()
(making it return ENOSYS), and then (ii) replacing the /dev/urandom
path with a CUSE device or similar.

I suppose (b.i) might be able to be done with some bpf seccomp cgroup
situation. Or, if that's problematic, somebody could propose a
"disable getrandom(2)" cmdline option. That doesn't seem very hard.
And (b.ii) could use combined inputs from /dev/urandom and whatever
FIPSy userspace jitter entropy daemon you have.

In order to prevent the actual security from regressing on this, all
you have to do is ensure that you're always using at least 32 bytes
from the kernel's real /dev/urandom, and then whatever you add on top
of that becomes just for the certification aspect. As your various
green compliance checkboxes change over time and per region, you can
just swap out the extra-paper-pushing-bytes-on-top with whatever the
particular requirements of a certification body are. And you get to do
this all in userspace.

Marcelo/Simo - could you tell me what you find deficient about that
plan? It strikes me that this would give you maximum flexibility and
pretty much accomplish the goals?

Thanks,
Jason
