Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F6758174F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbiGZQWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbiGZQV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:21:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494E32B631
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:21:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fy29so26993120ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wccH4xwr05h93IVuQ3GoAwjGPXfqL+WRIMDOQwCF8gM=;
        b=QwsS4/9rfZJ1e/jTXpFegguoxPntmNbZmXmzEB/kyL6jqGpORB697fFASlBKn+/LUc
         NTeguu10GJTQdz513oYHfieJpAzJgcvQ+nAC5bFKJlA/DNU8i5sb0j+wu7r1ve/euPny
         2mJnA6ufG0ni+DMKgLf4FwgCtsdkZ5QE5awAWtmL2B3V3Je1mrlxAF0zMSq8RuobSXru
         8oHjRSQeHoBkuebiwPCu4T2uhbwZcAImYZtcDdmstiObrr9ZwihWfgEqpNkSQztGwHH+
         HHTIbwRpxzI9F0aHC1oAgeZD2JWecVItZB2OK1ENjl/AijMefhlokH6x/QxeAhr6yd6d
         5OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wccH4xwr05h93IVuQ3GoAwjGPXfqL+WRIMDOQwCF8gM=;
        b=wrk5gG8PcOYYfFMl6l9dxhHj/ZzNUh5A1BxSE1j6/cC9oiD/iwA94nYqPxn5EktMqx
         0oWzqeFPdIa91/YTd27jtoEzQnMrfBwgrhv8YVCDoyM8qidlBDLNnTNMAsyTlya6o3/G
         +pgrd5axoPUtPqKF4tHSr1mjguZY2wqTenYLsQMZEV7bZaZsTNMPQMtNCx4SGATvVnTD
         JVRbAItAgcMVI2p9rNYmciUPSWG6s1YjcEZYNNjgF8VrY4MdZDlhFhCXLOAAM36I4z5c
         pCbsnX0lngUsqlxzVJc9BFaBKB4jgVfpozbe+Ggfw2d/dsHZTmuCnL1pLWLA/jngmKbn
         4Xwg==
X-Gm-Message-State: AJIora+N0uXKFUUlXDGCGCrnhG8Z8vSOVtrEju7iagD1IVgR+KAvTeyS
        YyIu0Ilp42ZX/6Yo2ut9Syo=
X-Google-Smtp-Source: AGRyM1uc5pNTL2QlDDKSjdiIDJBjI9sRl53yqrUC7P0ytlMIbrNWIkuIiNOngYELHwzsmkCAWLf1Lg==
X-Received: by 2002:a17:906:9b95:b0:72f:c504:45e with SMTP id dd21-20020a1709069b9500b0072fc504045emr13627813ejc.345.1658852511536;
        Tue, 26 Jul 2022 09:21:51 -0700 (PDT)
Received: from opensuse.localnet (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id gu7-20020a170906f28700b0072fdb26bd97sm2241980ejb.174.2022.07.26.09.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 09:21:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH] fs/isofs: Replace kmap() with kmap_local_page()
Date:   Tue, 26 Jul 2022 18:21:49 +0200
Message-ID: <2872796.VdNmn5OnKV@opensuse>
In-Reply-To: <20220726145024.rryvw7ot7j2c6tqv@quack3>
References: <20220725162331.9825-1-fmdefrancesco@gmail.com> <20220726145024.rryvw7ot7j2c6tqv@quack3>
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

On marted=C3=AC 26 luglio 2022 16:50:24 CEST Jan Kara wrote:
> On Mon 25-07-22 18:23:31, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page().
> >=20
> > There are two main problems with kmap(): (1) It comes with an overhead=
=20
as
> > mapping space is restricted and protected by a global lock for
> > synchronization and (2) it also requires global TLB invalidation when=20
the
> > kmap=E2=80=99s pool wraps and it might block when the mapping space is =
fully
> > utilized until a slot becomes available.
> >=20
> > With kmap_local_page() the mappings are per thread, CPU local, can take
> > page faults, and can be called from any context (including interrupts).
> > Tasks can be preempted and, when scheduled to run again, the kernel
> > virtual addresses are restored and still valid. It is faster than=20
kmap()
> > in kernels with HIGHMEM enabled.
> >=20
> > Since kmap_local_page() can be safely used in compress.c, it should be
> > called everywhere instead of kmap().
> >=20
> > Therefore, replace kmap() with kmap_local_page() in compress.c. Where=20
it
> > is needed, use memzero_page() instead of open coding kmap_local_page()
> > plus memset() to fill the pages with zeros. Delete the redundant
> > flush_dcache_page() in the two call sites of memzero_page().
> >=20
> > This is an RFC because these changes have not been tested (tests are
> > welcome!), therefore I'm not entirely sure whether these conversions=20
work
> > properly. I'd like to hear comments from more experienced developers
> > before sending a real patch. Suggestions about how to run tests would
> > also be much appreciated.
> >=20
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>=20
> What you propose makes sense to me. But the lack of testing is=20
troublesome.
> You can always at least test your patch without highmem on isofs image=20
with
> compression (mkisofs seems to support creating such filesystems).

