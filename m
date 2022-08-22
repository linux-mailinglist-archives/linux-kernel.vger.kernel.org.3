Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F8F59C49F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiHVRGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiHVRF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:05:59 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24CA3ECD1;
        Mon, 22 Aug 2022 10:05:56 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220822170553usoutp0110887cd4535a13af7f67c00824a28d34~NuaRoeXj_2782127821usoutp01-;
        Mon, 22 Aug 2022 17:05:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220822170553usoutp0110887cd4535a13af7f67c00824a28d34~NuaRoeXj_2782127821usoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661187953;
        bh=Bnxw5tMzchxMfhsqVWLqqRcZgO5MyayK/AJWfjtP/qo=;
        h=From:To:CC:Subject:Date:References:From;
        b=katzimIeGn2ViS84TTfFXch/X1YmrdG5+sQJwSFYoXK0QzodJV2/ERTu0VyX21W61
         LztUHJAIluTTUF0tlNWPu9/1iuaUnOb6gyU3KYfuPz5tVKjuNBQ2Vyjs2bu2BN841l
         hUANwiC2Ca/sE7VsgBtajPgwURSlSwVA6srBLT/s=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220822170552uscas1p1be94269293097026847ed264b653c2d8~NuaRQQ--V2902129021uscas1p1A;
        Mon, 22 Aug 2022 17:05:52 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 71.2C.65516.077B3036; Mon,
        22 Aug 2022 13:05:52 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0~NuaQ9bHrZ2964029640uscas1p1H;
        Mon, 22 Aug 2022 17:05:52 +0000 (GMT)
X-AuditID: cbfec36d-5b5ff7000000ffec-79-6303b770e120
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id F2.E3.59738.077B3036; Mon,
        22 Aug 2022 13:05:52 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 22 Aug 2022 10:05:51 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Mon,
        22 Aug 2022 10:05:51 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "widawsk@kernel.org" <widawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "dave@stgolabs.net" <dave@stgolabs.net>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: [PATCH] cxl: Replace HDM decoder granularity magic numbers
