Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCB4512C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245060AbiD1HTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245009AbiD1HTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:19:31 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33309A98D;
        Thu, 28 Apr 2022 00:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOhxswcg0FUi9XxktyuzCR9Vb34ag/dTNxUN4zS60SgkyqPYHElqcPYhlwHHXpi5TD5joD7drx9ki+rIwiZ1f2lgOdQwvGF0vKZTUb610abGeVXOR5LJ/UOiU92csHKA55cjTYM6KRPOiWIIFdr8GhydKuyyvmSSFzAUXVrGIg8qAJyRljB46cF3Gmdp4qtke9AbsnJjou8c2RN0NRIetsQp8Vu6iobr/fyBwMqlgnoSIdhNvVRs1Lcu/UPf220rkHjCOY6t8Fme2gYUqkYDCELc6J8pD4FoDPsi+cpH54ojBXMSiW4AwnbmwJZNX0+zjXrVOSBURnq6dntN4ZuRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyD/CVQpb9ifkGV1+Us/qJ5wKHlFpxLca+lSYXEmGdE=;
 b=G+DeK0SW41Hsm2hcoJRDez4MbRDZgO/w/jsgHP34O027Ar9I2OtBurPQHEqX/rj8UIGziXHoNRgV6wa96tclCKVzkDltvuLFpdHQFLGU+23zQjLflkc/ej+vhljqr8crKtWByPAxqoekfZFsRB/xKsdtFxFrARE4pTLw7dikSwtEK7lQvUc0ngiYsdc34Lc6cquCZtM6yz0krpmKDsDtb98kFCCvjrx243bGDMq/TxlszQEWQPmhtiW3InKeq0ZAGe1O4EWWyIe9BuIlzckNd+1ND2JlguMi0jtNcIz/bAKmAcKmQXIlR4zBGfUtavlG9Z0KCk52KGUdKuu3NGyExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyD/CVQpb9ifkGV1+Us/qJ5wKHlFpxLca+lSYXEmGdE=;
 b=NfO93rWDhoSVDsEE5w5LxVLIq9TxxuJVD8f7jlYKJx9PEVj2RbjEe/aQRc/Z5iONhTRR0F0Y8JlInmofnHmHQ4IOshJ+QK5/EuxrF8UaJoWZO9TrSKrBJL3GYgdY16k5siTVRUzRB6tciTn7IQlVk8X4H23VMPD7IgOayWT5fN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Thu, 28 Apr 2022 07:16:14 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d%7]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 07:16:14 +0000
Date:   Thu, 28 Apr 2022 15:15:47 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] cpufreq: amd-pstate: Allow replacing acpi-cpufreq
 when loaded
Message-ID: <Ymo/I5AQd1V0S+Qu@amd.com>
References: <20220414164801.1051-1-mario.limonciello@amd.com>
 <20220414164801.1051-5-mario.limonciello@amd.com>
 <64d7f4f7-3c05-7f37-d9eb-72d9d079f8f8@amd.com>
 <BL1PR12MB5157CC5E942986945F5EF088E2EF9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0hFstH6goScEhUmZwBQ4gEnt5-tcp=UKgrW8Xb5zdZ_zg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hFstH6goScEhUmZwBQ4gEnt5-tcp=UKgrW8Xb5zdZ_zg@mail.gmail.com>
