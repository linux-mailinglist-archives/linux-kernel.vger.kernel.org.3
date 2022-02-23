Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4194C10AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiBWKsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiBWKsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:48:22 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30089.outbound.protection.outlook.com [40.107.3.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2410D5A096;
        Wed, 23 Feb 2022 02:47:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYGmKEoIIA56TbjeUFaCUCIpzxfR6HhDyXbK6y32/KKC7RC+NZozjgsR9NX+3au9t83vfjrZ/W5gGj9GLtgA7U4b5RQ5MN6E8hgvmZSasojKtqsrgy9q566QWLyf+CzIgl+ouI3a4FEJzoveqdRNe12TMvbswIBvzU0ppU9ydqnUezfiTqsc+Fg+6drxyxUfj7r2Pek6T+OdBWanbmCcLstGbFiT8uj3pV1GDWrdJC8ZsU+M0kO1vzhH6zk6z1UuPMS4YyFaockFJuIYa7vpm4QCTtv8RB2XzBc82mK73XDl4qlTOUHXvkdwPLkO0S4FmjJCR5+5Qnknp8f/N6hArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KQzQtd6fQqPFvDOmKrMMU1j3A8taRshVE9UFocgvQU=;
 b=LIZEnHpPv4KBD/v+FYDrJ/ResziV7z8tYvSNMe9aW+g8dVBmenELtDVZaxuXtADKCzW95aRqxi47w1LqO7QOeRW/fsCnzOHHfnx+jWIS92xTSN+r+LjYG/a1LZpf0W8JXK3aGsfVU3G4QmPSTvK6HPv5y6pl2r3la+ESMLKH5WKPtw4RF+Vttie/SveUZk3HAWvPNBtIJGz7+onR/sfnRLFY85ZamKthcZdEJrGKDKPOJ6IuCTzFEPJq4lldrBypr4sWhKWHl3wo3RIKN/ribUdrVJ1oiCpFs1JJsoix1IsFLUKMDgAxAw2NtDBUoN8ozBUvxsAPB5+KSh4DNAIG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KQzQtd6fQqPFvDOmKrMMU1j3A8taRshVE9UFocgvQU=;
 b=h9lYQAcJJI2Un5SWn9Wh9WhgCffHz53jobcKh85DkKWB2gqH1Zc+X1ulFRv9AKw9PX2VdYrX7H6N3JRsCOunnyTo7eXwrjjbBYKlwvQjYEx65c4K9a5YTYXDupuFV/LMKjnnUtPy8qXEMGAIDv9f9nKWMWjBOcmsvvO2mu2DLYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DB6PR04MB2999.eurprd04.prod.outlook.com (2603:10a6:6:5::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Wed, 23 Feb 2022 10:47:50 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f%6]) with mapi id 15.20.4995.026; Wed, 23 Feb 2022
 10:47:49 +0000
Date:   Wed, 23 Feb 2022 12:47:46 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 4/5] clk: imx: support fracn gppll
Message-ID: <YhYQ0slgZICJBHo6@abelvesa>
References: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
 <20220223064358.4097307-5-peng.fan@oss.nxp.com>
 <20220223104308.GI22780@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220223104308.GI22780@pengutronix.de>
