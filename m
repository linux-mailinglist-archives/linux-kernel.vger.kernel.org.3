Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEFD4A04AD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349513AbiA1XyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:54:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29762 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344804AbiA1XyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:54:12 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SMcYIw016925;
        Fri, 28 Jan 2022 23:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NL4oskPiNo6Iux19zDIS5IyBzMZkZlT0Ji5AEKdo0z8=;
 b=C9gIVQLEZNDWGS0b8ocs5i3SB8f1IkZAi4IfjiZUBmMREoFyKApsPeVeRMAu7PBM2J/T
 gDcbcEDuXOhPKpmqd4qbDi5GvjGe8PwEM0yH4rSIxL0fN8n17EawDpquawqLB0WAJgaP
 FOZk7/Nid0ivVpQ+wIZ4VOktACtswmX8egoU3RylUtTCXfSPtCiKH5I1ZoTW/waIps55
 GKauQnbxfX5AxuKAYP3wfXhKUlcF+QsvtUSBSKeODaI/6op2wW2Fox8QzATFLNmWpFWa
 Ltu8MEn/qERrUwgK1iITZ/JjnyqU8rKTTAJ9a7vNaN1fU7K3laeCNVwN446l0ykD+kGh 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwub4mqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 23:53:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SNVqTj016541;
        Fri, 28 Jan 2022 23:53:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3020.oracle.com with ESMTP id 3dv6e5w6tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 23:53:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVn0pM0fZLDSpVN4rXCjvrLACMTN2Hq4+h7vvtIZ4gJ4dv/HLf5VQa8VBSFHbe1peI7VGW9FDbydnVJY/ySyeg1CsbI62ZrO/OuBIYQGhNJcCx2DNeAn8UiH1EOKbA/L4d/pvjgIwszqssx8Kn8j9RPY0OVaAKp4envGI43CzT5avrQWYQMsVyk66iqp+P2V/o4yhKgxEGiYEbuPSw8k+qwpBDIRjqgwSAgxbEguHly3oJ5CFjMys80jTD13QlGqtgZ0zq+P8QgFWyZY7rl4HwGTh0Tei6qpz2u6XHmET1k4jfPAUGZonN7dY+/R5LBtWgdZcr0q7DUHH+yeafqO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NL4oskPiNo6Iux19zDIS5IyBzMZkZlT0Ji5AEKdo0z8=;
 b=ZUkvTzurVvHb6rhP8T3hZTgVaeOuRqxUtcuDF2pz+Y2KjJr/YGys3T4XPq/May73O7ZJL/8a9d3wD6s6T2ueLt75afK3T1lXDpQvQ1CZ28ERep0x1mPigW2BW9hywRSGxqyRpk4i6yaaAelP+Ipa+WlaqU2PWiAACCCoWLTPTLt14zpTWeQCigU+QkWyg6eMiC0tt0KJ5OWy8hiHwePmIqTkVrxTOukb/Fe4KUBd0W9iGj9wyU2SRsK5R6VAEMlcOFeMohnolHt7gqyVnx7MIXQuXL3lWbGjo+WbAGnHrSauBQCR03JUuBF2mN6LmeooVrCBPFqNjR7v15ZZEgbxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NL4oskPiNo6Iux19zDIS5IyBzMZkZlT0Ji5AEKdo0z8=;
 b=n9FD+GYimrXVnbFiCtwehldm6Ncttqsb+WA8N0IEuhnkJpQUpuCpJR8IiDcdOogBN/NdnbD/US5HN94kT7BhZVPQYol+RvHdt5Ud7+BiIE4xmQFY3g6AcV1iIGRMZsJdjn9niDOMPQWhB1lA4CpSU3yab/+Y7FYKh5+aGDLpnyI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5108.namprd10.prod.outlook.com (2603:10b6:208:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 23:53:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 23:53:50 +0000
Message-ID: <9ddf2529-3483-bffd-986f-51ded56ecd19@oracle.com>
Date:   Fri, 28 Jan 2022 15:53:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] userfaultfd/selftests: enable huegtlb remap and
 remove event testing
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220128222605.66828-1-mike.kravetz@oracle.com>
 <20220128222605.66828-4-mike.kravetz@oracle.com>
 <CAJHvVcgjJNN81bAhsANccqsdYv3Xt5rMxH6i=JtHxijch55WFQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <CAJHvVcgjJNN81bAhsANccqsdYv3Xt5rMxH6i=JtHxijch55WFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:301:15::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e978d80-dd21-46a8-930c-08d9e2b96e5d
