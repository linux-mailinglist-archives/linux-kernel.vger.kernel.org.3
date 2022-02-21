Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1D4BE30E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379497AbiBUPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:47:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379487AbiBUPqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:46:51 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A98E22B0A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:46:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLQ8elH67pLzkonL/HxW/KMbtZaPfhaAlEHSlRlP7oOdaRMz2+P4gbQwjLxNAmqqZkGsZZmP7ZhrnCb1VL9Mcs/4KZLDdKZcLnuBj3PUTPHcbZ0Ys8rPQUHjOdJb3xQzAEMCGZLx2a1dD8BbFUYNdpqQWYWd0Jz3seI4UTkgKqj4wDdYZBGf6UjM/6z8ZVHbojZXfTbbn6ecwP4PrNQw9BtzEzokg2DTiJg0C+NPtD66oNmEajLD5GG2ndiArtBa3o454c7LYU8ViJZysf8TAGm+jaPPF/a7rqDqiZWKj71UdvS9asl88U8PRuueHO+XVkPYFHNHWk7rNcsA8Y4Abw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMl2HzDVHCFcTqGtphdpOrR47p6Se1SWJm3pb7um/Sw=;
 b=E/yJSnr6K7AJJCympSYNhrL9OyK7dJp3vWgLDSEHS24kOAVcygPDh2rlAr5VC6YEUA9ifrMncZ1POMCuEQeOplWbdwmlxXjki61WR9QjuushRqIf4Cn3yL72ycUiQ1+XwKRH1AEiaXLqRRtP9ukbzQwofe2qEewvWzPJP3K1GbrPlN7LCgJfmDkh3RHp8+da2C+/oNl6YStAPzW5b5QJFzxPmydKfbg/WlU8e+2/lHIqMHaUDpydFxqskCaEwM1W0A6XLGXZeTCR6H8iKwidO7dUn4Bs8GLEuZ6v4YH2ZxDi182jGSpQ0QfrJ06HZudL3zqwFOF1kJEZ3K3GE/cNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMl2HzDVHCFcTqGtphdpOrR47p6Se1SWJm3pb7um/Sw=;
 b=Ys9VOcUz81cscBTZr3T7AQXn5q34J9tXQADym2GwCuGwS8mL2/x5xZDsQT6/e151JmqkB8Lm10AV1dIRH437ZrRICUb9fDN3cU7eHSVFBR3Xb4GDdT+AkKQBNHO4Y7Co+eW3ggLpUk04yG/eX66QZ0RJbIVVTF0aI8RKtSDBy20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by BYAPR12MB4631.namprd12.prod.outlook.com (2603:10b6:a03:10d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 15:46:23 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 15:46:23 +0000
Message-ID: <3cd0fd16-2d59-d3ac-7a73-4209311b2b97@amd.com>
Date:   Mon, 21 Feb 2022 09:46:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     brijesh.singh@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCHv3 27/32] x86/mm/cpa: Generailize
 __set_memory_enc_pgtable()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-28-kirill.shutemov@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <20220218161718.67148-28-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:610:11a::18) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd97a944-b9f1-443a-6201-08d9f5515030
