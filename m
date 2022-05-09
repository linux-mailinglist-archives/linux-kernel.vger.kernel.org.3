Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9962051FDB5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiEINMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiEINMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:12:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6702A2F43;
        Mon,  9 May 2022 06:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpDKDQ90dG2N2e2aPh4OwqmhIJ6WdKThbU6XYTZPRTTQqGFBDD0nBPTBdT0WUF8lK0DzYlYtkZHSfOrFSOvwxtpOmaAMBsle1Vbt7Kkv2slaB8WDKS/Ssu+S552WWR3cuQoqGz6p8++bE7AIVUBEo1e1wGFCt1aoKA5u/Ag3SjsphT8HLt9A6CUN3rzkyS/XnCbx7+LUgt8TYkyPCwOAItVoSq7tWP/6/Y058DsVOddQUj41THgCpx2Rmh5SSurA9siXq0WfPynHG6q9FMVVX9jD+GqnAsrkKhpz5uPV7nX/q1j4H/K4kZcbn0ZwxCMvG77/h949OKZvexRtShZUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lavdKApkZ8q2tFopxbvJKi6VXohi/Tg0mFm882ldXGE=;
 b=gz8zB6J5xkRdPfUfj6TK+rSr/59WV8V7F3JZiomIQ+91OaoCSoXwhQoMTw3RJfqfpTEeriAP7aLaVsP0S+m+OV15pf+dCtnG7IrrBajGW0una/1TpjD0vWK4fALKjyrskrMccU2uHH0AQROI9I5zs24E89Ap00SnnylMhvuvw63AFUJCJ03tfj7oULG2b5E7irFhhc3xqwZG0/MDPefE/nmNay1xeszmkNglSXn3NYm70TpmgphBgm9TYSXmtz5okxg74w4unNup0mg7hzoL36K1WM+H98tu1dgKVFJS2GR0eJymbR8dXMPJXdyS6mi/y3srYIIlJEdaskMpB/c5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lavdKApkZ8q2tFopxbvJKi6VXohi/Tg0mFm882ldXGE=;
 b=mtXS3pNZfj93bWv7gqtYyimC920LJmgIYZ+IvobOlgw7sHxX6rnOLF1lslCFieAdzNVTgeMVI6cEHqILPHR7ou9pTqddet6jNj3uiY3u8vvaa/602SzmPsfqJTk6ygs4qSyC1CpXZSWKnV2FZecF0WijFV6Qt1AqcqunGfi40ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 13:08:35 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::8d3b:6561:8563:4f1b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::8d3b:6561:8563:4f1b%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 13:08:35 +0000
Message-ID: <96e41431-eb80-f61d-9ab9-c76cd9b6086a@amd.com>
Date:   Mon, 9 May 2022 18:38:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 3/7] perf/x86/amd/core: Detect PerfMonV2 support
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, eranian@google.com,
        puwen@hygon.cn, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org
References: <cover.1651058600.git.sandipan.das@amd.com>
 <8d3e23760726cf6647a98999e1fcd12a37f36a42.1651058600.git.sandipan.das@amd.com>
 <78e001bd-42bd-5481-5a19-1a0bcca9a63c@gmail.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <78e001bd-42bd-5481-5a19-1a0bcca9a63c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::12) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53dfc8a5-e2fc-4605-e437-08da31bd0621
