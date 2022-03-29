Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B614EA79F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiC2GFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiC2GFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:05:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51893E0C9;
        Mon, 28 Mar 2022 23:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic9BWal9rv+iM4kY5InGgYq2/++aWA6+wEnm3AUGEAU6vYR1iokrb/Fu1J+MZQqktKKzIwb6SIIkBxa7E4a1XCIVUKdI5+aAJLmuGMtz2RB2arfpca8y6Dz0KYfr4wRTBTxBskQNPCK7DsVjhZhvBLlToO6rMzyGvbm1JozCSshmaRuRZRfblPbbc2ShN65JKnL+z/W4L6rvl75/0X0e/Mw+DsrxBvGo0FUMFRJMQRQB0jzdpOLB+zN+fR6pHPou/bWn6WJby+d6ZlXbRNh40yUgGgnPYY9ajVj2QX00W3ArtbeyOBvhm+gWVLvJUYzTT0+PMZUdPLDMdrHGya3Jcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOw0aopa4PbwC4Z+Fy6eXUkTTMKPN42Rs5/KavVCJxo=;
 b=HbG0GNwx05VhEBTnbJZoxRlpussZFQS3njM28dYZP2IQAv0zpVhjDppJdSJEYm9Jb1DCNf+mObj0K4Kghzw8TkouXghcMf60uquCG5nbLpvH0ic2B3iMygFvbh60CmWxna13hlhNt1PoZ96/nfiqGLVYgHg163+4mFeowfcPzTy92SjTXK8gBc+exbIdAUwLnY8nnJe+ypg79lqIdEouz3/kz+yJ80nm5t3Ept3a/dcl/cNhlOcx6r2F+UEhaYkO1k9TPqjik+1ZSzuDUMhvzF7c7cTRh59Y8XZwahJupAOS/EvFl9oZ9RvT75dbgBWqqz2/PJ/ASlhs6rzJjbKujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOw0aopa4PbwC4Z+Fy6eXUkTTMKPN42Rs5/KavVCJxo=;
 b=LOzUkKeB61qSjYZsNYJu6jg5cHrYKJ6f+bcyeBSXJPFQw/jwQKMYJZYhpQ/8waA1LNWx0wpna9hoZrdpz8IETamW+5e7nVc4e02MaywFw41zC3IgoQi0b9PLjWob9thgRcVNT8Hla5nnlcaBBRpwMXSNZbAxVuDPPSL63gXWQ8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.22; Tue, 29 Mar 2022 06:03:13 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 06:03:13 +0000
