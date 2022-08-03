Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A993589414
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiHCVfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiHCVe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:34:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30841A06C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYP4cywjCb0tNl0x2RJTEmw+JPmpyANpxLZGKEaxfhPz1dFJjYH7z85Hl475934W7qhTM2r7PbooBqJrDVBGbH9RYYzOOOV/GXL6txU+neUHob9h4F7AnUvDuOobrqQyhvErHJiBoJvbfNfFb3UrU5FqIjX2Sl99Zh9Aatsq2RTi1J858BMcZTYhJGTAefFiH4/MNL8+a1ZevIlR7cQSbd47eAuGqLBtJ9rMoCjBLPcnHiAy2yJwggH77ad5EIVbzRN1gr0BX1HcBgUI3lz7+S4GkHp5yrMqAA6FLxRXVJgDk+iuCEtmpefXJ56poFCssCeQNPgghsDyM1vN5JfoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp4SBTy8zOeHLPGCqd1+wWiFmclbdzRKQfxQubHTWhw=;
 b=NZLdstDbAzeuoyMBsd5s73uuhFIafyZtdQ4kkJzgX2DXf9lO1LLkJMljF2HpmPhxvYDX8nLRZMe65SlNFyHx/33x+ssqNJ1aI6pOlLa4uV4dUHITL6YyO7lbLePUBOzwmrcWY2ihHJInm3nEVQBhzUftvJvAurougOffuU4c+N2YmyshZq0PtwAQjHVun4IU84/U50YUj28Bj7S5xG35O62ivP8AelZWG2FUqRgRGbkBhFWRB9C3kNOuLxQQZLRNoNmJAOsV7koOR7nGgv5YmV9SfR8tHf49F+iaczbXUUWXXNwDjUC86djRMS4HzSIet5IPvr2HImGBlupcR0La4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp4SBTy8zOeHLPGCqd1+wWiFmclbdzRKQfxQubHTWhw=;
 b=mLkLwtwXm7vmdsf4Z7pDZyXQPPaywkk/1q9CIFZtlsji4fylOUXKq6T1QIzNxMBh4IC3na0tSCJGGYbR8M6CJzyLa8zXiDnCoMK/vL1spV75rFRDtiq/uH3VqGyDaGqfmEKJhYxxV1a2Vl26fFP1mr1+dKRb6+xZeDhCXl78Xls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 21:34:55 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 21:34:55 +0000
Message-ID: <b33876b6-96bd-afe0-3523-b51b8628616a@amd.com>
Date:   Wed, 3 Aug 2022 16:34:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1.1 1/2] x86/sev: Use per-CPU PSC structure in prep for
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
References: <1b50311c-448b-96aa-1d96-f4bfed409c1f@amd.com>
 <cover.1659550264.git.thomas.lendacky@amd.com>
 <2a2adc3570ae9c24d03fff877c4fe79ed43605e0.1659550264.git.thomas.lendacky@amd.com>
 <d5902382-70f4-be07-99f6-80d17cdfdcaa@intel.com>
 <9f47ed0f-99cc-a237-f09b-45291feffcd3@amd.com>
 <e52341be-076e-92d1-a649-421dac5a4f5d@intel.com>
 <0eccea46-648d-ff70-dcc6-fdca88ff1234@amd.com>
 <3cf239c8-ccc4-d112-fb42-605661816cf0@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <3cf239c8-ccc4-d112-fb42-605661816cf0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::18) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7960846d-7ddf-4a3f-02e4-08da759801fc
