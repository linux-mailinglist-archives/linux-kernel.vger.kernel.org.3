Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2A0507EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358992AbiDTCjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358984AbiDTCjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:39:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325C337A83;
        Tue, 19 Apr 2022 19:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVIRjH2ysUtRdDu8RyF1LqGG6OHDvKBdX4HsIlRxlQW9a23T669+C5rMOxz8SUbCk61de+fnmpvkKSikTBZ6nP3ST+eOBgQexjeagg25XB5+KAvxzaE+xH7ZrpYRrO+6/sb7ToEghMFrvB5wa6w6JPEtIy/Fp8JDDemo/EcgkTN7HAH7HJBsXpHuuMjaidMniyhCLARCcv0kqK9kW3CBM36IUGBftbnenajBxeTXGi6BM+NH1sTUtSSWzB+niVJAk4UlHLE2BSsP65yohPailS5VnHmkpfX9bLpeT3XswULWR7CKCpnFEQAdgNAc6gENsufswxYSY6zFN53Is4+3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihiURGwiw2sax1zrl8u0rLtR+PFsndv08LJdk5kLK10=;
 b=GbGe6H9eu+QdQcJ9PpEzrzeb5xLyy9PQdpflUfMJifclTWrSIPTESZ+ComyDMsO/2Wa1B/e/dtj4qvwYCGmreWAZBWQQER3NXwcpBf1mRKZDX3qw8rBpgaT1J27nYaYm8pnDST450FWSilLQvnTcmODva8vjReotbuwzgtbtVn4wjDbfNP/Rp345sAuPLzv0PmF281UlZlw4xVeibkEywno0XrAH/zmrN8x2GeAI2mK9GQI9iZlkn4gYd8Bjt5+jFS39xPQiWHWwvVq/WrlAaGSRbBtn/W6Ze6kXM+c/LPZbC1tvhlVpY7zY2JTOa7bfTqLkzY3sQBTXnkEuN+4FCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihiURGwiw2sax1zrl8u0rLtR+PFsndv08LJdk5kLK10=;
 b=AYUq6nnAZCM7gwX+l9Rh5DAAjVDZ2dpdihY9DsMv3vPBb/Zw+CmUbvsFQChxRp5mCoqlzvpPF3b3rBqQAIieJUqG02OogOdmEgZeLvV3NzasfmbO41+pAAC3iwuoxVKrbtJEeUV0Y3Wxjab1A8OQvX/XgHN7cZo4dPhSJq0p8b8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by VI1PR04MB5597.eurprd04.prod.outlook.com (2603:10a6:803:dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 02:36:12 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 02:36:12 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, l.stach@pengutronix.de,
        alexander.stein@ew.tq-group.com, festevam@gmail.com,
        tharvey@gateworks.com, marcel.ziswiler@toradex.com,
        linux@rempel-privat.de, matthias.schiffer@ew.tq-group.com,
        cniedermaier@dh-electronics.com, sebastian.reichel@collabora.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Changming Huang <jerry.huang@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2 v4] dt-bindings: arm: fsl: add ls1021a-iot board