I understand your concerns about the lack of testing. I'll find a way to do=
=20
those tests on a QEMU/KVM x86_32 VM with a kernel with HIGHMEM64GB enabled.=
=20
(this is what I did for other filesystem, Btrfs to start with).

I have no experience with this particular fs and saw that xfstests have no=
=20
special tests for isofs. However, you are talking about using mkisofs and I=
=20
suppose it will be enough for this purpose.

> Even that
> would detect a bug in your patch ;) - see below.
>=20
> > diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> > index 95a19f25d61c..a1562124bb91 100644
> > --- a/fs/isofs/compress.c
> > +++ b/fs/isofs/compress.c
> > @@ -120,8 +119,7 @@ static loff_t zisofs_uncompress_block(struct inode=
=20
*inode, loff_t block_start,
> >  	       zerr !=3D Z_STREAM_END) {
> >  		if (!stream.avail_out) {
> >  			if (pages[curpage]) {
> > -				stream.next_out =3D=20
page_address(pages[curpage])
> > -						+ poffset;
> > +				stream.next_out =3D=20
kmap_local_page(pages[curpage] + poffset);
>=20
> This is wrong. Most importantly because you need to add 'poffset' to the
> final address provided by kmap_local_page(), not to the struct page=20
pointer.

Sorry, this is only a typo.

I've already made dozens of conversions to kmap_local_page(), so I know=20
that I should add the offset to the kernel virtual address:=20

stream.next_out =3D kmap_local_page(pages[curpage]) + poffset;

>=20
> Secondly please wrap the line to fit into 80 chars.
>=20
> >  				stream.avail_out =3D PAGE_SIZE -=20
poffset;
> >  				poffset =3D 0;
> >  			} else {
> > @@ -170,6 +168,12 @@ static loff_t zisofs_uncompress_block(struct inode=
=20
*inode, loff_t block_start,
> >  			}
> >  		}
> > =20
> > +		if (stream.next_out)
> > +			if (stream.next_out !=3D (char=20
*)zisofs_sink_page) {
> > +				kunmap_local(stream.next_out);
> > +				stream.next_out =3D NULL;
> > +			}
> > +
>=20
> This looks buggy as well. If we mapped page above, we'll unmap it here=20
even
> if stream.avail_out > 0 and we want to still write to it. I think you
> should unmap the page here only if stream.avail_out =3D=3D 0 and we are g=
oing
> to switch to the next page...

I need to look carefully at this because I'm not 100% sure of what you are=
=20
talking about. At this moment I cannot look at the code, however I suppose=
=20
that when I can, I'll have no problems to figure out what I missed.=20

> >  		if (!stream.avail_out) {
> >  			/* This page completed */
> >  			if (pages[curpage]) {
> > @@ -183,6 +187,9 @@ static loff_t zisofs_uncompress_block(struct inode=
=20
*inode, loff_t block_start,
> >  	}
> >  inflate_out:
> >  	zlib_inflateEnd(&stream);
> > +	if (stream.next_out)
> > +		if (stream.next_out !=3D (char *)zisofs_sink_page)
> > +			kunmap_local(stream.next_out);
>=20
> This is correct but I'd simplify it to:
>=20
> 	if (stream.next_out && stream.next_out !=3D (char=20
*)zisofs_sink_page)
> 		kunmap_local(stream.next_out);

It's shorter and more readable. I'll rewrite the code as you suggest.

Thanks,

=46abio

> 							=09
Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>=20




