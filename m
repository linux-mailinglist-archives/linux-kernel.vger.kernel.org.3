Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C3A51424C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354519AbiD2GaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiD2GaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:30:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083FF5BE5D;
        Thu, 28 Apr 2022 23:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imlXelY/zQcVJIXB1sBtmFV+q/FmvCuA5/aDOLdlqVrcNoIjlTsMW2EN0pAiokeDRY1aWEVnZpmiLNJ9EVh74thVOBwPF0TItapb72phXj/ovmu/EFY4kpVFTHaC/Drzqzs92e9p3KfiZ2+Wro9fnbzoR1KmP/P4kZ/XoeYF2pJZaBrARGbQ8v0W7+AnY4hYxCLe+8aklRDVxfW0HNs8TCwiMAKPTVzUhGiKgsqbFaUCgN+NKqSyPIfjMTQ2CiIjkrkZur0W7L7/ECzr7e8Ijah4lPiQqmUboDoNtBPqETRmj6Km13bZtFVsIv5q2ynfQpYBB3i5fFp5fq2Kb2S1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6ghhOClCsEFNaK/kPzvOLI2P+EaCYN9uqm8SD+SRKU=;
 b=FN4LbcODF9sDOOYv2NljSqB6h5i59hQ6tcHe7FdjakSCtpLOvQPJwViJ2kK9OsKUroYhICAwQykKI2dZ9JDqPetkOyfCcuS5JNRhw1J3BUsY86C5OVooeMgEQUcI2DcIoFxfdtgy7/hvaBZhl633BMKKnW87MFWEGQdQysn/FgDovlW5MDqyVvhJoSqP/ezhUF7zqcnG+5/t6o69fKkO/v0Ivzo6F9PYVakdHbH79hDrof6cTc1YdkwMsgrgHA5kcohLzRpV2BknNRkUSb3/vd0y8qtZYNHg92i4RTEuTiWJYFbou8ypXEQ0RGxM78ff/YiXPKHQyqWjuMV0Avyqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6ghhOClCsEFNaK/kPzvOLI2P+EaCYN9uqm8SD+SRKU=;
 b=1RazCxhbOvPFVm0sbadHfvOiWfG63fO28grEMXd3upLpk7i8sP2GjqxA+GvGMf9mdLCGIXZ//OyorsPu0eT+to2bC7Ux5L8aatw0EynTdPTv7Y/ii0HynFHcbu34Es4abondeWOtwEwz+dMAlQZKx4OdA8sxF2X2YRJZcfjquIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN6PR1201MB0161.namprd12.prod.outlook.com (2603:10b6:405:55::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 06:27:02 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 06:27:02 +0000
Date:   Fri, 29 Apr 2022 14:26:44 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] cpufreq: amd-pstate: Allow replacing acpi-cpufreq
 when loaded
