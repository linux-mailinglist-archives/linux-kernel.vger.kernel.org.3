Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA5E4AE93D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiBIFXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:23:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346582AbiBIFKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:10:54 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A7C03C1A8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:10:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGSu01VSUxaqt2c5VuHAZZ2gLskFbUgkJb8rBsl0HA8Ku6LPeaTtBceKmA0/fY/h1xT5Dansl4uW9y8+iuCWP07GkKu8yNxOifkV63h+t8PZgZP5Zo9fOVH6RVLPOjRSP+hhgSEA75hwAGjxEDEMz6Mo/r3DJKnyrCYBGCIDfOYqJ3WM0O2bP4o7f9oCImS0EIiqlNGH72HUUzZ0QeC1iUoemfiCWnoE/7vYwc+PFAdrfqO8pQcwiqnJq/9yLJ6T3iy9yjG0oH95/8Zl3qs7J3yd0Bmu7DWh7i/ijXyKy+j6dUJFct0pY5PmLLax1/L0WpDGn0GiZqt3xbRdBQOL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gx7kSopMV/YWrma+nnxxpYE8KM9JyHUvVZeWiwZ/VQg=;
 b=OjZ8MpRhVg9s2ffWXcohmFBGouLklB5+UJ58Nuh9qWSPntzI2FKw84scLf6mYYk7XYrPSBpWM41l7dW/t0t/X6pXilkMHpsxVr1G2W2CEfXYjag40XYsOMmxSoAaRdm5ZXkNpanEnwgru7WsvQMeMWAZOoGudlem2ZrnEa4rMhKuiCPy/NYPqUssscfLdlhRHhcvXL5eLxPICVIq3RSk+/50Z6zn27VuRaTUrlGrIi+KC+i5xM54uVIXPJNelmiBEHLJm7CI1svPVBaIMC7xkxFSjqis9/Tk0XZJFufdFeQSJydMz7RcPSY1euV7d6fPckzwP4l9jrSRK8kZnXXlyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx7kSopMV/YWrma+nnxxpYE8KM9JyHUvVZeWiwZ/VQg=;
 b=dGHNbq8WRxNF+iaZQ525BGP+243jrFfxCdFNKbSYXGQJwIR5XsFvuo+xwlm3ntoY8l46ho656JpqdmtIkuiVFMNnHZTSOo+pRk70m+KYPtMZ9Baxp2WuMn8S9fUgyX93Uiq6DvMOIEQQtFloAcCoWgL+OoKwnIA8NLBXtHRfRgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 05:10:36 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 05:10:36 +0000
Message-ID: <9ab0a2c2-7dee-40b0-edd0-56a5b1915745@amd.com>
Date:   Wed, 9 Feb 2022 10:40:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220208094334.16379-1-mgorman@techsingularity.net>
 <20220208094334.16379-3-mgorman@techsingularity.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220208094334.16379-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::9) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55b13c87-170d-480d-dd92-08d9eb8a8128
