Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9F75A503B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiH2Pb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiH2Pbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:31:49 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC27C1B6;
        Mon, 29 Aug 2022 08:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZhwsZ30ehhb5CNTV0FxaYamNRxBTWWRupoKgyxD8nOC7javg9AuvdVZjxbHbJ0VJfRnMAHInW5mwrhY+H5PBeCizOiGeBsSph35/bYgf0Qc6jOlRNzzpcpjmrBq8cPbqRSyQNfOOJYg7p9ijlTpImAMXod7t/nNthyJhjviJfWx2mvl+eTSpxiEr44WLoo85+MytbAHsfdAliPCwcAHS9s1scdflRdzIAYVwcaER9PfTHRWyA2xzdUcUSXfXPa9fHIZqF4ug7dIsdQScVAIbtczho8wxJLMKljX4IR09s5RLmZRXc9wyY8cGFxWRn/xdWS9PbiQ/WlFJJN9MM5k/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHCcbLF7ljyGSz3LvogawONE8Ntjl1UJICGxSYAtZl0=;
 b=jGB121ZlBrgVp/eJ1Par7QU2mwUU2eTxOjC93rCEmZ3VTS4Sf6GOdiuYTxwmTlBW9EjBh+odpX8M0XhkbfDafBhs9bVeB6LnAjk8NSCyrZzyj+GHmgNVex+tLS27sgF53vX/1z7GFo4NpA4SUbZdE86/VM4j1wyLw+fxQyTTnqtIB7ln0L/VVqIfvCzekvQ9ZiTOoDNupRdSkl0oU14XfGlBPfNcrzPWHQpDcFkCDzhBI6/taTS2xu6xObyX0gOsYTxXFKhx4efrmrS/0rUR/J41hb+Iy1PBHSx2LJew8rJtEZemdOFUituzX7nGT+shzLz1d/q5yiZGWJtan/tToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHCcbLF7ljyGSz3LvogawONE8Ntjl1UJICGxSYAtZl0=;
 b=ReUn6F0YRi/L7HDSRSY2HfzsULUDWWxjSmCoeRwCIFSvqRsujgJelO+KRzgFU5tQfYqRWjxxphHYskOXIGuAdTKXfDMwUgfJaOGH5If/TYRqAuGEUtHa6rSMR5NwgVQuk3a/VCW+HU3frxLiagrU/HsnecKPEB3qMDTqhoPbpLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB4313.eurprd04.prod.outlook.com (2603:10a6:5:28::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 15:31:43 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 15:31:43 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, imx@lists.linux.dev
Subject: [PATCH v1 1/2] doc: dt-binding: mxs-usb-phy: fix fsl,tx-cal-45-dn-ohms max and min value
Date:   Mon, 29 Aug 2022 10:31:23 -0500
Message-Id: <20220829153124.2791210-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::35) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e58c14e1-9e6b-47bb-1008-08da89d39378
X-MS-TrafficTypeDiagnostic: DB7PR04MB4313:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMmaeU3mevw9HGvVoVMgK96US2V+koUBkfhdBmkJ/ljJkGvX1i242IEi0h8ac0lYK4ZmgBTNZXtg0srS/+4L+TV7PUzOkk+fBfWQhSrCLed98nj6G/SFZgvJyKq5t/YcChyRsgO3D/+PHKnSqxm4BdwXNtsN/4WaEyY+nBzb0vTBarC2Q6dL0ekXEb9KfrvruyyUXt2ncnJl4abF0FpwMGWnZWrwWb6e0HGXOO1Qxrhc2tYVLSDAzw1LPp/rBQaQsH+JVcBiDw1xNrH0ecU6sqh92bSWrWKMEUMOR5ljm6KJ4jvSTuKE+aTBDOyubJ68xAc1z4t/Ptw6OjUrmAnRaQnw/3GqnlFMgQYNHiAmS3pSPAzJa6PA9gP8nmF3JfLr1mMI5ipEn/IEBUwgW4HOAyl2xU1iLlH6OO6Dq/cBgSK9V4ZyVAOBXEjTGjt+Fss+heTGhC4Gtfmc5auioGFGBmjmhsIN46SRu1ZEo6d3HU6RtEmLnZUicHQwK5zlhq0Ot3TUmE7//N7Flrz7ZD3k2LKUaSn2GfKdWSi1BcBhVi9PfsJRSd0VOnI0hBHWDYLgbHiLgTvxURJIEUGDgimERv7jxFL3FVMa1N8Dl07SbbIGKNEPn0A8x6fhtHIKInT5kPexFhAlESAoGSTmHnRlxvd/P1yoe+Sd15T10Fp7b7FCSogBpinrf1a2LWjkn4xdGtyTfRfF9faFNEOh/AOVaKTzywXKMp/NA1JBGrVfcwdEeBoCwpNbOCnqi4t0qtIqVwrbX7JlkXk6xl+e9H3BkqJD1zytaCNNgaxkNLquyDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(26005)(86362001)(52116002)(6512007)(6666004)(478600001)(6506007)(41300700001)(6486002)(186003)(38350700002)(38100700002)(921005)(83380400001)(1076003)(2906002)(66476007)(66946007)(5660300002)(66556008)(8676002)(8936002)(316002)(36756003)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xEuAgmoLxOb1vw2nGKDCLkuNO+ehhVOmcCUA12tMzcimQps/JFvYCkEQII2O?=
 =?us-ascii?Q?yOXvRpQeiTe+bqF3HzJMOBP+AxRENw1QHI/S+8GJ+2lLk8FxunXinF3X3Aar?=
 =?us-ascii?Q?76jfIko6rUgWGSUglshbAP2oX9Vy8RXdAb46LfYvHtwZ6vm2MKRn5RF1xsQ2?=
 =?us-ascii?Q?rsbQbgyqlUcOktbVo7Et+oSs4TxnrLIyweZfFhD0WMRdhw1PVmqrryhKnN8l?=
 =?us-ascii?Q?5IBH8iaGyzXShoVWeWFaCp3EhfRqncZH8rrsENLVoRpMye7noiK1nkgeVp4P?=
 =?us-ascii?Q?jQGrhtjwCUcSE16fex6YoUWIwT2f4F+kkisEKtiSw4k+0vYFZiGeUpVmkoem?=
 =?us-ascii?Q?Zc01/VVmwkWBYHlIJSOyF/e7vbFAqFPjY3ROYk0FxxNGeWGID3DZEZcyroDZ?=
 =?us-ascii?Q?q8WFoQLxzzEgJW+tbq/EqPfS0rlo+lgUxpma4Wz0sicZYEzGQfuzxnmEgOd1?=
 =?us-ascii?Q?ko9oyTC7d1vPiqvhDJ29G/WcLaVHk9ExcFOURtwsOfd2NqH5OHOQiDH/HfD7?=
 =?us-ascii?Q?km8tSiim4FZG7R4maZgQRgnTKY08bFPH5VdmuclXip+JUPy6VacmSZ2UKM/e?=
 =?us-ascii?Q?0dTlPjk0q6oLuaGbYyZ6vkhtAs4Qw58SX6SjLbo/fNlsqoITqJavh0nrqh4D?=
 =?us-ascii?Q?y5hGUyejC8v0F5YPgSh33rTEldjhR2CJ75J6rL91+CSlpo3VUTKawrglQ5Bs?=
 =?us-ascii?Q?xr3fUQmneJSVaLG4zjnvcEC7FH0AsWMUhCfWaZS+0OErUquLr6uWrpNGu+RD?=
 =?us-ascii?Q?QRpgqvJHUy9RofakUqtFmFFGQ+J286nw+yANkGvZ/3dCLLEC4jCM0aMO0P64?=
 =?us-ascii?Q?zNinkKjiZQNCGSgUuUu9MMoSjth95N40rqxt20vZC4KK7mvF9uYj+Fg2uKHP?=
 =?us-ascii?Q?fm2UeoPRdvN58KgyadlEJSvS4CyGj+6F4Pu+Uqg3YJuZFhF+zAHQjhFwrtP8?=
 =?us-ascii?Q?euuzGn27+v9fU38AYhv4L4KctKbqqsqeiyM/RQJawTatDKOwdo5wwSFfqghr?=
 =?us-ascii?Q?xNLE9EaNX1H3v0cZySf4S2OZkbS++jz2GBU9NOiNL+jJLmzt/tW+cqzRiKI4?=
 =?us-ascii?Q?WNurJ17h4mfzvrkpx20RHiqXC+YUemF1z08NG4HBQ8inoRMn8rvWq1xflnDL?=
 =?us-ascii?Q?LVaCndn0hsmG32qSv+aXQx/jyw2mHgRaxpi1aUQj5AvmlBxnwrCckiUdpi91?=
 =?us-ascii?Q?sQJpAqWvbAz1ShTIO2D+KxM14xePyGX7c2oTcRSr+a5PeHXrGyMOnLPS4yMf?=
 =?us-ascii?Q?61WOHHmxEAU+LX8l37sVUcGqut0OgY7Rw71q++w8fav0Clo8fu1X9LlqKarG?=
 =?us-ascii?Q?uL1BzUfiWumDGLkBvfHvDLiKOztpfEa1ICPFGYQhfcttDJIl+SjN80/fAFOv?=
 =?us-ascii?Q?+MIw+3TpZ2wDn4ge8cdU2n2u38J8prYrWfo5n8ek8vhBoSXhgrWvxQxXzMMh?=
 =?us-ascii?Q?3cgLzi1tys3JxebrUEoSNrmCSte/m6Lx+cDwio9AhWaWrVQdfmwTTdtSe6CG?=
 =?us-ascii?Q?BaVFnMe38LKj/rh6N97TImorZ0ukHTktlk1/s+XgCOZXD0zJ6MbrcpdGHZRo?=
 =?us-ascii?Q?s/dQyjDiSb+inNmCy08w/TIvTsPO49VhK4L/cqa1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58c14e1-9e6b-47bb-1008-08da89d39378
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 15:31:43.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqrUEQhk3UzgTs5o1wVcQMmFDoVpmiwekwzFnyKNLqaGM7Kyru38hTkfdbBY30+CIq1PpDvAsZsAqaltJIFGyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to spec:
	0000 +19.95%
	....
	1111 -21.68%