X-ClientProxiedBy: HKAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:d0::19) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44d5d978-68a7-4044-80de-08da28e6fa42
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB413816FC4F46750A5AB93274ECFD9@DM6PR12MB4138.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBhLPKwBIK7T0CuLM/ilQcJ5HDGXq+V/gd6oP8A0UuUAHoO9XrRtWVedALQjdVB4h6I9bC7B2G9A1uISmjqpvFVLlLxlO4kaMzrbS0Cm7lFTeyxVqRFzRc9YR8CA173rJSZZOV7Ew6nbjBtx4H1UF95bnbisWjcI0YZ71ROU8HhrHCKnUKt+FOoX5RAYkSLTlCu//E17i5mAWGpfD1GXnx5oSAfcgikJ0F88xu4M21Bddv/T2Abz6gCybAus+frqQ8j65nBAUsU47Bic2r6v8Np79UWaTKtfFkK/AZO/nAPvsmgD/E17yRWMs10U0SM947GYs8oCdHc7j+4DfWdHBsJpwjLo/Xi1xoqSPj1FywLNMt8ojlladB3nNSX5r75OA0nJxHqCHjFm1bXRLqtopHHw//WY0WNQ9wmDmjHeMHm4FvRrGkzpyagXQ1w6WmnvzwJL4FoaymiuMerxXthMV1vGl6OFpAiPP4mFUAtY2jEJf3GrfpykSZNuQ9dK/yYZUT5tDg4aF9u3FCDMGzO4igwTWeNb31mG+PNcQhKRvC+CR3fDekqwrdIIGJm+I7/t4H9Cr2HgD6pKFeQ4ngY+txsCGx95wtdNe9ZYYj0C/moqINx7hZxe6sRDYwC70Di3lNfI4vDaNirLhO616Tk4pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(316002)(54906003)(6506007)(38100700002)(2616005)(86362001)(36756003)(83380400001)(8676002)(66946007)(66556008)(6486002)(66476007)(4326008)(53546011)(2906002)(508600001)(8936002)(6666004)(186003)(26005)(5660300002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jXX0OqobDSwge4sf5vHMHekxHUuxbv3vG9EtP4WTmzdgJgqL/9PlXDi1kFik?=
 =?us-ascii?Q?P/1DUMquTlhp97L7ST9jbLxwpnxOz7dwixJNUq7EbsJOjAXMRWi7BN52Lecq?=
 =?us-ascii?Q?G7HQZ9h6a+cpoHnF852979k36aDos00T/594LAbpF3j6pfqOJcAcWs5pRWhZ?=
 =?us-ascii?Q?wo4twRLrp5GUYePH2aEGDgmoiwRDdfRJ4yB4DYCcH2kxjggfISCxCji5nYpD?=
 =?us-ascii?Q?S/2O7iN7RvPVOFZbxuYlYgztIpgBUXLFfxgY7FYa/TM2e3p3tMQwSKkJD7i5?=
 =?us-ascii?Q?8qUXoB8XjEmkhZIP92GCAJLQaeQgI/OExZVQiMGYOdD+Nfyv2dBAZRM3Xvnj?=
 =?us-ascii?Q?TorKOysN0hOf8h0ZOzZV5a+BIUwXL7NPRQNKLoexlT/Cg16NfKYKef235suX?=
 =?us-ascii?Q?lFzVuZBOc7ACnzR0euwhq8cxVtsKrKJboCKLe2JQAXECPPEctG9RQOcHpLyV?=
 =?us-ascii?Q?SDEUuTJNSx2eWb5CMoPPVAP85aj+j37GruOMj1EEy17v1lY+N0lK9RRhd57f?=
 =?us-ascii?Q?gEA8Gy+bS0PLqjLGc5cOq3QUlakQd+6tVEK7gtcxnN0TNBFblCs8GPz8FPcU?=
 =?us-ascii?Q?NGMNtYInSeULgMNwC78XXTNAdrDVs7zMVJFTtRYDT80KWRwT6W/ae8xGT3o4?=
 =?us-ascii?Q?7m9AdCRWIkBZB+9A7ygP51eZEjj/7dz79kVwrMzPDUazWHTDNfB1aYcAo7YB?=
 =?us-ascii?Q?iHAoRHhREXHouBvzlYDsSiwgyiJByCJsqpgyrXL9vQ2BwzUvbXzgv5vPX5ft?=
 =?us-ascii?Q?JPqU21aqZ7yMHZ/HOG3Hpo6syDk/kfX9ZSVUeOH2L1eUW9JlzaxafVkzgmci?=
 =?us-ascii?Q?rZnJ3ejxLdIuoaR2oXwQTeBnKATEnB72R9YXOqEs171hkfM4+wsUDQdJpieE?=
 =?us-ascii?Q?+fZo86JsZIPzAU29rGq0IXPodgduO0MoskO5a44A64Q/mYSjX/6vIREaT9n0?=
 =?us-ascii?Q?xovIHdC++nthyMOUJdcHqIpJzb0TK0cpaQCO9w0JCm7czdZYPViKLiQcxV2B?=
 =?us-ascii?Q?nUTSuyLxuND2D6Cd8/O+08PtCs7j3A1nyf5LI+2meihbBdse0KUEohxt0lh/?=
 =?us-ascii?Q?JhgRIfYkui7E1o99hiZMpcftcKBmUmCLCSHROyXojmbj5iwBvClPLViZS+yK?=
 =?us-ascii?Q?Pl3t/Py7nwjEzucl6rKsQQ1FHGBsGKumHSgJYLo0Cql91JQ48WM9TfUw9IQW?=
 =?us-ascii?Q?lxAAprec0npT0fUbljuCYMvhq1cAYMClD7vUvpynyPgNGdFrC3vaDNnsJPbG?=
 =?us-ascii?Q?rfoJEI+vPJOCl5aWFD9yDmjxWx5+jZQNeTrojBT+lWgJypM5UA5jn7Y+oDgF?=
 =?us-ascii?Q?JgrGeVez5D50Fxuv5D2JF3frb9wjnn7BWMHWi4dsFtMcU6esjjq58/n/7Vwc?=
 =?us-ascii?Q?bffKXhkYrImwbojTDR0yhCjJwt0BrREY1CVSln1ga17kaiXrzZFsiXox8RFL?=
 =?us-ascii?Q?JXUEMH+SVVTSGTEtui5jW1XYLiU41+yeSQS/OKM1sBY3Xd6eZk9HJEEO4XMp?=
 =?us-ascii?Q?ib5+PlVx+pIBQzI6hvuR/ii2kbtlPqCMtsibhH8RnI/xxjAIDxseAMG4aOxH?=
 =?us-ascii?Q?I9eunlhL+KJVoY0QJEhoJ2RZaUTo9uybTnb4wbDwkXhQWNkCFlRlSYbtpp2e?=
 =?us-ascii?Q?8WqqmWdw/f4ZgIiRvCMBZQa/SckXXAQdTFNJOwTn3wuLPI5pVGRgTNPFP5sk?=
 =?us-ascii?Q?XthnkXJNkRzqyupMhonyoo5Sj6tUGroWKQkZE2T62PLiMO2hIWE0YcUMxyY/?=
 =?us-ascii?Q?fReKIifJRQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d5d978-68a7-4044-80de-08da28e6fa42
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 07:16:14.0722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAkjClJIqXOfkudpTUoOw97JNFvlM8dNN8yMq4RTVtuQ7xDExdQnRtFomyN0ITRUyWgvAZE7JQ3YKpxoO06urg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 02:38:32AM +0800, Rafael J. Wysocki wrote:
> On Thu, Apr 14, 2022 at 7:58 PM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
> >
> > [Public]
> >
> >
> >
> > > -----Original Message-----
> > > From: Fontenot, Nathan <Nathan.Fontenot@amd.com>
> > > Sent: Thursday, April 14, 2022 12:33
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>; Huang, Ray
> > > <Ray.Huang@amd.com>; Rafael J . Wysocki <rafael@kernel.org>; Viresh
> > > Kumar <viresh.kumar@linaro.org>
> > > Cc: open list:AMD PSTATE DRIVER <linux-pm@vger.kernel.org>; Yuan, Perry
> > > <Perry.Yuan@amd.com>; open list <linux-kernel@vger.kernel.org>
> > > Subject: Re: [PATCH v3 4/6] cpufreq: amd-pstate: Allow replacing acpi-
> > > cpufreq when loaded
> > >
> > > On 4/14/22 11:47, Mario Limonciello wrote:
> > > > `amd-pstate` can be compiled as a module.  This however can be a
> > > > deficiency because `acpi-cpufreq` will be loaded earlier when compiled
> > > > into the kernel meaning `amd-pstate` doesn't get a chance.
> > > > `acpi-cpufreq` is also unable to be unloaded in this circumstance.
> > > >
> > > > To better improve the usability of `amd-pstate` when compiled as a
> > > module,
> > > > add an optional module parameter that will force it to replace other
> > > > cpufreq drivers at startup.
> > > >
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > ---
> > > > v2->v3:
> > > >  * Rebase on earlier patches
> > > >  * Use IS_REACHABLE
> > > >  * Only add replace parameter if acpu-cpufreq is enabled
> > > >  * Only show info message once
> > > > v1->v2:
> > > >  * Update to changes from v1.
> > > >  * Verify the driver being matched is acpi-cpufreq.
> > > >  * Show a message letting users know they can use amd-pstate.
> > > >
> > > >  drivers/cpufreq/amd-pstate.c | 22 ++++++++++++++++++++--
> > > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > > > index d323f3e3888c..8ae65a2072d6 100644
> > > > --- a/drivers/cpufreq/amd-pstate.c
> > > > +++ b/drivers/cpufreq/amd-pstate.c
> > > > @@ -63,6 +63,13 @@ module_param(shared_mem, bool, 0444);
> > > >  MODULE_PARM_DESC(shared_mem,
> > > >              "enable amd-pstate on processors with shared memory
> > > solution (false = disabled (default), true = enabled)");
> > > >
> > > > +#if defined(CONFIG_X86_ACPI_CPUFREQ) ||
> > > defined(CONFIG_X86_ACPI_CPUFREQ_MODULE)
> > > > +static bool replace = false;
> > > > +module_param(replace, bool, 0444);
> > > > +MODULE_PARM_DESC(replace,
> > > > +             "replace acpi-cpufreq driver upon init if necessary");
> > > > +#endif
> > > > +
> > > >  static struct cpufreq_driver amd_pstate_driver;
> > > >
> > > >  /**
> > > > @@ -643,6 +650,7 @@ static struct cpufreq_driver amd_pstate_driver = {
> > > >
> > > >  static int __init amd_pstate_init(void)
> > > >  {
> > > > +   const char *current_driver;
> > > >     int ret;
> > > >
> > > >     if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> > > > @@ -666,9 +674,19 @@ static int __init amd_pstate_init(void)
> > > >             return -ENODEV;
> > > >     }
> > > >
> > > > -   /* don't keep reloading if cpufreq_driver exists */
> > > > -   if (cpufreq_get_current_driver())
> > > > +   current_driver = cpufreq_get_current_driver();
> > > > +   if (current_driver) {
> > > > +#if IS_REACHABLE(CONFIG_X86_ACPI_CPUFREQ)
> > > > +           if (replace && strcmp(current_driver, "acpi-cpufreq") == 0) {
> > > > +                   acpi_cpufreq_exit();
> > > > +           } else {
> > > > +                   pr_info_once("A processor on this system supports
> > > amd-pstate, you can enable it with amd_pstate.replace=1\n");
> > > > +                   return -EEXIST;
> > > > +           }
> > > > +#else
> > > >             return -EEXIST;
> > > > +#endif
> > > > +   }
> > >
> > > A couple of thoughts. First, should this also provide a path to restore the
> > > acpi_cpufreq driver
> > > if the amd-pstate driver fails during init some time after calling
> > > acpi_cpufreq_exit()?
> >
> > I think that's a reasonable idea; it would involve exporting acpi_cpufreq_init
> > as well.
> >
> > >
> > > Which leads me to wonder, should there be a more generic
> > > cpufreq_replace_driver() routine that
> > > could handle this?
> >
> > If changing the API for this, my proposal would be that there is a flag used
> > in cpufreq_driver->flags to indicate that this driver should replace existing
> > drivers when calling cpufreq_register_driver rather than a new routine.
> > Then if it fails to register for any reason then the old driver can be restored.
> >
> > Rafael, what are your thoughts on this?
> 
> IMV there need to be two things to make this really work.
> 
> First, the currently running driver needs to provide a way to tell it
> to go away.  For example, intel_pstate has the "off" mode (in which it
> doesn't do anything) for that and similar interfaces can be added to
> other drivers as needed.
> 
> The reason why is because, for example, intel_pstate cannot go into
> the "off" mode when HWP is enabled, because it cannot be disabled and
> running acpi_cpufreq in that configuration wouldn't work.  So in
> general you need to know that it is OK to unregister the current
> driver.
> 
> Second, there needs to be a mechanism for registering a driver
> "weakly" for future use, so if it cannot be used right away, it will
> be added to a list and wait until there's room for it to run.

The amd-pstate is a new module, we need to add "amd-pstate" on
/etc/modules-load.d/modules.conf for most of the Linux distro to tell the
module to load at boot time. However, there are some issues that we
unregister acpi-cpufreq at runtime while the acpi-cpufreq is in-build.

As inspired by your suggestion, I am thinking whether we can add "off" mode
in acpi-cpufreq driver, if user would like to use the amd-pstate driver on
shared memory processors, they can set acpi-cpufreq "off" and set
"shared_mem" on amd-pstate to enable the amd-pstate driver. I can add the
RST documentation to describe the steps.

Or I can introduce a processor list (family id/model id) that can let user
know clear which type of processors they are running. Then they can choose
which driver that they want to use manually as well.

Thanks,
Ray
