Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50CA4640E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbhK3WHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:07:21 -0500
Received: from mail-db8eur05on2127.outbound.protection.outlook.com ([40.107.20.127]:64736
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229837AbhK3WHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:07:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8K3w8yEVGzaxhs6kwQkCrfGuLJXymJSoybtlQWDU8gP/3iSN+Til39HBZaV9+LjeN2QLhc+IjdG32mWJ2zFKeKN7vtkzbVXCzwA4Nv6QW2LM5g7E56h9WBq14uN3xkhNO7+FN676aiuXB08fr0h0UprO36rLWxSW3aQ7XvWdQui3h1YdRCbM+QTKGVeZBINIVAowc7YFPETQB1AxE9BUOlDaWVSLTCbGTICqbrcqINNoFzV9gX0kkYUSARrP3/g4FtVUSoVDUkjsZS84+Cbt6M+kPLxx4ajrfiZpG7ad9dZA2pnh5lwwNBTC1GWNvJauZCHMzXS7MYxbCBhMnsJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ko8xd4bcn98YcP0hgHXqLapQf7KgCRU5vbBHGeJp6R8=;
 b=H/JQCGWN3lsJHSxuzsKNcBbHM2Th8Vird6PGIFOiJJu9AwsH2OTSBhN3FCo14F5mh/IuUQDwygpd6MWdwHIZGqA7ymXfRuAWa9Jo3aqHv9BtEEXsozGRlQ29p45NPUYJ8wgJBmOhYGMvV4lknWaMQjVriUB1lYpU0xPr3VXWLZBwClTRA3SHKv+KWAKq+Hp6QdP66qlntnPJH2TUV2eILbbO6t/zbzYfWZkayoTjZcn871l2ltbJWgQ+i078HGSxvqO3eYmolfcwAk1BiLHqqmyEU9M7VI9v+m7aYNtMrJ5KOl4B93TE3pnT4K1X77pXVf1lPxGlREZJkLWgcNrSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector1-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ko8xd4bcn98YcP0hgHXqLapQf7KgCRU5vbBHGeJp6R8=;
 b=BdxD38unW4nMSgBpzXaDcKKmpOyAtPAl7VOCP0PAOGmt/DLwU1bxElcuYCFoFhuA9TTL9MLY9Bo3U3vSpUXUK31hLTpOafJpZkzl1+t7a6UejFnFWmHXikuAvBUoMNSeRw+7oLYVf3AxbgllkLzi4YWeLpfAJfoQj+Y2Xx6cUJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
Received: from DU2PR09MB5342.eurprd09.prod.outlook.com (2603:10a6:10:274::7)
 by DB9PR09MB5564.eurprd09.prod.outlook.com (2603:10a6:10:33e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 30 Nov
 2021 22:03:52 +0000
Received: from DU2PR09MB5342.eurprd09.prod.outlook.com
 ([fe80::59e6:bb5d:7781:7d1e]) by DU2PR09MB5342.eurprd09.prod.outlook.com
 ([fe80::59e6:bb5d:7781:7d1e%9]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 22:03:52 +0000
Date:   Tue, 30 Nov 2021 17:03:46 -0500
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Jun Miao <jun.miao@windriver.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10-rt+] drm/i915/gt: transform irq_disable into
 local_lock.
Message-ID: <20211130220346.GA2166@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20211007165928.GA43890@zipoli.concurrent-rt.com>
 <20211007171929.hegwwqelf46skjyw@linutronix.de>
 <20211009164908.GA21269@zipoli.concurrent-rt.com>
 <20211116152534.122f8357@gandalf.local.home>
 <20211116210249.t3f6gw56iaow57mq@linutronix.de>
 <20211116163924.5d5a2ffd@gandalf.local.home>
 <20211122195048.GB6166@zipoli.concurrent-rt.com>
 <20211130151045.idygiysuatdhwjd4@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130151045.idygiysuatdhwjd4@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN9PR03CA0868.namprd03.prod.outlook.com
 (2603:10b6:408:13d::33) To DU2PR09MB5342.eurprd09.prod.outlook.com
 (2603:10a6:10:274::7)
MIME-Version: 1.0
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN9PR03CA0868.namprd03.prod.outlook.com (2603:10b6:408:13d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 22:03:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4880f49-a5ed-4f26-c56f-08d9b44d4b4f
X-MS-TrafficTypeDiagnostic: DB9PR09MB5564:
X-Microsoft-Antispam-PRVS: <DB9PR09MB556461399B51A2DA5A50799AA0679@DB9PR09MB5564.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOf+UI7xBfYxcajNhEl8QgPpPi+LhVSg4jvWxaNfMGAcJLhAkUaph8NLk7Oh71zmZv90vL0x8VVHqHTZUOZ5ryMOjn4rAMItL/wtaZ1SNFB2NyPYjOGyGcGFgdGtobSOzurBhuSv6M8RP9qjAmx4kzbJ/OoepxjsUl/6wZglIqI6pifSP+2U5PbmUQ78yxhyx2rrBLIpZAYX1ooVkmfnwgexTwbDKKj9JqiPoa9PrTmNEkrPO9nQMEkVZj79cMaF0FgqFN4gi8pkJJaRrrxBrxuy2NOPgISMn43oFgwCpDt7DWRjIGWrGRvh1ab1pyO79+U2etk2oURx7/ACh+F/9wr2KMoL7NHrwhbnW+udS8CHBt1Tvi1Mon1lNMpNv+eTPu4wKuG5wc9MfSbcz1RocgtP+XCJ3R5Q7nhFlw8CW2+PEKxQG2Y/K9YNKTUIuGoOX26nabtAmUxJevl/otTterNTR3ZZYUZvUC0fQSFx08vzikm0s9R957WgM/DTq044yYnRSkj5spK9ql/YEMjFNVak8YMJoaCkV6kqqCOhpt9Ps9izdXn499UEowbG1v3wRHFRY5UC4X7nE2stUhz5ZZpuvtJ3IYbvAAOm9sbNyqFP+gD93bLDRWL5CbviCp6x9TuzluakEGhIDN+bYcM5bowGjwT6MROzVrrdQecb95IfgYv9bHSVx6RGuWpBQIyPdO3Y/Is1C/Sx2OZhkFRsDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR09MB5342.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(66476007)(6666004)(4001150100001)(54906003)(7696005)(83380400001)(38100700002)(4326008)(186003)(44832011)(66556008)(30864003)(2906002)(508600001)(1076003)(316002)(55016003)(8936002)(8676002)(66946007)(26005)(3450700001)(86362001)(6916009)(956004)(33656002)(38350700002)(45080400002)(5660300002)(53546011)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+65LOqV8h2ETI0lh6B4KUAZDVr5q1fSwGkx7TcDPqDKhsM++7K6/xK6NrKzh?=
 =?us-ascii?Q?jJSLqoDzkysPUk4MRReUroD5ukG9Kc5loRRECVBADVmhYAxx1Ckv2VpsDODi?=
 =?us-ascii?Q?RHwJFsMuJKlzk97AW0VETusxo3c+HFESgUbVdLeeA0XSknWRF1w6In9d2QUB?=
 =?us-ascii?Q?+M5+o5OKGvKI4K0GAHGHaT23Nn+AnuelzstJbRGi8G2GWt5z5zETvDgb/Vkh?=
 =?us-ascii?Q?s1L/Seo9iTcsEpN+8It2Q0d0U/s+Cjnl/HHz+kNcUArDIEQObh+PWQd0cdY9?=
 =?us-ascii?Q?0OBHnGmvzkcdi7NBNHHmTgwGRaexcN4FEbP0tODyMTgrFee2N47aKjxADqqW?=
 =?us-ascii?Q?Tp7RHvyCr36cBSJH1h4XpswvHsHZWAtDALw4gPp+MMFjjZ3pr/2lFWKcg1XF?=
 =?us-ascii?Q?c7TiZ7w5dSsu/brfA4SQBbIWzM6BYcJI2hVA2N7ahdz2llH26dK5QoE2c71R?=
 =?us-ascii?Q?1Kmr4nm6lKYhRoNBw/MkmExg1YBRe44ipB0XGAKbU6E6UDNjlvznH/RkhxEb?=
 =?us-ascii?Q?0z+k6InGxnbfeV5mdQJPgmTTz2BQbB9zPJ/Kt8uyRJZmCG09g7xgI5vVPuhz?=
 =?us-ascii?Q?T+TBg/4ak1lRx4ymHW6qkmJJQHVmfget+Wi+zk+0/u+6vb+fPF7Mk5RIK+zp?=
 =?us-ascii?Q?ku0QTNH5IsVsKarg327ZP9KWKXeBKn7p7n6uvmtOmUtQBNVgd+wMlvM9lgrn?=
 =?us-ascii?Q?qcR4Y4ttpnJZR3OJYehAkrDQ6a7wT+fASOAkWN7jsDLBAqgGnb1kRl+cpYai?=
 =?us-ascii?Q?jkO+M0HhasSz6iVt+lJ9f6vzDgeiR/BGKxpGyqSuH/+/oPLbUGu8+6ms2RQv?=
 =?us-ascii?Q?3X1k2uYHPs8SvhyrWWij/ucJQEJXDJ4kfs17rjLCMav2ymWFgCa3faiVucPh?=
 =?us-ascii?Q?/CQK4RHUoTtotF3VivDV6G6PoFarvHZc8UkQXryNgHvvPeUH1Fh1epTfkx9V?=
 =?us-ascii?Q?kkZveA+5kVL8j3Jd1UKKZ3n59vggTTMRlvc4B5FwaHfaE/e97ScQS9Ib6yjs?=
 =?us-ascii?Q?GxkL0XCWa+XoP1q6ozgl/b+7tg3SFpwEszhGx6tzFEkdWgt5qTC3xgBmhjbO?=
 =?us-ascii?Q?B5k3XjAEJlexWYwRRxrKyGBoB3iOn0f7tG3p86P93oZO2jA3sxlfJ0WjNmnW?=
 =?us-ascii?Q?Q3OqctTo+z8n6sJZp4KjXRq6lKbcLkozehTKlSMz5NfD7A0+Vn5zTYYLTZt3?=
 =?us-ascii?Q?ioMl2YpjsroJSzcrDCFkX9Tb9WCx8iWPu3cyyRu1kkTrS2B8fdNADZDUod3N?=
 =?us-ascii?Q?dA+bfi3bFMpUQ7ussuuyppXwuubhE67C90AOA4zchLbLqUdf9yGAgc1pHg6V?=
 =?us-ascii?Q?hq6VdjpF/8+kv2MQcZW03IZtDAWwSMjnJ1PpQY4JY6S2nVD8SJiKFnHL7z/8?=
 =?us-ascii?Q?exmJ0dtxS5h80QeWtuB1BojemsZl8XVmUvu5d5VupgHuzilutDuQYBH3mKGO?=
 =?us-ascii?Q?NDe5bQlGs2oiEr4vb+DVKq5tZeik/PmBFy/xqrAuTf3OoR4NIuNsYk6gvijf?=
 =?us-ascii?Q?oUh6KocCArZ3rZKAxhamucMwXVTdJR844giS0kjoSua76g0mm2drH6RKi9gh?=
 =?us-ascii?Q?aujP8kWZK/5O7st91sPGO8sTOeQXDEYnVtMDvDWSnaGX6dPftIh3DCzqUfXK?=
 =?us-ascii?Q?FJRHDKGZ9+GdWuxwS+wtNfuROqb39aobTd26x4nUt3TE4r9sJscDgAVjf6iO?=
 =?us-ascii?Q?fGAdZw=3D=3D?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4880f49-a5ed-4f26-c56f-08d9b44d4b4f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR09MB5342.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 22:03:52.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDQCa/l2qf6LUKWWMiqA3U0tKdRhBZmuzsaPbOqjkYcBxHqCqNYQbmW4HQ5pZWI+cg1tYcKPhSaqOxgujDCKnW2A6IpfPOI1YRKNuEZ4v5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB5564
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 04:10:45PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-11-22 14:50:48 [-0500], Joe Korty wrote:

>> I will keep poking at it from time to time, see if I can
>> get the issue to come back.
> 
> The issue shouldn't come back. I'm curious however if the bunch of i915
> patchesm that I have in the latest RT, cause any problems with or with
> PREEMPT_RT enabled. That is latency wise or usage wise (like lagging/
> juddering playback wobbling GUI or anything like that).

Hi Sebastian,
5.16-rc3-rt6 w/ CONFIG_PREEMPT_RT=y boots on my C7Z170-SQ
motherboard.  Graphics look good, mouse moves smoothly,
windows pop up and shut down cleanly, can drag windows
and the movement is smooth.

The i915 oops that triggered my original email is also
gone.

But there is a new oops, in networking, that was not
present in 5.4-rt.

In case you are interested, I've attached the complete
dmesg output.  I have not looked at it yet, thought it
better to get this email out pronto.

Joe



[    0.000000] Linux version 5.16.0-rc3-rt6 (root@skylar) (gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1), GNU ld version 2.30-93.el8) #1 SMP PREEMPT_RT Tue Nov 30 15:55:09 EST 2021
[    0.000000] Command line: BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.16.0-rc3-rt6 root=UUID=47a613fe-3ea1-11ec-a4b0-3cecef3fbd90 ro rhgb quiet console=ttyS0,115200 net.ifnames=0 biosdevname=0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 2032
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009c7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000068c5efff] usable
[    0.000000] BIOS-e820: [mem 0x0000000068c5f000-0x0000000068c5ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000068c60000-0x0000000068c60fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000068c61000-0x000000008bfe4fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008bfe5000-0x000000008c369fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008c36a000-0x000000008c4d3fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008c4d4000-0x000000008cb79fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000008cb7a000-0x000000008d2fefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008d2ff000-0x000000008d2fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000008d300000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000086effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Supermicro C7Z170-SQ/C7Z170-SQ, BIOS 2.0a 07/17/2017
[    0.000000] tsc: Detected 4000.000 MHz processor
[    0.000000] tsc: Detected 3999.984 MHz TSC
[    0.000285] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000286] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000290] last_pfn = 0x86f000 max_arch_pfn = 0x400000000
[    0.000358] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000693] last_pfn = 0x8d300 max_arch_pfn = 0x400000000
[    0.005069] found SMP MP-table at [mem 0x000fccd0-0x000fccdf]
[    0.005076] Using GB pages for direct mapping
[    0.006099] RAMDISK: [mem 0x24cd1000-0x2e660fff]
[    0.006100] ACPI: Early table checksum verification disabled
[    0.006102] ACPI: RSDP 0x00000000000F05B0 000024 (v02 SUPERM)
[    0.006104] ACPI: XSDT 0x000000008C7D40B0 0000DC (v01 SUPERM SUPERM   01072009 AMI  00010013)
[    0.006107] ACPI: FACP 0x000000008C7FA190 000114 (v06                 01072009 AMI  00010013)
[    0.006110] ACPI: DSDT 0x000000008C7D4220 025F6C (v02 SUPERM SMCI--MB 01072009 INTL 20160422)
[    0.006111] ACPI: FACS 0x000000008CB79C40 000040
[    0.006113] ACPI: APIC 0x000000008C7FA2A8 000084 (v03                 01072009 AMI  00010013)
[    0.006114] ACPI: FPDT 0x000000008C7FA330 000044 (v01                 01072009 AMI  00010013)
[    0.006115] ACPI: MCFG 0x000000008C7FA378 00003C (v01 SUPERM SMCI--MB 01072009 MSFT 00000097)
[    0.006117] ACPI: FIDT 0x000000008C7FA3B8 00009C (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
[    0.006118] ACPI: SSDT 0x000000008C7FA458 000877 (v02 Intel  PerfTune 00001000 INTL 20160422)
[    0.006119] ACPI: SSDT 0x000000008C7FACD0 003159 (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
[    0.006121] ACPI: SSDT 0x000000008C7FDE30 00255F (v02 PegSsd PegSsdt  00001000 INTL 20160422)
[    0.006122] ACPI: HPET 0x000000008C800390 000038 (v01 INTEL  SKL      00000001 MSFT 0000005F)
[    0.006124] ACPI: SSDT 0x000000008C8003C8 000DE5 (v02 INTEL  Ther_Rvp 00001000 INTL 20160422)
[    0.006125] ACPI: SSDT 0x000000008C8011B0 000A2E (v02 INTEL  xh_rvp08 00000000 INTL 20160422)
[    0.006127] ACPI: UEFI 0x000000008C801BE0 000042 (v01 INTEL  EDK2     00000002      01000013)
[    0.006128] ACPI: SSDT 0x000000008C801C28 000EDE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
[    0.006129] ACPI: SSDT 0x000000008C802B08 0003E3 (v02 PmRef  Cpu0Tst  00003000 INTL 20160422)
[    0.006131] ACPI: SSDT 0x000000008C802EF0 000471 (v02 PmRef  ApTst    00003000 INTL 20160422)
[    0.006132] ACPI: LPIT 0x000000008C803368 000094 (v01 INTEL  SKL      00000000 MSFT 0000005F)
[    0.006133] ACPI: WSMT 0x000000008C803400 000028 (v01 INTEL  SKL      00000000 MSFT 0000005F)
[    0.006135] ACPI: SSDT 0x000000008C803428 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
[    0.006136] ACPI: SSDT 0x000000008C8036C8 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
[    0.006137] ACPI: DBGP 0x000000008C8066D0 000034 (v01 INTEL           00000002 MSFT 0000005F)
[    0.006139] ACPI: DBG2 0x000000008C806708 000054 (v00 INTEL           00000002 MSFT 0000005F)
[    0.006140] ACPI: DMAR 0x000000008C806760 0000B8 (v01 INTEL  SKL      00000001 INTL 00000001)
[    0.006142] ACPI: ASF! 0x000000008C806818 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    0.006143] ACPI: Reserving FACP table memory at [mem 0x8c7fa190-0x8c7fa2a3]
[    0.006144] ACPI: Reserving DSDT table memory at [mem 0x8c7d4220-0x8c7fa18b]
[    0.006144] ACPI: Reserving FACS table memory at [mem 0x8cb79c40-0x8cb79c7f]
[    0.006145] ACPI: Reserving APIC table memory at [mem 0x8c7fa2a8-0x8c7fa32b]
[    0.006145] ACPI: Reserving FPDT table memory at [mem 0x8c7fa330-0x8c7fa373]
[    0.006145] ACPI: Reserving MCFG table memory at [mem 0x8c7fa378-0x8c7fa3b3]
[    0.006146] ACPI: Reserving FIDT table memory at [mem 0x8c7fa3b8-0x8c7fa453]
[    0.006146] ACPI: Reserving SSDT table memory at [mem 0x8c7fa458-0x8c7facce]
[    0.006147] ACPI: Reserving SSDT table memory at [mem 0x8c7facd0-0x8c7fde28]
[    0.006147] ACPI: Reserving SSDT table memory at [mem 0x8c7fde30-0x8c80038e]
[    0.006148] ACPI: Reserving HPET table memory at [mem 0x8c800390-0x8c8003c7]
[    0.006148] ACPI: Reserving SSDT table memory at [mem 0x8c8003c8-0x8c8011ac]
[    0.006149] ACPI: Reserving SSDT table memory at [mem 0x8c8011b0-0x8c801bdd]
[    0.006149] ACPI: Reserving UEFI table memory at [mem 0x8c801be0-0x8c801c21]
[    0.006149] ACPI: Reserving SSDT table memory at [mem 0x8c801c28-0x8c802b05]
[    0.006150] ACPI: Reserving SSDT table memory at [mem 0x8c802b08-0x8c802eea]
[    0.006150] ACPI: Reserving SSDT table memory at [mem 0x8c802ef0-0x8c803360]
[    0.006151] ACPI: Reserving LPIT table memory at [mem 0x8c803368-0x8c8033fb]
[    0.006151] ACPI: Reserving WSMT table memory at [mem 0x8c803400-0x8c803427]
[    0.006152] ACPI: Reserving SSDT table memory at [mem 0x8c803428-0x8c8036c6]
[    0.006152] ACPI: Reserving SSDT table memory at [mem 0x8c8036c8-0x8c8066c9]
[    0.006153] ACPI: Reserving DBGP table memory at [mem 0x8c8066d0-0x8c806703]
[    0.006153] ACPI: Reserving DBG2 table memory at [mem 0x8c806708-0x8c80675b]
[    0.006154] ACPI: Reserving DMAR table memory at [mem 0x8c806760-0x8c806817]
[    0.006154] ACPI: Reserving ASF! table memory at [mem 0x8c806818-0x8c8068b7]
[    0.006283] No NUMA configuration found
[    0.006283] Faking a node at [mem 0x0000000000000000-0x000000086effffff]
[    0.006289] NODE_DATA(0) allocated [mem 0x86efd5000-0x86effffff]
[    0.006471] Zone ranges:
[    0.006471]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.006472]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.006473]   Normal   [mem 0x0000000100000000-0x000000086effffff]
[    0.006474]   Device   empty
[    0.006474] Movable zone start for each node
[    0.006476] Early memory node ranges
[    0.006476]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.006477]   node   0: [mem 0x0000000000100000-0x0000000068c5efff]
[    0.006478]   node   0: [mem 0x0000000068c61000-0x000000008bfe4fff]
[    0.006478]   node   0: [mem 0x000000008c36a000-0x000000008c4d3fff]
[    0.006479]   node   0: [mem 0x000000008d2ff000-0x000000008d2fffff]
[    0.006479]   node   0: [mem 0x0000000100000000-0x000000086effffff]
[    0.006481] Initmem setup node 0 [mem 0x0000000000001000-0x000000086effffff]
[    0.006484] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.006500] On node 0, zone DMA: 100 pages in unavailable ranges
[    0.009331] On node 0, zone DMA32: 2 pages in unavailable ranges
[    0.009338] On node 0, zone DMA32: 901 pages in unavailable ranges
[    0.009358] On node 0, zone DMA32: 3627 pages in unavailable ranges
[    0.048540] On node 0, zone Normal: 11520 pages in unavailable ranges
[    0.048563] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.048570] Reserving Intel graphics memory at [mem 0x8e000000-0x8fffffff]
[    0.048795] ACPI: PM-Timer IO Port: 0x1808
[    0.048798] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.048799] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.048800] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.048800] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.048827] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.048829] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.048830] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.048832] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.048833] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.048834] TSC deadline timer available
[    0.048835] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.048877] [mem 0x90000000-0xdfffffff] available for PCI devices
[    0.048877] Booting paravirtualized kernel on bare hardware
[    0.048880] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.055473] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
[    0.056310] percpu: Embedded 510 pages/cpu s2052096 r8192 d28672 u2097152
[    0.056315] pcpu-alloc: s2052096 r8192 d28672 u2097152 alloc=1*2097152
[    0.056317] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.056343] Fallback order for Node 0: 0 
[    0.056346] Built 1 zonelists, mobility grouping on.  Total pages: 8237448
[    0.056346] Policy zone: Normal
[    0.056354] Kernel command line: BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.16.0-rc3-rt6 root=UUID=47a613fe-3ea1-11ec-a4b0-3cecef3fbd90 ro rhgb quiet console=ttyS0,115200 net.ifnames=0 biosdevname=0
[    0.056479] Unknown kernel command line parameters "rhgb BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.16.0-rc3-rt6 biosdevname=0", will be passed to user space.
[    0.057476] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.057992] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.058022] mem auto-init: stack:off, heap alloc:off, heap free:off
[    1.136656] Memory: 32579044K/33473444K available (26645K kernel code, 6923K rwdata, 8924K rodata, 3764K init, 21780K bss, 894140K reserved, 0K cma-reserved)
[    1.136663] random: random: get_random_u64 called from __kmem_cache_create+0x25/0x460 with crng_init=0
[    1.136955] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    1.137681] Kernel/User page tables isolation: enabled
[    1.138034] Running RCU self tests
[    1.138049] rcu: Preemptible hierarchical RCU implementation.
[    1.138049] rcu: 	RCU event tracing is enabled.
[    1.138049] rcu: 	RCU lockdep checking is enabled.
[    1.138049] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
[    1.138050] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    1.138051] rcu: 	RCU_SOFTIRQ processing moved to rcuc kthreads.
[    1.138051] 	No expedited grace period (rcu_normal_after_boot).
[    1.138051] 	Trampoline variant of Tasks RCU enabled.
[    1.138051] 	Tracing variant of Tasks RCU enabled.
[    1.138052] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    1.138052] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    1.144931] NR_IRQS: 33024, nr_irqs: 1024, preallocated irqs: 16
[    1.145353] random: crng done (trusting CPU's manufacturer)
[    1.147038] Console: colour VGA+ 80x25
[    1.147071] printk: console [ttyS0] enabled
[    1.147072] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    1.147072] ... MAX_LOCKDEP_SUBCLASSES:  8
[    1.147073] ... MAX_LOCK_DEPTH:          48
[    1.147073] ... MAX_LOCKDEP_KEYS:        8192
[    1.147073] ... CLASSHASH_SIZE:          4096
[    1.147073] ... MAX_LOCKDEP_ENTRIES:     32768
[    1.147074] ... MAX_LOCKDEP_CHAINS:      65536
[    1.147074] ... CHAINHASH_SIZE:          32768
[    1.147074]  memory used by lock dependency info: 6877 kB
[    1.147075]  memory used for stack traces: 4224 kB
[    1.147075]  per task-struct memory footprint: 2688 bytes
[    1.147118] ACPI: Core revision 20210930
[    1.147790] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    1.147895] APIC: Switch to symmetric I/O mode setup
[    1.147896] DMAR: Host address width 39
[    1.147897] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    1.147921] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 7e3ff0505e
[    1.147923] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    1.147934] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    1.147936] DMAR: RMRR base: 0x0000008c2da000 end: 0x0000008c2f9fff
[    1.147938] DMAR: RMRR base: 0x0000008d800000 end: 0x0000008fffffff
[    1.147941] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    1.147942] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    1.147942] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    1.149518] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    1.149519] x2apic enabled
[    1.149540] Switched APIC routing to cluster x2apic.
[    1.153803] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.157860] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x73509d9fa88, max_idle_ns: 881590914879 ns
[    1.157872] Calibrating delay loop (skipped), value calculated using timer frequency.. 7999.96 BogoMIPS (lpj=3999984)
[    1.157874] pid_max: default: 32768 minimum: 301
[    1.157987] LSM: Security Framework initializing
[    1.158012] Yama: becoming mindful.
[    1.158038] SELinux:  Initializing.
[    1.158202] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    1.158246] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    1.159530] CPU0: Thermal monitoring enabled (TM1)
[    1.159571] process: using mwait in idle threads
[    1.159572] numa_add_cpu cpu 0 node 0: mask now 0
[    1.159574] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    1.159575] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    1.159575] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    1.159576] Spectre V2 : Mitigation: Full generic retpoline
[    1.159577] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    1.159577] Speculative Store Bypass: Vulnerable
[    1.159578] TAA: Vulnerable: Clear CPU buffers attempted, no microcode
[    1.159578] SRBDS: Vulnerable: No microcode
[    1.159579] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    1.161181] Freeing SMP alternatives memory: 68K
[    1.162051] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1024
[    1.162065] smpboot: CPU0: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz (family: 0x6, model: 0x5e, stepping: 0x3)
[    1.162872] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    1.162872] ... version:                4
[    1.162872] ... bit width:              48
[    1.162872] ... generic registers:      8
[    1.162872] ... value mask:             0000ffffffffffff
[    1.162872] ... max period:             00007fffffffffff
[    1.162872] ... fixed-purpose events:   3
[    1.162872] ... event mask:             00000007000000ff
[    1.163284] rcu: Hierarchical SRCU implementation.
[    1.164674] Running RCU-tasks wait API self tests
[    1.271352] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    1.271669] smp: Bringing up secondary CPUs ...
[    1.272612] x86: Booting SMP configuration:
[    1.272613] .... node  #0, CPUs:      #1
[    0.006592] numa_add_cpu cpu 1 node 0: mask now 0-1
[    1.274015]  #2
[    0.006592] numa_add_cpu cpu 2 node 0: mask now 0-2
[    1.275233]  #3
[    0.006592] numa_add_cpu cpu 3 node 0: mask now 0-3
[    1.275720] smp: Brought up 1 node, 4 CPUs
[    1.275720] smpboot: Max logical packages: 1
[    1.275720] smpboot: Total of 4 processors activated (31999.87 BogoMIPS)
[    1.278324] devtmpfs: initialized
[    1.279252] x86/mm: Memory block size: 128MB
[    1.282889] Callback from call_rcu_tasks_trace() invoked.
[    1.317422] ACPI: PM: Registering ACPI NVS region [mem 0x68c5f000-0x68c5ffff] (4096 bytes)
[    1.317422] ACPI: PM: Registering ACPI NVS region [mem 0x8c4d4000-0x8cb79fff] (6971392 bytes)
[    1.324563] DMA-API: preallocated 65536 debug entries
[    1.324564] DMA-API: debugging enabled by kernel config
[    1.324565] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    1.324596] futex hash table entries: 1024 (order: 5, 196608 bytes, linear)
[    1.325070] pinctrl core: initialized pinctrl subsystem
[    1.327142] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    1.328908] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    1.328928] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    1.328947] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    1.329026] audit: initializing netlink subsys (disabled)
[    1.329137] audit: type=2000 audit(1638290647.178:1): state=initialized audit_enabled=0 res=1
[    1.330439] thermal_sys: Registered thermal governor 'fair_share'
[    1.330442] thermal_sys: Registered thermal governor 'bang_bang'
[    1.330444] thermal_sys: Registered thermal governor 'step_wise'
[    1.330446] thermal_sys: Registered thermal governor 'user_space'
[    1.330530] cpuidle: using governor menu
[    1.330905] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.331473] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    1.331478] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    1.331559] PCI: Using configuration type 1 for base access
[    1.337792] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    1.397514] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    1.398053] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    1.398053] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    1.398453] cryptd: max_cpu_qlen set to 1000
[    1.399212] raid6: skip pq benchmark and using algorithm avx2x4
[    1.399212] raid6: using avx2x2 recovery algorithm
[    1.399636] ACPI: Added _OSI(Module Device)
[    1.399637] ACPI: Added _OSI(Processor Device)
[    1.399638] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.399639] ACPI: Added _OSI(Processor Aggregator Device)
[    1.399643] ACPI: Added _OSI(Linux-Dell-Video)
[    1.399647] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    1.399651] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    1.478918] Callback from call_rcu_tasks() invoked.
[    1.608631] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    1.631044] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    1.646125] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    1.659447] ACPI: Dynamic OEM Table Load:
[    1.659489] ACPI: SSDT 0xFFFF95EA41073800 000115 (v02 PmRef  Cpu0Hwp  00003000 INTL 20160422)
[    1.665654] ACPI: Dynamic OEM Table Load:
[    1.665696] ACPI: SSDT 0xFFFF95EA41073600 0001A4 (v02 PmRef  HwpLvt   00003000 INTL 20160422)
[    1.674447] ACPI: Dynamic OEM Table Load:
[    1.674489] ACPI: SSDT 0xFFFF95EA41072600 000197 (v02 PmRef  ApHwp    00003000 INTL 20160422)
[    1.703729] ACPI: Interpreter enabled
[    1.703820] ACPI: PM: (supports S0 S3 S5)
[    1.703833] ACPI: Using IOAPIC for interrupt routing
[    1.704018] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.713044] ACPI: Enabled 6 GPEs in block 00 to 7F
[    1.731932] ACPI: PM: Power Resource [PG00]
[    1.735951] ACPI: PM: Power Resource [PG01]
[    1.739909] ACPI: PM: Power Resource [PG02]
[    1.761307] ACPI: PM: Power Resource [WRST]
[    1.764212] ACPI: PM: Power Resource [WRST]
[    1.767142] ACPI: PM: Power Resource [WRST]
[    1.770119] ACPI: PM: Power Resource [WRST]
[    1.773112] ACPI: PM: Power Resource [WRST]
[    1.776026] ACPI: PM: Power Resource [WRST]
[    1.778947] ACPI: PM: Power Resource [WRST]
[    1.781839] ACPI: PM: Power Resource [WRST]
[    1.784729] ACPI: PM: Power Resource [WRST]
[    1.787663] ACPI: PM: Power Resource [WRST]
[    1.790650] ACPI: PM: Power Resource [WRST]
[    1.793639] ACPI: PM: Power Resource [WRST]
[    1.796596] ACPI: PM: Power Resource [WRST]
[    1.799488] ACPI: PM: Power Resource [WRST]
[    1.802387] ACPI: PM: Power Resource [WRST]
[    1.805297] ACPI: PM: Power Resource [WRST]
[    1.808192] ACPI: PM: Power Resource [WRST]
[    1.820903] ACPI: PM: Power Resource [WRST]
[    1.823812] ACPI: PM: Power Resource [WRST]
[    1.826710] ACPI: PM: Power Resource [WRST]
[    1.925994] ACPI: PM: Power Resource [FN00]
[    1.926958] ACPI: PM: Power Resource [FN01]
[    1.927923] ACPI: PM: Power Resource [FN02]
[    1.928880] ACPI: PM: Power Resource [FN03]
[    1.929850] ACPI: PM: Power Resource [FN04]
[    1.940883] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    1.940895] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    1.950993] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    1.958666] PCI host bridge to bus 0000:00
[    1.958669] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.958672] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.958674] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.958677] pci_bus 0000:00: root bus resource [mem 0x90000000-0xdfffffff window]
[    1.958679] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    1.958683] pci_bus 0000:00: root bus resource [bus 00-fe]
[    1.959129] pci 0000:00:00.0: [8086:191f] type 00 class 0x060000
[    1.959569] pci 0000:00:02.0: [8086:1912] type 00 class 0x030000
[    1.959579] pci 0000:00:02.0: reg 0x10: [mem 0xde000000-0xdeffffff 64bit]
[    1.959586] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit pref]
[    1.959590] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    1.961758] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    1.961769] pci 0000:00:08.0: reg 0x10: [mem 0xdf34f000-0xdf34ffff 64bit]
[    1.962214] pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
[    1.962233] pci 0000:00:14.0: reg 0x10: [mem 0xdf330000-0xdf33ffff 64bit]
[    1.962323] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    1.967228] pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
[    1.967246] pci 0000:00:14.2: reg 0x10: [mem 0xdf34e000-0xdf34efff 64bit]
[    1.967684] pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
[    1.967706] pci 0000:00:16.0: reg 0x10: [mem 0xdf34d000-0xdf34dfff 64bit]
[    1.967818] pci 0000:00:16.0: PME# supported from D3hot
[    1.970556] pci 0000:00:17.0: [8086:a102] type 00 class 0x010601
[    1.970569] pci 0000:00:17.0: reg 0x10: [mem 0xdf348000-0xdf349fff]
[    1.970577] pci 0000:00:17.0: reg 0x14: [mem 0xdf34c000-0xdf34c0ff]
[    1.970584] pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
[    1.970591] pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
[    1.970598] pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
[    1.970605] pci 0000:00:17.0: reg 0x24: [mem 0xdf34b000-0xdf34b7ff]
[    1.970669] pci 0000:00:17.0: PME# supported from D3hot
[    1.973044] pci 0000:00:1b.0: [8086:a169] type 01 class 0x060400
[    1.973149] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.978895] pci 0000:00:1b.3: [8086:a16a] type 01 class 0x060400
[    1.979000] pci 0000:00:1b.3: PME# supported from D0 D3hot D3cold
[    1.984687] pci 0000:00:1c.0: [8086:a112] type 01 class 0x060400
[    1.984792] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.990483] pci 0000:00:1c.4: [8086:a114] type 01 class 0x060400
[    1.990607] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.996293] pci 0000:00:1d.0: [8086:a118] type 01 class 0x060400
[    1.996406] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    2.002102] pci 0000:00:1f.0: [8086:a145] type 00 class 0x060100
[    2.004331] pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
[    2.004346] pci 0000:00:1f.2: reg 0x10: [mem 0xdf344000-0xdf347fff]
[    2.006525] pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
[    2.006549] pci 0000:00:1f.3: reg 0x10: [mem 0xdf340000-0xdf343fff 64bit]
[    2.006583] pci 0000:00:1f.3: reg 0x20: [mem 0xdf320000-0xdf32ffff 64bit]
[    2.006657] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    2.010581] pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
[    2.010637] pci 0000:00:1f.4: reg 0x10: [mem 0xdf34a000-0xdf34a0ff 64bit]
[    2.010706] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    2.012944] pci 0000:00:1f.6: [8086:15b8] type 00 class 0x020000
[    2.012960] pci 0000:00:1f.6: reg 0x10: [mem 0xdf300000-0xdf31ffff]
[    2.013071] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    2.015579] pci 0000:01:00.0: [1b21:1242] type 00 class 0x0c0330
[    2.015604] pci 0000:01:00.0: reg 0x10: [mem 0xdf200000-0xdf207fff 64bit]
[    2.015659] pci 0000:01:00.0: enabling Extended Tags
[    2.015781] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    2.015848] pci 0000:01:00.0: 7.876 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x1 link at 0000:00:1b.0 (capable of 15.752 Gb/s with 8.0 GT/s PCIe x2 link)
[    2.019242] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    2.019247] pci 0000:00:1b.0:   bridge window [mem 0xdf200000-0xdf2fffff]
[    2.019582] pci 0000:00:1b.3: PCI bridge to [bus 02]
[    2.019968] pci 0000:03:00.0: [10b5:8111] type 01 class 0x060400
[    2.020003] pci 0000:03:00.0: reg 0x10: [mem 0xd0000000-0xd000ffff 64bit pref]
[    2.020149] pci 0000:03:00.0: supports D1
[    2.020150] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
[    2.023523] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    2.023548] pci 0000:00:1c.0: PCI bridge to [bus 03-04]
[    2.023552] pci 0000:00:1c.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    2.023556] pci 0000:00:1c.0:   bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
[    2.023611] pci_bus 0000:04: extended config space not accessible
[    2.023807] pci 0000:04:04.0: [1542:9271] type 00 class 0x088000
[    2.023834] pci 0000:04:04.0: reg 0x10: [mem 0xdf108000-0xdf1081ff]
[    2.023864] pci 0000:04:04.0: reg 0x18: [mem 0xdf100000-0xdf107fff]
[    2.024445] pci 0000:03:00.0: PCI bridge to [bus 04]
[    2.024454] pci 0000:03:00.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    2.024819] pci 0000:05:00.0: [10b5:8112] type 01 class 0x060400
[    2.025017] pci 0000:05:00.0: supports D1
[    2.025017] pci 0000:05:00.0: PME# supported from D0 D1 D3hot
[    2.028351] pci 0000:05:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    2.028376] pci 0000:00:1c.4: PCI bridge to [bus 05-06]
[    2.028379] pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
[    2.028382] pci 0000:00:1c.4:   bridge window [mem 0xdf000000-0xdf0fffff]
[    2.028444] pci_bus 0000:06: extended config space not accessible
[    2.028642] pci 0000:06:00.0: [12e2:4013] type 00 class 0x118000
[    2.028689] pci 0000:06:00.0: reg 0x14: [io  0xe000-0xe07f]
[    2.028707] pci 0000:06:00.0: reg 0x18: [mem 0xdf001000-0xdf0017ff]
[    2.028724] pci 0000:06:00.0: reg 0x1c: [mem 0xdf000000-0xdf0007ff]
[    2.029242] pci 0000:05:00.0: PCI bridge to [bus 06]
[    2.029248] pci 0000:05:00.0:   bridge window [io  0xe000-0xefff]
[    2.029253] pci 0000:05:00.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[    2.029587] pci 0000:00:1d.0: PCI bridge to [bus 07]
[    2.044013] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    2.044580] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    2.045155] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    2.045757] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    2.046319] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
[    2.046877] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
[    2.047437] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    2.047995] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    2.105739] iommu: Default domain type: Translated 
[    2.105739] iommu: DMA domain TLB invalidation policy: lazy mode 
[    2.106214] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    2.106214] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    2.106214] pci 0000:00:02.0: vgaarb: bridge control possible
[    2.106214] vgaarb: loaded
[    2.107300] SCSI subsystem initialized
[    2.107392] libata version 3.00 loaded.
[    2.107392] ACPI: bus type USB registered
[    2.107960] usbcore: registered new interface driver usbfs
[    2.108059] usbcore: registered new interface driver hub
[    2.108144] usbcore: registered new device driver usb
[    2.108487] pps_core: LinuxPPS API ver. 1 registered
[    2.108487] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.108508] PTP clock support registered
[    2.108671] EDAC MC: Ver: 3.0.0
[    2.111072] NetLabel: Initializing
[    2.111072] NetLabel:  domain hash size = 128
[    2.111073] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    2.111170] NetLabel:  unlabeled traffic allowed by default
[    2.111184] PCI: Using ACPI for IRQ routing
[    2.138743] PCI: pci_cache_line_size set to 64 bytes
[    2.138870] e820: reserve RAM buffer [mem 0x0009c800-0x0009ffff]
[    2.138889] e820: reserve RAM buffer [mem 0x68c5f000-0x6bffffff]
[    2.138895] e820: reserve RAM buffer [mem 0x8bfe5000-0x8bffffff]
[    2.138900] e820: reserve RAM buffer [mem 0x8c4d4000-0x8fffffff]
[    2.138906] e820: reserve RAM buffer [mem 0x8d300000-0x8fffffff]
[    2.138912] e820: reserve RAM buffer [mem 0x86f000000-0x86fffffff]
[    2.139022] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    2.139026] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    2.141143] clocksource: Switched to clocksource tsc-early
[    2.402787] VFS: Disk quotas dquot_6.6.0
[    2.402946] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.403435] pnp: PnP ACPI init
[    2.405579] system 00:00: [io  0x0a00-0x0a2f] has been reserved
[    2.405587] system 00:00: [io  0x0a30-0x0a3f] has been reserved
[    2.405594] system 00:00: [io  0x0a40-0x0a4f] has been reserved
[    2.405600] system 00:00: [io  0x0a50-0x0a5f] has been reserved
[    2.407753] pnp 00:01: [dma 0 disabled]
[    2.409058] system 00:02: [io  0x0680-0x069f] has been reserved
[    2.409065] system 00:02: [io  0xffff] has been reserved
[    2.409072] system 00:02: [io  0xffff] has been reserved
[    2.409078] system 00:02: [io  0xffff] has been reserved
[    2.409085] system 00:02: [io  0x1800-0x18fe] has been reserved
[    2.409096] system 00:02: [io  0x164e-0x164f] has been reserved
[    2.409729] system 00:03: [io  0x0800-0x087f] has been reserved
[    2.410436] system 00:05: [io  0x1854-0x1857] has been reserved
[    2.412461] system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
[    2.412468] system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
[    2.412475] system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
[    2.412481] system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
[    2.412488] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
[    2.412497] system 00:06: [mem 0xfed90000-0xfed93fff] could not be reserved
[    2.412503] system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
[    2.412510] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    2.412519] system 00:06: [mem 0xfee00000-0xfeefffff] could not be reserved
[    2.412526] system 00:06: [mem 0xdffe0000-0xdfffffff] has been reserved
[    2.413073] system 00:07: [mem 0xfd000000-0xfdabffff] has been reserved
[    2.413080] system 00:07: [mem 0xfdad0000-0xfdadffff] has been reserved
[    2.413087] system 00:07: [mem 0xfdb00000-0xfdffffff] has been reserved
[    2.413096] system 00:07: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    2.413102] system 00:07: [mem 0xfe036000-0xfe03bfff] has been reserved
[    2.413109] system 00:07: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    2.413115] system 00:07: [mem 0xfe410000-0xfe7fffff] has been reserved
[    2.414777] system 00:08: [io  0xff00-0xfffe] has been reserved
[    2.429144] pnp: PnP ACPI: found 10 devices
[    2.447595] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    2.448128] NET: Registered PF_INET protocol family
[    2.448395] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    2.450847] tcp_listen_portaddr_hash hash table entries: 16384 (order: 9, 2621440 bytes, linear)
[    2.451220] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    2.451612] TCP bind hash table entries: 65536 (order: 11, 9961472 bytes, vmalloc)
[    2.452994] TCP: Hash tables configured (established 262144 bind 65536)
[    2.453565] MPTCP token hash table entries: 32768 (order: 10, 5505024 bytes, vmalloc)
[    2.454497] UDP hash table entries: 16384 (order: 10, 5242880 bytes, vmalloc)
[    2.455348] UDP-Lite hash table entries: 16384 (order: 10, 5242880 bytes, vmalloc)
[    2.456360] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    2.457022] RPC: Registered named UNIX socket transport module.
[    2.457024] RPC: Registered udp transport module.
[    2.457025] RPC: Registered tcp transport module.
[    2.457027] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.457032] NET: Registered PF_XDP protocol family
[    2.457046] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    2.457051] pci 0000:00:1b.0:   bridge window [mem 0xdf200000-0xdf2fffff]
[    2.457056] pci 0000:00:1b.3: PCI bridge to [bus 02]
[    2.457064] pci 0000:03:00.0: PCI bridge to [bus 04]
[    2.457071] pci 0000:03:00.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    2.457083] pci 0000:00:1c.0: PCI bridge to [bus 03-04]
[    2.457086] pci 0000:00:1c.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    2.457088] pci 0000:00:1c.0:   bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
[    2.457092] pci 0000:05:00.0: PCI bridge to [bus 06]
[    2.457095] pci 0000:05:00.0:   bridge window [io  0xe000-0xefff]
[    2.457102] pci 0000:05:00.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[    2.457116] pci 0000:00:1c.4: PCI bridge to [bus 05-06]
[    2.457117] pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
[    2.457120] pci 0000:00:1c.4:   bridge window [mem 0xdf000000-0xdf0fffff]
[    2.457125] pci 0000:00:1d.0: PCI bridge to [bus 07]
[    2.457134] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.457135] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.457136] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    2.457137] pci_bus 0000:00: resource 7 [mem 0x90000000-0xdfffffff window]
[    2.457138] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
[    2.457139] pci_bus 0000:01: resource 1 [mem 0xdf200000-0xdf2fffff]
[    2.457139] pci_bus 0000:03: resource 1 [mem 0xdf100000-0xdf1fffff]
[    2.457140] pci_bus 0000:03: resource 2 [mem 0xd0000000-0xd00fffff 64bit pref]
[    2.457141] pci_bus 0000:04: resource 1 [mem 0xdf100000-0xdf1fffff]
[    2.457142] pci_bus 0000:05: resource 0 [io  0xe000-0xefff]
[    2.457143] pci_bus 0000:05: resource 1 [mem 0xdf000000-0xdf0fffff]
[    2.457143] pci_bus 0000:06: resource 0 [io  0xe000-0xefff]
[    2.457144] pci_bus 0000:06: resource 1 [mem 0xdf000000-0xdf0fffff]
[    2.458024] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    2.463931] PCI: CLS 64 bytes, default 64
[    2.464084] DMAR: [Firmware Bug]: RMRR entry for device 01:00.0 is broken - applying workaround
[    2.464231] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.464231] software IO TLB: mapped [mem 0x0000000087fe5000-0x000000008bfe5000] (64MB)
[    2.464763] Trying to unpack rootfs image as initramfs...
[    2.471454] Initialise system trusted keyrings
[    2.471584] Key type blacklist registered
[    2.471770] workingset: timestamp_bits=52 max_order=23 bucket_order=0
[    2.525387] zbud: loaded
[    2.536526] NFS: Registering the id_resolver key type
[    2.536546] Key type id_resolver registered
[    2.536548] Key type id_legacy registered
[    2.537044] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    2.537085] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    2.537087] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    2.541127] SGI XFS with ACLs, security attributes, scrub, quota, no debug enabled
[    2.548572] integrity: Platform Keyring initialized
[    2.554375] NET: Registered PF_ALG protocol family
[    2.554415] xor: automatically using best checksumming function   avx       
[    2.554432] async_tx: api initialized (async)
[    2.554435] Key type asymmetric registered
[    2.554450] Asymmetric key parser 'x509' registered
[    2.555061] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    2.555300] io scheduler mq-deadline registered
[    2.555302] io scheduler kyber registered
[    2.555802] io scheduler bfq registered
[    2.556649] cryptomgr_test (73) used greatest stack depth: 14704 bytes left
[    2.557340] cryptomgr_test (75) used greatest stack depth: 14448 bytes left
[    2.558867] pcieport 0000:00:1b.0: PME: Signaling with IRQ 122
[    2.559387] pcieport 0000:00:1b.0: AER: enabled with IRQ 122
[    2.562164] pcieport 0000:00:1b.3: PME: Signaling with IRQ 123
[    2.562582] pcieport 0000:00:1b.3: AER: enabled with IRQ 123
[    2.565311] pcieport 0000:00:1c.0: PME: Signaling with IRQ 124
[    2.565979] pcieport 0000:00:1c.0: AER: enabled with IRQ 124
[    2.568444] pcieport 0000:00:1c.4: PME: Signaling with IRQ 125
[    2.568958] pcieport 0000:00:1c.4: AER: enabled with IRQ 125
[    2.571386] pcieport 0000:00:1d.0: PME: Signaling with IRQ 126
[    2.571801] pcieport 0000:00:1d.0: AER: enabled with IRQ 126
[    2.572827] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    2.579131] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    2.579429] ACPI: button: Sleep Button [SLPB]
[    2.579826] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    2.580099] ACPI: button: Power Button [PWRB]
[    2.580503] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    2.582347] ACPI: button: Power Button [PWRF]
[    2.584357] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1024
[    2.598330] thermal LNXTHERM:00: registered as thermal_zone0
[    2.598332] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    2.600283] thermal LNXTHERM:01: registered as thermal_zone1
[    2.600284] ACPI: thermal: Thermal Zone [TZ01] (30 C)
[    2.603440] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.603754] 00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.636592] Non-volatile memory driver v1.3
[    2.636898] Linux agpgart interface v0.103
[    2.637870] ACPI: bus type drm_connector registered
[    2.662527] brd: module loaded
[    2.664459] zram: Added device: zram0
[    2.664913] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    2.665794] Loading iSCSI transport class v2.0-870.
[    2.666966] rdac: device handler registered
[    2.667159] hp_sw: device handler registered
[    2.667162] emc: device handler registered
[    2.667342] alua: device handler registered
[    2.668077] fnic: Cisco FCoE HBA Driver, ver 1.6.0.53
[    2.668196] fnic: Successfully Initialized Trace Buffer
[    2.668325] fnic: Successfully Initialized FC_CTLR Trace Buffer
[    2.669761] bnx2fc: QLogic FCoE Driver bnx2fc v2.12.13 (October 15, 2015)
[    2.671332] Adaptec aacraid driver 1.2.1[50983]-custom
[    2.671649] isci: Intel(R) C600 SAS Controller Driver - version 1.2.0
[    2.672438] iscsi: registered transport (qla4xxx)
[    2.672572] QLogic iSCSI HBA Driver
[    2.672572] QLogic BR-series BFA FC/FCOE SCSI driver - version: 3.2.25.1
[    2.672722] csiostor: Chelsio FCoE driver 1.0.0-ko
[    2.673585] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
[    2.673808] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
[    2.673966] megasas: 07.719.03.00-rc1
[    2.674180] mpt3sas version 39.100.00.00 loaded
[    2.675409] 3ware Storage Controller device driver for Linux v1.26.02.003.
[    2.675545] 3ware 9000 Storage Controller device driver for Linux v2.26.02.014.
[    2.675677] LSI 3ware SAS/SATA-RAID Controller device driver for Linux v3.26.02.000.
[    2.675808] ipr: IBM Power RAID SCSI Device Driver version: 2.6.4 (March 14, 2017)
[    2.675964] RocketRAID 3xxx/4xxx Controller driver v1.10.0
[    2.676070] stex: Promise SuperTrak EX Driver version: 6.02.0000.01
[    2.676447] libcxgbi:libcxgbi_init_module: Chelsio iSCSI driver library libcxgbi v0.9.1-ko (Apr. 2015)
[    2.676449] Chelsio T3 iSCSI Driver cxgb3i v2.0.1-ko (Apr. 2015)
[    2.676571] iscsi: registered transport (cxgb3i)
[    2.676592] QLogic NetXtreme II iSCSI Driver bnx2i v2.7.10.1 (Jul 16, 2014)
[    2.676704] iscsi: registered transport (bnx2i)
[    2.678094] VMware PVSCSI driver - version 1.0.7.0-k
[    2.679531] ahci 0000:00:17.0: version 3.0
[    2.691728] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    2.691731] ahci 0000:00:17.0: flags: 64bit ncq sntf led clo only pio slum part ems deso sadm sds apst 
[    2.713473] scsi host0: ahci
[    2.715288] scsi host1: ahci
[    2.716416] scsi host2: ahci
[    2.717521] scsi host3: ahci
[    2.718998] scsi host4: ahci
[    2.720120] scsi host5: ahci
[    2.720648] ata1: SATA max UDMA/133 abar m2048@0xdf34b000 port 0xdf34b100 irq 128
[    2.720649] ata2: SATA max UDMA/133 abar m2048@0xdf34b000 port 0xdf34b180 irq 128
[    2.720650] ata3: SATA max UDMA/133 abar m2048@0xdf34b000 port 0xdf34b200 irq 128
[    2.720651] ata4: SATA max UDMA/133 abar m2048@0xdf34b000 port 0xdf34b280 irq 128
[    2.720653] ata5: SATA max UDMA/133 abar m2048@0xdf34b000 port 0xdf34b300 irq 128
[    2.720654] ata6: SATA max UDMA/133 abar m2048@0xdf34b000 port 0xdf34b380 irq 128
[    2.729809] libphy: Fixed MDIO Bus: probed
[    2.733752] cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)
[    2.736979] e100: Intel(R) PRO/100 Network Driver
[    2.736980] e100: Copyright(c) 1999-2006 Intel Corporation
[    2.737085] e1000: Intel(R) PRO/1000 Network Driver
[    2.737085] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.737228] e1000e: Intel(R) PRO/1000 Network Driver
[    2.737229] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.739019] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    3.029020] ata3: SATA link down (SStatus 4 SControl 300)
[    3.029053] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.029622] ata5: SATA link down (SStatus 4 SControl 300)
[    3.029775] ata4: SATA link down (SStatus 4 SControl 300)
[    3.029931] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.029994] ata2: SATA link down (SStatus 4 SControl 300)
[    3.030016] ata1.00: ATA-9: KINGSTON SEDC400S37480G, SAFM02.H, max UDMA/133
[    3.030080] ata1.00: 937703088 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.030865] ata1.00: configured for UDMA/133
[    3.032237] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON SEDC400 02.H PQ: 0 ANSI: 5
[    3.032554] ata6.00: ATAPI: HL-DT-ST DVDRAM GH24NS95, RN01, max UDMA/133
[    3.034181] ata6.00: configured for UDMA/133
[    3.035137] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.035546] sd 0:0:0:0: [sda] 937703088 512-byte logical blocks: (480 GB/447 GiB)
[    3.035583] sd 0:0:0:0: [sda] Write Protect is off
[    3.035587] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.035676] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.042286] scsi 5:0:0:0: CD-ROM            HL-DT-ST DVDRAM GH24NS95  RN01 PQ: 0 ANSI: 5
[    3.050870]  sda: sda1 sda2 sda3 sda4 sda5
[    3.060393] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.090172] sr 5:0:0:0: [sr0] scsi3-mmc drive: 48x/12x writer dvd-ram cd/rw xa/form2 cdda tray
[    3.090188] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.091958] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[    3.117489] sr 5:0:0:0: Attached scsi CD-ROM sr0
[    3.118008] sr 5:0:0:0: Attached scsi generic sg1 type 5
[    3.157230] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 0c:c4:7a:b6:1c:f3
[    3.157275] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    3.157338] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: 010AFF-0FF
[    3.157488] igb: Intel(R) Gigabit Ethernet Network Driver
[    3.157488] igb: Copyright (c) 2007-2014 Intel Corporation.
[    3.157607] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    3.157608] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    3.157714] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[    3.157714] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    3.158100] ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver
[    3.158101] ixgbevf: Copyright (c) 2009 - 2018 Intel Corporation.
[    3.158441] i40e: Intel(R) Ethernet Connection XL710 Network Driver
[    3.158442] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[    3.158796] ixgb: Intel(R) PRO/10GbE Network Driver
[    3.158797] ixgb: Copyright (c) 1999-2008 Intel Corporation.
[    3.158946] iavf: Intel(R) Ethernet Adaptive Virtual Function Network Driver
[    3.158947] Copyright (c) 2013 - 2018 Intel Corporation.
[    3.159277] Intel(R) Ethernet Switch Host Interface Driver
[    3.159278] Copyright(c) 2013 - 2019 Intel Corporation.
[    3.159651] jme: JMicron JMC2XX ethernet driver version 1.0.8
[    3.160028] sky2: driver version 1.30
[    3.160662] myri10ge: Version 1.5.3-1.534
[    3.161019] ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
[    3.161261] vxge: Copyright(c) 2002-2010 Exar Corp.
[    3.161261] vxge: Driver version: 2.5.3.22640-k
[    3.161885] QLogic 1/10 GbE Converged/Intelligent Ethernet Driver v5.3.66
[    3.162039] QLogic/NetXen Network Driver v4.0.82
[    3.162180] QLogic FastLinQ 4xxxx Core Module qed
[    3.162181] qede init: QLogic FastLinQ 4xxxx Ethernet Driver qede
[    3.163189] Solarflare NET driver
[    3.164782] tehuti: Tehuti Networks(R) Network Driver, 7.29.3
[    3.164783] tehuti: Options: hw_csum 
[    3.164894] tlan: ThunderLAN driver v1.17
[    3.164998] tlan: 0 devices installed, PCI: 0  EISA: 0
[    3.165697] Fusion MPT base driver 3.04.20
[    3.165697] Copyright (c) 1999-2008 LSI Corporation
[    3.165716] Fusion MPT SPI Host driver 3.04.20
[    3.165855] Fusion MPT FC Host driver 3.04.20
[    3.166013] Fusion MPT SAS Host driver 3.04.20
[    3.166154] Fusion MPT misc device (ioctl) driver 3.04.20
[    3.166409] mptctl: Registered with Fusion MPT base driver
[    3.166410] mptctl: /dev/mptctl @ (major,minor=10,220)
[    3.166411] Fusion MPT LAN driver 3.04.20
[    3.166770] VFIO - User Level meta-driver version: 0.3
[    3.167608] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.167609] ehci-pci: EHCI PCI platform driver
[    3.167723] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.167746] ohci-pci: OHCI PCI platform driver
[    3.167851] uhci_hcd: USB Universal Host Controller Interface driver
[    3.169919] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    3.170855] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    3.172431] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000001109810
[    3.176779] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.16
[    3.176781] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.176782] usb usb1: Product: xHCI Host Controller
[    3.176783] usb usb1: Manufacturer: Linux 5.16.0-rc3-rt6 xhci-hcd
[    3.176784] usb usb1: SerialNumber: 0000:00:14.0
[    3.178801] hub 1-0:1.0: USB hub found
[    3.178971] hub 1-0:1.0: 16 ports detected
[    3.204376] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    3.205011] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    3.205020] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    3.206069] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.16
[    3.206072] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.206073] usb usb2: Product: xHCI Host Controller
[    3.206073] usb usb2: Manufacturer: Linux 5.16.0-rc3-rt6 xhci-hcd
[    3.206074] usb usb2: SerialNumber: 0000:00:14.0
[    3.207826] hub 2-0:1.0: USB hub found
[    3.208077] hub 2-0:1.0: 10 ports detected
[    3.225335] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    3.225859] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 3
[    3.284972] xhci_hcd 0000:01:00.0: hcc params 0x0200eec0 hci version 0x110 quirks 0x0000000000800010
[    3.288146] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.16
[    3.288148] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.288149] usb usb3: Product: xHCI Host Controller
[    3.288150] usb usb3: Manufacturer: Linux 5.16.0-rc3-rt6 xhci-hcd
[    3.288151] usb usb3: SerialNumber: 0000:01:00.0
[    3.289258] hub 3-0:1.0: USB hub found
[    3.289365] hub 3-0:1.0: 2 ports detected
[    3.290656] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    3.291101] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 4
[    3.291130] xhci_hcd 0000:01:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    3.291248] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.291483] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.16
[    3.291485] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.291486] usb usb4: Product: xHCI Host Controller
[    3.291487] usb usb4: Manufacturer: Linux 5.16.0-rc3-rt6 xhci-hcd
[    3.291487] usb usb4: SerialNumber: 0000:01:00.0
[    3.292567] hub 4-0:1.0: USB hub found
[    3.292613] hub 4-0:1.0: 2 ports detected
[    3.293908] usbcore: registered new interface driver usbserial_generic
[    3.294054] usbserial: USB Serial support registered for generic
[    3.294211] i8042: PNP: No PS/2 controller found.
[    3.294212] i8042: Probing ports directly.
[    3.298454] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.299285] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.300047] mousedev: PS/2 mouse device common for all mice
[    3.302101] rtc_cmos 00:04: RTC can wake from S4
[    3.304693] rtc_cmos 00:04: registered as rtc0
[    3.304910] rtc_cmos 00:04: setting system clock to 2021-11-30T16:44:09 UTC (1638290649)
[    3.304915] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    3.305946] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    3.306432] device-mapper: uevent: version 1.0.3
[    3.307254] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
[    3.307862] device-mapper: multipath round-robin: version 1.2.0 loaded
[    3.307866] device-mapper: multipath queue-length: version 0.2.0 loaded
[    3.307869] device-mapper: multipath service-time: version 0.3.0 loaded
[    3.307986] intel_pstate: Intel P-state driver initializing
[    3.310694] intel_pstate: HWP enabled
[    3.315089] hid: raw HID events driver (C) Jiri Kosina
[    3.315822] usbcore: registered new interface driver usbhid
[    3.315823] usbhid: USB HID core driver
[    3.316336] resource sanity check: requesting [mem 0xfdffe800-0xfe0007ff], which spans more than pnp 00:07 [mem 0xfdb00000-0xfdffffff]
[    3.316338] caller pmc_core_probe+0xa5/0x5b0 mapping multiple BARs
[    3.316527] intel_pmc_core INT33A1:00:  initialized
[    3.318587] Initializing XFRM netlink socket
[    3.321478] NET: Registered PF_INET6 protocol family
[    3.443948] usb 1-7: new low-speed USB device number 2 using xhci_hcd
[    3.487123] tsc: Refined TSC clocksource calibration: 4007.999 MHz
[    3.487133] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x39c5e149d3a, max_idle_ns: 440795336434 ns
[    3.487299] clocksource: Switched to clocksource tsc
[    3.578051] usb 1-7: New USB device found, idVendor=14dd, idProduct=1007, bcdDevice= 0.00
[    3.578054] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=7
[    3.578055] usb 1-7: Product: D2CIM-DVUSB
[    3.578055] usb 1-7: Manufacturer: Raritan
[    3.578056] usb 1-7: SerialNumber: HUY95006260000003
[    3.590279] input: Raritan D2CIM-DVUSB as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/0003:14DD:1007.0001/input/input6
[    3.645249] hid-generic 0003:14DD:1007.0001: input,hidraw0: USB HID v1.10 Keyboard [Raritan D2CIM-DVUSB] on usb-0000:00:14.0-7/input0
[    3.651308] input: Raritan D2CIM-DVUSB as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.1/0003:14DD:1007.0002/input/input7
[    3.652428] hid-generic 0003:14DD:1007.0002: input,hidraw1: USB HID v1.10 Mouse [Raritan D2CIM-DVUSB] on usb-0000:00:14.0-7/input1
[    4.987493] Freeing initrd memory: 157248K
[    4.992252] modprobe (165) used greatest stack depth: 13848 bytes left
[    4.996526] modprobe (167) used greatest stack depth: 13840 bytes left
[    5.001765] modprobe (170) used greatest stack depth: 13744 bytes left
[    5.005555] modprobe (171) used greatest stack depth: 13688 bytes left
[    5.007504] Segment Routing with IPv6
[    5.007505] RPL Segment Routing with IPv6
[    5.007543] In-situ OAM (IOAM) with IPv6
[    5.007602] mip6: Mobile IPv6
[    5.007659] NET: Registered PF_PACKET protocol family
[    5.007896] Key type dns_resolver registered
[    5.010782] microcode: sig=0x506e3, pf=0x2, revision=0xba
[    5.011065] microcode: Microcode Update Driver: v2.2.
[    5.011073] IPI shorthand broadcast: enabled
[    5.011134] AVX2 version of gcm_enc/dec engaged.
[    5.011250] AES CTR mode by8 optimization enabled
[    5.012472] sched_clock: Marking stable (5006823041, 5592571)->(5019071450, -6655838)
[    5.014424] printk: console [ttyS0]: printing thread started
[    5.014582] registered taskstats version 1
[    5.014598] Loading compiled-in X.509 certificates
[    5.036346] Loaded X.509 cert 'Build time autogenerated kernel key: 6c683f08c8e037452f4717b2e3a26b269bbd5b2b'
[    5.037960] zswap: loaded using pool lzo/zbud
[    5.040746] Key type ._fscrypt registered
[    5.040748] Key type .fscrypt registered
[    5.040750] Key type fscrypt-provisioning registered
[    5.044663] Btrfs loaded, crc32c=crc32c-generic, zoned=yes, fsverity=yes
[    5.053667] Key type encrypted registered
[    5.053743] ima: No TPM chip found, activating TPM-bypass!
[    5.053767] Loading compiled-in module X.509 certificates
[    5.054346] Loaded X.509 cert 'Build time autogenerated kernel key: 6c683f08c8e037452f4717b2e3a26b269bbd5b2b'
[    5.054351] ima: Allocated hash algorithm: sha256
[    5.054415] ima: No architecture policies found
[    5.063665] cryptomgr_test (196) used greatest stack depth: 13400 bytes left
[    5.132142] alg: No test for 842 (842-scomp)
[    5.132255] alg: No test for 842 (842-generic)
[    5.206296] RAS: Correctable Errors collector initialized.
[    5.211433] Freeing unused decrypted memory: 2036K
[    5.214331] Freeing unused kernel image (initmem) memory: 3764K
[    5.219198] Write protecting the kernel read-only data: 38912k
[    5.223548] Freeing unused kernel image (text/rodata gap) memory: 2024K
[    5.225233] Freeing unused kernel image (rodata/data gap) memory: 1316K
[    5.262921] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    5.262923] x86/mm: Checking user space page tables
[    5.298597] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    5.298609] Run /init as init process
[    5.298609]   with arguments:
[    5.298610]     /init
[    5.298610]     rhgb
[    5.298610]   with environment:
[    5.298611]     HOME=/
[    5.298611]     TERM=linux
[    5.298611]     BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.16.0-rc3-rt6
[    5.298611]     biosdevname=0
[    5.377840] systemd[1]: systemd 239 (239-45.el8) running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=legacy)
[    5.390092] systemd[1]: Detected architecture x86-64.
[    5.390097] systemd[1]: Running in initial RAM disk.
[    5.403652] systemd[1]: Set hostname to <skylar>.
[    5.547934] systemd[1]: Listening on Journal Socket (/dev/log).
[    5.548097] systemd[1]: Reached target Slices.
[    5.548601] systemd[1]: Listening on udev Control Socket.
[    5.548614] systemd[1]: Reached target Swap.
[    5.548624] systemd[1]: Reached target Local File Systems.
[    5.548918] systemd[1]: Listening on udev Kernel Socket.
[    5.625329] fuse: init (API version 7.35)
[    5.636149] systemd-modules (319) used greatest stack depth: 13240 bytes left
[    5.911752] dracut-pre-udev (388) used greatest stack depth: 13176 bytes left
[    7.930055] i915 0000:00:02.0: vgaarb: deactivate vga console
[    7.932154] Console: switching to colour dummy device 80x25
[    7.940536] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    7.942055] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/skl_dmc_ver1_27.bin (v1.27)
[    7.946174] i915 0000:00:02.0: [drm] [ENCODER:94:DDI B/PHY B] is disabled/in DSI mode with an ungated DDI clock, gate it
[    7.946226] i915 0000:00:02.0: [drm] [ENCODER:103:DDI C/PHY C] is disabled/in DSI mode with an ungated DDI clock, gate it
[    7.979667] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[    7.992942] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    7.996220] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input8
[    8.022014] fbcon: i915 (fb0) is primary device
[    8.037495] Console: switching to colour frame buffer device 160x64
[    8.056289] i915 0000:00:02.0: [drm] fb0: i915 frame buffer device
[    8.218590] systemd-udevd (447) used greatest stack depth: 12648 bytes left
[    8.220244] systemd-udevd (453) used greatest stack depth: 12168 bytes left
[    8.680378] EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    9.579447] printk: systemd: 21 output lines suppressed due to ratelimiting
[    9.731595] SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.
[    9.731668] SELinux:  Disabled at runtime.
[    9.758520] audit: type=1404 audit(1638290655.952:2): enforcing=0 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=0 old-enabled=1 lsm=selinux res=1
[    9.774136] systemd[1]: RTC configured in localtime, applying delta of -300 minutes to system time.
[    9.832820] systemd[1]: systemd 239 (239-45.el8) running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=legacy)
[    9.845089] systemd[1]: Detected architecture x86-64.
[    9.847164] systemd[1]: Set hostname to <skylar>.
[   10.112197] systemd[1]: File /usr/lib/systemd/system/systemd-logind.service.d/nss_nis.conf:2 configures an IP firewall (IPAddressAllow=any), but the local system does not support BPF/cgroup based firewalling.
[   10.112203] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[   10.210622] systemd[1]: systemd-journald.service: Succeeded.
[   10.216207] systemd[1]: initrd-switch-root.service: Succeeded.
[   10.217847] systemd[1]: Stopped Switch Root.
[   10.220669] systemd[1]: systemd-journald.service: Service has no hold-off time (RestartSec=0), scheduling restart.
[   10.220716] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[   10.278464] Adding 7812092k swap on /dev/sda3.  Priority:-2 extents:1 across:7812092k SSFS
[   10.341772] EXT4-fs (sda5): re-mounted. Opts: (null). Quota mode: none.
[   19.027830] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   19.032223] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   19.051802] i2c i2c-4: 4/4 memory slots populated (from DMI)
[   19.054169] i2c i2c-4: Successfully instantiated SPD at 0x50
[   19.054835] i2c i2c-4: Successfully instantiated SPD at 0x51
[   19.057940] i2c i2c-4: Successfully instantiated SPD at 0x52
[   19.066721] i2c i2c-4: Successfully instantiated SPD at 0x53
[   19.312903] input: PC Speaker as /devices/platform/pcspkr/input/input9
[   19.449699] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[   19.529552] snd_hda_codec_realtek hdaudioC0D0: ALC1150: SKU not ready 0x00000000
[   19.531299] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC1150: line_outs=4 (0x14/0x17/0x16/0x15/0x0) type:line
[   19.531302] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   19.531303] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   19.531304] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   19.531305] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x1e
[   19.531306] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   19.531310] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[   19.531314] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[   19.531316] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[   19.567502] modprobe (5295) used greatest stack depth: 12080 bytes left
[   19.617305] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[   19.619025] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[   19.621252] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[   19.626052] input: HDA Intel PCH Line Out Front as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[   19.627248] input: HDA Intel PCH Line Out Surround as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[   19.627781] input: HDA Intel PCH Line Out CLFE as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[   19.628427] input: HDA Intel PCH Line Out Side as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[   19.629023] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[   19.629547] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[   19.630320] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
[   19.630927] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
[   19.631616] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input21
[   19.632306] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input22
[   19.845623] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[   19.845625] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   19.845626] RAPL PMU: hw unit of domain package 2^-14 Joules
[   19.845626] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   19.845627] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   22.999519] iTCO_vendor_support: vendor-support=0
[   23.020127] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
[   23.026170] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   23.135499] ee1004 4-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
[   23.135755] ee1004 4-0051: 512 byte EE1004-compliant SPD EEPROM, read-only
[   23.137658] ee1004 4-0052: 512 byte EE1004-compliant SPD EEPROM, read-only
[   23.139713] ee1004 4-0053: 512 byte EE1004-compliant SPD EEPROM, read-only
[   23.826136] intel_rapl_common: Found RAPL domain package
[   23.826138] intel_rapl_common: Found RAPL domain core
[   23.826139] intel_rapl_common: Found RAPL domain uncore
[   23.826141] intel_rapl_common: Found RAPL domain dram
[   24.007697] systemd-udevd (652) used greatest stack depth: 11912 bytes left
[   24.125457] EXT4-fs (sda4): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[   24.243799] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[   29.076566] e1000e 0000:00:1f.6 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   29.077344] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   34.303887] NFSD: Using nfsdcld client tracking operations.
[   34.303889] NFSD: no clients to reclaim, skipping NFSv4 grace period (net f00000a8)
[   34.463128] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   34.491727] tun: Universal TUN/TAP device driver, 1.6
[   34.499659] virbr0: port 1(virbr0-nic) entered blocking state
[   34.499671] virbr0: port 1(virbr0-nic) entered disabled state
[   34.502944] device virbr0-nic entered promiscuous mode
[   34.707556] ------------[ cut here ]------------
[   34.707558] WARNING: CPU: 3 PID: 8312 at include/linux/seqlock.h:271 nft_counter_eval+0x74/0xd1 [nft_counter]
[   34.707563] Modules linked in: nft_counter nft_chain_nat nf_nat tun bridge stp llc rfkill intel_rapl_msr ee1004 iTCO_wdt intel_pmc_bxt iTCO_vendor_support intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel kvm_intel rapl intel_cstate intel_uncore snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core pcspkr snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd i2c_i801 i2c_smbus soundcore mei_hdcp acpi_pad intel_pch_thermal ip_tables i915 crc32c_intel serio_raw ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops pinctrl_sunrisepoint video fuse
[   34.707584] CPU: 3 PID: 8312 Comm: irq/129-eth0 Not tainted 5.16.0-rc3-rt6 #1
[   34.707586] Hardware name: Supermicro C7Z170-SQ/C7Z170-SQ, BIOS 2.0a 07/17/2017
[   34.707586] RIP: 0010:nft_counter_eval+0x74/0xd1 [nft_counter]
[   34.707589] Code: 41 ba 85 d2 74 26 65 8b 05 a9 f6 86 3f 85 c0 75 1b 65 8b 05 9e ea 6a 3f a9 ff ff ff 7f 75 0d 65 8b 05 94 f2 6a 3f 85 c0 74 02 <0f> 0b 83 45 00 01 ff 74 24 20 4c 8d 6d 08 45 31 c9 31 c9 41 b8 01
[   34.707590] RSP: 0018:ffffb3248244f898 EFLAGS: 00010202
[   34.707591] RAX: 0000000000000001 RBX: ffffd3247fc2dcc0 RCX: 0000000000000001
[   34.707592] RDX: 0000000000000001 RSI: ffffffffba26ceaa RDI: ffffffffba223a51
[   34.707593] RBP: ffff95f18edf50c0 R08: 000000000000000b R09: 0000000000000004
[   34.707593] R10: 0000000000000001 R11: 0000000000000000 R12: ffffb3248244fa98
[   34.707594] R13: ffff95ea674b3ec0 R14: ffff95ea40f5e648 R15: ffff95ea40f5e618
[   34.707595] FS:  0000000000000000(0000) GS:ffff95f18ec00000(0000) knlGS:0000000000000000
[   34.707596] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.707597] CR2: 00007ffff73b4934 CR3: 0000000469670005 CR4: 00000000003706e0
[   34.707597] Call Trace:
[   34.707598]  <TASK>
[   34.707601]  nft_do_chain+0x15a/0x5b0
[   34.707611]  ? dst_alloc+0x36/0xa0
[   34.707625]  ? __lock_acquire+0x3c9/0x2340
[   34.707641]  nft_do_chain_ipv4+0x51/0x60
[   34.707645]  ? nft_do_chain_arp+0x30/0x30
[   34.707647]  nf_hook_slow+0x3f/0xc0
[   34.707652]  ip_local_deliver+0xdf/0x1e0
[   34.707657]  ? ip_protocol_deliver_rcu+0x300/0x300
[   34.707662]  ip_sublist_rcv_finish+0xc0/0x130
[   34.707665]  ip_sublist_rcv+0x234/0x340
[   34.707671]  ? ip_local_deliver+0x1e0/0x1e0
[   34.707676]  ip_list_rcv+0x122/0x140
[   34.707683]  __netif_receive_skb_list_core+0x282/0x2a0
[   34.707692]  netif_receive_skb_list_internal+0x237/0x3d0
[   34.707701]  napi_complete_done+0x69/0x1b0
[   34.707704]  e1000e_poll+0x98/0x260
[   34.707709]  __napi_poll+0x26/0x280
[   34.707712]  net_rx_action+0x223/0x2f0
[   34.707721]  __do_softirq+0xcc/0x544
[   34.707729]  ? irq_thread+0x92/0x190
[   34.707731]  __local_bh_enable_ip+0x133/0x160
[   34.707735]  ? irq_finalize_oneshot.part.47+0xe0/0xe0
[   34.707737]  irq_forced_thread_fn+0x68/0x70
[   34.707741]  irq_thread+0xe9/0x190
[   34.707744]  ? wake_threads_waitq+0x30/0x30
[   34.707748]  ? irq_thread_check_affinity+0xa0/0xa0
[   34.707751]  kthread+0x196/0x1c0
[   34.707754]  ? set_kthread_struct+0x40/0x40
[   34.707759]  ret_from_fork+0x22/0x30
[   34.707773]  </TASK>
[   34.707774] irq event stamp: 4196
[   34.707774] hardirqs last  enabled at (4198): [<ffffffffb81b4da0>] vprintk_store+0x360/0x5e0
[   34.707776] hardirqs last disabled at (4199): [<ffffffffb81b4dea>] vprintk_store+0x3aa/0x5e0
[   34.707777] softirqs last  enabled at (3922): [<ffffffffb813c492>] __local_bh_enable_ip+0xb2/0x160
[   34.707780] softirqs last disabled at (3932): [<ffffffffb81b91c0>] irq_forced_thread_fn+0x0/0x70
[   34.707782] ---[ end trace 0000000000000002 ]---
[   35.463400] virbr0: port 1(virbr0-nic) entered blocking state
[   35.463409] virbr0: port 1(virbr0-nic) entered listening state
[   35.736473] virbr0: port 1(virbr0-nic) entered disabled state
[   49.506964] dbus-launch (8895) used greatest stack depth: 11232 bytes left
[  244.670574] rfkill: input handler disabled