Date:   Wed, 20 Apr 2022 10:35:55 +0800
Message-Id: <20220420023556.33157-1-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c11de23a-20e3-4e9c-7f27-08da2276888c
X-MS-TrafficTypeDiagnostic: VI1PR04MB5597:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <VI1PR04MB559754CFA59CF73A578EDDE0FEF59@VI1PR04MB5597.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCjxuj2exg2otKdqSTjXGA4wUeXnh1th6b4DEDhqf0eaUJSXRNyCBjvUPODaqqWQI8rXcMK8yS4zXbmsLHfGBJfsrx4OGDCH5Dwj8CDVhgRju9un2fx/Uqw5Jx0a1FuT1l8NOBR/ELlUI0qPwttnU8jfmSdAo2sC3mDwM5+gehSj2LeBBXwqAnmZ2FhSGmsD3KE6ERRQ/LmWErxVQcg6C/AJyWW6dQbOYCNWNjBOhxxOnkkg4MFfBPVZc7ZaTuZA9LKCuRFcwioiBE354F/fT1fHiDn/T4qgKOJBd2KGBOUTumtyW1ScYgKrdgMg2NVJgpeZertBM8yeIV6Ov6xCwftERDfj6zUtH5PawriY5A9dNXVXoOhhzNXHmWRFo88mRpJVfZz683cEa7IzMoqRXKPgXtne2w6NP+7dDFF739zEaL/Ps6aIJsVp6YQffkPjUvc/EJjRylnSodcJ2J+weDoIjAcoRdF8f0F9gAA7+wwozLfBN1SlT7KI0gjTK8now4agfaQOQtVRLb86IrSlF9HpLrRkNGq/hY0yup1PSLxrqhglWAYX3KAO6zOPIgCzeX3SMhWJDiCHRo9vt/WteRpIyYF+WFxM9DLnK7MX8SSXx9qRP/B33tTUeGnUwdDjD8vliApNHjGTIXRk6T58OWKi+UKBA4x57ReE5p7JrV0EZfdqxZ5VOqAQvnnBxLdmKNG3ouTbs6REn5Tb3NpJBQmizw+WkDcLB0CoTP3SmYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(52116002)(2616005)(38100700002)(66476007)(316002)(54906003)(6506007)(6666004)(5660300002)(7416002)(4744005)(8936002)(8676002)(4326008)(6512007)(921005)(38350700002)(508600001)(83380400001)(2906002)(1076003)(36756003)(26005)(186003)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SjLoQOYXa06W3LPrPieqdYDp9ZZyloEgFPqh8v6bdiqW986DwmtmFRjRO5E8?=
 =?us-ascii?Q?EvpTnSJH3pZy+lGyF3WNZ4uoI/rqMYy/1wV6zv5Xz4bMdXQddtGKyhGoiGNX?=
 =?us-ascii?Q?PQME7a5AT27ZhTw8klluj5viwz4griXqsHjTS2Qu9j2BUrdipHq9cIYlrH5R?=
 =?us-ascii?Q?Aj/vRpNMFJPiwRePW1dqf3XKTKj7xapTn9PiS9Ydabs1VRBmIRl1VEntfqWw?=
 =?us-ascii?Q?4fVTMn1i4kvjCOhgIsWkP39Q0J/fWgIgdZzWYS4nLz2ojP2/4UAUBtWEv1DZ?=
 =?us-ascii?Q?K/rs9ltt/5Bub7qEeBhky/Cxu/opHKbNTcCaSv73UVBX7zI5CqvgVZqjOCAA?=
 =?us-ascii?Q?ib2QAt5Od13oaoWfTkoBeIx0gsWnUNDB29kDU7ZMIs8WSS5HR7w+owmh9ECC?=
 =?us-ascii?Q?//woZeZYhGynxfnyPujbITwcosz+iKfWTfgpefaxFpyNX18+CIdZj6c8pjRM?=
 =?us-ascii?Q?dwffzKkI0B1oEva+xi6hgkFRKdwNWL7UYUufIEsv4G1HzT1JmBQF7Lof0X4M?=
 =?us-ascii?Q?yTCbSkVDyuIBc1xTq/PZFx28UaNqE89zxFqqc4yABezdwsKFWFAeQEdNDxIk?=
 =?us-ascii?Q?75o8Vwv0o8SujNxaZ3OvlKGWRJlsmUEacgzCPLjzjAGb+E3joVwjxwlUREEV?=
 =?us-ascii?Q?MSl0a3mClqqoZhH6i+6nw4F4OiADDkzl6yVrekW+4+6yfdFEeSRAHGiFK1dr?=
 =?us-ascii?Q?/QpbLiWSFT1JzK4HQb2056xXCxrrRQR6aUUsjOcNZXJUo3KI8Hju6O37dKfd?=
 =?us-ascii?Q?+CGAkj+u4N76bWTx+TxUUWu65gXfzb2qvjRSbYQ+kKH6XZgUsx7fjFKxQy53?=
 =?us-ascii?Q?lih+wyJXxt7HUm0Z3olcIDJiE0KbqjuSvr9ptzuHMIjG0RCtbfOKWRcQal8V?=
 =?us-ascii?Q?6mJrL64iQzzBbhhIlRnKTSybsr2Ljn0vl8vDW0ItUri9dvachNDflVuhZ/0V?=
 =?us-ascii?Q?lORgbAmoiajeIb9rD6WLWOkSCfcVsfWf4K08m8QA1LL85TN1mXSdi9r8BTx1?=
 =?us-ascii?Q?7WKBWZdreBRAzRcvmstEQvRc/3yboyDGhnDDkRvQ6SsxXraeGCaVdTmeiPsv?=
 =?us-ascii?Q?dZGJDprxFa5D/cYqxasiTcw6wnl0YK7V5d35q5mnGK6Lp3oigm08NGO7pnzd?=
 =?us-ascii?Q?SwkRqvin9sUKKAzeFNMvzcIdM99TrLgdzHJXscTMhwC5b1AljyFpE298O6zo?=
 =?us-ascii?Q?FA3cq0ELhSOEkBaySG5MEyDWXQlxBafDPnZJl52760BpKuJrQkVi3OeCXAN1?=
 =?us-ascii?Q?bEaP7gFsXCGhqEOsVkxOSkDNEYBSfUQfb6opyFwKbQe0OCZmjTt8VgK8rsqR?=
 =?us-ascii?Q?0zb6swDO80kUsKkz5DLuOUYxtnHs11Trm8qsPTkAf+nMmQw6IA7B8vJc6Jq1?=
 =?us-ascii?Q?BnxvU+w0OtWvl0377xtO+mWgjncCUyTHakbixnWqsKgvShZTIE1RK2pXOEDn?=
 =?us-ascii?Q?6CVYS/bQp0Qqm875nERBeyX5qULN1fuWfUHGcXe4Hfh/1ROlJ6mZwWVwbOEb?=
 =?us-ascii?Q?oOq88/qthr7PKBepv/Wcxp+kGzajkYu2xDE1f+1Cv2APR8lVS1ZsN6rS1dil?=
 =?us-ascii?Q?VVJg3CvEwBsJjQUBaERDV79zJ/vC1DKbrUHySGSBwzQf3KhAdv35K2Ylpb4k?=
 =?us-ascii?Q?PNYFVCmq+2ADhPLbgd+sUMP9y4snbPXdbtLTqXpho+nxTfxHQU0YcRp8C0b6?=
 =?us-ascii?Q?zPppjJ3RqpoPUGGzHIur3Z/yXn9C+7j8LgndCHtbI9QlBau0Ba95YDTk+ni5?=
 =?us-ascii?Q?zTgVBs7JFw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11de23a-20e3-4e9c-7f27-08da2276888c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 02:36:12.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BpUKBf/tcwjqQ0+EbcAOU3gQEujmEt9213Z5Zdspt0J67hmLgMh69gLdP2jMlMiAY5s1W5EmOpkkCtrgVDgZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5597
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board ls1021a-iot in the binding docuemnt.

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
changes in v2:
  - adjust the location in the alphabetic order

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 08bdd30e511c..242dd99c272c 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -999,6 +999,7 @@ properties:
       - description: LS1021A based Boards
         items:
           - enum:
+              - fsl,ls1021a-iot
               - fsl,ls1021a-moxa-uc-8410a
               - fsl,ls1021a-qds
               - fsl,ls1021a-tsn
-- 
2.25.1

