Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3754F5B08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349728AbiDFJcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351966AbiDFJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:25:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EFA57153
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9OZQVwmIScWo9VtJcyBWgiI/UhfFVIVgq4NyOIhZHYpBBkiQ8hG9ofYgpJIWpnzEDfbXGvn6OOwl5qd8HfslfMBS01vcffuTNDy3sQZIHOETAr6VbPWPcpDFL2qqwKv4MROWEgFl7cqEbKkX87ICk4qKeObtdOH36RykYCiasZpEXQBOiLbTE+fbnsFB58fh9xZzdutLin8w6dLRc2Uh92XmaYkRRP76tJtYgipUHhuTP1nV1M57cbu+JmB0EKUZIwmTpxgoJYhuyuMF1F60XdRxM4f1wQkO0/ztvs0lmmKpLvhhVsgJa8H6OxGI0wlmAegWKGDWno2IzupZLFCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd4dt+gUY1W1mUAZpUeYCL3LMRBYjjdch4+5qrOqEpc=;
 b=Lsd1dTFwecr3BWc7q/SW53GMmhal932QT9T53iumCIr2fu0hxC31dU28yqbQH5CrW/5z81jMwNHjKK8M+KUhz8JeqFVXgVXtDZ00U3emaqNuXSZugRcIvHgZ06DQ1jxhVwx5hSYjCjXkfNS5hVtwgB8+8FtwC1PXXKQ/cm4CNfCF1haSAJdDh/WLhOdbWkZzFuMEt1a8gN2HMJ5FSwXjJmc/QTJGMNhLpHCTGcqK4ynqhlIyJs/NBPRbwMt6Nv1qHGOS/s5fMB6l1RymJG7QSxYVPpEhMoOrkv2B1Kj4oPrdcTB59rZt2R9pdhycdiXaIfEYpAhTxoILjVN0DK3plw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd4dt+gUY1W1mUAZpUeYCL3LMRBYjjdch4+5qrOqEpc=;
 b=uRHmrp3iEmg5FYuqawiJeUExFCsp0dyFuwcH6mtzNBmfwdTQFp09BIsZ/0qzQPT7amrf+cysmkK6aWIMXgWGlVjdd9xpTfhQ1oH9dOIuHmPF8yeaKHNPLZj2A1Bysti6nRHQwQ5dhEApNOVuQR/sQUNZw186MwbPibUWSlh/MEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 06:15:07 +0000
