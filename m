Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41EB4AFCFD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiBITMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:12:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiBITMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:12:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D828BC028BE4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:12:26 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HMCFI013393;
        Wed, 9 Feb 2022 19:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=m1u9hbuz9UI7BJDV8JonQLVu/Fb3g7UjN7dldncmJ4w=;
 b=MtIoImgTdOIDoWgiHuzIKI/aTNAVNTaGuBnSZsTO7xQzruiKv0DVGrZBurdnNq3gvMZo
 DI12PFnOi36lWUV9sqJ9xPmybJqesPFvH7kWLhjxk+FLo7pFkOPX0IgAcYa/uIKB/5+G
 M6AXPabvCtaMiC2UTaiiSULVd0EWp2LF6mKF9rkRteoVVsYpRfbz0lsH8MkD43v7Dp7G
 tpYfKK93lYn3AmAGv59zayfCTUJOb7C5I3cMJAqg9o41zeCCxqtt2H7Wfc37MQDFR/aL
 WKrCiaG2oGY3DMgY0cPyHQHMKnw7RqZ9zWiN9cHq3T3AHOTZkgdvafgjOBBsQpV2lRPA tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e368txrdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:10:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219J5cYA157335;
        Wed, 9 Feb 2022 19:10:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3020.oracle.com with ESMTP id 3e1h28txtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:10:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUmTuphgDsT7z8m+v7FClmPFSwEXeWuyCw+ODztdsODcUA7hU78JPD+h59um+Urhn0SOiIJhAN9v5xt9m8tdSesEM5y0qfxsrSAapuRx7sXX6CMnZjX4dej9L/U4BPUvnydNPBRn3Etq25IDNVQdfo9r9NuSyRVS0TasMiNIYw23jM0ek15iEuBUOEPh3/S4u3ngRA/W2Uts0lbKzvUOeLyUnBIepJ1MMIEuQhEG1oYVf1DvcrTg4ban04cifGIUwLlvdluDGJLEC1O1lD7Qtzdxr+9trB5NIyuvdLt8w2bm5n5M/rSbDw3dehf5bN7H2TJsa57QjNViGUgPN9Cj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1u9hbuz9UI7BJDV8JonQLVu/Fb3g7UjN7dldncmJ4w=;
 b=bs0PSrtqvoMFE66NVT3aw3ngJS+fo17gX8XtqiD7q2jnjJguJ/IJSBxeVhuV3hk4G8GY6GmgnrfR+cP4/Fviun0x7SqJ3zcPgYe7j25fbmyLFr8hZP0KfkLZojiwjds3T9Jex5Zs7MK7AEPKEMa6+MVJHA+ZG5cqy/QN6SD9akmKzieA5OIpxvDvus1u0jQO2wKPzC1fAJJXuHxtXV6cqjtlC1SDsCJwJZCts5YHIRPHdbzSmaWwijlNm5RXHE37y9wovZC+lLHIxsSn1KsZrYRzGqT/6CwBMf8I/3LyJdTU/pVXglFwb90udqsem/gjIX2LKJQPYWInHB5VVuVa8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1u9hbuz9UI7BJDV8JonQLVu/Fb3g7UjN7dldncmJ4w=;
 b=QkY9gUykomNRrP9k9nvvl5+AfW8bCRIGF9AHKKfQL0T1rWPTTHJ/9CxMEQLfCzB8mWk0Ye8WenSFfZIGCe5Pocf4AFvHoCO0RXZQxyGiQTjkKF2IPjRLybCcbyUV0jRMwGfs1ONjldi1OV0CgJsAaCVTgYmujXYxSsCfkJOEnJ0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5871.namprd10.prod.outlook.com (2603:10b6:510:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 19:10:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4951.021; Wed, 9 Feb 2022
 19:10:15 +0000
Message-ID: <45aa3c81-aeee-7e75-aeff-b122a1f6ac44@oracle.com>
Date:   Wed, 9 Feb 2022 11:10:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 5/5] mm: replace multiple dcache flush with
 flush_dcache_folio()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        zi.yan@cs.rutgers.edu, kirill.shutemov@linux.intel.com,
        rientjes@google.com, lars.persson@axis.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
