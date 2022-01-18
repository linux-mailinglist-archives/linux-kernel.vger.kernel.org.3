Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2787F4923AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiARKSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:18:24 -0500
Received: from mail-vi1eur05on2051.outbound.protection.outlook.com ([40.107.21.51]:41824
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237058AbiARKSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:18:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSOD8FagscQkFKlxbdQYa5k+b3AUJ56LWyATI1cXIx4A6QK5xG7VoIJI5En9yPKE5B7DexZq222PufUm+NfT7CcCXnecrLaawASZIB3YVOoPZ4eL4iqG2pnc09/CuxGlsPnBeBjmYOn9p3DYADY9fIMfBheqrEhYv061GQKaYkIhCzqr3rxuKt2P2FStY7GsmwMesi1ZAkqAAH/o/lcw2zObqRDdRPnVjiFYnycuaOQcQLUtxpz1u8PfRK3XPTfdgaQy5wz+WOEWXK5sdC3kEal7N6c2qyAZNABUNZbWUqhoPLyHqyfXUerrSqgPaK9zMdbRL5+p6dECSXEfEveilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6Y7yGr1MRavTFOLtQjM5yLODpwv+FhUtRqK4+95bPo=;
 b=CicMTJ+LryRLs+0vHIgAb9A9U13Kr84fyC3gVn0EAA+zvl87aPuVYkA1YT7AjdaEx2yAUOJDg/P0x6BJxB6FdqbJIaYnsfr3qpy+nHA0v1oe7ooN/rlxEQpLd6nSLfJKEthyt+ipyuZCfd9t4y6pEs+SMe31LiT1alS3m+V3MgKmvxV0PLCASjFod177iMd6J57ShhHDPPQce+DCKE0Z6ZeGtRPAP+ADwwQs59f7AUkVBPchtSZlct6Q3oK2+FyVj9Ts+q8fdTybRTomDhN1+YuvGUPW1/NmaYDpzIKsU1fAujZgASIyb2SXsokmkt9FyxHzMS69/Q7Hg3505lIFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6Y7yGr1MRavTFOLtQjM5yLODpwv+FhUtRqK4+95bPo=;
 b=Twf6XhBgwjT/OcTfxypl/yAW5dztHo6FYECaR3XNB69kBu6UnLeSer827NW6gz7YnnZ8UQNHU1lxu1uSpGsA2tjeIKRVVNmdOuCDNlGTOFNqzcSalZ2DhGFO6a1KkBaNxAhH/1IyPaia7tOKwnLY3qFtKMoat4+xIPu3taA2ClQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM0PR04MB4611.eurprd04.prod.outlook.com (2603:10a6:208:71::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 10:18:20 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 10:18:19 +0000
Date:   Tue, 18 Jan 2022 12:18:18 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH] clk: imx: Add imx8dxl clk driver
Message-ID: <YeaT6pGCo2wUGEFf@abelvesa>
References: <1636567000-24145-1-git-send-email-abel.vesa@nxp.com>
 <20211216185024.7DE53C36AE2@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216185024.7DE53C36AE2@smtp.kernel.org>
X-ClientProxiedBy: VI1PR08CA0250.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::23) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c7ee4a3-94a2-48bd-7a40-08d9da6bd98f
X-MS-TrafficTypeDiagnostic: AM0PR04MB4611:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB46116B5585E7F119E25B5E70F6589@AM0PR04MB4611.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAq4H/mZzLQvz1/aHaOOxFti1xtmArDminLHZ5u9OhlePQnEAIIKE+BaVwMDJS2kd+Rq+JYy6Z6hRU089eurJAjd4sGNRehJCK6RB2YtJOeIMhopr0OI3S8qvBE5efd/9Q3QWDUOPShocpEQsyo2yAbmekTyqARNr2/4/dWi18283PrRHYIivpEU2Bu/cNIWqVgSLNbhLmkUW3r3pJRynXBJBqoXuHIIsdt9jj1ZxHMUSur693wCqypRNIKeOdsswAdmeg68cibAyIorHiLmY/HY+19cjiyT+tnw1nmbV9P4DgFzE/mGdUejKfNw7hIh82WC+bAqG1+zpiHx0Fi525no0kFCs19pL2U5hi9v0TQIShrJwuZ3Mp57al5ABoSvEtIf4E7e/NqwVMCwXsm/973FliTdKXKQM3oF/vXk+8oGBj8BXti6MbYDnQqpAa4d2nfd0NuS3p3r6On31fynXHioo53JvjtmP9ZS0YCOi89+COa6Bo8POhWfmTsJP1hFJIFMiJj0KZHlImbQ1EgM7vS9q3mBcSfm2rnltfnT2/OcdeJfvkVdpyEbV6OfHtI0jTR0TdXH18wvUHeEffuFggTM7sGJbg135ZRKABXiizNE2HpbhAHZz22k3me4PIFxfR5ZQRPBsD4Gep1/oY2qoHthZXpdJMk66BPqg3/gH4PUJZLRI86xstD+5zF0fTRXzqg9gDO8Te39DcHymPxBq20o5SN+vwuQMdA4j9WfLeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(8676002)(6512007)(66946007)(53546011)(66476007)(66556008)(186003)(26005)(8936002)(6916009)(33716001)(38350700002)(9686003)(38100700002)(4326008)(6506007)(316002)(508600001)(44832011)(52116002)(4001150100001)(6486002)(86362001)(5660300002)(4744005)(2906002)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+fNHXbgxY6oMG2hTO3P1ChR+LXX9AEYB7UzOLEUhgFvcxpS41QyYoQpYQsgO?=
 =?us-ascii?Q?6qR3TypUdB9l6cgvrXMLVY5IrVPzBHsIatH8QgIcNrNWMRzQxSDdxKW3iWKB?=
 =?us-ascii?Q?qSuJwOjmOhf7yg3YuBmkFT5494ZVqAKBNdiVZfentLSWojVo0aAE4YKjEQ3/?=
 =?us-ascii?Q?gBN5myn/K1DOSVoiQTb3syuxAyTgmQrsRJkPrkKqSZd7O7GIDG0IAqMmz7T7?=
 =?us-ascii?Q?EEGb+AQn4RoGsKYvaKi7xyzdt/X8xCyQ8xovKDQEcA24Iuap6G4nfDAE6CSF?=
 =?us-ascii?Q?UvtUs53FNl7I3blqvu7IVJkbJl9B4qXmQynZ1HgZer2xdQfEkDEpRZYE85YO?=
 =?us-ascii?Q?L001n2+nNrRsboQaDyX9ygB9CtF5xGI6Vqg/Gt5I1UTz0q2kGERve235izP+?=
 =?us-ascii?Q?b5DyMxl/d3w+HinEylfPQdOda8gSx4+JBr0OH2edTI/0arwenkEcyLvExyfJ?=
 =?us-ascii?Q?4SJW3wTkiGX2IdOo77DxZm2XRrL/TPD5YvC/zrAqBhblkZ4H+Kg5qxmr7M9v?=
 =?us-ascii?Q?fsR2wI8O3UEU91qCh6O/FhEBLKbQJbnG/RtGB9P5pSpZcZ2TmdMnfrycNrWd?=
 =?us-ascii?Q?/Qas7/wFimQiEGs72u5sc4j9bn6Bj1gJR/UQKl0+pwobo9AE2MpVOR6Hbtnt?=
 =?us-ascii?Q?qPBfK0VfsXs74SFYZD/ALXdT9tFaFhjTLWzrREwIdoju2EoFSZE4ZKfQGkou?=
 =?us-ascii?Q?a3cF0UI9kmklzSXMvdGVz0qWZeSLwf8sqUp5K01tdWLa4015UZOfvLjrzBc2?=
 =?us-ascii?Q?UzlTH3ZkY4PRIi+zLkHM8aWzkSxFunH5pgJgHbFF35gDvviNu9Vw9PARrph/?=
 =?us-ascii?Q?qoOf2crPbSv7Od5ODurfG7YWc8AiUuVmlf2y5Qm1zw6ZIeKKXCsuQHtmYAt2?=
 =?us-ascii?Q?qdERGSKu5+T2ukTG1a6aZezNgBXaWblyWmxYuVeJ4WbVwwGWgzZsOWzd46vS?=
 =?us-ascii?Q?SLQ1pDdWEAuypP+nB2lFAf2uJunxw9+OKTc2dQIs+pPjtX5Pld0w7CzLGFrD?=
 =?us-ascii?Q?GrCsWs7Ar2OAYEGKftIs4m2moffqAvjbCsQjYvHXXgj65RzgbBe/LHUcuksV?=
 =?us-ascii?Q?cJ6rX9J9VSPWJXTRzCfoS7swmxUb2Zavwb7PZ+fNgMUygjQrnI+Ej7oq6LBs?=
 =?us-ascii?Q?LVo1jRcGdpTJuotNHL59dN0afBZZmgAofSkQhFtecxfBgw6Dhv++PP7LK7qo?=
 =?us-ascii?Q?DQyTNRaxSXXYfdYy/dzj3zGXeDjgha1i1EcmmbPs3eo4UdyehOXYBr5RdE3p?=
 =?us-ascii?Q?ZebJyQko1trzkOt7VQWkc2iLnuIW80/7SCIiRGrWa+NCjzi19fYIrNL2ik+k?=
 =?us-ascii?Q?sEyJuvlhGk9Mep7ZKL+VgjrD8u4L33gs9t0juTFvRZdFanDLnk/cq/m6ORPL?=
 =?us-ascii?Q?A/0EiB/xFVb5zYDU67inVS9EjlqivmR/bb/mIfi2XWB8BN3DEmDsytDWzLuT?=
 =?us-ascii?Q?WP7pWCrJpgJex8LDXWNT5TL1PlAApnLM1eICayt0WaK9KAagi5YLj/wuyIH3?=
 =?us-ascii?Q?3Tg633uqxA/NjuaiQ5NTYngbGl+8wvwQ96qR8loqTs5ko86m9egSuIpL0Zan?=
 =?us-ascii?Q?DQwuS+oF+8ji8TRqbOeNgkLQvBKU8J0vRnPODeUKjqvAWIbNmZJ47Wd4s/j5?=
 =?us-ascii?Q?a5IO71ym1WTRsURjB6BB/qs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7ee4a3-94a2-48bd-7a40-08d9da6bd98f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 10:18:19.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: co3mQ1+qfQzrVyF8CMJcwfdWRLdxxmYa3vKTlzXoEuZXTHAMeyh1Uu+8MBlqwnzzw75v5CHOrKQ/RuLOp7Skkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4611
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-16 10:50:23, Stephen Boyd wrote:
> Quoting Abel Vesa (2021-11-10 09:56:40)
> > diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
> > index c53a688d8ccc..7f4893706cc2 100644
> > --- a/drivers/clk/imx/clk-imx8qxp.c
> > +++ b/drivers/clk/imx/clk-imx8qxp.c
> > @@ -297,6 +297,7 @@ static const struct of_device_id imx8qxp_match[] = {
> >         { .compatible = "fsl,scu-clk", },
> >         { .compatible = "fsl,imx8qxp-clk", &imx_clk_scu_rsrc_imx8qxp, },
> >         { .compatible = "fsl,imx8qm-clk", &imx_clk_scu_rsrc_imx8qm, },
> > +       { .compatible = "fsl,imx8dxl-clk", &imx_clk_scu_rsrc_imx8dxl, },
> 
> Can you keep this sorted on compatible string? Then we don't have to
> worry about conflicts as much.
> 

Yep. Will resend.

> >         { /* sentinel */ }
> >  };
> >
