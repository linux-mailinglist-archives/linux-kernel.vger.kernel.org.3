Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63A7553E92
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354444AbiFUWdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiFUWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:33:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC289FFA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RV+9YRnF3u+IbhI7BCN5WVTMHh9k04a7lglDee0owZ69oDr0/4Mkkr4a3WfV+ntQBrmqqqWq2dh3cK02CsC0ubBmhQNweLgEuAqJsGPVz81o8b1ya4ZgFGUj7OZNON5R4jJIak9QINuev2v0rbKsz+/C5c2DtzoOMiDAtUjMO6vOklYTnlOEGhhymzLf3EDDKF7blh/RF4D5mGyWEcw37Z3Ai7Ddl4ns668zTu9DQbf8PINEMC7oWAh170NzhHbop5OlF798i4bjrHxeLrPLi35MuNDkOON277w5ri/EfFK5KokznLfa46jpLttIzwEF6raJGevq5fEcSb/Jll2cIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akU42WsKLz86iUDjTMh0NGRE1HkzdIezsAda82vShjY=;
 b=O4qmcxfdQQFfJ2LRo1FEdeJX6oX4ada2/PVu2lCYcJYiIIJKUh05SkRlEuFEHZq7dcFjrOXdT+2hholxEqJabBc0wsTnyHozRw0e3V4S0TCjacxySg1ChHOSnzPyR3dvDkenx5NiUZtW0FgLdcEhrro+PYahS/j4FKDcWmWKuPk3Yld039HKA0APWQwO8Mg2Ypw7MQ/iroeco+oWeiwc5PV/mdMIEHVIRvnPUMueRyIQBEMeB739HhJl0lnQcW/0r94idfzf0PNs0CvXRR3rDSmi7w8ihLFQZFU93hgtFGFTCy/aEH5TJT0ActtxOyT1xaJzCb5i44pdrdqwAv9wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akU42WsKLz86iUDjTMh0NGRE1HkzdIezsAda82vShjY=;
 b=qj6vjx30bhONtT3qZGO92bLG7IkVf7NgW1PVXx1UdgOZ8uN33rmV+TPSQzf0Gx4Rqr3BGgBR9MXI5ndirnKm22PyfjXRv/fnr9QIBJhzHDt7cQ5TyMC5RvYYdG61gTvcI4p7IFg5O0ItNZzZ/Gku5Sxl15GfiElUIIfM9xn0yopn0TkDSJ06wPv2hdjHrrcr2KgOE/JfSG87F8p1s+k//SWuaR22tbLs3WHk2fIzJpqtY6JiiaWcs5WSu209Nr7AicdgmSceTQ/OxFjqxV58CspshnVmGhSCHVZ1eS6Z1lb/l+2TnKuoqRKWYibPqCubP4kAWD15s+SXEpkbAlRh2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB2879.namprd12.prod.outlook.com (2603:10b6:208:a9::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.18; Tue, 21 Jun 2022 22:33:37 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c44c:ea8d:1b00:5fdd]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c44c:ea8d:1b00:5fdd%6]) with mapi id 15.20.5353.017; Tue, 21 Jun 2022
 22:33:36 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        guoren@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fixup validation of buddy pfn
Date:   Tue, 21 Jun 2022 18:33:35 -0400
X-Mailer: MailMate (1.14r5898)
Message-ID: <D65BABD1-0785-4B68-9080-48CDE1B75795@nvidia.com>
In-Reply-To: <502ccdeb-372c-1d05-4b5e-a962f39cfb55@linux.alibaba.com>
References: <20220621031118.3650529-1-xianting.tian@linux.alibaba.com>
 <c45a6850-772e-8d2c-9261-7621f242dbae@redhat.com>
 <502ccdeb-372c-1d05-4b5e-a962f39cfb55@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6C734AB4-0073-4883-BBF7-9D9EA7B17258_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0411.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::26) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f61f440-ed66-44da-78e1-08da53d614e8
