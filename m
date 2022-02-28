Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3298F4C60C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiB1CH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiB1CH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:07:57 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150057.outbound.protection.outlook.com [40.107.15.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7886B08D;
        Sun, 27 Feb 2022 18:07:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8YEsg8l6k8owhwytuHAw2YvDOPwt+d3OP2WkHx0ozJ4As7UphaimVfMnAbsWU41QA7W1XZRYis0rjt+zO4vC4JFiOWII9pISG70NPU0gWX7QT9iOOlPxdRZWvBhydsCzvgZ+TVjvVTawHRCwSJp/y+QQeII5YTZqzya5Ssn1gZbXQdI1K9w3Jx294bwGv1ZiGYKDCRTUhAybERP3sujgj9F7upGcNklJveGeV4mbp8G01sxtwQURfTrVxjOAN0iWtA689PzlpRhPzNGOjywjRg2Rb0RUdC1pxGavl4IBJqtZQ81kj2JKrmx8JDL6mrEmP8KiJor/OhjYHUs9ywG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68D02XazkrwaDXAN15PZpeHsm572ACCjuLvA8NShyGI=;
 b=hLayyggAncQTuNkVuBMMfEnZsnx2c6vQ27t8ODS9UFjrbqhX5x8Xc33aghJGQJyAhpCpkKTPXmajeMx0HHkImKTGa8dVoP0FfJ8xwvvmLNYySh20knZ3W7/EQ7fQsrj7s8rJLMO0ZCNawZc/PrCunivWwjACWjWIXinKMpr2iTgDfI56gfkSFHEoCLaBrEOiphKAGNP3AMDfNpO7gyOmbattPC6x2cyfrU0VvR/lwL0DGlcodcYQhSwlcXqJ07hmz1JgEa4EasNR6iJPZQlsnMmArtTT4YFpB6Xw5rpVZYeEoIYbllxb/0/wu//SjjoMbKLper2ciBnvJvuX0odRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68D02XazkrwaDXAN15PZpeHsm572ACCjuLvA8NShyGI=;
 b=gvU2WwBQsOoi2KsGmg33r3wqNlCxaS9K2lZhq2/HJSXMLRcfMPSwZnKRQJkfh1YjnQMMi1OuUB8JFcwjtwzbpBvXgpwg0DuWB48cMjPh3C+aZUmx/IcZLuFAd8Gg5MwXULMOhBYmLI2bSVWPqlJAI/U/0ORz2TPux+iqq6DJn2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 02:07:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 02:07:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 0/5] imx: add i.MX93 clk bindings and driver