Date:   Tue, 29 Mar 2022 14:02:50 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Improve usability for amd-pstate
Message-ID: <YkKhCplrh/TJl/OQ@amd.com>
References: <20220329015947.565-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329015947.565-1-mario.limonciello@amd.com>
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 531655e3-20fd-432a-f827-08da1149cf04
X-MS-TrafficTypeDiagnostic: DM6PR12MB3369:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB33694A84FA45597357F16A41EC1E9@DM6PR12MB3369.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AapC5Vrn4USSwE8E6g0+7sc3VUIs/JEzhHvupLBoWPpzsy012zVCJ6fOdVuFd76DD1YEAsqDloPf+ZL6Pmh1qBpUIk1W6PVQiLJNw0/9RkQylsb6tjWVbiTMU6/JCmDZXE/Bc6Go+Ax3u62RAz4fZ56DM76L3mfZCfjl3O4a3ryvb9O/j++VG//mUTPOB44CehY/+HU6yj0hlu0Md7LInBCIkRy1tR9alBnF87HZbWlN9ad421xjK7ehxmzFxZuVm4lxKjF8wSc+YXLly9RfKAiqDLZ6uiHa7bvv9srKyrcX48U7WYE3AKGCb3UDr5dXmW+rIllPNPqQy7xuI/OhVzzw44C2YZD/QylsL5XzVcSUUtDa4trlkEYTGVkHMpRYA8Zv2Y+9DWSF38qEduv9QF95RFTsXF1SSJSXlZ9DBhG0Y2gd9vWD0u0zEUYc0gI60Hyxe40ppW1w4dxLRCVLrXZtjcAKXLyXujd8sDV92TFgTCAOFa7nZznfzPUUqV2KZRpNuroey4MLg019AOXb/F0l3Q636l0w0T6s7VYxWHlZ6dhhFcX8VL6xj6ZYPuiTaxznTLtzF90x11atVTnLvXsnu9F1BwHGRcK0c28r5dy2nNjxnMmIMxN0sWlj37gRR2YGgAbG/9/Ew7PwBZH86w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(4326008)(6666004)(8676002)(6862004)(66476007)(66946007)(66556008)(2616005)(83380400001)(36756003)(508600001)(6512007)(6486002)(26005)(186003)(5660300002)(6636002)(54906003)(37006003)(86362001)(316002)(8936002)(38100700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VyKbivoW+s6+TrdtRta0qCRgtcCLPVuzwaCkGsjDYB+qzOj9vYI68VewvUnB?=
 =?us-ascii?Q?6ydspn+StbgVfm9QiszEQCfZ9VkOZud6MS2oT5l6QerSBhcpgC2qq+pN/Y7s?=
 =?us-ascii?Q?OqJD4mBa3cVoNBGqQjXKmZZlRBN/qDzGCNW0JozWc+y7mLQOKtHfA3hDsj+R?=
 =?us-ascii?Q?4o0Bpo7VwDhgVysqe1T360jqyHPoruVuAHwarnxiJGlrUqY35vQKD7mxSWbf?=
 =?us-ascii?Q?fK+K9EELf7ACVv4A1MUiatLgKlVkYXP7Oe8MshJl/BLqTmBsnz0W3H7xZHpC?=
 =?us-ascii?Q?9sGda6SqI2uumqcDBOtfHrzNHWCqn6sSOSjTF0jj+kAsrcitN6jiffM9L+er?=
 =?us-ascii?Q?uk+ylVWWAfN8bKy7RyLScR/hFEUzhWfSMu+IFkkqPRRKjsljltEO2e8JXhNP?=
 =?us-ascii?Q?+rYvc81FjpYEkpldduviZsIHfiWlKjvQyOAOg7iks5auud83Kq+JQeri2Kkn?=
 =?us-ascii?Q?lJNg9HD7rxq4sSKxQ+10oEgxjWSpdu+IoJLw0/BJHGmOPfl9hOg/YHzhI1r0?=
 =?us-ascii?Q?jRm/Ktft/TB8MPN3FXCrAjJ1N2DmbbcEXMDf8YXeZpt6YlxfYOyGbx14rqQ+?=
 =?us-ascii?Q?8M9eSC4liwkuOGq2n7OhEOIwXE+8jKAVuLf3U0WNBtMAdiMJCDy4eWddN/+f?=
 =?us-ascii?Q?3SSnDNTf1VZztBW06oWn/493YPNjEGtqMgy34+sS91jMVW3sN/uVJdOE/F+Z?=
 =?us-ascii?Q?Q2TxkC0RT4aXpuXp1KJHrij+HWybNb6YQV+SWmEgKwGAcIVyGvPD9T8FRPg6?=
 =?us-ascii?Q?6jq0aZ0Xx+Kkllp7xJ+zC+yE9X37ogq1N2LnLD/b1ctsX7Fyq5BBDXvUuu9z?=
 =?us-ascii?Q?svp2yoY+O18VUDpMaPmUrwgCBJmBxKCeg3SCGco/Tqym/obdhcgKXCdhWNcY?=
 =?us-ascii?Q?bvNu0cQA+iwfeYudwWX7MIAWqDTfaExWmgIrDsMi+muubVbaL66mmb60dfWm?=
 =?us-ascii?Q?V5m9f0kVPsbod/TGGBalACLJMB/N5lMTIM6bCXyVKmK0E/P7shZ/H7tpetsE?=
 =?us-ascii?Q?+XGjIXhNo+Ib1w42alVa4snpjJIMHwoxPNLCdQZrIuhBtBjlXinDHUjD9lDB?=
 =?us-ascii?Q?aVf4j8pCneJIInp69fcQ11CaGAGvTjPAY/nEF/EW8V+J2ioHI46jFWLIJ7b+?=
 =?us-ascii?Q?zevy8PYMzpw/U8+T6vQS7QyHH7XeiQBsg6RAWVwOB8NdI1qLQq3rJyQ+XhLb?=
 =?us-ascii?Q?D4kjNGM95S1zrVeoHCZO8QkFKhdwDa58x9EDQXPtPJlirI7Iz7O4SfTovCZx?=
 =?us-ascii?Q?UDkZ+5LW5WV+VjzgpaGU+xKzx52vmaHK04N4P08ykUE0qoPS+QwQsG38SHaF?=
 =?us-ascii?Q?MsnGUyZDzAmdFCIy+5Hl4VlzFHppzZte2RKPKOkW4+ksdJCQZrGrTJmmWc3w?=
 =?us-ascii?Q?FKD2qbERKyPT9Te34Y+HED5x6wG8EVFSrBMHsBPmCkRknX4WcNT/sSZ3YwXG?=
 =?us-ascii?Q?7vXt0YBELqPemPadHkf2V6lZxoEubu6jIDfKDqjRh6uGKlVIzK9lP5Pth7Is?=
 =?us-ascii?Q?RTFot16/Siae+ARJ3Hu3NPJET1pceGXRoJTWwPWHWoCydarfmzB7dDGvINAq?=
 =?us-ascii?Q?/9eTrZdhwKb9SGTMM1XQC6yMfB+iQg4YmQOK9M3j/521fzQil8gZEa4El78D?=
 =?us-ascii?Q?4jEmX6IOiXdZe3wQoyQHoNUivlBYbsPBp1q1OU8ohP04de+3gWlVwmEfOXbp?=
 =?us-ascii?Q?xmqJcM1Eg3fBzJWHUUNC6dt8mMEHs5MujTBH2f6PzNyYZ1ueC00Y0EmAwSTH?=
 =?us-ascii?Q?BpF1+dNh6w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531655e3-20fd-432a-f827-08da1149cf04
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 06:03:13.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXJFgyIx7AfbMwdvoQ28ZKggqgf6BH6dwzQj5dJSlzG/HtAo6HlacNR3MYLEjzTU8Le0wxfEyi82wOYh5CVSrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:59:44AM +0800, Limonciello, Mario wrote:
> There has recently been some news coverage about `amd-pstate` being in
> 5.17, but this news also mentioned that it's a bit difficult to use.
> 
> You need to either block init calls, or compile the module into the kernel
> to force it to take precedence over acpi-cpufreq.
> 
> This series aims to improve the usability of amd-pstate so that distros
> can compile as a module, but users can still use it (relatively) easily.
> 
> A new module parameter is included that will force amd-pstate to take
> precedence and a module table to let it load automatically on such systems.
> 
> With the patches in this series a user can make a file
> /etc/modprobe.d/amd-pstate.conf:
> 
> options amd-pstate replace=1
> 
> Then upon the next reboot amd-pstate should load automatically even if
> acpi-cpufreq was included on the system.
> 
> Mario Limonciello (3):
>   cpufreq: Export acpu_cpufreq_exit for other drivers to call
>   cpufreq: amd-pstate: Allow replacing acpi-cpufreq when loaded
>   cpufreq: amd-pstate: Add a module device table
> 
>  drivers/cpufreq/acpi-cpufreq.c |  3 ++-
>  drivers/cpufreq/amd-pstate.c   | 30 +++++++++++++++++++++++++++---
>  2 files changed, 29 insertions(+), 4 deletions(-)
> 