45 * (1 + 19.95%) = 53.9775
45 * (1 - 21.68%) = 35.244

Chanege fsl,tx-cal-45-dn-ohms and fsl,tx-cal-45-dp-ohms range to [35-54]
from [30-55]

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/phy/mxs-usb-phy.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/mxs-usb-phy.txt b/Documentation/devicetree/bindings/phy/mxs-usb-phy.txt
index c9f5c0caf8a9c..111d446b5f986 100644
--- a/Documentation/devicetree/bindings/phy/mxs-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/mxs-usb-phy.txt
@@ -14,10 +14,10 @@ Required properties:
 - fsl,anatop: phandle for anatop register, it is only for imx6 SoC series
 
 Optional properties:
-- fsl,tx-cal-45-dn-ohms: Integer [30-55]. Resistance (in ohms) of switchable
+- fsl,tx-cal-45-dn-ohms: Integer [35-54]. Resistance (in ohms) of switchable
   high-speed trimming resistor connected in parallel with the 45 ohm resistor
   that terminates the DN output signal. Default: 45
-- fsl,tx-cal-45-dp-ohms: Integer [30-55]. Resistance (in ohms) of switchable
+- fsl,tx-cal-45-dp-ohms: Integer [35-54]. Resistance (in ohms) of switchable
   high-speed trimming resistor connected in parallel with the 45 ohm resistor
   that terminates the DP output signal. Default: 45
 - fsl,tx-d-cal: Integer [79-119]. Current trimming value (as a percentage) of
-- 
2.35.1

