Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341A95A1398
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbiHYO3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiHYO3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:29:19 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BED111D;
        Thu, 25 Aug 2022 07:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOOdE4ob4GJzjuni49+1ImKVMvOyAeMjrtZxFQ6WIDC0rZDbSNQhdctlZRDvBuxothWwe7nfDL7cLNQPFncttnhC3hZgpCAyQKCmsvsoaUKzQGWCoszz4ynIkC+CPel2DaCtpQc2Pyk/pF6OG6Q6TNtpkJ5S9gjWzcj/NuEKu/3kVDXvLbAOMqi2AbASF5hdGvvXrafaOb8ibWRVYbUNO0Nz0XO0synZYsvEKXRInP5m7P96niNij2FpEYvX07YQx7sZ+7JMHxZ5FkLTQhHrKyaE4CayGvdiaN3+wIRwY+uLOrILHC5etijp7UwDTOdz/illSZFPGMcKyQ5Zs7na9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NNF1pZSDbjhR7/+dd0L1FyodC/u/JkUCY52rRuIWLo=;
 b=FhY9UI0yNQ1JENG62oojYk9qxN2+mvIrd2EZaTge3VTrypUiSWYmfxVA5Se7kaqLcOmyrZsMu32VTQi8ALkVditlUpG7a4BiTYXT/isAGmzrCoMI4GHUqTnZnEwy9+kwzplYWTwh5NmjvHg6aYSjFkyxHShRj+TKtDKTKL3kb7QEx7B7peCnaUCmaH4zocIsil/v6Y0ZQqVgiKt4Neas0f63yHlUOAYa2BgEEy4tGhWG0mVOnabJ7p/2mQPr8YpR/RDL7n4LpYCvAb0V4QR1MHHfVUS2DXMKndNW69N9IILTRVjE7VJa0ywGaD5CyqIQbCDV2a7tj5RzXGCNML79aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NNF1pZSDbjhR7/+dd0L1FyodC/u/JkUCY52rRuIWLo=;
 b=A4+deBI/3IgHI9/C8wD6aGkvELLSutG3ynGozmqaN8HZxgUhuulH4oo6BwT4OhEVBEID8414n33HyEZO1zsrmUHMpbXVm3cK5JrI5GlZBtxnygC+tSV/d40UoF3sLG1U6EuFVB6q5jI26X3Mj3CfiMXa6TEAf+6KEn5Yh53EbbosM2ZTQBXpTy0fZxLJu3+YztNyfpHLjlVZJfwpUhlmlj+ZFHOm4JTNbKjHUJk1g7G+Ct42FXOnl6SIULDVRN0ZMn0Xhu2w7arEaS+V/ocecEO/gFk933sIlO4yVefdH9sOkkmI4a3A2YuJCFFF1qF/oKR0Cy9wr1+KRxp0avcqMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM0PR10MB2852.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:134::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Thu, 25 Aug
 2022 14:29:15 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 14:29:15 +0000
Date:   Thu, 25 Aug 2022 16:29:10 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        simon.guinot@sequanux.org
Subject: Re: [PATCH v6 0/7] add support for another simatic board
Message-ID: <20220825162910.6c8eab84@md1za8fc.ad001.siemens.net>
In-Reply-To: <34315356-f23e-34ff-98e6-a152b588f201@redhat.com>
References: <20220825104422.14156-1-henning.schild@siemens.com>
        <34315356-f23e-34ff-98e6-a152b588f201@redhat.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0301CA0035.eurprd03.prod.outlook.com
 (2603:10a6:206:14::48) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89b96154-1876-48f4-2ecb-08da86a62ff9
