Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281BE47FE18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbhL0PHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:07:16 -0500
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:51040
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230391AbhL0PHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:07:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKcluRAqNtm6i7sdV7FitxWvFqf/F1cO134UxeqCCSexhFqydOCq47nPB8IlOsGHaI854cNBkgNVpbtpxmMumcPmzfAvH65skDk3WGHkPI3X2SuoiRcs5qUt1nHKZFLs+ci53xejYRhOyyjdc+c1N6dPBOVfnAS8LSpbCAbO00vjPDdWJ66bIuO7pXU6GpZhjwgIXq80NXlVvYTDzPt67kTA2n+bcwuoitSi/7M4NvYcSlwwzvw6qhPpqVa+pRu08WDNlOVwkztioWWn6EG5N77tuLY/SWXY4INf4e9jl9CCBUuk7/M0JW/1avLX7mUBRDGzYWF9H/suQJH4vHvewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNQBLDJiyVxte97GrVV6HlHgvKDPkkxJceGiKWLIzJY=;
 b=IcxqZQF2LIoxn+Q7FcaMjUcvh4AeGSl5SR3S6+YPBuI8omtamj9BR9/4U1/w8lbJOczgkaJmodiQD4zbJN5s7T8LjEZwRHo3Fn+Ox+VSDXnTM1yLUksPhk9TAUlte7u/+uIkBh6lK+sEVNEQHmDrUTGaWTqF2tSmsOzlRtT7xsPYxpSRQa3ug2JUfj9MoRWoIa1CmdKYc3j0t0iOXP3u8GN9TxWrtCAtzeaNpWESH65WlY0ZiJan2oIoLf965gp5M/dM+S/NcxJj8I+iXOGnHEg1EM2Nv5ZwrvnBF+fdxrq0oCtwrYUI/3OFUzOY/Yc9vBVQURJkg/kJUdtt5cEJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNQBLDJiyVxte97GrVV6HlHgvKDPkkxJceGiKWLIzJY=;
 b=cZTRT90qdCAKYaQz6e2otWDjDD8fLFE4ZxVyCgTwfsy0pnUh+R0imAoOVrnmaIB3sKFIISPPZeprqqlEgPYURMAhI/P/qpkj7LQsleXc1kP95J95LiSXRN5xTN9t3SgdfcTrg6YdoD+JtptVE3SxLO3Au588yuPp05bWkbXlR0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Mon, 27 Dec
 2021 15:07:13 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2429:24de:1fd2:12c5]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2429:24de:1fd2:12c5%7]) with mapi id 15.20.4823.023; Mon, 27 Dec 2021
 15:07:13 +0000
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-20-kirill.shutemov@linux.intel.com>
 <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
 <20211223171530.v73posbqizb5l3md@black.fi.intel.com>
 <f61b591b-a06c-bc29-4b9b-a5d46111fe4e@intel.com> <YcTTt4LXKfDO+9u3@zn.tnic>
 <20211223205604.g44kez5d7iedatfo@box.shutemov.name>
 <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
