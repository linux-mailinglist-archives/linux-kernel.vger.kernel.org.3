Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CB04CDCE4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241813AbiCDSq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiCDSqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:46:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFC01D3D82;
        Fri,  4 Mar 2022 10:46:03 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224HA66D020777;
        Fri, 4 Mar 2022 18:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sAMJCORI5geVc5vtnx/oGMEglFU5pWIXX/h4NIRy+fE=;
 b=x5yqkPMb038ZATORw3tJx11DRl50MECk1Haw4cG2gnrew3WNnZs/unLiSup1UUMSsOzS
 TzM/gJYl8XKYdmP9XKrkjdg/PHZlueZBEp4UWH+awW+9gWvtb216sZH12hg2ygjDpsSB
 e93WPXhYVDJ6aHvzCjXjvMwJnxcEttRFpHU+y95kGe6XG6xSGqL7UuL7EIt86gZ9NHQx
 VvVyNu6JcoL+WDrEKPfgH1WvJ7fUfD+R2TSu7GQ3ycd+TS+0rAUy3z4xurYitaH/ZZyh
 SkJUjSR2ZvJZTAIGupw2L/riFsSq1PN0uiZpVCK3KmmgUNc45QR9NKuuM50KROssNqu6 uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hw2ky5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 18:45:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 224IZT5n180869;
        Fri, 4 Mar 2022 18:45:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 3ek4jh23w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 18:45:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJ3AbbAMRnyZ3UAE9qelhtHABN0hdpdoKV8YgqR1EoJoCGrWRS8Espr0lxpEZOCvMO/j5O+wgVeHT2wONH01mnTIEeRUXr+aNqsWBQ5h0fBrlKxc2OXzVuwWgRvDjuA3cJxQzPoPcSyXrAJ/nMbctTuK+i0GRQYG49SGtH8XLGhVBds4g70LTPT9rViwfP4OOS9l3hfLcjM4K4ThftOtFWvLJVR3iyFEiQPuISd9PARDCIpfxOtuW1T9LjMUZjZU38O5V7EqM+uef6uKBkcl+PYRM4edKYQ86kvs9AsL4XR/hscLskGu6GcasvGMUcijtBggbQntxNYzL1zBn+ih8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAMJCORI5geVc5vtnx/oGMEglFU5pWIXX/h4NIRy+fE=;
 b=QlxpX5fqiVVz0gR9DdS8qQUtNz4WpXcCQ/+f3eZA3M0DkWQy7Dfesrw8zMEoVQ9PomK10h7kedjCsk9GebQFhSAccBrGUi47Aa8kdT461+htJAQqEGfnChj01dHX4HvYNjIL7Wfq8NyEsQZNV6Vm/nLpZ171bo3k95tmPKdCoNXKvSsUGFsPdhR46glUY5cgpQBT4EIy6oRFXEohCIF49GzGyNf0NH8RgEUkZ4LMUiVuDduxjaT2vYamIC6hoFmCAFtl5+CpyrLW7iGjLi7sz74/EADgBbLiq/X8Ju9rhMsoTC6W6apoEuaE0PDx7ZXkXqts/0Jx/HoV07xoMVnxWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAMJCORI5geVc5vtnx/oGMEglFU5pWIXX/h4NIRy+fE=;
 b=simj07g9/xTtjQRW4gkL5zby8aud8ttDDExrSBepIf8lR4nb29nueiXoig68bmVVD/opUNdoCBiyZroltCZMwq2bUepIt8vpAuGYpQqeQa/R+DUOvXhecLt7jAfnVh2b7MRkqzvJRKUdRWCLJtm3m3musnWObg9VCYmEXsEjGiY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 4 Mar
 2022 18:45:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7%5]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 18:45:47 +0000
