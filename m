Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1605AC9B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 07:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiIEFGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIEFGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:06:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85F62409E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 22:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dC3amOhnk3xUs3Iu5CElYikogFQj+YKNmvCpgXTD+1SUBk/bV6v1BWVjHoL0baJ+qBPS7inWcDNeQlgyo3Ijn4lU00ENu2fuUqphUO7KiuJgYWw3rCflrZHGtWNdAV3Fw3AKijGBUkRP2MpvTKrrnQq4HtBTtNwl44/dVr9tbE1Gt80Z4i0PLn/My07BVb1/J+yNMbW9rLLw+Mt6gprrDsFBzaqBnDGivRHOmS91Re3q4TddyKRYnnNUDMBneIHp5WiLGIybhPu7FIir5dGhlj9Hv1fFlP0dcqGlC2lvuNLvSllJoki8jlupCaEILpnapLXstJcbmAwWGb3sZLxKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbeO72bl1JsYqJ+gs+74fRTo3rPChLeJQYYewb5iAcE=;
 b=UNpkbvgvnhIYUMKBieU2Y7xTb2Bnf7N5fjwf8DquiLRYV3d4LfXhTgcZsEsKyFpv0BI6NsGuLAVOYql1jNamxAhwA2eK1PBTzsQEErlnS1XhlnoqT0ibX3G/EtAo0xS6D2mV48FeAGkjsRF8l7eAVTNX4B8K/GZQz+hCbWfz259s+2KepNDyFd1w+Rhu2oChN4gnCY+FKnLMnj31UTPkLfSwQ+FoaS2bTWwTVoT7wiKC5IDCWfGsfxs2YgSRr5sCFcXt74/mKm5wgBtAwQgVqZCYLV/H18lsz0O1j3PQT2nfPJXYE9ruUNioi9bLlfC5+hXGA+eQfskqdOGqV+xq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbeO72bl1JsYqJ+gs+74fRTo3rPChLeJQYYewb5iAcE=;
 b=HX8nlk7GkRqtboxryj0tZlzmOCzdV3d8sHdRgIY9gpBbNWpm/mqo+YNxQnHoLd45hMVBgjvGcL7IhWvKikRvogFMRtnd+0kIueu8Mmks9hEzeCYps3pZskuLgN4MOz9ZzOZbacYqNOPjKqKotjFgdxJVGWeMka/jtLLWW8z9k80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 05:05:57 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::7811:2fc7:9719:b545]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::7811:2fc7:9719:b545%5]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 05:05:57 +0000
