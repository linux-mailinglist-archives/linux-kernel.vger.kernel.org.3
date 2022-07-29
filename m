Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B960585184
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiG2OZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbiG2OZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:25:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBB61E3DA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUWtSVfSXZtO1W49QKinXMqG3If9lClf7Y++sNCe7tRdqlI0lpq6lObFPwZ1WaIZFL9CvWcICj6HfFz8OcYf3VrmDrPrLH5kYK1L6hD8xWZrAPX/3pTfQUXgFW/AdOqctmqMl4JMrQQLp/3FNYnjnGSrlKt5cmNpaA9JI0sgYHaIOfFU081afYyICCyyrTWsSVd7E0X5I6kISqhoYg/cuxmnpY1/zTr1Sj6QMN6k+vEFRt+IBWehdfeUcSv4kkSjmVAeHADzPp+CORLKfZQ70n4TQpTLagfD9K7DmRZ2P7aqkB41HrXbUCAJ34mF2DAfI1mpRkrMRMxiDxvMXYWuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IFHvv5auQtWOn7VRC+doZQqAMo/K6KjRA3RXlmXLqo=;
 b=m7Wm0TjPdfn0Dd+SJifA8Ucs3JKRIqx0hc4R8ywuabnVLXhdmYsHag0+yDhczsUG450W0IjnEjl8zEuEvgO9pAmD2jljkhuzvNMc2WXRizSxBWIurMvCzd8TeV9Qei2jz9k0i2gw7NS5b147QeDLkhTsHDyW6Dl3fqJgVKllWDID6xgZfO6wfqYN0qdfCK6yaPvfSaDauRdwiipJ2tM88QRfh9FBVetWKJpwR0d3AZrmYkVOrJwK0TTtTnF0b72QlTAZR3rdVNZwleYu665fCsHFDQBHi1wVm9EfwYFhvmQH/CUdIm8jlX8cx77V/VUXnhyxa2pGIoKnsRPerHwNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IFHvv5auQtWOn7VRC+doZQqAMo/K6KjRA3RXlmXLqo=;
 b=oWYlK8RLsOKN74zwGr91BAdCFqkKsCV32K5kR9MDrg5wB5TOjkVbao+E1ursQmI2aoim+FLhIPzJUdgGmXZsV/IGg0eFgVURLWBqlwJjVfyV7Uf68Fi209EZaaBwYs0I21Jj67DRSMMAjXMBSzy9l6f98wYOycVjAXGCmxjpYA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB3150.namprd12.prod.outlook.com (2603:10b6:208:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 14:25:23 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5482.012; Fri, 29 Jul 2022
 14:25:23 +0000
Message-ID: <9da5204f-5c8f-b47b-bcc6-d68ca63db08d@amd.com>
Date:   Fri, 29 Jul 2022 09:25:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/2] x86/sev: Use per-CPU PSC structure in prep for
 unaccepted memory support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659103274.git.thomas.lendacky@amd.com>
 <658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com>
 <d27e42a8-b2af-f922-4cea-b1ddaa2a0af0@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <d27e42a8-b2af-f922-4cea-b1ddaa2a0af0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:806:a7::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b31613f-71db-4bf1-2ea4-08da716e2c2e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3150:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZ2ygPpZIEpQmxQg/tfmU+A8+ikF2mbABI1TgoChp/gPh8PHs7CHigc16zRLiov3XrOzsGJVwQDweYyAms7zqzoSKBzbO9MTmvLEjoQoNgcsmTdt7eTeE/zyL916e7FW6PoLYYLiTYMPMLo7tLwQwJF0PiN1un/D1rzcBNjg6UBItYJWN7edg6gW3rsWtTXz+dlmuXuc/Aa69KCKzLT5EXxWD+R52otbT7TVJ6dGlWRdhvtUiaZw+aS7SVO8kADRZHNjogq1BVNmURReUc+7DqsHJIIraKJYnqQrkYl2yFk7B00GKuMnm8X0aNHt7dYeyREKS66+Gm3V3J08nll2nM1Z5p/VIqYrCOkuFRfQkeft+/AinrGRRf3ZynRMhOa+vfvmnpCQAF4tAmaxCsSqVEnK7k/X7duLVzK8BPg1O6DpjsqVjLnUEga762OD6X442MZpff/3Bh0SyJ9yWmL1Ff1KN5d6BecVK2sigHRd/6ZP3O0CdOZ4+q5fQ0isgvzlr0EACuIWav0v1E1pA1aTP78HwArLhJ0vCDkzIRSJozujG8t6Y4T7TD2s6EvyRJCWJJiXt64eV2szqEROW0KXtJN8OaBYuwNAB1Lubz1DqHYU7+PmDEoQ4/MvjZWQZ/rdfzbkLxou+480yHOyDShbKRTyIRdfN9BEdyjiUzaQcGXxU+2Cvv3u8lt7mcHRLJhlOACc00zIXnO/hdrlrt0d4cqDczgA/aJC4ARIr9vu4GzZz3KZI4jd35gSNOZwVv7LlAqenI3xhpUhULEOXNo1ct32JRt4FJ/CGqQfqQnwpQkwGLXdiqPyDJj86GoTq079tBounKcej+eG3dYNd+yyQrHezqTr3GNqPkMQoduWGErxboC4Ax+lvcVuPW70ErLj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(83380400001)(6512007)(26005)(6506007)(186003)(2616005)(38100700002)(53546011)(66556008)(36756003)(8676002)(4326008)(66946007)(2906002)(5660300002)(7416002)(8936002)(966005)(41300700001)(66476007)(478600001)(316002)(54906003)(31696002)(6486002)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFRPZC9ZNDVmNmZjNy9oUkQ2OFdTaEwrUzIxVHZMVGQ0YzFYTFV0WkxYdnhr?=
 =?utf-8?B?ZkZkQ3JtVzV1MnRocGVxQVZmMldmdWNmNllsQ0N4NC9QTERCb29ycHc0U2NC?=
 =?utf-8?B?V2ZjREp3bk0zRVI4NFlSdFpGUFhveGhCS2YzNSs5T3ZjOEJLV2RKMXJJdmoy?=
 =?utf-8?B?YUVzUGhKWWJkRFN5RGdyWjFTTko1Z0ErNmo2QkZ0blV4N3ppU0FtSXFyT3o1?=
 =?utf-8?B?Q2dFUUNnSXdnTWE4bndLS0xiU2QzbGZiRCttcWNEQk9VU3hTUFA2MlJPN2pJ?=
 =?utf-8?B?M0p1dnF2cWVpMTlueEJJK0hMRTM3VUxNbW9hajllNEZBRzE1dk5CQlJ4SFFM?=
 =?utf-8?B?S3JOcHphNkxsNVU4dmt6T0xZN0hjeTBRSGNZaWxXMWJDNnVQcW4zY3V5TTJK?=
 =?utf-8?B?TllwOVNubUVpYnV0N09JTTloa2RWNm9DaVZuTEdvVDd3K3prYUVPRHQ4a3NP?=
 =?utf-8?B?UEhuZU1xNlBKSEVRdGJYWHNmYngzK3VoTXBtL1h3TzZBU0ZkdVlJa2MrOUtv?=
 =?utf-8?B?T3hqcjNVMWVZKzVITHVoMnpGL2ZwOStKNllnSlJiQk1aY1Q5N1VJanJBOEoz?=
 =?utf-8?B?Qm1FNlN1ZzhpZjZmK2FMUi9NL1ZRNDlkN1ltRzluMUtaQUZ1ZE9tLytRTnJ3?=
 =?utf-8?B?bll5OTJYVUFvV3ZnZDhQRUs1VjNrOW1KdkRhcWNUaENwS0FSSmRmQ0x2RlRK?=
 =?utf-8?B?bzZNWHFYTzRad0RyY3JGaVJRVVFwczh5Wm1oeUdvbHl0MUxISzhPWjZiRGFF?=
 =?utf-8?B?UDBBNVJJVXdpZW9jTUtKYnJjU2FEUU5ncjRWb0F2VEVIMktBQ2FPTjROWTZR?=
 =?utf-8?B?UWVraFhKTThxVU1HSTRseUxIRXoxQUxkWXh4NGFIb1FMU3ZHUnFQUHlaaXBP?=
 =?utf-8?B?QkJPT1ZqOGFwbi9qbUtZODU5U0dGWFhRdlBBdkhFa2FyR3hldEhlbFQ5QTl0?=
 =?utf-8?B?V2hLRk9EN0V1b0JFMy9mTGtWMUdQS3N4ZmpPTEI4NFprTXJDUjgwaHdBSE1r?=
 =?utf-8?B?eUNTL0dVUVpSUmFPS25hZlFpRUFuNEJmMEdiaUpzZk5KbWpGWjFOTFZCUEFJ?=
 =?utf-8?B?Z01WVVk5ZmxiZ2FrTkxvMEEvNWVXQ0NBUkhvdDgrNlJmOTQwZElJOFRadi9B?=
 =?utf-8?B?dVNLdDRyVm44T2plN3lEbmhMeHp4S0dBRlhNV09KcUlWT1RxaFp3YnZUMnZk?=
 =?utf-8?B?UkdGNEpWcVBmQzdKWkQzVVJjNnBtRzdpK2FkaEZIdlVDVmhVWjgrdWNjYjBB?=
 =?utf-8?B?QUlVVitZNWdMK0J6NnU4cmt5YzZnNjk3VDkyS0FFeitBRTlqazBTbWw4Wnov?=
 =?utf-8?B?bHd0a29BTGxMRmpRa1pIMzFpdjVpZ3ducjJLbmNIMjNuRnM1Yy9JU1I5NGVS?=
 =?utf-8?B?YkY4YnExQTVFa3F3UVRiU1FlRDRxL1VLWFp4NVdHZnp0d09acmwza1IwM3RN?=
 =?utf-8?B?Nzd4ZWU2S0F0RGFMSFlYdDdsa25VMytoamYyUTNRRHh1VDJtNnRpWmRiMCti?=
 =?utf-8?B?aHlQdFVhVFdGNGo2alNhWGlNOGVUL0gyWWl6Z2JDMS8wMWRjL0lMa1BJR3VV?=
 =?utf-8?B?RnpGSEFyUXpkZEJCdzZUZFFKUFpEeXZyV2p2MXlaN0d3LzBFYlVtSEw5aWd4?=
 =?utf-8?B?Ulo5bEgxL0QvQmlrWGQ2K0huSzljeDZuZEZVUncvUkxpRGhJU0tvT044REZI?=
 =?utf-8?B?NjMzblhVMFo2dmx0WEdhNysxU2RRbjVaTmY4UXhHUFE5UWFLcStyZm9YVkxO?=
 =?utf-8?B?VXFYYzVBRlY5WThEaERBRllzVDg3dlJTSnJ1SWtKNE9FbkZML2R6dmxBM2do?=
 =?utf-8?B?YndoS0xmVjRmTWlzOTZIVHY4UVJLN3FzQnR4VXRyTjZnc0dEazFZR0FnL1U3?=
 =?utf-8?B?QWxZQ0N4RHZ1dmZCWUJwQ3g1dWFCbkozSUFkMXp0U1IwY3VieXM1L1kwYmJh?=
 =?utf-8?B?K1MvVGJBOXJEbk5zRTlod1dNWFBzZ1JSUzBBQTNyUW01TjVUby9oV09BanJF?=
 =?utf-8?B?UFM1bjZKNFBtZVVqbGkxSUd3K1NnZnZMOUVGai9LWTd4c25pMUNUQ0tFclJQ?=
 =?utf-8?B?V3VlUjQxTmZTSndtdUoycER6dUlnTG5rV1RNWEJUNDFCSWpkcUNESGVmeUN1?=
 =?utf-8?Q?66O5Pw59emMnwI7/WF4Ho1aAx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b31613f-71db-4bf1-2ea4-08da716e2c2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 14:25:22.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NJaJ/BGq9tLD9dikKOWVHlKy/KYDAU6IdTIICVsdhD19wRULKAcDmBzqhiPFf2yQyLF10BFsyZmFZscp+EUcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/22 09:18, Dave Hansen wrote:
