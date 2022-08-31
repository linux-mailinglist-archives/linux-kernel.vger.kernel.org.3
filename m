Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359AB5A7FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiHaOM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiHaOMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:12:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8165D7CCA;
        Wed, 31 Aug 2022 07:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxzPNcXfBQTfZXUNsydZHTo5UQCZginOjhIEqyKPFtFvvJ7XqRF53NpKMlG9el17strLE9Kuo9I7TfUrM7fTCfRTGju8PJJcGamC4cQwWHFDlHdCTvRgYxOwlSD4LPlFyQn7Bd5PBrNz+L1hdLuTNYDJYmC4mf70i4EDIZw7eiAsWQWK3cHKEPSKfg/QCiLNOmAMmTscJklfnlH58Z8i0ZAqFDN6PRS8Sp5cyhvvLW8fc7cHRfYsKh8Hp6kI6Y5auT3+SIvhZ1gofIRQQOwL6nZo/RntAOoKEBieF10hPIYRufDnCQ2W60utbOB9++Aw7RguCTg5qeyPrIa/9lkemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ps/RRas3htm+eeCAwSZtEu6tYoWx+l1EXPI+oa22fB8=;
 b=ICSvuSjyzq644/ugbO6np+ctSGzoZ/R1P4IjNoV0zITne1574nkrI6rsbaSKTcOVKwXag/pjGSZyt00p26X9Gn8oCQV/bqwaMTKosDhcx90mdcaP5VL7gVqGHN3fBULoVn/CW3Wt/XQFin7dY9IdTFHJFqoi6A9aa3cmh2I/NAyuMH0LqSUov0wubJs6H471EWpGX05XxVcDWPzqlLMYuFLi6cUfzOWyipm0aqYEXMdHzrH4YcOMg6PtA9TDYM9bWwrfsAlhx2mJehOH/oKfVSToun01tbUwV6vehvKQFt6pPrevBD7z5uSUX/sO+3Ps22cxsgD7BeuQpUlZfM4/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps/RRas3htm+eeCAwSZtEu6tYoWx+l1EXPI+oa22fB8=;
 b=ivUv8gsix86p7pX1oIabIZjablrXh7pHBvGE5thESYAVAiYGAJX7gbI63g4Jov3cg2t+qkb+oZAD8gROgpPCqAynSYvyRuEJZvnUD4I0Gv6bQGFEgqFt1w6k3ZqPqGzn5Cw5H+f9Q0PKftSBhU0NxxMuPF4tEMu3Mrpnz7gI/MQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:12:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:12:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/8] arm64: dts: imx93: add several nodes
