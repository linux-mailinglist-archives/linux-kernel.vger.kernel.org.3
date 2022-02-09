Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA254AFE82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiBIUdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:33:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiBIUdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:33:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2380EC102FE5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:33:35 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HQ7Uo020167;
        Wed, 9 Feb 2022 19:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fGMoDb9brlFHBS6lPQZhipdMmL3ur2PvyxdS6gTTAJM=;
 b=HkkRn2RAHmFl8vpSTpLu1Jq10kQGK5+4Y8jloisVrrIF9s3uLPH9DitiTqHWw4Z01eZL
 6zCdg90/4yqKJHVlkENkEywIVzXdGa3uqGblXTHqlqv/vfMPqx3k21+7UJOPqiXu0YCG
 52KR8zRrsY6EOxiHoF6DS+BqaBwWGm2/bBRSRWd5hZcVhdTO7hYeHO9wkW3/iIXGclLs
 JLuiDQBj2LuS/TXmbqJi6aUyMbII53s4yLOPUazaYxSpEvYkCw2uRFsnyVBV/eSLzrw9
 W5fFmEDVdWe9Okg3HGRmQWwu8U61zYTsqdqWN0DReaoPGwpUbqeyJoW987P34/mNn9LB Nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wxuj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:07:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219J5peW069105;
        Wed, 9 Feb 2022 19:07:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3030.oracle.com with ESMTP id 3e1ec38b38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:07:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLX3x5ljKmRCg7rq8qJfLwpHEGzDQ2uPRq7yuymvP4JYl5yKfUbCQ5EhR3TPgkOeEzI4DgmgQioO83Y1hgFt1p4r4GSJ5E6VhKumdjTdPor7tZMsx/59mGirEGAhyS+QSXeVvpxaHxInbHfcfpfUcnwJQK9NM9MskFENCrPQ2qxAki7JsnnJJBln+G2lujF7IgYsDAVW5+NAD9lldfBVvhIe4zCkuU5Cb768Cz14N5eX7i74itGe8yCnizQM5q1/eUCzFaQCf6ZUg33FfkWO5Nqu/FrIPJaIb0fuCvrZEkb5pxrxR7nUdQ+i53XCIp8p2Y237beOX46y9o1O8g3NHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGMoDb9brlFHBS6lPQZhipdMmL3ur2PvyxdS6gTTAJM=;
 b=XHBacTooIWt4XsbInIluHBif9tDisyKNNZcss0GEkr1AMpVbjcrpL7YPJXtlZ9SzLZYNIauvS5Kli70sFYSJBmAhgwuHt4mCzTWjbbrxQ3jZAfoiF3njCroLP1FEmps9c24fk50JN8lXRnnyzkXi1eQVbSJlZdd4Pc6tifYnKHBfV3YkYvFGT003xlzSe6c5l3tCwHxHkXxu3Q1qwy9cfJyCgAh19JzLgkl4F44Z94Kq4TJCOcFG5ho3LSEOQc97fA7/1lfkS6W/UUJOXujoI47oohewA8frehaconct0ruJd0XCUpMqRzFQtM8S70IGsvT9HKhET5svHf009Fz8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGMoDb9brlFHBS6lPQZhipdMmL3ur2PvyxdS6gTTAJM=;
 b=gL2aj3YLYg5er8z7CkWuLHSDpbuFFQV5CX1O7tLz6YBPYGezcA94viOkqPPaTeh8Uyy4ZQ3VBgEtUJO2ZDyT+fN1Sl7b4wY6I4hdpzn3n3mCpbv2HJ3bqOAxwrA0Mi+5xZQ2Ew6LVUdFmpcd4ukGefpL4xJ6SCv9rbbQ7+GfR4o=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB3914.namprd10.prod.outlook.com (2603:10b6:5:1d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 19:07:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4951.021; Wed, 9 Feb 2022
 19:07:09 +0000
Message-ID: <d78d6e56-1879-94c8-dc28-06431e583a77@oracle.com>
Date:   Wed, 9 Feb 2022 11:07:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/5] mm: hugetlb: fix missing cache flush in
 copy_huge_page_from_user()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        zi.yan@cs.rutgers.edu, kirill.shutemov@linux.intel.com,
        rientjes@google.com, lars.persson@axis.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
References: <20220208073617.70342-1-songmuchun@bytedance.com>
 <20220208073617.70342-4-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220208073617.70342-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:303:6b::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d84b73e-7d62-4839-e774-08d9ebff5f2a
