Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CEC48A7DE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiAKGkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:40:52 -0500
Received: from mail-bn1nam07on2045.outbound.protection.outlook.com ([40.107.212.45]:9958
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230516AbiAKGkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:40:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zfp0RPCh8OLmfZ95RaEAIQSp2f53C7a4HjOqXNdXLBOfsX/KVjSaKdK72CLWQi5kj67MvapYLrxLVq6eXAbuHcpOMgzHALp7QRALlnCfP2naonyATpfwjT+Qx57EFMe8kH7BT9PWFaNkVSyRE30hNbu5oyU++WVRtsK+xIdPro0rcl5W2rM1LN8fH2JQCQMXO2tlwtGS5JaWc3CqoHVWSYbxgVXO9pd0CbQRWPBfA3Q2GHbZctU3L5XxoVwDh4w/TkW+uBBnpeZDXBN8f/hG+/HIgprAMUWO6DODH+SG0lrHc9UHkN7KEnOitk2dr1rDOcgsEHd+x+Dlx97mGeR+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDyojUBK19vS5WhYH0xBC8L9jS0KVFm7aQ7CnRCILW8=;
 b=d2/cj/g6ocJAqYMuxwHeEm3Ku69dalaijdvcjvyHhAfFybTfEbLeFohsk+Cpm9wimH0ra4m4RnIwNL31K/A00ydHT4hDTgmHFT/+imShuhl93qe9+MwTjUGH0eCqhR7Kh9DfYLKFotqpk4VUFwXAljWcpIOamO6QcQOkk9phQVlt4dzK7O/LIgBlseRAT8dS8V6DH7vXmSTkVQELi6o6BmLBa11LWSDehDdtOHT6FwEeN22MV/tX+Q+WToSwCP7dddmvQTD9LGKkU4LhpB259v6Q9/wbhLXeJGTOuHVkO5Bmvgzq90pbTFXLEG4cVtP/FMUK0OlqslwUEvS/q8cOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDyojUBK19vS5WhYH0xBC8L9jS0KVFm7aQ7CnRCILW8=;
 b=tasAkMcaXZwUys86jpcA7mImvRvJ4b5OwEhfKXknRF4r9EhSkZqMcoZqkwRfaI0FqDv9IC4/+kCUF+FJ3dlW8WFrsw+9K4b2A4QIg+gMhzTaND9ynrV3pm6JQZHaLuhdpED0no5K83SaLuZYCMxP8nxmd0XNXiGjcNxsEsXllEDTKyXFqeHbC2c3l+lZyno0ToDGuNN1ZqhVqSSBZ/p/MDRN81SD1ujuj4GlRNS76uWUGBEmmlXAWtyNebJrght6Rlsgr30vUFEvXNdC1VsE9MMdjCXDxXMOG3CZmDfUBW0XmD1fgTZ6njDgay3ntddELsAU0VGV2zX4BjKZSzpn2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3511.namprd12.prod.outlook.com (2603:10b6:a03:132::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 06:40:48 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 06:40:47 +0000
Message-ID: <5d29d866-2d5d-6a64-eb35-735468ff8649@nvidia.com>
Date:   Mon, 10 Jan 2022 22:40:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 10/28] gup: Turn hpage_pincount_sub() into
 page_pincount_sub()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-11-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-11-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4b3e457-3868-47e6-5e84-08d9d4cd4d3d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3511:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3511E177D408C835F0F07005A8519@BYAPR12MB3511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Og9a7VxxgcoUCWPF5eKJeLWAkgUb5SF6xb5g8WDfIPpBYQGPsCvuOTxR9w8V4WnBNaf9bpbCwqXRwnennPoQe+JApiKDut+rV/xttpPTUJQYB7f51aCq/L1Z7Wzr9nWti2eNoliKwz4F1GNgIgtUS3eHt2Ta5kqzt2np2SgX0CoJHFc+ZgKNu9N1xtVndzwa3EXvUZZUJJSQEl0zttU00PbvvmmUONawgH9iuHQoA930FO/NndfuPbxQSW+c0OrgJ9GK7T37y62K/LAvTAOQIfBkLWJ4rNl51TjYuThvvRK+yr84NuvsBg2CS/dVaN9GVLB1VpkP/k9GhAK0oJgDGCZcnY8Qvff2CUh6jiIafbsb71F3PeNfbYrnxfYtNSVTi6QcpuPy3xyTucV/YhS10g+XIocTTla7RXFG1LB/Lyd8aBsJ7jQggsHJrr16nEPeJozkA1TOhtk3Z6i6z+nOliL6LdkMXLFAwp9ibZUyh6xOtyR5EuN+V8q1l6nCzGVQfRkzZIpjzwigw9BQM7fc9QwVcrc7R81PgbZKEdL08+bhlR78uitZsxi2ZMIC1utUis7mPpx4Qi5gGqDMvssxwsTqIkji8QJ/KrI0HwX2uo1m47hXTYERIyhdCuqnHXs7kAT2y+0zFxTvihaNNfkmXN54VtMdplPKJY1Xqe5Rb+vJiZ6bUVNXWWTDGVEoqFxnzv7UvbXpbvvhW8P4tW8/fitPUULF9R3zgucRPkRlT51NgnzSVaYPlPNz6awDw1MY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(31696002)(83380400001)(38100700002)(31686004)(66556008)(66476007)(66946007)(2906002)(8936002)(508600001)(26005)(54906003)(53546011)(6506007)(6512007)(186003)(2616005)(36756003)(316002)(86362001)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2srYTJRK2oxUU1VQXVjRE15WWR4Nm8rSWVuMDBZUVRtRHVmbjBuWGRKZ2E4?=
 =?utf-8?B?Z2tnMmR4TjRqZTROQ2ZtdVh2MDRBQWdkU3UzTUZ5THNKSlIrTUUybWx6TW5m?=
 =?utf-8?B?UWlVZGJ3RURyZVFsemNtUC9VY3dod0JEaVhZRFpRblQxUW5GR1B1U1l0cGZV?=
 =?utf-8?B?a0JzY2NDZDF3bW1QaVNCcTFCdDh1eGtRV0ZlVHBBKzJIN0Y3S1BDVElIdys3?=
 =?utf-8?B?c0o3OHB2Vy9HZk5Kc1dPMkhsK1NoTXRiNCtuVDZ6dTdscHd1UHc5THViWVRR?=
 =?utf-8?B?a2JOSWJ4MGs1QWJYTkpQQUFPcmN6SFBXcEQrcWhwV3pvQm55KzBncXI2OFNE?=
 =?utf-8?B?TWo2bUNFOTZXZnZQQ0toUnMwVmFLV3hXZTQ4a2g5RDlyenA1VXJ2d3lEeGxt?=
 =?utf-8?B?OXV5TXVjZ1BzNTdWcnF3eVpUcjk3UUVqQllzSEMrTnc2YXFUa1lBYnJ1TjU4?=
 =?utf-8?B?V0FIRnc4bVNXYnhMWCsvVmxpQk1yK1ZmVFZCQmFuRGVxZG1lUkp6cVdES1V4?=
 =?utf-8?B?VVFxNDI4UFExTUJYU0ZaUXZGdkt6OHo0SngyYkpia29RdSszNlFmTS9ONXJW?=
 =?utf-8?B?TUwwSzVLRnRkajBFTjc1Mm02NzFBYXFlVTV4ZTB1TTdOenZNWjJvV3UxNkhS?=
 =?utf-8?B?UC8rTFh4WEtmWVNZT3h3bXJIWkErb091cXpFZWRqR3NNemR5ZDZCeWF5KzFJ?=
 =?utf-8?B?L2JTME5URlprMFNaWmxHSFJDM0dZWFRGQXdmTkZhVnpJRjI5cHA3MzZiU3lv?=
 =?utf-8?B?OEhaZUFrM3g2OTE0c2Rva2ZzQUlLQnNZRVN4cE5sT2ZpUlQwejlUQmF0UHpq?=
 =?utf-8?B?ai9EUEZva0NJTDRjS0VIYTVVY1hVTUhrd3pQYk5CL3FoU2RWQkhqenY1NHl6?=
 =?utf-8?B?RzJ3UlBueWh1Zkc1MGxhK1IyRzVScnJOVVNCS2RvY05WRHJhQjN5aHhIbHhU?=
 =?utf-8?B?bGNtUEdiampvZnc3cTBIcDFVWElkTU9uNWtqeERwL1Z0Z3U4allNT2JsblA1?=
 =?utf-8?B?ZWpXSmlTWHhZOE5qbkNuV0Z2a2hNMVRsdzRGdGNvdEV6QSt3bTZGTitZTjBz?=
 =?utf-8?B?UFBJWElYSkZSNXRuL3V0WDlhNThoeVJCOW8zUXlXSHZlUkhqcXM5OXNidEZ4?=
 =?utf-8?B?SVp2OU83c2k4N0pwYkJzMC9INzFnbWtwVXRoMHlEdUhsZ2FTQmtkWHdYWlBy?=
 =?utf-8?B?aW01RHRCa1RHOWRGSkxITWZOYjZiMmVRZi9PT2hmdndSeUtteHpHVVFhN3JL?=
 =?utf-8?B?cDJpamhMakVCejFqV3FSUXRweEFxckhGemNnUFI1UEliaEMvM05DNnp0NlhT?=
 =?utf-8?B?L3VJRTMxYjRodkVKWWpTSW5hWGo5ODFnbXNiSVFMaElKci80M1kxMmRpa2Zm?=
 =?utf-8?B?ZENCMGQ0dGVFY29ZWEc4YzZMaUFXV0tyMkRQNVVrRVdxWG9nbWFjMEZXaTJj?=
 =?utf-8?B?TkZCQm9zUnhJeHp0WncwNUtYK2NDVEFkU0V1L3EwTUhaamJOM2p3YWVqZzlv?=
 =?utf-8?B?ZGcwbTZnVFBySFIyQXRNVmVDUEZaTEpiRXNkdzBCUkdVODQxTHpLMTM2M1I2?=
 =?utf-8?B?UkFLWFh2ampmeENtcE9MWGlWNmgyZWlpR0xSeUxqVDE5Q1VCK2hxWE1GNGtt?=
 =?utf-8?B?ODBCc1kySEpoYlFrcWhpODcvQUowNkpFL2E2SDNQMjk2WS94Y1NvdW1BRFVK?=
 =?utf-8?B?SE1Ic25Lb2tBTkx6TitMMEx3d0RKWVJFR3RMNE9NMUZKRml1Umhta1Zudk1T?=
 =?utf-8?B?dFA5cGhwMms2ZW5SVVI0dVlLKzZMRGVQcDQ0dGdOK0ZMTVRrZG5wdXk2a002?=
 =?utf-8?B?SWV5Yk1uVWJ0b3hsQTRtbExMVjJrRmZRUGRUenVVVURXYUwyQVllTWxXL3VD?=
 =?utf-8?B?YkM5STNuTDNuMUFmSU5RYkZhMDU0RFk2Wmp0WFRMUXFiV0pOQ21ZeFBzWTJ1?=
 =?utf-8?B?WndZeHphNUVLY3BuVXpsb1ZsL1ZmM0U1SDFnblI2aDFYVGw3TU82c2Z1UzRu?=
 =?utf-8?B?NS9OZ0hWNjlMSE5QaVI0SkRoMkUyTktIQkhWTWJBYUtQNFA1QlJIc1V3bW5R?=
 =?utf-8?B?QjdIYmUwWXdIcUVJQ05ZdDZYeHhDeUxnWmo0VTREZjBKVkJGdTVDTW9hUU95?=
 =?utf-8?B?SnVqQ0ZyNWdQN1dFSHV5TmltK0dERnZBZ0JBVXViNVN3Q1Nzb0p4TUE2WUxD?=
 =?utf-8?Q?4BiH76OqfrWIBcyLJM4ll84=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b3e457-3868-47e6-5e84-08d9d4cd4d3d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 06:40:47.9668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7l4Gwap3m7iNbksWJFKf1H08pyVzd7qorXaUH11pW0O1dbfFpyZPWg//z3rxKqUgdQuP/1eGgcJAANj1JZCGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3511
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> Remove an unnecessary VM_BUG_ON by handling pages both with and without
> a pincount field in page_pincount_sub().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 3ed9907f3c8d..aed48de3912e 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -48,12 +48,15 @@ static void page_pincount_add(struct page *page, int refs)
>   		page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
>   }
>   
> -static void hpage_pincount_sub(struct page *page, int refs)

