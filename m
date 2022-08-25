Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78845A0B89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiHYIcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiHYIcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:32:41 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50066.outbound.protection.outlook.com [40.107.5.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB216A599B;
        Thu, 25 Aug 2022 01:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRlc150en7tN/SnR32a71EU/JTr6S/9BdfdGq8Bq5cPoq0tfKqTbktMA3NVjWQnzEo5YZP7EAOObb6WJFFAT0EhO1rG4r3XZoj/nRsuZQdyz8b7GDHwgDV7KnZazLa9lxARpJdc9Xf7osRG+qaPOINsHvR+EQxzqoO33bYV4l7O8V/fop9Pua500L66hMYiMzqJvZvwqrDy/5YXPNbC6sqVlVQ4dSePhcoAX6jtRZyD6pxfdo/8DaB1gLsw6g5aB8I/rYWhrh0xTp9h14anDk7yAcUXb/Kz1+UplgRzlXqG5peaybkmnfxHbmt5/UCkczkTNIDfAl4oQfnO5YQh7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy54CTR9mAV0idWsKdj/dYNIpkKAR16Oyj4Cr4kSiDI=;
 b=ogBVP2C8lK9xESugbCKC1kNm9CwWKooJlbik1NuR7NRTOaMc6wlpJEfE5Ar8X9ZvMnddEnX7TyTbrJsWeHEavO/v2pdGJJ/xxlwowPtch316gLSnkqS4tfcCR8JXv7ODbpd+1P68qU7RbsWcjXPrPiKIfcwnTgg+a3/LBbjolWSZ9L2pnom2qObveLaV3KiG5eNaRLMZJ/okdQBgcd8QAHjPeENkqxmedg3gxoOmdq14WrlRRgxLEyUk6TFSDhCx4w/VR6OzG1fbiMeZWGPKE3dQ76PiHiBC3GGRWsog+RBSGGFQpQ/9w3dNV7z9qImw+A2J3Wd/jlP5QP9SBcl9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy54CTR9mAV0idWsKdj/dYNIpkKAR16Oyj4Cr4kSiDI=;
 b=OVNbYHKlaxh9Pryx5QFqyo9zliZsrcnxzU5qB+Uca/7MbdkZOM/alU21QCAV/4eZy1GeLiJIIM4AkMRuy4UpRq2jv8F67sJaG1xL/Kv1csH9qhGFjVyy0XJXnSztH2E1UpqUqO1+oe7OqS3ih4WSR7aDaSBduc8wAlScvfS6lEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB4901.eurprd04.prod.outlook.com (2603:10a6:20b:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 08:32:37 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:32:37 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     m.felsch@pengutronix.de, linux@roeck-us.net,
        wim@linux-watchdog.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] watchdog: imx7ulp_wdt: update i.MX7ULP WDOG timer driver
Date:   Thu, 25 Aug 2022 16:32:49 +0800
Message-Id: <20220825083256.14565-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8accc69-8063-43cd-7265-08da86745d8e
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5Z4vQdF7LeI4DKlg64O1c4MEkEKErjHfueBoBtD32JelHid+SOaKLxCXj+BglGeefeNeqzN8JG8H/aatVTgBTYkkhKSqhSTNa0vW/F4VDUYCVYA6FLqMmT9exrfv0buUEyH03v9/KA6FJQkD3LXn48WCG8LRaLVe45RiRdbO/ixeqlA4ZenwlRYvzWkFSf7Fqv13qNpBi+dEsIbtM62qBixyPoqVQatV84UctJxuAJpN9Gy13O0jeVwMy1p5ERq6+474wNeACb63QJtjRQDizbaET5ZwKOwGIb9JfhpI1lM/6ZttPYG9/Z7tOfQIckmWf9aACv+4QgySxXOE15nxmdIvRoKS8D/aHszW9tPBXlYy64HfjdRqcmDzGYTdgFsBypZVb8S2nJ4ZzPQM2xdNqAgISBHAIU7TTuqEvg72Db8uIOC6w72RvkhDsoxGeZwfvjtGZu1A9v7bDnKAndQAEYBstBgEa/kqBSBkqLujs3JjihPZGGteeO3Xe8OPr6tn4Zn2lwitJ399fUxu3CWGROih2ZhsrDVlurtuGSdNfEz1/KCloqse+xBFhpSbrSvy3DS9AdBEqQZPzDu72+vWkxcRvrpMy05J7Gr4zF+PMIlPWNork8NX0YRoz8hZ/tM/DWj+RBJqBTbAnwd2qjittbZ9VO4f1EIhBq/YN+xdmLj+7k3LFf+WXzGrJQp5joyHo4U8Jfgb2D5nTbry8bWc5JGFns8EakbVISD8WpnxqTSwtbgiK/Cjftjjacf6gV3svhb+FTw4SE4MPlSFwCN7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(8936002)(5660300002)(7416002)(38100700002)(38350700002)(4326008)(66946007)(66556008)(66476007)(478600001)(8676002)(6486002)(15650500001)(4744005)(6666004)(41300700001)(316002)(2616005)(186003)(1076003)(26005)(6512007)(83380400001)(2906002)(52116002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4SMjhfX6uq100EUnoH1gjbdnwkTuZpnaAUGHj1mfDdUIFQDrZ5meRKQMCsb+?=
 =?us-ascii?Q?C1gbiRsDrhoFxF6boxvM1F4RfKgu9NN6ANJiNxm8xWB9cRcpqSFt+X4JDnn3?=
 =?us-ascii?Q?uTA2doSlg4PD31CtQfTFUQQqFrryoWYBIcsAFz1agBJdTc0e4+DymcM9bqE+?=
 =?us-ascii?Q?yUnvkbNhNfoTAQpp+8dpQX4Sz5RXigOMhtguBs9Pksk9MvPpVHgkY/p5m7f4?=
 =?us-ascii?Q?OG2XfeScWplpz9lJ9Vk7ZG0sfN9/M9M2cCr1nAS9DeTbJW7cq+vcO8bbViZq?=
 =?us-ascii?Q?pOrzQ3OXTvt1SAQAw6HBg0ctdMbAVQ4GxNbkfCcX8nDSpvja3BNbWZm8hh2Y?=
 =?us-ascii?Q?gZbchYcylfr/RsbwXKXBEObiJN5PDuLUmJw8BgJ04H30QS/Sln+5lCRX9Xaf?=
 =?us-ascii?Q?vUp+sV+lT/OLRtucGdqWM3EQ2j8UqqQjw9rdwWDeAQjA9AdAbTTj0CpPB20Y?=
 =?us-ascii?Q?jgYCYktC8tQRBTlxfgOCkWNMPBUcfsoLsY9+tlteTayTjZ5hVWD3C/xB7xSi?=
 =?us-ascii?Q?BjT9pKhyG2qd9B5P0+FpAQHsPHIi+ug28+RwNw//3fkx4W0eZEMxJukcIB5k?=
 =?us-ascii?Q?zT6/r7oM6chsnlQFx8zSs4xWCdl2ufdboOU8dGgdfH1zn5vUcObPtfao7vxu?=
 =?us-ascii?Q?+j8lYz7khENC8gn05gUpmKa0qV8J+MJLveXalVXISm5XfdWq1ck1K35B6z4H?=
 =?us-ascii?Q?/7X74O9utKW9kCGO8vFXptI3ZG9wQcY/+cyNEW5btK7ZxMZU3HKdVgk1Vz2S?=
 =?us-ascii?Q?jqT6vrLuGo4hYx2Cv0ry/w7tJ+U28XV0mW/+9Hqr5i+eXOgsrxviGqEeQLkx?=
 =?us-ascii?Q?tbBL0aLIlPO3NFQDuUBBqMEcEOx+UrBfc2T6wlLHmCss+3W9ZZRNkZK/Hphi?=
 =?us-ascii?Q?uf3RIJeX8iL+/INswS6KErqaT4HPokXkMqf83fVIJpUeQRWZeG0k1ROeIOz+?=
 =?us-ascii?Q?QkrjGn7MDQlDjf77UcJSBvJmMPvQ3v5d2tC6FeUjt/ecn1rM0Lr6Y0uWZD/c?=
 =?us-ascii?Q?lT2zDzaF60K/t5tkXXTp6hmptwixo7Ojh8nE5vW499YADyHj1ga9GMewnHYU?=
 =?us-ascii?Q?wTj3KLLV+Ix0YH4oC9szxIBjNjLDmtdAegpQfaTfGRZrvOID2yUVPjOCVi/K?=
 =?us-ascii?Q?njJhsVfMtAo42FKEA3Ku3ZLh1bX/SvdCtZvLHSrDlMwVTp0aqa0uLVGPLvz5?=
 =?us-ascii?Q?gwfHzw01BIp04Y8Tka+mF5oz2rtW87YYAqSyuAuMk6k75zfRxMZIaG9P0jBx?=
 =?us-ascii?Q?oJUODRqa2QDrMpX7gRUHHAO41sOxpK4culPJgS2cwRT8hIqrcIH4MBJX+FKY?=
 =?us-ascii?Q?23aNE1lhQTmUoeenJvIk5APHfgJoxEqHV+U/LdKWN0mvSZlPs5tnrByn/639?=
 =?us-ascii?Q?w6teyZMhWIvBFnrZMcM7rIf1u2Ip6e71vkZFT6zSZ8OJGA4C4mIpmaT3tkz8?=
 =?us-ascii?Q?jNDJWckSOxZFHvpYP36iocNXfy7+mnQMEVP9OsD0HXRTc5eO9Gb1/rV7Rvvq?=
 =?us-ascii?Q?YAZGspY2mtMxoOJrh0KI+67aKeJF9ngAMNYYQJeQRAvDrK/hR7SW7VTEXYy1?=
 =?us-ascii?Q?HvTJZes/yO34ayoTLilrO7A/LaFpxvMbeRoPTDPq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8accc69-8063-43cd-7265-08da86745d8e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:32:37.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kn0P2g5FDS9QnxFIQvfwDKKryxqbUmexSufn6mzM1XYyYeYtDWV4CnRBJIstHp3JJgXq+P8N97Yu9ejsBV7JwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

