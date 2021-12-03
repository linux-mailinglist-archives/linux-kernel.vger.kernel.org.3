Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE5D467C89
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358727AbhLCRc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:32:28 -0500
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com ([40.107.93.66]:64065
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245736AbhLCRc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:32:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBJpuHkUiP4uuDzrAq6c7j3/qNpJq5JrYCpuryyq1tCDGQOgWzvKQl7CCvkj6qlNO0dpeEIkHgS3O07iiB4kGVofpK/QXLpElFSPeNoL8I1iLJoQUSUzRI7v3mhui4jdkrG9t4UMUjBl+yF+HoH2GvdCx9bWkekbmWslTqwUoe4HQl7wwsk7O1lCXy6tnpL6qgk44Vq/Rl4UCqH+XRJRLE5TSyEexRqiTFZKWAMLSUYd3W/j1TXGExdVqRhvGkVbnX6KvvRj8xjsJm0He83vIXvFmZoRmKOslXNKzH4MUX3I/Hss1m41iVufZxAlTJgwkGIdKTS8Jobr9Q+Ch/fFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0DSdo89471um4kVEbj17YkEv5c8TMW82R/IFLOxmWs=;
 b=TPsL6OMkX9+Plx1LYsdQjiwRpDVCeG741iCP4KZMUb/SLdYyATaYs4SclUZJ3IUoknolwmYYyVdBzN1ceDO+OXIjpARa/b2AxpnU254DD0eYy2PvhtRo1TX17INM5ZJwWZaJogpzJftBOssQ7Sak1TGtT9EBNdEi55CM5n3njjVX+b1COmEZT97foVVIhPqgzlJQ/e+hjEDmFp9RHd0j1sRIGJxJ6j9ebKg1voY8Ep3QRt4R+JcLXUmUr1TPcsM7GaZvZrzgxjSp2i3sDhiXTanTtqVbhw6akHdaAvekwDXoNNszA44P0+9IPWvkjbFiYMo6HtR+VB+urqHqYtzbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0DSdo89471um4kVEbj17YkEv5c8TMW82R/IFLOxmWs=;
 b=fR/yczEh9yLg5inK86m4bcrgzaIksgmBlND/vAV0QarRWfzRlM1TY2mKOv1PZZK0/SrhF4Whk1JtkberGe+2ulprU1s17SC6Sqmo7SqLT9nUdUTKknETpf+zk/NGDZ7vOgTLkmojySpfl9WeUVbc2o0HGXYg8lZi0HlK2esPwAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 17:29:01 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 17:29:01 +0000
Subject: Re: [PATCH] x86/mm: Fix PAGE_KERNEL_IO removal breakage
To:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
References: <20211202144646.23186-1-joro@8bytes.org>
 <20211202155452.jh4qnvpx52r3od67@ldmartin-desk2>
 <20211203002513.fa43j6uvsn2ho4mm@ldmartin-desk2>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <35ba181f-c182-aa74-07e2-fcff94bf345a@amd.com>
Date:   Fri, 3 Dec 2021 11:28:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20211203002513.fa43j6uvsn2ho4mm@ldmartin-desk2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:806:6e::26) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by SA9PR11CA0021.namprd11.prod.outlook.com (2603:10b6:806:6e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Fri, 3 Dec 2021 17:29:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d6d8fb5-d39a-460e-57f7-08d9b6826553
X-MS-TrafficTypeDiagnostic: DM4PR12MB5133:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5133FBDDC2BFFD379DC6C219EC6A9@DM4PR12MB5133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:208;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctfLM4/T66u5CYdWva2yni4OOayDafRu2v0kaQ8kBFCq+bUGwEH9Sue35BuRyn25BoV7xIww8GivJLf+HPkTTZcHjk5ZCZUNWAHFiPEUmEpn03HOw7ESTaCvxuacY6FZBo4vWF4HSZcY+48NYBHng5aTHUiHL4YAnOG136ct84UxlPuaOJigSfN5OV+UNFXqeNH3sBZ7XkkSP7N3S7e0+44oakOJSteu0N5ZHQ6CnQwEGRImj2avWnC6zFkzlCqflU99bbTlBW1IVWKklWe3JEfRihCGwwReEHCgJCYPxJ57YIGVf7mX6CZwBrW2VwoBg9WXmTK1reomNqD9u8jS3u7T/vMElb4RRR4LxS3gGFwVSXWxcUajL86qHypv0HAkWJkJnNISC9+QNTNG+/xR21G10pCMGx4GxyQ9ymAjbmkoYgWmtPMSr6g/tqW2Qa4R7Tnn7XPbYtgKEsAZ5YOQmUPZ0KyXKOMzo9HLaB/cU/VIIFiSEg2WxW37ZPnqGIn4zrUDXS0wPx24IhAAYrQulYw4SU43JCUGPi5NBKfeoXe00//NNZyXc/9WLNwgDGu6J+WefiswRKj19bKs36aoVbooTtbFiho3owN+t5cbzvUXBfk939EtjNZXuasuB2X9AdS3FDd50fijBkILkFSAZXpZW9Ug3mVQfGxXTXn9NPZypiygAt+BR4bO0tqcg3varF9RZnYOROLqeGI4S9yhoJpNbOY4IYoDB7pNWyhxQROn7+cBbfgT7TASpG7cMvNf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(86362001)(8936002)(53546011)(6512007)(6486002)(186003)(26005)(31696002)(66946007)(508600001)(8676002)(2906002)(6506007)(83380400001)(2616005)(316002)(7416002)(110136005)(54906003)(66476007)(4326008)(5660300002)(66556008)(31686004)(36756003)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBLZmtkalZMMWlNZVdDenFmWkc4WE1ZZHc0cUZGTUU5bTBOd3h6OWFtQnAr?=
 =?utf-8?B?UXYvSEs4aUtEelhwZDh5dmhJd0RLbzhSQUl1a2FDdnV0NUhFaVBBYlBFZS9L?=
 =?utf-8?B?R0JvamszWXlZL2R4UVlPYkx0ZHZTOGgvNGZvS0ZsUkFWK3hRVEZBelptSDNF?=
 =?utf-8?B?V0phbWlmSHUvUnBWVEdobmpsNEUyVzBJOGQxOGh6eHk3Znk2Qm02M1pXeDBp?=
 =?utf-8?B?ejBLMXA1ZHpCVXZjWks4Q1o0aWk1d094MnVML3pxN3dQV1RoYzREcmlFS0ZS?=
 =?utf-8?B?ZDlvMU1YbDhZbmtNVmsvMEJnOERqMEZGSzEwMkRvLzdaTWlZZzQ2MnVkKzhZ?=
 =?utf-8?B?aDdQWEl0ZkNlTU1iM0R0MEN3RFRVME11QW1rYUV6UkU0YWpvRU14MVlMN294?=
 =?utf-8?B?UFlZdXdIMWRvaW5YM054eWI5Qk9DUEQ2dTJobFJDY3JXYS9BNDJ2eVJBZmhQ?=
 =?utf-8?B?K2oxdXJVdnpBTU52K1hiTnVmUk1UbEJXMGgrZmthczF4WG1vWjVnK3VENHMv?=
 =?utf-8?B?cWNmTlozV0d2YWlCV0JtMkIyZlgrdWNoY1hNRHRwSllzZmpmSm1YY3pPMjhy?=
 =?utf-8?B?bHMwU2hUL1gySkZtdGljbGJQZ3ByVmxjUDYyYjYwQ2ZtZ1FnS3ZOV05LZjBh?=
 =?utf-8?B?T2QxS2FDZytRYzlLbUFPeXFQSzljcHY4L1BrWVZZamFvU2dUbTJJZmhNZ1Jh?=
 =?utf-8?B?eGNoUWtMeldxVTF4dFp0K0pvay9XS3NLcEttRkx1MzF6ZzRHdmp6L1NjSEQ1?=
 =?utf-8?B?WSttZ3p5RVZoaHhEVlM5KzdUSlkrdHQyQ3FwMmFnZE92cGQ1SmErUGtROURK?=
 =?utf-8?B?VGhoVlc4UVlaNEdPVVQzMVVXUGJDMEM2bFdrNHhoMmsrcmhqWlphd1BLc3do?=
 =?utf-8?B?QVF5dmk1RENnck5GcVI4b1loakp3UDdrR3o4QktsTW1NTGJoYk9qdnNrTDRy?=
 =?utf-8?B?anloNnBMMlRDcU1HS0gzMXVxbDV6OE5XVlJqYWl1c0E4cGxZelFCWlRoSUNP?=
 =?utf-8?B?K0g1N01HMWM4SG15Z1RCOXNRTGlScTdyN3BLRXNhdmpsRGJsTnRjUjhLcTFr?=
 =?utf-8?B?RzY0blBQcGMzNGwvdUR6dUx4UTB6MzF6NTN3N1ZaUnBXaytGRmMvRWZxNURv?=
 =?utf-8?B?SGRuTmI5TWlNUmx4aEE1NDk3MG5HeGhlNGNNVDhXU1UyaFdSejk0YjlGUGIw?=
 =?utf-8?B?T2lXcXhkT3lWSXV4WEVra1ZPbks4U1FPQklWRVd6VHBUN1JCUk1IQ1NXeXcx?=
 =?utf-8?B?WFdSMFpaK3NhYW9Uekw1T2hQaTN2b09MT2RXbzhuUVNmYmJZZGJoTW8ya3VV?=
 =?utf-8?B?K2t5cU84UkV0TGRyWkZkOGs3dURXUkY4aUpDWjE5eDdDQmhiREc2dTBtVjhV?=
 =?utf-8?B?Z1ZNQm1Gald4djlReG5KNTFIVFhSbFg2K2NnK050cTBpUnh3aWN3eEx6M2w5?=
 =?utf-8?B?VmttaC9VV1pLTEFiSUZ2alJkeDJSdHdUR2YwTzVrd0M2cFpJRk8ybFduekg5?=
 =?utf-8?B?c0xJM2llRkh2Mm5teGoxd1Q5WGpiOWVXU0dnRmllV2h4K092OTArL3ZxN2Ux?=
 =?utf-8?B?NjJlS0VnWkNFeStQV29tYXFrTmFwYXg4aVRBR3BscGY1R3FCNmd1eGJWbHdh?=
 =?utf-8?B?Mm1rS0tsb1BKQXZNLzdUTEtNTmludkZBekZYazBiVFVtaW1KdEtNV3puRVRn?=
 =?utf-8?B?dGtSL3NWb28vOVNhZWxQOXRjaHFUeGI1REhTT0h5d0xFQmZKSC9VNmszeU0y?=
 =?utf-8?B?WUN2ZU5XY3R2TzQ5V1pJMllsc0ZnVHlmRk1JVGFHeXpXcEd2L0o0SWJwNVBP?=
 =?utf-8?B?dm9UQ0s4QXJzbFAwek9NSk5rTDBxY2o3QmRPeFloTjVvYm01aVVUNXdZbXRY?=
 =?utf-8?B?ZjRpN29yNWZOZi9KYVBsd0s1TkpsMHpOWThJM3FIa2hTQXBGUmFLbXhHQmdu?=
 =?utf-8?B?ak1wTkl6WW9lQVdvWDZuMFRJdmNsbmhBOE1rTGhpNlY1Q3pNMWs1ZlZJNVVl?=
 =?utf-8?B?WUJRL3hGS3owY2NQMjlHY0ttVFdNbXlieU9iV0JIZjFHWS8xUzlocXV2ZDNI?=
 =?utf-8?B?aEZ0c245QUc5SkpJSUNmOWRPMFYzbGZKaWxua1lYUFk4K1kxRU8xdlNST3lw?=
 =?utf-8?B?NFg5MWNDQThwY3d4c2gvQnpFZjRPbjNTTXJlWW1ERWhvcEd4MzBmMG1Ia08y?=
 =?utf-8?Q?Zj00mvuRGi4dTv45HIODRIc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6d8fb5-d39a-460e-57f7-08d9b6826553
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 17:29:01.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3g+MNlovRMK8q1yTsnBMK4bilEXfgAzGeNrBaQzoNmO6v52CTnuwfxkp+an9kZ052cpsUpq3aTthaRA70/nttg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 6:25 PM, Lucas De Marchi wrote:
> On Thu, Dec 02, 2021 at 07:55:14AM -0800, Lucas De Marchi wrote:
>> On Thu, Dec 02, 2021 at 03:46:46PM +0100, Joerg Roedel wrote:
>>> From: Joerg Roedel <jroedel@suse.de>
>>>
>>> The removal of PAGE_KERNEL_IO broke SEV-ES because it changed the
>>> mapping of ioremap and some fixmap areas (like the local APIC page)
>>> from unencrypted to encrypted. Change those mappings back to
>>> be unencrypted.
>>>
>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>> Fixes: 27dff0f58bde ("x86/mm: Nuke PAGE_KERNEL_IO")
>>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>>
>> oops, missed the fact PAGE_KERNEL had `| ENC` while PAGE_KERENL_IO
>> didn't have it. Thanks for the fixup.
> 
> on a second thought, the fact that PAGE_KERNEL is _not_ the same as
> PAGE_KERNEL_IO, completely invalidates those 2 patches I sent. It seems
> I screwed it up big here.
> 
> About the first patch,
> 6b2a2138cf36 ("drm/i915/gem: Stop using PAGE_KERNEL_IO"),
> I didn't notice any regression on the i915
> side though. Is it safe to keep it? Otherwise we are probably better
> off reverting everything.
> 
> I'm wondering why the addition of memory encryption
> in 21729f81ce8a ("x86/mm: Provide general kernel support for memory 
> encryption")
> didn't break io_mapping_init_wc() though as it had already done a
> s/PAGE_KERNEL_IO/PAGE_KERNEL/ in commit
> ac96b5566926 ("io-mapping.h: s/PAGE_KERNEL_IO/PAGE_KERNEL/")

If I follow it correctly, since SME/SEV-ES are X86_64 only, 
io_mapping_init_wc() takes the ioremap_wc() path which uses 
PAGE_KERNEL_IO. iomap_create_wc() is only called when 
CONFIG_HAVE_ATOMIC_IOMAP is set, which isn't set for X86_64.

Thanks,
Tom

> 
> thanks
> Lucas De Marchi
> 
>>
>> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>> Lucas De Marchi
>>
>>> ---
>>> arch/x86/include/asm/fixmap.h        |  2 +-
>>> arch/x86/include/asm/pgtable_types.h | 21 +++++++++++----------
>>> arch/x86/mm/ioremap.c                |  2 +-
>>> 3 files changed, 13 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
>>> index 5e186a69db10..a2eaf265f784 100644
>>> --- a/arch/x86/include/asm/fixmap.h
>>> +++ b/arch/x86/include/asm/fixmap.h
>>> @@ -173,7 +173,7 @@ static inline void __set_fixmap(enum 
>>> fixed_addresses idx,
>>> * supported for MMIO addresses, so make sure that the memory encryption
>>> * mask is not part of the page attributes.
>>> */
>>> -#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
>>> +#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE_NOENC
>>>
>>> /*
>>> * Early memremap routines used for in-place encryption. The mappings 
>>> created
>>> diff --git a/arch/x86/include/asm/pgtable_types.h 
>>> b/arch/x86/include/asm/pgtable_types.h
>>> index a87224767ff3..fc9b6995cb22 100644
>>> --- a/arch/x86/include/asm/pgtable_types.h
>>> +++ b/arch/x86/include/asm/pgtable_types.h
>>> @@ -208,16 +208,17 @@ enum page_cache_mode {
>>>
>>> #define __pgprot_mask(x)    __pgprot((x) & __default_kernel_pte_mask)
>>>
>>> -#define PAGE_KERNEL        __pgprot_mask(__PAGE_KERNEL            | _ENC)
>>> -#define PAGE_KERNEL_NOENC    __pgprot_mask(__PAGE_KERNEL            
>>> |    0)
>>> -#define PAGE_KERNEL_RO        __pgprot_mask(__PAGE_KERNEL_RO         | 
>>> _ENC)
>>> -#define PAGE_KERNEL_EXEC    __pgprot_mask(__PAGE_KERNEL_EXEC       | 
>>> _ENC)
>>> -#define PAGE_KERNEL_EXEC_NOENC    
>>> __pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
>>> -#define PAGE_KERNEL_ROX        __pgprot_mask(__PAGE_KERNEL_ROX        
>>> | _ENC)
>>> -#define PAGE_KERNEL_NOCACHE    __pgprot_mask(__PAGE_KERNEL_NOCACHE    
>>> | _ENC)
>>> -#define PAGE_KERNEL_LARGE    __pgprot_mask(__PAGE_KERNEL_LARGE      | 
>>> _ENC)
>>> -#define PAGE_KERNEL_LARGE_EXEC    
>>> __pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
>>> -#define PAGE_KERNEL_VVAR    __pgprot_mask(__PAGE_KERNEL_VVAR       | 
>>> _ENC)
>>> +#define PAGE_KERNEL            __pgprot_mask(__PAGE_KERNEL            
>>> | _ENC)
>>> +#define PAGE_KERNEL_NOENC        
>>> __pgprot_mask(__PAGE_KERNEL            |    0)
>>> +#define PAGE_KERNEL_RO            
>>> __pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
>>> +#define PAGE_KERNEL_EXEC        __pgprot_mask(__PAGE_KERNEL_EXEC       
>>> | _ENC)
>>> +#define PAGE_KERNEL_EXEC_NOENC        
>>> __pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
>>> +#define PAGE_KERNEL_ROX            
>>> __pgprot_mask(__PAGE_KERNEL_ROX        | _ENC)
>>> +#define PAGE_KERNEL_NOCACHE        
>>> __pgprot_mask(__PAGE_KERNEL_NOCACHE    | _ENC)
>>> +#define PAGE_KERNEL_NOCACHE_NOENC    
>>> __pgprot_mask(__PAGE_KERNEL_NOCACHE    |    0)
>>> +#define PAGE_KERNEL_LARGE        
>>> __pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
>>> +#define PAGE_KERNEL_LARGE_EXEC        
>>> __pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
>>> +#define PAGE_KERNEL_VVAR        __pgprot_mask(__PAGE_KERNEL_VVAR       
>>> | _ENC)
>>>
>>> #endif    /* __ASSEMBLY__ */
>>>
>>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>>> index 3102dda4b152..4fe8d43d53bb 100644
>>> --- a/arch/x86/mm/ioremap.c
>>> +++ b/arch/x86/mm/ioremap.c
>>> @@ -243,7 +243,7 @@ __ioremap_caller(resource_size_t phys_addr, 
>>> unsigned long size,
>>>      * make sure the memory encryption attribute is enabled in the
>>>      * resulting mapping.
>>>      */
>>> -    prot = PAGE_KERNEL;
>>> +    prot = PAGE_KERNEL_NOENC;
>>>     if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
>>>         prot = pgprot_encrypted(prot);
>>>
>>> -- 
>>> 2.34.0
>>>
