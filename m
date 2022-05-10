Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B3E521BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245758AbiEJOTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245231AbiEJNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:47:31 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4CA2D3F71
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIxNG0TdYTBh11BRCcUnttO5kQ2vy95QXknTtZ0HwbWAAgU7P0+K3vc3BPPTJzyuaoAawh0+L/Z02cC0BTbPf8CRD5c0fZOj3W1u0ingcH0jXlmNGNTPhsEiYWS47P/wBOIRRqd4yxcoFNZtM7cS1HOqwW5thouf0uWCUeMUjUt9NQDhaQx2K2x7+QgT4zA9IKsqj8bIcl42J5NMLW76zMZKQuFbbnjNyKplIvj3PmWC1p14PcDrLkDYHRtNl/2TA/SsSkCEnUxc60mcZNLCN5UWOkoUD3PV9dlcaixXr6sf8SWCshfN2vHk9duPToLTU6rIWeOp7j+mYbs/KeJ+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgRGTzwmopzC8CQoxyorTEf4mc4vxJYIIr7gCpviWzs=;
 b=dU0dKIoj/mubtfq7+rLXTE3iXgD2q4ykVVjKLInc6ei/QUF2U/iarrK1K4Cjm3+Y0I4QuXRrhmVqKB0EqNTMVl73sHYpg9yfsrTpfXZ+4lrVyVZhJjL+vE6nHkSKtMVFGFu+W8F4YXNGcoQgleXxfE5JIumygqAOQddRNOx+aLTZXK0q10xXCqLQVT3UCOwDWd5c4Yl8GftTEoA/sUWhuHB89IjCtQKBpsB9mDcqvmE0x5fFAbaTeRltHwT+Rg/+jxIjOWY2USEob/fIirgy9zoPV76523+SJpcsfPV/myP6pxRNdeTmtc6K1gipwCRKzuvr3ySLqCNNEyRak2NewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgRGTzwmopzC8CQoxyorTEf4mc4vxJYIIr7gCpviWzs=;
 b=NE6BWavbKDZj5e8Q8jQoqwGJ3ycjL12Ff25ixnEwFXQjf4mYUDvIarBLPtqXN0AuDT06FQ0pE/ZJZe0gGw3M+jg1BezLSuboefSejDVJAeh3fBmZ34msSTPWj1N7OmhuJe+UK38F0HSgJgjNxjcAcYHEpq2RCo21XnXuIH1zakI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BN8PR12MB3347.namprd12.prod.outlook.com (2603:10b6:408:43::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 13:35:30 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::db8:5b23:acf0:6f9a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::db8:5b23:acf0:6f9a%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 13:35:30 +0000
Message-ID: <5fe161cb-6c55-6c4d-c208-16c77e115d3f@amd.com>
Date:   Tue, 10 May 2022 08:35:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] x86/mm/cpa: set PAGE_KERNEL in __set_pages_p()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
 <56f89895-601e-44c9-bda4-5fae6782e27e@amd.com> <YnpTHMvOO/pLJQ+l@hyeyoo>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <YnpTHMvOO/pLJQ+l@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:806:28::22) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d69c9c0-1ed9-47c2-ab08-08da3289f341
