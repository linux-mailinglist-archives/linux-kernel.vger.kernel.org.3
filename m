Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A675A916E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiIAIAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiIAIAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:00:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC001902A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=floKauWvTCAzh19466Gt+8R1RDrbKItvYlXhItBuy/cT5oiYkuORmRssZeJQ44NeCczXJGO/s8YX9tDUe9P1WVaYgNpiLmSBJOLAZtzT8DGbkHKCDiSEuvg2z5QC7CaYCHja5vo8NbyWTCmI0qmMc9u7JYpt0zQifa0cjcOCwC54Hyr2/ctR8XJ4ct+7e+dBecVVav928WNFonxDbr6f0dS/6pMd5sJ0u0pXwzVm4/YGQSEyHQxFHwqmjkYignD30QyFoRkiFFIqIDI1QkevPHNwrhLOLMsFIxX2IsnTvLAhUglLNgJmTXz/wn9znhCl7kKWex8j5sjr2TNzCm0+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yudzn1kur/5vKIh9e9hXsTRkV4N1sD+H27Yrp5+974M=;
 b=og2NYKAqZU7OD0NYQAwiCC646U3huwDn0TpITS7LTFKzUJ2WEdmxmazcXLPemcvTFpqPTZoCZjNnqrn7FT0B8dJywAZ28pqwiDPes9qwQ8rRsynv1mpQk7skJ4Bo5BGBXryFAaltEfyf3pBjmf2+I4Onnkivh0gE/k3NNuTD/60+l/Sg0GTIp3ASh9DNCe3rdU426gQeMxm3NkAPoUM83yPBbkUXv0FjSCKKcQ4YEFrRwwjQqeZShKGGs6rWQs8Z7nk0GHMlOYG2F5tbzxc2TMjIi9rmwb1Bn2LP9by1vmAPT8MKh7y5tP7Bi6MAjs6rMiBBRFzC3Wbey2seS9+aoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yudzn1kur/5vKIh9e9hXsTRkV4N1sD+H27Yrp5+974M=;
 b=WXFBBz8I8VD/2/ubUSQZKLwAC4SEhP23XVhFdifEDgYrpoOU8050IECu0EzzzcrZ6E+VNC0FHOW614feEA/ApXp2OyIHvkiUSV/941JQ9AKNC+NgYFtuQER9tDPCi4aMrApgKL3lH40leaj5FQcnHwtVO2DtZeK1VRU65cWHxeleb3AYIdvvpTH5EfxV0M8BXmwhwX/p2Wj9P2rhboKmx0r53xKlb0ip/mQ7nFSj0o6QXrS/j7OFUUxnV+PMvbHN/WO8s7+//sJUpii8abMtMHAijVpFnJhBiGlTS8RJiTIdF1nBsbSEVNlRWseikgIod6UC1QNP/knQQkSuGOn4Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SJ0PR12MB5407.namprd12.prod.outlook.com (2603:10b6:a03:3ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 08:00:03 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::7432:2749:aa27:722c]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::7432:2749:aa27:722c%7]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 08:00:03 +0000
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
 <Yw5a1paQJ9MNdgmW@nvidia.com>
 <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
 <9a4fe603-950e-785b-6281-2e309256463f@nvidia.com>
 <68b38ac4-c680-b694-21a9-1971396d63b9@redhat.com>
 <Yw+KnRTrZ74qFUAA@xz-m1.local>
 <4d067a99-1112-3b3d-bedf-35c1124904fd@redhat.com>
 <Yw+nFBgnSH9WWYHv@xz-m1.local>
 <0aba2bfc-9f10-2fb1-1858-d8eb04b5d52e@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
