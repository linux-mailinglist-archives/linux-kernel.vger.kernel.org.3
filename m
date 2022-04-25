Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE4550EC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiDYWj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiDYWj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:39:57 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77901EEF4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:36:50 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220425223059usoutp0180058bb5497758d6c96c67edfaeb449d~pRFJzJZg42449424494usoutp01e;
        Mon, 25 Apr 2022 22:30:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220425223059usoutp0180058bb5497758d6c96c67edfaeb449d~pRFJzJZg42449424494usoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650925859;
        bh=CsbcO+p6CiS6d9aB1oojSVgJ8bcRlB7m2SpwxFhLZ+w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Ms79yjqZu0Z9XqSv/uUS/GzzP/ZoH5OTirpEAK1paMBNSHKJFP3ZAI5HX6pbXN6JN
         0by9ULy74aKV7itzxlI6UGHi89IYU60YMCDfm/k68VBWSq1CeSRNO489bcXDxyytkE
         mXK824lnFmaweU8IGQrJegX5Ie+RSnzSgXQojl90=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220425223058uscas1p1bcbfe155435028c3a9a27c76b3e25c6d~pRFJbb5gs1749317493uscas1p1a;
        Mon, 25 Apr 2022 22:30:58 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 3F.6F.09749.22127626; Mon,
        25 Apr 2022 18:30:58 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220425223058uscas1p10722f66722de23c644f8330da82fe1da~pRFI1fUX_1749317493uscas1p1Z;
        Mon, 25 Apr 2022 22:30:58 +0000 (GMT)
X-AuditID: cbfec370-a6bff70000002615-9d-626721221174
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 32.5D.09702.12127626; Mon,
        25 Apr 2022 18:30:58 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.7; Mon, 25 Apr 2022 15:30:57 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.007; Mon,
        25 Apr 2022 15:30:57 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "yosryahmed@google.com" <yosryahmed@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "gthelen@google.com" <gthelen@google.com>,
        Heekwon Park <heekwon.p@samsung.com>,
        Jongmin Gim <gim.jongmin@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] drivers/base/node: cleanup register_node()
