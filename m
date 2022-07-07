Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D429656A08F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiGGK5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiGGK5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:57:15 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A291957226;
        Thu,  7 Jul 2022 03:57:14 -0700 (PDT)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2679r5Ms028262;
        Thu, 7 Jul 2022 10:25:51 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3h5v4jrxp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 10:25:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9WCASTF7szgHWAnnYq8efcfdtxzeapOA9nH31cL7LeTqRl/R2Jdq1DhOByUY3+DkSNw/nth9kxnXcbNRu/OXan+fvMSax78YJlmD0Ep5d4wKq/+s9trRLXlcqmLFx2a6XmfiLcFyntVm9xao/AyfQSGMAYOKaiOAitGilVSKF1x/xeto+N5q2Tdkegfd0tUWTo7wxRPhmFObvXRrA31f7Tsp2b0TAnGojp8eumEXOb4KrSd0tiIN+dNnMtzCWFP3vHwwcM3QGcVIsjlNrgLIYOtHcEr0apoILyuwwP3VRVQCiOSx3z+hNAxGPd5nOaLf/ym+AZX7RLCCjMLqPlXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i4n9bzbQSxSqRiYueybYy7ss6b0iVjA0S/VRo881xM=;
 b=Vk07ofYjIilkUMWmrUzuD20IXWEH2wFq+UCw0OXDFNEbX7VV2iZWW6OblEhb+iatkVyqZ7fJ7avy1CegQ9V941t08sGCA1YDxJjrE5f12pQHFqVuyd1cFh5hHonDY5WMaUfWSaU3MnXhzpM8z23LECkPSrMZ64vFYpgUMxaGbndnbJdzrhLkgTe3hxsVYHRyxUPM53q6oFNmE2WhFco8uBdZeYdMhbXfVcA8rOIUyZVEehNvWXSUSD1KLUZlljcjFkTJuQMnSZpHQMvqCF4CT+5+8hoim5w79cc00UC6pujRT+dE6oiJFZxXhYkGFjxy2HWYJd4aIEscadRI4Mr5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i4n9bzbQSxSqRiYueybYy7ss6b0iVjA0S/VRo881xM=;
 b=L7mHnZz9WSaq41HVEs5PJwPtO852sY5JhCZRX0MZHkztPnG/1mNvutO1/RuNZrEt7CbMEbsURR6FaSgOF4oLKobVqGJutPygSg4cU0aPndaATxJcBavVOklZMZX0nnwCiJpT9dlHx7BLbwNr6CZnJV03Q9a13yvZbhARHFSdCjBHmS6A/cPVfvFWpTcRpqU67NBgryBMwjKZ/VSe2fAakHt5bYBaxMmK68krmJsQk6VDXtE2ukm/4qBOQUV0I18ZwKo4lMr47ax4PAcvOpR8NT4BAU1MbRfZrO35TPY4w2VAOdOt9U6WdUJLYUDFwllqNXYuxee6TEh7M6WM/dm+7g==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB8PR03MB6012.eurprd03.prod.outlook.com (2603:10a6:10:ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 10:25:09 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2d63:5490:24b9:415b]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2d63:5490:24b9:415b%9]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 10:25:09 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        "benjamin.gaignard@st.com" <benjamin.gaignard@st.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: Document common device controller
 bindings
Thread-Topic: [PATCH v4 1/2] dt-bindings: Document common device controller
 bindings
