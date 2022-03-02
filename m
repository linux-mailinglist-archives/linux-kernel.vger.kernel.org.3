Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75634CA059
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiCBJKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiCBJKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:10:16 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C505B91AFA;
        Wed,  2 Mar 2022 01:09:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSQ8RzzSxOKx6lJ6FwlGv6zWew1hGJy4EYOVgW2MSYq1qWcauHJuXaObVGsdbTukh0JHVOBNrPKaW5We9QHPPa3PW8w7kJpvSFOo3RrTfGRQplNrrhLmYVkPYBzrN7Wd9svLmQ5HpWA1HLExgN1JxWowo1kOoGCBypBb2WQ30AwxcuUbuSN//Xyz5XyseP8KqyIGfXA2kCjoY/V7XEFqmzE/WEUuyiWiYbiraCw6hbYpDeinVIuV7TCMutXjePPDzC/XvfT1IM25PLx6QUK7UHjqkyIC+UjMPtr4rw0Zk9z8f6APSg6JHebm64tvv/kkKRmLTvsjftFF+uWLG0k4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXktILI0PfZJ5F8vsfW1awWiliHTwPcMwz+znL6DfX4=;
 b=bEgUnBAGvYqollxOc4NYHgiRSBgfFb0CIndRL8uVOnBHWdNEmHxJABzdrXUA2WHPVy/PBTjYLa80086CmQn2ZPN3VXxgKEvG3kgwoqTM3cj0aK2vJiluwG8BZZHxNFeWLt3ylhKKxbmKop/6RuU7ArbbEWhd4/5OEhogOizXGnFno+/LdI4ME/7nb+CpyEqL2gQAkuZhaH8cIdafyQ7aLIyZNIb+aO+CzPvRqcOKbedba1h5p82G4ZD3PokjmkcuZsFe9KD+SahIKtMe0R/S/HQ3alXHYehkoafc+yo+Wy37CVaTUfKnwEIAAqTHxX6pUkOzZ/TmEOQJcubmiL4QzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXktILI0PfZJ5F8vsfW1awWiliHTwPcMwz+znL6DfX4=;
 b=m/jy4wYVhSEG94AA90O65bj9N8E2CnF1QIjicrOzyuqoFbqMDw8MuqeuGu5M1KsKLYOumkcM3Qapf2m1jVz7qx/xdScC95BpYNZVooGITcNQ3qolNddIt4/uZ8YS8vhZTWeiIr5wjTLIT9LkczatOlatu+Jb0LYvkryYvw28Stk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM5PR1201MB0091.namprd12.prod.outlook.com (2603:10b6:4:57::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.26; Wed, 2 Mar 2022 09:09:31 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8%6]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 09:09:31 +0000
Date:   Wed, 2 Mar 2022 17:09:07 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Subject: Re: [PATCH 1/3] cpufreq: amd-pstate: Add more tracepoint for AMD
 P-State module