X-MS-TrafficTypeDiagnostic: BN7PR12MB2836:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Iq2gIJ95EFNPuqXj2ZOA6j5/qdQGNPL90in0j6YQWoQ0lvkXkkAqaF6TCxkcvAFrFXrvrNoAXfk/YfCftTLOcUnulpAmju27j86sXo2gm0pX/ixqRCSy07ZZbdOV9ejEVHEa4KDntrMVDOwXcA9ghUWCktjMfhNgHg+FYXagghd0Uz6TJTl7136MkEr/BgwZE8a0o82k9BQ0ECgNlBBTakuxohUj0J7FcOHDkoC5it3Gn+evriat3IYF46jci+htr7PbsrlkSc8eRWyi/V622ivU3T24EB5hz46mT4lcxiKezZkTI35L2L8UTHFALo8SX/iFx0B+feD2bf6DGz2raHjY0EQogw0XruCnz/X+L2JRbjx//lOuLgnTqbgy1U9HQW1l/+AospFdMwd3MDtJGNoFJMAmughz4JIAwPKKEjTv3H7PkKS4dhoGBPkkQ1lXsDyE+TlmQCH65Sb5pvSLyWxE4VBuhBwWgb3ib0MjX6Y+joKkGkWQwDWjBngVylg2/a8kYHGd+xyBe+gdxOZvsT0OAH5ITQlry5h5SWgPw2Vo4e2NPn/rJju+n85CQtczCCEAWAws8HFyDP3YkfbwJ8BYVEeOUyT2cikn9ihq4rfvzK1WpMXz6q4U/bIOm/rZ2rN78NV3Nk3tKuWUIh3qNi/X72IyUeiDMhFA/zH8bI1DP+oINK4PR8XcHJ4PRvci4NI/lkxUncosPha4P06QgE92meHAiEpWwlUUvwKHSJpCVHfsd7N0xTXSDQVzVN8tcFHnx3k230QqFQq515agN5F2JXRreO4n023a3M84Xxc+n+mI/Pb0dCbV3b1f+6XOY2DfENl0FM8nqalUR0Mmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(38100700002)(26005)(6512007)(66946007)(31696002)(66476007)(8676002)(66556008)(4326008)(54906003)(86362001)(6506007)(316002)(83380400001)(53546011)(7416002)(2616005)(36756003)(31686004)(186003)(6486002)(5660300002)(478600001)(41300700001)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFRSS2JicXZxdStVak1Xb25zWTJralRLcS9pbm53VEhRaGJ6TTUrUG4zK2lD?=
 =?utf-8?B?UVJQRTB5cEpINkhIaEVQNnR6NUw4R3RlS0ZwSldrYXY4cVo3amJwQWowbkVt?=
 =?utf-8?B?WUt4MmVFcFRsZy9LTENOK2hNQW14ZE9ZU3EvMDdKODVUUzhUVEZ1QnduZXd2?=
 =?utf-8?B?dS9LbzJkbDRvQkgrMzlVVDgwV0hZallTdHJra2kzNGNUUWF6OTRmM1plSk5H?=
 =?utf-8?B?NThFcXVBVEUxNExnMXdLbm10RzU4RHU1S1dyZEtTYmwrZXpmcVFkVGdkUzl4?=
 =?utf-8?B?UTVURm1Kc3RvMStFK1M0UTUxR25RUjRzcEVtNGR6bHVDZkxJeERqR2Y2Njl6?=
 =?utf-8?B?QXZFRWtRbjJmbG9pUzBuQldjM3MyUWRQQlVvVzJCS2dvYVJZaHdMa3RNbCtY?=
 =?utf-8?B?M0NvUWR5UmdBcG5sQjV2dGd3K0lCOVhlRFdOMWNZZnNLckg1WXlqcDhsYkFm?=
 =?utf-8?B?WUczTzU0QXhIQ01NZFlYYXgvS0FraXJlRUVKMUltYnFUdFpuSlp1VlZYOTVl?=
 =?utf-8?B?b0t0TGRJSXVVcnVQYkZ1Q3EvMHdFOVFZaG5HUGtoTFFwZy9aZU9CbHgzczhq?=
 =?utf-8?B?bnV3RXkyVWpRdmdtVjFIbk56MVZsb05hcTA3UStaSVZ5WnVQQm9PZFJ0MUhi?=
 =?utf-8?B?Zm9hWW5hT3Q4d3F0Tm5ZSzNOU1NHNmV1N0F5WEhCSzkvNTRneFJ4WWcrVkFU?=
 =?utf-8?B?VzFxdmpwdEYya3FSZ29xSGcrZXE4dFlGUHFjbWRUQ0xqRWVrZ29DK2hjUGR3?=
 =?utf-8?B?VEFVa1p0ZFdlOXMwVmpSdkRqWDBScEMvTkR5SUJCZEJ2U0Uya3c0eEJXK3pH?=
 =?utf-8?B?cVUxZzNIMEU5ZUlxa0hBbldTRElPMmhCZklQZC9YaFJ2aHNUQTFGeDNjSkpm?=
 =?utf-8?B?YUFMeWR5TTMxNit5VUxKNHVVejk1SHRsQmFpdHFEU3NiMks5OTR3WFpqZFRX?=
 =?utf-8?B?SStCYk5zZ1lsa2E4N3RHU2xxMExpR2NOdithbGFZc0ZvLzVVSElkVFY5Y0NP?=
 =?utf-8?B?WVl6ajVDTWx5ZDVyNUk0aGp5cFE1ci9NQjUyT3Y2UmxvQ1J3SUd5dHQ0SUZU?=
 =?utf-8?B?U0U2NWlEWWJraUZ0bmlRaHBmZnRBaGU4NS8vN2JwWnNaNnlhb09LRk4vUFFB?=
 =?utf-8?B?MUwwVlM1R1k3Q3JhVnowN05EQWVWbzNadWZZTG1YUHdMbkNubDhFY2I3TW4v?=
 =?utf-8?B?ZjBLenVoOGlWMm1adHFyYzZLUFB6T0pmMnRuRUMxS3U1UmY4dHRUZDVxMVlB?=
 =?utf-8?B?anJ5ODErU1RUeWpCT2xMTVoySVhnYWU5Qi9ScHJYcjJEaGxkempmd2k3Nk93?=
 =?utf-8?B?NFUzVmhHUTlNTmNlekdxalNDQ3JYY1VUOWI2Y2sxeUNaVWZ5dHpWWVZRRjJS?=
 =?utf-8?B?a2t3UWMxcWxSd2FaeHFiY05pdE1UWHBYUjZod2FRQ2lLd0grY3E4aVM2SWhG?=
 =?utf-8?B?dFpBY1lMWEZ2cmxTRWk5Nmw1VElScXdIK0dwTUZjME03K3NQTlptZ2pBeElX?=
 =?utf-8?B?S3R6R01kRTZ1TDl2NCtQbjVUWlJ0NHZJMUcwSjFnT1VaRFRDVzJONnlsMEJt?=
 =?utf-8?B?T2NYRm8zWFpWQzlkby8xM0oxSFA3UEE2T0ZkT0pLSXkvUWVadHZ0NWZoeWha?=
 =?utf-8?B?OWJCdFJ1ZExEMnA2d2Z0N2R1bUl2S3RNcURweFppRElMRnZoUnE3OG1jMVhK?=
 =?utf-8?B?eEZOandxMDhFOFl4cHJQS2ZZY3JvSFgwR2dHcCtiRGlrMXN2a1dxSndUYkRv?=
 =?utf-8?B?Z1FkZ2dSZFVZR2pIdG5ORmRFckVoUDRxL205b2dVS2d0QllOdndXTFEwUWJZ?=
 =?utf-8?B?cFJQWHl5ZU56WEgzWVcrVDFMekZEZVVudXkwd0x5dkI1VFNOdkZkaEZQSWNQ?=
 =?utf-8?B?QUwzZ3p5TXdITkVveE9mS2V1ckZSYmdUY1ZBLzQ0TGJmeTQ5dEUvbHFUaW9V?=
 =?utf-8?B?ZmtZV0VFM3JvYWdxNlQ2NTF3ckF5bjR0ZXJhNXR0SlR6dXBpcisrMDRGakp3?=
 =?utf-8?B?WlBxZlFBSG5Mam8vSXkzb1lWWW5UdWgwT3NFNHJxUmQrWHdRNjZxYjJzdjhs?=
 =?utf-8?B?MzN3Zll4MVh0VHR0WTRnTzErSWZ6a0hOaG41b2t3WCtSRWQ4dGg3SWNMSkFZ?=
 =?utf-8?Q?M91Bc3Nc9v9UVsI0Wjh7g1usm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7960846d-7ddf-4a3f-02e4-08da759801fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 21:34:55.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqGd3/gTL/UguEarITLjjVMkhXlRCpzFu3r4BNtEbpnfNvpuNCAMMUVx6uYp5IX9xopN3sn2Xji68tvnJRP4IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 16:18, Dave Hansen wrote:
