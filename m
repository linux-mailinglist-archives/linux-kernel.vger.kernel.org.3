Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFC44A029E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbiA1VV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:21:56 -0500
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:29262
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239231AbiA1VVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:21:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzNbj0s8DYDOkJ8+AgpZizmmgBjmHARFp+5EvsaucvZz+gji1HIPYlmusEfYWt1YOphY8yapWAFor43AGnoDf9h3IgRGkAnZpYt7G+WruYA0rH2w7Z6ZE6Ex/puNGW1PUK1TzrdiumRoHoCqSbi61+agApQJdOE9dQZ6OiRAihlPt/HfV7NWiqQ9b4zVp76BUntlLbnd9yVo6Sc8wM6MZHA+oyApv/3HnOmYutRmetuHOginoQUNUo6NClA8MD4hRS2eXzQwbBoyo54hbT4BxZhzC4CSiYBsVWykKRGkTWn5zzGwA8ptHM/KFUuHG3L8EzAPh9Do21KgRITZVdHwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttJ29mVURvzVzlKsA7Xw4d1pAvX7ovqqwAtbukzdlOk=;
 b=V5OwHe6dLbwgwmB4f4CTwuKvGm7TxYRIecDxfkroUISNKPiI5kugQQjvW8mM6zbnV/sWOGNYbZRyNx5SfovmML7J2LwaGEs69UEouzs6SfNj65Et2zH+XFC2KTEXLkTTAYoctln6l9oO/BNOzvbI/6JyVna9NBKUqys2qLuO0okYhbE/1uwAnnJpcEa1aRD1JO8jVWsYGG+HV7NY4yFLeJfKwO3MbFG1vWARKo6xTO7sViyDbW1VHlOynGP+qjGBJTzAG4fgw8yv7DEW+E9EeEHgTCaW9CEbxL0bCRYxz4GnKeTlklCtEJwF+L3ZR93A2U+Rf82yxpG57Euz+k02Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttJ29mVURvzVzlKsA7Xw4d1pAvX7ovqqwAtbukzdlOk=;
 b=X0g8Duug2XFm6Q6F5uwJEo1dI/9pKuiKVrv7hG8Ze7HDjC86XllB62uyVTPcaSpR1kvZPbJdtz1YuPZySOtzf+76Lx6SVdjG7lvJzTsOm2rqR5oXd64kUYZ534WQjOBei3lLNMCBO79w5AtdqDm1vM4z+ogf5LMwMeYeVHEjlAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DB7PR04MB4298.eurprd04.prod.outlook.com (2603:10a6:5:17::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 21:21:50 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 21:21:50 +0000
Date:   Fri, 28 Jan 2022 23:21:47 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Adam Ford <aford173@gmail.com>, Zhou Qingyang <zhou1615@umn.edu>,
        kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx: Fix a NULL pointer dereference in
 imx_register_uart_clocks()
Message-ID: <YfReawz+QGsgkYgR@abelvesa>
References: <20220124165206.55059-1-zhou1615@umn.edu>
 <YfPCdPuoB3RYgzL8@kroah.com>
 <CAHCN7x+bvC70Y18j8tvSVZNjwipYu3xTvFo=AjKvYnmaucBiGg@mail.gmail.com>
 <YfQQ3iQhSxCiUQ2U@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfQQ3iQhSxCiUQ2U@kroah.com>
X-ClientProxiedBy: VI1PR0102CA0096.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::37) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d6f32a1-ed0c-40dc-2ef2-08d9e2a4326e
X-MS-TrafficTypeDiagnostic: DB7PR04MB4298:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4298B0AD3858B65989174E2DF6229@DB7PR04MB4298.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n5oyqoQIbOS7hsP9L9GNxwqJeg1xFdVzhGyqLMKMtqMlPmgE6Ao7hAtqQNZ17J0VQGOROkdBsMwP4vIOTKO6jkG1y7GivLLxYUvLHBySj7ktI3ywZ1cPfn/IQRzrP6fmZ45eBOvYN686Kz4wQWjMASXiibubbM+radkRRvvIO973jbeyZr5/pACCUdiSVtF3f3fNhzECT5gf61aP97Pb6v/bWYnOxYmW97omikOxkKLealVIc4U2Zo1mkkQhQVsnaojpw5HpnfavawjVwCup+xGI4kwIV1iqlJzRHXubW4NAlQcIf9tUIKKOE4YAEzCgBnaXaAAbOwG0tUg9W4J3ZpljLq8odnCp4iMmzPAYapjZPqtRBGtEnV8n013al3oxi9AFLJBBRqYCGLWWy+6H6R/Aa0rwDwwWt/mj9z05jz1Cuav9C/oOwpxaGcS9h9YTmN5hbaT+NJxLnDORkm9HfLVwjyicW51G5FLOHli/3404gmPVwrTN/INoqDZPzaiNpylNemEz/SqYj/7EJs6st1pOzYDMn1X5UpdXtvMcMQ/viwOSnF3KQxnLigE6xc6KWjOlObEBRg8t4gYeF7C6xhyP/23tHqKJQr3wVVgzGc4LNH6ijV5+pjRARoOT34xC8AVncQ9lg+ysYrRQ5e1HqdQPbix2XQO0gcH5IFo4XyyEmBw76kJionsW5cClG5EzA+qQaGApWAT+AR06PFvotuofZEvQI3f9HRsWfzdgFHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(7416002)(66946007)(38350700002)(38100700002)(508600001)(6486002)(8676002)(66556008)(54906003)(66476007)(86362001)(6916009)(8936002)(4326008)(186003)(33716001)(83380400001)(26005)(316002)(53546011)(52116002)(6506007)(44832011)(6666004)(9686003)(6512007)(2906002)(67856001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eexi7OXiTGIV8YmOLeC65k1aH+KHhFY1CpRvKStw3fwAWpEoTHWOqEQRTD+x?=
 =?us-ascii?Q?WHuCZEKnqbsM8oOtzENZBBHGs/OTXWvPGRoqvP8D54wxgG3sma8osVWEZfQ2?=
 =?us-ascii?Q?j2sSOPqRzgDRU5YOGsAdIMa9jNMPwAtwSCjDg70UoMoMUfz/6JS/uB+jyn3+?=
 =?us-ascii?Q?9e/oh4QlcfSMD1FAHW9gOUFZuFv9SxREmxa4W84pEroAp245gUbx8xdwbpry?=
 =?us-ascii?Q?oLreGjAUMcinlf/ympAhv3WHR3VBegrHURUk7gPDKBzXJ01bXQxtSiFsTMwL?=
 =?us-ascii?Q?/c8awlT2kPtrVZOPzbIa+4HYQtjIb13OgGjaWbEk7TPOCw3Dh2AimraAhdRF?=
 =?us-ascii?Q?VNrmt4cEnU0HDwjCXXx1x0UNTg1EDIZIj8lHIBSIsHdxUSzU4bLxqiM32zQm?=
 =?us-ascii?Q?F5aeeewqFMsMbSd4BNPSMoVM660izERnrKbI6YtWxuLdOItStUDtCmZEoSe+?=
 =?us-ascii?Q?m1gsJ1SaUA7VCWyfBCXIq7ZIYzB3zHoCIo3SVj2DDTjzIZHW9Q5qEIfmnH2N?=
 =?us-ascii?Q?BtC5PYxM1aPQI7NqGtqzUbOKy0OAK2M7JBXEzg6lfZgrBfyAJs0vgdkPX/7O?=
 =?us-ascii?Q?0N4OdnvNzWK1LLOm1DPIUdZS0GrWN2hZcJZzGqnOadHYF3228dbPHNWfs9Vr?=
 =?us-ascii?Q?twwgTJE7504glo9fYy7Tn3D8uA0l2cwl1mJI6FUdLGIEbHa32sdUabggh4o3?=
 =?us-ascii?Q?6ltETGuC+E2Cg/W6ZhsUYfnm9UE5T9oI4Q/lLLJpJ2Li+1j39Q7mkjv00/uz?=
 =?us-ascii?Q?J5S2bNUdVb1g7Kner9GqE5ZzJSxkpphs48PxryZ5IyFkq7vU2Iv1d9yzk3wj?=
 =?us-ascii?Q?S5XwK9OkL7tu+TlYqeqh2IUHb+HrGtzi3ydM98o0j7g0zkOGEF790HqRHZ86?=
 =?us-ascii?Q?sRxKHjxbKvGREkajAxZbk1lMa3L9F9+Ig48nWLMdmrOsSk+TAAoAkF9mBNo5?=
 =?us-ascii?Q?GodVf4OQ2DubxynhcUYmH72YmYX40lrVc3M68JZVeGp+TWRFYlf5mO+eRNGP?=
 =?us-ascii?Q?W79XwXeE8hepQHTk3u3+mLCXZxRUgpbceRdcPCfbvA46FcLtlXeesPs3Dyme?=
 =?us-ascii?Q?1PDo2HyQ9tQXgvULMlsHbwKaqVOar5ASIjzIcMhzwKrE9CsVC/DLN9Tm3rbe?=
 =?us-ascii?Q?joZ6kffBrky53A1a9lZM5US9FpfF8Ehm8un8qGrZPf1m1GcDKKAqMym+wHHg?=
 =?us-ascii?Q?N9PL+pE01rwFChq8YVDWuGFM8XtVQEEbBe+5DsG27/zE1QYDP48oJu4TSiIk?=
 =?us-ascii?Q?9JMCa9iMEYtiy1pvGf/Wj2HSpcwbJaJ0W8VQsEVCij5SJMnblAIs6Em5tzs9?=
 =?us-ascii?Q?OL2X1w2QCX++Sb3+ZXnTkaHUyJB4LaYk43XmGFrWv0OZ1oP35FJcWmr8Flmr?=
 =?us-ascii?Q?Si2dLbXHdYICAX+NTfw0fZGrNL4uwy7m5yClasRHhr/9SLmmirYD87jEMhSJ?=
 =?us-ascii?Q?QayXm1vvjMJA2IH68rw5w8pqqzcBGZECyw6tiQYq22nAcR3aaIAVUrBKOOk0?=
 =?us-ascii?Q?5OCcoYZgMcSPZO+FkKKd4axAwi1XKDSGe2jxPUbWdqfTgm9Yr4L78GrXdiX8?=
 =?us-ascii?Q?oCnPCl3x9Tf79++H65W/UKgl3tDBal3rGSJTlaNFy6/hnPxgF4CZr8PR/LcO?=
 =?us-ascii?Q?vDXQIVfd0BLYLjeKdANiid4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6f32a1-ed0c-40dc-2ef2-08d9e2a4326e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 21:21:50.0575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zl3isVSait6G73FLsXf0aDLH6MK2uL7nQJdXxvFNB9tChdKlUgnU4iR+9PTC+vrhnLKvxcPkYObrjPf/uUqAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4298
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-28 16:50:54, Greg KH wrote:
> On Fri, Jan 28, 2022 at 07:47:06AM -0600, Adam Ford wrote:
> > On Fri, Jan 28, 2022 at 4:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jan 25, 2022 at 12:52:06AM +0800, Zhou Qingyang wrote:
> > > > In imx_register_uart_clocks(), the global variable imx_uart_clocks is
> > > > assigned by kcalloc() and there is a dereference of in the next for loop,
> > > > which could introduce a NULL pointer dereference on failure of kcalloc().
> > > >
> > > > Fix this by adding a NULL check of imx_uart_clocks.
> > > >
> > > > This bug was found by a static analyzer.
> > > >
> > > > Builds with 'make allyesconfig' show no new warnings,
> > > > and our static analyzer no longer warns about this code.
> > > >
> > > > Fixes: 379c9a24cc23 ("clk: imx: Fix reparenting of UARTs not associated with stdout")
> > > > Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> > > > ---
> > > > The analysis employs differential checking to identify inconsistent
> > > > security operations (e.g., checks or kfrees) between two code paths
> > > > and confirms that the inconsistent operations are not recovered in the
> > > > current function or the callers, so they constitute bugs.
> > > >
> > > > Note that, as a bug found by static analysis, it can be a false
> > > > positive or hard to trigger. Multiple researchers have cross-reviewed
> > > > the bug.
> > > >
> > > >  drivers/clk/imx/clk.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> > > > index 7cc669934253..99249ab361d2 100644
> > > > --- a/drivers/clk/imx/clk.c
> > > > +++ b/drivers/clk/imx/clk.c
> > > > @@ -173,6 +173,8 @@ void imx_register_uart_clocks(unsigned int clk_count)
> > > >               int i;
> > > >
> > > >               imx_uart_clocks = kcalloc(clk_count, sizeof(struct clk *), GFP_KERNEL);
> > > > +             if (!imx_uart_clocks)
> > > > +                     return;
> > > >
> > > >               if (!of_stdout)
> > > >                       return;
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > As stated before, umn.edu is still not allowed to contribute to the
> > > Linux kernel.  Please work with your administration to resolve this
> > > issue.

I'll ignore any patch from umn.edu until further notice.

> > 
> > Greg,
> > 
> > In the interest of safety, I believe this patch is reasonable.
> 
> How can kcalloc really fail here?  Seriously, this is an impossible
> thing to happen in real-world situations, you have to have special
> fault-injection tooling to ever hit this in a system that is not just
> frozen due to other problems.

Totally agree.

> 
> > I
> > wrote the original patch that is being fixed by this.  Would it be
> > acceptable if I submitted the same patch with "suggested-by"
> > associated with Zhou @ umn.edu?  I want to give credit where credit is
> > due while still maintaining the rule that patches are not actually
> > being accepted by umn.edu.
> 
> If you think this really is needed, then yes, feel free to rewrite it.
> 
> But rewrite it to be correct.  As it is, this is not correct.  If an
> error happens because we are out of memory, actually handle that and do
> not just return as if everything worked properly like this patch is
> doing here.
> 
> The "suggestion" here is incorrect, which is the big problem here.
> Whatever tool this group is using is wrong, and as a few people have
> hinted to me offline, maybe they are just still messing around with us
> and seeing how we behave.  Personally, I'm starting to get mad.

Lets consider this matter closed. The fix is quite pointless, TBH.

> 
> thanks,
> 
> greg k-h
