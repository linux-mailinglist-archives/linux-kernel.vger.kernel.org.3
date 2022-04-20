Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4585089D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354167AbiDTN60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354116AbiDTN6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:58:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744E93CA5A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:55:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id s18so3818626ejr.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lWkDf0wNceWcaf4i2M1FdHierloyPBoW31t9T2JLGrs=;
        b=MMLAf5NoGw56Pzvcxrd5pY9+RhqwItSeA0OHHxL1ivLiEGGdjUaxH+oPSJccQLbtkn
         jqSvrv0+NgCPeCx1Tq8ErwuVVY+ZEe431Iz58dHu7LSBisKz0idcCiHGFmTSZ0KXHI5S
         zsSQrw9kn5p8BtVCZe7iVkRyOUB+/9/e4nx9Cd2mH6A6kKMpXdkONZKiEhcx/kanQ/Zb
         7/WKktk6Mxp4M53vfXEfzUFgnxt5gi5ePPpqMQjIYdY3uOf5q9+5sWqb0a3adab0WOQu
         5iswm3+ZIIUtQqotZWENSzvIV1k4O52iky9KWA24KAdVQlCwa+33sDpfS990ze9syLqL
         cTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lWkDf0wNceWcaf4i2M1FdHierloyPBoW31t9T2JLGrs=;
        b=aVkYc0u+Dg/glkQlv58yC/msC2TlPbm0cZX7dfKauR86hEdVLH/ovzOyke6jfD8yTa
         phXmUwr5BQJa3FhhCLcK8o/sywyp08DjUXo14GGAymTbLWrrwGd44aEPHue3gnjrqb7A
         sU41pXuMOE+g6e4arTT3ji31TmVRh1MeSyjRtJ+zXrZDBIKweT3/bCCLJ7zFmff684ml
         +P4aw7HjtcOXDHqP2fMcZkHwNoZanLtRwyL94aH6RGtNdFd+G91C19fNQx/SIjHN1Ywl
         5weIyyvn/NVPbLtdvyV8Ibg7zrjedROHIWuOZvgbmSS4q9t21dDFWu1r7L0mNcU18QNf
         jPeQ==
X-Gm-Message-State: AOAM532MUW/7sdq76t+a0IgA52XumL/WMzaOW2GG3S/hx6qPYaxIJkd1
        wBbr478VT+Now4qy9KIl5lY=
X-Google-Smtp-Source: ABdhPJz0c2WM3jXMhp3SbAHw3bgGqgx8hp0cdYVR6eNckJU3LJwiBiMvAH6WyMFGZfERJkze9g8T4Q==
X-Received: by 2002:a17:907:6d23:b0:6d9:ac9d:222 with SMTP id sa35-20020a1709076d2300b006d9ac9d0222mr18765799ejc.595.1650462936798;
        Wed, 20 Apr 2022 06:55:36 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id x19-20020a05640226d300b004228faf83desm8275806edd.12.2022.04.20.06.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:55:35 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>, ira.weiny@intel.com
Cc:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
        outreachy@lists.linux.dev, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xen:  Convert kmap() to kmap_local_page()
Date:   Wed, 20 Apr 2022 15:55:34 +0200
Message-ID: <3990312.6PsWsQAL7t@leap>
In-Reply-To: <alpine.DEB.2.22.394.2204201538560.2937@hadrien>
References: <20220419234328.10346-1-eng.alaamohamedsoliman.am@gmail.com> <2940450.687JKscXgg@leap> <alpine.DEB.2.22.394.2204201538560.2937@hadrien>
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

On mercoled=C3=AC 20 aprile 2022 15:40:10 CEST Julia Lawall wrote:
>=20
> On Wed, 20 Apr 2022, Fabio M. De Francesco wrote:
>=20
> > On mercoled=C3=AC 20 aprile 2022 08:03:05 CEST Julia Lawall wrote:
> > >
> > > On Wed, 20 Apr 2022, Alaa Mohamed wrote:
> > >
> > > > kmap() is being deprecated and these usages are all local to the=20
thread
> > > > so there is no reason kmap_local_page() can't be used.
> > > >
> > > > Replace kmap() calls with kmap_local_page().
> > >
> > > OK, so from a Coccinelle point of view, could we do
> > >
> > > @@
> > > expression e1,e2,x,f;
> > > @@
> > >
> > > e1 =3D
> > > - kmap
> > > + kmap_local_page
> > >     (e2)
> > > ... when !=3D x =3D e1 // not stored in any location and not passed to
> > another function
> > >     when !=3D f(...,e1,...)
> > >     when !=3D x =3D e2
> > >     when !=3D f(...,e2,...)
> > > -kunmap(e2)
> > > +kunmap_local(e1)
> > >
> > > julia
> > >
> >
> > I've never spent sufficient time to understand properly the syntax and
> > semantics of expressions of Coccinelle. However, thanks Julia, this=20
code
> > looks good and can be very helpful.
> >
> > Only a minor objection... it doesn't tell when 'e2' has been allocated
> > within the same function where the kmap() call is.
> >
> > In the particular case that I cite above, I'd prefer to remove the
> > allocation of the page (say with alloc_page()) and convert kmap() /
kunmap()
> > to use kmalloc() / kfree().
> >
> > Fox example, this is done in the following patch:
> >
> > commit 633b0616cfe0 ("x86/sgx: Remove unnecessary kmap() from
> > sgx_ioc_enclave_init()") from Ira Weiny.
> >
> > Can Coccinelle catch also those special cases where a page that is=20
passed
> > to kmap() is allocated within that same function (vs. being passed as
> > argument to this function) and, if so, propose a replacement with
> > kmalloc()?
>=20
> It looks complex in this case, because the allocation is in another
> function, and it is passed to another function.

This is not the special case I was talking about. In this case your code=20
for Coccinelle tells the right proposal and it is exactly what Alaa did in=
=20
her patch (which is good!).

I'm talking about other special cases like the one I pointed to with the=20
link I provided. I'm sorry if my bad English made you think that Alaa's=20
patch was one of those cases where the page is allocated within the same=20
function where kmap() is.

I hope that now I've been clearer :)

Thanks,

=46abio


