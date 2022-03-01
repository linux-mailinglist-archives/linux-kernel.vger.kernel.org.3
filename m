Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF874C8D9B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiCAOYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiCAOYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:24:33 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60071.outbound.protection.outlook.com [40.107.6.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085892B265;
        Tue,  1 Mar 2022 06:23:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yluozv+oExQW5A0uk+tIQN50bZfh3G1wh0mjLnUjSNNPCgroWvUNx02TmHRQzI29+APgP56NkngR0aeu6NMvKQjknd8gXqZJwrlvGVchE3gf0x4W9oDYAGm1lQkhRm7Zj7zWkNZ52QH+63xUiq/+2MF8zE6SuljjpkWJNxIPsdEZQ/qJZ6iXQBu0c3iyBpKAnInDz51M3v3LN4HmaLwQWfBt6fm8xXKXeXqkJ+E9Es/6mVwNQrtB4QKr/TnpPsuR/tGHMNi2kVqXzqNBDODS1WT4ehiZZduNfMsGGF8Zzv0Emurq3Cy2UNlDxxQ5t3+W5WMv3tes9OuZD8mZF9DoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQwHQEDiZGBjEp7fIOth7EnD1kZXvmPqhI5aCLvlHmY=;
 b=NAE6fp6JvqnNP4XvqkphqFrr9+tdaACNX0QK9GhPQkqv7ZmjIvupt5bS8+UwY7b8n1WqqLhYf75rr7bM6AdwD0IbTigStHsqeuat5meL9CEesjTv26c68IJ/CQTPOCgrMs5sDR1u4cCqIb9OkGP0cwIP/6gu/ri9GCBiwivbEFhm5wORdfJoICHpGb/S+RV0LpCZFm0rmCbpteFMs4c6KE4zT8SeAGFFRaSu+tcvLPzyEluITMuoqdg7wVdfkWL4Rq+i+wby6uEnu9fM5CW0CE8SyDJ3YphaY3zmqbplFF2Ohm0wDaJWEdwBBGP2aZynILXuJwW50lQ8zDlgmjXZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQwHQEDiZGBjEp7fIOth7EnD1kZXvmPqhI5aCLvlHmY=;
 b=bVg8ixtP2u02VDfSNtLYeg/f3mTrIjOqXipdS4NLnRearxptaGer+itZ9yyn4lyFQAWXt0LRLizn4+DQT5RldjOBbO0dxrEgkP0WqcEGlYeq/0tsVe4v8kcUSsQEdChPDr52rn4wRg9RX8zFVHlNq6XacCND73VqKxSpc2WVdrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB4957.eurprd04.prod.outlook.com (2603:10a6:803:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 14:23:49 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e%5]) with mapi id 15.20.5017.026; Tue, 1 Mar 2022
 14:23:49 +0000