X-MS-TrafficTypeDiagnostic: AM0PR10MB2852:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxCAKe3up7RJvOkZWhTT3G4pMaud8PqPfOsYHXh3UltVkfNjkH6g6LoKu+8zcdM/pNHxvr93BSS0HArIERqHf3eI4v8RCuzW67kL0MRmdeXwuRlcoG2RPasMTQ17q0M6ykEp3+sXM4l+ubEsjkn8x/8UUp3AGfXr8Y75992BHXUV4G/43Ht5mrqXWXhgt0cEK0WalEZlfYmUmMMbbpONavspy/EF6i7RhTTx8Op6qkp/P3HFjHPJCkUf0iwk3/lUUy0tPU/uob7RPIdvUOUYhGsNFlAXsNP6K2ca6FockGMerGeaOrJOZlN1TX1DiWx59MSnaYvj0CSUm+yfI/cCwcMUZBFKTaO04hKz/l0iZ/VquvXptm7JkRkwJi+Kz6F+CVGf1GIDK0ulYh4O/CSVPewKX/StImWgY1l0lpDrNXcOjxReKeL1cde/q1b//loHBwc8FTNiXVw2kCxA3AtTvZ4c511Oj/e6B8ycy2c/brycnUzGsudCt116pJFm4y96LR5QZmIAnQayJp/Ky+a37/KpZuvEP8GEq6iuilA+KQ/IlK8EJbWBqyUOzUv9THtYUf1ljZ/EHiWN/GnhX+ajm+rkDn8LqgbUWQfvY390GFQXXBUJDzy8srOpWXUaGUy/BGr66uGJLNQawx4OrW4Ey1Bx7jhqTXDqk3AXoIEXEziebO9pVLrmse34AudvMx1UBKJsL6+7tsoZuR/hc1TS3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(5660300002)(8936002)(7416002)(44832011)(2906002)(316002)(4326008)(6486002)(9686003)(26005)(6916009)(478600001)(6666004)(6506007)(54906003)(6512007)(41300700001)(53546011)(38100700002)(86362001)(186003)(1076003)(82960400001)(66476007)(66556008)(8676002)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QK5gFPYr+miESIwq+MgG89ckRgrSpz3ddGVbfDwH96KtevyFMbt153pNUnNz?=
 =?us-ascii?Q?hYbSDYLDcaNyDoZj/9vKrB3ql3f8ZnKuKHJzTspKLqmsE6Qu/Gj7qeKdvBfx?=
 =?us-ascii?Q?s+54Z5drunsrBTCYeMrSoWVhwYoajDG89koT77jIrL/UcboEXXwyzIbCR0zg?=
 =?us-ascii?Q?XK952Yl1EnBuebeaEVGlvJBJEOuH+nrXXvkccE3kGZBrE9KuW3jUXujLFomE?=
 =?us-ascii?Q?iCBaCjAzsjkebQH1wxqqmRcac6AOEp+1c7u9XGMGngTnzI2sc3wgpalllIb+?=
 =?us-ascii?Q?Rwe+bdbxf3eVX5UL5MN1aVxRTpSFzl5KWURbiYqnUr1tV+5Q3EXVZG/u/ife?=
 =?us-ascii?Q?gFKoddUgF08cOmSBgLvPy+aPIKxXfHwWhDpJerblUxG9ElDYsPq8jWze4mgJ?=
 =?us-ascii?Q?JDdJ5JCGE1FpVplndFlB/FZdHhMx9Gjo1UoTPhkM8XQv1k7x5/c4jVExpIxJ?=
 =?us-ascii?Q?oYN3vqn+zvPjFCaj3qDvoXS03aH5iPWp/uTELxNNbQvqa94LoqxMErhl2+GO?=
 =?us-ascii?Q?Ww1Vz4eApRdhDo11FsnCw3xb208dO2JxJRofa/nvDD0xTBt/KLLcc+1uFuZw?=
 =?us-ascii?Q?X493Y9vOo1iHA7ifNKU2EaL/D2vsPvNdUNZiRqs46ml3eeG9qF+EQRI29c2G?=
 =?us-ascii?Q?XL2DvBQCVXwI8NRTHg3wvzxkxS63FskDzTPhxGNydFBeivlERZapzKct17cj?=
 =?us-ascii?Q?n+rYoLGDim7BUDt+hkndx6ZyUnwXoYKbhFlwq1m8TV0uJrWc60KSlU7mXvTw?=
 =?us-ascii?Q?5vMU/gc/CjgjmrnEt2p0pkvII23EbaWnBYjPIBGy0AU+oqqkPoWUexWW4dV+?=
 =?us-ascii?Q?ctGnQ6Odfh2/SOF5h0/gzOfIpoGyLBi0pYnmj0UgnPRc7j3TCJUYarYCMerV?=
 =?us-ascii?Q?ERiziN4JGxr1EGT4cImV0cc/wL37WpnCm6/Cw4DiRKJBuOj7LnBr+1IHZA+N?=
 =?us-ascii?Q?ocCal+xE5O4pOXkgaBeB64V52x+wW67A3BeIAADqmDC/uiMUsBRjr3l9nZVS?=
 =?us-ascii?Q?HWAK9M5uULOOnBITZZ8aNWuNEqZTK62l59Qat1u2Ett/HOZrS3jtYtJAeDIw?=
 =?us-ascii?Q?UP9zSr9/ImjzlbcTfOvfnGYg3k2WBApSaeJQW8z4TtB7ERiHTbHj7ZbtPNCw?=
 =?us-ascii?Q?UTrVI3XlePilPxJL7fR2gyjWwPZHgRG72J2cA8xvoM9ueTIWXgOmiSx3sZtY?=
 =?us-ascii?Q?imXuOGfAzwRe0zvLNWV6Xq7F/X1vExjVh07/J1Vf+JBcGOO3ea2+XFJiswtY?=
 =?us-ascii?Q?DCirQLtF0OKKvsGYCfhNo8AuEp/XKV/hGsQAT83TyEGiIQh+ycvWgF4zbbrh?=
 =?us-ascii?Q?T70cGjguGMz9Xg+M5/pVDfz4m91JF8Pyhg8HyuDs9DEautP7ndTjVpvFPSaE?=
 =?us-ascii?Q?bZijBM2YNock61qkP5xDSob4BFoDDFXt62a1XL9h84DP6CnsIhedJt9NUtOc?=
 =?us-ascii?Q?B8zpqmTpQy/OsCB2gHqBNIWYML74262E7fRyuGs5Uf9/yQFvP9mfkXI8kX0V?=
 =?us-ascii?Q?q+8qdnu8cXQOZG7QBaZ5f9RfPGERFSVVxluWz/dJd9zaV6aaOrdv7+iRMUgf?=
 =?us-ascii?Q?XxTf950vLW/lzpiDeyLx5k51DhkWgH1JL8kY0+wNWCHcD5JH9msRZx2ol5wO?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b96154-1876-48f4-2ecb-08da86a62ff9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 14:29:15.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUuEQksPhCLpcKKFGhJHs99KdOcsZa74shcid1Iw3y1Pe9XgG+Tr2xaiSivac61yep8EdMoCj8t2GLLk6ietxRydHSI3T9N7t7KHnAh70uI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2852
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 25 Aug 2022 16:25:49 +0200
schrieb Hans de Goede <hdegoede@redhat.com>:

