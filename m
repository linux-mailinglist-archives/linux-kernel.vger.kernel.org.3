Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB584706A4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhLJRGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:06:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229462AbhLJRGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639155759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGaYO1j6h84aCFk04PZZIhKSIuZSnKoPH+dYEmHAADA=;
        b=QwsgAFeySjy5WBRk3v+OznbTG6ORajbxjBNxR+zK6d+Y1PBGF6ZhQGoM4igXkFwIKMlcFC
        alfa+6g1CL0ajs6vpJX8HTL8XGY5QCEIaIPbc5Nswu7bq4SQg0KYzYO3GMfbTa+pKuU8Md
        HOjOWSOOTWtQv9W7WaTX69mxK5wePXE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-17nIJ7xuOQCpkj56rsjFgA-1; Fri, 10 Dec 2021 12:02:38 -0500
X-MC-Unique: 17nIJ7xuOQCpkj56rsjFgA-1
Received: by mail-qt1-f197.google.com with SMTP id s6-20020a05622a018600b002b2d93b9c73so14734741qtw.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=tGaYO1j6h84aCFk04PZZIhKSIuZSnKoPH+dYEmHAADA=;
        b=4aGcPO2t+4a7NYgwRtqRioJwof0tt7z6TZSGnUVm4klUsoA4DVFftWmAURlZ/CSMi1
         RDBnkP7voFhK/Lvmv2zrB0sXhdlCoTsbZIO1QXLj7mz/AwaJ1ALJ7gbElewmZ+rHfmtW
         Ae7X+BXb+i8okT2HbihgRWHZFYS5lKHgC9oPAQhSZ7d8tKvApOlUgQbRv9chagrXl+iH
         4a8CRmPuZrRg+yf/CBoA28fs0b7zYENilcYrFXW2eK5qShYSBFSBoRSx05QcXkttI3vU
         AENZ/0NTbvv9LGCj/6FXKzr7Vehn1jQy2tGbuLYpmyJ69scbahJHb2AQSvMj9pK5hP4U
         GAlg==
X-Gm-Message-State: AOAM532kihNbMRPOJ/J972uEXUofvqNaoMtcJrIB+tlcxfbvnb+P32rB
        DM4Hqn0yTv6uamrFhZYNQ87o9Tx39P1xMuqjBDIqopWMsthjvV2adkkycVUa7qM7thm3OYouWvS
        qHPwAk2bx3b26Ekrr4U7QgNUS
X-Received: by 2002:a05:620a:2796:: with SMTP id g22mr21173699qkp.341.1639155757798;
        Fri, 10 Dec 2021 09:02:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvsCLTF2NSleLLppw0vQIrAiOo8+lEyDbTYy1B/7+erjHGckZQClbN9iNKe/k5JoPTskHbFw==
X-Received: by 2002:a05:620a:2796:: with SMTP id g22mr21173642qkp.341.1639155757502;
        Fri, 10 Dec 2021 09:02:37 -0800 (PST)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id g14sm1514563qko.55.2021.12.10.09.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:02:36 -0800 (PST)
Message-ID: <b806a2a1a42b66f0fa5569b79862fe57277feda4.camel@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
From:   Simo Sorce <simo@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>, Tso Ted <tytso@mit.edu>,
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
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Date:   Fri, 10 Dec 2021 12:02:35 -0500
In-Reply-To: <YbMiXOCibTRXYYCo@kroah.com>
References: <YaYvYdnSaAvS8MAk@kroah.com>
         <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
         <YaZHKHjomEivul6U@kroah.com> <YaZqVxI1C8RByq+w@gmail.com>
         <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
         <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
         <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
         <20211210014337.xmin2lu5rhhe3b3t@valinor> <YbL3wNBFi2vjyvPj@kroah.com>
         <20211210093003.lp6fexzrga3nijxn@valinor> <YbMiXOCibTRXYYCo@kroah.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-12-10 at 10:48 +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 10, 2021 at 06:30:03AM -0300, Marcelo Henrique Cerri wrote:
> > On Fri, Dec 10, 2021 at 07:46:24AM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Dec 09, 2021 at 10:43:37PM -0300, Marcelo Henrique Cerri wrote:
> > > > Hi, Jason. How do you think we could approach that then?
> > > > 
> > > > Are you willing to discuss the FIPS 140-3 requirements that random.c
> > > > doesn't currently meet so we can dive deeper on how we could implement
> > > > them in a way that would improve the kernel other then simply
> > > > providing compliance to FIPS?
> > > 
> > > Discussing things doesn't usually work well.  Let's see some working
> > > patches first, that solve problems that you have with the current random
> > > code, and we can go from there.
> > > 
> > > Again, like any other kernel patch submission, nothing new here at all.
> > 
> > Hi, Greg. I understand your point but we had plenty of patch
> > submissions already from Stephan, Nicolai and others and that didn't
> > work. So I am expecting that anybody taking over as the random.c
> > maintainer can at least provide some direction on that.
> 
> Then submit patches to be reviewed!  This patch series was commented on
> why it is not acceptable, so it's done with for now.
> 
> We can't go back in time and dig up old patch series to be reviewed now
> unless they are actually refreshed and resubmitted.
> 
> Why isn't anyone doing that?

I think people would at least like to know they are not spending a
bunch of time and work to have another patch series go into the void,
or be rejected again, *after* all the hard work is done, without a
foreword of what is acceptable.

> 
> > > > I believe all the distros are interested in making progress on that,
> > > > but without a general guidance it makes very hard for us to
> > > > collaborate and we end up in the current situation in which each
> > > > distro is carrying its own "hack", as Simo mentioned before. Canonical
> > > > is in the same situation as the other distros and we are carrying an
> > > > workaround to wire up the crypto DRBG to random.c in order to archive
> > > > compliance.
> > > 
> > > If everyone seems to think their patches are hacks, and are not worthy
> > > of being submitted, then why do they think that somehow they are viable
> > > for their users that are actually using them?
> > 
> > Because although some people dislike it, FIPS is still a requirement
> > for many users. That's the reality and that will not change just
> > because there are some resistance against it.
> > 
> > The patches that distros are carrying are hacks because they try to
> > minimize risks while keeping the code as close as possible to
> > upstream. But that has several drawbacks, such as performance, limited
> > entropy sources an so on, that to me makes them not suitable for
> > upstream.
> 
> In other words, "the hacks we made to the random code are so bad we do
> not want to submit them upstream for everyone to review as our names
> would be on them and we would have to justify them to the world"?  :)

Our patches are all public in our respective tress, with names and all.
The hacks are not necessarily *bad*, but they are changes made because
we could not put in what we think would be a better solution. They can
definitely be sent upstream.

> Given that there are no patches here to review by anyone, why is this
> email thread still persisting?

There is a will and a need to "improve" things, but given past absence
of feedback, people are trying to understand if there is any point in
trying to submit patches. Patches are work, and people like to know
they are not wasting their time completely before committing many more
hours.

> Again, the only way forward is to submit changes that meet our
> well-documented development process.  There's nothing "special" about
> this very tiny .c file that is any different than the other 30 million
> lines of kernel code we support that warrants a different process at
> all.

This very thread shows that there is an issue, people are not asking
for exceptions to the process, they are only asking for direction from
the maintainer so they can work productively and get some result, that
is all the "special" there is here.

Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




