Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF015A56A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiH2WD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiH2WDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:03:25 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DAE66A50;
        Mon, 29 Aug 2022 15:03:20 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220829220316usoutp01dc2d8f865c2c8bdb3986bbd6d1cd1108~P7_7O3oX91779517795usoutp01r;
        Mon, 29 Aug 2022 22:03:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220829220316usoutp01dc2d8f865c2c8bdb3986bbd6d1cd1108~P7_7O3oX91779517795usoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661810596;
        bh=5epiZwNsV5DTxYYzTvQbIdvXjTK1eNeWQnuKWHX5CHo=;
        h=From:To:CC:Subject:Date:References:From;
        b=cn+KqSH+eWkAqJGEd1NOsMb5DSnY6GRvXBihabV6ufuELP9QgbKnt4nzBun/nXJLl
         c4blhzD5CdOSjyd6udBBcfsUAcdVQEWOtYh7yYXQ+UVnTLq3VFxMRzDWEOwU38eDZK
         hJ+Ed1zxKEQhoijI9+qJNLY7Ki88R368+wYBwhoQ=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220829220316uscas1p1280f1848006893c74386a871251dcd5d~P7_66BL4N0899708997uscas1p1M;
        Mon, 29 Aug 2022 22:03:16 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 4F.C3.35398.3A73D036; Mon,
        29 Aug 2022 18:03:16 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220829220315uscas1p125d01bdd52a7aa6fd07c26bef7ead825~P7_6gfYOn0445304453uscas1p1H;
        Mon, 29 Aug 2022 22:03:15 +0000 (GMT)
X-AuditID: cbfec370-817ff70000028a46-40-630d37a31de2
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 70.0D.08434.3A73D036; Mon,
        29 Aug 2022 18:03:15 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 29 Aug 2022 15:03:14 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Mon,
        29 Aug 2022 15:03:14 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Adam Manzanares" <a.manzanares@samsung.com>
