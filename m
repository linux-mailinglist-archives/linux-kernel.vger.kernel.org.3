Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DBC529D19
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243911AbiEQI70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbiEQI7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:59:19 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60087.outbound.protection.outlook.com [40.107.6.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64882ED6E;
        Tue, 17 May 2022 01:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRyaerss1zb89JyHxu01//O7K/jHexfJ0xfJxFfbcP2j6PNQSjDqHM3pnAP6cU+eZSK/IklyO/Roy7CYC8ctbEcElsPD4dy1nG1MtX8BWqBmmUIgYTnDqcsUmRRPQ0XyDGdwYowhLOxKZuqn4hcYAPwuTdhPLwXNC3d3HOAonQ2NOFFSD012koTSMw6gyOfeaOQMwKF+vZcJglOFiPpgKws7ecB1rSPXqADrLowKgjjarX1yAhwQHwGKuoQKtwBZqY3Qnm1OLsh0q45opIXhMnNB8xnaxW40/v4MeNPZdOK5r+WCa8q7KcwF8LfgjtIPDqT+3QWyDfKCKt5yODtbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnSpVJrPs3UM0Q20B5nCbGZ6yFIoPs8CgiZkdtAT6c0=;
 b=HxYyPAJznZ/MnauQBkXiMnx8NlX+sBW3MOYN0HU/ShOvjDahpWhsZX0AjO5iRTrUDG+cFcKjWeo8+F1rWLL3gKw0IOOp0Iczyx/X/Vw9JeEPhEDg7uiN5D9fthYLpXZur0ciQmeUVxj8zwEySOIP52+w7f2I11RTW7GdbMOawNYRepX4TXX6uDPQ1pTQWy2JQCxfLLGeKLeI8ORgr3e3gPXhvW1Z5nksV6SQXI05tetdn/57zJXkYCvrqkYe7WqesmzhZNGyeHREfHhEr63W/9SHODjBXh5W/N2dTJNNwcc6fwJm/GfQ5m+ZysYx77HmdyyX6uwritqFHVcCZZgfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnSpVJrPs3UM0Q20B5nCbGZ6yFIoPs8CgiZkdtAT6c0=;
 b=R0/QSCTl3P8JoPTg8QNfysEJK5M/6Czp0aDk6cxkd/Hppy1piHow+IEMR4a6dU26m/NXVFpcCed9JTXNVZ52nvvcwgHMot0b6/AWbte6VAMmwtGciyXjPAvjVuG0+sU4WvUcBBE4CnpMd4j5Cb7bZlECXtP5VWQOsls5wfWrrkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB3806.eurprd04.prod.outlook.com (2603:10a6:803:16::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 08:59:15 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::9060:4119:5466:f5d]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::9060:4119:5466:f5d%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 08:59:15 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v5.19
Date:   Tue, 17 May 2022 11:57:20 +0300
Message-Id: <20220517085720.375941-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c086832-abb7-4871-064a-08da37e384c4
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3806:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3806C8606137F5CEFC024A2CF6CE9@VI1PR0402MB3806.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6hUHyZP8NNv+xqfTpnFALjTiUqKnf8aeifJY/Q9gXc5YcbHnnPIC3e+a04mS7QKCeia4wcuBZtYz27p/7klkHBCpZGSE1384ErpJROycxRycJGJDwonPf7BUdtbsyiPN+Lx3P+WozU40eAPzS8SdZPfz8xNRHf8MXfIGKDmL1Ekw8BKBa7XYSgW4P+3PVPCUCfTJf5uSd+VZij2JOeTK93lVv8e8gARDvMtxnMThF+zJe+DdGphV6ff16X3VUVDioB/YneDWku2Z+D7atlq9YjYNqa7rdFm9nNJcyc8eFUPr1ViA6L5zA8M56cHJLU4SV8eanZuBDPw1HUOX4vjvQGoVoCCeahoJtvGyowM9Nan+ge3mqqgHTIOOSGEplF/1eCGe0qv7gpGiY2LeENicYw5P+RVzgPwKl77ZRgn494rAP+DjDEZdMpVIIvGcisVc86PLz8f0a2aG6/cYmWVfS0K63bHcnGiSnq5jvMZ6zOqTfWz6NJNvrsgYV5HSkdqIIq2goKyp5UWQ5KjPnCGxhsP981MMhXplIJ+4ypHxGQAqUcwbPxaV36wuH1pZdZc7paL/9Fxpk1LJPsEnoBoJMEp884jKCPtYbcapI0h7UbEu9D6xtveWkXKr2nIa1jVGPOscM8HDPOkpD90sHYUzcIoU9LGLOuGO/dsH1coDbu/m3/RuAEyLIGg2ZtCzTtWX6Q6VKQ6VkN6r9aP1mXQyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(186003)(52116002)(316002)(83380400001)(38350700002)(38100700002)(1076003)(5660300002)(44832011)(6486002)(26005)(8936002)(508600001)(110136005)(4326008)(66946007)(54906003)(66476007)(66556008)(36756003)(8676002)(2616005)(2906002)(6666004)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0hhWFFLWjB5ZVhUbXZsQWNNZXFxZVlLci9OeHVOc3QzWVhqU2M3VStlWVc3?=
 =?utf-8?B?bGswWVlXc21TbHZGQTE2WTFEK09wWDFRdFBRdnI2dzRaajBwdTRGY3J5ek9q?=
 =?utf-8?B?YWI0OG52TDJkUkR3dmVlTU0vNkw0dEk3YXRIL25MMDFiRGJjeVU2b1dyS3Fn?=
 =?utf-8?B?REF5SWRZNkpaVFUvbks2c0pOUGtYa1ZVRHhMVVpFMEtGZm1ObkhMa0ROZTJL?=
 =?utf-8?B?MGpXVGw4S3BURmwweDV6MUpZbThMT2F5NGFmZkpJTW1UdGo4TUZGS2tna0Z3?=
 =?utf-8?B?K1Mxb3B3V3Bha0ZsbzFLSUUvWkk2b3M1bzVTTW94TUtpY1ZSV01uWmtOa3Bs?=
 =?utf-8?B?NGl2K3ROUFRoZ09jeXh4cmJHR3QwZWptSnRKdklMRWFpNFI3aldqcVFndVJ0?=
 =?utf-8?B?YnZta3FTcjR6dGFpOUV4Y2dJTm9VRDBMVllhV0pSYnpQK3lOLzF2U0VSOVkr?=
 =?utf-8?B?a1NpdFRsOThvQ2RQNFBRcGIzRUMva1RMVlAxcVdMeWQwQXFKbjJxOGEwTVdj?=
 =?utf-8?B?a1Qvbk9HN2FlUFpMVldkUVFIY1lCMlBRQ3F4MHM3ay9OOGZmZStFaXRZZ01P?=
 =?utf-8?B?TFF5emI4VjF5ZEY5YldkU3VPaExPazIzMDByTmhYeFR1U1J6WUpvVTBRTmpU?=
 =?utf-8?B?dkFzdDBDNHJTci9sTTN0MDVNSnZXa2V0SGI3bExKa0I3SndaTVBaa3QzaG5O?=
 =?utf-8?B?VDlkQzh0NUprTm5WWnNCSkRpRzNJak5qNElGNWs5LzVtT0FlRjF3a2htSWZ6?=
 =?utf-8?B?ZzAydnhNVVU1R3h2MjlTdFZOUzc3dHRvS21VSU1BcWZLdGhsak5Wd2lLb3Q3?=
 =?utf-8?B?ZVhsTGlWQ210bm5RZ2swTDd4QWtSVkJoT21GU1cvaU9BakxXN1BJZXBndUZO?=
 =?utf-8?B?a1JwazUveGI1blpJd21ubDZtdjF6MHIrdlhkbDJ4VHcreDNuUVVhWVhreVkz?=
 =?utf-8?B?Q25yYVEwNGY5Z2VWelJBdVFNTlZlamJ0bGhuUHBDaXdBYlI1R1pzVnNPaTRE?=
 =?utf-8?B?eU5sbUxsK3ZPdm9jS1RGRnhVZHZObzZXakw5VmdpV1E1N0RpZGJzSTJaelI3?=
 =?utf-8?B?VzgzNzV3aUtERy9YR2NERFVGbnhmc1BRTzNiTG1QWTg3Yy90OG95MVlOemwx?=
 =?utf-8?B?R244OE5CdVFGQytIaHRqWGpFMDlXMk56R05tQm1nNEgwQmM0Y3p6d29sZ3hZ?=
 =?utf-8?B?c0FET0ZtZkZEeitwKzd5Wm1wWncvYnlHcWFzUDc3Z0p1RGV5bnV5V1VOc3Vm?=
 =?utf-8?B?VVdGR2RsNUdzdnVrQ2licHFxcFF3L3o1b2ViYStRMjhJZnlXMzZYQUxFOHls?=
 =?utf-8?B?Z3p4TlNvR3VEYnVBOGo0NVJIOVFHMGJjNHdrRDhIMS8xVFlXTFA0d3A3QUVv?=
 =?utf-8?B?aE5JS0M3L0FIeXQzZHNpa3VKQTkxTHlXUFdDdkZjSGVzemVCdGFJZFhFb1ha?=
 =?utf-8?B?aWJ4a1ViYWNrR1NLbSt6cGpCZzUvc0RwczE3T3ZFQVlpR24vcU5PY2NIOElE?=
 =?utf-8?B?Y2ZDVG9JUjRONzgyeTNoOXl4b1hQSWFsS0NqWlgvc0lXS2tNVFp4M3B3djZ3?=
 =?utf-8?B?TFRNZEs4NDQ2VmRINXFYUDJjWTVNVlY3RXc3dVVEekJmbVlIaXpYQlhiZjJL?=
 =?utf-8?B?QXgwc3h2aEhYdDl4WHpLSjc0TkEwTGN3MnVNY1BrcTFVV0NoUUVpMTIwTHYz?=
 =?utf-8?B?NHkvbWtGZGRNdCtkem05NE5WQjdtaERkOHVkaE9KaThGN2VxZ1RyQ29XS3ZH?=
 =?utf-8?B?TWdCaTdoQ2Yra1d6MS9SS3BpcEEyU1B4b3k0R0h4UDRaZW43U1g4eXFNMC9P?=
 =?utf-8?B?b3UxclIxL2ovdWdzd0lMUmVoYnE4eHE5d01sNmZ2NW1QNjVYOTNPcGlWc0lZ?=
 =?utf-8?B?NkZWTUNyQmx6U25ackJtZCtUV3FvUWNlalNnRzh2MCsxWHZDRjU4WWdpT1Rh?=
 =?utf-8?B?dVNSRlJyTVNmQ3FFbDRlSVZKYmV2amlUOUd2UWg3WEkrMXVOMWd4WjllbEdV?=
 =?utf-8?B?aDA5dGUvNktuWWMxellCNlpCVDdZZFhWZ0V5WnV2eGJUSW5qR0VsWkNkYW56?=
 =?utf-8?B?L05lNlBPdlBrTUFmSGI5alhKTENDQlU2ZURJV0JzbTZrUG9UVjk0eE5WTEpY?=
 =?utf-8?B?TklCaTkzNHRrSGZLSWZ1dzEvczM0MXlSVkZjS0d0cjFDQWVmeG1GQTBwclVh?=
 =?utf-8?B?aDVZOHFhaElDdm8zMWdYNnFrTTZ1VU9tN3RBbUdOcCtobXZBYm5aRmdhRlpB?=
 =?utf-8?B?eVJZdTc1dWFWUlJiY09UL1RXeUQ4NXdYajM4WWtrS0JucFVzdU1nYnRzSVAz?=
 =?utf-8?B?UDB4eDB4WDRJNERpbzF1cXo4bFdndzRTNTJjV1RBUjJKMzRLcXNsQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c086832-abb7-4871-064a-08da37e384c4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 08:59:15.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4jxOTvjcIQAzwHJV0mZ7AOoi+pMvqsjU2Sp0qQFbI9Zlo/6CkuhKuFYi5a+DvWKYPGwW9W9YaCnsg6sDla21Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3806
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-5.19

for you to fetch changes up to cf7f3f4fa9e57b8e9f594823e77e6cbb0ce2b254:

  clk: imx8mp: fix usb_root_clk parent (2022-05-17 11:42:07 +0300)

----------------------------------------------------------------
i.MX clock changes for 5.19

- Add 27 MHz phy PLL ref clock
- Add mcore_booted module parameter to tell kernel M core has already
  booted
- Remove snvs clock
- Add bindings for i.MX8MN GPT
- Add check for kcalloc
- Fix for a potential memory leak in __imx_clk_gpr_sync
- Add DISP2 pixel clock for i.MX8MP
- Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage
- Add clkout1/2 for i.MX8MP
- Fix parent clock of ubs_root_clk for i.MX8MP

----------------------------------------------------------------
Alvin Šipraga (2):
      dt-bindings: imx: add clock bindings for i.MX8MN GPT
      clk: imx8mn: add GPT support

Jacky Bai (1):
      clk: imx: Remove the snvs clock

Jiasheng Jiang (1):
      clk: imx: Add check for kcalloc

Lucas Stach (1):
      clk: imx8mp: add clkout1/2 support

Marek Vasut (1):
      clk: imx8mp: Add DISP2 pixel clock

Miaoqian Lin (1):
      clk: imx: scu: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage

Peng Fan (4):
      clk: imx8mq: add 27m phy pll ref clock
      clk: imx: add mcore_booted module paratemter
      clk: imx8m: check mcore_booted before register clk
      clk: imx8mp: fix usb_root_clk parent

Xiaoke Wang (1):
      clk: imx: scu: fix a potential memory leak in __imx_clk_gpr_scu()

 drivers/clk/imx/clk-composite-8m.c       | 19 ++++++++-------
 drivers/clk/imx/clk-imx7d.c              |  1 -
 drivers/clk/imx/clk-imx8mm.c             |  3 ++-
 drivers/clk/imx/clk-imx8mn.c             | 41 +++++++++++++++++++++++++++++++-
 drivers/clk/imx/clk-imx8mp.c             | 24 +++++++++++++++----
 drivers/clk/imx/clk-imx8mq.c             |  5 ++--
 drivers/clk/imx/clk-scu.c                |  6 +++--
 drivers/clk/imx/clk.c                    |  5 ++++
 drivers/clk/imx/clk.h                    |  1 +
 include/dt-bindings/clock/imx8mn-clock.h | 16 ++++++++++++-
 include/dt-bindings/clock/imx8mp-clock.h |  9 ++++++-
 11 files changed, 109 insertions(+), 21 deletions(-)
