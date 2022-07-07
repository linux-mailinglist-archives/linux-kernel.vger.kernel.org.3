Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129EF56A037
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiGGKn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiGGKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:43:23 -0400
X-Greylist: delayed 1033 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 03:43:22 PDT
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5DD33A38;
        Thu,  7 Jul 2022 03:43:21 -0700 (PDT)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2679r5N4028262;
        Thu, 7 Jul 2022 10:25:54 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3h5v4jrxp4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 10:25:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QafqqYUSY55ZT3hkzo2FGLmzPy1XfKsaYLbVdp9Lt/U9zWOTTnHbM/CkNoL6SuqWgs01Y1gMRqznfn01G1xQ07KEcjGqlToAQrRSwXR2JstbzS6E/58LkCjnN6T5vgbjkgvsdyWb03bDZRzCKQwBI3UX1O9Mqo4YPWJ0Z8fJzNUvdNa/3qI6tpT4l7RehTDtqVugcgLOdBJ5GWImTPqu69t8w3f26pmncpC0AR+ual0p4xrRFz8zkjCulgVDst9CRBlSIgi34Ay8KHZG42k0mLoC1fhe2489SQ/DE7JE9WpdcAMRPaebxnvfLIl5Hh3gKoOTGiBKsrSVq+qe0zBkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nbj9O2STiP0ZVjHaen0OOMKkny04OYQ971tIntTnNgI=;
 b=j/99qsa7ImSxqo8br9mVsTwmdHPhRziwarUmIhS6kLxf7dbIJzZjHfZWXLUjvwXMr3xUVOmxBhZJ+/Zqz25twgikboOqWctZD/IOaW4CSc3NcO1VaEmfMSBEUIyYrVmKs/UswRsadUhFI3qfl+aTbfRCUzybhiqbMXgZsBRxj8cNRipaWRUsVXLQHB/eQV6ylkQWbA4M4xv6zLREMylnYCeNutR+UEzotM0Qx/93Ycl42BuJrGM/1jpH4EmSVBkqKEejfr5SYsN46HS6oPbRkdUiX0vj3JSQV7c24dkXlVmZKezLV+l3KqC6uvEntBoN5Rl5UjoD2VUxFVNKsnMAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nbj9O2STiP0ZVjHaen0OOMKkny04OYQ971tIntTnNgI=;
 b=cKH6Vtt2eb10EqBF8ehADbm97sK4q25ahqnnudQvlGwjVukH24ehVpyTlbykCQsMs2x7zb4ms0ogPcE6QYP5DReV2QSD58hdT8QAx2hiSaatmyfOQzDtTO26MrrrxvbtJl7u+hCYiowqcqTLmnJHVds7NCZwltp0PqzRvL5F1U1mTR8GlCK87nC7it4XXAkjDL0T54R3MQj0oeoJq5nhXMojjRhwoQVOF9NtqncsC2gU+1U7jiOdHDGPIFXPrZ0G/r2rcrwmmWJkDcj8R7o+ajfNzmPwXrunmbX3fYDRa9D2GPApORI4h0mRYtNKEY/JqqJZAz7n0VgAitdHb1G5ww==
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
Subject: [PATCH v4 2/2] dt-bindings: Update scmi node description
Thread-Topic: [PATCH v4 2/2] dt-bindings: Update scmi node description
Thread-Index: AQHYkevVP3S32fpdeUiTm/voQggjvw==
Date:   Thu, 7 Jul 2022 10:25:09 +0000
Message-ID: <f7386e5cca4e7f53bab3d6d4272f1d2f28a2f2b9.1657187536.git.oleksii_moisieiev@epam.com>
References: <cover.1657187536.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1657187536.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77cf61b7-000a-4817-8da6-08da6002f844
x-ms-traffictypediagnostic: DB8PR03MB6012:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+L1Lh8m6v/xc9G6H0/M5kuV7Ez/IUlSnrw1iK0+KP3ecxvdOelsY3zqrFeYsP501gev29BKeRNclxUs05SFr/vE2p44S2PY6Oub7fyzUlQLv/Iqp7HMzFM39AUAHGPGYlK567xXKdT0GzOGC2QiglPNogShdYJ8eARGNKnTc74tlDi52X52e7gdYqnUuJniL6zsZ+bWNSb/8C8nQbmR1GR6EmIorefs1mJLHr9/M3Gdhq8TZck6IUVYQCvRyt8Vr73zeQJLfpqr+oCDECKOISiEqghrokdk9kEl9WCpW8CeLuIpKPyhXUgj/RW34PYF11aDDw6ngu4iZkDL/FYM3anD6JjieRmySfdVaGukudlg5LLe0Gg5biiMUEvHGEMn9o9GlpEtMZjOC02Ul00sIQBkUsCQ9JLj8n/jsWD4SXWMRG9W14WvgtRKr/SRrvrdcO1OHEJ3IMne9VxqkpAh3eG12UuCwVq6Bb++sYC0cEQZuLx9Q0QCo2FxNXQE37c/zG0ujj0DRnBTXtY7+OZxQ8Qqz8Lf5N0T3w935fOL8zFY1Saa2/xxKX2EyguSED+CGHB1NaIfYdysBFd+ZDyipanTLnPoS0QlGSNqRJFRfOt99Idqj6i2tZAxa6GSj8cZ6mH7m4X3pb5BiL8q2e430+E3yhDqZTalD09CrH5EKdUrEytizXVDrdfkKZkrQQokvRsrfb9Xw6Z89/36JE+47IEexkfUaJxhVQP5QXBgunJL39xgzmWGJTIEQj9d4gq8TWcGDl/XSiOLjRM6zQi6g4HlOB1+mZh7lXwlD6fRhvBZHkuBDg7CRWRyQHE3+MHX2GekSjstdWF+7PqAnOlhECDbVnFu68/SHiJR40vUGyQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(41300700001)(26005)(55236004)(6506007)(122000001)(966005)(38070700005)(38100700002)(6512007)(86362001)(186003)(2616005)(7416002)(54906003)(4326008)(2906002)(8936002)(66476007)(8676002)(66556008)(66946007)(316002)(76116006)(91956017)(478600001)(5660300002)(15650500001)(6486002)(36756003)(71200400001)(64756008)(66446008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c89kT+BjzYaCsmkJSsDL3/+zEAnQEqAE0LKgN8kSgEhweIbXZcdvUPFv+W?=
 =?iso-8859-1?Q?SAFGh3zR56gCNFSj3/lE8R93IvsWNOiS4RvMxT8PGDTg20ZHuJ0wf75Jiq?=
 =?iso-8859-1?Q?yM6twt+BciBCxZjzfk7CmZAXJP1aRnOn76Aaka3r0QE/dihUCtNrbWLFsg?=
 =?iso-8859-1?Q?ObtxL4BOTasN5K1RlASj0wqD4lwJUkcvQCDBCe6dHYs2TwEFL4pznUU8ol?=
 =?iso-8859-1?Q?UfBYB5o3q3rdqv9QjwSK5Cg+D2vZi034TTBQw5oSyZns9QJxmYDwtYIPY8?=
 =?iso-8859-1?Q?hjA/3/vnQ6JScgaAhLCppGUlYxyyyqjFXv0nyKdsQjk0GMfcKstDfCzWA+?=
 =?iso-8859-1?Q?jxurlxcMTVZlZ4RFgYkvWoHkq0RpnpJ+YIy+zd0GRJbrGWS9KczkzJje0V?=
 =?iso-8859-1?Q?9oQoM/iMqWxcsXLql6zpzmO60IHoJaIL/jXPA9XR0bTjbUYPZwG4sDBKy2?=
 =?iso-8859-1?Q?dRZ4c+r13mrzmkNFB1McW4qawm3dsUlaG9mS/0AoGpRDhzRty/G+GCQTAJ?=
 =?iso-8859-1?Q?6qlq83F5rUw4fS2+rRwclBf5Y5yEQybY/PUHst7Lx2aR6ZNMOa3HGxZhP1?=
 =?iso-8859-1?Q?GBLzhTeMvxRkC4z5WVXDe2WJUI3MVf2XR5QcssNccQpTolPPfR9AyPJOKG?=
 =?iso-8859-1?Q?6/SwHlx1A/GQmTxfrlJHcvV45ANxIYH3yANd24t9VsBckVqgrZIsT40UM4?=
 =?iso-8859-1?Q?SZsU+7am94pkUzNEDAuBrrGcfI/xK/iqFwQaoro/86SLqZnCaowPiqtvJA?=
 =?iso-8859-1?Q?O8Rtk+SOPBiGLpfHqY8H4RXqMA9SR5j24Osro8ZshgbF6s1VhLy9ujwvmc?=
 =?iso-8859-1?Q?yIlyzgRW2/LsjdWU6UoGt+OuAl1CqOuCrgRMFnz5IwOpRngOUIJZMotRKI?=
 =?iso-8859-1?Q?EpAWXA2VrRr/GkuN1Mj3dd4TifeN8I63HaAhf/ALjqYg01cCzfIKj/YG0R?=
 =?iso-8859-1?Q?0mr6Ije5ELpIfm+Xq9czSV8GZ2xNn8IMqWpV6DaI0fjy0N3Lm4X3gvTKKw?=
 =?iso-8859-1?Q?rI68kRiGYFIOCHSq/w9jGa0vRgh+R/RNL7F1B5mUocYFSNmBYPHs79DzNr?=
 =?iso-8859-1?Q?IP1ggMbkcZb0wLqxRBBFxulSfz0jGAIrOO+towq5reDBr9cSFnWqdlcd29?=
 =?iso-8859-1?Q?i2Ddl0eROA15mdYw22pjFy2yRhJRVjC+dFuTRyJWFEs+CP4Kz0+UFcMQ7G?=
 =?iso-8859-1?Q?g3eMPVzpiGAFAmzO4w75zVExIaVfwavbR6rDTDkLH08VB2VV98BpBCxzWO?=
 =?iso-8859-1?Q?jBJHlpt7idVMnYc2CjSUCpdMMo22BSftOjeBq2//jXAJby0wnNc5DABur/?=
 =?iso-8859-1?Q?oSTZvKaymFxI/fRE4YkLZIKkQgEZJOIuB/6ewATgBsF6Wf/CS4TsqkEfhm?=
 =?iso-8859-1?Q?YBMwGXIyTD6TQDWHMKE9gX/rPl5vC3W7zD8YqEXQrgQLfkqrxCVYkcO9lS?=
 =?iso-8859-1?Q?OptBVIHzb3/LyK+OW6wdbbPnAg0AfcsE76GAvetk7IsekWC7HpU0keWJ0v?=
 =?iso-8859-1?Q?HZV+FaXW7Ex20Q8cFGoBZrhGm51qW7M1STYBaRxksfwVu4t0tPyA6B0Bp/?=
 =?iso-8859-1?Q?fjNso0xjlKP5Mu2Pk7K8gYGraZq7p9sExKmtleuOMgT7NLWpmKPcRYM0h8?=
 =?iso-8859-1?Q?eRS9Ef9/Lvm2YPGfjHVJ+CQTrYM5TlL1kBqVkjCZQw1o9bvSO9JN67EQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cf61b7-000a-4817-8da6-08da6002f844
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 10:25:09.6226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y7Uov1Og0p+6H5PFT7hyKM/JaI5xp3S1Z3AzhF0FqiYzFp7qrdveEtGfLdB4lA5gAqCd6LW3vGttg/tP4aZ8+8FqATfT8PIcwKUauquMw5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6012
X-Proofpoint-GUID: 4DbTVCgKy27472BTsQhGMLYzCWXV_-Ke
X-Proofpoint-ORIG-GUID: 4DbTVCgKy27472BTsQhGMLYzCWXV_-Ke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_08,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=856
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

Add '#domain-cells' property description to the scmi node.
This property makes scmi node as domain controller provider, which allows
consumers to provide scmi node with the device_ids of the devices, which ar=
e
using scmi protocols to control clocks/resets/power-domains etc.
The device_ids could be used to set the device permissions for the
Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of [0]).
Device permissions management described in DEN 0056, Section 4.2.2.10 [0].