X-ClientProxiedBy: VI1PR08CA0108.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::34) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea454984-920f-4deb-5dce-08d9f6b9ef41
X-MS-TrafficTypeDiagnostic: DB6PR04MB2999:EE_
X-Microsoft-Antispam-PRVS: <DB6PR04MB29994427F295E2B9C8338640F63C9@DB6PR04MB2999.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gf05tNuB1XwFILeMtNphvQJ+3n23pjcRE4ry8BGL3M7i6gLTOY5yevEr2ZvGxToLvWcEmPRvo2JGfpQnpUOSAeLokcnuSumdEcTX7fJHmVt6sGvksZC4P3i2qOkLpki9C3SAMy+//62CiC+qULZkiXp2UKhLIRYsE+79rHLLcCfPFR/4n+Ssytqt/eUHpDbQMdDZlPpNCpxavcPDOxUg+eJceUatCP1DGVEZvTJoCX4P1CSYY5VsUOO/QkumHD/DXN4RtIHo4pH30Xvf33MviLsce3r+Pq61Z41Z3zeUrCL8FzjwAm0L8C/1QXLmtWZIWBrDrraP/4e/XmP0W/RadV/ZKcbjIFuTZIVjNOGRaA+mxS5sg93yf6wfOzOXYfwnsvHjltr5uKzA13cgAkvkz/TmqI23PWfiOBQtom2Nh3oZ9erMCfUVdkMHiqZMRPIp9NJnPxR0Uou5/caNqhoUeLjMpZVJKhta2D3MTJN786i7ryscD1VCoLGFnATXgkEV/PoWV+Kw2ZIjU2deH0fDrsD7hJONM9X0iGcK21i8ia2t5zd8HcP25CprrZYioHlBz/2oS7YmkGwKgDrTBAf0/xfoYyTrl+1+Lre3n0kkcWfA42XGMyvlV+cOsqGTta2MLO8N8zlA+OjRcpl2KLS7qrmjaL3wuVZ2sOV1O+Bv1JkVtMnoL7Y7jCsvcwHpwE8z0XTOmELEWH22HRpIwX4sfXgsnJ8rNjxunqvKRlmzYi1gGxAMvK8k8zhUnnlx3Xk58lKL2y2Tu9F9g/4tDhaWcsxdLG7ingLrBUGEujk0Pbiyn9Vkm4RxOtS7d2LIn6CSl7IIyJPZE++cBmQ65k7Pagu9uB2owuTBlvzIiulrplc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(83380400001)(8936002)(966005)(6486002)(6916009)(53546011)(7416002)(6506007)(316002)(38100700002)(52116002)(38350700002)(2906002)(26005)(186003)(33716001)(30864003)(44832011)(8676002)(66556008)(66476007)(66946007)(86362001)(54906003)(4326008)(5660300002)(9686003)(6512007)(508600001)(6666004)(56820400005)(54580400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUk4OVpzSFhsam1SL2JRdWw4ZEVVWWlwZ2c2cDNoVU1zeWJHQWVUMFJzTFNF?=
 =?utf-8?B?eDErWFkrd2hyeURpSElsbjk1S1R1aFlDaFpoNlRocjU1RVh6eGJoTWJHaG44?=
 =?utf-8?B?RUorSmZaM2puV3ZKRklDb0s4WWJkMW85YzhTOWh5RVNtNzYxZGVyZWFtelUw?=
 =?utf-8?B?Zm5RZnd6TG1ZNTNUV25NeVV2Nm84cnl0bTdudTA4WG9tRDk5eHFqSjVhWGhq?=
 =?utf-8?B?UG9YcnFLeFZzV1FCbHNyR1kyM0hiWWF2T2E5UFMyd1Q3bjZlUTgxRHFqZzZX?=
 =?utf-8?B?cWtLSmJreWZaMnZPMlVVMHlFN0N2SXAwZnFwMmJlb2VGWFRIS3llelY3SkZE?=
 =?utf-8?B?NjFBYzNxaThrUnl5T0NtcmZkcHM1aUk2ZDBnb3dNNmxSN0FOODdicTFJVzN0?=
 =?utf-8?B?QXVNam5kZHFYUlFGUkpkSFJDbzFDT2lpRWptMFpDaUdNOUZSS0RFbyszdU92?=
 =?utf-8?B?R2t6N0lQUHZxeU5qVGlneEpXWjhHZWVBOFlMeXZiMUJudmpidnV0d0xBbEVx?=
 =?utf-8?B?ekcrb0kvdnhRY3pVR0N0Q21KdXQycUR0ZTdJd2NoazVhS1RTdGJhcFRwdmJR?=
 =?utf-8?B?YThSVFRvR1NJT2FBSTJtd1FITmt4WVE0OG41bEdJT1BITkZKN0pBWk1xcDdP?=
 =?utf-8?B?VldmMi9EblJQaTM3UFNQRWVtK1RUb0Y3dHVUbnNRNmowbWFTSzhGdHVQSWhm?=
 =?utf-8?B?aTBieWZVNFUvTFpvRU1WVWFHOWdaWEcrNUFFaWFVSnVIUW5OUjRLNG5sbVlq?=
 =?utf-8?B?SmJ4eFMreGdGWllQcG9IYUkrOXhidTlZRTNXNGE4M25VOXVxeDNUMTJBK2VE?=
 =?utf-8?B?bVFHR0lGRUxoVjI0TmRES3dVT29OQzZEejZpckFIakEyLy9ndkZ6bGwzS3Ri?=
 =?utf-8?B?OWE3cjUyaTVhY3lFc2IxNC9waXN5UzNlQzBoMGVPUnNEM1NLNUxNbE9ESk5h?=
 =?utf-8?B?eVJGN2tjblhvSVU2YUM1Vlg1OWVjUmNWTkpyYklOMWJNRXUwazlHdEduWS9n?=
 =?utf-8?B?dmRoRHJzUWZHbDAvZnA2TkN0Q2ZNYk1RM0Y5amx5eDQ0aEZBQlFJamlyWGtL?=
 =?utf-8?B?SW9SeTF5aFJDb1o2ODZzQUluNHRJN3NjbE1FSmFvNWMxOWNHRHM4cFhjMnRL?=
 =?utf-8?B?ZE8zRndBYUM1cm1seGpNZVVDR3FkZTFFRXI2MnVIUFpNbjM3SitJUVlyRllS?=
 =?utf-8?B?dWZUT1dVTlNwMlFkeWRPcWtvS3hZMHUxWmxzRm5XREZsTnJiU3BRNi9vNVBi?=
 =?utf-8?B?bkhEOFRBS1NOMEpWdHdMenIrSFY1MEl2bDRzWnV4SFFacHExbDNFMmJPdTE4?=
 =?utf-8?B?MVBGSHdOc04wdnJIekpkbWN3dWF1MTJVS3YwY1c1bm9NSHVXVDV6SmpITlZw?=
 =?utf-8?B?TmRTbXN4WDZra2UvM0dTdXpIVEhJSklDcEFmQ096dmNocGZMQnMwcXJFOGhQ?=
 =?utf-8?B?WmoyWnk0Q3IyUTZwZW45UDlDR3hoY0tNWFAxVXphMnVUOW95LzFZTnV6UVcv?=
 =?utf-8?B?NE9uTkl0NVJKeldZTTlBby9PbjgyYVI4cEV0TTNDUzdjeC9IRExGeWFsb1I2?=
 =?utf-8?B?ellMVm1RVG5UQ1I2dEZMOUFMM3ZzcUZJalgyVFZNWVJPdjVZUnZoSjdDNzBK?=
 =?utf-8?B?SldTOXY3UTRTc1ozMmNWakduQlM5cS9oTDZNNUp1YnNmVU5mdVZGcW4ydGoz?=
 =?utf-8?B?VnBHbVNiRXRJbmZhSXdrdmx5TGhZYjlTVGJSWWVLZlhZWDMvQVdtSGVEWnZ0?=
 =?utf-8?B?ZHRCaE5lci9FQTgyOVV6ZGlpRkFxR3lhbThRc2ZBc1FINU5sTjhqMEVSRmFr?=
 =?utf-8?B?SnFYQXgvQ0VkZ2FZT2gzQUVkOXVjc2VieGVHbzloQzMvZGFtRHRoRjN3VVRB?=
 =?utf-8?B?eHVlUCtQZFRQdFRtcm9DM1RtSzE3L2xpTWRFeTZzdjcxTFYvaG1yWXR5aFVX?=
 =?utf-8?B?S05tdWJWN1B3MVZUTVdGUXBPZXc3YzJPMG16NDljZkQ5a0Yzc29yTEhoektm?=
 =?utf-8?B?QzNraVROdHFlNm5QWml5Mk45V3p1Y01IVFl6NkFmb1NIWlNqbHF0cjF0OFd3?=
 =?utf-8?B?MThXL1hPbFIzWVd5cEw1UWx0emdvNnFwa1ZZb2NFY0NqUjZFZHhiSFFIZmZO?=
 =?utf-8?B?VVBMZmg3MjBhU0R5M29KZi95WTdGSzdUY0ZTTGp4UFM3M2huVk03Wk12cG51?=
 =?utf-8?Q?3ZJOOWLWlJNZI89+RSCBpb4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea454984-920f-4deb-5dce-08d9f6b9ef41
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:47:49.4306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ga38uKFx8M3rZHNsEA1eQhbqLuDWohj3HXFa/9dmyT3vq0VrwyKcncgGy4K5Uw2XH8fgz2iBQazxIEyTAc9Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB2999
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-23 11:43:08, Sascha Hauer wrote:
> Hi,
> 
> Sorry for the late review, but this PLL seems to have some copy-pasted
> code I just cleaned up in another PLL, so I thought I have a closer
> look.
> 

