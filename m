Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37544C3139
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiBXQ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiBXQ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:28:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E44EB4588
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:27:40 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OFWRka007294;
        Thu, 24 Feb 2022 16:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=200kOCfXtYF/tAr9UfR5CF5vsCqg1VPUr0/EKP19veM=;
 b=xf32NczT6zzwTEZjbwlYZNa+rnT4KZl2IqUWLkY2NzzqVlKrRyWNoL3i1CAaibrnk4Ua
 r7bbfqcVa5MzbnS2FZiFxMrvVNiF0vUlTDf3M/1WH3hTzCnLpag+jEcyIEPvG17Y2dDO
 QiqskH/Qb0cKMlzv9RGEKbXug0LvyxC4cN6DpXpL97S+Sf9aImcn+3NSPXnDPnJPXJAs
 L0LvYi6HXqOYTADLwWzA7B5eELGReGMVdiiY07JlTnK3Slxuqo46n5kBkwn7TXl3gk2z
 /POq8ZCWc4uxmPT6hviVvXKp75Ki5VAfcoMHq6XDrKwOFtO8UfOSKTD8SF1s77mbXw0Q yQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx7wm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 16:26:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OG729V160817;
        Thu, 24 Feb 2022 16:26:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3030.oracle.com with ESMTP id 3eapkke0ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 16:26:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2+kYs0GBXgh9l/eTkxQi6sTq9vY3GjpQNKeUFdbfJAlcE5TVDPRObvsy3akWX0b1brvyJ/Rp1zluHkZvDXdOF49b8N6rjqldRhzzLj8PoOmMno8JbjXux51q01UZUQ0txs57jXIYXAfuavc7L3v7Z2B5A6nU2SR5nmOuOCIETi3X1ndg8A4PvIIDMe0q04S11dw1wa9G/pAc3Z0eB3WU8/iLCLRaZPNWmkUsl3c6smRQ/LltFuA/+wbw55/otRzqXf+CWpxWnbJRnICaVFSsIEO+JAePRk3L57BdVZnmNAj3KMaLHzRqI1Xu9rWD7UTdLB3VbqykjwAFTKzn2SPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=200kOCfXtYF/tAr9UfR5CF5vsCqg1VPUr0/EKP19veM=;
 b=ZmfdelQ5YfwOf7NXDETkTBriOjY+8NnZAX3y61feQ4untZWFgWFUMv2TX6z1OLhUOCty+GP54h/xd0gjj/4Is1RvvbmMy6FaLROep5HrP/UWcjxhLl11EK9L0Nzv8UNpBYb2FsRtTsCz5YpLJn5FZPpCmaoevkQyY6doaW5GkV15NoAn7A/YNuymOQXCOCbVgip24My5E0habFTjoOFBHf+A4nxWu4gRNOUC88u/CVYiKJ0jqQ9RHxK1SJSZK2ErN2+VzvlDIDu6suJ0DJDuhmJCLNreFImntfAjXLuIB8u9fL2UH3qzOmSnNZ45LGwouCO/5EctsPz823UrLgubTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=200kOCfXtYF/tAr9UfR5CF5vsCqg1VPUr0/EKP19veM=;
 b=waawE2gRK7RnLnKngVqJAH1pXhPLV433AD911zyaX/aXtl9QYf8tSfjpW0LLDyJrjZv/WJxlNvfQwm3yMha1mI3DtWyv2lJH9ruJLk/oNS+KajiMAFwG5pgqR8NECPJwtoyFRVLDbFddv45tuSsYI3/rc1ycIo8+fI4s2xgBT9c=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CH0PR10MB5050.namprd10.prod.outlook.com (2603:10b6:610:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 16:26:51 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::5552:4944:d684:1bfd]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::5552:4944:d684:1bfd%5]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 16:26:51 +0000
Message-ID: <e1c1a037-9782-dead-fcfe-e6be318069fa@oracle.com>
Date:   Thu, 24 Feb 2022 09:26:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RFC 01/13] mm/rmap: fix missing swap_free() in
 try_to_unmap() after arch_unmap_one() failed
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220224122614.94921-1-david@redhat.com>
 <20220224122614.94921-2-david@redhat.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <20220224122614.94921-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0010.namprd05.prod.outlook.com
 (2603:10b6:803:40::23) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7855cf4a-08fd-4b3c-8d40-08d9f7b27666
