Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12F358ED4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiHJNb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiHJNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:31:19 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDBE28734;
        Wed, 10 Aug 2022 06:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=La4YIqECGOQYxIqRZV5OGBC39pdJ6MHwsW9cSVEqg5vrxx37odsHLf6NKX1r0/+w6y1syG/J87wmL1TQqQWCJPyUM17qAabTlO2empBWYIZV0XtQDNUy6G7ZmOWIDenBmO9cs2nt14sDaa3oz6vTMMmQUZ5s7hdH2fy1Tni4SHucXnt0SvokNVtPfpjAl6OOEYdeXkyoYm/YeDAvaSgmruvXQQryVeWzdDTfzPpZgfm1a+CJ3lVRbJHhHkWma81XfwQrAXZcCQxBQ6OpCCpTVcY23jmJ8y3ZFzVAavEycts4t4+UGVVzykeyKTwD0QSWP1Mc3PWXdI89KZdxINl3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPoNUUAWJwTQLHmukrcMAojyPelPwaeHF8g7mbBRW8Q=;
 b=mXq5eCbEiJ2UlH1gcI9d5e719kmVyuHkEceY4gGf2rZ7zmw2LLcgP9dTZ+PhmJZ9SYrmqZfRiJtOs762VkkwK1I8DK0/Wa+svMLTuXRK9DHCHq304PvrkjFJQ0RvcW1zL/om5gBX0qb771nCWUDFmKC23EW5J9loyMsVXyNja60kECmUifPh1xh+g4HZ2UOG+O6vkEGxMIIrVqcvctQ5IssuR3imlAS2FKbvsN72xLtoDzVT8Y4GHZEG2sshID5+9BeJOh6fv8L5P7S3U8q5YyCD5BlY/2taiKcuZnP6PicGqiCUDNU2CK4R1tjW4FzPFe875eFuaxmoJ0QDntm1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPoNUUAWJwTQLHmukrcMAojyPelPwaeHF8g7mbBRW8Q=;
 b=Vv4fZ8YuIeQ7i6UHZgJ28F2rTCVdAAC1FToTvi1OS9IDuUH3D5aslrizDMEcyOv+rzVtGZofh1jo45qVleyOYDcGEXSHGfLInkr3CRdM+v2V6MjbFJSDRMb2pstn3b+QKY5wKlgVgiTv3cdBqdLCZg/Ec2R/sygWeuI+RHsPARQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 10 Aug
 2022 13:31:16 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 13:31:16 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v3 0/3] Add IMX8 SCU GPIO support
