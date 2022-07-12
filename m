Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395A15726F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbiGLUHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiGLUHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:07:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A24AB3D55
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:07:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2/idtXrt5DjnaOZcWuo22C7q7XGZZ0zwBaX7G19KJkrG8G2zAbxplmmw0T7VqhhVaZpFIA8PFaccoQYc2jQvzffkYQ8pChbA9cDRRWnyLre6v5A36zjB2emvCYb/jAfIo32HKLa5raNTBxmztMDpVpKgNnT3Kus34reH6aKpylTX4N87mvl8rj73THltP1CYlEQ/oGQcoskAwU+HTrbPlXMVnf1fnCFerJ/6LtLch8E8z3m6TGHd+kZsvZw6sF4X7SS1f3dJ39X+QcwM6aG39IAhw2Ec4XiLGLbSNpjVNtcN/iJ+vLlY50mV4w++Uu6Je8Zr9srCM/idKq/xYGGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFwQYtSK7YxW0oVlg5Kqjt0G0xCj9qV/45DmRSXjrSg=;
 b=jyr12IYDJ1hNf6KKsWq2zh6QvS8eNc0UkEaEUqDN4So3V05hho0r8lH0zeBqfCxT8EHmMcNx12ntB8IutfWhy655Fh1pvU8zBEbrz1MywF9dR5FQ0bw9A1Qve5Q9hJOdfA6l/EYZqtASNEQKFtJRSxWHhF3JACTvQWoet6yncSjgyBfjhya4AQiF1CwO0fNXEVvjzLOnsoC52bF2+D8Bcv92EPb2/siP9kQmXRH5ZbM5Dbpm9pbVsRHLzgALmSjxlY1y4dYq2kkxdcC8tGVqWrP2ECpwHKSlX5HLOpzx145nZ6oF49uahrCn66jO3UBc2II/9bZR4L51cjP+mFNvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFwQYtSK7YxW0oVlg5Kqjt0G0xCj9qV/45DmRSXjrSg=;
 b=tn3TePnwHhOQUf2W5OZiXVEuXd4Mppj7/2qQLwNF+cC1EaO+eeP67i68uZVmmmHX6kg2oH4Gv8xmLRR8ZXFuAr21ZiRA2piYmoV/rL0F3ZV6CNr4iBykd95BmFfBUqPEvEft3rxyVsuLmw1rxef5W3f1AOnsWAnRzE23KkmSY1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB3534.namprd12.prod.outlook.com (2603:10b6:208:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 20:07:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 20:07:18 +0000
Message-ID: <4c9e3a4c-40b2-3ce9-da88-ad507769658b@amd.com>
Date:   Tue, 12 Jul 2022 15:07:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [REGRESSION] amd-pstate doesn't work since v5.18.11
Content-Language: en-US
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Huang, Ray" <Ray.Huang@amd.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <3559249.JlDtxWtqDm@natalenko.name>
 <DM4PR12MB527879122FE84DCD355C33B59C869@DM4PR12MB5278.namprd12.prod.outlook.com>
 <MN0PR12MB6101ECFEFBBDBB65CA75F1C3E2869@MN0PR12MB6101.namprd12.prod.outlook.com>
 <2414945.NDPYyZybsh@natalenko.name>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <2414945.NDPYyZybsh@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0154.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b80c66e-5530-435f-5b52-08da64421f10
X-MS-TrafficTypeDiagnostic: MN2PR12MB3534:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j85S66Q0bGwvYsOAUcu6Nlu7qttzGdOMajCHPmvkSp8PVfv6HwRtQgMToamOY/ZkjLWOlfV29/GxQuqHw3JhrpoQOekT15+4rdVpRs8Cx2s/3AKYAei502Pzc3X+S5NQzar9Zm8sK4qZ5ycVpifi3zJkZHWkOVEgr44P7khfec9cxhEQYIb3i34eZqfBRbHWLIM4BhX6exN85Qbrvo3F3bjjrJTZ67OVXLvSSva6hYqOspXCRZfdg8rwL5i2TwrEhzoTYZN4vy74JCg8XZramyODsGavSy5V8KVBeYgwhaVKEXRizjl4IqjQpqYDUJSHUm9KGPe/A/nxyLJvltehqrAyNmQ0UPOJ+WZwSMpMbxESQlH1rLSo1RaX1rsSAQBpmSj01306FCTzcdR4JELcnmq2e7CS4OFONr+Xp28MpygpeluSEhvkTefe+WtL22QY3ZtU5pABdC2Zukrww1NuRwy7TdDFjCsvuTZ1AZNTX8GkMdELIihz47en/OyDJ7nbhgpUGJ5m2PRFyOeNcrkXYqAnStKOV2Nn9Y376w0meiEWpeRaNxiZPq0sr5Cg1etwiqn2Ny1QpnGOcloxOy0I2RKotxbu+HM6qssCpbqCatEPXI02lq0PeSi2ZMnrQf2qwSvvCJwx+lwFUjn3i1aJ0sC342gO4W3Ik05jNm8OwR3zYIU3gdQKYTHGymFz/LfBD+MHacZEZbEpegD8eRZqviYK8pLpY2KDcVBxNg1jyr3/vn2xAw0gluq7GFi2had/qGK38vo1y2JswaUK8lLpLqJXT3l9msVkBIKtyY2iDIJ1r9OA9rcimroNXNFHxmCvXXNsXa2Z8eI90qmoKBRwFQ5bIm11KBZkibxxYFIlqRZmlLjmTkliLqb+C1pNTo4hJYARJzkq72krZozDnHPdEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(186003)(31696002)(478600001)(66946007)(6666004)(4326008)(66574015)(53546011)(26005)(6512007)(41300700001)(6506007)(38100700002)(2616005)(83380400001)(66556008)(31686004)(8676002)(6636002)(2906002)(5660300002)(8936002)(6486002)(36756003)(316002)(45080400002)(110136005)(66476007)(86362001)(54906003)(45980500001)(43740500002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2NhY0xPSHcrRmlPdGJOb0c3M2F3WVNpL1pyRHBMVkhqME5wZHZqTmsxKzdk?=
 =?utf-8?B?Mzg2c21TYnk3bFA5R0Z1N1ptRlhJc0tMcFduSnBjMzVqZVFiRHZjdWpzTkdL?=
 =?utf-8?B?YnFRRHJBVndrVTJ0dXlXQ1ZJUCtQQ1JWeXZwdzRKLzUxZVZnUHkrWGV6a1ln?=
 =?utf-8?B?OXNiYUhHRWlSMkhpNXhBNE9kSFdTeTNWWFdIREo1dC9rVjU2ejVvZmZpOWw3?=
 =?utf-8?B?WUJFOGExWEUyb1hldTY2Y3lvSlBmYnZJREVNb2J4eFBPRlB3Mk1sWnl4VVEz?=
 =?utf-8?B?RWpWSkl1MCtyVmh6cHlDQUZMb1ZqQk1jSGx5dFp3MVRiWElOU2xCYUhGMitn?=
 =?utf-8?B?RVQ4QmZjSUZYWWhhRlpENDJBSnlWZVRQQ0FYTEF0bktTcy9wd2dGbjhML0Zy?=
 =?utf-8?B?U24rUEU4T3RkUDlUcnJCUzBJRm1tMnhqMUhudEtncS9JOGVNUFJZQ2k5Ull1?=
 =?utf-8?B?L3BwekdYZTNsK01lVFZmSGhzblBDZGxhd1R1S0VKWUZJalFXR3V0YlpvbGZ5?=
 =?utf-8?B?OUJYbUwvaW9yVnlzWTBOdCt4MngwWkdGTVVMYXhXaUdIUko3TUlJU2o4QUU0?=
 =?utf-8?B?VVNYODZOTG9GelpWTTN5NGVJeldIem5UVDZwQ3FPTXRvd1A2V0RXcWpmdTJ5?=
 =?utf-8?B?NWFlTGRQa0tpb0VHNzA5cW9hOUVVak9ZSDVSam4xa0FSek91cHJVenpJUkd0?=
 =?utf-8?B?dmVtUiszMGkxa2x3cEJrZzVGK0dOMGlIaWJWV0tUV00vYjhoWEZFWmd2YTg3?=
 =?utf-8?B?L1N4SEROb2plNzkzMXdtSVpFK2l4Vkl0bkYvUkRGYWZUQUt3KzUvVy91NzRy?=
 =?utf-8?B?RHNCNlVYck91enFVTmxBMWV5ajlQY1Y5RWI1VG9XSmRoSlVWSUlNaVFTMC90?=
 =?utf-8?B?RitQbWVQQjNRa0dwSDVlaExXc0lUWWQvbjJKTEIyNEt1Z0wrYXEyNmYvc3RC?=
 =?utf-8?B?ZEVYbE9zV3dzL3piN0labkVpZTlvbE9CdFhqSkRtNWt2NkU2TkppOEU5Njdz?=
 =?utf-8?B?MVYrU1F5Si9BVXpGVWdOZWFha3ZoZ0lINVBoNWpzeTFacEJVYW9hWkhoVURK?=
 =?utf-8?B?a0E2Q1JnTHArOEEyV2RrUEtWK1B1b3NGbmJZTi9KT3lwcG9EUTVIRFJ0WGpU?=
 =?utf-8?B?QWdPek1WSWxPSGthdUIyazZUTDkybS95KzRseDRreURjZ0c5MmgreDNxSHFh?=
 =?utf-8?B?R0k2TUJqMTFiQjk3VzczVDJBY0xQMVU5VTNKY0g5Yk9ZUVpZYkhJZzR5L0RP?=
 =?utf-8?B?ZER4SjVxWXRlU25ncVRYV0t5UFZKY21oN1o2QTVyeGRXbXozTnRjUlhjTUhq?=
 =?utf-8?B?Uy84c3hrdndxVVBLL2IrL2VvZG1JUzE2OEMyNjNDY0VGOFl1QUhiZXEyWk1J?=
 =?utf-8?B?cGRjblFpZTlhazlZV1ZNQ2s5T3BjMndueXNsUkJXNjVrWjRyeW1EcW50UjJC?=
 =?utf-8?B?QzNReVRBam1VRlcvb1h4VDlETzZQbmZiUlhxRVduODIzbTU1RDFxMWtmVWp5?=
 =?utf-8?B?MmNtWFFMRTUzdjRtK0EzOHNCU3VVNDF5RFVCQVUzdVUvUW02Z3VTSndoQkl4?=
 =?utf-8?B?MlJyMUoxUkdjM3c3V0RUTmJ2K2twZlpFQXJhUjQzYmd6dHEyaXcvaVE2SDNQ?=
 =?utf-8?B?dHU3U2lKdHZHeXF5QW5tZEN6Q0N5WnQ2Sjg5TGVtUWgwU0VKeldTS2FiYlFw?=
 =?utf-8?B?MHI4WlllM2NrSk50MzgwVmpTNkR0Y2dMcDBMMjZBaEtvSXNOUzJSZEQ4cXRU?=
 =?utf-8?B?MXh3cXU3ZWxaYW04R2hlZW9tcXhwYmpmSkFtT0dQeDRPM1BrUzFTYkV0MVh2?=
 =?utf-8?B?SHdsbHd0blMwVllyT3BBcGJjemNXelM2Y21MWllYYVdFVXpxTHpIUm5aRUw2?=
 =?utf-8?B?ZWQ3cVl0aVRHT25uZ3E2MmNJZDhBQ2RoNjNoNFhPZ2M0MmNhZDlwcDEyMVAv?=
 =?utf-8?B?QjRpRDUwalJYeHVjRit1WE1ldjBBdmZFcW5jSFFHYXdHYzkxaWlVSmtDa1dn?=
 =?utf-8?B?RjU2a3hhR1d1SHREcndxWmpJNnFmN0lsNXJpdFV5OGdrMFlhUWp4R2J2S2sv?=
 =?utf-8?B?cWNHY240alFwN2JjNzhQaUJXbHdPMnE5SmlOY3JYeEJoY1JxQURjMnZUTXpU?=
 =?utf-8?Q?7tQLgpjZVr3vkH7zWBihidURr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b80c66e-5530-435f-5b52-08da64421f10
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 20:07:18.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9EbZ9S8XCaSJvoO/YTefChfvQhJy8Pdb66hXwSeEehPKP+YZsSziHQ5H2hDIqYwWsmGP9+SYjyj4Bp5UW+qvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3534
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/2022 12:54, Oleksandr Natalenko wrote:
> Hello.
> 
> On úterý 12. července 2022 19:50:33 CEST Limonciello, Mario wrote:
>> [Public]
>>
>> + Ray
>>
>>> -----Original Message-----
>>> From: Yuan, Perry <Perry.Yuan@amd.com>
>>> Sent: Tuesday, July 12, 2022 12:50
>>> To: Oleksandr Natalenko <oleksandr@natalenko.name>; Limonciello, Mario
>>> <Mario.Limonciello@amd.com>; linux-kernel@vger.kernel.org
>>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>; Sasha Levin
>>> <sashal@kernel.org>; x86@kernel.org; H. Peter Anvin <hpa@zytor.com>;
>>> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Subject: RE: [REGRESSION] amd-pstate doesn't work since v5.18.11
>>>
>>> [AMD Official Use Only - General]
>>>
>>> Hi Oleksandr:
>>>
>>>> -----Original Message-----
>>>> From: Oleksandr Natalenko <oleksandr@natalenko.name>
>>>> Sent: Wednesday, July 13, 2022 1:40 AM
>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; linux-
>>>> kernel@vger.kernel.org
>>>> Cc: Yuan, Perry <Perry.Yuan@amd.com>; Rafael J. Wysocki
>>>> <rafael.j.wysocki@intel.com>; Sasha Levin <sashal@kernel.org>;
>>>> x86@kernel.org; H. Peter Anvin <hpa@zytor.com>; Greg Kroah-Hartman
>>>> <gregkh@linuxfoundation.org>
>>>> Subject: [REGRESSION] amd-pstate doesn't work since v5.18.11
>>>>
>>>> [CAUTION: External Email]
>>>>
>>>> Hello Mario.
>>>>
>>>> The following commits were pulled into v5.18.11:
>>>>
>>>> ```
>>>> $ git log --oneline --no-merges v5.18.10..v5.18.11 | grep ACPI
>>>> 2783414e6ef7 ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
>>>> supported
>>>> 3068cfeca3b5 ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked
>>>> 8beb71759cc8 ACPI: bus: Set CPPC _OSC bits for all and when CPPC_LIB is
>>>> supported
>>>> 13bb696dd2f3 ACPI: CPPC: Check _OSC for flexible address space ```
>>>>
>>>> and now this happens:
>>>>
>>>> ```
>>>> $ sudo modprobe amd-pstate shared_mem=1
>>>> modprobe: ERROR: could not insert 'amd_pstate': No such device ```
>>>>
>>>> With v5.18.10 this worked just fine.
>>>>
>>>> In your upstream commit 8b356e536e69f3a4d6778ae9f0858a1beadabb1f
>>>> you write:
>>>>
>>>> ```
>>>> If there is additional breakage on the shared memory designs also missing
>>>> this _OSC, additional follow up changes may be needed.
>>>> ```
>>>>
>>>> So the question is what else should be pulled into the stable tree to
>>>> unbreak amd-pstate?
>>>>
>>>> Thanks.
>>>>
>>>> --
>>>> Oleksandr Natalenko (post-factum)
>>>>
>>>
>>> Could you share the lscpu output ?
> 
> Here's my `lscpu`:
> 
> ```
> Architecture:                    x86_64
> CPU op-mode(s):                  32-bit, 64-bit
> Address sizes:                   43 bits physical, 48 bits virtual
> Byte Order:                      Little Endian
> CPU(s):                          24
> On-line CPU(s) list:             0-23
> Vendor ID:                       AuthenticAMD
> Model name:                      AMD Ryzen 9 3900XT 12-Core Processor
> CPU family:                      23
> Model:                           113
> Thread(s) per core:              2
> Core(s) per socket:              12
> Socket(s):                       1
> Stepping:                        0
> Frequency boost:                 enabled
> CPU(s) scaling MHz:              59%
> CPU max MHz:                     3800,0000
> CPU min MHz:                     2200,0000
> BogoMIPS:                        7589.71
> Flags:                           fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sev sev_es
> Virtualization:                  AMD-V
> L1d cache:                       384 KiB (12 instances)
> L1i cache:                       384 KiB (12 instances)
> L2 cache:                        6 MiB (12 instances)
> L3 cache:                        64 MiB (4 instances)
> NUMA node(s):                    1
> NUMA node0 CPU(s):               0-23
> Vulnerability Itlb multihit:     Not affected
> Vulnerability L1tf:              Not affected
> Vulnerability Mds:               Not affected
> Vulnerability Meltdown:          Not affected
> Vulnerability Mmio stale data:   Not affected
> Vulnerability Spec store bypass: Mitigation; Speculative Store Bypass disabled via prctl
> Vulnerability Spectre v1:        Mitigation; usercopy/swapgs barriers and __user pointer sanitization
> Vulnerability Spectre v2:        Mitigation; Retpolines, IBPB conditional, STIBP conditional, RSB filling
> Vulnerability Srbds:             Not affected
> Vulnerability Tsx async abort:   Not affected
> 
> ```
> 
>>> Perry.
>>
>> Thanks this is the sort of thing I was worried might happen as a result of requiring
>> the _OSC.  It was introduced as part of that commit 8beb71759cc8.
>>
>> To solve it I think we need to add more things to cpc_supported_by_cpu
>> (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Ftorvalds%2Flinux%2Fblob%2F525496a030de4ae64bb9e1d6bfc88eec6f5fe6e2%2Farch%2Fx86%2Fkernel%2Facpi%2Fcppc.c%23L19&amp;data=05%7C01%7CMario.Limonciello%40amd.com%7C96addaab0edc4e22779908da642f84ac%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637932453099304670%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=4KHD3UUlfDJEmpTpqDCmuV1x%2F7nj%2F0iuhwdnhJqtQeU%3D&amp;reserved=0)
>>
>> The question is how do we safely detect the shared memory designs?
>> These are a fixed quantity as newer designs /should/ be using the MSR.
>>
>> I am tending to thing that unfortunately we need to have an allow-list of shared
>> memory design here unless someone has other ideas.
> 
> Happy to test any patches as needed.
> 

See if this helps out:

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 734b96454896..88a81e6b9228 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -16,6 +16,13 @@ bool cpc_supported_by_cpu(void)
         switch (boot_cpu_data.x86_vendor) {
         case X86_VENDOR_AMD:
         case X86_VENDOR_HYGON:
+               if (boot_cpu_data.x86 == 0x19 &&
+                   ((boot_cpu_data.x86_model >= 0x00 && 
boot_cpu_data.x86_model <= 0x0f) ||
+                   (boot_cpu_data.x86_model >= 0x20 && 
boot_cpu_data.x86_model <= 0x2f)))
+                       return true;
+               else if (boot_cpu_data.x86 == 0x17 &&
+                        boot_cpu_data.x86_model >= 0x70 && 
boot_cpu_data.x86_model <= 0x7f)
+                       return true;
                 return boot_cpu_has(X86_FEATURE_CPPC);
         }
         return false;

If that works and no one has a better idea how to do it for these 
systems I'll send out a proper proper patch tomorrow.
