Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7490F521EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345756AbiEJPhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345886AbiEJPfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:35:34 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2773D3B563;
        Tue, 10 May 2022 08:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls8T2pj67LzSz5d8n7AkvSbnf5xF1hwnL0N5a1P2WH67MQFNhl4sXW5xJeVqzT+w6Ce00Mvfjex4OsRQyKjW+AsB9x9jVcxF9M0KOLHaRXLRHLFGBdMhWgk4vWkmD9V1VxZW6RB66EQwSM4JdijgINpX3ApHGq2sVeKVuU7lvOdbnCtyJZMcgRXjBYuLBl8kTAWfEntvR4LSyc5bDx1M5XgX9yfQ+oohzyhCqWhwooWpEf26abbZvNVbuKbo2SGIkGMT5Ch9pqENF3KhzPa0RMmuh3A4lMeLw7PcK3EaKrqtg8o+nOk/W1fE5p33W6SUsBK6Y74DJdpQSyblogtFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw9tzlEbdLAGigUdea9n8mEXoSc7XvrBSZtwqGdeoiA=;
 b=h05G73e4MU3kicU2NF38bvpM2oqgVTaMTHK2hrt+lgkH6d0m1sCNe+rJoxujs2OPvsUXSVFobs3PnFF+hyQ0jujTbjEHdONngYSGf2zBfv1RUCKFPjXDmzMR2rJojLjzxEnVb1FePREdWeMAuTmk/lypynx800jbWhkdzPD/FuUwNdf5whSoWkNofDErF/pCMjiyB292ThHVJb6mSpBlxLf1GJKbtXpjZhagAsi9bXb0VZoZ1u8xukhnEtzCxRXdDVEpS+x1xAHdDuR4xAqlgyD/xfuWM3zdbv+0aBZxYSLcF1XbPbhnZONsQEHAqlCFXmjBSKNs5GE9YPJ8El6iPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw9tzlEbdLAGigUdea9n8mEXoSc7XvrBSZtwqGdeoiA=;
 b=peToJ4GyMeBysPV/gRc/Fgf/+8QgpuEIW1bEgg0fHID1JrmcFo38HdOMGoOL1CS9+UTNrwooKhmNcpLO1jhBawBt+iv3TroRjqNrNVo71LhYJ2ydOnKxFPHbbQySxQPRXxBjv9egN3772mGwOUUkkOKsoite2IfKT1lboUMe3zptK7A7skgljXbK4VLQardvXzaGAT1dW5oWAR/QXH8r3jYphi1JVfV05ynO/V8ZVm12cizxxdA/NmB6t+RpLSkAF98aME83QDA/zHGxVYKbDmEzsL0pT7/thBIEDdKLXUrsPecmzh40a+PZsvZir3zBDhtbTfiTQU1R8HTKt72QIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM0PR10MB2339.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 10 May
 2022 15:30:57 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a852:a1:7888:f20f]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a852:a1:7888:f20f%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 15:30:57 +0000
Date:   Tue, 10 May 2022 17:30:53 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH 0/2] simatic-ipc additions to p2sb apl lake gpio
Message-ID: <20220510173053.10a14aeb@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220504171951.0d569632@md1za8fc.ad001.siemens.net>
References: <20220131151346.45792-1-andriy.shevchenko@linux.intel.com>
        <20220308193522.26696-1-henning.schild@siemens.com>
        <YnJ2tYjCpJi7yc4j@smile.fi.intel.com>
        <20220504171951.0d569632@md1za8fc.ad001.siemens.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P193CA0101.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::42) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b264c0f-0eda-4589-ad2d-08da329a1445