Date:   Mon, 28 Feb 2022 10:09:03 +0800
Message-Id: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fae4a9a2-d0b4-49e1-9afe-08d9fa5f0a8c
X-MS-TrafficTypeDiagnostic: PAXPR04MB8734:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB87340C4980544B664B756E44C9019@PAXPR04MB8734.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Rd5NTFoAAKpDeDmgvxsZeVT/FLGXKks8OUWwR95/lYEjLr/0jclN++bwUnZ9dOtBrXnUx4t4TKPdC1HOZ5Uc1Z7qIkgv34o5CBzU7IBAa/u3xIjiR+gp3BewrupPx7lld7ji7bn+EXW3+OxRP5gLQxOJDP+CUCr0WscgvhA+79WHb4Sz1bmmtg/ng5KCdHLVGdTAGAaMdJ9z5U9MLLXWBBNueIhDQDOJKM8fYYVtay9oyLFAo6weRgNcdcYezDfvfNIP7XEYjtPnDQxcMcgGcueNeMlmryLGo1QOxMO0ikxRaSbLJXdvSZjPQm9ctv0xdU/svL0hthKqouYOtijrWLGsinI8UYL2bCUY1j4NE/hQopFK8Q/E4IWikrS5hQgdb/Pl/a0AWQnR+BXbJkoh4fSiSWuM6NO6A6+iDNTe3ntcMM4y/jpx9hHVHogaoqV9Tx56FFYIKMMmh58/CKlQ7CmY4x4CUp6YcwtwGjBu31ZNMQO321rtQ5R1JSYIq4gM5TIQgYasIpjIyzp+6M0YCl9+QyWJp0MrSlmrIW9afJNgyYJKxXhvl+PrV/4zfXDxcHlJEOXjTsqpFYMvchyR6rZ/9v5da1s2y1WsE7sBulFUyhiG9vOCuf4UmbBrvOUEm9ilUHdqjhKDOWyIL3iBvHWCqyJXlGXPwObuqaa6iceNOQRoIs7e7JFznCUBa3gdAapkIxquHLZ/u6aiw1QyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(5660300002)(66946007)(7416002)(66556008)(1076003)(86362001)(83380400001)(4326008)(8936002)(508600001)(186003)(26005)(6486002)(6506007)(52116002)(8676002)(6666004)(38100700002)(38350700002)(316002)(2906002)(66476007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hYbDj/gP6Ish+RwaZhxTFyuxs06TyTwzPKFKwzJPnsxMN6+5Pxl3Zk5VGH2+?=
 =?us-ascii?Q?Q2qXLf3mM+l6zZn1OM/6ArFrY0pHpCp04efV9dKdqRpw/nW/aExWxAFXNRFP?=
 =?us-ascii?Q?jyme/7zET775JIHSG3RyY5U5Qc9LC3TGcWNGl/vbOVGaXHS5LksaKSE8ytbD?=
 =?us-ascii?Q?rdm3j3fyOvRy7AT+g5BHLE06J8j0lGgNosHEdNxhYrDXIME9do22XIChcNdC?=
 =?us-ascii?Q?r79iUK2cZ4T5+yJBneXEQL3v+bMlwr6kpwcjAZBv3JQnXCDNYYy5jucNRsHQ?=
 =?us-ascii?Q?h99KMrNqtjTNEfmElXYGQtq/fgsYTAgdQ0mH+fGKhFp0LyelKFV9Asf9HoBy?=
 =?us-ascii?Q?dOqe/j2QcvBHuKmAzRLfYh1TiJpufo/HIuZ7lk9zDEk0qoym7WF7lSri5ajI?=
 =?us-ascii?Q?BAb9SA+ac9ll1cmDf0WpBQpOZCvzf3NYmdJahiL4duAglSRwJoln0bzCw26Z?=
 =?us-ascii?Q?SmZkzoBiMvovAbqtm9utdHCz7nCUp/I9sJ0WIu7JcIYrqpGQg+p5QEQrDNXc?=
 =?us-ascii?Q?AsexbIdKKThL6UKs7uujkMFGIGJja9S7ra/nJeLLTG3Jk/ynhUZesvBrU7qp?=
 =?us-ascii?Q?eOAajbsRGM3u5mEZf3jbDJPuu/uD+E6yPwMcj3u7vWiZ1TuX+4HM/M/aCzb3?=
 =?us-ascii?Q?O44cR14epr6ZQ83nIlXe7Zty7bRserDGCjn8lKc3WkkiD7ppAAslXi0y3nzj?=
 =?us-ascii?Q?7s0Ku+uF9IxUVQKHuOSMb4g1kmVkgJ9WnWOweRE465NmfnEG3TkKshctF/H2?=
 =?us-ascii?Q?M4xZ1vOuRnDfV1WVWF973EY6h8zTeJnvAy8AvrYcvYRSiMaci8O/JO9TRfzB?=
 =?us-ascii?Q?c1bJ5kCVyvzefSOjfVfdBsC29d+F5zuQ68IY8kCgmotTCxHv8GLKn5sGICcm?=
 =?us-ascii?Q?vJ7f3MyLDaSVo0dFqtFt3YwvdSFIMiZAKXdWrrnxnCyxk45Mp1hfM9VUbnQZ?=
 =?us-ascii?Q?iWEssCYa45iv/uDc+OsTWIVLeLrQICVGzAIjnO9xu1P/uerJgq0wZ2T9mYlf?=
 =?us-ascii?Q?BMvRX0Ij9JAY2aI45KD0yP5G6ySxU1dQdq+isXS+DFq8xvGqIBhhtigXQnwl?=
 =?us-ascii?Q?uX/EVvuZ8CjqCAyT96CFn0kHujvsnQBkUzFSyPj2HALGemdz8OWUGiVmP3vP?=
 =?us-ascii?Q?0FvrZui1qo71OOhk7ECqbDuIeHUSa2zEJMw/BS6ptipJ8wsdpAqwiQAFj7yv?=
 =?us-ascii?Q?8J7aoxUsH0H0fi8PK8HsLJvn+ojU6qP00bSfQnYARiTkqjpBvU2FUOrqkxqK?=
 =?us-ascii?Q?R7q6HrUA1GmXtqNRMtzxDgtdisrV08/77soU0cHh++ae/Ezh/C8K6G1Ypios?=
 =?us-ascii?Q?dpjVEWOIppCvQnVsRZTS84axtIaeL44mCT62AzGpXFg8rZY42wtnySQhVvor?=
 =?us-ascii?Q?oHxe+ekI4rEdWZ9S91Ru90DodACUHYMVXIwCSsRX0jtDUaj2Uuk8dl+4U9Sk?=
 =?us-ascii?Q?uWkCtnb9tJhpbJOfyY/n0UM4rOL7VBHlYgz8OJKlKvR7r/x4ZxVRe4I27Kwp?=
 =?us-ascii?Q?sAyvAd53vkXDrWrvSrF56ZuBl3gPjBYUciIaOKM0dToP5v158C5nhdryZa//?=
 =?us-ascii?Q?QaMS9BmeQnbkrSG3B4j6bT+22qb8PVZNqKYqDAFQupPEwDUKX/zXUByqNq4O?=
 =?us-ascii?Q?jeYk0aoy/J8RJHw8of+rSfo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae4a9a2-d0b4-49e1-9afe-08d9fa5f0a8c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:07:16.0159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQDGuGpRr4cs/w/7ACJkBO2AQGiW/W/bBJQmzGLnIUzBc4BNZqVTlZihXfliF7WpNdXeFsT445YcaF7m9uLlDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V6:
 Add R-b
 Address comments from Stephen for patch 4,5 to cleanup header including 
 and static const array, drop unneeded WARN_ON.

V5:
 Add Rob's R-b/A-b tag
 Use FIELD_GET/PREP in patch 4/5 per Sascha's comments

V4:
 Add Abel's R-b and Krzysztof's A-b
 Address Krzysztof's comments
 Address Sascha's comments in patch 4/5
 Typo fix

V3:
 Drop an error included header file in 5/5

V2:
 Split yaml binding and clock header
 apply to Abel's tree

Add i.MX93 clk bindings and clk.

Peng Fan (5):
  dt-bindings: clock: Add imx93 clock support
  dt-bindings: clock: add i.MX93 clock definition
  clk: imx: add i.MX93 composite clk
  clk: imx: support fracn gppll
  clk: imx: add i.MX93 clk

 .../bindings/clock/imx93-clock.yaml           |  62 ++++
 drivers/clk/imx/Kconfig                       |   6 +
 drivers/clk/imx/Makefile                      |   4 +
 drivers/clk/imx/clk-composite-93.c            |  93 +++++
 drivers/clk/imx/clk-fracn-gppll.c             | 323 +++++++++++++++++
 drivers/clk/imx/clk-imx93.c                   | 338 ++++++++++++++++++
 drivers/clk/imx/clk.h                         |  30 ++
 include/dt-bindings/clock/imx93-clock.h       | 201 +++++++++++
 8 files changed, 1057 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
 create mode 100644 drivers/clk/imx/clk-composite-93.c
 create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
 create mode 100644 drivers/clk/imx/clk-imx93.c
 create mode 100644 include/dt-bindings/clock/imx93-clock.h

-- 
2.25.1

