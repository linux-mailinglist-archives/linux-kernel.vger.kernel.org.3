Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16E054CD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346714AbiFOPoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiFOPoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:44:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5F327B39
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dA8Ixjb1NbglIqXQBCTV3DnKHQzbJ6gXbID+PJ2TYrsUoF1AK3kjUdbXNy050dy6mfFs8xNsJCkM3ZyR3y1Ig3o1adR/JmQiyXXRgjXxKIpxpCnkso/O3qH7MpPcndpeDx8MCS33Y35vkz9NpLCbISnOMqwSmnzJm+037NWRy2TvAIaB1QpcJjiY5ZLDtvEGP7bV8ihoZ0hZvjHkNQKPTJPVU06lG82voO1vfxJ2Wv6AWKyAJoJxqlW7NlxKQfFKmuCVjf/NUUFJjw+wPifnNE2z0f9tkPGQMLsGr2hUUp7OJteWQAFGupm2lXIrlw49kd4iLwyKMu/+1IvELul1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8mB0aZrohZbig0Mpk8fW/07T4t9mskdLAgdesHe3n0=;
 b=UkxjQwczW8cpoVYDMFGP8gU9avSaLtuOOTwRDrUW8+Gf01DijhKsbJgXOncfd3LP2vGkSCiFHvrXbr8y1cTHClEqhKsI5RiEb8qqz/eg2/L0jE4eqlsKOB3BZlBOl9wGtRDc+BUCOVDAKZxVGZCOeVE7VBrId/XGWZZGmV886uP3njw0f0MV/XCwsrXJi7/c6OI73SdlBeyVj1GyVMoy5os44wJcuqRwsP06pz3c8CMYzZaZpp83WPHs6TxV4avzHkS8EXZOzAdAqmgcaZxqoUrrdoKMYGZF8CJ9wsCVSrIYeSBiMcXEV8lcNHRiDvHZIkdsUb0JKhTybJuJQ5LfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8mB0aZrohZbig0Mpk8fW/07T4t9mskdLAgdesHe3n0=;
 b=s66NIyt8ZVNjY8nCD09ad2VDFQt0D+qPwrP05tDhBl6nqxjINKe3tv5F7uaXO901Uz0PngyNFxO2WncPgx3klIFXbW60v3IKjpwD4bVuN4jcDWhnvD7zTarZDOIEZsV92k6MNu4Zc9vBYE2gb0sDHXMw8jHhlYexflMiftkLBHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by CY4PR12MB1511.namprd12.prod.outlook.com (2603:10b6:910:4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Wed, 15 Jun
 2022 15:44:01 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::1d7a:89e8:6a16:90f6]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::1d7a:89e8:6a16:90f6%6]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 15:43:59 +0000
Date:   Wed, 15 Jun 2022 21:13:39 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Yicong Yang <yangyicong@hisilicon.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        guodong.xu@linaro.org, hesham.almatary@huawei.com,
        john.garry@huawei.com, shenyang39@huawei.com
