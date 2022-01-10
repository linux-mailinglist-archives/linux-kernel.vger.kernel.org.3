Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F87F48A04B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243706AbiAJTlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243685AbiAJTli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641843697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBMBe4dO3nSB0U6CFk7w2nP+S3gF44je8ioEtuONEO0=;
        b=dsaddWyW9r26y/WAh/NN/VOD7cra0ig+6Nij+1n7a6Uz5EHmhAMh+wInRjDEf0K2bV7GsV
        bI+B0izs29tjU40IsbLCdsEnKamT678TbHqKUBwMw1SasrTnK9vmEBVWqPN3H4gqMzD7pw
        QIF+7/nvuWMehnVNYB+XwM6Um4q57Gs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-2z2QfAICMZGTstJDCbHtXA-1; Mon, 10 Jan 2022 14:41:36 -0500
X-MC-Unique: 2z2QfAICMZGTstJDCbHtXA-1
Received: by mail-qv1-f69.google.com with SMTP id 5-20020a05621420a500b00418562c923bso1682919qvd.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=cBMBe4dO3nSB0U6CFk7w2nP+S3gF44je8ioEtuONEO0=;
        b=A5/0yTC3cwAtwG/JP0sgNb4dt+lJH/wVVfTUGeiwqRacZS2a3BUXKIfqu0tX/ROIUg
         l+2JiQJu2ykbrnh5ZLWtNl4CcdRpdZQbsSzfQTxCpJmjIlpFOycbwY/vz3q9aG2D+BB1
         W/oQpDbAR8bsREpB0foMBJQprKmBf+QVOleMup0hmEOdnnyuFhw6PhciiF/p9R3QCaxN
         81Tn3F06wu8UgvjRRgNNgZyBx70XxG7hOCH2KHrJgohFigMPUceDa+HAa2XwL/3AsTZy
         mSIrV8BCYc237fOtyBnraWFsg5OyQIhoFG5pxEZu/uAr2ZG8Kd0XWGSRS07VE/gW0+3N
         xujQ==
X-Gm-Message-State: AOAM530+7PrJ6NGLA3FIabbtUb9fE0Dq74eylNY9cw3ofFbzhFtedDd4
        P40wjrMJ7bJ1zrUg+2d+bJZPwb2yZ/jzUJEYNP1Yv8c3/R7trhKr8jBXMl1ZQNBFl351Bmpx3Uh
        pZ5TwRkWuMRtcIcMil70svucP
X-Received: by 2002:a05:622a:49:: with SMTP id y9mr1097767qtw.647.1641843695537;
        Mon, 10 Jan 2022 11:41:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcWiY5G1FVUMTQxu0P+OADGVn+crDsTX92wmng6dtru+mvd6ypr9sgJrt3hXVwdBb2+aXKEw==
X-Received: by 2002:a05:622a:49:: with SMTP id y9mr1097751qtw.647.1641843695259;
        Mon, 10 Jan 2022 11:41:35 -0800 (PST)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id f11sm1639365qtk.28.2022.01.10.11.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 11:41:34 -0800 (PST)
Message-ID: <cdfd8173b1b343413b054957dc2984c27587495c.camel@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
From:   Simo Sorce <simo@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Date:   Mon, 10 Jan 2022 14:41:33 -0500
In-Reply-To: <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
References: <YaZqVxI1C8RByq+w@gmail.com>
         <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
         <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
         <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
         <20211210014337.xmin2lu5rhhe3b3t@valinor>
         <20220110132349.siplwka7yhe2tmwc@valinor>
         <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
         <YdxCsI3atPILABYe@mit.edu>
         <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
         <Ydxu+KS5UkQ6hU9R@mit.edu> <Ydx7D3H0PS0Zs9/B@sol.localdomain>
         <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-10 at 19:44 +0100, Jason A. Donenfeld wrote:
> On Mon, Jan 10, 2022 at 4:08 PM Marcelo Henrique Cerri
> <marcelo.cerri@canonical.com> wrote:
> > > Just to confirm, this little patch here gives you FIPS certification?
> > It does
> 
> On Mon, Jan 10, 2022 at 7:29 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > Now, the idea of certifying the whole kernel as a FIPS cryptographic module is
> > stupid