X-MS-TrafficTypeDiagnostic: MN2PR12MB4407:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB440794D34E6B16B28E4E34C2982E9@MN2PR12MB4407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3w+pnFR8sml3PtAFWFT0AaUnJdNks/ttmpXKypAEjhNd2HiDxNZzgwmC24K3+2sDzJnmCYbP/cLTbDHxOkWIPc8hqG36PPTwEZ5UZlhBOIGfM9FmYHotHpviGJeLQBoGvrdIl+/xh9PmxB+HhQ5PpZDke8nW5+58nKid2GMdDgkEgHJY58f8w8KeyuExXWkE31k2d28lDr+CHw4D9REy/tywg2gtv1s1S7cbJsONGYZobq9oXrwa23fpLar1TJDSuO6sLFyXz+VCQdwvYJK2DGbTEYg0YOEO4HvGVHrvXwt9qYEMgVIxMINg0SLqtDNU4GgNDk7d4NPRaYvB09Zq3vWkr6hN3QbISct4mdFxzDxfAkZYHoAbiTctk6cAUTjKxBDSBDRJEMvDAy77G74PEdeso/9KbkXaAUdYJaPOGlzfHrrPdhGJSiOBPdDDo5m/pwtn5sJteaN5C1wLL3FVMsPLKQF1v+sku6jJYXxDLkkcB8YWbpjeiCmb8IDgEGV1KnJYE9JWFjkNb0Zilv4GAWlIiVMBWvVkvct7WO5LOX5T01eGaWSfmXHIM9xKIpKuW24QNIggFAtwrx8gQ0eiJz6gUmrhKnF/ITAfDdesfZ1gDdWbMDnbM/F87lJ1+n8yGxJL9GTFF0Yn5eMa6QAVqSic8nqbXULwesJiGiLr87xD8alFbLOnVnmUD+wa56uy4HTDbo5dttrbgGhZsyNJfI+slhATSpD/i8q5/Fp4U8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(36756003)(6512007)(2616005)(54906003)(316002)(6666004)(6506007)(53546011)(6486002)(31686004)(6916009)(508600001)(8676002)(5660300002)(31696002)(86362001)(66476007)(66556008)(66946007)(186003)(26005)(4326008)(7416002)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFk5ZXJQTzVURTZ6blN3NFN6QTdwRW1rbDNHVVdOVndmTkx1VExXdlBPZXFC?=
 =?utf-8?B?czdsT3JzWFdpeTdWak5MKzJMZ0V0eFpLcGRLWnR4OHhaekpoMFd1RTlpR20v?=
 =?utf-8?B?OHplcFMrMHJ1T0x6MmdzOEI2L0pMR1p4UDd1Mjc5eGxUSU9xK2ZNTDA5Znkv?=
 =?utf-8?B?UEZPWWdMbkQzcGxQSXRkaVJjWGYxZlFWcUlqc1hGTkZPcXc5Uy8vaGo3TE5S?=
 =?utf-8?B?Wk1FcnhOUDg5S05reDNhWmovZUd3bVVCZWpDSm1JVWJzOGc3RGx6ckVHeHky?=
 =?utf-8?B?bXd0UUg1VHlham1TU3A4cGlyVlN1VjRuby9sV2Q4QlkwRGl0V2hPSWJISXZt?=
 =?utf-8?B?U3VDd1pRQ2g5dHdpS2lBRmFieWVKT01CYkhucTkxUVpVY2xHaFBSZ3Z2MFNS?=
 =?utf-8?B?VFQ0Vjg4bXRWR0w3VDhuNk5sbVpEbEIrcUVqTzlodTV2YVh0R1hVVlNJN0RJ?=
 =?utf-8?B?eUZOTFkwbG0zTEp5QWRINjByQWwrdDNPTkd1Q09wd2dTWGxsdERLL1hmN1NR?=
 =?utf-8?B?R1Z3MVJXQzRESUNCSm52cnV5ZFpMK0FsMm5KdDBYczVZZ1VZMVNrMW1veTNo?=
 =?utf-8?B?Z25aQjlsalEyeVVyZm95OThiM0EzempMOFQ5OU9sdjJ4NVVoQ2RFbzNNVzFk?=
 =?utf-8?B?MjZZeVZnc3VpcG56WG9YTjBJYnU0MnFoTk4ybEVnUDRXQXJncUxGaUV6YjNF?=
 =?utf-8?B?dWJ5S1FYNW9QdC9EMXNGV3JBR1c1UC9JeUU0SDFuVm1OVDZXZjZ0aUo3eEoy?=
 =?utf-8?B?ZlRYb1ozYjhhWHNLTzZrUy9MQnZGUzdhWElPN0JhUENFbkxpcmdNYVQ4MUN5?=
 =?utf-8?B?c3dTckJLcVdrejY3c3Qrak5zdFNvODFLNFhaU3FoRkJvc3dkNWlZWkcxYzha?=
 =?utf-8?B?VXA0TGFUOVZuaGtSV1pHbVI3MU5yUnJHeG1ZbXN1a1NaZHNTcFk5S3puaGZN?=
 =?utf-8?B?Nmtjc2FJSFBra014R2hsVHFpN0o2OUZRMnB0SmtwdmlQRUFiTWRSNm4zS2gy?=
 =?utf-8?B?OHJpQlcvNGltckhaaGRXVm9TZWMrU3c3OVFDQlZzcWJmNzh1MjhWUjNzMHFO?=
 =?utf-8?B?Znp2dDMwWElmUEg0R0QyVTJ0U1hod21NRGpaL1ByM3ZvS1huUG93VW02V0dG?=
 =?utf-8?B?TVh3eE1KWDhxTCtFeWppNTd0RzZtNlBiSnFzdVE1SFRJenJwWEFianlHdlc3?=
 =?utf-8?B?cDFKZGlXbmRFdkFEUTh1SFFDK3pHZXo0SzZUdW1zMkJaTjFMODE2UGFYSWdp?=
 =?utf-8?B?ZGRMRkRqOVpPTENFc0lRSThMSW81TXhFeHJZTjZwVEtoUlBIalB3M3lUZTY0?=
 =?utf-8?B?aFZWWlBvL3NKTWZiMlMwbnZVVE9jVG5aOTNpTWZ5MFpvU0ZHK1FIVHl6dXky?=
 =?utf-8?B?M2pySTNKdzFHcDJoZjRXdFBKbEw2ZzEvcFlBUU5xcUliRC9acnZ6VFFoM3d5?=
 =?utf-8?B?SDR6ZXlwMmxjckdlSFo4RlZoN2xtQzhhNmtrR0ZRaDVXcU9tTVVDeGkwWlIx?=
 =?utf-8?B?M2p5VDZSclJ6cncxdm42RC9PLytuUnJJTkY3ckhCMkdzOUVEbHNsbEFKaVRO?=
 =?utf-8?B?WEs2RlQ0Q21TczN1Ky95QmNVNTEzNVZaQm5vckxqUG9KWEwwYk82NWRQV3A1?=
 =?utf-8?B?T2pQdmg2UWgwcHppNnZIaEl5c2xmOVJaMlBoY2Q3Z1JpbWlqOTdnL2xGbDRM?=
 =?utf-8?B?ZFQrNWhRZDUxdlIxdk5WOE9JcWVaL3BNSSs4MGxQaE1TT0JDQUhBSjNaNDNh?=
 =?utf-8?B?UU9vZVdYRUlJK01aOFFWSWhrZ2loYXhoZkNPZFYyUTRTb29GeXVrRXhPM1Y0?=
 =?utf-8?B?UVNPV0tYMFE3NkVQUEV6cGg0bCtwZ1V5blpKdTRKSXZxZ0R3QkhJeEtQb003?=
 =?utf-8?B?NHNtb1B3T3kxUUhCcEh6VkdRMExrc3dDeEcyMWhMWlNyRmdZOVY2dlFiRWVH?=
 =?utf-8?B?bURMemk1bFpKa0pEQTBrQ1c4Z2VlVG4rWHJBMHdWeWZQNDdLaHpYeU5KeU5z?=
 =?utf-8?B?RElCZUpkbDlNKzhNMmQyMVJJMjFXb2hHUUcwS3RCUkltcmJhR3JoWlpNa2Ey?=
 =?utf-8?B?U2FsT0FzNzRtZ2cxYjhabDJoZXBaNHlNcjNIYktlRG9iL3RvVnpOWFc0T09x?=
 =?utf-8?B?VE8zZllwTUdIRWxPVjBPSFBmZkNYZkt6VThrOVNPdVd5MmFFSHF5QnU3MUwy?=
 =?utf-8?Q?qlJzFenodxCO2X0/c6WPPfc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b13c87-170d-480d-dd92-08d9eb8a8128
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:10:35.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnQDJakgeuCExc+ku1rQVNStIduKy7P/oE4mq3V16mXCGXgun2T+cSHsDNogZQDiX1s745Yr3ns65FfV3l5evA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

