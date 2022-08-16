Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E12C5953C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiHPH2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiHPH2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:28:13 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78218384635;
        Mon, 15 Aug 2022 21:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Og98N8rZ9ZzAw4Z0HoZ6228nZjCQd32MqNR5/Tgit8J5GYhBq+ztpFeUCNe908pH/Hpe1mDACaZoes5scvY0dy7s5SoHTuLJR1AOGmL57U2bW0OnpdMOrgwq0F8q98IiSH4NjWmkGtWGKcuuJejEpaxL/eiFeFhSCFqT0lZMSyLcTEW/mmaYot4COFtk+nZWWRslPEwKVfjrtCdKWUdAVS61Yjf3COK1NE6B1hjhErWOPvROgwmCDM4qtlWHuhTkoVd9LGCVwUzXe5DM1J3yWtVCOAyqmTCBeQ+ig1WBs2T3tq42X2phBaza6TQbfKLskBr2KhP7dRA8vRKBo40/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy54CTR9mAV0idWsKdj/dYNIpkKAR16Oyj4Cr4kSiDI=;
 b=c7bIpVhQTciWZ9AlMEh9/b/u72xxSEWMd8YDdUnJGX97JLOMuf6W4D/SS3LIrVpYoyBbfMxqmMj/ymSXj7pz8s1DXvuUk1hfz9msX0BZkCPb92IGWtDN0aEi2xdKxBSuD3G4GdB8nQSn4bf28qZ7EPvm+mOYWsHmZSP08EQW/hBBIK7+mONbQoq6MbYjHggEV0ofmA2pK3epyqbLpKwdaimGJlXr1ywPOkcyGiUriUETLRvTWSC2sBGk9h2+OwmEZbDDP+26pj+SomuezNzwVzRrT12F/9Rsy1J6VKr1ebtXdvM+YotLZZcKfq4/HPRmJEP0aWu/6Q3X/K3VkIto4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy54CTR9mAV0idWsKdj/dYNIpkKAR16Oyj4Cr4kSiDI=;
 b=lnAobDIFu+MnwdGZe8pMM+HJMZp4BDPfswNOD9bjeMAnJQ1zgGDDRIJaQ6arWtNQ8QVlI/nU6yGpwxH1w8g8s5Xf3MEFxwlwbFVuVRr1hGqH2sdTI+MazFvQrK1HxiXoBPIDnHzdcYv5o+yz4jV647dd0WBez5GtHP/HvwapxxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 04:38:08 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 04:38:08 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] watchdog: imx7ulp_wdt: update i.MX7ULP WDOG timer driver
