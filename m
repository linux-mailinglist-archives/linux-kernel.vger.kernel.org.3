Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5C458770F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiHBGVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiHBGVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:21:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B721162CB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:21:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l4so16568578wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 23:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kSse5FKWL5kgJ+ejLrneA4q2v7qyL79FOUMp7CrCCXs=;
        b=BcjRUF9h+NwxPb28S85WIalzQC2VbdN+D8R/grvLJn86rcmyW+Pht6z84HK+GRJHyW
         Fj/VSfr8Qq9UDP1Amzvd6Av6ynuA5xRB9Cs3MTlz6/wRiP6VChiR5sNpwRHKX7KpOKU4
         vfdGGOEQclsTz7QS+LSeYZhT3MNIkX6Yp+D3c9ldqWqX9sR8YhH5ZA01XcG5M6LEeQph
         X9jSmnbQWcnXwVA54GY3KHHHkQYvDgBnTfDgiDSfnREniDa1fEmmPTZ2kfEZDQA6fI/v
         aAXjoUrmhAJSYk0y1PmX10wLhIzxqOROqRv0vIPzWn9CsDIQg21UbDXztj6DeFQjACEh
         U7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kSse5FKWL5kgJ+ejLrneA4q2v7qyL79FOUMp7CrCCXs=;
        b=cY77GmIN2KsZWvdbf/IhpX8agJVDm1XHh5HFYq/XpEsh4+PhrG6tZJtq2t3LZ0xR5W
         dQGJs+1+O3Qw6ry/p5te7sk166j4x0surqTpe+Yxf8GH5l8NdlBd58F1Y22LgF9+N3K3
         EabsIlrKkqcpjhSi3BZVziwf4LT9amalBr4PG17CIdpFdTtKXc8gbrl13hpjuIG1f1FW
         02AJJxp/pF/tCdL2949zGebOZFvnX6I9I+IfTGz511UhLDv35w8PCqG2p9yenBc7GCgt
         ChohsMWVgAi7S4qeoFNs8RSDqaRSzLI3LbbuUOf03KCDY5oNO1LFRCT7Oa3zNQJxlk3N
         TyBw==
X-Gm-Message-State: ACgBeo2JgYsI9/EWIpUqlpC68Dl/nPW7M7QqE/5Hm2KzXMd2QhxWdu7k
        B5i5+Z9eRyy6P+JQP0OBrTw=
X-Google-Smtp-Source: AA6agR4T3FIeyScX994uVLbWgpN5xhMLL0YKTgi3q9YLQTHazQmN2/yWlyOy9rpBthuuQT0yBTWrAQ==
X-Received: by 2002:a5d:4907:0:b0:21f:bc42:989 with SMTP id x7-20020a5d4907000000b0021fbc420989mr8729711wrq.375.1659421260272;
        Mon, 01 Aug 2022 23:21:00 -0700 (PDT)
Received: from opensuse.localnet (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id a1-20020adfe5c1000000b0021e491fd250sm7768696wrn.89.2022.08.01.23.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 23:20:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] kexec: Replace kmap() with kmap_local_page()
Date:   Tue, 02 Aug 2022 08:20:57 +0200
Message-ID: <1923146.PYKUYFuaPT@opensuse>
In-Reply-To: <YuiUzodsyv3hZAgs@MiWiFi-R3L-srv>
References: <20220707231550.1484-1-fmdefrancesco@gmail.com> <YuiUzodsyv3hZAgs@MiWiFi-R3L-srv>
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

On marted=C3=AC 2 agosto 2022 05:06:54 CEST Baoquan He wrote:
> On 07/08/22 at 01:15am, Fabio M. De Francesco wrote:
> > The use of kmap() and kmap_atomic() are being deprecated in favor of
> > kmap_local_page().
> >=20
> > With kmap_local_page(), the mappings are per thread, CPU local and not
> > globally visible. Furthermore, the mappings can be acquired from any
> > context (including interrupts).
> >=20
> > Therefore, use kmap_local_page() in kexec_core.c because these mappings=
=20
are
> > per thread, CPU local, and not globally visible.
> >=20
> > Tested on a QEMU + KVM 32-bits VM booting a kernel with HIGHMEM64GB
> > enabled.
>=20
> Wondering what arch you tested with.

