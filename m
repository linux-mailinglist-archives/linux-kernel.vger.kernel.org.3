Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C115A0887
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiHYFs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiHYFs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:48:27 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B453789930;
        Wed, 24 Aug 2022 22:48:25 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220825054824usoutp025f4315e35c0a59e295590c6cb46b9f99~OgGncUPzz0215502155usoutp02d;
        Thu, 25 Aug 2022 05:48:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220825054824usoutp025f4315e35c0a59e295590c6cb46b9f99~OgGncUPzz0215502155usoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661406504;
        bh=P776fLopEvsV1xTXaH6epmsPfaf2B9QlRJ7uSyUKMVk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=fVLfHe7YSuc25dpZ0VJfv1mPltrgbJmWPaceR8CQ6861+32CbPEvXjTdUmqXevAjn
         CECdw6JRzC/rwegGsoe8BH/K772Jx2vzcg2tKAMpe6hwd4mZe7ddJwuRUPwLR+O4Mg
         pjCcbbbYYFXlhSQiBepp5SRscCNFjMqV92wZTssw=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220825054824uscas1p276e1c575ec6999bb67aa19cab73432e5~OgGnIgxiM2441024410uscas1p2w;
        Thu, 25 Aug 2022 05:48:24 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 6B.B3.35398.82D07036; Thu,
        25 Aug 2022 01:48:24 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220825054823uscas1p2ef2ed3d5951da7f384d3fe646293ab05~OgGmGW_mc0801108011uscas1p2Q;
        Thu, 25 Aug 2022 05:48:23 +0000 (GMT)
X-AuditID: cbfec370-82fff70000028a46-80-63070d289ce8
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id E0.3E.59738.62D07036; Thu,
        25 Aug 2022 01:48:23 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 24 Aug 2022 22:48:22 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
        24 Aug 2022 22:48:22 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "widawsk@kernel.org" <widawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: Replace HDM decoder granularity magic numbers
Thread-Topic: [PATCH] cxl: Replace HDM decoder granularity magic numbers
Thread-Index: AQHYtklu6j3UH4AVtU69YQX5WSmWH627nsOAgAP2k4A=
Date:   Thu, 25 Aug 2022 05:48:22 +0000
Message-ID: <20220825054821.GC141173@bgt-140510-bm01>
In-Reply-To: <20220822171703.sfizbmn6retpxggi@offworld>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3383A43F9A0F3A458DAAFF132F6005F5@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se2xLYRjGfeecnp5Oyll166vudQ0zBHGMzDVRl4hIRsJkmu6kG1s3PYbO
        bWw2E6PGJjqssxhmCy2Z3RidTDahw7pLt1XRuS2TzdRiWKgzSf/7PXme93ufN/koXFIikFPR
        2t2sTquKUZB+REmNxzZzmlionu24NZRpf1dPMuez6hFzs6UIMVUdHwimMK+RZGzGOoJ5VX6R
        ZByGGoy54zqLLRUpUx53CZT5lZ8wpaUwnVRm5RxW9lrGbhBs8VscycZE72F1s0K3+0XVmXfE
        3wvY15BpFyahPP8TSEQBPQ/Kau/jJ5AfJaFvIDg/cFnAi2MYdNb2C/+nWgx2xBvFCBwmw6D4
        iuB9s5XwpiR0AYKSapmXSXo2/Hxixr0spafC5eLWfwM4/RiH/N9H/j5LUSPoVXD2hYjPKMGa
        20LwHAI96bXIywQ9GY4n2wReFtPz4VmKkfSyiF4A2Q2ZmJcRHQh9dUX/GKdl4HDnYnxrf7iS
        U4nzHAgD5W9InifA675PQj4fBKaKryTPoeDqqkI8z4CCvE6c3+sPtRfcBD87Eh5dbya8twDt
        pqChpkfAGyuhIvvc4IJRYG/KwvlQGoJuwwMBLwwI2rp+DKYWwUB6o9CAJhl9mht9Whl9Whl9
        Whl9WpmQoBDJEjguVsNyc7Xs3mBOFcslaDXB6rhYC/r7tZ4OVMeXIoejJ9iKMApZEVC4QioO
        qSHUEnGkSp/I6uIidAkxLGdFoyhCIRMXRN9WSWiNaje7k2XjWd1/F6NE8iRsjOvkuBbDleac
        RXd7uf7uVtG1592mDE6dKt/25sbWIXrLEPXE14EHNVEzvyVOjDQF5ds2f9h/YP7t/YprL9c/
        NCclb5mwJKLq2fp1O/sqyAC1x0Q5i2yHlrSGtS5MXDDdHT5cfErfUe7SXx32KKONy1wrXaoN
        lzrtZs/zjHbn2v5jnZMais/o5Z/VpmQPaiqLfovupbUZtpUtH3O4oitr603bxzLhaKwuZaMT
        y37Vm/ml9O6U0PAvRRHVYZ3fl61es0K/TJ7dk7ZYcyDhVz0tDWiKP/r+p+xIY+rIS+1BMbss
        zLjxZo895Nym1DBRZa5TEpJC2939c0u7GwM6plx1xZ1WEFyUas50XMep/gBy+eBqyQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWS2cA0SVedlz3ZYMUxDou7jy+wWUyfeoHR
        YvXNNYwW+58+Z7FYtfAam8X5WadYLC7vmsNmcWvCMSaLzQ8mMzlwerQcecvqsXjPSyaPTas6
        2Tymzq73+LxJLoA1issmJTUnsyy1SN8ugSvj1Masgu2iFVcmXWVvYFwo2MXIySEhYCJxc8JV
        xi5GLg4hgdWMEge2nGKDcD4xSrz7uQ4qs4xRYt+G2cwgLWwCBhK/j28Es0UE1CXmrb0NVsQs
        cIRZYvHfRvYuRg4OYQF3ickXOSFqPCQOzb/JAmFbSXzsPMkIYrMIqEp0NJ9nBbF5BUwlzrbM
        gtq8n1Fi1YQZYEWcAuYS065MYgKxGQXEJL6fWgNmMwuIS9x6Mp8J4gcBiSV7zjND2KISLx//
        Y4WwFSXuf3/JDlGvI7Fg9yc2CNtO4sHb/YwQtrbEsoWvmSGOEJQ4OfMJC0SvpMTBFTdYJjBK
        zEKybhaSUbOQjJqFZNQsJKMWMLKuYhQvLS7OTa8oNsxLLdcrTswtLs1L10vOz93ECIz30/8O
        R+5gPHrro94hRiYOxkOMEhzMSiK8VsdYkoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzCrlOjBcS
        SE8sSc1OTS1ILYLJMnFwSjUwsfap6dw9ZJsekPi4Um2yVfML1peaDaFTZ1vcdmpfP7G84WXI
        7qgV2/fG+7sf+3frrPWUFoc7ZcJfeWa//6UyKdyW36p7EV/d1d6/Nzut17TnXgvceH/hiVZF
        TvcvG/UTrgu4b62QYJlX9pPdv/32fn77ONsfnfOK7l9vN1oYa7x25dzOTt6tmXc5BV1NJ/z/
        0WC2affrmmlOK3e/PzTpttXn6qXmulu/rNQIv7hoY8O0G0dmbn/cael3Vjab4d2/jBsNS9O5
        L048cHGP1XsLnz2fH7gcWa0zp7bz9zwxuY/Lhbuma8pu/v/3q/ecst684071pT/4ZrZx+52V
        5i4rivrlVz/36FHBvmtq94Q5tZVYijMSDbWYi4oTASnenW9mAwAA
