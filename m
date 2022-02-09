Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40F44AFFF7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiBIWOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:14:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiBIWOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:14:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD99BE00FA61
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:14:47 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HBlMv008856;
        Wed, 9 Feb 2022 18:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2wEZGqccgO46V5UuIaQxxSYUIrbHGm7xRYNusUCLIN0=;
 b=rGXb7dY7maGD2mxpUInzSJ5B9mTdT1Buuqzh+JmSjDVEXlfMM5NliaDm4hO4dIgdVFyQ
 qCavJaxlE7NHakGZEE/PNzZemJ9ZKme5AzvW4Hd1jixFiaDHh5mey97gns6YzIiR1ATl
 oMObJcSOQcuXqlbxvbB7pZWUdDnofFZslZxiMQmduToEPt7GYvmMkl39xS9dcMCWBnTV
 ckXMxJHKWHxkcnJm9NZpvi0ILplcUlhvy/3Kt3F+4ebuEIaTBH+jmfhbgb/c+9kJhKs/
 dGAIFVquqbzc7siJ3Jx+Wz+7bsu6G2VOcAfnqDBkUqzKEB1wfrFSoqw29WAHd+E6AUAC Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgnp9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 18:59:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219IwO5G174656;
        Wed, 9 Feb 2022 18:59:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3020.oracle.com with ESMTP id 3e1jptk33v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 18:59:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKFNDPwaRMLL+jxfJwxScjDXg6QMoC2rhM99tDH4Z+opsVm8IGQgge0N53hAm98xZ5MU5gZlfJKFxpzDw6g+wg3QokPrTcamc+Tuin0TabarB+HSelsw8NKW33sQJI5SGsCNsWrtCy0Y1K2d67LgLRJeSRn8NmByPHvRaPfh+zZyvq7u32qsWgEQFy3zkAvU07JPdrp04lCofBbdLLKrd4/m3yAQZ4InSSX3A3VYWJt+m5NVf18NkwPPu47ULJd641MzIY4dj1/KQrDb8baqmpOQrJMKveEuGOEDuURJ4CzcszZCCBdBvI2E9m91fr4zqQYWOgXfDe4STUwm/HHF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wEZGqccgO46V5UuIaQxxSYUIrbHGm7xRYNusUCLIN0=;
 b=JAM6f2sltBCFG+1y2rIhqtMvhSSJHr7Jsw7gfwuoo9wleSDfiJWv3BhcjNJT/3lbv8WG8eNe+iuRCCiGrFRrXCO7lvu1+i4b7Tyzb8VVa4hkukSXSpKEGGYvLOtJG1bH2s1k7ccBZ2Wu4x5mU0BNbMJTsXq2jv43nEZl4T1P0PjLxhvke+jMhfdqH7JB8uSCYHCdok4mbm6IFslJmqKTGjvbQiRvIagFhGtWh7vMr0fwhCA4FUJpgE/dGjlkyfrA7t7loYOckZ5Bx0vrgru5NSV2LLPpdUzojG5ECu+X08cvZjYYwwvtIyz7zMzt+i0UICVA71u7LbaKDBwL7Iekmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wEZGqccgO46V5UuIaQxxSYUIrbHGm7xRYNusUCLIN0=;
 b=q+mw+onAFYwSCafO0spCuyg7I5yIChwRv5q843O+HVryjkmQb0Brju2LKWvX8tkZwU1hxB6gkHd/npnUxrSV42ZdzUSsNUf0VlBN4oHheoio8HWAX2deAMVW5LMzyf1EPOSp0POm4EzVs+8TtFVpGmF/vM0mb9rWJK+XhzZljFc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2885.namprd10.prod.outlook.com (2603:10b6:a03:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 18:59:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4951.021; Wed, 9 Feb 2022
 18:59:23 +0000
Message-ID: <cf985291-36a9-e60e-f1e1-f12719c7b3fb@oracle.com>
Date:   Wed, 9 Feb 2022 10:59:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 4/5] mm: hugetlb: fix missing cache flush in
 hugetlb_mcopy_atomic_pte()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        zi.yan@cs.rutgers.edu, kirill.shutemov@linux.intel.com,
        rientjes@google.com, lars.persson@axis.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
