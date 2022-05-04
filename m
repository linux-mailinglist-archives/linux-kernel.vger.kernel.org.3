Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BF551A3B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352253AbiEDPXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352227AbiEDPXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:23:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E472443E2;
        Wed,  4 May 2022 08:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPcGFQ1uAxGuGx+A9AFqyvhrVoMGugXjNe2G1McFJf6SxtULIbeG/kEPp1flk2rCSEig+bllUcKeczXygFEFMmxeRVIyeZsvodsFPFYObEIg/j3bbN5/rzusmUjU+MgwIStQnlZ8xovG+ibi2q0V5pwYHa9KDoxbwWhBulruk5KgkiDxGbA9Dgbrl9qnzBLS0uBThGTlLSRRzfi5Z6xCok4TkJLNfdDBqHpZXFadgUwZEMTMmObWB8HyPubPdhIYMiDDZag4w8fbRPeUqkKLyfuU/q6vmR9UDnOM8p1CbT5KWs8JgB6o7MRqFBx1hLCCapWBlAP5HJFqjacXhWZs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syebumXPcAWGZvREzXE1vo+vzjah2K51G26GiAWeZwI=;
 b=FcjNUEKgS1Z53PtxvVXz7SmPlbOmoRRoVEXsVAJ82AH/Z5ZSnB2qIIEif3oqavq663GsOXZRb04HjscI4JcROEjBMSFYrMjtOO2V428UYlB42u7bONi12hsfIx5OGBZvhSTzUCYNUl5B/yWXZSEBqe1T1sVUOdaHgz9kQumGql1kQxQxpPoEvBcOXlSbLtQbeAsINepMQ0Vutah+Wz1bpiaStMETPWHC31OMYjGtWfHiOUfb2WUs6w5bxnV1zH9E5E0tpXkZtk7Kn6LX9LAuZDzLQ5sjar+ChmykQTV9dmyZiFZ+YOSVehGKShpAkFoHAfO5oaKC7Hjobl3BDb0Bvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syebumXPcAWGZvREzXE1vo+vzjah2K51G26GiAWeZwI=;
 b=gJUJhxjIDfvNlblXpLSVTitsN84xqksRUKXR2zA2O6ReRMxiBOcvdFjTk7rdIsCF7kf8WndlQFT+U7Q906SRSFpAIpdlZYDYIUFhgor/FMYN2gCJ35bCh/FwzcVA5E6IlY/RM5LrfpOA4j6zzEzJzx4YDZBKQm1N01Ev0q8f9OBIB18RJFQlTqAlmrSgDrlLIjZNO5gQI0nqxLRkUO7IR9/zEpYWGeiLXWU/OoaiFPH/3DV35wTmwPLOsm6pt0vLimp6eyEzk/E1l4NpFnwi2g6t/O3kv1zJTpZy5yYHaWZMtKljnek5KzKi+pPtyal1QfYMqetw6/Yvijs2OCfrIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS8PR10MB5830.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:50a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Wed, 4 May
 2022 15:19:54 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f4be:8b5d:4314:c2d8]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f4be:8b5d:4314:c2d8%4]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 15:19:53 +0000
Date:   Wed, 4 May 2022 17:19:51 +0200
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
Message-ID: <20220504171951.0d569632@md1za8fc.ad001.siemens.net>
In-Reply-To: <YnJ2tYjCpJi7yc4j@smile.fi.intel.com>
References: <20220131151346.45792-1-andriy.shevchenko@linux.intel.com>
        <20220308193522.26696-1-henning.schild@siemens.com>
        <YnJ2tYjCpJi7yc4j@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0141.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::26) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03033f90-8828-4890-aad7-08da2de18a4b
