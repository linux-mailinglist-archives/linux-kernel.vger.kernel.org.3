Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BF050D6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbiDYBp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbiDYBpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:45:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3479318376;
        Sun, 24 Apr 2022 18:42:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id m20so6078206ejj.10;
        Sun, 24 Apr 2022 18:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTJ6Qxg0/5nlhl4vmzwwENt9cVKC/3rOnVT0SS6sQq8=;
        b=ojRneeADSEA6BaRdkds7e2bmYUC3SHr7OdeuP5+peMeTy7BzRWFy7cV/iP0AQ2xmgn
         GCWU+YYQ1VveAa0FuwptEhwXmXnwjzmSKGq9edDrUSFtvU51ry96KlJc9teKpSPIqSST
         JV0uRK1FqUDr4UfWSY/khySEL0S7fvSQeQyQUcveIH/vM6x/zOJsxJEXkJ4gYiVTNkxG
         wi/ra+CWADO6GzFjrg/JcjiWukGf8LWpiUtddehDLsICJAtaEI6bDd+J1gsuIUOmIKvO
         SPYE+Z9TSI+XHrrwSSrraZ6izy1Mg/WlWuz5SvEwWyjgibvxUcOdpt+miU337Nl1p56l
         u06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTJ6Qxg0/5nlhl4vmzwwENt9cVKC/3rOnVT0SS6sQq8=;
        b=r5EdlsjF38ApWmY413nTyOhBB1q2Z9F2CyEnLI702772GokzOyzf4lt2Oe9GPc4BVb
         tngsp4i0jNV5k87jyRMet22rvybJnNMgLu6lz9DuobAs6kILLW7tvna2m50yX7GbOXCO
         2YAX3gV8ejQG5ghQa+D19H0SfAYWuREhTJhQKA4cLYfVTk64ezvvBarr+iubtDZE+Mqr
         WXfXWBqfuqnmLCfsFry/2hTKh+sFXm3i0EpI5DaPH1wB0WIfl4W3H5eoyL3HQL8W+qaA
         TpCXZaRR/+cp0rKws3wvKf+m2MYGdk/xY+shlTrzmzZ1v2QYf2FVxqubuA0Qgkmri+6i
         uSvA==
X-Gm-Message-State: AOAM530oCOPD15dk7YXEy54bSxMHs5HniBeDYIJ+tAvFw/B4/Tt9g8pF
        C7qcd9mGP4Had63ZcETsmeo=
X-Google-Smtp-Source: ABdhPJyW6ejxpIcVkrz2DMuzy3Wuo9OnaIIVvsenfZWbUz1jmyfO6SmbtEXkhO8OpbWQeLaqUnQKYg==
X-Received: by 2002:a17:906:19c6:b0:6ce:98a4:5ee6 with SMTP id h6-20020a17090619c600b006ce98a45ee6mr14227755ejd.567.1650850970699;
        Sun, 24 Apr 2022 18:42:50 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00422eedf16b4sm3918641edz.60.2022.04.24.18.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 18:42:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/4] Documentation/vm: Rework "Temporary Virtual Mappings"
Date:   Mon, 25 Apr 2022 03:42:46 +0200
Message-ID: <1894872.PYKUYFuaPT@leap>
In-Reply-To: <YmXyhH7wAJo274WB@iweiny-desk3>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com> <20220421180200.16901-5-fmdefrancesco@gmail.com> <YmXyhH7wAJo274WB@iweiny-desk3>
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

