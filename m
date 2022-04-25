Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A96150EC23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiDYWfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiDYWf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:35:28 -0400
X-Greylist: delayed 76 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 15:32:20 PDT
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE105D5E9C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:32:20 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220425223219usoutp013549bffb0b871c7ece6fefc277a8fc8d~pRGUjbSkH3194031940usoutp01v;
        Mon, 25 Apr 2022 22:32:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220425223219usoutp013549bffb0b871c7ece6fefc277a8fc8d~pRGUjbSkH3194031940usoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650925939;
        bh=lUAxorIG3xx22FZeCKViHdal4uXa3obuhG1AtQNjNUA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Z+LK/Mp1cS5Oi0ld7U+6fhQEkKnu0UJASw7/CO/2P/2uNC6feWm9XmvX9ZUcLs1qB
         ayW6c+eHx+qx37WHERRuw3Hcl7Zu4W/aXUAVwxUUgvPsN4udqrimiNvotQvEnismaB
         mmrGMP6WozpeLvPwVfAuNRRPLGlKwoeQxVHCLu08=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220425223219uscas1p101cc13ac23e68788ee44d1254d088d44~pRGUTSpti1843318433uscas1p1Z;
        Mon, 25 Apr 2022 22:32:19 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id D1.A5.09642.37127626; Mon,
        25 Apr 2022 18:32:19 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220425223218uscas1p1df8f7f2bc2fb34585b983833172d37f0~pRGT58O2L2651726517uscas1p19;
        Mon, 25 Apr 2022 22:32:18 +0000 (GMT)
X-AuditID: cbfec36f-c15ff700000025aa-9c-62672173d603
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id A4.1D.09665.27127626; Mon,
        25 Apr 2022 18:32:18 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.7; Mon, 25 Apr 2022 15:32:18 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.007; Mon,
        25 Apr 2022 15:32:18 -0700
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
Subject: Re: [PATCH 2/6] mm/vmscan: use node_is_toptier helper in
 node_reclaim
Thread-Topic: [PATCH 2/6] mm/vmscan: use node_is_toptier helper in
        node_reclaim