X-MS-TrafficTypeDiagnostic: BYAPR12MB4631:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB46318588B1F10FAC3700DD36E53A9@BYAPR12MB4631.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Fne4eLr/QuyN7hken2Jnop1naBBB/qVnpc5lpMhaW+4jHEZ0PNhKbInSsTqgTnRL6/+KQa2MMcqi8WXC8Xo3/ZniGrobgPuTjjOjHE1OHVXhHHAJT8y7vFSzbP1ttthXnEQJFxsoYG6jT/n07053CSc91R/sPaKx1pWjKYkeYN6v06SHXBPd9GI+jo9LlxduU5NnElRAmWdKV9pcq351Vr45nfUC5mHMVv0fvIoo4Qi4U8bdlg+1qT0dbBcvvJ+Xv2jD4DX3GZuOP7dzarNplzCDAewV67z0RHwJ0KktKDxjqH3ilY6hWh3aAI00HhFvTSSW4gCKY8h++jJisWFcZVQPcqnD4TwQP+CwGK8fvnrLCSGyZnoQqN/IcEzpmU4Re2XY4FZN6G24BtYRjXv/DMqHypiqcUcVlS+t0AEHdLn2WPGwJHd0PS86NBEAS1QGiq3VE8ZYUq9eFxhMatEu5kuXqlASwMwXULVsVdmuNOednUgdx6KiSDImKd6f3bo1nosIDBxk7gTAS1k8O+y1S0VDf+fjLGAvuYOw0FSuTo463GMX5S2NNUWk+SqQ42TRAtmzryWlqXqviyyorfxYG0MuWHeOrMFb55XEoJb32fJKhKPmCWA85ZqgqLgmV7wcOFZCafoZHGK/yeqOujYmIs13DSnlwxU78wkKdXpiD3WjGFFMZrM65W3vC27+/6J8oRA9FOlO98N8XpEc9kmGGz2OZO/Z+ZuQ283vVueBodcHa/40pvfRhPznoTFbfabzGcnQaQ/XhvM4In+4Wu+vzRFMV1KU756VpTtvhcK4t6xxau1XR26droMDw7K/2w6IhOA8o3PMlINNxfJhP0WYpSClvKrczvqjE8Y69zGkqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(38100700002)(44832011)(36756003)(7416002)(5660300002)(31686004)(2906002)(8936002)(6506007)(26005)(2616005)(966005)(6486002)(53546011)(186003)(6512007)(66946007)(66556008)(6666004)(508600001)(316002)(8676002)(31696002)(66476007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVpjcjBwampQOWcxMVhCWjJEcnZLWitna2g5djBNQ1V1WmNEWXFrUzlLMm56?=
 =?utf-8?B?aU10RTV6OUpjV0d4eW5naDJOb2l2ZUptYmt0UW9FUmtmT3RoOUNUNGczNTJU?=
 =?utf-8?B?ekxlRzhHOHM1QkdyRlh5bWM1T2o2dnM0dDJyazFqMFBzb2ZpMnhpZ2dyWnBa?=
 =?utf-8?B?aG9HUmRQSzJzcmtlNFo0bis0aThnSWxKZGtHZ1JzaW9yVFh6dy9Tbmp6bktF?=
 =?utf-8?B?Vk96ckNmTkdxTy9nZkRYcUxSUUFEZGJLMDdVdk9Zc2xYc2g1MGFqbElhWWtX?=
 =?utf-8?B?c0ZVeHZqUTJPcE0vR1lzRGc3UVdqNU1aZFJUMzNuQXJxalZxRUpXZjR6bmJ6?=
 =?utf-8?B?TVJuZ3Z4aityRUU0WVExd2pRaUN0NXk1WFM0UmhGaWZaUHptTE0vdGJFa3ZP?=
 =?utf-8?B?ODNRNk9BSFNRc3BmVGRLdjRza2ZoVVNQMnVacWY2VzdNNG1JWWxBVDd1VFln?=
 =?utf-8?B?TW9EMm1wdVorcFdvRlZtYk4rVHhxYWFYWXFWbmRrSVZKSElNT05rNWx4SU03?=
 =?utf-8?B?TXViRXA5RElqeXNlVVcxNmJpWWxRV1NvampsT3hNTGpDUVlCbHd6YkVnbGdv?=
 =?utf-8?B?aXJCYjJqQmF2TS9uU01EZHVEMHhRNE5zSXc4bkwraHRoOXJhRzlmcVRXazQ0?=
 =?utf-8?B?OXd3dVBuQmErOWlCTThnQ1QzMWVNNzVpekl6TXZ6clRtdjZPcXpvcXdNcytB?=
 =?utf-8?B?TEp5Ty9IemRoMWRhVDNybzhWTDBrb3dYVnNXSTNVU2tNNjZMbFRlRWRZN2xE?=
 =?utf-8?B?WjFLUmxybVBVbjdiclhzeXZsUFFyamp4SFc1WVNjV0ZSQWFKMTZGeUFnTDV4?=
 =?utf-8?B?OSsrMEVSazI1VnUvc3ViaU5nSkkxL2RRV3o5NlN1c044V21oTFdHUDlmaXhD?=
 =?utf-8?B?ZnNLZDhSMmdiMmRmaUJNQzk4WHUyR0FVTEZTbmN0NW03U0NySHB1VlgvN3lP?=
 =?utf-8?B?U2JzUCthUlREdy9RbkRZVFNmbnNPQVBHenMxcHhwWjVJa2Myd2p1T29BQ3E3?=
 =?utf-8?B?NzlHWFkrYmk5YnBuVUhLNEpJSUxkUW1IcDM5Q25GVFQ3WHhRaHRLeVVPZkda?=
 =?utf-8?B?RlpnR0V1VjA3UWV5VGZHTS8wZ1ZibHpVN1pGVHQ0c0xtT2xhZmNVTVRtdlRy?=
 =?utf-8?B?TEtLUCtjZTNWZ2w4QnRmbXpuWGErRU1nS1hHN3NQaCttL2YxTURvZmdzdmJs?=
 =?utf-8?B?djdUOU51TW5pMUhzZDc4VldxVnRFUEdzazlrc05qTHFIQmhjelZHQTdram9j?=
 =?utf-8?B?bWhrRlRVbzN2eWZnbzNJSGVMUFk5cFN0TkdTanNKdkN3cDdhNXNwVW85TFpt?=
 =?utf-8?B?MlVjaW11bFAvVkQ4ZHFLNGpFZnFCUk9XU05DcTIzN09XaVI5MGROeHJhanZq?=
 =?utf-8?B?eUxXejNlWEY0YncyelZCbGo0cEFzRmUxaHRVTXBlSU9xVDR2clQwRVh6TFpO?=
 =?utf-8?B?bW1USXZ1UFAzdVRMYkQwNDVWRHFLN0hvSVFxaE0zak5COCtRMXFPalpoWlpY?=
 =?utf-8?B?Y1V5LzlvbFMrQUY1SGVmblVFVTJwcHZnZDRjRVlQME50V2Z1U0pVeGZoK0x0?=
 =?utf-8?B?Z1MzdzdMQkFTdlBzV3ZvZG1wNy9FUUhCU3B6STdPMStZM2tKbnNRd3puSnNv?=
 =?utf-8?B?MjlCRk9UZnY3V2xqbytrMGlHNTFJSkFjdTRmOEl3Y3g4aFhydkFQQnEzVVl1?=
 =?utf-8?B?UWJjeFlyaVdPM3F5ZngzUldFL3p4cWNvVWU2VlpEODJQaVRQV25GT3lKSm85?=
 =?utf-8?B?dnUzenNJSjA4N2FJMmhOQTJIYVRMcUlRWW5ybzlabXgyeGdyWm9qR01NQzFI?=
 =?utf-8?B?cnQ5NmhHVUVpOEM4N05zazgzb2F1d2tzUnMvY3I0aENCdndvNVdmT3FxNGFU?=
 =?utf-8?B?WDFJUktEMFhPcktidC9QOEFzbW9EK0lsNU0yZVhYemt6NGVLeVZFRUpva0hp?=
 =?utf-8?B?Q1paM3ZWMWNNTDV0RGE4UURNUHFwZVRBUmYvcGVPU3FxNzVsMkJsek1teWF1?=
 =?utf-8?B?YW1xZ2NmWUd3VHgyUDV3NmtiZ0ZEQlFFVUcrVFpXbVYrdHR5Z2UyUHVnVHQr?=
 =?utf-8?B?UmM3dGZVR3luaWcxeVF4eHNxd01IY0NrQ08va3k1Q294bVp0bjFUS0tXR25Q?=
 =?utf-8?B?KzFUU0JlY1U1NFREdkU4WldaazlseUkwSUNkTjZjM3YrNUpwRlN2N1VKelFX?=
 =?utf-8?Q?lToeoUCyeY6Cpw6U4urdVpA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd97a944-b9f1-443a-6201-08d9f5515030
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 15:46:23.8483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Q8T7zvkFkQEm0hSW1sXRg6yN2F8YeogxcwF3TYy27yt9hmRCBKyg8780OmWRokkNmCaFrSLSafmwOGyIFSGvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/22 10:17, Kirill A. Shutemov wrote:
...
>   
> -	/*
> -	 * Before changing the encryption attribute, we need to flush caches.
> -	 */
> -	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
> +	/* Flush caches as needed before changing the encryption attribute. */
> +	if (x86_platform.cc->enc_tlb_flush_required(enc))
> +		cpa_flush(&cpa, x86_platform.cc->enc_cache_flush_required());
>   
>   	ret = __change_page_attr_set_clr(&cpa, 1);
>   
> @@ -2027,7 +2026,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>   	 * Notify hypervisor that a given memory range is mapped encrypted
>   	 * or decrypted.
>   	 */
> -	notify_range_enc_status_changed(addr, numpages, enc);
> +	if (!ret)
> +		ret = x86_platform.cc->enc_status_changed(addr, numpages, enc);
>   

Boris has given similar comment on SNP series. This area of code have a 
very similar requirement. Boris proposed it here [1] and I followed up 
[2] with SNP specific comment. It will be good to get your feedback and 
do a generic implementation outside of the SNP/TDX series.

[1] https://lore.kernel.org/linux-mm/Ygz88uacbwuTTNat@zn.tnic/
[2] 
https://lore.kernel.org/linux-mm/20220216160457.1748381-1-brijesh.singh@amd.com/T/

thanks