Message-ID: <8080cb2f-09e3-30d2-0f60-160bfe5f9803@oracle.com>
Date:   Fri, 4 Mar 2022 10:45:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: madvise: MADV_DONTNEED_LOCKED
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>, dgilbert@redhat.com,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304171912.305060-1-hannes@cmpxchg.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220304171912.305060-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:303:b5::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4613edd-4df9-4fb7-6d12-08d9fe0f3218
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5785:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB57859837CD001746B74F397DE2059@SJ0PR10MB5785.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRvTxeNTZBhg5Gc+J6+EgHMfg1HVei1nDHDA33Fn6Ndr8i+Bbkxa85/p1lK4TEs71oGs5X2v7bThgU/zBeUabVbk7P6wLjPE2Urivu5lSA22+dw1TBJd4ICwfhq7vzoKBflSOpB6Xty14Eyz6xBnzUMhMMRMUZnKp3uhVq/Lr2DWqh+HTXc/2Q1FAfLwfhTrhWI8KD1eNB/s2qgzOY5Pqk0gCloYTmzWOINMefn4n1hLAoCnfX4dEGdwlmT0vyiLT5ELMqMCqwP28XAJHxLG1xaH+uyBj+wmmH7x31yF+snZYcCtIxldNnu4q7d+ihvh4/+rKUv2zPRT/j918JeynMJhKuQKmTotLnc/vITy/Z0ku0KK4dzV2pc6h2s7QLNP6VyCyHP/WxVWwtTyJdS3mjkhMv50DGrzkUx2SUhbKAIevF/uYxnvfu/J+eFlCQ+No9vwm7Mu5bqao6Ha0ff9zJhW6h5koUq8JCDL9vGu9iudsaN49ZyNVbdDIHH/c7xbI+V8nO9eb2054CUqjKYW/nAAKucm4IVWW9gooOdY+7ktBO+HA9hNa06AMQa+4fAsHNdKMZTWHzmYJOPHyhI6VPLk96UmaoFgOI79r83A6mmB8VAezY9PXncuCuckL/iylmi5WBwxnh4KnHnyXrWvkHO70AKvItJAjk+frzfpuzTgYr5x+1p0pbNX6Js9Oe+jeYbkTvAc4vfdZT8bnpqGLT0VIl1TqgV0vrVBffX2tmGrlAhGM3ztgr+nYrqhj1SCdkt/HzOFi6fJTTZA0LsbLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(8936002)(31696002)(44832011)(508600001)(66946007)(6486002)(2616005)(66556008)(66476007)(5660300002)(4326008)(86362001)(8676002)(36756003)(83380400001)(2906002)(26005)(186003)(6666004)(6512007)(6506007)(53546011)(52116002)(38350700002)(38100700002)(110136005)(316002)(31686004)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVhSUxoZlF2K05TeGVHeTFDay8yc2NvaGF6V3Jvb29rWEQ2SjhOUEh1RGJL?=
 =?utf-8?B?dE9JWGMyREt5Ym16L1B2NTBETTdYNjZ4MjhtRVZNNlFzcXdGek1tZ041eDVs?=
 =?utf-8?B?MVE4M1FDbS9zbnlTU0U3ZVdEbjJ1TURhN2ZQb3M4a3NnUVAvSno2alZNbUto?=
 =?utf-8?B?MUxybEpoMjQ0MFVPbFhGUXpZaC8vQ0RsWW5nM3FZK2c2cFJvSlgwVUszdklR?=
 =?utf-8?B?M2V2bHdVU1FjTWg2dWpoUCs3RmdGVzMwYU5HeXlXQUdHRG9QYU1ZTFVQY04v?=
 =?utf-8?B?QzRvRUZoQVUzZnViREJ4OTNhNVZrKzZ1S1FlYVhDeG9LS3dVa0hkYTRFemxj?=
 =?utf-8?B?ZldiSHhsVUg4UkU0MWdHbXdTRXdlampma1hXbURMOUcwUDZIdlJVVUpvMWJH?=
 =?utf-8?B?VUxQVjJGbVBNSUpocjlQdUlqcDNmeEJUVHJjRkplRWQ2YzF2N1Bzem80UDFr?=
 =?utf-8?B?V2ZBYTlYdlFFTmlvY2NyMWovQU9aZWsrYXRZTFE4dXgvSlh1ZktidE1rVllw?=
 =?utf-8?B?VU12ZXdOVzVHNWtUaldWUUZqTUNmUFd2aURuai9ZTzVJQXFFZ1pyWFNuRjJR?=
 =?utf-8?B?YjJzUVRldVhSYzVjaXhBcENHQW8zZU9lVVhrZU5vQUh3MGcwT2hnS3VuVWJI?=
 =?utf-8?B?Qnp5TjFNRCsyc28yUUZjWWFsd0NaSi9XNE9UcjA2MXhjTnBqdHNTWStrOWRW?=
 =?utf-8?B?ZDlvTC9xU0VaVUZyZmQ2YVJRSGh2eGVGSThTUmlUNjJnQ2h1V2x5dUZiVWdp?=
 =?utf-8?B?T3ZYWGQrbC90aEc4SEs0ZDJieXFheDhhcUpjL0hibXhuR0lWc1F6UHVNV0Fr?=
 =?utf-8?B?dHhDY3UxMGNmOHRNNzlwMXU1Qit0RzFMOFpIWCswcmJXeXhkYTBOUGNhSnh4?=
 =?utf-8?B?S2pFbm5malRFT2hzTVBSVHl4SXdyZ0I4QmxXWVNPdlk4ZGdBVzFvL0xvdldm?=
 =?utf-8?B?ZGVzMHVmR1RGdE5Lek5pbml1aXhlMEh5eDRqQmR0bTRhL2VyZnFWQmdnbHdU?=
 =?utf-8?B?ZkNSQVBocE9KTjc5N0dMWEhlejJTa1FwVkRUc05odDZIT1dxeWJwQUIxeDZl?=
 =?utf-8?B?RGVNMlF4UWRGMTVyTE1LYU5PWnhUWWJvU2pTaVArQWl2ajdObjAzOUc2K1Fw?=
 =?utf-8?B?eFA1elpHWGxJc1R1QTIydytOVjFtZHZjeEkrQWd6VVNZU0lqSENaUUd5STJM?=
 =?utf-8?B?OFEwQ3VqU3p2V3NxVVpwaEhUZmU0VEhtU2VuSjNTMnVVYVYra1RPZ1NwSDJU?=
 =?utf-8?B?NmN5WUFjZGd0dGF1dHJuVnBXTU9STUtSZ09ENFZibkExUUxwb1pYV1dqWE9I?=
 =?utf-8?B?cTZQMGRSUTdzMHpIZnBCL2luUVVWWG1PTlExT3N2WFl0MmxVV2M3S1pmajkw?=
 =?utf-8?B?eWxsemI1WlpjK2lua1hzSzB3N1Z1eERMV0tlQzE0Y1F2b2V3L0FuOENkWnZh?=
 =?utf-8?B?R2ZoMW1VOUx5R0M3eTJGZjFGRlhSdk1LdEdiUy9Wb28vWWI4VjdXRmg5U1hJ?=
 =?utf-8?B?ajgzd0Z1WHhEVWpYcDJUb1hOZStrRHhVZGZvWkkvd0wzbWJsbVdvS1BmWXht?=
 =?utf-8?B?T0xDODZWSFBpNE9weGNzUDF5TzFrUEFSZ1RlUThvRy80NFlrWmQwZWdmOVlP?=
 =?utf-8?B?a2NDWUZ1NDAvSklPWmJ1REF1cWhsRXdPV1grUXYvQjNuU2RJMnNKT1p2ZEpn?=
 =?utf-8?B?OGJIeEgrelhwTlNLalVKSTBzeW44RkNXTjRsWVBLU2tZUitpOGVCQXhsSDB1?=
 =?utf-8?B?TGcyYnBRenZWTHVFbDlNWjNwZ1puNEdBWjZpTEkvaUdCUXhiN2pWZDNRTndj?=
 =?utf-8?B?bmZxZWJ0Z3RUdUJqTWNzc21jS1lJQ01TMFU0U0oxaTFVOFZ0Qi9mZjJYVGt2?=
 =?utf-8?B?WnBoV2NpcGt0bUd3eWZXd2JaNlp4OXVhSVYraFpFWkhkb082R2lxSUFBQzJB?=
 =?utf-8?B?VXhyS2dhUFJpaHNqdHVhNlFWVzIrRDZKajZqYTFTOVRFcE14VmtmSWhSSkRi?=
 =?utf-8?B?OTN4L0RnVGxsdlh4Q0FKM0swYTdrSTA4ajl2ZzV5VUFXR0c5OC9SaDRqNFhr?=
 =?utf-8?B?RmhydjNLbk5ETUR1T20yUlBFdDU5Z01aS05TbWJWeEx3cGtRWTFUTWZ3OFJR?=
 =?utf-8?B?WGpSSXBIRVpQcWdCaHRWNUxCN081MG90TXV2eTg3UXdmSDRUdFh6VWlvb2Rm?=
 =?utf-8?Q?eaX8wydXZHQCwCjcupv90ps=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4613edd-4df9-4fb7-6d12-08d9fe0f3218
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 18:45:47.1186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnJco1qS2WndsyJviI7RBAjUU68v9C0/oOhXbkaItPSlo0esF+OZv/ULM8XLbRX4Me6nfzXXHu42A6S9i0Qb4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10276 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040093
X-Proofpoint-ORIG-GUID: K3KuPFvz26Zw9Mqm8TuzSADS57HSW0aM
X-Proofpoint-GUID: K3KuPFvz26Zw9Mqm8TuzSADS57HSW0aM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 09:19, Johannes Weiner wrote:
> MADV_DONTNEED historically rejects mlocked ranges, but with
> MLOCK_ONFAULT and MCL_ONFAULT allowing to mlock without populating,
> there are valid use cases for depopulating locked ranges as well.
> 
> Users mlock memory to protect secrets. There are allocators for secure
> buffers that want in-use memory generally mlocked, but cleared and
> invalidated memory to give up the physical pages. This could be done
> with explicit munlock -> mlock calls on free -> alloc of course, but
> that adds two unnecessary syscalls, heavy mmap_sem write locks, vma
> splits and re-merges - only to get rid of the backing pages.
> 
> Users also mlockall(MCL_ONFAULT) to suppress sustained paging, but are
> okay with on-demand initial population. It seems valid to selectively
> free some memory during the lifetime of such a process, without having
> to mess with its overall policy.
> 
> Why add a separate flag? Isn't this a pretty niche usecase?
> 
> - MADV_DONTNEED has been bailing on locked vmas forever. It's at least
>   conceivable that someone, somewhere is relying on mlock to protect
>   data from perhaps broader invalidation calls. Changing this behavior
>   now could lead to quiet data corruption.
> 
> - It also clarifies expectations around MADV_FREE and maybe
>   MADV_REMOVE. It avoids the situation where one quietly behaves
>   different than the others. MADV_FREE_LOCKED can be added later.
> 
> - The combination of mlock() and madvise() in the first place is
>   probably niche. But where it happens, I'd say that dropping pages
>   from a locked region once they don't contain secrets or won't page
>   anymore is much saner than relying on mlock to protect memory from
>   speculative or errant invalidation calls. It's just that we can't
>   change the default behavior because of the two previous points.
> 
> Given that, an explicit new flag seems to make the most sense.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/uapi/asm-generic/mman-common.h |  2 ++
>  mm/madvise.c                           | 24 ++++++++++++++----------
>  2 files changed, 16 insertions(+), 10 deletions(-)
> 
> v2:
> - mmap_sem for read is enough for DONTNEED_LOCKED, thanks Nadav
> - rebased on top of Mike's hugetlb DONTNEED patch in -mm

Thanks for rebasing on top of recent changes.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Looks like we both will be making madvise man page changes soon.
-- 
Mike Kravetz