> On 7/29/22 07:01, Tom Lendacky wrote:
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index c05f0124c410..1f7f6205c4f6 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -104,6 +104,15 @@ struct sev_es_runtime_data {
>>   	 * is currently unsupported in SEV-ES guests.
>>   	 */
>>   	unsigned long dr7;
>> +
>> +	/*
>> +	 * Page State Change structure for use when accepting memory or when
>> +	 * changing page state. Interrupts are disabled when using the structure
>> +	 * but an NMI could still be raised, so use a flag to indicate when the
>> +	 * structure is in use and use the MSR protocol in these cases.
>> +	 */
>> +	struct snp_psc_desc psc_desc;
>> +	bool psc_active;
>>   };
> 
> This thing:
> 
> struct snp_psc_desc {
>          struct psc_hdr hdr;
>          struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
> } __packed;
> 
> is 16k, right?  Being per-cpu, this might eat up a MB or two of memory
> on a big server?

It's just under 2K, 2,032 bytes.

> 
> Considering that runtime acceptance is already single-threaded[1] *and*
> there's a fallback method, why not just have a single copy of this
> guarded by a single lock?

This function is called for more than just memory acceptance. It's also 
called for any changes from or to private or shared, which isn't 
single-threaded.

Thanks,
Tom

> 
> 1.
> https://lore.kernel.org/all/20220614120231.48165-10-kirill.shutemov@linux.intel.com/
