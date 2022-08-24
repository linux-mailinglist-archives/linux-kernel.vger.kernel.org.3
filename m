Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7459FFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbiHXQsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiHXQsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:48:21 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A454E61E;
        Wed, 24 Aug 2022 09:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS33+LxyfsCcFLOacDB7X3U52jHVEmzBZxWKeRAm7xjsW648n8Gs1N/s4mpVsAj/qvAjU31sLJa+1xfX3MhRnA6yYMeTi363DBLmMksMObA+ZXT6nCY/cxtR+857X9PKRQcSRFDxlhuJ3ztAKnKbq2+xfoYy6AjEJUqKN8V4JGX6wFIv+EAGcIYv/bUT5hrCYWgSwYBYvAfE1ahYRLvU8l4Z5G1tCnDuaFuMkc1SVg2nueY82E6XalDfXQCG5jRS9z7hKJ/7dgm3NuOotqvKuXCi67USBpkrkbJm7PLy3lNXNgF4DeZJEDhJingZsKA8lgogWSpHZuo2b1yeQ2LS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCLpYUT/bf0TC2nIGoE412PQgIz7Sj6V8OvSMbWQ4aw=;
 b=ccoVsKx5EPt5S/mqAjz3Q1n9XFDOtOk2RgnYb2ZS/spqp5/uJNbu9b2hjFeGUVWYmAAeEmx/oZi2SIorv+QAnnKiQVECvzE1GL1OV7IFDHKRwSGdYiq/lN0gTga7AlrmBWElVyz/qLSz9SyziexF8Fnae3COziJUvEdmkUVSRboKAbsEYGhbqq5T9QxeXbHsD5FGDvwic2A6hpssVGdqtx7dFVCYIfXjucFBaQw1UDNDjMn6Rs9FQz35Qdp07s1TO4of4Xu+KJJOmnE72sYnvj+/OK212lebsfs7nfzuwui77Yy06ynekOD1ME808GIanLPUpA2lxQ5C7cmN2qjGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCLpYUT/bf0TC2nIGoE412PQgIz7Sj6V8OvSMbWQ4aw=;
 b=XD/+EpvWqypJqsEzauAEdF0OoACegha9LFdBl4VO/RYJ4PWQ27Q+BW41HNJZ82ryv/ATx967+ETS8LSMaMXZYI8XjzUGzS1Kf9cJAv0guaRr/C2aXTdGu8xCxSTYjAorAMnbCYbBm851cvABl3aPs7BoMbEhpZlyKYben5jvSEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Wed, 24 Aug
 2022 16:48:16 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%7]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 16:48:16 +0000
Message-ID: <d5d040db-0052-7054-f55a-5928360d536d@amd.com>
Date:   Wed, 24 Aug 2022 11:48:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 04/10] x86/resctrl: Detect and configure Slow Memory
 Bandwidth allocation
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117578936.6695.16882887771401229703.stgit@bmoger-ubuntu>
 <fa6c01b8-455e-4be6-2607-985ddbd3449e@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <fa6c01b8-455e-4be6-2607-985ddbd3449e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:610:77::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aba0f62-730f-4515-6df5-08da85f0710e
