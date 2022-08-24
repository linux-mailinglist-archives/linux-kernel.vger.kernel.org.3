Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933D159FEEF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbiHXP60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiHXP6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:58:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81DF7CABC;
        Wed, 24 Aug 2022 08:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlLlCCJpDJp9GzF8zdoY5PNUsU5SGoYIn4a2ooIDfglIwySpRtk7K4gim6ZJijC99fl9HB0DLZnvAAaYbKtoU0uCtoUlNLBqHjYz6HY8OzIecgJF+5z0qcTt9IHdP1HmiuHentbMSkvZW6KnaLOX93npp7C5crZ4j3R8fv6cPrpynO2SVkrvXUPxFo6SQKc7Y/fM9qFc22SKZiWw0zXmIu6jBeJNUT/N2AzzblV67neOMfj2qqm+rmgkrwBC5k+hEzbsgD7jZIraXYn8Wf1iHyoGlmNJL70S/EnsmmtPY5PnJVCh8nFPj1XuIfLR4afWk04DJ/61UpX6g0aUk4gp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI1BCeUhb4Qr9i5VR33wemkxLPeKlckc5nNhBHe8BbQ=;
 b=Iiy90b+HfiEAGAFGwBhpX33l6xSylHU484DoIuce934XMSABkNYmo1cEHXTsB2ZI+oM8/Jb87ALU/BfGE72kYVVPxM7N/Z8ACUL2HH7drtLPN4NIJ1JcTBOP+wSqJdcvITpmuF6KrLKOG2In4mU0ST5URr9OUlwuNeKtq+0U1kkGyFRycBTZD9HXK8pEjjEe03ngDfm+u7yGITMteY/1dZgLaBLCSZolFoBHtZH0wbxqc9jZY8jm6nxZIgQwBGNNR3UaoUrcGwEvtktDc1dXRYzJiRDAlL5zqLHHU2upf/TK/TAg+uo9X8m4fspurX95wZ1eVNRqKz8UQ016NVACvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI1BCeUhb4Qr9i5VR33wemkxLPeKlckc5nNhBHe8BbQ=;
 b=Ob8hMxx5i5tj7u2unX3A0HBiZ3dQYvna92oOdZwmwjuUKfjA2g/Xjlsu9n28gjFx0P3EoJ1WfEpl+mDY6/3LB4c8Dabw/K5GzFbUyJltr1fGWFOkG1GdL+q06LwvPlN2t56kqnYjFYpxjC+0nSAJlyTwML2jffI/EOQH3GpYIYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR12MB1326.namprd12.prod.outlook.com (2603:10b6:300:10::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 15:58:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%7]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 15:58:20 +0000
