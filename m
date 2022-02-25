Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7A24C45BE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiBYNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238729AbiBYNQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:16:51 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94661FE578;
        Fri, 25 Feb 2022 05:16:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO4Q7EM2UmlIOWqhHsJvVUiV+NdvmJAwIUo77/oYJTZH8RHxvwqSOsAAVGb8wgkCqgsazvmZxC6gU2Chv4TO6YG4sY5HZtI2BfjB8O+NSHsZ8rZNfcY/c0x5RqULhFKS1PGuTQQp/GUep0BQF30h5PAWcm3Q6em4qOtvVfjXHI3ctlSjbIOW1GIPiyRt9ZML+8vjaYBtjAlS+Vjyp6fwC65qXg53hz5OuuWVrnR9JdQZnBfLrIdaLoQaKwZkS4jOArWpDJx/oEkKUUWLZy9TuAyUHdSTsLotuYh7tAMbBBbWTkCHIpo6NcbCKfVfgemX3yJcbNwrDTp+qNHbuCCKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElW3Jkef6DJOOJy2f30tthlWOT5zBJi3OFyaYJ757m0=;
 b=Qnie+VMi+CwYM/phzKC3iOdpCXWkfvFxYGK4fXKz8z5Y14ugfv8+BZw2m7pOFqmolB/cvLnPNitTPdMhO/mHBrKj41U/q+00h9gVItD6FgY5yeei+7tBnebARuRE9XRko2NFKxupnEatHXisCRilUWwBnklZ3pHXTJ88GPVE4c8hy65IQeu/kcgC1q5jS+5D0srzq5nQUBRFzKhtmJyEAFnvUJX5UU28MGgw2lmsK95mapk1BxacdQqNCbpVW9UkX6sEa+LI8Dy48jMNQwOxJtDKjebwTsqNV3561Ds2OnU1N0O0BBe4arbRDH8W7elTsebU2lHQV+Ka/upUx8Q9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElW3Jkef6DJOOJy2f30tthlWOT5zBJi3OFyaYJ757m0=;
 b=w7TON6ojOR36CyNuMtBnB9NR6Lf24yVFN4gU76TC3o93j421gp4q5plfayX+iGU2i1j7mKpFfTZmt4Z4Bx30e6iuuSt5CdQicEbC9aJP0YPEr4t4IIMkS/QC1wOIE1WuzbUuyqV6D366uSiI+rtj8Bpf3s/w9fiej9GFl6W3830=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by PAXPR08MB6591.eurprd08.prod.outlook.com (2603:10a6:102:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 25 Feb
 2022 13:16:18 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.028; Fri, 25 Feb 2022
 13:16:18 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: [PATCH v2 2/4] dt-bindings: usb: add rk3568 compatible to rockchip,dwc3
Date:   Fri, 25 Feb 2022 14:16:00 +0100
Message-Id: <20220225131602.2283499-3-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225131602.2283499-1-michael.riesch@wolfvision.net>
References: <20220225131602.2283499-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0109.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::6) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e3db8fa-77b4-433d-0c9e-08d9f8610226
X-MS-TrafficTypeDiagnostic: PAXPR08MB6591:EE_
X-Microsoft-Antispam-PRVS: <PAXPR08MB659165A0BBEA51CCBBFB3356F23E9@PAXPR08MB6591.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9JfvnotK7gWGGC5JVxFGJlrj4gxfKCbr1uFnpIhBwi25R+8e6hkgn8ZOQyGiuj4LzFCal1jnLhSfWSzwF2/fEw5k6pqUnyJNXPLWWe9wdZstRpFGMxRnZEJM3mD+qsZsVJnzQYf02/lXubo6jN6v/wmyKzVM3iJSx6zU+ShPepmYjHp8CEyljafYI0/JKHkByQ47PChDETRugHNc+Qu1xE+9K4zei1eWATA8UjgzG5pt8VYjFHJu1UADYxIflbSieEdkMRdufqy5ilYldixY6eq0qC4ms8O9ad4NzAOtsrPXSJKjtlSm0LW/WmD09iPAKbIS9FLDmjb0m/58Hj39ksT6KQcW5RKA1jELT5ybl6Uo36YrzEapPuu3WcR8eG0u+ilNf+2FEktJ/l1K7pEGodRDj5z6rlKdIqpMjSqXouBvjX1l3WhBkkDCn0btUPCy2lBq0LZ8hz4bk/WkQGy4Yi1xX5D8Uey+jIRQCODXRP7qJlaO0+zIM+tNN9aZxNtuBgdZ8U0/WvAvCqDdCkPgvp8E1pFI+oH2Afx5n9lYJLYIDSGrbVH8LUX11lhtJ2zaCghst4qzlehQ/Kp/I5DAkRflCkTCMiDC1yKRM6uvY6KIRimL1PjYnnFDnuJ3UZN0BnURLzFmzi2ChSpJKzRVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(39850400004)(346002)(396003)(376002)(136003)(186003)(44832011)(6506007)(4744005)(36756003)(1076003)(2906002)(8936002)(86362001)(8676002)(316002)(7416002)(4326008)(2616005)(52116002)(6666004)(508600001)(6512007)(38100700002)(66556008)(54906003)(5660300002)(66946007)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iklaBYOmnBFyyLfSf+wcL2hiiqtMQpoQGYoMzTRX2g92vHPZ5h9dpVpYisRl?=
 =?us-ascii?Q?zNhh6m2by3uRofNgVq3iHMUzE+iSx7Zs9roUpc0Viv2fTFw52nv04UAs6zRL?=
 =?us-ascii?Q?jtRraqv9LZWlMO45EbAeUyeQsroRHwpOKi8wWIiyL9nr8/JyCsIsFI5Yn5zj?=
 =?us-ascii?Q?LAEGynVsMLp4jCvZ5ZP5ncP0i25pIqdcRRyIEj0q6Jzvhi/FvpTiNM3rB6ms?=
 =?us-ascii?Q?/I3YzBHylCKNdwopmWoohozGEokK+8XkmySO0mqUL2a8lm9wodIW062ZQlO5?=
 =?us-ascii?Q?b2bbeVnusm7Y7YWXA2nAyqJ+456poU2EdKywuJJfrnxx8/GsYVIL9wE1Pjcm?=
 =?us-ascii?Q?0Em+YLidp6YDoD8u0VaATdz4+L5ZFsdqdIdwsJIzmBjnwBGb2fuK2nLK/nNW?=
 =?us-ascii?Q?zbqfWshUZjlac5cMMvlfeoq2krUjvTGWuKc3iZVfNbVLo3jveuUseJABvD2L?=
 =?us-ascii?Q?i/zgbmRWeKB8wEWASrfAQ303QYMbUsEiZJWc3yBX44geC7bMkfI6/YdcDfMn?=
 =?us-ascii?Q?ZA6NCDz/Af6YzYbcw1u+OiJ/dbf6LdSmSs+sRBvl6ttpkzyGE7WO0GFP+ZVr?=
 =?us-ascii?Q?3sNvnyGjx+CQz9ZhEMmgE2Gp5I8JGL419928tiInR9GHeQbzsaI5QLexL+3W?=
 =?us-ascii?Q?w3m+g/BJkgcZmcbGtltvVRFRBRK6OCgSHAlp/wl5T0PmYbje4+/9TJQKWfYn?=
 =?us-ascii?Q?qkog7U7LWx5RJ+Ut4F2bh3AA4/soDY5MKZUab/lpKR7ehS9amIGU7xLMrMoP?=
 =?us-ascii?Q?Bjjj1jM3edPgx96O8YWlAjbnLowT51EUcTZMydX87ZP7mlWgOUdkE246n3mY?=
 =?us-ascii?Q?K5ZR2JXTl5uKgJ+DWa2dHbekpsfbvErwXxU5G25j3VI4lv7uraGuizDMT99z?=
 =?us-ascii?Q?NhNGU2tUc/hYQExaGq4rybjFJWx2+JRpsVdlWJ6BBgJBjSantsfECSJv4D/K?=
 =?us-ascii?Q?kzSD6g9G47WV62ESmWrGTLubNCn4D/z567cDj0sz1nuS/kkBMu5y/JXncBPa?=
 =?us-ascii?Q?1SY/EAmpL/YptbeUfUthjtiN0Y5OGp9jtIcgAZPvZ4yutV3qpb+QMjmS6bK5?=
 =?us-ascii?Q?77XaR4OfGwoXKZS5Pk0HsyotmeOMNTixVdZk/q6YYZgOJHDquHl+w60VIAc8?=
 =?us-ascii?Q?aWbbdxUp6dp8v8dh9EJKbiswEUcm1ZPnq0BoJUWQqpAQOn/bz/UHVKhCPr+P?=
 =?us-ascii?Q?b1irv1WeB30+M2U6UqoSMSREO5mSNWX16YrboeX0/jIpj/bo0Aty/cRfrU3l?=
 =?us-ascii?Q?kuMNOb/B5e2Ot8Ytnwzwm3FrqJE2hqw87+CzhGyAVmEhcU7TeIXiR5rWJSzK?=
 =?us-ascii?Q?eh2rmF6Nl7vnKsoHNiizZjScVysenpawqOdPxyAvXw/qnPfbtcRIXu2yNfIb?=
 =?us-ascii?Q?msMiQlgu5WQjD7id3QpbyI1S4dO9mILO8U3cHpbZPhSzH3qMoovjQSddkyF4?=
 =?us-ascii?Q?cJfSKai9ozf2bwpoR9Aq4PdnCK1CFBV1o6ika4Uv1tmcOE2DvamKL8TlJDk4?=
 =?us-ascii?Q?O9J8zWA0St7goKdL79rFoQdFvIGvtCFMKzLWQ9Sp0JA7Tg7PyiicYKDiIC8m?=
 =?us-ascii?Q?ueV8c1o34aJ7vXvexo3jq+B1yQCIz7iVFYvypULohXEc1z9lcHIPpk0TXtJy?=
 =?us-ascii?Q?mixxhbcfw9fm3CiWb1ZtmzRdDr8iZOFrmY1WlowyeiR+V26fkO2q/rCL3q9H?=
 =?us-ascii?Q?l2TwSvX9VOIMBYeENcDfPyttFWE+wQ96p3yQzyNm0oXRtLfrl6CtrYvx5dA7?=
 =?us-ascii?Q?x5fdL6Vz+YKhxI9EkwYPMl+vLYMaoNY=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3db8fa-77b4-433d-0c9e-08d9f8610226
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 13:16:18.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ff+aTSECQnYBaUiZY+Y6CmDALmopjHmGZZgHzGGzS7v/TU9Ub4/amd85XuUbYcStJdk2Tn3bDbYHSCL2DaBCD8wRpQweOUTUgDbGtXir0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6591
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for the Rockchip RK3568 variant.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index 04077f2d7faf..b3798d94d2fd 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -30,6 +30,7 @@ select:
         enum:
           - rockchip,rk3328-dwc3
           - rockchip,rk3399-dwc3
+          - rockchip,rk3568-dwc3
   required:
     - compatible
 
@@ -39,6 +40,7 @@ properties:
       - enum:
           - rockchip,rk3328-dwc3
           - rockchip,rk3399-dwc3
+          - rockchip,rk3568-dwc3
       - const: snps,dwc3
 
   reg:
-- 
2.30.2

