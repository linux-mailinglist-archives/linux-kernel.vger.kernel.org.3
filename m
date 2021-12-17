Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA53F478410
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhLQEbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:31:08 -0500
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:65132
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229511AbhLQEbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:31:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYDvIRNVZfTTf2Z19ezcVgYHD9RuiZh1HSAAw3ILpALKiHfB4Z2Vuv1wFMOphq8l2gtTkZT9MtGFXoWWrfVH0xqmNguNaT4vpSueHyiwZUSHBjOXX47jTRIqTU+7HnyoTlcigh7TGdRHJ2j59gChFkTy8IUKsOf6/xy1duCxNPelrdORKgn7Q4+vIj4JP2+SEa9sPS5LyjdHlHwKASE0LvxKGOiQboI6I/k9qvK9TJcHnyg8ECKBKOGx68V8NtCs/EXcVPPXwjNofBBIMBSpdfvaav7RP+xqw/MLwxeA2tq88c6/CvzDUfZ+DUZwatu9dZLxey+shDxPEs9TY7uGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+egCpSftPeCYN2Wzb+6GyeY2UYQps5hcz26o+sk7Y0=;
 b=D0nR6isxfsP7qn87WtYGwu6Kz99xJ7nq3t+NlbIfd0vq2myTYbRc67IE0kP61fJvIeYcbnEhs66CG7LhJ3qC65Ka7VHuk8PYmaAsIz/9ISpsOb+hbZUp1jnxMBZvhcAETO+rg59BM1/twa/pXTYxUHjzx+tTONJJJJkmKrTtknYxjuKIjj1EjTWXRVqoZi0VcOaYcrjkWL17Gr5NqbLG0Sg2r85TUPwCCHhc3rfZB3NWKI8i1XLGQbjnowvo6ctId+6SdwKLG1bxckZ+65Jsxjkw9XGQiXz7zbFjH0M+Ztru5HnEJXqXKIbjgCjcP/WRi7Ds/rhfAmR4H9K946WNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+egCpSftPeCYN2Wzb+6GyeY2UYQps5hcz26o+sk7Y0=;
 b=3QAY38d17Q+LbPWz+7KCfwQ5ZZpjdAvV813VN79KpCQIKOqdpEcjxJA7xUGtKQk+DZY9pjpGRmF1BrdSru2O6VrVwiw7xXvmtR+IQzWonh2YcmLJy2I1ByNbGzQJTzQZ0fgsbfZFMIPxB/kUeIKtRmQ/5z7yBzN90517zBKzkzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB4530.namprd12.prod.outlook.com (2603:10b6:5:2aa::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Fri, 17 Dec 2021 04:31:06 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187%5]) with mapi id 15.20.4755.027; Fri, 17 Dec 2021
 04:31:06 +0000
Date:   Fri, 17 Dec 2021 12:30:42 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v5 03/22] ACPI: CPPC: implement support for SystemIO
 registers
Message-ID: <YbwScmyB6sml3onw@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
 <20211130123641.1449041-4-ray.huang@amd.com>
 <CAJZ5v0iTnQYpj6aZBa8ZqUQN-TJCK0GLRhK1-mdXEX1iPpkjxA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iTnQYpj6aZBa8ZqUQN-TJCK0GLRhK1-mdXEX1iPpkjxA@mail.gmail.com>