Date:   Tue, 1 Mar 2022 16:23:48 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 0/5] imx: add i.MX93 clk bindings and driver
Message-ID: <Yh4sdEIJ3NWwUMFW@abelvesa>
References: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1P195CA0020.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::30) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f0b7b9f-3706-4e9c-ff3f-08d9fb8f1aaa
X-MS-TrafficTypeDiagnostic: VI1PR04MB4957:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB49578981863D4CA143FDCB1FF6029@VI1PR04MB4957.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCmHmf6Qp+JJBFSOaCmke1onhpiCBIg8Xb9hWkXW6T0hQ4kjf31VhnFjvGZiG7Aj3oqfA5ipPgX7601pFdk22iiZyIF8d5BdUQM+OIWO6+c5wrGYfW9LVB6WleFR2zCqMcd+yTRhHaFDAbXWBR4CIY+g9alqaHujzzUX8Pr9DAfymPMD0G9vZq2zjnkRoRBjWqALU9Tx7a8TcmRdMggA7wJqSBWX4bn49aw42lfRXKuZzIrjHQFdtVxT8NM/b/+2pwF3NjYhjZuw9SfP44rBMrc5hkuaJFWmSwcmYDXIeQzFDf8/MQPnTHCFI9UY8a8cEx58CxnL4uG7hOej9Hagr5Y/85vxw9jIhP/uxswz+MYP5Ht7DjFh1tB5RweLCxQMjGrRqi6umJ4YkW80xFxaEaM6ztcirzmRU9eTqFVBcx7qBi78DHCy4yl2gdW46acuE1yQQaUmZUhGE+AxxJ2CVRBOnWwypnmxpwOIKocCkKAK5tQY5/OSdu0aSPmaQoRu+yItf03T/BZRXdDfwy0qD/Nmu3tbP/Vx30QYBCegLYSqusdci+D4uYfQIYV5/UfCiBkU8NO7B8P/k+Rh8/cccAhgPFF/p3bucu7oMjY3cRQTkxiaE4sqn6Z/Y0yw2MI614jFXgBH/HT9aUrnzd8UDVvAlX4jCWbiScuY/ho8TSxcgNvIofbwa6qwp1Cro1MOh5H/1bKGcCNB9lpfef7t8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(33716001)(52116002)(53546011)(7416002)(38100700002)(38350700002)(44832011)(6512007)(9686003)(66476007)(66556008)(66946007)(6486002)(316002)(83380400001)(8936002)(6506007)(6862004)(8676002)(4326008)(186003)(86362001)(508600001)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DIYs3EDqnlAx71mvzfEatk+oif6JK+IT7zlRm6tXhat7CRWa0KGBrtjA6aqh?=
 =?us-ascii?Q?dPPQmTtTQVm1tDnFrXE5u9jtlzR0f/uNEjzjiVKvo6870YOUR4Tbghcwiw53?=
 =?us-ascii?Q?vCcakntowsN6QfdIDJxRW3X/a09RQN6/l2/v5FR7MwgYPS1AfLHVd/azDghj?=
 =?us-ascii?Q?MbcYBOtthbf0uc65CAddxP0sjPX7oQmyWHZqwEF55FdhG7qiAUkcOilaZD4D?=
 =?us-ascii?Q?UZnmb/5J9dbRijhAPsn0sp9OJ0MvM+qm6vhqcf+ifGKpep3JKuy3hQs2nm82?=
 =?us-ascii?Q?s1GgTp8PqRzzUycLcr8mILVW4PdMl3oDFxv0ZfZ12ZJrIXey+h5KRuBy4RG3?=
 =?us-ascii?Q?jBSTmJYW2pj7GwI4SQTE3YcQLj9dZANTMoP8SrGCxsi5aKQhldKb43aB8f48?=
 =?us-ascii?Q?KjGetnp1EZt27/6EoBPw4twcSgFlBc/PWDCYD+9I4A5AsWlSTK5LgQyxAT04?=
 =?us-ascii?Q?qAx06CWAYB4hvtmUx5mqa2kuWbcrck3+ahOOY5jxsqnfm/OFzuTa9AJO31Xs?=
 =?us-ascii?Q?6XkAKhzivxOV8S4xBLtdBAhc32Zo1vWpq00GyHphMSWJGY91PwfRfLEPfyMe?=
 =?us-ascii?Q?w4xJAslJtaenB6WCEgdQQVzM7RwOHg5ZOYvzQGqGW+/K4MnyItAEUFKcAK54?=
 =?us-ascii?Q?GAMXvzp/vywbSp759TdB4cCp1FsJXy9mGdpNIMOiKUFhH3FF+tPlhaeFt9Om?=
 =?us-ascii?Q?YCYLCXXGAgfBOSyc2dfLBxyNB1E5L0kx5X05TGiX53IM/NlbvF46UKXBMqTW?=
 =?us-ascii?Q?SLaql2bF9X610dEq/eCZ4nGHiVRDakDeX8KlWmNKEtjmY2U1wj8NGQfakKjA?=
 =?us-ascii?Q?C2WNoAyOn1T//KFJsli+gwfAMSVJRVi+iwbmoe4wu9sDaeTIUMNagxm81fwv?=
 =?us-ascii?Q?9Tipe9hTpG0nSSSn0XzpnNmFnysAFEuHcOMLfapy+DiSUCmJxYr4zvQagoVf?=
 =?us-ascii?Q?0XFrJ/okZ5sl9rhDqDDvBgzS0r3+/TBWJVCjc5QQEWdBN3xHEpvruhIiQGZ1?=
 =?us-ascii?Q?Gx/pTQiZ5PCeWN1nvbjqFsJPW2ug3CG4jCGRfFjWMPCF43dGAzLOY6a3K3Db?=
 =?us-ascii?Q?JPdrFvn8OZvDgBTVelmrnxBWzyXTZDbBXXTlD0YyhdHwubjAz8se3U4DbSUW?=
 =?us-ascii?Q?gcdo7qiv/YcvtwFQ7Pcb8rW30TT2DAYJ6CAeF4vSuRdPZvcWQdRYvawSw8LF?=
 =?us-ascii?Q?wWdsRM1dcGUspI4iy/c0lMqLJWLsLKZx95L1aR+N/pBvinyNmbNTUY3heMX1?=
 =?us-ascii?Q?RUzPt+9T9TWE4gk4pnAZWsyGGJkVE4a+/VTqMSh82qhBzythfKCv+SVQXXmP?=
 =?us-ascii?Q?NYY1UNPxyMKbvIvZfuCW3BoCjSGpyw9kS8dI2B+ZP8cVpU83XXUCaDXSlkB1?=
 =?us-ascii?Q?63wBiM/rIsNXwDj44jQ0bO6/Cy8oJ0+WEG3MPR0I7jNlNNPaTlFeWiTBuJha?=
 =?us-ascii?Q?xMBsy839DCTznl/IfkRpuKfwTEP287xjz4DeOaZ0eczIYhrnfPVfWJV5Ze8M?=
 =?us-ascii?Q?hwTC/nrPVpF9fmOMnY3MO4zGjbtdk8FsawTB2sNbb8uVTbQkxgapImeWShNY?=
 =?us-ascii?Q?xGdpi4g8S5Fe+LPJhhKD1CPRKRcjrgxpMd5SBOxeTFyOb31FVgnlZFTAKMdW?=
 =?us-ascii?Q?IRx85nLz68z2g3Kf1DUpM7k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0b7b9f-3706-4e9c-ff3f-08d9fb8f1aaa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 14:23:49.7507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xog5LMwHyioFbHgIKbgi0HpBSo+1yofyMXcvYtpabjazamx6tmBaY+yivKVBBvEdG8WRC17lbM/S1c9uGFiJ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-28 10:09:03, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 