Date:   Mon, 27 Dec 2021 09:07:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0401CA0037.namprd04.prod.outlook.com
 (2603:10b6:803:2a::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cd6214c-4236-4e99-acc4-08d9c94a903a
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB5549C8E73E62A0586D333755EC429@DM6PR12MB5549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZJ0EnsQUZ/lU46evwT95Rcv6nIetjp0Ze62EcteBnmPlMAe/sR9mXU+62tDTLOMdqih0GqbAT2EPeXJJITGiBD6jvkrC7367ICNyk7wGk4CQEIJKovmDSl5izJnZATwQhEl33SWnkQkp4ZeVltlOsKxksNboCEi5stQ0BQrr5fhym9eoP263jLvG2yizatN3BMj1xn/g7Grpw1nDgnDxX+v2UFZv18fm/3ASzmlsUN4ZtuprgGoyNlf7jNP5y/aSdYmymqsZJUwJLrrbYnbxjZN5Nol94cjIhjKA8WrKgMNk+80JKUI0mOfVlGVnN5SXGhI3O56koqQVFkhb/av5/lC6eAefpRnpKOhXbmu19pGJLM54AhmC1iOSznn2TSoNPM09UrUJxJ9z9Hx74Gd03y5ITo3vhQ9mbaIbx/MJxTq+FCi0Hmt+9DFwDRCvuTDVIlskw27JuFH04JLfWGi6CIb8M2D42m1hnL/8WDb0m6xhKkoAvX9mz90fZfmnv2tzqbMw9pwVyXz4h8/B5xqowFUFuPJE6IuZuqk5Ro9aqH47PtgaDROe9o34Jyn0oqjNdsDtjvSJAADE2UK8pyjJzsSddZ1d0sSKgQ8SLAnB846BGDrlyMC1jzouhlpc/HlCPrxPMz/ZdzliQUlKc8u5NUIKfJiqC6TlPILqujMmzB84lclO1ltZ0bRSZLiQLkNsp/bPuptaDECoTO7Qk+Jt2EhUQPqOv4AeDl+68BGwEYmUr9c7qVFsltv3hvunHZf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(6506007)(66946007)(110136005)(8676002)(31696002)(6486002)(38100700002)(54906003)(7416002)(316002)(186003)(8936002)(36756003)(86362001)(31686004)(26005)(83380400001)(508600001)(5660300002)(66476007)(6512007)(2906002)(2616005)(4326008)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnpDQklsb1ZLMFpUd2JpaHhldTM3RjZHMGQyMmFoRjNqR2pzZTZDUE9RMldB?=
 =?utf-8?B?RTAyUjliYmIvZDVhdlB1L3lsUVJodHZnbE1kTDVWYVdMMTBVUUtlR1R3OExB?=
 =?utf-8?B?eFhvZFVPQ1JqbnNnR2xGUzBEQndDbmM1VEpPaGlsMHg4UXdVZjllNG9LTUVn?=
 =?utf-8?B?RU1pWFN1ZkNzOVlHZFNwU3loSXVKeld6TEFhaytjUmw0bVAxQ2NKVEtyWUt3?=
 =?utf-8?B?RXBYNWFCTm9tUENUK05SYnNWVk8xNVpuazI4UHVYWWZzSTBKc04xUkVtdytt?=
 =?utf-8?B?KzgyQU9EK2dIU1Z6Tm0vcHByek5tc25WZERGK3ZFMFpzeDBvSzFHL2hOYVZz?=
 =?utf-8?B?eEV6KzZpQXlLNXhGd1Jwcm9xMkFSZFB1WFZUUzc5azlKcEFNN2lvbjNnUXdC?=
 =?utf-8?B?RitFTGg2Wlg3WjhaMVNSWE9MY2FLbStZUWYzdTE4MkxhVEVXU1ljRVdrQmFF?=
 =?utf-8?B?WmJzdlB6aTB0aS9ZV1ZaU3h0YmRBZWFHaWZ6NmFtd2d5MlNCSmpoYUdnK0Rh?=
 =?utf-8?B?a3F5WUEzUStSRVNUZGVXQXZ3cHUyUlRzMlg5TGtONUdielJ6TkprMDJRMjZT?=
 =?utf-8?B?dEl0SzJmSWI3cHdtM2c0T1E2TWFPbnZ5UGRFV2ZwSVd3TUhrTVZJKzF3SlhK?=
 =?utf-8?B?MXhYN3RlNkZDV2JRbmZaMEpiM1pmTzJjL2wrdmlWaEJKTlBWYWxHMFFCcXB0?=
 =?utf-8?B?eWFDTjQrUGhjUXp0bmowUnBTU0l0L1lRbytNSjlwVTNOMnhKUUVGaXJ6R0tW?=
 =?utf-8?B?aHhsU2JhNDdOZ2l6cE1sT1VKbStoQ2tqdGRLTVJTUHNIMit0bEllcm5NVHlZ?=
 =?utf-8?B?VzhvM3B0a21WOU44aTFGYTZCdU1IUitlTGVqREtrdmY3RnhtNXg4ZjNuK2lU?=
 =?utf-8?B?SU9WZFZDcVNKMFlZejR3WThWOEhEbzNQVjdJdVBwYXYwTHNxckR0VStuS3Qv?=
 =?utf-8?B?cVZjRVk0YnBHNnU4MlR6NEZMdklnYkJJNTVUamo3WHArUlI0bi9wbUEwTEhq?=
 =?utf-8?B?QWhmbCtuQ1NVZXpQWG5pRUJ1OFliY3dKTDFhcmlMeU01NFN2Y2h5MmlVdzRq?=
 =?utf-8?B?SWxwc0k1NU5jM3g1QktJTGEvY1BGZ2U2cmFOeFJ5bXFTWFI2NWF0bm5TRStC?=
 =?utf-8?B?RVQ2b1pLajl4SytkNHNwb1hQekdhS25NdEI3WnFPam9FbUIwemUzVFFOOGhr?=
 =?utf-8?B?MFRPNzFUbHBUVlByeWFIWUIxQVg5ZkMzMVhpYWl6NmNWdkhFK00ya2pMeUE5?=
 =?utf-8?B?cW9hSThwMSs3NE9TTzVkS2Y1RndrQkNqSDd2OU1LZHg3RkZzSnBkaFZKaWor?=
 =?utf-8?B?V3lRdXFMcUZkRFZzTFVZbkhvaGhqVDJMR1I0VmNvMGtyaGNhR0pjN0NqUTk5?=
 =?utf-8?B?SXZrQ2FSZ0JqTGx5SmhjV2VEdE11STVHcmtpdmdIZTNLalgwOG1kZjJ0bmxn?=
 =?utf-8?B?YjFSNGI3cGpSNzk2VWVDNEhCZVFORElhZHNCaDZXTFBUZUllNjVRekRqRUp3?=
 =?utf-8?B?SW9PSElhSnJQWERpcm9XWHVOa3k2T2Y2L3pDYWU0ZzJJYXQ1ajNJUjNuamtR?=
 =?utf-8?B?TjUrVGUrN3Nzb3FYQ0RhZ21KM2paT1U1clhJR2Z3YjRlMVpFL2VjbHNRejk3?=
 =?utf-8?B?eGhkV2RGc0lEVEVUcDBNSG8zT1kxM0Y4SzZiZlZmK0pjb2xieTRZU1BsZ1Ay?=
 =?utf-8?B?TjZPcS9kT2ZxZkMrd0RDL0oyWHp6bk92OU5PREp2NUJRWXBGejVub1ZUVm1G?=
 =?utf-8?B?OXZZdklvRjVnMzY4am8wZW5xQWR1MEg2R2g3VEdSRjVPanFHZE84SEtnOWcx?=
 =?utf-8?B?V2JqSWlQaWhhTDRPT3pRNzJSbU4vZUUwU1hJTUFlUlBtV0lNcGc1ZEpZYjFZ?=
 =?utf-8?B?YjA2bzJ3UHluZXpLR01ROXBWZVhpTUQra1BZTlNFSmV2TkJmdlQ2aGNYZEhZ?=
 =?utf-8?B?Vi9uYTB1ZG8yVm9kSmRxY2JkWXpmaGtiUzNDTkhkUy9TMkdaekE0MzNWaWNO?=
 =?utf-8?B?NStxdjJMdC9OYXBBeTR3azVHUXlKR3BmaE1Ma2tLeHNoM3dqRWZMU0l1NVZ1?=
 =?utf-8?B?Ymt1WEtYdFdYaUxyT0NJN0ZSNERPK2RnS1R5c0hyWUwrd25QQnJJK1Z3Ykwr?=
 =?utf-8?B?cnFFcUdvc3NpUFJWdEZHa281UGNIeHd4VXVNdS9VWUdZTzF0ZGhEdEF6Wmpw?=
 =?utf-8?Q?8NT5fgz5YXgBPBo9/sVqqu4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd6214c-4236-4e99-acc4-08d9c94a903a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 15:07:13.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00s58bQrnzjM+47k2ZGjdqal+FcSJZz1b9tcGdvYTvUW024I2dxlsRReW385tUliRTMIbIh1lp/N/RaXmgKbBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5549
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/21 5:03 AM, Kirill A. Shutemov wrote:
> On Thu, Dec 23, 2021 at 10:09:26PM +0100, Borislav Petkov wrote:
>> On Thu, Dec 23, 2021 at 11:56:04PM +0300, Kirill A. Shutemov wrote:
>>> Except CC_ATTR_MEM_ENCRYPT is true for TDX too, so it will also depend on
>>> check order. It is fragile.
>>
>> So the query you wanna do is:
>>
>> 	if (memory encryption in use)
>> 		use mask;
>>
>> and the mask you use depends on whether it is SEV or TDX. Right?
>>
>> If so, you can either do a cc_get_mask() function which gives you either
>> the SEV or TDX mask or simply do:
>>
>> 	if (CC_ATTR_MEM_ENCRYPT) {
>> 		if (CC_ATTR_GUEST_TDX)
>> 			mask = tdx_shared_mask();
>> 		else if (sme_me_mask)
>> 			mask = sme_me_mask;
>> 	}
>>
>> Yeah, sme_me_mask has become synonymous with the kernel running as a AMD
>> confidential guest. I need to think about how to make this cleaner...
> 
> Okay. Meanwhile I leave it this way:
> 
> 	pgprot_t pgprot_cc_encrypted(pgprot_t prot)
> 	{
> 		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> 			if (cc_platform_has(CC_ATTR_GUEST_TDX))
> 				return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
> 			else if (sme_me_mask)
> 				return __pgprot(__sme_set(pgprot_val(prot)));
> 			else
> 				WARN_ON_ONCE(1);
> 		}
> 
> 		return prot;
> 	}
> 	EXPORT_SYMBOL_GPL(pgprot_cc_encrypted);

Why can't this follow the cc_platform_has() logic and maybe even live in
the cc_platform.c file (though there might be issues with that, I haven't
really looked)?

	if (sme_me_mask)
		return __pgprot(__sme_set(pgprot_val(prot)));
	else if (is_tdx_guest())
		return return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());

	return prot;

and maybe even it call it cc_pgrot_encrypted()?

Just a thought.

Thanks,
Tom

> 
> 	pgprot_t pgprot_cc_decrypted(pgprot_t prot)
> 	{
> 		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> 			if (cc_platform_has(CC_ATTR_GUEST_TDX))
> 				return __pgprot(pgprot_val(prot) | tdx_shared_mask());
> 			else if (sme_me_mask)
> 				return __pgprot(__sme_clr(pgprot_val(prot)));
> 			else
> 				WARN_ON_ONCE(1);
> 		}
> 
> 		return prot;
> 	}
> 	EXPORT_SYMBOL_GPL(pgprot_cc_decrypted);
> 