X-MS-TrafficTypeDiagnostic: BN8PR12MB3347:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3347EC1DDCD33F590BA25BF0ECC99@BN8PR12MB3347.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3zeQ8Er+L67NV4qctYTeMvc0UQxerqsU9BeENs5NkRkVcjaEMS3cRtehl/zzuSwekGDL0pdaJuFG+LeRhiFlCPFnqln8Nn+9nMTVWnsHHT6CiC0gDl1szY+FD2hfHgjvaJimXUBiXrOvaRHygine5I5UFlHNFMIuP7FHkM4NeJASH7/8PbNyyoOutk7ac6iw+8/QsxHJ7+yzcJ16s2qjT8iUNqg0wmMaWybDjkPaIsckAv1dts4Z61ORhoE7tH7R0MjZeaA/LqF2/cPHhmaPROoMmCw64AC+SveDnF1h5c9OuqEwEibB+yWhw/oyr7hk16qOzdav+s7Ep+TM+ff9PkgN2fv40pcszM7U4MEYmEfUMVhNlptzv7oaN6Vo3XTwvbxDAVJwozjZSTBhXyJGqJRsJViBcDw+qCgiIz5H+vS0wkEjMzWILbycdV+WMAcF9iXqSwaUYGkxsPInBt+9fYrji5zG2HT8MzYIg2wKndUs8ku8ZYNOMP8T0UBFg5wFDvrGQJfXnVJfVrou48oNWFXv7A1P83yWzDdzUCMOl2o1+ZSqSmBOnO97PghXaSCmOZKak6DfertSUvkuzcRe4Uuy9zy/lDoNRW2wxt0ri4fEEXtXHabM3xoocrN3r9Y0QcYbcH8pE7Gwp8QTnrmvr77qEJir9SzolMyUYl7qA+gmRfM7EQNs/7/DFHrfFbD8AjhkEMEVBTQP9nCz9zCy1sUzpq52rDPU2sEG6JOf/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(6512007)(54906003)(8936002)(86362001)(31696002)(2906002)(508600001)(6506007)(6486002)(316002)(5660300002)(36756003)(38100700002)(4326008)(53546011)(66946007)(66556008)(6666004)(31686004)(8676002)(83380400001)(186003)(2616005)(26005)(7416002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1JxWHpXVUorVHgzNUxBSzR3WWxSQW1FSE1QeDJ1dmU4L21UcHpNVC95Z0dB?=
 =?utf-8?B?ZnFkdnN3cTJXUVZRN2pSTHdwQ0RHVFJuTnhqeEo3NTl6UGtzYVBiWFVYd3Vl?=
 =?utf-8?B?OEk0RFNMWWtzSThzc2lkbmowU0IzVnZveFFVM2U5UkhPQXFXMVhCOTNLVnZF?=
 =?utf-8?B?U041RVBiU2szUDRlYXhEYWRwU0c1RVlIenpNb0hzR2VqNk8vdmw2S3BibHNq?=
 =?utf-8?B?dGpRWFY0aXRNV1g0UytjTzBkc0dRVXJYQVJLdEsxT2xhNGNNWklPeHdMM29G?=
 =?utf-8?B?RFpreHQ5cWFYYUJQRE9FUFdESlVQOGptYkxRVU9hVkZEL0IzR2o2WFQ0UzZY?=
 =?utf-8?B?WDVQci9NenBvWmZLUGwxVGpBbldjUWNzVlgrcmVGV2dDTDQ0VEJFS0FvMUJF?=
 =?utf-8?B?NnZ4QmFmWkkrQVovSCswZmd3QnMwRmVMaGxUdGl2VXl0NlRRT21ySzFVTmhM?=
 =?utf-8?B?Ym9zMURKa0hLRGlJaUp0ZVk2WXY3a2hsZ1BxR0JJSis1MFNLM0IrbGhTVEpw?=
 =?utf-8?B?WEo4QVRmcjF5cWpUVnVCVDU2M0lTU3pjZGVqUldQMFJKcVI2TUZnMHltMkxM?=
 =?utf-8?B?aUpxbGJvYVRwTlBBRUtSdjVMWUdTWm12bUtMbHFLNW9QcE95cmJlT0Jlb2dY?=
 =?utf-8?B?WmJIL2NvL0gzWExhbVBFN3gwZDAyZWJ5N2tORFg1VnlWbmNuSHpESVlPeVdK?=
 =?utf-8?B?T3RNT3RkTnc4RElYN0JYazByRGFmaFBhS2orZ2t3UHVvRVM0R0RONVE4a3d5?=
 =?utf-8?B?dGdtUWhhWHZibzlpcDUxNHlNL3J4Rm4rRU9nNkQyZDdtSm5YZEwzVVgybC9t?=
 =?utf-8?B?amlGSGMvYkJ1bitrakRrRzJ5RzJHZkEwN0l4RnlYeFJaUlF6THhEb1g3ekpN?=
 =?utf-8?B?V0NuenBpZGxtS2c1NERZT2pTeEZNR1pEeTVmd1N6cDZYY0JZNGloYm96MDcr?=
 =?utf-8?B?NTRjNWpZNTJmUXVXNGIrdmRqcGI3eHY5c2plakNxUFhPdnJ4VUpPU2JIemlZ?=
 =?utf-8?B?dTl3dDg3SjQrYXlZdDFrMnVCRk4zSStuc1RGeUhFUVZtSStRRXFkVTB5aWl6?=
 =?utf-8?B?TElyL1YyMWZteHFyT3o1RUNjeVhSV21TU1J3RlA0OUZncEx3U2ErVHROTUd2?=
 =?utf-8?B?MVh0NHJtWWdjcithcGdXKzJHOHJPVlQrZG90UzU0QzJzVjNrUFJCdnNUYS9S?=
 =?utf-8?B?MkVINkZnY2twVVUyd3FGUlpNV1pGZzMyakVtaE5JZUZPSjhDVXRhZnJjNnhI?=
 =?utf-8?B?VDJzUUx2WHJDejRyblNRZW9nUHU5RnNNek9ITExWaUxRcXV1Ykd4S3lQbmpR?=
 =?utf-8?B?ZjVDaElGN2wzT3kybXRXbkhlSWRQUmpKY1Y3YjJUMWd3MHcwTWJ6T3ZQMXkv?=
 =?utf-8?B?UHY2eGRLVGNObmx3MFRiQjk5aGxqMlQ0MUdiTm5lTURVNEE3elNzSkw4eGo3?=
 =?utf-8?B?emxNMThUY1VHcFIxeTFYMVB0THZjcERqWHdZU2MzdHYyZUdxbTUzaWowWlV2?=
 =?utf-8?B?ckNGaE0wOU5lbTFmNXhKNkFrZWVScVBKTldNWndLZnRBYlBwQmpqWC9GSEh1?=
 =?utf-8?B?UnZVRTVIL1RpL2ZjcGlmeVQ3OCtiTGxTMjNVendMSGpkWE9SZlkvbVM0cFI3?=
 =?utf-8?B?SERwRHFKd05CSzcrQzRtUEExR3YwSCs3aURyMjJ1MWlZbzc3TEt1OWhzbXFG?=
 =?utf-8?B?alJOSmxHODZTWlFSUjZnNlVQOGEveGJvWi9tbXJnMlVZS1RDaTBmT2lUd1Av?=
 =?utf-8?B?Y0dlNUF3RHNPWWcvRDJzV0gyaldTYVhpUzhNaWxhRVdaNnVOOHFlTktpT0w2?=
 =?utf-8?B?R3pzTG5NSDc5ZmI5WXJFblMzNHFxdGdvUzlRaTlFR3dSNW5zeGlZZWhUQmlR?=
 =?utf-8?B?WmdQMjhPQktjSEZTQzJUVWxHTDNTcHRKRGFId2RReGZReCtrM0JDR2tjNnd4?=
 =?utf-8?B?dysraWgwem8raldkeVlERkQ1SllNdG9kY3pkSnk0Z0tmZFdQQXZkQ1ZubmVT?=
 =?utf-8?B?bzhxWlRuN3l2N25ZditiZ0Y0anFZdWRUL0U5bTFCbU1Hd0xkdEloSVE3a1lG?=
 =?utf-8?B?Q1N4VjN2WmN4a3hMVWpNMnVLdmJXaTU2WW4vbXNJek5PNW5OSUloazNHeUMy?=
 =?utf-8?B?VFhCTExFRTZGSmhJcE0xSjRDd3FWR0N0cUxoOWFVKzN6dXFzOXlDUHhKWEQ3?=
 =?utf-8?B?ZEIwZUZEVGhnTjRrWEkyYWxndmVUVnZybkZwS1FUdXNVVjNGdU95Z3N5bjN6?=
 =?utf-8?B?V0M2Z25SRGcxOTVjZEdTWDEvUC9sRVZBRm53RjcvbExHdXc0blJNL2EwM2NW?=
 =?utf-8?B?QUpYQndmMFgzQ25LbVg3QlhhVEVXdzFoOGszWDVKY1NPTzAyYkVzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d69c9c0-1ed9-47c2-ab08-08da3289f341
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 13:35:30.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baWN/te16nmFKN8wXDZ7tn/go39/W4QJAvdwviXn+6xXtKRKurDvti3aQhMT5BhrvfINhgn1+xUIgYyYmX3ADg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3347
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 06:57, Hyeonggon Yoo wrote:
> On Mon, May 09, 2022 at 11:06:22AM -0500, Tom Lendacky wrote:
>> On 5/6/22 00:19, Hyeonggon Yoo wrote:
>>> __set_pages_np() not only clears _PAGE_PRESENT and _PAGE_RW, but also
>>> clears _PAGE_GLOBAL to avoid confusing _PAGE_GLOBAL as _PAGE_PROTNONE
>>> when the PTE is not present.
>>>
>>> Common usage for __set_pages_p() is to call it after __set_pages_np().
>>> Therefore calling __set_pages_p() after __set_pages_np() clears
>>> _PAGE_GLOBAL, making it unable to globally shared in TLB.
>>>
>>> As they are called by set_direct_map_{invalid,default}_noflush(),
>>> pages in direct map cannot be globally shared in TLB after being used by
>>> vmalloc, secretmem, and hibernation.
>>>
>>> So set PAGE_KERNEL isntead of __pgprot(_PAGE_PRESENT | _PAGE_RW) in
>>> __set_pages_p().
>>>
>>> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>> ---
>>>    arch/x86/mm/pat/set_memory.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>>> index abf5ed76e4b7..fcb6147c4cd4 100644
>>> --- a/arch/x86/mm/pat/set_memory.c
>>> +++ b/arch/x86/mm/pat/set_memory.c
>>> @@ -2177,7 +2177,7 @@ static int __set_pages_p(struct page *page, int numpages)
>>>    	struct cpa_data cpa = { .vaddr = &tempaddr,
>>>    				.pgd = NULL,
>>>    				.numpages = numpages,
>>> -				.mask_set = __pgprot(_PAGE_PRESENT | _PAGE_RW),
>>> +				.mask_set = PAGE_KERNEL,
>>
>> With SME/SEV, this will also (unintentionally) set the encryption bit, so I
>> don't think this is correct.
>>
> 
> Thank you for catching this.
> It seems PAGE_KERNEL was too much for  __set_pages_p().
> 
> I think __pgprot_mask(_PAGE_KERNEL | _PAGE_RW | _PAGE_GLOBAL) would be correct.
> Thoughts?

That should work, but you are counting on this function being called in a 
specific situation. Should this function ever be called from some other 
place in the kernel, in the future, that might inadvertently apply the 
global setting when it shouldn't.

I'm wondering if adding a specific helper that takes a boolean to indicate 
whether to set the global flag would be best. I'll let some of the MM 
maintainers comment about that.

Thanks,
Tom

> 
>> Thanks,
>> Tom
>>
>>>    				.mask_clr = __pgprot(0),
>>>    				.flags = 0};
> 
