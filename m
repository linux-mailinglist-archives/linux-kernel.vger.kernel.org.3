Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862D74C1082
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiBWKme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbiBWKmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:42:31 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A2A41329;
        Wed, 23 Feb 2022 02:42:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m54K5DfJf0MqTecXxj7o12HLTCdk+D2uaZaV9twtLRwf23mw3WXirbCDAhFe8dnzoaqxJSFRVbqcTOkL+IaqWCGHy9rW5aclW7s44Btt7jihx9SnrFRSHwb2oazZTBJnK8D5lkTZXpBOBCFE7YRQbCIoYDSPOWlgx0w0Kqid2rLEff1rA2RPfZe7/nBnPlsR+NiXwZn11ANzwyafTCnlDci+L0K25m9KqNk71GPLKRiUE2AXne31eapcsWvT9CZuODgVsGKWjfuQyjj8G5aLfKlX5fhS1/dus9MNXHx/NXGWJiQNRBP3+fQ+djJktkM3LUEyKfhtyTRVdzb+TRZ+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIA/JyCo5+irZpDqa9V1IPcFrPtYGwLb9b0Ed03pbU8=;
 b=k4xtQz8EJtX2ssNbJx2FMjdffJ4avhzrrqwraitVxQYKDLIkuHbH1lzMeKNGTcOMD+zXdesn6Fm9XpQLElivC8360IIhdcziSr434Acj4Dlew2RwimEwviYTdLEDuLJBqMKpIX7EattzB7cxDvEePFeVdwns+AO9IxpTUt93WBZDfJ5mG5VCkMIhcWnCXQW75gqaijBs46toLaZEXobS2g06S2Mv4BZ6Z/ZhDv02Tg+VqIo27gPmXOboO46Rpta0wTLRbtpf7Cyjc/1D65DraIBzB28N2xI+3HdBI6it9eZi03rU8GNpVw9/Dvi0ZriK5OpwyveP8JF8MJDxje1cag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIA/JyCo5+irZpDqa9V1IPcFrPtYGwLb9b0Ed03pbU8=;
 b=gkXroLyoEJ2asYzZNA5L9CWKZh8jBdrm/RXH4euFkVxMFsNLhLA6GD9MPveUhWMCL8hWon1SK+HdX7nlJHKTaUeAPF3LbEtAjBT0hBkYtDc1WfqvstLDObWHI5XKOqTHIHeVcauc+ohnrTYkTaOfvYMi1eH27+IjTPnjjOXxFUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM6PR04MB5976.eurprd04.prod.outlook.com (2603:10a6:20b:99::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 10:42:00 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f%6]) with mapi id 15.20.4995.026; Wed, 23 Feb 2022
 10:42:00 +0000