> On 8/3/22 14:03, Tom Lendacky wrote:
>>> This whole iteration does look good to me versus the per-cpu version, so
>>> I say go ahead with doing this for v2 once you wait a bit for any more
>>> feedback.
>>
>> I'm still concerned about the whole spinlock and performance. What if I
>> reduce the number of entries in the PSC structure to, say, 64, which
>> reduces the size of the struct to 520 bytes. Any issue if that is put on
>> the stack, instead? It definitely makes things less complicated and
>> feels like a good compromise on the size vs the number of PSC VMGEXIT
>> requests.
> 
> That would be fine too.

Ok.

> 
> But, I doubt there will be any real performance issues coming out of
> this.  As bad as this MSR thing is, I suspect it's not half as
> disastrous as the global spinlock in Kirill's patches.
> 
> Also, private<->shared page conversions are *NOT* common from what I can
> tell.  There are a few pages converted at boot, but most host the
> guest<->host communications are through the swiotlb pages which are static.

Generally, that's true. But, e.g., a dma_alloc_coherent() actually doesn't 
go through SWIOTLB, but instead allocates the pages and makes them shared, 
which results in a page state change. The NVMe driver was calling that API 
a lot. In this case, though, the NVMe driver was running in IRQ context 
and set_memory_decrypted() could sleep, so an unencrypted DMA memory pool 
was created to work around the sleeping issue and reduce the page state 
changes. It's just things like that, that make me wary.

Thanks,
Tom

> 
> Are there other things that SEV uses this structure for that I'm missing?
