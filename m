Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311C1508922
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378941AbiDTNZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiDTNZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:25:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7890A427FF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:22:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lc2so3466130ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ng4rT6I4vcHmv4/7ezO3PQ9fpnN0wzaNSUcZ6IscV4k=;
        b=hisOYUiR4cenD1rp5qPKSBG+WAk64wKCLuwUm8RftXBLSnJNAj+b10FaYqJQ3H8Y9I
         Ll8ySPsAvRZBbFLxQqCxiKgJ0Raz+OKxSEH123P/ID9N4IMOW/8S2ZkWhDmPtn4DAB/m
         CJXmIRJgEXBZ86KiTOsgJKbzAQqulyO6SC+rF1OBjPNBAOlcac+iA0cVT2Zag6WtfN5n
         hByBi+9SfZHZRP99RvjAjR8Z+1Dv2JwgaaEJBwfKpHlGXP9Cqug0aiqIne7waUJcKbUf
         gdKJgXh+ank2b2a3ZSQAavn0rdJK8My3fLILeOefKuQTSWeoq0kT/7SmppbOo6yXDD9L
         H7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ng4rT6I4vcHmv4/7ezO3PQ9fpnN0wzaNSUcZ6IscV4k=;
        b=faGGspw3AedWwV3onWueWBb6ZZpEcINrSftYGphHjaqtKimjueonc0pM+R6MY4vz5n
         xTpXk3N7RrzqSB0+9FCGEtZZMEF3NQtLLHr4vtPVnsmm8gTVlOZ/pgSEPFwKXiullnJy
         t/xsXZXEK6uoNgOCpx9zS7UYTbg2TrSUkTCAUTH7wkvUQ7l7mgT2dLLd7UD2/KLgrdqV
         /aU6Owyn34tvAUldNn9b2DK1XVyCxSlrwY4jutnon5ZmRlPVzwWf3VMaVRkN95/ttijt
         3/o/cJevLZT1Wl3okNCNGm0d4Y9AdT69SSxhFjq376dmlbzBS3BY7eMoBnpY/J9+O1n9
         L6YA==
X-Gm-Message-State: AOAM530Gv5PmiaA1aQvNNHFjiHACrnEeFZk/XqVPwmq/DkwFClORKzzF
        Zh730IzlDXED9lCEjPsMAP4=
X-Google-Smtp-Source: ABdhPJwU9wCOFteWozSkt5bu3lmUNtDTL6NNULRKJcKJoaUjbAjkFKxtS6lDaecx+VwibuEjcyEeBQ==
X-Received: by 2002:a17:906:60c2:b0:6e7:681e:b4b7 with SMTP id f2-20020a17090660c200b006e7681eb4b7mr18667712ejk.130.1650460932892;
        Wed, 20 Apr 2022 06:22:12 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id w7-20020a1709061f0700b006ec8197e8a4sm6255708ejj.97.2022.04.20.06.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:22:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>, ira.weiny@intel.com
Cc:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
        outreachy@lists.linux.dev, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xen:  Convert kmap() to kmap_local_page()
Date:   Wed, 20 Apr 2022 15:22:10 +0200
Message-ID: <2940450.687JKscXgg@leap>
In-Reply-To: <alpine.DEB.2.22.394.2204200759080.2937@hadrien>
References: <20220419234328.10346-1-eng.alaamohamedsoliman.am@gmail.com> <alpine.DEB.2.22.394.2204200759080.2937@hadrien>
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

On mercoled=C3=AC 20 aprile 2022 08:03:05 CEST Julia Lawall wrote:
>=20
> On Wed, 20 Apr 2022, Alaa Mohamed wrote:
>=20
> > kmap() is being deprecated and these usages are all local to the thread
> > so there is no reason kmap_local_page() can't be used.
> >
> > Replace kmap() calls with kmap_local_page().
>=20
> OK, so from a Coccinelle point of view, could we do
>=20
> @@
> expression e1,e2,x,f;
> @@
>=20
> e1 =3D
> - kmap
> + kmap_local_page
>     (e2)
> ... when !=3D x =3D e1 // not stored in any location and not passed to=20
another function
>     when !=3D f(...,e1,...)
>     when !=3D x =3D e2
>     when !=3D f(...,e2,...)
> -kunmap(e2)
> +kunmap_local(e1)
>=20
> julia
>=20

I've never spent sufficient time to understand properly the syntax and=20
semantics of expressions of Coccinelle. However, thanks Julia, this code=20
looks good and can be very helpful.

Only a minor objection... it doesn't tell when 'e2' has been allocated=20
within the same function where the kmap() call is.

In the particular case that I cite above, I'd prefer to remove the=20
allocation of the page (say with alloc_page()) and convert kmap() /kunmap()=
=20
to use kmalloc() / kfree().=20

=46ox example, this is done in the following patch:

commit 633b0616cfe0 ("x86/sgx: Remove unnecessary kmap() from=20
sgx_ioc_enclave_init()") from Ira Weiny.

Can Coccinelle catch also those special cases where a page that is passed=20
to kmap() is allocated within that same function (vs. being passed as=20
argument to this function) and, if so, propose a replacement with=20
kmalloc()?

Thanks,

=46abio