Subject: [PATCH v2] cxl: Replace HDM decoder granularity magic numbers
Thread-Topic: [PATCH v2] cxl: Replace HDM decoder granularity magic numbers
Thread-Index: AQHYu/MjWtJoVeCJUEGjhX9Fa44LTg==
Date:   Mon, 29 Aug 2022 22:03:14 +0000
Message-ID: <20220829220249.243888-1-a.manzanares@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djX87pLzHmTDc4HWNx9fIHNonnyYkaL
        6VMvMFqsvrmG0WL/0+csFqsWXmOzOD/rFIvF5V1z2CxuTTjG5MDp0XLkLavH4j0vmTw2repk
        85g6u97j8ya5ANYoLpuU1JzMstQifbsEroxnVxYzF9zir1iyey5LA+Nvni5GTg4JAROJC/M7
        2LoYuTiEBFYySjz71MoM4bQySby/eZodpurxxfmsILaQwFpGiaMTRSHsT4wSdzdVQTQsY5R4
        /nQ3E0iCTcBA4vfxjWCTRAS+Mkns2LuSEcRhFljDKLH4US8LSJWwgJtE85EZYB0iAt4Suy51
        s0HYehLrDvwCs1kEVCXe39nGDGLzCthJdH6YwAhiMwqISXw/tQasl1lAXOLWk/lMEKcKSiya
        vYcZwhaT+LfrIRuErShx//tLdoh6PYkbU6ewQdjaEssWvoaaLyhxcuYTFoh6SYmDK26wgBwt
        IXCAQ+L/v/lQg1wkvj6/B7VAWuLv3WVMEEXtjBIfJuxjhXAmMErcefsTqsNa4l/nNajVfBJ/
        fz0CeoEDKM4r0dEmNIFRaRaSJ2YhOXAWkgNnITlwASPLKkbx0uLi3PTUYuO81HK94sTc4tK8
        dL3k/NxNjMDkdPrf4YIdjLdufdQ7xMjEwXiIUYKDWUmE9/s5nmQh3pTEyqrUovz4otKc1OJD
        jNIcLErivMsyNyQKCaQnlqRmp6YWpBbBZJk4OKUamPjvVHZWfxGT7mjU/6X3U/3RLK91k6qE
        7y/hLlJSrmg+UqwrvmatU0L8/mNXp/P/fLGl2178bumLe9OEFzxcqn/3xLS4gGnT2g/Uds5t
        WapdHr445tyEzOUGbEVVYfMqlPbtSHklvI35iYn90mUrw28vFbzce/HrXw71vjvljFMOLrdt
        /h65t9ryXRP72aC8KbpWl9ZeMvml7j3RuSl4keTr7FqJ/UkfbCIPdeq+sJt4wvTrF+cVbasP
        OGY1fk6+1bHeafNFJZ3YlX+3BE85s0/mMdv6HV9utepafPzz/vKzCVtULRRmqa20e2y1SNF+
        ccQ2a0HT9dX3XSbGpDT4O0ddZQ78v8VN9VBQc7b27/lKLMUZiYZazEXFiQA0nod0vQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWS2cA0UXexOW+ywZ4mZYu7jy+wWTRPXsxo
        MX3qBUaL1TfXMFrsf/qcxWLVwmtsFudnnWKxuLxrDpvFrQnHmBw4PVqOvGX1WLznJZPHplWd
        bB5TZ9d7fN4kF8AaxWWTkpqTWZZapG+XwJXx7Mpi5oJb/BVLds9laWD8zdPFyMkhIWAi8fji
        fNYuRi4OIYHVjBKvH95ngnA+MUp8m/OZGcJZxiixZusWZpAWNgEDid/HN4IlRAS+Mkns2LuS
        EcRhFljDKLH4US8LSJWwgJtE85EZTCC2iIC3xK5L3WwQtp7EugO/wGwWAVWJ93e2gU3lFbCT
        6PwwgRHEZhQQk/h+ag1YL7OAuMStJ/OZII4VkFiy5zwzhC0q8fLxP1YIW1Hi/veX7BD1ehI3
        pk5hg7C1JZYtfA01X1Di5MwnLBD1khIHV9xgmcAoOgvJillI2mchaZ+FpH0BI8sqRvHS4uLc
        9Ipio7zUcr3ixNzi0rx0veT83E2MwJg8/e9w9A7G27c+6h1iZOJgPMQowcGsJML7/RxPshBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHel1ET44UE0hNLUrNTUwtSi2CyTBycUg1Mnid+TX/cvtbh
        g/sqUSWzz+frbna3NUgL2ivYcqbzqyxe3Bzh+DZx2x83Pptfr43ulkpv9/3KWv1q6lHuVsf4
        2PMHDNIuGe5asHrrxGvTouosjuQsPKu5boLWDK1JOx+UuClO8MgrXDRnUpMzm4TtdF+x0AZ7
        v9Lb2/etlD924NL3pUy2ZYerGubOWPG15KjcNO5WX9bNv655esTu7ToiwJ2jVaVut2jaxdiH
        6dtcldcvUip2URWQ8Tt9ov1NM4OgjNTj8A0fT4Qv/Kb7V6Xm2duVurlxmaGSShlHll+J/pMa
        vvQo082GhOT3ux5sSJu0t+oN6yL+jW1/T06/28SZ94N3XSKXWXzlzkczbFY2KbEUZyQaajEX
        FScCALtFYrI4AwAA
X-CMS-MailID: 20220829220315uscas1p125d01bdd52a7aa6fd07c26bef7ead825
CMS-TYPE: 301P
X-CMS-RootMailID: 20220829220315uscas1p125d01bdd52a7aa6fd07c26bef7ead825
References: <CGME20220829220315uscas1p125d01bdd52a7aa6fd07c26bef7ead825@uscas1p1.samsung.com>
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
with constants defined by the CXL 3.0 specification.

v2:
 - Change references to CXL 3.0 specification (David)
 - CXL_DECODER_MAX_GRANULARITY_ORDER -> CXL_DECODER_MAX_ENCODED_IG (Dan)

Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
---
 drivers/cxl/cxl.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..3ab81ad9d2e5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -61,6 +61,10 @@
 #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
 #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
=20
+/* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
+#define CXL_DECODER_MIN_GRANULARITY 256
+#define CXL_DECODER_MAX_ENCODED_IG 6
+
 static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 {
 	int val =3D FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
@@ -71,9 +75,9 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
 static inline int cxl_to_granularity(u16 ig, unsigned int *val)
 {
-	if (ig > 6)
+	if (ig > CXL_DECODER_MAX_ENCODED_IG)
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