Date:   Thu, 01 Sep 2022 17:55:58 +1000
In-reply-to: <0aba2bfc-9f10-2fb1-1858-d8eb04b5d52e@redhat.com>
Message-ID: <87zgfj5xtr.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::37) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 847b42e7-2ff6-4133-411b-08da8beffa00
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5407:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EA0zkm+d9cDOvqTQDy+/lu2YwU5rMWePQgjoSopJlmqexMIko1fa3AgcPOsRmFYCu5iL6Cgiw0w7hzS2KlmsdLJYUk+qK7w4BrweqCtlmi7Mw+DaC7fFqUa1ABubS3TsVnJTBo3P/F8GRaULlVvnZ/6p6RtJR1x8GWnsDjjf+pv4DdNeW7lX+QnjKC3ZUdVuYkopRQwmCcOed4jRzrINydiODsJkd505BTbsDgrf9SepEf6Zi6sd3A+Xb1EGY2NevRQdq7ZEgTvDAw0+GXtlCvZ9fkclTZIjoCzxbbasY1WcCb1ISHo0oshlYvIw0nQyI6FJprAPStYrSX7qiHF//fWKG5uYC8c+WF+mhT0yZCXX7nlXI3CJU8YaOn9A8QwtqaAsJGVy/iNwhcj57+pIxeeJu7nYZOAGB9Ff8lLNVHHPxw0t6wgdEl99y/7DkV9c3F22BiEeMMPe/bedf5mcGZdVErbSQPc8laHtLmPiKeC+auWE3/xUuTNilS6LSio5/bYqxi0zW1TOBvyPjTFfYcLPE3oHuhILQjFGlqhrc5a9iGlJP+8qUsK5ANEojlciUdJC0fGmd/+ltMSzSGwXdNhUld8AKvh9FaWyPnD0iq/cRdkxB0KDpCvPL9nDgqxxmC/TFcl+oad/Rjs68JWfJDUfo9w+JeRO8rpEkf8rsf33P0vRy2Uv7TMpICATu19tgb7dFFXMBeqwbZ1T3dVMOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(6486002)(8676002)(66476007)(66556008)(5660300002)(478600001)(54906003)(4326008)(316002)(6916009)(8936002)(2906002)(66946007)(38100700002)(86362001)(9686003)(26005)(6506007)(6512007)(83380400001)(6666004)(41300700001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fQ7DCWcjBClYy74hXpQLlGAK+JhccNUFT43cAJ26CWJuGBfx03qpTmh99asC?=
 =?us-ascii?Q?5V2QYQAFSoqajm80NKiTUJ5QAidmQUOK+N/DzvbH/84STA1UGNEwJKkHXYE1?=
 =?us-ascii?Q?6OQ8+vdO7GfkuRy+Pidoli1wO0PQxDUgxd+ateO47Q8ZTkNAyGKRKWU9f64O?=
 =?us-ascii?Q?T30E3sMdxnHde4MuZlGqo24diOf6Rubn3E/HrIws7yeqRWOEodBXcGmCJ5jY?=
 =?us-ascii?Q?GSh199i7aoFfHcY6BOlc5jg5rfTrNrwZhcqO07Cp4RRCUu8h93B24T5yUGvs?=
 =?us-ascii?Q?jOUz2Aekwn22S8raKuJh+OhqodNXx+i/ItCNQM/n3L/qLorBqHXDrlNS0Jon?=
 =?us-ascii?Q?wqrdMxVz6jJMY8nFAoVocZvbyMgybUlDt7x0pKmpNgOyzuPxnlk9G31CHaUb?=
 =?us-ascii?Q?7zF5+KikH9LBnbWj9XU15BNr2dm6bAqb28pflE5ZzVz3ZPt21Xgd1B1QaM3I?=
 =?us-ascii?Q?NlyPAkcnGYoLTsz5UnrxcgMvmVfkgVF/a/72j/OkOvrwn6ZLgLxskDUyV/Y2?=
 =?us-ascii?Q?ZtFwlIoTkllxDJWmiRY6t3vjNJCUyyXmUWB4fcpmSHcX7WFqXhPS9KQzHYJj?=
 =?us-ascii?Q?thhxvD1fLRyDcpX7Rr5WBrYpt48JtjjvkgrwRYaEAOKyMAYmT8BGx9S8i1uH?=
 =?us-ascii?Q?pN6trjbz58LDevenl3v/kWRgOgfVJMkJhq5bCRLkR9NC7wXhCdJN7fAbwXtV?=
 =?us-ascii?Q?fNdy32Bl96t+tY+ai21VgCS3ycW33YOyNpLnIbgmliI+zBCuvqkrbnmmErY7?=
 =?us-ascii?Q?K38W68GTHMpNLUloie1wbvwXrvyAwXQrGAmL1SddJSbGUAROhNvujnv2q6RM?=
 =?us-ascii?Q?S/VyK9s9TR437z11m8pQQuAA9WRJaueJ59thi8u5Hq8nWczq0OHvJYUyYNUn?=
 =?us-ascii?Q?8sExfw93IOCCxRhyvtnZZHldziXyt+6EdSwpSrVHNGHrvK4MMBzOjbuwQ2n3?=
 =?us-ascii?Q?JBJnM6S2q4s0J5UkyPEoPg/8dFb5/wqLsxkZNoWu/PrfbxH+wyv4U113j1Mg?=
 =?us-ascii?Q?dYAbrb+Bb+AFNSYT9ThzB/5YK8L00w92daU3AkERtbnpg8wK27jRjnjVdxfz?=
 =?us-ascii?Q?rfwF15l7h9TkAVISbD+HYV3/rcUUh96K1LKtDT1aTnbQKllk+CrVJgbjfbNb?=
 =?us-ascii?Q?QrWsy1VDxGYpeMfv5tCDyQaElfnwFKzekQmXYDtcyQhHGxzX4fRodzsWqECc?=
 =?us-ascii?Q?hQ57V8+ZQLH4s5S3x/+thRj01gWFMDk/Q4s78BS1n0NRwZKPbiSdWzobRLm6?=
 =?us-ascii?Q?GBFVXxT3gSt8UI+wxWMeEWOa1agZ9Dm3fAGDIiBWQckaGV2S/mEvgRsuyfqT?=
 =?us-ascii?Q?7GCS8uLrPjRMGVcF7QlZejxSiptcZBmId3nSlB0aDjaMe4SF9ZFh/oG9FRE2?=
 =?us-ascii?Q?jBhRNkNfYlhZGG/gbq/9VGqIGWBiMSmmuNmh6JtUDyNP/fi2cwtYj7yGyS72?=
 =?us-ascii?Q?VsUFMUbsbnHKR90mwHvZZiXMpGRp15VpOFQ6vzTnV8VKLM+T+060S8RsoXML?=
 =?us-ascii?Q?j8WJ2ibJQiT3KJz+B8phsKw/jPExp8rEPD30onrQi2VHxf9Nuua0AZ5/Hm34?=
 =?us-ascii?Q?YKT3Y8WTB+RpSvyb2iu4QxsB+G+JdN4qDk6zT+f8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847b42e7-2ff6-4133-411b-08da8beffa00
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 08:00:03.5674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfMVvTPNvqO0byRBH6aZqICMasYcIXsDi9zgMN4uE+T0tokfueR4TXmtltAFAFjnd8P1mHGlQgM7U/uJeFN3OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5407
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

