Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32F35A0876
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiHYFep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiHYFen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:34:43 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC9B792EE;
        Wed, 24 Aug 2022 22:34:39 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220825053434usoutp02a58836af429fba0ed8dbe264ad332e7d~Of6ikpD8z0207502075usoutp02U;
        Thu, 25 Aug 2022 05:34:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220825053434usoutp02a58836af429fba0ed8dbe264ad332e7d~Of6ikpD8z0207502075usoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661405674;
        bh=TjRZuN4Iy9WgZv13eMsWVPDmjvfnP9Q2meeJjar2v0U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Isfq6fDkiIgkhLOBdbppDSdBhwvoViFLfmHNq4RHuhr8IV/f/dzQfOiiwAu+uRA4q
         UsotJMNLYz4OYQa1rfYiZkRiu3HLp63gCyoInrUDFN6iIW22sJYcfyTt58wFgWJ0uF
         nwoMa/i2iRI1C3AGGAiSLi4zlYlGokIRU23unDaY=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220825053434uscas1p2f771507a73590e1fbe5efc296493d291~Of6iWzRQe2478624786uscas1p2n;
        Thu, 25 Aug 2022 05:34:34 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 84.25.18126.AE907036; Thu,
        25 Aug 2022 01:34:34 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220825053434uscas1p11df952b561acf7daf01df54c8d45f1e4~Of6iDJeZ50260302603uscas1p13;
        Thu, 25 Aug 2022 05:34:34 +0000 (GMT)
X-AuditID: cbfec36f-ff9ff700000146ce-4e-630709ea3057
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id A6.6E.03193.9E907036; Thu,
        25 Aug 2022 01:34:34 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 24 Aug 2022 22:34:33 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
        24 Aug 2022 22:34:33 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "widawsk@kernel.org" <widawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: Replace HDM decoder granularity magic numbers
