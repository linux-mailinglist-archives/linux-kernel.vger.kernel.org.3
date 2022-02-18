Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A664BBE46
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbiBRRWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:22:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbiBRRVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:21:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C701F6C954
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:21:38 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFww4A002644;
        Fri, 18 Feb 2022 17:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WEn3mgwUGJezatfaBWXpw0Wp6Za3+RfCjUvd4jWqZ/4=;
 b=hARdYIp8fuTBzSoq0Kpk/rqG/IjYmwsW/ElHUr6FExB23KQ54UaOEWOuSJ7WSRg35tMJ
 Ff9/LGgz1KITp+SBv+Kh78Y5gI2mPJIzAAHc/uhbryS/QIHhynH6Hs4H9W+2IFitA8FY
 Sk54IVrHCh/vZ8XFFaXnvw/cgGDrxcMsHWJbzvQswGhGE0nMUxZAl56UIr8xrefsW/ne
 Y79HSxhE3Nac2NuuNiNy5RxiNSpvyUqjJEmS/Mv/6mlvRZi5MMJfJFcVaAGaQtKDYU3+
 +EjUDnyKAMKMBuOGDfqC7Wp/xWr7StyxeACrDk3nwDyJZ1HnphzMSiCS8ICTZRgrHDCg xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncb27n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 17:14:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IHBL5a018712;
        Fri, 18 Feb 2022 17:14:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by userp3030.oracle.com with ESMTP id 3e8nm1bbt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 17:14:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3KU8YDUS9vIvaVjhlTf0+ISw+kXtOrUwpd3qJbF+QDXT8eqWkEo6rHBWst1hO2bhxQvuTtGvy7/+vwOfhcl/IMOLH8IX96HbQq9vMBh8Gdv68o/1O3OZhF9Gij1Xjqvz7PsEFJeczE5Yqqw6WErYiNYB+6oiy0ynD3X9o5cLDPK5fcfykXJgwpqQnJcweW+oXIRb77KDmEucode3OA1cIJxQY3J1R3YGOF5pc4xQ8nRW3Z5AY7Rwj44vp9Z4d938ag202+dxQSeMr+7vtWKzbjJESwpaEzY0EFvLy15UveXwUOZuQjkQkoWb8IbTb8dBhMqj3OO5Huonw2hU8JIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEn3mgwUGJezatfaBWXpw0Wp6Za3+RfCjUvd4jWqZ/4=;
 b=LlrNSrCOqjjZKLcNJQG+t6D/8LfRhvOjKOMl3YpdvtV0h9XuCqABI6LUylIkffEbsPX3vC4+w4qYge3s1RjOrvy93oGPp5sUGR0HA99uM++9Cv3qyqFSa8VwoPgscxua8AOclADCKlzMbf9GXwdgXV/kvTd4RQgq4Bwibgh6lXlbBGLBcPmKA+SmBaWfFCmNfQhs5KkPgzEL2B6GQLf51bWVzr/zAxxHxO0rKvHqqRALlygyPt45ltQCjxBeS6YR3tphzy2fKg9xD5F7lOMK0a7jwbQJ5nfS1AodA4BwhB8S4Q845h9fAkDhskbLcjae6+b4qTQy3PKC4lNv6PKBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEn3mgwUGJezatfaBWXpw0Wp6Za3+RfCjUvd4jWqZ/4=;
 b=mJzrii+QOLIMKzCo2P4idP+jnZNXCZcMi1F5VpU94H3aM1ll1eQR0kC36Amt9yleTqLNuPhIG2H4zKFOUXyhhZjpOHQ0yLWY14PFDQWdC3beNuqIZspXDL/WW/1TGiXCJg+9hoJhzHtJxWp92XAbzuBjUw1nRDuq9YdLBife0E8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM5PR10MB1786.namprd10.prod.outlook.com (2603:10b6:4:e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.22; Fri, 18 Feb 2022 17:14:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4995.014; Fri, 18 Feb 2022
 17:14:24 +0000
Message-ID: <8ba01b8b-6fe6-522e-5a56-28a4bf0c79d6@oracle.com>
Date:   Fri, 18 Feb 2022 09:14:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] hugetlb: clean up potential spectre issue warnings
Content-Language: en-US
To:     liuyuntao <liuyuntao10@huawei.com>
Cc:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, yaozhenguo1@gmail.com
References: <20220217234218.192885-1-mike.kravetz@oracle.com>
 <20220218034025.17687-1-liuyuntao10@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220218034025.17687-1-liuyuntao10@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:303:b4::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b01a7034-779f-43e1-6f69-08d9f3021c72
