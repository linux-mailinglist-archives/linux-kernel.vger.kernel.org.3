Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCDA4C3B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiBYBlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiBYBlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:41:17 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA95428B622;
        Thu, 24 Feb 2022 17:40:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFad8IYRCqSZ+Fxc6r777Px4y1XUHj9/96Tg+ieEQLPdOUs5ACYsZF4MkbXljYgiKHeviN0g6IrUHu9zbo2PHWobg3uT0wIlIaLVQ6kcRzTdtLaPMx+QQRcMtG+QXGJ9c1WGpQgbB6cLFUe2Lch9/UoHf1jEN5Ht2EaeJBIRpnctn42sHyZ8ubVmyZEz51pgO4Zzu46c8nnelk0d08raHZuFoG7qQbkm/SDwdygUx/CH4HMyKEhZYaWTQq5myUMlKSJsjHMn6cabC6bkPFkI1+WJ2QN2myiLnBtxl25N9eFg/1KTYIpYAYm8Ipp4r6MWmMm0LdvgI7ndRwBiwQwjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8EVcDlynaAMdGQ4+LW5vv3ckuXhzObIw3hzPPUp4jA=;
 b=kR29/JlqsxavbbCv8EBRAXRRHsd7txZURFPIzkdbRQ+2AcXnXgRJ3Idm/V4pdNf7zDnRaCBDXRaWraFKiFNuhcQpXPHf5JiQ7gE0SBuCQZ1CLuqhu5JbKJzZpMJMNinYQgocPm+df0SP6JnrI8lyt8qyqaVs6qBIKghjX8Vocsef1NhSlmxW8mZ4m+O1Fera8EGNZRd6c9dVWYTfNZ1rqlZ6VEjw8mPI2KIlFz3SBVX7LnQMQeqJyvFd40M0LHz3BwsC6cMi2Pk+xrnvsbCVGVYDQusk6mgtouy1Sw6pZCzNzP9iywQ/h8ulZTiWg8+M2Hs2oFPKNHjs/Ne8QwzVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8EVcDlynaAMdGQ4+LW5vv3ckuXhzObIw3hzPPUp4jA=;
 b=ALxD5jmPa3gjbrMFpNKTG3F6Zha68RGFY3Rcn2F1ggEpIxiK3uHeLthYaa0cICsPh4IYClgaTXImkTeR50NaUcuZhzUyu4ZVSlJ9pyRdqvP/2vLQli4qWmKY7HuEqepQbcCc8kwLur/Vj24bXDEhrfORyHuGmLKwcH6/srFLDl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5316.eurprd04.prod.outlook.com (2603:10a6:208:d0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 01:40:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 01:40:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 0/5] imx: add i.MX93 clk bindings and driver
