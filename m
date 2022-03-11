Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAED4D5AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbiCKFoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbiCKFoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:44:10 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBDDD0057
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:43:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjZ5zAo+VjCcL3NmPwEH7G+rW0oYtyQAt0v7qOYfYJxHBZxjT/Yhh6bQDE5Wi2t4wVoWaFHz4gz6+0gAlSYJJ7sunPusykHpYq7tdLSfmO1mUYtTrclI9OYeFxIW2jpbbKeVD4aXuYXywOC/2ttdkekdUCy5PRHurCo8geSgdrxgheCZtIwk/13H64d1sDD8xCXq9a/6SstXO2uDcj9MKntRxazFC7rnWVGLxrmcQFx+1LWoYFjLW1oj4VXkkRXsQcFepq5WkvcyXpcXt3kaMEHhBHdNFJni9tkyheeC6lHrMPWy4SO4DOg+mgbRjLgCuW5XPPzokR0StgSIwshyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMj+56/ihRSt9t7sTtsPCNXI4iUFgBpMwv6HAymI64s=;
 b=FmVf8H6VwtRUKK44/aEULhLjEUqzvP6jaXSHEDxlPN7CgrFwrFf4mpiIHoMwaodDTLEZTtHz1V+JJ9Zo60Y+yW6T7uMJ5rHgeFLmRqHhyDWGpgimEQ4BmuqT0OfTKhuIPKs5NMXE2wBRAJACRV9shl2hLel5QJosxtiOhbbBKgDkRugycxqo8/wfpfTpDPgfbGzgPeL8hiuP0mmNyDf3BkPpbBmni8XKMVRPDWeY5tQHqANIIDXa9f1Vokm+Mma8cS0k6CSHm0NkOswSQUHZnOuSpkYSKzv+hQRg78lUFosNyGsZEgDtH/XBScytMJgd+JUhjTA76pQyc2DsaDK/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMj+56/ihRSt9t7sTtsPCNXI4iUFgBpMwv6HAymI64s=;
 b=XZBwMIxEi/A3LOBN8NVetPFWRT0H+UOCjqvWa9cV2nLDp/K8u8eN6UKgAmvjyeRKr0jsxyREv/mAjYVSuCcGJDnBoKbBfm6oDOKSAD8KSbqN4PfnTSUhnqv8LDL9sJeAuBPJexXkAWevwJFMRot3p1MCv2o2Juc6y7U5lHjfJqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by BY5PR12MB3651.namprd12.prod.outlook.com (2603:10b6:a03:1a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 11 Mar
 2022 05:43:02 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::4843:222b:2955:543f]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::4843:222b:2955:543f%8]) with mapi id 15.20.5038.029; Fri, 11 Mar 2022
 05:43:02 +0000
