Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A64E4CD06F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiCDItT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiCDItN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:49:13 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60071.outbound.protection.outlook.com [40.107.6.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C1FB0A66;
        Fri,  4 Mar 2022 00:48:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1ibKJ4COT0XDjVC/Zjhjn1Gtj4VkcTGeXbqjlEozjLly+p7hg/YmWvKzI4DyyKJaIJXfJruczOdp7BHY/105SCjWQuTAy+6trP1484ym4uGneOUWupcge4XRmYni6HAbxJzW3LzWJeT4jzXsIKBkSpBvnDigHe872ghE39RzCDXYdAmpJu/xjKLuV0NKsWCDbx++uAMufqDeDdcT7WwpSAgzVByXnlGjIonwRl7AnxLsr+7gWqokA3wknvMps143zFzs04LwOzbZyNh26MehZawyWywivm/9zEzDWFtKNiLQx0j8uGANxXfj7itIBRvhucW/BFpMPcDJSZ7ITRx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oB0e05h0/Zibhk1LlJ0HkWMN8OHdrygFDV3xc+iEj1I=;
 b=mNgr3ooiw3g6rN8qxA7RqBBPYwR2zSxGUB/XIih/S31fRFI1Azzycze+SKIYcuXIJCY/5p8ZrK+j3ZdT0iy7kdi3hGZSLRgg9DVBmsvTbUcyzT4wtmDAlHI39T0cWGmYyLD9V7iJNC6jLQ+/vlJtK27tmF92skKu5tnT/kJUMgvu6EiyO+tDa6YU7eoL0lkoyt3RZGAqPqr4ZTsDPyGU8SPp5lvLSdwBASxQd1MYh4nnqf58mUTjNf04Blm45RyeoGpJOuALBHGawWbJ1yJxncxcFnbpbEcbCw/SV2FTMfQh6xIVEY23UJhAJRZ/vBGyFTvO5GXWpIzIohi5TFrFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB0e05h0/Zibhk1LlJ0HkWMN8OHdrygFDV3xc+iEj1I=;
 b=nWvMm/QEADWjYQfuA3SW/BYF5Xr+s/hlOjyBfKpTirgeD9g18Xa2jCk7fBiKGclhe5ZOVJSn5qNe8v2foi9e0nUqtzpjNj454KTkB/oKwcJj2FrBjubmcFEmALnT6qPNwcC9lq2xsOAz3DkTyJAjLtVHTs6LFxdtNsMwvbKzxLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM0PR04MB6609.eurprd04.prod.outlook.com (2603:10a6:208:16c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 08:48:22 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e%5]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 08:48:22 +0000
Date:   Fri, 4 Mar 2022 10:48:19 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 0/5] imx: add i.MX93 clk bindings and driver
Message-ID: <YiHSU6j1ZUkg41vA@abelvesa>
References: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR0601CA0011.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::21) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ec1033b-499f-44da-1149-08d9fdbbbd35
X-MS-TrafficTypeDiagnostic: AM0PR04MB6609:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB660956B68672C236E91BDC41F6059@AM0PR04MB6609.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5dKd6OkTRF0GDS9Zj0DuknKoopRzm7ExghS7j3ptX9BPRtVmtwpSU1zPa8hU+jQErAF4u7BZo0ejfAfZcZaclFAieZbIbdUDdjvJ0XkxEV7xrjvwCvt1Db5VK72WeiQCmw8ScvNPTRKr9tCXnwlsWdYRsZwHYFQ13Nd0T65WCaj4F5v7Ofg4h4s/M3q1MxP7ywXIxxWjTtXNebe29TVtY1ChgVwETv4QrdA46y+d49468ZSVdGo6yaq2fb6q+uNZIbX3q6puFARVi+ircx9Uy7tYZlf+iU1goybUbuh79I2betPZagt5+2KBGU7An9Mf/cAUk6kcCO93Pjf/5Yb5yecAPt1yKBtM7BD8h5exb3O0y3KVCak76LLgst2GX40zt9uHthJxEdoWuERM4jq7yIX5RUV3UK35ZUe10voF4GMw0bb9q4b0hpFEvO12q4Pyn5lSv8uPQZhT14C4x4lZP1n1gzFhVgPhOboUHlN2OQELG7DALWC0qALpLzhcPtTVChzQA3z/Msua8s6pR10qTVZdNWXXnew1lfYJBwaOrrBrOJv5iBXo+yjHAtZIJOoCgca6MlVZiJm7UDwEsvTcxIU4T8vB2HVdnux/if0cq57nRktJ0lQj8tIBU624Nh26L8LSfY3CzipjBpQ0uOMKYTXq40CKIxJzOw6TfxpDqP8E+pPn9SaGI8CAN3CcwcC39b1yPM+9SgbyCN0EbNQjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(7416002)(44832011)(53546011)(8936002)(52116002)(33716001)(316002)(5660300002)(86362001)(9686003)(6512007)(6666004)(6506007)(66946007)(508600001)(66476007)(8676002)(2906002)(66556008)(38100700002)(6862004)(4326008)(38350700002)(83380400001)(6486002)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PeeUQtKkIxxSs9ZM6e1po5HM3h65+t5hG4VNyfc1/+27eNt6g/dcuHsCds7h?=
 =?us-ascii?Q?/Jx3OPSfWFqLJCEQrpqDjgW946U+YHMCqNzX1HZaeaXfPpL6XSuA/o53N4sg?=
 =?us-ascii?Q?mVsYy+vTUg76u3XTw0bomJPRvxOz6BAlovSamBtR1AaDBaRtlQhEnhtooHYA?=
 =?us-ascii?Q?cGd4zd9jMNCR5efV3NepsbUoTRCFolZA9l7VVsZwQdSEU3znFC0HVUV9waZw?=
 =?us-ascii?Q?SEafn4m0Sxy/gdsGjKJhGaRgdRz//mxQ6LZcYobbaDD5w9qta4vQXMQzvujz?=
 =?us-ascii?Q?W7zEBLy7xPbYKeGOEK1UwWBGd3B6MO9Juau/kWX2SQ4YehROBH2zS72dhxfD?=
 =?us-ascii?Q?tmlSkrUC2BDsIKknaDMChge9mSqWW/Qs46DF06nRf/OTlckSXUl3lADTU3/V?=
 =?us-ascii?Q?kuKkTNEU5iRHhDj8PaczyOXqpOV1qWylSJRxuoSzMp19e5Q9KaKnMWEKg/D0?=
 =?us-ascii?Q?25vChG0SkJtHrUBYj3lpWEui0EkPOSOfmrfmuQh0XV/Dd3uFyOMNysadubZz?=
 =?us-ascii?Q?H/lN0QqL41QL6Ku6iAmQPGcAPBIPR6bkmW0shwIuUMaQy40HRjVcPzJVUIbO?=
 =?us-ascii?Q?YACpMP+mvef+INIfVSrkPh/kADveiEduaYmZBavzCfyz/o+bSXns1Vs+wgKz?=
 =?us-ascii?Q?h0L3kpKVMROr6EAXiMzP0T6hZwMqqc14xxTizl73+R8X4a/qeVp+Jr0BbZAr?=
 =?us-ascii?Q?8Me0XnMtC83aX04ky+3izHEoRPySM7dGU1ZN2VSlvvaEtKXL0pkiKiG6Kflq?=
 =?us-ascii?Q?cOXn1BtQtFJSefMH1WQ7Au+dBUNROrE336U0U5OVQOmw8bWEh2FtRnsSLCGd?=
 =?us-ascii?Q?jpqMeZA1dGbA5mzDX8navW+HaQgYjCeeHHuERqjfPDwVQ5bMv7Z4M9fl0JVT?=
 =?us-ascii?Q?tTKoulXnFP6VBrKOXiotAzDsB+8AIY1V+xlvdbZWPhdm8pDKm9MS0c/y3Qmd?=
 =?us-ascii?Q?FxZfP6tWFnJFEQ+iKoorNA1k2bQ8HMmNtEgDAgPztH4532AhHYL5bFv8xMj4?=
 =?us-ascii?Q?0JkQVU/vEbZ6bF0rKrhUsuBwmvC7ID714fKEhV1dj56vZRtgQWQ0hbJ7chba?=
 =?us-ascii?Q?ahXiHtf3NfNUUYDU5J/T27t38nAUMJtLSvbPuwlLQo5h+DPnFKFNcGwGrRQE?=
 =?us-ascii?Q?ZGiCiLYXWiq2WolPEhRk6nBFjyOyDD0vR3G1LXKR5tqElyxsvx8PggWe1fTg?=
 =?us-ascii?Q?MpIfgkdpcguQk5ZbsTnCEixcJuZUdTW8XqwLDTZjuCYSUkKIIiFv3JCcY//5?=
 =?us-ascii?Q?mPJvon3I8xLrhqhvxP+JFl2mQksJHhL0pUCJyCgPMAAVc4vpMGi3gfRQPVzX?=
 =?us-ascii?Q?HlTNOyCfBLXxb+7wf9/Ig04wZz+oH0ikMIwu9cYaF5t56RccU30NDnU6WTI0?=
 =?us-ascii?Q?wyahIAM9IIostCjOX7tc5SRNNWOLIRWMmSxBHBWbSxURvC/mp6Pawm43HwWI?=
 =?us-ascii?Q?YuoN34Z1lWFHpM7BPGVWPNq1W1J19X7jP/VloeDn5+YtiimWF3uaAFUgsnrR?=
 =?us-ascii?Q?Ndo3jcmI/FqU6cQD4WU3ozvFvPWwXneJfhGOqfLVDhTKSuRLzYVjChsljtWD?=
 =?us-ascii?Q?9vw6Ff7rZ78yulh5O6sw2fy94eT+cYYnhBai70jvfRAhWVmbHnTX8+C1/e4K?=
 =?us-ascii?Q?VJJPbb6hBBCC+zFWqsCHeOg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec1033b-499f-44da-1149-08d9fdbbbd35
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 08:48:22.5969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7DHLmIadXd646wKtp76pD+nkNxYIzN6swh7iX5suzWxc3A3hrJ3HwG5cXxVXwxgjulqk7y+GLdv/yJg7I5ItA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6609
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

Applied, thanks!

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