Thread-Topic: [PATCH] cxl: Replace HDM decoder granularity magic numbers
Thread-Index: AQHYtklu6j3UH4AVtU69YQX5WSmWH627nsOAgAKmF4CAAGEMAIAADPQAgADemwA=
Date:   Thu, 25 Aug 2022 05:34:33 +0000
Message-ID: <20220825053425.GA141173@bgt-140510-bm01>
In-Reply-To: <63064f28720cf_1b3229490@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5B0FDDFCF444524CBB59BE01FD1BB71E@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djX87qvONmTDR6fkbK4+/gCm8X0qRcY
        LVbfXMNosf/pcxaLVQuvsVmcn3WKxeLyrjlsFrcmHGOy2PxgMpMDp0fLkbesHov3vGTy2LSq
        k81j6ux6j8+b5AJYo7hsUlJzMstSi/TtErgyPr2dyFwwjbPi84c37A2M/exdjBwcEgImErtX
        8XQxcnEICaxklJj+4iozhNPKJPG2/SdTFyMnWFH74fusEIm1jBI9d1ZAVX1ilHh9fB4LhLOM
        UeL+uldsIC1sAgYSv49vZAaxRQS0JSbOOQjWwSywlFliwcaLLCDLhQXcJSZf5ISo8ZA4NP8m
        C4TtJ3Fj6T0mkBIWAVWJ5duTQMK8AqYSrd9OgZVwApV33t4Fdh2jgJjE91NrwGxmAXGJW0/m
        Q10tKLFo9h5mCFtM4t+uh2wQtqLE/e8v2SHqdSQW7P7EBmHbSXxfPJUFwtaWWLbwNTPEXkGJ
        kzOfsED0SkocXHED7F8JgRccEidP7IWGo4tE+7IgiBppielrLkPVtDNKfJiwjxXCmcAoceft
        T6grrCX+dV5jn8CoMgvJ4bOQHDULyVGzkBw1C8lRCxhZVzGKlxYX56anFhvlpZbrFSfmFpfm
        pesl5+duYgSmrNP/DufvYLx+66PeIUYmDsZDjBIczEoivFbHWJKFeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ8y7L3JAoJJCeWJKanZpakFoEk2Xi4JRqYJqe7V299dzGWP+6p51bmpJq2d/+Nrn0
        Q0Xt8aZk/Uf5XUL6D+q7t+x98eT0T9FJx9M37lp1MmrKwq23/btnLbfXaQht6Xs//+eGyiVp
        s3f5ZjLoXj2/rzw13oLt3YF9RRExCndvvd683ECwMeewg7/0N0unTxFVc02rXxrxPLd5a1GR
        faoyN2jyvjubRZ7tKX2R9YY1WKN417pz0398fHlKL7ZZ/i+n1swfjX6uexZeuS3pMfvAv04G
        Vt4Q0bKMCrWnUyIe7zDXkTyZs7Ky7kywqsS2iYcXxzaxst99Uu8m+vi2rl3Y9FOXvr/8LrNv
        nfqW5hMuxUsM44P3MFu37WhlYGtvf9HlnhUgHrLzqLYSS3FGoqEWc1FxIgDG4t17yAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWS2cA0UfcVJ3uywaSnXBZ3H19gs5g+9QKj
        xeqbaxgt9j99zmKxauE1Novzs06xWFzeNYfN4taEY0wWmx9MZnLg9Gg58pbVY/Gel0wem1Z1
        snlMnV3v8XmTXABrFJdNSmpOZllqkb5dAlfGp7cTmQumcVZ8/vCGvYGxn72LkZNDQsBEov3w
        fdYuRi4OIYHVjBJNj2+zQzifGCV2f7vCCOEsY5SY9PIcE0gLm4CBxO/jG5lBbBEBbYmJcw4y
        gxQxCyxllliw8SJLFyMHh7CAu8Tki5wQNR4Sh+bfZIGw/SRuLL3HBFLCIqAqsXx7EkiYV8BU
        ovXbKRaIXReZJFrvP2YESXAC9Xbe3gW2l1FATOL7qTVgNrOAuMStJ/OZIF4QkFiy5zwzhC0q
        8fLxP1YIW1Hi/veX7BD1OhILdn9ig7DtJL4vnsoCYWtLLFv4mhniCEGJkzOfsED0SkocXHGD
        ZQKjxCwk62YhGTULyahZSEbNQjJqASPrKkbx0uLi3PSKYuO81HK94sTc4tK8dL3k/NxNjMB4
        P/3vcMwOxnu3PuodYmTiYDzEKMHBrCTCa3WMJVmINyWxsiq1KD++qDQntfgQozQHi5I4r0fs
        xHghgfTEktTs1NSC1CKYLBMHp1QDk4xMxXF9vhiJxu0rr8/Nu2MaeY3/RkSQRcbT5S0X07cX
        C/OzrZ18x8cubMmaw/q7wma98nu7R7m593Rj9Yb1jud7blsaJCh3360Sq2Kfc8rtgMwFN9Vm
        r911IRWnRZNNDcrjv696s8jdfLZ1m5d5hHufh5zKV8NbCtMMhT7el97ncZE3sGD1L6XcdoVL
        Gh9fzZ156umuVe/7Qlh/iGvM4Zgj9VjxQ/Al6y2cZaf333F5eszs+qQ0DdvlxXyPZKNr7/L8
        Wqj5l1mlTzv58aRza9Zx6qcqy8Rbd16WWlk5ddE6c+WDM5SLrqVEdIkuSjANv8P8dMPx+Ckt
        Ocd/cL9g3ba4chJrm1Dvxm9xN9brKrEUZyQaajEXFScCANfUl7VmAwAA
X-CMS-MailID: 20220825053434uscas1p11df952b561acf7daf01df54c8d45f1e4
CMS-TYPE: 301P
X-CMS-RootMailID: 20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0
References: <CGME20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0@uscas1p1.samsung.com>
        <20220822170510.125082-1-a.manzanares@samsung.com>
        <20220822171703.sfizbmn6retpxggi@offworld>
        <20220824104401.00005cd4@huawei.com>
        <20220824153122.2bgths6lnsxlolos@offworld>
        <63064f28720cf_1b3229490@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 09:17:44AM -0700, Dan Williams wrote:
> Davidlohr Bueso wrote:
> > On Wed, 24 Aug 2022, Jonathan Cameron wrote:
> >=20
> > >On Mon, 22 Aug 2022 10:17:03 -0700
> > >Davidlohr Bueso <dave@stgolabs.net> wrote:
> >=20
> > >> Actually the whole drivers/cxl/* could use updating the comments for=
 3.0.
> > >
> > >Interesting point.  What do we want to do on this?  Most similar
> > >cases I've been involved on rely on referring to 'oldest' compatible s=
pec.
> > >(this is true for ACPI stuff for example).
> >=20
> > I find it incredibly annoying to reference table or section numbers fro=
m old
> > specs mention in the code. Unless dealing with specific version things,=
 why
> > use old specs at all?
> >=20
> > The main drawback to this is obviously the constant need to update ever=
ything,
> > so...
>=20
> I think a happy medium is all new references being 3.0 and touching any
> old references and refresh them up to 3.0.

I'll shoot for the happy medium in a v2.

>=20
> That said if someone wants to do the work to refresh all of them, and
> someone else wants to review those updates I would take the patch.=