Mario, just applied your patch set in my platform, but it get the page fault
panic below:

[    4.195078] BUG: unable to handle page fault for address: ffffffff8aa2db87
[    4.196838] #PF: supervisor instruction fetch in kernel mode
[    4.197035] #PF: error_code(0x0011) - permissions violation
[    4.197035] PGD 1f980e067 P4D 1f980e067 PUD 1f980f063 PMD 100800063 PTE 80000001fa42d163
[    4.197035] Oops: 0011 [#1] PREEMPT SMP NOPTI
[    4.197035] CPU: 2 PID: 464 Comm: systemd-udevd Not tainted 5.17.0-custom+ #1
[    4.197035] Hardware name: AMD Artic/Artic-CZN, BIOS WA21407N 04/06/2021
[    4.197035] RIP: 0010:acpi_cpufreq_exit+0x0/0x46
[    4.197035] Code: 7f 00 00 a0 56 95 d2 4f 7f 00 00 80 f9 e7 d1 4f 7f 00 00 00 40 90 d2 4f 7f 00 00 10 36 93 d2 4f 7f 00 00 10 a4 87 d2 4f 7f 00 <00> d0 b6 57 d2 4f 7f 00 00 40 bf 1b d2 4f 7f 00 00 00 a4 85 d2 4f
[    4.197035] RSP: 0018:ffffaee0c156fc78 EFLAGS: 00010246
[    4.197035] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000040
[    4.197035] RDX: 0000000000000000 RSI: ffffffffc04ee5c5 RDI: ffffffff8a706100
[    4.197035] RBP: ffffaee0c156fc88 R08: 0000000000000000 R09: 0000000000000000
[    4.197035] R10: 0000000000000000 R11: 0000000000000001 R12: 00000000ffffffed
[    4.197035] R13: ffff9286ceead7e0 R14: ffffaee0c156fd90 R15: ffffffffc04f0740
[    4.197035] FS:  00007fe0ab0c3880(0000) GS:ffff9289ee280000(0000) knlGS:0000000000000000
[    4.197035] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.197035] CR2: ffffffff8aa2db87 CR3: 0000000105a40000 CR4: 0000000000750ee0
[    4.197035] PKRU: 55555554
[    4.197035] Call Trace:
[    4.197035]  <TASK>
[    4.197035]  ? amd_pstate_init+0x7d/0x1000 [amd_pstate]
[    4.197035]  ? 0xffffffffc0477000
[    4.197035]  do_one_initcall+0x48/0x200
[    4.197035]  ? __x64_sys_delete_module+0x251/0x260
[    4.197035]  ? kmem_cache_alloc_trace+0x34c/0x450
[    4.197035]  do_init_module+0x52/0x240
[    4.197035]  load_module+0x2471/0x2790
[    4.197035]  __do_sys_finit_module+0xc5/0x130
[    4.197035]  ? __do_sys_finit_module+0xc5/0x130
[    4.197035]  __x64_sys_finit_module+0x1a/0x20
[    4.197035]  do_syscall_64+0x3b/0xc0
[    4.197035]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    4.197035] RIP: 0033:0x7fe0ab64589d