References: <20220208073617.70342-1-songmuchun@bytedance.com>
 <20220208073617.70342-6-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220208073617.70342-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2001CA0019.namprd20.prod.outlook.com
 (2603:10b6:301:15::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e73a5550-c367-4be1-635e-08d9ebffcdf2
X-MS-TrafficTypeDiagnostic: PH0PR10MB5871:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5871161B8FC2C5006A2D6429E22E9@PH0PR10MB5871.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kaFZCgKQRG2av/qrKNv4+JDusnJxRvwfTLag1zD8daiBw8gy4ulwGomFskGZpTM0cLB7QGG6ctWdPyqbmWTXH7HMv+8jPFGthkBYEjsR/TbepNcSbHDcrSWYnQi/drMxBQYzbfpc6vPmtZ9P9zdmVVo+F8L8+IETJh9pflJ2fGJa1FErBRwe8BiMLFx1dXFwL1/PMq+bEA6OaJB5ZRm2xHNDkk15RcnCrFGa3IaFxSMjhVctJofNVsj890dZFoM8A2tRe31tOdll3w+1Jx/mlZDCqBxwrWPvfOXcmX+ehTqZ2hEMnUKEJtYFRVs7vJ6Kb+y4EsagPOROcdp+wMzOZMhONDSSVBVfpYwID8tU8F9f+g2pQpRWLDEREaeV0k+sZTV+k87SltKUaLNsMtniHtUx8xS6YV/neLNHkLgQLh8FHLsilvM4RpOu5bKHSmjQG26ENU9Vl7S4HKm9ge0UJg9YmqNK6XOJv4N/mZtEmmSdzNDBn1nYepAUpH6GCfZVdottlyMZv7kHUV+VeuXUO6RS2jU4BagXzixSemfq0rS+ItjWHGdQVmptFn8HTEJxZhMs7nDXXrHUM7kMJN3bao0CthSFbu2u4OzLjmsXofV+rCQpotY+mnuCSVxXwWm9hQjOicfkPm8NP8f4qoRI6FebZhYNMu5ILLS2Zs0h4mwzUHgC6Hc3PAYbMNZh7DYcntm7CWhsVi7JLcdQwANCVPkxyrcVjDh9YiWAwL/J65vtuwOPKdAoYMepwiDZ8ZfqF0m9/WKQdid9+J0TFsfpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(508600001)(7416002)(53546011)(6486002)(6506007)(4744005)(66476007)(83380400001)(52116002)(31696002)(86362001)(186003)(66946007)(2616005)(38350700002)(36756003)(4326008)(44832011)(31686004)(66556008)(5660300002)(26005)(8936002)(8676002)(316002)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1kzeGRwNGR3aVAxenlrQkx2VUxWTlVXTEdkTE9qMng1UG05OEg1aFdwNUVH?=
 =?utf-8?B?NWw5Um9HWDZMa3YzMXVoQ2owTFVMME1zK0hFOEkxL2RycGdwcHkxZkx2WmFZ?=
 =?utf-8?B?b0JldDVTV2Jxd1JiQWI5Rm03WGRZVkMrUzhVaUdSMkVMZ0JjT1J1cDF5SFdR?=
 =?utf-8?B?czZIZnA3U093Zmo2RnJUMmF6U0oxeE92SjNmVndidHBMcGdEeDMyREp6dXVr?=
 =?utf-8?B?UVRBeXg2Rm1hQ2Y3RExwQVAvcUoxZ21layt0RlBMaUdzcXlsOG02L2s0dGZJ?=
 =?utf-8?B?bjc4VW9Ndys4RTJoV3hOU0Z5UVRaYjArdGtFRXAzRVJaMGlRa3ZDL2dKYjZq?=
 =?utf-8?B?dXcrZk9jV0R6d3VNTTBqeTNqQjN6T05aL1p1Zk9tU1NtQUlqWk1NZ3pBNkhC?=
 =?utf-8?B?UzQ3Yjh1S2ZBYkovNVJHTXlISlRreEp6aDJSZjdSTlZHbG52RW53dTdSMjBR?=
 =?utf-8?B?ZmUydXJQckZIaDZ0N1BFSVZnd0VMRkd2OFhkNE5qQVlaTzJuUWFleWR2emFK?=
 =?utf-8?B?SkprcFpST3dZYk0wN0dSZW1JME5wcTEycUtCZ3RzakhCSzd0cm13ckxaZ1RQ?=
 =?utf-8?B?ekxQckNWSm1HY29TUlZMcjRmaVptcjUvWWpBWUFBVU9reUZLeHVWcXc5TU9j?=
 =?utf-8?B?TjZLQzRxOUhQWklDeWJSbkdLWkVvdDdrTkNuMWR1bHNIcnVucTZKQ01qZ1NQ?=
 =?utf-8?B?ck03Q0JxMUY3bDlCMHZ3Z0sxUWlSMys2Mzg0NVRIWmEyd2J6cDNoQXkrTGc3?=
 =?utf-8?B?dyttT0w0MjVHSC9LYlZrM3ZIdWtxaFlOUWxKYU5hYlNkeENiSmVrZmlhdXBh?=
 =?utf-8?B?U28rRWlkSTFXV29UVXlHa3BNa1VqNGZNNit5UjVNWjR2cnJUMmtuK2dOV2Zq?=
 =?utf-8?B?MkgrSFJTRlNZSXhXcTU1ZUcrbkUydzc1NWhlaExEUHB6Unp6QlQ5WlgvSHVF?=
 =?utf-8?B?MTI3ckVIWk5GUnRPOVZSMDZmMEkvbjZjV3VNZ3RuTEJ0K1ErVVN2RUpiTFh5?=
 =?utf-8?B?SWxhd3dzRXVVQ2dpZHI5U09lUG1kL2c0RU4vZGNMSFh0bUlybkxLUmhEY2hq?=
 =?utf-8?B?eGhkZXJyUkRuaHF5ZmRUT0lSMVBpcjhIS1hBQ21QWVZjMXJTbWZubXRLczBo?=
 =?utf-8?B?Q0s0eUFuMEtuMVNnc0FYMHBoU2h3a1d1ajJLMmwwNkkxNlJRaHNOL3RNUmRr?=
 =?utf-8?B?VXRCN0dPaDJYRTl4MU5UV2tROU5TbCtEOGsrVlYwODhMQ05Ob2UybWltZXZs?=
 =?utf-8?B?eWY2bjFpdzJKMXl2eEljQWJCL01HdnVTY0s1TkRNdzcvRjEvejNOWDBocDhI?=
 =?utf-8?B?Y2NlL1Z5WXc3NDQ5OFJkWVR5Q01PT3RITzVVZHZIOUc4Y3h5M3U0M09nNDQw?=
 =?utf-8?B?R0FWNUh0bzFFS1BGN0U5dVZibGdMRWlWMEFmZWh0d3RQVkVOeTJ3QlZXM284?=
 =?utf-8?B?c2tJSDhNM1FkdmRxUzFTd2drOW5aRkFoK2RLd0F4V0g5TmNiNlZsaThEUmlO?=
 =?utf-8?B?VzhhVHNhOGNoYkNMVXNGZWFZZ08zMVdtWklwZEYxU2EvT2UvV2x3TXROYlBU?=
 =?utf-8?B?OFEwaXJ5QXFySDY4Y0wxV0JreGdJTW1WOFZwK3dlZ3NFSXI3WUloZ3JpRWhz?=
 =?utf-8?B?RHNtanIvR05nTXZrbnFmYlFpYldrZEZ6dkJkampVOXpVaGpKcVFHZFdoZVBQ?=
 =?utf-8?B?YU5jU1o5MVhIUW5KQ3NUNGRodm92Sm5aOGN1ekNqd0laNVZ6OGJWS0JFbnZt?=
 =?utf-8?B?b0VscVZyV2lmb015ZUk5eGhlemVZNC9RUXlrSzJDTEFJOGlSbitPdVZxMXBU?=
 =?utf-8?B?UGhZYXdjK3NSZnYvS2ozVkhWUWlUemp4ZkNua3BEK1RvdUx6TWU4OWp5SkxU?=
 =?utf-8?B?TDZESUgyR3J2VndaS0tqTjVrVEthKzFyaFlYV0lMWGVqc1RPTSs0WU5IOHdZ?=
 =?utf-8?B?VnQveTcySmZlY1drbEJBT1FsVlgzWUxvQThYZXZZbUk1ckwxYVRDK3NXWXlR?=
 =?utf-8?B?SnJXMVB0aldNbkhUdHlvRWtLdE9ZTTBhR2UrSm1tbXRTVHFwdmxMK2xlSWdu?=
 =?utf-8?B?WjZVRHM0NEppYnFpZlNKcDR3UFZzSGpBQ0dvQzV6ZTlKakNlQVB6c3RUQ0pN?=
 =?utf-8?B?OWt4MUZyUVJmMUFZT0hjR011cXNpcWlSaG1xTkxvYzMxbVlPaU1zZkdXN0J4?=
 =?utf-8?Q?NLU4kgd4ji0uUgLUf+N3bJM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73a5550-c367-4be1-635e-08d9ebffcdf2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:10:15.5600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wm3DvcR+Oht7q4cPGxq2Nq79zFoMBcSGmUQRX9AIAFS995r3cUxEv93iLQHos2h/4ogtA2fWAW95NP4HR+v6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5871
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090101
X-Proofpoint-ORIG-GUID: wjXmNZwmVUWUsxrs0i0qMjtezH51O875
X-Proofpoint-GUID: wjXmNZwmVUWUsxrs0i0qMjtezH51O875
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
> Simplify the code by using flush_dcache_folio().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/migrate.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c418e8d92b9c..daf2b3508670 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -933,12 +933,8 @@ static int move_to_new_page(struct page *newpage, struct page *page,
>  		if (!PageMappingFlags(page))
>  			page->mapping = NULL;
>  
> -		if (likely(!is_zone_device_page(newpage))) {
> -			int i, nr = compound_nr(newpage);
> -
> -			for (i = 0; i < nr; i++)
> -				flush_dcache_page(newpage + i);
> -		}
> +		if (likely(!is_zone_device_page(newpage)))
> +			flush_dcache_folio(page_folio(newpage));
>  	}
>  out:
>  	return rc;