References: <20220208073617.70342-1-songmuchun@bytedance.com>
 <20220208073617.70342-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220208073617.70342-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0106.namprd15.prod.outlook.com
 (2603:10b6:101:21::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d40aaa40-6b74-4277-8a9f-08d9ebfe4941
X-MS-TrafficTypeDiagnostic: BYAPR10MB2885:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2885899F02B81A157C87F598E22E9@BYAPR10MB2885.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhTDrFok67JqXZcKel6YsPZTkVcPmMpzkUv4RynF77ZrTyzYLTtPQVUTVIOp+isfiQ2AR3qW0B002qGrJ4Xkj1nMIGXCf8snPAsYUDMsuXr7sW3UVn83mX+ERE5iHyuKhnqAl2yIW10pzyhplCU/CkizUgt5HOvACTzBaXPf959lLMdHdmBUhOZlUdzm9Oc41WVDZOlGSP6Rlu6nhPjoztwdXbYfGjhk2pYNZAdttxJeSi4f0KSkS0FMaayzy34bbIHfAn4nadsiauA+onsNhr7pbJJE+tpY9FbAFx5pFJv6Q0igKq0KGRZCmmmrKmFLyQlBiZp0okRJW9O83pgwSZvc5Mr0eldTnBh4nJwYjpdjPsk3WEQyTP4/QxVtL0Ii8BgMZyDqIrdFrzoKv2iu5gFIEcqapolCSgwdG4eMlLaDw08yujQgGP4I3xy2bSx4DAn4ra9iEHwyhFvCgGSIJY56t0ghdC4b2Mg9KxUBr3wjeR3g8Ly6KF07LoAwihs30pkV5WAF4mrInqu8EnRp3HqiKTtJUpStU+M1B1P0qJqFWmYTQxdpbmZj4Xj3eqANeIQgonL1vyG2UAoD3uVR6N+Z2PqbOcjzMiYNotZuvSqYvqdJuoUNPNb4IVTyWQQWR9umI6xCcdvWsH4Eyd7xJcdJq2ETGzXV04JU1oGLlUTAG2IuNpIxwuN5jyc26+huZchSgglSwGRxISyMXQDnWErLnJeIzomVBM/J+KU83dkdgQUqjg8JBVsYoOXJouzeF5219rAPNJO0hfopvojqLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(7416002)(4326008)(6486002)(66946007)(8936002)(86362001)(31696002)(83380400001)(316002)(8676002)(66556008)(4744005)(508600001)(5660300002)(66476007)(186003)(53546011)(26005)(38100700002)(31686004)(36756003)(38350700002)(2616005)(52116002)(6506007)(2906002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnJhSFpDN2pHMGhhYXVSNEpDbDh5NUFmUFdKM2R1Ty9ZWlUyZ2RicktBaUdr?=
 =?utf-8?B?bTdGUTRuRk1hYmpTMGRTWHp3alVkTlhxWjNORlNJTDZQZkloanJmWERrUVZn?=
 =?utf-8?B?RnRlR1lxdUdxUDFwek8xd3hiazMwTTgzNEQyNkIvTUtmM09YOTY3cGs5bVZj?=
 =?utf-8?B?bi8yVnBtbXA1T1p4aitLTzcvWE1YLzFvZWdrVWxTYStCT3lFclhZVy9uZXR6?=
 =?utf-8?B?am5QdHhUZWk3bFdoZXNsYUZ5TDJpcXkwOVlTRjN4UnM1bnk5TEVTMlYxcjRP?=
 =?utf-8?B?OHNKNm11NDBJZ3k3M2ZXd0Y3SmlZSU0wbnVjWUN3RUxQZk91LytYODJnejUy?=
 =?utf-8?B?TU9YSG9JQmtLZmtsY3daOUQ1WjBFTllYL3BGekRpSUx2NEFFOVM4VkwzcDRu?=
 =?utf-8?B?dVVvQ1grN25jOGdxSkZ2ZlRxVkt6bDJOZ0ZOUjc3cmJjQ1BhR1RSdE44WWp4?=
 =?utf-8?B?T05jdk1Uck1pa1F6OHlvaGIra1VXL0EzRkxtZWJheTVjWnlPdTYyR1R5VTli?=
 =?utf-8?B?dlUzTWxlWEJUQXppbnVqNmdSSzM4S01PZFY0L2N6TTcrQlBOcGx1TnUvWU1P?=
 =?utf-8?B?OGZRVzNIVjhONHV0N2hWMnpGZWh2UUZDamZHUWR6bGFJbGptT1VhcTJmNDRk?=
 =?utf-8?B?VFIxOHpCY0ZwTFY1dHlYNVBOZ1V5bldsL05hT2prTFNCZUJJSWpoRm9CRWV0?=
 =?utf-8?B?UUI5MDFsLzBQNTFOREN0RzRtb1hsOEZtdGRvZFZkaTBKZGZaQ3liV01adTNQ?=
 =?utf-8?B?T1FzenAzclo0OWN3ZlQ2MEJ0V1JVcW1tbmgzeXdVWHNBdFhXU2swSkErTmdx?=
 =?utf-8?B?bWtTeVlDUkhUOUI2dG1YU3JLQ0xLZk9kWjFjc0xYZ2ZIVUxRWDlzb1ZPcXYv?=
 =?utf-8?B?NXhBUVM3MEFmM3Zoek9QUlprc1Fabnd2S1NhNThaRCt0VHB4R3NzUWFXaVlO?=
 =?utf-8?B?VXpJVXNWMXJWV3ZHOFNOeHBvZTdVaE0wSUp2WmZoOUhSa0dKemExd2loSTEr?=
 =?utf-8?B?NWovU3FxK29yYk01aXRwcTRDR3h4VTV1a3dLM05uQjFaUnlQSlJQaXU0Z0lQ?=
 =?utf-8?B?MFc5QXlxNlhNaHB3cGlGZjNUMWtLT2szUERZM3Qrc0hRUHZjbll2bVNhYzRG?=
 =?utf-8?B?bjMrdGx0WGZXejV6bmliQi9iMS81TWhNUzZwc2h4YkdkVXNvNVVuRUNRcUtG?=
 =?utf-8?B?UElnU0ROWUpJY1RidWw3V0dFRDVuQ01pa2E2bVBoSmRERXpBR29iY0hORXRu?=
 =?utf-8?B?akdpT0p0anpSRkQzS084c0d5QWlVaTI4YlM0TXg5ek5pTHdGQlJ6ZTdaQ1hZ?=
 =?utf-8?B?MTByZ0RsYVA0QzNRbWU4NjUxY0JYdlJOYXVpdXN6VTFENnBUQkZnSFFEQUdB?=
 =?utf-8?B?Z0FlaUxZc2J6TGVLWkNOWnkrK2NTV3pLamRyRWxVY2NhK1RvczVLbWNMMWZn?=
 =?utf-8?B?THNyVUFiaDFMVHhDNkM3bHp3a3BPWC9nazNUc2NZNktmSitQVVNpS0QwK2hE?=
 =?utf-8?B?RG41WGJycWVoQ0F5dmpSeG82eHVXeTJZYjZ4WktRNEdWamJBMkt2NnFEQkwv?=
 =?utf-8?B?OEZteXZXYXZERkZtRUVId1ZFR2tGcnlQWmlleHEvVG5aRlQ1RFQzL1ZKZkRz?=
 =?utf-8?B?NWUva01UR3J2U0VLT2NidHdDVVZkTXlnYlpNUWhQYkpMQ0ZaeHFYUUZjQkN2?=
 =?utf-8?B?WGRSU3dleDNkalNMK29iR0V6eFh4MmFucm1DZ3dsVXMvR00vaVhPVWM5SmxY?=
 =?utf-8?B?amFtQ2dhOHYrZmZCTWJnTDNLZlFwKzlGRVFtS2lWSWU4UitkUVhIcmM4bTNy?=
 =?utf-8?B?MXNFclllR1NtVE93QVcyU1A1dGdWa2l6cFBnb0YyVWZEU2xSZEtOejNLTUwx?=
 =?utf-8?B?Qno4cWZ5c1BxWGVzak1Oa3hYZFVPMW9FSFZ3VlpxWC9BOXFPb2lkeWoyeG1P?=
 =?utf-8?B?L1JITlkxYWlSUUZoUExpZVVRdXhkRy9WbTRVR3NtRTVUNlZYNUk3SGZ4ZGln?=
 =?utf-8?B?QVVWM2N5ajJMS3k4ZytGc3FLODgyQ1RGamJORHNVTnphcGZIWHNrK3E1ZEFJ?=
 =?utf-8?B?eG1TUjkxQ2lscVBqZ0dTa2ErRUlQVWpuOW1NcDFpNjRkL01IUXlXWjVtL1FK?=
 =?utf-8?B?ODhJNUhPdFpjWm9peDd2amJUVk4zSWREeWFwTm1jcW82eDUvMFdsMDh3UExI?=
 =?utf-8?Q?FJYDb7nY0eVqvMtg/OOIgWA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40aaa40-6b74-4277-8a9f-08d9ebfe4941
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:59:23.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUilNjv1dUD5qQ0BVsUy1le4TpJiPXJRGfO9+oXSuvrTSkG96fqfQMGxkAIQep+cZL5jNXyBu36pQP/K7L+I1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2885
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090100
X-Proofpoint-GUID: D4lFvOQ9tOo2MREcfTtCUHnPSEGxYQUm
X-Proofpoint-ORIG-GUID: D4lFvOQ9tOo2MREcfTtCUHnPSEGxYQUm
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
> folio_copy() will copy the data from one page to the target page, then
> the target page will be mapped to the user space address, which might
> have an alias issue with the kernel address used to copy the data from
> the page to.  There are 2 ways to fix this issue.
> 
>  1) insert flush_dcache_page() after folio_copy().
>  2) replace folio_copy() with copy_user_huge_page() which already
>     considers the cache maintenance.
> 
> We chose 2) way to fix the issue since architectures can optimize this
> situation.
> 
> Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks!  This will also make backports easier.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
