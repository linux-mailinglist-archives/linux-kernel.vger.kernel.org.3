Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19CD48E169
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbiANAQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:16:00 -0500
Received: from mail-mw2nam08on2057.outbound.protection.outlook.com ([40.107.101.57]:36704
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232240AbiANAP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:15:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P86YSHktTsSXa1Mt6/m6a4reaqHzAxgqTxLX7au7DAOXmseFq4C3ozhfzyLZNkrKKFBPazH9+X38yFhwTqnWFiT36SpX/TTaqfqV+P6J1ijhw6i4wxvgfjr07Ro75+TiXq7wjFg2J49D0KqjKcUtOAQchppElKD3E9MxIWkrnKImO6zIXSg+xLI20rAQogrJz6cwRmqSagVO923CSn5fptKR0YKF7mFy23eA0Z1GcKGo4vxjChrECjLJH6hAUwAbJmCcW8qQCgqlCSEn9yliMGGKqjJPFQLg0EfZXk4UzPSvSiodltRoxH7vMXDVHUKc3gb7zUxMkdB/ThKI6V0Zrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sP9Sc+WxWFf9tvmgN9cDqfqxd1MjUWMdEey83TzBq0=;
 b=Klx/GcFix9l6ApkiNSeh8RgoGSdwQ7+NLdTdT7KhWYo8NDqZN5a9DqHHLiF90QXW5GuSXGTe73PfqkibwBn6fn/JG4Q3JJhQSsoqHq/BIld3csBYBOrvXWohwDxQMkLFNSN06ldU2iktFIOWCABWf5AM1//TsvsupF/uf7yHE42oRcwTDSWwTfMKj1k3FrjQqIGkt83i2em0FhOcTJs3GMxcW6x190F1o0DCvTD38PTCKljM5j3dWrylh25OHxreaDt5GXvFEayvddQHItpS/G/baUVeH0CxVh7qQwa70vhGJ+rIf3rpSvbXIgdGgjHynkWH7/K3IW5zEtfzeJk7Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sP9Sc+WxWFf9tvmgN9cDqfqxd1MjUWMdEey83TzBq0=;
 b=vVr45gA7znJV+7Fp+k1zRjV7GYmr/QG8QuLVUcdll7ervSOA1TQ0BGozoUCeSqHdwM0uEjKUnnzZHwKuCwvqqEUcwkbeEEvghsyCnXa3if8Sr1t4uyOhRqpeH4CaH9TiW9bSCLOc+Y9ncpYdHvmhGLIWCoUNJqO/Hk9LzfvHFBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB3465.namprd12.prod.outlook.com (2603:10b6:5:3a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Fri, 14 Jan 2022 00:15:52 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 00:15:52 +0000
Date:   Fri, 14 Jan 2022 08:15:31 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/1 FYI] tools arch x86: Sync the msr-index.h copy with
 the kernel sources
Message-ID: <YeDAowKCU777NXSa@amd.com>
References: <YeA2PAvHV+uHRhLj@kernel.org>
 <9d546cfa-93e0-5b53-9100-5e9b091fac1b@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d546cfa-93e0-5b53-9100-5e9b091fac1b@intel.com>
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15fbd1e0-c55e-4ea3-dc4e-08d9d6f3067c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3465:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB346505E954E1A08EFBEE494CEC549@DM6PR12MB3465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N72fYhY1e5N1zG0l4cfTMt3XtrHw6/XCMrzoRWTd6c3O6OGetdQriGN3krCN4PicgF/eN4DFg7tP1l9iWaRPwWLzA1qjg4ESQx0ndzysku5Uk9VHb41s2ulILAJRxaFSBmUKrM7QhgOFLenqImwv1UcDdShxc0mxNpVdCNNTdZl/ajPE3d9WKVqAHzTnTxt/SnnCOjLGi1036VLm5Sv3cCW4p7jMoSofTQCMG7yEnz3JeU4ivXP7cNWX1CPwUzrh9/wPNaRMKdX5AESuPtK7xc98x+XAMGiEF9revyRf8cZuWqW9Sa0Gw1JBNDXzwvjJQsVcLZsNe1blDA8UCzbvvn53W9jX+gYCaZsn/IrqAvNmRXSSC/ytMSklu+1qb9Cpkb4jStkXqZWoxS+CUsOaiFZOPS03uR4haQK5zIOmLKosJ+ALViLGGzXo/3liD3MiXdplYat6iYrDS6iXCIbNwthVFLE86/4o+wnabFJYJFvEXtwAB0TesxoLukb1owQxmgJ6pWzVtnXCT2RihSg92b67m9plr4x2ZSD2TC/psXRxV9zdF+JV4v+CyPqBpRFZmY7kUoSPMMLWravhB7T5LAdjunMAPXo5YLtE4grRngHi6MDfsx5+1Kx59IbKOdMS60Fz/yWhCpM9MR2e29tdtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(86362001)(53546011)(6506007)(6916009)(6666004)(66556008)(66946007)(2906002)(316002)(6486002)(2616005)(4326008)(8936002)(38100700002)(26005)(54906003)(66476007)(5660300002)(8676002)(36756003)(6512007)(508600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QHoWZX3W8YK7p2ClNTnX7M48G7NJpzjLedRBEnlCfI9v9M6lljHmHmFtUwoM?=
 =?us-ascii?Q?dLsgTQAcby8AxVbe5s2Zb/yPII3xRoPFscJy9ZWIygushEqx7HMTgceGf3yK?=
 =?us-ascii?Q?u4w3MPY+Jno5rHu9hU1n/2dzVmTnWwt5j0tJisDVIYFs2CKSupgdmuf0zxyU?=
 =?us-ascii?Q?8ou3YxdPh48aovVuFW2KMdUySTWh/aFKMkU7T+qPPXOd9whGe7cu7LTD6v7a?=
 =?us-ascii?Q?pAEf2b/crEE5MWg2xbbqklBrPUuY7JaD2TzzY7q05vePY07u8o5jYDQroLcQ?=
 =?us-ascii?Q?kyPhFN7FEDx9HIJOwZ9WV905mHOMHF2JpJKQF0sfjLDxbpqWZknlSjyQoFgW?=
 =?us-ascii?Q?JUwLDzncu2EBUCn0dk0KPreUlrTSSTHzLNHFAQ3/us8zu6WmmqtqGBroZkJD?=
 =?us-ascii?Q?Ua2Zn47aDEga+vONXvQNQsbcHefG5OBhvheJCoKhIXY09tAiRmvXw0E8M57A?=
 =?us-ascii?Q?cMPXqx+ehaeSA3trFhlNFwrrokPiBvRpFwL0L6YIIxqaz6MVu3DES4ZW4Ar6?=
 =?us-ascii?Q?ZX2Ffa4/W7+copyLhZBiLbrZipqCnMBj2iD+Y9g7gXRji8WsaynpyhRKe1tA?=
 =?us-ascii?Q?LaCblhVSgozooCZIw2WzcMyv0KlUIKSMsMlCpylmarlHWtvNPzMJUrLuyDSq?=
 =?us-ascii?Q?2LQw7TfTc6FLZiUQrjWmJndndRAsLILPy5h6JL4LgAzGIA/y1ot7JpTL4Eyc?=
 =?us-ascii?Q?L8jmvy9qJ9dPfMLqpQMXBevcwdzOZOT313q3xDZQqbIUCZBX0QLyZjM2iMej?=
 =?us-ascii?Q?dtg7tNCx1/lCGSpgh/c7JaynJ1b+1HKBMwxhx3GfwQt7hoT7zwXH3r8+XtWb?=
 =?us-ascii?Q?cQLpwg4HS6juAJeumVuYuw5Eme8ojkVnJ9YIPqW1fQdr2aqAcCgG6DYth1na?=
 =?us-ascii?Q?2VVdm9p7fB3KspJGyOG2sts/GhFT0Hm7sFan+zbHqBu9bF/vPCADFNHaZ5OY?=
 =?us-ascii?Q?viAoFKE9CE/OBgKVxufzkCvpJc74SpVUAEHy173suiareDLB6pVWPnxb2+Vt?=
 =?us-ascii?Q?raI1PMCr3c2l/mJpnTtIBGho3HY/3zyRwFKT09mN211RHL35aqKxE00ySmMQ?=
 =?us-ascii?Q?Pah/aBcmLGbXQKONARcAOIMpMvRtwRYFRQg+5JWJs5mN+OogeuFVfyoy/1wQ?=
 =?us-ascii?Q?Ke/dpdPhK9qs8+r9UvV3Nxnm8NCknib/bvivkuVhF4wk2/sm7SoubHTmIDI8?=
 =?us-ascii?Q?7/3AhyE77kwPms//9LQI07Es5Enqec88EkOXEMMl8P37B4NtQc0JJUwSjBCJ?=
 =?us-ascii?Q?ACyvC/PFEYvynV4xWqMI2s5n4wvWyAD7p1bccywuPXKahWw/A+/XYtRg6lpu?=
 =?us-ascii?Q?RhJc2FX1D45AHdiq99kumm2umfMkd0CrwQX6FiIScceLPnAbg8zKSTORAhQD?=
 =?us-ascii?Q?sKM3+FMbMdDtSD0++0hyXh+8yg7aPZLc3Sb88P3rKoD2n74b50LAWfCwN9IE?=
 =?us-ascii?Q?JyTcWJJeLtaO2LM7KGbFnpU5f2F6wwDi2c+J5xsWAjh/86bkoM8Bf216r2EU?=
 =?us-ascii?Q?vJ2ia4vR7+DuoRjmZYtvedcoV2nwGTP9p0C6uyBvNm5+i/aDVdWEMSgyA0Jq?=
 =?us-ascii?Q?5fRRy/8v/qKpgTVT1NPqou0Tz2fl87I2fQoVmhIT8xnHDjxMqgWKK+uS0K5X?=
 =?us-ascii?Q?h+pMRruj6DA+EX8Y04c6t2c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fbd1e0-c55e-4ea3-dc4e-08d9d6f3067c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 00:15:52.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmiytInc9oorChhZ9RFT4MfUnpwZqL8OdNYy+3Y+9YTR7/NywtinN0DMKTjV45wJZ6LbRXUzqvbFQ8g4bbufWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3465
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 03:14:32AM +0800, Rafael J. Wysocki wrote:
> On 1/13/2022 3:25 PM, Arnaldo Carvalho de Melo wrote:
> > To pick up the changes in:
> >
> >    89aa94b4a218339b ("x86/msr: Add AMD CPPC MSR definitions")
> >
> > Addressing these tools/perf build warnings:
> >
> >      diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
> >      Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
> >
> > That makes the beautification scripts to pick some new entries:
> >
> >    $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
> >    $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
> >    $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
> >    $ diff -u before after
> >    --- before	2022-01-13 10:59:51.743416890 -0300
> >    +++ after	2022-01-13 11:00:00.776644178 -0300
> >    @@ -303,6 +303,11 @@
> >   	  [0xc0010299 - x86_AMD_V_KVM_MSRs_offset] = "AMD_RAPL_POWER_UNIT",
> >   	  [0xc001029a - x86_AMD_V_KVM_MSRs_offset] = "AMD_CORE_ENERGY_STATUS",
> >   	  [0xc001029b - x86_AMD_V_KVM_MSRs_offset] = "AMD_PKG_ENERGY_STATUS",
> >    +       [0xc00102b0 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_CAP1",
> >    +       [0xc00102b1 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_ENABLE",
> >    +       [0xc00102b2 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_CAP2",
> >    +       [0xc00102b3 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_REQ",
> >    +       [0xc00102b4 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_STATUS",
> >   	  [0xc00102f0 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PPIN_CTL",
> >   	  [0xc00102f1 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PPIN",
> >     };
> >    $
> >
> > And this gets rebuilt:
> >
> >    CC       /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
> >    INSTALL  trace_plugins
> >    LD       /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
> >    LD       /tmp/build/perf/trace/beauty/perf-in.o
> >    LD       /tmp/build/perf/perf-in.o
> >    LINK     /tmp/build/perf/perf
> >
> > Now one can trace systemwide asking to see backtraces to where those
> > MSRs are being read/written with:
> >
> >    # perf trace -e msr:*_msr/max-stack=32/ --filter="msr>=AMD_CPPC_CAP1 && msr<="
> >    Failed to set filter "(msr>=0xc00102b0 && msr<=) && (common_pid != 2612094 && common_pid != 3841)" on event msr:read_msr with 22 (Invalid argument)
> >    # ^C
> >
> > If we use -v (verbose mode) we can see what it does behind the scenes:
> >
> >    # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr>=AMD_CPPC_CAP1 && msr<=AMD_CPPC_STATUS"
> >    <SNIP>
> >    New filter for msr:read_msr: (msr>=0xc00102b0 && msr<=0xc00102b4) && (common_pid != 2612102 && common_pid != 3841)
> >    New filter for msr:write_msr: (msr>=0xc00102b0 && msr<=0xc00102b4) && (common_pid != 2612102 && common_pid != 3841)
> >    <SNIP>
> >    ^C[root@five ~]#
> >
> > Example with a frequent msr:
> >
> >    # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr==IA32_SPEC_CTRL" --max-events 2
> >    Using CPUID AuthenticAMD-25-21-0
> >    0x48
> >    New filter for msr:read_msr: (msr==0x48) && (common_pid != 2612129 && common_pid != 3841)
> >    0x48
> >    New filter for msr:write_msr: (msr==0x48) && (common_pid != 2612129 && common_pid != 3841)
> >    mmap size 528384B
> >    Looking at the vmlinux_path (8 entries long)
> >    symsrc__init: build id mismatch for vmlinux.
> >    Using /proc/kcore for kernel data
> >    Using /proc/kallsyms for symbols
> >         0.000 Timer/2525383 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
> >                                           do_trace_write_msr ([kernel.kallsyms])
> >                                           do_trace_write_msr ([kernel.kallsyms])
> >                                           __switch_to_xtra ([kernel.kallsyms])
> >                                           __switch_to ([kernel.kallsyms])
> >                                           __schedule ([kernel.kallsyms])
> >                                           schedule ([kernel.kallsyms])
> >                                           futex_wait_queue_me ([kernel.kallsyms])
> >                                           futex_wait ([kernel.kallsyms])
> >                                           do_futex ([kernel.kallsyms])
> >                                           __x64_sys_futex ([kernel.kallsyms])
> >                                           do_syscall_64 ([kernel.kallsyms])
> >                                           entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
> >                                           __futex_abstimed_wait_common64 (/usr/lib64/libpthread-2.33.so)
> >         0.030 :0/0 msr:write_msr(msr: IA32_SPEC_CTRL, val: 2)
> >                                           do_trace_write_msr ([kernel.kallsyms])
> >                                           do_trace_write_msr ([kernel.kallsyms])
> >                                           __switch_to_xtra ([kernel.kallsyms])
> >                                           __switch_to ([kernel.kallsyms])
> >                                           __schedule ([kernel.kallsyms])
> >                                           schedule_idle ([kernel.kallsyms])
> >                                           do_idle ([kernel.kallsyms])
> >                                           cpu_startup_entry ([kernel.kallsyms])
> >                                           secondary_startup_64_no_verify ([kernel.kallsyms])
> >    #
> >
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 

Thanks!

Acked-by: Huang Rui <ray.huang@amd.com>

> 
> > ---
> >   tools/arch/x86/include/asm/msr-index.h | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> >
> > diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
> > index 01e2650b958591e0..3faf0f97edb1bcd3 100644
> > --- a/tools/arch/x86/include/asm/msr-index.h
> > +++ b/tools/arch/x86/include/asm/msr-index.h
> > @@ -486,6 +486,23 @@
> >   
> >   #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
> >   
> > +/* AMD Collaborative Processor Performance Control MSRs */
> > +#define MSR_AMD_CPPC_CAP1		0xc00102b0
> > +#define MSR_AMD_CPPC_ENABLE		0xc00102b1
> > +#define MSR_AMD_CPPC_CAP2		0xc00102b2
> > +#define MSR_AMD_CPPC_REQ		0xc00102b3
> > +#define MSR_AMD_CPPC_STATUS		0xc00102b4
> > +
> > +#define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
> > +#define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> > +#define AMD_CPPC_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
> > +#define AMD_CPPC_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
> > +
> > +#define AMD_CPPC_MAX_PERF(x)		(((x) & 0xff) << 0)
> > +#define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
> > +#define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
> > +#define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> > +
> >   /* Fam 17h MSRs */
> >   #define MSR_F17H_IRPERF			0xc00000e9
> >   
> 
> 
