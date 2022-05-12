Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1490524871
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351611AbiELI6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346555AbiELI6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:58:42 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30067.outbound.protection.outlook.com [40.107.3.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD15838D;
        Thu, 12 May 2022 01:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adWABasQLXBaT/VY38PiMHCVkPpPFjK3yNuF9EnKrzIdilOu79x3ro2Ioy/NUBUC+p3iRy7dK4yCVU7HeYuGMevN33ysfYJtEkWke3r5IV04RB/j89S3v0udppVjbN7NGa+3TZUbSxGSgFMdUPmDxFPlGme5i3928iXSjLSlqj38oWNoKCYt1PudXEeeMVxy+bAZc2DA5v9q9waY6yXhV/14VeUKq9an6FEUJAbxBSCNFTrmyIbbYPxZVFWY6764TYxEArrIMaSz+KRc3JhYQwDYW2qv7rQ2Ac6ewynt5JXm0eabvsMLRzr0N0TAliC44qneYB3wypN4kthf1yrMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxYLS8yY8+C5UHIOz9nz3Bx5mYH8srTmRXlal6rArd4=;
 b=mt2ziwH7G6t0TAexSxjsNlxbEonwg+IK6ymLwv33Q+teBa5dtHh74X6jzYbymd0QDHiyeDO4U2de9RsRiRgvRdA078KCySPxhQxs1Bf8mNhb1qjGvTd0zkD1xtH35EKXEBUzQkhm6c6nL7Pf8WVTiLPtR5Pch6Dks6ty8TlEbsl/jYsfBGnbZP8HL2hykCY8QjYZ7E694FJgEMxqtd18Y8InlD2mddvX9WcYGnzWwpj4RdAnbxmLKO++saghGD9Tqqueg9Gt/enFwHrnf/IlDXP4HEpKdUmrlh+qyScny8p3ElRYJzCm1ipyTT/Dhcn5KA3J5F9SCZBnUKtFvMxFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxYLS8yY8+C5UHIOz9nz3Bx5mYH8srTmRXlal6rArd4=;
 b=CjfV/20vsCYmpD3BSD47+I6DXiTCPNBVfnpjQkjOSjT7RuGTH1fggmkUbgIkqcTQPdD3YiFdFMtZ5Svki0lt3iLaB4wVoUUZLLlUDPtsUJTXUi/VFeaQ4Tpjmo5LcqqTpGU0ahvdJP4qEZkg3FVy+JtuQKA4lz5SkceXAJJNjCaBMXCe7U8SrkrNGE6oUz8psW3utQLgyL0yUBmxJptEsTBoNELjqSbBLwLmLulBs8YLZ3BJ34MCW8ispYEobWpdphkPAyG6Pk7/8swKbC3KI9Jed9zjp8So8FQH+zDd/OVLaukqPGb81OivCu7ateGjF3y5oTBUfQoD0Uus522Jow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ed::13)
 by DB8PR10MB3211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 08:58:39 +0000
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7574:7fdc:9b12:30be]) by DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7574:7fdc:9b12:30be%8]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 08:58:38 +0000
Date:   Thu, 12 May 2022 10:58:36 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH v2 2/4] watchdog: simatic-ipc-wdt: convert to use P2SB
 accessor
Message-ID: <20220512105836.3fb3ff95@md1za8fc.ad001.siemens.net>
In-Reply-To: <7c458add-a496-6b3a-a04f-e6b68865daf4@roeck-us.net>
References: <20220511153905.13980-1-henning.schild@siemens.com>
        <20220511153905.13980-3-henning.schild@siemens.com>
        <7c458add-a496-6b3a-a04f-e6b68865daf4@roeck-us.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:50f::16) To DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2ed::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b44789b7-03f6-465e-21b2-08da33f59b11
