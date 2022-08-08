Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A0E58D012
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiHHWTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiHHWTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:19:05 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E6913CD6
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 15:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXYyh4HU9lufPs0qFnIdIGtIi3fNAUDJyNjBuPPzB2dtG7kD1yBfRnGcWmJOCgagxvR0a4TUCtcgf9/kiB90GuUBqCj0RnqPbnN94T02XWbtt1C2Lpbqg3nQ7eG/6DmeDaRmWZ6wBEXh4HNsRoEKFgoKQUV436De5+CVD3SYWdqum/d31ukBSJNX9+1Sz8OVd4FmkAg+mGc/qlSXc4zByebX+g5BXsN3rm5V7auZtClOzP7W15B5pUyHrhm4hehfRGQEahKh8NIPSXWFJIKretGJ9UoiRkqh6VabtFSgIXvZU3XRVdbgYkegUclp24YElmuJGPo+kPvulbuxUvOExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGnhChjQu9XurkLcSckOgT2su4m6DIbN38Etuui7ql8=;
 b=WXsq1OWMWDsr8TWipJbt5xM1CjBM2YsPQ7t3nuwT5vwQ1tSkZgmZj0CyOfp7NIT9hirXFrlkyYgHD1Ju0kMm44TVjB7wIIYh7PMY2N2FV8z9y6GuZ3aqibU8spoKxU34iMkawaBLCFCNgAamakeSanl1XkZyhyn2kVPSujQ8CaDd7M1l8wkl3ATdp9i0vkm6henQPGP8B17dFyGhiPArFOtLZoSxS+kOp92bBQAKwqsonFWv4DkoCFd7Z+wetf4BxowoCWUR1oj+pVv+0I5Theh5kbDMMcvQZfL3jfaTwfcvhwXb1JyKzaHpudVoyR2VL+8KykSYsr1ap+4t2agGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGnhChjQu9XurkLcSckOgT2su4m6DIbN38Etuui7ql8=;
 b=bpxlu9ZJ/vi4WPXNHXVpRov57GcFvhEtR0D1X3O47tmGbu3uSce1aBo33n6wm6aZlTxE25ULEYyXnSuUCts0OT3XmxLlMwigTnzVCSzD4zP9m0xWMrIgSwxqcBr+VAbkuoQFZ9bmDovf7+dpCcQ7wakfBoxmiLZzyX/A788KY7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BN6PR12MB1859.namprd12.prod.outlook.com (2603:10b6:404:ff::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 22:18:57 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 22:18:57 +0000
Message-ID: <6b615140-4075-4fab-de23-e0c7cd3c64d8@amd.com>
Date:   Mon, 8 Aug 2022 17:18:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] x86/sev: Put PSC struct on the stack in prep for
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
 <cover.1659978985.git.thomas.lendacky@amd.com>
 <21d5d55640ee1c5d66501b9398858b6a6bd6546f.1659978985.git.thomas.lendacky@amd.com>
 <50599c3c-eacb-7774-746c-021adf3f56e3@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <50599c3c-eacb-7774-746c-021adf3f56e3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0021.namprd12.prod.outlook.com
 (2603:10b6:806:6f::26) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b87fd05-6420-44bc-b9dc-08da798bfc62