Message-ID: <64519d0b-b696-db47-52c2-303451e10c09@amd.com>
Date:   Mon, 5 Sep 2022 10:35:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        ananth.narayan@amd.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <20220904010001.knlcejmw4lg2uzy3@box.shutemov.name>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20220904010001.knlcejmw4lg2uzy3@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::19) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99bfed81-5016-4385-291f-08da8efc5144
X-MS-TrafficTypeDiagnostic: DS7PR12MB5789:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRS37kMS0YhcZW2Z/+6jSSSo+CMDfZjXlNZ+6IYljDWIa6nDJKAHK6wR1kcRH1ERkdaQnq3BWe0akvT5HupyX4ZMM0Yu+Jkv3BpXB6NNyLYKninDEeVRNe33wgM6r2DPioxECm101kBtOyikjLygr869Wa4qAmlOV3Bd9FH9BbBTbjRitKx9jvZEXo11Pe3+awVQLCUhoOFrt+0rzNX521kkDipO5pBrAo2QwNjJk/4i3CH4ZL9rHrJrqEdN9Lw9hl62U+5X/46gVLXHgprdjxcCOywTRnn3HMvtqQbxnu9pHkU6knJBe0z0gtA7KeKtbNnpXEEl6re5R7/yIQcNVX80DLHZz/j/SdeItUyASpeBFzR09qm7/gYFIYVQIoGVnwKQWVXI4Hv2lMt9B1r+d+loaY3OGJTRUnRSSifXvDUd3O9nPh3mjPSj+JXQQ8IFHZtP9+lUXT3k3tYBvhm9AnLDrjZdNCjkY2H7est36b1LSJidNC1THc4nqsuf/VrIY2BBzhxYQvJuXNvo17VYRUOVGXwzpiZQOiWYtV1FqtbgXN4hX2ierGy5JE/bWUA5QveTvg/It2GN35k/v9S+A0W2KIUtShoOERFgV0W46wWUn9gQXxxOJZWYxjPQlj09hCHlVb93ajvSIfshGxFKS4f1r4m33cDQx3gb1DHgmX+ebXI3aWflFcYRNz5bH0KzH6SSDoNt8VrWbm5lHR3ToIom2NmPyw9zGvxRt0WZc7EySrN04WIKyKIGNqMvCR9A85MykC/Ck1EmNL2ckob4CwnFyqVsrJTfEPn6wqtoMWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(6512007)(8936002)(186003)(2616005)(6506007)(7416002)(26005)(5660300002)(53546011)(31686004)(36756003)(6486002)(41300700001)(86362001)(6666004)(478600001)(54906003)(31696002)(2906002)(110136005)(316002)(38100700002)(66476007)(8676002)(66556008)(66946007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVUzVlA1TVNWMkg3V3RRNmxMekJXOWQycy9ZVEk5dWEyWGUyYkZRYmQ3alk3?=
 =?utf-8?B?bjkrWWZGM2NBNG1XZzF6VFZTczhpTWhVTkJmdGk4Tkp1cU1CVlJsK0VkZlFK?=
 =?utf-8?B?UzM0R0dtc0Z4QzZRcGtyR2hFcTkvZEpIRDJaUzg4ZEVQbXBZVXZseXg4VFo3?=
 =?utf-8?B?M2NEZ2UvVy9OZ3lNWkZHVHc5N3lnQXBwYVpNMHVXd01RaXBTMXNSSDB0NWds?=
 =?utf-8?B?OGZnOGdJOG9MbUVZN3YvSStSK25WOE9tbDljS3ZsRlJNRlRxa2NvM2xrNjdI?=
 =?utf-8?B?bzlXL0dDSzVCb1N2SEhXT1RUbmltdzBFQ0xqRW1vTVk5SDNBN05iOWVrZ29L?=
 =?utf-8?B?TU5iaHFaYmpSN0Y1UU1FeDhTLzJDazZ3YmNaU1dmSTV5OFR5U2t1RjZFbEYr?=
 =?utf-8?B?U2QzWjM4ejFmbnhHbDg2c3lBYm1WNWorOHJmL1VSVFRHbVhHVTZVVjVjaDFI?=
 =?utf-8?B?TFREUkJYVWdQWWhJU2RHMHIwSzZCMWV4VjNlRytaZkRTZ082bStsdmYvVUk5?=
 =?utf-8?B?d0NBVFBrNG56TlZRVVJVRk5TdGd4SkN2SldyU1Z3dU1EeEFRZXV4RTZ6WkVa?=
 =?utf-8?B?MzFiSTRJYjI4ZnJ5TFJZMUd1SnRIcHQxeStLc3V0Zk8ydWJwVFJGN044MjlG?=
 =?utf-8?B?Nk4vaFdMa203Rjlhanp3Q1BLcisxMFV4ZG5IOEhqdVNQRjFMV2FFWHRxR3Vn?=
 =?utf-8?B?QVE2bTloUUVqVTRyT0lqV0tJSThGcmZob1EzQnAzcEt6UzNmYytlK1FxWm5u?=
 =?utf-8?B?SCsybkVRTktsZFVnWW9HVEMvK2poT1dkdmtPOVBLbmMvaXQ1bjg2UTFxOHVM?=
 =?utf-8?B?SXRFczF1QXhEWGNvbFZ4YnpzMGZUUUhFNUNuWmZuVXIwQXZwUEt5Q2NIVkpn?=
 =?utf-8?B?K1YrK3NDanFmaUo3Yy9iMTJKVytZeUhEUVVCakx3a2RnVUsxMFNMd3RQQytT?=
 =?utf-8?B?V1ovNmhQYWpqRzhZekwyTlQrc1FrMXhrNVRxclVCUEh1OXFIejJnSEhZM2RL?=
 =?utf-8?B?c2NQbnkwbHpxSTlxRmNDWklxNzBvVDRpeHFRTEQrTzYxbGFDR0NMMHREak1v?=
 =?utf-8?B?MmREWW5ZeGcyNjZpZUVSR08yT3JjbzBjT3NKcVpBRm8yT21hV0Voa0pUTnNa?=
 =?utf-8?B?VjZVNVUvd0s2U0ZZZ3cvKzZibitta3huRVRMUUptNTdUQkc2VFB1OWVCZXpF?=
 =?utf-8?B?dzhYbHF6a1dRRFBnM1lWbVphbHpjQWRJeEdKRnBzNVVuYWF2RFZpblBLRjdP?=
 =?utf-8?B?dFRKcUxLdFd1QUZQQUZDSWdzcFR2WXc0WUVLUnk1djhUczE1cWFaZHhoZjRG?=
 =?utf-8?B?YW9WM2hxRDZTeXREc2IrTmQyZXN1U3djVWZNdnE5NmsxL0g1UDMzeHdrUkRk?=
 =?utf-8?B?cHo3a0E4NS9nK29hRmw5cnJKWHFUSU84YmRreDBic0kyb3ZObkpEWkppbXJr?=
 =?utf-8?B?U2J5eW9rK2FVRTdKbnE1TzF2eW1vS0ZwOFllcGp0WEFQelliNExpck16WUpa?=
 =?utf-8?B?VGpQSnF6SzR5UnN3Q1haZHBUOFhBdUxKdmxHNXUvY2VFSWV5NldPUit4VUVv?=
 =?utf-8?B?VytuNXdCVy9kSS9TU092UVFoTSt0Z3ZLVE56TVFZSzc4aERHMENubitlaXll?=
 =?utf-8?B?TndtWVRZdkZkZWhiaTEwUDlGUzJvV1JlNHhQSXdhb0lzejQxa0FPQjBqNFEz?=
 =?utf-8?B?RnBpc1Z6MkdZeVEyOGg0S0lnSjJ5Q2JrT3h6UjZWTklpUHlUS3BGQkpwcjVE?=
 =?utf-8?B?Y3c5VFJ5SkVud3NLTUFXa1dvdHBiemQ0LzVjNGhvNERrLy9zaTBaUzNRY1dh?=
 =?utf-8?B?V3lCcXg5R3ZReElUSVB3K3pRYXhzbWVpZEhWMmpBbFp1TGl0bWhvK2tGNUNz?=
 =?utf-8?B?TkVYUTljK09XREFkbEtBYUlGTmw2azUrWnBXNW1lbnZkNGZYMS9FcEM2SDNn?=
 =?utf-8?B?S3FsaDRZekFpNGdXMU4yR29nRmZUZVNsQi9kdWlzTmNPSlRyZmQ1RFlJZVRk?=
 =?utf-8?B?d3ZkQ1Zlck5YOEdRclFWNkxKNkRiajdkMG1UVUlIQklIak9KUWVobnNqZlJU?=
 =?utf-8?B?YmVuTlUrcHYzRVVjazF5ekRBN2lsbXVlclZPMVVXQ1hVc1lQb3FQNFMvLzRL?=
 =?utf-8?Q?oigydk/9PBB4N3oNwPMeI+pvS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bfed81-5016-4385-291f-08da8efc5144
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 05:05:57.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VW0cBvgvNKDgEejahGC820814+1mwxKyVIS4jlW7JVjJfhS2j3SLjtn0iCIj76gC338wBML3ldajSYOfQ55Zmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On 9/4/2022 6:30 AM, Kirill A. Shutemov wrote:
> On Tue, Aug 30, 2022 at 04:00:53AM +0300, Kirill A. Shutemov wrote:
>> Linear Address Masking[1] (LAM) modifies the checking that is applied to
>> 64-bit linear addresses, allowing software to use of the untranslated
>> address bits for metadata.
>>
>> The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
>> this time.
>>
>> Please review and consider applying.
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
> 
> +Bharata, Ananth.
> 
> Do you folks have any feedback on the patchset?
> 
> Looks like AMD version of the tagged pointers feature does not get
> traction as of now, but I want to be sure that the interface introduced
> here can be suitable for your future plans.
> 
> Do you see anything in the interface that can prevent it to be extended to
> the AMD feature?

The arch_prctl() extensions is generic enough that it should be good.

The untagged_addr() macro looks like this from one of the callers:

        start = untagged_addr(mm, start);
ffffffff814d39bb:       48 8b 8d 40 ff ff ff    mov    -0xc0(%rbp),%rcx
ffffffff814d39c2:       48 89 f2                mov    %rsi,%rdx
ffffffff814d39c5:       48 c1 fa 3f             sar    $0x3f,%rdx
ffffffff814d39c9:       48 0b 91 50 03 00 00    or     0x350(%rcx),%rdx
ffffffff814d39d0:       48 21 f2                and    %rsi,%rdx
ffffffff814d39d3:       49 89 d6                mov    %rdx,%r14

Can this overhead of a few additional instructions be removed for
platforms that don't have LAM feature? I haven't measured how much
overhead this effectively contributes to in real, but wonder if it is
worth optimizing for non-LAM platforms.

Regards,
Bharata.