Not that it is not the whole kernel, but a "module boundary" is drawn
around the crypto API and vicinity.
It would be really nice if this whole "boundary" could be built as a
single binary module to be loaded in the kernel in fips mode. That way
we could update the rest of the kernel w/o rebuilding the module, but
we are not there.

Rebuilding the kernel does technically invalidate certification however
NIST themselves tells people to care first about the security of the
systems as long as the vendor is undergoing or promising certification
of the patched kernel.

There is an assumption of good faith.

> Alright, so if that's the case, then what you ostensibly want is:
> a) Some cryptoapi users to use crypto_rng_get_bytes, as they already
> do now. (In a private thread with Simo, I pointed out a missing place
> and encouraged him to send a patch for that but none has arrived.)

I noted your point, just haven' had time to act on it.

> b) Userspace to use some other RNG.
> 
> (a) is basically already done.
> 
> (b) can be accomplished in userspace by just (i) disabling getrandom()
> (making it return ENOSYS), and then (ii) replacing the /dev/urandom
> path with a CUSE device or similar.

While this is technically possible it is not very helpful, as it
requires downstream patching of userspace programs, most of which do
not have either runtime nor compile time switches to change the used
random device.

> I suppose (b.i) might be able to be done with some bpf seccomp cgroup
> situation. Or, if that's problematic, somebody could propose a
> "disable getrandom(2)" cmdline option. That doesn't seem very hard.
> And (b.ii) could use combined inputs from /dev/urandom and whatever
> FIPSy userspace jitter entropy daemon you have.

It is simply easier to just patch /dev/[u]random/getrandom() to use a
certified DRBG in FIPS mode, although we also considered all the
options you mentioned we couldn't really find a good reason to add 
more work, and make a more complicated solution when it is simple to
wire up the correct DRBG to the random device userspace applications
use and is the de facto standard API for obtaining good random numbers.

> In order to prevent the actual security from regressing on this, all
> you have to do is ensure that you're always using at least 32 bytes
> from the kernel's real /dev/urandom, and then whatever you add on top
> of that becomes just for the certification aspect. As your various
> green compliance checkboxes change over time and per region, you can
> just swap out the extra-paper-pushing-bytes-on-top with whatever the
> particular requirements of a certification body are. And you get to do
> this all in userspace.

You can do the whole jitterbug in userspace, but that is simply not
efficient and too disruptive (the above patching of all downstream
usage).

> 
> Marcelo/Simo - could you tell me what you find deficient about that
> plan? It strikes me that this would give you maximum flexibility and
> pretty much accomplish the goals?

My goal is to deviate as little as possible both in kernel and user-
space from what upstreams do. Creating new interfaces is easy, making 
people use them is almost impossible. Witness the process in getting
people to use getrandom() 


Let me also add that NIST requirements are not capricious, they are
written by people that study entropy sources and random generation as
their job and know what they are doing, I err on the side of giving
them credit. The requirements set by the various 90A/90B/90C documents
are about raising the bar, to guarantee that random number generators
are actually "certifiably" good. There are entropy assessment performed
by the labs as part of the certification process to insure the random
source is a good source and does produce output that passes randomness
tests.  I personally think the kernel would benefit from implementing
those "checkboxes", it is basically like implementing a sane CI/CD and
testing environment.

To answer to Ted,
every certification program necessarily requires a certain amount of
bureaucracy, especially when governments are involved, but that doesn't
mean that it's all security theater.

The FIPS certification process has changed over the years as well not
just the requirements. Until a few years ago the requirement to use
FIPS certified cryptography could be waived, and because very few
consumer programs were certified a lot of agencies considered it just a
burden and didn't care much. That has changed, it is now required as a
matter of law for most government agencies, and the waiver process has
been discontinued. So we really need to provide FIPS certification to
our public sector customers, moreover various other security standards
now reference FIPS standards, so it is extending beyond government
agencies and their contractors.

FIPS is painful for us undergoing certification, but as a program it
also does have positive effects. We scrutinize all cryptographic
modules a lot more than we used to, we have a lot more testing than we
used to and a lot more confidence in the solidity of the provided
cryptography in the Linux world also thanks to this scrutiny. I wish
the certification process was less painful for sure, but I believe it
does add value when done sensibly.

Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




