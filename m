Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C603C4B7202
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiBOOvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:51:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiBOOv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:51:26 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2041.outbound.protection.outlook.com [40.107.95.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9602C11986F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:49:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZbOWg8dE2Ofu3iqOsQG87VtvEHKJl0EJeUmm7NKBdD9VN7tCLZG7w+YwprXFrnvaMsa6Z/0USvcfCIMYqFdEZJIWwPBHIkgEaHczRf0XFon024alj1mF9dq3/LEXWku6yoZNi2tQ7RCsCPbPOWZCzOkbt/sIaCLUUrn2nEJDDKXEU/8R998fvP+zjBbJDQn0CNeRed4x0VGRqC63VuM0nxkGwg8npoOKH2Nqg+Mf1jCsK620R4n7RaySXN8hBNBoHcR87L90i9jdGC5D+zYmWuOF/suEue43l6k9N1IchbZ59BLtr7t90aWkfW++03EBAHKRz9KZTtS0XETGts0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRTfgkLIS5jo3lLqbgk5HFkDGZE2YzSQTOsN7z82ybc=;
 b=fFKGFWyKs+KcbFACj5ZtUMwudcDGcSvek/H6rHeH2E2AX2ERfuS3lDQVzIDSIixPeDTD0pOfetVVvBCiAG7m2OxqjBvUs8d8L70jRr/x5+JCoQNYFKMHFjtk8+/LTUuWbBUlBV/YOhkGYoBHQQjaaRyfq+AxFCbdJ0RfBxe0QQYwi6C5BBmCh4UYSPfrmzDg4oAMZz8XB/t2VVHJEaxohl19cdrhxTUryWQ2eculDkPdsBqLUkm4XxjHrXzgkK6V7F8X4y/OiSTD+b07vF5iO5EO9S6aJT/JriOuxEv++XC21eBkCMHV2S+EKxNDVaCOPtjCrAftYAyaydKNKCCD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRTfgkLIS5jo3lLqbgk5HFkDGZE2YzSQTOsN7z82ybc=;
 b=J7DEBqepB9UGgP/NrLEMSVjtRWqFWOhnG0D8SC8rFErCBilNm/I3iyABSINO/tHT6X32E4tlRzsomE7v8iyJgF4DAR8Wl6BKWaK9xczed8gI4aJaZ35jIWOobjtruPAGxd02cCXvam0tGbhbK7Da/pf9khg0BxiyYmYrnJjwMms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB3710.namprd12.prod.outlook.com (2603:10b6:208:16d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Tue, 15 Feb
 2022 14:49:37 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49%3]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:49:37 +0000
Message-ID: <f1dfc268-7b2f-9980-27ce-0b5bb1aea962@amd.com>
Date:   Tue, 15 Feb 2022 08:49:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
 <YgFIaJ8ijgQQ04Nv@zn.tnic> <1d77e91c-e151-7846-6cd4-6264236ca5ae@intel.com>
 <YgFWpGQfA84Y0mW/@zn.tnic>
 <20220214220926.fjwlyieatwjhcpij@black.fi.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220214220926.fjwlyieatwjhcpij@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:610:118::16) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48ab373b-c112-4e1c-3c42-08d9f0926325
