Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9846848A649
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346665AbiAKD1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:27:53 -0500
Received: from mail-dm6nam08on2065.outbound.protection.outlook.com ([40.107.102.65]:22592
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236807AbiAKD1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:27:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pn2+F3uzLu8wv+JUKVZfPkXmPWlCY4Iim+jBDW7ftv5bkVPBRf04Cv6Lz/ncqdH4+BeCB9S8NbF/HBmCaMtBpCa21ivV1A8ape7L0N5q+NM2n1MAawyOXFVocjyJ9Ny+bXSUEFC+z1Y0MBQkbCh1l5+TahsWIgKtgHWtifvjCD9H8tXsnGGr3vYUJlJC8dYIvQxE/H2EgiAfwnbYGLeGfYEwG882o6X6c+TNsC1W04bexSbiFlnnVPP/+DNva8Wl4VLGwE1FlHbAEpxUSAqgy546NBAh4hEuSLsWgInmyHzi4e5MkdeP7sF+XIfrjDgw7FtMwiO88NYhqQat2VjxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5BpcchhVUF1gQ4R+rDLya+qV19A58d9+x+5QjqhJU4=;
 b=AvU+SH8xdU528Wx5/JqxjSleWOkSExu29h/P1q1jCPua70jnm9fCUBhabtw3U84lryAjkTzP77P4Jbh9J3K83UMoYOgyKTiQfq0zKXC7t8YoClj6UfMNJY7IvxJiArczSOt0FitksPdNTP6X/jE8aTOEnk0ytzFD5hkDlOWW3jtyl3caSQwYOUmZOedKZYVU6Tmvg7l5VmxKRfDzqwczjKfeK2kXk8ewfqwKqKTwhtNkn1NOkN5Q/uZy5cepjezz70BYhkQ8mzeSl7XhJSh+qU091lSTJ0wWrs79NNlZAXM+tchaRzoc6gfrh8oZhDfnOLzEFnu6G1YV0fbh2xnFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5BpcchhVUF1gQ4R+rDLya+qV19A58d9+x+5QjqhJU4=;
 b=X1R7fH/ybnGzqxAPLt/EZKkjQ0ql9HkDWwITGP44+pCfwUPkvsb4cvz/vr67FvW5DLMt1MeMJimIO4CxNoDpUgL1YEFKPEgZO3eVc50+m8l5txVypvd881TJ0N6IxZZ66MJ4rcYaA6Mm1K4AasxpPPTcHzF3oZ4HcU6sripWEEOlfolAJGO2yJtRXT/1NjlFHzhsD30reKua1+W4BWVnaaMcyIoeYLTNb447dZZ+aRHYRADd4N7DFCOF0JlUwQcB8PNhtd0T/XbBKLKdkqB/JQgM4jVQxIpehfwB5Lq9nSR0Qqb60DdXXgBkqoZ1IC89AfJ+NFc2QZnLI3yClH+CbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3715.namprd12.prod.outlook.com (2603:10b6:a03:1a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 03:27:49 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 03:27:49 +0000
Message-ID: <cd1ea34d-340c-86c2-16d8-94e689e3edb5@nvidia.com>
Date:   Mon, 10 Jan 2022 19:27:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 07/28] gup: Remove an assumption of a contiguous memmap
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-8-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-8-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:a03:74::45) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43a608c7-427f-40a3-1e8e-08d9d4b25817
X-MS-TrafficTypeDiagnostic: BY5PR12MB3715:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB37152EC378AE9155BC26EA14A8519@BY5PR12MB3715.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XKBVGCng3DfFo9fjXr0wET2MRYCFM88h643iDRgLYBeQOFgmkH23D0T5VYP4hcH9Ph2xcff8H1T8rTE6FjLARO6LvXTQpNeCQ6Ripk8ZN/FeqIdQYc1ay53MwC6AeLyVbMGDLKe/XPoEs/yjDg8l1ThoJn6pXa40HVT+I5FRtV4/b8EMS6uTH/S8OtFTuYm33iYbzoo1rBIIpGQhZxav63PqtDkXgPuGviwQMqhuQO7FnH7/SO7BCegtSNOIsgZumapkkezA50UtjQwwOj/canC5+WwSUTU5Q5xs7MGYmRVj/53s1VVCnQZwiaWwJTEwATvg7w0gE/C2bGWIjtS5040mp+RoSrgyA4ScBRErA8uLBCvM891TSzlnUp95JviPqQTb2GvnkrKW4LXYnqkxE64fr2xC0sIMYFVulAGTORTcGQEI9rFXyIfID/CcOsxMB4K68ThKf7F1YtECXMyUJBre0e+XwPcYAcEuqS+k8vMHxfqkLeshxOtwPiShJC+CROqWOYwFNwfA1uBXy23m27aHg2MEu4cD6IWA61i+VNLISbsE+6Nc22hnvr9LAs+Q2KV3s1NfoEWfxH576ErkxyFHZW+jcZzUFVlDK7vQcJf7S4su5XRPcJVFvVNVrUOJYZI0H4/VrzbszZzF/wNUaKn8ZtQyiic30boAZHI/jhgp5PkjFIQ9mhJ1235Biqj8mXR+9ycV2qYIvz5LMAeWU+SwLE22MbVwiMStK8VLPt3hwnl+7nYnhp607zEyxuw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(54906003)(8936002)(86362001)(508600001)(36756003)(6486002)(31686004)(8676002)(53546011)(6506007)(2616005)(66556008)(66946007)(316002)(26005)(4326008)(6512007)(66476007)(5660300002)(38100700002)(31696002)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDZYR0I3eUUxb0wrZjhtTGtCK0F5ZHpPSmFBNFA3Y0FkTEorMjI2NHFKOXdY?=
 =?utf-8?B?MXJMalpJczY2anpBdGNHUnpNTjBuSm5OcEdkN05sWnJCNUVxdUtibnlpS2c5?=
 =?utf-8?B?NHlaZWxUT0M3ZkhNL1BUbFlNTndoLzRya0U2WmsrSkVNZHdVd21KbkxMQTMr?=
 =?utf-8?B?T0xXb2crRXJPL0hVWTd2SEdqOGZBT2VEeWhCcUpUVWJDWmtQZzhNaUx6bTdw?=
 =?utf-8?B?TStsUnRzMnlVVGVRU3QxRVl4OUhqRzJ2OHVIMDRoQTlPSXhFQkliRWZDMnJ1?=
 =?utf-8?B?QVkxbFEvaFM5R0xydkI0ZGh0ejZ0UmZjQmxkelR0OEVYdGxTVUxaMHZxMFdw?=
 =?utf-8?B?RU5NVjcyMFQwWE9MQ0ZjOGg4dWQxWWxZSUF1UXpWM0NSRlNDK0JLREhVZXNQ?=
 =?utf-8?B?eE8zQUFBUSthMExzdGR5NkM5WlBqWFdxNFpweVE4OHJzbkk5T2pMNG5PSHQv?=
 =?utf-8?B?WHhYMzczZThYUGxSWmNWWStHUDE2ZktVOXE1ZDJYSWJyT2VSckZDTFVuOFFP?=
 =?utf-8?B?Mk5wanlWeTNrZ0c0TTNTM2VDSm1wSWpadnRWeEZzcnB5c043RWNtMzBOTGpH?=
 =?utf-8?B?WFRTYUdSSFA2NnBSK3FXbGhYZVl2M0NNY0RRSXh1WVdvQzJVaGZLaGtDQ1p3?=
 =?utf-8?B?RjRSVTQ4QVhhT1FBSHVwNTBMSVdjMlZVZzJVZCtyc2h5S0d1TGlsUngxSE04?=
 =?utf-8?B?Wm9IOVp0WUQ1bVpsVFdlWWdOQTAvTWpnNDBwdThpWGloeGs0aUxVWmczbkhr?=
 =?utf-8?B?bGc1SmlYMUI1YTQvM0pQTVRmSGVVZy95L3lSbTJpTE9Ic1RZQU9lTU1nSzJZ?=
 =?utf-8?B?UEVGTWpDZzlYeDY5VDZtQTE5ZDBXb3pwK2Y3dUtjME01UlRObTE2ZmVIRGVq?=
 =?utf-8?B?c1BTZnV0U3l4cW1BNEpaUnFPdlFYWURHUGlGQU5STjF6V0xnbTgwUmgyellL?=
 =?utf-8?B?Q0JyNTNqWW4yQ3MxQmlJTFB0cjhyTGwvQmhSaEQzcWM2Snh2ZVQ2REFmZUJy?=
 =?utf-8?B?UTZBU01IRmoxUmpiZFJpeCs3OGhWeFdwMXlOeEgvVlBJTmgwMFF1dGtMZXgx?=
 =?utf-8?B?SVJSdTR4Z3VrSEwrWU1NOEh0TFJDdEpRMDRHR0tUamt6dTRpZFBrRjZnUEJY?=
 =?utf-8?B?Vlg1TWFOMDJ0QTZnbGlvYXJEWnFjT2xuNTB6bDc1QzVObUVmOHFWKy9McndN?=
 =?utf-8?B?Tm1UVnU2TFA3eVhTRmRVTE5BTGxvbzkrRG9MdjNNT2V6cGdyZ3BCbldsTlZ6?=
 =?utf-8?B?RDA2T2FKV0FjdHNFYjZ3QllEZ2YvMHA0QlNDMGlKam84Y1FRMi9aYXNLYWhP?=
 =?utf-8?B?SndXSXVBTllOODl3Mmo3SG40bzQvb2NTcTFUb3hMa3Y5NHFJSW5aWWFjWVMw?=
 =?utf-8?B?NzZpWE8rcHJBNkpWWlZDOU1MTUt0RGZ0TnBrSUF4NDZiUjFXNjdpTEVUV2dl?=
 =?utf-8?B?cHNSLzN0WjVwUXpxaGRTNUxocThiVGU0RHZvU1lLdVR1UVlZZ3NrSk9kUkgz?=
 =?utf-8?B?cHY1Ukc1VGhsUUkzMXg2MEN5S2dFVWJCa0ZpT3A5M1lPTW1OSWNiRGxhVStK?=
 =?utf-8?B?VVhyNkdBSkR4d0U3TFlBM2hpQU5PY3JXdFE4Ty94eTN1UW1pOTVtUDhBNlZv?=
 =?utf-8?B?UVdKVFpkTk9VWDBHOTBBYnI4YVdXb0NFcWl6VnZCUVFEUXJpQlZ4NXh6aTNH?=
 =?utf-8?B?aWhBODNPKytkNWNERGdRTzRkNHp6NSt0MGRTaEU5Z2xTb01yb3R0cUs0SFcr?=
 =?utf-8?B?ZytZOG5LOWJtdkU4cTlXYUR6OHRjLzZEZEN0ZXg4Zmp3VEZmVzJLZVBJZFda?=
 =?utf-8?B?WGF2amZNNDVLdGo2NkNzUGRmckhLODhrVXlFWmVGOHV0NmYyTE02WXNWTXVC?=
 =?utf-8?B?OE96SnNZSkR1eXlsVTJ5azB1QndqdEVXYXdFdS9OcjQ1QVBJdDZHVnQ4bHJP?=
 =?utf-8?B?WlppSTBlSmk1M3U1N0N6aWpBVWd4L2VFbTB3UHE2Rjg3MkhITWhPSW1Kempt?=
 =?utf-8?B?ZU5rVXVORDlKTkdnamtsOEQwc0JoVHM2WlNCajdzZWFyZ3lJZVMyU0pRVE9n?=
 =?utf-8?B?cW5CUmh4alVraGdMOWNUYm5qVFl6aTJxeGk1VHdxSXNWdHQ4UEpFSDhQSk9v?=
 =?utf-8?B?UjhlRlhnZ3RhSGNVK0U1bFdscWsra0Rkb3AzWE0vUndEWmZMM1hYN0pteGpE?=
 =?utf-8?Q?X17RM6ZwJ/lzuFGsBCHTwdM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a608c7-427f-40a3-1e8e-08d9d4b25817
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:27:49.7750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNHsBhX9GeEtpzh8Mu64jSkASfDR0J1eb4yHAH1/guWvwPopOM36FHnvmY9HmJa0SrF+PX3Qnx+P9Ud+pXPSFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3715
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> This assumption needs the inverse of nth_page(), which I've temporarily
> named page_nth() until someone comes up with a better name.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/mm.h | 2 ++
>   mm/gup.c           | 4 ++--
>   2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Maybe a better name for page_nth() will come to mind by the time I
reach the end of this series, we'll see. :)


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d8b7d7ed14dd..f2f3400665a4 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -216,8 +216,10 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
>   
>   #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>   #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
> +#define page_nth(head, tail)	(page_to_pfn(tail) - page_to_pfn(head))
>   #else
>   #define nth_page(page,n) ((page) + (n))
> +#define page_nth(head, tail)	((tail) - (head))
>   #endif
>   
>   /* to align the pointer to the (next) page boundary */
> diff --git a/mm/gup.c b/mm/gup.c
> index 9c0a702a4e03..afb638a30e44 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -238,8 +238,8 @@ static inline struct page *compound_range_next(unsigned long i,
>   	next = nth_page(start, i);
>   	page = compound_head(next);
>   	if (PageHead(page))
> -		nr = min_t(unsigned int,
> -			   page + compound_nr(page) - next, npages - i);
> +		nr = min_t(unsigned int, npages - i,
> +			   compound_nr(page) - page_nth(page, next));
>   
>   	*ntails = nr;
>   	return page;