For SCMI this property is used by Trusted Agent to set the device permissio=
ns
for the Non-Trusted Agents.
Trusted and non-trusted Agent terms described in Section 4.1.1 [0].

[0] https://developer.arm.com/documentation/den0056/latest

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
Changes v1 -> V2:
   - update parameter name, made it xen-specific
   - add xen vendor bindings

Changes V2 -> V3:
   - update parameter name, make it generic
   - update parameter format, add link to controller
   - do not include xen vendor bindings as already upstreamed

Changes V3 -> V4:
   - introduce domain controller provider/consumer device tree bindings
   - making scmi node to act as domain controller provider when the
     device permissions should be configured
---
 .../bindings/firmware/arm,scmi.yaml           | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Doc=
umentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5c4c6782e052..89589ed81b4e 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -78,6 +78,14 @@ properties:
   '#size-cells':
     const: 0
=20
+  '#domain-cells':
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Number of cells in a domain controller specifier.
+      Set const to 1 here for nodes providing the device id, needed for
+      the BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of [0]).
+    const: 1
+
   arm,smc-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -344,4 +352,21 @@ examples:
         };
     };
=20
+  - |
+    firmware {
+        scmi_link: scmi {
+            compatible =3D "arm,scmi-smc";
+            shmem =3D <&cpu_scp_lpri0 &cpu_scp_lpri1>;
+            arm,smc-id =3D <0xc3000001>;
+
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+            #domain-cells =3D <1>;
+        };
+    };
+
+    foo@0 {
+      reg =3D <0x0 0x10>;
+      domain-0 =3D <&scmi_link 1>;
+    };
 ...
--=20
2.27.0
