Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA9F4D4B11
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbiCJOkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343944AbiCJOba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:31:30 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD70990CD6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:29:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWgFPGzlzHjMBXqGRYDPjqr3sSXPQbWM7Dgi1fsmA18wWXgxaxjdLnmVqocNOn6JbaZhPt4xvVwJd/SHHATFDwonpQ28dJXaKvv0qRVOcQmS56B+omjqmqe5f4eRzwxdsQm4986Ky26ppwLBi0QHFVSGd1uQi8p8By34GbXzbEH/JRMdSO+kYlXzIrxc2K3fOmliVErN+ogtbiPMIK+EndXskCKIwYt8hT7nSpW8oQ3xR1I4TFSS3veLzIPb76Sc6/7fV7NugTuWlsNdo6YbCbsr6ii4q3MrBTg4xJK/PRJJVkhcm+3Qtuj98lrqqZcs3uGdIs8iFgScP+TlnWd2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQ6moQqpvMO5rO15AGEe4Sau+LktrTiJR579xDmehf0=;
 b=W140Y+gTzrzxysJMxZlVT38zVYHi1cjnm4HAXEtjqjQRu9PecNFHW7/72ZZVcY5rNMGKQjKPtR20NFKVIqA2B0gooTSbM3Y9Ze0VJ+He32ThQ1nG4deB2IxlNKAIbR/jH3lnMwP20sILM3mKrCWkj3lFbLgjZ1Aw5q1icEL/a4VOaXjqLhtdqmjJA5vYUfS9tehy6YMk8U5RyJZxLuQoHY1hAhO2AZKSNi6/zytaOkNkmGuEo4s5Zh3//sTeOmoKqkrbGfGF8Y8dZ0qwpowE5Edn4UgouQ+R/QOLSS1cl6xJRVlMVH84XrhiogjOLO2mBltGkhcDc1dEd0Yesdbuvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQ6moQqpvMO5rO15AGEe4Sau+LktrTiJR579xDmehf0=;
 b=ozveeiv45QIHBYrP0QQUZd1l7yeE8C2iuD0qvHwVHI9TlfS5AzgAjqnLoDG2D4LNEdTJtc6tbDPudkYFmh8+NYMCWAFLaVVjde3E9Lwerj/1/Jn9ktw0WXFOdVc6m7lJtsGeEPSHi5oo/VbGLPe38k1d4R+uXqQKFIQd+N4Q27A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB3312.namprd12.prod.outlook.com (2603:10b6:208:ab::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 14:29:05 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::b981:ecd7:f406:d32d]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::b981:ecd7:f406:d32d%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 14:29:04 +0000