On luned=C3=AC 25 aprile 2022 02:59:48 CEST Ira Weiny wrote:
> On Thu, Apr 21, 2022 at 08:02:00PM +0200, Fabio M. De Francesco wrote:
> > Extend and rework the "Temporary Virtual Mappings" section of the=20
highmem.rst
> > documentation.
> >=20
> > Despite the local kmaps were introduced by Thomas Gleixner in October=20
2020,
> > documentation was still missing information about them. These additions=
=20
rely
> > largely on Gleixner's patches, Jonathan Corbet's LWN articles, comments=
=20
by
> > Ira Weiny and Matthew Wilcox, and in-code comments from
> > ./include/linux/highmem.h.
> >=20
> > 1) Add a paragraph to document kmap_local_page().
> > 2) Reorder the list of functions by decreasing order of preference of
> > use.
> > 3) Rework part of the kmap() entry in list.
> >=20
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  Documentation/vm/highmem.rst | 71 ++++++++++++++++++++++++++++++------
> >  1 file changed, 60 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/
highmem.rst
> > index e05bf5524174..960f61e7a552 100644
> > --- a/Documentation/vm/highmem.rst
> > +++ b/Documentation/vm/highmem.rst
> > @@ -50,26 +50,75 @@ space when they use mm context tags.
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
> > =20
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
> > +  It is assumed that kmap_local_page() always returns the virtual=20
address
>=20
> kmap_local_page() does return a kernel virtual address.  Why 'assume'=20
this?
>=20
> Do you mean it returns an address in the direct map?
>=20
> > +  of the mapping, therefore they won't ever fail.
>=20
> I don't think that returning a virtual address has anything to do with=20
the
> assumption they will not fail.
>=20
> Why do you say this?

Oh, sorry! I didn't mean to say this. What I wrote is _not_ what I meant.=20
My intention was to say the same that you may read below about=20
k[un]map_atomic().

This sentence should have been:

+ It always returns a valid virtual address. It is assumed that
+ k[un]map_local() won't ever fail.

Is this rewording correct?

It's not my first time I make these kinds of silly mistakes when copy-
pasting lines and then rework or merge with other text that was already=20
there. Recently I've made a couple of these kinds of mistakes.

I'd better read twice (maybe thrice) what I write before sending :(

>=20
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
> > +  that the CPU cannot be unplugged until the local kmaps are released.
> > +
> > +  Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a=
=20
certain
> > +  extent (up to KMAP_TYPE_NR) but their invocations have to be=20
strictly ordered
> > +  because the map implementation is stack based.
>=20
> I think I would reference the kmap_local_page()

I suppose you are talking about the kdocs comments in code. If so, please=20
remember that the kmap_local_page() kdocs have already been included in =20
highmem.rst.

Am I misunderstanding what you write?

> for more details on the
> ordering because there have been some conversions I've done which were
> complicated by this.
>=20
> > =20
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
> > =20
> > -  It may be assumed that k[un]map_atomic() won't fail.
> > +  It is assumed that k[un]map_atomic() won't fail.
> > +
> > +* kmap().  This should be used to make short duration mapping of a=20
single
> > +  page with no restrictions on preemption or migration. It comes with=
=20
an
> > +  overhead as mapping space is restricted and protected by a global=20
lock
> > +  for synchronization. When mapping is no more needed, the address=20
that
>                                          ^^^^^^^^
> 					 no longer

Yes, correct. I'll fix it.

> > +  the page was mapped to must be released with kunmap().
> > +
> > +  Mapping changes must be propagated across all the CPUs. kmap() also
> > +  requires global TLB invalidation when the kmap's pool wraps and it=20
might
> > +  block when the mapping space is fully utilized until a slot becomes
> > +  available. Therefore, kmap() is only callable from preemptible=20
context.
> > +
> > +  All the above work is necessary if a mapping must last for a=20
relatively
> > +  long time but the bulk of high-memory mappings in the kernel are
> > +  short-lived and only used in one place. This means that the cost of
> > +  kmap() is mostly wasted in such cases. kmap() was not intended for=20
long
> > +  term mappings but it has morphed in that direction and its use is
> > +  strongly discouraged in newer code and the set of the preceding=20
functions
> > +  should be preferred.
>=20
> Nice!

Now that I have your reviews for all the four patches of this series I'll=20
send next version on Monday.

Thanks you so much,

=46abio

>=20
> Ira
>=20
> > +
> > +  On 64-bit systems, calls to kmap_local_page(), kmap_atomic() and=20
kmap() have
> > +  no real work to do because a 64-bit address space is more than=20
sufficient to
> > +  address all the physical memory whose pages are permanently mapped.
> > +
> > +* vmap().  This can be used to make a long duration mapping of=20
multiple
> > +  physical pages into a contiguous virtual space.  It needs global
> > +  synchronization to unmap.
> > =20
> > =20
> >  Cost of Temporary Mappings
> > --=20
> > 2.34.1
> >=20
>=20




