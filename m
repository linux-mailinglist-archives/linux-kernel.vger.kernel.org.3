Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A55B495738
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 01:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378346AbiAUAKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 19:10:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18496 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378263AbiAUAK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 19:10:28 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L04MBW016482;
        Fri, 21 Jan 2022 00:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tnEE+FOWj42srr0d07H3zYwZlPXhg8o3o4WLdGf17tk=;
 b=YLGq7/7TSTr9v2GkJZLcpSX2zZBVqfqEOx65yL1vQ+2u/qZFNgglQRV3JeNeRBzX4f83
 YWxgBuxIu6R4yPIt4RMn3hYJsG+L/GDxsfxvZi+ei9HlcFO1m8qoKx5T2ONZyVi8Crtm
 bxs7M896EU+zb+ULejnCKrzz/eJiW6CEz86y1MB573rjrNs7pR0G/zsjw6ZCLaIokyGU
 Ay7BGBJGNcUk10Jy7SYO4zI73q2klg2XZ6l5nxaw3PBLSCRCnQVwFixn0pjPSjUYX5KU
 9fWsPPaUpfB6X0EyOGsDaxnsaMeJUD0eQgMGUb8PNW4fnhPIAAlDcGMpj717hjTbowIX VQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhydr09q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 00:09:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20L08lBa109976;
        Fri, 21 Jan 2022 00:09:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 3dqj0v06md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 00:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN6j1Y2fANPqCnVAeY37JB/+Xc5QWqLnuGw14nkSb5p1BM1heEzJyeDPBqIjO2/BTzcwCSB1zqa0O+aTrsxFbQsXzrL6PPsQZiMSriV2xaE0xLfDuLA8i02WdUPBjbqvLvvlyzGQBPVTChDt4PtpNy/nj/sx+5Omc/ZYDTOIxebuWWxMVaXyNTEzh+3J5R5TJA7YdtkJa5rKTv1IYUFErlhefey9BoKy9jfOtZKGJkr6BI03YLFvO6EMRQJ/xqevStyeHyBtWPpANMsz+gwQvItocL0q0ygYM8pDY2fB0Znq2ZYped8Cv2VUQGPgr6sVDzgZ5W7nj/yIUOoX9I2Fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnEE+FOWj42srr0d07H3zYwZlPXhg8o3o4WLdGf17tk=;
 b=YHZSEDnMcS6KFoIhe9WVRuNiBkAvnqcgW5OgAWKC99QDJOFSpvDyHJ8ASJJOaNYbiBYuejy2HuYwIVf3I+VVvEqsDCYaSDHprlvjtirkV1ozgykxOeEKWM4b3JQDO9dNJO4wJLIONqEIJxLo2fP+4qFZfzBqpXRjcB+xUvqmnR4jttDG8qla3Qx13VZt7FRH0BDmu3Z05Utx5TEtFrF68HR3unBWeEEGB+ZsRlUShbqRQdEVxkCeTW5Rgu9pd1HHdoJGUHzwKPoACtOYOrI+idteZJxmFzEddl9ejdSr3AdO6bi3ojF90vhkGnKd3T/031VD2ZnLYsaxX/cK1nRNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnEE+FOWj42srr0d07H3zYwZlPXhg8o3o4WLdGf17tk=;
 b=G0flwTuQ3TabVHh/IsQCBg7htyvIIGLXvPO/zarzvdmRqH4Ex+3qDk3/k8EeznuTR6BH4n88MLRjsGomheT9LhCEmqkaP6vF9qNEC1kgkd6Zkebr24tn8bHLp6e6XQFPGzzWvOF9Y4q5jwboCivEDVvCMD2Pc+Qbj5dYYsshY/4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5838.namprd10.prod.outlook.com (2603:10b6:303:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 00:09:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%5]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 00:09:52 +0000