X-MS-TrafficTypeDiagnostic: DB8PR10MB3211:EE_
X-Microsoft-Antispam-PRVS: <DB8PR10MB3211F934569EBC7537802E2985CB9@DB8PR10MB3211.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cH8SgwUJCG+SXSGb/cDhWCgB1Zs/UgpKno5JsgwNvVtGwpnLLhcqGCfapVYOmHCgP08rees/ThK+gItMzoCe7qLNCFTXvL61ht9ipW4yIWip8XHTFb01umPutZHwtPVtoijnPkCggh65j9UK2NmyGw2tmV3OglNNSwzHMr+fAi0g1LTypVPl+4LnteVcu67qnpjZJPK6W+/aeqSsF4h3ecIfy+1AtoUOd+XKGqAAf2Cy/kCNtQF2L32JnU3XEPcfUKlwpBj3agb/LJTLZqYqE9bO69p+ztIFf8SFExkHA/CDFSqv94vn50E1r2towEuUnQ9FxyvGRh+9O3o9Z0dQugzFvZA8kHBy3zvIHdCxy7HcrD1gg28Ucno/RWBFpcXgOiSTYiSFDpXp5jxaDFU3bZH5PiHBKILQ1pLfIMR0HTODhqPOlvIzeMdR7n8yT21MO+O1OVWRfNh4tGISCJC+FKKhwhd2GMtErjztX8mdIcNdCqfC7OFD3HLMmDyKJwwIoVt1zlUlU/04zi9E5Xfp6AcMjASIjX84ifImf5rp6JSBNPII8iR+lDyeyOdHFFLMHhnjn0qkk4YobJ6BA3vb9zkvUWMkwInsl4iQcMOXZhHI6/mWlyxcJWcu4AfKluILs3ACqb6Pjo22y70lpnWClA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(5660300002)(1076003)(6506007)(186003)(2906002)(66476007)(66556008)(66946007)(44832011)(8936002)(53546011)(86362001)(6916009)(8676002)(6486002)(4326008)(9686003)(26005)(6512007)(38100700002)(82960400001)(498600001)(54906003)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y1qWKtAcdg+ymxQd7KhZ+u/SnS1XtqsoOiKyvdkow+zt7A5px2+tiPqPLMel?=
 =?us-ascii?Q?bVkGYCMHGAHToUn0bnBymhwmFlTqXPgJGf6EETckb553Lkbwiz9mDo3X4RG6?=
 =?us-ascii?Q?/1NuH0KUsm+5O20OL7m3K2VJ2nFXzy0LJHcql2TIRHibVDMMP7FNPfdfimpu?=
 =?us-ascii?Q?z0iBoSsKsUYta4aVsRSh+n8/6szU0Z5eE/A81xt89QPjTlgefUT16iTnOStW?=
 =?us-ascii?Q?IAPNI6Vau8hz2LYwS9NbTGxgvCbjNpSHBkmszgCHGYpB0pVFDH6TuU1Ur3FG?=
 =?us-ascii?Q?muyG0uPOcDzcUzSPMofDnNxOwU24rGo+3mTHGmQdtecDQf9TvaEhl9sFJIex?=
 =?us-ascii?Q?evPusHgVlR2l6X2NYZoGE3rR1z4aLo7VzEUzqWvoc7C0SRakUxMlN6pb/gcv?=
 =?us-ascii?Q?s8T4p1Rd/7tvOBdwYsbP2ad0bUB2UedPlvL9HQtV/ZLkk1ktWsvjpWGEin8Q?=
 =?us-ascii?Q?0lA1moqRPbb4Ts3wbVNepuAGGJQ9zsqnWWL6Vn0NxvJQ8k7cFIMDiSt36rPV?=
 =?us-ascii?Q?Gg8R9LX3r0/yPYsqRwAcuWl9PjC9JfSBj8ub01bAo0NOUmSAQqkk9dr5pxa/?=
 =?us-ascii?Q?jqeg4XAgk0reNKfG4BDLMgFjLNWo1S/mJID2KL8+RSCLYLEYkRrUmFug2vp/?=
 =?us-ascii?Q?6QLhJrWEzthobSjeOvD3b+Cxz/kDzBLOtmjuikcmbmoVSOXFLx/d4hibPZ5T?=
 =?us-ascii?Q?NFR/U2leNlYlXVzpHyGvokfLKGpZsVTy3sXa/7w3Pq0uBD5W37sFY15d5AB5?=
 =?us-ascii?Q?8SmxV45wNcE1Pae0B2Hj8mwdyQtFtbhbTDdWTTdUNhQbhXigQh7jyMcgDl70?=
 =?us-ascii?Q?HXZAYgHTnxq67570GEWrCJiZ79NmbepY6KLrAg1gxv5VoiXaGtC7or9xhoFg?=
 =?us-ascii?Q?+v1Z4ouetB8nASI5zyb+THJ619VWyAHo9yfJGg1PjZ+9RB9RDvMDyEGY39EZ?=
 =?us-ascii?Q?KaD8PnukygDFrmRYfzy90dPaiPgTD7SLrp8cxqjd4e1l1bmGOAbgz7JrFnWg?=
 =?us-ascii?Q?K3AxwVL0gwpT6Dx1NgRRxvtBzJ74EupTaWQAymvc6eFYC3g530YiN4KWRny+?=
 =?us-ascii?Q?uiTf+ieriEUWd+xhEBORtoowKFTQct5eiUmY5NKDnx2p96XVz2uIoqpJfZoe?=
 =?us-ascii?Q?8TPqAJhty+9vx1v35+U52VUyMf/Y7KcIN/0wGND32gdCCuFWJNm30ZcUpHU0?=
 =?us-ascii?Q?Y9MxjiIsRGliWQWfR9vfW+T4bwq9KjW+mnSYg+PniY2YXSKjwVPcgoKm4qXf?=
 =?us-ascii?Q?s1EwkC5dQ7XDVeKU8dYQjADJSHn7PdrkIJ5BJcFXwpc4uqYEckQgd8ZPcQfQ?=
 =?us-ascii?Q?+NBnqVcJ/K5cUwp6aQ7+JbgP/MNcYKVEtUb1N06ROOsU6ODDUEvFnfaCDeWe?=
 =?us-ascii?Q?OLch8y71aQEFzgLdlnN0i1jBmi/3G3xrsfMRb7vr7hYfaXaBAMu32cWc7daM?=
 =?us-ascii?Q?hL3ikk62Lg5ySnB1GmZm+cmDWcxmpj2SWbGOZQU0RUIRXAqKx8ArqHDefdpf?=
 =?us-ascii?Q?jAXHzjPmUDMI3B/OVYhyVUOClj5sMsjF0Up7fMuNtcsBJAI40P4DI0sZEO2h?=
 =?us-ascii?Q?1jZgEfc6XKaeveDcxZg3w22R/LnhmlkCQV7jJYyrswpbc7kZHYqmVTXGGMof?=
 =?us-ascii?Q?l4xfX4ao0nhuIp3CwHhe3L8UJ3JWryzCCs9t8s2e7hy6bWrhNMgWWoWZPzEB?=
 =?us-ascii?Q?A0EC4zEtMo3LyC962l3a6WLcTR8dN6TRPY3xddtbFaTpcxfgKRpUWpGLWE/R?=
 =?us-ascii?Q?YH2bLkuUW3z9t8ca92ZMinJ1uB5YyCmJJHJmm/rgTC/SD7CDZXO9?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44789b7-03f6-465e-21b2-08da33f59b11
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 08:58:38.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5Si+QI7BmkcNF1KioNYvfpDXDV8wGXycM5AMy62jpfrXrmcjeLGODMqxNZSRYQdBi9cuLk56eQFTn9zYajBmNIIcDPyYDy0dHp96pbV5eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3211
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 11 May 2022 11:03:04 -0700
schrieb Guenter Roeck <linux@roeck-us.net>:

> On 5/11/22 08:39, Henning Schild wrote:
> > Since we have a common P2SB accessor in tree we may use it instead
> > of open coded variants.
> > 
> > Replace custom code by p2sb_bar() call.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >   drivers/watchdog/Kconfig           |  1 +
> >   drivers/watchdog/simatic-ipc-wdt.c | 15 ++++++++-------
> >   2 files changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index c4e82a8d863f..643a8f5a97b1 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -1628,6 +1628,7 @@ config SIEMENS_SIMATIC_IPC_WDT
> >   	tristate "Siemens Simatic IPC Watchdog"
> >   	depends on SIEMENS_SIMATIC_IPC
> >   	select WATCHDOG_CORE
> > +	select P2SB if X86  
> 
> Why "if X86" ? SIEMENS_SIMATIC_IPC already depends on it.

Thanks, will remove that.

> Also, I just noticed that P2SB is neither in mainline nor
> in linux-next, meaning this code won't even compile right now.
> That should be mentioned in the introduction e-mail (the use
> of "introduced" suggests that it is already there; you could
> just use "will be introduced" instead).

It was kind of in the cover letter, but maybe not verbose enough. Sorry
for the confusion. v1 was sent in-reply-to on top of P2SB, maybe i will
do that again for v3 but for sure point out the order in case i send it
without the reply.

Thanks,
Henning

> Thanks,
> Guenter

