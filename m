Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952D349D919
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbiA0DTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:19:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15280 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235576AbiA0DTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:19:34 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20R1fADH011980;
        Thu, 27 Jan 2022 03:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3U3SynMmP4/sbVL0piqqUb5D3fJG1Lw/PMn70C/BIUo=;
 b=i+05Ys9i86b8ZVI2r3ZP5kNKqL37bzsCKJ2JqrSo0e/6/7IBecSwCaabZgPm5MsVYTQB
 G3g87f8axuDMutExPv9P10VOcolIS8NoHLD2lpVqAeXwNkLt+efwSsMXzHB+1s+WgBYW
 Ao72CiOCi/d9he6c7EuzQo8CLQ0qk6H+6+orz6mXuwqW46f7iHxSuvXrJ79UQ0Tly0Vn
 SF83clxOnGaxenFbPaOAmvW2cb6XTctxrDKKpP5QoBNXr/RTfkGoFFH/saAMIIkUSW82
 XUDbmdLyBileNbnbzQX6mJgATEvKM8hadEG2t5b8DRMoZaQtrVFwPBRVSyM+2CgJHxDM Kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaafv70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 03:19:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20R3AVB1023514;
        Thu, 27 Jan 2022 03:19:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by userp3020.oracle.com with ESMTP id 3drbcsdx29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 03:19:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbFH4VsnR+t40nO7Gg1ZSOb9f8BJlTivYKu4700/08wFKLYXgRaCzf790YUdLVKfhf9+ySrtDZws8g/8110j1szfIZepJ68WowlqG1oGKVWnRheOqOprUW6jxlisLWdf9IP5eZe1avvNE2AJBIn5ch/8Rg4I51fZrCLDV/1orMV8i/C5nqu0w/HzzVdWTQjYACtb6eYHBkgSXNEB2/prDyBL8H748UCxDSlyVY/45mZubi23o5b9diGpeGn3jktiHGFzSqXdd9/XmGGxQC3eVDhBUCzhY0cGENu+wvqgvy218ZRFlUz2BU8fTw5yviamJCeWqGNrfSEz2Rb2AxDdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U3SynMmP4/sbVL0piqqUb5D3fJG1Lw/PMn70C/BIUo=;
 b=azfUaxlwiRnffCeXtWNjiyT8Ek9iaqR5Jy0SPQdJwycSU6iIhuP7w/kgGiFKdHd0y9NpkfnbOHpVb/0mM66+PX6Ei7QvKJ7t7swU4DAG1NqheoNlT+vO3KUiD7NhzIL/yaVrA4Om71F0sdpXWfZqHHE9GXK7JRm6dhZKpod6IQXKqr5l4o4d6LpymFOUj9u3sCmr9uX9Tf004qNPDyvftc0l9iuGNqFMhJCa3v3B8n1wG20IpIuelMG7wspplikPSB2cgpmUusImMOc6EWXR+kqurXQJdzt9B0xZeK6im2yWXu1pAtRM7VvabH596pWF+aIybGWEvFy4qQEFIRqbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U3SynMmP4/sbVL0piqqUb5D3fJG1Lw/PMn70C/BIUo=;
 b=Jljpke1hh219g9POIaRyWQn/oKkRsaPvKjw1IYb27BL7t/eOgSDnsEFjgdKJLYmEDmE1LmIey5RWP4eDiAQycACEp8JHNZOCy3z9rMiQMZCiY1HijiUbBW3do4Mp0InsHhUk8JGTJd8e1iNrzrw/XSgg8iNBNz05tbc3yDd+bW4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5059.namprd10.prod.outlook.com (2603:10b6:208:327::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 03:19:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 03:19:17 +0000
Message-ID: <ee516ae7-03e3-46c1-28a4-940050e56b9b@oracle.com>
Date:   Wed, 26 Jan 2022 19:19:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220113180308.15610-1-mike.kravetz@oracle.com>
 <20220113180308.15610-2-mike.kravetz@oracle.com>
 <20220127025845.GA3401059@u2004>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220127025845.GA3401059@u2004>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f3150f0-6f89-4799-7d0b-08d9e143cd3d
X-MS-TrafficTypeDiagnostic: BLAPR10MB5059:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5059FC6D07144E198A50D9E7E2219@BLAPR10MB5059.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icWuKgGbq5hWMeOOuMG0U2vIBZoEwghRW+wqJq62sr+PYnjiH54Sklc2q4jZRAgaYXxaosFf3cFvp3+7zpiCgecoWRcKEtxFDfsJC+j/N2k66Bpa0YP1XCPeGReAI0y7yXnSwn782Qdqj9Dmj/2Kc2DjwkK1mFzqGnRW77psS9MaSoMs2S/gj5StqQJ3dRAlS/8yIxCivtjepXbI8wq/X3NJwdgZXwZDAYHPFS7fEXgNbUaAxHYfNqEnP2xziBBHyfNSNJuEydFgwdPmpxoSYIL2eYwlV88qSAhCYaY0PR2s76/b48BbmluKmvj77TJG0EParMX7tQVCBMyU/7tYPFmopFe8Xaf/1/8w0Zqxd1I0lfqYatbpUiQUw45Z6WsbjZuXlJPByKQ8PsMFiv9qh3bwUe+Oa8TMegWlocZKFK+wWh4M3ryC3Qnma4Ea+1gOtveSJwDqWnmlmFP2arLSVhBVGOuTH+0eTU2NJoJMu3TA6TkUts3+ZMhlPjaBc5/cdSeAS59irsDmvIbSk/NZfjtvt0yp0XRi6wSC9tm+F+HGqWNEHLn1f0Se+97tSEYM0y3C7sBJw69fF1F3yISzsBh/b7ey7K6iQJaX3jsDbLRx0Ap1trSofJuKMRzN9qd1i6sqF5KhQlreE6T5YN30f0TOfapy57jS6sVLO3qpdcN3l87aV15u6bUG4xOa2TebHsjHiRE/ahwL2HrMoY+vMAJSt6K+G4s+5Y1LpLWIzVme/r6u/f3xX485skWQkN9yCLWpEx94+sp0Qq4ahb9YAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(31686004)(36756003)(2616005)(186003)(26005)(38100700002)(38350700002)(2906002)(83380400001)(54906003)(6916009)(508600001)(86362001)(66946007)(6512007)(316002)(6506007)(52116002)(53546011)(7416002)(8676002)(8936002)(31696002)(4326008)(44832011)(5660300002)(66476007)(66556008)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elVTWHFIRXlCNlJNZlRBWENlWW82VTd1SVBIenlqRWdvVVlWSnhBcjRkSFd1?=
 =?utf-8?B?UWZOc2h1dnNZKy9OSG1Cd2l2ODdCV2NpZ1FCZmtQaGlpWHlLTUpOSFUwdk83?=
 =?utf-8?B?Wm0wdjRpb1VxVzB4TmZ5VjVHVmxxSmUzN0ppSkJzZUtRWjY1SERPYUpYZGVM?=
 =?utf-8?B?SXR1TjRMc04wc1FiaTBpV0FwVkk3cFJIUy9Zdjg1NjZFamhWdEVKNVlCWmFo?=
 =?utf-8?B?cFZDOGI5Z1dmT3RnTDI4ZzlFRDR6ZklGSE9ScGZxREI4ZVd6ZHN4STZVL1h0?=
 =?utf-8?B?ank0SEtMaThLOW1FYlZGQlJ6OVJJZDB1aHpQL3lZL1RJQjJQTGVhc2lDMGVN?=
 =?utf-8?B?RTFMc2tYVXhzSGFDUTFTT2QrMjZzRW1vWmM4RWlWZzZmSXpMcE5JYnNUZ05F?=
 =?utf-8?B?VlpCYVBlUVNNeFl5UVFRcUlxYTFGYmxYbjN1aE0zdEJLQmpJTWN5V3NLNVE4?=
 =?utf-8?B?eXBDZjBCd2o2aWFGcTZraXZleWhKNHdGa1VXSWt0TG5sc3NUaXlyUWJXcmNv?=
 =?utf-8?B?enNheFpWYTFYYTdhbks5MXhGS295SHVaSGkra1liYjNWM3F6Sm5LT29pdHJQ?=
 =?utf-8?B?b2VPQnNmazJiQmdjblZlTnk1N1V0OHBjczZldXpzTmNuWDZrS3RtQjVUVmJi?=
 =?utf-8?B?ZVduZ01zZWNnTzNKUjJkQ0hVa2RIanBJWjkrMEorSjMvb0pTT0NCL3dUZ1Jw?=
 =?utf-8?B?cmlLWG9sRkRBc3dBVHFpZVFKKzRNUjR2SDNieVoxVlFVOWkyRnh6THFjM2Y0?=
 =?utf-8?B?cmVSUjJGb3dHQmQrVHRZZ1ZaMmlqZldBQmdhYk9PeU1tSVpBT01kUEdEUDUy?=
 =?utf-8?B?WVI2QTFwOFVpRm9lQzVlSFE3TEx6L3o5K01WNEphdFlXNU9yUTNySmM2TmIx?=
 =?utf-8?B?ak9kQkg3U0RDamxyQnNKK0VnUU5raUg2K3RjbDY2MXVmRDJwSUhmM2thNTQ0?=
 =?utf-8?B?VGNndDh5cThMZTNRc1B1NjU2WG02eVVodDM2Rjd4di9kUGxKcDBtKytyYW1w?=
 =?utf-8?B?YWNDeG1OOTE2ekovd1JRaE9LZS9XR3p0NkNTdGhHVzJ5aGluREQ0RWtpV2dp?=
 =?utf-8?B?eGxwY1c1Z3B2em4wZG8zT0N5ZVowSXgwVFlxakdRR083VFk3dlFRNGRaKzZR?=
 =?utf-8?B?K1JaZlBkanBrQno4dW9BYU45ZnU0RVdrR1N3WVg1ZkxVejdTek81N3VsaEJD?=
 =?utf-8?B?cXgxTngvemYxWkVCUGYySUM1VUNZdW1Td0pXUytPUEZRZElMUExqT0M2YlVX?=
 =?utf-8?B?QTRkS2l3NWxLbkNXbWhJaGxBTDN2M0x0RXE0M05NVGVBNHhsVHIrbmNJYmk2?=
 =?utf-8?B?SUs1MUc3TmFvcGhCdDI5WVZOWVFhMmV4ajFxZTJ4SVp5L3FtdzRGRjQyV2pH?=
 =?utf-8?B?dEtVOFltOHZDQkJuK2I5ZXV4bFFxMGttZ2hONkN4WngyeDJDVmR2QTZKMm8w?=
 =?utf-8?B?UkFWa0VXQXFQcnFZdkVuaXEwdkVCTmFwNEpNb0t3YmFTZGNoOGxpMlJSRWFR?=
 =?utf-8?B?b3phV3B5c2Rpelczb1lGY3NVdXAzMTFpQURibGpLNkNYUzNsVjlDTCtYR1l3?=
 =?utf-8?B?RUZpSFJ6aGJrdWd4Z2QwT3JjOHI4ZGxTTFErU0VINStBSm1aWDRzUjlBZGk5?=
 =?utf-8?B?YWpualNJcGxRcUUvdTZqMmprVnNuaDQwaHZpY1JBTXhNNWp5ZzdxWlNjbHln?=
 =?utf-8?B?V2h6QVZNenNrcWxTMFlkWlI1b3BGZXJ3QkdrUTErY0cxTWtydUIxeko3VG81?=
 =?utf-8?B?c3l4NmQyWExqaWIvTExNZUFjUjlvaGdWK1lLTjFGenU5Vkd1SVJiS3VQZnRO?=
 =?utf-8?B?MWczeXpsaXRoUCs3c2hCUno1N0lYcWFTdjdJbC9xcE5oZHFhS0VCY3JLN084?=
 =?utf-8?B?T3Z6dDRPVkc2TjZxc3E0RWRiUSs2eHVRdW9hYUJWV1dwaTR6Z205RnNyUDNS?=
 =?utf-8?B?SlR2Zm9DYUZDbDZlbXNUdGJFVWxQMEJFc3VYTzFMQWt0VEloT3JKeTg0VWNM?=
 =?utf-8?B?aEZYeW1LZGU2bXVIMVFBc1lMYko2TG9yd08rK2F4Rm1mc0dZRlNuOVRVOUk4?=
 =?utf-8?B?R0pSbXVQMHFVKzQrajlkN1JFY2hEZi91T3k3cnJMbjNWSnNxVitoTGJ5Ymt0?=
 =?utf-8?B?NXpxSkgrdS9maWZLODduL1NNVFJ2aVIzdkJOMDlQYnk0UldpeDdEY2FSYkNB?=
 =?utf-8?Q?7X9XrQOjyHrQYTgdX6LmE78=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3150f0-6f89-4799-7d0b-08d9e143cd3d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 03:19:17.3615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/IoY+3WPoY0Vuwwfcas1hpjabOQahpFgYIowjNnV6DGtXlzHE2w5lLQC+/0ccgdx88jokVP7EPz30lMEBq3sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5059
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=990
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270018
X-Proofpoint-GUID: afip_RMe8QC0hTlpBgQXFhsfkv48RdII
X-Proofpoint-ORIG-GUID: afip_RMe8QC0hTlpBgQXFhsfkv48RdII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 18:58, Naoya Horiguchi wrote:
> On Thu, Jan 13, 2022 at 10:03:06AM -0800, Mike Kravetz wrote:
>> MADV_DONTNEED is currently disabled for hugetlb mappings.  This
>> certainly makes sense in shared file mappings as the pagecache maintains
>> a reference to the page and it will never be freed.  However, it could
>> be useful to unmap and free pages in private mappings.
>>
>> The only thing preventing MADV_DONTNEED (and MADV_FREE) from working on
>> hugetlb mappings is a check in can_madv_lru_vma().  To allow support for
>> hugetlb mappings create and use a new routine madvise_dontneed_valid_vma()
>> that will allow hugetlb mappings.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> I briefly tested the patch and it seems that when calling madvise(MADV_DONTNEED)
> with the range unaligned to hugepage size (like 4kB) triggered the following crash.
> Could you double check around the address range issue?

Thanks Naoya!  My bad for not considering this and doing more testing.
-- 
Mike Kravetz
