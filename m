Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE62B574000
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiGMXU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGMXUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:20:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2098.outbound.protection.outlook.com [40.107.220.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9569D52897;
        Wed, 13 Jul 2022 16:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfs1ppKb92yF2UPSuQ4dDuHIKby6lrKvjewnwLfcSM1XIPa90vGtfuVhlQk6fZeJ9lZBBVUv9necdNnMQNJqLuEX5MAUarEzvjlYGcX/tp1gwlUKzoIKqdMoIQ3BJg87dFIbnYbkkdmhoeGKaeeagA2+/tjJswaV8+uJmYhP3y1DogNY7ddUKFNqoafCgXyvHhVy2LXsZxu2oh/D+IuQpJPpAeE7Asb0ZGt1q/4XpFT02VyF05glQK3DV3+fHxhcX673JEpDbkR0M9dgfWAyml8Rv5lhb888HC/9IIJOyZjouYQdV5h+AiPUSbyEuJ5hbiYDiyjmokGmmXT4ar3viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvnOY8qfleckzXTkh2YEi84gBKcbNiKOohvqnWK4L0M=;
 b=TW46bT5fFiiCNGfBsvzEYlgIHzxAHH4RsDPUUaHnO4rbj0s5FcRNO7wOXPIxwnOqnJAhkxIOUsQ2Cdbg3mpo24yPACuRcrIoTdkv290S48IucobN1rx743Yr25p2Cvq5k0yFV8MY1lKsqF7k5u1nh+uUn71Yf+NwN44Z7LTjAB1UcNfBr+re5mqdT9slGDAhqclDiGTjLvnZNJA7J5NJCzKQqauIeep21EESCidYjSe6RRM7lR29+4s//752ge883nWmaLFhWAEAZcVLauxMXTDV1Bd2Ad0u/votyp5Typ/PNTXdtQ8R5/b7ISZvlvESWbBrDWnY0hDrkkLEx0G//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvnOY8qfleckzXTkh2YEi84gBKcbNiKOohvqnWK4L0M=;
 b=ciLi0V2gE1AO0QPtF5lex2jTDuIrmccExLYvqhE2L9BI0K6/7aay9nRiesePeENWk3ocPqGFFTAuI61Tg5JRAAvTDd/9551GjvteDx3wVefnO1PU5ri4zA6ai28sme7hFFMYd9D+Fa45J39k3RIHTrzMjdyM3X7f7hPO1M24Z9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by SN6PR10MB2702.namprd10.prod.outlook.com
 (2603:10b6:805:48::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 23:20:48 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e%6]) with mapi id 15.20.5395.020; Wed, 13 Jul 2022
 23:20:48 +0000
Date:   Wed, 13 Jul 2022 23:20:47 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH 2/2] pinctrl: ocelot: fix pinconf
Message-ID: <Ys+1v3UKvSgOCD+7@COLIN-DESKTOP1.localdomain>
References: <20220713225151.1476041-1-robert.marko@sartura.hr>
 <20220713225151.1476041-2-robert.marko@sartura.hr>
 <Ys+xTubC2iwetqYS@COLIN-DESKTOP1.localdomain>
 <CA+HBbNHwbPtxGYW=xnay7zW9nxUgu5EURy6nX9m2rkTPdSELLw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HBbNHwbPtxGYW=xnay7zW9nxUgu5EURy6nX9m2rkTPdSELLw@mail.gmail.com>