Applied, thanks.

> V6:
>  Add R-b
>  Address comments from Stephen for patch 4,5 to cleanup header including 
>  and static const array, drop unneeded WARN_ON.
> 
> V5:
>  Add Rob's R-b/A-b tag
>  Use FIELD_GET/PREP in patch 4/5 per Sascha's comments
> 
> V4:
>  Add Abel's R-b and Krzysztof's A-b
>  Address Krzysztof's comments
>  Address Sascha's comments in patch 4/5
>  Typo fix
> 
> V3:
>  Drop an error included header file in 5/5
> 
> V2:
>  Split yaml binding and clock header
>  apply to Abel's tree
> 
> Add i.MX93 clk bindings and clk.
> 
> Peng Fan (5):
>   dt-bindings: clock: Add imx93 clock support
>   dt-bindings: clock: add i.MX93 clock definition
>   clk: imx: add i.MX93 composite clk
>   clk: imx: support fracn gppll
>   clk: imx: add i.MX93 clk
> 
>  .../bindings/clock/imx93-clock.yaml           |  62 ++++
>  drivers/clk/imx/Kconfig                       |   6 +
>  drivers/clk/imx/Makefile                      |   4 +
>  drivers/clk/imx/clk-composite-93.c            |  93 +++++
>  drivers/clk/imx/clk-fracn-gppll.c             | 323 +++++++++++++++++
>  drivers/clk/imx/clk-imx93.c                   | 338 ++++++++++++++++++
>  drivers/clk/imx/clk.h                         |  30 ++
>  include/dt-bindings/clock/imx93-clock.h       | 201 +++++++++++
>  8 files changed, 1057 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
>  create mode 100644 drivers/clk/imx/clk-composite-93.c
>  create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
>  create mode 100644 drivers/clk/imx/clk-imx93.c
>  create mode 100644 include/dt-bindings/clock/imx93-clock.h
> 
> -- 
> 2.25.1
>