X-MS-TrafficTypeDiagnostic: BLAPR10MB5108:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB510842F60D297AF5F035D3C6E2229@BLAPR10MB5108.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DTDtUKky43TIiN9NU4/un4/7NQtNDqhGsr2B6BQhbA/VPkQzvmqiEta4gCuUBeTprf8QlYrosEfUT47zMgmEpJpbdU2rprIKDhzq9CLb95QdHJEdAo0hUgRpZG2jqedx+AvBx2vphz/6cmUNa5qDDtsvJLeFsi8G72kEukcKz9viJ8QCsSshe2WkfBSNZVBjttf/gnb625ALQX8dUiVB4TurUdFQrwo4VYzmDiHRLtsF3XuVFz5cgyCYhT/ET9hWW0SXp+sdp22YpPQlq5hK4eQb802jZtY6n4SRcjy9afgqpTiHf+6r2akHgnss2NPOAATuluL+peY1jquoAQuz+ZdXVuWGEDXJhv7FrXTS2eWT9nw6c3HhHwwZUufMGXTC0VSxvbljj5CI+xd81pKATnnFG2fbX/lFdh2M8LoXL+IDWiauB91L1WVdII37XtZEVluiIkOkwHbyU/tfA25P/xU67FmU+SFH1snYQpzPSMaFRGPng1v3QjSA/rLQ1mXBQC9t+/TkqZZBPxmeP9QXcFAMYaNLHZt/wodYcyEc9+GxR+2KK5bebcWO+iDqNeACWfsDJT/OSu0QWvMKCazU73YD3cwnSuqN0Xxv96YsHJApUAKud3xInH8TlFwjtePDraeMxUpbOFSdpBHXDwgDe0m6TmZopcN83sYoGUT+L/szUyCkKPNXQFP66gq2rWRZ1SVM6sMIHU2oqJSk5i4rcZ6LdjJ/fZRfxO1Za9aqhpo9HyiCpvDeHHNcrnHJaK8JMIUrNCHnfhOIMq1rmrrSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2906002)(31696002)(52116002)(38100700002)(53546011)(6486002)(7416002)(6666004)(6512007)(6506007)(508600001)(316002)(54906003)(6916009)(66946007)(26005)(44832011)(8936002)(8676002)(4326008)(31686004)(5660300002)(2616005)(186003)(36756003)(66556008)(66476007)(38350700002)(83380400001)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2VheUg0THJrTXF3cVpZdHFJcnlyK3o1azJBcWwvR01mNGNIY2lMTW1TaFhp?=
 =?utf-8?B?eFZZZ3JMdGx1b3ZQeHY3NW05di9nTEtHUVozR3hQTkV3eDdFaDZmb3RZbjQ4?=
 =?utf-8?B?SjRDeUo5dW1FMi9jZEs4a1pZSXk4Y0RjTmZyQWE0NFpjQXZpeVBZZGVMZ3Vk?=
 =?utf-8?B?VkpLYmU3ZkNTVW5UZ0xTekQ4U0VyS0JKcFU2a2pNdk9Xa2ZEdkRvOUJ4Mmw2?=
 =?utf-8?B?bDcyTDRsQTVINFUrNUJIWDBraDcvQnNWN09nSnRpV2JtbjBCNmQ3bWlHRmJ4?=
 =?utf-8?B?d3J1TU02SFQ2V0pGYmpad3pVSWlOczlwVU50WisyN09Sek1GNU5zNkNJWUN0?=
 =?utf-8?B?MkN4bVloLzBvc0Q1YUh3UTh0SkZuaDdKQnRsdklsbVhZTytGTnA0a0hGK3pO?=
 =?utf-8?B?N3BBUWVOUE5mTWRtT09CbXNYSHp6MkxRZGpzUWxlVzlnbFlENkFZUWR2Qi9n?=
 =?utf-8?B?bGJreG1jTm5LTDNzL0JyK0kvUVcxVGZqL0xOS2x1UlR0RnVyLzZ5MXU1VnZL?=
 =?utf-8?B?T2txTGVIdHFQRXZnZHFFaERVMTRvcVQrQk10eSttbmxkbHZRb2pOUU4xSFUr?=
 =?utf-8?B?UzV3aEZab0RqeGhlVnVmYXNHYVBUVFZPOTQ2eG1yUEVna1V5ZHlVMUlPYUN0?=
 =?utf-8?B?eGFuby9LTE1ROEJWdThjRy9SZmtQdlJpLzFuUWtmMndvVTBhbmVyMEdOaTE4?=
 =?utf-8?B?dkVYNm5OeHdKT0N0NUQ5ZUNmcHJQM2U3dUF3YU1PdmU3bEdPTEwwN3RNWlkr?=
 =?utf-8?B?ZDljdDZMYnQ1NlFmcy93bE4rSk9HNi92eTU3U0hCOVBjcUlmWWthenVvWXc0?=
 =?utf-8?B?czR6L01iNHArQS9Ia1ZJVDMyeENkWUFERmVhVDZRYjVWaHhvOUtKTm1nRklm?=
 =?utf-8?B?VFJzWmVjRDJ1U21udmdKRnhvL3lQaThKZkkzWmpuUDJaTU9rRE5lRTU5VWg4?=
 =?utf-8?B?RmJnQ2ZBM3RjMmJmNGFFZDRZRFo2dlB2RnFsZjk4U3FldzdSZ1hqYk54YUJw?=
 =?utf-8?B?UzZpZmkvNEpxOU9LV3N1VllxUjNYYlIzTFlPKy9maWNsL1k2UDJCL0VzbTBz?=
 =?utf-8?B?VldTcHQvQ2FRN3JVMkVETmkxNG5hdGxUTmRXcitUOXN0NGYyOFU4eXoyY0p0?=
 =?utf-8?B?SFZjV1U1bXJDbEV1eUxtUmVOUzhlZ0x0L1FBSDFHWVlwT3ROdkorMVhRRHpa?=
 =?utf-8?B?R3FvNkFaWXUwWkU1dElKZnU2R05ZR29mNEZvU1dJL0ppVVQ3MjNWMS9vYmww?=
 =?utf-8?B?SkxIOSttRnk5YXdWVG5SNUZSSElnWkhQMFdEWUFpWEhPdmNRalJ2QmJoRDFZ?=
 =?utf-8?B?Qi85Q1ZOOEx0RlhZZkR1MUpwSUlHbHVRK1BsQzNNU0RZaUUrKzBTSG9oR2h6?=
 =?utf-8?B?MEpyUVBtRjZVemErWUdJWStjRVRFazBULyt5Q3NrRUNQemNWbjlIaDUrMHV5?=
 =?utf-8?B?Tit3ZlVRRnhDY3FJMkhOT0FwSTFPbWJsa0V2Yzh5UjdHNVVDdHBDZExCOFdT?=
 =?utf-8?B?TmEyb1owR0U0MFYzaFFCbDdhYTdXbm5SYW9FZnMvNmZqTnJzWHVtOTBlSW52?=
 =?utf-8?B?OHFCRGFuVkJtYmt3N2xmU3FTSmk5akhGbE1UVzZqOXhod3dVV3Z1NnhsOVZL?=
 =?utf-8?B?cnJMcEY2RzVBWkozSlRZQjhrZWFuYXFEWXNUYTVRSEFuQUhZeTc4WGQycVlw?=
 =?utf-8?B?N2NsSlcwUmJkeXUvc1lmb09DMUZQMHI2cG1wS3J5bDZHeHB4ZzlZKzNhaGEy?=
 =?utf-8?B?Syt3RVRRcEFNZ2Z1Wk5MTHBzZlZRZ2JRSnJhc3pJSjNkTW5SUmVxQkYvWHUw?=
 =?utf-8?B?dDNQMWUvOTNDcGpFZk5Kdy9LanJWYWY5U2ZFd241UkhXOG8zZWh5MFhGY0M0?=
 =?utf-8?B?Tk03WlN1WjA4QWExdW9FK25lbTd4K3BNUHU1bitaOWw3d1JPVThLQmJiSUZT?=
 =?utf-8?B?SVJ6emFKSmo2ZG9mSGdTbHJUY3JxN3Z6dUM4OVRBVk9HZ05RRHhVektwbEdT?=
 =?utf-8?B?c09kKy8xbjE4TEh0YlhEQ0ZOZUNDaFBraS9XaHF4Zkt3ZktkSDdpV2ZBbFJz?=
 =?utf-8?B?Z0dLRWVqWjFsYzZKZmt1My9pSnZjbUptTXc4c0RlNGE3V2UzSXQ0UXZDbEpo?=
 =?utf-8?B?M3VTdjI0YnpROHpHRU85TmJzTGQyTkE1OExUU0NqQW4wSjFIR09kbkhqOEwy?=
 =?utf-8?Q?4F5WypKUJFMdFj7fEDL8JDM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e978d80-dd21-46a8-930c-08d9e2b96e5d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 23:53:50.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l67bGWzwT5FYgoVrEDXJ5aW82bBZTsazuQibv5xBnQqU8d2h27EEdOOWuL/0Gt+UywcmkDJgK+ge182DAKUQNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5108
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280129
X-Proofpoint-GUID: 8SCvLWbyCukSfqIs7TlLpR8RZMDRJEQS
X-Proofpoint-ORIG-GUID: 8SCvLWbyCukSfqIs7TlLpR8RZMDRJEQS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 15:34, Axel Rasmussen wrote:
> Besides the help text, looks correct to me. I applied the patches and
> ran the userfaultfd selftests, and everything seems to work properly.
> 
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
> 
> On Fri, Jan 28, 2022 at 2:26 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> With MADV_DONTNEED support added to hugetlb mappings, mremap testing
>> can also be enabled for hugetlb.
>>
>> Modify the tests to use madvise MADV_DONTNEED and MADV_REMOVE instead of
>> fallocate hole puch for releasing hugetlb pages.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  tools/testing/selftests/vm/userfaultfd.c | 67 ++++++++++++------------
>>  1 file changed, 34 insertions(+), 33 deletions(-)
>>
>> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
>> index d3fd24f9fae8..f5578ef85560 100644
>> --- a/tools/testing/selftests/vm/userfaultfd.c
>> +++ b/tools/testing/selftests/vm/userfaultfd.c
>> @@ -88,7 +88,6 @@ static bool test_uffdio_minor = false;
>>  static bool map_shared;
>>  static int shm_fd;
>>  static int huge_fd;
>> -static char *huge_fd_off0;
>>  static unsigned long long *count_verify;
>>  static int uffd = -1;
>>  static int uffd_flags, finished, *pipefd;
>> @@ -124,9 +123,9 @@ const char *examples =
>>      "./userfaultfd anon 100 99999\n\n"
>>      "# Run share memory test on 1GiB region with 99 bounces:\n"
>>      "./userfaultfd shmem 1000 99\n\n"
>> -    "# Run hugetlb memory test on 256MiB region with 50 bounces (using /dev/hugepages/hugefile):\n"
>> +    "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
>>      "./userfaultfd hugetlb 256 50 /dev/hugepages/hugefile\n\n"
> 
> We should remove the path from the line above here as well, right?
> Since for the hugetlb test type, we now just MAP_ANONYMOUS |
> MAP_HUGETLB, we don't open a file descriptor.
> 

Yes, and I should also update run_vmtests.sh to not include file path.
The test just ignores the file path in this case.

Thanks,
-- 
Mike Kravetz
