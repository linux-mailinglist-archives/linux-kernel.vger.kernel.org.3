Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FBD4B906B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiBPSkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:40:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiBPSkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:40:07 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0620F2ABD13;
        Wed, 16 Feb 2022 10:39:53 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21GFFhRr031935;
        Wed, 16 Feb 2022 18:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=uT0BuypPvB/Qp4jG1XQYFQQo8xXD9Y6Z+PQQ9CCh31A=;
 b=QdTnifi3hDVWbXrUoI1o+qTwneIa32OdLaWNRESjkvevBBO1OpJYnnLFWVxthLNCaNrG
 c4wC82m4CO+kv8Qd6z8bfUWEyvvoEgcSSqyexhv12a7OGq+QlIHd83sUzwNmFTtw7c8J
 oeppK/6iPRQTMIjU4JcRFGnCEjEl7HauDNV37tySV1+zaNtTZlrPgxjst3/7zSaGX79Y
 q02mi/H6910RaNet59RKgZSvisY50wFdQGVydAVM5ZZN7f8Ibc16cKUHR8+nxfdSCvaV
 ZxPfvGP/tlWKWXRkBBSnQjhL52NKKn8jwVnosQOgOBhUNYP9no0Tu3u2hZpGM3iDHbob Fg== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3e8x4yn6de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 18:39:44 +0000
Received: from G2W6310.americas.hpqcorp.net (g2w6310.austin.hp.com [16.197.64.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id F0A5B5C;
        Wed, 16 Feb 2022 18:39:43 +0000 (UTC)
Received: from G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) by
 G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 16 Feb 2022 18:39:40 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W8453.americas.hpqcorp.net (16.216.160.211) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23 via Frontend Transport; Wed, 16 Feb 2022 18:39:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXCYzk9UvwULX6nOicajPVA2qfZNubzTPvaIKwJVV/IsNk7eo/OnR+XDUofw+LsqLLPi9pFsRbXKUqQTf+GV1waKs0oZkzZ77i30pBg1exIVE9I2XqcbO/779NSC1w5RI8Ft6l3OrVgdxI9Ztey9YgZoM0dqKnyUfomet8lGZkmj/Qzm273PDS1HwsPsQHljD49MkXMVEu8RwbkLGNKALtKnxnm7xCAwZzdNCZdDqx9Ro82X3dD3ClVyePWdMSLdf037YTiiZWNdjiX0u4DR+HNtbn7H2q9iLhxTCPEsBDX9vFvuFhXqo5gZWR6cAooXWH7L8jT0FqUq27DLk6SBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uT0BuypPvB/Qp4jG1XQYFQQo8xXD9Y6Z+PQQ9CCh31A=;
 b=NlbivQtCu1DGex8Fm6pPTo/fQMbmLfvDH52fb0+QeM3WEr3HS2Ng/UIRQIgC6p1Bc2qYXbRweZhzo12Ejp6UN8OrJgdn0RWR9w4KMTJ+06yNWRFh/2Jd5SvleGNHXVgWbV8LCJZhy9VxTX+ZCVQoUvjP1cjt5N6ry5uIWX8lAiqkww7X7KVG/iDV9S6CT7XOlH0Vl5gIyZxT6aU0OzUa7S5/6a4DlIS3aDhx9kWYuVplBCZGNqhQGRXPXAcuAQJzRoN9DINEwD1LCsmSgWN1DedjkS+bd7Lc9Uq2S1WiWmvWUi2WBmB7c0fmMOVtqkFaeJ0bLINlI5E46I9Q2pLWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by PH0PR84MB1811.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:162::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 18:39:38 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c0d:ee00:1db5:4b32]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c0d:ee00:1db5:4b32%6]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 18:39:38 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     "Verdun, Jean-Marie" <verdun@hpe.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: soc: Add HPE GXP SOC binding
Thread-Topic: [PATCH] dt-bindings: soc: Add HPE GXP SOC binding
Thread-Index: AQHYI2DGsTWNxqoPk0CdfqSShu+HyKyWgdYg
Date:   Wed, 16 Feb 2022 18:39:38 +0000
Message-ID: <PH0PR84MB171896BF80AA6757C105EFC988359@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <nick.hawkins@hpe.com>
 <20220216181434.41682-1-nick.hawkins@hpe.com>
