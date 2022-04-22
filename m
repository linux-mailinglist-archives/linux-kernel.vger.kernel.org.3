Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E2B50BCAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377201AbiDVQPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359191AbiDVQPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:15:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2032.outbound.protection.outlook.com [40.92.19.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C04C5C663;
        Fri, 22 Apr 2022 09:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xqqss+JS8WLPLYp+qk06/aqCAVYSi9Rl4xsWF3o0y0cTIq5dcpXQo2p2DS7jQeY1y0ag2vTQ/2j0JXRJ1lFPGAhUuIHE+lh49CRA428saQ9LcyPsTsl1/EROnLtSU2XSRS8446C+7ytCqNi+AvxdBd5qhbp9l3bKytjzURcjOD8iWPKmBm5PhxhFXd1ah0lD8vmov/ZuWq/HU/1yjFsFpF2g+h65q3rQ7PUEAfxqxOz3jJPpSkXdxow5NZ61Oows3U2B1zd4UiPyED5i3bJ6utOAF9XsAgOtPiW1Vn1i3wmMREyJpoMWrenT9//fHJ6QnPVrb3+bEYW44e7wkfhrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYJYWSVOlY/aFeV76qFGEuaR4R7mU1Lqs64suar0nDo=;
 b=QVUZUbZzkglbLgorKvDMqYUKiQW1q6xDKUvHvxvTteJRWZZzdREQ3+afOJWMXR//7/HMHFAVReLic0xun8bLrr4EIbx8URoHgh6Qm5MZGenZ2H7mBYp+1XU4EgQdajnLpPky+AFAHpENYfeV2BWIO0ONgi497mlzBcQILivJtXY5t9urZroFtgK/kks/r04r2E6D5Lovg8St8WdbrgDEjPtqN/ub183VROmqN4nIPmxbb+FbXdTKeLePGwlIm3Wv+DdvZZurJ5AGMdFypx96LXV+k4rfnB3Q1RiEqn7MInioaga2Xtm07ZVPZQI/lS1wF6EuNe6IPDqCYN0EEPH1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYJYWSVOlY/aFeV76qFGEuaR4R7mU1Lqs64suar0nDo=;
 b=A0zezP13E+99eryrfj13uDWp2ZG0LODzI+o+2fOJT77G5I4RnUqzOeRMKNkCKn8c5rnVcSDq3BPhdMP8mCdn0QOj71/YhfTEbZfzvb++i4SSOT1ul1AG/grTvViR5wwoUSrpVQlsp7kBk9ivSNPeYHklEMPVEvENlbiNbnEmLII3c8UzWKCAbvS3NUShU9tcM4b7Aj20pB2vh8V+9t2mQbPFGJ5ZLmR7zVXTLDl0+YcnhnR0HKtGMrfu9RuRY8hWMCP127I1U3YUGgsPbiMOjtr4pwQuRLgktmadnYhh2TAS4EXQehmM5kvV3UVVPmt600HcbHp2NbKDVWScBQDNRA==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by CH0PR20MB4187.namprd20.prod.outlook.com (2603:10b6:610:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 16:12:11 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 16:12:11 +0000
From:   icenowy@outlook.com
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/2] dt-bindings: thermal: sun8i-thermal: add binding for R329 THS
Date:   Sat, 23 Apr 2022 00:11:55 +0800
Message-ID: <BYAPR20MB24721F9954252BECBEF486ACBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ZtWc14FKzJcyVoeMPRhfVOOWM8V5hk6q]
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422161156.1075227-1-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c451c1f9-7f54-4548-c767-08da247adb56
X-MS-TrafficTypeDiagnostic: CH0PR20MB4187:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgNa5E8bGeDDsQ9uvOovpY28qxVzolB8bylIuiI+hWSNi9lmfxDR1xIk+oFM3Cdq/gvavVtG8fyOxyZJ1ZT2OaojU8RinU1ihsvv4CN61kVayMzedf3s8gzrH+/JxseDJ8Tx1HXBnromZO73ebsvuP+ya8MynDVNGCU9tFR7555ll+0XA/LKAlf33JnMQo/kYU5sUb0r0CE2/KkosOw0ib7q0kEaxU8+G9FmS4jpZaxIg1d2Hh6UQYdm5ibHEx7sve6qUOsge1Ey0BU8UTGEhjwMy2KdypN7TvHmiDVqYYgFhXQ332XnyFswSvrTCgVqX16Qr667O4iBODU6YfM0VnfE1VUoC9c4P1kbUElgvrTsTV/+yYz26nLVzgdO9rwmfGjtSS47qn8mq9tRSpzFZtUG6wWjU8Cvp4/o39HCpSjCFOl2fQ9FS42RDLjjiHFTDpBZ1Hs5b1phrubsAdgdNxNO6U0YTPnX3B6slmjkapJittGDtpF/8pmZlZo1FHdpYWwWlSN7d0L9ioB6NkMrNqoN1xL49fOJ3jNGFX/85zs3CENR5t/Jh/UTpd3sBjM0NPc7WI7RMPt7IQok9xgsTQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8uD+2GgjeEhNzgsHCAcuzMBOUg62rHyMTu+HjJaxKwKo+2Z171KP3p+DeEOn?=
 =?us-ascii?Q?R9dQjzGmnE2DztMEML9G43m2JYaIPx6tV/hlg5QDQfQfJ2MYWDNG8V/6/uVQ?=
 =?us-ascii?Q?F8KbmLUQG69tyNMqnSC0223xE+R/qCXfuHyERHv3d0NnDGSaVVB9Kqd9BChp?=
 =?us-ascii?Q?I3egAZKm5gguwdiMLrURBI+dvj9wZS12yvxvOllCoZKnKptht7ng2zqRS+tv?=
 =?us-ascii?Q?APP4K9rWGc1x29m8/2u+4bjr5TbqmHxn4qrTBLG/AWqq+hdS/L5F/KtHAZMT?=
 =?us-ascii?Q?pdq2tLZMgOi8aHohYjooyvSBTatYiK0+gy9YeLuG/m46kws1P6VP0KDG6cd7?=
 =?us-ascii?Q?ywM9t3q73daFWU+9uYgOkIeVpytN+zmiHFDys2b5sNJIJ+j8POSqALF+eOoS?=
 =?us-ascii?Q?R5tOlsp2F+xH1k2g9p3KZu744TNPRjKoNgg+o/x20l28GvND8LO+bBfy6Vcy?=
 =?us-ascii?Q?abTAlkQGcfmAtya+GikLbyNrJEfcGWPPDFo5v0ID4Vj84+ujVTkWR5P0OZjv?=
 =?us-ascii?Q?FTC3k8bsycfsqfoQ10ezXNTW5NWr5K4A7ZQ254apV3KXpVLkzTtNFp4t83/s?=
 =?us-ascii?Q?aeqaB7acWax0EwuH2URY5s4XBuLyLamXtAdMnEVvOX+4sg4PeuU+P/dPji06?=
 =?us-ascii?Q?oocMI28VrP6xoXe5zOQRgsP1yzrjc+Cqsooz9JMjgmMhdNDGmyLPZJ4FoUE+?=
 =?us-ascii?Q?cBN0zJHrV7f50HgWEO7ynNsR0nZxc9HOKGmOk5tHtgq4JD6qYjSm2rip/SG4?=
 =?us-ascii?Q?Sakqy8UNDO4ORZh1e/eywyf3FLmlf05Q9ZSgDVHVxsokxny34RpA4C+y63uH?=
 =?us-ascii?Q?pABKQ1b6yJD2Ua5T6Y50m4RFmaD9Ci2VR4e24omJiIhWwNZp45FdzbWgNDF8?=
 =?us-ascii?Q?vVRFNVp4SE9vmII7dXO2mxvJk+i9XhynZKB56cXzgYEsAmuAcGYbH2cdp59G?=
 =?us-ascii?Q?qFZQ5tj4iahKdCtxrMAc8ZB1iEAmkhRlY3fLR1YhSybdaNVmQKdvGJVl1SEG?=
 =?us-ascii?Q?TpAVefoUV0Go8U9/VEs+mW5BblY3eewkGP3jMAndCAKI0T66PM/J2ixyk55b?=
 =?us-ascii?Q?w/oOz7gXkhSkHVlKo0egOD2i1XPi8HuUtF1AabtqhsbFpj3cLxdeS2hPlEBM?=
 =?us-ascii?Q?s3kNMKT/TqwbjW61YXfSUcKgJ528pFxxFuQtxxXXlBstoGNv8YW1n96M+TUo?=
 =?us-ascii?Q?2WXiEI39KNercMBRKVgsjFqooxSTadCauInz20Vo/nxutp3aTvevTtm/JEm2?=
 =?us-ascii?Q?zV48a+e0IvHtY2FmsR+jwa9ZzyB6FXkRBxs5NaMlU4aRp25LofGizkQVemiB?=
 =?us-ascii?Q?fVq4soDg8z0efsqFwyUIrDc1dcfo6TudQNLEXEwdZ171XiXH2rsaRhOY2ScS?=
 =?us-ascii?Q?6IBambSU1P6eIjOYOdUcdTeJtqfVpr7y3XVVfExEvkuCp4psWJVd1uawlCqc?=
 =?us-ascii?Q?BkETjFt5d+0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c451c1f9-7f54-4548-c767-08da247adb56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:12:11.6009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB4187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

R329 has a thermal sensor controller that has only one sensor, and the
structure of it is like the H6 one.

Add device tree binding for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml  | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index 6e0b110153b0..87b4103e0a5f 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -20,6 +20,7 @@ properties:
       - allwinner,sun50i-a100-ths
       - allwinner,sun50i-h5-ths
       - allwinner,sun50i-h6-ths
+      - allwinner,sun50i-r329-ths
 
   clocks:
     minItems: 1
@@ -63,6 +64,7 @@ allOf:
             enum:
               - allwinner,sun50i-a100-ths
               - allwinner,sun50i-h6-ths
+              - allwinner,sun50i-r329-ths
 
     then:
       properties:
@@ -85,6 +87,7 @@ allOf:
         compatible:
           contains:
             const: allwinner,sun8i-h3-ths
+            const: allwinner,sun8i-r329-ths
 
     then:
       properties:
-- 
2.35.1

