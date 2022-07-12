Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11DF571ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiGLPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbiGLPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:19:38 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7D83342A;
        Tue, 12 Jul 2022 08:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXch5SW307mY1j/XrbOoieNWiSkVcEQ76rhrJp4gWQcXO+vKRljS//SUY9zcZnBmiACUr7knjg8Ufskr5oDhWgl+vxoNdOJFepnPXs/6OCicSZLHsNxqV9b1LpRN5UI95s4ISVbyYej7eoXTGeEGLpKYhoXKnpJmDoUc20DLKxLuH8VeoW/3Vvy2V5pAZB4Kvx5zgZYfut9X1GB5nptg4qX6tynX6l5Wq3ep7ZPICtxtrmnYae0KLozBumxz2RrS+82yLV1gJFBVHgKbeIHzA9ukzN+C4jtgD/2CSNn/iT7W7JgTiFz/IX8t3RahWirlt0ICdyxKtIWXAHjBUWZ/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEDPbNVnCwDaZs7equnBoBjt3ofA3Lfg9PKeTcuI04w=;
 b=hhN8TxaTAhwrTEztQl+TY0AzNzhG2o+jOWlN2LqkC1AZwjg+8QpQiwY7Lt/DFh0N45szcTcai/qPN6NntqQlR3jNebgZ9394VcKHIrEqnAdbN7d5PNhYCKPU+kHMJZPsmm1+q1FuzPox1EWLXKE3IV4T6AcJrlcyrZHYXw/OcQIKY1TREFJxWercNSWCuy/xCgm1ClfG+yYr4LyoucgRWlZAE2bT0lwsU7JbsoSSIRuUe/GMIKFFWNDbdcWt6dPkH9agrihuAJxIvi9X44jFRRqlW4FLg50cbuMzd7ZTW8MiBlNNeiuomX/TG0xZuCwrdFsYMOwqrvJikoQy3CwL8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEDPbNVnCwDaZs7equnBoBjt3ofA3Lfg9PKeTcuI04w=;
 b=o/TCTcZAOalM6GrbaNRp0KjxACtCw40s7GjgqL0AJidc3D996+and/TtfxbnLFZsNcV1Uh0Vm+12XpiNrmi74y/WyYAYPjcptti2sPRHRdSV2fMG5Xjpi9jx2gVe8c0cubOOnhscZTkJ/gffKeJhBsUGmOxbpBAL+Kj0LVJMVbM1QVR67ZGVyRC96ExjP3t/gozKYAbIfX5d0KS2oSSu/5/L0dcXQaEXnweW8v7zJjQNlQWP57o1hsMphEUQtQ/RbYx76/WT/4a6AUW9gvy5PxZb6etM5PU7nQ2DRJPQFGE2yC3SyPG6eva4rgXtB1ULsQ3EmjPJnYJepKVPHuhKEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ed::13)
 by VI1PR10MB1615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:802:31::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Tue, 12 Jul
 2022 15:16:04 +0000
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec0a:6162:dc81:efb9]) by DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec0a:6162:dc81:efb9%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 15:16:04 +0000
Date:   Tue, 12 Jul 2022 17:16:02 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>
Subject: Re: [PATCH v3 0/1] add device driver for Nuvoton SIO gpio function
Message-ID: <20220712171602.1e7c49f4@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75VeYHi8XTf3Y6HMmitVvuvF2uiWdSzpiKFji5SfV20HqpQ@mail.gmail.com>
References: <20220712143237.13992-1-henning.schild@siemens.com>
        <CAHp75VeYHi8XTf3Y6HMmitVvuvF2uiWdSzpiKFji5SfV20HqpQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2ed::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5cfabff-c30a-4623-1561-08da64196ff6