On 2/8/2022 3:13 PM, Mel Gorman wrote:
[..snip..]
> On a Zen3 machine running STREAM parallelised with OMP to have on instance
> per LLC the results and without binding, the results are
>
>                             5.17.0-rc0             5.17.0-rc0
>                                vanilla       sched-numaimb-v6
> MB/sec copy-16    162596.94 (   0.00%)   580559.74 ( 257.05%)
> MB/sec scale-16   136901.28 (   0.00%)   374450.52 ( 173.52%)
> MB/sec add-16     157300.70 (   0.00%)   564113.76 ( 258.62%)
> MB/sec triad-16   151446.88 (   0.00%)   564304.24 ( 272.61%)

I was able to test STREAM without binding on different
NPS configurations of two socket Zen3 machine.

The results look good:

sched-tip 	- 5.17.0-rc1 tip sched/core
mel-v6 		- 5.17.0-rc1 tip sched/core + this patch

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Stream with 16 threads.
built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=10
Zen3, 64C128T per socket, 2 sockets,
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NPS1

Test:                sched-tip                  mel-v6
 Copy:   114470.18 (0.00 pct)    152806.94 (33.49 pct)
Scale:   111575.12 (0.00 pct)    189784.57 (70.09 pct)
  Add:   125436.15 (0.00 pct)    213371.05 (70.10 pct)