Date:   Tue, 16 Aug 2022 12:36:36 +0800
Message-Id: <20220816043643.26569-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:3:17::27) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d69241b1-a11a-4a89-0ba4-08da7f411dde
X-MS-TrafficTypeDiagnostic: DB8PR04MB7036:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72w5oWvHhl5b6Qx8KjL4LZh3sOsnBZsMd+YhbQb1FBWylhrmmc+7SrRFnMwVSqdfwA0m9eOlTfN3AN6LsPOWvWzxgLAwJQ0UCJdpCzu+fNEyMlNJ9bB42wX3tHkWhcmPxw+yoMLmuVIeu/3fvuWXhyJ90Er9spBX9lqxToFHhyzP1zF7CkveoEoX/RghggbB++4Kc5bJFd0+Cuk+yg/M1wHo8vDMq7IY+jmb9JayzRzG9POIyQEwsY4U5Vn1s+VrwWJGHNyA4LnWaLsJoi4OQO5vUpg5FQ4CMa3BQJOmn4XYW+SHV/8yDaWs9dZpFeYyDAumZUKdAdxL7fNKTWTeyi96AnSDp/XuJjT2omWgWIHUVg5jzAnCGb/TVzoK/dbG0SoNWpN2GySz4qcRQ1gYps4aq/4TSxxa5Vhs89E0vuyg4MpJgMfbhDtLUgoyFdhRn30EWhwaCyiofCaAooAd+S5WwZgpGOJ8394BbYsKjTprwr50+EAPH/XmEahlswCF+jQDU30p6FV90yaBIiw5z+4u+8G7cg0LSIjZVqA845v3SDsJPz3XQECyPELSAWVssR2kP3OHBgfiVUgejTGEBxuLVBdqaVJrHD7JooE+fNKgBMYZkQqbH+Zrkpvxb5V6hCrw6QyBk3bsCA7X4NKPgHuqKCr6FIOZmWArfksYtyw8OZ0NKMA4QkATRrxMyQ0bw74mkjSNwKPbsayHUNDLrch+yywaOuJz8fRPfhmZs2X4T8wGpB2IdJ+qMk3pUFPOlvTmn+XFuIoDCRy3C2H8mfm2kjQr90vv2NlzoFga2q6Hgn925NoupoW2XVkqk0ej
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(83380400001)(38350700002)(86362001)(38100700002)(4326008)(8676002)(66556008)(66946007)(66476007)(316002)(2906002)(8936002)(5660300002)(6512007)(6506007)(4744005)(26005)(15650500001)(1076003)(41300700001)(2616005)(186003)(52116002)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rz4VrT77G0aYwwL9OdS6hw8uzenW3aCZK8u8x+OFFM1/g+HUdMcTfhAEww2n?=
 =?us-ascii?Q?0fBvDI7D8Vskjt7YcdEpU153SOF7VVGzUSQ+Vcf8pHa/Brwaep2cUY2zqqhg?=
 =?us-ascii?Q?yOaI5HLMQTvxGuHXJifB6LPcD0AvYu+kdKfIqEISUstMnuzQ2x7qwX+7AsQG?=
 =?us-ascii?Q?KVqrDVfW6jdh8Jf668x4nWpp6+VtMA8s8jSrQdE248KN7WpW2ZuhUt2+1fGZ?=
 =?us-ascii?Q?j9hImiSia4zGpixNXiUG+y8FIdRZEXw7ugIXxm6tLObbsbSOeu2dpgeh9/jk?=
 =?us-ascii?Q?LPK2I1cjM9E/ZfmT60wthITVPAqKLA80dvGK2R7ceB7ijjxSyhUzMVnBuPjh?=
 =?us-ascii?Q?0TEqH0yRJ0rewU7my5rz7cOELpAvfVzvRAGpKa5p5LG1Cuwer7w3eiq1DbCQ?=
 =?us-ascii?Q?TBc9+RmgwzsSdWrQT9PUQqbd1qq7kXn7sbQUXl/2q9FWKvSafuLWhFTJRara?=
 =?us-ascii?Q?yyqkF//xaE9UzgVvFUS83t2CgAROqO3NVSOXW3gfLIrA34a5OJ1OxQrKErSI?=
 =?us-ascii?Q?Q+O/DeJnt7vQAShyFuCkr0dTWCWXZQreXITMJUkSuO7BOCbQA5bVrbn1HesK?=
 =?us-ascii?Q?tPeGZKOJK8eRfrGKFtcNZ7mDsBRYFMVXtgxRSi7PCZWxo08zUteh/39w0cNv?=
 =?us-ascii?Q?da5YAoAKBvy85EIIrRxbWwdn0ZiKDHXME88WMtWJ4OhzdWJ8VshzPy9nIJwu?=
 =?us-ascii?Q?5/snMFcjTGOSDXR1x4QYe0lACr/FAo0w6i3EemF4HcoWy1AYscMkfnOozMrd?=
 =?us-ascii?Q?hDcqQcKOgLlH5aboO2OD4C6hb/uzzJcsnYLxdZlsNoV+z0Pfajh7AJjBWb5D?=
 =?us-ascii?Q?7DR5dRPYdW+4evYzLQOuTj2viZCfVjHXm3lWb2DCWHwQiW+1hH5Ndsmx/K9j?=
 =?us-ascii?Q?zZjvjtYjaPrBpfNFG11sGYGyTzxE6Xh0lJ2V8BeJYGdIV0Vz1bi4KNjUA/0y?=
 =?us-ascii?Q?PfDvaFHW/pAhQk07yRejXk8sNUTyzF65V1nzaSY+K1GVmZ+akTe93JVKoqaD?=
 =?us-ascii?Q?uvyegttOI/nFXIwuVgxRiISgZai8eOkfSprdg4saKuEFttw+MIvNkgVj6n4U?=
 =?us-ascii?Q?6Snr9ShDWWD1jCCCCpoQgN3P6QW8eZgJrSCXUxeD7buULzbsyJWn0vB+k1FU?=
 =?us-ascii?Q?yTkUQvhdwMrBGdPJLe8J6xNTzSyR1tAWG8NYZN7k33dDVTTkMYG992WhhVVR?=
 =?us-ascii?Q?asAQ9vhRYoTvIR1utqbBdBGALz58GmYjNhPnohy1xwK//6lfmdRAFW3NFLR1?=
 =?us-ascii?Q?a/qtWUYwO8qQIvykXi8AV1CE+nL6tP2uo7fsBA0v0CIENlH6OGRgjj2xA3IM?=
 =?us-ascii?Q?JJeFuUOykP3+IqNtngbVTmZZ/Jbzvr/WQI+2uK1/4hyvk4RGEuR++OxraDbc?=
 =?us-ascii?Q?/K9SQp14E6boxo1DkRirRXw+cvGwHduq6n62c5oJl67jk2Nqh+Uq2F74X13z?=
 =?us-ascii?Q?Rnqt9leXvb4gppccjJkVwWrWpvMdIb/vhOt/6lmg38EA6NNtKdJqwPPYj5UD?=
 =?us-ascii?Q?k6e4drefS/HXnw+oPFr7E4sSV09xFMgWynoIAzeTFZCXFu40ueQnc0/4JT5D?=
 =?us-ascii?Q?ahWEhraf3FQxB52H5LTXEr6RQ5UbhFs5hL1SqwKQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69241b1-a11a-4a89-0ba4-08da7f411dde
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 04:38:08.2195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAPTxtTgPbRKSOCf5roYpwHr5sRLbXB0o9n41+osLEp5vFAj/u4pxQCzd4jbaXkeJ3kJM2O1tsagViEJ2jNk/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Alice Guo (1):
  watchdog: imx93: add watchdog timer on imx93

Anson Huang (1):
  watchdog: imx7ulp: Move suspend/resume to noirq phase

Jacky Bai (1):
  watchdog: imx7ulp: Add explict memory barrier for unlock sequence

Jason Liu (1):
  watchdog: imx7ulp_wdt: init wdog when it was active

Ye Li (3):
  watchdog: imx7ulp_wdt: Check CMD32EN in wdog init
  watchdog: imx7ulp_wdt: Fix RCS timeout issue
  watchdog: imx7ulp_wdt: Handle wdog reconfigure failure

 drivers/watchdog/imx7ulp_wdt.c | 212 ++++++++++++++++++++++++++-------
 1 file changed, 168 insertions(+), 44 deletions(-)

-- 
2.17.1

