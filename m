Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01BB50FB68
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349148AbiDZKuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349824AbiDZKt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:49:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354A8E0C0;
        Tue, 26 Apr 2022 03:45:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gh6so11134861ejb.0;
        Tue, 26 Apr 2022 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yT6MeZr7lrp+pl5JuXM90CrfagSL5tvHFlanqgPjJyY=;
        b=Eh6AA+i4KyqffI3eRab/pWanLJ7aZW9oDevFcQw82RRV2PPvtunCBBil6y0k9ESIcu
         SA1DCF4MrUk6nsGxk2OXzp0oQF2Ai+FRR7sDAka3wb/4Vc3v0OLicXbm3+//s2BlQlG0
         VL7F+GIShYom/wVK6kTpH18/FuspHEebkCzPFvjGDRgmpQMkukDIAm0p61iKs3c6Oc83
         thOfmaOrKTsudYzWs2LrTbcF/t1P+Yei6gM+d39nVfXxZaz6lDRh0Y6JSbiGK5p9gD5+
         XAdhGwYjvEdBQ+GeaPN/EOeUWbPV5peKdS2y/+b+qBkV3VX/DKJhGHsrNMJFBpQ/O3y5
         YI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yT6MeZr7lrp+pl5JuXM90CrfagSL5tvHFlanqgPjJyY=;
        b=x07PmAYKw/wwK6Hp473Fx5iCS8fyccZhltbc9pvGN72LK4k8rlLf6F1dTQ3LmzcJb3
         0V4HHWy3B1IjB7uOhwpB0CmKmxvr2NRiJ0lte21sJyMriSBEVofD03Ib+x82s5kX9kRb
         bMJMwfDAS2LruKqg5HW6xYq4Is1uA7Nb8V7GCw6Pp1IQl6M8143Mjygo6BJeL6VpBQvY
         E/IeN8mYoAkl1Lk9g84UzLIFoml2R/H52nWwY/4uWt9VtuyN7vs8OlRZP5zyIYsy2tgi
         7quFcECXBBkcxLdmegcVtSYMlH6DFKynqjOZK4YAffVBw8DizNfDNN9zqBhpVsjAc9cc
         nz5w==
X-Gm-Message-State: AOAM531Cqr/uhf+n2BCfkX/+jQIs6D0X9K8ryFDHrf1o0dmz34Vzukj4
        PNa5bfd+U6LyrQ9oXbL03WM=
X-Google-Smtp-Source: ABdhPJzA5ggTUsN9zCEkiGOvUxl5pVGQ+/cozLKTUfXtLV4X6wR9Kub9ICs5sVUhAX4HWJ/vMNNE4w==
X-Received: by 2002:a17:907:7da2:b0:6f3:a802:d52d with SMTP id oz34-20020a1709077da200b006f3a802d52dmr4684546ejc.706.1650969914613;
        Tue, 26 Apr 2022 03:45:14 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906709000b006f3a8aac0eesm1091139ejk.0.2022.04.26.03.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 03:45:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        outreachy@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/4] Documentation/vm: Rework "Temporary Virtual Mappings" section
Date:   Tue, 26 Apr 2022 12:45:12 +0200
Message-ID: <3610796.MHq7AAxBmi@leap>
In-Reply-To: <YmecctAD9XXYG8CR@linutronix.de>
References: <20220425162400.11334-1-fmdefrancesco@gmail.com> <20220425162400.11334-5-fmdefrancesco@gmail.com> <YmecctAD9XXYG8CR@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=C3=AC 26 aprile 2022 09:17:06 CEST Sebastian Andrzej Siewior wrot=
e:
> On 2022-04-25 18:24:00 [+0200], Fabio M. De Francesco wrote:
> > index e05bf5524174..b09f1f9a81f2 100644
> > --- a/Documentation/vm/highmem.rst
> > +++ b/Documentation/vm/highmem.rst
> > @@ -50,26 +50,77 @@ space when they use mm context tags.
> >  Temporary Virtual Mappings
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > =20
> > -The kernel contains several ways of creating temporary mappings:
> > +The kernel contains several ways of creating temporary mappings. The=20
following
> > +list shows them in order of preference of use.
> > =20
> > -* vmap().  This can be used to make a long duration mapping of=20
multiple
> > -  physical pages into a contiguous virtual space.  It needs global
> > -  synchronization to unmap.
> > +* kmap_local_page().  This function is used to require short term=20
mappings.
> > +  It can be invoked from any context (including interrupts) but the=20
mappings
> > +  can only be used in the context which acquired them.
> > +
> > +  This function should be preferred, where feasible, over all the=20
others.
>=20
> feasible? It should always be used.=20