Message-ID: <65577d45-8b15-08b6-2de4-3ca820e4d7a3@amd.com>
Date:   Thu, 10 Mar 2022 08:29:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv5 27/30] x86/kvm: Use bounce buffers for TD guest
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        brijesh.singh@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-28-kirill.shutemov@linux.intel.com>
 <f368d524-f676-d112-5bd0-0eeba6b77ff5@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <f368d524-f676-d112-5bd0-0eeba6b77ff5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0138.namprd11.prod.outlook.com
 (2603:10b6:806:131::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aac2d0ae-7837-4450-54d2-08da02a25424
X-MS-TrafficTypeDiagnostic: MN2PR12MB3312:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3312EB1F8520AA08488E85EEEC0B9@MN2PR12MB3312.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qh6KqVCkqZWhIhAImU17sjmOFGTIihrwNFfGhkJREEjZxmKJ2n4b+fomQKfrYaCUAs40TA44FEZC5CpgxCDIn/vXglMUeH9CJRJD0Qmj4sCoXyS+5UAbykQzB1QJKMHPWXplXQuSwwxw45QGfN2JUiKLbGyKYZUttuQvye72KbwB4q6iKvmM6b4mnY38pxg5f9A+2jbnC72BFIHo0h6N/IR55lcNcM3Ou6dAMFQSY5QNTHU31QaXJqktjCRxVGGFFq6LjnLzGUAoaS7iF3wBV5REo2w44YmUi3bSfW0sk6goh7w0CLdMn3PM7LaP8Jfnd/xkPHwiwpD/Mh2VDYFdL61U8YXyjBf+Ef91rItm+xMYZyaMdgG/NR7WWHubhaXL2KQh26R+rV3K+Oqr+3mAU6Zr+zj+PBTcdhKLmOVj4i2YPzzHoYAUvSgEqrv5kgDUTvt0HJKqRsKA0ZIObq4kFxxsBd0g6rN/ttAeN6ArXYkeDS2KjQ7gENIoDu3Y/g61zjzQchEG0UlGvMchb2nDCc0D4Rt/ecHiZbQqa9X/XbjcHzM0U6+GANZBOkc/brcLYNIhjGJh+i8sWyqk7UsAG5Wxam21ithQqayQ4xADnBXkFe+F/jTk7/XKdHymeSpK8sYiSadwUFzVjRLQK78XQLgSN4znsGH6y0MLDRifeZmeV9UHOcaDMW7gaFXcoQ+sWpeAjzCSpGnAJO+BTWsuUjp5U/nC3DxWG2BMrEHfTNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(2906002)(316002)(6486002)(110136005)(6666004)(53546011)(6512007)(66946007)(8676002)(4326008)(66556008)(83380400001)(66476007)(2616005)(86362001)(38100700002)(508600001)(7416002)(36756003)(5660300002)(31696002)(31686004)(186003)(8936002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTFZdnlLVHBDMnlsSGsyTVhXS09wWnhHb0p5ZEUxT2dieTJQZGNFck9MU3lS?=
 =?utf-8?B?U0pCMmhpb1gxWXBlMXJtTE5ERjlpcy9PVGJJTVNuZ045dnkyb3BudTBkNkox?=
 =?utf-8?B?NStzdDZaRHNORkpOV2xIb3ZuUWtVL25pQ0o1bHQ4bmRoWEtpUkNwcS9aS3c1?=
 =?utf-8?B?bHFiNGExOG5PZXJnc2lxU3RraENRRkpETmJ1L25XQ3U4Z21tbEpqU1ZXNlgr?=
 =?utf-8?B?NlUydzVIZGRwYzY5cDlMbmdmak0xS2psZHVSWUdER29LMUFzanExb05wc3Fn?=
 =?utf-8?B?OGt2eHpMWUxTRFFwZGI0aVZZeFY0ZzZCeGNzeTV5WGlKUytiaCt0aWVYWFBr?=
 =?utf-8?B?SVhGRUZBS012MWd6Q3F3WVVCaVRwZUNzdDVxT29pRkUxQkpLVWc1dW1UcnhH?=
 =?utf-8?B?b1k4a3FreHBENHF1VVZ6SEh0Z01jUGFCS3ZQUmdzSU1mKzAzdHhqVzkxQXg4?=
 =?utf-8?B?bFVIK1YrL0hEYmNwWUI2S3dUMmdseXNIV3lXdkRZemhGcDVib1h0Uy9hQVli?=
 =?utf-8?B?QURrUC93bnRJakUrVnQ4ZEtJSlJkbDltV3MvRzVXU2V6c1h4R3VsOHU1bUZt?=
 =?utf-8?B?ZHhKbHVBbUtvUDJaZTNsdFlOQzRsWjVVZ2taNm04VHpjZVZyVjVXbExLbStt?=
 =?utf-8?B?SEtKelIrakJVM0hhemR5OXF5TDU5ZkRvWk84OTgvWGtneGRxZ2U3QlpGQnRt?=
 =?utf-8?B?RFNjMFBQWmVJL1Uwam11dFhENWtGQWpqVS83ZXBtdHNMdmgyYXh0Z2tXdXp0?=
 =?utf-8?B?S3BBYkhaWXAyekl1cmlkRXduSlBsM3JtcHVVS20wckJOeVJhOW96K3hGdDlw?=
 =?utf-8?B?MS9zUUxLRExVVlZrTnlPMVB2ZUpvb0Z1RkZuYk9Vc282MldtSWpLTTFHSGR1?=
 =?utf-8?B?ZEFSNjNSVlM5cCtLaVJRSEFHNDEyczFwUTQ1NENKNzFvSE9uUGR6SGwxanA4?=
 =?utf-8?B?bTJveTdaTURibjduYjluVFlBK1haVWJ3UTZEUkdMc040VGhRR04wcnRHTzJE?=
 =?utf-8?B?TlJiTWZvQzBRa3p6RlFwcjlIckVHbjNrRFFPdUQzT1N5TTd4aldMMWhVZEg3?=
 =?utf-8?B?ZWxQZGNlMGlDenRSVmtNYnh4YkRHZVI4UGJoNG82QTJ2V1g4MlRyYTBLMWg4?=
 =?utf-8?B?WG5XTU5yVm5CRmRwSDc5c2tOMXpTdEtzNmNaZjJ0bmZnWk85bE9SNFpPeUhh?=
 =?utf-8?B?YmE5ckw3Z1JhSEZhZkU3eEJQVEdaamJzeUx0aGgxVFhwcGlOdldqb2hWL1ow?=
 =?utf-8?B?Snp2KzMzTWNKRlNMdWFrNTNwcTNHdnZNRUhXbkZ6V1pBc2dJRmVmNXAvVUNy?=
 =?utf-8?B?T1Q1SWpDcmFoNUt0RVdBMTZYRmRLNXNRY21xekpXZks2ODVuYnpXeWF4czVQ?=
 =?utf-8?B?MERndHNMazJYN1JnN21NVmV6aXoxMDNwTEwvYk5yOWszZG9XWVFyRHhaMVBD?=
 =?utf-8?B?YjZ6bEJDWW5JbVBBUURuTWJLeGZrbWtpL1d1aTRWOUFhUSttNmszUWRhVjNK?=
 =?utf-8?B?MmppK3pqN2ZGWnN0WXFCUm43SHVia1F6U1lZckhhRmlzRHY0NGM4OHBoUnR2?=
 =?utf-8?B?S3hCYjdwQzR5bG03STJMT2diVW1SL3lOZDhFY2d6NENHbUxQM0loa09oTGU4?=
 =?utf-8?B?SGo0WWZiektnR0pJdkRwU2xneksvVHZxYTFRWk5peWVaY0hvSXBpREpTM0Fv?=
 =?utf-8?B?Y0Q1Vy9kZnVTZHBLZ1NibStqNUIwWklnRnBqTkNzakV4d2NlM3RIUm5RYmFw?=
 =?utf-8?B?VEh0LzU1UzR6NThzcXl3L0FadDdmVEdvYjY2amIvUVJzLzhSRUVBa2VVQUNw?=
 =?utf-8?B?Y0lIaWhTMFM4Q0lxcnQzeEtSczMxdW1BdDg5QkRxdGNMaDBTK0hXU2pKUEFK?=
 =?utf-8?B?RTNiMm1lczFKcXBxSnJWZUZqUWxrem16My9HblVBQTkwbHhZMEIwU2JxL3d3?=
 =?utf-8?Q?NbnbkQkWCDr6K6Hd01mL76crc+KqtOHa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac2d0ae-7837-4450-54d2-08da02a25424
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 14:29:04.8170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRAw25YjC8BdIJ4xWdUPGBjDJaeeGFHsPP3W4SXSQSN4H2RSRIDUZ5tjnCNkqtPsjAPxy7+sMP0Ej1QHRWjPAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3312
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 14:07, Dave Hansen wrote:
> On 3/2/22 06:28, Kirill A. Shutemov wrote:
>> --- a/arch/x86/coco/tdx.c
>> +++ b/arch/x86/coco/tdx.c
>> @@ -5,6 +5,7 @@
>>   #define pr_fmt(fmt)     "tdx: " fmt
>>   
>>   #include <linux/cpufeature.h>
>> +#include <linux/swiotlb.h>
>>   #include <asm/coco.h>
>>   #include <asm/tdx.h>
>>   #include <asm/vmx.h>
>> @@ -627,5 +628,7 @@ void __init tdx_early_init(void)
>>   	x86_platform.guest.enc_tlb_flush_required = tdx_tlb_flush_required;
>>   	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
>>   
>> +	swiotlb_force = SWIOTLB_FORCE;
>> +
>>   	pr_info("Guest detected\n");
>>   }
> 
> AMD currently does:
> 
>          if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>                  swiotlb_force = SWIOTLB_FORCE;
> 
> which somewhat begs the question of why we can't do the
> 
> 	swiotlb_force = SWIOTLB_FORCE;
> 
> thing in:
> 
> void __init mem_encrypt_init(void)
> {
>          if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))

If you make this cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT), then it 
should work for both, I would think. If you use CC_ATTR_MEM_ENCRYPT, 
you'll force bare-metal SME to always use bounce buffers when doing I/O. 
But SME can do I/O to encrypted memory if the device supports 64-bit DMA 
or if the IOMMU is being used, so we don't want to force SWIOTLB in this case.

Thanks,
Tom

>                  return;
> 
> /// Here
> 
> I recall there being a reason for this.  But I don't see any mention in
> the changelog.
