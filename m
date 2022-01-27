Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928BE49E969
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244953AbiA0R4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39500 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244795AbiA0RzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:22 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RFu4Ip012792;
        Thu, 27 Jan 2022 17:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KOJm8mbIk/MO6dz//mcuSW4m0HL+T1gLt+D3YG+qBbM=;
 b=R9stXyUMrMuMDm1wsoTMmyyN5qtZoYWuvHdHuR6ECWFkn5ba/N4KjojqlFK1jaFa19aL
 ZgNKOhnfPJlRxumOPVGLaubYUFM9oKjioSqLe5I4KfKabccfh19M6RuGEaPLJ1fNdaVc
 mqc8U/GN+FWWQWC72LguDwyglsAAdIh2p/rM6mL+hhLnrdB0rWkFC5v/7bmdcSdV7ne/
 ykU2/quD0h+p//pBcz6urFahDc4PwHxUkJo4el+NBzy584g6mj4Mec8PyQGBPEWfNI34
 sPw2wD7ZNETcMJM5lAP45cu4twdf/944DQ4pd3G/SS9Y3AspcMfE8e6DoTE+6i2H7ybj Vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwub0mr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 17:55:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RHfL86069058;
        Thu, 27 Jan 2022 17:55:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 3dr72408wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 17:55:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FATsqldhTMrPDwb4nqs4qA9g/NgSSJHYwdQwoSvyhM6W7fS+5eIN/Vn7LcFVAVqGeMqdRiE6TGEb44r/N35TZ/qL7T2oylpfq9Um2ecky8bgsG2Ma2SzgftpcwsR+GpHdcH7I7GjwPspNCq847GM4+wQkAe3DEHfHse6B1yAwInLfLs2a1F3gXDoW6ICqJ9pVE7AUF0eMQhzFVOrq/ImxQp0DvPWEoLBHZLrPeZXGThKxDTeX1tqqlqzcTf+uITWIiqp4VZoREbhDIsMLguoGAtLZPB+KDWacBiiZWnujTFaZ9baHu56DWRm+rjvfetMk5c2PkqS200eDK5W6F+bFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOJm8mbIk/MO6dz//mcuSW4m0HL+T1gLt+D3YG+qBbM=;
 b=T/ORCi4VUeQ221yp1tQwXz49O+gbtn2Uz8vEJW6r320zCQRhlTtqDGOa3uwI3nxM7vyGE66EFMjCfaQsb1RdpY4w6YQEWxzHHWoE9P820+RTSDMOowRYncGTVo2T64EnssR7pjWeQfCuYF84Wt71cmxSMqJFaMbfjcGaLe2pWFncd6buAragi/DdBDTNd9pp3bH8d1KV4DmXpkfxew8mRTIhXNJuGYoNaqAqJRlCU6/IF4TBRgMQ2eYtAuFOpZJNd5vJV8ed4fD9+sRDVLH06Nf/hZxc/3ffj/Th++r8onK9/hxE9FvNnjR8EhfSoxrEIa0LEggdFek07ips5HCvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOJm8mbIk/MO6dz//mcuSW4m0HL+T1gLt+D3YG+qBbM=;
 b=n9kX855sDVbH+icCYhnOl6EGDO47+HT6obHPPOWYMA8bTy0+AAQ6NhDzdoUL2xMzp7lp/+2lqtqqAVpEfJPy9/5pMYBjywZCUA5DK/25aI8/BC+axJWLCcUuI6fljdWxYzp/bNDfL3fq+f7H0Pxegysh36RAb/BSl7CztovmS+E=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB4956.namprd10.prod.outlook.com (2603:10b6:610:c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 27 Jan
 2022 17:55:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 17:55:05 +0000
Message-ID: <21242c94-6748-b76d-f38e-5ac140c6117b@oracle.com>
Date:   Thu, 27 Jan 2022 09:55:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 0/3] Add hugetlb MADV_DONTNEED support
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220113180308.15610-1-mike.kravetz@oracle.com>
 <b476e461-aba9-e92b-d392-270029ab6b18@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <b476e461-aba9-e92b-d392-270029ab6b18@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:303:b4::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0b2a1df-e288-4e6c-2b58-08d9e1be2675
