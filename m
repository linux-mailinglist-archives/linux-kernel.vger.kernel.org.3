Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A12A5A1ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244661AbiHZCa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244795AbiHZCaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:30:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA45DDA;
        Thu, 25 Aug 2022 19:30:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 199so244578pfz.2;
        Thu, 25 Aug 2022 19:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=w4E8yIskNGkMMeeV03IGlzvK42z2oKDk+ZFn+fHYqrY=;
        b=nGZY7mzWQ49s6QQ2qpJXLRxVQzVFX1GLw+mfVE4qGnqtj0mYnpx8T1E2CPT0edmU+Q
         BWbbQncV4g/BvEmO2YAQc2zcimhoeGSfKjLb6BfM81ZV7Zz/4bXG4Ye7u9xUrEAwolF6
         R9iMbA5T91p8G4aDtHv1UlXZFF3DfVz/0dCJeDQatiLz5NQ1L5TZCXJdvJ8HDor6SIqu
         iBU7C9oOF6QL8YvmYMxflfTgyR1sJL5cVuJX8PX8uNg9661DN76Npv1CC/SJGm1e7rAA
         6r4YfzoVavvdED4/J/TnRsem9XEcMkWgSaVQmj4fNDWOsYC0J9dw4y2W0KTbHMPPKEbz
         prIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=w4E8yIskNGkMMeeV03IGlzvK42z2oKDk+ZFn+fHYqrY=;
        b=blKhJIaxZqZJP9CLP6pxW9eYHaN7RP19Sm5unJe09XLb6/R87f3OXHyZbOsPdSWmW9
         MrPvVZeE77uwHmVcUjaTDgUvbAAj3oFf6rbJTGJMLwp+og+KCL5znCDtsGAe5wXUzmUf
         qtRet+6kN9NT0fGbMV565FETrLjevazvP2IHmTWf7iWEGVILKrWWuuIXq3CRwF95fSLr
         XnnjcNFXWeRd0TwESJGQzNvJEl+8GPdGjL9za5L6FwQYQOpFDrReYj02sbv8gXXsj+0V
         C7hdAI/tNbop1ltq4v3qgX+8JekfhE5F2Qfs/n9wYwxKVE856m801olpW40zq+bLxmB9
         tBWw==
X-Gm-Message-State: ACgBeo0sr9teAk8RMv0htNAVI7kyR3sriSAYbeyRL23SsIWhQA0JLiJL
        syyUPD+fF6GmpUEFJqFZk0c=
X-Google-Smtp-Source: AA6agR5i/T5TG0YSwpfnDjBusYRHCNmmzS3L6WjPqmluVXdtIpYKNn9IhcVtDEhkJ1O3XoKyt68V9g==
X-Received: by 2002:a05:6a00:ccf:b0:536:63ad:25d1 with SMTP id b15-20020a056a000ccf00b0053663ad25d1mr1776300pfv.56.1661481050406;
        Thu, 25 Aug 2022 19:30:50 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-18.three.co.id. [180.214.233.18])
        by smtp.gmail.com with ESMTPSA id w10-20020aa7954a000000b00536fc93b569sm336558pfq.200.2022.08.25.19.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 19:30:49 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 416561039CC; Fri, 26 Aug 2022 09:30:46 +0700 (WIB)
Date:   Fri, 26 Aug 2022 09:30:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>,
        akpm@linux-foundation.org, yejiajian2018@email.szu.edu.cn,
        skhan@linuxfoundation.org, akiyks@gmail.com, rppt@kernel.org,
        zhangyinan2019@email.szu.edu.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/mm/page_owner.rst: update experimental data
Message-ID: <YwgwVsKYLUq0kbMo@debian.me>
References: <20220825172934.4344-1-caoyixuan2019@email.szu.edu.cn>
 <87ilmgyz34.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vxJg0Yu+kIIQU9hP"
Content-Disposition: inline
In-Reply-To: <87ilmgyz34.fsf@meer.lwn.net>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vxJg0Yu+kIIQU9hP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2022 at 12:09:35PM -0600, Jonathan Corbet wrote:
> >  - Without page owner::
> > =20
> >     text    data     bss     dec     hex filename
> > -   48392   2333     644   51369    c8a9 mm/page_alloc.o
> > +   58581   3166     652   62399    f3bf mm/page_alloc.o
> > =20
> >  - With page owner::
> > =20
> >     text    data     bss     dec     hex filename
> > -   48800   2445     644   51889    cab1 mm/page_alloc.o
> > -   6662     108      29    6799    1a8f mm/page_owner.o
> > -   1025       8       8    1041     411 mm/page_ext.o
> > +   59085   3294     652   63031    f637 mm/page_alloc.o
> > +   7464     125      28    7617    1dc1 mm/page_owner.o
> > +   1396      32       8    1436     59c mm/page_ext.o
> > =20
> > -Although, roughly, 8 KB code is added in total, page_alloc.o increase =
by
> > -520 bytes and less than half of it is in hotpath. Building the kernel =
with
> > +Although, roughly, 9 KB code is added in total, page_alloc.o increase =
by
> > +632 bytes and less than half of it is in hotpath. Building the kernel =
with
> >  page owner and turning it on if needed would be great option to debug
> >  kernel memory problem.
>=20
> This seems like a fine patch...but I do have to wonder if it really
> makes sense to maintain this information, which will surely be subject
> to frequent change.  Perhaps the whole thing is better replaced with a
> line saying that enabling page owner adds ~9KB?
>=20

The size figure above is from size(1) from binutils, for which the
command is run (maybe) against vmlinux.

So I would like to say "Enabling page owner increases vmlinux size by
several kilobytes."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--vxJg0Yu+kIIQU9hP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYwgwUQAKCRD2uYlJVVFO
o7uFAQCf7bu827yq5x9ny9c+LlKFv0l46wV2PWq4kJhF5m6qdQEA2hfbdTF9ZcuX
rGwwYDz1OzPqml6oVW7JJN9HoIT27gI=
=ru9H
-----END PGP SIGNATURE-----

--vxJg0Yu+kIIQU9hP--