No, it cannot always be used. Please read again few lines above this that=20
"The mapping can only be used in the context which acquired them". We=20
cannot do blind s/kmap/kmap_local_page/.

> I don't see a reason why using
> kmap_local_page() would not be feasible.

Ditto.

> > -* kmap().  This permits a short duration mapping of a single page.  It=
=20
needs
> > -  global synchronization, but is amortized somewhat.  It is also prone=
=20
to
> > -  deadlocks when using in a nested fashion, and so it is not=20
recommended for
> > -  new code.
> > +  These mappings are per thread, CPU local (i.e., migration from one=20
CPU to
> > +  another is disabled - this is why they are called "local"), but they=
=20
don't
> > +  disable preemption. It's valid to take pagefaults in a local kmap=20
region,
> > +  unless the context in which the local mapping is acquired does not=20
allow
> > +  it for other reasons.
> > +
> > +  kmap_local_page() always returns a valid virtual address and it is=20
assumed
> > +  that kunmap_local() will never fail.
> > +
> > +  If a task holding local kmaps is preempted, the maps are removed on=
=20
context
> > +  switch and restored when the task comes back on the CPU. As the maps=
=20
are
> > +  strictly CPU local, it is guaranteed that the task stays on the CPU=
=20
and
>=20
> Maybe "thread local" instead CPU local? Another thread on the same CPU
> can not use this mapping.
>=20

Hmm, I might add "thread local" to convey that the local mappings should=20
stay in the same context that acquired them.=20

However, kmap_local_page() also disable migration. This is how Thomas=20
Gleixner talks about kmap_local_page() in his patch where it introduced=20
this function:=20

"The kmap_local.*() functions can be invoked from both preemptible and
atomic context. kmap local sections disable migration to keep the resulting
virtual mapping address correct, but disable neither pagefaults nor
preemption.".

Therefore, if it "disable migration" it is "CPU local". I mean that I might=
=20
also add "thread local" but I think (at least at this moment) that I won't=
=20
remove "CPU local".

@Ira: what about this proposal?

> > +  that the CPU cannot be unplugged until the local kmaps are released.
> > +
> > +  Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a=
=20
certain
> > +  extent (up to KMAP_TYPE_NR) but their invocations have to be=20
strictly ordered
> > +  because the map implementation is stack based. See kmap_local_page=20
() kdocs
>                                                                        ^
> > +  (included in the "Functions" section) for details on how to manage=20
nested
> > +  mappings.
>=20
> While they can be nested I wouldn't encourage that.

I'm not encouraging this kinds of usages. I'm only saying that "it is=20
allowed to a certain extent".

> >  * kmap_atomic().  This permits a very short duration mapping of a=20
single
> >    page.  Since the mapping is restricted to the CPU that issued it, it
> >    performs well, but the issuing task is therefore required to stay on=
=20
that
> >    CPU until it has finished, lest some other task displace its=20
mappings.
> > =20
> > -  kmap_atomic() may also be used by interrupt contexts, since it is=20
does not
> > -  sleep and the caller may not sleep until after kunmap_atomic() is=20
called.
> > +  kmap_atomic() may also be used by interrupt contexts, since it does=
=20
not
> > +  sleep and the callers too may not sleep until after kunmap_atomic()=
=20
is
> > +  called.
> > +
> > +  Each call of kmap_atomic() in the kernel creates a non-preemptible=20
section
> > +  and disable pagefaults. This could be a source of unwanted latency,=
=20
so it
> > +  should be only used if it is absolutely required, otherwise=20
kmap_local_page()
> > +  should be used where it is feasible.
>=20
> Please add a note this function is deprecated and must not be used in
> new code.

I have already responded (in my other reply for 1/4) about the possible=20
addition of a notice of deprecation. But, as said, I also need to take into=
=20
account what other people think about it.

However, I agree that, since we have that "deprecated!" in the kdocs of =20
kmap_atomic(), I should be consistent everywhere.

Please let me wait for more reviews before making further changes.

Thanks,

=46abio

>=20
> Sebastian
>=20