> Hi,
> 
> On 8/25/22 12:44, Henning Schild wrote:
> > changes since v5:
> >   - adding patch to convert to pr_fmt
> >   - adding patch to prefix macros with "f7188x_"
> >   - rebased p1v4 to be p3v5 and added tag
> > 
> > changes since v4:
> >   - remove int case from a printk in p1
> >   - include tags into commit messages
> > 
> > changes since v3:
> >   - update Kconfig as well
> >   - drop chip names from comment in driver header
> >   - add manufacturer check for Fintek again, Nuvoton not possible
> >   - drop revision printing for Nuvoton
> >   - restructure defines again
> >   - add new model 427G
> > 
> > changes since v2: (p1 only)
> >   - rename macros that change behavior
> >   - use chip type not device id in the macros
> >   - reorder defines a bit
> > 
> > changes since v1:
> >   - remove unused define
> >   - fix bug where (base + 2) was used as second data bit
> >   - add macros for "inverted" and "single data bit"
> > 
> > The first two patches apply some style refactorings before actual
> > functional changes are made.
> > 
> > Later, This series enables a SuperIO GPIO driver to support a chip
> > from the vendor Nuvoton, the driver is for Fintek devices but those
> > just are very similar. And in watchdog and hwmon subsystems these
> > SuperIO drivers also share code and are sometimes called a family.
> > 
> > In another step the individual banks receive a label to tell them
> > apart, a step which potentially changes an interface to legacy
> > users that might rely on all banks having the same label, or an
> > exact label. But since a later patch wants to use GPIO_LOOKUP
> > unique labels are needed and i decided to assign them for all
> > supported chips.
> > 
> > In a following patch the Simatic GPIO LED driver is extended to
> > provide LEDs in case that SuperIO GPIO driver can be loaded.
> > 
> > Last but not least the watchdog module of that same SuperIO gets
> > loaded on a best effort basis.
> > 
> > The very last patch enables a second model of that same board type.
> > 
> > Henning Schild (7):
> >   gpio-f7188x: switch over to using pr_fmt
> >   gpio-f7188x: add a prefix to macros to keep gpio namespace clean
> >   gpio-f7188x: Add GPIO support for Nuvoton NCT6116
> >   gpio-f7188x: use unique labels for banks/chips
> >   leds: simatic-ipc-leds-gpio: add new model 227G
> >   platform/x86: simatic-ipc: enable watchdog for 227G
> >   platform/x86: simatic-ipc: add new model 427G  
> 
> So it looks like all these patches are ready for merging now,
> the only thing which is missing is an Ack from Pavel or
> one of the other LED people for patch 5/7.
> 
> Pavel can have your ack for merging this through another tree
> please?

Would i need to send again and include the tags given on v6?

Henning

> So what is the plan for merging this?
> 
> I see 2 options:
> 
> Option a:
> 1. Merge the GPIO changes (patches 1-4) through the GPIO tree; and
> 2. Merge the leds + pdx86 changes through the pdx86 tree
> 
> Option b:
> Merge everything through the pdx86 tree, and I will then provide
> an immutable branch + signed tag for other subsystems to pull
> (if they want to).
> 
> Regards,
> 
> Hans
> 

