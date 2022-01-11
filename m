Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3168548A4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346189AbiAKBS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:18:58 -0500
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:21568
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243319AbiAKBS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:18:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChwTYF9n8xMfu1XsTdEkmrd5BJQlRr6aPgh78h/5sba1qPEcKH7mR0490CTyLEi6AfaqGzHg9rmIRHk7mQB+uXbV9Bau7Qxswy7mlcrW/X76D392WTXoQwOqjzThxN2iWZPxXJDv5wE91zUKfIf7WC31k6nHZefrQkAuXwqigQ+UYJcJ14gHRn6DlthQlYzLlJXXZLPQfnmbk2PeejzIBnNCfjusz+h2PF952IKSEK7bKzJ90NjoT9iwlqPCnKX1miE/4Z7BNsr3hg4AZvESfkIB7nqTLWMxFHpfSmMx6jTopSw97K7/WqyG5lFoqWI0n5USv9hdotgDKYn7hDYwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AkdqpZ3VyJSV4uvJ5+xn78kqP31DQ4/Rc7BF+84Vkk=;
 b=HrNbr0yeVuoxiK8fNVabGGmLWP6EVd7qlg+9ve/OWIox+eZIh8/Ol3qCOwn0IXEDrzy7Z9oSAf0vHzbxol9EBJRB2X3p2FU3MUBKEvdcGS78WidK0V6qmkpThE5+1+5rRbMif6aParn5CCQyBRFVr8B2XswxpKTHo3OH2Lc+vch3T+eTC0/3ygiYOOtopcyIW/6bxtc/Q17zFZmYgj17HTNQD+6Rh5Wju0CNPr7uwLp7SLzbN0fhuT01hY2J51HqOmKaexVzORklXYscTxn+dZajZSb+eZP7qX72Tqsxg5VPcvaeVxk0zpYSB18ajs2EjnKiiFpLCaARzCmAIbl30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AkdqpZ3VyJSV4uvJ5+xn78kqP31DQ4/Rc7BF+84Vkk=;
 b=ROc721Y7SLAAqHx7SZYabsjli6b1Q0yDZWg4umR+yWjN5ZDHHcMr+y/6dOAsjJF62xAtBmfoAK6hkq2Uv0Le+vVGMH30VvFf/59AKbYOzc6mVNCYF+jRb/cBDa7LmVE71F93smN7Q/EqD8hlt71BNn0VOl7IzCqAcebHtLHChO6A7ThnF/kU+moCgQcYP8CCHodty4VTo6dfT3zodaVeGZu3P2soaHWsfeSY+lTYG2KnbSzt6rWj1SbLzOSFwPBG/o9S0hYT9Nns0hWhi+gs6GQd/Q7rbjQ0W/C2Fb4fNooXahx0M1w8wjFmSkVRfjrAyD+/EcxhgXsP7U8WUyZIUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3651.namprd12.prod.outlook.com (2603:10b6:a03:1a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 01:18:55 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:18:55 +0000
Message-ID: <3f2ed38f-e0ce-aa59-88a3-c2cfbb2f83a4@nvidia.com>
Date:   Mon, 10 Jan 2022 17:18:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 05/28] gup: Change the calling convention for
 compound_next()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-6-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-6-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::20) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c4cc474-4836-415a-51c1-08d9d4a0563f
