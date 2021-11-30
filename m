Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF0C463F04
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343594AbhK3UJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:09:48 -0500
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:58018
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236006AbhK3UJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:09:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALQi7G2yMQAqVaDMWZbYZOiGKWRobjiTPCXcCi82k2nLj/2vsT9DwIX9ubPhs5EhWkJqONNDGctaS8BdggJQvN4dCPYSAon1FMyqTV1CWLF1hWqsIHcH4X/ngxQY0Rk2GgBMp4opIcBdyqsbBWuUJbalH99vK/oAxVw3znY6c7APCiIIe5gb5tkItbvksGG/bh/V/QiBkMw3T+4ggFgzhenGySwb96EtB2Ohi4wu0Du6YvnRgaugPW/+7FPaD4h5ReHB3z1JWYiL65/b/l+uuVAb/JReU+JwOLD0/ncM9G8b3Hgcij4KiBVaVnWz0xgfeQ+YvI/S6oQ4WyBFvFPY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNasSBEYOIBtk1j4Sxhu5Hmv2KYsod/FUdaXXNKbDaA=;
 b=CPXhc3eXMvCMVDI2JtZQCp66mbu249M4EIScczFLLdRHkWCUH2gqstH0fG6fwDptw2bX9teViPkthYlulA5iKAmOnBn9B0yN39fLHkDYlWXREF+hvHDisrbmHdwxPrtzSIcPOvZ1B9qDb84vFkD0MtdPg1p2cb4MKGHQyw/h65SIU2UT4aoqQ9PoYvbMDuHTWQThKbdstYXGJr/buoan/5GYoHIYqup+1I6bYzveF9QkRFhvrPHPwSD8TNXgaFq7rdz1BANI7lu4e07NdjK9aUvDjgTaYA+4bgewogAVBFq7zGnKWhHtYkZE7Dt67qZHXugQ5gWWywGwkc+8XQY79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNasSBEYOIBtk1j4Sxhu5Hmv2KYsod/FUdaXXNKbDaA=;
 b=bQGqGYgD9gzgyapygnVSanHdEf7L2i04uE8wLBCL7GTrPqVYKnF7Pay4iOMPurciJ0zq2eK22pZqXxcdN+6aABZF80mFs2aMi18c5ot5mlW3Fu2Y1bOJ8TyxL1ad7T8qOvJq5Vdf44zx399URMbGNY3Y9C5XqrolXKJebEO6xzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB6014.eurprd04.prod.outlook.com (2603:10a6:803:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 20:06:15 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 20:06:15 +0000
Date:   Tue, 30 Nov 2021 22:06:12 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Rob Herring <robh@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 06/19] devfreq: imx8m-ddrc: Add late system sleep PM ops
Message-ID: <YaaENEqlQbW8W6PI@ryzen>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
 <1631554694-9599-7-git-send-email-abel.vesa@nxp.com>
 <e9a3a64dcfec858e612037199df7627b77ececd9.camel@puri.sm>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9a3a64dcfec858e612037199df7627b77ececd9.camel@puri.sm>
