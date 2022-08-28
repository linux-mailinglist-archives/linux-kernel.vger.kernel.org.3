Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781F95A3ABE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 02:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiH1A7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 20:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH1A7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 20:59:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6C0501BD
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 17:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaDMqx5vrETLcLC5RRYJAK0JDXyzLEeStpOE4FYJdMQsx9TsuXffq0JfV3RWAHWsEMzE8WC4nEMQ7ZAl79j2mvYtcq5+woNevPBYv8FONIOpbKC123OxyXFOHj2Slk2jmt5XtTcHQPx0HXhkbRCt7kJJr8jdviWi2Zyi+2QDG4oHoWsfjW/biv4rCNmumjxbd0NvIBfIXi3CpT/y99yEbeQC2bvp0w+PN5fHQ4rwjc/r9LZdHhNIEAJ/8Y07/1JpDmwf/zeUfzm7F9AV0I4zcWJ6oxI5Bu7Mj96d/pevNIBEvmhXWj3qNkXCykvlb94FbK8CtxTQZLhUxN2SfT6u7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfRYng4ouihPTg3N5FABq630ffCumSEItstXVRQQiWg=;
 b=JqIb1AgIp8tfxN8xgewsblYgaOQrWEUen+8RvAbp08KtCJjr/SXNzztFE0tXDlQ5g9h4UNybzt4lryE9AQ/AFQVhm6ftYms8Se7fMXLGYQqdTuYRl6q4c18+eu0g/KRXkus6OYEq67l4giPgEQgEequK9cFZfVtSwM2Vc/xN45aqFHfqcINlS41FsRZ1kS+JGKOB3Su/3gkYLST5GmSIRRb5tkdZ5GsVh+04WxB2PKuHLgfELwnUQSZCXRVeOUyk+UbyXQ+Vyyh3Do0cgb2BYtNkEa843ZY/vTUnfEKgc0Sn8N1fDe/8Kc8uJzZEovSHtsb8nFcTojT4kJUax4pG8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfRYng4ouihPTg3N5FABq630ffCumSEItstXVRQQiWg=;
 b=T5I+MEulItpA2FBG1wuzJWrmQvWgx74GBL0dk8Tzpb9ymf4IKC/Ym2pUHEhzYENdjtAJ0C4weLv+1/UvxfjqLXdcgtFzZeGk8bRT6T2I1wOeSKkeP140asP8QixOWQzgLCDgyyka8s7cAEEbtpgqn4cjxrsQxI8T0UT0ZTT43LlQbm+qduPqNjFqNH7TJDx6uRsd87okhQ0aokczdZ81KTB206jqwoZklfe8Ifbmn+QVBn3WeeY4RXMLlXoHzDBSeGx1+XWeAdr9Pk1C88OPOcV9baGSuMEuN5fEf24DzxsKT1yRH/iWx++zd50/F7qyye0VUVG+zi+DbX+sklXKRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY4PR12MB1829.namprd12.prod.outlook.com (2603:10b6:903:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sun, 28 Aug
 2022 00:59:35 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.021; Sun, 28 Aug 2022
 00:59:35 +0000
Message-ID: <033c2e8d-8ba9-3e0b-9dee-7d0973c708fa@nvidia.com>
Date:   Sat, 27 Aug 2022 17:59:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] mm: re-allow pinning of zero pfns (again)
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>,
        akpm@linux-foundation.org
