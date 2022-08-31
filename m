Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1A45A7AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiHaJ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiHaJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:58:51 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130047.outbound.protection.outlook.com [40.107.13.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2118EC991E;
        Wed, 31 Aug 2022 02:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYyKTc4nJJ61bW7fEjWrHDAFF+6/PnjQop1k+sJ27g00HG9v9oS9INNVG3k18ENkSmc/AdA8c8TGHBOAloB4D3mQMkDU/UURPoijunrETP+69Mcz+PJoJiyH1QfH6JCJq4XJWxUTd3C4YwOnpxD6hGEgBmAb5Y5F9dStwQ9l8/4lOZ/31uxno/A6oK1591mFyHPrzS6gz7tFKdU7XdHE0gC8gsDW1R7hyGb7YwSYnDvkJjiJi1yKXxMV+NrIm0WA3+WdxkV5qooxRsKn7OIkl8cEvf9OQcSFv+9It/LR4PReW16oPnCUpAxEa9PWmt9X7pcRxo0Wdu+tydXXEF9wkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZuoNo2QerBFgEnb2S90vfZ490CYmpr5LfUKW/tA7iM=;
 b=E48gdY9AhxDhUTPE3pRAoBXoEBTMdHnqXVK4b4TlhvUKggHu7uRbw5/ylnLhvXS9mayB3vIvki3Cd5Jcz8OK5kxniBmSqLUa5vse4YKEinnFw9K4CT6NN40wiusMrYKbo+YVZkVax42NEvx67ymKQaSIm9rBlNb2PFziN1dgRTbiOb+DSo6tBkYsdfN/XjVfi/dy1lURI+Gd/REWna/ysDzQnI1oBscP1jSaO7DQd1hFy9S2lB8h/xGKGS64seA5+FLe8kRkKYPple2AHhdn1oq/EiJ86V53oD9Ew1CIekC3zVQ2XW3Icb9wU9gBSXlpl5IKJ2ZjVRFGU/QlgaHLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZuoNo2QerBFgEnb2S90vfZ490CYmpr5LfUKW/tA7iM=;
 b=Ue8gwzTF4cWCzu16d31eTM8JU4aYppCTAlI4TqDnYrL5hPquWIQpMUsunJYeoDJdMoQRXf2gg5NA4XATURh0/6i0JeEw83piFvQxnB3ptkg+m8QE/HWtQ5Hj8pN7rZTPh9EGY+wVLY6uIg8MZwUV5b1SCpDtzKoCNVC6xNEO4Po=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5671.eurprd04.prod.outlook.com (2603:10a6:20b:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 09:58:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 09:58:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/6] arm64: dts: imx8ulp: several updates
Date:   Wed, 31 Aug 2022 18:00:10 +0800
Message-Id: <20220831100016.3649852-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a528919d-aeba-4b8a-ca97-08da8b3764ee
X-MS-TrafficTypeDiagnostic: AM6PR04MB5671:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05dbCufOt7MXBy0DCthb10QSmpkUlN7qdh+zoKw9Ea8ZmheKJ4HuZ8vSe4UaLKisuY4/IZasPWmm7OOwtMN4qWa+mGi0mRn5EZIslkJG8qjG6zU9sehCubyRTn0hhObiKKfc3iCLIt0J5HCsTo42BoGm7sKvH5X2JJE9SSUTt/uZUwHB7nNspkSiFopgDC/3xOow1MWhaYqQ4Xq+DasruO9+Z29WFN02zwT1/f0mlUwlnwmPhpDvFcCPjvCswVIu5p+4hU42wRz+HBcKSf+ebwSWAbuK3FZSgeXusbzXORSIWF1nO2TAh4yePSEpPcSc/ofVLK3jLV+RMfcV06loNzWgR2V4fTI4Cnjtnex/XRRc/Ex2ryjOrQ9JOOXR1q1HcvGObimdGhZsHw/8jsg60owVRsSW3Hl3+fgVbh+fzBpdfPo1RlZQPU9Z9ToFCQ9TcxRRscrTEh1cVH5SwqDcbyx26STUSNdOwmi+pEop3deBTsLmtcerdjbDRHBjSWxk3WkNgujTNTG9dQM9NlbzV3nAiuhWfkbu55fC/PBUsKaykmQxDzMQJXo1db2hvP6YqedoMm1Dg7MyVYJa9L/Jwhaq7776ahKClU1hOfeJM2nJTe0Mh19iQ6E8I5dECiYJgRuy+NQ4ZPGZjAFwAITtfdUWlFuwrUaVO+zSbUaJBLN14/ttEzJycUpweKSCPhw3EGUlw6QAfWXjHv+0cKnH6UgKUCjIyYK9D/UABnv3yI6vATdWITKjTY/mxPZtY5BSMpQ8YgcLqIBOyA4hH+Fst+Z1vZqz0PuovDc/oSOptgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(4326008)(66476007)(8936002)(5660300002)(66556008)(2906002)(66946007)(15650500001)(8676002)(2616005)(1076003)(316002)(4744005)(6486002)(41300700001)(6666004)(6506007)(52116002)(86362001)(6512007)(26005)(186003)(478600001)(38350700002)(83380400001)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qveqBqXB3XOvOfe0JJJhtigFtbTeo973gE7N4GsYfKI+ohUlJBKFjC4Dkl8a?=
 =?us-ascii?Q?xdiw6mj1Yalq1GIluJ+jixbPtg8v1BayYSQOZJ8QQ0hyusaZ8pneO70IraGt?=
 =?us-ascii?Q?csrOsgdzRQo2RyvBngGPxjkqNhU4BCgAdAbRxL02I5NBqHRddkDHwsGBQre5?=
 =?us-ascii?Q?wCSrffqPizcp6HyXl7xnad0HCssyRnh684AZN52QrKXNXn8nGWOlRo6XQtNm?=
 =?us-ascii?Q?H0zIDyhbNSfKAnKNmYI5Xz60wep90Ym0HGhIad7ZVoEs3uvw2xKqS9pc6xsc?=
 =?us-ascii?Q?7wZ9Cqm9XSISAjlklG21PyVgkR7j33zEnQzaq52bVHl/zY8WIWADADC0tNvT?=
 =?us-ascii?Q?BL1vDFswNrvmxi4VxOd7JqFXW1K/nIcmS5aqhzdUPVjV5kGkqDHb7Kf+d/jN?=
 =?us-ascii?Q?rR+0Fp09gc5nRirZXCkZCHUZfQPc4hGxFy4zEyzoVRB6+ztBICj7XpYUiyJ4?=
 =?us-ascii?Q?YfgBAsnslrc//+T/i1pIXyGjH1K8LIDd/dOJmeWSsSGkMC9jBeNpZYxfMi3l?=
 =?us-ascii?Q?sDsDREdGifZc+YbcGUiw0BvyypKCnKZAQb722HzcbBZ5LiA8tR6blmBWbKY+?=
 =?us-ascii?Q?qXSPFPcH9B7HtKEDzh/flhBqfxzNI8OTxrvAhX9W+ogsekPu+myfVt/6fbkF?=
 =?us-ascii?Q?s2GHO4jsIH5J1ePZWIhspXMRmLCTlrrqwvXBBMLqKFwGxazKBGo1CpvdrC4a?=
 =?us-ascii?Q?8aPfSA9Jk6dUamUCYdNGyl70MhXCXdm+uB2WNMWwYlLl8owneAzdIWRb8ZyR?=
 =?us-ascii?Q?WSGMR/sgnI/eXwl5n/P/4/W037CT01/WM+OOyDzwp7+e96GHJMqPXWhUUC4e?=
 =?us-ascii?Q?bg5nxH1HkNpa6RVktXrK54D/6aundA+NgTNxqCWc+5zEb8BuO2Dl7FC7dCjZ?=
 =?us-ascii?Q?DjpT0IuqxILyGDurPYc+ONC4ExMNbjp8hZzXfEwG89TM45R0JCVLBv19g2w7?=
 =?us-ascii?Q?8bKyAVcZafcBMxJJEhH5tBKpv+qXhAdl9ZlQJEIYX5BjitFI7q0XFjEqD+t1?=
 =?us-ascii?Q?tKVZ4Utc3P7zMf9huVFmpYDfIn2+ttX9ScuTDtgc1Yqx2TYC7ZPL0iQ3uSVa?=
 =?us-ascii?Q?1cayyq9V+vGTcrHxjrUGqadw7NHG3Ub1Xr9qg6o9nREupCRR5dQpVPhw39LX?=
 =?us-ascii?Q?da7IuT0AzjuOhhALvLj0CfoFLk4i2sU3LqMZ39f/4o+ZcZt6YY7Cv1UmGLep?=
 =?us-ascii?Q?c4Ao5uNA/ZUHFIyWgv2M9JZqytc7kTXBE2PZrHDMT8JJdOKULT2THPg0RB7G?=
 =?us-ascii?Q?MtWAHOQmA4Ql9WL9eIl6XPJKUUnodXssSzjkaHtFqW1LgYChrQvo2S21rNJW?=
 =?us-ascii?Q?aSBXIAjVh/MyBVldiODhWp8A8/GczzFoGvlt5T4cSNwWdTGIjod86DLSRdwP?=
 =?us-ascii?Q?10l7YhtVmrNg3RP8ZDNJiUdVi6K4Or4SRC7WANlEq0JUtX1DeKBhBMD0lqq7?=
 =?us-ascii?Q?N036kPW1fz38p1VL8C495ONysWBCXszfXn7DUs8GK1kOjr+zi+iAh0oWnvD0?=
 =?us-ascii?Q?MfJ59PS0gm3i42zCj/THrNPpNvgAuoD7quLH18AT/cF+W/swhrZbjvbCjMff?=
 =?us-ascii?Q?ehjTcNckBhDRb6GrN8gq+VcRZCIwBhdldvwjWb23?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a528919d-aeba-4b8a-ca97-08da8b3764ee
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 09:58:46.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZaTUq6To7AZMRYvRym5UnIAaOunhwbrfKmp9M+pYQLUFQzxKIaly09NIwI+YBo5s0XZodPkuYnk17dro0GhdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5671
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update cgc/sram/pcc node to match binding doc
Add pmu/mailbox node
Increase lpspi clock

Clark Wang (1):
  arm64: dts: imx8ulp: increase the clock speed of LPSPI

Peng Fan (5):
  arm64: dts: imx8ulp: drop undocumented property in cgc
  arm64: dts: imx8ulp: correct the scmi sram node name
  arm64: dts: imx8ulp: add #reset-cells for pcc
  arm64: dts: imx8ulp: add pmu node
  arm64: dts: imx8ulp: add mailbox node

 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 59 +++++++++++++++++-----
 1 file changed, 46 insertions(+), 13 deletions(-)

-- 
2.37.1

