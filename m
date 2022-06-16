Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE9354DCD8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359584AbiFPI2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiFPI2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:28:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694A286D4;
        Thu, 16 Jun 2022 01:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpztJ/sSFxko6eNp7HbBnFcMb4uK4E0Q96WZx0YtgwZgPMFfZqmXRmtPC4oEXsuR7eTZJ4tazcVQbxO6Sq8S6E0yA5rZU3s0LlZit6gE/hTclo8MR5b8Bau9L2vf836mXIYfvAaWqR5Xi7woC07Pd9fGiExdljdGh854m3BJ+aK9woNAos46BlQM+EvnTlzpgfP/Dk5od3aHUIfeqWO2BEqin4XglOAwS6Xhm9iv6ZgU+qt6qRBpQwjdN1/g7u6UlKa6alPNisILgXaz9UNjm9Vw/x2LasE/aKLuGT6Ru+uGgiBGxH8jkkVwuIfICKxtpk9foJJ5fZWV9baX6kmFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpQxdhUNG2ehzNzgiP08Ujiv0DlrjHN5xP9T6nZlU+M=;
 b=ioVPaJmBtWsFdTABtp78Jywf8sMFkrXDezmIprcc/FuCzsCmiiVW9pJauwWQ+MpXNe+2Hk9WpGMHGFuucFAKKNy/OmSWZO94oLcTphqWXwmdzODIjC7cee+l+E4vvpT7vLagzumhbe3wC9JXQSa0d88+9rgXDyBMXFMuTbQlcoPpt7kkPeSwrjI6YuZ5/gOCiVPnfJxNzgTF+TC2ZN7pLyMMjGbby0sUdL9/hme/jHRoVc5n/gzlcGnzwBzuqpMKZwcwWGRpX6kQEoThr+Z2r77A0/IEoIeGNxC3c+BFkG2hXLPTvcNBG+1XIlaraDteL24J1GuBdr48DyM1aVWtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpQxdhUNG2ehzNzgiP08Ujiv0DlrjHN5xP9T6nZlU+M=;
 b=Mmn6BIdozuF3t+ZGl7JDEIn95VKsbF5sZsxGUZSX24fLzv+XylYChISQlJaFQYRmlHFJ0fbucdfnSp+DAo8rvyMwAf05cn2s6zI41t6iTSh+DQA3w90SZ3RpimYY5TnOSWUm09JswWJRDvPIXk7ZwMeuij5TA+efTa08EWDgrhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2506.namprd12.prod.outlook.com (2603:10b6:907:7::12)
 by BN6PR12MB1684.namprd12.prod.outlook.com (2603:10b6:405:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 08:27:57 +0000
Received: from MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::7567:d120:4673:e57d]) by MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::7567:d120:4673:e57d%5]) with mapi id 15.20.5332.020; Thu, 16 Jun 2022
 08:27:57 +0000
