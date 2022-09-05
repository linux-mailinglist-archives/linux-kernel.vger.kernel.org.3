Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAC15ACA2F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiIEF6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbiIEF6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:58:23 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32E93336B;
        Sun,  4 Sep 2022 22:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APTgDZ5ekg4qtcFIjSy27CN6O9wOxJiRh2TMnF6004RMsAI8TmRI08Yd/ajZfgKVVOqnqg64OaKEL2YG1xqSB7fqWPm0ZNYnyvc2MqFa+eRB4gxk007jysZjWKXR9DWOWHcGBLFwbR5FedJuMlz+UuDpzY820NBGo9di0RFrmxhvq8oTYaY/wWQkqKQITrsbczG0uMTHfWRD4oGH5BF2XVHBz3gSNp8lraOOePvOz0kAhksY+ZgRSAvRAHN6j3+3BPUobD/EO0XQfjzK7fUQXaJVoaxuIFuWL3KjQfIxInWSxJkdNXB3Z7972ESv5Nrh8rhpj3LzGKmg14uW4ucACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGSebiQwmPPdWBcKmzKbBv1NzSuMoKMA+wf+NeLGXYU=;
 b=ezsnAoacL6zdCFw7PEJ4Z52JlmdcxQD+trGBKnLotoyoUkRVxukEqvHR5hku0J4BOxC81DULFxHuRjJsAdU9a3se3eFUheFs3onmx+Tu9INWwwgk7P2QmXA+yFYZIOGCQqi8MaNw9Pu3J4R7rxxew57icSvOT8Ff6TkFxln0UM0MNJKov5Bm3n6+wXeR61vQe37OqOZW2YAGKPZlY8PMP0TVRzd23kuTHHrzVD+A3mUc/oHn0Ryec8BOsw1ggWu/wgqKi4hW/RXvsnNByYGl/KGY79Rrsnp5lzQEGa4mOof/h65Q468o5IZpgsa1uCwgxEaGkkLkUXsf+3XfbmqP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGSebiQwmPPdWBcKmzKbBv1NzSuMoKMA+wf+NeLGXYU=;
 b=VC8FwlcfBrdZxqs8dcckb52sxS0+tezhLJNFaT5ND+vZfyZXOLcwATDh1q+XHRJXlu9jfyeCPaTmWKI6L0Qd6M3ZIJ/ugtscZjSzQxX5crMrkA0TFnPlwsQtqAROIXeQQGFQxvtHdS3hkSg2ss+As1KIdZf+si3L030y7h6y6L4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 05:57:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 05:57:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/8] arm64: dts: imx93: add several nodes
