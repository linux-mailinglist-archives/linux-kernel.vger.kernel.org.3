Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DA64CD079
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiCDIvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiCDIvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:51:09 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6FC19DE90;
        Fri,  4 Mar 2022 00:50:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC84Nrv2srGvDi/hpE5IxSTUE1NTfu/9Hp+gEzjQfjyGfgRc4s0EZ2OAEPpa0KlElGr1qv/Umdm+QECHyWQOHQTS7I4AkxAHjZx192hpaSr7WTf057m++GA6xoUMwmazOV+8qcUBcHz2Ma8QtToZ6r7Nm7lyByLMbgSfV+5h7k5Z+7xoBeBJmYJxvQ0xDjAdOP3vdSLGFpbnujksZJFyJCyXqZLi3cAoyEl0tKkVbkmWn+ZcfHI74wz1W5TtguTFKOlubuk8N3cX0uj1mObXeyybWQI0Gkz+CvmQUv79Kbfu0GxpSTctvPUsaQu1Q+bV4/l53p9G8DPZaiKe2xIK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uh5FbP5JPRQ9ABBCPRnT+Ubi9YKw0FlYcW4W/lDQdeQ=;
 b=GoqhMP6K0s2q9eD5m0yUGGzM13zn8ZiSm88FotdeEjZZ1ZmZt+yBoPvZrpvgpQ1e36UyFva2vVq61hSiP64DdlGXn94rrhCD03tcPOa7E1M9wHJDLGJUUftk3sL0z8hCrjmwuSRwmwTA1366DP2qJmALC7GIpBF8yvlHF1jFuNh2qoh64EQrEp3cJuWxLyVU4D6ije6kfXa62QhP7pYVRw8830WiI15G4Afn6gbHM+iNTHqOIxaeWwRk31FldDzosAGlnHC0B60F8ZT0JUp+erS0xC591r/+M1EFvKmAg9+x23ZKEJbq8vwW9pwuTn5rZncwDqXA1Sn4CxzF4shHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh5FbP5JPRQ9ABBCPRnT+Ubi9YKw0FlYcW4W/lDQdeQ=;
 b=PfVY5WWcRaS+RmM8iqayuo4INYZmLUihES7nL9M1M9sPiGK/h0pouEgNZQVUDjAXsdayOUTLlNUq2cMkR3nbPJuInrWYq93R80c41apxWRWgHHeZhIt54VjTZ1lFRitVUfEp8Ji7Z9I/UQpPiYEkjtMonj9mzSUZH3+IhY3wOfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM0PR04MB5842.eurprd04.prod.outlook.com (2603:10a6:208:125::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 4 Mar
 2022 08:50:18 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e%5]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 08:50:18 +0000
