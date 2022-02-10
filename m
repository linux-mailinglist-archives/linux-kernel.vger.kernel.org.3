Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F24B17B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbiBJVhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:37:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbiBJVhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:37:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438A826C2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:37:18 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AIkQpb013543;
        Thu, 10 Feb 2022 21:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zIwWFg+GzQglDwq+BELmJGFrQvb9mtH+BD/PZ2V2iXA=;
 b=Pz4jlJ3C2ZasVMVGVy9vMott0cLD8rAQq3qqHyMKGdICS39ko9/jZCf7sl0duMkC6MJT
 Dnl2kuzYlYLOTGfcTgiG/Nsub9Ek094kX0+HTQahysQKkeGxyzCoBVhfEpnvgM1f9JDy
 JDY24qm35TY9+LRhKMHPDEk9aouRTtu/qXQ0xx3gHV7tjvddcy4SP7R02FXm05MgFinn
 DSh4v8s4Ya7u2gM1kKfclY3nmSQn3hHv8hPknjoukd+dQ4VqAqyMnblIG5lUai2T81d3
 qGTElGB0DCO66Dq70vdUT0JZvjfhCGJL0uQG5Jj8F4DIhvRfmVpwzCxYlHdHZKiXaOeh DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345suawm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 21:37:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ALQCEP028879;
        Thu, 10 Feb 2022 21:37:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by aserp3030.oracle.com with ESMTP id 3e51ru23ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 21:37:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCRgHsy/Smuv6D9nchCHIFug/JBZzKKBJLMQfJ3TwGpr+yttsCZYkb7TgK/bZCDcrTG7iXuVlV6IKr3J08KhNatLTq3DFvWuJ+U+lNOI7SlOCNXSBuofnOpBh5LDwfH8kFXenGnQiCil9DUFRhp9x+4gkqUrKxS+cZ4wqDZfiOPEIqLUI+edsDGq53GsyimqprA9R9DZS5GkXf3vT8DxNOll98p0x3fJfoq++wa/wtRr0Vju/dLEqdUq2vSo4xlKVp2Ar2k/DSwE2Q8RQ7+LcAsoHgbDSRNgki6Ba1rWU38FtoR+rO35fF4MWsYqvY9WMz3nxb6KiOK1ZjTeqjXuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIwWFg+GzQglDwq+BELmJGFrQvb9mtH+BD/PZ2V2iXA=;
 b=TreUQfMMOT99AWjJH0q62Lc/oG1CYKed5JcFZqr6TRBYNVGMJDvom+SwpZ2D7OMJuon3xBq7U3WDsEJar20dOtOba3laX5VMboZFYBK7mViHDLneCmj+vnkziugjVekRqAM0RNFhwhER17em6QpFYhIEvUAOYdloV+BcXrPI/yM0jUZ6b6gzWkyynvpSoEBmsvNmOUZdS2RExPxGyM7/gCEEToUzg7HeXiQP0Y/cP3MtZUgYiJ9QndLvTiJ80KBmPnGBVnXPjcKH6o7K9j3lyI/LpK2x0Nl3JbzpfVP0Rs8Q6taJ1AyIuYVh+XOLk9Ienau1Awp3l2K1mStLV8T8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIwWFg+GzQglDwq+BELmJGFrQvb9mtH+BD/PZ2V2iXA=;
 b=H2n+pFcdbC2bpFq1DiY5aThw8JTV6N43kdTKxNrfyKdKVx5JH1AqZ0DgFuvJIG2czvrjsfC5mGJ9Wzv52i4jzgerzK8pP7TIorWC4qTn+M8HRZ6QWSUq1fYnKcPjIipPPOMn2Kw9kQB8a68YHwp43DTyq8yCXP1qbS/A/a7abws=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5043.namprd10.prod.outlook.com (2603:10b6:208:332::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 21:36:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4975.014; Thu, 10 Feb 2022
 21:36:59 +0000
Message-ID: <bf1f7a47-5d57-492a-03dd-e42afe186d47@oracle.com>
Date:   Thu, 10 Feb 2022 13:36:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
 <20220202014034.182008-2-mike.kravetz@oracle.com>
 <YgSDcmXya7vTvvZE@xz-m1.local>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YgSDcmXya7vTvvZE@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0103.namprd15.prod.outlook.com
 (2603:10b6:101:21::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 168e6f1f-df3b-4dc2-fb80-08d9ecdd77ed
X-MS-TrafficTypeDiagnostic: BLAPR10MB5043:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB504383B84F2B18FD816BDA9CE22F9@BLAPR10MB5043.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TeW+TYk2A8uSvdnRV5BLwPXv9QnlbM8rAfY4ztVDXppJtfhFiEP6+beKwZ6JQDwCqCdSC+kzTQ1uoPUvnnVBv11K0kT8s91pmEBNcBMFsRlaCA2WmT1sYfGFlnN+QoISKzq77IxPYPP2DqAdHLmtzX41Ad6xSce3n1MDh8wS/v1vU6DQjpe+hwRB3E3qAoGzaUjxB7bAzM3b/1lQafLOX/c/Xydm2g5dGUAAi2FyK/cApRX4eGlDfe2s89zOBF/Q5+mL7ZXcbn1jfb73eOxnGZYTx8yLN69xtwR+3jw6VoMH19VMQPAo8fLJoy7Ft+BKwbEtgejOSt/mNVtsBCF25OPn+LB4lg2Ya+i2ILEmwM/gHvJB3cI5TcpajKqbJv2vmIsyAPTG+/NkpaSmHLW/hbqWh2EaWPzRo8sIT1Abgzv5xVXbX2HJEn0B87bASJJHQyT4B1C8a2r1hHuC4kVIkK3ALwAMSvMKdnrv4tFnEbtQBjWpDEvTYjwjtE9rEAaiMerX1J5BMmslLaAC12qmPhetDHhMXlz9JgIAoIXAxgx1K4p9TepoSu1iyXMY06B1VK+q1geN/wOVhcKefDqKPHxHL3auh4uq9sNC8xHaR6BajoDByZ8Lmq48dr2Lr6NOr1KpLRn2n7gABPwKHU1LgJYLISStOLRMRFc8t8FZiOOhPtkTR8LYdqNDpdhoglFPSNOJkw3eRNFcKr4m+n89pFpzC9nTYZziT04X8AVAnW10lfxXtaEw8eLNZW9MpjIk5q4x2LWHFjxSzfH8UKH4YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(316002)(4326008)(8676002)(26005)(186003)(53546011)(6506007)(6916009)(54906003)(66946007)(6512007)(2616005)(5660300002)(66556008)(66476007)(6486002)(8936002)(508600001)(44832011)(83380400001)(38350700002)(36756003)(2906002)(31686004)(31696002)(7416002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2RRR0xmN2EyeEdaZWJoczhodVVoQTk5MS9NaHpXUnMrTE1tTVRVLy9pNUdK?=
 =?utf-8?B?bjhZZHNxNVVBZnNyczhuTjBjd2MwTUljT0pCU1NHUmlLbHFBNno3cG1rV3pN?=
 =?utf-8?B?OVlzSkNMdGdaMGYycWZwdmkraWlNRmFKempHZ2tYbnA0aU45N0dJNHJQZ01X?=
 =?utf-8?B?RmxpY3duVEhlcWxZV1YrUExXWDFvMXVyeDdLT0hRVmRVZ0J5azJsNGF4alBB?=
 =?utf-8?B?Rm11b1Z0aEhPMXB2dE9KTjViTkg4RDJwakJ6eDJ6bTJ2NWVPZytUN2FXWXJX?=
 =?utf-8?B?Qkx6TlhReVZNUm1JTW5PenF3aEdQNkdJOTRiRUlKMHlSNnZVU3EwdE5sWEtB?=
 =?utf-8?B?cWNNbWtCcVNFalVkNVFmNThhcW12SXNHRFpvRjFHTGcxV056cGxJZU5ScXcy?=
 =?utf-8?B?eXhObFVLUTBieXNlT1Q0WEZPQ3dLa3hrdDdDWkZzL2UydDBvbGgrUHUyQmQ1?=
 =?utf-8?B?eExQSU1KVzRsUGVzV2JmSWYxSDNmMS92SFA2ZFVxejJCNUpSaEJpWUMxUEox?=
 =?utf-8?B?czdVNzg5TUZTTVdLZmtVTTZScDBkV2wrQkYzaEh6WGhlZitGNHVxeWRYUUV2?=
 =?utf-8?B?SVhPTER5aDNrcW9FRDQyb0VaSXZubDF1TU1wQ2JPMnJpckJQOHJMcnQxbjJn?=
 =?utf-8?B?YmZyNHJBYkdCbnU0OTN1ZXJqVjhEL2dyeUljUlQ5Yk0rWWxSMHViUUoyeHdR?=
 =?utf-8?B?c2NWTGRrMUhDWGdoTHhvVUxBSTNZNnpSZjljTFBMNjV3d1IxTkxuN3hVeHJQ?=
 =?utf-8?B?dm16YjZuRUVmdWh6SjQ2eU9ZWmQ4ZzhHYXBIWUIyVkxFUHRCOWM0bzdzOUQ5?=
 =?utf-8?B?WHdCN2NXaW1ybUllMnNZQTIwemZEcm41N2RvbjRiWmhuQ3pORUxhTWhrOFQ4?=
 =?utf-8?B?UmtWWmh6ZklnNFEwbnV6V2s3TlYyRXptbzlCNTYvbUljVEJZOHJ6M3JDRENT?=
 =?utf-8?B?WVMyNTNmUFN3UkY5cEdzYXQ3WFVlOHRFbDdTUW5pNFlhTXo5NGUyZWxoY2M4?=
 =?utf-8?B?Y1llQzZxUHRZNTRMb3gySmZBc3UrVm14a1lWMkxGN0NWNzM1Z285RXRiS29F?=
 =?utf-8?B?SVpBejZoZExhdm50bzY2MEhTZHU2bnNRQlhWNGgrSFhialkxUHRaQ2R3d01I?=
 =?utf-8?B?TURJY2xpbVhKSm1IYTlEWUxKZHNPdm9QRldadnY0Ui91dmIzL3VNcEV6R25u?=
 =?utf-8?B?aFZ6aEJUSlQvbG1YUncrTnFaendyU0NNR2VBb290NEd2ME5IWk11bHo0ZVFr?=
 =?utf-8?B?SS83YWt6REMzTmZzZ1hMZ040amtsNUVEb0J5dXZPVGNZbkI5RXFUZlNpUFdn?=
 =?utf-8?B?NDRLczR0TFZCdSsvTE9RMVNNUG1WZUdBWFRpbG44TzNXU0cvdm1MWFd3T3ZS?=
 =?utf-8?B?R1FjUXMzNGQ3YXMxemQ4bmswTGdUcEhaY0RXc3RkdGs4dG5yVWhTQmNCUndQ?=
 =?utf-8?B?TjZZcDNOcjVOeE9JUFdrUWR5TXU5RVh2Mm5ZQ2xWMzMxK3NKdldVcGZqQTl2?=
 =?utf-8?B?WXgwM0hoaGlhTVBrRWU5QkdyOFlaek5NQ1k1enR6K05hZmRvNjZhNXBRTXBV?=
 =?utf-8?B?MkpWSlFwQXRRQ0lHb2R5Z0ZuODBEYXJVeXh0OGVSdm1LM0k3YUpCeTN0b1dG?=
 =?utf-8?B?ODNTUVp1TUh1TWhKSmRjWlVZb2JiSVkra1NFTjU0R3dUa1JNZVozdXFKckl1?=
 =?utf-8?B?QXhtR21xanR2SXBTMHpSdVI3MUhFek1zelB4Q3A5b3pjdHlyUWFad3p4SDNh?=
 =?utf-8?B?M2o0amcxSGxqZkg0NytEYSsyS093K252bWlNWm5CNzJsYkxWMnp6aUQ1RHZp?=
 =?utf-8?B?QkRqTkxpS1lhSDFIeTV4RmljdjlpSmpTaUZ2a0FKOWtkT0Q3eVdpRkV1VUJY?=
 =?utf-8?B?dUxyZ2Y2WEFnNFVSODJwcHVPdjExMURNNmViN1l4L1hrT3FVVmpEMVViZk9m?=
 =?utf-8?B?NGxZLzJvT0phOHN6Z0ZzUHlMenpKaTJMVEdLVlhmN3ZGWFl1N1FMK2swTTkv?=
 =?utf-8?B?WmxNdUJWTm1YeUVscERkWS94cE0zMXlvTEJYZEZoZnUrczNCOFJvVGljd2Jo?=
 =?utf-8?B?djlGUVh6bk9jQnNGWlhxRVYwWmZpb25zRlB5WVNvcFFlUm9OYnVVaCs4a3hE?=
 =?utf-8?B?ZzExOTJyRDJlR29nWVA2M3hSc2JycHM1dVRBUTZlZ0Y3b2czaXJsRXZtT0Qr?=
 =?utf-8?Q?YsRfOTcu7vJMSs3x2P6Rolo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168e6f1f-df3b-4dc2-fb80-08d9ecdd77ed
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 21:36:59.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xM7yXb1gtADUG0lO7c1HftfvPLmnof4X2QXVoz00RRKHoQ+VvO73QIaXhqrOKtuW7LnjhlQeKLhiyKDNfESfEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5043
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100112
X-Proofpoint-GUID: okgyLgmaHu0GQmLOOR1pjEjhSu2gnIHu
X-Proofpoint-ORIG-GUID: okgyLgmaHu0GQmLOOR1pjEjhSu2gnIHu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 19:21, Peter Xu wrote:
> (Sorry for the late comment)

Thanks for taking a look.

> 
> On Tue, Feb 01, 2022 at 05:40:32PM -0800, Mike Kravetz wrote:
>> MADV_DONTNEED is currently disabled for hugetlb mappings.  This
>> certainly makes sense in shared file mappings as the pagecache maintains
>> a reference to the page and it will never be freed.  However, it could
>> be useful to unmap and free pages in private mappings.
>>
>> The only thing preventing MADV_DONTNEED from working on hugetlb mappings
>> is a check in can_madv_lru_vma().  To allow support for hugetlb mappings
>> create and use a new routine madvise_dontneed_free_valid_vma() that will
>> allow hugetlb mappings.  Also, before calling zap_page_range in the
>> DONTNEED case align start and size to huge page size for hugetlb vmas.
>> madvise only requires PAGE_SIZE alignment, but the hugetlb unmap routine
>> requires huge page size alignment.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  mm/madvise.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 5604064df464..7ae891e030a4 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -796,10 +796,30 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
>>  static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
>>  					unsigned long start, unsigned long end)
>>  {
>> +	/*
>> +	 * start and size (end - start) must be huge page size aligned
>> +	 * for hugetlb vmas.
>> +	 */
>> +	if (is_vm_hugetlb_page(vma)) {
>> +		struct hstate *h = hstate_vma(vma);
>> +
>> +		start = ALIGN_DOWN(start, huge_page_size(h));
>> +		end = ALIGN(end, huge_page_size(h));
>> +	}
>> +
> 
> Maybe check the alignment before userfaultfd_remove()?  Otherwise there'll be a
> fake message generated to the tracer.

Yes, we should pass the aligned addresses to userfaultfd_remove.  We will
also need to potentially align again after the call.

> 
>>  	zap_page_range(vma, start, end - start);
>>  	return 0;
>>  }
>>  
>> +static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
>> +						int behavior)
>> +{
>> +	if (is_vm_hugetlb_page(vma))
>> +		return behavior == MADV_DONTNEED;
>> +	else
>> +		return can_madv_lru_vma(vma);
>> +}
> 
> can_madv_lru_vma() will check hugetlb again which looks a bit weird.  Would it
> look better to write it as:
> 
> madvise_dontneed_free_valid_vma()
> {
>     return !(vma->vm_flags & (VM_LOCKED|VM_PFNMAP));
> }
> 
> can_madv_lru_vma()
> {
>     return madvise_dontneed_free_valid_vma() && !is_vm_hugetlb_page(vma);
> }
> 
> ?

Yes, that would look better.

> 
> Another use case of DONTNEED upon hugetlbfs could be uffd-minor, because afaiu
> this is the only api that can force strip the hugetlb mapped pgtable without
> losing pagecache data.
> 

Correct.  However, I do not know if uffd-minor users would ever want to
do this.  Perhaps?
-- 
Mike Kravetz
