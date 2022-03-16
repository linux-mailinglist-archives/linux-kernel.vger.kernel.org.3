Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CFB4DBAC5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiCPWxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 18:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiCPWxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:53:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754161D31F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:51:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GLEWLK006894;
        Wed, 16 Mar 2022 22:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JrvY/4QO9FBtfgv7Iz4MY/uBYn0qsrygm7n/02oAFKE=;
 b=gVxwAuRlcKS5U7Y3pimaBlR8XHROBWbeDff4FEc8vMxTzX0z5A71VOqSnGBrBjAbvEIE
 1x8M46SQmDuywlXNUtNfDgJdN9Wjy6cHFBl6wvT6hxbIQjyZJYmrJkLH8RPgHvF/GKWc
 BULNIvAhAzIRkrtB/HV0BkXV8+mMrqLUPwQW5LxdpmSxnyjO0OHM8EM8YPOJB0xZ8wXi
 ewMgqW9mfYR1c57zddLk9WURwDbUjzYQHg/+iCVuczyh75I2w/+ysviBG0utg8fiOzbp
 bEBfY5HCxUr99blBUJXyudloSglO0A9Gf4ePvLqBtV0i/bgb4DyF7rf2L90nhxXVoQNg aQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et52pyrgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 22:51:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GMpdA0077703;
        Wed, 16 Mar 2022 22:51:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3030.oracle.com with ESMTP id 3et65q1544-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 22:51:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLUweDTGp4YP4XTGEvARoBg46Kdpxw+K8eNwl/PEZsPnkPZ90Vp3I9c3Woi9h6Xa4cvYowHNRs/LYoMyxPbKgkjNpbZ4RWwjrjEztixjq9E2qtFbn7WSPPyUb63fuzIp6kkvongV9ofP25eKUUkd6XQH2UYczK/5auHMwY5Rume9goEu1x2oEPduaOQKHdELnE9qVlUpQ+2oJyVpGEcDo5g4/V3SGS4RSO5DXZjGpIETrcDkKH9zYIwXildQRqtZui0/Qu6b3pRfPmscNzheVyMRY0Fj+djBnJCXl3Os69YD24bES0eR1FfMK3z25PXYxP5l/Qny9HWwNhhzmRn5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrvY/4QO9FBtfgv7Iz4MY/uBYn0qsrygm7n/02oAFKE=;
 b=RaXKp4/IqhPv/TQs+3zHLAmJkHD2UvhwVe5alrcRQwTei6h1+P5k+BH/5FQIX9xYEZ8lnAMhSeM7D/nSsegt/H6C1zNV4u5HxhfdTjr+8Kg2pc05pvcnhU9MUvDRLiI8LyTJEsrdjED2KAM7wOOvVk9NiD8AZpyGiNxHXJlV0JcColqwYGh+rLExx86LMbWsmArPnxGrC+HooCD+yAQgJuNNHbR5GsrNmM9GWyfLXs3IW8PO3qMcu8CLfw8DHbGbPNWUKsBL4oMkWbgEraGmkvT0GegyudvQY7gVjx/DKXqYNQ9/mOjht9+o+ZlAiHvbp18i13fHBs6kHl4oz8mUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrvY/4QO9FBtfgv7Iz4MY/uBYn0qsrygm7n/02oAFKE=;
 b=eVJm5T2/7j5vgnWs0mBMz0hB6z0TdcNwWjuG60Uk1vMg6Z1Ym154uwmFKl3htBvOJCvdaoxtoJk7cG+ZryMGMWAfl9c0xb+D6t774BkyedSFupFAc8U9SptMSd0yun6yg5J3zLcEULL964pdL7ICJ/YUrZFghTe1GijMUr7NLXA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5817.namprd10.prod.outlook.com (2603:10b6:510:12a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Wed, 16 Mar
 2022 22:51:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7%6]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 22:51:38 +0000