Date:   Fri, 4 Mar 2022 10:50:16 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] clk: imx8m: remote sys pll1/2 clk gates
Message-ID: <YiHSyD1L4CoMW6tO@abelvesa>
References: <20220225081733.2294166-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225081733.2294166-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1P18901CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::24) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bd0264a-3f6e-4d76-9e12-08d9fdbc0268
X-MS-TrafficTypeDiagnostic: AM0PR04MB5842:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB58427D09757151AB536B0B1EF6059@AM0PR04MB5842.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jc3w0gANMFHhSBFW+VtrlYokeTuRCEHgVZgPWbVpyy6gf+Dr45ESzsi3KrsowGEPbd2VM/UEpB+0VlH9dMJ6zY2CIuCfy803R4OMwBGTqIOPX6TC8TL30BZ2jd8oYgVydG4knadcnuzLlUFExi4/v038l8/FfLPH2nED/e8D9p82X1h+Fd6gnEJ0c0lU7flbhjg3vslXosueZVwV0xmJcftY3xewbC2UWhedKnJrlg2Z2AXbCh8FC81I9JPRLoMOVKN3Ai46mrI1hbnJRSzht8qv7mYtvuOXsNb62P8Cw7yssOoYy9cDOK4C9kwCtivrtB6aSRWkL+Br7x9674kTmlY5zbxLXA0MdE4oC4mlCkvnTVPkf6IZn6HqETmCzuSqYm+UsfmA9+QfDMveVhbvz3/ZyWT8KUQ0gZU4pwXHwiprTKQGcVq04BVCab5Oj1htgP8auBu1lj7LUeePcv8LNGvlBeCpiRv/e2YMhA4KINHDiOA9WUgqTa12ZEoB9OGVKEJ94DWD1Y0KNbsHq0vnLO9fosJTMREoLkvJcVGqijG/cL4JpMuqJUK2E6nmbWlgHvs8gBdSs6D0wU+DgINT0YidmuFoGcJ1ieKnIE8V1sqrsyvYRtL38NglEBjEgozX1RgFFWBfDaiqi5AoCgNX83UxfT5v0gEMS7qkaXbyeSlo3rZxFy7RH/nYJ2SOywKU0BdLLcwNh+43SePz96LyshBdIhHH2blD3lSdaO0w5Q4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(186003)(26005)(2906002)(83380400001)(33716001)(6862004)(498600001)(86362001)(4326008)(4744005)(7416002)(8936002)(38100700002)(44832011)(52116002)(53546011)(6512007)(9686003)(6506007)(38350700002)(8676002)(66476007)(66556008)(66946007)(6486002)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P+kRdDaRzUHY6gySAZ/CAuEQSq1qmF1dEYFRl3AI3qfrIYYuo2uLig6xD7Ro?=
 =?us-ascii?Q?nQZoM4HEw4TGiyHtvSd1YYrX96D2DMwj6hMcO+s3YFPnNTa3Pzm/u9l3wMQB?=
 =?us-ascii?Q?G+aybQZagBgKB5UffjzmEK7UaWTNHKKTIkD2EmE4yJn9Xz9Ke5isk/EG/iW5?=
 =?us-ascii?Q?/uBOEARhT0H/wkCFAcrGPaX7KopinffuHe8xx4a1FJZK6wgC6stvcyelLiFp?=
 =?us-ascii?Q?Sda/lNRbS+BdTnpxYlm40xclTdt+W/YdXJNmDVdxSs7S9VOws5mrBWURFX0T?=
 =?us-ascii?Q?pNmS/u4ftqkGXs8uBMoMxbZo49zgsql5jJ8n7KooyHCyT5kqsxf5Ryda1o4U?=
 =?us-ascii?Q?txjNY/3fqyK5yamOEWY5BqQ9fmkOTUQhFWZYZggNpz7+OSor9poJhFDtVsRC?=
 =?us-ascii?Q?fnIEdvIU3cYYdanLaE43ZjvS7rEm0mqNWw8k3nH99UcugprWgugwQR9S16T9?=
 =?us-ascii?Q?Uyx7XPiIP5951VaPNuAldGbUFivVVMNhqzv1epVcHLASjG45eElOMp1MCs18?=
 =?us-ascii?Q?Q/CU2AkACH86dh2lYfqdlt9n6RKRdPEAyc8mIRMNJWIa3bsaCwtwPvLAthYW?=
 =?us-ascii?Q?8yd4aBHM08UpbTHq1W5QfGF9iYf6sZRgk9QzHeSgq7VGdSofURP1FWUddV0x?=
 =?us-ascii?Q?6bbC4qnaxyyu+ZRH++Z3du0uLaDSL8y+WwzJoSMxt92hPHYsL0fJRxizOVcD?=
 =?us-ascii?Q?wtdyHDQ9mkMQZBdDQkbYZowofuARy1m4UHReKbmW3/6JpQTF1f6JxKt9uvg+?=
 =?us-ascii?Q?AiQ0gqfER8FElwGyqNzr5vhr50sHgFP5rtnCXmvo9V4XArj4pz6uT1b6oyrE?=
 =?us-ascii?Q?3UmCW0xbGYB1VA5WC0cn+hmanGvzxSHzisiJeHhXfOymv4Mk64+z0ZguUOS/?=
 =?us-ascii?Q?tVIJgZNuZdrpeQS+zjudChfiu/aTDGROE2Ib4hCUmPEMLHCwtxFvl8dgmdbt?=
 =?us-ascii?Q?2n3fyT5qgM7Njv4Y2a0KutEVtQqBx3sC6iDWAJ5g7a0HxX2AAncbyQ3O1S2W?=
 =?us-ascii?Q?Bc2si9wxuLMPoKG2LgYrKk2FeC9vmJo27KqtfM+RWhQ2f2cQGMb7EZKJrZzm?=
 =?us-ascii?Q?4iYEmCKvmUkg6t1MIMkfqbQu7R0jxTk470yAQ6CzX3xqoUfer5r6atI2NJbb?=
 =?us-ascii?Q?3NfSZZaSQEMcgcjXV3aAt27jHSHrSvoVPjX9UWRY2LmV5gEHOxXt26gffsn6?=
 =?us-ascii?Q?qGtF7Ea4rvNsKoJpjlFd46bGtlrBh+JI/qLMC1hCMK+v1hiJ/2/74W8VGg4q?=
 =?us-ascii?Q?zwadQQ8BIFAV/D7wHwTl/VQ/Y6wLoRRHhigoKNfYLDIZb1lGgg1xAXJlCEOk?=
 =?us-ascii?Q?5bdoPBd5eEo4EZXNqIAEYfs+jWUKvTJ+XkuEeE57zski6vy6u2L47XMiCYsx?=
 =?us-ascii?Q?AO+1ke5qXALZHFDshmOBTeRE2Khz6nHIsK/cE+yFfIbw/UbTolb9f1kBTqYJ?=
 =?us-ascii?Q?0ZyFSKx2Pq79fan5IxSLxlIGWgvs4tjSu2nqXqjXyuaSKMP6X0Q0Fx547mlY?=
 =?us-ascii?Q?AbKMbjVKr3TdjU+LMvbxxWmqOMCT91fPf8kkw5+214WyU0UL9em7qAyLECFm?=
 =?us-ascii?Q?IPWitSfa3zqIgZZf/LN8XYqglrdAbBsXuTu32hciRRzOE/1Tt6TfrMxcX2DM?=
 =?us-ascii?Q?vNfIMIq/W/nmV+ZI98xYewk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd0264a-3f6e-4d76-9e12-08d9fdbc0268
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 08:50:18.6975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vy5hmPY1q038kNVg70znL74WpldhT3foqeSWs3JlPbpYRzUdZD6j4f1Eycy0smcBSgSXD2wKBxaUSyMPmwSxVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5842
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-25 16:17:30, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 

Applied, thanks!

> Same to commit c586f53ae159c6c("clk: imx8mq: remove SYS PLL 1/2 clock gates"),
> This patchset is to remove the pll gate, but still keep the pll out gate
> following NXP vendor tree.
> 
> Peng Fan (3):
>   clk: imx8mm: remove SYS PLL 1/2 clock gates
>   clk: imx8mn: remove SYS PLL 1/2 clock gates
>   clk: imx8mp: remove SYS PLL 1/2 clock gates
> 
>  drivers/clk/imx/clk-imx8mm.c | 49 ++++++++++++-----------------------
>  drivers/clk/imx/clk-imx8mn.c | 50 ++++++++++++------------------------
>  drivers/clk/imx/clk-imx8mp.c | 48 ++++++++++++----------------------
>  3 files changed, 48 insertions(+), 99 deletions(-)
> 
> -- 
> 2.25.1
>