Thread-Topic: [PATCH] cxl: Replace HDM decoder granularity magic numbers
Thread-Index: AQHYtklu6j3UH4AVtU69YQX5WSmWHw==
Date:   Mon, 22 Aug 2022 17:05:51 +0000
Message-ID: <20220822170510.125082-1-a.manzanares@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djXc7oF25mTDfr+GlvcfXyBzWL61AuM
        FqtvrmG02P/0OYvFqoXX2CzOzzrFYnF51xw2i1sTjjFZbH4wmcmB06PlyFtWj8V7XjJ5bFrV
        yeYxdXa9x+dNcgGsUVw2Kak5mWWpRfp2CVwZb6/tYSl4wFfxqHstawPjNJ4uRk4OCQETiS0d
        Pxm7GLk4hARWMkps2L6bHcJpZZJ43r+MBaZq8sQHUFVrGSV+vrvJBuF8YpQ4+OQcK4SzjFFi
        48kedpAWNgEDid/HNzKD2CICnUwS3TckQWxmgUlMEjObs7oYOTiEBZwlfl1RhyjxkDg0/yYL
        hK0nMen7NDYQm0VAVaJ97XewOK+AnUTb3seMIDajgJjE91NrmCBGikvcejKfCeJSQYlFs/cw
        Q9hiEv92PWSDsBUl7n9/yQ5RrydxY+oUNghbW2LZwtfMEPMFJU7OfAL1saTEwRU3WED+khDY
        wyGx5N9tVoiEi8SnLfehbGmJq9enMkMUtTNKfJiwjxXCmcAoceftT6jV1hL/Oq9BreaT+Pvr
        ESPI9xICvBIdbUITGJVmIXliFpIDZyE5cBaSAxcwsqxiFC8tLs5NTy02zEst1ytOzC0uzUvX
        S87P3cQITE6n/x3O3cG449ZHvUOMTByMhxglOJiVRHirLzIkC/GmJFZWpRblxxeV5qQWH2KU
        5mBREuddlrkhUUggPbEkNTs1tSC1CCbLxMEp1cCUZ2Rk+eVoS/MG5Yf3Jmj2/tzyi/XBikyd
        7x27n1+M35WkLr2rUWBDPs9v99QV09d1i8zk/Hx7qtsS3cTjS/7ppEv0x2wu4Df4JrV63aq4
        wi45xbkJ1XOUxZ6mWRhlhb02D9ic7nhb/8OUJPbM2M8fF1/6vPEL64o/h6JXlDQ/WzHXr7nz
        WcdtLwaLsqe3n/3l+RJ6Q1/S3FaX9f66eKEl/B6mKUu1zF+k8XTeOPXwgrie8aWUKP4DIrkb
        zI4dTO74uz20XuoSg9tJi8Ccli1172vssoxPfRHJuRlkd1HshYNljOUZpTMvNzHpy/Lla0VU
        bn3s9fh7d213+GnTyKnTVRubbgf4Gj48a3H90WwlluKMREMt5qLiRAB9nGCPvQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWS2cA0SbdgO3OyweUj8hZ3H19gs5g+9QKj
        xeqbaxgt9j99zmKxauE1Novzs06xWFzeNYfN4taEY0wWmx9MZnLg9Gg58pbVY/Gel0wem1Z1
        snlMnV3v8XmTXABrFJdNSmpOZllqkb5dAlfG22t7WAoe8FU86l7L2sA4jaeLkZNDQsBEYvLE
        B4xdjFwcQgKrGSWetDUyQTifGCW23JgOlVnGKPGz9yUzSAubgIHE7+MbwWwRgU4mie4bkiA2
        s8AkJomZzVldjBwcwgLOEr+uqEOUeEgcmn+TBcLWk5j0fRobiM0ioCrRvvY7WJxXwE6ibe9j
        RhCbUUBM4vupNUwQI8Ulbj2ZzwRxqYDEkj3nmSFsUYmXj/+xQtiKEve/v2SHqNeTuDF1ChuE
        rS2xbOFrZoj5ghInZz5hgaiXlDi44gbLBEbRWUhWzELSPgtJ+ywk7QsYWVYxipcWF+emVxQb
        5qWW6xUn5haX5qXrJefnbmIERuPpf4cjdzAevfVR7xAjEwfjIUYJDmYlEd7qiwzJQrwpiZVV
        qUX58UWlOanFhxilOViUxHmFXCfGCwmkJ5akZqemFqQWwWSZODilGphSAtx/LPet9Lhfk9Hh
        wX+3kJlDwVE3W3f/U7ubs7oL70m3vHjitn/XnyU6IsKOfTV1+0rWCO2efEHawi19t131W/uT
        97y51RI7WrQmnLt5f5HiARP7BK6jPre1Mm99v/T3qkOFRMOW/T93cfJ9+riHm7HiqHXoDCcV
        TtmSj2UNV5pmRNSdPNokbjfTUWN171SFRYq/9Iz5EyftYz5WcePXa2cGl3nrpprd7f5vuXiy
        9EErn/lp1r+0u32yTzLo71IR7z1Vertr6/KWBeEf3r/Zr1A2Xz5A4dmSy0pV93e/MLHxT7Iu
        +MQ4d7n6y7if02z6bCfnzzbav/qWwVO72I5fdzukBWTPHD93X1HOTV2JpTgj0VCLuag4EQAB
        HMF+NQMAAA==
X-CMS-MailID: 20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0
CMS-TYPE: 301P
X-CMS-RootMailID: 20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0
References: <CGME20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0@uscas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing the CFMWS parsing code that deals with the HDM decoders,
I noticed a couple of magic numbers. This commit replaces these magic numbe=
rs
with constants defined by the CXL 2.0 specification.

Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
---
 drivers/cxl/cxl.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..ba3a66b5b9cd 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -61,6 +61,10 @@
 #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
 #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
=20
+/* HDM decoder control register constants CXL 2.0 8.2.5.12.7 */
+#define CXL_DECODER_MIN_GRANULARITY 256
+#define CXL_DECODER_MAX_GRANULARITY_ORDER 6
+
 static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 {
 	int val =3D FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
@@ -71,9 +75,9 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
 static inline int cxl_to_granularity(u16 ig, unsigned int *val)
 {
-	if (ig > 6)
+	if (ig > CXL_DECODER_MAX_GRANULARITY_ORDER)
 		return -EINVAL;
-	*val =3D 256 << ig;
+	*val =3D CXL_DECODER_MIN_GRANULARITY << ig;
 	return 0;
 }
=20
@@ -96,7 +100,7 @@ static inline int cxl_to_ways(u8 eniw, unsigned int *val=
)
=20
 static inline int granularity_to_cxl(int g, u16 *ig)
 {
-	if (g > SZ_16K || g < 256 || !is_power_of_2(g))
+	if (g > SZ_16K || g < CXL_DECODER_MIN_GRANULARITY || !is_power_of_2(g))
 		return -EINVAL;
 	*ig =3D ilog2(g) - 8;
 	return 0;
@@ -248,7 +252,6 @@ enum cxl_decoder_type {
  */
 #define CXL_DECODER_MAX_INTERLEAVE 16
=20
-#define CXL_DECODER_MIN_GRANULARITY 256
=20
 /**
  * struct cxl_decoder - Common CXL HDM Decoder Attributes
--=20
2.35.1