Thread-Index: AQHYkevV3fgkseHGNEO5BLWgEntWmA==
Date:   Thu, 7 Jul 2022 10:25:09 +0000
Message-ID: <0215e92bedd7f058b84bbc64d454d76f2d7b7366.1657187536.git.oleksii_moisieiev@epam.com>
References: <cover.1657187536.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1657187536.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 212e40ce-d55c-4f9e-b5bd-08da6002f814
x-ms-traffictypediagnostic: DB8PR03MB6012:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YhFNx/8fzk7u7lXzJPfch7gDQbzi5QNtOGt8vmTO0xvHbkYQ5rSiYrmSafeQawqCRvo3DTCXORLi0azDIDyjDRJ9CsIg27HkbUFS1KS5L+TAebSTGnjU10jPoUJJqDSdmacXKwJDE9FzJtIrtdBvNlxSMlJt88BNRImenZCUk+6qOcgqRDAJ34sLvwlzLVOhdCixXAnokAzLxda20Pe+zsH6Aiut6fJOf8g/Jipinf0x0TlK29o4ipXfR2nIP0T5CBQesETd44/6q23k5Fnjarzb6hZmeyJbcK3AH0LQyW16BI45Cp47VMVoZAanumRxNTFmlqRLLAM6IQztSl7Hf7iRhKnpGMkUUd6WsvTFe0o+nSwyayr3GYBfh1/DQmEmoEtgdQsUMvLmGVXUo/pfLaN/gjm18rx9rve90OKUUKNsyyV3sDWscdpyg38WfdA3Nu06gdw03FQDCDSwowABHNaB4mBZHdGyv2n9l9ij6ulbU7fbdI+40JZHAVqm1tedQnAYPwNaMZ7bLiI9U0omQDqfNIp3TR4Q13JPj7+XufN15nckfAfAxaiB16ToDfmnZA1Z6lcdqLLPnf6MGIAwQu+OvhNGIn14MBUs4zEBdK/zBk5ezBYrkRA7J1L1xQPIJat950uuzER3Wy9GzRu7lH7B5Gsp2i/xKuGedrx47chLf5aCabeF0PBBjHXe4fS8smyHKK+Glo0R9t4ysxdil70bWLRzQPISwVGKNHgVmZtisIxxPuNQZO1FomoTYHRNkeokhA+i338+iyfa/nhyDRKFs2ph8JPk8Hz7Uyh10f1LpBcXIuqSuDe5k1AwseKVKZZ8gxhLjfLKRsY6gB078BpnBJhkInJD8S5s9MnRgi0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(41300700001)(26005)(55236004)(6506007)(122000001)(966005)(38070700005)(38100700002)(6512007)(86362001)(186003)(2616005)(7416002)(54906003)(4326008)(2906002)(8936002)(66476007)(8676002)(66556008)(66946007)(316002)(76116006)(91956017)(478600001)(5660300002)(6486002)(36756003)(71200400001)(64756008)(66446008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?heWHMtGK+3bqaKiFgEmyNk25RdyJvCA9UCIAidI3z+KRn8Dxnv6Rh+rC8N?=
 =?iso-8859-1?Q?qNiRtM25WaZGLhOEUsc/0q3IKh9sQUGEXiLkWOV0IHDiSdshVGMp0mvbjt?=
 =?iso-8859-1?Q?Pg8Sq/1LiXxoKZTbEoDtKbgLXxJIQaPGEkqjz3kahnw1ZCopM3wOSA5LiH?=
 =?iso-8859-1?Q?3cDZmoQbsMO/M9cKKi/Sz5Ej/WJ3SdHRSfVWt03+M1eVmfsYQkNZ0D+8gQ?=
 =?iso-8859-1?Q?yemd8YhHy7lci907ir2mj4ZwWaKGmLqdJtP3epMqNxp+dUZKzGXJRIsDie?=
 =?iso-8859-1?Q?8bqL0WNM0H4IvbsOxtqsmEXQUHGrouR7ildZ3MfPT7K2bEU8LUbMvU85M+?=
 =?iso-8859-1?Q?A7anM2ctZVGsA9yd+5FbocQeFloZImJujcsFZ51eayvR11K3wF5j5xAjzr?=
 =?iso-8859-1?Q?auCHkHquxKHxU45SuSmlrYuBCkRtPGHK4D1sYlOpcdrlRqW8qKR0+ioP2j?=
 =?iso-8859-1?Q?XondDV9Auq+2d22kTrRBNvULnAkB66Oe/XAYYdJq7RJ/9ox5ZgMDSn4LAJ?=
 =?iso-8859-1?Q?BVYJuAeUWlCH9CW0J73vM7I8kotU/+YcKepsXPPs8XSRCKiSwmlMMyyEHy?=
 =?iso-8859-1?Q?qOzDIDhvEbtitP4BD3b0JvxJp5VBc26C/+4dpTQ2z+u3V6abOEnff1ZkR7?=
 =?iso-8859-1?Q?Nsf4cn6NiNlvE5lJSLMjtJ+3phmaSvEUTewcM9l1FW3eqtr+w63ofSqpZH?=
 =?iso-8859-1?Q?hjE0PZWvgK9MDoHqplXZYvRk38xVc/vOdgRC9yhZnJe3x7shicS3MBeifZ?=
 =?iso-8859-1?Q?UMizRlzoW+T8jO1WORS0TtbSRGtfz8VS9Qui9V2UR4vHU4lguiNt0GhVYh?=
 =?iso-8859-1?Q?Yy8rm6Sknp52JsjBJllO/8P3P4fF0F6sr0BqkqMLwBaxKnJXoFzyMoYnmo?=
 =?iso-8859-1?Q?C8Hsn+pb9v29rG498kzOzmcoEoFSew3FtZWhCvWIC2WM3TvLpvneuAaMwz?=
 =?iso-8859-1?Q?F1sQllv91ulpElchMmLFga9E7T+CCT5UkeADJP2V2TS3EwSR6P7I02LfPg?=
 =?iso-8859-1?Q?onZuErxrfyBd2qOXBxKvHlkt2rDjc1vUx7DYeRMq9pGMiSnvnvckUQgWqs?=
 =?iso-8859-1?Q?FYcXvR9csTIhOLVK8oa3Esr5fj/2GM5LORgQJDLpYVWkUVoSFuuYFJlEBU?=
 =?iso-8859-1?Q?S4Xt+j+RX7yo7Q5C1p2RokMm1KmSYYO4dbdtwjUbTP3tseVAXJGz4p+iQX?=
 =?iso-8859-1?Q?3yxGBO1aYpN2OsdF2Q5cImqE9SM87m8CvPsEpphlN76ZaVFeZWeYPcDyqV?=
 =?iso-8859-1?Q?cpoJnEJKULtjt3DLVC2gc4TBcs4dDvXub9SX4ZAloVJByjjOEBv8kbr7Kk?=
 =?iso-8859-1?Q?LkiIA6GAHeQvKDiMdD6AYzq10kvqaBznFgS/+opbt6BfYECrMsmYUtZZHP?=
 =?iso-8859-1?Q?ivlawyh2OgWIA6P3Fl4pprCH4xhJ1HK4k+Iz6oi3CdkfubNjUA8GidU4wC?=
 =?iso-8859-1?Q?f372XKrdWYPlvL4KPMtBU0udOBA6idZFU9UCOi5CRLsJHDfkXTzCfKYZjG?=
 =?iso-8859-1?Q?xLq8Qjn6Y6AAWE7xFDAVs1D6uX9WFBtW0nPTJULg261Ja4h/wQi5ED8LzT?=
 =?iso-8859-1?Q?NtHLH9qE9Of84IGiqRsgaSY5YYOp2DUQi9zY6wdulH/7n+MPHl8xd4J5GO?=
 =?iso-8859-1?Q?sXU6sjavKNljuDaiX/WTe4jJ19BAh8nQxjI68+IwOTKnyS4ZNthd/SCA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212e40ce-d55c-4f9e-b5bd-08da6002f814
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 10:25:09.3092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ffYyhti+rkMHbYtNWwH+a42wffBulgwMdH1vZQy0A0aIB2ez+uN1FPDi3AlkgBSwk1Dwq4TFeuPUO7pz4PAwKPn6Ek9yoLVvriTCpbrBG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6012
X-Proofpoint-GUID: Yy4fs9-7PuVxtD9vNqakY5mv3X6C21Oc
X-Proofpoint-ORIG-GUID: Yy4fs9-7PuVxtD9vNqakY5mv3X6C21Oc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_08,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing of the common device controller bindings for the controller
provider and consumer devices. Those bindings are intended to allow
divided system on chip into muliple domains, that can be used to
configure hardware permissions.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 .../bindings/domains/domain-controller.yaml   | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/domains/domain-contro=
ller.yaml

diff --git a/Documentation/devicetree/bindings/domains/domain-controller.ya=
ml b/Documentation/devicetree/bindings/domains/domain-controller.yaml
new file mode 100644
index 000000000000..377fdf0c21fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/domains/domain-controller.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/domains/domain-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Domain Controller bindings
+
+maintainers:
+  - Oleksii Moisieiev <oleksii_moisieiev@epam.com>
+
+description: |+
+  Common Domains Controller bindings properties
+
+  Domain controllers allow to divided system on chip into multiple domains
+  that can be used to select by who hardware blocks could be accessed.
+  A domain could be a cluster of CPUs (or coprocessors), a range of addres=
ses
+  or a group of hardware blocks.
+
+  This device tree bindings can be used to bind domain consumer devices wi=
th
+  their domains provided by domain controllers. Domain controller provider=
 can
+  be represened by any node in the device tree and can provide one or more
+  configuration parameters, needed to control parameters of the consumer
+  device. A consumer node can refer to the provider by phandle and a set o=
f
+  phandle arguments, specified by '#domain-cells' property in the device
+  controller provider node.
+
+  Device controllers are typically used to set the permissions of the hard=
ware
+  block. The contents of the domain configuration properties are defined b=
y the
+  binding for the individual domain controller device.
+
+  Each node can be a consumer for the several providers. The first
+  configuration 'domain-0' or the one named 'default' is applied before pr=
obing
+  the device itself.
+
+# always select the core schema
+select: true
+
+properties:
+  '#domain-cells':
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of cells in a domain controller specifier;
+      Can be any value as specified by device tree binding documentation
+      of a particular provider.
+
+  domain-names:
+    $ref: '/schemas/types.yaml#/definitions/string-array'
+    maxItems: 9
+    description:
+      A list of domain name string, sorted in the same order as domain-X
+      properties. Consumer drivers will use domain-names to match with
+      existing domain specifiers.
+
+patternProperties:
+  "domain-[0-9]":
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description:
+      A list of domain controller specifiers, as defined by the bindings o=
f
+      the domain controller provider.
+
+additionalProperties: true
+
+examples:
+  - |
+    ctrl0: ctrl@100 {
+        reg =3D <0x100 0x10>;
+        #domain-cells =3D <2>;
+    };
+
+    ctrl1: ctrl@110 {
+        reg =3D <0x110 0x10>;
+        #domain-cells =3D <3>;
+    };
+
+    foo@0 {
+        reg =3D <0x0 0x1>;
+        domains-names =3D "default", "unbind";
+        domain-0 =3D <&ctrl0 1 2>, <&ctrl1 3 4 5>;
+        domain-1 =3D <&ctrl0 6 7>, <&ctrl1 8 9 0>;
+    };
--=20
2.27.0