X-MS-TrafficTypeDiagnostic: BY5PR12MB3651:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3651AD1D258B6ECC3219FA61A8519@BY5PR12MB3651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:194;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2PLkTI38W6aOiGZ3PEvOLMakWs7GnSPSf7BURM9nuyVlJfzQZnkiQza83BsDjps2TpNZ9JOIUvfE3BHPTDi421YD5A+Z88FUVu2PqVjzO7WTAmlWDU5kwJr6zuyUcFwnwNM3t0MBIj/n74lxLiufmxl/ujdTLpYZcgjPP5yD0W6ygKRg8dbhJPIRFeUmy96oDHb3M2IR/+/74o3OkAR51x32v7+94MY6UyqJ0HbREars7JA80vfsmsP5AAEG1ORsj+m8Ya0ZQSNKFwYs1hqAEo6FWSr9djoWExz2y3jwoMW1R8dROC3+rT+eGp5UpuC6kXlzwmBzUgyiIsBXAvCHJsJcNoZfruZHjrcr6ZKGOX3xO2LY8nuTgL5UP7YlaqTkWANsmYVSfOhFqvOoOCL13JMcUOasfVDAF9YMhG/1Jk01j1JwHonQtPlJTTxzGHbcweIRtzHm3TvpYfdchOT+gJLBmJ7bu5Yzj2JZc1ojOeac0pxQujiXuucCtUgy8CQsdIK5yrvzlQ29+YKoorY6W29hKV4vifeebTeSzZWH5tIh+iLZpeIVfWHelcMFYfmMUBj+K0KXoWOKrgsJpSYLG8PBiTpQi4UuK/0QA462uNFGsOO5WSAUCgva2t82cmjC06jg/jaai8BlKpUy7mwHnX48PtJmQmhANu0bl9gznEEst3XVjGabXN1dsO90BIwbhKZC7FxIWOtD159qE6mc0HCshqTS/Ui3A7hNX+PxA74TbrCp+yCQtrW0ckArIWo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(38100700002)(6486002)(316002)(31686004)(86362001)(53546011)(8936002)(186003)(2906002)(66946007)(26005)(54906003)(36756003)(31696002)(66556008)(83380400001)(66476007)(6506007)(4326008)(6512007)(2616005)(5660300002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDJqRVBEQ3NhKzJGcGJldXJlSVU2VEpvRmI4Z3NlSVc5SEFBQWZsYURjdXo0?=
 =?utf-8?B?MHFDS1FacmlpcTFoUW5KRUhzTmkwWGxxck5OSGJqdWtLTUZIRXBodnVLL3pN?=
 =?utf-8?B?M0tHRG5CZ3h1OENlS1ZHY3V2OEVxNS8wYnVEcytUTGswb3V4V25oTUFuSy9Q?=
 =?utf-8?B?ZytUeWN6aUZnV1pOdXlCV0xtekhZTXdoT2ZMZTVaOG9UMHRKSzZpWkpqMHov?=
 =?utf-8?B?cWF6OHdmeHFaMnRaZ3M3aFNrNGNZWXBxS1NDWjgrMzF0VENrSU5Sc09BMm9S?=
 =?utf-8?B?L0pRcTg2SGdSS1d3c2FKTXdNNUpSYzYzbDhORjNjL0NySHpSZlZLb3pha1Jw?=
 =?utf-8?B?bHAyVjJ5TmRwaC9WUC9kQnplMk4vQ3JuaDhMN1pWRHFiOTF6Nm51RFZPajhR?=
 =?utf-8?B?dHJQSHBhaUZrOVF0QjdUellLeEl1YjNYaHBLcWVzWkJMSkFVSUtQUXhvNndT?=
 =?utf-8?B?YW03OFNHSCtpc1VxMmpUN3JCWUN5RkRSMDlvSXd6VE81Ly9NREc0L1FUdXNL?=
 =?utf-8?B?WW53R3psUTJDMVJ3MVpySldUbU41dWlvVXQrclBabWJJU08vU2grbWJqaGNF?=
 =?utf-8?B?clRaaWwxeTROSDZ0T2lVTUVSWWNCQTNnNU9kVFFPb0JjYmk4akI5WStPRmp2?=
 =?utf-8?B?NlZhd3FicXA1ZjA4ZkFSd2N5MkVlbTF0d1NoT0R6OWpLUTNkWUVtb25iVjdX?=
 =?utf-8?B?UkhYTDZ0YmVjZUxqY3piSmRPcmJHNDVsOEVybW1sVFhVUzJRUklhSEtINXYx?=
 =?utf-8?B?dk53TllmMlFvZTZyeUI2WnZISnc5QkhEUklYaWswaUlKR3J1c1l2UnVRNU9X?=
 =?utf-8?B?LzU1clFrbUYrUmdvamlJTHcwWXpiK3RqOWZpRGc2MmtRRVROQlBQRnBjWTZF?=
 =?utf-8?B?LzM1UjlIUWpNOWlqK1ZPaEFteExYZllKQWRndnZpZzVWMlFES1JUdjh6K0RW?=
 =?utf-8?B?MHovWDJmcEFjclZVNHZmS0dKaFVUcVVyS3JqLzdJeStScEN4SytWVE9JVENk?=
 =?utf-8?B?ZXVSZnA3R0t3QmZlaGY3UDJjdkplSVJiZW9QS3M3VnZTN2crb2lrcjJIYkd1?=
 =?utf-8?B?alhva1dFaERIaUx5L0RlTzF3TEkrTEsvN3ZQRDFZbDBrNE5oWnE2WHBDYzlx?=
 =?utf-8?B?YlBnYk5XOStLcmVDbHJMeHFPaEo2WEJxUWsydUJyMFQ0dWZ3NkVrVzJaU1Bz?=
 =?utf-8?B?bEF3K296YVhGN1llWlBNTjZKZnFGSVYxU1VSQVJ0TUZ6VVpINEhYVklENmtl?=
 =?utf-8?B?QkpPeTdQb2RFL3dIby9TSE1LRlEyaVY2N0MvYkFWQ2RwbVVzaUdraDlTL1Bo?=
 =?utf-8?B?dWk1SWNycE1EeEVWdHFSS0laTktSSXUvSDFjNEwvS1UxVlNDVWpVY0NoWWFB?=
 =?utf-8?B?VUQwY2twUWovUzJsWXphMzhJY0FSekJlcGQzcHZjK2l4S214L1d4SlJPa2dk?=
 =?utf-8?B?UFVycERCelcvSDkvUlpUdUJOS3dwRldvQ2Z6WlVPNUJvV0pSbVZnbW5LTWds?=
 =?utf-8?B?T2czTjBsTUdaQnBEWUFiaWJ2TEg2ZHB1dnNCWlM5MWtFd3AvQUZyZnNDWXc4?=
 =?utf-8?B?VFlKNjZUYlRnVU9kQW9uNUUwMkxpWUdYVVJqZjRLdFZyUDFBNTVHN0N4SG5N?=
 =?utf-8?B?cmhBWGMwSEhuVEhldzBlZkVPRURoL1dKZzZjUStneUE2RDJwU1lNa0l1WlZj?=
 =?utf-8?B?MXFwdW9ZKzhNRE1jelMxdTU2czl2RzY0WG5sMlV6ZWxONTVDaEtCZXMxenIw?=
 =?utf-8?B?NDRRVWVFTUszVXNnc2J0ZmNycEdyNVloM0FkWUY3NGtLMmxENmorVkhzR0ox?=
 =?utf-8?B?aEI4K255THhMVmE5RW90Nmh2dUY5Yk05MHpEc1U3R2h1VnYyV0l0Y3M5K01y?=
 =?utf-8?B?VU5GQ2lZNGl0VWxLSWhKYkpYZFZCSjdCREhoN0FSNjNOWHlBQVJISHBkL29Z?=
 =?utf-8?B?YUx0NDc2VXR5eFBLUUYybUtWdk9peE1ySGFyWXEvdkF4YXoxQTlNVTBFSi9T?=
 =?utf-8?B?Q1Y4OVFuZmN5ZEVyUVNvZ0IvajYxT3lQZzBhWmQ3MzQvSVZXMzdJcEdrRldG?=
 =?utf-8?B?cXNWUFJMdHphQUkybmVTRGVqY2x1b0tubkNsOE1BVjM5Tis3cmYvS1Y4NHpr?=
 =?utf-8?B?b1QvMXlBM0U5eG5NdWc1Y0duSlpGMnYvRjZDcFVIOUFQRXVJcFVYdit0MExh?=
 =?utf-8?Q?S71dXUjFRxfverrRTLSzwhY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4cc474-4836-415a-51c1-08d9d4a0563f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 01:18:55.8357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkdvYuBPAa/NSSj2yxmYm14/STOKa8CgB+YN282eugTL0URsPoKaZ0G6L1xytJW+rF6Vq1OZo/VeuqAyb6QuZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3651
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> Return the head page instead of storing it to a passed parameter.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)


Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 6eedca605b3d..8a0ea220ced1 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -245,9 +245,8 @@ static inline struct page *compound_range_next(unsigned long i,
>   	return page;
>   }
>   
> -static inline void compound_next(unsigned long i, unsigned long npages,
> -				 struct page **list, struct page **head,
> -				 unsigned int *ntails)
> +static inline struct page *compound_next(unsigned long i,
> +		unsigned long npages, struct page **list, unsigned int *ntails)
>   {
>   	struct page *page;
>   	unsigned int nr;
> @@ -258,8 +257,8 @@ static inline void compound_next(unsigned long i, unsigned long npages,
>   			break;
>   	}
>   
> -	*head = page;
>   	*ntails = nr - i;
> +	return page;
>   }
>   
>   /**
> @@ -297,7 +296,7 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>   	}
>   
>   	for (index = 0; index < npages; index += ntails) {
> -		compound_next(index, npages, pages, &head, &ntails);
> +		head = compound_next(index, npages, pages, &ntails);
>   		/*
>   		 * Checking PageDirty at this point may race with
>   		 * clear_page_dirty_for_io(), but that's OK. Two key
> @@ -386,7 +385,7 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
>   		return;
>   
>   	for (index = 0; index < npages; index += ntails) {
> -		compound_next(index, npages, pages, &head, &ntails);
> +		head = compound_next(index, npages, pages, &ntails);
>   		put_compound_head(head, ntails, FOLL_PIN);
>   	}
>   }

