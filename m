Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6204AB334
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348038AbiBGBxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiBGBxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:53:30 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130088.outbound.protection.outlook.com [40.107.13.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB5AC061A73;
        Sun,  6 Feb 2022 17:53:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIOueEyBckt8WV/0orDXhxn4E59KAWeE44DHgX3fVV1f+tXAGnGi/R3FyTPXjg5DazXFX06tYb78tBhVnkRvv/sclTc2KBm4lWaAYzHNtn5e69+XfH2uBUgojytzmw8bFVD3mj2VEtcc1JpdVPTN4XUEkKEPg/ktFaOTPfPbhW7Dlhs1XOaLpHoTRkCp/6l9QqJ5txLTLAC/eEJ0lewQnBnIcaR/1gHq1DSxdF32XXAs95wA3Agg3eKIL+eCxPwVZGj6rGtZenNYGrxZmsX5ie4FHJ2b1IiwlAb3oqtwGrK63nc8Nc+Nehkqdqk6eVKJ65yUcbvMje8NuXHgdWIJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQ+eBBHy3a7XCStcRLckEjFSjUiaJhvxgp7SE+Fhetc=;
 b=iUghezE28CpydCqQVm0SGXzi7ptHh07kvK8+mFjUmIO54T9yOqDDxeG1XrGQuUbKcOs3bFcEMthlLPLXwb2mCJcgrDIh0ijxMFf6LRSSCYhgYWRmU9cYsKuUoS5d7pxZi1houwZzujC+1zSKkPpYISoWm437Vb99jixdPTps6YtQLNUpT/3gJWME8uM43k6tIS6n6i6MHSvRXX69wuSZWemeU3YTr6eodbnop4zpGWUD9AJkhBRtznj37gtcHGKj/Tq/dG9HBto4Djp3N7zhR3ZmSYOMTqmMXNy5Z6npzYlqEt4Kj+kvv95TLOtZH+KFWnRcHfzKqi3h0sLyFrv/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQ+eBBHy3a7XCStcRLckEjFSjUiaJhvxgp7SE+Fhetc=;
 b=BW+jtYMq0bMX84gUcz3+ZGlLgB1y3Mt5dqeLkgj0sOjZBgAFYApbp2vKyI26lcxwU2G5wD/iLvg9dcxMCZz90nuhcgKeQIleZIRGGs6g6WFpnEyYtXQQZ5g3VRleTV03KNMlT+v4Ws3330/7iPdxsr252Jjn3xhGbmK+jAaxJp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2493.eurprd04.prod.outlook.com (2603:10a6:800:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 01:53:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 01:53:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/6] mailbox: imx: misc fix and SECO MU support
Date:   Mon,  7 Feb 2022 09:52:05 +0800
Message-Id: <20220207015211.394297-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3726985e-9e1a-4bbe-2dac-08d9e9dca0f5
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2493:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2493FCE61F792A92BD52E6B8C92C9@VI1PR0401MB2493.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXMVULOiJ4zTfGx9vSNyJRr6k0bOv0L6YGFhK8oslZMIIlcqs+VzrRFj3guJXz1F65oyU8ZLdfeIZqsyIw9VtzWl6VHwtGf4iFNhmuOeGe+rR9wVOEZ5T4XOKtfA4dpK9fIvO242gvoOy7P86sDy1qRDKp1gKIidMMTIbqEA6PsZLm5Gflry137BSNQBsQZ3PXWlTuMsQskvZ2tjRBDiPVYuVswCV96AUexrp/P+vSKnFLQDzsKhWIIjOi2Z9EJOkgtwZOTkcFeTs3P1a9QoaZ1al661ari1kFrifqIbuKwxJkusLFcOgeauukdLCIgmtIQNzjFLrYmyR/jj5AhzK9bucPg74gpRa8dqndyqtVn1oy/+GwPm2ffBGO4bskc7Y1YXTudO2C281z0lIX6yhC5/6n6PHagJ7+yAiKCd3SWN9CTlec+XFK3kY+aZGktVO3c1+blXDBgS3xj5fwRQYRiOcZbI0W1NybWyxNagHF3YD3AKUJs2V1pRYMhBWu/YQ5zJLyG+EutMnH125AyQMyIFz5dU85OyYsK9WAM4ap9/DmYAwRLQZpc6Jyb+BrqZTBqIL0V7g8U7zDCdH26nxyTi6pDTPOApmduHHuaVeej1RCcRGeQJdojPxoXsmS7J23qVyvcJBUtQ8RYWX6rGHDxG7gE2893jY1hcu2w8FF03fSeDYK3/B4NP+5WR3CsuVzz61lhZ+jpvQrAs2mDYdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(52116002)(1076003)(6512007)(6506007)(6666004)(8676002)(8936002)(66946007)(508600001)(2616005)(66556008)(66476007)(26005)(186003)(38350700002)(38100700002)(2906002)(316002)(6486002)(5660300002)(15650500001)(4744005)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IpbQpRszrjCRGCgal0Voe8dN6fwWXywpNrPODVL77LPzuPZMMxvFETin+Prs?=
 =?us-ascii?Q?Hcwk2ZvL2f3tiSy/fSu1H1Fh9tdwiTokTdIdPIfE3uHjOK9FY6Zn/dIsdHIo?=
 =?us-ascii?Q?1zdIPCGAOZrD7/giVIAZ9exOiF79RY3g9l8kU2M4npVWzxaNHfzrE4UCrBSF?=
 =?us-ascii?Q?tp3Y+gmu4Z4E+stpd8NVZZy5az2LdWhLfkyDUBCV5MlHYpypf5U7SQLqbtUc?=
 =?us-ascii?Q?50JLt02lklcc/HsVilwKhgWmNFL25EULUSZ52HQf12nLe+7hsTBhpJ+nXryq?=
 =?us-ascii?Q?M4ZO9oHwoYrGf6YaMXh8WUJlFoBgcTs6zqgJnL6S7x99tSIN/ezI37OctKTO?=
 =?us-ascii?Q?yYuz0qpkRUmywSgFbBaFvWvT7WXgH7aDDLrx4siD1pf+yX5RnPLW95lGHI3y?=
 =?us-ascii?Q?fMktqzHOls2CKz73wAcEwGnZq9O3pXKGaX8W/H4ySggy2rZrWcM7zHR3NijS?=
 =?us-ascii?Q?lWcuByDaUHTk+Hc+EIpVpF9mbKv9m/wBiOq+czIMUDjlaTC0R+CC4a6cjQdI?=
 =?us-ascii?Q?eux5BRf34uG0OmviTbgAH3r2lVp1coPFAyEtRpim+70ysV5A7JI1eiYPurL3?=
 =?us-ascii?Q?8t+meC7AvUKfQggNXzvtR51bFypnf0ZeZSV1F5durO5dLNC64ddP1m8XRBU1?=
 =?us-ascii?Q?+I52seGvFSfp95g6O0J/T6uXFAX9ib2q+NK/jtRGNe7ZYDS1qkduw0yJEkt9?=
 =?us-ascii?Q?DaP+AS3z3qLN9O/fcx3ZA0ZGQEhrLNyoo9QMNyXUQU9fURGDwyhrVhVu0KDp?=
 =?us-ascii?Q?G7N9rTD0iUXTZeUyPYhCodMxMGJWYh/Az0rv+v/QXZfcZEkoB/tNhA26pg23?=
 =?us-ascii?Q?2fP8iiklHD2ThZWtdMR9jd2ldRZ7r20nlvrwPMwfd8knUkXIHTL5IC3f2FkI?=
 =?us-ascii?Q?bNkg48m29DgCB9xcBUtzbs0xZ7TClXmvxPWZA/6a+m44s473nH+D4EoyHIN5?=
 =?us-ascii?Q?Qz3TV30cJzcHiVeh+vCdVB0ofumwv5IBzIKhbBlqSd3cczeR603vmCVpa8do?=
 =?us-ascii?Q?0bY5AZGTKz1AuwERdeTJphBGJNPSbsWtACREzHCXge9rzkcw86AyTlHVuwl5?=
 =?us-ascii?Q?/pnJ4bAm843zEutRvWbkkXEYXmq1BAqXYLzPuiy1bq+yhp8gpHb4t4KyJ1WQ?=
 =?us-ascii?Q?Woky5XE1qjb3b3gfyMZ2OukoX4FzkdiUrH5eXU6a3P6XtuUriCBJAOWhwNa5?=
 =?us-ascii?Q?Y68DYnB8A2FSS4Xl4e2vpdIy2sW1ccY3fINKCZPEEw44iQt0mup/8UHzbEZK?=
 =?us-ascii?Q?VMRw2eFb4HZ3uw1AEFNVc7UG9JPKqw3soKUf2XbNvATr40NRImWO0wlcLspf?=
 =?us-ascii?Q?z1s5stPXeIVMaTmnj6wHz1iYi3Eniq2aGyV0FC6vahPSR1DOGn1hYnJldA3i?=
 =?us-ascii?Q?KfGWpMtDhjXOynRzWTZobB7/LDGziDgUyr/b7ir8vd1EVkdDJaCRc+QMt9p9?=
 =?us-ascii?Q?PzVnQ3PbKC/sc26ECWfUKF5eM3ehcZTW4/y5CmjWuF5R+xydizgVQcyGo17L?=
 =?us-ascii?Q?eN5KQzs6IO5bNZswSfX9/io7mhKCZBxvkBgn8ggzP4qBKJiG5SGuChEmrC/S?=
 =?us-ascii?Q?slGYkUTtzXqepWIVjpU7FUmPC+xHqkTlGGNPCSQ79hBkVFnBAYyds/0hlA/h?=
 =?us-ascii?Q?Q77E+ZGTTaeSIi3xqMSfYZI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3726985e-9e1a-4bbe-2dac-08d9e9dca0f5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 01:53:25.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jzd2hwRiEjwPfY9VI/mmxcFW3l/dYbX53RLLGL13Vb0ugSwpekJJ7A0rQDSdM52mG/SSSDIOYTBIhVS13gIiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2493
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Drop "mailbox: imx: Add support for identifying SCU wakeup source from sysfs" from v1
 Add A-b from Rob

This patchset includes a few fixes for low power and i.MX8 SECO MU support

Franck LENORMAND (1):
  mailbox: imx: add i.MX8 SECO MU support

Peng Fan (2):
  dt-bindings: mailbox: imx-mu: add i.MX8 SECO MU support
  mailbox: imx: introduce rxdb callback

Ranjani Vaidyanathan (1):
  mailbox: imx: enlarge timeout while reading/writing messages to SCFW

Robin Gong (2):
  mailbox: imx: fix wakeup failure from freeze mode
  mailbox: imx: fix crash in resume on i.mx8ulp

 .../devicetree/bindings/mailbox/fsl,mu.yaml   |   1 +
 drivers/mailbox/imx-mailbox.c                 | 249 +++++++++++++++++-
 2 files changed, 243 insertions(+), 7 deletions(-)

-- 
2.25.1