Thanks for helping with the review, Sascha.

Peng, I'll wait for these comments to be addressed then.

> 
> On Wed, Feb 23, 2022 at 02:43:57PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > This PLL module is a Fractional-N synthesizer,
> > supporting 30-bit numerator and denominator. Numerator is a signed
> > number. It has feature to adjust fractional portion of feedback
> > divider dynamically. This fracn gppll is used in i.MX93.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/imx/Makefile          |   1 +
> >  drivers/clk/imx/clk-fracn-gppll.c | 328 ++++++++++++++++++++++++++++++
> >  drivers/clk/imx/clk.h             |  21 ++
> >  3 files changed, 350 insertions(+)
> >  create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
> > 
> > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> > index 36c04922d789..60c8a4bb7574 100644
> > --- a/drivers/clk/imx/Makefile
> > +++ b/drivers/clk/imx/Makefile
> > @@ -5,6 +5,7 @@ mxc-clk-objs += clk-busy.o
> >  mxc-clk-objs += clk-composite-7ulp.o
> >  mxc-clk-objs += clk-composite-8m.o
> >  mxc-clk-objs += clk-composite-93.o
> > +mxc-clk-objs += clk-fracn-gppll.o
> >  mxc-clk-objs += clk-cpu.o
> >  mxc-clk-objs += clk-divider-gate.o
> >  mxc-clk-objs += clk-fixup-div.o
> > diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
> > new file mode 100644
> > index 000000000000..6c9946a4bdb7
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-fracn-gppll.c
> > @@ -0,0 +1,328 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2021 NXP
> > + */
> > +
> > +#include <linux/bits.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/err.h>
> > +#include <linux/export.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/slab.h>
> > +#include <linux/jiffies.h>
> > +
> > +#include "clk.h"
> > +
> > +#define PLL_CTRL		0x0
> > +#define CLKMUX_BYPASS		BIT(2)
> > +#define CLKMUX_EN		BIT(1)
> > +#define POWERUP_MASK		BIT(0)
> > +
> > +#define PLL_ANA_PRG		0x10
> > +#define PLL_SPREAD_SPECTRUM	0x30
> > +
> > +#define PLL_NUMERATOR		0x40
> > +#define PLL_MFN_MASK		GENMASK(31, 2)
> > +#define PLL_MFN_SHIFT		2
> > +
> > +#define PLL_DENOMINATOR		0x50
> > +#define PLL_MFD_MASK		GENMASK(29, 0)
> > +
> > +#define PLL_DIV			0x60
> > +#define PLL_MFI_MASK		GENMASK(24, 16)
> > +#define PLL_MFI_SHIFT		16
> > +#define PLL_RDIV_MASK		GENMASK(15, 13)
> > +#define PLL_RDIV_SHIFT		13
> > +#define PLL_ODIV_MASK		GENMASK(7, 0)
> > +
> > +#define PLL_DFS_CTRL(x)		(0x70 + (x) * 0x10)
> > +
> > +#define PLL_STATUS		0xF0
> > +#define LOCK_STATUS		BIT(0)
> > +
> > +#define DFS_STATUS		0xF4
> > +
> > +#define LOCK_TIMEOUT_US		200
> > +
> > +#define PLL_FRACN_GP(_rate, _mfi, _mfn, _mfd, _rdiv, _odiv)	\
> > +	{							\
> > +		.rate	=	(_rate),			\
> > +		.mfi	=	(_mfi),				\
> > +		.mfn	=	(_mfn),				\
> > +		.mfd	=	(_mfd),				\
> > +		.rdiv	=	(_rdiv),			\
> > +		.odiv	=	(_odiv),			\
> > +	}
> > +
> > +struct clk_fracn_gppll {
> > +	struct clk_hw			hw;
> > +	void __iomem			*base;
> > +	const struct imx_fracn_gppll_rate_table *rate_table;
> > +	int rate_count;
> > +};
> > +
> > +#define to_clk_fracn_gppll(_hw) container_of(_hw, struct clk_fracn_gppll, hw)
> 
> Consider using a static inline function instead.
> 
> > +
> > +/*
> > + * Fvco = 𝐹𝑟𝑒𝑓∙(𝑀𝐹𝐼+𝑀𝐹𝑁/𝑀𝐹𝐷)
> > + * Fout = Fvco / (rdiv * odiv)
> > + */
> > +static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
> > +	PLL_FRACN_GP(650000000U, 81, 0, 0, 0, 3),
> > +	PLL_FRACN_GP(594000000U, 198, 0, 0, 0, 8),
> > +	PLL_FRACN_GP(560000000U, 70, 0, 0, 0, 3),
> > +	PLL_FRACN_GP(400000000U, 50, 0, 0, 0, 3),
> > +	PLL_FRACN_GP(393216000U, 81, 92, 100, 0, 5)
> > +};
> > +
> > +struct imx_fracn_gppll_clk imx_fracn_gppll = {
> > +	.rate_table = fracn_tbl,
> > +	.rate_count = ARRAY_SIZE(fracn_tbl),
> > +};
> > +EXPORT_SYMBOL_GPL(imx_fracn_gppll);
> > +
> > +static const struct imx_fracn_gppll_rate_table *
> > +imx_get_pll_settings(struct clk_fracn_gppll *pll, unsigned long rate)
> > +{
> > +	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
> > +	int i;
> > +
> > +	for (i = 0; i < pll->rate_count; i++)
> > +		if (rate == rate_table[i].rate)
> > +			return &rate_table[i];
> > +
> > +	return NULL;
> > +}
> > +
> > +static long clk_fracn_gppll_round_rate(struct clk_hw *hw, unsigned long rate,
> > +				       unsigned long *prate)
> > +{
> > +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> > +	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
> > +	int i;
> > +
> > +	/* Assumming rate_table is in descending order */
> 
> s/Assumming/Assuming/
> 
> > +	for (i = 0; i < pll->rate_count; i++)
> > +		if (rate >= rate_table[i].rate)
> > +			return rate_table[i].rate;
> > +
> > +	if (i == pll->rate_count)
> 
> This is always true when you're here,
> 
> > +		pr_err("Not able to round rate for %s: %lu\n", clk_hw_get_name(hw), rate);
> 
> but this message shouldn't be needed at all. When a rate is passed in
> here that is too low then the driver should silently round up to the
> lowest supported rate.
> 
> > +
> > +	/* return minimum supported value */
> > +	return rate_table[i - 1].rate;
> 
> IMO rate_table[pll->rate_count - 1].rate makes it clearer what is meant
> here.
> 
> > +}
> > +
> > +static unsigned long clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> > +{
> > +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> > +	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
> > +	u32 pll_numerator, pll_denominator, pll_div;
> > +	u32 mfi, mfn, mfd, rdiv, odiv;
> > +	u64 fvco = parent_rate;
> > +	long rate = 0;
> > +	int i;
> > +
> > +	pll_numerator = readl_relaxed(pll->base + PLL_NUMERATOR);
> > +	mfn = (pll_numerator & PLL_MFN_MASK) >> PLL_MFN_SHIFT;
> 
> Have a look at FIELD_GET/FIELD_PREP, it really makes setting and reading
> fields easier and nicer to look at.
> 
> > +
> > +	pll_denominator = readl_relaxed(pll->base + PLL_DENOMINATOR);
> > +	mfd = pll_denominator & PLL_MFD_MASK;
> > +
> > +	pll_div = readl_relaxed(pll->base + PLL_DIV);
> > +	mfi = (pll_div & PLL_MFI_MASK) >> PLL_MFI_SHIFT;
> > +
> > +	rdiv = (pll_div & PLL_RDIV_MASK) >> PLL_RDIV_SHIFT;
> > +	rdiv = rdiv + 1;
> > +	odiv = pll_div & PLL_ODIV_MASK;
> > +	switch (odiv) {
> > +	case 0:
> > +		odiv = 2;
> > +		break;
> > +	case 1:
> > +		odiv = 3;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	/*
> > +	 * Sometimes, the recalculated rate has deviation due to
> > +	 * the frac part. So find the accurate pll rate from the table
> > +	 * first, if no match rate in the table, use the rate calculated
> > +	 * from the equation below.
> > +	 */
> > +	for (i = 0; i < pll->rate_count; i++) {
> > +		if (rate_table[i].mfn == mfn && rate_table[i].mfi == mfi &&
> > +		    rate_table[i].mfd == mfd && rate_table[i].rdiv == rdiv &&
> > +		    rate_table[i].odiv == odiv)
> > +			rate = rate_table[i].rate;
> > +	}
> > +
> > +	/* Fvco = 𝐹𝑟𝑒𝑓∙(𝑀𝐹𝐼+𝑀𝐹𝑁/𝑀𝐹𝐷) */
> > +	fvco = fvco * mfi + fvco * mfn / mfd;
> > +
> > +	do_div(fvco, rdiv * odiv);
> > +
> > +	return rate ? (unsigned long) rate : (unsigned long)fvco;
> 
> You could bail out early here instead of calculating fvco which you then
> don't use.
> 
> > +}
> > +
> > +static int clk_fracn_gppll_wait_lock(struct clk_fracn_gppll *pll)
> > +{
> > +	u32 val;
> > +
> > +	return readl_poll_timeout(pll->base + PLL_STATUS, val,
> > +				  val & LOCK_STATUS, 0, LOCK_TIMEOUT_US);
> > +}
> > +
> > +static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
> > +				    unsigned long prate)
> > +{
> > +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> > +	const struct imx_fracn_gppll_rate_table *rate;
> > +	u32 tmp, pll_div, ana_mfn;
> > +	int ret;
> > +
> > +	rate = imx_get_pll_settings(pll, drate);
> > +	if (!rate) {
> > +		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
> > +			drate, clk_hw_get_name(hw));
> > +		return -EINVAL;
> > +	}
> 
> The core does a round_rate() before doing a set_rate(), so this should
> never happen. I think this can be dropped, in doubt the resulting NULL
> pointer deref provides enough developer information to debug this
> internal error.
> 
> > +
> > +	/* Disable output */
> > +	tmp = readl_relaxed(pll->base + PLL_CTRL);
> > +	tmp &= ~CLKMUX_EN;
> > +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> > +
> > +	/* Power Down */
> > +	tmp &= ~POWERUP_MASK;
> > +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> > +
> > +	/* Disable BYPASS */
> > +	tmp &= ~CLKMUX_BYPASS;
> > +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> > +
> > +	pll_div = (rate->rdiv << PLL_RDIV_SHIFT) | rate->odiv | (rate->mfi << PLL_MFI_SHIFT);
> > +	writel_relaxed(pll_div, pll->base + PLL_DIV);
> > +	writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
> > +	writel_relaxed(rate->mfn << PLL_MFN_SHIFT, pll->base + PLL_NUMERATOR);
> > +
> > +	/* Wait for 5us according to fracn mode pll doc */
> > +	udelay(5);
> > +
> > +	/* Enable Powerup */
> > +	tmp |= POWERUP_MASK;
> > +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> > +
> > +	/* Wait Lock*/
> 
> Nitpick: Space missing at end of comment.
> 
> > +	ret = clk_fracn_gppll_wait_lock(pll);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable output */
> > +	tmp |= CLKMUX_EN;
> > +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> > +
> > +	ana_mfn = (readl_relaxed(pll->base + PLL_STATUS) & PLL_MFN_MASK) >> PLL_MFN_SHIFT;
> > +
> > +	WARN(ana_mfn != rate->mfn, "ana_mfn != rate->mfn\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int clk_fracn_gppll_prepare(struct clk_hw *hw)
> > +{
> > +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> > +	u32 val;
> > +	int ret;
> > +
> > +	val = readl_relaxed(pll->base + PLL_CTRL);
> > +	if (val & POWERUP_MASK)
> > +		return 0;
> > +
> > +	val |= CLKMUX_BYPASS;
> > +	writel_relaxed(val, pll->base + PLL_CTRL);
> > +
> > +	val |= POWERUP_MASK;
> > +	writel_relaxed(val, pll->base + PLL_CTRL);
> > +
> > +	val |= CLKMUX_EN;
> > +	writel_relaxed(val, pll->base + PLL_CTRL);
> > +
> > +	ret = clk_fracn_gppll_wait_lock(pll);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val &= ~CLKMUX_BYPASS;
> > +	writel_relaxed(val, pll->base + PLL_CTRL);
> > +
> > +	return 0;
> > +}
> > +
> > +static int clk_fracn_gppll_is_prepared(struct clk_hw *hw)
> > +{
> > +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> > +	u32 val;
> > +
> > +	val = readl_relaxed(pll->base + PLL_CTRL);
> > +
> > +	return (val & POWERUP_MASK) ? 1 : 0;
> > +}
> > +
> > +static void clk_fracn_gppll_unprepare(struct clk_hw *hw)
> > +{
> > +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> > +	u32 val;
> > +
> > +	val = readl_relaxed(pll->base + PLL_CTRL);
> > +	val &= ~POWERUP_MASK;
> > +	writel_relaxed(val, pll->base + PLL_CTRL);
> > +}
> > +
> > +static const struct clk_ops clk_fracn_gppll_ops = {
> > +	.prepare	= clk_fracn_gppll_prepare,
> > +	.unprepare	= clk_fracn_gppll_unprepare,
> > +	.is_prepared	= clk_fracn_gppll_is_prepared,
> > +	.recalc_rate	= clk_fracn_gppll_recalc_rate,
> > +	.round_rate	= clk_fracn_gppll_round_rate,
> > +	.set_rate	= clk_fracn_gppll_set_rate,
> > +};
> > +
> > +struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
> > +				   const struct imx_fracn_gppll_clk *pll_clk)
> > +{
> > +	struct clk_fracn_gppll *pll;
> > +	struct clk_hw *hw;
> > +	struct clk_init_data init;
> > +	int ret;
> > +	u32 val;
> > +
> > +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> > +	if (!pll)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	init.name = name;
> > +	init.flags = pll_clk->flags;
> > +	init.parent_names = &parent_name;
> > +	init.num_parents = 1;
> > +	init.ops = &clk_fracn_gppll_ops;
> > +
> > +	pll->base = base;
> > +	pll->hw.init = &init;
> > +	pll->rate_table = pll_clk->rate_table;
> > +	pll->rate_count = pll_clk->rate_count;
> > +
> > +	hw = &pll->hw;
> > +
> > +	ret = clk_hw_register(NULL, hw);
> > +	if (ret) {
> > +		pr_err("%s: failed to register pll %s %d\n", __func__, name, ret);
> > +		kfree(pll);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	return hw;
> > +}
> > +EXPORT_SYMBOL_GPL(imx_clk_fracn_gppll);
> > diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> > index 63eb7c53b123..a7cbbcd1a3f4 100644
> > --- a/drivers/clk/imx/clk.h
> > +++ b/drivers/clk/imx/clk.h
> > @@ -72,6 +72,27 @@ extern struct imx_pll14xx_clk imx_1416x_pll;
> >  extern struct imx_pll14xx_clk imx_1443x_pll;
> >  extern struct imx_pll14xx_clk imx_1443x_dram_pll;
> >  
> > +/* NOTE: Rate table should be kept sorted in descending order. */
> > +struct imx_fracn_gppll_rate_table {
> > +	unsigned int rate;
> > +	unsigned int mfi;
> > +	unsigned int mfn;
> > +	unsigned int mfd;
> > +	unsigned int rdiv;
> > +	unsigned int odiv;
> > +};
> > +
> > +struct imx_fracn_gppll_clk {
> > +	const struct imx_fracn_gppll_rate_table *rate_table;
> > +	int rate_count;
> > +	int flags;
> > +};
> > +
> > +struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
> > +				   const struct imx_fracn_gppll_clk *pll_clk);
> > +
> > +extern struct imx_fracn_gppll_clk imx_fracn_gppll;
> > +
> >  #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
> >  	to_clk(imx_clk_hw_cpu(name, parent_name, div, mux, pll, step))
> >  
> > -- 
> > 2.25.1
> > 
> > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