Subject: Re: [PATCH v4 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_resources API
Message-ID: <Yqn+K08JFRgtR3eY@BLR-5CG11610CF.amd.com>
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
 <20220609120622.47724-2-yangyicong@hisilicon.com>
 <e000b124-afd4-28e1-fde2-393b0e38ce19@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e000b124-afd4-28e1-fde2-393b0e38ce19@amd.com>
X-ClientProxiedBy: PN0PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::14) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4863ec44-1afc-4e27-e3cd-08da4ee5dd0f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1511:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB15118B4B7A1DA51BB0B64FF096AD9@CY4PR12MB1511.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZ3l4nouJ2LFQMmieWnddQ5YGUwt+Dey9e2MXki8glTVVUm6GIdzkf/l1al2ZljubxC6qlSJxvQ1ejNyHpDR1xxDdtX1NN5LRJI8H5B6UfVGUjElswN8QFZUnzpAvrlrAa0fqVKdqBv4V4KmYmDRCVataEixWPRWyeOLIuk7J2/vznaXsJU2pobtfdQPD2Snq+aI/hf9sstNQQWYD5PWUYXQlEpGjBW/PsmVzwkAMWwXsIBM+jQchNiuMIbYfONrgnBc3oB14B9HXWfUZxaEQJ0yG37fJSwcPbh8HrXobj4EPYmmRHR32Os5kYTQQont1j06uF6gqMbtsboYT517VWuneM71VJJ7LgGpSU80dw/+Ao6YLM2c3J7Mwmc2V1K/jN3CMGjMcyFETVYTR8UZCHxhZ2ufnROauReT0DGPtk27uCHa2ZowHX7fLMnqNko1ons9mkd+6JTqpsyCjjyp/yiE+fpf9/WXJ1qpwcCaDix7Sn0E/VNxd3XtVa/70dwayIK5EtokPkLBBEl7UDmwLJzwN7n0q5aoFXQdFTyaQ3d8rI4v166UIJ/vm79VLso0wvWSgiBfZm6bWgMs3la/nBkVBT6aiHpqQKddEWmsuFPlVFuqO/GdJsXDOD5DM2R2JgrSzzQDODBrsVF9hbC9562DO1wUKE0aig8Gvw5VlXvOPYX00pUe1g0hzBYqNkMFnZVfTRAeDZ/N+neAcbA9Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6512007)(26005)(6666004)(6506007)(6486002)(508600001)(6636002)(38100700002)(86362001)(83380400001)(186003)(2906002)(66946007)(7416002)(66476007)(8936002)(8676002)(5660300002)(316002)(6862004)(4326008)(66556008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a+jGMvhIFfia1SioXWKo+POemRLxAyZfLVz2lIKAbQUjqZcVO4PDR58dKwS1?=
 =?us-ascii?Q?07vCO7dANeuRkrlkMRWWJny0V6FEVIRrGDbO6b6UWPyWYhgWiPvXilrQlkiK?=
 =?us-ascii?Q?0Dkau0DCxY5qfUX4gsJq8qzxOsIoLOZO+RZi7QCtRLntgPqOs7/9bdt5JRMu?=
 =?us-ascii?Q?6mSaJ0TfAzMSdtHOTsUtGz6KFTYOJs0Yqm62fEsvXUuWdSq4IqRy3U3pyp8K?=
 =?us-ascii?Q?Zu/75J0aSE2/oh5gglonfQyMaJD9Q3tZITDVYYd/TIVhYPs9fDgH4mw4wS0/?=
 =?us-ascii?Q?333GvMSSAXA06pFA9+94soRIaijGNmymhkkNcPZtO1u3Iw56wp3P57fcGtkb?=
 =?us-ascii?Q?ikQRjynNudqWCS7Z+1HK/5+l96CygMLPcghB+cSYq7uwdhx4vBIA4RHDZv4s?=
 =?us-ascii?Q?caYJlo8JOltYqmA4rQWQgcLx/pjZEsCTfwN3RpY0Atr3G6bM8r91LYGPs1Pn?=
 =?us-ascii?Q?lBuAsYQSbD7TJo6Iq+WsbmaHimGs6FFe5XMzYH88k3UTL5XZ9R8DGm4O1j/X?=
 =?us-ascii?Q?kva8uQ3xB7NqJOCpXXO8gS7NLODWkY/lVpfj5iw1hn2SQ0je83GBEbRKp21q?=
 =?us-ascii?Q?thURcNPZWSaJFZxPnhp9yeEwHU6sZXAgL/BBKZRJypidFzy9z3vFB51uLbvr?=
 =?us-ascii?Q?d9CVUFqXGZhvtDiK8iJ5PGqA0kFCfP6xXtI9sJRcsZpvo4YOKyCZIRura5vx?=
 =?us-ascii?Q?8Se9bKYlwnzFIuFYl/RphDjGhfqLC28SZVS73XbTQZ7IumWs8204U1TMloW2?=
 =?us-ascii?Q?hkuE0dtGERu3rfKTLQaVBTPDf8IlV0UcSPJmhko5JAKaJ4UcD+5G4KQA226f?=
 =?us-ascii?Q?3ITZht5fNuCJcj5WW9Xdvnb3+p3fUbfqBMJEVTadLZuJ4cJpdRlAwf3CkC16?=
 =?us-ascii?Q?PukXD8z8aRMd7m20++3kANI4U4sIBVFf/sQjj8gsZGKuciWScGJKJZwod+du?=
 =?us-ascii?Q?5aV83Ye7Ik89nRuoPtQkzg9VOHHokk3WMTgVwA66q/DQSym9XR2XJX0thOUX?=
 =?us-ascii?Q?VEeM+nIHS7oHrtpWe7jxFAE3/63nWBRfa5qPFbVR9MCip3lo1B0mNiDY3JrG?=
 =?us-ascii?Q?mTI3hywkHqZXViJzQ/Os5xoR6eZd5r0jMAt+B0V6RPb5P6K3kUFqcpe6Tp/K?=
 =?us-ascii?Q?7+VTCjRAR1ew17Z0VCCMcs4j+78VCGvlOP2U6pPLxdKIB7WEaWcd+9ZehWdM?=
 =?us-ascii?Q?UZVFPFjgH1ArOFsFtHDT/WSpXzNusuafal8s1+QRtkSd/mdX4gXzpvobRCSG?=
 =?us-ascii?Q?awB3ZgJtOHomAM4amBjUWA1utKxB6Qn/DUJ/P7w21dIK0Tue6cpM4u0us2dY?=
 =?us-ascii?Q?Dp8P4NwkyV/dfrHbFi13kVO+9+Dao/nWlAkjwnOU6cYGMpqH4YrYUoCCDlCX?=
 =?us-ascii?Q?AKPUSxulYH5/0voHdRM6R27eJpvIqiJGtscSXkdu0rClcXLgEqVPz/XPpBiZ?=
 =?us-ascii?Q?+sFhp4q2pV0UrxNFnaZTAOucdWGSniJ4lLjPaIK6Jizxz0/oOUvM4RaTUvcL?=
 =?us-ascii?Q?gxaJptds0fIQPil1UGVZjgVw9f/9dlwYmIzO8aw/bk2Yx2ZqL4N2q5OUDjy/?=
 =?us-ascii?Q?sv+skyAV2omjUVmNqFjVHaGrNV3r3O9o3ZfAyZmHjEq1k375aobwrpiFk1k1?=
 =?us-ascii?Q?dn56pBllSUAsGXNOPkULa3uDGSiH243tJkH6+pI4Tn64DHgPW+yyA4JAc+qg?=
 =?us-ascii?Q?4+FbdD0yZr+2n7L3zdiCzP/4H1UHm9CGxigqN/JdriU7UlUs6tmaSg8zdX/I?=
 =?us-ascii?Q?UOO1xQnhOw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4863ec44-1afc-4e27-e3cd-08da4ee5dd0f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 15:43:59.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNjEe8ZJWGFsFpPTrRhBGuwm3xBp8YPl71nX9S8zTTV2MtRmEIEdTUH4dzH5gKo5ryB6Zc9tjQ3kX089+BWNTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1511
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 07:49:22PM +0530, K Prateek Nayak wrote:

[..snip..]

> 
> - Bisecting:
> 
> When we ran the tests with only Patch 1 of the series, the
> regression was visible and the numbers were worse.
> 
> Clients:       tip                     cluster              Patch 1 Only
>     8    3263.81 (0.00 pct)      3086.81 (-5.42 pct)     3018.63 (-7.51 pct)
>    16    6011.19 (0.00 pct)      5360.28 (-10.82 pct)    4869.26 (-18.99 pct)
>    32    12058.31 (0.00 pct)     8769.08 (-27.27 pct)    8159.60 (-32.33 pct)
>    64    21258.21 (0.00 pct)     19021.09 (-10.52 pct)   13161.92 (-38.08 pct)
> 
> We further bisected the hunks to narrow down the cause to the per CPU
> variable declarations. 
> 
> 
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 01259611beb9..b9bcfcf8d14d 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1753,7 +1753,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
> >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> >  DECLARE_PER_CPU(int, sd_llc_size);
> >  DECLARE_PER_CPU(int, sd_llc_id);
> > +DECLARE_PER_CPU(int, sd_share_id);
> >  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> > +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
> 
> The main reason for the regression seems to be the above declarations.

I think you meant that the regressions are due to the DEFINE_PER_CPU()
instances from the following hunk:

> > @@ -664,6 +664,8 @@ static void destroy_sched_domains(struct sched_domain *sd)
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> >  DEFINE_PER_CPU(int, sd_llc_size);
> >  DEFINE_PER_CPU(int, sd_llc_id);
> > +DEFINE_PER_CPU(int, sd_share_id);
> > +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
> >  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> >


The System.map diff for these variables between tip vs tip +
cluster-sched-v4 on your test system looks as follows:

 0000000000020520 D sd_asym_packing
 0000000000020528 D sd_numa
-0000000000020530 D sd_llc_shared
-0000000000020538 D sd_llc_id
-000000000002053c D sd_llc_size
-0000000000020540 D sd_llc
+0000000000020530 D sd_cluster
+0000000000020538 D sd_llc_shared
+0000000000020540 D sd_share_id
+0000000000020544 D sd_llc_id
+0000000000020548 D sd_llc_size
+0000000000020550 D sd_llc

The allocations are in the reverse-order of the definitions.

That perhaps explains why you no longer see the regression when you
define the sd_share_id and sd_cluster per-cpu definitions at the
beginning as indicated by the following

> - Move the declarations of sd_share_id and sd_cluster to the top
> 
>   Clients:       tip                    Patch 1            Patch 1 (Declarion on Top)
>     8      3255.69 (0.00 pct)      3018.63 (-7.28 pct)     3072.30 (-5.63 pct)
>    16      6092.67 (0.00 pct)      4869.26 (-20.08 pct)    5586.59 (-8.30 pct)
>    32      11156.56 (0.00 pct)     8159.60 (-26.86 pct)    11184.17 (0.24 pct)
>    64      21019.97 (0.00 pct)     13161.92 (-37.38 pct)   20289.70 (-3.47 pct)


--
Thanks and Regards
gautham.