X-MS-TrafficTypeDiagnostic: BN6PR12MB1859:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJIg0ga6rqjWMP5b0DwfY9xdOzQNi665xCmJmE8zdw92H6Ez9xe5MOCXsucOWwh52Zcij7kKFwqKMwQ17brlTY/V/HzILggAN4mYCMd10UGs4CYMd6q1+3v+JTjJYQrxFTNq4wUE5TuP4FFJv/XI0hWDWLNOppHo3MwSZMokYL7olOvFuIeUVjHoKn2synP4AcPdtDjHNlZjevQxl2GFYM524Nb/O8NHTg0d4gZDsKSuPi0nNmruB83sjdnOMtSBNbejtfnTo76JR6YBqEAl7ORzjtFF/9jSNi/9rfxVVRgl41caulbQDTsHXZWg9tGWyGsBTvL2CNFHpjW/N+yVbRpyoXjlqUcOA3aLec7/mvktnGhsr/23RV5/Iyqr0ZP1MoZGk+ZdS7EbyVPCQ+kwKC1aSRFAqjNFQaIy8E9Bk0JwiRKY4xadOihK6MGUVgXJkmb0phPVW/vOIcB+INT4LcDlVA0eq4YVeykSeIzh7490FX0XjDlmUrMavGj7qFh/O71U2BUXGLZKOU7tPSXRbPEvdKCzBFKresVIvCvpv/cKzZbMJ9McDjcjoAVB6y0lJZuDfPSCi61B+VJgQOV5TXOBqMMHaECX6VY5zYcVK7pRiv1YE+b+EdpxvBHvigJ/stpb7nxy0hTccOQ/LB+JBherYYaQyecZIqFChf5x+toJhLjFSnV6YBdP2LU6f2r1cMdep8GbM80HS3+fjLuE5OpaZ9AeU1LFY6ZY/pRRSI8Jd02YPnfRqNuHlsSNEmJksZc8t++kxhFVo+oOJC9eMm2rgLEM1uJqO6id6eH3/oHgFI3Lg3oiFFLHOgeB3YeJfNoRwG6/UbPkEQYjJML4rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(478600001)(41300700001)(36756003)(6506007)(6512007)(53546011)(26005)(86362001)(31696002)(2616005)(31686004)(6486002)(54906003)(186003)(83380400001)(6666004)(8676002)(4326008)(316002)(66476007)(66556008)(66946007)(7416002)(38100700002)(5660300002)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blFUclhaUXkzYWNNUncyY2tjaTVFeWsvbkRMRHdrMWtIdWpVNHRITVdPQ2k1?=
 =?utf-8?B?Nm8zNFJLY0lSV2pSMTRLWWUyTmhnZkcraDZ0YncrV05vRVROdkJxWXlVVFBW?=
 =?utf-8?B?bkdXOC9xbncxeVF2ZDd5MFNuNFYwcDIxUFV1VzJuWlhoa1o1anBlcHE0NzB3?=
 =?utf-8?B?aWVSRnZUSkphUWljYnd6SVQ3ODJUdnBkaFFyK1l3M05kVXNqaXhneWNyNEtw?=
 =?utf-8?B?M0IyQUJ1WHlncHR1NUFMRnRDNWlZNTdRMXJVSjJlUldDK01hc2U4bDJ1MmRR?=
 =?utf-8?B?cjBYQVJyMFpnT2RvSnJlaXczTThrekJFMGVmWGErZ1NmWlhQVnFqa2tzT3ht?=
 =?utf-8?B?R1NUalk3U0ozMDRLaGZHQlVSTGhuSmxHUWtnTFI1YStMTkdrOW5uT0ZiVWlE?=
 =?utf-8?B?UG50c0ZCb3hnaVNSZ2ZaSWhrUHRTZ1hSdzNFMmlXeWlYQktOQVJqNVR5T2sw?=
 =?utf-8?B?dmtGTW9wMTRENUNuR2xRSWFEclg2OUYxQk0rMHlzeWlhWTU0ZFYxTkN3bHZW?=
 =?utf-8?B?ZjdDdXA5eDV4VWp1ZlkzZE43L1pxUGdqUkhGUEJDMTRvSlhCTUZaZHFUQ213?=
 =?utf-8?B?a3lGSjFZZm1GKy9KSkt6aGRmK0NOcFYvQy9uc1NBcXhHTm9lU3k5YW1xczF5?=
 =?utf-8?B?dCtJMWNwQzNXWVlYOHR6SzFmaDJVclAxaG5PNnZ0aHNaSEtsSlR2eEhDalUx?=
 =?utf-8?B?UDkraWxRcEt4SlluZEI2VE1WMTJjYkk0ZXdtMFFJT1hKS0lxWDd2TnRGUDUz?=
 =?utf-8?B?MGlwL0NxcERWMFhkTlNoczdpd1lheXg4Y1ZpVmlNNi9iMnVFZTByT0NNYjVh?=
 =?utf-8?B?VFlFSXl3bUVaWVhoZkJVVURXZXZkRWF5LzlYaGlCZk93VllnUStVNkZOdU9D?=
 =?utf-8?B?VmRJVGEvZWV2MVAvbWVGcDgrYjEzRkkwYVlFdjlxZ3hRSndsK2Y4YWJUUTBJ?=
 =?utf-8?B?NUtuK3ErMzFrcXlIVk8wRGdNK01CZ2pBSXdhZzEzY2c4MUtrTHlwMDJEVzIw?=
 =?utf-8?B?aG02S25VTmRidHpnSk9rQmNKUjlkeDdNbjM0d2FaL0pDd1hHS2RaQ3R3VVp1?=
 =?utf-8?B?dEc3YzNmd3VtQnhpN1RFTVF2bDRUT2JDTkhHUlBtQzZJdEloV0x0Uy93T2wv?=
 =?utf-8?B?MktyRktpd0F0ZXNkR1puSXZYU2JCY2JKTU11SkRRTWM4VVlURmhmUHpuS2hE?=
 =?utf-8?B?NEhWN1Y0L09LMDVxUWJjRUhqaTZWNld3ekxSb0l5NCs1RFQzdmovZVlwdmN3?=
 =?utf-8?B?MGtkMndZcnZaeThCMEFZK0xjWVI1RlFpcW41akI5dnFmN2lyajQzNFpVV21o?=
 =?utf-8?B?UGcvRjlJT05NcEZUWDVQcGk3OU5SbWIwYjFJNDB5TkJmQVdOTk9vQzJ4REp5?=
 =?utf-8?B?bVBkd1hJdmMycnUyaEZnWGpmZ0Njb0gzK2VUOUxVeEcydndBRDFFMFQrZUNu?=
 =?utf-8?B?TnZwV1RQVWZFNm1KT2FVeXhNbjY4QkZGeXVESUo0NWR3Kyt5T1l5c1R6Y2My?=
 =?utf-8?B?TlhkeDVKQVVudEF1dlNYZlhpOW15M0x2bDFMa3Q1NXIrcmZKbW1RME9ITXZj?=
 =?utf-8?B?R1o4bnBFOUVnZjFOWmc0WFJmTFBnNVN1RXprR0l3WUNjb2YyR2dCT3pnN3Q4?=
 =?utf-8?B?a3JhTjc3Z0g4VDNlaVdLeDFFejF5MnI5UGpXanMxVnpTQlBhT3J3TEwvOHlx?=
 =?utf-8?B?Z2hxNHNxTVJhQ203bnRvT1lhNWdtZlhXWVAvU2hUOHlOYkJadjhIQWd1b1hy?=
 =?utf-8?B?aEt5ZjJnY0RGMGc5cmhkR2FqNE5SS0lKZkJGWnpVb3M4ZEpFQTEzMUVQVE5W?=
 =?utf-8?B?NW14M2RUYzVUTHp6VVV4N1UrRGhtNzdKeDhETGFVUzlIbGtXcUszVlowSDRO?=
 =?utf-8?B?UGtIZyt1SWJqYXVzNjJMRUYvUGZOUUJEV1VFZDFiVng1aHdIMjZMYUh3MlRD?=
 =?utf-8?B?Q2JEQVFYNGt0RkszK1FraWh0QnBRUDdDT1gxYkFMR0xrWjl2aWZ4eU1uQlJ0?=
 =?utf-8?B?MVNjaTN6VUJ1WUttRndWSHE1NmNUSUFZbkNXK3h6cXpZcnpPeWtkbjh0T0hK?=
 =?utf-8?B?NEhnM28vYWhZeGZGSmV3bklodENlY0lCc3BFYXplQktQNUdMc0RQUU1MUERi?=
 =?utf-8?Q?5Xjs3FXcKPAGPr3xhuT6AuOUf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b87fd05-6420-44bc-b9dc-08da798bfc62
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 22:18:56.9196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMI4J9a7Xh/gkta+0JBaAC9Ik7RMDzfdXGrYbfRCSah7UKy8UAkh5o/O4n2vdeuubYrI+tZMhxsrSNUKKgiBcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1859
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 16:43, Dave Hansen wrote:
> On 8/8/22 10:16, Tom Lendacky wrote:
> ...
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index b8357d6ecd47..6f7268a817fc 100644
>> --- a/arch/x86/include/asm/sev-common.h
>> +++ b/arch/x86/include/asm/sev-common.h
>> @@ -107,7 +107,7 @@ enum psc_op {
>>   #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
>>   
>>   /* SNP Page State Change NAE event */
>> -#define VMGEXIT_PSC_MAX_ENTRY		253
>> +#define VMGEXIT_PSC_MAX_ENTRY		64
> 
> In general, the stack-based allocation looks fine.  It might be worth a
> comment in there to make it clear that this can consume stack space.

I'll add that.

> 
>>   struct psc_hdr {
>>   	u16 cur_entry;
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index c05f0124c410..275aa890611f 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -66,6 +66,9 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>>    */
>>   static struct ghcb *boot_ghcb __section(".data");
>>   
>> +/* Flag to indicate when the first per-CPU GHCB is registered */
>> +static bool ghcb_percpu_ready __section(".data");
> 
> So, there's a code path that can't be entered until this is set?  Seems
> like the least we can do it annotate that path with a
> WARN_ON_ONCE(!ghcb_percpu_ready).

Sure, that can be added. Right now the only function that calls 
vmgexit_psc() is covered (set_pages_state()/__set_pages_state()) and is 
doing the right thing. But I guess if anything is added in the future, 
that will provide details on what happened.

> 
> Also, how does having _one_ global variable work for indicating the
> state of multiple per-cpu structures?  The code doesn't seem to delay
> setting this variable until after _all_ of the per-cpu state is ready.

All of the per-CPU GHCBs are allocated during the BSP boot, before any AP 
is started. The APs only ever run the kernel_exc_vmm_communication() #VC 
handler and only ever use the per-CPU version of the GHCB, never the early 
boot version. This is based on the initial_vc_handler being switched to 
the runtime #VC handler, kernel_exc_vmm_communication.

The trigger for the switch over for the BSP from the early boot GHCB to 
the per-CPU GHCB is during setup_ghcb() after the initial_vc_handler has 
been switched to kernel_exc_vmm_communication, which is just after the 
per-CPU allocations. By putting the setting of the ghcb_percpu_ready in 
setup_ghcb(), it indicates that the BSP per-CPU GHCB has been registered 
and can be used.

> 
>>   /* Bitmap of SEV features supported by the hypervisor */
>>   static u64 sev_hv_features __ro_after_init;
>>   
>> @@ -660,7 +663,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
>>   	}
>>   }
>>   
>> -static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
>> +static void early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
>>   {
>>   	unsigned long paddr_end;
>>   	u64 val;
>> @@ -868,11 +871,16 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
>>   static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
>>   {
>>   	unsigned long vaddr_end, next_vaddr;
>> -	struct snp_psc_desc *desc;
>> +	struct snp_psc_desc desc;
>> +
>> +	/*
>> +	 * Use the MSR protocol when the per-CPU GHCBs are not yet registered,
>> +	 * since vmgexit_psc() uses the per-CPU GHCB.
>> +	 */
>> +	if (!ghcb_percpu_ready)
>> +		return early_set_pages_state(__pa(vaddr), npages, op);
>>   
>> -	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
>> -	if (!desc)
>> -		panic("SNP: failed to allocate memory for PSC descriptor\n");
>> +	memset(&desc, 0, sizeof(desc));
> 
> Why is this using memset()?  The compiler should be smart enough to
> delay initializing 'desc' until after the return with this kind of
> construct:
> 
> 	struct snp_psc_desc desc = {};
> 	if (foo)
> 		return;
> 	// use 'desc' here
> 
> The compiler *knows* there is no access to 'desc' before the if().

Yup, I can change that.

Thanks,
Tom

> 
> 
>>   	vaddr = vaddr & PAGE_MASK;
>>   	vaddr_end = vaddr + (npages << PAGE_SHIFT);
>> @@ -882,12 +890,10 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
>>   		next_vaddr = min_t(unsigned long, vaddr_end,
>>   				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
>>   
>> -		__set_pages_state(desc, vaddr, next_vaddr, op);
>> +		__set_pages_state(&desc, vaddr, next_vaddr, op);
>>   
>>   		vaddr = next_vaddr;
>>   	}
>> -
>> -	kfree(desc);
>>   }
>>   
>>   void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
>> @@ -1254,6 +1260,8 @@ void setup_ghcb(void)
>>   		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>>   			snp_register_per_cpu_ghcb();
>>   
>> +		ghcb_percpu_ready = true;
>> +
>>   		return;
>>   	}
>>   
> 