X-ClientProxiedBy: VI1PR08CA0122.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::24) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
Received: from ryzen (5.12.226.136) by VI1PR08CA0122.eurprd08.prod.outlook.com (2603:10a6:800:d4::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Tue, 30 Nov 2021 20:06:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2bdbbf7-d7c4-4611-eed0-08d9b43cdd57
X-MS-TrafficTypeDiagnostic: VI1PR04MB6014:
X-Microsoft-Antispam-PRVS: <VI1PR04MB601414BE02ABF20A5A5E1095F6679@VI1PR04MB6014.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXGnPkrmPBVQRjJZLxjAqHTqyMlAeVieKx1M0b2HQkZ4lXGbhMR66fIC5g4S12sUHDET9KCYis6ehVQggQ9GuZ9Vg626c5tLcKCSuAeoXxwkyySBURl9BetsBSo9Mi8sKgCiu3ecL/67oJ2NfPCkrVRSyn1NXft1TrsIMQcA8deT7hzzuIRRRDcE0C1p3g9VxTKZypZ7Egm37jVa6czW7BtdxB4aKGGV2BUlQj37d1V6vAfXJqUKxxfEZcxVigSFnbXj7dVrlTnq9uekvL006fsjesJW6GjKyEWZtpESNx8GQHsDQY7GsKeKy0LxX8om1PIjgSKywQgC6ovNs1uoe59NhANV+7I1WVUH3cZH4DxTrL6u46gY37X2M694Pcogr7D494obAcOBRpNw6JGDUmZIAwFpHt6sQuBsrNGdiOxqnJf9KaUXYv8Rkz7wiZ/aFws2gsk89cT0Glx6ay14sh9FlRFeKyod6SA8bSd4+L0HTGj+g5F41+CodiK5dDhoLmwf3kcd0bhSPavjm4t9DJVgBbayPo9F2+ZXbsYOE4/4Jukg4MBF+UzrbWVli6faTxq2JVtYVxHWY59WRGjvatQpoNWqeliqtgBqUWHV8Pl6U43oObl4VZdFvndsQ+r5F+yXWbt6rVFbXZBPIMsp3LGLfsZKviHgIigu1GGFfhkMikAhNwO+DxUkO/aCvkM/xdoMFT0CpAPsGobEeGN0SqCOmA6U7DaCh7mup9lh2cs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(8676002)(33716001)(86362001)(44832011)(66556008)(66476007)(9686003)(8936002)(55016003)(83380400001)(5660300002)(7416002)(956004)(52116002)(54906003)(38100700002)(26005)(6916009)(38350700002)(9576002)(4326008)(508600001)(316002)(2906002)(6496006)(186003)(53546011)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?oMHpj/srsaZcWflpd0NN/d+jAMZwRhDUIhzg1Lw5lWFDbJR3zauZPEcG0r?=
 =?iso-8859-1?Q?PkZL1ga38xGoCjT4oVGWgE2RZjdjrXKlAIjwF2Dddg9qBacKHXDYCJyO+e?=
 =?iso-8859-1?Q?HncdNApa56Z9LtZPBEMeC05q3fSRqzc2SVTvb0nUwKuqEtPtyDx+MFpVsS?=
 =?iso-8859-1?Q?qedQXmrzMPBra48suMcC6mUS1XFKiJyh66j8wYVApmLycyK5Wc5VVkMzxp?=
 =?iso-8859-1?Q?MicrHR/uPEvOHktxyrl7x92bMSs9/4N3jb2BQ3LSoLm7w506sTnJld0UFy?=
 =?iso-8859-1?Q?qYTdPZOdcuRS1JV1teCbAjg3hhNgs8ak3SjOf7Ovih/pMZrY/SCz0cWP1o?=
 =?iso-8859-1?Q?6r4TiyZvazg32Y93tCNdeOLPo5Ixo8iyn8P8KlESz5mmdtcIsP196+m9rv?=
 =?iso-8859-1?Q?cCZ6XLbrxYYS+2LSu4KM+lfQhAjCq8JafvWX9b9cPgMZb6gS5luPaIJPX8?=
 =?iso-8859-1?Q?0E0oR5Pbo5W4woYI1Ug5wqeaHL3E+SmRNg5M64zXlagrTnRKeeuxot2MQU?=
 =?iso-8859-1?Q?9bUSHwYq8uCYOndVY45Z0cLWAE3i5qTe+niAqJ7JqGLMeEFHl37bXyZQ7R?=
 =?iso-8859-1?Q?+n7z+YVUYzZHzJZB2n05u7QJ5bG3WtZjTPwPngFCtgxiluD+K3aOhbABA5?=
 =?iso-8859-1?Q?d8LUR4vxPA5ZaYpeBXtxxJed+HVwJCmwDJxO4JRIVkDQtTac+seGZtPHar?=
 =?iso-8859-1?Q?YBVJTKgL4lO0LBeIES68tJiAJlK8f1CjU0Lvyqh9jpxGFgW7LZN+TKSSVQ?=
 =?iso-8859-1?Q?9vq4fewBlrIbSo/mv4E3boWNqwVa/r7V4TYsKlOdciADdMY8u9a5MogwUO?=
 =?iso-8859-1?Q?B9Et3HBaIQP/gI6YLdlFIOzGXIW+PuwnTsRt0wop/Sm9B1uT+yDi0NNQBj?=
 =?iso-8859-1?Q?2BdT5FwEYuUjf8E+usPtqCrqLJItrzJkzqfN7n/Q3UlAb9/dAtwRGIJqji?=
 =?iso-8859-1?Q?XGhZLkZxjNOGoZ+jTZnV08q4/1ekBWGICW0l+Bbd2IrrOlLWCpqtuyH68A?=
 =?iso-8859-1?Q?5oCQcpKDoYyJH281O+Q7HCe5bCUXnHCS2G5R1Swx95zLdKz5nBrUcKWfu5?=
 =?iso-8859-1?Q?Ua0tjgvmWnuWoSacsWRNySX4Xd456zokH+78zm4wmc79IDgP02yD9Ry82t?=
 =?iso-8859-1?Q?5V1nOlcRKiX0eW0n39OZJu3JbSa7xw0XNpmcTSjyRrVuP8SQ42UFv/GbdB?=
 =?iso-8859-1?Q?yRvgvcNYUvwqHuPG4x0+0NW25VPKpsStOKIv2sxZd7+oolz2jK5513GS2w?=
 =?iso-8859-1?Q?zf/hDNztEs2AYrlZN3rFtjsl6wxwZ+G+REr374ARi7JW9xC2q7DT+yQ+3+?=
 =?iso-8859-1?Q?XnqGRarpMsTftkggGmoKpFnib59WoXKtgeRwunZse7l0HrYo6Ck2MpPCcZ?=
 =?iso-8859-1?Q?cSuB3WJE1ikcFnUSLvc1xw0Y+QgFE532rsd6KF7gR9ZGtybY8DEahEzdQt?=
 =?iso-8859-1?Q?QpGF0JEGNZXZeNClACySYTru28oDTDE5ulO2g35dJJKNjnU7pwmkaAjNl0?=
 =?iso-8859-1?Q?lbjlSulEEIgJ2F+a7I7pwXhgGagybO2PONrVMa59F+lvmG1bq/rTQaulsf?=
 =?iso-8859-1?Q?4rzV7MigVc4cKz5ekg+VyUy28MR1s2/zbRHh3XgA4uLPzMUK63nQjYM2WE?=
 =?iso-8859-1?Q?Tm9yu24NNCDQ+zSRY+hdQSw8MR1Dc7VRznmcMvohI+0DCQJuEnFJ3co1+u?=
 =?iso-8859-1?Q?2Vnyw9+fFpJivlKQpRI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bdbbf7-d7c4-4611-eed0-08d9b43cdd57
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 20:06:15.6089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBHaZs1b1sS7xH93TUbO0OfMBBIRTlJqO2GqRKyvhxbo3X+ohJ6sDTR1M+nkdHI+XfQmHghrPjGyzMk9MlXZAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-10 13:15:26, Martin Kepplinger wrote:
> Am Montag, dem 13.09.2021 um 20:38 +0300 schrieb Abel Vesa:
> > Seems that, in order to be able to resume from suspend, the dram rate
> > needs to be the highest one available. Therefore, add the late system
> > suspend/resume PM ops which set the highest rate on suspend and the
> > latest one used before suspending on resume.
> 
> Hi Abel, wouldn't this mean that s2idle / freeze would be kind of
> broken by this?
> 

Nope. Only the DDR rate needs to be raised at 800M before suspending.
Everything else stays the same.

> Does is make sense to test the lowest rate? How would I force that
> here? (just for testing)

You can try, but it will surely freeze. See [1] what you need to change
for testing.
> 
> Also, you could think about splitting this series up a bit and do this
> patch seperately onto mainline (before or after the other work).
> 

Well, I sent as RFC until now. Seems there are no big issues with the
approach. So I'll split the patches between subsystems on the next
iteration.

> thank you
>                           martin
> 
> 
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  drivers/devfreq/imx8m-ddrc.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-
> > ddrc.c
> > index f18a5c3c1c03..f39741b4a0b0 100644
> > --- a/drivers/devfreq/imx8m-ddrc.c
> > +++ b/drivers/devfreq/imx8m-ddrc.c
> > @@ -72,6 +72,8 @@ struct imx8m_ddrc {
> >         struct clk *dram_alt;
> >         struct clk *dram_apb;
> >  
> > +       unsigned long suspend_rate;
> > +       unsigned long resume_rate;
> >         int freq_count;
> >         struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];
> >  };
> > @@ -271,6 +273,22 @@ static int imx8m_ddrc_target(struct device *dev,
> > unsigned long *freq, u32 flags)
> >         return ret;
> >  }
> >  
> > +static int imx8m_ddrc_suspend(struct device *dev)
> > +{
> > +       struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> > +
> > +       priv->resume_rate = clk_get_rate(priv->dram_core);
> > +
> > +       return imx8m_ddrc_target(dev, &priv->suspend_rate, 0);
> > +}
> > +
> > +static int imx8m_ddrc_resume(struct device *dev)
> > +{
> > +       struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> > +
> > +       return imx8m_ddrc_target(dev, &priv->resume_rate, 0);
> > +}
> > +
> >  static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long
> > *freq)
> >  {
> >         struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> > @@ -324,6 +342,9 @@ static int imx8m_ddrc_init_freq_info(struct
> > device *dev)
> >  
> >                 if (dev_pm_opp_add(dev, freq->rate * 250000, 0))
> >                         return -ENODEV;
> > +
> > +               if (index ==  0)

[1] Change this line to:
		    if (index == 1)

It will select the 166935483 freq for suspending.

> > +                       priv->suspend_rate = freq->rate * 250000;
> >         }
> >  
> >         return 0;
> > @@ -399,11 +420,16 @@ static const struct of_device_id
> > imx8m_ddrc_of_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, imx8m_ddrc_of_match);
> >  
> > +static const struct dev_pm_ops imx8m_ddrc_pm_ops = {
> > +       SET_LATE_SYSTEM_SLEEP_PM_OPS(imx8m_ddrc_suspend,
> > imx8m_ddrc_resume)
> > +};
> > +
> >  static struct platform_driver imx8m_ddrc_platdrv = {
> >         .probe          = imx8m_ddrc_probe,
> >         .driver = {
> >                 .name   = "imx8m-ddrc-devfreq",
> > -               .of_match_table = imx8m_ddrc_of_match,
> > +               .pm = &imx8m_ddrc_pm_ops,
> > +               .of_match_table = of_match_ptr(imx8m_ddrc_of_match),
> >         },
> >  };
> >  module_platform_driver(imx8m_ddrc_platdrv);
> 
>