Date:   Thu, 16 Jun 2022 16:27:32 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 0/4] Add unit test module for AMD P-State driver
Message-ID: <YqrpdA56ZlC8ODwG@amd.com>
References: <20220526034725.1708916-1-li.meng@amd.com>
 <fbd6bc2f-b6d7-497e-410c-4a82876075ff@linuxfoundation.org>
 <5792136d-079e-6e1e-0bf5-aed1b3db6566@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5792136d-079e-6e1e-0bf5-aed1b3db6566@linuxfoundation.org>
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To MW2PR12MB2506.namprd12.prod.outlook.com (2603:10b6:907:7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9acb807-6b19-4a8f-6e41-08da4f721e08
X-MS-TrafficTypeDiagnostic: BN6PR12MB1684:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1684ADC65B7D3493B0976596ECAC9@BN6PR12MB1684.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: En/0a8vVIQ3hhmyGKdFAr7hVOeIG+Oc0G/FIYwitAo1FFsomhR20I3EYCJ9i1C2p0CS8SO5i3nlAXqKleTStJm+yANz+DLXCfixH6ao7HQyt78Q33s+Y6kCSMt2w7GApscg7FaqagRQHmvk2+sAtF8/vsVvGeds4STxzaLP9gHMwtLDdouyia4Mjj82XNMLgZfP3MB8vUwqRTgEfdAyf53DRYUwWPen3YX7L4e+ldmouI5UXZz79aXqPkqL7fJT6ewNXAedvw5pBWYBnW6rSZBB2mbaf7IaZaQOqpuCbKyyDdY52b0zwDIFNDBtypnmeV8BoqBM/IbVFdn4RJ7KL40oP+X+n5RK49BaXiCDd3sOaRrfeQ4LxvEhn3gDwZyJah585va5UNFTzu/tMcZTqPAHQuFMJzf413kyNeFU6XOraWDfLG2/8r1n2vdp61fUD6Ny867h4AFWxVR6FAxm65pBw4K47Bx5SDS7bMwXiiNom7XgueWlK6pmsU41Nm0VeypOxX2rdTjCL9/HmdERXhsHAP2qxjfu+3W8FGkNsuMfxExABCObH8FqOYBpG3bf8BrWLbogK6gcwyp+HP7qf0AISef2CUX7dFlY+BLY4xdgZjb2ivEglQs+WZiTUjaqczAL7Tryyifs5VfdrdA3fADy3G+F6NEOs1mJ1ceqbRd3Mg8Iub3Q30jSujpEDeixIeD8U4zcmn1Z6fvV+uUu+tVcGGmhhzhYsVsRqT7QbyOTAHZZU8bvqnbqwPMsbXPtkGJHwFh16gUd+ckoFULpV9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(4326008)(36756003)(5660300002)(6486002)(8936002)(8676002)(966005)(508600001)(66476007)(66556008)(6916009)(316002)(54906003)(2906002)(66946007)(2616005)(26005)(86362001)(6506007)(45080400002)(6666004)(186003)(53546011)(38100700002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qXeqbAyGjhzW7cvuZD8+RA9XSdy6oHY5I/p5z9PSxp4ju0Ka0F80Vo/4OB0h?=
 =?us-ascii?Q?uX843gp0yqg+AyGVFLwLqO79fxoKDFiK2F2GtNj4vOos8eJaV7K+xMkAVm4A?=
 =?us-ascii?Q?76wkkmhxSuOpB7rlf51NE0BadxhyvlLMnmDygcHw4wi/armVtF/oQKgozp3r?=
 =?us-ascii?Q?G9ZDyNUobBDJsWaTKhVJSbUQ2ccjHQ1uVTCw0ALzJe/NeV9uW0H/QL5uCF9t?=
 =?us-ascii?Q?rPx3f3stQ1LLoVm8qh60KdXt2Vcv5Io6Dw9Q7u5uLFhsZFadCTj41ALVoS5+?=
 =?us-ascii?Q?4OkXNplyZ9ajtqlEBrxMQD0CLJHa9FwReT7aoYLpI8yzB4MrJuz2Y85LQ2/J?=
 =?us-ascii?Q?0Gv6hBtIrPyTvfmZIGMPP/YfGFiQT8EYRwag2gjIHE8DoxD2iOPS0lt1xoDv?=
 =?us-ascii?Q?LvOhYUonCILaTeiV4cBsfuDU3yhqaAxqORu+901UvL1Y1kHnU3op8aY4yHqi?=
 =?us-ascii?Q?VeOpIHbqr+uPUU1wyWopjfcgVc/+mMIcyMqVj0cGTldXcvJZZcuZfpXhgCcS?=
 =?us-ascii?Q?dtle0vCgPawEMnBO0E6NpZZ2uBEntDQj9h3aPuXqQgv/uDkaA8iIiKZXum4t?=
 =?us-ascii?Q?jX80YPt6CxyNJU0Ubo2DC0uKbAHN7uACjQvXhK3ikZP6nIR7kVCc43S2G5GC?=
 =?us-ascii?Q?zOeXZBKI071NUo95prnmL1z7GLTQjsdbYd/zDrHXchIcNXmhP6h8DsI1WXJ9?=
 =?us-ascii?Q?BIXVuOePnfQ8ZOaWLIPXYgVMmGT3YcBDOCjYeRJFcoCE4M2D7XEL6dFsXMUQ?=
 =?us-ascii?Q?oVferoH1eYjvhIgXvJyixadr3m4YbXfwp1NTX06I+KVO15Ma5Kk8r8HWwCrG?=
 =?us-ascii?Q?EX4pOuAHYvUqBUVuKIvcPf3JW0usOvw7aGe/eGJ12afzokwCNKpqTYUU5E/5?=
 =?us-ascii?Q?mw6mWJF/ZOdzUIUzTAsZwfFaDOdwKg5Zjd5l3JlCOmnAVIMU9cqpFCKDt65v?=
 =?us-ascii?Q?RfAqZ6yrYY4xAd8+j62C38e5aFtfZVWgDkZsnAHpJS2E+7oFXVqbwqw4k+Yf?=
 =?us-ascii?Q?j869fONFnqvyrh4CsSdhf12KF+X7YqPtFFgqmnSUVOTaHeUtjyHG8ZdFCpFE?=
 =?us-ascii?Q?VcEqa6YysiMCjWrIIG3CbEX18XXLnrElVENWUzchMYfzFcyo+UW6PZB72mcB?=
 =?us-ascii?Q?X76UDjQRodnSmO/ihz51On4eZF2zHURoIeP21an96qyabgBq8In3/qf8zHbt?=
 =?us-ascii?Q?qu/fhqfxwzIQK3H3gpm3Or+MWFpbRJkc8zC3EQ2p9iY+xw+ZAGdGMiqECCNz?=
 =?us-ascii?Q?B8FuJ0aNytgHBC2UQdIPWzzYX0e6vhlGvtuX2xqYFZ7PHeZKcgkR6H0Vzf2i?=
 =?us-ascii?Q?DS0kFkUQtCRPUVS5SbwjRlp//vHdz1+sGGOQdChwOhyjQcFd7ZHkaap4xFIe?=
 =?us-ascii?Q?rD0i6mch6q/NXeIXx1IGM1jmfUm6ZcnLXt2IHnKMIuEYYnH2GrsH5wf6UGSz?=
 =?us-ascii?Q?aUHlngkm+Wj91PW8rh7DSXJom3+xHcpZwtAw0G6QFNNxc43Yh+fxnoDqQjwE?=
 =?us-ascii?Q?zob3QPlNRMf56n8cGrKjdsEHyJwsMz6QcfPPm8Kp7Noyr7sOa84AdOhbcp1F?=
 =?us-ascii?Q?Tzu5wn7FWYC/QsY+1sLtSaUVz6ibddxtpglXN7jWl0DreMaRQJZn5wgdy8Iw?=
 =?us-ascii?Q?Zzlm5iX+robnrXIAQu52ZbnY4MM5K6H3EJ2czV0oLVle0BXVznLs153I8Gt8?=
 =?us-ascii?Q?Kub7MVLmPC05f5GbTSSB3yZbxQrnSAyzcx7tOXOLRMUYbWWvb1ojSl3x4sjQ?=
 =?us-ascii?Q?eCCPumnS3A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9acb807-6b19-4a8f-6e41-08da4f721e08
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 08:27:57.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xRjwe3va8YVhUyQ9mGnnApuvpHoc/QQjUcsGMhEW7WcJcA+RFsIkf53uidh27oMMgKhcrAPdtkDYf1t0KcZcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1684
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 04:28:27AM +0800, Shuah Khan wrote:
> On 5/26/22 9:44 AM, Shuah Khan wrote:
> > On 5/25/22 9:47 PM, Meng Li wrote:
> >> Hi all:
> >>
> >> AMD P-State unit test(amd-pstate-ut) is a kernel module for testing
> >> the functions of amd-pstate driver.
> >> It could import as a module to launch some test tasks.
> >> 1) It can help all users to verify their processor support (SBIOS/
> >> Firmware or Hardware).
> >> 2) Kernel can have a basic function test to avoid the kernel regression
> >> during the update.
> >> 3) We can introduce more functional or performance tests to align the
> >> together, it will benefit power and performance scale optimization.
> >>
> >> We upstream out AMD P-state driver into Linux kernel and use this unit
> >> test module to verify the required conditions and basic functions of
> >> amd-pstate before integration test.
> >>
> >> We use test module in the kselftest frameworks to implement it.
> >> We create amd-pstate-ut module and tie it into kselftest.
> >>
> >> For example: The test case aput_acpi_cpc is used to check whether the
> >> _CPC object is exist in SBIOS.
> >> The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is not
> >> existed at the detected processor, so it is a necessary condition.
> >>
> >> At present, it only implements the basic framework and some simple test
> >> cases.
> >>
> >> TODO : 1) we will add more test cases to improve the depth and coverage of
> >> the test. E.X. use the script to trigger the tbench, gitsource, kernbench,
> >> netperf, speedometer, and etc. testing and monitor the cpu frequency and
> >> performance goals change, power consumption at runtime.
> >>
> >> Please check the documentation amd-pstate.rst for details of the test steps.
> >>
> >> See patch series in below git repo:
> >> V1: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pm%2F20220323071502.2674156-1-li.meng%40amd.com%2F&amp;data=05%7C01%7Cray.huang%40amd.com%7Cca871cbe21d34368046408da4a569d82%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904033129149948%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=RhdyH9UelmQuEGokmUcPZKla%2FTr1j9GC%2BzC%2BPGD22xo%3D&amp;reserved=0
> >> V2: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220413090510.4039589-1-li.meng%40amd.com%2F&amp;data=05%7C01%7Cray.huang%40amd.com%7Cca871cbe21d34368046408da4a569d82%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904033129149948%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=f8%2BUhVE94oDnm9aWy2Bz9FmV9f2fBwOF%2B%2FfioZCjX5c%3D&amp;reserved=0
> >> V3: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220421074152.599419-1-li.meng%40amd.com%2F&amp;data=05%7C01%7Cray.huang%40amd.com%7Cca871cbe21d34368046408da4a569d82%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904033129149948%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=QOYa%2FjtTrh3sXhMmMBPPIsY12%2BjVG%2B9hn1myQ0HhOpA%3D&amp;reserved=0
> >> V4: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220427135315.3447550-1-li.meng%40amd.com%2F&amp;data=05%7C01%7Cray.huang%40amd.com%7Cca871cbe21d34368046408da4a569d82%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904033129149948%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=e4GBakHlYTqv0dhAUOmPu1CueJceKIjQCZ8OeHhgFqs%3D&amp;reserved=0
> >> V5: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220505022913.329259-1-li.meng%40amd.com%2F&amp;data=05%7C01%7Cray.huang%40amd.com%7Cca871cbe21d34368046408da4a569d82%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904033129149948%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=l3zbZC6SjF0R%2BeAGN%2F32M4FnT16OTDv5FvCfKf%2FXDyw%3D&amp;reserved=0
> >> V6: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220519134737.359290-1-li.meng%40amd.com%2F&amp;data=05%7C01%7Cray.huang%40amd.com%7Cca871cbe21d34368046408da4a569d82%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904033129149948%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=KW5KbwUOe1DReaKRvu2AttcXsCJYYr5zHrB%2FZvxPAYo%3D&amp;reserved=0
> >> V7: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220522115423.1147282-1-li.meng%40amd.com%2F&amp;data=05%7C01%7Cray.huang%40amd.com%7Cca871cbe21d34368046408da4a569d82%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904033129149948%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=JscI%2F69EuDNzZsQMGbgkyF3rAChKJl1nz2sZLxdm5H8%3D&amp;reserved=0
> >>
> > 
> >>
> >> Changes from V7 -> V8:
> >> - cpufreq: amd-pstate:
> >> - - amend commit message.
> >> - - amend module description.
> >> - Documentation: amd-pstate:
> >> - - amend commit message.
> >> - - Remove the personal data.
> >>
> > 
> > Looks good to me. Thank you.
> > 
> > Rafael, Viresh,
> > 
> > How do you want to handle this patch series? We are in merge window
> > and this would be for Linux 5.20 based on the changes and content.
> > 
> > Would you like to take the entire patch series through your tree, you
> > have my Ack(s) and Reviewed-by(s)
> > 
> 
> Picking this back up since rc1 is out. How do we want to handle this patch
> series?
> 

Rafael, Shuah,

Would you mind to put this patch series in bleeding-edge of linux-pm kernel
tree?  Because we have some patches that based on the include/linux/amd-pstate.h
in patch 1 for amd-pstate driver next step.

Thanks,
Ray