Message-ID: <YmuFJJZGLGPoncyG@amd.com>
References: <20220414164801.1051-1-mario.limonciello@amd.com>
 <20220414164801.1051-5-mario.limonciello@amd.com>
 <64d7f4f7-3c05-7f37-d9eb-72d9d079f8f8@amd.com>
 <BL1PR12MB5157CC5E942986945F5EF088E2EF9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0hFstH6goScEhUmZwBQ4gEnt5-tcp=UKgrW8Xb5zdZ_zg@mail.gmail.com>
 <Ymo/I5AQd1V0S+Qu@amd.com>
 <d5db8a44-06ac-08ca-c9dd-cfb837e1d9da@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5db8a44-06ac-08ca-c9dd-cfb837e1d9da@amd.com>
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfbce44d-2c2d-49e9-d793-08da29a9457a
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0161:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0161D84C2957066D7231B764ECFC9@BN6PR1201MB0161.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +t3vVhFNfKMDqk3heY6lIQbpZqBwKqjQvJiDlBu76vYDdXLX4iq3B5wU3dTBf7gjmrPhlo1QEoMf6U2zV+5Bl0TwNIluToSI8OhEq0/V3sDPTP+LEsoIlsEim03CCVhQ3M6o2Hf65btyuvhl0alD/xeM1aaEUOzmpI9UGOYMCWpZc2SUAO/R5KyOUyb+Qiy2J++UwjsTtTDQ3lYYo2lSpBiB7wXMc0U1r87pQehAuUPkgnT3yKy9KaOc2Q9ynahYm9gFxh+WDLSoVzkq7Yrx5weMeyIzh56EHae9bl4YZ50pcbmv4tNZfSY1/qq8Le+ovMhva4qTCKUuS0SyQMakO9fmqjejswdYkLueKWkRodE+44ciZXdOp62r2zBb4pBhLm6zIBFYPqB3U0hRttf/YNop1uO/tEnWt/KKsNTiFZa0emI4TAcqIthR9vdK1gukQ+ojMaRas9eO4Zvr0HfOs+O8OTF7xq5UZeh6DpCnFUxbdyqmMo0NOGPLpSn5w6jVtIG1TOSsTMBcqRog0PQxI/fAdFTaaYMYsvUjKamcmI+UXns0B8m7qyqXhgxMY8DWped8CwZSU2RiFxvrV1xd10jwi2VRCFRQt8Th/9mpyx7CZ67ujxQy60ZIYR/1sIUQRJaoPKFhXGgyF4rafx5YSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(2616005)(186003)(6486002)(66556008)(83380400001)(8676002)(6512007)(4326008)(26005)(6506007)(53546011)(66476007)(66946007)(6862004)(2906002)(38100700002)(36756003)(316002)(5660300002)(37006003)(54906003)(86362001)(6636002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DirokEPtMlUtK+53aISTT+1VsMKqcq9FlQjs+dgHG/13o/AwRSWHdXRnSvfK?=
 =?us-ascii?Q?3rNXczfu13WfCF7I/5u4v4O+pveUQSmOyPGTXa+u7f+WKn8Q2fin5zFt++0y?=
 =?us-ascii?Q?FAyst9v5xoXzE2A2bYOwzTmz5Fv3k51zE1kS9seTOK5sG1Sl/jwDqqFQunwX?=
 =?us-ascii?Q?hkH2mOKL6KTP6c9DUGn/JI/4d8r2cv0hHC3i4MeFcr7qNvO5RHk3VHtLo4c4?=
 =?us-ascii?Q?sWtZkpCTYuC25YriWlYmISVz7ugWWwCCB6Ix7Il7PbD7Jge5568H7s8IIxyz?=
 =?us-ascii?Q?FquY3p+GfyUfa9wkarREq1Hk2yI1uA0K74Mf6p/o4V+gb0xXdsEXoXO6Ai0C?=
 =?us-ascii?Q?qAJAMT1U+r2PkbcZoPTGC9G+E7ZPEEm2hX06rWpiiMn4PKW1MIGa+2spOQm+?=
 =?us-ascii?Q?TVLxq/2QQ3FolqwX3QuKYZUavTFYtlWWiB6CaDy/wbFPi6LOQlN89NwADo/2?=
 =?us-ascii?Q?EYWgSQkKWP1bSkUEYwVe980LYYY43581iG4Q7S/e/rBy4eb/P1KS4nU6LZCo?=
 =?us-ascii?Q?fjlp1J7TG4ZA4gux9AkSz25tP2laUHehbdfMbawCSUCWzvyng22bk78bAES1?=
 =?us-ascii?Q?dZXpkr6nefGCHusWbAh6z/+5HWjsCgSLDGQaNsbxh5R0fqS0Lg1vFtJ4Qsw8?=
 =?us-ascii?Q?xzXDFvhmKwpuhqxwOaJzS/Ann0THbQJwjPST1SsSRPZ9tOZj16MGnix9WzAd?=
 =?us-ascii?Q?jrBOEZKNXUzB/voVDRbvgbmQdlMZx8v53zA5yLIq5E6neFR8W4vhNTc5j9R+?=
 =?us-ascii?Q?dJ27Ku4oEsqq/1/PUWdrUvBn9DBxZjCUC+2g7F4L+Ox0OM6I5HXDLRwFH7YL?=
 =?us-ascii?Q?NuvTgCFhkqLakZUmBC8XVzlHrWkDMOXuSyCjLdjPrYTxIB0EQF6kr4bD7SfO?=
 =?us-ascii?Q?KepUrxQ0MfPOzW75pPJ4KtT9kqMrbJTN2UqOfLTOOKye8q649WpWIYHMMIOb?=
 =?us-ascii?Q?Hek8/faZarQxrdXu8TXDSMjrvY4TbSwI/aeclcScWGFsB17VlXlEWHIlcxBL?=
 =?us-ascii?Q?m5P2SqrKNN972k8PDx5dYUHlIQOqNqJlAYY7E89ykIsDwzV6gQnB7RXtUQfX?=
 =?us-ascii?Q?SVkYzz+5rTUXHu3NKnqiRrfFlypW4ClhnNIPnTc4TWZKaV9b4RSwlnCyxUCS?=
 =?us-ascii?Q?zZhtd/DOlTVzXBb6hzRaJEK8umequdHX4zWzC8tdbIkvx9BrbKKhRhEOvzKI?=
 =?us-ascii?Q?e8gqH58MP46YyoyJZm7El77mVoZpyeafKFHqG2ARARpZ1GP7jdvX/uzQ/sPU?=
 =?us-ascii?Q?jPdyBJYrUlvZBU2Bk17JKHsCSccgF0fcmE9MEOHFg6ujVjJiPMfA5WfUEnYj?=
 =?us-ascii?Q?vE+VYQ7LcOoAI98wfZFNkquE1EbucEhsVPKyFR3nZ/oLrRIx/j70wp7YeURG?=
 =?us-ascii?Q?N6+V+S7/0cLwZnuoBRk09XnWsPXvEK1ls4k+DKdkNr/hPbI85wj4lwxxDjt0?=
 =?us-ascii?Q?8eOT/HNLGz86+VZAPROsSBw+XvvWqDht+BDacfr168F8dxhm+b0QSR4dH8cE?=
 =?us-ascii?Q?Gbru1rAPKtxqeaKJ0RQLxVkKfv0l2bSgk2P45KBjoAicjTY2AkzzQzExxPLV?=
 =?us-ascii?Q?+9dFh2UQIqJfaUehKH0ZBdhEFF36PxempHtUjyVeGTWjE85E8LsqrvhkXVU7?=
 =?us-ascii?Q?//UTCkAPMi1dSkfdkcubO90TeHgYlYSpWU5sKlPmXIBDX5mLOiS4gl5rlIwM?=
 =?us-ascii?Q?alhVuf8Ej1OcVA1vdr5hVik16Ch0iLSMzqTykzK+pXidRahlNYBvxFxmLrqB?=
 =?us-ascii?Q?QiDDkcuksw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbce44d-2c2d-49e9-d793-08da29a9457a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 06:27:02.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8oyUcOR6A0e+T6vKJzEbza1FygOY4YiKgEV74hHXrGuT2rfB8mBtKKMUHNc1FOSBbl6M9ZFSJ0D1+M0VpXYCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:36:06AM +0800, Fontenot, Nathan wrote:
> On 4/28/22 02:15, Huang Rui wrote:
> > On Fri, Apr 22, 2022 at 02:38:32AM +0800, Rafael J. Wysocki wrote:
> >> On Thu, Apr 14, 2022 at 7:58 PM Limonciello, Mario
> >> <Mario.Limonciello@amd.com> wrote:
> >>>
> >>> [Public]
> >>>
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Fontenot, Nathan <Nathan.Fontenot@amd.com>
> >>>> Sent: Thursday, April 14, 2022 12:33
> >>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Huang, Ray
> >>>> <Ray.Huang@amd.com>; Rafael J . Wysocki <rafael@kernel.org>; Viresh
> >>>> Kumar <viresh.kumar@linaro.org>
> >>>> Cc: open list:AMD PSTATE DRIVER <linux-pm@vger.kernel.org>; Yuan, Perry
> >>>> <Perry.Yuan@amd.com>; open list <linux-kernel@vger.kernel.org>
> >>>> Subject: Re: [PATCH v3 4/6] cpufreq: amd-pstate: Allow replacing acpi-
> >>>> cpufreq when loaded
> >>>>
> >>>> On 4/14/22 11:47, Mario Limonciello wrote:
> >>>>> `amd-pstate` can be compiled as a module.  This however can be a
> >>>>> deficiency because `acpi-cpufreq` will be loaded earlier when compiled
> >>>>> into the kernel meaning `amd-pstate` doesn't get a chance.
> >>>>> `acpi-cpufreq` is also unable to be unloaded in this circumstance.
> >>>>>
> >>>>> To better improve the usability of `amd-pstate` when compiled as a
> >>>> module,
> >>>>> add an optional module parameter that will force it to replace other
> >>>>> cpufreq drivers at startup.
> >>>>>
> >>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>> ---
> >>>>> v2->v3:
> >>>>>  * Rebase on earlier patches
> >>>>>  * Use IS_REACHABLE
> >>>>>  * Only add replace parameter if acpu-cpufreq is enabled
> >>>>>  * Only show info message once
> >>>>> v1->v2:
> >>>>>  * Update to changes from v1.
> >>>>>  * Verify the driver being matched is acpi-cpufreq.
> >>>>>  * Show a message letting users know they can use amd-pstate.
> >>>>>
> >>>>>  drivers/cpufreq/amd-pstate.c | 22 ++++++++++++++++++++--
> >>>>>  1 file changed, 20 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> >>>>> index d323f3e3888c..8ae65a2072d6 100644
> >>>>> --- a/drivers/cpufreq/amd-pstate.c
> >>>>> +++ b/drivers/cpufreq/amd-pstate.c
> >>>>> @@ -63,6 +63,13 @@ module_param(shared_mem, bool, 0444);
> >>>>>  MODULE_PARM_DESC(shared_mem,
> >>>>>              "enable amd-pstate on processors with shared memory
> >>>> solution (false = disabled (default), true = enabled)");
> >>>>>
> >>>>> +#if defined(CONFIG_X86_ACPI_CPUFREQ) ||
> >>>> defined(CONFIG_X86_ACPI_CPUFREQ_MODULE)
> >>>>> +static bool replace = false;
> >>>>> +module_param(replace, bool, 0444);
> >>>>> +MODULE_PARM_DESC(replace,
> >>>>> +             "replace acpi-cpufreq driver upon init if necessary");
> >>>>> +#endif
> >>>>> +
> >>>>>  static struct cpufreq_driver amd_pstate_driver;
> >>>>>
> >>>>>  /**
> >>>>> @@ -643,6 +650,7 @@ static struct cpufreq_driver amd_pstate_driver = {
> >>>>>
> >>>>>  static int __init amd_pstate_init(void)
> >>>>>  {
> >>>>> +   const char *current_driver;
> >>>>>     int ret;
> >>>>>
> >>>>>     if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> >>>>> @@ -666,9 +674,19 @@ static int __init amd_pstate_init(void)
> >>>>>             return -ENODEV;
> >>>>>     }
> >>>>>
> >>>>> -   /* don't keep reloading if cpufreq_driver exists */
> >>>>> -   if (cpufreq_get_current_driver())
> >>>>> +   current_driver = cpufreq_get_current_driver();
> >>>>> +   if (current_driver) {
> >>>>> +#if IS_REACHABLE(CONFIG_X86_ACPI_CPUFREQ)
> >>>>> +           if (replace && strcmp(current_driver, "acpi-cpufreq") == 0) {
> >>>>> +                   acpi_cpufreq_exit();
> >>>>> +           } else {
> >>>>> +                   pr_info_once("A processor on this system supports
> >>>> amd-pstate, you can enable it with amd_pstate.replace=1\n");
> >>>>> +                   return -EEXIST;
> >>>>> +           }
> >>>>> +#else
> >>>>>             return -EEXIST;
> >>>>> +#endif
> >>>>> +   }
> >>>>
> >>>> A couple of thoughts. First, should this also provide a path to restore the
> >>>> acpi_cpufreq driver
> >>>> if the amd-pstate driver fails during init some time after calling
> >>>> acpi_cpufreq_exit()?
> >>>
> >>> I think that's a reasonable idea; it would involve exporting acpi_cpufreq_init
> >>> as well.
> >>>
> >>>>
> >>>> Which leads me to wonder, should there be a more generic
> >>>> cpufreq_replace_driver() routine that
> >>>> could handle this?
> >>>
> >>> If changing the API for this, my proposal would be that there is a flag used
> >>> in cpufreq_driver->flags to indicate that this driver should replace existing
> >>> drivers when calling cpufreq_register_driver rather than a new routine.
> >>> Then if it fails to register for any reason then the old driver can be restored.
> >>>
> >>> Rafael, what are your thoughts on this?
> >>
> >> IMV there need to be two things to make this really work.
> >>
> >> First, the currently running driver needs to provide a way to tell it
> >> to go away.  For example, intel_pstate has the "off" mode (in which it
> >> doesn't do anything) for that and similar interfaces can be added to
> >> other drivers as needed.
> >>
> >> The reason why is because, for example, intel_pstate cannot go into
> >> the "off" mode when HWP is enabled, because it cannot be disabled and
> >> running acpi_cpufreq in that configuration wouldn't work.  So in
> >> general you need to know that it is OK to unregister the current
> >> driver.
> >>
> >> Second, there needs to be a mechanism for registering a driver
> >> "weakly" for future use, so if it cannot be used right away, it will
> >> be added to a list and wait until there's room for it to run.
> > 
> > The amd-pstate is a new module, we need to add "amd-pstate" on
> > /etc/modules-load.d/modules.conf for most of the Linux distro to tell the
> > module to load at boot time. However, there are some issues that we
> > unregister acpi-cpufreq at runtime while the acpi-cpufreq is in-build.
> > 
> > As inspired by your suggestion, I am thinking whether we can add "off" mode
> > in acpi-cpufreq driver, if user would like to use the amd-pstate driver on
> > shared memory processors, they can set acpi-cpufreq "off" and set
> > "shared_mem" on amd-pstate to enable the amd-pstate driver. I can add the
> > RST documentation to describe the steps.
> > 
> > Or I can introduce a processor list (family id/model id) that can let user
> > know clear which type of processors they are running. Then they can choose
> > which driver that they want to use manually as well.
> > 
> 
> This sounds like a move towards an infrastructure similar to governors where
> all supported drivers register and users can choose from a list of available
> drivers.
> 
> Ray, this seems like a lot of work to be able to dynamically switch to the
> amd-pstate driver after boot. Given that this behavior does not currently work
> how crucial is it to have this ability?
> 

Hmm, maybe we can enable an easy way to help the users to rework the module
in their existing platform like acpi-cpufreq "off" and set "shared_mem" on
amd-pstate firstly. Actually, many users mails me that how to enable the
module. We can dig out an easy way for them.

Thanks,
Ray
