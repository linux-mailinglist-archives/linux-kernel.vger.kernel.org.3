Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4255CC12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiF0M3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbiF0M3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:29:13 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C007F766F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:29:11 -0700 (PDT)
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25R9k2gk019836;
        Mon, 27 Jun 2022 05:29:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=1wTA08R/aTgwRoDtCuQTh+RR0xzOjULSok72bblOOps=;
 b=jwg+vLJv1TaptW3stLryVI0aNRBgEgGu+7JIMvbtR9Kidwy83qSAzzXfaTMWcqGqhaOm
 ExTRNUyPfrNyRfjKeCHlJYDngBG2mb9LoS6v+rUjajwfhZA3DVEcQmbAhNl8w8cXws64
 RpdQmIp/FS8d6B5CvFezrl6KCiNxUEJIlKB46h4pEFMdsdLy1/m4Eos/uM72LewpBWW4
 KKvzfQn1r+Xz72qPjs8iVMk+myPqAedg0DZ0zRTtKwJXcvUzvDiz2APQTGG/f0xFwzQk
 h8By6z+iLlRWuERJisKsAiKv+lwJl0zcQMnFLDZ/GRAAZkaEfXTVmeGPaD1onGnJuvPA Xg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3gx1pfkf7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 05:29:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQj7T1MruAnFBZc4afP5zGc0pdyBIB2x2UgN53k3wI38jatSiLJwn4S4cbkhSuJi6rpn6l66X1UIJm0iqoj8qWAlXIjZkwGSrplvR+GyhgiwvRbUmABVIMIM3nV7XUo/OKQNwTvw14jo/0/0nTkHCqrV+lKMzdBfe9YQndMHsm6hL7bMKSM3QY9xoGnr/bWzDMNQBc6/YtTFev8lT6X8oeuTyDAhmCWFlbJy82gG8YUbEzYOtABzbJOlrMGmPKWqdksTZ8HrFOmGMRhVN8XcNj6+gKLtFlIgIj1zFhtFGuSRrvIGtiqXbtP2MC5ExtxJpp7ry4dhC3m8edvljrKUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wTA08R/aTgwRoDtCuQTh+RR0xzOjULSok72bblOOps=;
 b=BfYbX1B8jhiO3FrToFQBVX4rFG+XlL9GjL4m3XPdQ0llcMvOdXAL5899Ez4jUZG13Jbl0jHQFzupJYGTv+OSn2qJhujvbG3AFRwEmtOLUR6miHBVCuGU95qwGEsM1NPC73zEkxUq8BF6H6FZM1PiqUHgLAVcTbzYRJftdZKwamPSBCKpM/PArMi/eLsGossIJpR632qEMVRlmgPGaAh9RXHmzhHuPmYhdAhdB5K4cVBsSw9fdIIW783nGtUYTehsJhd4CnW1pUkQ37wPa9/q88i6K2E3iz8VVseYPgw6YCm52fefLLSAGMA6fEiK7gOMqYpuFBNVafyKBYzDVqzUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by DM5PR02MB3735.namprd02.prod.outlook.com (2603:10b6:4:af::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 12:29:03 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 12:29:03 +0000
Message-ID: <d2ac6c08-5d73-828b-9e14-64ef03ff87dd@nutanix.com>
Date:   Mon, 27 Jun 2022 17:58:50 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 05/26] hugetlb: add
 CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
To:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-6-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-6-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0070.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::21) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 560fc351-22aa-41fa-758f-08da58389ef2
X-MS-TrafficTypeDiagnostic: DM5PR02MB3735:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EcI+cAx7eoMoCS/sopkrZOjMYpFBYBjAHoEhinqsdguAteBb7ZYev7SNztGewTCbYD4AHlrXrxUBBJIG7yyqBhRaIwgrToQupheNcgkRm0KdwaQNrBq4nNiF8GYEbWAoIunw4M1OB2d9MDbPTOG931mLBHQ+ntQt4+Wnr2UU22rVQNes+LcrR3q54f/1W5RMrlV33x03ijuMuldgm5ErhtSFLKcaKaUJlpkOqbKo7JnWxhNqemJNBffwfz7xwp89gDtXb71TV9Bsd9kCxiTYrB1vOgi/o5jdEMm6JSePB6iWSaylXyHmSxxi4YXG+4TB7M/27y8v9CRZC9v5Y0upb+OYuqP+PUNhLXwDXmFARqfM6yEPASEgqJnaK1JJTf4k3wqsVOHaxHwASFr45MqXdQ1mG/GgF5n2fDSCNvhWHS4vHbJBdcOl2QCgCtfhyKzbHd4Xu9N+PHkWdZ0YIXgHZXmsww1Y12ondCOQA/nXVEpgeOPlwHJKH+1fjm+AD8qkKbgRBvSxtMl04/kr65kQjET1/F3I0KdG4GgpvOrfkSeDEyWzHhCDs2kzBQVscZENeUKi5lbcbYzLkqwAQAioxzcXZxdETMAFdRj7Qg3c651JbmHs2pK4Y5XXkPn3o4/CuqfVnkUmJQZeX/xkiJlPkRq7FtvaPrm0R1Bck9gH651WwK3qw/mkS1Cpz2GPgoRcA8vdPHYHTLiWvx+guA8X1Rp02BWppWxXhCn+NwMAR35DbyCtVl1wQZbVx3iI2IhgmZiKiTYExxEjUH8UCwNW+F0iiS6sy6Efsr0aCHnhcaiTt2i0jqJzgnj//1qi2r3d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(376002)(136003)(346002)(53546011)(83380400001)(186003)(41300700001)(6666004)(8676002)(54906003)(2616005)(26005)(6506007)(31696002)(6512007)(38100700002)(4326008)(110136005)(31686004)(36756003)(2906002)(5660300002)(7416002)(478600001)(66556008)(86362001)(6486002)(66476007)(8936002)(316002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXB0eENxcjQwSkt1cTQyc2RWNVE0TXhIMUpWbG90SFlsMmlqL0FCVmVWREJT?=
 =?utf-8?B?SVROUXgxTnprell6YzNGam5lQzNIcXJRelQ0akhnbGUyODBpR2NDTVRLNjc3?=
 =?utf-8?B?QXFKMVhBZU1RTjBDM3hHQ0tzV1ZjYXAySU4zSktYOHU3YzQrbkpPd2tHc1Ez?=
 =?utf-8?B?aGRlb0ZwREVFbGpRTTVjVnRmeUw0SnFCWllVNm5kUEZLVnJJQitOMXo3WGFj?=
 =?utf-8?B?Z1JrWUp3dnMyais2ZG1udUl2amZWYzhGU3UyMHdmOFp1Z1daRVc5L1BMNTRl?=
 =?utf-8?B?Rm90dE9wR3p0NzJzL3hQYzc3WVUzUlVYZ1pVS1hVOWhaM0dPRzZwbkc0bmZy?=
 =?utf-8?B?alJpbXhodkdzU0NDSW1aSitKcnBpQy9qbDgvV0NJVUcvQXdKa0ZFSEc0eFEx?=
 =?utf-8?B?c0pncks0TlF1NEtsVjF0enhaZ01hc3Z5NWRya1lHSUZUdHFBeEE5VGhYVFZN?=
 =?utf-8?B?SG84ODZTRTRaMWVQdDRoY1U1QXN4WEpsNzNBOElJWXVSaG1FdHFCbTlRY1Bv?=
 =?utf-8?B?ajhkZzFzQ3kvNmxJa3hRMUZkWFprSU5SQUJxU0VaZWp5WDFQSHZOdmNwWUdF?=
 =?utf-8?B?SURMa05aeGZwdEhMYmQyU0tlZzRwd2M0Z2tiQ0pOdWlNOVgwdzR4UHExYU9l?=
 =?utf-8?B?UVppR1JyMW5XdkQvclVvQlRNMTEwdVFRYmtnMGNwRFBwMFV4WW5iU0p6ODF2?=
 =?utf-8?B?TUpESEFBdlJkTVhYRjBWNWVkTHYyWnFlTy9jc1NLZHRUMkIyVkpGaEE5bUVS?=
 =?utf-8?B?MG1YYVo2U0FMa2FQdGtrU1QyVWVkN3ZuZlR6MWxYQlNYS09vbGlMNy9wTDVT?=
 =?utf-8?B?bW5ySVl1MklXUjU5dHRNWmJ3byttUDdNc1I0L1lJRlhZMUFEM1hybTdJZ2dY?=
 =?utf-8?B?dkp6VVViRmRHT0RUQ0o4eWxwVWRBWmRYQjRXUnNzVUsvcTk1MGZuMmUxWExJ?=
 =?utf-8?B?c2NoWVJEVHlSWU5jdG41bU9qRUpIYkl5SExnbXV4Z1RNbEJzbFhrQ0xUREdC?=
 =?utf-8?B?UVpZd1J0UGJ5VGVnc2FDVlFuRWI5WnduZFlUNXJaRUd6S2RqNUNMWTFObE9Q?=
 =?utf-8?B?akd0TCtiVmViNmxFWTVhNTl5bHJkN3RZN0twUjJGRjhwTUoxTU9kbmxPTXRw?=
 =?utf-8?B?TURsUlIyOXRsZEZpTGpHcEpnOEFWakpmT3A4UUk0eUhKMmdVQUQwakdxam9D?=
 =?utf-8?B?Z2tTR3ZHT3JoZWdkWlI5SkVLZ0pBMVVjY0lVZEd5U3FGblNxWDJ3VkEyUFc4?=
 =?utf-8?B?OXNPZDhKcUdqa2drODVjVHI0eGlMV2NzOTRnRlNFNWN6OGFHR25hN0R6TU1N?=
 =?utf-8?B?b1NsMWwxeFREbTQ2eHNWRWdmb0pudUFybVVvQTUxQzVreGFyMVk5OEVBL0Ny?=
 =?utf-8?B?QmxXSEY0NEU1cE9RMTNGeEFFby9uNTdleXR4S2lDaGhiTHVkWUI5eGZrRmFo?=
 =?utf-8?B?RTlvN2MrdnNncnpPQ0ptR1IrMk1VTHBWMXZTeW4wVGNFUUhVM3BLM1JVMVVH?=
 =?utf-8?B?WDBUcmFCbjMvTmtlWXhmYngwcnY3M1NNLzRSUUI3L1BROFZpcFBubEwvMjR3?=
 =?utf-8?B?QjFzVUQxV1JsWCtONkwxMzIwTHp6TzhVTVQyZmtCSkVtZThCVnZUYWkwWnVQ?=
 =?utf-8?B?SFFzTkVTa3FhNXdIM0xKeklFU1lQbFg1cklId21YMVgvRzhpczZOUHFIa0NP?=
 =?utf-8?B?MytHdDFWWWtsQWpiTzA2UGZpQnNvZmkvVW5zMUpvd1NYcjc1WVE0OHlLUTl3?=
 =?utf-8?B?NEZEVFVXOHJUWUVvazIrcjgyVGFGMC9LSDRpNnE4K0tQdXF2dWdUbnlEcGE2?=
 =?utf-8?B?V2ZyZ2xpUGN4M0dXSHJNZDFmTUM2eVZRTGFPUHo1dHlHelJPb2VHUjFKeU9B?=
 =?utf-8?B?SURNdnJ2Y1pha0tRUmgyTlFLKy9UdFpPNlBkMktHaEJiSm5WbmF0bU9DME1P?=
 =?utf-8?B?Q1BHZnVCc08rb2RhOW0wTEp2dUJIUkJTNnc0YVk1M3NVSWI4d3MyM2FaVkVr?=
 =?utf-8?B?ZTlEaEZZSlFmdVlMSWxpQzZDaVc1VmZyek1kVEU5OERuNXJobytMdFhUU25u?=
 =?utf-8?B?U3pWZ3hic3V5SDZQTmx5TVlGYXZXak5qclNOOW9CdkVXVWRvY0tVdW4vOUhl?=
 =?utf-8?B?ZDZvaS9aZ1p0RVBJUlRKbkxTd20vZlJPemVBZ2xObG1XZmh3RlFkc1c0eGoy?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560fc351-22aa-41fa-758f-08da58389ef2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 12:29:03.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpCv27fANBfOJ3eJIM98gEdONAeknASJzjkGUjzoTZZtuPMYywTemIIPJXCDxOXq6L5lYyRlXOqsiFs6wNxJkWTNyAWDf86NfyptdTDDLbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3735