Triad:   123068.86 (0.00 pct)    209809.11 (70.48 pct)

NPS2

Test:               sched-tip                   mel-v6
 Copy:   57936.28 (0.00 pct)     155038.70 (167.60 pct)
Scale:   55599.30 (0.00 pct)     192601.59 (246.41 pct)
  Add:   63096.96 (0.00 pct)     211462.58 (235.13 pct)
Triad:   61983.39 (0.00 pct)     208909.34 (237.04 pct)

NPS4

Test:               sched-tip                   mel-v6
 Copy:   43946.42 (0.00 pct)     119583.69 (172.11 pct)
Scale:   33750.96 (0.00 pct)     180130.83 (433.70 pct)
  Add:   39109.72 (0.00 pct)     170296.68 (335.43 pct)
Triad:   36598.88 (0.00 pct)     169953.47 (364.36 pct)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Stream with 16 threads.
built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=100
Zen3, 64C128T per socket, 2 sockets,
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NPS1

Test:               sched-tip                   mel-v6
 Copy:   132402.79 (0.00 pct)    225587.85 (70.37 pct)
Scale:   126923.02 (0.00 pct)    214363.58 (68.89 pct)
  Add:   145596.55 (0.00 pct)    260901.92 (79.19 pct)
Triad:   143092.91 (0.00 pct)    249081.79 (74.06 pct)

NPS 2

Test:               sched-tip                   mel-v6
 Copy:   107386.27 (0.00 pct)    227623.31 (111.96 pct)
Scale:   100941.44 (0.00 pct)    218116.63 (116.08 pct)
  Add:   115854.52 (0.00 pct)    272756.95 (135.43 pct)
Triad:   113369.96 (0.00 pct)    260235.32 (129.54 pct)

NPS4

Test:               sched-tip                   mel-v6
 Copy:   91083.07 (0.00 pct)     247163.90 (171.36 pct)
Scale:   90352.54 (0.00 pct)     223914.31 (147.82 pct)
  Add:   101973.98 (0.00 pct)    272842.42 (167.56 pct)
Triad:   99773.65 (0.00 pct)     258904.54 (159.49 pct)


There is a significant improvement throughout the board
with v6 outperforming tip/sched/core in every case!

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

--
Thanks and Regards
Prateek

