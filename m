Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30D4EB4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiC2Upq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiC2Upo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:45:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5247156C12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:43:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TKeglq028406;
        Tue, 29 Mar 2022 20:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8/AiFHodVaPAEictazV7DFCNDibggGlrrh+iKKb3HGY=;
 b=phEiDC/egvQyfXtW3lcyLLB89beHNNuCUmo6FsYu05/6j40cFmaNKUM90/OgFZXkleuX
 KMNlHSvZZf9SojfAC+MEDX0sv5W2G2wF8aXJ2npEKoQnoifNHYbAYLVx+vidcSlNnNGy
 bkC3f5WaJTN7XIdpDPY8Cfhs50GIG+Jhvr02QPPweqsoQiEYuk6O2K8wETXqe/zqdGLn
 hE9bwdLcRYcc1CW1iwNSQjFannoT9ktktlSIVv7s7QG3ec5QonYkWE4UJ7mcb8WkXrYg
 zzLZBJO+ZpmQiSk4pvubvU8ktamtiOEaPOBou8UZaATZZT7ACbC8C+h2fUDTmH4lOOKg 6w== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqb7n00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 20:43:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22TKet3L140265;
        Tue, 29 Mar 2022 20:43:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 3f1rv8dt7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 20:43:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3GYmR9d0MzKiT+E78zjqyGeLLEn5udc7wr5o7lRq+KmeeyYFKPvcBQk+vaVFyg2ls/2n8xUNeKRWI4Ik+VCl1iyD1FfqHYP1gZOL0sQ/JVUeduf5SBkfzyUrDhpb89Q1bMYomxRunduHEwx9jSmV4g3rmR8cWCM9AdcRfCn0va2j1RF9SAU6IqNKsbIKByM9nnxL4vQY2MOsdAlRbTGym6Sy7IlKi4u6jxMR+QqKPHNmsndp42iU8UNNTAMwIpqRKJ8lUbf/4OnmohROA1t7dZtxwJQ+B7TkqsdkF0/I/QxW5D6lDJij9lDbH5yG2gegppAzN/mMJ7/2X8JmzA1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/AiFHodVaPAEictazV7DFCNDibggGlrrh+iKKb3HGY=;
 b=MH9OCc6yjxihWCZXOKsqtmP/5mrnqybbQzE64QxrOzT+gvL6A2X+5/R409y4/5psiUEHxskDEtBa2Yj896xSJqAJ08+Wt9aFeTXG02vRxyi2iADNXOECXa2JKqYSVrSgCZ9Nw3Z4bxT00Yey1Ppj/Samv6XPT9JZ5t+oPudfr4dybvSPyoON71Mt68tKDCUy7qseXPmzpQHimDk5G2CMSuIjDvpA3KVrxmtYhMBS2x243HxvuQy+cyFQoFwPPewFDpbmX6XXb8VzZw7kHt3SaxIoBYUnQIYoEhMMXSwDOlZR9/jo84n5Ba3M2uPzi4NueXat+s2HS0OLyHDsxekpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/AiFHodVaPAEictazV7DFCNDibggGlrrh+iKKb3HGY=;
 b=MaZYbuOscsKQ6DePu2LuGi1ZUOXWP/T/S1dnlfeGnBYwSU9MxC0xl0OTQANEtwDQnEMh7Hg0IuhUZwzMxkbww+xvc/7kMxlCU1W4MwodT9TjcgM8rMQjpWtA+PRRf/kGNB6yThHlyr5nMIZJ2IOMNXpoeAPTagYwZWx/3Ss4J3E=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Tue, 29 Mar
 2022 20:43:05 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::7dba:ea0:121a:eeaf]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::7dba:ea0:121a:eeaf%4]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 20:43:05 +0000