X-MS-TrafficTypeDiagnostic: MW4PR12MB7166:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bomw1pckxhugDjSuymZgtZeFm3QBtWe3sx6vsncTIytBkvwREr8AiQUH+fF9qjhMtS8L08+JrcA6PskpB8zJp87lX5FoLwrhBslLXhqGF5NtbJrb6iErd3x/lODw9GTta3RO1376ikSVvb7GttONvAOemlTQ28lT5MLFzGaJFUI6kaqQ0cTiKFG3/rDdgpLmSmeeW5lybEM6RPMxsFOYw9KYRQRW25M8a6KyqwZHZRirNgJY9w+1cQmAoFrBAbbpgD6H/AqGR6b4GXYkMxJAEMK44APKYnfjG/1p3VQoWNeX2VCflYifEt1tBkM1MjvfJ8ba5tIpDvBMosyDRGYuBoCW40YX8id0dV2LyxKygiA/SFEuVz79xUQUU2SGasexxWJazD7SVkx+PmS+KCXTFG6Nq54kTcUKzjkIHTzB4oSfhimNbRYZt5bXoyx7Yjh2XGp2Ah2+lL01SyBOnnLCt1TOTqrG1+rL/bq3WiABOiKhCN1BquGMZHk1AiGBMEgKOzB3+YeWHCA5naWCx4pOQK5rpx3iIsnPBDX8q2+mcw4H/kq3ILApKCjF4JQ9uaY/Ko0eo9UhYsxphAyFqavDTNxDR2FJECNwp9roIu+HuoXoIC9kWgDyqyxwspQfK25qYeYpVGmCobZEOhHm4GybzoL0Iu7F+D9jf7+vhswcFqOxawp/X9dwSS/LTDYmMe3zU1Sj7TTR3uh9nQihINs4B7J8iHwabHAmfH2kh5cY8kp/PfJDBjRrLw6EsQKCDSNtw7fXR2eWrmQAa8ihUD4BsGFdmCqEQy5yQjnvyRuMOSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(316002)(41300700001)(31686004)(2906002)(7416002)(6666004)(53546011)(186003)(3450700001)(6512007)(5660300002)(36756003)(26005)(6506007)(2616005)(86362001)(4326008)(31696002)(478600001)(66946007)(66476007)(66556008)(8936002)(8676002)(38100700002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dmMWxXVWh1ZmVYekVDdHFvVjJna0FsdkhmOWJjUEFXY0lCN0NobEFlUTNs?=
 =?utf-8?B?VE9LKzBYbEMzencxMHVjelpSWW1Pb3IwTHVsbEc3STZXb2lFZW5YdXNhK0pX?=
 =?utf-8?B?dUZRcWN4ZDNKOE56akcxdmxqRE5yR3BLci96M0FTdDIwNzUwNzVBbTMxMEQ0?=
 =?utf-8?B?Um5DOVlwU1N2UFl0OXhSNWViSVcvc0N4dDBlTit2blAvMVBXUnhtUTFHaURL?=
 =?utf-8?B?YXZ6aFVKd05ncU1oQmNzV2poNmNrZTJudXF3cHFsMjdFYmF4SmRaU2VkS1dD?=
 =?utf-8?B?b2htaXdzaVU4OTBnTWdueWc0STZBL3hBNGF4ZDh5cm1qMWE5TEZsTWhiVTlQ?=
 =?utf-8?B?Slhob3U3NWp0M1N3d1JmbFlZcjVUcFJlTGRqeDgwWDhiVS9Nd2xhWFlTNzdm?=
 =?utf-8?B?cXpLc3hlcUFQY21reXl5TjhBRm5TVVE0QXVxWWV2emFZY1d0U3lqSDZPejFv?=
 =?utf-8?B?eDh5QmhuYklWb0Y2bDZtcDV0V1kySURaa1Z0WHpTVDF0WktFOFVGRHJPUDAy?=
 =?utf-8?B?VXl6c0lNRmNPY2NXMHZaR2R2dGoxdFdxY1pIQlpnZVBBaUdJdFpUQmlBODVC?=
 =?utf-8?B?SmVlR1lVbWk1enVreHVZZE42UG1INTFBQkZDSE9Pcnd6dTN0OTd1ZjFRR2Vo?=
 =?utf-8?B?UVVZdHJwYkpLbStJUzZHVmk5SHBZMDNqTjJrUFg4cFhTZk56RElabFBLYWlU?=
 =?utf-8?B?WnNKa3BrYlFCZmF5NDI4MXFuVGoyNFBac3B4dXRnUGlCdis1a0JNUnRhOTR2?=
 =?utf-8?B?U1I4VGtDbkEvNkY0dUdnK1VYUTV0MlV2MUQxNGpERkliTVhzZklxZklBVEV6?=
 =?utf-8?B?b3BTaGxTQUdDQkM3cDVndlpKTXNRSGl0T1pIYVBrQUo3ZnN0QVpYajlxNnRV?=
 =?utf-8?B?WFdscGE5cXRoZGptQ1pFcUN6ZWN1VTNWOWxFMThPWXYrQlhYakxreGlHenZD?=
 =?utf-8?B?cE1TYUJFcVhIRFYxTlJOT09IakVQbzhjY1pHZmUvTzNodHIrYjlHdnJDSzU3?=
 =?utf-8?B?RUpUSXBwRVJESE9nK1dUaDVyQUxFQXMyTEdOQndpcGMrN0QyQkxqNUNTUlRD?=
 =?utf-8?B?Yk1nNGhSKy9ONlk3OXE5ODQxem13dGJiUVRlcHhtOHhsUC9XUktrMFhQS3dr?=
 =?utf-8?B?b29XVU1kaDBCejhpdmo0dDh1SDVaR3FMVkQrMEVFcGtVQ0NySkFKUkNUZDAx?=
 =?utf-8?B?SXczTThYbnVtbWp5cEJJYWdmZUZ0ZHhOZ3c0YzVPbWZQRzRPSHJhdytSNGw1?=
 =?utf-8?B?andZaGZ3WHl1ODg0YUJpbUNucXA1NmtzcWFQNzc5cE1iWjlra3ZYU04yd0x4?=
 =?utf-8?B?NVZ6R0E4TUFvZnFadVc4VEVZQ2IwczlKVlIxTXpFSkFtSWpZY2R1SVN5c1BT?=
 =?utf-8?B?TDl1YjR6VFl2eGJSU1pKYVRtRHVGNXlWcGVLTHAzNENSRlQvQkdhbXFDczRI?=
 =?utf-8?B?VUhxK3U3Umt1MWFYUkZ0RXB3bUI3WjhNbk9hRVdUMmVjR3pNSHhoVFNWWXVa?=
 =?utf-8?B?YkE3NFNRLytZVzk5NEVxOVhuU2VrT3VrNkRqK1hCYWI1OTJXSUNrUTk1a2dC?=
 =?utf-8?B?SGhMRTZkNzMvS0ZmN0lnQm5KdG5kbDlIZ2g5UHdkTiszQ2RSVjVGNXJQOFEv?=
 =?utf-8?B?ZktjeUhGNVljblY4RW5DRGlCK00rZnVmdjZZZG4xQktGanlNVHV3Nnhxa1lV?=
 =?utf-8?B?YmluWmNPTTg5WkFFV1BHK2ZPeGxVc21uTXAwVWE5S3BOREdXL20vNmp0VXhB?=
 =?utf-8?B?L1pyMEJNRVhMWm8ycWo1UjNCNHNTaitxRU5vNGp4RTFZMm1zZTJyRE1PT3dI?=
 =?utf-8?B?aTRRSUQwNlVTR2VUY2lOTkNxeXZNc1pHVjdUbFUzQUF3UCt2V1hMRTVhS29P?=
 =?utf-8?B?WjdSQ3RJMXBmL094QVRlTEhkbUFJWERKV0YwdGtlbi94b3FuSStzTklmMXM0?=
 =?utf-8?B?dzEyNjA2RDUyRGRLeXBVcVlyK0k3a1paZzYvKzAvTzRaUlZHT2kyalRkaEF3?=
 =?utf-8?B?MjhaVW13bzk3MjlBQWZYMWYwSFdJUlBKUG9kNnZmcnRzc2lKTTJHcFRnN2Y3?=
 =?utf-8?B?R0R1bEZncjNVa002YUlGVUpBL0tzb29MNEVueGNBZVR1U092dUpNVXdFdnQ5?=
 =?utf-8?Q?5CCw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aba0f62-730f-4515-6df5-08da85f0710e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 16:48:16.3481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PU//j+4xBvj/stR/6hOYBNdYd9iffdQotRzpUKekmPhsDAE7v2Femm0/+wCmCsl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/23/22 17:47, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/22/2022 6:43 AM, Babu Moger wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 6c38427b71a2..36ad97ab7342 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -253,6 +253,37 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>>  	return true;
>>  }
>>  
>> +static bool __rdt_get_s_mem_config_amd(struct rdt_resource *r)
>> +{
>> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +	union cpuid_0x10_3_eax eax;
>> +	union cpuid_0x10_x_edx edx;
>> +	u32 ebx, ecx;
>> +
>> +	cpuid_count(0x80000020, 2, &eax.full, &ebx, &ecx, &edx.full);
>> +	hw_res->num_closid = edx.split.cos_max + 1;
>> +	r->default_ctrl = MAX_MBA_BW_AMD;
>> +
>> +	/* AMD does not use delay */
>> +	r->membw.delay_linear = false;
>> +	r->membw.arch_needs_linear = false;
>> +
>> +	/*
>> +	 * AMD does not use memory delay throttle model to control
>> +	 * the allocation like Intel does.
>> +	 */
>> +	r->membw.throttle_mode = THREAD_THROTTLE_UNDEFINED;
>> +	r->membw.min_bw = 0;
>> +	r->membw.bw_gran = 1;
>> +	/* Max value is 2048, Data width should be 4 in decimal */
>> +	r->data_width = 4;
>> +
>> +	r->alloc_capable = true;
>> +	r->alloc_enabled = true;
>> +
>> +	return true;
>> +}
>> +
>
> From what I can tell this new function is almost identical to (it differs with
> one character from) __rdt_get_mem_config_amd(). Could it be refactored to
> avoid such duplication?

Yes. Sure. We can do that.

Thanks