Date:   Wed, 23 Feb 2022 12:41:57 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 0/5] imx: add i.MX93 clk bindings and driver
Message-ID: <YhYPdYRYKDpfBnji@abelvesa>
References: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR08CA0094.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::20) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24003a9e-d256-4aa0-f71e-08d9f6b91f25
X-MS-TrafficTypeDiagnostic: AM6PR04MB5976:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5976CD79A5B7B51316774539F63C9@AM6PR04MB5976.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQJNemT+XzDq8JUV3nDnbKvDouzytxEQ8bv4I7EmL75b5BZGmP/Q9Z3nLFnxBNMueNvVNfL8TNB87meYKQwcMpKKQEYcbUauBi1bEjdXGbZ/Ym0iuoEfxRUGOKuiJm/1tCnP6sgKZ4MAcnAAKmDOjF5AWWxYciA1WUCMK8Et57JQyAqIpBSvyYtWw7U5RbngEGmXpBut0AvpjuGg7yBDCbrvWnSO8sqcUYAiXWneE6UAsmcbvOEYKcKnK8XFV0uBXAPSBwEynpoeXqB/DwO/INstN42PMOmKFn803aYhdVXHfr1Y48TJBAE1sdwbeI85KgPcucN5zcjcXY0aXKpN5HkfwhXSHQxd471Rv23uRLax78rQeAOMr5zjfmspd2xi0Bnr+eoiSAPC4/RYxMuCjnfUAVNtoBwIAu3SoM5t0zemrX48sLb0OLSNwvfK/pndYwIaPpI26S/+TsfeyRZuvhp37+eEqNL0wnO3+MbeqsXEywywGRsMVI02OAoq0oUyQ4Q4snxa0FjdZu2A/jBQ3jaxmi6rwoC4a/jDxeu6ZOyD+yr0YEziE/WmhSY3joNhh+c03V7kzGKP4OXLuw8qAgs0eJIMjJ8QxCu7uU1INWYveUNL3wmk9KHvM0Ol65E3A3zDVk4hw8e3EQR+WxIQ+wX8Q7SpSY4rdP2QLMwO8oAYdGcvf9qT3E3UHNSCgKGY4uAT8VavpRvSR/Afj2gsEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(508600001)(86362001)(6512007)(8936002)(7416002)(6486002)(9686003)(2906002)(83380400001)(316002)(5660300002)(44832011)(38350700002)(66946007)(8676002)(52116002)(53546011)(4326008)(38100700002)(6506007)(6666004)(26005)(66476007)(33716001)(6862004)(186003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0BfZseABsiFeAWA6j9pPVg1dDpXwzoERBLwZLGuLxsfPwRYYp+oXiN5BdIFs?=
 =?us-ascii?Q?8YRBs+a/KmXrZEbvEhxLYh+Swz3ObECHwRWrFTUo9pG3Zhn+aBtgaFDLQ7x7?=
 =?us-ascii?Q?P/4p2li4c3lNR3T1bO+Hy/08w+jPjC4w92pOI8gd4RpW0RiswFy8i148SK4C?=
 =?us-ascii?Q?uBe6FiX71yN2Rm3Gx5g1eZHnZxrqaxfMjBUc3hDMPMKZ7Av1K4Arp8MKH9/Z?=
 =?us-ascii?Q?9QgsVn54zcgCN14D9Vl/ZNfifwLHcks7GZy7VQuAyu85WMOf1nYFEgtH9dHK?=
 =?us-ascii?Q?jg/tdbWDEpyDlfX9WE9jKTs1qZ7MZ3e4m7YI/eSWyyIbqn8oDkwqwv4xg7BL?=
 =?us-ascii?Q?OpY3XvkcvgaFEVtuEJT1e6hP82FA1JHpWLCJ4d07gz/ldmVx1DvI5miNsUs6?=
 =?us-ascii?Q?Y7Vmu+s8MrOlR7KbppPrLIlxjwqin/xCO1FFTpi8FetJzbWmZd0CQPWJEPep?=
 =?us-ascii?Q?O4K37QHXs6ykn+ZDFe35AvUJyh+jP9DxcepcN9uNnTUr5hrQrdfa6CPlbTZc?=
 =?us-ascii?Q?HnUTkkfhZqJlVnJ1OICspTNRa8xl6MtyR6ea67hdDRJxguCTSI+XWCDBEXxv?=
 =?us-ascii?Q?taMlzvhqq6M9/sN2IYcb6dAbEK03cpIdVAm2BItlyvlPoKIczvH1K4BMW0P4?=
 =?us-ascii?Q?+xti5QOlNChBmWwOxLYsO4b+gcFRVW1AKKUOuK+bSMmds2fLdetR49cgD2+w?=
 =?us-ascii?Q?X145pqMNbhcM73sAK6dsKVqPfktQ3pkmMtT6he7iKYMGtfCMe8rsY5zfX761?=
 =?us-ascii?Q?MJw/26qFlbJPFNa+FrlmrSL6y8iwqYYsyc18bNY9D1qV6LcRZ0EDwnkrgIYp?=
 =?us-ascii?Q?cNY1GwD7PTWasJ8vb1KsoGg8afap1pNriigTw9OG4eh2s9vvf6S56vg4sIIE?=
 =?us-ascii?Q?jXOf17TkwfvdhSYommVSG4cBWA2jsINlxJa2JE52wkV+pD2tuRMr8kbPDRyg?=
 =?us-ascii?Q?6d9Yw4/plSbQs9NWQgUAFGpK8CIU/VXteq7Kx3CTDmw0XKzjKEN7cqFTrmJO?=
 =?us-ascii?Q?sYCnLaJbvvbhSgdfU/Se59HXZV7y4vgxLkJ9/m0ifd4tRYaYKk690SYoHDj1?=
 =?us-ascii?Q?XnubLtJRAtTyBmGbLn4k+RlDdQw5d98viTspR2CmCMQ3dkmKbqpbN+jum/FX?=
 =?us-ascii?Q?PT5G9eQLIiKy9NPWdMdnSutTZDGUw7s1QN4q+8LefcHTDoI/3zVlAJJ6dVLK?=
 =?us-ascii?Q?Or9nO82coG01BNm2VuNBZKuKriUqXvxwtu2gbNfRrShd+IWiTVR+7Odpy3ak?=
 =?us-ascii?Q?hh8kt0B5n+h96poYefDm5M5cy7rA96t4A2Hl2US7W683EP7Iol1iefxYUoCq?=
 =?us-ascii?Q?yaVTrjWedePm48KOvkQMs1fbTYKBxVmgHQahWu+k6JWyD8MmjQVU0qQ8yGgI?=
 =?us-ascii?Q?3y0GsF3QPYjMAiJGc+dY+eRehL/iX4k5AbN1lyk5PE7DlAjOBpFv/QUL1kDR?=
 =?us-ascii?Q?8GGYs/gvojyHOY7GUJfPd40mV8OJjBIDlTIq82uNYKHRmYCE2/2vuPlM4hCD?=
 =?us-ascii?Q?0sSbDvjp/pHkh36b7M9fvkcMhd097fKJNrglA8mWpMqLz4EsY+PbqXC/vW46?=
 =?us-ascii?Q?hzbRLRJkTpHx3ESu+X7GAj61q0UDGnggiKlpnMz5Ry2x9K7xG2Bvbgs3BJ1A?=
 =?us-ascii?Q?tcd200ZfdNKzKVmSFsIlowc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24003a9e-d256-4aa0-f71e-08d9f6b91f25
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:42:00.3162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sX0fuJqQnFScV5oGxFZj8O4aPurnGs8TntfmS6qkFbo22+WHaRXaG/7t83wSCWpzbxncCb9nVE8Z9zkSjKx+SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-23 14:43:53, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V3:
>  Drop an error included header file in 5/5
> V2:
>  Split yaml binding and clock header
>  apply to Abel's tree
> 
> Add i.MX93 clk bindings and clk.

With the typo and the unused issues squashed in:

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

No need to resend.

> 
> Peng Fan (5):
>   dt-bindings: clock: Add imx93 clock support
>   dt-bindings: clock: add i.MX93 clock definition
>   clk: imx: add i.MX93 composite clk
>   clk: imx: support fracn gppll
>   clk: imx: add i.MX93 clk
> 
>  .../bindings/clock/imx93-clock.yaml           |  63 ++++
>  drivers/clk/imx/Kconfig                       |   6 +
>  drivers/clk/imx/Makefile                      |   4 +
>  drivers/clk/imx/clk-composite-93.c            |  93 +++++
>  drivers/clk/imx/clk-fracn-gppll.c             | 328 +++++++++++++++++
>  drivers/clk/imx/clk-imx93.c                   | 338 ++++++++++++++++++
>  drivers/clk/imx/clk.h                         |  30 ++
>  include/dt-bindings/clock/imx93-clock.h       | 200 +++++++++++
>  8 files changed, 1062 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
>  create mode 100644 drivers/clk/imx/clk-composite-93.c
>  create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
>  create mode 100644 drivers/clk/imx/clk-imx93.c
>  create mode 100644 include/dt-bindings/clock/imx93-clock.h
> 
> -- 
> 2.25.1
>