Message-ID: <fcfd3c41-f462-94f3-dcfb-9298cd44b340@amd.com>
Date:   Wed, 24 Aug 2022 10:58:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 01/10] x86/resctrl: Fix min_cbm_bits for AMD
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117577023.6695.4825793379162387650.stgit@bmoger-ubuntu>
 <673b861a-5c87-e066-09cc-d17e2d16ef68@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <673b861a-5c87-e066-09cc-d17e2d16ef68@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0253.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 607c05d9-b0a2-4a3e-d4f1-08da85e9770a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1326:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqnqFM10exZebnzq9rcqtCGrj8z/a+3coWENlEFjP9+MfDUf49/Jukd9ifRF7PAGJB1BcfjVIpN+L/LeiV4rw/ZOAdLGnOgNfNd2mVfhnuBzpDlF6MrcVhwQvqAvVSIZAXWLHvqdNGGfpKlRCOJHreNODHhDiHp4rq31uBMP707sx5bURmo1kq5EEy1hGFjwcgGSy+kkMOCodfjtQLXK8FyIBrzB0K3EIVI01rAzYEbVze/Q1tinkhYWa0EU14qjEqm2Ox777B1sc0Na1LqNcR7nXkSPIg4Blx9CrNyE1SM5mwcLAoVMmmS1nJYtfqdmIIhtoeFMZ/ZqHVscnqK45hqvYDVw8N06bGis8InGX5Cymc96d6PClwvin9xxlzjyi2Mv6qRHsPb5a7N+9HpgE83IgLj+RYV8wkRTYu9vNMBiC+Qorl51dRQZJUH8J9RXdeuYhcTzfWWJrDfNHr2MJY7LYC+hrPUj9qI6LRCam2elyR45NPqfr8J04XdHYdI5VVyAea9+SrxW7/dDvbjc5YtUBA7v0PbzUxY2FhltJ10vPqL7voPmFqKUSOuPqqtXGfzpCLZHOhJAbWKggghcBdYhblfmmwL/Ybdnl2BmQNh/07KIBmwvz/jQkoSFv5zyOTrhXYTIVE3FmFjMVpk8LxTgpwc6UfLd3Xj3yaF069AWtnW0DmIVKW9j/CwpdhbRSfuqXAr0LWZfO+ecI/V+ijvqgGeDD30YQGCHdVzLvHeAYByMGpUD4/yfGWopr+c5qf5OCJfhe6R8qi4E+dEt8Rh8MqwFrNVXp2vQrOr19CJMN4+k7f1n3bq511/aw1YqfQNAPBsPoWPmrI414VUQXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(41300700001)(6512007)(6506007)(6666004)(26005)(53546011)(86362001)(36756003)(31696002)(31686004)(83380400001)(2616005)(186003)(478600001)(966005)(6486002)(66946007)(4326008)(8676002)(66476007)(66556008)(316002)(38100700002)(7416002)(5660300002)(8936002)(3450700001)(2906002)(45080400002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWpBeG5SczJ4WDdaWEt6MEdhdURRNmNTaVk3QzJlbFY5SUpacWtrVkc4UzFz?=
 =?utf-8?B?M2s0cUowTFU1NjlvNXZXNVB4TEMrSFlWaUIyQnVHejR2YkdEeGQ4Um1OaXJM?=
 =?utf-8?B?Q3pqcUhKdU8wUnFQb0RoaFNNc2FRMGVDdzI0WXMzRitTZ1d4M1poSy9LNnM2?=
 =?utf-8?B?RmNERk94ZUlpYWhpaStYeERHQVM3Q3ZVS0ZBR1IvNzZNNjAwU3pvQnY0VURR?=
 =?utf-8?B?cXdabHlYVythOE1VSDRJVG8xaGsyWWdXMGh4Mi9vMEVIMU90cVdmbzhLNy9F?=
 =?utf-8?B?aXVEZFQzVnVWVDJSRXJncURDS0ZXODRoa2dCN2RFOVhWcm54bVJQRW9HR1NZ?=
 =?utf-8?B?bEhnOC9vUU5ueERHelRvY1hnZCt1emsrMDd3YXB3ZHFUb1VST3dIR1BYRllP?=
 =?utf-8?B?UEcyNldJdlZhQjlOWUI4QW1HeTMyOTJVYXBqNHZONk4ycG1sWFFFVk9uSWI2?=
 =?utf-8?B?bEtyY2g4ZHNQU0ZsK1pXMElpVUZYUDcyS2ZVQ0NQSDlIQWNJUnVUUjlIc3Y2?=
 =?utf-8?B?YXNRRzFLQXRsclJMc2RZRWFiajQ0VjErYitta0JhVnhYSk5yamhwbEhiNmVJ?=
 =?utf-8?B?dmV3alFZRkg1SFhlNHhZTVNBak80L1ZjTlVSdmJCakVhc2V2K2N4Nk85MXlL?=
 =?utf-8?B?RHoyalh3VittY2VCMjlCazk2YlV1V1hkZlEwZ280TDVPNnFBQmFyblhNeUhM?=
 =?utf-8?B?bDJRelRYYTV6ZERYekRWaFBLSHlBUjRRNStINjlqMjhnRlh0NldBc3pCQW1N?=
 =?utf-8?B?bGk0V1dEUUhLMVdtdkpsdm41eThmWEpYUXJYa3RRNHgvNm8wR0xEWVRKb09v?=
 =?utf-8?B?RE9leWNOcEcxbmVWTU5ZZUxIRk9wT2tzdjljeHpnd3poRWU2UWVkdENCaWFF?=
 =?utf-8?B?cmFmMjFBL0tQUyt1Y1JjbjhVTTQvT1R3bFRiZzhHR3JlUE43OG1XTzQ5OHhF?=
 =?utf-8?B?U2xoOHRMNjU1NThKRitaRmFYUlVUaER4WmVtamo4MU5IZysxSlFPaEwwb2Z1?=
 =?utf-8?B?by83TjA1UHZEbWhCN0M1WVNYWjVaTU5XU0JBTG5Vbll6a3NGYU5iU1RoRTd6?=
 =?utf-8?B?cjk4VzliTndieVI2c1hqNE11ejVwVi8xcmVGSTE3RDlRcWwxbklUZUlnTlVB?=
 =?utf-8?B?MEJmelRTR3ZJTzE5dzluaEYvRmhWYzQ1TisyZzlrQjdUa1h1ZTR2UlAwWjli?=
 =?utf-8?B?MTY5aVNjNlRSKy9GUXBhOWEvd25SUk5NeSthRGpQVmNhWWhnd3phK2svUUl1?=
 =?utf-8?B?bTVIcXNlZCs0UUllOHRjakpLaCthRjArN3l6QVJmT3c3U3lhbnM5Mk00Q2I1?=
 =?utf-8?B?SWNXS1BUSHROVytEQjlzMHFyRG1DODEvNElDSjJFeU9yekQ3b25jaFRSMVR3?=
 =?utf-8?B?dmxVSDZ4SVRDeDhkMitLcEpVdzdxa1JlSXFCdUg1OVdIaFJKUXhyUGlnenIw?=
 =?utf-8?B?akdCMUFsWFhsN3dKcnMyYjhkSUhTdVd5eWJqWnI1aHdlWHpIOWx3d2xaZ2s1?=
 =?utf-8?B?cFNaOS9CMnMwSHBveFNGTS9RNXZoZkVxTEVJR1hSNVdkUDFmekRiU1NYUDBC?=
 =?utf-8?B?Mi90aWF4M3Q3bnB4VEExcEw0VXAyQlBpVVpzcVdxcnY3MTY0SGNHaGpzRlZS?=
 =?utf-8?B?TGpoeEdEcGZVYkE1TzJFaXo1akZUbG84aVlVOUF4S2lJWDVOc1NsZDNVeGRB?=
 =?utf-8?B?alBqS2hJKy83YzFpWjE3M3lrQWtiMnJLT2ZqTnlhRFNXWFpoL25yc1dJc0w2?=
 =?utf-8?B?Q205eEhzKzJFNDFCR0pKR0xsankwUWhCTlBqcHZBSnBSTUd5ZDNwUTlLWnZa?=
 =?utf-8?B?WE10eFdvekdLakU1Y1dXa2xLenFiMFpNd1BxaW5yRDgzeEVyN0FYTGpFcVl6?=
 =?utf-8?B?NHdoRjV4cER0SHdNMks5Sit6NVd4MllkUE53Yko4N2IrblBleVh1UmNxM2RQ?=
 =?utf-8?B?Q1kwR25zeHFrUWE1VkJGVnRVZmFCQTlnSXVIVzdYck1SN3E1UlNRVHhzVXVy?=
 =?utf-8?B?eWpHY3IrbmxKQk1yOU50UmY2VGV2SVk4blhkOHh5SzZGVXplWGpFOHBVR29M?=
 =?utf-8?B?NGlUNmtycUpiOTF1MG5YYncrMTNDM1FWOXc5ZmtuQXJQb2Z1VG1CZzJQSitm?=
 =?utf-8?Q?7w9A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607c05d9-b0a2-4a3e-d4f1-08da85e9770a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 15:58:20.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sp14Nvfs6Jahj1/eaRhIUjgoF9oOn+ccUO949qupSVTmwv/FTMc5n9TU8pAXHemc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1326
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/23/22 15:56, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/22/2022 6:42 AM, Babu Moger wrote:
>> AMD systems support zero CBM (capacity bit mask) for L3 allocation.
>> That is reflected in rdt_init_res_defs_amd() by:
>>
>> 	r->cache.arch_has_empty_bitmaps = true;
>>
>> However given the unified code in cbm_validate(), checking for:
>> 	val == 0 && !arch_has_empty_bitmaps
>>
>> is not enough because of another check in cbm_validate():
>>
>> 	if ((zero_bit - first_bit) < r->cache.min_cbm_bits)
>>
>> The default value of r->cache.min_cbm_bits = 1.
>>
>> Leading to:
>>
>> 	$ cd /sys/fs/resctrl
>> 	$ mkdir foo
>> 	$ cd foo
>> 	$ echo L3:0=0 > schemata
>>           -bash: echo: write error: Invalid argument
>> 	$ cat /sys/fs/resctrl/info/last_cmd_status
>> 	  Need at least 1 bits in the mask
>>
>> Fix the issue by initializing the min_cbm_bits to 0 for AMD. Also remove
>> the default setting of min_cbm_bits and initialize it separately.
>>
>> After the fix
>> 	$ cd /sys/fs/resctrl
>> 	$ mkdir foo
>> 	$ cd foo
>> 	$ echo L3:0=0 > schemata
>> 	$ cat /sys/fs/resctrl/info/last_cmd_status
>> 	  ok
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220517001234.3137157-1-eranian%40google.com%2F&amp;data=05%7C01%7Cbabu.moger%40amd.com%7Cd695c39eb7d94d659db008da8549ed74%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637968849807214070%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=prSwl8bTHx0y3o9hBNxp3u%2FNu8SrNcEWUwDOCQCVURk%3D&amp;reserved=0
>> Fixes: 316e7f901f5a ("x86/resctrl: Add struct rdt_cache::arch_has_{sparse, empty}_bitmaps")
>> Signed-off-by: Stephane Eranian <eranian@google.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Ingo Molnar <mingo@kernel.org>
>> ---
>>  arch/x86/kernel/cpu/resctrl/core.c |    8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index bb1c3f5f60c8..a5c51a14fbce 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -66,9 +66,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
>>  			.rid			= RDT_RESOURCE_L3,
>>  			.name			= "L3",
>>  			.cache_level		= 3,
>> -			.cache = {
>> -				.min_cbm_bits	= 1,
>> -			},
>>  			.domains		= domain_init(RDT_RESOURCE_L3),
>>  			.parse_ctrlval		= parse_cbm,
>>  			.format_str		= "%d=%0*x",
>> @@ -83,9 +80,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
>>  			.rid			= RDT_RESOURCE_L2,
>>  			.name			= "L2",
>>  			.cache_level		= 2,
>> -			.cache = {
>> -				.min_cbm_bits	= 1,
>> -			},
>>  			.domains		= domain_init(RDT_RESOURCE_L2),
>>  			.parse_ctrlval		= parse_cbm,
>>  			.format_str		= "%d=%0*x",
>> @@ -877,6 +871,7 @@ static __init void rdt_init_res_defs_intel(void)
>>  			r->cache.arch_has_sparse_bitmaps = false;
>>  			r->cache.arch_has_empty_bitmaps = false;
>>  			r->cache.arch_has_per_cpu_cfg = false;
>> +			r->cache.min_cbm_bits = 1;
>>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>>  			hw_res->msr_base = MSR_IA32_MBA_THRTL_BASE;
>>  			hw_res->msr_update = mba_wrmsr_intel;
>> @@ -897,6 +892,7 @@ static __init void rdt_init_res_defs_amd(void)
>>  			r->cache.arch_has_sparse_bitmaps = true;
>>  			r->cache.arch_has_empty_bitmaps = true;
>>  			r->cache.arch_has_per_cpu_cfg = true;
>> +			r->cache.min_cbm_bits = 0;
>>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>>  			hw_res->msr_update = mba_wrmsr_amd;
>>
>>
> Thank you for putting this together.
>
> This change makes arch_has_empty_bitmaps redundant. Can it be removed?

Hi Reinette,

Actually, I thought about that. Sure. We can remove it.

-- 
Thanks
Babu Moger