Received: from DM6PR12MB3369.namprd12.prod.outlook.com
 ([fe80::f02a:8f85:a63f:5c0b]) by DM6PR12MB3369.namprd12.prod.outlook.com
 ([fe80::f02a:8f85:a63f:5c0b%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 06:15:07 +0000
Message-ID: <c6ceb0a5-c3fa-790e-d3c7-228c71a477c2@amd.com>
Date:   Wed, 6 Apr 2022 11:44:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Lewis.Carroll@amd.com,
        Mario.Limonciello@amd.com, gautham.shenoy@amd.com,
        Ananth.Narayan@amd.com, bharata@amd.com, len.brown@intel.com,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        chang.seok.bae@intel.com, keescook@chromium.org, metze@samba.org,
        zhengqi.arch@bytedance.com, mark.rutland@arm.com
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxMtx9zdk+nH33r@zn.tnic>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <YkxMtx9zdk+nH33r@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c822e965-0c39-435a-9a85-08da1794cb64
X-MS-TrafficTypeDiagnostic: PH7PR12MB5926:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB59267F2FA0A247E756E633E484E79@PH7PR12MB5926.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7Ul8mntDdmIR1Az0w35mF4QSxbs2KwWkv1jDvJ4gdulYBMODf30hIGeSoIf1tsqj1+9EuvLkFB4yvATYmTIghdSeO+feoe9IXN3+V4y+/535X/OKQfxRJG2LkJzj5oFqNw7CxUEVn/xrBpXnfZgiYy8he/6udivm/APnBy0jTWtSz1Kuc1sJxTj7fP0DjmmtmMBmmd16Pe1/Hnxg6NwQdPWfbm3MLCCwOV3Lkd602Lrn0lch8bzQFQXe8uedAggW2mwTsNz4TK4tGOa0iDu0q/NIt8OgPzyAM+iUIBdkYabxMRCfVoCkFYDysYAi274PqtdoIXo0JVwOkRzsGmuY1PzZG44UMnHhtjSQUixr//aC1V46IEbALIs2saJkwOKQjK/+ju1tvT2/uXoJXjvd/itNReaKpgwNvH6wcMkKNPpGtWOE8dt1NUFsMq6uhtgLWGkG7f2mtrIKp9owVi03zpkCxpyiv2UoIIIz/VmqD9G9Ht9BpSUYTPHqQrlYgOYx9sUK9RvNySZkcd0vn/T1oJ8D+ET1CczGeceHvinV2pKfEBJIwUUABvElCpk4/1P4p0gHCnMzH4qMiOxMRR6VfxYHyw/O49q8dR2ypwW74XaQBZ0J/KDvOxCnPZt49J1CxnYFoit8KUQ8kygMjWSSCwZo8sF+OeKOS3q8EwR9wrFeJrcOoG+iQJtR4Z9aMI3UKIrr7WMagoe+gJ4dv7rOgCRjQD7WJS1L4peiQ5CcxWHTkQQPwUcihqmNeR51x1g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6666004)(36756003)(6916009)(6486002)(53546011)(5660300002)(4326008)(83380400001)(86362001)(2906002)(8936002)(44832011)(38100700002)(31686004)(6512007)(508600001)(26005)(186003)(316002)(66946007)(31696002)(66476007)(8676002)(66556008)(7416002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHRkTzBZb2x0VmtkZlcwRUx1bmwxY1E4Yy9KYllNTTJ6UW41Y1l3RlNHT0t4?=
 =?utf-8?B?ZzlEMnZWeFR6OG5HbWdNbm56M3ZhUmRWVXRZN1BiOWIrL2R6ckp4NE9RTkZ0?=
 =?utf-8?B?SlE0T1hBTWN2aS80Y3M0NkpDSG10NzNCNTNVNTYxcUsraGFKb2Vwb2xRMlhO?=
 =?utf-8?B?Qlp3WGdqa3laRXNUekpqUWRydEtVUE9YeHk2b0hpOW5WUWxqbDB3M2ludWRG?=
 =?utf-8?B?aDEyN1lPOS9zQW9NRUVtOEtwSGtQY1NQcHViOXJwMlJtRkZLaWRPOGtBcHkr?=
 =?utf-8?B?OW5FemFtTkU3aXR1cHY0RDNQRUsrOHBpaFNIaWh3RTZvMloxVzNzNVBDT0NM?=
 =?utf-8?B?dTFPMW5QYjAyR1dNaFZBUVVDMnVZREp5M0RUck5JRmUwNWFLSXpBelNYeEpV?=
 =?utf-8?B?U0hWN0RwRkp4V29BNWxWVlk2ZjEwRTE1bmJRK2FKU1o4NVZxWStNamI3OXIv?=
 =?utf-8?B?bURWK25vRXE3Q3dXajFyL1ozcHBIbjJ0b2x0Y1d6Tllvd2prdWxrRkVOMktF?=
 =?utf-8?B?Yk5FeWROblBpNi91MGhCTGVLMDkwQmJyMnp2cDJsN2tSbko1RmZ3ZXZoYkV6?=
 =?utf-8?B?Y0Uxd2J2K3JiR1dzQ3FoNTBvc0dibUZTdlJndzhBNTJISWNmTy9hb1dsa3E5?=
 =?utf-8?B?MHdPN1Y3c25za1AyaytXcWw4eTZndjEzcDlDdmNIQjU2SDhVWUNTek1nTGVh?=
 =?utf-8?B?dWxwenhYeFNPOWF3NVhtMVRLWmNVZm1qWm9oTldzL3c4cjJEcjRHK0lZa3F4?=
 =?utf-8?B?clJQMUhmazcrOHU2YlNvMVhYS29obzdrVXhjMmlHOURha3Y1bDFOUUpPUFNy?=
 =?utf-8?B?OVVrUWo1OW5OWXcrYjdQU3VDazl5LzRualVvSWlndEY2K0k1YTBUQjBhTGNu?=
 =?utf-8?B?TVY1UGpwU1UzcFRqdkk4TU01SXJZZFBZai9Jamg5aDFBeFg0cEFCVy9UUFYy?=
 =?utf-8?B?bVlxOExtdVU5dk1pdW9Pell2WEp3VzdiQVc4T2t6NVhpUDNrdjBES1lTQkFz?=
 =?utf-8?B?OVkxRWJMZ1A4amdrMzc5WWwwOENOZHRsbUh3YzJ4aUkzNmd6V3krNU5rSUs3?=
 =?utf-8?B?NVRMN1d3eDNnTUpjMGczTzdobTlkL0hVcG1KUjllc1VhbDBsN2l5NitidVo1?=
 =?utf-8?B?a0hucm5ZUVNFMUFjYUZBUFl1SnNtN2Fyb0tLQ3FUaC9nUjl0R2FHcDJwaFVy?=
 =?utf-8?B?TU5qY3hkNHE1eUpIdVZlMGR2WHk1UXFnUHhTaFpVMG9pOXpvTkFadHpBRXZS?=
 =?utf-8?B?RndsdnZHaEtDOEsrRDBHMHJ0dUtHL3BVa1NQUEE4QlJ1OFdieE9xR3lZeGRP?=
 =?utf-8?B?UHhSdktvcTl5UGpDL004emg5TEdQcnZNVmNjNHdnRXYzTFJQTE00R3haYitm?=
 =?utf-8?B?VXNwVkltaSthTXkxSEkvWUVPcHR1NDRoY1E1cCtraXR0VzJ0VUFSS2t1NEJo?=
 =?utf-8?B?Mi9td2Fza0VZaS9QM1BNR2ZPVW5OL2NWOXVaQ3VkMlRUUWthQ2dCSG5RSDFl?=
 =?utf-8?B?SUZIbllZSkJqOGM4SUU0UGh1OWhWTXBqdFY1QkF4dk1jbEJoMnFWcjRFSmpK?=
 =?utf-8?B?N1lTWXB5VzhIdE9URlQ2eDFaY3gzMXBTeXFIKytUZXYybWFwbUNVUm95SzMz?=
 =?utf-8?B?Z2l4Y1hqVnljUlVlNEFXQUVXd0N0aU9OckE0QTg5N0UvY3l3ZitjenBWWVhq?=
 =?utf-8?B?UkljbWpWKzNkc2hsbUVlQTNrY2R3djA5QkcrWEIwcklhT095Zktic25WaXZk?=
 =?utf-8?B?QUp4V21GWXQyMjFWTjQ4Y0ZEWWx3Vk1aZUl4a252WmgzSHZTSHd6UGt5MXFx?=
 =?utf-8?B?K2NvdC92dFRnMFBJY2wzZndpVXZLV2ljSjRVbDNtczh6UWtMMFlrUlJJd1p4?=
 =?utf-8?B?bzdGSGhQTVRNd0NNb1cra2ZWVXpWK1FGQzFMY1JJUWx6YzJRaEJyVTlYRllU?=
 =?utf-8?B?WXhkVTd5SitLOGZYZVZsZWp1QUllSGZwNGdxSU9NNFNVV3loZlRRRFBJQXk1?=
 =?utf-8?B?dkU2UXU3ZFg4LzdYY1daSTlhWHZKeWFWUTN1VEtZSG9XQU1kUzFGdXRCbFkx?=
 =?utf-8?B?QVNCVWNsWDZjU24zeDNhOFl3dTJ4M1FJbmFXeDFvb0w5TDZQQ3RQZFh0dWpi?=
 =?utf-8?B?VTRocCsxMm9XLytjeUNXakp5cUFaZWtZNW1GdmM5bEdoRlB4QjhaUFlNQ2RC?=
 =?utf-8?B?eDRZTzJ4MmZMZ3RWT2swSkRJUlhMKzFqYU9sM29jQ2QxREFUeCt2TGJkaHk2?=
 =?utf-8?B?c2twbFFHSkljMVVubDZ3SlVGVmpjK0Y3aEY3b1dOdzh6eVBYbjJ0TktuWlVX?=
 =?utf-8?B?M0pWdktOVG02ckVNNmQvblNvMWtMT3J5anhMWlVoRjlaeGl1U0U4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c822e965-0c39-435a-9a85-08da1794cb64
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 06:15:06.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZLtxibFa0A7luUYGSg8wzHPAZ1P9zzbD/4Le2DfA2It/etTdAMK+EHm5vpPwGj0VfkDN03CSI8GjDFBJBqOvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/2022 7:35 PM, Borislav Petkov wrote:
> On Tue, Apr 05, 2022 at 06:30:21PM +0530, Wyes Karny wrote:
>> From: Lewis Caroll <lewis.carroll@amd.com>
>>
>> Currently in the absence of the cpuidle driver (eg: when global
>> C-States are disabled in the BIOS or when cpuidle is driver is not
>> compiled in),
> 
> When does that ever happen?
> 
> Sounds like a very very niche situation to me...
Certain customers prefer to turn off C-States from the BIOS in
low-latency environments.

> 
>> Here we enable MWAIT instruction as the default idle call for AMD
>> Zen processors which support MWAIT. We retain the existing behaviour
>> for older processors which depend on HALT.
> 
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.
> 
> Also, pls read section "2) Describe your changes" in
> Documentation/process/submitting-patches.rst for more details.
> 
> Also, see section "Changelog" in
> Documentation/process/maintainer-tip.rst
> 
> Bottom line is: personal pronouns are ambiguous in text, especially with
> so many parties/companies/etc developing the kernel so let's avoid them
> please.

Sure. I'll update this. Thanks.
> 
>>  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
>>  {
>> -	if (c->x86_vendor != X86_VENDOR_INTEL)
>> +	if (!early_mwait_supported(c))
> 
> Isn't it enough to simply do here:
> 
> 	if (cpu_has(c, X86_FEATURE_ZEN))
> 		return 1;
> 
>         if (c->x86_vendor != X86_VENDOR_INTEL)
>                 return 0;
> 
> 	...
> 
> 

If x86_FEATURE_ZEN is set and X86_FEATURE_MWAIT is not set or has X86_BUG_MONITOR
then it won't return correct value.

--
Thanks,
Wyes