X-MS-TrafficTypeDiagnostic: AS8PR10MB5830:EE_
X-Microsoft-Antispam-PRVS: <AS8PR10MB58307B36FE7E6588F9E60F7185C39@AS8PR10MB5830.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KgS6gtcFoU4vYoRtDz595gVgTeImKaU+53H+tIk0nfxvL0hh20qbpDXorTGU1P2R3HpcwYNdontgbZj6bEnsY3BCagXIF5llQ9OH0aFlauTYiDQijtgInWX7DeV8INdoA9RR1gSjQrjrtRYFRW6QbokxB2GLn79FYH6pYmO1HFbfnOLNawvmZYaBJ6g1doLCJN7Db43o4FdH/QWebPw4EQjAbPtOJUmun3B8Xo4iqLwEhPj1pYPs6SswDLlJpkus2Ul+33cLV+vtltEjoYr3FDgLZod7vHYg7EDDVPovOR1xMLR/5rhJhr0y2lJV4mxaC4uTc0UOsBYejAXW1JETRnIHVUxs1xTktOs+ugqP6ief7GKRR8S82QCNCQmB8/9zhF3sEnIt2QlOxN9AkP7H5MSTR3WXePrxMjUzugAekLwrruXbOk27wEeFmSGHgugGvf7sNSG5q8X1B6wujHZCdRzwFb+YO+wo5qaeYJ6CikSDZ0lZ4c9eWd61FuKVW9ecij7qb4U4W5qrernejpvTnfL6zWHP4wcP0g/YZM3SYBWV98cJULniBdoifSPVBAeGZU4RNFz4ChvqujR+EYHHIP6fIE8p+sVk9FR7Zl9/r6IA8be9hOX1My3HU5SclTbfZ5VpEmyISnT/oJhlW4ZsnEwuzp21g9muRJXmUnEIEe3H8lm/ZN8fOCxRdOGean54ctlHfDA++rAzEzrGzbN1IcFSD46oYYAW18viHmCjwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(44832011)(2906002)(86362001)(1076003)(82960400001)(66476007)(8676002)(4326008)(66556008)(66946007)(966005)(6486002)(6512007)(83380400001)(5660300002)(8936002)(26005)(9686003)(107886003)(186003)(6506007)(508600001)(54906003)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1jtFtJOq8gwCukzE5+8PXTR2Zgw7spWFOJQLgxdPpkm077x7U+X9ziDsIZLL?=
 =?us-ascii?Q?99ginLO0fW2LGphwJOT5kEpPVgl+0n9xyeYrdIaK8tUNNHeJ1mga7e3lvMYb?=
 =?us-ascii?Q?K1AId6v6UAVozMNaTNtOyVFhk7YC3IeD0JuaAxEGU+rIRq5JLeaqZjD4lOPc?=
 =?us-ascii?Q?EV1kUJj0XrHuxpOFq9iB+AyVNQV86QkumhmOBp6YSQrw+a4dUklufBXp11Ic?=
 =?us-ascii?Q?t4eQFG9li8IpgiG9rqGVaDhBJe9MGcEz2rC6UgJTkd4dr6kBGi6dbqrWlPbp?=
 =?us-ascii?Q?b19dFnt6KzWp4t1P8h2VFxBVwcbbT+5p1ZUptlATOmgXf1tUMyNMHb+tF2Zn?=
 =?us-ascii?Q?cmFBT2se1b9b1oJmmdPl0YN+2XiVtlh/jQ8DuSRBULxuM3jytru3b0SpQ506?=
 =?us-ascii?Q?uzwlhOUy32BuUZF5cIaZpTAJAOQRLv4gIeSZLvyf8qnKeSe1An08aPoV/pz5?=
 =?us-ascii?Q?u1h9Kbf5/42zmzyiEIfBAInfiJD30+Z4x7g91bsFwWCm+TrLMnEhjJUs+few?=
 =?us-ascii?Q?MkhwVJGkXWt36SVKmJCmZanfG9CNL9r+ldgvVwszQqFyhVeeptxAE8EaoS51?=
 =?us-ascii?Q?IHBZfFgTxAdPaN/YNLwsd0eC5cgYt2FSAftEGEIqDCNGtSDq8vvSH0JCqrEW?=
 =?us-ascii?Q?q3a0QR605o1et1U8IK3r7SnIWELsqek7VlGSqKqS2xy+p+bYMOfhQ4trlNMy?=
 =?us-ascii?Q?CCRenfThJZ4a6G+Tv1GtosksIUciK6+20q1vL/CQaz1qCj65YpQdGaYXCnfY?=
 =?us-ascii?Q?df7aosfsTF3OfmbKeKVgyh3S+4UABMXLGV1SEUM5rGlchdk/D4QKoz0vMIht?=
 =?us-ascii?Q?IeQ0JURG4mbq4NpwtgAjXVnwnLdpgtXJls3p7GjJ+xuqv5XdOePsIfFzGvK9?=
 =?us-ascii?Q?v1ECLfYlsGOpbGS2r6s1gPoW4RPkGmNZaZ7mckq0C0SdcfZzxKwAk6nJAu9F?=
 =?us-ascii?Q?6dJ44TaK5GfhuRClkXbZ71uA2WLpMTmeJv44Fsjxa+J2504fMHS8Euyul0ZH?=
 =?us-ascii?Q?uyxZ3hgG0z82kUGa/32BsmFu6nA8hugUchiS/FQGWicRaGwkY6vg2Wy4LXJQ?=
 =?us-ascii?Q?t4TmOa+Yw0wECaKyJVh6dJ+U0mqGydAanNrYrdg8vf89jJO4Ymh94zd+q6/H?=
 =?us-ascii?Q?nmKfkku/dsOpcNHceIQ9PG+YPRnWgAkAzIn6l+/aqvMUpqTCKg5kCruhTTws?=
 =?us-ascii?Q?mBJYYbEEugT8QqEpB5mGo/7OG2R8diIdzqNOjzXJW5Q0Md0IN4CoQdq1Q9xZ?=
 =?us-ascii?Q?y5b/E+WmS+xemnxxRHlu13xl57XWgiW7plKeoTB+Rw9N/8RsDUfRIFRaRBFo?=
 =?us-ascii?Q?DVItAMb2IONFkatZhnjyzySTKgdeuICv1tV8I6twdl85/twq8C5Ysfirwfc8?=
 =?us-ascii?Q?TGbTX/6Umk4NDNuwdu1lci/aYnpnEEf+2tmxv1BfB/rO3AWrbpY8y7RLzvoz?=
 =?us-ascii?Q?j121kwLscaNvhvGEO+CYAW4N2lweLiBAYWcPhnRbQJCbu3uIuWvwfOiThaeV?=
 =?us-ascii?Q?qhTQdqZmsKsmzAtYpsflZe6DM3C4Obk7fj0oamTbIfMep0WHDYTkAeLgM67v?=
 =?us-ascii?Q?0o0UgzKbmzROdX9bJz1a/E+wOO9RLQQHHj+QouJX9j2z9vNxlsAIIAEvMTux?=
 =?us-ascii?Q?DXewtH75qKtPKuE9exmPAgSaQhKkWR0aCSVb6k3rJYhDJGlf38DeyUpkjzb9?=
 =?us-ascii?Q?WhZGmU8xnVtX76Vjk/f0rfWAiBzNKRT4lg9+2PMz3n0Y7NuUUNqQa1jGrIlK?=
 =?us-ascii?Q?H3aZUOGz88GfJTH8cN1c0PFuUWfaSjZV8H7FJih15XP5h2QPVkjO?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03033f90-8828-4890-aad7-08da2de18a4b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 15:19:53.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3PxVk+c7PnWVp6I1xwWE9eou2rhBOfL9watHm0NEclrcGMxvhKn9QUjG2xeN1WzErtf5HnfJSlC64Vcjd6blV4MJfIVt9WDedjazKV+MBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5830
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 4 May 2022 15:51:01 +0300
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Tue, Mar 08, 2022 at 08:35:20PM +0100, Henning Schild wrote:
> > This switches the simatic-ipc modules to using the p2sb interface
> > introduced by Andy with "platform/x86: introduce p2sb_bar() helper".
> > 
> > It also switches to one apollo lake device to using gpio leds.
> > 
> > I am kind of hoping Andy will take this on top and propose it in his
> > series.  
> 
> First of all, they are not applicable to my current version [1] of
> the series (it maybe something changed in the Simatic drivers
> upstream, because I have got conflicts there. For the record, I'm
> using Linux Next as a base.

That is possible, some sparse findings have been fixed lately.

> Second question is could it be possible to split first patch into
> three, or it has to be in one?

I assume one for leds one for wdt and finally drop stuff from platform,
and i will go with that assumption for a next round based on your tree
directly.
Can you explain why that will be useful? While it is kind of a
separation of concerns and subsystems ... it also kind of all belongs
together and needs to be merged in a rather strict order.

regards,
Henning

> [1]: https://gitlab.com/andy-shev/next/-/tree/topic/p2sb-next
> It would be nice if you can perform another round of testing.
> 
> > Henning Schild (2):
> >   simatic-ipc: convert to use common P2SB accessor
> >   leds: simatic-ipc-leds-gpio: add GPIO version of Siemens driver
> > 
> >  drivers/leds/simple/Kconfig                   |  11 ++
> >  drivers/leds/simple/Makefile                  |   3 +-
> >  drivers/leds/simple/simatic-ipc-leds-gpio.c   | 108
> > ++++++++++++++++++ drivers/leds/simple/simatic-ipc-leds.c        |
> > 77 +------------ drivers/platform/x86/simatic-ipc.c            |
> > 43 +------ drivers/watchdog/Kconfig                      |   1 +
> >  drivers/watchdog/simatic-ipc-wdt.c            |  15 +--
> >  .../platform_data/x86/simatic-ipc-base.h      |   2 -
> >  8 files changed, 139 insertions(+), 121 deletions(-)
> >  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
> > 
> > -- 
> > 2.34.1
> >   
> 