OK, this is a correct transformation. But it does make the function, as
small as it is, rather hard to understand. It is now factored out at a
strange place, as evidenced in the difficulty in documenting it. Here's
my best attempt so far at documenting it here:

/*
  * Subtract @refs from the compound_pincount, if applicable. Otherwise, do
  * nothing. And in all cases, return the number of pages that should be passed
  * to put_page_refs().
  */

...which I think is worth adding, if we can't find a better factoring.

Either way, it's correct, so:


Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> +static int page_pincount_sub(struct page *page, int refs)
>   {
> -	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
>   	VM_BUG_ON_PAGE(page != compound_head(page), page);
>   
> -	atomic_sub(refs, compound_pincount_ptr(page));
> +	if (hpage_pincount_available(page))
> +		atomic_sub(refs, compound_pincount_ptr(page));
> +	else
> +		refs *= GUP_PIN_COUNTING_BIAS;
> +	return refs;
>   }
>   
>   /* Equivalent to calling put_page() @refs times. */
> @@ -177,11 +180,7 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
>   	if (flags & FOLL_PIN) {
>   		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
>   				    refs);
> -
> -		if (hpage_pincount_available(page))
> -			hpage_pincount_sub(page, refs);
> -		else
> -			refs *= GUP_PIN_COUNTING_BIAS;
> +		refs = page_pincount_sub(page, refs);
>   	}
>   
>   	put_page_refs(page, refs);