In-Reply-To: <20220216181434.41682-1-nick.hawkins@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddd0bfd6-2036-4375-edee-08d9f17bb00d
x-ms-traffictypediagnostic: PH0PR84MB1811:EE_
x-microsoft-antispam-prvs: <PH0PR84MB18119EC0D6AE750802FA849788359@PH0PR84MB1811.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zw8o9pLFzI88LwXh5YWEatNLuzNymPM7jy+WT8mwD8rvreESIbAIDKo3V4QnjwHGcoj/00R06frpLLmDQ8ksMfUZ9ajiUzDYxR04tar7boAM5rN+wVjehN94J86wczjWkUXDmf5CRW0F5mKb1b9oKp/EjdLG+5ahix5oeREXnMgfm1LgKVUCdxSfXVykjRidbU+TaHA0JZJ4/tH5E9ZqyXx+7FpMBNKaNcJSv+GEQABIXfakBZOk090pB/sNHYFHqME+MDSatiWo8ogy9wQtJj4aKX2Ex6XF9LJAXQUHCSdX711juBNycPkYrharbQNAb2X+B8GEo4PlTkelQS9xgxPaDQ3VKXj0vjU0/0r5Vjl+ZfYMkyi1XVIL2pwZdzLYJGZoFhYnHGuZ13Q72DrG26lFIUNnhqur2e/94e5r9UYAAnvygK7c1tW+KCp1rR0+emGjfkh6IgmXV8FrUEWIHwbyjfEq6bLodOojVVQEBsAChnlnbD2efzhIJvJEyTwp+mZf+XjhtjvaQ8wBSvof16SzrD/T5vWS9JYkJdE520zbP1ahoLh+4TB76xLEqpgkv32Ao0DZrapcqTqd8BLo7dMRLRG0HtrW4h7Q3e2twB1Loq0n9LrLVrGVsguCXishW3rtMYcbVGJqULVCwa+QAyW3MVWzIGf0mznUUx9LSocm/hxLKH94dIbps4Zizriuz+fn92Wewebe4y9aWpJ3VTVnSEVUYih1vIwXuv5BGvVXd5aSCSBWlF9XazhKDsFXSGEhau1BYqoGVbZ93rJ73HMfRNE99JyrNtYJxTg0hqw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(5660300002)(55016003)(52536014)(64756008)(66556008)(66946007)(8676002)(76116006)(6506007)(54906003)(83380400001)(6862004)(4326008)(53546011)(38070700005)(6636002)(8936002)(33656002)(122000001)(66446008)(316002)(186003)(966005)(2906002)(38100700002)(9686003)(71200400001)(508600001)(86362001)(7696005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vHn+01YjmTnSx468BXUKPyKwgMGdP4ojmL69QoGBJJY53LZE9JEcusLNKeQJ?=
 =?us-ascii?Q?mTb6PlO1Br5H613YywiNNqEF5dN4t4L5j40D6krWuIGv7MlaBJQ++IIa12Eq?=
 =?us-ascii?Q?9PXp1GsYzTAmGD8oKBXA1G0syuSVz11U97ZP4LEK9cr6Zrr7d9/mQLOL73PN?=
 =?us-ascii?Q?rbOZkU/zaNxkNNB3k0sMN8xl2PD6JrdOGshptAvqPkOcw5aC3fAAba32Q9kM?=
 =?us-ascii?Q?dj9eOM6J3mW6QDZvAIQWawOFCoU2cQpFj2rGlAe2UZoKic1X8KXqLfiN6zs+?=
 =?us-ascii?Q?gMsZ2LTk9iBSQLNVmN9lRdUPBu1g3mYbQmA01+Q33WIPCesJvXLm/Y2GifGg?=
 =?us-ascii?Q?3/zA/DVIMtCB1/vQBVrNzeb7JFgbV+NkGe77wafUgdcZaOHxp8x24wnbcXP2?=
 =?us-ascii?Q?QfKR47ccQt/7hwLRiVHye/69PdGvKagS3EPkzGSfHxFj5oF1uX9nJv3D9+me?=
 =?us-ascii?Q?BC+BzRVWF6D8Ikkn0Lv48dB+ZpCdId3yK9GKRRWPIr3paMxSflVEBAT0M8sa?=
 =?us-ascii?Q?hHouYKuYxr2QSFb1wYFll0JZutzeJAivo6eV093q9OqL1lpDcR8YK9A89lsC?=
 =?us-ascii?Q?54rIy6kdOrRZKOBTYhwLHI85B5pQxAc8c4hdCQJ1tuIC9V35AAGoFmcdyezQ?=
 =?us-ascii?Q?HL7Rq1uPP1QYnJ9hrah0IIIM/J6h+kCScsbREocOJi98hxKCg1QVRpdXzBff?=
 =?us-ascii?Q?VbM9cstWDZH+u4LjlH66tZ1Jrt2CEE61nsJLtjVoeSLh18wNjZQuuC+ja3Uk?=
 =?us-ascii?Q?+GlfLHEpyf5hvYX+3SvAfd9UCV2FnFAKzQvNM67OOlvz8EicJpDEouqV1sQ+?=
 =?us-ascii?Q?vEzUX5VT2KF7fJyf1umvUsXhZzVdrPOWbvI+z0rAHiSATGtKmhlw8UEgFZLt?=
 =?us-ascii?Q?qENbFz8W9vg2bXBeGMEuhQCz5lvFCpFqj2+vW82QKVOineUS0OjlYzImrgXe?=
 =?us-ascii?Q?xmMuRHg9Qaz3URsiPVdfvYAFd7TQfuXuXz2X4MrGeDU8mJ48yPXKD3JjakLt?=
 =?us-ascii?Q?pEODJJ9vlB+ALxWsNXprZR873grkAZg0FM9XHgv5BrNuBnddCoUqLPKcXmfc?=
 =?us-ascii?Q?byBNtXU+O9Ov8lRC+UJu+uKUK/F5N93Hh98ifCxpYRHqEbJOgP7vlm8U8A92?=
 =?us-ascii?Q?nJiEd2ymNfX/ZxoXfIolZO3xSgBWMsYaUpfaqEavFPsXh7ll6SEcTbuRqrYu?=
 =?us-ascii?Q?K2c5uuN7NHwZwmS0rNb91U9MW0zGCKNAuYQehhnaCQdPwL5sCuv05I8nUJS3?=
 =?us-ascii?Q?yfHU17qsSNayUfXFxhHZj8AW8N9zLcs8cF2Mejt3JQ6CCJiWigHSyKKZSebi?=
 =?us-ascii?Q?jr4X1a7ajUS9sc7nxMPE/yktLY5I1DQ0DIikVCUVujCQB8wl4/VbTjI280ZF?=
 =?us-ascii?Q?HIKbBuJskENwBY9ErDYOWVdr2TJO5l+BsVZFUqi70HkOL/h/M/fmTuds5HFz?=
 =?us-ascii?Q?8eb5p+7hSJWX68LY0IdS3mA7m6IW4Wh7DpnF63/t0hRh9ZERWdOlYkLTu2EY?=
 =?us-ascii?Q?Y3DinSRXQGbHPheQQ2e21I0lC50aKQ2s3OHQ85nIUfGhQPHFoCOEaMHzXpbM?=
 =?us-ascii?Q?ZD7JRj1ovyA4sTz/XQY4FY9o48FjZqU+3LFKOQzbpkJv4rdQOdJtLZdTIwrs?=
 =?us-ascii?Q?v1l38elmmdlf31wCmoDxwtNhY4yok9wInaeudoR2/Wx6RKD4XoyM6kHqzkTv?=
 =?us-ascii?Q?+qj1KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd0bfd6-2036-4375-edee-08d9f17bb00d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 18:39:38.5828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w4xiNF5mTNriAVHiGJipHYscjZSydpdZBn7+JgtCShlD60lzUidvt3muQsQ5gaNpSlocMeRAzyXV+mJbaBEuRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1811
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: MVAtUNRN47FOFsT_9gcrgI0Fl7Z1ozOi
X-Proofpoint-GUID: MVAtUNRN47FOFsT_9gcrgI0Fl7Z1ozOi
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_08,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160104
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry all disregard this patch. It needs to be in Documentation/devicetree/=
bindings/arm/gxp.yaml

-----Original Message-----
From: Hawkins, Nick=20
Sent: Wednesday, February 16, 2022 12:15 PM
To: Hawkins, Nick <nick.hawkins@hpe.com>; Verdun, Jean-Marie <verdun@hpe.co=
m>
Cc: Rob Herring <robh+dt@kernel.org>; devicetree@vger.kernel.org; linux-ker=
nel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: Add HPE GXP SOC binding

From: Nick Hawkins <nick.hawkins@hpe.com>

Description: This binding will be used in creating the HPE GXP  architectur=
e. GXP is the name of the HPE SoC.
This SoC is used to implement BMC features of HPE servers (all ProLiant, Sy=
nergy, and many Apollo, and Superdome machines) It does support many featur=
es including:
        ARMv7 architecture, and it is based on a Cortex A9 core
        Use an AXI bus to which
                a memory controller is attached, as well as
                 multiple SPI interfaces to connect boot flash,
                 and ROM flash, a 10/100/1000 Mac engine which
                 supports SGMII (2 ports) and RMII
                Multiple I2C engines to drive connectivity with a
				 host infrastructure
                A video engine which support VGA and DP, as well as
                 an hardware video encoder
                Multiple PCIe ports
                A PECI interface, and LPC eSPI
                Multiple UART for debug purpose, and Virtual UART for
                 host connectivity
                A GPIO engine.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../devicetree/bindings/soc/hpe/gxp.yaml      | 35 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/hpe/gxp.yaml

diff --git a/Documentation/devicetree/bindings/soc/hpe/gxp.yaml b/Documenta=
tion/devicetree/bindings/soc/hpe/gxp.yaml
new file mode 100644
index 000000000000..8690c1e28ed2
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/hpe/gxp.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/hpe/gxp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE bmc GXP SoC driver
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+  - Jean-Marie Verdun <verdun@hpe.com>
+
+properties:
+  compatible:
+    const: hpe,gxp
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    gxp {
+        model =3D "Hewlett Packard Enterprise GXP BMC";
+        compatible =3D "hpe,gxp";
+        #address-cells: 1;
+        #size-cells: 0;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..e482386bb248 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8385,6 +8385,12 @@ L:	linux-efi@vger.kernel.org
 S:	Maintained
 F:	block/partitions/efi.*
=20
+GXP ARCHITECTURE
+M:	Jean-Marie Verdun <verdun@hpe.com>
+M:	Nick Hawkins <nick.hawkins@hpe.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/hpe
+
 H8/300 ARCHITECTURE
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 L:	uclinux-h8-devel@lists.sourceforge.jp (moderated for non-subscribers)
--
2.17.1