X-MS-TrafficTypeDiagnostic: DM6PR10MB3914:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB391486052702246DD528D837E22E9@DM6PR10MB3914.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MS8aSbqYc71OHsneJ+TTZVV0Uj0hNxp/33RRq7Lbv0iK1KHwbXpjO9oO+bRr0T85CE/dlKwJrK7Nvc/5rskhOVDq0zU5T9YCtNhc4V4ZiyWYN9WW+uEKxBdK8IrR312AejvVTkUwNtjZt9n3B5X4ewLBLZatpRCJg1gebZt1d4HTbdA7DP6+xsjtli75cscuzspRsFuUXzaRu6BkhIIE+fD6YGcdrIMPfNkdOPEOFckzE6cnagPqmrI5ETX42XS4cdogttQ5PTb+cyRqTkqf6XQFwqU8+9ieA96kk/ccr98mBqS38p6PKp6c0yGk5wdGSYyCzKH4MzPyIre/9AU3+W8WbypOA9wfIrsfHZUw9Izr2iYC3Hqx/eW5NDWF5LsC3FMW2yltpdwtyq5yy9WZUTrMv70MsAkUBD4BCNVz39I7PJimNRIZq4ZDh7Dadz64CpA9JTNayFWDCxD6raEiPhgCs0CjUuL6exdByF1I8VORANlvMY5rQZie7Jo7kpb3dt5Nlfi2qBW9fyULjLIHv/uIJISfoe4gmJCjAcsU0ue9eFLilrWn2JnqiFpYVa1XK0Kx7hN2ozv5T1Ssm4XTIukUmebKUMdpIQ0/H+EFV8idOe5nPJWE2JWfljFG5/ejcCKyWXPjrt7u3MM82pRFNVNBgWRX67GtczFidGbkprrVi3yxCj7UZ2WfMsvHqf7WNKbHAsaYw7iPnNIv1TzTQI3DegD3xcln6+Np7yVYsB3pj7buOcdUFtJVUSh7PVsc9e+i1pfn5ai8M/cJbccxh1JnlKu96rPa5SRv5zYZKZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(31696002)(186003)(5660300002)(8936002)(53546011)(66556008)(52116002)(66476007)(6506007)(8676002)(44832011)(86362001)(66946007)(4326008)(316002)(508600001)(31686004)(7416002)(38100700002)(6486002)(2616005)(36756003)(2906002)(38350700002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXJST2Vxb0I2MG9kVVRUdUpKekxmUDA0QUM5cmxoMWZpcVpyMWNOSjNuY0dz?=
 =?utf-8?B?ZDh0VHFqbUJEWXE2cDdJUHd1cFR0TkV0L3FDeDVVS2xraERBU05LYnl0cXRY?=
 =?utf-8?B?YVRKNlQ4TmNsVEJoSUhlbkxEUU9MVGF2MFVDdzM0RHpoSnBzU2tmbWpUU0Fl?=
 =?utf-8?B?RzRJd1dvNk1FUHBad1Y1UEFhd1RMczlGMTRPYmlzNFNhdU9lQlZ5RHJUOE9C?=
 =?utf-8?B?ald5ZTh3bDllQnNMMmVHUHhYUWMyZllxOUIrbE1BcDZ4YS92UzN3YVJic2M0?=
 =?utf-8?B?S2tDVlNhWEJjY3hvTDJzdjNhWkp0TzVEWTVHMDlSd1FKSDJ3azVQM0RNQUtl?=
 =?utf-8?B?SFNRa29xUkg2ZnVoTk9DcExyOHJuc0FJbkJ0VnIrNHEzK0NBeVVYcGpMTndQ?=
 =?utf-8?B?RWJITUN4QUxFN01LdDk5YXk2SGN4dnNpekoxemlGWTRadEZUTGZDOUNjMThQ?=
 =?utf-8?B?RmtIUWIzcGlKQXhZcmVQN3pJdGNrTFhXNnAyRkxxdVJVZ2QwZkNsMHF3YmJP?=
 =?utf-8?B?MEQ1VFpNSzVxNytha2cvaG5oRDFUZGZUcEpYSlJqOGVoUG1HK3UxZzkyRENj?=
 =?utf-8?B?bnFzVkZlekluenVqYmZuTlVUbDFxaUNpRUs5K3hqREozMEd6RmtHL2tDZmVM?=
 =?utf-8?B?dWorY0dqT3NwYmcwYzZ2UStQQnNXaWRrekFRdFFJUnAwNGpNVTRLK0lOMzV2?=
 =?utf-8?B?T01JWGNVamJ1cU4wMzcxSFpqVFJwRU8vZWVJMXkwa2g1Rk9uV1pPMDkrcTRW?=
 =?utf-8?B?UExIUzVvVk03VVhnaTI1ZjdEbXZjdTNjVTYxRnl4Rmt5bVF1d3FQM0ZVcDc1?=
 =?utf-8?B?a2Z2UDBPaWJ6c0tHSlI0LzRSbVMxSW5FS2dNdmFVM1o3bnBFSWNUOWoxQ0RD?=
 =?utf-8?B?L25Fd3VXWjdoTE1RQ1ZEdHpDdXlwOExLaDlBaWoxMnZOdDJjdWJUMnkvZlZQ?=
 =?utf-8?B?VnlsbjQ4cXFmSTRXZWtvbXFjQXhhRXorZ0xlZjZLbXIramFBQXYxMnJYRkQ2?=
 =?utf-8?B?T2xWRzh0SW52OUYxQmFTS0NUZzRqRjRTN1M1UU5KOUtBUk1WanoyVlovOWF5?=
 =?utf-8?B?OUJUQWZiVEo0dHV5cjE3QjBzeEVTUWVQaGowTkJ4OTVFRjM0NEZMZ1k4a2lG?=
 =?utf-8?B?ZnoyemxzZzVmK1F1cng3bk9rTFBlQlB5S2IwL3FNaVh1cDVFdklIS2dIWDFR?=
 =?utf-8?B?ZldpSnBjOTZCUXZGbDNqUFJCNGpTaTZFRWZiNDRtWWxPYy9od1VJRUhzMWM0?=
 =?utf-8?B?RzlvRzlMZDlDbmNaMXMvQXFMbjh1aXkvUWUxVzZwZzdya0xZMmY5VUw1SXFE?=
 =?utf-8?B?bVBJbyswUEtMVkhmcWxaTGNYQ055K1I4NHNhMlJLTDJlYWFsNFdKNkVxdlRD?=
 =?utf-8?B?eDVmVW1CdXUwQVRrazhIaU9XRXlmQTRtK2lBTE01WEk4TzM0QTU0S1RNTy9G?=
 =?utf-8?B?QXJmSWdNclc3d2Rac1QweVJMRFBCTUFEZmZwREZicHlmNnY5SnZLYmZaeVJt?=
 =?utf-8?B?T2QrWXRZTFcvNE1ReEtQU2NPRWFXWTZUSThSelNsR1NaNTJFSjU3Q0N1RS8x?=
 =?utf-8?B?M0xDNXJtdG80S1RCdTY3enQ4TU1lRkxNVHg5WGJSY1QyaUFsbm55RnYwbzJu?=
 =?utf-8?B?N0Niaytoa1NONE1qL0FyUXZZaTNYWDlRdDdnNG55UHBnbWxSbFlOM1llbGZx?=
 =?utf-8?B?SE03c0hWVVZPOGlvZ1JTZGlPR3huZG0xKzM1K3c0UHBxY0pzTFlyU1NYUnRV?=
 =?utf-8?B?cXY5WWI3OVZhd2NPbS9YQ0FvbW9KZWJpR1kvQ085TEhHeWhsU3ZJZ0IwczBi?=
 =?utf-8?B?dHZiOGZqbUR5RFRoa25tYlpHTHNpdEVCTGpkQ0JaMHF5OXVDdUJzMEJjQTlI?=
 =?utf-8?B?RStTRmUvWHJjMy9GL2JneUxVU1FBWldOMHlsSk50NS85bURBSEZBdDlNMURM?=
 =?utf-8?B?RHgxUVlzSTBHSmhUbFRIcDl5VHhSUXJOamF1OUludHZ5TmxMOFAwYmhQTFFC?=
 =?utf-8?B?YkNwck1hT05SZmNkT3hRUnkyTitqUXRFNG1NcXh6RE8wRUx1OExaYmExLzEz?=
 =?utf-8?B?WnZGWndNbmNPM3ZnaWJ4b0RSTGhrWXBOSGZDWjNMSjNiaFI4alJ4MHBXbWU0?=
 =?utf-8?B?UnBURWl5c0xXTjZvb2k2TmJVS1hUZk9OcWJmYUZNVjZuL1RCcDRRbE1KTFhl?=
 =?utf-8?Q?m+bWuYxGNrawtAmLORWn8TA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d84b73e-7d62-4839-e774-08d9ebff5f2a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:07:09.6718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5ch0Bewt9HFvdW8EifnXawsfp8XS1TkvVmGH/uO52qAhR5x0apWFchAfsRB0yjZ4Lip2S2MetrNM1podjAmYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3914
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090101
X-Proofpoint-GUID: Cd2uC3sdHuRFE9FMDCmLRnXRk7zacGj7
X-Proofpoint-ORIG-GUID: Cd2uC3sdHuRFE9FMDCmLRnXRk7zacGj7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 23:36, Muchun Song wrote:
> The userfaultfd calls copy_huge_page_from_user() which does not do
> any cache flushing for the target page.  Then the target page will
> be mapped to the user space with a different address (user address),
> which might have an alias issue with the kernel address used to copy
> the data from the user to.  Fix this issue by flushing dcache in
> copy_huge_page_from_user().

Quick question.

Should this also be done for the non-hugetlb case?  Take a look at the
routines __mcopy_atomic() and mcopy_atomic_pte().  Or, is that somehow
handled?

For this change,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> Fixes: fa4d75c1de13 ("userfaultfd: hugetlbfs: add copy_huge_page_from_user for hugetlb userfaultfd support")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memory.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e8ce066be5f2..eb027da68aa7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5405,6 +5405,8 @@ long copy_huge_page_from_user(struct page *dst_page,
>  		if (rc)
>  			break;
>  
> +		flush_dcache_page(subpage);
> +
>  		cond_resched();
>  	}
>  	return ret_val;


