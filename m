Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150034B17F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbiBJWLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:11:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbiBJWLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:11:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B9DE7B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:11:29 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21ALnw7i013515;
        Thu, 10 Feb 2022 22:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=r39ZhuRdQSgh9QEFs6Bu1r74RRgsigdZ1Sznp9f4yI4=;
 b=qvASVR9lGMxX+Fc97/WMXGtXlW/qlaZoxIg4O6iKmS7WD214zMF/Sq1D8rPYuQ2K1JYh
 Oxo/l3J8xBbWcl4LVF0EeEjLMbX+4mw6yktXaO9z51a/WPDL8ot+as3IVEZuiB7PtrT7
 nFZBPpFSm+8mID0bs8h+q1Fo3SUFdioI8PSlvhqZFC9g11X35UTYqVmsi/haazilY+tM
 wNAAJUNh+I73C5KCY//HH5xYj69w6wbhXGE3222JWu2Xl8eptfQACEKtGCmMvpKmxB88
 uIf4MePjJjurIOXPm49z0GSnK7mHjt/fFjPsKGNDLUy4KI1gtHsYO1rVDLZLixsC9ZaC qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345sud10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 22:11:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ALpg0A075368;
        Thu, 10 Feb 2022 22:11:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3020.oracle.com with ESMTP id 3e1h2b53ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 22:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Erj/Fn4KIiUph7+4Jav9KSK5hxmEOdQiusk73b9cEfeEAOQWCWV0EGZJ8XCinUvC/7b3zE2rAcsgCcytAsGBgtyJK6+GIuoUZwOy3wPQ2LqixrgLs0FVLgOkrm7JoKCImH/e8A/9yf0KiqpDnA8/clVYS60AJ3FOdcvb9nj5EqHiPLqBF6J9lt72CtIQW4aX+/VFqhKo7hYzswnMjHbIkMCA5FvTzY1GVw00HoA0TmdJUXl/KO3w08w0nCge/7dLQV8whaWRFjJQixSO7gf/fCLyPqq0RvQIzMaYc8SQLkOQSijIXo4+TExlba+oj7UAbs0qqhU1JS9RrlkQOGPFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r39ZhuRdQSgh9QEFs6Bu1r74RRgsigdZ1Sznp9f4yI4=;
 b=m3riUMwe+xrOe6nK/MSCCAaibAadbi//UOqxhnwr5sKbpkEh7c0RAYTX1LHTVn8l+B2TFQbgikHKQPxMxDgpIes66JoKDk4TEvRVNjO1jfi4L6A+7oCG/OUF+ISBJPknW2KH0WFA5YKlW3h4jX0bAimLliVFcrl9he7cRbdL946HN5GP0pGlIycW/ejlo+pSSsZM+tII0REkgjNcVUZ/xycOQ99UzrciIFpnh4rt5In26j4TiHJVTcEbbAWoJM5TxahlYZ8GkS2Si41dbepHSOBl6JScgqukOzCSLRfKsjd7KzjSsBJhmOe5+D+ucIXj8Io9n8XoZoDwxkB+tlcfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r39ZhuRdQSgh9QEFs6Bu1r74RRgsigdZ1Sznp9f4yI4=;
 b=tzZc3PmySdRKdmuJaiB+taprO5cxU2rNH/MOJMIdsWDjkaEuuh3C4kkikbvdLtJ+6h1fqth7mD7Xo+N8ZshWGD1kfMpPLfdXh0KRYXI7aq4AVm8LuRiHx516WkVoSTO11VAw9DH2DGKK8B6S4uUA4vWI3m8mRVFHXWOWd72FiG8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB4171.namprd10.prod.outlook.com (2603:10b6:5:21f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 22:11:16 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4975.014; Thu, 10 Feb 2022
 22:11:16 +0000
Message-ID: <55b6e78f-9594-8d5b-6ce2-bb699b9549fd@oracle.com>
Date:   Thu, 10 Feb 2022 14:11:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
 <20220202014034.182008-2-mike.kravetz@oracle.com>
 <20571829-9d3d-0b48-817c-b6b15565f651@redhat.com>
 <7b174c48-d368-43ba-7eab-13719a0d15ef@oracle.com>
 <6a82ea68-6e1e-8f5a-ca89-6744fc896a0b@redhat.com>
 <d7e6ee46-8e0b-2ae3-c159-449a26c17ae9@oracle.com>
 <b7ebafed-7dc3-b08d-15d4-859c7bc0fe2e@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <b7ebafed-7dc3-b08d-15d4-859c7bc0fe2e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:303:b7::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70074d94-5850-424b-abae-08d9ece241c9
X-MS-TrafficTypeDiagnostic: DM6PR10MB4171:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB41711525F52D7DD98B733D5FE22F9@DM6PR10MB4171.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFPZfMvfqUo3j5hfBo1YwpxpIStGbwiPJx6NLu81iSCUw/zhmb/M4YnaYumuFAJ6/mG28wzKgCuUpSk/KwaX9kg2PJdYrlDgJy+ZhGdPd9aUFlG/3tlW9BUZAQDMM+O/29H3N8gADEdYZu0tGK5LdUWrsMLX7/vqz9Ol0IlpHWUhtLAugqxlFMXPtJcjJtLHmk89q9KNND7QnXwlblT1S2CGVEFUhsaydaNWNMEZSJB6p+gQoi9nlDm/kKOAj8iTcB5EREMPnrANTDTRM+ys3tlJJtM5m5uFYVEQT4WAKA4s8kfdG1k5Vi/MWyWIlKCqH/6X/CZEIM3PyBjNg+gBgBh2WVL117Uc2kjN/DG5IzZCcWtDMS3TwksHNT76sfj9/W1Db1IxaJraLh8PXJlmvD6F6FxdO4lYiU585iCCGonnbjnwHRUA0IT0NfDymPItmEjaB03QGOmj20h/bLGGODfII3NqUMNUaQhTBlo12csVsKCtvBL9jKRG0UGPvPRcyXoXFJPslEvreUTsQDMYud6Cusx9aE+rYdt4wCwpIPJlwp7fV64dSOMVPsYKk3kQADVR4Y++IlHrw21QNQozuMo0YRkG2X1D6K5r2MBepmSS0haq1Htu9ZbpGaAZ28+h8lyY1QEL+g0VPxI5xiFbxCi+99XOXm0yS24vz3iDz6BJQ6jsDbaGfen7Nxhthbz6ru3oV6dKtqxfvJ3wVqzsCnbtPS0Q7NVoohAJMEW9lYO7SAOtXNQIx6uuTnGO2eAQf0sxZaCDy5tLpp7QNP1J1GH0/EqaivZuwqpQIyjAwGZrIzssb7lNMXo4aaauQNpH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(66946007)(8676002)(66476007)(6506007)(8936002)(2616005)(316002)(54906003)(5660300002)(38350700002)(4326008)(31686004)(38100700002)(66556008)(6512007)(86362001)(52116002)(508600001)(6486002)(2906002)(44832011)(83380400001)(31696002)(186003)(26005)(7416002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UElMOXZENFhkYkRLelpIaW9oNXVCZnp1T0pveUpMQ1h4TER0SXZBL05XTWtx?=
 =?utf-8?B?VXNueHBNdGRiNmd3alpkQWk4dE96R01aaXJrKzBDSGlYUmQ1MlY2dHdVbk1m?=
 =?utf-8?B?UWJobmF0VnlIQUJVcVhDNk9HN2lzUXo2VDJjVlB0Y1ppUkpJaExobmFEbUlH?=
 =?utf-8?B?a0hkU2t3L3gzSFBuYTdVSVAxOExBYncwL08vN2J2M294V1h0SHhrR3hKNWhX?=
 =?utf-8?B?dGtuUUZEMlpwT0J3WlZEcEFMYVlQQW5iSldNT0l2QWkwYm9QWUczUmI2eTd2?=
 =?utf-8?B?RFVJR2phQ3BjSWFZenpseDQzZnBUWGRxOFQ1NXl5UzVhc0JqWUovU3lwTTJU?=
 =?utf-8?B?ZDRHbTBsODFRZ004bi9EQXpkOWhTQ2tRMy9WcHdpNFpPVG5DcDlVQXBTZGFJ?=
 =?utf-8?B?UjdqYWk2NEg5UTJadThoQkhvRXdHRU1JQm0va2ZjdHlRWlU1UjVwT2VCc1B6?=
 =?utf-8?B?OEY3ZEhMVk1rQktaWkxvKzZSUkJGaHN6NXR4eVZCUTloenFmdzU1VStjbjd0?=
 =?utf-8?B?bXdzeEJ5SjRCbUhNSi94N0p1YW9yaU1NUkFHU0ROVXhwbkxjejBOMStYOE1h?=
 =?utf-8?B?R2U0MzF6UmgralRZTWRXOUdNaE9WbzZvbVBrbVN5bE9LUnA3ck9yUkgyK3NZ?=
 =?utf-8?B?NkcyclI1S3FaQVVST2ROcy96cFFZamZUZkhaaFVuNUVoWjhUcDFpTzlsejNk?=
 =?utf-8?B?ajhqM2YvMmRsQ0Q0WGt2TFhJd1ZRWFVhL3BYVGpiaVYzK0RIYXhCRG9jdzdP?=
 =?utf-8?B?a0IycjYrUlI1QXpjNHF4QnBDYUUycDR0MkU4M2xQcVhnS0xxdnpIMHBKeFhy?=
 =?utf-8?B?UTIrYUpXL3BMalBDeld5SHJIdGRrdFZ5RjFHanVnZGpsaCt0STI1NXVGejRn?=
 =?utf-8?B?TWJ2MTE0V3V3WlBwenEvMEtrVTRobHVOT1ByUEVta2Q5ZCt0SUJUZCt6Z0Ew?=
 =?utf-8?B?WExOSmpBK0o1ZXp0ekVFOXFpdUtkT0lFZDRFYWY1N2hTWXIvL1g2d2t3L1ZX?=
 =?utf-8?B?bGFzaTIycHVyQU1mN0YrSnRqYnhRQWdaam1MMVhoOEVoQlFFdURrdmdTanlM?=
 =?utf-8?B?TEFXZEhONm9xdlAxM2RFZXRQYVBUWXZiV2Y3MU1qN1ZMTDh3M2NzeG9UanZn?=
 =?utf-8?B?dzlhcXhiRy9acXRsZVRjM3JOWm5ycmcrSXpOVWdpclY2Q3FRVHkxNmpuWlpR?=
 =?utf-8?B?NEVtVFFuc1pySEgzWHovM0xQNklLU2V5VTdJM05CcnJta3FaWk10cnRXei9V?=
 =?utf-8?B?dGVCRmhGWm9MdXZHVW5xWTR0MG1PcDM0cUtHU0xaSjY1MnN5VFEwMWFFWFBY?=
 =?utf-8?B?dnpCYzg3VytpdEZVYUs3WUpOTGpKS3QzWXpWcEY0c1NoYWtGTUoxOEhxQWpQ?=
 =?utf-8?B?bGJYUnFNYjFDb3Y4dEltZ1FublkyUGpqaU5JcCtQQm8zYUhibWhXVXA1bVZl?=
 =?utf-8?B?eTluRUl4cTFFV3dvb1NacmRzTHlkVEpFWThFYXdYemF5YkFvMVpNam1nNjh0?=
 =?utf-8?B?SmFUdEhIbVpxaDZ2VzIvZmJtbm10OGJEQUg2RmN1cU1NcDBlLzNla0FESzlY?=
 =?utf-8?B?NkdPRStZMlZXN0tvZFU2SE95eEgwQW1WaDJLOVB1N2tPd3c3Y2xHOEJWNmhV?=
 =?utf-8?B?b0dndlphSDhIYU5xS1RtYTNvZzBLNzV0bmxmY3h6b3JWQ2tWZUtrc21HQUxn?=
 =?utf-8?B?MFJhaGhPOThBN3RlM1JBdWJQN3diUzZ3bzI5QWVEbHJ0S0cxNWJsb2pIOW5D?=
 =?utf-8?B?S3RDMStsZCtac1J5VDVZbjNqdVh1SFY1SW9IM3RZaXVLNE9SSVdYeUlvRWtT?=
 =?utf-8?B?Wlg3cmVISHY1ZmphU3kyaWo0Wmp3ZEVXMmNmNDlYaVJtazRJK0Y1b0xtSnYz?=
 =?utf-8?B?c2Z1VGJYR2FIQncrQW9JMVN6MmJGbGdYYlNEM2Q1dWtpdElYSENnQm5nbENv?=
 =?utf-8?B?bHY4SU9kUDVjaXpsRG41WlowNEErTUFVN1A5Y2tQWlUvVE91bGlSNUpkSE9r?=
 =?utf-8?B?MHh0a05hMmN6NnhYNyt6NTVHNWloSmpGKzl4ZXhmZHgvN2ZPakNrYnI1SnF3?=
 =?utf-8?B?RlErMmIwRFc3NUxBRHBrSUg4ZE5oK2pwVitBTkNtUVQxZDFXV21QRzZ6SGFv?=
 =?utf-8?B?TjFPd0pqdzNZak51bTJvSWdrKzNrbWdScFhyMVF2aHc0d3ovYmk0TEZkcmN4?=
 =?utf-8?Q?R3TS+HZ4TlyxTcUnB+ECz6U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70074d94-5850-424b-abae-08d9ece241c9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 22:11:16.0916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnDED3pTpiiw9oCMCyZCzb7RvITvNGuxCteuV1T70GVQuVsunYBdtsH+L0ssilF2L2WLKLK4vGZ9GEOanLseLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4171
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100113
X-Proofpoint-GUID: fXi6UW0_zvGVckH_uCWe1W_Ynxf_QAfo
X-Proofpoint-ORIG-GUID: fXi6UW0_zvGVckH_uCWe1W_Ynxf_QAfo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 05:09, David Hildenbrand wrote:
> On 08.02.22 00:47, Mike Kravetz wrote:
>> On 2/4/22 00:35, David Hildenbrand wrote:
>>>> I thought this was simple. :)
>>>
>>> It really bugs me that it's under-specified what's supposed to happen
>>> when the length is not aligned.
>>>
>>> BUT: in the posix world, "calling posix_madvise() shall not affect the
>>> semantics of access to memory in the specified range". So we don't care
>>> too much about if we align up/down, because it wouldn't affect the
>>> semantics. Especially for MADV_DONTNEED/MADV_REMOVE as implemented by
>>> Linux this is certainly different and the alignment handling matters.
>>>
>>> So I guess especially for MADV_DONTNEED/MADV_REMOVE we need a clear
>>> specification what's supposed to happen if the length falls into the
>>> middle of a huge page. We should document alignment handling for
>>> madvise() in general I assume.
>>>
>>> IMHO we should have bailed out right from the start whenever something
>>> is not properly aligned, but that ship has sailed. So I agree, maybe we
>>> can make at least hugetlb MADV_DONTNEED obey the same (weird) rules as
>>> ordinary pages.
>>>
>>> So b) would mean, requiring start to be hugepage aligned and aligning-up
>>> the end. Still feels wrong but at least matches existing semantics.
>>>
>>> Hugetlb MADV_REMOVE semantics are unfortunate and we should document the
>>> exception.
>>
>> Thank you for all your comments David!
>>
>> So, my plan was to make MADV_DONTNEED behave as described above:
>> - EINVAL if start address not huge page size aligned
>> - Align end/length up to huge page size.
>>
>> The code I had for this was very specific to MADV_DONTNEED.  I then thought,
>> why not do the same for MADV_REMOVE as well?  Or even more general, add this
>> check and alignment to the vma parsing code in madvise.
>>
>> It was then that I realized there are several madvise behaviors that take
>> non-huge page size aligned addresses for hugetlb mappings today.  Making
>> huge page size alignment a requirement for all madvise behaviors could break
>> existing code.  So, it seems like it could only be added to MADV_DONTNEED as
>> this functionality does not exist today.  We then end up with MADV_DONTNEED
>> as the only behavior requiring huge page size alignment for hugetlb mappings.
>> Sigh!!!
> 
> :/
> 
>>
>> I am now rethinking the decision to proceed with b) as described above.
>>
>> With the exception of MADV_REMOVE (which we may be able to change for
>> hugetlb),  madvise operations operate on huge page size pages for hugetlb
>> mappings.  If start address is in the middle of a hugetlb page, we essentially
>> align down to the beginning of the hugetlb page.  If length lands in the
>> middle of a hugetlb page, we essentially round up.
> 
> Which MADV calls would be affected?

Not sure I understand the question.  I was saying that madvise calls which
operate on hugetlb mappings today only operate on huge pages.  So, this is
essentially align down starting address and align up end address.
For example consider the MADV_POPULATE calls you recently added.  They will
only fault in huge pages in a hugetlb vma.

> The "bad" thing about MADV_DONTNEED and MADV_REMOVE are that they
> destroy data, which is why they heavily diverge from the original posix
> madvise odea.

Hmmm.  That may be a good argument for strict alignment.  We do not want
to remove (or unmap) more than the user intended.  The unmap system call
has such alignment requirements.

Darn!  I'm thinking that I should go back to requiring alignment for
MADV_DONTNEED.

There really is no 'right' answer.

>>
>> When adding MADV_REMOVE perhaps we should go with this align down start and
>> align up end strategy that is used everywhere else?  I really wish we could
>> go back and change things, but as you know it is too late for that.
> 
> I assume whatever we do, we should document it at least cleanly in the
> man page. Unfortunately, hugetlb is a gift that keeps on giving. Making
> it at least somehow consistent, even if it's "hugtlb being consistent in
> its own mess", that would be preferable I guess.

Yes, more than anything we need to document behavior.
-- 
Mike Kravetz
