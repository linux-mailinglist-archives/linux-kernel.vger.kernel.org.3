Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD450FA11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348652AbiDZKUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348825AbiDZKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:18:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95CB7C797;
        Tue, 26 Apr 2022 02:43:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k23so34897008ejd.3;
        Tue, 26 Apr 2022 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXpWaaRmGnZjQpqeRY15jGRgaTNc7B1+ySXCFXyXBRI=;
        b=pybP3w/+N+OcgwzWtmwntk3lxR6h9mQ391PMJx2VTma/UT4L7sQGvKIgZ25XhHZEwH
         b+xKL6/wkW1eUkxtmMTtIs34tCpl/fZW6F/DVwZzi/X7gza46AZJUovBvXttWt/jiB9l
         IKm1CUAyKOJjyeNJ/N8PUuNGfBdRVn0dSAojBCCfZVlqccAPwPF+aJ3siKwpdNLG4Dsb
         bYy1OTRf9rcQj17LbRxxrAqd5hV5DNuDRq/MSj3xSkDg9G0+VH0ckcqa8iggTlTnMVPn
         kR3JFwfjeknjMqA9nkkNcDLywIPOnuJyHeDmLDTbPsFh2nQDTMXrMXJ4+Nj7Y5BRQJYq
         xARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXpWaaRmGnZjQpqeRY15jGRgaTNc7B1+ySXCFXyXBRI=;
        b=kOi6G92Xwyl7Dd3ozUQ73GUBv2ktCI5aLm4uVEYybT9q+77X5qPuiiZeVj70h2OHNo
         yK58zRITpOyyqrsshp9CC+CmvV3GMx2R3x88fm0d/akY2L0gzYW5BmbQ4BuSuQ1LYlmf
         LQgw3GB9MZU6CgOybC4Nibxjy/mpmI9/FVwL17xtpzCWD+qntUMaltMvdyRpK82SZkNg
         4zkVfmXQXYfazgk8n/cZq5ZmfDh36lWbOFcjorrEeq/NwlHL5xZX2q2XiK82m6O1iCq0
         0bonLXUhTQbjrXebo8NHJ/HxU5LLDUfi19Mn/GjdtUDnVNsRUhPmdOsfgHW7k/kZtFNy
         Xmbw==
X-Gm-Message-State: AOAM533emJl3d7h1w1uonEJrkwVRw7vsweqa6WK4SW/dO8/b30ZGuDSw
        uKuFddB+nqLCiQQ06Jk7b2Y=
X-Google-Smtp-Source: ABdhPJzjhE45gRePoeCjG0ZCGd5Mc7TMOr1O1ulUhWi+DgC4crSwYQkmHDFmKQQ5PqihkhjIduvqHQ==
X-Received: by 2002:a17:906:5d04:b0:6db:7262:570e with SMTP id g4-20020a1709065d0400b006db7262570emr20578793ejt.8.1650966186345;
        Tue, 26 Apr 2022 02:43:06 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906521000b006d58773e992sm4630221ejm.188.2022.04.26.02.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 02:43:05 -0700 (PDT)
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
        outreachy@lists.linux.dev,
        "Acked-by : Mike Rapoport" <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Tue, 26 Apr 2022 11:43:03 +0200
Message-ID: <4396926.LvFx2qVVIh@leap>
In-Reply-To: <YmeYzKT8Ikq5SfdE@linutronix.de>
References: <20220425162400.11334-1-fmdefrancesco@gmail.com> <20220425162400.11334-2-fmdefrancesco@gmail.com> <YmeYzKT8Ikq5SfdE@linutronix.de>
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

On marted=C3=AC 26 aprile 2022 09:01:32 CEST Sebastian Andrzej Siewior wrot=
e:
> On 2022-04-25 18:23:57 [+0200], Fabio M. De Francesco wrote:
> > index a77be5630209..aa22daeed617 100644
> > --- a/include/linux/highmem-internal.h
> > +++ b/include/linux/highmem-internal.h
> > @@ -236,9 +236,17 @@ static inline unsigned long totalhigh_pages(void)=
=20
{ return 0UL; }
> > =20
> >  #endif /* CONFIG_HIGHMEM */
> > =20
> > -/*
> > - * Prevent people trying to call kunmap_atomic() as if it were=20
kunmap()
> > - * kunmap_atomic() should get the return value of kmap_atomic, not the=
=20
page.
> > +/**
> > + * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
> > + * @__addr:       Virtual address to be unmapped
> > + *
> > + * Unmaps an address previously mapped by kmap_atomic() and re-enables
> > + * pagefaults and preemption. Mappings should be unmapped in the=20
reverse
>=20
> You mind adding "Deprecated!" like kmap_atomic() has?=20

I might add "Deprecated!", however Ira Weiny asked me to rephrase an=20
earlier version of one of the patch which is is this series. I wrote that=20
"The use of kmap_atomic() is deprecated in favor of kmap_local_page()." and=
=20
Ira replied "I'm not sure deprecated is the right word. [] This series=20
should end up indicating the desire to stop growing kmap() and
kmap_atomic() call sites and that their deprecation is on the horizon.".

What Ira suggested is exactly what I'm doing in v2.=20

@Ira: what about adding "Deprecated!" for consistency with kmap_atomic()=20
kdoc?

> The part about
> disabling/ enabling preemption is true for !PREEMPT_RT.

To me it looks that this is not what Thomas Gleixner wrote in the cover=20
letter of his series ("[patch V2 00/18] mm/highmem: Preemptible variant of=
=20
kmap_atomic & friends") at=20
https://lore.kernel.org/lkml/20201029221806.189523375@linutronix.de/

=46or your convenience:

"[] there is not a real reason anymore to confine migration disabling to=20
RT. [] Removing the RT dependency from migrate_disable/enable()".

Is there anything I'm still missing?

> The part that
> worries me is that people use it and rely on disabled preemption like
> some did in the past.=20

This is something I'd prefer to hear also from other developers who are=20
CC'ed for this patch :)=20

> I've been told this API is about to be removed (or so I have been told)
> so I hope that it will be gone soon ;)
>=20
> > + * order that they were mapped. See kmap_local_page() for details.
> > + * @__addr can be any address within the mapped page, so there is no=20
need
> > + * to subtract any offset that has been added. In contrast to=20
kunmap(),
> > + * this function takes the address returned from kmap_atomic(), not=20
the
> > + * page passed to it. The compiler will warn you if you pass the page.
> >   */
> >  #define kunmap_atomic(__addr)				=09
\
> >  do {							=09
\
>=20
> Sebastian
>=20

Thanks for your review,

=46abio