X-MS-TrafficTypeDiagnostic: DM5PR10MB1786:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB178662F2C71B896317F4A7A6E2379@DM5PR10MB1786.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELg5zkRxh3gdZPuMwYGPs1zQXvo9EHQJgIlcyvY8f6Qldiiyi2m4uuAjhVXkC2y6C8/N3Faf+MduTyckOI5NyR+8ads7J87Me2LZ2A6kFQoimxcCTVDCm2Ze7qVxc7X1SgWBwRMQxoTxBLinVGdKjVb3iDaVP/c34WNbBGELK8w6anTkz4LIwCxa+LWFwHjeoM9lNy8mt0VagDt4al6X6TO/vZUtQAj3RxAR6UKqEvCB5wnLblDkZOcycHmUgdlwOkJe8vafY3rYOpGXN/Czp6xjK9egGnWQJJRTVEPFn4vWwA+dlxBnB/4p/P7Jbk3pm6PdJr/kXj720MvG18uNQzgPvil5aRdw5Y9tFfq+YsjBoPy/JUJxNd3ip/IV6rAfehhy+fjcw6hHl/RMqNQFgO76wPaJrTo8fwPIl8y5yXTJJJB7UKlxi7jEjUu4Eei2RaeiROuYGB/ALLuUZvD+OwZ9qBHxbM/09Ke+lTybOGGZAvYRULo6S6Xz1/rJhys9jV9gE2kLxhMCJoZiFNV1/41cpiVYy6/GdP9cxPv4M/8wa/+iZzJwlZEQvi7HjFXA24F74N1ixm6zSM1ZIw94uH5HsH6/Qgt4qMrFB9tu80UdMHhI+rgvyHolIHDocUDWYHpnoozNPLgPXTycO5Rk+by/90Id6ls6v8AlbUVzbCSTrlJJ4gVM15ffeMUOMrKgU0DqXgGFE+55wevvHYnzu4Iu1hjkLe2rmCzM3PmSuV9iHqe5C6kR1NE8f80d4CIosWDyWvIXtr5QjzVM7o7bydiFTyWR5G+bPwcqIIFRtYxSmJhQ+KKgozSkzn6uzobRdMsSFsPL3iXxhubtPqhwX3x4JfluJuYXIi20hdE5vrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(508600001)(186003)(83380400001)(26005)(6506007)(6666004)(36756003)(38100700002)(6916009)(52116002)(53546011)(316002)(6486002)(6512007)(966005)(38350700002)(5660300002)(2906002)(86362001)(31696002)(4326008)(8936002)(31686004)(8676002)(66476007)(66556008)(44832011)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDQzNjE2bjl6RHBvdTMrcFFTd2RCNzlQMUNjSUsxYU5xRzU5bC9Lbnc3eXIw?=
 =?utf-8?B?d3F2V2M0cmhOV3hBN0h4QTVuU3poZ2VzYzk3UlN3QlBVUEZkbG1KRFFMMEd4?=
 =?utf-8?B?eDM4dDF2Q2xHeXA3NXpvdGFuVTMvQzhrcnUzOXlWTWFrbUt0cWdNcFlaRStR?=
 =?utf-8?B?UHJnME91RVpCSEo3bGFLZVJJbVRFQzlLOWdLS1VCTm50cTZ3V1BuMnhTMTQr?=
 =?utf-8?B?V1BIWTNLOURqR3V4aG9ESlppTk1wOWhFd0FTQk53Tjd5ZnI3QmtrU2N0VmVh?=
 =?utf-8?B?V3hjc05TYktraDIrTXpMMXJaRS9EclR6STYzV1IvK0hINVc1eHo2MTRnRGsz?=
 =?utf-8?B?NWtkeERpRVRJZlFVZmJJL0dxaWZ1OUhIU014YTlSWld4ZFhwQVY5OHUwK2Np?=
 =?utf-8?B?TzdSSzF1VXUrYTczRVVNV0tsMXJMTXcvazY5dzFPZWQ4SGhac2ZNaWRnL2tk?=
 =?utf-8?B?T2VjaXJWeXFiT0xHSzdGanRhMlBObnhXUUdYaWxrZ09NQUVvT2JWaEZmVzgz?=
 =?utf-8?B?ZTVBeThVb0ZWcnpVa0FRQVdvQm5vMGF1WU1oNW91WlVwQm10RTFpbmgySmFR?=
 =?utf-8?B?QXd3dm1DR201THl2RnNuZnJWWW0rQmNtclMvNWwxRmxsT1R0WGpHWDFBNWpz?=
 =?utf-8?B?M25ZelBWQzlheUNrMktZaDA5QTdwVDRVdlhPUzArL0ZxWVFwUWpUQUdqRVZE?=
 =?utf-8?B?WmU1NmU4WFBvSWZqcTc4LzA4SlhjbDUzYWRoclNlWHdFM01Td1hxemtYWGla?=
 =?utf-8?B?SW83MmtHbVVjOVF2bTJoNUNKRldjV3ZxK09zQmxmUkc2aXQ4OE0yVTE4OVRp?=
 =?utf-8?B?MThHcm5hYUlzRXZ0TmpnU0FEV2JyU1hpM3l4T2tOTzFNR3ZvYlF2ZEJINHJH?=
 =?utf-8?B?ME9lWE1saHpPTTd4MlNUaHVQRnFWZHJvbnREYWdRQTRwbmRhcjIybHQvK2F0?=
 =?utf-8?B?K2VJTXFNL2FZZ2JtNlZaeERrdzF2NlBUekNSRFRQNFNXSDg0bHpZVnBTcysy?=
 =?utf-8?B?R3BoQ2J4Q3VhdzU4K2wvdm1RYXR4YTAyc0tVSnRNQ1NzMmhZYjAxNlVaendN?=
 =?utf-8?B?a1l5a2EvdWpuTjNySjNEakU3WDhhdEJjMEJXTnlNMFRLN2xQd0I5VlpkTDht?=
 =?utf-8?B?NDVWR3Y1TE1JQ2NhTjQ0eXJzemVJb2Z3RExhM243SEVOaUdWM2xBT1ovSmo4?=
 =?utf-8?B?NjlBMDNJaGRNQk5xUk55bko3R2pteVhSK2x2ekU0Q0o1VFZYdHp2enFxZVpq?=
 =?utf-8?B?YktNYW1SQlQrRXpiWFF6UE9zR2NZZGNwNFBicnVaMzJYSUVpblRCUjI2RDNn?=
 =?utf-8?B?TDZqcWtpUk9qWE9TZHlsZFdaZXNpVmQwajY3M0lQYy8xOVpXbkhGelozM2dn?=
 =?utf-8?B?S0dWempSQ1V6LzRBSXcvU01LTFpRR041cFM5VEZXS1FKWWR6UU9tdUpKQkhJ?=
 =?utf-8?B?emlnV1YrZTNpWjgybmx6Z1R1V2hIY3NnWHlaSkJmVDI0T0drMW9mdDJPeUQ4?=
 =?utf-8?B?ZDBRKzFQdTFoYTk5UFNwaDlBU2RadVYvNGRvTlAyVXlERmNKa2NJZ3BseW5R?=
 =?utf-8?B?ekVFODM4Tk9yVmh5cjUrdGp4anpXRkU5aVBwdERRM2NxNUNZUytCamJicGJJ?=
 =?utf-8?B?eFJCem50aVd0azJERjZzaUlaNm1HSGVWMnpSQlg4STFsc05CbTlMRGFoSUFy?=
 =?utf-8?B?bEplYlBqMlFqTTlHczJTTFJWc2NSUzdFZTR2aGhPMytGQ1Jjbnd2VVlRWE1v?=
 =?utf-8?B?YzZwVGFiWHdLWFVOVXEwdEkyajdGVU81TnFmeTZoSE9rTVNUTDUvdkR3Ykkr?=
 =?utf-8?B?ek9sU05qZGdVQUp0LzVPYjhaN2QzeEQyZGxHK2djdGlCcWROY1dNTWdNZVFu?=
 =?utf-8?B?aVZ5KzBDSUQ1WjlkbCtkejBORVYvNDNYNmV6Z1MwWWo4TzBYWmxrMXpjMFoy?=
 =?utf-8?B?NW5BZmVrY2dxcG5IRTFObU1wM0hnOFVSc01NWTlSKzAyWjFNK1JWOFo2UEVk?=
 =?utf-8?B?cUpkbysrZGJaUkE0bkoyYXhFSGFwY1ZwUHZGN3FXdE5ENy83clNoU1NXcHQ1?=
 =?utf-8?B?Q2hDM0dKNHZBdldmQStvcVo2M3NvT3NEa1BYU0FXVk9MakxybFB5V2MrMmFM?=
 =?utf-8?B?aWErTDJ0MWRoQmJLd1BkVzZQN2ZpRTEzNWFsQ0c5UlVQeEtyU09aVUVPb2pz?=
 =?utf-8?Q?2eZaTnrYgTvvk5E2vwCBL0Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01a7034-779f-43e1-6f69-08d9f3021c72
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 17:14:24.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fDEIprp49GMRBZUn8TymzizxCt6Rk572PH5w4c3NRg1RKXP/Q3QS4XGyxNZu+swepZhnC+51H+fRjf34I3aSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1786
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10262 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180110
X-Proofpoint-ORIG-GUID: UzMsaso-LvlDxYMwjm0gADES-4AjNkLe
X-Proofpoint-GUID: UzMsaso-LvlDxYMwjm0gADES-4AjNkLe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 19:40, liuyuntao wrote:
> On 17 Feb 2022 15:42:18 -0800, Mike Kravetz wrote:
>> Recently introduced code allows numa nodes to be specified on the
>> kernel command line for hugetlb allocations or CMA reservations.  The
>> node values are user specified and used as indicies into arrays.  This
>> generated the following smatch warnings:
>>
>> mm/hugetlb.c:4170 hugepages_setup() warn: potential spectre issue 'default_hugepages_in_node' [w]
>> mm/hugetlb.c:4172 hugepages_setup() warn: potential spectre issue 'parsed_hstate->max_huge_pages_node' [w]
>> mm/hugetlb.c:6898 cmdline_parse_hugetlb_cma() warn: potential spectre issue 'hugetlb_cma_size_in_node' [w] (local cap)
>>
>> Clean up by using array_index_nospec to sanitize array indicies.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  mm/hugetlb.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 1f0cca036f7f..6b14d0791cb4 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/llist.h>
>>  #include <linux/cma.h>
>>  #include <linux/migrate.h>
>> +#include <linux/nospec.h>
>>  
>>  #include <asm/page.h>
>>  #include <asm/pgalloc.h>
>> @@ -4161,7 +4162,7 @@ static int __init hugepages_setup(char *s)
>>  			}
>>  			if (tmp >= nr_online_nodes)
>>  				goto invalid;
>> -			node = tmp;
>> +			node = array_index_nospec(tmp, nr_online_nodes);
>>  			p += count + 1;
>>  			/* Parse hugepages */
>>  			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
>> @@ -6889,9 +6890,9 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
>>  			break;
>>  
>>  		if (s[count] == ':') {
>> -			nid = tmp;
>> -			if (nid < 0 || nid >= MAX_NUMNODES)
>> +			if (tmp < 0 || tmp >= MAX_NUMNODES)
> 
> Here tmp is unsigned, no need to check if less than 0.

Thanks!

I shuffled the code a bit and missed this point.  Actually, this routine
cmdline_parse_hugetlb_cma has the same issue you addressed in [1].  I did not
see that until now.  It is fixed with this change.

I will send a v2 with:
- Remove check for unsigned tmp < 0
- Add a note in commit log that this also addresses an overflow truncation
  issue in the assignement of an unsigned long to int.

[1] https://lore.kernel.org/linux-mm/20220209134018.8242-1-liuyuntao10@huawei.com/
-- 
Mike Kravetz
