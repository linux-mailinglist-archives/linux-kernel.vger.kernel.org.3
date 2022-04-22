Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1294050BEE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiDVRlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiDVRlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:41:23 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2081.outbound.protection.outlook.com [40.107.102.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C847AE1CE9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USkfdyuKazD4CFVuvRPShtaDzIzhu8Clnc1p+UxXz+PP3Punt6ZR1obsaYh/css6u4kpzz8zGDCaT/EBkt8f6JG6/q1zhn5FajWaqYuiGlIBUM1WbgHCql6Max2n9bh+TRLNgJNWbtF/NH/lwppnQv/68JZqws02WzpM4ulvmmnZraZK4eC8rZVb7Lv2bmhx2MhPKS3gHmmD2jGhRIHiaenJTIuwpM473UyhAQqiNjSGoDjkuOP/noNGLrfN1stfnExctiY0MN7oJHCBXtN93uebE+I1MyGCam+ZWr0+mbznMz7b11UgvXfQkXnCzt44uLFqic3TZF95vxMqfYX8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o//bJ76awndrxPuDsErQs2FtHqw5TU3tPx0GpyJvlOI=;
 b=Uofvh2pJJId1a+ZZik8c/O7Yk19WgytOQVHvg3RvfcmdSoFNWFo+F27McB6XHmYw5h7gVHpRfzV6eobpqJulfqK+uGbO4vsKWIGn/7leZjNzF5Xi06GI1+QPXA0qaJClAFPk37O5aU0u9V3kDeCoCrEsj0UZ1QjMRw4/688JGlZQcg4J/TL+qX1hAybCzcSeWXsgUJpbpenmCpuaB+dmYmBf0c0nebPuYvFQoFQx/YqW6wT6jQfAgjhjkVMxCfnfoPRg84x8sJ48+zoJd/z18Mdx7beCy3tQhR/OaYFQppSLxCxN00gVRy9FrP12PUt11sQIQ7ApCAqpWW8FOq4QAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o//bJ76awndrxPuDsErQs2FtHqw5TU3tPx0GpyJvlOI=;
 b=iFvzPxz/O+dN+Bv5ukAUbyZcuS+WAYm+uSm2+kRgncyxRel8HClJEgPNIULiD9d1XFZD2cuW13nTcMzFhmqjCj0V3D7em1MEhinb/oW8B5Jx+5xw3M8hRQ4bwb0lkrnzIWAIwQW20muEebazh6iXrEYcqvU/KhFHa5ykXAT6j28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 17:27:14 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7%7]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 17:27:14 +0000
Message-ID: <44b72da3-05d3-a9cb-eb74-43295383c9d0@amd.com>
Date:   Fri, 22 Apr 2022 12:27:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] x86/sev: Get the AP jump table address from
 secrets page
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20220422135624.114172-1-michael.roth@amd.com>
 <20220422135624.114172-3-michael.roth@amd.com>
 <c3baaf5d-db99-f432-125f-9884b57b40ef@amd.com>
 <20220422154056.lhzmii34he6blvwv@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220422154056.lhzmii34he6blvwv@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:806:f2::29) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fe3e955-4776-4cae-88d8-08da24855726