X-ClientProxiedBy: MW2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:907::15)
 To MWHPR1001MB2351.namprd10.prod.outlook.com (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ff3246e-f3d4-4003-a10e-08da652651bb
X-MS-TrafficTypeDiagnostic: SN6PR10MB2702:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VjY6vrb6EH9Dkk2x58Mk8E8knzVcCraImc3y3lD5VnS4qFXri+L6cAwYb5E9RFU70dEH72QHW0wWhxJACLyIrqZMFZo2kAWW+BoN3IOrgl2uIr60I4qgrKYqPGpS7dPo/eQ9wz6wyoUxoGKy4LembNcuVdm4hDbnpfKnjD9i9yXtw+sj1Wi5X1csffh8ss4kgZ76mkRiUGthrwb7THo+iL6oSPu+w98+g21FQpXX0Xb2JhkQ1bJafprx2RvPxFkD8QQ+IE/VAuu2msKpMDprWI+68pXGvdzZbYJpN4RQqDtgDghqgO4/TfLcd228IpZqtqaiG9VhlCa404oCOcFQjj/yWGAun4kZcnDF53H3Bg/jBpqB+xbx1hwrhsVBdlTAkVgPdbTDAPD5eSY9GTvBUDu0/+HkxtvLdpNBW+E+QVPBtfohNn8WGmB+YK4qsi2M7hQle0ts1tjfrdFAsfVKZ25rmdhKyNVJ6sG+uZ+UF0V4CWUfkk/aYU3yWlOX5RZhXe3NEgmBqBP0Bo19js2eGwWC/2Xlzo8k9DJ1R12RcLG1v1WzBH1PvKvUzUhyKO/dHFpixduO2V24mNu1IfQs4LD1QvyhzZ1sIDdbYJMQOQCPQCcZ+qZrGFrTIsDZzDdWG86IDp0IS8CLwMGxb33cMg5tejOYB/MgVT1ncAwOvrObGmE3Wuv5QYR0sMqpnZws9Cr4sLTFBup/ftv1crK5WpCY8/MuMUyO5VgKe/JepZAFoV4IcsB5TwYLsYCSDhuhVzi3ifJs4iN0B7Nd40e9Z/xzjdyh9c8lj5h906faUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39830400003)(136003)(346002)(366004)(376002)(186003)(38100700002)(2906002)(44832011)(5660300002)(8936002)(66946007)(66556008)(66476007)(8676002)(41300700001)(478600001)(26005)(6506007)(6512007)(6486002)(9686003)(966005)(53546011)(4326008)(83380400001)(6916009)(86362001)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rjTNxuw3avPvqTxMIiw/8T/N7WhiqfhWklLPRcJMVRPnpWxGvM4gFLM8OkCp?=
 =?us-ascii?Q?dSpkiQrCD8Je0DPyYnZ1Mk++xTJAR0uY/OAXyUs/+vzFxc2TDr2nSD44WZ5x?=
 =?us-ascii?Q?hSbrHg0IjTNblOo4B7xEa4jj83KXozSH0RArXWSJUCYaxsyZst5vZLOLqLr0?=
 =?us-ascii?Q?3xj0m/jFrlg/k4EHd2OP5ijlgngSD7plRbZqGNqGNB0Is6hnKMBY5VQOuvP/?=
 =?us-ascii?Q?5ChmRgoRNXGt9myiMDrdIudhMLq5KNJQg4FW8aOoxznXmd/sNHlxYC3Z9IhQ?=
 =?us-ascii?Q?X7nJB73VIEbZirkLERT0Kc/KWtxRYS/Ug9JeGk69DzB8CvqSS2V589fuoC+4?=
 =?us-ascii?Q?vQPf1IpQ0ySHV/0RzvYs8cFo6HcDEWVmwluHAEPNuRtmIhpt8u1W/lLEQcE0?=
 =?us-ascii?Q?s3b5Fa7yHVyxw/Ux/gbP2N6Ea2oqNS+KsfHNhtHm17Nor9vBPMTzWiXIOgK0?=
 =?us-ascii?Q?/0jscxNq6cbHWvzWHDFmi1Ie79B4jpxbAgWl3LumUKl79lz7faxQxuPE9vce?=
 =?us-ascii?Q?F+jWYLY568qFlmmrCl22fzkQ6Cpr5uJet3A4su6HZa1CjZmNKPaH1OjUdI/g?=
 =?us-ascii?Q?DDVtZjIh3S8JszGQb4dhUe7RDVUdjP6LQs5JOhZ7O3zZU1PlXjr/zxcPMNWY?=
 =?us-ascii?Q?1G9vHAxi5XG2yw+iuND4r83XxEs6goFQ7aqC7PETDco4RNTFUvHqWsixEnuv?=
 =?us-ascii?Q?m+kiWa28jqQeiGIIRn9KtX9asSUjHwHjrLYnZWKBec31gYw95wR40VXeJ6rA?=
 =?us-ascii?Q?Y0JKgCHyWaK2pmAnP8MJsY2waCGIaR8KSM0cwfM0wMlW/Y8XmRS0aSL6Hwge?=
 =?us-ascii?Q?1l0JXMx0SLvBCDWk4XtGPwbwLkL+ne+kCZFiqTKJ+GiLdWzC0T6ILuovborY?=
 =?us-ascii?Q?+FS2N27vsNpGCCT3loK+7PE+WAQqqxd0LxsRsyhCzXsENM94BVYRk3DQyVSK?=
 =?us-ascii?Q?VnsKDRcvOjQ2/vBYvdl1KTQLNC8qUoMw0zjwe8rkzcWy7BnWXeS3B8jJy9zC?=
 =?us-ascii?Q?jAZWT1T+D1ggCLlbaD1gLk6hvQJGgHGJiX3xW6q6xMP3Dxx9wjnHCHzE31zq?=
 =?us-ascii?Q?CDZ739QAfKIJ2whzhp9lyye97lj4OOkRh+LYwMSaji1XGO33BxpHOm7bMU1I?=
 =?us-ascii?Q?bpHz5WOTaMhxLHAO1oviKAYmMNoECcsummdlz2JOD2KeEFhEsQTHopf4oUDv?=
 =?us-ascii?Q?CV1II1LD4hGmYJqfx6p0beHC8i1XJH/kAM7F/cPOHTPkzdg8F7hPE52Ij6Ah?=
 =?us-ascii?Q?BCcL8YBCjq3iUNhr3Rs1tCVh4ppd9I4YptpSLlvdK4V7xI5T1jjvBVMBOXd6?=
 =?us-ascii?Q?PWDSTN1S671/29zZz868h6Zj6rqc5WCVAvJb5AGBdlEOs21yn0ZtqMGa7Zac?=
 =?us-ascii?Q?U7LgHypzS7Pdz5IPveqYhAojTrycc0Pet93GhykA4/2sEUAYUUXNfhYejg5D?=
 =?us-ascii?Q?R/VvYVjrF3As3cMB5Fi6LNIht5b+4ms2KSuhcOrTZC/gfIPfmE2uISkV0HeV?=
 =?us-ascii?Q?/UNTUgpmalct++45RwEMk8xg84DllKnvh3kQ7L4XTs2VKOiiKko33CrwY8/X?=
 =?us-ascii?Q?Grfoa5roWWmz5X/VMGdvFem4jVWem9QXzCR8KpleFlomKzUvqwrZ4NfJ12OD?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff3246e-f3d4-4003-a10e-08da652651bb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 23:20:48.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XryK02xxCdZ6neR/6Kay8KIqlew/5U+ejTD+5zNqtYR1vrJ+7an5Z6Xqi1bGLtwVbX4nLKrzBK+TPuaqaieREpDlEenFwONJJWosGM/ghDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2702
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 01:07:24AM +0200, Robert Marko wrote:
> On Thu, Jul 14, 2022 at 1:01 AM Colin Foster <colin.foster@in-advantage.com>
> wrote:
> 
> > Hi Robert,
> >
> > On Thu, Jul 14, 2022 at 12:51:51AM +0200, Robert Marko wrote:
> > > Commit "pinctrl: ocelot: convert pinctrl to regmap" moved to using
> > > regmap_read/write, however it neglected to also carry out alignment
> > > to register stride of 4.
> > >
> > > This would cause the following error:
> > > [    1.720873] pinctrl-ocelot 6110101e0.pinctrl: pin_config_set op
> > failed for pin 34
> > > [    1.728110] sdhci-sparx5 600800000.mmc: Error applying setting,
> > reverse things back
> > >
> > > So, regmap_read would return -EINVAL as it was being passed address
> > > of the pin without stride, so for example pin 34 would end up being
> > > 0x22 in hex.
> > >
> > > Fix this by accouting for the stride in register address.
> >
> > Sorry for the bug. Horaitu found this as well and recently submitted
> > patches:
> >
> >
> > https://patchwork.ozlabs.org/project/linux-gpio/patch/20220713193750.4079621-3-horatiu.vultur@microchip.com/
> >
> > The second patch in his set fixes both of these issues (reg_stride and
> > max_register).
> >
> 
> Yeah, I noticed his patch only after sending this.
> Sorry for the noise.

It doesn't bother me. The only difference was your 0xfc for the max
register, while Horatiu's (per my suggestion) was info->desc->npins. 
Just pointing that out in case anyone wants to raise that as a sticking
point.

> 
> Regards,
> Robert
> 