Date:   Mon,  5 Sep 2022 13:59:07 +0800
Message-Id: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da0d0aee-4001-4f25-3a76-08da8f038b09
X-MS-TrafficTypeDiagnostic: AM9PR04MB8276:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3zQcJkMSsoOvA4gpIYtPC5OfiFzg2T+s/7YIs3oHdSZwY1jLKellU1rzGECKljElKro2crUrsR/w6du58G7wh7axEwvZ5O9aVxCPLsMje4ENs5I+WJjUspnB6lL7H7gJBli1zdB9uCCafVYIBmyGlFt8D0PMv/CjzThxJIkBfXd52odEzFi1o1UC8C8j/xw4alYdVhAv+YcdrN07+QFBe+Sd656f7sKe0fdx3IfgtTGE0GANjDuBETsZedmowWA4HoxlJ8m0a1EOBh5MClx/YBVSGIaNo/7BExL0X4VyPxT3au6YS7Wk1tg4ZFXBLJMOQEvl85lOvdt0sff861gHdQoUDmtP3EtYxbts1twPAC6/ldUaOK5xf7fczb9A6A4HOeEEwfPH66A9QsGOp9/u+r4EJOFYsFR3WcJouh7yEN+e+OzCJnQVbit/2J+W8ST9jZZ94RQSpGO/DdTJLSk928aFy60S/PiBcfetw2LUTYFyecGivr7KTmT+5xewekxq93fz/qNyBHvrClPfroEwiU9K1nosN1+ZzSAxs4ow1Pzx7zSWykaQfNqUKBOdltMk9GID00hrwKl5+OwhlZHilsGc8DUByWZGnj09bmS4xSOvv6DVtLk7tZdzivcq3T/5N6Edw2nrPgcirLWqzaZGFoNklG1SCAPF8tYVbFrXIScV+uyTg8vl7TXAEY1As+wZzpmT3jfE6eb+NwSjFlrJ1DsgQEqkFCfh60wOMwtelo3ACA/rHF6yUTbrSdBySXOyA9t1foW47nw7vmSJrXoGkK2sSCikWIgj8FvagFhugnhTe1XrCLFAmv41RQmWoPkpAByWNz6Xa+dlu4v8Pg8aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(38100700002)(38350700002)(478600001)(966005)(6486002)(316002)(86362001)(41300700001)(52116002)(6666004)(6506007)(26005)(1076003)(2616005)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(186003)(8936002)(5660300002)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BqzoJ6yMP4A3zV3qff8ji4nWW5YBL+87aR4XhHqWL7h5YnKq3of56Yai36lJ?=
 =?us-ascii?Q?T2WRZQducEvDBAGkEiYCFYg1myHYaw7HkEVv7nOU1awf8CxchPT4LaZiIdLf?=
 =?us-ascii?Q?GouaaDUgJ84YLLSPAi6Jo/jtcHdza1KKsttog4Epyr9H//LRirdwLpKWtB7m?=
 =?us-ascii?Q?Wsw53ObUFV4znxAGRWR848fR2f9rpX37UdeucIQgH0x3SCR4mpiTGupDNtbd?=
 =?us-ascii?Q?CsqhSGGlJmLw9y+TPsI56p6HxX/96k/2jAwx8sRFjtClfg/wCVQfNcYDeV/R?=
 =?us-ascii?Q?wt8hWDyiaEeZ5MCZ7QTUlQtwJktaYwhSunJmi6N1/BBsepHPruTm0xv0dSrE?=
 =?us-ascii?Q?F7tHP6HFZsKv9LJ5KiuX9zUYUdwIQoBvpVOuvm27TR5ec47E7FouBrxOVeuX?=
 =?us-ascii?Q?vbcCtaSZQAFWNt/i1UohyzCtTzfflTmHPLCv/8IQ/nsXrnXTk+c21HG7IIoP?=
 =?us-ascii?Q?8J7VYVs0KuzEh98AhS3Y2AemkR6RzvAt0Qvk7LnA19FysO1x/X36TwJgFrz0?=
 =?us-ascii?Q?W6pD0UccV6lHx41P0OEXr0SeQabpchlmLDdb3DmjYV5axKpnQnkMSm8OPPkp?=
 =?us-ascii?Q?PiCppHynmDy0Ak/bsR4OwTBEl99UkrHRdJxtRIZ1IpyO8j7m0n7MA2mt0VRV?=
 =?us-ascii?Q?pgyYk4I9wLaIuMzwlWXZVR57tsH2JHmOg/D1OGYo5BDbqKSyGASVLyeh1O/Z?=
 =?us-ascii?Q?Lojs7NCD9BIXqwpCHMnMWMv5teHb8i5e2ZcRHAZE90logHff230QucaeU/Hw?=
 =?us-ascii?Q?1k8SMYmiWvvES4N6wwdB0k3FGn9CavRkDEyEfkytxmqOwfsFxeR+B6CkNJnJ?=
 =?us-ascii?Q?oDXBHIB+Tl3PRyYHFTqIHTCmB6pj/ZLpC65Lz4x7DVCFG4D3D5O5KLqowuOx?=
 =?us-ascii?Q?2KpYH4uhWOjllFDh9A6GMbGIi9Q5f7OZUXzdZr04/cGmkxTH4ewcPiKYdEZA?=
 =?us-ascii?Q?WcBluVI6eLEZh5mde17IAnQskI+yjx5xNeoY5g3CrzSLgKKzMFZ3M2bCPGoj?=
 =?us-ascii?Q?8LSUqB8/buBCqBa8MQZ4eHRcYhyxMxY0NVBC5Gy/PL3FEET/wUp1PZltr2P2?=
 =?us-ascii?Q?MR+/9Kw8gD9OVcnPpTqDq49z7XhxgvnwBSH4Jg5Ofc8OXFx/xy6VP0SeYpRg?=
 =?us-ascii?Q?k97FU0WAOVo18upHmrJka1tvRDOs2+430cULxv247fiBK7zvIGiHqwiADEkW?=
 =?us-ascii?Q?g9aslkAJ0pS0FvQHQUh6+1HC/ptrFOlp/sTmn7agIsWJ0D+hBkliTX+X1EWr?=
 =?us-ascii?Q?qEAJLHaEdRBLXg78EBgHqRokzQRuLRbuu9Bno6uBFGOzk9dF7nNBUKFRC83Z?=
 =?us-ascii?Q?dhIyV5QKKzBLXEB2Ob0oKWRAVqJO7IVOAui/9o62wTVlrVq+rGNk6AaaidpQ?=
 =?us-ascii?Q?JofyNeIM+sw7HSGSPvgBPpx48LtMTwG2WD8ZKgeluAcny1gP2IPE55auLtxk?=
 =?us-ascii?Q?/2ncdLhOnaBMqbJY2mQELJtapCWrPrW1qqpu7S+NwZPTWzJLYUG9lBQEHrPZ?=
 =?us-ascii?Q?ifgTc0P6Dq1wm7pi0Bm4cor/WOdiMFODJlipFmnXrloNLBxql5XMyR2hLSUC?=
 =?us-ascii?Q?RXYAqWq2i7oqq5POGUPTjOS5KlCCU/tMkpQNewhF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0d0aee-4001-4f25-3a76-08da8f038b09
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 05:57:41.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcwjJ7eD16t1PrhYlyUayAZumIBIRKRzEAO3pR/P2ZRn7ECexTwcBV6hfLQ0MxwMDPxhP1IYjiC0Lgz2UGkKYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V4:
  Per Rob's comment, use syscon.yaml for i.MX93 aonmix/wakeupmix blk ctrl.
  Drop status okay in s4mu node in patch 4 per Shawn's comment.

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
  dt-bindings: mfd: syscon: Add i.MX93 blk ctrl system registers
  arm64: dts: imx93: correct SDHC clk entry
  arm64: dts: imx93: add gpio clk
  arm64: dts: imx93: add s4 mu node
  arm64: dts: imx93: add blk ctrl node
  arm64: dts: imx93: add a55 pmu
  arm64: dts: imx93: add lpi2c nodes
  arm64: dts: imx93: add lpspi nodes

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 161 +++++++++++++++++-
 2 files changed, 157 insertions(+), 6 deletions(-)

-- 
2.37.1