X-ClientProxiedBy: HK2PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:202:17::22) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
Received: from amd.com (165.204.134.251) by HK2PR03CA0052.apcprd03.prod.outlook.com (2603:1096:202:17::22) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 17 Dec 2021 04:30:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d461dcc3-2fe0-42b2-4948-08d9c1160a24
X-MS-TrafficTypeDiagnostic: DM6PR12MB4530:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB453058B09CA2C4B3E7C15C68EC789@DM6PR12MB4530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GHcxNvxsp3od7GZQS6jIoOf+Qmy38U1BiRbkwWJ+AV1Sp76xd9EUmFcANlZHGP3s/AuZVce4pv7hsNzIetWEp1j9BqG3xejYYTtH7XVaxmjkUjI9LX8OJ7P3VdeGBdtIkO/t5yLCYm6sUVxLFBmqWQLU2AkoV0N+7zCBndJ8Emf3tmzWYMhx5Eh0l/2acvIN3Unhhn0mt6ixnRBvtL07BNTJLjnI+RJNWw5624foBTLoHa3b0+vh82hwwd4PHTaNTvVluk3Rb4gLVJ5PDKftFLjF9vGRWso3lA/et5d2o+cC9RLlMHO7BLA17RU5zSBQnIi/IxYDJI9F6q0aN3vxXQscFagllppwJCj+ieSwk68XbGmiAVdhXUNnRS4YyiOiXv7yEJxUCbN8k8t2wRymdkN99PrsY4VXOrmXyi57MASJGXIoiSHGYYk/hAJFGOGQMLayItPrRdMURlKV/ivP0ZQw/EUmjuQjNVLfHNI6EJHDL5KiHDxxYpg0MToHPRx9WtXwH7OQXqWT3TJDlH0UuUvG9QcwFl5gvzes02GtilrlC8ZTru0CGMBWa9LeskAfjpczfIrK0vrLZ/X9N6H0fFw5FbyTk7kMKNI3/4j7n+zQL/tQ4HAOYcC6eAip0vE+6CGv8YkLJNeQmBaZMzvxZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(4326008)(2906002)(26005)(83380400001)(38100700002)(2616005)(6666004)(8936002)(7696005)(956004)(8886007)(6916009)(8676002)(54906003)(53546011)(36756003)(66556008)(186003)(316002)(86362001)(66476007)(66946007)(55016003)(7416002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?84kuAP+3DUeatf0pHVx/XIEo+dYrhotrGBToNDpUxdNmf7VL4ximZ3cR+WBU?=
 =?us-ascii?Q?X6nP3U1gDthV52vTheMeXtCHZAUjlDaxmCcgPcnw46Ezqb7u2ByDh+BDT4ZF?=
 =?us-ascii?Q?QqjAA3B8wsFfAT2REROdL8fhK6ej6UKn7v3FhY+iFRcMflqaJUiRLA0yIJA8?=
 =?us-ascii?Q?8kPwG9tK02vwtsfUSkey0e+yxBLHQHVXNxeUdMeUDapijxhmq9+LJhqdBp7k?=
 =?us-ascii?Q?eJSaW+w96fckXLObxg+K7Nb6HemZvUA/QlACE8Zo4IMg5pIiR7qC6/yHVYX0?=
 =?us-ascii?Q?pZuqhcLjPHRQWI9bbE83X1osAGYct56bSvdjCv9aXCkHuy6UwVcLjszy1ARO?=
 =?us-ascii?Q?/0ZfhKxu50wg27cqQ80G9fzNwip0b7sses/0+HGabsahpKrc+lbYqZ4mFg6s?=
 =?us-ascii?Q?kaTjrGSMSXZtmZKbjij/DwUG8eR1yWZhU1nJgT6XTr57t0UyJ0oVv/vmLcvL?=
 =?us-ascii?Q?p/a0eQBQ/zEv0tu3olu0kIhgPJnAtUrQNmmqlV8C9VauZGtANcYrCF/L07M9?=
 =?us-ascii?Q?aKdUGtZOglU7sR4p0bGco3l5hjDES7UGYZWzwqKuR8O6iL//+aOGltlqaWh+?=
 =?us-ascii?Q?FkOPMpj5Yw2IBhHPE/M8pzAlCWEnl6YZ953mOKxCHdF4ILUcazQsCrSfaXiS?=
 =?us-ascii?Q?G2AurdWVFKGMKDdOzFhgxoVkgLWnCdIy8qD+5yN8rPyE2BBNs+eIg/Xt43WZ?=
 =?us-ascii?Q?dBB58xcgyzctw5W7ke0u7LjN9q5OreJ9B73xkzeW6AzKWRuKvZ4oeupZdd+Y?=
 =?us-ascii?Q?wGqq226GTKgCZCv10VdAW0ZVBg89TCLUcSQf1f0e9qm28VFkWoZJlHMMSq9N?=
 =?us-ascii?Q?hBi2dM1pxJOiPCgMC0GpyMe8ZfC23y5AGixuvCec5tK7qzQrOkJgtspwcEaj?=
 =?us-ascii?Q?wZPehlwLr2+mF5rxDOmmQ3pe75jliibJTiFI4gzD7M840glD/TtgpLIe5/Mg?=
 =?us-ascii?Q?YM4TALfyXS4SaPHwtooTF8WLdNqKnqxKC26k3pbi4moP1BOXgVjdlTXbq7Yu?=
 =?us-ascii?Q?Lxc7lCT0xhBnsboiOli+8p64yglK++ApbQS70zdVaNfEgpLpKseHucfFiM4V?=
 =?us-ascii?Q?cr5S2Y9iddRQKqM4pPuI2bGObSvT43gXrO2pCwb7WHVycESZ+g3bQuxvZ0Fn?=
 =?us-ascii?Q?MarH35wyug3v0wiDlIhI9q2I71fAoJPSx/DhdHm8He9gwCAEoHXewo7pNVeQ?=
 =?us-ascii?Q?Dvgc2FOZ8Z22afSVil8UjuOz8db7i97jwxBdn+866vwJK+asNQsxSsmtqhsa?=
 =?us-ascii?Q?d+OE9xDXpZAmjHdCUFpnQXf72xdtLL5wwFSRclBlmC3KHkEBu7J290Oaxa9H?=
 =?us-ascii?Q?1ghOJYBQAl18hstdzSoMwwIejnYOn5UWzugBtcAwp5CmsjwxBqDbLGjRRWiW?=
 =?us-ascii?Q?7yz3k3PY3n5QJVvUDtnyNY0r1t+y3xM7deLVVj7Ub94AiO+dhkhtgxHeX0f1?=
 =?us-ascii?Q?RwIym2qxbEZ2JLeT4c54tonjvUIKsQ533WW9D+BHYQRqPHvyTNk+k7htzAvL?=
 =?us-ascii?Q?21eVXty5cd5I59rntGz7fZCRA7QXeio6clXzgajWLo4lPU7esyHRcxzhpYcf?=
 =?us-ascii?Q?DEUKZbO7HLMG/cAKHTWznvlwhyAjTmqFVkJzDexWlNfPbFOE1k+1bQ6F8g6q?=
 =?us-ascii?Q?2rKl5x/u98FThiy2mbndlG8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d461dcc3-2fe0-42b2-4948-08d9c1160a24
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 04:31:06.1195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kmz7GtMa7RcJHYTR3xNq5/pnxakjKu/K4/oCOxXNgASUnwov3KMqHe+4LK67RL46gNk0+6LSFlxH09JsWEqhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4530
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 01:40:47AM +0800, Rafael J. Wysocki wrote:
> On Tue, Nov 30, 2021 at 1:37 PM Huang Rui <ray.huang@amd.com> wrote:
> >
> > From: Steven Noonan <steven@valvesoftware.com>
> >
> > According to the ACPI v6.2 (and later) specification, SystemIO can be
> > used for _CPC registers. This teaches cppc_acpi how to handle such
> > registers.
> >
> > This patch was tested using the amd_pstate driver on my Zephyrus G15
> > (model GA503QS) using the current version 410 BIOS, which uses
> > a SystemIO register for the HighestPerformance element in _CPC.
> >
> > Signed-off-by: Steven Noonan <steven@valvesoftware.com>
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/acpi/cppc_acpi.c | 46 +++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 43 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index a85c351589be..ca62c3dc9899 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -746,9 +746,24 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
> >                                                 goto out_free;
> >                                         cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
> >                                 }
> > +                       } else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> > +                               if (gas_t->access_width < 1 || gas_t->access_width > 3) {
> > +                                       /* 1 = 8-bit, 2 = 16-bit, and 3 = 32-bit. SystemIO doesn't
> 
> The comment format is not in agreement with the kernel coding style.

Will update it in V6.

> 
> > +                                        * implement 64-bit registers.
> > +                                        */
> > +                                       pr_debug("Invalid access width %d for SystemIO register\n",
> > +                                               gas_t->access_width);
> > +                                       goto out_free;
> > +                               }
> > +                               if (gas_t->address & ~0xFFFFULL) {
> 
> It would be good to define a symbol for this mask and use it here
> instead of the raw vaue.

OK.

> 
> > +                                       /* SystemIO registers use 16-bit integer addresses */
> > +                                       pr_debug("Invalid IO port %llu for SystemIO register\n",
> > +                                               gas_t->address);
> > +                                       goto out_free;
> > +                               }
> >                         } else {
> >                                 if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE || !cpc_ffh_supported()) {
> > -                                       /* Support only PCC ,SYS MEM and FFH type regs */
> > +                                       /* Support only PCC, SystemMemory, SystemIO, and FFH type regs. */
> >                                         pr_debug("Unsupported register type: %d\n", gas_t->space_id);
> >                                         goto out_free;
> >                                 }
> > @@ -923,7 +938,20 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
> >         }
> >
> >         *val = 0;
> > -       if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
> > +
> > +       if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> > +               u32 width = 8 << (reg->access_width - 1);
> > +               acpi_status status;
> > +
> > +               status = acpi_os_read_port((acpi_io_address)reg->address, (u32 *)val, width);
> > +
> > +               if (status != AE_OK) {
> 
> Please use ACPI_FAILURE() here and in the analogous check and below.

Fine, I will update this as well.

Thanks,
Ray

> 
> > +                       pr_debug("Error: Failed to read SystemIO port %llx\n", reg->address);
> > +                       return -EFAULT;
> > +               }
> > +
> > +               return 0;
> > +       } else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
> >                 vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
> >         else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> >                 vaddr = reg_res->sys_mem_vaddr;
> > @@ -962,7 +990,19 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
> >         int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> >         struct cpc_reg *reg = &reg_res->cpc_entry.reg;
> >
> > -       if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
> > +       if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> > +               u32 width = 8 << (reg->access_width - 1);
> > +               acpi_status status;
> > +
> > +               status = acpi_os_write_port((acpi_io_address)reg->address, (u32)val, width);
> > +
> > +               if (status != AE_OK) {
> > +                       pr_debug("Error: Failed to write SystemIO port %llx\n", reg->address);
> > +                       return -EFAULT;
> > +               }
> > +
> > +               return 0;
> > +       } else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
> >                 vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
> >         else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> >                 vaddr = reg_res->sys_mem_vaddr;
> > --