Message-ID: <909cc1b6-6f4f-4c45-f418-31d5dd5acaa3@oracle.com>
Date:   Tue, 29 Mar 2022 14:42:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 01/15] mm/rmap: fix missing swap_free() in
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
References: <20220315104741.63071-1-david@redhat.com>
 <20220315104741.63071-2-david@redhat.com>
 <d98bd1f9-e9b7-049c-7bde-3348b074eb18@redhat.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <d98bd1f9-e9b7-049c-7bde-3348b074eb18@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0007.namprd07.prod.outlook.com
 (2603:10b6:803:28::17) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 955bf654-d46c-4d6c-53b3-08da11c4b980
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5600:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5600F06039596EF5A72D7825861E9@SJ0PR10MB5600.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBp07Xhj8lK+VydNEs+YI8xklsmIabAtr215WtCjNj9LVLoZLq1w9RamnL+Vu3BkKVWFMqPizSTaQxKmTnO1KxuRCczHll1yA1ouTxkd61gq21LMfKT1TmSSPKmBH0xk/VY4AfEPR5JjfLfMQtaZ6HX9Dj5KUS0eS+DYRzgagvv4cW4RWshJJIx9o/eE4h20UdQcKQpkA6V59P9i2TxIrDWmgaMWaLTKDEXwSHlEfoBvpoMBBxu8BSzelV7N9t7bpjvs8KxXIo+oqMwtMH/vefj0CQ5rye60JP9GCM3m4dWycstIc8sQGClZf8tt2RYHa7PBsNMFcY105rqWlDlS7I9wA8tDWDKR+e262bCEtb5IKeT1WkFe5Kxofp21NSm7NTyEjAaqrMa606RM6swMxIiBrl8ZpsrZvVICOi0XGCNLhhAsXORhWvsMXbqkgwgu39LVxhviM01K32QiGd53V1Dlp3I77Tr86G0w2Em1cVWFfOKncipP/Tz2fpBInolnwatUbugMnqCi2jVjNCqyaAj5XQrMcXO9J26Y08nZaSBDc0Lgy9CGYI8TS8LJJpBG5LTX1PEHr6UtisjgP3/2g8ApOh1DmF39HQb7MScG3dNWhq8fh/qj93hS9sxKUZ0k8oac1Pb8aLAbS8pHXk3WZ5cy93g5FMTihESyBryEswPE4B60SpKZjWDUnlb4MzSd2/eF1L8XsUG9F+93H2OmOQZ8m0q4RbzZ1T4Bvrebu7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66946007)(66476007)(66556008)(53546011)(44832011)(508600001)(83380400001)(6486002)(86362001)(26005)(2616005)(6506007)(31696002)(6512007)(8936002)(2906002)(5660300002)(6666004)(186003)(38100700002)(7416002)(54906003)(36756003)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2FKblZuN0ZocU5haXU0YlZORGphcGFuQ2NKYlA4Z0VRVVN3ZkRLeElSdXkw?=
 =?utf-8?B?aFNTa0x3T05CVXA2akNmSWdzdGVEZ2haRXNQcDZKbUVqTnJRVXlLTWsrOHg5?=
 =?utf-8?B?dzlaUkFTY1ZiNWw2MEIwRE05WlVsWWcwWE1oWW1LWVF5NklHUUY4cHRNeElk?=
 =?utf-8?B?ZzBvSmg4SFAzb1JXdG5ZRmJGMm1nSW05TCt6RFIwbUErL25MZHNYT3RNMTVr?=
 =?utf-8?B?aHVRUjdqVkZJcXdCQW9pOHJ5MHppc04xemRTL2EvRHBLdlpCTTBvQXFLZTJp?=
 =?utf-8?B?U2loa3dTeDBOdGZmTmNOanRGUVFzYkpmRmZTak9ML01tWDJmeDdwaVN0V2RM?=
 =?utf-8?B?UGNWSkNxNGFTUWNkNVlxL0wwY2Fnekp4dEFNdGJXcTlLQlBDRWZCT3d2VnpI?=
 =?utf-8?B?WWN0YnF6Q2hjZEg5VG9TTmdOTXBnUjdIUkZ3N2JCemNpSk4wMDI2Y2I5VVl3?=
 =?utf-8?B?djZjcXZqS01WdmZiSDR4VXk2SkdmT0F2ZHpIWTV4dVE5Q2xmTDJSSktpY1hx?=
 =?utf-8?B?ZkNjT213RG5pR2x4YVZZd05uYVFIQXIrMmFISkJKUmI1RUt4SFpZNkdrdkFw?=
 =?utf-8?B?UXo2YWgya20yeTBKcGNwdnp0Q2h6aUkreHdxZnFKdU56L0wrWWRVYnBIWExt?=
 =?utf-8?B?ekNpSTlNRldpcmhETlN5MkhBNy9oUzRnNWtyYzBXZHFnUHJUWURYOEk2VTVF?=
 =?utf-8?B?QjAxMUhJVEc1UU16SGc4ODRIS2MzSnBqa3VzakducTY1VVVnQWhCandkZjl0?=
 =?utf-8?B?Y28yazFGVHF4UUg4TFlqT1kwUTN2Q0FRb2FPUk9SYlFmUTVLN3lYaHpFamow?=
 =?utf-8?B?K252TVFtMHlXcHJyMngvMFp5cDZ0WGlYQnVoVzcxZlFGZUUxU2VOWnNkUks0?=
 =?utf-8?B?MkZBNytrK0JjSHdsTlhqV3hKWE5jenBhYlZiMDJvR2tEbWRJMTFIeGJ4TUp0?=
 =?utf-8?B?UDNCYmhRWHJjNkJFa3pXY3BvS0tFc1FXWlV3cmUrV2RSZ3ZweS9XVEN4TGZZ?=
 =?utf-8?B?Q0pUZU5LNEtYMmhaYjdqU2dVZlcyNmZZYWlwWnZjN1BDYitBWDNsT054dk5u?=
 =?utf-8?B?VDhzMkpwWjl0UEhKb1ZpbCtmV1NEeEFUL3dQY3NOTzBsZHFoMDBlR2xucDBx?=
 =?utf-8?B?NGMyMU1ma2J3a1pjL3VxVFhiSDZrcnB1V2c1SUNMSnFDOGNzYlZYTTNzUTBU?=
 =?utf-8?B?UTAwTlhrSGpFRm5UNnZYYXpTSkFlL1hqa090V29nKzVQVjVmNEdqTDlsMnY1?=
 =?utf-8?B?M0E4NGdha0FTMHBLQ0dPRGlrK3JKaU8zaHpoZkwvT3pJZ2pJR3NObm5rYmoz?=
 =?utf-8?B?MTN6UGdQTkNZVHhob2F2M0ZrZUtsY001ZG4zOGJlckpEZEN1ZlBEcTlmeTAy?=
 =?utf-8?B?TjA3b2xvREJtNjZuQzRlZUsrTlZYRDlIa09oSmdSNWt4WmQxRTZBaWxaSy8r?=
 =?utf-8?B?Tllobzluc0YxdG5wNVlrRlJ4YmhscFI3RWtQcEU4QWcxN1ZqalpsZjlOYVUv?=
 =?utf-8?B?TWl1K0VjTmwvTHgwRjFVcG1iNktGN2Z4RXlXSkxTV2UyV1BiOGl5YTNNd1VR?=
 =?utf-8?B?MlVaVGJFQ2JOdy9TUThWQyt4dm4yam1MRllhWlJ6eUFGM2lFL2wwbFJyNU1i?=
 =?utf-8?B?akVTbTdIalFyMkd2WHlZZWpuL1JUQ3hwak91aFlhR1hvNGVEbDczVlh0T1Fj?=
 =?utf-8?B?b2tLbmsrN2M2Rko1Si9NOGxzZm5uWGJ2RjRLc2hoTWN4ZWMxRW1pNTFheTFZ?=
 =?utf-8?B?Ly84MG5PejFaaVFTcXllbzN5UEV2NkN4c2QvQStCRXhWcEtqRHVPR2oxdFhh?=
 =?utf-8?B?cmhRQUhFYjNDVHJmY0dIMVpGU0JrdFlod25LNUQ2SjRwa1JqTVRpem5LQlhD?=
 =?utf-8?B?MHVXV2E1TXBGUElWUVNNWmoxQlB1b2xDamh4K2Z1RGNucmYzd3B4cFdSNDZs?=
 =?utf-8?B?eWRrWUdSa0l4eUhWbGUxL0cxZjN1R2NmYnI1cXR2TWpXMVZYZDBNbndyZzd1?=
 =?utf-8?B?UGJkRllGaHZTQkxXY3lIYndBSmYzYzlKSCtSbWN5VTR0cmV1UlkxUks5MUhZ?=
 =?utf-8?B?R0hkakVzT3ZQMzRJKzNYdFFRRWNWMytQSmJLL2FKQTdFZnFUc2NBbjkrSmRD?=
 =?utf-8?B?NnhnZmg0ai96ZzVmTlJ5YVNqT1QxQzM1T3lLY1pkZm9tcjdUU3NXcFphblA5?=
 =?utf-8?B?aGR6QkczVnU4ZDZhWk5wbGFaNkplL0tpbnlUUlBNUTA1ZitqUXB6OWJpZDJ6?=
 =?utf-8?B?d3BHT1lGcGg4ZVhUMUxhSUlxYnNqc1k3VjQrdERYTDRGZXV3dkViYi9vWjI2?=
 =?utf-8?B?K0ZoVVpPUUI4enc4V0FSZUNweWt1eDJ5cDFmTG1KWDNXYmFYajhkUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955bf654-d46c-4d6c-53b3-08da11c4b980
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 20:43:05.2772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /f+vrT2vw7+b/14/5beK/PAUvTQz//zzvK5FhRqrOvPq/lkt8NRPBEqpKXub12VcubvlPIyWv8gJU4HNeeemvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203290111
X-Proofpoint-GUID: 0jB5aYVfAHXGqlnc8cVQQ54-FDMiZJow
X-Proofpoint-ORIG-GUID: 0jB5aYVfAHXGqlnc8cVQQ54-FDMiZJow
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 07:59, David Hildenbrand wrote:
> On 15.03.22 11:47, David Hildenbrand wrote:
>> In case arch_unmap_one() fails, we already did a swap_duplicate(). let's
>> undo that properly via swap_free().
>>
>> Fixes: ca827d55ebaa ("mm, swap: Add infrastructure for saving page metadata on swap")
>> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/rmap.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 6a1e8c7f6213..f825aeef61ca 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1625,6 +1625,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>   				break;
>>   			}
>>   			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
>> +				swap_free(entry);
>>   				set_pte_at(mm, address, pvmw.pte, pteval);
>>   				ret = false;
>>   				page_vma_mapped_walk_done(&pvmw);
> 
> Hi Khalid,
> 
> I'm a bit confused about the semantics if arch_unmap_one(), I hope you can clarify.
> 
> 
> See patch #11 in this series, were we can fail unmapping after arch_unmap_one() succeeded. E.g.,
> 
> @@ -1623,6 +1634,24 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>   				page_vma_mapped_walk_done(&pvmw);
>   				break;
>   			}
> +			if (anon_exclusive &&
> +			    page_try_share_anon_rmap(subpage)) {
> +				swap_free(entry);
> +				set_pte_at(mm, address, pvmw.pte, pteval);
> +				ret = false;
> +				page_vma_mapped_walk_done(&pvmw);
> +				break;
> +			}
> +			/*
> +			 * Note: We don't remember yet if the page was mapped
> +			 * exclusively in the swap entry, so swapin code has
> +			 * to re-determine that manually and might detect the
> +			 * page as possibly shared, for example, if there are
> +			 * other references on the page or if the page is under
> +			 * writeback. We made sure that there are no GUP pins
> +			 * on the page that would rely on it, so for GUP pins
> +			 * this is fine.
> +			 */
>   			if (list_empty(&mm->mmlist)) {
>   				spin_lock(&mmlist_lock);
>   				if (list_empty(&mm->mmlist))
> 
> 
> For now, I was under the impression that we don't have to undo anything after
> arch_unmap_one() succeeded, because we seem to not do anything for two
> cases below. But looking into arch_unmap_one() and how it allocates stuff I do
> wonder what we would actually want to do here -- I'd assume we'd want to
> trigger the del_tag_store() somehow?

Hi David,

Currently once arch_unmap_one() completes successfully, we are at the point of no return for this pte. It will be 
replaced by swap pte soon thereafter. Patch 11 adds another case where we may return without replacing current pte with 
swap pte. For now could you resolve this by moving the above code block in patch 11 to before the call to 
arch_unmap_one(). That still leaves open the issue having the flexibility of undoing what arch_unmap_one() does for some 
other reason in future. That will require coming up with a properly architected way to do it.

> 
> arch_unmap_one() calls adi_save_tags(), which allocates memory.
> adi_restore_tags()->del_tag_store() reverts that operation and ends up
> freeing memory conditionally; However, it's only
> called from arch_do_swap_page().
> 
> 
> Here is why I have to scratch my head:
> 
> a) arch_do_swap_page() is only called from do_swap_page(). We don't do anything similar
> for mm/swapfile.c:unuse_pte(), aren't we missing something?

My understanding of this code path maybe flawed, so do correct me if this does not sound right. unused_pte() is called 
upon user turning off swap on a device. unused_pte() is called by unused_pte_range() which swaps the page back in from 
swap device before calling unuse_pte(). Once the page is read back in from swap, ultimately access to the va for the 
page will result in call to __handle_mm_fault() which in turn will call handle_pte_fault() to insert a new pte for this 
mapping and handle_pte_fault() will call arch_do_swap_page() which will restore the tags.

> 
> b) try_to_migrate_one() does the arch_unmap_one(), but who will do the
> restore+free after migration succeeded or failed, aren't we missing something?

try_to_migrate_one() replaces the current pte with a migration pte after calling arch_unmap_one(). This causes 
__handle_mm_fault() to be called when a reference to the va covered by migration pte is made. This will in turn finally 
result in a call to arch_do_swap_page() which restores the tags.

> 
> 
> I assume that we won't be properly freeing the tag space in case of a), and won't
> be properly restoring/migrating the tags in case of a) and b).

I think both cases are covered correctly unless I am misunderstand the code.

--
Khalid