Message-ID: <10577ef3-57c4-b1eb-cd0f-40518dfd9ad0@oracle.com>
Date:   Thu, 20 Jan 2022 16:09:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 1/3] mm/hwpoison: mf_mutex for soft offline and
 unpoison
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20211115084006.3728254-1-naoya.horiguchi@linux.dev>
 <20211115084006.3728254-2-naoya.horiguchi@linux.dev>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20211115084006.3728254-2-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7979e2a8-c437-49ff-7b72-08d9dc72588b
X-MS-TrafficTypeDiagnostic: MW4PR10MB5838:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5838DA3CCE0677B3771450D9E25B9@MW4PR10MB5838.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYpP3GDOC48mM48EgjFBEKKWfAF0/zHy53yRiDTI+cioX6ebYgHMwPmJZf3VTGqm6do4PrANI4iuL/4djLg5yZVuehfetGzRqQZ2mbRS7tvVmX3IQXCWX8jXEwW7kTkoZiQNAeulHsp9SgueOzwuvY0iTGudWlQWCapwH01mgp9oW6ZjU22s5/h71xXNeqH/O4D3MXe9CqhKwaPUsd5POA+97ybmq0WzJXgS1KjwWKNsAtVb8DfR7zP41MBxcdnEKsSxGjBKes+RuVccwkkxWEDJsbtu0BSwbQFSDSfK07ymOoMhiIyRX8TAovKxBqEAYXudb5dBlgbNXuzWdUviS8aXih+76EHOxeLpBg44KF1E10eaM+88bTPPd0fcxCLkO92DPCX+IbxU4RMpcaxI7Tbast4KFaSaCmGT3+vf3Lv4EG+qJ+de7DwE0KKbilxlUzHErpKfOpBiFV/QKyRxduNX0Xmyz+S1fRyUINtO/Tklye9uB5bVSKJdefSIhpIYZtDNQ5Cw8Iycw06QDurpoQjSTIetPT2ORh9PmOwGwLCzFjZR0yoxQY2oLSVMUZ4uyZE8/L4NQAP2jrYZdHKaNkRpl6fPV570jofQwO3zbY2Xd5xLN9cPp/SHseXJtWn5SxUm7vRjNx8yeGtqXKP3C9hQ90alXErpK2EbFB7ikE/VIo7HBOYSJRO8HJNKnRsbjEdM9J7PZUyFdVkQx3FLR9uScWdCN08vlLo0c/ITLQBUP6T7OZSMUuOrAQlXp3MyzvwYgxcRNS2VswiiMa2ikQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(186003)(5660300002)(66556008)(36756003)(2906002)(86362001)(83380400001)(8936002)(52116002)(44832011)(6486002)(38350700002)(7416002)(38100700002)(26005)(66946007)(31686004)(8676002)(6512007)(4326008)(508600001)(66476007)(53546011)(6506007)(316002)(31696002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC9yL0F4N3ZadTdzdFY4eXpYRGRLT00xRzBnajBjdEpwcGdiMHo2RDF4azJI?=
 =?utf-8?B?N2dmVll0cy90TGdMZEVHZTc5RllVTUIycVlhNW1IdXhIZjUrNDliUTdEWmI5?=
 =?utf-8?B?MVdTeVF2SWVuMVlockhjSU8ycDNnZHR6NytQVDBLNlpwWmVwZStxeWw2QmJl?=
 =?utf-8?B?aGJ1SitEeXppdWhuWmJQQ2cwWnNQckovWEtMV3k2aVNMbjlBT04ySjVrelBK?=
 =?utf-8?B?V2hvbUk0QmtUM1dTNU1yNkhlZVF4QUl0Z1dmVXV0QTNEdStkTXZMTHgrRGx6?=
 =?utf-8?B?Q1BzUmIzZjNZNUJHczdVc1RtMHhNeksvUG44enZkdEw4bnBOZEI2S3puQW1a?=
 =?utf-8?B?b1NZcWZXa2lnL1ZFWktBSkM0NFNvdGg0blNmS3hFMjNUNnlJalpMNUlJM1hB?=
 =?utf-8?B?ZEl2TTNvQ05tVUhiWUdjL3pHMTdXUS9CUkJ2Y1BHUGVnU01pNm5kVUo5aTV3?=
 =?utf-8?B?Ykc0aTZtSTFmOUkyU0RUdXJXUVhCNWhUYUpZUHBST0VzRm9qREtlN3B3T2N4?=
 =?utf-8?B?cHVFNkcvQmRIMW9ha3lMQndUV0R2bmZkNi9uMVI0d3R0Q09vR3hKY1RGcW1O?=
 =?utf-8?B?K2FHZk5xeU0xMDVsOXpwRTQ4Syt2Mk1STzhXakY3WENoSW1mSkNDanJwY2hz?=
 =?utf-8?B?b1hUZ2IxV3cwcGRTaGZqaytQSUJVaG9DYWRJaVBUaDd2VzZDYXoyUC9MMzlw?=
 =?utf-8?B?ZDhEQkRpMzFvSmVCb0hGU1hwL3dwQnMvb2I4R0NSaTlBN3JMVVFVYXVGeVFu?=
 =?utf-8?B?NUNBdjhiMFNSdnpkMjFDOFlhdm91NVN5NVRMMWVsZTRjZ2llS0RoMVNMWTJS?=
 =?utf-8?B?UWlGWGkwWUtyOU44bk1TWWc4K2JWVVhOdzk5RkNTaWVuRHZyRzdONW1jREVN?=
 =?utf-8?B?RjFpejJoZHVHWnQrUmoyY2tLV1FUWTFyZlc5eDFHZjc4djFnd2FBYTEzY2w0?=
 =?utf-8?B?RlpnOThIYTkwMXRBOWs0b1ArY0VlRURyNWRWSDlJdkJqbjFhWWovNlRUTE5P?=
 =?utf-8?B?TzNrZ29ERk4rTThvem44dklGREkrQ0FaT0ZNNGR3OGQ1UkNZbWVOMFpCZjhW?=
 =?utf-8?B?K1YybG90KzZQbnBQdTVXakwxaEVoSmMxQmh6WmRTWnYwTDRTSnVQYTU0TDRv?=
 =?utf-8?B?Y1Nzd0VUM1F1azBqZFU3bEtuN21VQ2czdjZhWHcvOWdKNFQrcjkwTDFRaGZG?=
 =?utf-8?B?a1RzUGtnZ0pUUmpyakhjSUN1Z1d2cUIyM1hWcEJxSHZWZWRsbVRzTGhFcER1?=
 =?utf-8?B?dFpMeVA3YUF5WGJrekRPR2I2a2FUZFE2Wm5OT3ZkQWFieFNwNGo1VVkxM01l?=
 =?utf-8?B?czBlN0l6ZEpvK05zWHlRd3lDZGlaSkxCS0sxU2lURy9wTzZZMTROelJFL3pI?=
 =?utf-8?B?ZTJyQkExSmROYzlHOU5kd3ZlNnBCU1lUNjBYUjd2Y0c5TGZIVXkybnFjVmdE?=
 =?utf-8?B?ZWozYUVsZkRrNjhrNWVWcW5maGs5N0pCL2tsVE1SMXJFaWZEUEh0aTF1Zklq?=
 =?utf-8?B?REp3OVVXSFlnTEY3U2RFNlJvRWpVYU9NQ1dwUGkydlRBQ3BodFBFMXRpWkZK?=
 =?utf-8?B?emYwQUhJUVNESlY5a2pDSDRWU1hTN0h3dFZqV1ZwU1Y5cXZUbzY2N2thNHI3?=
 =?utf-8?B?MkVwYUZEbFR3blJFN1ZxZEN3bnFwZ1NiNndPWSsyYTdDWnYyY3NNWUl2THc3?=
 =?utf-8?B?Mjh3QTloK01XbEszbzYrRnpySXVaeXBROCsxaVVzSHM3SnNwektJSm5WSkFK?=
 =?utf-8?B?czEyVUpzWWowa3RKSXlrSGNYYThOUzBvUWlzN1dhekNvTVRZZS9TdFhkRlJm?=
 =?utf-8?B?RXpUQi9qSVdtaGFLaGtYQWljbHkwcmk4ZXBtckRNSUw4dDhhZkJEbVBRamlp?=
 =?utf-8?B?bGx5Snd2aHBQbERpdkpGcjg0dnJFU2ZyeE95WDdzd3ZodE5WaXZibUovVXM4?=
 =?utf-8?B?UG9WU2Z0RHZacnRIYk1SODNncktnSS9tT0dyaS9lWDNOTFgvTklncDQzeVlV?=
 =?utf-8?B?cXpRcy90R25KR3NOeVhGTGhicG52YlZMSmJsQzhFRmJHSGZnMUczWW5EMU5q?=
 =?utf-8?B?ODRpN3ZUWlVleFhDU1FQOHd4bnVQS1F5c3ZCeDhSeVNBM3preXZvdUFtcDdS?=
 =?utf-8?B?NXRqeFlLak9paERNYlZwZnlkOVpRS3FZT0hLY3FycXdRMzN4eTBrc05yV3dI?=
 =?utf-8?Q?hg2QUxi3OXyY4xv8Qw3NT8s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7979e2a8-c437-49ff-7b72-08d9dc72588b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 00:09:52.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QE3vDKE0gR/qO+KD0nqTwJ1lkPJE7WS66hbT2BT1eVyqT4K1mThlv7pAp+H28h+fNZ5Lk06GIp5Pin0/VozUQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5838
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10233 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210000
X-Proofpoint-GUID: uz9WxwkjVtT6Nyk6DFZDHYL5hfShwUEY
X-Proofpoint-ORIG-GUID: uz9WxwkjVtT6Nyk6DFZDHYL5hfShwUEY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 00:40, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Originally mf_mutex is introduced to serialize multiple MCE events, but
> it is not that useful to allow unpoison to run in parallel with memory_failure()
> and soft offline.  So apply mf_mutex to soft offline and unpoison.
> The memory failure handler and soft offline handler get simpler with this.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> ---
> ChangeLog v4:
> - fix type in commit description.
> 
> ChangeLog v3:
> - merge with "mm/hwpoison: remove race consideration"
> - update description
> 
> ChangeLog v2:
> - add mutex_unlock() in "page already poisoned" path in soft_offline_page().
>   (Thanks to Ding Hui)
> ---
>  mm/memory-failure.c | 62 +++++++++++++--------------------------------
>  1 file changed, 18 insertions(+), 44 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index e8c38e27b753..d29c79de6034 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c

Thanks for working on this.  I tried to exercise memory error handling for
hugetlb pages and ran into issues addressed by these patches.

> @@ -1507,14 +1507,6 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  	lock_page(head);
>  	page_flags = head->flags;
>  
> -	if (!PageHWPoison(head)) {
> -		pr_err("Memory failure: %#lx: just unpoisoned\n", pfn);
> -		num_poisoned_pages_dec();
> -		unlock_page(head);
> -		put_page(head);
> -		return 0;
> -	}
> -
>  	/*
>  	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
>  	 * simply disable it. In order to make it work properly, we need
> @@ -1628,6 +1620,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  	return rc;
>  }
>  
> +static DEFINE_MUTEX(mf_mutex);

There are only two places other places where PageHWPoison is modified without
the mutex.  They are:
- test_and_clear_pmem_poison
  I 'think' pmem error handling is done separately so this does not apply.
- clear_hwpoisoned_pages
  Called before removing memory (and deleting memmap) to reconcile count
  of poisoned pages.  Should not be an issue and technically I do not think
  the ClearPageHWPoison() is actually needed in this routine.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