X-MS-TrafficTypeDiagnostic: CH2PR12MB4166:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4166C17BF4530C49DB555B798BC69@CH2PR12MB4166.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a5r6Q9ppy6VX0TlktNSH8sK5iILmhoXftbotC0yKEClvgHvvC/U+o1GTb8Qnvag8hPOYRFPfjW8a7gFoNMvGdKwasJl7cyHSfJhoOMwdxPo7nqaF1VQt6QYh5palqzSyol8YLPUQBslQLwiRjMhZ8Cgpl0c8Gg0PTvOIASrWN0cSPy/8u8cRtatMzv7wwAr/5s86+z4XMYkNfDaJcMrSKiQwXJiTl4O7i4tianSXfJfxhbqtfkpp9K1qMSsjgy6mhCfhFWEsmKtCByHqNQUXt+2HzQM3BIU/F1IigFUCvqJ/9I+H17cCgpT2dUpF5IFWvoK3hJlV+a629SP2rdzkvmLPdN1EKW81qqNMsuTD0egMyhtjdJCUHm6mwALWZLbRgv4L8aGGZGh3Z8YNP78ZJjYcF1IPoVP997cFGFx86/NtvK48OAv1DO23OQuqVBbmdeDyt0Xkhwu2PWdzURM6YOyTXQYMdDqDO7fCd/skD0nBJ7w+NbJJSimGqbiA/JITSnWJgXhfoUPR2yTNCtTmoWO4uyzh2JRqbKkk0Q6MsSd2yacN4LaemKaHfvueoAqgr39XRycbVtPoBX+heDjT/0bBY7AuA62lApZjD7sCBZpUxgJ/knij03lR5Mev87n4KYJTjre7N0I2EfM0UFa6vCirDPh+Lljey21aPyIi92p/LZBKNIthag8VcGBcV1DeyH1Uk7xJrazE4dlqSAv5DAU4Z6bfcjvXaiL1G9mrYJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(5660300002)(7416002)(83380400001)(31696002)(2906002)(44832011)(4744005)(66556008)(66946007)(66476007)(4326008)(8676002)(38100700002)(316002)(31686004)(36756003)(8936002)(6486002)(186003)(508600001)(26005)(6916009)(6512007)(6666004)(53546011)(6506007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzdkR1VUUjdyZWxPVVF3SUNIUVdPTmcwNnRmMkF0RFNtdFFBNG8wMlU1RG9V?=
 =?utf-8?B?K29qY24xYXVwazd5RFBUU3lzRjJpQzhzSTR5djZuQlI0ZmhHYUFsSFNrWXJm?=
 =?utf-8?B?TDFFOFZiSlNzY0VKOEhjeFJDelZoZ2dHRmVJQmFhNy9PNm4yODFEa0hPN2t2?=
 =?utf-8?B?ZGx2MU1PWkFIWXBaeU9OZGFFZnpRaXptcDkwVTljRVRRc3A3Tm1xT1MvRndr?=
 =?utf-8?B?eC81U0hDRC9kZG1vKzZkclZ4dGlBYVpiMURteEVoYnQ5M2hyckFqMFZRYmN0?=
 =?utf-8?B?UFBiUHU3WjVXdDh4REpud3RGWHpTZzJLQUxuQ2hHdGZkNHBLVUZkOWlVaHZq?=
 =?utf-8?B?S2tXQitZNndQdTE5eC8xZFptamdXZ24rRlYyZzFIUnplVGJZbkhFUUFEcExh?=
 =?utf-8?B?d1Vmb3VCUXBsL015dThYOWdhMHEzWllUUGVDRFZoQXdCTkFvUmRoNHR3ZHE5?=
 =?utf-8?B?UGJPaWlHdmxHV1RINGNncWFXNWZXR0YrWUtUd2FsR0tWV2FYZTVTeTZDOTlT?=
 =?utf-8?B?UlJzT2xmbUxaUVlSWmoxYk9XRnFKdDVlSkR2S2U1bXJnaVFrRElYcXR6anM2?=
 =?utf-8?B?L2J1a005eUNUUTNqNWE5WHdYQW5SYjBmZkhKNHN3bmhtTVdLVU1JZW9FTG9C?=
 =?utf-8?B?T0Y4OW1hbWxJYnhVc3dLWTE2TnFST01FeFBzNlh0NWRvaVV1ZTN6eTMwQXJX?=
 =?utf-8?B?V0x3Nmt6YUFDSWdOMVNabnUyUW5wR1BMb25RSnlEU2Z2MUgzZFVsNnNkYXo2?=
 =?utf-8?B?NEpON2gyeVRIaERXWVp3R3dWUmdCbG52QUQ3akt6S0Erdm9QRlZlaWhWNklO?=
 =?utf-8?B?WDA1eG9ZTFAxWEczblJzVzh0U01YSDFTbGxSWk5vTE9QNWpZaWk0TkI0S3Y2?=
 =?utf-8?B?VEl1L0lOOVZTU2Q2ekZlMFFNOVZzdWtOaGhnS1J1aUJyQW9UR09NZXdndWZa?=
 =?utf-8?B?Z1ROMTYxN3AxVFVqaUVDM3RyRitOK3B2a01VQnF5RTA4Q3ZFbERYNVZwZytX?=
 =?utf-8?B?d01jMEhCN1ltZmIwVFF0TkZlcnlxTmdkVDlyZmo4UEQzNTduekgrMUppN1Vh?=
 =?utf-8?B?SGJXSWFBUnFKTGU0Y2RIQlNFWjN6VFAwN0ZEZnBrZkExVWNXYWpRd1V5NjR2?=
 =?utf-8?B?N0toa2dkZjZxMlZDTk0yWFVjWU03dTVOcXVBcVpYU25WUmRnZ2JacVpYeHQy?=
 =?utf-8?B?N01rNXQ3ZVN4YUpQYjRPSFVZVmN3TVdjcnZqdUIxZTIwUmExc0dWMkpuS2pq?=
 =?utf-8?B?YmFzVzVqSmVNS2h4WC9ZOXdRS1VBdllBRDlDWDlCV3FvMEVsMjlRR2ord3R5?=
 =?utf-8?B?K3pNMjhqendITzVPR2lRNTBGOC8rNGxhQXhYeW9sY05ha3ZLUlFSa01QY0hO?=
 =?utf-8?B?TjJjcklQWlBFUk0xRUJWVWVQV1lYNVIzbjBQR01tRTQ2VlM1OW1qYnZ1YkNC?=
 =?utf-8?B?dVlxbUZHbTR2NWNnbmZveXJHT0Nvc3c1OXltdzhrWk5pT0gzbloxeW5oVUxR?=
 =?utf-8?B?R2VxZjJMYVpMMkpnbWJ0bFk0eVZYOW9hQjNBV2dCNzVHcUFRZUx6ckRjMk5u?=
 =?utf-8?B?OWxvTmkvdkFVMDkxc2xadjI3QUJpZFVYODc5SDgyeWlGMDZmUit2ZEF2cVhj?=
 =?utf-8?B?cXhkVTRpWGpnb3g1d0FkK2dGZGV2amhHdzFmZ01zOCtwaWIrNnVVL3ZIUkpp?=
 =?utf-8?B?ZVVhdW5SaW91d2UyL0pMczJBSEc1M0hmNzQ0Umh0Wk5neDRsS3YveFc1UnBx?=
 =?utf-8?B?cjVFSEYyUXVKOFlPcWNLMnB4VlJNVUg0bHNEU1FUdzlOQUFmc05oUjZGd1Rx?=
 =?utf-8?B?M0sraU85NEgyelhFK3RONk83Q0F4MzlMY2E2MzloSGtBTzgySnN2N3luMlpk?=
 =?utf-8?B?c1BpRjN4ZEw4R1pCTzQ5SU9OVnFOR21SSjZISVBhTzhJRjFmNzdvQ0dPemVn?=
 =?utf-8?B?VXRpbXFNU3p5c3pDUnNzejBNNytORUJJaVpleXR0cVpiK3dMelZabS9EdktG?=
 =?utf-8?B?blBESVVtR1VRcnBzQTA0TFYrQWRYK2hsK1d4SXR3cHZGOVpVemhTaml2cFk2?=
 =?utf-8?B?SW1YOWRQN1FoUTVoZ3IyYWpIWGJmcG9ONEV4RXpIZjh4eDJoa1ZRdVVoTU15?=
 =?utf-8?B?RSs0RFZCWDgvTDQvdVZ5d3dSV1RhblYyTCsxaU5laVhzUW45bXFRejQ1VG1D?=
 =?utf-8?B?d2p1emVtZ2pneE9NbWYvU21JVm1HSjhmRUNxVWRSTERQWm5QcTBJY1ZTZ1BY?=
 =?utf-8?B?VnRUemkxSXdBQ0xOTFV3UHBnelZQcGVpaGZ0WlZpd2JRdkl2VEFXbFVCWFFW?=
 =?utf-8?B?c05GMmRLU21qaTFXaUxydXZUWUFUTnkycldTNklVSENBSmh5L2FRZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dfc8a5-e2fc-4605-e437-08da31bd0621
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 13:08:35.2510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqRkgKOS94Q0fXRtNniSnP2AvlRFhLWASLwPDB1KizAJ4ULt8gtL0CFf+DFyEYWpLSl4Wtwnoej8O9Il1OCySQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/9/2022 6:31 PM, Like Xu wrote:
> On 27/4/2022 7:31 pm, Sandipan Das wrote:
> 
>>       x86_pmu.num_counters    = AMD64_NUM_COUNTERS_CORE;
> 
> Thus boot_cpu_has(X86_FEATURE_PERFCTR_CORE) is true.
> 
>> +
>> +    /* Check for Performance Monitoring v2 support */
>> +    if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
>> +        /* Update PMU version for later usage */
>> +        x86_pmu.version = 2;
> 
> Is it safe to assume that once AMD CPU has the PERFMON_V2 (or further) bit,
> 
> it must also have the PERFCTR_CORE bit set ?
> 

Yes, always. There won't be a case where PERFCTR_CORE is absent
but PERFMON_V2 is present.

- Sandipan
