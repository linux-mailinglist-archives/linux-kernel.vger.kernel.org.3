Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312304EBE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245055AbiC3J5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiC3J5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:57:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBC083B26;
        Wed, 30 Mar 2022 02:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWX4EO5VDboqfaf9x82DpEA5O09yKrbW0qp2p7eWAIEVKktaH8c4681UhIUOMRNZhjn+efaVduro6PW2zDvUsScHcg+m5d981zfYQ1G1HG5QlmZla5OXlSK0SNVZsOcJXbuXxe5UKlQcj1msFGfcbp3JRdIRkCgsNsdzhKn0hnG2ICiVV1QrV1B1xAIKbshFpM1T8r0uR2IQ5iAD4LdsR7bKSNpw1YxHt7fY+jUezGXfluk1M1guOzu1SewsiE40oTmuVSBL20etjIBaOT5aGDYaCDGEwmQ86AHjJkktVwLG2s1by4uQuz7sW33A7739APRb68mJnaKR+dd0Ii/kIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnI9oM3FVEmvlKT1ftaNmkTPpEwAxeBSpzLNB+64Qnk=;
 b=TJ/oiVCUSPCKoA0nsMZHZgkYwhvj4VK1CSk5dl9ubHH5+qZX8BbjWiFA/mgOsaiCMpsAiez5+938pgFVUnICfiXbea8fx1AAb1XQGyDp9Ohj7TnqC5H5j1c0I6sMJrGvsW86ps9E4cI2aDQ3UbsmxB896FF5yqU6Tao3CvxnS7DBjlsvDH7q9h9y7EeqG4w91za8bCvpqijX+zihMp98/7G99jwT9ZTElo/odmSC3dbfXVec+qd+rBiFUiDQZ46xrsJWlNdbhnXszRlHaJnpjsxg4wYmKpU3VQmes+jS0hJIj6SN0UVf/drJMJ70fJo6ouYoGUHdLNUqJsiSOrr3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnI9oM3FVEmvlKT1ftaNmkTPpEwAxeBSpzLNB+64Qnk=;
 b=BPmfROyOadocpR05ys5Obp7tuKU6pCR4Sv+wS340A2ENtPmErMmHDMAqChVR6uAtM0HQNLdzpEKlAMvTAL+CXKq/SSLHe5cNuY0PVOqUrmrUf7gq4l03xb2Zxdi5FahXfjMmUjC5z/J0FN0Oz4nM2O2NNUVLZoUaYxukbzFr6wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SN6PR12MB2704.namprd12.prod.outlook.com (2603:10b6:805:72::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.22; Wed, 30 Mar 2022 09:55:19 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 09:55:19 +0000
Date:   Wed, 30 Mar 2022 17:54:59 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Improve usability for amd-pstate
Message-ID: <YkQo81jOIcC1t0tr@amd.com>
References: <20220329015947.565-1-mario.limonciello@amd.com>
 <YkKhCplrh/TJl/OQ@amd.com>
 <DM4PR12MB5168F84795F4467B048B6AC3E21E9@DM4PR12MB5168.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5168F84795F4467B048B6AC3E21E9@DM4PR12MB5168.namprd12.prod.outlook.com>
X-ClientProxiedBy: HK2PR02CA0210.apcprd02.prod.outlook.com
 (2603:1096:201:20::22) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9d38936-3d81-4b05-e994-08da12336612
X-MS-TrafficTypeDiagnostic: SN6PR12MB2704:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2704D83D787C06324F0DD72DEC1F9@SN6PR12MB2704.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBj8RkURfOItARE7aUI48zRORDY4h3dfvD0YYf5q2W3EtEvAtqS1zmLhC7wg1yglq2E9TiJMXRNgLpI1rC7x45heQD6UTZ7hN9gQUPc1a0mTHWQkvxmy1T813UqdcMiSzxHqZ/Z9BAjHS+4oCatM4bHzj4JovxoneUx3G0wIbJdbuRBQOjNDEYyiPIOeqmbs7fsK3giOk/29Ou5e+gsUMxROi5qcTNbhc2MGIP223irHUTeDvpMcvwvRlZt7RQlY0kdr5E24zRrCTrHmJxfDUj8R7niseo47yLaRqn+KCzDAlez+2X3PFDiuZIjFXltf7fL3AVVUmFDf0va0U5Ka1622v6deo4DBP4PdAMD5kHNhdkqirACUoWhpJp5Y/g3bRGIbg4lGgfsaFCnav3DuYA/t/6pHqTgjYlqPV6inQbkA9zxqOhTkfQlmiIx2fBxCk9BkGUDj0uftaocdn0lWLz6T8oOuYJCqR7+0uWmxvBGtbfIIilNE9Ni0KRlQ0xsOlAE3RUmUwtGcMAiw3LI8VFpBdOovq4jQr+9fi7DJR4pu4rg8t8HMWZ2BpNFixJF2/Z6C+N/qJKOO58L4D1HhVrgEf22Lu8JrqzbWKjd7S3ytbfm0ZArOYjUu9lGNGa5eaYUggDuXcGVa3i08/RxICg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6666004)(5660300002)(8936002)(36756003)(6636002)(6486002)(83380400001)(6512007)(186003)(37006003)(316002)(2616005)(54906003)(26005)(66476007)(6862004)(8676002)(86362001)(2906002)(66556008)(66946007)(508600001)(6506007)(4326008)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ecTHe20dX7e4ynG0clZEJ5VFD2rp32oUvRZd39otQJ2SsWa/y7/gfx7p8NVf?=
 =?us-ascii?Q?z7lioMB4QO3/NeIqhTmAQtCduBeUFKE4dr4kcBm+1I8EHhTFuJINzBWJwi+R?=
 =?us-ascii?Q?SSvcj9+7CHdOnivJXu+dfHrVlh4MaYPUDLRxB4BFMxIOZlP+VCowgQLEFoV0?=
 =?us-ascii?Q?8450dZB/854T8mgGiRjCONlq1OR86DIkQCenhwBdxuMWr325b5SvXJTAikO0?=
 =?us-ascii?Q?xeGTd5jvs61+YMfHMExhA6WNeINvZELiGHMZG5B9nkxS54OdFCtM84+DoyJx?=
 =?us-ascii?Q?ZMEZ3cq1J2lCLJvc4h7VjrgjCuDIOyZPhsbU2Sh73mbPTHzhFHT3TtnwBpMM?=
 =?us-ascii?Q?I/Wj1GEMtcdc8GEetIKBSXMkd9jJ8ON/2Bkl14LQbUymo2rumGY4CKIiNZbQ?=
 =?us-ascii?Q?9JWZrPmk+wZj4GlX5BghrfoRTvoH88rn7ypu7+Ty0C1v6c1HTy2/WAWoq0rV?=
 =?us-ascii?Q?Um/7stxJP7rHHjV7LZu8LwpInsvNW3tpP2RbJ4Kc3XLFTDDhuJWAzsF53XWh?=
 =?us-ascii?Q?APIK52X4IyE5/C2OZqdd0jcD7mt585b4XeoeoiUAq9moQmMZZ9KCMNIXGT61?=
 =?us-ascii?Q?l7GmKw3A+nFDuFeAsxClhb9mxfrr6fRUjUNLddCVYjgXWWnEHqeBcBlTPWvs?=
 =?us-ascii?Q?oqVpKa4VcymJLo6B7U5pwwXuTMVNHI02pmo6JYHNE//TqqDMKGp5q92Vz821?=
 =?us-ascii?Q?Pp+buTbnhUNFLl7G3XPiQBRZ31Lk/VODRcOtXnug9PpHvPePOeTIrYfJyNZd?=
 =?us-ascii?Q?p0SE7QcSptD65vT6JFCcf3hNVj6VrkYkov6yQMtN2jQmzJIkiH9Om3M+4rk0?=
 =?us-ascii?Q?Z23001j4Oea3cKycvtb7jYbtmRPyQzB8Mdbjlz9pXNWZlbMiIxDy4CsU5wKW?=
 =?us-ascii?Q?R5PYdsvEbW93yMYIozJcE7ZzDfoCvudiHkR2cPIJUMee1foPSi/vp/VB7sWH?=
 =?us-ascii?Q?kUipwaNoj8MVCCYG0xECmrB5gTwgYKmQdsqxJT1rA2V6YqIxteeJDor7tSqR?=
 =?us-ascii?Q?cmrQt15X1NNf3RrKikc443lc2xziv10c51yVoQwptMGqLUMDCO7lQileCTJI?=
 =?us-ascii?Q?8gsvswlvGEI60Juc3aR+6FbM5iT/X2HvbM1fOwQkFOuaQFoUYLR6+LVSBgow?=
 =?us-ascii?Q?5mujNvUs0fvncKkc9bRvDTeIcLzW+YpW9YNfIHg0zFR5428Jtux31J7Sn53u?=
 =?us-ascii?Q?zfBsWgMR+gjpxwy0/9ASGuzzFvywJo7gsnjIr4+mlX00rkJ0k4UmBahcLnr6?=
 =?us-ascii?Q?tM+siMDCdHvmWCgMQfer6NkAWeh2AxAzcfdT0dk1DWMdckGh1arB4mK9E7zF?=
 =?us-ascii?Q?48g5fzucPuYTGnu4A/zn6DEbs9Ta/e5FiQEMTVeg0n/BYdj77/n5V8utOBEg?=
 =?us-ascii?Q?17Ehb2m7vb1RMOCQLstr1em5ABNI3fxqu9PyF5oo+/C4YNa+x382Ckaiic8r?=
 =?us-ascii?Q?y9HAIbgzxXN+up+EpAS9AUitq0qCdApavkNAwY5dkrdf1BmEjtwYf+iCwvOd?=
 =?us-ascii?Q?+N6OXfsOMnyJQnZF3ocRcEOYZVG1O/XHVGiBSm9bF4d1FEjwes8DLgIj1gF+?=
 =?us-ascii?Q?t6urvtXUGKFJyQ1ijhjEQdtSwWltJ/WQyXbqKAepEstl047MQQeJnTKobyTe?=
 =?us-ascii?Q?y3IXWNjVbOiE5yEy+2Pq2y7tBy6zmR63SLKieBFrLm4KPuQmXZKl9bNb7O0U?=
 =?us-ascii?Q?eBcOJukffp47w5LNE1zrV/UEe0LmhOjURMK2gTqTSBjy5TE7CKvH/h4B/UbF?=
 =?us-ascii?Q?jUtd8FC/ng=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d38936-3d81-4b05-e994-08da12336612
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 09:55:19.6493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGZzefm1jrZKrvBp7KE7TXlBmfeXFQdXzGAdD0jVYN8XQSDSqlEufQqvrJi34c62RG1dXdja5T/nZpVWRI1JCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2704
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 04:47:02AM +0800, Limonciello, Mario wrote:
> [AMD Official Use Only]
> 
> 
> 
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com>
> > Sent: Tuesday, March 29, 2022 01:03
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Rafael J . Wysocki <rafael@kernel.org>; Viresh Kumar
> > <viresh.kumar@linaro.org>; open list:AMD PSTATE DRIVER <linux-
> > pm@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2 0/3] Improve usability for amd-pstate
> > 
> > On Tue, Mar 29, 2022 at 09:59:44AM +0800, Limonciello, Mario wrote:
> > > There has recently been some news coverage about `amd-pstate` being in
> > > 5.17, but this news also mentioned that it's a bit difficult to use.
> > >
> > > You need to either block init calls, or compile the module into the kernel
> > > to force it to take precedence over acpi-cpufreq.
> > >
> > > This series aims to improve the usability of amd-pstate so that distros
> > > can compile as a module, but users can still use it (relatively) easily.
> > >
> > > A new module parameter is included that will force amd-pstate to take
> > > precedence and a module table to let it load automatically on such systems.
> > >
> > > With the patches in this series a user can make a file
> > > /etc/modprobe.d/amd-pstate.conf:
> > >
> > > options amd-pstate replace=1
> > >
> > > Then upon the next reboot amd-pstate should load automatically even if
> > > acpi-cpufreq was included on the system.
> > >
> > > Mario Limonciello (3):
> > >   cpufreq: Export acpu_cpufreq_exit for other drivers to call
> > >   cpufreq: amd-pstate: Allow replacing acpi-cpufreq when loaded
> > >   cpufreq: amd-pstate: Add a module device table
> > >
> > >  drivers/cpufreq/acpi-cpufreq.c |  3 ++-
> > >  drivers/cpufreq/amd-pstate.c   | 30 +++++++++++++++++++++++++++---
> > >  2 files changed, 29 insertions(+), 4 deletions(-)
> > >
> > 
> > Mario, just applied your patch set in my platform, but it get the page fault
> > panic below:
> > 
> > [    4.195078] BUG: unable to handle page fault for address: ffffffff8aa2db87
> > [    4.196838] #PF: supervisor instruction fetch in kernel mode
> > [    4.197035] #PF: error_code(0x0011) - permissions violation
> > [    4.197035] PGD 1f980e067 P4D 1f980e067 PUD 1f980f063 PMD 100800063
> > PTE 80000001fa42d163
> > [    4.197035] Oops: 0011 [#1] PREEMPT SMP NOPTI
> > [    4.197035] CPU: 2 PID: 464 Comm: systemd-udevd Not tainted 5.17.0-
> > custom+ #1
> > [    4.197035] Hardware name: AMD Artic/Artic-CZN, BIOS WA21407N
> > 04/06/2021
> > [    4.197035] RIP: 0010:acpi_cpufreq_exit+0x0/0x46
> > [    4.197035] Code: 7f 00 00 a0 56 95 d2 4f 7f 00 00 80 f9 e7 d1 4f 7f 00 00 00 40
> > 90 d2 4f 7f 00 00 10 36 93 d2 4f 7f 00 00 10 a4 87 d2 4f 7f 00 <00> d0 b6 57 d2 4f
> > 7f 00 00 40 bf 1b d2 4f 7f 00 00 00 a4 85 d2 4f
> > [    4.197035] RSP: 0018:ffffaee0c156fc78 EFLAGS: 00010246
> > [    4.197035] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> > 0000000000000040
> > [    4.197035] RDX: 0000000000000000 RSI: ffffffffc04ee5c5 RDI:
> > ffffffff8a706100
> > [    4.197035] RBP: ffffaee0c156fc88 R08: 0000000000000000 R09:
> > 0000000000000000
> > [    4.197035] R10: 0000000000000000 R11: 0000000000000001 R12:
> > 00000000ffffffed
> > [    4.197035] R13: ffff9286ceead7e0 R14: ffffaee0c156fd90 R15:
> > ffffffffc04f0740
> > [    4.197035] FS:  00007fe0ab0c3880(0000) GS:ffff9289ee280000(0000)
> > knlGS:0000000000000000
> > [    4.197035] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    4.197035] CR2: ffffffff8aa2db87 CR3: 0000000105a40000 CR4:
> > 0000000000750ee0
> > [    4.197035] PKRU: 55555554
> > [    4.197035] Call Trace:
> > [    4.197035]  <TASK>
> > [    4.197035]  ? amd_pstate_init+0x7d/0x1000 [amd_pstate]
> > [    4.197035]  ? 0xffffffffc0477000
> > [    4.197035]  do_one_initcall+0x48/0x200
> > [    4.197035]  ? __x64_sys_delete_module+0x251/0x260
> > [    4.197035]  ? kmem_cache_alloc_trace+0x34c/0x450
> > [    4.197035]  do_init_module+0x52/0x240
> > [    4.197035]  load_module+0x2471/0x2790
> > [    4.197035]  __do_sys_finit_module+0xc5/0x130
> > [    4.197035]  ? __do_sys_finit_module+0xc5/0x130
> > [    4.197035]  __x64_sys_finit_module+0x1a/0x20
> > [    4.197035]  do_syscall_64+0x3b/0xc0
> > [    4.197035]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [    4.197035] RIP: 0033:0x7fe0ab64589d
> 
> Presumably you didn't have acpi-cpufreq compiled in or loaded at this time
> right?  I think I'll need to use IS_REACHABLE().

In fact, I have compiled and loaded acpi-cpufreq at first, otherwise, we
cannot get "acpi-cpufreq" driver instance with
cpufreq_get_current_driver().

Thanks,
Ray