X-MS-TrafficTypeDiagnostic: MN2PR12MB2879:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2879872F2496578F2C246F39C2B39@MN2PR12MB2879.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CN/aGEEY5b4cx5wrTouYIle+5kva4xTG3y5vkW8PxHtOwkWS1RS6TQ8QWQYwIucOlvFtPJG9uNs0QqSZl8E1Oi5qNrDLCBulgxUygiV3YueVL2tcbCitoYUUMPRWlJuB9xPrhXmE79Z+bIQVHOuqHx6cCepqRigGzWFo9LkhhNQuvVnqP7uSXVT1MftUj1UExd1KBwBrMtsm2BvxwUEZlhbeCmwo4YbHZ31qukYhYKcFAh5BpLUrJi/YPk4EgPF61lVaWfSlpgZZflSgKsMWzI7qXqmkfM0jj3zYqoOuU70qg2hUGWOqLmlUgqv6pA4wMDnIL4qCganQnQRJ/3FNqIObvDxCrYFyrLhTLjgeypbDBGHrP4CqHqpp79kP5PNX3+E1+u0VzT1Php3u1jXmYOhym2X5jtVFibJzjhiBGZOiEal3WZK+GrVlUVcD3OPNmKxOW+CN7M4xIuDfPk8O5NM9seLRH0VIzVWvw7o4fairHTRj23GqP1HFSgIhP9p20mTqUeg+TWJfK2DwuR8fgQFdQMgux+uq/aH1XJK2s7gYJvSHO3GLtsLQ+9629/Urs+hyBjrPcxfKzrsyWKI8qVyjILtaAnMJsxxJFtZ+zpC7aLmgcm5b3ibEoY9Ye8ZUXjxcBMgg9FExkAnR5TxY17s4ds5lAJATV+YhWiFIY/qAebIZLUACqJa6HP4F3IzuYwO+TET0A2GpwYGsICn05iGcUlbdqqjPLohxZm08eXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(33964004)(86362001)(6916009)(6486002)(53546011)(4326008)(8676002)(6506007)(6512007)(66476007)(26005)(66946007)(2906002)(21480400003)(8936002)(2616005)(186003)(235185007)(316002)(5660300002)(38100700002)(33656002)(83380400001)(41300700001)(66556008)(36756003)(478600001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0pFcFpvZmhwYVAwdXlPTGxieHJOaU9ic20ycHo2MEl4aEd4YitTWkdjdTVr?=
 =?utf-8?B?N001WTFnak9JTElIcE0xZ0ZBSlFmcm8wQTh3OFpZMGFWWmdpMVh2MUtqYUZa?=
 =?utf-8?B?eEpEeTIwdHgxVXh3bXhWSXVwd2VaWWRTN3Q0RTNUYUs4LzZnaUJucGh6Uld5?=
 =?utf-8?B?SE4xSUJ4SGs5ZXQrY09Ya0dKbXJlcm55UE8yT0diMUlmMFlXZ1NWcGt3OUFP?=
 =?utf-8?B?bURzVDVIK0d5bEkrTmJNa1VXT2NpM1kvM1Z4ZXZkQ2MwTkVqRWl5VHFGRSsz?=
 =?utf-8?B?Q2p0bXBWZDBYU3dqRmJTbGxwcTI3L0tBQWdnZlVtN3ZHL09yeTlBbVJWUWlX?=
 =?utf-8?B?LzZDU0RERFo4UXJzOXNiVlByTGVsQ2RaNTJuN3BxZUtxaUhRNjFMR2dlZWFI?=
 =?utf-8?B?QXh4OTllZXRXZ3ZzS29sQXVXT3REendkaDBFQkV0akxJd3YxTE4zdWNiQTMv?=
 =?utf-8?B?eTlGekJGSjhuNEw3NzQvRGI1cGNjQ2xJOFFsaUR6T3RDZ3ZubS9PZy9iOWFJ?=
 =?utf-8?B?eFU1ZzNRb0t1OGpIUzN2Z0pvMHhmL2JpQzhkcWcveEhvVFdpUDFLWmJRdVNV?=
 =?utf-8?B?SHNuSi9jbnRJdGZsbTN6NjFzUXBUZjNSTy9CNG5PaW1tSDB2Tk96ZzJCVm9T?=
 =?utf-8?B?WDVlbEJ1a2p3aTRkU2QrUGd4U3B1a3puWWRQYmg5d291VmVOT1hYdHNDRWZy?=
 =?utf-8?B?RC9rSUEwUEQ2L0o1NVIyaHhjakh2QTg4bWlnYzNycnJyYVluTUx0WEV4RlRO?=
 =?utf-8?B?YldpeUcrWmdDbW1tcCtZd29jRThyZTJPSjFtU2kvYm02ME1sK1E4VWRqTDZs?=
 =?utf-8?B?TWRzUjJ1NEMyY2FsclQyUGpXWno2b1l2dkozSU1oWU5TaTlKL2J2dWVXSXJD?=
 =?utf-8?B?V1pJeEdnVkJ2WEpHTEoxRkhjdnhKVmpQbGZrb0p5QnRjMkxoK3dxZnNFUHNJ?=
 =?utf-8?B?UW1ONzE0TUtuejF3MG1ud0NLT0xtSjA2bnZuZ3QwOVBIZG53YmxuVUtHb1Vv?=
 =?utf-8?B?VXN5K1gyRmlmdWdocjhXdG5qZmpvSTc1ekZ0aWY5S3N0dkd4VTNoQW9mZlFS?=
 =?utf-8?B?Wm1ZN2F1bGVJeitwZHN6MVNwYVZoWVU5by9qb1pxSWxJclpmOWt0NjJoN2kw?=
 =?utf-8?B?ZSt3QUdSanFkaTh3NWJtaVV1ZmlFNEZmMFk5WFRTNVFvd2VJazUxUE02NjBn?=
 =?utf-8?B?YjFOa3NZVkVLVm12L1lvRUF1aEUxd0FHRDFiZGswaEo5L2w0ZkEvTjYzbExY?=
 =?utf-8?B?TEVzVGkzMG1WWHNOUkg5TDI2RlNHYkx3Q3hpRXRJRjZxOXJIeHczSEYxek5M?=
 =?utf-8?B?Y0dITDJhdFcyTG16NmVGWXVXWW5GRFJrS3NEem41RGw2ZUNyNDRIVHBkVjZN?=
 =?utf-8?B?bEhWTld3UytUbnIrUkhQNjQ0bEFreG5rdUpNL2xXc1dINHRQcDF6cjdyOS9K?=
 =?utf-8?B?b2M1YnJPa1k0N2hFRi90bU1jWkd0V09UbXUwWk1jbXpJcUs1TDlpaDlGcnpM?=
 =?utf-8?B?dTNaRFlJRytwVmxVYzAxL0J6bi9ZVktESmdOVzF2eXY3anMrZ0RDd3JtL3FK?=
 =?utf-8?B?WlpkUktQc05IRHFqMHVJMDFybHJWR2c3VHlHWnJFVDV0Qm0wRERISzN2aUFJ?=
 =?utf-8?B?RUJ4UHFOSi96QytvT0RlZHY1RmZZcnRDdXZDcU40OHJ3Z3FSdjdGTkFjbytM?=
 =?utf-8?B?cHBFQ3RMdFFuNFB2MGtjNlg2a2dtY2J3ZDVHTVRnYzNSeTBJQjYrQko1WG9M?=
 =?utf-8?B?YnhSSGlySXNZREptLzN4ZjBWdmVCRkNQVHJ1Nmxua3JjTUJIWmYvMnJJWDh4?=
 =?utf-8?B?OXJoWVZpSHVaN0lVTXlPNHJYaE5VVzlKZXZjUHVlTUNRY1Z3ZldJVWJ3R0hw?=
 =?utf-8?B?REZGYWt5YWpTVW15UkYzVWhUUWpDRlBEY05wYkpncXMrTitGcW9RNjVXalVM?=
 =?utf-8?B?ZS93OEVvQkV4R2J2WG1MbkdUT3U0N2ZrN1VtcE9JWXBUeWF5ZFgzRWI0UkJl?=
 =?utf-8?B?aWFMU0htMUdzY0packNXWjU2cTdkWVQ1bzRLdFBOYThzQ213R2RZLzZDb2lF?=
 =?utf-8?B?dW1YUnE0ZmMwSXVKY2psWjQvemgzbWVrWS9tN0ZEcWwrVmR1OFo4dThnSEJP?=
 =?utf-8?B?T1NmeGNuRFdEUU1yelNva0pQL21qVlNVdGlHOWx5N2R6ZVJRbDNqbUh2clZh?=
 =?utf-8?B?RUZtRGVNcjIrWGF1anNlTURHa1dUY280QnhqNHFJL0FDRXhJajBMcFVmcGtk?=
 =?utf-8?B?RVg3ajhteVNzWmp4TWRObkp2aDVicEtxM3d1elk1ZWNDTytNTlBiVXMxY1hw?=
 =?utf-8?B?d2k4dmhYQ1pDeHg0QWRMUGZrSHVWZ1BqNHRnOEFBSTVxRG9tUWUvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f61f440-ed66-44da-78e1-08da53d614e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 22:33:36.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGrgPLdj0+/QNsN5t+7kV+B16kxKPsSGZUwnWdrV3DhJ0MRPWDm0uF/sIN1ZBwC+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2879
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_6C734AB4-0073-4883-BBF7-9D9EA7B17258_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21 Jun 2022, at 4:49, Xianting Tian wrote:

> =E5=9C=A8 2022/6/21 =E4=B8=8B=E5=8D=884:01, David Hildenbrand =E5=86=99=
=E9=81=93:
>> On 21.06.22 05:11, Xianting Tian wrote:
>>> For RISC-V arch the first 2MB RAM could be reserved for opensbi,
>>> and the arch code may don't create pages for the first 2MB RAM,
>>> so it would have pfn_base=3D512 and mem_map began with 512th PFN when=

>>> CONFIG_FLATMEM=3Dy.
>>>
>>> But __find_buddy_pfn algorithm thinks the start PFN 0, it could get
>>> 0 PFN or less than the pfn_base value, so page_is_buddy() can't
>>> verify the page whose PFN is 0 ~ 511, actually we don't have valid
>>> pages for PFN 0 ~ 511.
>>>
>>> Actually, buddy system should not assume Arch cretaed pages for
>>> reserved memory, Arch may don't know the implied limitation.
>> Ehm, sorry, no. Archs have to stick to the rules of the buddy, not the=

>> other way around. Why should we add additional overhead to the buddy
>> just because arch XYZ wants to be special?
>
> We ever sent a patch to create mapping for the first 2MB RAM for RISC-V=
, But it is not accetped.
>
> But I am just wondering, if we have the RAM whose physical base address=
 is not 0, for example, start with 0x200000(2Mb).
>
> Then the base PFN is (0x200000 >> 12) =3D 512, Do we still need to crea=
te mapping for the non-existing first 2Mb RAM,
>
> if not, the issue still exist under the case?
>

How does RISC-V get mem_map for 2MB-4MB in FLATMEM? alloc_node_mem_map() =
from
mm/page_alloc.c only allocate MAX_ORDER_NR_PAGES aligned struct page.

>>
>> If at all, we should fail hard if an arch doesn't play with the rules
>> and make this a VM_BUG_ON().
>>
>>> With this patch, we can gurantee a valid buddy no matter what we
>>> have pages for reserved memory or not.
>>>
>>> Fixes: 8170ac4700d26f65 ("mm: wrap __find_buddy_pfn() with a necessar=
y buddy page validation")
>>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>>> ---
>>>   mm/internal.h | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index c0f8fbe0445b..0ec446caeb2e 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -322,7 +322,8 @@ __find_buddy_pfn(unsigned long page_pfn, unsigned=
 int order)
>>>    * The found buddy can be a non PageBuddy, out of @page's zone, or =
its order is
>>>    * not the same as @page. The validation is necessary before use it=
=2E
>>>    *
>>> - * Return: the found buddy page or NULL if not found.
>>> + * Return: the found buddy page or NULL if not found or NULL if budd=
y pfn is
>>> + *         not valid.
>>>    */
>>>   static inline struct page *find_buddy_page_pfn(struct page *page,
>>>   			unsigned long pfn, unsigned int order, unsigned long *buddy_pfn)=

>>> @@ -330,6 +331,9 @@ static inline struct page *find_buddy_page_pfn(st=
ruct page *page,
>>>   	unsigned long __buddy_pfn =3D __find_buddy_pfn(pfn, order);
>>>   	struct page *buddy;
>>>  +	if (!pfn_valid(__buddy_pfn))
>>> +		return NULL;
>>> +
>>>   	buddy =3D page + (__buddy_pfn - pfn);
>>>   	if (buddy_pfn)
>>>   		*buddy_pfn =3D __buddy_pfn;
>>


--
Best Regards,
Yan, Zi

--=_MailMate_6C734AB4-0073-4883-BBF7-9D9EA7B17258_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKyRz8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUx74P/ix+nL74tRL9PfkZLsUUmoruLkfTJU4qE9dH
7fLFbuy6FWd6WiFfHbn88EN7362hQi6t6zoatU4Nhd16J/6gtbrjeO3jfhNVPBdy
5AGLoBBeHOfBMlTIgM8Fs3lKZH01YAhiUX4Uqll3rN96jhTzHdMEPBpzmLMBZIAU
gL2W6S25Dh/A3KG/qompRockRDOI24iDC02gBEm3QVyxrENM0J1RVK6IVhnIo+NU
1igJkRwJPrvxYsg5GRnSjg2OBNt4aLGO/xBqoenLbLQr/s3/3BgteofvZPGMbV5z
7p+0YygVLfPs4t/VTxZYSrId8RJmpdTOlfTTznzixuKPKVWh4Z6JLeIgQE8Thxj6
kT3K6VmH9s5jND3eDCENQcj8zSmSvkIhYk2kVEfciU6rQXXc6xmqgBnd6h8nM4s7
lYnn0KqDAO/HMgJtsIdrIIn++vKF/01sc+IrTaE0WOh7DPMTKXMUEbEMdkoF7qLJ
l1tDPPmPbMlp2aUENTsPWEEQNcqeYanuI9SlNS+Gx1LHm58eiHpTxmjn1hr2lPbo
EBhlZ82OcRp+f5r73t+rxOgc5qoI93DDTvT2upaKeBmhvZO4sa1vAgYmjsumvayL
fuwq58YMHwghzcnZYCS87/Fl4r635SK6nNnkEIp0JADUfVPflG/CsNaCZkb3t9ci
teEr/0LM
=TjuU
-----END PGP SIGNATURE-----

--=_MailMate_6C734AB4-0073-4883-BBF7-9D9EA7B17258_=--