Message-ID: <de443f8b-8ce0-8664-65d6-daa767ba086b@amd.com>
Date:   Fri, 11 Mar 2022 11:12:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Dave Hansen' <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <699fb763ac054833bc8c29c9814c63b2@AcuMS.aculab.com>
 <286efdb9-7dbf-82f3-b172-29c575a3791b@intel.com>
 <f6212ddf70bc408a80d7eb690c46bccc@AcuMS.aculab.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <f6212ddf70bc408a80d7eb690c46bccc@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::20) To BY5PR12MB4289.namprd12.prod.outlook.com
 (2603:10b6:a03:204::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90030611-eda2-4114-c75d-08da03220172
X-MS-TrafficTypeDiagnostic: BY5PR12MB3651:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB36510FB75626DC627647A8C6B00C9@BY5PR12MB3651.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQmhD1DRzn0acxU/+PtEQ3nhu0TYV+Jjd0UC4y5AqqbcuZbzVdBLgiRGegcMB8/OamAPkpxQchRVXCqoYXWiKSdJsNqK8dN2I7dVAQkbnjXb/+h0GzJQWJABgRab9Z8L4Od76q+4vzPkOvNh0ksFR58BdK75JoFjzmGsZ8K2kTSCYeMUJmgz/8SmJVryMPAci5OcRDXxGEG9gqZnM+46rFjJroq72IBs3i0twQIrgcI85P3YcFdr8SHgbbkWx5gnlHhoIEAxbBoBpLMt+fR7DS44RzOr5dZiADuMjpFmrAV70LbkeC3dvSB+dJa20amKmNyS4YWSuJwgyWUF4QxURc0MRI4TYpWd44fqEMYOq5ygV8cYEIZ129zMrrnK0CIPhlFFYLjkh8Zbu9MBtd3Kvla5xGdTbMbZCWAmMuaa9WhJyhRSCJLd3paS/8olHrMkIdZBaSRISHCPrLdVvbYZGpZ02j/Oeo7D16emCsJg2Wa3f7vf/lIIcLBEPDu2n35dM3gsH5S2t2ecarrggZzXuRPPf5PjvDY6Sth1xL5T0fOUfhC9rarh7qFydWqZ+xOolbaus28HM8+ZatwjicllyxH42Hdilu5sLQiRW98eMHvppo1yjkMx75ymriXoQMPFuseevVixlqjGROJBlyix6kM3W8GTvjAt4Wo0xFZz9fx75msJxI7BS8bioWRmbZd5H7piNaPL7krbIcXAJt+uYt6wTyl+pBGRAQ0fhgv8Fmpza68xnWAIusoPkcw7rYDXqFjRdWALFOG0qBNoQ+NfwS70qboxmgrXCwhk4JeS/lJw70TW6+0Zlm3DtYU6Ahjz7Pa/YOzwkNJVc6aGziXkyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(2906002)(83380400001)(31686004)(2616005)(38100700002)(110136005)(54906003)(316002)(6486002)(5660300002)(7416002)(966005)(6512007)(8936002)(508600001)(31696002)(45080400002)(86362001)(66476007)(66946007)(4326008)(66556008)(53546011)(6506007)(8676002)(6666004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUQ2TmR6TVFQYWJObmVLM29MQXBFNWthQ0hRb21JQVN4anFzbWFWak5CNzZW?=
 =?utf-8?B?bHZTSXB1Nm1Rb2RONUJNNjN2dVhaMnhEWVFhLzB1cktDYjJyQ3BGSzJUZmZo?=
 =?utf-8?B?cklRTmlJUnVYQXNna1hUeXJmZ1pBRnhEdmxjV0JpTktTdzMvQW5zYlpaYkRi?=
 =?utf-8?B?RXQ2K0RsMHR3WStTYXE0OTFqVHBHL0pJbmxqOVlsVWpjL1RGV3VzLzZXYU82?=
 =?utf-8?B?V2c3SEpvVS9xRlY1WExSYTVlSU12V3lBWWF4cjN3Yi9tUnQzSkExU2FXUk1I?=
 =?utf-8?B?T3ZBcUJSTWw3QTNGOGllVllLY0d2VzFCZzllL3luSTk1U3FCeWo5b0tDY0VV?=
 =?utf-8?B?OW5iQXpsVUdCUS9SOEVnUUlKYmwySUJFdCtzN0dHZW9Jck1UbGhmNU0xekZy?=
 =?utf-8?B?WGpOUEJhUG5JSGw5UnMvcXgrTEtzRzFkRWE0Y0xlWU9OeEZrMVV1d3FWRk83?=
 =?utf-8?B?Mk8rbm1ITEtWMUZzSGZhMG13OVprOVZaTWlpUmlZOTRTTkJVcWdSYVR1WW1l?=
 =?utf-8?B?bHlGOXV4Wm1CKzhMbXljcllFV3NDbWJIRzZBb0YwaWNGeUNUclhQbFIxS1Fi?=
 =?utf-8?B?UHBtT0EzUG1JcGlidXRENGhHSzhYUGo4YVQxQkNTSHk5VEhKbXRMTDE3Vkhv?=
 =?utf-8?B?UnpPb2dxQ2xTN1N3ZEx2QzdXUHRNb3I5OU5CaE9NU2RDbzhyOEZSWDdsMk9o?=
 =?utf-8?B?ZjlUcDRqTVA1V2hYSmxkRTAvZkd6RGhjc2xKM01KMGlpTlVlSjF1S2xFMHhm?=
 =?utf-8?B?ak1hOGMrTTcrMHRzM0UwNi9Od0ZrZmNZck1SUWRaZytNc013TWk1RWkwbmNE?=
 =?utf-8?B?cjFOR0hLR0ZXSnhRRVYwcHRXNXcvU2UybHJRcXhmZzQzYmZCM2tqbk9VRGNp?=
 =?utf-8?B?dmJHbm8rTVIwOWJIUmVtMHdkLzRqYjlYdnNxbi90ZFVFTW91ZFBBWW1KNjJF?=
 =?utf-8?B?L1doMmEzaGZUZU1MZjBGVXBrNHFZRTB5VStMT01hRUVUQnpIK0V3c1FRWURV?=
 =?utf-8?B?QUorSmxlL3loK0xzV2llOVA3TTJMTHcyQ2E4K0pZZEFneWZlK0ttWXNGTFVU?=
 =?utf-8?B?R0x1eHBrc2s5OHo5VmEyYmdoU3hqZGdsWTloMm5mWlJFVEo1ay9DVlhKbDgv?=
 =?utf-8?B?OG4zWk0xVWd4QnRYSHhKN2cvSXR4SlRDOThDdVF0Y0phdTY3SGx5WGdPN21m?=
 =?utf-8?B?S1dUTHg2RURSY0dnRG0zRzVXaU82ZjVDcU91Vm5pZFZ5NDdxRnpIbzdCNG5W?=
 =?utf-8?B?ZWhIaWV3TURtdDFxWU5MbGxmb0x2aXJzSXlHeUJkRU1VZHg3WEV2ckVwTHNU?=
 =?utf-8?B?bWlaSlNoVmVGb3BZeVVkS0JwT2tLQmVrdkh3U0swNnlZblk0RzJpQThqbUIx?=
 =?utf-8?B?ZWNHdk83MmlGWWhRUkFNOWVNQ05LRURCd1dMcWdzTkFYOTJpd2ZoVkswaFov?=
 =?utf-8?B?YTBYa0F5SEhQbG1wVXYybmpIZm1veHpUZWg2Y1NqcitEc0ZITzh5ZVNjWktG?=
 =?utf-8?B?K1pkc2pzOUM0M1BzZHpoRS9mUkk2NkxSd1ZkbDhHejRTSWR0NEpodWpYMmFS?=
 =?utf-8?B?U2NSZEpYU3Z2VTBuQ3Z6Z1QxOXBDNzdBK1dRR0NwWDVzYUE0d05GMXBiZC9K?=
 =?utf-8?B?M2d1N0xlOUVUdUVaM0dlcGJ3K2hJdmZxaWJZUVoxOUd3SmIwOTQvZkw1eDgr?=
 =?utf-8?B?MkxLejVnbmYvdEJsdDJZcU85NWJLd3YwaHVYb1pPbDRNWk0zcFhySGlJZktz?=
 =?utf-8?B?YUhTblFVODhtN3l5OTRBTEtHYVZ0K09PeVRqS2FvNVdXbGVKZFNvMit3N0FO?=
 =?utf-8?B?amFlYU45Qy80dWRCMk41d3poMU1aL3lSZCs2NlFoeVZhZG9HaEtpcytxbUdy?=
 =?utf-8?B?MElIaFZkUWxYZ01GRy9veWYxOHFzdkc3TERjRHgyVmE2eW9wZmZWczltNy81?=
 =?utf-8?B?eFlwSHM1ZVBiL0Y5OGtydGRNNHExTjlEZTVNMldPRTNkZVNDQ3RjcThYanhj?=
 =?utf-8?B?TnZtbXMyMGtaeTdUbFBldTQ2SG5CSEtsYm5KSTFGSHA0MVVhZnA1ZENMMng3?=
 =?utf-8?B?eWdWQmJNR1VyQU9HSVR5M01zYWVpdVZOVklZemdZNG8xYU9XMGFOZG45Rldy?=
 =?utf-8?B?Y2N3UUp5WFhlTjlxSUxwY1ZSNHlCN3UydVVGMTY3K2cxbzFKcTFkanJyNVVn?=
 =?utf-8?Q?yJmsAoSJqbb5T8M12cspuuk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90030611-eda2-4114-c75d-08da03220172
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 05:43:01.8947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50D5ftIIiI7UmBjwDaBlqYx8VPSeemtDJdVaEqC+DqtyrUpF2tsn2xzGDLpBm6wnmb092AlFnR2XVxqhnp63vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3651
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/2022 10:49 PM, David Laight wrote:
> From: Dave Hansen <dave.hansen@intel.com>
>> Sent: 10 March 2022 16:46
>>
>> On 3/10/22 06:32, David Laight wrote:
>>>> UAI allows software to store a tag in the upper 7 bits of a logical
>>>> address [63:57]. When enabled, the processor will suppress the
>>>> traditional canonical address checks on the addresses. More information
>>>> about UAI can be found in section 5.10 of 'AMD64 Architecture
>>>> Programmer's Manual, Vol 2: System Programming' which is available from
>>>>
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fattachment.cgi%3Fid%3D300549&amp;data=04%7C01%7Cbharata%40amd.com%7Ca1de24223931481b3fcb08da02ba2e6f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637825295938946622%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=HijEAUq172r8YwkcCuhvl99Vk5BwE6iSROXcSQXmJHk%3D&amp;reserved=0
>>> Is that really allowing bit 63 to be used?
>>> That is normally the user-kernel bit.
>>> I can't help feeling that will just badly break things.
>>
>> Yeah, this does seem worrisome.  The LAM approach[1] retains
>> canonicality checking for bit 63.
> 
> Actually it is rather worse than 'worrisome'.
> Allowing the user all address upto the base of the valid
> kernel addresses (probably tags to 3e, but not 3f)
> means that you can't use a fast address check in access_ok().
> You are forced to use the strict test that 32bit kernels use.

From what I see, there is a single implementation of access_ok()
in arch/x86/asm/include/uaccess.h that does check if the user
address+size exceeds the limit.

Guess I am missing something, but can you please point me to the fast
implementation(that benefits from bit 63 being user/kernel address
disambiguation bit) and the strict checking in 32bit kernels that
are you are referring to?

Also I wonder here why ARM64 TBI which also uses the full upper byte
(including bit 63) for storing tag/metadata doesn't suffer from
this same problem?

Regards,
Bharata.