X-MS-TrafficTypeDiagnostic: CH0PR10MB4956:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB4956DCD46FF1DF59DC3A62D4E2219@CH0PR10MB4956.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ab1V/gfqrInViD16t8qMfXWpeyZ8ho40v6q36C7uMURwHNGl7M/sl90weKHNoaGi/2t3Grt7oD3l9O8oFVZrPwlZvSUg33htgFOPupctrIDlpWNjr2og4emX+BD0PNf3jjGra7OdJlrm3NJuzQJ3Erk5JcnvHwGR5er0PhVD/wHo9Nd3+2orXLL8dX+AgYYllKg6bHy0se/s58qSesImjGP2feuqri2GAF1UCDC5/WdxpONzMn1x80sDQMbvj3gtD9BrzJ3XLtobX87A6fmuWVh4ArSISVOOmIFNhdE6h+y1kTqsbTV6+8a8xmE16wlmtYWwh0Bkpey0RB74dGQEqWdgPK1ZY8wG0JYu2BBc7+7NklG7okePqIrVi+6C/ncXLNZxenWPeuPuQn420UBkUvDkNhcJg/7xgOxKC+eUvQKuNYlQkP3HYZiHEEb6Co7Usn8tcLhBL/WQf7FFZdM/VokQf55E7/J8KZJp8hEjphSl5lA02YJTxA3gkAK2kFOzF5T6+WmCpgc3X0HuUVfQSelSGuRZIcQjb3rrXsIAsotdh8qblYd6iKcCKMWwGAnvtsFYmJbVE+EamR2Occ12KfkpEg1bB4C0uH5efktBhPXGijd6p+Y5tT+WT5bVJkb2PHIHyqQ2I0Wo4zN9JbkQ7ur9l248ic2O68zxNc9yKq9NuemgaRUTBV1mjndqcj/MyGiUQQWarauVSDqMKp09kyIOCarHvs54op7rnY4NxZfHOllFKPWoIE18eeIbk8HB0XeEaGxrzW6IZFL49AqNpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(7416002)(4326008)(6666004)(66946007)(6506007)(66556008)(31696002)(86362001)(83380400001)(6486002)(53546011)(316002)(52116002)(8676002)(44832011)(66476007)(8936002)(2906002)(2616005)(54906003)(186003)(5660300002)(36756003)(26005)(6512007)(31686004)(38100700002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVdyT0ZmN3hhREp6blVoL3FhTUtiY3IrbnFnZE1uRUw3S2pwYmswSEMvd214?=
 =?utf-8?B?eGFUVklFL0FnMWdPSGQzdGtDK253WEN6bEpYY3o4YS9ja2RXQmN2YTJ2SEIy?=
 =?utf-8?B?VFJQYjBBZ21PUGlDYXFwbHU0OE1ZbWFjb1VnNHhCUFlrVTFpY0NyTUdCWVlk?=
 =?utf-8?B?NEJXaUh1cnBmYnBKR0drT3lXQWdtb3U3dEp6NlY0RXYxbkpGbGhlR3dJZXJy?=
 =?utf-8?B?WlIzL1ZOeGRHeGVMNzNNd2lpTGUzZTh3TmlNWEhuNE1KVTV1clIvZmEyc3Mr?=
 =?utf-8?B?SmVQYmpTRHd0VGtFeHlYaEF6eGVIamV4N0VFdWJxWmFWWTJtNlo0bkgyZ0RU?=
 =?utf-8?B?cHREZUdkMFY4NUV0WjhjWjI3SjRQRDZ6Q0xjbVh2OTVOYk5TajdtMWNHbjJN?=
 =?utf-8?B?M3c1SjFGNXVneFBRc0VmVGNyeWhkWUVLTllMRVNoOHRheHJ5SzlKek5KejQw?=
 =?utf-8?B?a2tsOFgyeEREVXkwTmRhZGhXczlJQjZHaE1mWmhKYnh3MGkrS0xIL25XWklJ?=
 =?utf-8?B?L2hNYm4vdkFvdWd6MXFIY0xjTEtMclkzN2xlNDZxbHNYK1JYcWQvempTSXJP?=
 =?utf-8?B?RUM5YW1QRVgwUXp0Zkd5d0RCWldSVXNhTVNtZ09LcEZLYmIrQkk1NXJEUExx?=
 =?utf-8?B?dUpPOVdEZkNHNm95WUE1OUFKZ0w0cXZxeXVranh6SE9JWEl6NnFYTzNwam9u?=
 =?utf-8?B?OXBKYlkvaGt4QUhsZFpIWTAweFBOWGZyVGN3K081d1dxTGt5N1l1WnN0ZnMw?=
 =?utf-8?B?VHFCa2dpMDdTVFJXVkxGUDl4c0FGK1FpbStneDRSQk40UkxTenZCUm91Qk9R?=
 =?utf-8?B?YjduQUx5UFc3bXE0dTlyeHUwRTdyRzBhNDJuOHZBOVR6SVc4d2ExK0ZkSS9C?=
 =?utf-8?B?ZkR6aE5RTDZVaEFrcW5UTVgxalI4OFpYaUFSdnF5Uk0yM2xyWVM0VldvZ2Fq?=
 =?utf-8?B?QzhTYitkYURSV3ZkcitVNVNZMi9XQjU3YlRFTlJYTjZyQjVYcmJiNTZVSlJE?=
 =?utf-8?B?emVBL3lUQUY5QmFUSlYyV1lpQnowUUpUVHVEbXkrZEpab052OWFDUVZjaFBk?=
 =?utf-8?B?WG1pSXpKZ3Fxd293OC94Q3BJQStNU3J4NXFYcFZJa1ZqQUs0Q3B0RHhhc20v?=
 =?utf-8?B?UTRLTFFEV05nUDBHK3FrcWNiOEplcHF2aHVxQmFZYk96SGlmN3MyYmp4Z2tH?=
 =?utf-8?B?L0piaUNHM3BqRks1TFI4T0I0NFM5T0NrUytzQmJZVFA3WTFJU01wOWNpMFl4?=
 =?utf-8?B?bGc0SDloWUwrMFRyNDFldEo1d0hNM2xaTEdkS0E3U1ZoTURPTmVuSTFLeE1S?=
 =?utf-8?B?VnhmM0k4Q0twellPb0dmUUt4RkN5aVNrbTdQQzV1N1k4N0ZqOGxaWXgwOTZB?=
 =?utf-8?B?Nlp2bkxEUUo4NGJJSTZ6R2prQ2tNalpxUzlSNmVqUW9BLy9jc2xXcm9hcThv?=
 =?utf-8?B?RlFNMG9pZzJWN2hLNU1BTzFHeW5LTTUvWlRGRHh1Ujc4VitFdENkUGNCWGxY?=
 =?utf-8?B?OUN6L0dIQVl0V0dYWUFrZnZNdEgxNnJhMlgxaTFseEExZDcveklTNWNSUFNa?=
 =?utf-8?B?RHROenRvQWNQRjBXYmxUbGQvUGdTYWZ6RWxvTmpIOEtlaFJNa0tSSmtNUFdu?=
 =?utf-8?B?Wmg0ZWdoalk5OFg4dEtxMmJBL25hSXhBK2xIS2RsSmM0RUE3ZjVSUTZGeGZ1?=
 =?utf-8?B?QTN4Umg2S1NHLzJmS3ptZWFrSXhDbUpOQXR0SGc1RFp5azdDTzZxblovVU5r?=
 =?utf-8?B?WGNJRzU0MW5VeU9mTDJYTTZmSDJSejZRUmZzOEw3a20xZlJIV1IwL0ZMWkpR?=
 =?utf-8?B?TEx6bTlwQzJ5UnBMNGdvU21jaFMrSnpuUUpoUVF6czFEY3BrK1pxaVlJSHEr?=
 =?utf-8?B?d0x1clNoUitDL08wNi9QeUNCSFMva1dtRjdrWkJqM0prNXpyVlJkaEhOU0FB?=
 =?utf-8?B?TDRqR2pTSGZvNFdodGF5YzhQa3g5aWpaMzVGUUZjMUFnM1phaWhDdGVPMzlZ?=
 =?utf-8?B?WU9JNzJ5VHpmTGx0bWdJenhoME83TTExWm1NbEtWZHZGYlJIOTZtQ1RsQjdN?=
 =?utf-8?B?TW44VkpHSnl4LzBITWtHQVJIelptRGZnZXI0dlh3bVVqcGhXR1p0SUgxdEVL?=
 =?utf-8?B?cmw2QWROTklCZmwrY1pFR21NNmlUVSswUFB2QkhQSjE3SGxrMmpoUHprMUVk?=
 =?utf-8?Q?65iQW5cmB7UWvas1otGspEs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b2a1df-e288-4e6c-2b58-08d9e1be2675
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:55:05.6446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KYC7YMl3je46O5BeimTYps9bh/apFC/lFxqsEQrD/K3TonUdYQ2G5sbSvc6xMD0itxvx9Tl9jdHRihiw9LW0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4956
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270103
X-Proofpoint-GUID: bbJvqWyVqR3lVLDG9hS0dDw9if-D7y94
X-Proofpoint-ORIG-GUID: bbJvqWyVqR3lVLDG9hS0dDw9if-D7y94
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 03:57, David Hildenbrand wrote:
> On 13.01.22 19:03, Mike Kravetz wrote:
>> Userfaultfd selftests for hugetlb does not perform UFFD_EVENT_REMAP
>> testing.  However, mremap support was recently added in commit
>> 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed
>> vma").  While attempting to enable mremap support in the test, it was
>> discovered that the mremap test indirectly depends on MADV_DONTNEED.
>>
>> hugetlb does not support MADV_DONTNEED.  However, the only thing
>> preventing support is a check in can_madv_lru_vma().  Simply removing
>> the check will enable support.
>>
>> This is sent as a RFC because there is no existing use case calling
>> for hugetlb MADV_DONTNEED support except possibly the userfaultfd test.
>> However, adding support makes sense as it is fairly trivial and brings
>> hugetlb functionality more in line with 'normal' memory.
>>
> 
> Just a note:
> 
> QEMU doesn't use huge anonymous memory directly (MAP_ANON | MAP_HUGE...)
> but instead always goes either via hugetlbfs or via memfd. 
> 
> For MAP_PRIVATE hugetlb mappings, fallocate(FALLOC_FL_PUNCH_HOLE) seems
> to get the job done (IOW: also discards private anon pages). See the
> comments in the QEMU code below. I remember that that is somewhat
> inconsistent. For ordinary MAP_PRIVATE mapped files I remember that we
> always need fallocate(FALLOC_FL_PUNCH_HOLE) + madvise(QEMU_MADV_DONTNEED)
> to make sure
> 
> a) All file pages are removed
> b) All private anon pages are removed
> 
> IIRC hugetlbfs really is different in that regard, but maybe other fs
> behave similarly.

Yes it is really different.  And, some might even consider that a bug?
Imagine if those private anon (COW) pages contain important data.  They
could be unmapped/freed by some other process that has write access to
the hugetlb file on which the private mapping is based.

I believe this same issue exists for hugetlbfs ftruncate.  When fallocate
hole punch support was added, it was based on the ftruncate functionality.

I am hesitant to change the behavior of hugetlb hole punch or truncate
as people may be relying on that behavior today.  Your QEMU example is
one such case.

Thanks,
-- 
Mike Kravetz