X-MS-TrafficTypeDiagnostic: MN2PR12MB3710:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3710012C353081C8EB591455EC349@MN2PR12MB3710.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxDTsEcrsAWYkEUFs1p0dibxBSAiDD3GIIIyYl+6ediTTjmrm1A+IwQ9xnOmaZ38+o5HBAnUlE7w5MMZF/4fVlZ9ZlSLltAQEciL0wrx7YI+RfRH7GRDyq5EIyFcUr9fHjJWShwdTs9NFKBZPg2Fs5E4jVu5EqnzS7BPkaKRB04yqrXnMqZj0Yk9zzJmTBwUj5wguUTzz+XcLFg1hQ6ahiJHeFI34rFLAI3GtyRXpMU/ooFOkwQkOTbXEe9dOUaXZ9YlqKineZYHPuQlblG4WW/OlsqV2mW0Cl6oHuf1kVxDYp7f8mSlcxS35pXSgsdQRF0azIc5yOjOhdh/2ANKh4v7BfeIikhErZHPgf6Da1q3E5/yrwRWaRe14hrqlpLnwd0P28qxxLTJ7xtg+glQ40udORhb+5Uqzd16BSVQlj7tNeoFIaYz5gU3ji7Hk4Dy49xOKds/DkYIAnwhRFysEy3kGimwb3oq/3MQY22j76/Cm2dVzQuREnfyLXAaNXHx7vk3MZS13e34N7xoytnUvNvZhVFptbO8bdgWS9f9NMe8SMnkCqniYEjkF3epRBcleHXIn4AIubD5Nwob2UoDhcdKNOmQFOliVyUr1CSOkPBqe+RetECA92qOJXI+FwzdmDariNJ6BDub18WFSIM5oZuKvhdEkeG10MjzLgdWOPVuHOiOhrOZFDStxqx1NYuqJP5L7F+Q/YgtZReiE92RHdj3dTdwvm2kOI2JwhiD0TpAdlFk0KYeLwG8G0GE0lSL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(8936002)(38100700002)(66946007)(8676002)(186003)(6486002)(6666004)(4326008)(83380400001)(6512007)(508600001)(66476007)(86362001)(66556008)(6506007)(110136005)(2906002)(316002)(7416002)(53546011)(2616005)(31696002)(36756003)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N01OdWVEVCtOeWpnU2toTHNaMFhsTGZzVnhsMmNJRE9CaFFQdGRrSEg2NUg1?=
 =?utf-8?B?SXNGbk4xZHdYSnQ2aStrUjdyck9YK0hLMFBJMERTbHovVGwySGlBcWpsWWxT?=
 =?utf-8?B?YVNJQjZDWUZzUkt1Rnc4NDRYdHBaOHJLdko5SGVzK1ZHY0VSZFo4UjZQdkpk?=
 =?utf-8?B?elc4UGN4cEtVellyYmZxVDluSmFBamhmQVRmOTIxK29NU0hiNlZkWGhnN1RG?=
 =?utf-8?B?MGViSm9kSnNZWndlbnFGUlprcGRlNjJxaXY3K2lVdDhNUFdvaVdSdkhKZ2RP?=
 =?utf-8?B?STh4RHhGV3FsOU1DZjUySDN1d1NJcGxRWWprQ2pDa0tLdFNnaWxDOHlzaU5y?=
 =?utf-8?B?ZnBMeWQxV3czbFRZNENNVmtSNWx2a2x6NDNHVDRIOG84ZWdXbGd1STd1OFIx?=
 =?utf-8?B?S20xVkVYYkVDODlkVktnbW4xZTJzM3g1VS9VZHo5dFpXbWhVdGdBMmVtTXl6?=
 =?utf-8?B?MUgrMXV4Z0I1bnlVZ3VVdDhDNVlYZDY5aU5aSVo2WWliOEFZMnhpWGwwdlEv?=
 =?utf-8?B?aTRxTE5FU3BGUGp1cFgrWXRTWE1TVS91RVMxTTYrcFVKdjMyZTZjY0dkKytL?=
 =?utf-8?B?WFprRVY0eUgwZFBPK3dsU0RwQUZYeWtxR2NoaXh2TUhITWxBcWRaM2E1WnVU?=
 =?utf-8?B?bFc0aEhVcFlWckVOMFpacFE0QU5XYjZaeEVQaFdPTzVhWGdwZmdkWmRBVVRS?=
 =?utf-8?B?TVVqVml0ZEthVFVESkd1bTEzMzZwdGJhU2Y5a1JrZkZkeGlyUGsweVFiV1Bl?=
 =?utf-8?B?SElEN0paZWtDTzB0cDBUbjN6NGl1cUVIT2pTdlZkenA1OXRFeEFjVExQanZz?=
 =?utf-8?B?VXRNYUxQTmx5WWRHcTV1QmpKTnZ3UUo3bVMyM3RPOHI5b1BEM0loTEJsSmVN?=
 =?utf-8?B?bmw2cFZNR1pTTUpVZmxEdUwrK2NxV2s5TjZjZVEvaEV3YitlVVRpNS9GcVlw?=
 =?utf-8?B?ZTNsZDUyWUtSNkZTeGdTdDJGVFUxQVZDMEZpR1MxZkNTa2VDanUrd0tZN1BI?=
 =?utf-8?B?ZDNtMXRONVh2TG05SERLTXJlbzNvQWFxcUpQbWEvaVVJMVhvTmdFaHU3UXBs?=
 =?utf-8?B?dzdaalI0ZDdKMTgzbzVxNXVPSTh4Sy8rSkoyVDhzQXZMQlU5Mi9RZDg3L0Er?=
 =?utf-8?B?RnBhSTJFS0JUd3lOM1lWSFJqN0NLWUs1WExuemRGdjR6R09ucXM0Qm9FOW5m?=
 =?utf-8?B?cXVTbWRlQlZWd2tXQ3pwb0VUTFBPcWRrTDA2YUJaNFZqR2VSVFJSdjBUZlNE?=
 =?utf-8?B?TExWcXkxanl6ODVSUGJQcWJZWWw2anRBSGcwWVN4OU5NUkxZVjMvZFN6c1Bn?=
 =?utf-8?B?TkZ4ek1wbTFoblVzRU9kcUNjQ3MydGdualEzWlp1dlNMUnR0L0NKbjNpd0tD?=
 =?utf-8?B?b0o3K3UrdXJUS3Z4U2w2S1EyaUs4SDhHRGU4WThLZTRxUHpmbzF2TTl6Nnhs?=
 =?utf-8?B?bENkZXdnS2Vzd1BnbThSM2Jsdnc1Z1oxT1RzY1lzTm42WWNTcTJhTWdhV0xV?=
 =?utf-8?B?Y2NvQ1Z6eGljcW9HUWFoQ052Z0lqWkgzZDJxZlBGOWVOOVNIVVplbUxqNzBk?=
 =?utf-8?B?bmpiMERrd3h6RWRXTTlKSEpxd3pjQ1N6SDMxRFN2Y3I1aFRRK1VHRStpZS9w?=
 =?utf-8?B?MWFUZG9ZeHI2QThPMlMwS1B2SUZaaXVTWTNkQlljak42OHVQZzZmUDJCVlAx?=
 =?utf-8?B?THEyNjRqSlpLc2ZrWVo4MUtnMlVMcjFFdjQ1VnVTZjhkRzk0Y2RlaW5xVk5k?=
 =?utf-8?B?dVZtamR6dUhvV1RPQmUra2htUis3UEZxb3U0STRXR2ExOVB4M05tajdWRlo4?=
 =?utf-8?B?ckZiRE1iaUtOeUNZRE1TUk5NUCt2azRCUVpwQVBDT1lLZDNmVk9GeHd4ck1R?=
 =?utf-8?B?WGVjOU9hM3QxV2NTVWwwMTNaMGwxTzZKcTRubFZDcFRxVHFCTW8zMU1NVUNx?=
 =?utf-8?B?RmZVckVMRkR5S0lTNmcvZFNXWnJOZ1cxSm5ybEJBNTErbmFTdFMxOWJuK2k2?=
 =?utf-8?B?cjRvenROTHlVaFduaHBEUXdOS1RnVnlkUHBlcWk1WXEwVHBQYXRESzJjWHdQ?=
 =?utf-8?B?MzJKM21uc1NqekxxVVF4c0NHREgyZVVRYS8vQWNTNUJ6VXc1dDIzN0l1VDQx?=
 =?utf-8?B?TjNTckVPWHg1b1orTHBna2Q0aHRBMm1HajgxNllVMEF2clpaNUxLT1NpMUg0?=
 =?utf-8?Q?fqYe1dhprFlWTop2R0E8JUM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ab373b-c112-4e1c-3c42-08d9f0926325
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 14:49:37.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jb44L3f/4rRQvJWisQui3ke0rReRtgCMnDBZp7EYITW3OV7BBbzgvfjj85yAyVYuB5E1ZjV3fmhRQaU/oa1s8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3710
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 16:09, Kirill A. Shutemov wrote:
> On Mon, Feb 07, 2022 at 06:28:04PM +0100, Borislav Petkov wrote:
>> On Mon, Feb 07, 2022 at 08:57:39AM -0800, Dave Hansen wrote:
>>> We can surely *do* this with cc_something() helpers.  It's just not as
>>> easy as making cc_set/cc_clear().
>>
>> Sure, that's easy: cc_pgprot_{enc,dec}() or so.
> 
> So, I've ended up with this in <asm/pgtable.h>
> 
> /*
>   * Macros to add or remove encryption attribute
>   */
> #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> pgprotval_t cc_enc(pgprotval_t protval);
> pgprotval_t cc_dec(pgprotval_t protval);
> #define pgprot_encrypted(prot)	__pgprot(cc_enc(pgprot_val(prot)))
> #define pgprot_decrypted(prot)	__pgprot(cc_dec(pgprot_val(prot)))
> #else
> #define pgprot_encrypted(prot) (prot)
> #define pgprot_decrypted(prot) (prot)
> #endif

A couple of things. I think cc_pgprot_enc() and cc_pgprot_dec() would be 
more descriptive/better names to use here.

Also, can they be defined in include/linux/cc_platform.h (with two 
versions based on CONFIG_ARCH_HAS_CC_PLATFORM) and have that included 
here? Or is there some header file include issues when trying to include 
it? That would clean this block up into just two lines.

Thanks,
Tom

> 
> And cc_platform.c:
> 
> pgprotval_t cc_enc(pgprotval_t protval)
> {
> 	if (sme_me_mask)
> 		return __sme_set(protval);
> 	else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> 		return protval & ~tdx_shared_mask();
> 	else
> 		return protval;
> }
> 
> pgprotval_t cc_dec(pgprotval_t protval)
> {
> 	if (sme_me_mask)
> 		return __sme_clr(protval);
> 	else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> 		return protval | tdx_shared_mask();
> 	else
> 		return protval;
> }
> EXPORT_SYMBOL_GPL(cc_dec);