Message-ID: <7362f9ee-81fa-702a-7a03-1a91ecf0b58e@oracle.com>
Date:   Wed, 16 Mar 2022 15:51:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20220316120701.394061-1-naoya.horiguchi@linux.dev>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220316120701.394061-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:300:13d::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7067472-6f91-4bf0-497a-08da079f8759
X-MS-TrafficTypeDiagnostic: PH0PR10MB5817:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5817B75B57F172622CA5A95CE2119@PH0PR10MB5817.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGvdvjRFm7wBmUO/+rgDJzWO1lI11UhVAeLwCLqLhMY7SlOPrlcYBLcrEtRDHOfndkJ47IAprgJGiuO7gMpin+AKKuLIH2AV1uoLfP5FyjO3Aj3w9D+ULxW8lFvaTJ3TiQGWgdxv7O9hv7/JUXjy/7nZh2GzR6EvSYEGyt9LJcrjlomb0Q+TVMR5flElyIDOYCH64aaz9reAXh5/fDoAKS1Ubd7+tvNuwT3IbnIh+I++DRBmZHdnkuMX6bllXRh0TtXm9lKS10K+9RmckJYTymLiPkjKJW/jMeB+w8KsBaBRZwiIZFZXTpfCWYxX044lMGEujC7LjZif1cr7mF3kepx0x5F1apftsZV2c4trfgnWPHwI7fnjmXQLWiPLlxynaDm8c8NVDI81nv/8kEcRh+of9R+at+3aY/BnAfpt6vilDX8KFib0N0yEy5WR/ngrGnVEem3h4hnc+5Yg/eqXTE7Z/8yTgzrHQsxu9kn4Zry3YJiLonWbWNN2mqQJVBhZJ+gHMTPGY2c64/FfRcad+LjGWOkl1ErnaV3h80cdDTaSri0SM9B2l0r7j5C/idhIphXFV4bMpZiVckmn7rvVP/q+wq+3HQYYoOkrPxeKbfQfjKNTtP/XQbHWWctGgsPyhOPP1wOBQ+8/U0qO/I9elyp3DG2jlq5HkgGpWybhv/2JHydn39FFRdhH/+VDVtzzYJQOI/EGrsYHHBqcWOzqWGOHyDZtjebVANgYAERiE416DXV60bkNOT26Gs42g4v69n94fzH7H0GYo5INL5hUKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(2906002)(31696002)(38100700002)(508600001)(6486002)(86362001)(44832011)(8936002)(54906003)(316002)(5660300002)(66556008)(66946007)(8676002)(66476007)(83380400001)(4326008)(31686004)(36756003)(6512007)(52116002)(6666004)(53546011)(6506007)(2616005)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGxJem5ocmY2VGpsVnZuTnhySzhEWDBLL2EwUEQyMGJKYVVRZFFJLzM1dnY4?=
 =?utf-8?B?MVA5eEdCVEpBc0EveUNZaXN5MlZ6eXEvdWpWam0xc1djZ2R2VzMyVDMxYmhB?=
 =?utf-8?B?a0l1TnVyaUtyYVQ1aXRLRnhNeDJiVVFkQzd5MWp4RVN0RVFCRGpGakh2ZVlw?=
 =?utf-8?B?U0NucFNRMWtmaC81S2NoUnFTRmpZeStIV1ZTQ0V3dGliQk5tbVBVOUJaL0Z6?=
 =?utf-8?B?cWVHUS9QeVoyRmd6Zm80by9UWSs0YUZ0SDFESGhjbUY3WCtLVXE1QklpRGFi?=
 =?utf-8?B?cDVTemMrdU9ZQnFwUjNtandvR0VqWmI5QjJzVktzbjY4U3hPUzhDRDNYVTQ3?=
 =?utf-8?B?bTdBZ3lSOVpuZ0tod3NMTGY5UzVTcU5wMWtuUlpYVGFmdmwzNHI5L3R2RGdj?=
 =?utf-8?B?VXlES3FUcnJzcktBNXVtYVM4ckFQdzlWdWVELzBCZURDYUNhbXlYUUZoanJt?=
 =?utf-8?B?VENLa0pabUFnczZiOGZ4QmF1cDcxZm10VGNVNHV6Q0NlaWtSMm1qc1dwRkVi?=
 =?utf-8?B?dlRwTlZST3lWWUNjcGF3dFA2Q0Q1dWMyWEt5MFJLamFESjBjQTJoNzB6Z2FN?=
 =?utf-8?B?TnFmZEtLMjBSa2ZOdDFaRzRka1lyWlRFT0RSUllZYWFlV2t6REptMnlxWDFi?=
 =?utf-8?B?TkVjS1VMT3BGS3p5dUlON1F3TCtGRFdpSDNuZDhpdHpzMWRUNlNzbWNlRGh1?=
 =?utf-8?B?RlRuZldzREdldmE1Vm9EcGlCazdZaTNZaVE5akFDS0JIdzhNSFZsMm0wWDdr?=
 =?utf-8?B?bkpBeEt1NmRLSVlKaStkZXZqWDI5SWhteVozMzY3VDU1Rkl1aXIyQ0FObGFm?=
 =?utf-8?B?RjlFeXU0M05PVzNnRVJka1o1SDdobjB1a0JhK2txMmZVZDRtN0JHeC9MYU01?=
 =?utf-8?B?SllUSmxNUExVY2VwQzVSU2czMVF2QitMOTEvMlpBTjJUOWpGMG1aVzBiSlcz?=
 =?utf-8?B?dnNneno3QWMrSHZqZnVlSEp5M2sxdU40R3ZqZWNDcDBpU01wdjFtbEI4NWI5?=
 =?utf-8?B?eklEWGFwRGNUQTkyRXdlVi9uMEtqSXJIMkVIaEhFcEh0V1pOOHZQTUJrN0xk?=
 =?utf-8?B?eStaMzU3a1JWYWRTWTNOYnF4LzlCYVdzSE0xN3RZMHVpMzhMVGNDZE1xM3dB?=
 =?utf-8?B?TFIzdHdDTXdxeFFITUJOSkdjUktyYkhrcWxlS1pSclZSTjMyWEpXZnRlK1Nn?=
 =?utf-8?B?c21GU1IyWFk2blJ5Yjl6YnZTK0JNSVlkTzZVODQ2UHI1UEd1RW93ZHN2K0lN?=
 =?utf-8?B?M2Z4UC9nb1Y1REVYOW0wNzF1VnZOOWpIY0FITEJwblBZOG1TZmRmMnpCR1Zt?=
 =?utf-8?B?N1M0K2EvYmNEUUpxRXBlU0E4ckF1czlYQlNrRFFkTDAwWFNsakRSUld4bVpR?=
 =?utf-8?B?WDJIR0dnZmk4dVNSVy9vdmFUbk8rYVVlTlAraExLRGg0RFdZQjc1RVV0Y0Nr?=
 =?utf-8?B?SVNaRVRTUXZVQWNWV1RTSE1TQXZVK1BoMG51SEp2cUdJZUorcU9kUW9GaDdl?=
 =?utf-8?B?ckpFNGdaY3NqOGFwb0JhbmxMbU5zcUFjckd2djdDY29VVUtIdXFzaWdxVHQw?=
 =?utf-8?B?MHkvRDU1OVNxVXEwYThvcmZ3bUZMUHJ0cHVUcWpUam5tOGNCOC9VZkV4SzNP?=
 =?utf-8?B?TVBZeS9lRzNnVlRzcllWNkkwczNoNFZmNC9QUGlkMDg5dllSVnZLa0l1WDVq?=
 =?utf-8?B?a1lsRGRWV2F6NDR6NkhiTzNJR1NYVEZ1dkZZWjJrb0JmR2xudzRsbkpOTTRl?=
 =?utf-8?B?TWczSU5UMFlmWWlTNWw3S3hzRDRSNWl3RXZraTFRc2hGM3NtN1VXR2hNODI2?=
 =?utf-8?B?REpjajlJbXVtM1plT1prZTJXNUFGSGZlSTVqWlNkR3lsbHZDVzlzRy9lNmg2?=
 =?utf-8?B?aWFDRnB0SU9xMWJUSk9USW83b21JUjBNS2I4K2FTWFpacm9xWVFudDhiQ3Vx?=
 =?utf-8?B?VXFDa1Y2T2VlNytwRjJvdnRic1ZzeUdSdWVqMFFlRlM2NTZlMFk5WDJEaXd3?=
 =?utf-8?B?TFFjWk9sbGZnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7067472-6f91-4bf0-497a-08da079f8759
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 22:51:37.9878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUXLBkTFUVA5HXkmdQXDiZxZebLXuFGcdrRkyqXkUDlpdzO0Cm2keSnlPnpREw3TQlepBVg1lj/oXSYGbPGsmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5817
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160137
X-Proofpoint-GUID: CvQSALMwa8vbJ4syoOYyqjmlHdjulEiy
X-Proofpoint-ORIG-GUID: CvQSALMwa8vbJ4syoOYyqjmlHdjulEiy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 05:07, Naoya Horiguchi wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> There is a race condition between memory_failure_hugetlb() and hugetlb
> free/demotion, which causes setting PageHWPoison flag on the wrong page.
> The one simple result is that wrong processes can be killed, but another
> (more serious) one is that the actual error is left unhandled, so no one
> prevents later access to it, and that might lead to more serious results
> like consuming corrupted data.
> 
> Think about the below race window:
> 
>   CPU 1                                   CPU 2
>   memory_failure_hugetlb
>   struct page *head = compound_head(p);
>                                           hugetlb page might be freed to
>                                           buddy, or even changed to another
>                                           compound page.
> 
>   get_hwpoison_page -- page is not what we want now...
> 
> The compound_head is called outside hugetlb_lock, so the head is not
> reliable.
> 
> So set PageHWPoison flag after passing prechecks. And to detect
> potential violation, this patch also introduces a new action type
> MF_MSG_DIFFERENT_PAGE_SIZE.

Thanks for squashing these patches.

In my testing, there is a change in behavior that may not be intended.

My test strategy is:
- allocate two hugetlb pages
- create a mapping which reserves those two pages, but does not fault them in
  - as a result, the pages are on the free list but can not be freed
- inject error on a subpage of one of the huge pages
  - echo 0xYYY > /sys/kernel/debug/hwpoison/corrupt-pfn
- memory error code will call dissolve_free_huge_page
  - dissolve_free_huge_page returns -EBUSY because
    h->free_huge_pages - h->resv_huge_pages == 0
- We never end up setting Poison on the page with error or head page
- Huge page sitting on free list with error in subpage and not marked
- huge page with error could be given to an application or returned to buddy

Prior to this change, Poison would be set on the head page

I do not think this was an intended change in behavior.  But, perhaps it is
all we can do in this case?  Sorry for not being able to look more closely
at the code right now.   
-- 
Mike Kravetz