Date:   Wed, 31 Aug 2022 22:14:10 +0800
Message-Id: <20220831141418.38532-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14900046-bcd5-4067-bca8-08da8b5add99
X-MS-TrafficTypeDiagnostic: PR3PR04MB7355:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/sLHzworC/3c+T+uXEh9X4GXrgo3+Bew41JmxkkEFRHF9yeY7Nj3hzB9B12+kRzEG5cqtJIujYm7dKajBeCxqbMTckNKcOFTr7HYxQwfW9Veyf3UQPzLTZpqNlpphNdJGa/7vTqmnnp34l7JjujXOWaI4Tp7du1s2OsQOBrJ0kYc8H6ofaGa1C6x/zZiMtS0JOecOXW9/aOYuiCyCK8A5hbFSsPMWmKLusZ4mThuqKtOf79Dtb+FS5fNeOT/dK6hWQ9cr4DKx+AIcEo6SZOJe9Zx7Hfsw3mX8VRp00mLe2xXpxPwFi0sy7g5BakOOoqlcxRyFXFD4Lq7GACaxhPiS+tuQT3MBlxVgvstHyo1fL6yNTns6HOQao0Z7/ogrHTnwCJpZTp9izsk1BiKy2BdYmSO0d/nB7ljIgJDiXgLTKpN92IefU3kBsrmPx05koVDiFYWwKBLPRzOkzU/vmGLCBSgItBrfA3JdHmdk8cqhZUVXrlfiamjGQt/jYIh9+p1Yd5uWVZ16k8kcMIB55kF6dAhSlOSZFKaK36huO3SSkoRXwK0sXrmCuqnOeD1+YZvSrV29OmFGdPMQJtKrxUOkrvAHLBz0Gr5WIBuu3YHQsirm40pC7D4i2SgsqJa72QMbDl/W1PNYvbGmFjRS8tPXRTxxScB4yrbGe0D+tcGRdwcdsf4Z3Fr1xyCKjuqmjNActuMX1TcLn3G55Pjih4qT3PvFrA7JRkSzZRscEQqMdmD/wQusUZQPMrF4IAE2Uq0/z9XT8gVEB5aNh/hH8RhGGb1g7jcXmIgyK5jHQdJqxT5hEdW3Dre8WtDO85mn74mAvVkGW/rv4b+8FPFxD9cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(8676002)(4326008)(66476007)(66556008)(186003)(1076003)(2616005)(5660300002)(6506007)(52116002)(316002)(41300700001)(38100700002)(66946007)(26005)(6512007)(6666004)(86362001)(6486002)(478600001)(2906002)(966005)(38350700002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XXbNnvJSg0LR0fKNopMeMdcTVrqxi0Ulos5pdZ8JZgWze3R5Lg539Ow6o3wD?=
 =?us-ascii?Q?khFciZj1z4ct5gto4GWZXbmc2jAiYoYKW8TdVTpYttfxp3SE1HrDBU9aWKx4?=
 =?us-ascii?Q?IIxZuRD8CBbpkaj7T5KbemtoaMMHrE0/l4JW2z/XidK6S6JDkbJOjOaGK+P7?=
 =?us-ascii?Q?nqrF28hpWfXYZKp6Uj0XnH3lJjkBV/yvN7GkXUnY4NNMwv7uiN+G4C5e+KUU?=
 =?us-ascii?Q?tDmfcZAEtprZG84fgYS/LgSEb3TUsa0omohAoBN8MP2/Gh4EnP791GXqXS2l?=
 =?us-ascii?Q?pqUrbvU5+xoKZeNhOHTbuOYeInt/CSbulPf5kWkvJ3M3JNWZw37KsgStw0of?=
 =?us-ascii?Q?0nIi3scIlJRZlagmBqe2zr9t8JJMevjdu6pKB7rjz6Ruk5dSOBXe4756jlpj?=
 =?us-ascii?Q?MtWJF+fkkat5fhecdFNgfiJY7HjsTHjyOLM6ZLQc4XuD+AIWZnhxT31hax+1?=
 =?us-ascii?Q?xtyIsd2O6yNQ7kXxWw8Zm3TWs4RfCRKraeN/H6ZdAJG5E4EeL6SArnNMHuzP?=
 =?us-ascii?Q?hBILpOleYFhNh3ORYvUzK71c8kF6PGeVBcnJLiLKKLia8hyLrVmWwlxuZVVQ?=
 =?us-ascii?Q?ArtTaHKOaaF7jDRoKXwvbuovRfvgXkeTuGNQ76uPQHgNSRbNqkoZTpbCVaw5?=
 =?us-ascii?Q?FArcl1AGMKno0qA61yoyxtlAqLMhM+nNlDOUHnpwpzvYXqw+TH0W6J+dkaOg?=
 =?us-ascii?Q?ksEyMKCCKPreSE26MyhIkKsYUZhKDDrRbUQXOWMd5zfJ+ICArSGr2xDeT2ze?=
 =?us-ascii?Q?pxwtQJvJ8SzKWGrOX5LnwqWfLx9hO98oHb/pqnitXbJEQ6AQoYTIjNKwIeJN?=
 =?us-ascii?Q?+G53BZv4DHzJFwaMMsmFDIqOHCxIleiZhFkbiAb2w6tU5uTU1GDG5FBceegU?=
 =?us-ascii?Q?rdIvcq8kIxtt/JFMeyBKxiy9M0Kmcx2FL3n6re81zTRohuyGbMqk3QmZDblb?=
 =?us-ascii?Q?eTpxtXCcJypTWmUR6PvRQfzINwvTtbWj4v1Jg3rxBa2feNnGUVlwWwzAkzhJ?=
 =?us-ascii?Q?oBmPolbX/GZRyP2RcVdKW0usbbjguOVcFnV6aw3S+XNUMX0reIb3lypD7jNs?=
 =?us-ascii?Q?6VdlxQRLkjJlpC+mkc9kNJ1sT73vno7qiJwS3xU+I0ESz7EGwAuwtoKcX13d?=
 =?us-ascii?Q?UClNOWDUznJCg9/sODEXjDXzzeGBeFEA/pXMNniVOrBGVk3fsNzQ2YkINhNI?=
 =?us-ascii?Q?Qr6zqpNKigduDPY88Cbmmmgh3gwX5z8ueuYqOvZdQ7UmtPP99ZcT2dQkVha5?=
 =?us-ascii?Q?sIiDHOnVLXIqP70rUpxI2n0nn+MfLAKg6Dhf9paLcDkEidX5rDQXCme1Bg7v?=
 =?us-ascii?Q?xbtglse9brAo0EXTrjk/PjetDs9CEX34ehsNxLB+h5/t8NXMQE44dykdqhdv?=
 =?us-ascii?Q?UqBlIDPHujq3J7g0Cxl8NXL6D0z5eF7CUySGgMpnCvEz8am8GT1ZafFE3iU7?=
 =?us-ascii?Q?nnZcQ87OQI0FsxjKbYsE7c5XAHwcBnNSicCZluCTcI6B3VxdDRWti/o8wann?=
 =?us-ascii?Q?9s3Dm3Zm0Lqc1Vr575yv7WCdjZXpoKC0DDQfUwbSkzX+Ky7DT5E8325azbjA?=
 =?us-ascii?Q?u2cjZXx8qVELKyEqsXBHWM32jgAuZYBQ6YbldPqA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14900046-bcd5-4067-bca8-08da8b5add99
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:12:41.1253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7tf20UVA/Y7O4D6mbv5s/yHAmqzZ5AbCjQ+hbKv9rAcSWJvrgwoSkSfQ6Ewbsd/cZGEi0UY4UzkpQVE+ItuQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Address DT maintainer's comments in patch 1

V2:
 Add binding doc for aonmix/wakeupmix blk ctrl
 Update compatible in patch 5 according to binding doc
 The lpi2c binding doc has been accepted:
   https://lore.kernel.org/all/Yw3hfcQ2JV248GIo@shikoro/

V1:
Add S4MU, BLK CTRL, PMU, LPI2C, LPSPI nodes.
Add GPIO clk entry.
Correct SDHC clk entry
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20220812074609.53131-1-peng.fan@oss.nxp.com/


Peng Fan (8):
  dt-bindings: soc: imx: add binding for i.MX93 syscon
  arm64: dts: imx93: correct SDHC clk entry
  arm64: dts: imx93: add gpio clk
  arm64: dts: imx93: add s4 mu node
  arm64: dts: imx93: add blk ctrl node
  arm64: dts: imx93: add a55 pmu
  arm64: dts: imx93: add lpi2c nodes
  arm64: dts: imx93: add lpspi nodes

 .../bindings/soc/imx/fsl,imx93-syscon.yaml    |  36 ++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 162 +++++++++++++++++-
 2 files changed, 192 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-syscon.yaml

-- 
2.37.1