Date:   Wed, 10 Aug 2022 08:30:02 -0500
Message-Id: <20220810133005.74653-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::30) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 483b6735-8893-4eeb-383a-08da7ad499dd
X-MS-TrafficTypeDiagnostic: AM6PR04MB6630:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ko4JPPFuvszkFdI7nDPa5jZT1S3JNmA+07EP6D9sPAFc4bD6ZITzu9MuU+Zp/kYRmMFfKX7vf8WMpgBD86iYP3fciDjjM2RqqeZDIBCrrLriDUBtxaqBdzmWmerIVsoEKR/xYD+5SNESzJujW0Vwqzt9QXykdSpgPI3sDKWbvNteGqQf4fjU6aTpzUWRnglSFY2q/YOa503e581q7TJmTl1FpwHV3WUcR/9hkblD5ak3Ceuro2L3akCP8r/P/YNUpaJDV4AUaEBLWMM/K5V26THwRyDgH1ObfxtLg2mEr2IlX/9ur5BBg8Ah0Qmj9MxIs2e/PenJbGFtseXwJOt4HMSgs5Bl34s5TsQVzm4kvyZw5ljy4gZ15pycreq5ITp0nPLvbdq/qe4Cv6z/G+856XI1QKHr3dIzaHQ1Q+xcT7PxDeGAQ+1b5maAEjG8ZwQgJ0/3zlFCjDezbpimTFsyakVyDE2/EmlfOep833CLB36WI2PONCLgbgEqUS6kMlgSSUUS+phyLdIzkWZ2fK9fPRVPUUo8ftC1hScOmR3lpb6C4x5mym6A3GjptLJNIWyVokNB5hmaO7lleHIbVB2NI5ZjKqB5VKcKzuN+5b13m2psoknWurfd1Mmktyk51Out66msPXfEfH2Tec2RWBW4ja3shYlRa+jpBMsjjXvAjoc/cVdNeGVdfIbQl/62SEXjGdS6WYlXR1c9DCUhdBTtT//3BT+ByQ9tZGaan2IDVB6AjYTnallW4WColsDkY8P4ZWJ6S025602xHY6GXRXAJKc5g822ZSnRS8bxpKr6o9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(478600001)(2906002)(186003)(55236004)(36756003)(8936002)(44832011)(6666004)(52116002)(1076003)(6486002)(2616005)(316002)(66476007)(66946007)(6506007)(5660300002)(83380400001)(26005)(38100700002)(6512007)(6636002)(8676002)(66556008)(4326008)(7416002)(38350700002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vFRuYjXSIiOvr97wZEpge8iFxwCtSsraV0bT345GrSCMF8S4slTDcv1yObFy?=
 =?us-ascii?Q?+5HS9yIuGiZULCqqMr5BnzJKY6578BDp0PC7I5pWhXUTgV12JXZhEedOdOCm?=
 =?us-ascii?Q?2PFB1ZLpNdZl7jE5rl4+t4RdREaebnSv7fW4pzE5kB3ZPMRKZp3RMxx2dTnA?=
 =?us-ascii?Q?slRZLBtxDPpVF+lcUkEaZisX84/5sW96EviWE+G4oac0gnPpkS31GiIc/oUa?=
 =?us-ascii?Q?u/Bio0En2NQsjanu00R4zBhkeBb1veqWZqoDoQ/sKWW538DGi0Sigj+q/kqT?=
 =?us-ascii?Q?VxTXEzsGm5tS6utSDoUOyvljj5OjHPR7vVwAsYQGXj73IveyDy6yZmn4Kej/?=
 =?us-ascii?Q?D41U63Sk7Ey5GHE8L1KiOqz16yebd/xx+7Sp0OiYTYPlUBn4ofXCixHfbHZV?=
 =?us-ascii?Q?WDwWrR/B7uo/8CzgLFwX/ymhLrQ0QrI0duQxHpcCvElNlTnjiHzqbNJM53sG?=
 =?us-ascii?Q?C8mAEJdjguAp//4GsttbMKGcTcikui1aYPm2PM2S7W2sUMuBQrs5UNIIWE7n?=
 =?us-ascii?Q?uHybpCV3G49g3F+djZRklFC3KWIrSpddV1N3bnVRSf5h2C3Q+n3Vz1W8DkMQ?=
 =?us-ascii?Q?739hhcm+i7xlkwxNvWDyHuAPdjW50gW8f9ZtAfaP5cDw8HNgobyNPXXUpRXW?=
 =?us-ascii?Q?21QF5lPQVVoQO1Wef/afq4n2BVRpuxdhqGkeechAtgx+2/b4qHSAww0gnzFg?=
 =?us-ascii?Q?Wo//WsZF/w8hAT0kIyXjzDW2Z4hSCM6ZdGP8KF4O+PZ+0/38xCD1SJpFyBEz?=
 =?us-ascii?Q?Z2QGqnWWOh1NpSfEBSw1VtnzeckI/wbjJq23rbx/tySRW4BzLQhaGY9UGa0i?=
 =?us-ascii?Q?iUWxurm7dn72V4btay6t8ABGQsTrT5WP4gCkO5DRL/MDz6NpiV8xjizl2mlP?=
 =?us-ascii?Q?jzXM+hxy8exMMNUplutEe1lS3Y95OYeCGSW01PVUS1xI+UxPrGjk9mGEWRYr?=
 =?us-ascii?Q?xU4wgK36rfuQIDtw3TUqRiXQ++I3x6JV8HRgQhjOJ3+xBrbYvjRNiapNRcEZ?=
 =?us-ascii?Q?C9JIAJGlhtE4ci/F14wnP3/3Ro7d+CTaGdCUWIaZyhuWABpyVOCI8RhOzsyR?=
 =?us-ascii?Q?jSv76+9Np8ftqY+Wzylfh9YtLp+/g5wGHeEqfj+4Ok/bQNz1X2/nXb4F0JqG?=
 =?us-ascii?Q?2uBux8+ZqvYs3tW7prK0cJeLJmw6FLep5qS0oZsGcDwDBtJD6rAgstIXDmld?=
 =?us-ascii?Q?0hx/wKJMizZVP85LV8efOusMP1m7zU4y+UexpFdh6yb1vNp2Rvp8kjTBqsG4?=
 =?us-ascii?Q?GKu7j+Awa82d6WwmUYgtpKlFieEe6RrTTAUqaAQ4WLAtK8+ZsDYpuq1lOC4B?=
 =?us-ascii?Q?aK/Pf/1JX4s1tx+lD9shXH5kdtrnMil6Dm8KNyvoAGwW3O4SReXYgnbimGXD?=
 =?us-ascii?Q?VEfegi86i3e++C/VhduRcXR5KdPCdPpq/Q2lW5i1xF9ELMX/Et+JwYvO68RU?=
 =?us-ascii?Q?LU1cxH75BlvjJkWa7RgqUbP96P0ttvTcPj/ItP810tjvwiv7z/HSwIaT0IVu?=
 =?us-ascii?Q?M6E+f9jD9m8GbdVfXmxLRLALNwxRyR9g002V8lX/AE3KXve7FHRlkKwGMkTk?=
 =?us-ascii?Q?UB8msDyOXLzxqjFKQO9uLu/rXIyVsWV9DWVcVPQD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483b6735-8893-4eeb-383a-08da7ad499dd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 13:31:16.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnVD2kzZnvHfiVpz3nLYVkdnGXpggTpDc7NMzJ5JJFwSkkD0yUSBUS6ikYELuSzrjgkgBixLkQQxrCXSfKO35Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6630
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system controller (SCU) is the central unit to manage the resources
on i.MX8 platforms. The SCU firmware provides a set of APIs to access
the GPIO PINs on the SCU domain.

This patch series implements the standard GPIO driver over the SCU
firmware APIs, so that the GPIOs on the SCU domain could be accessed
like a local GPIO PINs.

Changes in V3:
 - follow the other imx8 SCU binding rule and rename the compatible string
   from fsl,imx8-scu-gpio to fsl,imx8qxp-sc-gpio
 - rename the doc file from fsl,imx8-scu-gpio.yaml to fsl,imx-sc-gpio.yaml

Changes in V2:
 - move the driver into the gpio directory per Krzysztof's feedback
 - change the subnode description in file fsl,scu.yaml
 - fix the dt_binding_check error

Shenwei Wang (3):
  dt-bindings: gpio: Add imx scu gpio driver bindings
  dt-bindings: firmware: imx: Add imx-scu gpio node
  firmware: imx: add imx-scu GPIO driver

 .../devicetree/bindings/firmware/fsl,scu.yaml |   5 +
 .../bindings/gpio/fsl,imx-sc-gpio.yaml        |  40 +++++
 drivers/gpio/Kconfig                          |   4 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-imx-scu.c                   | 140 ++++++++++++++++++
 5 files changed, 190 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml
 create mode 100644 drivers/gpio/gpio-imx-scu.c

--
2.25.1