Message-ID: <Yh80MwmHqAXK+PbD@amd.com>
References: <20220223100350.3523826-1-Jinzhou.Su@amd.com>
 <20220223100350.3523826-2-Jinzhou.Su@amd.com>
 <CAJZ5v0iaY3tsNKFXv09Z4wg_2R3+9UsSnqfPBbOYFaqoVS1qCg@mail.gmail.com>
 <BL1PR12MB51447B1235E91A81309190B2F7029@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CAJZ5v0jDbNVEtRiaiUXembZB2r4uxVy3iKO0aTqOJsB0rLpV=A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jDbNVEtRiaiUXembZB2r4uxVy3iKO0aTqOJsB0rLpV=A@mail.gmail.com>
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a0873b1-c927-4839-dc63-08d9fc2c5c99
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0091:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0091E26990063BF83A309E61EC039@DM5PR1201MB0091.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gicSsCkd9O510YPUgAs1qI48a5aHTZHl2KBAbQy3GPEciBrkEF5EpGhHaqVvo9fdL/AElgQ2666fjIFcrjEtSxF3Yb3VIXgo9+IxtAiuhaI0WmGTPOgs2OEtdN3T822A3IPf4AKg6uRnQtK6drpobKBgkrYN5CVUtnzCwW65wJgN1j2bokVjabgajfmd3a5uJ+pPQkKZVaHJFwa94ZAkB8rQX3IbHMv81N8fAoYvlgwxAjiwc7xVKvcJkSUZi9k+jUbS6eLN9F7a9eluqa2LSfu3vBsNM/imK6xbIDV3QEQGqeKC3mkH2FxNNyYrgcl3RHzwenCNKE3wj2wHNFTTfB9+1ffVMfKZXgLO2yTx3k7s4yM5KINU5sxORsaLfyFAO0gDmpsp3304WS/rASCvAk5Y/R9TOPslSHyOvt00Ikx9lWn8dTpoUrA3SCsH/y+DSkNoiTPUWsY2xkv4W1YTEA2AOFW5zW9HxK2I7USBfNNFrdZ+GwmwDLSjZ5GFlMov7KwwH5WWbdd2tuwceZTB4fMXZZ0+CBVMJZTW5qd0jRY4MCzA/caZXxiQo8i3DLBfuKeuBYA1s6DiSr7D/nAxSH6OCzctZbFfTDnd6jxPKqVPTXA7S0tqz62W/sh/bZEhID8cnrw64HnFeDvj5FCIfadGHzskNgRO+AIeAik67d5m2ctHsNnU8RVn7ReksXZe6KXc94SpCqIfS8j+p7PPCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6512007)(5660300002)(316002)(8936002)(8676002)(66476007)(66556008)(66946007)(2616005)(4326008)(2906002)(186003)(26005)(38100700002)(36756003)(53546011)(6506007)(6486002)(6666004)(6636002)(83380400001)(508600001)(110136005)(54906003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PT0sq6wk7EB8s/Nc97WSOx+jS7YFtL4OYsCoBlTauggfKrHSSvXMk61IytQU?=
 =?us-ascii?Q?GY0jTMSZCxI2z9S1OLpT3kmLG9Dp0QTS961ON1A4YNiUO4eqPAgPoKkAfFni?=
 =?us-ascii?Q?GsLP4j36ZxZhWVQTMxogNEonaeehtyhd3QQFDMsK7NvMOd8R3hAnLqNGHXTd?=
 =?us-ascii?Q?chk4PYvQz9REaJT23bDj0Lh6/V+dMxcAYeg426nuDYqpa9RxmN0BxL2k8Tkx?=
 =?us-ascii?Q?Ig2sspJcO3balTq2NJnj1AsshfO+Kytt6kECbJVT5kmK3KtUkIUfAQBfWjml?=
 =?us-ascii?Q?UZs4gHxVyNb+Co0z2a1irVeKQliw9NKDCGChg2p2b7UxUpbZTmPZ1UKCdK2v?=
 =?us-ascii?Q?EZSofwcBRnlKq3I+t0Xq7ksOVR4hgeZMuyt0yjX6LUKCMxhHXKeRWyRoGp5m?=
 =?us-ascii?Q?D/yzGCL3yYXajGr9ju5rhp5v2j3o7X/IKPgKoTRJk7fdAWTz5awZPjgAhXKW?=
 =?us-ascii?Q?Sqh90x4fuioWuULFB/54V4amwaQFOMRX9lGd/N2pvt4p7mpyIhBlSDNCbpka?=
 =?us-ascii?Q?TY4PBk3QFtOsMBVAHnZBu80COfBYdkRmlS/cjUiYTfytsByN5s27Zt0Z3Qgx?=
 =?us-ascii?Q?whaKG5w2PpR5oXwiS51ILMksYtmf1Ba7xeN2qHDVf/+kSjh8+d9Fq4Sl3gov?=
 =?us-ascii?Q?LZktIsKF/YnOQ70DyRLRwCy+ZKforYqomvFthNgv/DQItUN+mA/0yAmBPJ+u?=
 =?us-ascii?Q?XAe+S0pQOobTG/478ml10/ifGMY86rJylCc931I96Rgzy+vyMIiLkTEx5bn7?=
 =?us-ascii?Q?tORHlkFEJgSn02W4fbJBX56gPaK3PlbPP5hZHMZhWfMRIkW2mXcFuH6Rgz/I?=
 =?us-ascii?Q?Bwm3fwU7eDRNvJVb2YP+vQ9U350UtcFa/pa8Nwv1tat7EaerkesIqcEdXBca?=
 =?us-ascii?Q?lR/ykbf4iLMhxdlRbND+NMq66xMTfuDgzwMiGupuyceQH0BRluhScJE/pa5e?=
 =?us-ascii?Q?QPQqwbLsQ3Zwo0zSDqiPObhVyPom68AKZhtJ29rw5e4JnoL9JzGiuv9Ekamd?=
 =?us-ascii?Q?/My6TR/7fMrC+Xux3IocdvxzNe5XgkuZK0okNT4cT2K8Qw1d+KQ9Alze71sJ?=
 =?us-ascii?Q?CaTbjCZygn+YaQ1DAB11h/9Ksbouz1QGpcTbr+RN1crXXjhfKiC/iEXCChQW?=
 =?us-ascii?Q?mCfbg8YGnk/UAmEuUCY2ODqO2e4F2Pb9LBUKXpmBLtp0jEFZmGP6b5u0jZiE?=
 =?us-ascii?Q?pazaXNtgCoSjREQ7XoWg7hCvAEvd65b+fSom0ucMQJT3oeYQ3kt3e8/bhV8P?=
 =?us-ascii?Q?LnrqgMIMqB1Y4GkjV7AydFD5uRvJC+gHlp/yOIrr3ZobYp+dprqcGqDSTqXS?=
 =?us-ascii?Q?T6oRAvekuAXm7/DTEQkxkkteTY8vXYRhRGc4U4HlfspLGPijQbmjBmNbYVO+?=
 =?us-ascii?Q?ANOEL2XfDCIARVudyc7WmiSI7tqOzBzEY6nCLMXqx+RBHEk09Uy5QYwLqX/9?=
 =?us-ascii?Q?I6etGCDVktXeZ+cfsJTpiZVd6szYU7IMG/k73WN0RVMqcxfULKoeOXvG08o1?=
 =?us-ascii?Q?YxSZKz0OekFTgAGIRER+kQxBo7+tUl/EdhmRBjY27TJszhlx0nYj+auVIcHU?=
 =?us-ascii?Q?TbD+PbIreAzW6K6I5J3je5QUdfHDVzHlh3T+lTfPVOB+IQbULe2Ssx/4InIX?=
 =?us-ascii?Q?jEX1womAxlFE/TCJz1x+We8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0873b1-c927-4839-dc63-08d9fc2c5c99
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 09:09:31.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4oBOikUhwGXkPTduo7fw3crDT2zziHiU+RNq+hL4nUDgD1mZmc6hIdwCemkXC7ZdIH7H8FI3s8CHichfE06tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 12:07:45AM +0800, Rafael J. Wysocki wrote:
> On Tue, Mar 1, 2022 at 5:05 PM Deucher, Alexander
> <Alexander.Deucher@amd.com> wrote:
> >
> > [AMD Official Use Only]
> >
> > > -----Original Message-----
> > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > Sent: Tuesday, March 1, 2022 10:26 AM
> > > To: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Linux PM <linux-
> > > pm@vger.kernel.org>; Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com>; Doug Smythies
> > > <dsmythies@telus.net>; Huang, Ray <Ray.Huang@amd.com>; Viresh Kumar
> > > <viresh.kumar@linaro.org>; Todd Brandt <todd.e.brandt@linux.intel.com>;
> > > Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Sharma, Deepak
> > > <Deepak.Sharma@amd.com>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> > > Yuan, Perry <Perry.Yuan@amd.com>; Meng, Li (Jassmine)
> > > <Li.Meng@amd.com>
> > > Subject: Re: [PATCH 1/3] cpufreq: amd-pstate: Add more tracepoint for AMD
> > > P-State module
> > >
> > > On Wed, Feb 23, 2022 at 11:04 AM Jinzhou Su <Jinzhou.Su@amd.com>
> > > wrote:
> > > >
> > > > Add frequency, mperf, aperf and tsc in the trace. This can be used to
> > > > debug and tune the performance of AMD P-state driver.
> > > >
> > > > Use the time difference between amd_pstate_update to calculate CPU
> > > > frequency. There could be sleep in arch_freq_get_on_cpu, so do not use
> > > > it here.
> > > >
> > > > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > >
> > > I'm not sure what the second sign-off is for.
> > >
> > > If this is a maintainer's sign-off, it should be added by the maintainer himself
> > > and you should not add it when submitting the patch.
> >
> > Both developers co-worked on the patch.  Isn't that pretty standard when you rework someone else's patch?
> 
> It is, but that's when Co-developed-by should be used.  Otherwise the
> meaning of the second s-o-b is unclear.

Yes.

Joe, can you add below in next V2:

Co-developed-by: Huang Rui <ray.huang@amd.com>

Patch looks good for me, could you please add new patch to describe how to
use the tracer script in Documentation/admin-guide/pm/amd-pstate.rst?

Thanks,
Ray