X-MS-TrafficTypeDiagnostic: VI1PR10MB1615:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7agm9E4QLGoH5rm1sTKlmMoFa9abCbPnWl02L0uWj3ff5JyO97OHSH514Cq4V9Kg5yTyEKBpjp+yNf/eQZktIAvpXk0eCJO3YUag0Um8ufLUiq+SqagUrqdsH9eQ/FBiXpH+sTv3Vh9xS/fd7vOtIke6QUl5M9/xR2trrKIWSflbqFXbywNUKcl5lkr6zcBpRjDW/r3NZdZ212R7ql83W+dIW4TS9fPOrmhJLR6Ip1jkCxhDvhb/DhLblid8cYMNdDe92zXebA+m8njvS089ffhMoiFEGBxI9jK3Vnn0CGGmVg8rgpIhoWTLhO7vUCCk2yWkOWB1SW5doea/T0nQlIFIBgIGxv+Fy9if1tpECivs0EL6Rcb5gx8rJvlLFiql7rtRHyyJ2SFrtNSdkToqsu1GABX/TQ+x3d8j3brpkwGB7ijstGvbZTDbCefmWp7niA8xzTeDz2Wz/iwNeYa2F1Lu6SwDBpYH3TWz4r2G0/E2Qid1HnM9DrpyrlHavYiJ6sw21ALnoW63oUDPbL7UueL9YKTKx6ZjMBXxujvyeVENjBqwc+bb2O+P300XhSDCjQxIxHW3IqsLdRGhyTDhGzDlsaL6WGHi0iVWWm7/f3nYkxUC/TxK82I1k0p6lHnLF2MFDnq7KfU5KqYjyKQqQ7eBe7WRY7e+vJhGS6SxesMtBiKZrkdbCyOzF7NxYsUKsbvs8wujh5KA+0Km2hidCla6btQHamt9vecOaHqAWyQC1v5jrM2lrlEd9nS2Oebnhc2zPULl29SLbLuWRnhhag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(82960400001)(66476007)(8676002)(66556008)(66946007)(186003)(1076003)(83380400001)(4326008)(6486002)(53546011)(478600001)(316002)(41300700001)(54906003)(6512007)(6506007)(6916009)(26005)(86362001)(44832011)(5660300002)(2906002)(9686003)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BsaONZPWkq6aHSa9wsZP6xDhnmye+Y1U6hJAHC9kfT8iP85qp68B0DKlBk36?=
 =?us-ascii?Q?OEsOnGrwcW3DHkjhShm3/apeeKMDa98MYh8t2Diu0MvC7jDmSjeI9bXE1tlN?=
 =?us-ascii?Q?T3Ay8UR0jUitnolzUO0ETKLMIiMCGBIm+2pMi5nyAjJxQse1WAT+RS9sxiDb?=
 =?us-ascii?Q?0M7jB1lZuOJGAlTSPWGPWGDPOm+UAm7qUvpb0nsU4bN83SvgaM0xS2pXbvoo?=
 =?us-ascii?Q?HMhBP61xphKuRyIExyJbr2bZsIix4iidnfPGwuxzjt1qitsZ5cK7UCYli5h+?=
 =?us-ascii?Q?C6c7ziGp8cPD6Ovn2mqHkI7tGmaS69++X40b7T9nWltYLfS+Fd+d3bYXIxn+?=
 =?us-ascii?Q?FIwg+LdCYk1hdHD9kPzJiDeiCVaVZFSRPli6z0byLco6I4LNGOxttg1SpRX4?=
 =?us-ascii?Q?BS4B35XLGJsYaHHvqnnrJ9mtKfFPzVibL66tsvLhkK1UkkU+gW7GvoTZXun8?=
 =?us-ascii?Q?mGPNaE7WlxTu4ZCIXlKBHSSTAOlo1HitRZypNJnSWaFf3GPFDUzJNgL4pSGB?=
 =?us-ascii?Q?tj/TnYi9/ZDTagKsfGDos+O4vuvzzSeQ0XFxS6GlAB1ON5YJOn4tHSP+ygE5?=
 =?us-ascii?Q?ONT93I+NJHJeWv9RU6qTe6BXeOqUAe8SClgXfcLHAykozVC31ATjMMhfBDDx?=
 =?us-ascii?Q?s4rVRxE27rRzPsIN7bJOI9asKZMWIs60cVi4cebjgY7sY+QH8WKhCSiwuqrd?=
 =?us-ascii?Q?tjjB8FwLeaJ1OPySwbFa/ba1SrnqFR70nJC1yKwChETqdLm5ss8CHEK66Bhj?=
 =?us-ascii?Q?5nwZTXhwsi3V6fWuwqW8HvGgi5AmPctnooMaAEait7i/ZeYSx6KqX5XtTIae?=
 =?us-ascii?Q?NIAyQMZT1JBNlX43r/vY5dl7rorZO7kMMc/IflfL/Np628UUJDS40UkroDPO?=
 =?us-ascii?Q?gJC4vMcl5rnn+jQggTwBGxRxhadod0IH+3ERVTBdjyj1kqjibZa4VTsphPWv?=
 =?us-ascii?Q?5gmjXERwg0ej+ehqCD3o3oZvY7eNTnEX4cBxHJwprtPNdbhU8gG/d5dRREkM?=
 =?us-ascii?Q?+gg/YBdjkyDLJPgHIS+tX+KcjZjhVEq/AsHEPRh0+8v6SEcwqOvCfyTeVl8m?=
 =?us-ascii?Q?lsYEsuMMv4Dr92n3A4LteZ/tPORTYOYHlsoCNbRZBnWTH3jkZ5JTAgUhQ7wz?=
 =?us-ascii?Q?wWCXapGuZ95+nE4l95P4GfiCsgRQFvvTMLLEsdTPjdPEreD6I/fO8ZJJBmWj?=
 =?us-ascii?Q?n+kQkBAbEuMEF9xLYYMkJ59K3NU2tMfiNkKyApssvDB2LqJ0EWEqSEY3wLzg?=
 =?us-ascii?Q?gH10Y8gOsxGdPcsRMbHAxTACz4tGlcdJMobUOz5WXjsv3zpNQIZiWuh3FC2N?=
 =?us-ascii?Q?VLNSBYmt67qWcMX74zExqlgkEeYk2JmD6+fq6NJbmE34hL7QzU/ws/SMymXJ?=
 =?us-ascii?Q?8tZlQVIj5KE0r/dJCxA5ri4xKirXzc1aRGG3LlK6xxau6maTVVLwtjAYA55i?=
 =?us-ascii?Q?1BSQLhZrTp/toMZh+b/29tNp1BfpdJWzHTG/5X070zKGfVyz1Dav4zz6r2R1?=
 =?us-ascii?Q?KgEqKI69yA3cH2cwPDAagQn59UbFrS8bl7mS1EFuiY2Gsv7PhnBZb2sQlkbg?=
 =?us-ascii?Q?C/TPfX/i1rXtG8iMHPsfCHHNv8+YyrihihLQbzpX8Tu3E9whdicK4bUq/nf6?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cfabff-c30a-4623-1561-08da64196ff6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:16:04.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1T1pKVEeeTyxToHrezi5oi6CdvWClhvCUN4NDGthz7tmv/zLhGM16BDtxzeGwl7QxvWptziU4iS3FUg6Gf/N/MJOv4zmxkIPXWaMX3YSuWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1615
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 12 Jul 2022 16:42:46 +0200
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Tue, Jul 12, 2022 at 4:32 PM Henning Schild
> <henning.schild@siemens.com> wrote:
> >
> > changes since v2:
> >  - move from subsys_initcall to module_init
> >  - add 2 more patches to show how it can be used later
> >  - v2 is based on [PATCH v6 00/12] platform/x86: introduce
> > p2sb_bar() helper
> >
> > changes since v1:
> >  - implement get_direction function
> >  - style changes requested in review  
> 
> JFYI: You have a strange subject. Had you used `git format-patch
> --cover-letter ...`?

Yes, but i changed that subject. Took the old line and turned v2 into
v3. What is strange about it?

Henning

> > This adds gpio support for several Super IO chips from Nuvoton. The
> > driver was originally developed by Nuvoton and i am just
> > contributing it on behalf, because other patches i will send later
> > will require access to the gpios. The driver is valid on its own.
> > In fact v2 of this series shows a future user, not to be merged
> > right away but to show what is planned.
> >
> > The driver supports several chips, of which i only managed to test
> > one but did not want to drop the others.
> >
> > I hope the original authors will help with the testing and
> > addressing review feedback. The changes i did so far mainly are
> > inspired by similar drivers and some just concern coding style. If
> > more has to be done and the original authors do not jump in, we
> > might start off with just that one chip i can test and add the
> > others later on.  
> 
> 