Thread-Topic: [PATCH 1/6] drivers/base/node: cleanup register_node()
Thread-Index: AQHYUVRPCSx4CL5jbUm8oG94siTkjq0Buu6A
Date:   Mon, 25 Apr 2022 22:30:57 +0000
Message-ID: <20220425223050.GA147460@bgt-140510-bm01>
In-Reply-To: <20220416053902.68517-2-dave@stgolabs.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1D3122BB7B4C84AA59E81DD72B78789@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djXc7pKiulJBuc3mVrMWb+GzeLFhnZG
        i9U31zBarFs1kcVi9SZfi8u75rBZ3Fvzn9Xi9bdlzBZtSzYyWUxcI2px8NprRotrk+azWWzf
        FenA63H4zXtmjwWbSj02repk89j0aRK7x4kZv1k8FjZMZfaYdzLQY+rseo/Pm+QCOKO4bFJS
        czLLUov07RK4Mp6+b2Et6OasuPZ9JmsD41r2LkZODgkBE4kb37+zdTFycQgJrGSU6Fj7kxEk
        ISTQyiRxdo8FTNHUlWtYIOJrGSX+r66GaPjIKDGv/Ss7RGIZo0TDE3EQm03AQOL38Y3MILaI
        gLrEvLW3wYYyC+xnlfh9zBLEFhZwlri55yNUjYvE7PX7GCFsI4kNM5eAxVkEVCX6D34Dm88r
        YCoxafUGVhCbU8Bc4vnpJrA4o4CYxPdTa5gg5otL3HoynwniaEGJRbP3MEPYYhL/dj1kg7AV
        Je5/f8kOUa8jsWD3JzYI207iwJOlUHFtiWULXzND7BWUODnzCQtEr6TEwRU3WECelxCYzSlx
        +8tvqISLxL6L/YwQtrTE1etTmSGK2hklPkzYxwrhTGCUuPP2J9QZ1hL/Oq+xT2BUmYXk8llI
        rpqF5KpZSK6aheSqBYysqxjFS4uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQIT3+l/hwt2MN66
        9VHvECMTB+MhRgkOZiUR3qmqaUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZdlbkgUEkhPLEnN
        Tk0tSC2CyTJxcEo1MBW/StmYqSb8XefN7qzVr5uKN62+x3nc+cOp+wv/PdNMleeI4JLp3cid
        /z312OW/FyZPb0lPutR77UGNZL1n8YRXS+Q/ROh+nRlcd+AId1AWK/O66+mpoXprTvGsPpTx
        xmnPyQXTny+YdCJW5ZJ+sP65+k172DqT9MJZzQ/ya0+NV+b0M5ZvVHS5NW+lsMepOf1TBHsv
        M0nMnqtxqfqbRJj00p2fqr0rfOeu8ZWeGuB9JPd7z4JA1XDVpKzYnGv63OfPTDvm33s2RfXy
        n+j3r2r1rs3RKQzxffnYqoyv7+gdqUdaZoXL1/2WaOpLnt/A0/frpHrv5LjTP53nuz5s29O6
        wURq/WeXiQtE/A641CqxFGckGmoxFxUnAgCCCKTP6wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWS2cA0SVdJMT3J4Mlzbos569ewWbzY0M5o
        sfrmGkaLdasmslis3uRrcXnXHDaLe2v+s1q8/raM2aJtyUYmi4lrRC0OXnvNaHFt0nw2i+27
        Ih14PQ6/ec/ssWBTqcemVZ1sHps+TWL3ODHjN4vHwoapzB7zTgZ6TJ1d7/F5k1wAZxSXTUpq
        TmZZapG+XQJXxtP3LawF3ZwV177PZG1gXMvexcjJISFgIjF15RqWLkYuDiGB1YwS5xZPYYZw
        PjJKnJ/8lxXCWcYo8Wz6GiaQFjYBA4nfxzcyg9giAuoS89beZgQpYhbYyyqx8l4nC0hCWMBZ
        4uaej1BFLhKz1+9jhLCNJDbMXAIWZxFQleg/+A3sDl4BU4lJqzdAbdvOKPFuzyuwBk4Bc4nn
        p5vAihgFxCS+n4K4gllAXOLWk/lMEE8ISCzZc54ZwhaVePn4HyuErShx//tLdoh6HYkFuz+x
        Qdh2EgeeLIWKa0ssW/iaGeIIQYmTM5+wQPRKShxccYNlAqPELCTrZiEZNQvJqFlIRs1CMmoB
        I+sqRvHS4uLc9Ipiw7zUcr3ixNzi0rx0veT83E2MwMRx+t/hyB2MR2991DvEyMTBeIhRgoNZ
        SYR3qmpakhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFeIdeJ8UIC6YklqdmpqQWpRTBZJg5OqQYm
        rx1+Myf0ia7nuyfQ8sTSiU/A7+SXlQ8iw1TvHH1WOmfK7Qf7Vto3bDrULc3Vef06u6rHz6S7
        U//aGDPXdHiUfLFlXPB67UtB3kWXTpxcf2mp4CWGJxN3v2aPTdr6S9HKcJePdPSOTaFily3v
        Gb5cqelwXnxzgn11/bOsG18v9jIyc+UGFnZ0zbf+af/M0/Tv7tcaJ+LOea2568P3om6Gm8mx
        mW9mlGzesW7rqlnrk6cvXLJz/9X3z7U/7m1aVNu42vvH06Bp3/4lic5cVL5RTq94y/2TFlml
        36+stPoe6qW8KXRZ2P1n15nafd7qTYnJ7lu88ptMoPebukXOVw+umRp6LCbcqS/mPt+BOqP9
        5lxKLMUZiYZazEXFiQDmCv9riwMAAA==
X-CMS-MailID: 20220425223058uscas1p10722f66722de23c644f8330da82fe1da
CMS-TYPE: 301P
X-CMS-RootMailID: 20220416053912uscas1p2df42c3e74997a1443a9a38450dae89a9
References: <20220416053902.68517-1-dave@stgolabs.net>
        <CGME20220416053912uscas1p2df42c3e74997a1443a9a38450dae89a9@uscas1p2.samsung.com>
        <20220416053902.68517-2-dave@stgolabs.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:38:57PM -0700, Davidlohr Bueso wrote:
> Trivially get rid of some unnecessary indentation.
>=20
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/base/node.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index ec8bb24a5a22..6cdf25fd26c3 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -661,16 +661,16 @@ static int register_node(struct node *node, int num=
)
>  	node->dev.bus =3D &node_subsys;
>  	node->dev.release =3D node_device_release;
>  	node->dev.groups =3D node_dev_groups;
> -	error =3D device_register(&node->dev);
> =20
> -	if (error)
> +	error =3D device_register(&node->dev);
> +	if (error) {
>  		put_device(&node->dev);
> -	else {
> -		hugetlb_register_node(node);
> -
> -		compaction_register_node(node);
> +		return error;
>  	}
> -	return error;
> +
> +	hugetlb_register_node(node);
> +	compaction_register_node(node);
> +	return 0;
>  }
> =20
>  /**
> --=20
> 2.26.2
>


Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