X-MS-TrafficTypeDiagnostic: CH0PR10MB5050:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5050E1942755F878D2020229863D9@CH0PR10MB5050.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8NOaDxHoQ2Cj3JU+DYXj0t3f0NMe5VlPU4lQq4b6z4vFbldKqACLsSGcQs19qy+D1PzzSmvCyaNfXDNm5sOug13HSBc/Azekq0o0RXtVpGJlYsVCmolY6eh0+1hw3h0fEtZGL9z8YgdzN6xrBJ+BiOIFmja6EbgCD6fTV8VoQ9T9CeJo6VF2ZLXoZyEu5hi+ae8AWZn5EP/BDGBe58F7W2gRRsvFa7aceg0qWbhakKXeh5jdHm6/Oi4xOooQXE7NFA1VjGM+d9PrnSR1ncVz+nTqKd8R2IxCbmULWurArT+9RA2Oy21rSjWfYEngb5rOMXCQbTVJoSCN9Zvf/Tc0M4BVZh9UYjgLDH7O4ScosQYUd3Yo7MwXpZRHvwQ60ZLNw9vEmEjWsr7HdjTOuKxMAMqwEkLy4LRtl/lGrrbHPbTCwJZAhwGfNxChfvN/f/u3r+qI9ikgOiASsHpyXYjI9E1sLp4L+guNeJGy3qB1yhrIdmhcJIlIYwiY9Y8uVF7OyLcPBLPHyQ2rsLgNHEutNk75hHj1vqhMSxK9m900g/03BF2ch0ruAWCgw6Hr8YM9cfOcaHZC7yZS0rHMY0gxYWID1ht7rVpa4bjI0UrRwheLEfT1wkpMm+YeVToD/hcO2t3m5MEe8aKGPvXpkFU1Etmo8VmbFTwUZZn4XJL/+HkChUwYY7Vc117v79+PLgISRE1Zj4F53xqg1+Hp46quX7NeG31I/JICCUOcmWiQhd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(8936002)(6486002)(26005)(2616005)(5660300002)(86362001)(38100700002)(2906002)(6512007)(31696002)(54906003)(7416002)(4744005)(44832011)(36756003)(508600001)(6666004)(316002)(53546011)(4326008)(186003)(66946007)(66476007)(66556008)(6506007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2tOVURzZFJkL3I3OVpCQU1IWm9kL2hlMzNjc1NQekV6R0lGOWR0RS8weDdh?=
 =?utf-8?B?ODdRZDBieStvQ2RBbWkvbVc0QWRMd0kvbElkcmJIdEp4em1lT2ZyYzdpMkV1?=
 =?utf-8?B?ZlhmOU9nTU9EMm4xUG1MY2RaVmlMRFExOUs1V0ovajdLMlR2YkZxdlVtZHlw?=
 =?utf-8?B?d1l6R203MHFSRjJCc3ZFWUNsQkFtOG9xR0pvdnkycGZvVkFyVXN6b2R5KzBP?=
 =?utf-8?B?UDdOYmRjenNBZmt4VTRZODdHajN6dnhDZUNKdGMzaFhWb0k0WHkzckdGczdK?=
 =?utf-8?B?OGZCZ3o4RVE0Sm8vaFd0UEg2TEZvRWNJU0JHMjdQdkV1bHp2WWd4TzRFOGZi?=
 =?utf-8?B?RFpFRG9yOEdYQVpKT2VOb3VmZE5Db0hpaVpqZXNTSFBxR1EzZ1pvYnpuQlI2?=
 =?utf-8?B?RFQ2SHg3SGFydDdFNDFjRDk1bFNub2Y3R3U3SWlROXFsUHNvditGRU9rMjkr?=
 =?utf-8?B?OGk1TUt5cWZ3SDE5NzBaRURBSEhlb0s5T2d0KzExMUFmZFFsaXNDNWduMnc2?=
 =?utf-8?B?eXczbEE4aE5BV0VBT2RwN3VCWVppeVhqc29HOTJtN1EzR3hwYVZndmt2Y3Vs?=
 =?utf-8?B?RC9aaHd1bXRSY3dQMnpmTXA4NVlKUlJxY3VtYVRBL0NwRkROYWMxUFRvYTY0?=
 =?utf-8?B?WnU3ek9GZzJ5K1o0c2dmKzVFOXk5clJkaVdLWWpOSWc5UWk4UmtyaitVMHE0?=
 =?utf-8?B?OTMzcWUrYldDbGRoVFVWTytFM1dwTkcraUo1eUViTEtRbTZvWFI5RVpVUjJz?=
 =?utf-8?B?bzA2Rjl1eFkxc2RoclZlMkphUFlTNDAvYy8rUTJJaUdDNEZJS1lWNVV0TUJN?=
 =?utf-8?B?WmJLY2J1Q3dOTU1LN3BYdTg0V0NnY3FtN3Y1blp5Z2E3UVdMS1JKSlVEczd6?=
 =?utf-8?B?WUduRDhOMFduUnZLSjhTc0ZPdVpjeVFZMERWWG5HOTJaa21qUDRZcHU3RWpq?=
 =?utf-8?B?R0ZlU293UW9WTVJlcnBVMGlTWDFXdGFqUnNRUUJpNWExM1hRVXExVlR4UzNO?=
 =?utf-8?B?TzJaRTkwOWpvV0h0ZnlGYmJUYW1lMWZHK2VZWHNUcHBsZ00xai9kRzVva3lC?=
 =?utf-8?B?SkpXKzhnL2xLbHhZdXphNHUyYXJZUzF1SWQvUGQ1WDB4RExsdXZpMVVobVVk?=
 =?utf-8?B?K2dFSHVrcjRXd2RLU3hudXJHMDVpdGNVL1dUVmRTK2JQMmY0OTBMTWs2OFpj?=
 =?utf-8?B?SDNabzI5eWJsRjd0Ym5xV2w4MmhJbFhJS2xtRkxsNWlwb2VhaHl3QWU1Q0Y3?=
 =?utf-8?B?YVllZ1FnN0NKSGw1aVE1SWNWYzZmR0x6WEdxRnllTUd1OFBlV3d1ekdiNXYv?=
 =?utf-8?B?WU1ackQxWDN5T0ZtMllBWi9FV2FCSWNxMjhzUnorV1RDdHZ5bHZ0c3MySVIw?=
 =?utf-8?B?aUl4N3l1SmZBWmVjVGV5QzB0VWVOeTkyY2VWalpzbGk0V1JIMVJDQ3JmcEtI?=
 =?utf-8?B?RWk2elVMZEtRTTdueGtkUjU1RnlIdU0rSHVOdFRWSERXQUtLb1FGQjBrcWpL?=
 =?utf-8?B?MW9veWNjbUg0U0JTTjBScHVLZTJNbWwrRDRwNURzQkxDWmxhVDJIZUJnOVVv?=
 =?utf-8?B?cVFHM0k4QW1sSVF1bXVJSmdvSFFleE5zN2ZKb1pEVFk5NlJqM1VZMkpINjZ0?=
 =?utf-8?B?VVNqbDZXeCtQTDJydzk5N0NwM0hXNzFFdDFaNGthL0NwbHZZYTRXdkVNbER5?=
 =?utf-8?B?QmxDWjNxNVdJWlFhanl5dU5FdlM2WUpaMlNoN1JFSzhyaFF1VW9WNkRNdzJo?=
 =?utf-8?B?eDVtYUNnZ0hBWXA3c21GVEIreDBjQy9KL2VYRk9iQ1MrcWVGUFd0NUVGbGJX?=
 =?utf-8?B?RGNuc3dabVMwSERQdDBWelcyMTJWTGxscmgrSGpJVGxLWWEzQnNGR3hEWDNO?=
 =?utf-8?B?K3NpRDF0bFM3eFcyK0M3UzJBTzMwYmkvQURKM3VmdjZ0S05MSzhIVUxOZSto?=
 =?utf-8?B?dHZQcjNrckJuclVWTGFMMmMxOG5IUnBwclpzeGtHODFKeFRHRVhQOWhiWVJV?=
 =?utf-8?B?MTVTNXNlbmFwbDlMKy9IdHlJajFqeEhub01vRHRIdFVDUEcrNnY5bjZTL240?=
 =?utf-8?B?MTRDT0h5NkFJT3pqSjJ6L0kzcjhUNUZXR01HK29BRUIyRXlUQnZhNmkrWnRh?=
 =?utf-8?B?M0l5SFptK1ZlMVlpVGl4N09tSk9RRU1LZTJQVm5KOE8rdnhhNUYveE92dmtE?=
 =?utf-8?Q?Hb1geG7iyQz948rw9bvknuU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7855cf4a-08fd-4b3c-8d40-08d9f7b27666
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:26:51.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PImcNyw8YkJW3kOwwjk39t7PpmORMROp141IcGlMoqcSfsKy+PnTNLrqm5hw80kXZupFwZ3DkRPglRULh9yZ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5050
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240095
X-Proofpoint-ORIG-GUID: Ttp9MZKlv1NKZG1texLjA6y7mUsOIoW0
X-Proofpoint-GUID: Ttp9MZKlv1NKZG1texLjA6y7mUsOIoW0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 05:26, David Hildenbrand wrote:
> In case arch_unmap_one() fails, we already did a swap_duplicate(). let's
> undo that properly via swap_free().
> 
> Fixes: ca827d55ebaa ("mm, swap: Add infrastructure for saving page metadata on swap")
> Cc: Khalid Aziz <khalid.aziz@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/rmap.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 6a1e8c7f6213..f825aeef61ca 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1625,6 +1625,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>   				break;
>   			}
>   			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
> +				swap_free(entry);
>   				set_pte_at(mm, address, pvmw.pte, pteval);
>   				ret = false;
>   				page_vma_mapped_walk_done(&pvmw);

That looks reasonable.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>

--
Khalid