X-CMS-MailID: 20220825054823uscas1p2ef2ed3d5951da7f384d3fe646293ab05
CMS-TYPE: 301P
X-CMS-RootMailID: 20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0
References: <CGME20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0@uscas1p1.samsung.com>
        <20220822170510.125082-1-a.manzanares@samsung.com>
        <20220822171703.sfizbmn6retpxggi@offworld>
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

On Mon, Aug 22, 2022 at 10:17:03AM -0700, Davidlohr Bueso wrote:
> On Mon, 22 Aug 2022, Adam Manzanares wrote:
>=20
> > When reviewing the CFMWS parsing code that deals with the HDM decoders,
> > I noticed a couple of magic numbers. This commit replaces these magic n=
umbers
> > with constants defined by the CXL 2.0 specification.
>=20
> Please use 3.0 spec :)
>=20
> Actually the whole drivers/cxl/* could use updating the comments for 3.0.
>=20
> > Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
> > ---
> > drivers/cxl/cxl.h | 11 +++++++----
> > 1 file changed, 7 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index f680450f0b16..ba3a66b5b9cd 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -61,6 +61,10 @@
> > #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> > #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
> >=20
> > +/* HDM decoder control register constants CXL 2.0 8.2.5.12.7 */
>=20
> This now becomes 8.2.4.19.7.
>=20
> > +#define CXL_DECODER_MIN_GRANULARITY 256
> > +#define CXL_DECODER_MAX_GRANULARITY_ORDER 6
>=20
> Considering there is a single user, I don't think we need to add
> the CXL_DECODER_MAX_GRANULARITY_ORDER. And if a new one is added
> it would be better to keep symmetry (bytes) and just do
> CXL_DECODER_MAX_GRANULARITY, but that's probably the reason why
> it doesn't exist in the first place.

I wasn't so worried about the single user. I was hoping to give some additi=
onal
context for the constants used in the granularity calculations.=20

Given Dans suggestion for the name change are you more comfortable with the=
=20
proposed change. If not, feel free to suggest an alternative to eliminate t=
he
magic number.

>=20
> > +
> > static inline int cxl_hdm_decoder_count(u32 cap_hdr)
> > {
> > 	int val =3D FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
> > @@ -71,9 +75,9 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
> > /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> > static inline int cxl_to_granularity(u16 ig, unsigned int *val)
> > {
> > -	if (ig > 6)
> > +	if (ig > CXL_DECODER_MAX_GRANULARITY_ORDER)
> > 		return -EINVAL;
> > -	*val =3D 256 << ig;
> > +	*val =3D CXL_DECODER_MIN_GRANULARITY << ig;
> > 	return 0;
> > }
> >=20
> > @@ -96,7 +100,7 @@ static inline int cxl_to_ways(u8 eniw, unsigned int =
*val)
> >=20
> > static inline int granularity_to_cxl(int g, u16 *ig)
> > {
> > -	if (g > SZ_16K || g < 256 || !is_power_of_2(g))
> > +	if (g > SZ_16K || g < CXL_DECODER_MIN_GRANULARITY || !is_power_of_2(g=
))
>=20
> Looks good.
>=20
> Thanks,
> Davidlohr=