Thread-Index: AQHYUVRPhFduil0j7kuBgiP9pteKmq0Bu1OA
Date:   Mon, 25 Apr 2022 22:32:17 +0000
Message-ID: <20220425223217.GB147460@bgt-140510-bm01>
In-Reply-To: <20220416053902.68517-3-dave@stgolabs.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20BE6FE238A73040961B01F8E3D668AB@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djXc7rFiulJBuvaeSzmrF/DZvFiQzuj
        xeqbaxgt1q2ayGKxepOvxeVdc9gs7q35z2rx+tsyZou2JRuZLCauEbU4eO01o8W1SfPZLLbv
        inTg9Tj85j2zx4JNpR6bVnWyeWz6NInd48SM3yweCxumMnvMOxnoMXV2vcfnTXIBnFFcNimp
        OZllqUX6dglcGZ8eVxQcYK/Yf+M1ewNjD1sXIyeHhICJRGfvWSCbi0NIYCWjxNXmUywgCSGB
        ViaJA28EYIr+nzjHClG0llFi9cX37BBFHxklNuyrgUgsY5SYe2sJ2Fg2AQOJ38c3MoPYIgLq
        EvPW3mYEsZkF9rNK/D5mCWILCwRI9F2fzgpREyixet5fNgjbSOLetLdgvSwCqhLPJhwEi/MK
        mEocmDiLCcTmFDCX+HriE5jNKCAm8f3UGiaI+eISt57MZ4K4WlBi0ew9zBC2mMS/XQ+hXlaU
        uP/9JTtEvY7Egt2f2CBsO4mDL9ezQtjaEssWvmaG2CsocXLmExaIXkmJgytusIA8LCEwm1Pi
        woaP7BAJF4mXL59DFUlLTF9zGaqonVHiw4R9rBDOBEaJO29/Qp1hLfGv8xr7BEaVWUgun4Xk
        qllIrpqF5KpZSK5awMi6ilG8tLg4Nz212CgvtVyvODG3uDQvXS85P3cTIzDxnf53OH8H4/Vb
        H/UOMTJxMB5ilOBgVhLhnaqaliTEm5JYWZValB9fVJqTWnyIUZqDRUmcd1nmhkQhgfTEktTs
        1NSC1CKYLBMHp1QDU+ab61pT857ndy57+PnYwmvtObc377UuqXpt8fyn986XwZzhd97HH5yz
        yCrszamdTRsy57Db3z36/dLiqa9DDJ2XZ11cf832urTnsr95VQun1x4NT9+Yx15xMFHqyVOm
        nRluP7R8JybI9XhY7F560MlKaXLV7SvLVYy7XWRbP9y/XSG/bOqnnprNCnyvrQ6fODBhLbPn
        S7H/Juxzp98LOVW4ZYe/epvJzycTnj30esW8Q2zqziKb/jrhnxsc72UxJXjqFf5xs5E7uX/e
        j48TV7XpW0odTz+xdrGP2gze1nx13u02NV7l3wL2nzCSuTzRP9rR6QR/w+Smj4IfOv24b+95
        cuKAiknMyceCjlURq88qsRRnJBpqMRcVJwIAe6M1TesDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWS2cA0SbdIMT3JYPcuPYs569ewWbzY0M5o
        sfrmGkaLdasmslis3uRrcXnXHDaLe2v+s1q8/raM2aJtyUYmi4lrRC0OXnvNaHFt0nw2i+27
        Ih14PQ6/ec/ssWBTqcemVZ1sHps+TWL3ODHjN4vHwoapzB7zTgZ6TJ1d7/F5k1wAZxSXTUpq
        TmZZapG+XQJXxqfHFQUH2Cv233jN3sDYw9bFyMkhIWAi8f/EOdYuRi4OIYHVjBLXLr1ngXA+
        MkpM+7OFCcJZxihx5WgnM0gLm4CBxO/jG8FsEQF1iXlrbzOCFDEL7GWVWHmvkwUkISzgJ3Hp
        6w92iKJAif/7H7FA2EYS96a9BWtmEVCVeDbhINgdvAKmEgcmzoLatp1RYs/Xw4wgCU4Bc4mv
        Jz4xgdiMAmIS30+tAbOZBcQlbj2ZzwTxhIDEkj3nmSFsUYmXj/+xQtiKEve/v2SHqNeRWLD7
        ExuEbSdx8OV6VghbW2LZwtfMEEcISpyc+YQFoldS4uCKGywTGCVmIVk3C8moWUhGzUIyahaS
        UQsYWVcxipcWF+emVxQb56WW6xUn5haX5qXrJefnbmIEpo3T/w7H7GC8d+uj3iFGJg7GQ4wS
        HMxKIrxTVdOShHhTEiurUovy44tKc1KLDzFKc7AoifN6xE6MFxJITyxJzU5NLUgtgskycXBK
        NTBVbDvI9nata9DTWaKLXCtfzVfge/+CX/2B3vwF77qOT5VnFVhS2ls+iUNCPmLCw5csCld+
        TZvQOcd7Q2uD8J08Lj3pOnUjLQvbSSovD+suTlhceqoqvPQG56zsNU09okdu3t+S/rf+W5Q3
        30Quh3MFZ3/Gn/y7k/tMXrG2q2rJx/CiL0d97kuqCS9xmCKQmLW65PMx0dmJ4Tfe/5metmv6
        PD4LpmMmfmu6W9e57TxRc07UMjJhb+vq6JNsUpq7Zy+Yxi4R4cx9XH992M6aA5+/efleuSqd
        tXFWTbins1tid/y2AC7BhJ+1Ac9CT29byBxtEr/B8fakePsNkUmv8sQ+b2F5xr7v6wP9ZMal
        ATxKLMUZiYZazEXFiQBwB9nKigMAAA==
X-CMS-MailID: 20220425223218uscas1p1df8f7f2bc2fb34585b983833172d37f0
CMS-TYPE: 301P
X-CMS-RootMailID: 20220416053914uscas1p1552442654a37adcda208d5fec86ec1de
References: <20220416053902.68517-1-dave@stgolabs.net>
        <CGME20220416053914uscas1p1552442654a37adcda208d5fec86ec1de@uscas1p1.samsung.com>
        <20220416053902.68517-3-dave@stgolabs.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:38:58PM -0700, Davidlohr Bueso wrote:
> We have helpers for a reason.
>=20
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1678802e03e7..cb583fcbf5bf 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4750,7 +4750,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t g=
fp_mask, unsigned int order)
>  	 * over remote processors and spread off node memory allocations
>  	 * as wide as possible.
>  	 */
> -	if (node_state(pgdat->node_id, N_CPU) && pgdat->node_id !=3D numa_node_=
id())
> +	if (node_is_toptier(pgdat->node_id) && pgdat->node_id !=3D numa_node_id=
())
>  		return NODE_RECLAIM_NOSCAN;
> =20
>  	if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
> --=20
> 2.26.2
>


Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