X-Proofpoint-GUID: N0GoNmZ0hC46MP53ZOiqiwW7ubwh_6EQ
X-Proofpoint-ORIG-GUID: N0GoNmZ0hC46MP53ZOiqiwW7ubwh_6EQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/22 11:06 pm, James Houghton wrote:
> This adds the Kconfig to enable or disable high-granularity mapping. It
> is enabled by default for architectures that use
> ARCH_WANT_GENERAL_HUGETLB.
>
> There is also an arch-specific config ARCH_HAS_SPECIAL_HUGETLB_HGM which
> controls whether or not the architecture has been updated to support
> HGM if it doesn't use general HugeTLB.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
reviewed-by:manish.mishra@nutanix.com
> ---
>   fs/Kconfig | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 5976eb33535f..d76c7d812656 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -268,6 +268,13 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
>   	  to enable optimizing vmemmap pages of HugeTLB by default. It can then
>   	  be disabled on the command line via hugetlb_free_vmemmap=off.
>   
> +config ARCH_HAS_SPECIAL_HUGETLB_HGM
> +	bool
> +
> +config HUGETLB_HIGH_GRANULARITY_MAPPING
> +	def_bool ARCH_WANT_GENERAL_HUGETLB || ARCH_HAS_SPECIAL_HUGETLB_HGM
> +	depends on HUGETLB_PAGE
> +
>   config MEMFD_CREATE
>   	def_bool TMPFS || HUGETLBFS
>   