I'm sorry, I forgot to say that I use x86_32 with 4GB to 6GB RAM.
This is usually an information that I add in the commit messages of all the=
=20
recent conversions I'm working on across the entire kernel.

Another important information (overlooked again this time) is that (1)=20
kmap() comes with an overhead as mapping space is restricted and protected=
=20
by a global lock for synchronization and (2) it also requires global TLB=20
invalidation when the kmap=E2=80=99s pool wraps and it might block when the=
 mapping=20
space is fully utilized until a slot becomes available.

More information about why these kmap() to kmap_local_page() conversions=20
are needed / preferred can be found in the recent changes I made to=20
highmem.rst. They are already in mainline since about two months.

A second round of additional changes has been taken by Andrew M. just few=20
days ago.

My goal is to convert the most of the kmap() call sites that are still left=
=20
across the whole kernel. I'm not yet sure that these kinds of conversions=20
can be done everywhere, especially if the kernel virtual address of the=20
mapping is handed to other contexts, because this would invalidate the=20
pointer returned by kmap_local_page(). =20

> This looks good, but may not benefit much. Say so because I doubt
> how many 32bit systems are using kexec/kdump mechanism.

I really cannot say nothing about how many 32 bits systems are using kexec/
kdump mechanism, however I still think that the conversions are worth=20
everywhere.=20

> Anyway,=20
>=20
> Acked-by: Baoquan He <bhe@redhat.com>
>=20

Thank you so much!

=46abio

> >=20
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >=20
> > v1->v2: A sentence of the commit message contained an error due to a
> > mistake in copy-pasting from a previous patch. Replace "aio.c" with
> > "kexec_core.c".
> >=20
> >  kernel/kexec_core.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 4d34c78334ce..6f98274765d4 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -814,7 +814,7 @@ static int kimage_load_normal_segment(struct kimage=
=20
*image,
> >  		if (result < 0)
> >  			goto out;
> > =20
> > -		ptr =3D kmap(page);
> > +		ptr =3D kmap_local_page(page);
> >  		/* Start with a clear page */
> >  		clear_page(ptr);
> >  		ptr +=3D maddr & ~PAGE_MASK;
> > @@ -827,7 +827,7 @@ static int kimage_load_normal_segment(struct kimage=
=20
*image,
> >  			memcpy(ptr, kbuf, uchunk);
> >  		else
> >  			result =3D copy_from_user(ptr, buf, uchunk);
> > -		kunmap(page);
> > +		kunmap_local(ptr);
> >  		if (result) {
> >  			result =3D -EFAULT;
> >  			goto out;
> > @@ -878,7 +878,7 @@ static int kimage_load_crash_segment(struct kimage=
=20
*image,
> >  			goto out;
> >  		}
> >  		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
> > -		ptr =3D kmap(page);
> > +		ptr =3D kmap_local_page(page);
> >  		ptr +=3D maddr & ~PAGE_MASK;
> >  		mchunk =3D min_t(size_t, mbytes,
> >  				PAGE_SIZE - (maddr & ~PAGE_MASK));
> > @@ -894,7 +894,7 @@ static int kimage_load_crash_segment(struct kimage=
=20
*image,
> >  		else
> >  			result =3D copy_from_user(ptr, buf, uchunk);
> >  		kexec_flush_icache_page(page);
> > -		kunmap(page);
> > +		kunmap_local(ptr);
> >  		arch_kexec_pre_free_pages(page_address(page), 1);
> >  		if (result) {
> >  			result =3D -EFAULT;
> > --=20
> > 2.36.1
> >=20
> >=20
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >=20
>=20
>=20




