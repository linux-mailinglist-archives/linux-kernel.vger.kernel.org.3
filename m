Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93CD4D13F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345501AbiCHJ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiCHJ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:56:58 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6257D42485;
        Tue,  8 Mar 2022 01:56:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/exWD/25pTMrp0YFqtbEyshkVth0x2aBAhIHN4hDdizpVNvrMskIzsnYNDDwKp1gYskqiec/y/L0u8CkCrVhyysIJg7pP0rt1ATLKhihJ7n/19WGaIUw3HxVnzrvG60ZwAsqeln6FVpysLOwp1QyyabSRJRCzWhUfM0BqnEgOOFQAcP44kFUE0Zbl18RJgZ2BmXnJqDDRwvemz8mO+nRu8v/2nwN/LcLGAGoaV/245fAaPifaYa4lkgfJPIEUbi6bTNDPnnlqlIa5rBduqkNmZGugU/8YgmwgxuhSGN/TR8eTIefRCBZrjjvqWkcVoOle2VZ1ltj8n6eT0LiMP9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thUGlvU+fxepmfdUt2V5itFc6vuBSYevrrZZeNOuVxg=;
 b=O1tFE5PFwWGbD/CugLT/wo5vCL206dVfmO9PxxW595KQx8JsqaucSKkOx72Z6Wnt4mKKNyuzQ9V07Q1oRGHd9q+581hN0VH8jK4f+GiW14aEEaZUzeXKb9DoE0Cxe0AV30rKWhgkhnNPInW3R827n2823wM3myuupfjfKPm338dPiusbDbeWhRib3nqXGlKEUAgeXlznf3YGuX06/NgsAgU3OMWQJSwu387LTWUxKFjgQ7X4NUv8iXB9yhhdcg/itN2rktbEtplhtGq2CevU5u+KzCnzEclqrTiFi+Z3y/NRdpzm2wnhmhtq94ZYKF5mUjJhh7B0guO6yiBp599OtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thUGlvU+fxepmfdUt2V5itFc6vuBSYevrrZZeNOuVxg=;
 b=R7EIRrPztFieHniqycjfamNBilb5h0KdEvWPZN3yhl2I+OJox+9sSGZNCvLGV3Ct83GpCvHH2HB+Aa5aOeOyDL2h7PWPBDV3SmYdWwyRbo6MWDEG6d+/Ttr0/V+dZFzOEp6JHYzME32w7h9odHqFf+ee/dHVmzaoe+i7pJ2Rpm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB5786.eurprd04.prod.outlook.com (2603:10a6:10:a8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 09:55:58 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 09:55:58 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: fix Documentation label name
Date:   Tue,  8 Mar 2022 17:55:30 +0800
Message-Id: <20220308095530.14099-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0104.apcprd06.prod.outlook.com
 (2603:1096:3:14::30) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75612e05-661b-45e5-7f23-08da00e9d860
X-MS-TrafficTypeDiagnostic: DB8PR04MB5786:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB5786775A0E35DC1B8C97BE7AE7099@DB8PR04MB5786.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMBy9gBdQhLN37hcbW0Jd3pwnBaj65OlaDALSWakcQseIpE/gd7UPv7E6QUlcR/qUVhBVON32qYVwyDnQTexwt+3MK6/Klt1MquG/xpAegVzgxCTp1egttKq13ToB7IFK8EnWEnKNMWE8bNh2pRApubR36obvNwfOOAN9acSOpS2HPgZhtQoocdvwLC4B/9bbLFKoExV7mjqJI2QiTSxA0fylc/MTkZeRRF3lQI4K/Up+6AMwm4TW95FDizmWqB1cp8Iq/AqtMQPMvii0bzXjdIar1NmuEt8W4s79uE0AjmVySU66PFE0bNjeT+t7K5kQWAeifoGCEfUsXIG0pe37HHl2qCcGq05jk4g4i4XA6wN3D0FW+OZuL4fLPH5VlrNEUqkJ+JmfokOx568P7CqvFtAsthaWvOzELqcleZZWXfl9gRj9dNdWkWCwEW2ztCsVh0Jyxc+ND+jUsk50vp2rA0BvAGp5wmWbc2Eo9lI9aTukHq49/G/P3YzjXm5VE3EMsbPUnNEP2O5aEON1MyOEJ1uxVBPPBGWVzd+nbXMMAsAUehLUbEbXhQSeMBiQpiDKYD3QTUigildm7IexCFgFrlg/xmrRO/FNf31zNdvykOuMa3xxlpUT57/VlG63r6Mo+nT93w3Bq8ldFW6wbQozJ1grxasmomXUKAe07G7OLPRvxiOYV+SxhSLCcj3jiOTR7NB8i1hwcwzgdfeqZJCkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(86362001)(7416002)(44832011)(38350700002)(508600001)(8936002)(4744005)(66556008)(38100700002)(66946007)(36756003)(5660300002)(83380400001)(8676002)(4326008)(66476007)(2906002)(6506007)(26005)(52116002)(6512007)(6666004)(1076003)(2616005)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WvTmh6jpy84Tvr+e29v7oNzvCpqC648by6Q/f4OIzU11EKzSMZK9u+LAXKHr?=
 =?us-ascii?Q?SGT+Kt9jbKZp8Gig6SBZ0NA8sXleaSlN9MPIOPPuVuCBYEm+ybgn0wp0SSBD?=
 =?us-ascii?Q?3i6UqfqMRPq+7wvG1x7d0Uvw72tq5sJkHGUIrVGLAK1ecRmvsrW3yKNPUB21?=
 =?us-ascii?Q?vBi3xj7nncmLMJd+mtO3hu3xuqBFMdqWKVymBjB1ia90VETOCPUUoSuPYc43?=
 =?us-ascii?Q?frMLozHu7sSP6k1j2JBLyugFEhvfLBaWcsWUq/0/NNKuIg5Dij8wMxTo08mC?=
 =?us-ascii?Q?33chXFxFImfra+13sMv8to9Rn+uDB5x8dy0d2R6tFnr/PNPl7UpgwN3SXfSi?=
 =?us-ascii?Q?79blzoVqWb9etjt9OpC+nnXiZGQ2f7OYU6SMEal8BUW00AvBDWpzwoTYIvTp?=
 =?us-ascii?Q?HjRku5LxI+BpN2vws8OdtEJaALxAS2tU8TnXKaB9GkbhUqDs84hCXcq2x4Go?=
 =?us-ascii?Q?YwsTdA4lRysMh84wHBtB+CdPxSTTExl8MMTKL1j+os0qcfmhHZrTWDtPW2MY?=
 =?us-ascii?Q?tKh0f6LwEIIFDp1V/b56qF3EBoIt5/l2ptoUuLi/8yKekLhC4MINVRGAwPDg?=
 =?us-ascii?Q?m3nw2DV3DJbECMJo5MjAjMercOfITeYWahJinR/b6ZgpOlqEQhIQplOQXAUS?=
 =?us-ascii?Q?qw24Dts3OD58/Y+eLnmxAF/Wpdspk3Q1dL31MGWC/spIgxxDHLUFTVy8S2vJ?=
 =?us-ascii?Q?h45MF/SMHF9yjbJDTvxBw/oMO9PZ4VCzLF/no9t0jy+vO2SuhHSuDBQAQWp4?=
 =?us-ascii?Q?ZZJ0U7gfupcLQwzEU6BrT9LuZ48sLKWvk2vqgPMaEOdPg7zANhAuEWfIK3UM?=
 =?us-ascii?Q?5FMNiyU8t6VkcwnUE9ezBodCIy4pRJughrzX1mul9ngZOWcOYSzUErS4gooN?=
 =?us-ascii?Q?47mM8SSBYFefhJSoX1ebs7ewBI9ze6oRwe1t792nmtsj4OBOYiiECRdm6TxY?=
 =?us-ascii?Q?Tl6kdr84cQ+JN9/v5qn9KlaR45LCBOciXPFXfJNczWIyfFOc1PsmanHzzrUG?=
 =?us-ascii?Q?5arKc7A0krM5Ga+DLik1aLpopGT9YMSZ44FhQYO8KiVTulH5xnR3jp/oqjLk?=
 =?us-ascii?Q?etcxzubXF3x7npm0tKCNyMvXj5k5f8ToE3qseOmQdFzzW5zwq765Y1TEFrw5?=
 =?us-ascii?Q?W2u5mBZLIUOfo/faLZeRxZbnglUF4s5Rw1BvgSws/S3Exe6lm57CONRqX+Mw?=
 =?us-ascii?Q?o1dtb7UBNGuuBMD0QI5XNXice2LZAlyOoMYmjXdwETXpLibbIVY/SHS8pEPM?=
 =?us-ascii?Q?GUOsCmq5l1phRp39L5tQ9cY+G6F4o9PDHqkhPWdn+w//LWakMyyVrPi+/s0O?=
 =?us-ascii?Q?QPsf7GfplT1fR9U0b/UwewsvAtF2Nscq8DHTCZe5gQWnoaU1RztN+nhzm1El?=
 =?us-ascii?Q?X4UAn0I2psAjsBRMUl0URaCPFCotrWTWquApdlF1KooMM0e14TfJvnMtz/32?=
 =?us-ascii?Q?E41Rn7zjVka4s7g9C54HCUBJg2EGnQIBwJzQH6624drVofRfh2beTXy3vJ5A?=
 =?us-ascii?Q?e2SYKuLhAhx6oPTPz7iZHGfMq56tKO/HlyGw0jKB8TUzPB6Q7M0XcAggoOR8?=
 =?us-ascii?Q?fnXsq3+8Nuozt/cUTWBfrqt8eMf6DiFMNYeziC+FCL3SX+6CxfoSTHs2fqKD?=
 =?us-ascii?Q?YcBbNpsaEnCXkHiApkt4jWs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75612e05-661b-45e5-7f23-08da00e9d860
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 09:55:58.6585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlsiVlXGV+3Zhmw4nURlGlR5u0fhnES/OWvnp8WY61spw+wyCe2ZpkTuiOo32UjzGdtCprtz5FFfqJ81Z4Q9mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5786
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the label name should use dash, not underline

change _V4L2_PIX_FMT_NV12M_8L128 to _V4L2-PIX-FMT-NV12M-8L128
change _V4L2_PIX_FMT_NV12M_10BE_8L128 to _V4L2-PIX-FMT-NV12M-10BE-8L128

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index 8b2ff1d29639..bd1a962a80a7 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -257,8 +257,8 @@ of the luma plane.
 .. _V4L2-PIX-FMT-NV12-4L4:
 .. _V4L2-PIX-FMT-NV12-16L16:
 .. _V4L2-PIX-FMT-NV12-32L32:
-.. _V4L2_PIX_FMT_NV12M_8L128:
-.. _V4L2_PIX_FMT_NV12M_10BE_8L128:
+.. _V4L2-PIX-FMT-NV12M-8L128:
+.. _V4L2-PIX-FMT-NV12M-10BE-8L128:
 
 Tiled NV12
 ----------
-- 
2.33.0

