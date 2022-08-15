Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D988592C52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241611AbiHOJHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiHOJHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:07:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEBD12774;
        Mon, 15 Aug 2022 02:07:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ch17-20020a17090af41100b001fa74771f61so1815605pjb.0;
        Mon, 15 Aug 2022 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ytCNQGwIeXZj40U8A3wP6jYSy3C0nPDEAZKyhH2Bm+s=;
        b=I1miXohSb8hNNyyM+IVJ6idZ1Ndfl/8Z5XclxLN2xJ/bqrzlw98AI/yWMo36Lzeljy
         ChXe+sUd5e1jmsA1xAOEGfmxEX0I8siMd2gNtYHQf5PmB752JQ6O36qMjqt9lLzenUw8
         9sFcHFrdtd8GSjs6md+islA8hd9ygR48FED061swtEuyBacH9289en3RA9elFowHDyNv
         KiCd50ZU5qNwlX5ZjmuyBbnv6b5HegoZkKqmNYN98rpzNENfVpS3460020KgatdlLhnW
         EtvhGEoZ6FWbpEl+obArOBF4erBVSCkSWsa5wWE5+6zHWdih7u4gl3ARPCDoCDRmwUp2
         bo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ytCNQGwIeXZj40U8A3wP6jYSy3C0nPDEAZKyhH2Bm+s=;
        b=vaU2BQ8QaIy1Zmw5zG88L0raeR6+kvPY9d6pNJRegvhxC1fnTwdFPRnDiqTo01mDMf
         W1nsVRVTOrWKwQhg6CPDcq0oKQXYz5kpenxv+4anJbYDVfllbGHjfsAagaINkGhZ0xxw
         rJyeZ11Q0oaccAOEKA7EsmbAFiGKcSzanWK1EnX+g48e/QKjYaBmIqhw+m9mKmWrebi6
         ZLeX3ciGivgyhFKPexvp9UAZ51GwDs6mDH+Mzr72/rn3xIjYXI6dKdfpLXX/wusgU3u1
         W+ZFjzHt47+H3d/u7Scl/W61aXrG4OtVJ77n9Jv/mOZegwmThz1dQrjviAs9Z9xKqFaF
         rVQA==
X-Gm-Message-State: ACgBeo1iPV+FOZ9Wfqfegcq1Ivav9GCD5iZ6QVENKdPWdn5B3oOeyEVs
        aNXUGLW1WvKw0NrStyvFOuU=
X-Google-Smtp-Source: AA6agR4mSolBgLsCmfRic3/79moJacqTr4o/KFdaTbuklFRrYfgws+ojqvi7jwpP1zEp3mX11EicMQ==
X-Received: by 2002:a17:903:110e:b0:171:3114:7112 with SMTP id n14-20020a170903110e00b0017131147112mr16647193plh.114.1660554421334;
        Mon, 15 Aug 2022 02:07:01 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-81.three.co.id. [180.214.233.81])
        by smtp.gmail.com with ESMTPSA id ja14-20020a170902efce00b0016be527753bsm6536541plb.264.2022.08.15.02.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:07:00 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A8AE5103981; Mon, 15 Aug 2022 16:06:56 +0700 (WIB)
Date:   Mon, 15 Aug 2022 16:06:56 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v14 13/14] mm: multi-gen LRU: admin guide
Message-ID: <YvoMsLV9ACCtx3yR@debian.me>
References: <20220815071332.627393-1-yuzhao@google.com>
 <20220815071332.627393-14-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hXl4J7c08OjeDapH"
Content-Disposition: inline
In-Reply-To: <20220815071332.627393-14-yuzhao@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hXl4J7c08OjeDapH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2022 at 01:13:32AM -0600, Yu Zhao wrote:
> Add an admin guide.
>=20
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Acked-by: Steven Barrett <steven@liquorix.net>
> Acked-by: Suleiman Souhlal <suleiman@google.com>
> Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> Tested-by: Donald Carr <d@chaos-reins.com>
> Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>

LGTM to me (no new warnings).

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--hXl4J7c08OjeDapH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYvoMqwAKCRD2uYlJVVFO
o6ekAQDViFd9adq3PN+jhvi+0+SA8p4xYIu8+wX0rK5RwyefKAEAnqBJxRVjYgtH
qQ2ZJ61By45ALibbbomA1BTxDGKAmws=
=uIV5
-----END PGP SIGNATURE-----

--hXl4J7c08OjeDapH--
