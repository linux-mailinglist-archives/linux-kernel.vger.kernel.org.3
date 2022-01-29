Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027CD4A2A88
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351921AbiA2AUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:20:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30230 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348189AbiA2AUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:20:00 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SMcwYj002536;
        Sat, 29 Jan 2022 00:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nNXFWmIZvHugWkyeCyI2FgZp031eoLQbIn1ivQc6C5o=;
 b=Mazk7zlfVHvwUaqm3R7IxfEw0NHbuaRiDGsjOC6QafmNU1Shgteoh5pAcp8EyIipJFZJ
 QNvuQ32NNganqKsLi6isYOihBjrTIHBgYLXQ5J5GzRIM2VzdKGiFOLwLXJ1M9HDdmTgR
 mXieEUxyUuciyIbDqJExoZgGw5EvZ+CFYsmELjzxeBwGAEMQjX4OTPfK39RwnpXW6Yvq
 LI+rCfaWQI32m+WoBcpV1RgNN+/qV2U8kFXetSnjc6uPPp+KCsb3DHyZc9URSrQ5TWL0
 OA5pbdi9rcix7e5hROwTCCGM+v3u7UyZ97jeRKHTCCH/5mi/TrYe+K4c5LNTBAwhc70+ gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvnkcw5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jan 2022 00:19:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20T0B8oe076452;
        Sat, 29 Jan 2022 00:19:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by userp3030.oracle.com with ESMTP id 3dvtpsgh4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jan 2022 00:19:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJmA3kcYWVg9Ci5TXo+oXfzEgAlV2mlw1VYw5NZf0TMNTMU1cn7VNo7UxovLflOlRsDYGQEBf7dUgNJV1zeinPezNlV4j0g8eSXN+/t+Xp2b27mBe2+VLLhrxNtZ+Iem50Fv/jtDOFDBHvmSBrUsY4kfepNtB+zMcaysqvllTMWNKLWtPULlt8P9aEeyP5Ut6CxQK19v4FEyDV7hiYg5qRCXY3OEP/3Ddmqm3uCqpkIhMn4r9n4/U9Kin2pOXXd/cF4Ta0xDmVUh1moO6p6v4NK06LQefqxp8UzV76OFP8sn3zEbIJteLoJLusPkAig+pFjJmPkH4C61BcLpMcHCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNXFWmIZvHugWkyeCyI2FgZp031eoLQbIn1ivQc6C5o=;
 b=hRveGVd+9TG3TooiTdTEHc0F/d65H97YwAZJeMh8QwkVqfL698fv4CxvOUeO/wkd7Q6J4KNIpZqOtoRkCeYxk5pvIj2rePOSbG33ddjvnq1oUQW/IxivcvMelmDDVhDYXWgoZAgjgeB3dNjrkxSq/unxt4jqzw1tKvSHgbVjgEu7Pa6bjGqPkDxSVOccdZQZ07f0w8tmdOPHvSif7syVge5otatFRfeh+QDd9NVUihlbrdHBdm829Ajlo+1JeeMZJFtNGH5u42vKU73zmnSjq/4Z/9LwPQ6u8yNrvIznb3jOidOj3gFW8q0DAVK1YkmuI+fpQX0PG8Xku3HBY4K7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNXFWmIZvHugWkyeCyI2FgZp031eoLQbIn1ivQc6C5o=;
 b=BUIMyG9W9bILHLKgRV7scUU0+FOFHrCClPpYac9MVH9E9PYAk3HMdHOpX9P25xZSwvvUSewIp+Y4noshopWTgAO/5+jkb3IK6e/9F3BWsan4MSrvEF5wLEoogr4Y0J7+KSxFS2yKpfd3mLsVXnmSDz2RHdg5915xCddXx+OPc1M=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN8PR10MB3458.namprd10.prod.outlook.com (2603:10b6:408:bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Sat, 29 Jan
 2022 00:19:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.019; Sat, 29 Jan 2022
 00:19:34 +0000
Message-ID: <874277c4-7d5f-73ba-1158-1a2d7e0df9cd@oracle.com>
Date:   Fri, 28 Jan 2022 16:19:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] selftests/vm: add hugetlb madvise MADV_DONTNEED
 MADV_REMOVE test
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220128222605.66828-1-mike.kravetz@oracle.com>
 <20220128222605.66828-3-mike.kravetz@oracle.com>
 <901f1117-e1ba-d5f3-f711-b3b581bce6cb@linuxfoundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <901f1117-e1ba-d5f3-f711-b3b581bce6cb@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0267.namprd04.prod.outlook.com
 (2603:10b6:303:88::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 705dd1bd-5ebb-43a1-4c7e-08d9e2bd071b
X-MS-TrafficTypeDiagnostic: BN8PR10MB3458:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB34589A46E2ED21B49510B3D4E2239@BN8PR10MB3458.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MTtyZc0iEerXqkSfRE1UHr2J5ZknqFkvpakn7rjInBN+OYKaxhIDZ8ewopEy1bkcCJAjKQeCSEKi746xU6Z/FCG/lrLqde0l/4Iu5Ohyud6B4l/GNtVp45iDTI+d3bNm7Ok6J3ZDi8kQ69P0LI9Tt84fK9GGhuqwSkNB/KUkz9Hq7AYxoJvR2Ok5cSrBoIkuxKa+TLSLYyTYtC432BdMWeX9yMIOQBGu6QiHwTm+dOR4oz/B7tsNxc0svgDEfL2TdU71dhN7gl0xsWwj7rrbYx8+zvbpBBPZHz5iocfloUEAjNONgGBMl9LIiWSUz8khLsziVvsv3X7qFJs1/JA2WXqLr20qxPxaupo/0gFkQldC6gva3lw9rDgUrdBU4mcL8hFQ/gbPpW9jLhmct1q9VMOFfQjQFtOyyOv+8iubJfSoWEPdFcrJvpfypZva7oMm6/BDbw8wU0+TlURYBRCxlm71pPgU3AsFDnRw2l1bFeMhN3uvy40MnXe9lujq1ztJeuJjlXN7JPk9FvwJ3OOFOgYJK1W3VrkD/WS/xfKGWS/eunuNfl77FGhZRkfkHzBbp3SVo6Aa/vtEZBzddOe2HC9yXRAHG7NALwUvsR1WzrkG279QUvUp1ux4JGv0JUCsvrBxu+u18WngKxY4LFHrDhL8NBYEg8sT7sOQoRE69u/PSRT9Kt9bC+2PCHSwlChrgCc35JOIkseRMNqMcf+CnovhP+W9FTsQa9NlJgTGEh1A7PkDWmlfDVvsACaXZZT3Lxp3QLCCTzkQ3ToPEiFMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(38100700002)(2906002)(31686004)(8936002)(316002)(8676002)(36756003)(66556008)(66476007)(44832011)(4326008)(7416002)(5660300002)(26005)(186003)(6512007)(508600001)(2616005)(6506007)(31696002)(54906003)(52116002)(53546011)(86362001)(83380400001)(6486002)(66946007)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZThMK21CcjBWcUNpVzVubjZ6c0k3MDhyQ3dHSER5emtMR2pocWNVZ2RvS2Jr?=
 =?utf-8?B?dm91dEFYYXlHcURmNnlXRlhoK29tM3Rvc0JNNDJSaEIxYWF5SktDZU9VNXhz?=
 =?utf-8?B?aERXY0hvc25Yclc0em5yaDd1NEpSRzlHbDBkWHowOFJQV3VRRnpKWW1EYXhk?=
 =?utf-8?B?T2cwR05EUFpRNmd4Mk5mYVgva0lHUFNBTjVtK2JCL1lNYTJnRHNzR0RRRTlZ?=
 =?utf-8?B?N2R2dzV3OGZONnBRUzM3cWFBeTZBMTVEZ0t5WjlqTUtmTk54NFVlY3FEWmc2?=
 =?utf-8?B?RVMxWk9PZkZwWXVuL1lwMkZ1RDh0NnRiVnQrRkcwbjZkcGthTEd2Q2J4YUs3?=
 =?utf-8?B?eGJWVzgyRGplODJpaFRHVVVxOVZOWm9LWWl3Z09EOU01dnlUT3ZHenIxK09a?=
 =?utf-8?B?QU8vZlRaSVZyS083cFE3cjV2ODJWNEdydmJZd2Z2ZE16dDZtb2pKNFBmcWx3?=
 =?utf-8?B?Q0hZbjdiS1ZGa2o1SGJDdWp3dFdXekZaUjJ3VHRybVNjblRZVFNUbHFGZ2g1?=
 =?utf-8?B?R0toOG1vSUNtSE40S3JBM3I0MGJHYWVyM3llSmFvVHlNSVBKbkV3bk1XT093?=
 =?utf-8?B?b3NYMnBpazBFY21XUnRtYkU3eXVZamt5VUw3akwxU0tGT09vcitYQ01oT2lm?=
 =?utf-8?B?cnRrR0ZWa0poOUgwQUlTVFhoWS8zMmtnaTZjaU8xcmRrY09XTTFicmgwWFlK?=
 =?utf-8?B?UzFLSGFrZmN6aEhnQ1lTZDNwRGRtVFZyMTI1MjVZdGpScFp1VWpMR2t5dnVZ?=
 =?utf-8?B?b1B0YVZlZy84V2xhN1RodThzaXNORFd0VlNJL0txS0NkVjJDKzJ5ZFJVUHJZ?=
 =?utf-8?B?SmZyRTFFamNGbXQzQXRpSlN0dkttRnBXRHlGWWEyMG1KbWgzdFZxekRpVHVM?=
 =?utf-8?B?ZURwT3QrbUNtWHNsOENsbzZDeFoyZ2FTRm9XQzdSN2Y1MW05c3hJNEJhL3Fx?=
 =?utf-8?B?VEFpeUk1SExmMFZXd2xZZjJxdXphWHU4V2VDZFh2TW83YUQ5cmk0bHpPSW1E?=
 =?utf-8?B?YnZ1UTVQTmlabnFvL0RoQzA0bUpUajFUTkQwdkJ4dlBweVNpOVRTZUdUdkhJ?=
 =?utf-8?B?MjFPYm5Sa3VmTVIzQlExRzBwSGhWZHVCZDU1YUNYREd4NzNNZW5HOWYrUWM5?=
 =?utf-8?B?WlpsbWRDK2ZKZmU4bTR1MFVHa2NGRTI5OGgxT0cvK0REL1UxRDVkR0NQWjB4?=
 =?utf-8?B?OGZLVTYwZmFjK0ttai9NeWdORVR2VUN3UXExK3YyYVE4SFlFWG5QU1FPeFhK?=
 =?utf-8?B?cUtqdStOZVQ2QXg4VDQxV0h6RHZRSTkveEtpWGdTNFFlelRvbzhWdXIrSlJt?=
 =?utf-8?B?SGdMQ2U3Z3YrSmN3S0Zzb2s4ZXZiZHJ6cnhzZTM3Yk5pcys5SlBWQ1BFY3h0?=
 =?utf-8?B?bTZIeGtqM0wvWklHdGQ1RWxoQVg5YWNyZ3hETTg1aStTVEhTcGdhaWpvQXlV?=
 =?utf-8?B?azRudEY2WWNhUGM5alVyWWpmUFhQbzZCQk83Tk5Ha2N0NENPZi9WOEhkekJs?=
 =?utf-8?B?UXBMQUhhUW9pZWYxOVFObjR5alo4NDdPbE9DcDZhM3cvMm42MzFOcGtVaXpE?=
 =?utf-8?B?aStpVFZLVktqdHhaMmxKMGw0NFFQS3NuNmtnQXEvMkN0RFJKbjBjVGozRnBX?=
 =?utf-8?B?aHFIb2lCcTVxamhNaEh4aHh6bm1pMDBrQm9ZM1dwY0x5L0tubFlRRkhMcE9p?=
 =?utf-8?B?VEN2L2ZkMFlCN04xckg0VzNycm9XYXkralluZFdHVmpZMHN1R1F5Y0VzNzlp?=
 =?utf-8?B?bEc3RlhrRzIrLzBONEM5LzFMZW50bmdsTW5wZmZhbDBHbTV6RWsvVExnZ3hw?=
 =?utf-8?B?a0wxMFF3c0t5ek9rNkJxRWdXNVlRb1NDNG4vQjQ5Wi9uQ2dzWXpvL3ZrQlh5?=
 =?utf-8?B?R0xIdGRoVUVuS2lKY1ROaW9Oc0Q4ZU51bDhFeGs2WjhwQm5ORGhUMzQ5cVhR?=
 =?utf-8?B?SklUUmVyRlVVM0pZandaN1dvM3F6V2VBUGFUVnZpSytEY2YxRml4dUo5MytJ?=
 =?utf-8?B?eW5oRnViaG9PWU53TG5ST0ppNkQzUm5ZalNPV3RHQ3pVSjdjbnF0L09sWWxy?=
 =?utf-8?B?aEJsUE9KS2RpOVpjQm1JMjhmWVNRRDdBc1JUOHFvZ3E2NytUSnhhS1lMSDVS?=
 =?utf-8?B?eHVQVXVpSlRtMDd5dzcxcmZRWFkxTUc4VGVPS0hxTzExbkYwNFBnVVlmOHRw?=
 =?utf-8?Q?kituhXzgVCQQCw0DF3g3uhY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705dd1bd-5ebb-43a1-4c7e-08d9e2bd071b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 00:19:34.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RN4QGBjff57y4rc2gGeWMYBYsLeYkH13QLT9v8CQj6W4F2qRnA4O9fjiCe/SWFj5xzmiA898VXiHkkAvKZG5cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3458
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280132
X-Proofpoint-GUID: tSQFI_ehdI9W2RyiGL18Jr8Mr40qIQ56
X-Proofpoint-ORIG-GUID: tSQFI_ehdI9W2RyiGL18Jr8Mr40qIQ56
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 15:46, Shuah Khan wrote:
> On 1/28/22 3:26 PM, Mike Kravetz wrote:
>> Now that MADV_DONTNEED support for hugetlb is enabled, add corresponding
>> tests.  MADV_REMOVE has been enabled for some time, but no tests exist
>> so add them as well.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>   tools/testing/selftests/vm/Makefile          |   1 +
>>   tools/testing/selftests/vm/hugetlb-madvise.c | 401 +++++++++++++++++++
>>   tools/testing/selftests/vm/run_vmtests.sh    |  12 +
>>   3 files changed, 414 insertions(+)
>>   create mode 100644 tools/testing/selftests/vm/hugetlb-madvise.c
>>
>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
>> index 1607322a112c..f60cf43bbf61 100644
>> --- a/tools/testing/selftests/vm/Makefile
>> +++ b/tools/testing/selftests/vm/Makefile
>> @@ -28,6 +28,7 @@ LDLIBS = -lrt -lpthread
>>   TEST_GEN_FILES = compaction_test
>>   TEST_GEN_FILES += gup_test
>>   TEST_GEN_FILES += hmm-tests
>> +TEST_GEN_FILES += hugetlb-madvise
> 
> Please update .gitignore with the new binary.
> 

Will do.

>>   TEST_GEN_FILES += hugepage-mmap
>>   TEST_GEN_FILES += hugepage-mremap
>>   TEST_GEN_FILES += hugepage-shm
>> diff --git a/tools/testing/selftests/vm/hugetlb-madvise.c b/tools/testing/selftests/vm/hugetlb-madvise.c
>> new file mode 100644
>> index 000000000000..31c302528f2c
>> --- /dev/null
>> +++ b/tools/testing/selftests/vm/hugetlb-madvise.c
>> @@ -0,0 +1,401 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * hugepage-madvise:
>> + *
>> + * Basic functional testing of madvise MADV_DONTNEED and MADV_REMOVE
>> + * on hugetlb mappings.
>> + *
>> + * Before running this test, make sure the administrator has pre-allocated
>> + * at least MIN_FREE_PAGES hugetlb pages and they are free.  In addition,
>> + * the test takes an argument that is the path to a file in a hugetlbfs
>> + * filesystem.  Therefore, a hugetlbfs filesystem must be mounted on some
>> + * directory.
>> + */
>> +
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <sys/mman.h>
>> +#define __USE_GNU
>> +#include <fcntl.h>
>> +
>> +#define USAGE    "USAGE: %s <hugepagefile_name>\n"
>> +#define MIN_FREE_PAGES    20
>> +
>> +#define validate_free_pages(exp_free)                    \
>> +    do {                                \
>> +        int fhp = get_free_hugepages();                \
>> +        if (fhp != (exp_free)) {                \
>> +            printf("Unexpected number of free huge "    \
>> +                "pages line %d\n", __LINE__);        \
>> +            exit(1);                    \
>> +        }                            \
>> +    } while (0)
>> +
>> +unsigned long huge_page_size;
>> +unsigned long base_page_size;
>> +
>> +/*
>> + * default_huge_page_size copied from mlock2-tests.c
>> + */
>> +unsigned long default_huge_page_size(void)
>> +{
>> +    unsigned long hps = 0;
>> +    char *line = NULL;
>> +    size_t linelen = 0;
>> +    FILE *f = fopen("/proc/meminfo", "r");
>> +
>> +    if (!f)
>> +        return 0;
>> +    while (getline(&line, &linelen, f) > 0) {
>> +        if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
>> +            hps <<= 10;
>> +            break;
>> +        }
>> +    }
>> +
>> +    free(line);
>> +    fclose(f);
>> +    return hps;
>> +}
>> +
>> +unsigned long get_free_hugepages(void)
>> +{
>> +    unsigned long fhp = 0;
>> +    char *line = NULL;
>> +    size_t linelen = 0;
>> +    FILE *f = fopen("/proc/meminfo", "r");
>> +
>> +    if (!f)
>> +        return fhp;
>> +    while (getline(&line, &linelen, f) > 0) {
>> +        if (sscanf(line, "HugePages_Free:      %lu", &fhp) == 1)
>> +            break;
>> +    }
>> +
>> +    free(line);
>> +    fclose(f);
>> +    return fhp;
>> +}
>> +
>> +void write_fault_pages(void *addr, unsigned long nr_pages)
>> +{
>> +    unsigned long i;
>> +
>> +    for (i = 0; i < nr_pages; i++)
>> +        *((unsigned long *)(addr + (i * huge_page_size))) = i;
>> +}
>> +
>> +void read_fault_pages(void *addr, unsigned long nr_pages)
>> +{
>> +    unsigned long i, tmp;
>> +
>> +    for (i = 0; i < nr_pages; i++)
>> +        tmp += *((unsigned long *)(addr + (i * huge_page_size)));
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    unsigned long free_hugepages;
>> +    void *addr, *addr2;
>> +    int fd;
>> +    int ret;
>> +
>> +    if (argc != 2) {
>> +        printf(USAGE, argv[0]);
>> +        exit(1);
>> +    }
>> +
>> +    huge_page_size = default_huge_page_size();
>> +    if (!huge_page_size) {
>> +        printf("Unable to determine huge page size, exiting!\n");
>> +        exit(1);
>> +    }
>> +    base_page_size = sysconf(_SC_PAGE_SIZE);
>> +    if (!huge_page_size) {
>> +        printf("Unable to determine base page size, exiting!\n");
>> +        exit(1);
>> +    }
>> +
>> +    free_hugepages = get_free_hugepages();
>> +    if (free_hugepages < MIN_FREE_PAGES) {
>> +        printf("Not enough free huge pages to test, exiting!\n");
>> +        exit(1);
>> +    }
>> +
>> +    fd = open(argv[1], O_CREAT | O_RDWR, 0755);
>> +    if (fd < 0) {
>> +        perror("Open failed");
>> +        exit(1);
>> +    }
>> +
>> +    /*
>> +     * Test validity of MADV_DONTNEED addr and length arguments
>> +     */
>> +    addr = mmap(NULL, 12 * huge_page_size, PROT_READ | PROT_WRITE,
>> +            MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
>> +            -1, 0);
> 
> What is 12 here? Any significance to this value? Add a define for it
> so it it clear why it is used.

I'll add a commented #define for the 10 as that is used throughout the
file.  I'll add a comment here about mapping and then upmapping areas to
make sure nothing is mapped at specific addresses.

Thanks for taking a look!
-- 
Mike Kravetz