X-MS-TrafficTypeDiagnostic: AM0PR10MB2339:EE_
X-Microsoft-Antispam-PRVS: <AM0PR10MB23398B557B4BEF80D1ED15D385C99@AM0PR10MB2339.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbLJ5XP3FO5AZV3RaSVowX6AYz/dGNPkaFuKpi/BCJfeF5o3lLZwhtQq9WHlF80cIf42NpJdfxlGTvWTKLOjglURXQSRJbPBN2MNh55zZjjOsPFJoo7kJOegeQEALAvWFsW8OMbNadCFaTN3jcCRm2ZcAXat1yh5GlqbFy5G9KoQmVV6Pt0rdihWgOOxtb1rYmD/osUns/S+0lXDgXoVTg+w2npS8rIe1gJn4LHtg5uB/u5nAmK7uoOJkVlq029LRNnpdHRIdgu0aEZ/SA4j8XTjwGieJEh63Ameu7Rz7FzBAj/AycRy5oUQCSq818HpIPAnJQnoLzy5V+IALKG0K0rl2FnQxupK4JgVIKicY+6Zr1yTftNTaxAIoVKBIA/tgjqL58Cw6vfAeuLOojjE01XN1W6vF3mBPJ5XqLJwyEz5XiB01gLvmBN65Q9LF+gPW1FYxf3GHSzmnRopevyPxnqiQmkA6HpGFLf8pU0d5yoHjd6zkU/DnxARFA8JebIS1btW2IgW3aHcK5mZ6zPqm2syd9OmefXg/g2OfKvRg744866u1hxV67Pvy5FBiU3moqTKPG+ljgPwHW+gbAM3NwwgFGNBOUKDtoqkDbCS8yLL3l3SpXYpxg+oSWJQTtu2uyQPG9rxYjWgVWV2fsSYydzPIA3VOMzgiphTutO3dRTYX1bFG7B7LzQ32d3ybWt7bRG+bs7jKfXjc9kyKSxkwI7bQsQIX9KUr+mGFqfoNPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(1076003)(6512007)(107886003)(6506007)(26005)(38100700002)(9686003)(54906003)(66556008)(66946007)(66476007)(2906002)(4326008)(8676002)(186003)(316002)(6916009)(44832011)(966005)(6486002)(6666004)(86362001)(83380400001)(8936002)(5660300002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kvD55vauXx+L+SpeqlC/jHw1rvOXkYawCt3UEVlaEluNqm8TChGuTH3ir/Yq?=
 =?us-ascii?Q?zgDkgb9rXXCJT/ydzYSVPNWT8mXOZ8aQ/0HvYxXrMI+aCwieEi2RqOpXQb+L?=
 =?us-ascii?Q?mG7AoaSEUnwyc010wolBaN60hMaPXyccgygqCWMTE7vfi6P6cTdeK1ofVnT3?=
 =?us-ascii?Q?SR5FjZpVwdi++QnNwIuTi8cm3RkdLsgbaKHiLH625RZZGg+eYkg6fYt1dc63?=
 =?us-ascii?Q?BOQUdBhP4NJkGDiZX6kMe+HATN+VP+pP//DNPBX8JkVy8DzuhGMT0Araj/eX?=
 =?us-ascii?Q?nBSja2R07Mm6tMYXeqVDpAG5DkZWIGDPKjyxWqCcz3yZBrEgh6KbVymci7QQ?=
 =?us-ascii?Q?i84SLvDKx9Y70GtBsgpTW8Nk02X4gEJEL2XKZ796MDRU6JcDJw6yoyvuqJ3g?=
 =?us-ascii?Q?9JeyRiufiolFUSJX3q4NQT3iuHdr1ZrNNJ7V+yW2r15lhtourd+VlA+ZFhTi?=
 =?us-ascii?Q?8gI0aK+oEt/7ZWfLNYe6/WFdg4E5zzEoY4V+2OnK2KJRGVYQsQTNMwOUnMQb?=
 =?us-ascii?Q?/dPBbaoGnI3L7ejnG0n8jPnD6XdvhJ5mb+kT29a0UZRXZ01iQ1Tg6+MNTXcM?=
 =?us-ascii?Q?9oyi1Np2ZdSuY3ite33JyidC3lsaXmuit1pVAEAVmL0LE609WjjBp0fsLvhY?=
 =?us-ascii?Q?l59nrWvLRvRDWZr84xcSxNmVv/B+TbQpLPOuFJQhVjcJ8IG/XvjLP+sej42A?=
 =?us-ascii?Q?UsOh87Puikza8uLtBCpTabG86+RANg9Xik6hFw4c+rJ1OVCDUCKgTvSmFu6h?=
 =?us-ascii?Q?BJzShHwfD5JM2XOakpcm8NIE5wrT8xKj025NwdsOMYNNuhGxE5/1XCcUvSTl?=
 =?us-ascii?Q?T4RxUSU6Jdu9qQBeKvZIkicwjQKoBIGzle8lDhpEFL4pi9u4IQBk7xbZM5vz?=
 =?us-ascii?Q?s5Nnk4BdKrBgcGmVC86xf55/gBAcn2OM1zfspaVRLNoGzehOpqchQEHcfRvv?=
 =?us-ascii?Q?JomyRhK7EhJBYJCIO3wDZiLTyqG8Hl1yRMQjbbBPwJVmXSoVrmiHnnkxtYdp?=
 =?us-ascii?Q?3EpKHuvkvGbGcf8ch6Dx5bRu84jAdSQxLgpDplJErakfp9Ha7h9Pup+jbgKw?=
 =?us-ascii?Q?UW8InN9eH20rR+BVN0Ga0NzRihTBem15CSkNkKvqpmyBMF3N8JMw4c6QjAdP?=
 =?us-ascii?Q?R81UGGGs7j8FcXqcDyTmhBVrwBIsNC9b8nwl/UYPWVg/iHERYRyh7sSJbhS2?=
 =?us-ascii?Q?IjWIvzv2S6Psf1gO7k3omjAm0L81NpJS9Ihw7rLiAP/aXg33ixs9p8Q/T/da?=
 =?us-ascii?Q?uB8Jd3W8d327TSxFdky3hhgZ7IkVYvPYA81wT9Vzz3fFaHEDouWEjTRbDfXJ?=
 =?us-ascii?Q?v3NAFUcG5GeszuHvhutLCH1SLUhGWoNo+IoB+qTrPOUNnVZDMD9zT3htLHVt?=
 =?us-ascii?Q?sXxoMHJa8CIJj15ICFxnWkPndh1OX5wqCRkiTR1Z6StNLlRl4szqGS0/Fbuw?=
 =?us-ascii?Q?e9JZx4rzfL/CUlwsgjn5kanf8W+DmwgggQ/3VXo6Aaksjn2vacmJKxduU2Dr?=
 =?us-ascii?Q?luZidfZFbnxaaf1tX9NoVuMiC8gUuj8A1K9szPEKITSuYLhhcCYRzaiTQ0+o?=
 =?us-ascii?Q?qDiDT4fdHcERouTZhteAD4X5K7AK44lITBbKSwWJFkphVYcH80i1kAFv1WGI?=
 =?us-ascii?Q?bwGR4exgSLvXsQIzzcy0IPv0ymnbxRYE2eVWMNsOicCym958CZwpDnippRNC?=
 =?us-ascii?Q?Fdcq3FhonZj4HLEZ8xgHmsaiwrqPmgiHAVb3yLYNhswB3nCB/4aBhu09tMQm?=
 =?us-ascii?Q?w6f9C9P3voZQRbwJzy1bH2aVzKsONpY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b264c0f-0eda-4589-ad2d-08da329a1445
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 15:30:57.4059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFN7xRD4ZLI6a/iyTyS8R0AgOEi83liAxgSUEEYLP3Le6FZqPmpsBXsOMEcGjX2Bj6pQ+zKf/3CmyRi4niC7E8TimYJ5+fosfMc0EMDt3Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2339
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 4 May 2022 17:19:51 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> Am Wed, 4 May 2022 15:51:01 +0300
> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> 
> > On Tue, Mar 08, 2022 at 08:35:20PM +0100, Henning Schild wrote:  
> > > This switches the simatic-ipc modules to using the p2sb interface
> > > introduced by Andy with "platform/x86: introduce p2sb_bar()
> > > helper".
> > > 
> > > It also switches to one apollo lake device to using gpio leds.
> > > 
> > > I am kind of hoping Andy will take this on top and propose it in
> > > his series.    
> > 
> > First of all, they are not applicable to my current version [1] of
> > the series (it maybe something changed in the Simatic drivers
> > upstream, because I have got conflicts there. For the record, I'm
> > using Linux Next as a base.  
> 
> That is possible, some sparse findings have been fixed lately.
> 
> > Second question is could it be possible to split first patch into
> > three, or it has to be in one?  
> 
> I assume one for leds one for wdt and finally drop stuff from
> platform, and i will go with that assumption for a next round based
> on your tree directly.
> Can you explain why that will be useful? While it is kind of a
> separation of concerns and subsystems ... it also kind of all belongs
> together and needs to be merged in a rather strict order.
> 
> regards,
> Henning
> 
> > [1]: https://gitlab.com/andy-shev/next/-/tree/topic/p2sb-next
> > It would be nice if you can perform another round of testing.

Just got around to testing this with my patches on top. My stuff will
need some more work before i can send again.

Is this a rebasing branch? 
With efc7d77ea372 ("EDAC, pnd2: convert to use common P2SB accessor")
I am seeing problems while booting ... things do work but still error
messages which probably should not be there.

[    2.215715] gpio gpiochip0: (apollolake-pinctrl.0): not an immutable chip, please consider fixing it!
[    2.217506] broxton-pinctrl apollolake-pinctrl.1: Failed to attach ACPI GPIO chip
[    2.217542] gpio gpiochip1: (apollolake-pinctrl.1): not an immutable chip, please consider fixing it!
[    2.217771] i801_smbus 0000:00:1f.1: Failed to enable SMBus PCI device (-22)
[    2.217788] i801_smbus: probe of 0000:00:1f.1 failed with error -22
[    2.221460] broxton-pinctrl apollolake-pinctrl.2: Failed to attach ACPI GPIO chip
[    2.221482] gpio gpiochip2: (apollolake-pinctrl.2): not an immutable chip, please consider fixing it!
[    2.222010] broxton-pinctrl apollolake-pinctrl.3: Failed to attach ACPI GPIO chip
[    2.222023] gpio gpiochip3: (apollolake-pinctrl.3): not an immutable
chip, please consider fixing it!

regards,
Henning


> > > Henning Schild (2):
> > >   simatic-ipc: convert to use common P2SB accessor
> > >   leds: simatic-ipc-leds-gpio: add GPIO version of Siemens driver
> > > 
> > >  drivers/leds/simple/Kconfig                   |  11 ++
> > >  drivers/leds/simple/Makefile                  |   3 +-
> > >  drivers/leds/simple/simatic-ipc-leds-gpio.c   | 108
> > > ++++++++++++++++++ drivers/leds/simple/simatic-ipc-leds.c        |
> > > 77 +------------ drivers/platform/x86/simatic-ipc.c            |
> > > 43 +------ drivers/watchdog/Kconfig                      |   1 +
> > >  drivers/watchdog/simatic-ipc-wdt.c            |  15 +--
> > >  .../platform_data/x86/simatic-ipc-base.h      |   2 -
> > >  8 files changed, 139 insertions(+), 121 deletions(-)
> > >  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
> > > 
> > > -- 
> > > 2.34.1
> > >     
> >   
> 