>>>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>>>> index d7526c705081..971cf923c0eb 100644
>>>>> --- a/mm/ksm.c
>>>>> +++ b/mm/ksm.c
>>>>> @@ -1091,6 +1091,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
>>>>>  			goto out_unlock;
>>>>>  		}
>>>>>
>>>>> +		/* See page_try_share_anon_rmap(): clear PTE first. */
>>>>>  		if (anon_exclusive && page_try_share_anon_rmap(page)) {
>>>>>  			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
>>>>>  			goto out_unlock;
>>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>>> index 27fb37d65476..47e955212f15 100644
>>>>> --- a/mm/migrate_device.c
>>>>> +++ b/mm/migrate_device.c
>>>>> @@ -193,20 +193,16 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>>  			bool anon_exclusive;
>>>>>  			pte_t swp_pte;
>>>>>
>>>>
>>>> flush_cache_page() missing here?
>>>
>>> Hmm, wouldn't that already be missing on the !anon path right now?
>>
>> Yes, I think Alistair plans to fix it too in the other patchset.  So either
>> this will rebase to that or it should fix it too.  Thanks,
>>

Thanks for the heads up. I'm still digesting this thread but I do plan
on fixing that up in my series which I hope to post an updated version
of tomorrow.

> I'll include it in this patch for now, because by dropping it I would
> make the situation "worse". But most probably we want a separate fix
> upfront that we can properly backport to older kernels.

Yeah, probably best if we can rebase this on my fix-up series.

> Thanks!