Cc:     alex.sierra@amd.com, willy@infradead.org, hch@lst.de,
        Felix.Kuehling@amd.com, apopple@nvidia.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <166015037385.760108.16881097713975517242.stgit@omen>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <166015037385.760108.16881097713975517242.stgit@omen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75e20251-8e62-43c3-464b-08da889092e8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1829:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3SJZuu5df/IvZsrF3S58YXwQtf74kutmqq0lQPlJZh29Vh+04ra993KosV+kTafoafO2YA0Thhykr/Bg7cschxFjEowTnxuRR4vxYPwhbDrns12I9n1+6hZ8EsOGGENWnICPl5o3V8NqBDlvcGBlPH3DK/2dyG83kLyRZXvPhcQDK6e1Yy7hFzNQf3680DpKo988n6GYsyOJ9CAHrcQr/XjGmeBDMf3myO3BCoXQ8HLKZ58/EkK+rHWGrj6GWSlMDiIAuFYphm2LqqINFQUENgZ2hQtwTxPHbmwdRSsPkaBsOpAyD8ENiviNEIiJg6U8mJv1hjQ/jZmbrfGBScxFalxw21MGTXlgMV1Nj6fYjvRie3FmZy0UWNyJS3hkIKcILO4HZcJXb5suiPH1A6x2rr2WJowKqihXGsVVQ/0mKOmDgge+03CtaL4JYkbH3m4s2drwI4e3HbkLfA8yXiyEozo+NBpdoDKLVBHn7PJ5q0Zp5hhtpYq6BUEq3D/kTmR9ziHU5D/lf86ilDJz2n6ily97mCXzLpGoh8g2pPHynr06DJ31xLe4T/jYrqi3rSzuT7Zdv9g3JZG/TpDSslhtnAaVs6u1WGEKipFKCEe/NeODb8f7KkgEuROqhKbpPUQTIP3oYH1fqzPEt+g/ykPQNRaLvWmjV3oy7aIJ1+ax09bz03SnyrqS16fRz/tOlPtag+ezrvofBLXKCIsj5XI6VPR6jTp//VOurPa+ZzTTCTHOuyXW8FdjHji8oYynKE/ApTH5ObyFxltf3trMqaCWiE1nFusz6Hqpyj9FhQe7T5ghT34acGX4rCRQhf1sA5Lg0i6w9prR6Xp3EXU9YuETR0GS0rLkZLBvHnCRhCgSPIFQlNK2xFe33ic8IJBPIng
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(83380400001)(6486002)(478600001)(41300700001)(966005)(2906002)(53546011)(66476007)(5660300002)(8936002)(31686004)(66556008)(8676002)(66946007)(36756003)(4326008)(2616005)(186003)(86362001)(38100700002)(31696002)(6506007)(316002)(6512007)(26005)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enovSWhIa0FaRFhza094THJjVGlYR082RTBpR1V6S3Y0RG1MTXdBaDl5eGNO?=
 =?utf-8?B?K3hWTUE4SEZkSDFCRDduNXhnRVNQOTJNQUtJQWZKK3JYOGhrWjJPZktmUko2?=
 =?utf-8?B?NEw1dE9lZWNhYUljK3FENkozd3Z1b3RadlJGdGVZNXY3TlY4d0V5QzVBVWRR?=
 =?utf-8?B?VldlVEcxdmxOQVFXTndobGxIbXhid05yQkVpMzdYM2FBYWhqaFM3WFRNSG1K?=
 =?utf-8?B?UW95bjh5b0VicnhSQWI5RDZVQVJIdFMvR0N1NmE5dVBHS08veEYxZnY5U3Ri?=
 =?utf-8?B?YnZ0Vi9kQUpqektWVWJnTTJ5MzBSaFZEVEFaTEVPWWhabWhITnZaelNVMTU4?=
 =?utf-8?B?YXNIazYzT3JpYXZ2OXpXNzJZbHpWZ0JpSDV6SWdIL3hiK0FQM0d3MzRQVllu?=
 =?utf-8?B?WG83TTFLQkU4MVMxd1E3TW4zeTdTTHhtenJmUHBZQXNFUkpJWE5MM3U4akFV?=
 =?utf-8?B?QTdhSkxRcUlEL2RNbkhZZHRPY2ZOYkVtVU5ScVQ1QmVOS2dyeVRoTWlPVkov?=
 =?utf-8?B?OUhRQmtSYXJHdForYVVkdGpSd3BidzNXS1dWT09qQUNLa1lRdlZqUHdlNkNs?=
 =?utf-8?B?MVA2b2JCU3BRdjF4WGhCaWQ2bzBSZVJJd0g2QUkrcDlCUVpkYXY4c3pTd1p4?=
 =?utf-8?B?OWJSYlNlSXBaL1FUYjVkWHpBZ2FNMmUwYk52NkxWa0poZDArL2xYY001bkkw?=
 =?utf-8?B?TkpVMkxEVFZwZjNYYXV6MExlM2orVytKN3JKZGxJZWdUbjFibXNmTnEwdFU5?=
 =?utf-8?B?REJ3Y1FMVkE3emVXVkVnTk9hcTRrUnV0OXhLNWZSajdPc2xKekE0bnpnYytX?=
 =?utf-8?B?YzkrOW96bDZUUHRwbGlIRFozYmMvVUplLytkRDNDRHhIcDZHaloyaEY4YS9V?=
 =?utf-8?B?eGM4RUZHOXVCbW1oNWFGamR4WmE2a3J4enlYeHF5OUczdnIxcDV5KzVDR04x?=
 =?utf-8?B?bVZqNUlJMUcrSUZSalhPWlo5WVlyZk55VlgrNmRYYnM0aWVHRDZidmZZaytU?=
 =?utf-8?B?UUVKT0FNaUVMdWh0SUpHTlROOTBKbkNxbHFtRWRLOVZ5cTVacnZhWjhUNjZj?=
 =?utf-8?B?S2c2VVdWTWNyRnRLQ05Yakc1OFdLTHdvVkhRUjFjcGZHT0QrMEVkMHM2ZGZD?=
 =?utf-8?B?cVJocEpGZWNqcGlFTm9hWXlBRGIxd0ZKTUxmdXp5eWhzdERxdFBMdHAzZE40?=
 =?utf-8?B?YnErTDlnd2ExRlNrc2pSNms3U0RxZndZNnBOK0JKWlh1MkYwc2paQ1ljR1dQ?=
 =?utf-8?B?UStUeHFlV1JVVXJxWUd1TVdNYnM4cEltOGpzMG9DdENxVkgwNXVTeEZYZmsx?=
 =?utf-8?B?YVBnc2x5Tm1oMjBreWQ5dG9DZzFnaE4rck5pdmtadmI2dDJGUWZDUXM3c2ts?=
 =?utf-8?B?WHJlaVNHSS9zb21VSkdEbVdYaDB1aVh0dkpSWlh1YUc5eGIxaUdjeEZWTjlF?=
 =?utf-8?B?clYzYURrV05Yc2NFVG8xd2VONE80MUxyR0VlTTNjVG9nUGdOMHE5UTV3Qld2?=
 =?utf-8?B?N2RYMjRpU2c3VGFONVFqUHBQNGpzcGdzaHBndG9XTWtDRmgydjVXaFlyZXZi?=
 =?utf-8?B?K3JJazVMVVhDSlVoSm1qaUZKUEJ4V1Y5bXVZTllFc2RlRlZHeHI0RGtlbjlP?=
 =?utf-8?B?MUswOFo0WWV1MFBwazZxeFkyNkJKNzBEL1lVQlk3K2dyVUdia1QwajFDeVpa?=
 =?utf-8?B?d0Z1RE9ZdEdRTkJDTlAvZmJ3cFN3ZlhRbFNMR05zdEdEWFRvLzhzbkdlR25E?=
 =?utf-8?B?emtGd2RrK09INXNZcW8zVkxVUjh4eER3TklFbWFqRUl4Lyt6QVYrdlZLTFQz?=
 =?utf-8?B?RVhQTkQ3MThYSllQVkFBSElUcTlPcUlOUkdDZW9ndy9Pelh3K3d1UHh1ckR3?=
 =?utf-8?B?Q0YvNGduZDNIM2ZCLzBxSm5UcDJUby9hakVMajVUbm5pYm9WVEowbGtOTzA0?=
 =?utf-8?B?ajM3aXFIVDdmVUZxQmZYTTkzOERPb085VFVpcklyS3JPNUZnQng0ZUxBYXU0?=
 =?utf-8?B?a2h6ZEZ1VDVQVFRQTW1MTldmeE11aVdkSVFITldIcW1sTVdVeE1wa2FQWmQx?=
 =?utf-8?B?WDVGdm9qZ1JJSXJ1RFRpMktxVDVQazJzWjZsZjJhVFUvdU51bXhpL05YZmp6?=
 =?utf-8?Q?Y4k99N8I64SQ5H16jr5EdaiVD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e20251-8e62-43c3-464b-08da889092e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2022 00:59:34.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbihQFDvQoG67C38E4eSlhD3lttxgpOM3/aisIvZYLj02VgdnK8bFlqTKIPbuBgrD9Sh/bFAVECsc/y1uUVSfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1829
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 09:53, Alex Williamson wrote:
> The below referenced commit makes the same error as 1c563432588d ("mm: fix
> is_pinnable_page against a cma page"), re-interpreting the logic to exclude
> pinning of the zero page, which breaks device assignment with vfio.
> 
> To avoid further subtle mistakes, split the logic into discrete tests.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
> Link: https://lore.kernel.org/all/165490039431.944052.12458624139225785964.stgit@omen
> Fixes: f25cbb7a95a2 ("mm: add zone device coherent type memory support")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  include/linux/mm.h |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
Hi Alex,

Looks good. I'm suggesting a simpler comment, below, because
even though the VFIO folks are thinking about VFIO, here we
are deep in the mm layer and there are lots of non-VFIO callers
that may pin the zero page.

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 18e01474cf6b..835106a9718f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1544,9 +1544,20 @@ static inline bool is_longterm_pinnable_page(struct page *page)
>  	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>  		return false;
>  #endif
> -	return !(is_device_coherent_page(page) ||
> -		 is_zone_movable_page(page) ||
> -		 is_zero_pfn(page_to_pfn(page)));
> +	/*
> +	 * The zero page might reside in a movable zone, however it may not
> +	 * be migrated and can therefore be pinned.  The vfio subsystem pins
> +	 * user mappings including the zero page for IOMMU translation.
> +	 */

Those notes are all about (some of) the callers. But it's a simple
answer, really, so how about just this:

	/* The zero page is always allowed to be pinned. */

?

> +	if (is_zero_pfn(page_to_pfn(page)))
> +		return true;
> +
> +	/* Coherent device memory must always allow eviction. */
> +	if (is_device_coherent_page(page))
> +		return false;
> +
> +	/* Otherwise, non-movable zone pages can be pinned. */
> +	return !is_zone_movable_page(page);
>  }
>  #else
>  static inline bool is_longterm_pinnable_page(struct page *page)
> 
> 
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,

-- 
John Hubbard
NVIDIA
