Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B914B7119
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbiBOPBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:01:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbiBOPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:01:43 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDDC13CE5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:01:33 -0800 (PST)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nJzKT-0001Wq-7a; Tue, 15 Feb 2022 10:01:21 -0500
Message-ID: <63f930e411655a6ad37d4818d0ae19784c82f076.camel@surriel.com>
Subject: Re: [PATCH v2] mm: clean up hwpoison page cache page in fault path
From:   Rik van Riel <riel@surriel.com>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, linux-mm@kvack.org,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Date:   Tue, 15 Feb 2022 10:01:20 -0500
In-Reply-To: <2a881586-3f5e-c277-f373-a9014d631700@redhat.com>
References: <20220212213740.423efcea@imladris.surriel.com>
         <2a881586-3f5e-c277-f373-a9014d631700@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xmBlxiMQ0RX+8gFzH+9g"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xmBlxiMQ0RX+8gFzH+9g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2022-02-15 at 12:22 +0100, David Hildenbrand wrote:
> On 13.02.22 03:37, Rik van Riel wrote:
> > Sometimes the page offlining code can leave behind a hwpoisoned
> > clean
> > page cache page. This can lead to programs being killed over and
> > over
> > and over again as they fault in the hwpoisoned page, get killed,
> > and
> > then get re-spawned by whatever wanted to run them.
>=20
> Hi Rik,
>=20
> am I correct that you are only talking about soft offlining as
> triggered
> from mm/memory-failure.c, not page offlining as in memory offlining
> mm/memory_hotunplug.c ?

That is correct in that I am talking only about memory-failure.c,
however the code in memory-failure.c has both hard and soft
offlining modes, and I suppose this patch covers both?

--=20
All Rights Reversed.

--=-xmBlxiMQ0RX+8gFzH+9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmILwEAACgkQznnekoTE
3oMtsAf/XQAcMuxVcOH1jkV3QUkXIetX7cd6gY7wiQ5Nw88ELC97QThAKEp/zTv5
RfVSqZmBLEaaW0oP81CrFinLrMk1IZZp8X8hkuK7V+086dGa1oxHoaF+k55yNpx9
6eIqlEiTloIgbTLVG6qKJhEZqgDCM0+fwBMVasVIAvfZ/scni5reBLJM2RZ3jVfl
xwBOvAIPZT+/8kxxQSuT+h2UDiATqZWdfGrGR/TuX86AxqVQEpNUovmufTST9tvd
yJpDju9ZHAbyB/tWquV+d5CBcXhQWqzw2aA3OH1te2nUz6M8azQA47gWZTBLzd80
ULrSoX/7Ez9S1U0VVYFIhivhGwbhmg==
=9B67
-----END PGP SIGNATURE-----

--=-xmBlxiMQ0RX+8gFzH+9g--
