Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C22584238
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiG1Owy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiG1Oww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:52:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDCC5E320;
        Thu, 28 Jul 2022 07:52:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b6so1082689wmq.5;
        Thu, 28 Jul 2022 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LeWUujqUUuiOXJGzjNUETMmb8nohrj2ZZRb1epQbHFk=;
        b=moPHxaWXP3cr7Si6/x+QRMQbL6jeZTgh0WL8q+R3F86u3P098i6+0rFsoV0tqigSnQ
         zH/f0FnGyWQQ8div8AovHJ9+SJWIqvzwJuiYugZs53e+H2K4E2QAsRVul7O/IBvE0m8N
         +Fway6zrPNVG+LHr+fLr+7fujrggd7hLzXI2hSVljE3WeFNfEXTwNabYKIVUGNsQsVw7
         w4q7DB4WuBkzXJX1GfLKyZdQjv+SPottmch25I+47q8lIUadGf3PU265/iNLZRam7Uq6
         vO9pNjaCQpzfrxKK7UbDV0kBUPVZisvS6i7dPW/hyEep20OPhVE0ROU1jKBMrsRMDevn
         Gqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LeWUujqUUuiOXJGzjNUETMmb8nohrj2ZZRb1epQbHFk=;
        b=HrHu8uSEna8TeVwS+3VRqWsoicDc1NsjSMTvqiXf7OsSnxLo5YZnme+kCTfSL5y8mE
         JHwLsNFChA0yTXaDMZn3nIv6soBydkntajReht1XLrDfYL92tD8nxM+llS/sQGO+8D3d
         Y7siuuW6b6qqWjgZ4Etcw0QNwKKpaymhle3ycP9Ku5PN2WGDpiwhvWc+7VrAQB/WOatg
         JqocZmCqtVWdaRnw/HzbYM1gjXp1IuUqYy4zOLY4hvYPoQ2xx4Jt7X2krBLOWFYDVRTs
         vK07tANHSfVoN8a9c2yNuDJ32spu/IU68vJojkmHPptML2agAbh+PsO0waqL3dUJYLvP
         r6MQ==
X-Gm-Message-State: AJIora+pMJ4cqV/iJBqHZBfCn3y2JP/G8H6KJztBqBYztO74qQr1p8Gu
        oIVd6kISmdepe9YXZQ1ZuQA=
X-Google-Smtp-Source: AGRyM1tDgKjTqzIVR9eANcLwwwOjNs5YN+u0THQUFjYz7G8PROY+O+6EjLMN8+fA0mjwP+9QiKAnGg==
X-Received: by 2002:a05:600c:21d7:b0:3a3:2088:bbc6 with SMTP id x23-20020a05600c21d700b003a32088bbc6mr6768686wmj.68.1659019969612;
        Thu, 28 Jul 2022 07:52:49 -0700 (PDT)
Received: from opensuse.localnet (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id p6-20020a1c5446000000b003a2f96935c0sm6840625wmi.9.2022.07.28.07.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 07:52:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/7] Documentation/mm: Don't kmap*() pages which can't come from HIGHMEM
Date:   Thu, 28 Jul 2022 16:52:45 +0200
Message-ID: <7426546.EvYhyI6sBW@opensuse>
In-Reply-To: <87czdykw4j.fsf@meer.lwn.net>
References: <20220721210206.13774-1-fmdefrancesco@gmail.com> <20220721210206.13774-4-fmdefrancesco@gmail.com> <87czdykw4j.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=C3=AC 21 luglio 2022 23:13:00 CEST Jonathan Corbet wrote:
> "Fabio M. De Francesco" <fmdefrancesco@gmail.com> writes:
>=20
> > There is no need to kmap*() pages which are guaranteed to come from
> > ZONE_NORMAL (or lower). Linux has currently several call sites of
> > kmap{,_atomic,_local_page}() on pages allocated, for instance, with
> > alloc_page(GFP_NOFS) and other similar allocations.
> >
> > Therefore, add a paragraph to highmem.rst, to explain better that a
> > plain page_address() should be used for getting the address of pages
> > which cannot come from ZONE_HIGHMEM.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  Documentation/vm/highmem.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/
highmem.rst
> > index c9887f241c6c..f266354c82ab 100644
> > --- a/Documentation/vm/highmem.rst
> > +++ b/Documentation/vm/highmem.rst
> > @@ -71,6 +71,12 @@ list shows them in order of preference of use.
> >    kmap_local_page() always returns a valid virtual address and it is=20
assumed
> >    that kunmap_local() will never fail.
> > =20
> > +  On CONFIG_HIGHMEM=3Dn kernels and for low memory pages this returns=
=20
the
> > +  virtual address of the direct mapping. Only real highmem pages are
> > +  temporarily mapped. Therefore, users should instead call a plain
> > +  page_address() for getting the address of memory pages which,=20
depending
> > +  on the GFP_* flags, cannot come from ZONE_HIGHMEM.
> > +
>=20
> Is this good advice?

Well... yes and no :-)=20

However yours is a legit objection.=20

I'm taking most of the suggestion from Ira (from an email in this same=20
thread) and send the v2 of this series.

My intention was to avoid things like those I encountered when converting=20
fs/btrfs:

page =3D alloc_page(GFP_NOFS);
kaddr =3D kmap(page);

Why one should kmap*() pages allocated one or two lines above with=20
GFP_NOFS?=20

=46urthermore, since nesting kmap_local_page() / kunmap_local() is last in=
=20
first out (LIFO), I had several problems with several un-mappings until=20
David Sterba made me notice that GFP_NOFS is not OR'ed with __GFP_HIGHMEM=20
and suggested to use plain page_address() instead of those unnecessary=20
mappings.

However, you are right about the fact that, with most of other allocations,=
=20
it is not so clear where and how pages are being allocated.

Thanks,

=46abio=20

> First, it requires developers to worry about
> whether their pages might be in highmem, which is kind of like worrying
> about having coins in your pocket in case you need a payphone.  But it
> would also run afoul of other semantics for kmap*(), such as PKS, should
> that ever be merged:
>=20
>   https://lwn.net/Articles/894531/
>
> Thanks,
>=20
> jon
>=20