X-MS-TrafficTypeDiagnostic: MN2PR12MB4160:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB416015C00697DCF58C00E0D8ECF79@MN2PR12MB4160.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: feBwBdh1efCZYd1F6MuphN6MBz4hbyMLFA7tVxF77HkoeGRkIrkLwco1mAC51ofSnaBjeNOyjVR1+7f94sAWoTz9pfAfDbQ+4d2Nk+eMD95ZuIk9QlcUgPq4OACFn71fD24M/aAqOI4foYh+D3JOJ3d214+wCo7eKxjGD0e/V0Fyw3JDECXTPx2wKYW5Y3JKXnWLvidQUTcUg8RpHWoc16lGG3NqRWS25MB6ORWTUCssZaPPzmHjz/FGhwdpd0qYt34QCS5GuKFwElUPiuVqf9xkTo8WljcPD6niF2msdGw1lde6+OdwOaLuzdm2olVgx+6QNh7ERDQJu821T7gJB5knZfc5GvFtEtaD4EnYbM9PNj8JvXF/WX5+QuRIsoGmAIs/ouwU5uPomV0GvorRYyJS+Paa6GgtJWtMBceDmMZBjam2BBy5RXkDsx7PsM9sWb8HePnacd8YLwXqwj8FNJOxjYOfwDk4R9oa5JCkUoeSfh4DmI0cWa8xcGgbvyCuGVeMpgwaNkAFKIHtHP3uqg8dyebn6URg1nTopCM7lZUvZ+91tRJ6SgG8TrKSUDBVVepOa+rB7zoRM7cFaM68ZK/9ON7ehA33B0dYBYjy5eIHypnXZpFzAM0Vr4L4ibvTNiB+slnZ10lpnMjRfJ+XjF9ZwIG0wtbo25ustC9MLGKPB+aohyubezFUlV7HLlL6SSdJGPBY5U/hsZeMudfCQRJlpKzjNExecHU/PU4QyhklZHkH3GTff1+ZKhHib86GghmLU+YNEcaMQpMKC+9QXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6862004)(4326008)(5660300002)(8676002)(66946007)(66556008)(66476007)(36756003)(53546011)(31686004)(86362001)(7416002)(6506007)(316002)(508600001)(6486002)(2906002)(37006003)(6636002)(54906003)(83380400001)(8936002)(6512007)(2616005)(26005)(31696002)(186003)(6666004)(38100700002)(15583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWphZ01kYllzbGVCekZ4TGhUMG4zQXVjekd5dkJ4YnR0Q05EbVl0YkNNWEs1?=
 =?utf-8?B?WTMxNUlwQVR4eEszSnlabmRSSlhTWHkrS29GUTh3U25URGpuYUpYUmRPV0Q3?=
 =?utf-8?B?VFhYQ0dZeUo3ckdsdFVYYmRBQ2orMG5Qam1YejAzd0YzbUgwUEdzMjdFQWpv?=
 =?utf-8?B?Tm40aVlOYTFpWHh4bGhBU0FVaDErL2hXL0pvbkI3aGI4SmRlejRBU0xweWo1?=
 =?utf-8?B?aDdRQkhSRkIyN1dZSTVWTjA2bm0wcnBkU1IzQmtVdWlzMnVZdUpXRVpSY3k4?=
 =?utf-8?B?Z2dnWm1sQmNPeGg5LytRMWVyV1VSVE43UGlRZ3dHYmtuNStMVkhjWjg5N2x1?=
 =?utf-8?B?S3B6N3B2NW5yckJmNVJzQUQrcFNWUUhvQmJoKzIzSzlvMlh0WVhWT0pNOGxT?=
 =?utf-8?B?SDBuaFJVZ21LTXhSODY3RmxOWVU5SUtTR3kyQzdDdnpxNSs0U0d1TktlYWtv?=
 =?utf-8?B?SVBjNlQyUmZXTjY5YmkxMy9NMnZ5ZGhFUXdZRnhaTUIzZFo1a3VXSnJQYjBx?=
 =?utf-8?B?QytLK3RxN1JubXBCb2hQZlRjT2NjeEJWMHAweDZ2Tm5KTEtndmtDQWhYMXJT?=
 =?utf-8?B?VkE1VzJFeXk3cmFRNWwrUjZKa01zeHYvNVJybDVyNHFmYllGZWVMZFVCZXdY?=
 =?utf-8?B?U25OQ1crMmxwNHJWVk9SRFZMMFprMWcrdjMybjhHYjhJMXBOK1R2L1diZG1G?=
 =?utf-8?B?MWl1bTd0VGFiRE8xcWhRSmoxMlRnbEExYWJTQzlKeVRpWkFnVlRBa09rVENG?=
 =?utf-8?B?b2tlNWtHMU9CRkdmSjBrMUZCL2xTTjRKVGtwOGROZ05nODVjOG1pUjNxeHNz?=
 =?utf-8?B?OTlxRHBkSWZjbnlLY2p3Ym1hSk42dXZPRmVRWkNOckU5S1BydGZnZk11bE5M?=
 =?utf-8?B?NlQ4NGdpZHdKcytJOXJkbE5xMm9VQUx1Zkdpc3VmeWZ6MmVHbXdQQjljMDJS?=
 =?utf-8?B?VkNuZGxQRjhUQTZpS3BrMndUeDV3ekY2SURML3NZbzFTYXJRUElqV0ZUNGQ5?=
 =?utf-8?B?RkM2a0VNRlU5K3ByU25NRWxVdTZLQmoxcElDVjE2ZVBGWFozUlVTZ3RaUHJG?=
 =?utf-8?B?cGFzaFdlaS9zcW1oYklqNEtLZ0l4V3ZzaGNQa2lCcEVyRWFHNDhXQVNFdE44?=
 =?utf-8?B?K3lkd2tmK0Q2QzlCVWxzbzQxdkVpSWFLNnRFdDRMcm8wQUliTXZKYThhQW9L?=
 =?utf-8?B?bk41WlRxQU9xZ21xTnpUaUhCMjhyTVgybHhwaXdoNGFTaHQyOFp0QUJid0R3?=
 =?utf-8?B?TlNaWWZpVDJuRDRnMG85Z2xpM2xYYzE1VG1sYVk5K1lyVVJzWCtCaGxSdFVP?=
 =?utf-8?B?cndVRWo5VVZyMm5rYjdEbGJHU1dOeUtLT2h3Wjc4enl5aGZOa0ZJM3BCSWc2?=
 =?utf-8?B?bS91Z28zWEpuNDFoS1JYcTdEWVdSOWZaaVpwV2l4S0pBWjdldzF2T1pqVDJh?=
 =?utf-8?B?c2JWcjdQekZPRU1EQ3VhTUpWOEpMcDB3UkhGRVREQkxWZDRER1J4K3JsdHJy?=
 =?utf-8?B?Y1ZWMnJHejUvM0E4Njd1dk41TWZyUmpBYTRPUlVUTzBCN1cwRXFNTlVVeTFh?=
 =?utf-8?B?a0Rta2hISmlaRGtMeW51eXcwYWtKRmI0SDlJaWdVbXg5dWVJYTFtY3NwVWZ1?=
 =?utf-8?B?c1RmWHQ1SmVJOE1NZ2pKTVB0OWVOTnhkbEdIRE5PcnEwT0NBU2Z3OHhKUUNO?=
 =?utf-8?B?V0ZLaUg0TEFRRitHeXU0L1pZZHVYTVdRU0svSEdxQURUdlZhQzY2WFo2TXV6?=
 =?utf-8?B?SENMaTV2VGd6aU1CRkxoeUNoN1BiY1lUQmJoUHhvUTQ4M2pITWUrbloxaDNL?=
 =?utf-8?B?MEl5YlJvYUNHVTNzcEFMeDRDbDFZdmthRkdCMTREdS9hY20xckdwOTEwR1ZX?=
 =?utf-8?B?czdXK3FKSncrTkxUZlBWS2E4aXI0a0xadnY1R29kQlBxakx1dnJMOXJUd3Uv?=
 =?utf-8?B?bHRQZWRGQWNjVUFkdlZHSjBkVFllUkdNVG1TQ2c5Y1o2M01oS3kyVnN5NURZ?=
 =?utf-8?B?UElSem51bXZOaklIZFo4czVkT0pFd3NjcllDdzlvSXhicDhweVJ3ZlBZNVNL?=
 =?utf-8?B?VDh4RUlPVkZFWHNFRWNvL3NxWUZlRnpXd3VPMloxTHdmSllVRmk4bk9pdk1Q?=
 =?utf-8?B?aFd5NWhWUDBEVlRubmlFekZxZnNlQ2NXcTdvMVZBdjZwdFNhakJ0Ukc0UFkv?=
 =?utf-8?B?SEpVdmZldUYyWU10b2RtQks3MkJwM3BaMDhoY1R4UU8zN0RkZG5IbmRkUktx?=
 =?utf-8?B?eGdkaEtsem00cVA1dHZDdjQwbm9Xd2pWZldIRG5sUXlGbkpzWURyTW1TMG1J?=
 =?utf-8?B?czZWZVdYbkp1dzYyVnBCNHErMHpmWENBajdUMmU3UEp3M1htTEt6UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe3e955-4776-4cae-88d8-08da24855726
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 17:27:13.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpsrLPDVkEcxN7TXlw9RVQ6mq5wEE0oDnGD2Cfg7AaQAVyhOZth7bRdIxrGNoGWmvbc73Y481pR3TNP9l/7lOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 10:40, Michael Roth wrote:
> On Fri, Apr 22, 2022 at 10:15:08AM -0500, Tom Lendacky wrote:
>> On 4/22/22 08:56, Michael Roth wrote:
>>> From: Brijesh Singh <brijesh.singh@amd.com>
>>>
>>> The GHCB specification section 2.7 states that when SEV-SNP is enabled,
>>> a hypervisor must provide the AP jump table physical address through
>>
>> I missed this on the first version. It's not the hypervisor, but the guest
>> BIOS that directly provides the AP jump table physical address, in our case
>> OVMF sets the address in the SNP secrets page. This allows communication
>> between UEFI/BIOS and OS without hypervisor involvement.
> 
> How about this wording for the commit message?
> 
>    The GHCB specification section 2.7 states that when SEV-SNP is enabled,
>    a guest should not rely on the hypervisor to provide the address of the
>    AP jump table. Instead, if a guest BIOS wants provide an AP jump table,
>    it should record the address in the SNP secrets page so the guest
>    operating system can obtain it directly from there.
> 
>    Fix this on the guest kernel side by having SNP guests use the AP jump
>    table address published in the secrets page rather than issuing a GHCB
>    request to get it.

That sounds good to me.

Thanks,
Tom

> 
>>
>>> the SNP secrets pages.
>>>
>>> Fixes: 0afb6b660a6b ("x86/sev: Use SEV-SNP AP creation to start secondary CPUs")
>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>> [ mroth: improve error handling when ioremap()/memremap() return NULL ]
>>> [ mroth: don't mix function calls with declarations ]
>>> [ mroth: add missing __init ]
>>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>>
>> With the commit message change:
>>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
