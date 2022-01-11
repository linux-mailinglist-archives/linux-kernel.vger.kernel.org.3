Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383B048A6B9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347546AbiAKEOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:14:10 -0500
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:54572
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243745AbiAKEOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:14:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZZt7+tgvw9YaetskL562QHnYarBuK2Eer5tIPq8fQalgUWpARellRjGdpMUCuw2Q8ucnwrV/xyUBfqsAOtwp6pA0Q+zyFEVmMZlFkz648u3e2Su1s4guzUwJga6henyUCYyjBYu6cT2P2YYiQqiuyR6ba9O2mO3Qc/FwgD+Qj/6MLdGvMgi1bbc72Wbs4ZWtDaLXAFd3IOyzG4j4Fnmo1xXXbSWMSh+9UvDDb3qc8dn1urbCrr7XsZsZr+GO5Cgz+qQPQCVOkksbuJbxwxhwZBPWdrTAyIV7hjzVnWq763SqHBhqfSC9UFpj4UFHNSXxjdeD9+7lc72UDu6Kyru0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvsfKVVUs3G8qhK6b8wtLdjzwY8itn+IUwfX1/lE+mo=;
 b=efvfy3bcOMFR9fHNUmql00Sz58FJiKQrxXCQFDfmLMJPc2QogepHmxPjmww1KWnvtk7tGhSc3r7BBD0tfwEDyRhrGraJYGn7UNxem8RaDEUFGbZGPBOD4wJr3+cES1jswtczr4K7HAlM4wXqcPjKP9kTe2VYYFSt3ojFGNku4j6kQvnkDdutVIbWzOmHtbDEMfuGiC7OD/fl7UnOhmL6twTXSmNSKFhoX0p+S92D6yMM6AZMRqVY6GExKIGKTi2Y970/eCagoPjEK54+BIS+BhIl8cDU9y9ARmVToex7fj83xVweYPl0JPiGEyKQgH3j302z4AIbY3Dx3Zejjd2u6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvsfKVVUs3G8qhK6b8wtLdjzwY8itn+IUwfX1/lE+mo=;
 b=I5d3FkTqiZ4N5PHL4UzpirjGzuCRrVQDtZOklp5tSzGixGk8YMf5ssUwdTgr9KFMiG94ZWAXIwko/uwwRNDilGSCUEPeg74bzQM19Jn9oRd7DsKeVvQxRFmUlNt64WYsr3VDxBI5OCXp4PhVny0R6kadwG+D+FNxw5hr7WRkVo62aJrMY2+iJ6faLyQDB9z9Y34CMOnv43B7xx/tGfmSD+ylhROCZ8oYYTYBjS/4nRfwIxBgF/HQ5oE+ni4Trn7nqzUTMsUTD5t2c9VkhjZf8T2WUDCRudjx8MTWL63AD9o8NtwOYrtE2usyaFvpt+sGazZhhm9UeX7gVon3mJ9yvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2984.namprd12.prod.outlook.com (2603:10b6:a03:da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 04:14:06 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 04:14:06 +0000
Message-ID: <f91d9546-1621-8431-5ac7-2192adcf9482@nvidia.com>
Date:   Mon, 10 Jan 2022 20:14:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 12/28] mm: Add folio_put_refs()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-13-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-13-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::21) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef5abe60-43b8-43c5-a3cc-08d9d4b8cef7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2984:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2984125F88A5BBC0A72C29BFA8519@BYAPR12MB2984.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/pEiV9MTZYMLf29c/s2XlH/ftclGqwkaW43oeiZLlSAL+LSJTEHI8f/jZUP4RnsObbK9ccpLvdNnENcptud2tKQnLFXKAEWmC4rUGbBZjpTrd8zJkTl2B3mNsSrudeZQ4/UqjPrltebJfqAyICJmSigv1s5ymJwkj9Q2sz215MXZusOLI9fa5ktd5vHyN+7dlCcf7KyAXPlsVJO8NbERNcVBKlDpJtt/r8+wL15V64HQcJ8t4Um1cvXXTbpBSsjLYWea9wReaLavl8iqEMvcImVlZGR1Wqr4FVjge/388Pc8aCa+fMFleEoDcrrszIEZhj7fY5w4ItkWqLgq7aDk54aWrFdiJ4iubdxUsJ5D4gQnm3aEOHk6sL7/fusyS5vaXanufiGXPHBXToO9X6oDZjXiJ13Rge7I+0RlSfM/GDR32eeyILVbgNbGiSqW5lIUbVJZiOi9asP5+CQ0ghsjywF1S5qp01V5bPIxsBzSb1AX4GP/qH5sAr3GOF24OPcX6TxVgE/IcDgMXwnBui7iRUlSKlInupYcvMROjNgAS7AoHdpMFvr646WSvEPGB/TM07RaL8xUIC41uiHgLwZGmA5yR0bMzzb5JsG6pMQsnnE2pDC7YTgTs1u/qSpCpg26bQ6q5Z0K+SK/7vKpahWAu+6S8TqFbYjTe5JjAi1MVgCLp7Uwkv7HfxjRZ9DqhrfCxDuVwpX0xIgyR4klTfBsVZ15EHGEHQ4vBXDNt+Ux0+nSzbxpP7U9SxQ9i9XTtCP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(8936002)(6506007)(31686004)(66476007)(4326008)(508600001)(8676002)(36756003)(86362001)(6512007)(54906003)(83380400001)(26005)(186003)(6486002)(66556008)(316002)(2906002)(38100700002)(31696002)(2616005)(5660300002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzZiTFZLR0FjVmx6clVSWTczbXhMcDluZ1RVWHcwZVhJeU1lazU2dDc0ZjBv?=
 =?utf-8?B?eWJuaHhPNWpQc3JwUDM0eEV2VGxNQUFpcnVNMWZYNDR3MWc3U1hzMzQwNWZY?=
 =?utf-8?B?bFRWeWFkY0JPUmREUzNTZ1FETUkvbjJuRi9LSDNyTUhPTFlFQTE2UktubUdO?=
 =?utf-8?B?U0RQOW5Fd1ZhbE9XSlVFL2JKb2NxUWlHM0lBUUx0VGtqcWM5c2pBVjBCOGYz?=
 =?utf-8?B?Y3NDUFhuajRralNOR3ZOblR5YW5Ya2NobURyRzVBVnVmM2tTdHZZNDM5aWRp?=
 =?utf-8?B?QVVPUlphakJHODRJYUZaZ1ZxY2U0RHZyYUszNjFMMzVsNVFZTk1sclZEWC9l?=
 =?utf-8?B?eXRKamswR3hWVUl1STYxRXJud2IvSnN0ZVdnR3hibkwveFZIaXZLYjdnSDRm?=
 =?utf-8?B?M0VDYjVTcEt0OHo3QzJTcEZqL3cvNWNjR0hhckppMnNjcHhwTEY2aStYS3NI?=
 =?utf-8?B?aSs2SkEwNkhVSWwyWUcxWnFVRFQ2dUJPN3pQNkhpVzQ3TVlsTytFbTZ4STBS?=
 =?utf-8?B?WTJLRjlnYldCUDNzNlZmallyTTAyMkJFbUpFc0Ftb2hnTzRKRXdra2tRbTNK?=
 =?utf-8?B?YlhYeS9wYkNxRHVnMXBZck9PM3NOWHRGcEVnc3AwL1VMQ1ZEbHlWd2hSSFZo?=
 =?utf-8?B?YUJDL1l1dWdkcUVKWkx3NXgwYm1tWTU0VGUxMHoxOWh3QVpNbXRkMFpKRmVh?=
 =?utf-8?B?Y2VEKzZKSmlHOHJVS2o3RmxwR0ZtbDZwOHo4akJ2YkVpd0NmM1p1OCtUYzh6?=
 =?utf-8?B?NVNySU9BRXFqYlZmUWJza1ZBTkxnRDh5REh4K1I0S3o4N2g2ZldSVmVrWjRx?=
 =?utf-8?B?b1RWcDQ0SkNScjhVQWUvYktMSUphT2ZqWk1JNG5YRFJnaU9yOHRMekhUeE5i?=
 =?utf-8?B?WTRsMEZrY3VvbEFiZXo5aTNvMFYwVTFPb084MDhvNFQ3TmJQRUZObWhqdGdI?=
 =?utf-8?B?QkFQQlBaUWFRQm9tazA0WUFQQVM3Q0VZK1NzWnJXN2ZFenpydDhYdFd2Vk5x?=
 =?utf-8?B?cTFlcjh5Rk41STJoWTBZeUNrT3I4L003YUJWZGJQb29McVhMaW1NQVF5NnJh?=
 =?utf-8?B?dFU1ZEdYa3BISDFxamx3cUpMZG93WHZBRnFmTy9xYTE3NEErcEp1dFdPWDAx?=
 =?utf-8?B?ZEhlaDU4UFBhcUJUT3plZnE4MUljcXZTYndDa0Y1MzhqUmgxaUphbVgzUUdv?=
 =?utf-8?B?eVVYd1E3azlJTExhOERSWERwV3E4SHhsU0c0ZHVWWXVZTGVNaWxVdmF6RFdU?=
 =?utf-8?B?bEFleDd2cE5WUkxuV0pQWE16V21rVjhjMy9XeGI4Q0YvejhVVE5keU9qUzZM?=
 =?utf-8?B?VUdrWHpFV1lzTzBXWG5CZXMrY1hyazJFck9GelVzQ0ZoenYwcjgzVHVvVmJD?=
 =?utf-8?B?N2syZW9UZmtpZm5tUUN4bTNpZUpQSWdNM01DMzQ2dnFGckFzUUJUZGt2ZFJQ?=
 =?utf-8?B?c2xMWm9iMXlaZ0RvL3R2REZaZnBWSm8rRmdvUXFjNlJMeUtiZ1lOQWRyei9H?=
 =?utf-8?B?WlFPdEJxRmRoNEgxVk5aZlMycTZmQWEwUXFCRTlFOU45K0diMGF5Z3UwZU1r?=
 =?utf-8?B?SXpINlpYTnZPVkZkMjdpNHMyYWJRVU1xTUVoWXc3VTNBN0FPOExXMVo5dmdv?=
 =?utf-8?B?YW1vSWJrSDlyNVJFcFRkYzVzV3lhci9wSkxKaFVsRTlYYy84RndUZ29odmF3?=
 =?utf-8?B?UG9xVWVBNStZemhBT1M1VklPcFh1YnRqZDlPeEZaMks1QUs1RStlQzBVM1ZN?=
 =?utf-8?B?U0g5UXppajlpblpXcklRK2REOEtYbmVqZk80VS8xYTdDSXdwT25mdzRDckR3?=
 =?utf-8?B?WG9oc0krQUpSZnlnQ254aDgwMjJnSUJCU0EzZXEyNjNCNnRncldMaUxsLzIw?=
 =?utf-8?B?VHpPS1lxSEVLeExENG9pYzJtZ0N4Y0RYUFpNMVZROXVrbm0vdDQ0cS9qdHhI?=
 =?utf-8?B?MXZMakgwVDVUNlM5U25oWEhVOEhDY3l4UXNMWWFaM1RQblNPaGw4RWxIWHlr?=
 =?utf-8?B?MXBnUUdvenYzV2xnT1ZWbzk5WHNoQjBXd0Z0SzBBMGtGcUZzNWd3MWlFWFJs?=
 =?utf-8?B?QnVEVndYeVN3NFJseW01eEp6L2dETE91M1hsS2tHcncrS0pvWmc2ajJkNHRx?=
 =?utf-8?B?TGdFMC9MZ081ckJnWDEra0hiR0hxdnBQT2lpZEp1UTYvamJFUSs3c3B1ei9R?=
 =?utf-8?Q?audvWATB9fDlyHGDg6R0nFk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5abe60-43b8-43c5-a3cc-08d9d4b8cef7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 04:14:06.2136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ckTs4sNn504D80G1Mqsa/BesdDTfgJPLDbVCqfTkxyZotouxJnDCe+HOQn/sKIT+JzvQZGRAywkciF4/Y4RQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2984
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> This is like folio_put(), but puts N references at once instead of
> just one.  It's like put_page_refs(), but does one atomic operation
> instead of two, and is available to more than just gup.c.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/mm.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 598be27d4d2e..bf9624ca61c3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1234,6 +1234,26 @@ static inline void folio_put(struct folio *folio)
>   		__put_page(&folio->page);
>   }
>   
> +/**
> + * folio_put_refs - Reduce the reference count on a folio.
> + * @folio: The folio.
> + * @refs: The number of references to reduce.

Tiny rewording suggestion, if you end up sending another version:

  * @refs: The amount to subtract from the folio's reference count.

> + *
> + * If the folio's reference count reaches zero, the memory will be
> + * released back to the page allocator and may be used by another
> + * allocation immediately.  Do not access the memory or the struct folio
> + * after calling folio_put_refs() unless you can be sure that these weren't
> + * the last references.
> + *
> + * Context: May be called in process or interrupt context, but not in NMI
> + * context.  May be called while holding a spinlock.
> + */
> +static inline void folio_put_refs(struct folio *folio, int refs)
> +{
> +	if (folio_ref_sub_and_test(folio, refs))
> +		__put_page(&folio->page);
> +}
> +
>   static inline void put_page(struct page *page)
>   {
>   	struct folio *folio = page_folio(page);


Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