Date:   Fri, 25 Feb 2022 09:42:29 +0800
Message-Id: <20220225014234.1766305-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aebedd9-14cd-4c93-22af-08d9f7ffd615
X-MS-TrafficTypeDiagnostic: AM0PR04MB5316:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5316FE57E585291593E8B5CCC93E9@AM0PR04MB5316.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJseakT6es/JKLDTqWV2+PGR8nc2n26TROEwCIFkyF7BoHy6ghYujAuG99XB3+QZp5WfLNYoZlbmV1bHp+7qRNOphRkrwTnj/6bHAMnqcPrX2dfhqPYtBJnOUPDV8bYbs9hxZq4jzQqNplEPkG/Uq5sLC5DkcDZPPD9Unz1fPFi7T1ksfsi36LUBpAmRTS0f/kwqTfuINGq+1R4cXvig7yO2RCVOX3BapDTmVz7EI+UgpEm4GPUzXUPPv5d4c9nQreTZDa7CK2mXEnIEM54oTtTwKHGAkKzG5qeOK0ioK038LV5s8ZngYkGd5iOj+k575ZnBllCKfMkiXWctuLKBWks2JKN2AQzmjabQy6xb8v6n3ihAi2g8aCXP+sXeL6+uwCcu0umNy6tL2OfiUIafMRNA1rLEWCmsNbkzbT125XmKJzfx8aaRZllgUxo1e5dUxOLj0cGp30UsNyJRJi6FwkZ7SrGUO0E5vAQ61s/Ad+TsNCMQ8L8ZIjZA6MNa6l2xpzd0tZzAc8ZdCJ6leMgPT9GI7BXpcAkJSdvNnxkItsaPncIBnJCHQ0+/v1GMhD9lRCUzndBPvz9307bylT//Buujc+pvSiJHK0RI4U/TVyjEpMBCc/ELLFpDt2YxQQwOdWAbId5DZL/yeX2iYtLXtESXHR3XjW7r0WCzW9LpB9rRD3Mt6n8CYzIuzdoHicNpXKemBThnQAC8Hvnw1ZJzoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(38100700002)(83380400001)(38350700002)(6486002)(316002)(66946007)(5660300002)(7416002)(6512007)(6666004)(8676002)(86362001)(66476007)(66556008)(4326008)(52116002)(2906002)(2616005)(26005)(1076003)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Jm6Q6FqD7cCeRnZxHLvPqGTia1+hhVJXk0m2wbQyk4AMqrhToDIYIxnFfYI?=
 =?us-ascii?Q?DttaQEnWjw7nScyy6Q+TqN59lC6k/HJmbAJzF4gDljshCroC1pixG8HGRfJy?=
 =?us-ascii?Q?F5KRKVyhqBbcOAteSwVOUI705vNPPbAk8ZVYQiBjKMNIwDPUPedso2cYzod8?=
 =?us-ascii?Q?CpxQQMxA/vpUCXB1wveo55vUu9c8JqtduQbxttDydhuCTsEau2aqBnGRGQMs?=
 =?us-ascii?Q?Dvd+1WRWyst/RT/uvTX0cdiQJ6e58HNKQWjjuX1dYa01Lfwk4oNoOoIJE7GG?=
 =?us-ascii?Q?MqgMuwIPD82Wm8lMEojLepoXV6njoc+8T26BwlG/0gjQV9B4Q5dqisLBMhL5?=
 =?us-ascii?Q?Ldre37TOT1Vl7z5yBYMnONe7AYgS/XOcRaXB/jTZCLiFS36mUqsgpH9sduwb?=
 =?us-ascii?Q?EZ0GKaL8M3Q4VoWvX5Iz0xQz8TnVlJ3Y3Tt0b4qcdb0PnEsBYIQyprvkI+Lv?=
 =?us-ascii?Q?HYJg9tJqtnQznw1O4NtqEsDH8F5CykaeXkN/tbv0j6h5dG9IvUEMVGRc8YbS?=
 =?us-ascii?Q?FBsjBWTX6ubWsxmUcfUrbbIRegZ91wReEZn2+Dw3x9sW1OWSSGA9AKSiJFRV?=
 =?us-ascii?Q?Kq/Jgn3J8qMKsMnPT4mSuziVFnviM2dfinfl/ULkxBHxNTUQa2TsnMuoWyH/?=
 =?us-ascii?Q?hYBptr9ntUt4SYwTuTCuITOkuaRWU6TSAZiofUjWbngc2dmkonicwQBhPsSm?=
 =?us-ascii?Q?ma6QMN/wx7TmJOnTK/MsD8YiyUGn7fx54Yq4Cargo7gMpFeP06DVLKl+3Mh9?=
 =?us-ascii?Q?dlwN4Fs6Xkwlw0052xFfGoYMcVhM1eS4STNvHJe7HC2NccR9wLA2aqbxPdgs?=
 =?us-ascii?Q?fEIDPFLbR8KZGblnCJdnIV0rOaJb4jFeAHUMM8Lhc9POlEUl7qL3e0S8ihDJ?=
 =?us-ascii?Q?bmzG1cJ7wo+suFYzudqMM+IS42o+v9J43BgQ6xxj6K3AdbXWcBcYIazC6Tx6?=
 =?us-ascii?Q?O03BW2hsF6WLp/4lZp0Oo5MkX4XhLl/ttGebzIUP32sD/7j23D8Fo4w1pR61?=
 =?us-ascii?Q?4ZNVWOAQA9DnIcvoOyehJQ8gT+Qd8YVDO8GsfjFlrfm+3yqZ3fvuz9kxLb7M?=
 =?us-ascii?Q?VdlYKgMVmw5JYXzkhkheDLrnavRt6QiUKd6oCOY1o+9gIh01Sj+yft9rmOiq?=
 =?us-ascii?Q?kzoDHr7m5kSIKMiBDzSxe7ncayrLeZxnN3suf4r4YuZS/gpi2t6i9tDy5wz2?=
 =?us-ascii?Q?OL4xeCMbEMt7YIL08V/mNVboiQzjDISCdtGr8VpYax95QkSj9VdVG+ELSGhs?=
 =?us-ascii?Q?e9n0DQ8pUNSnXZG3M0pj/XSAeNwIj3NZBXnqrUTCkYOs45P4falEAM+r1/S/?=
 =?us-ascii?Q?XjDFDFF3cHsPFyZCPshFVu6/Y0c09GDmnGhzGurHlByjlz4FNHeG3Xp3GeB0?=
 =?us-ascii?Q?vFZijtG5Li3TKjZRLlUpluA3kCpZewv+RZiuGxIMb93O9QqeXSzzJjK/+PwL?=
 =?us-ascii?Q?gFaSdtoVkPq1Y1PqdjHjDGL4B4U+iZdsUyFyUaacPe2IV2uhSLMUVTCxU3AK?=
 =?us-ascii?Q?/IGWMzhA8kbgsMwMnuZedNe+iAXbN0Sm28ubCNChrWE4dVoN9JiXOVPL6djW?=
 =?us-ascii?Q?FS7/bZL7kzVQ52niDOx4R0oVu8em93twpxoJ+cDpNMnwPSchg6CDHZzQy4by?=
 =?us-ascii?Q?ykXtPHmi9ZbzcoLVDYdlgrM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aebedd9-14cd-4c93-22af-08d9f7ffd615
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 01:40:43.3972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5zGmOqlxMx9OJgH6rg9LnwvVdVIpwUbPr88se0Wql+p4QWFENl+Xhj9H8lnbUsGEJBGhB7QBjyx8jSDcEm7Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5316
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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
 drivers/clk/imx/clk-fracn-gppll.c             | 324 +++++++++++++++++
 drivers/clk/imx/clk-imx93.c                   | 338 ++++++++++++++++++
 drivers/clk/imx/clk.h                         |  30 ++
 include/dt-bindings/clock/imx93-clock.h       | 201 +++++++++++
 8 files changed, 1058 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
 create mode 100644 drivers/clk/imx/clk-composite-93.c
 create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
 create mode 100644 drivers/clk/imx/clk-imx93.c
 create mode 100644 include/dt-bindings/clock/imx93-clock.h

-- 
2.25.1

