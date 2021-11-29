Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68273462157
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244671AbhK2UGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:06:11 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4396 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352151AbhK2UEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:04:10 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJVA7b025317;
        Mon, 29 Nov 2021 20:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=V0RdAXECFSF5vFxs9JjV/EBTRb2Rm1cbBks/1yTJeSc=;
 b=rPQYiblyER8KKECP0SMaGp3nFTwQMGtqYELKY/4ZRiGy8uwPRzYIhOhVOmrhx3fY/n4Z
 UfVOVTbzhxe3bD6bJ15w+DKtvLX+FPn6SpuDrUNpoMLUriQaRwEYdoVoRRUwl7Obr/uf
 zdNHyv1g7ttYBoUPs+EdH6NjEH39dQuqtDosW1chRFJUuS2JqFSCmeD4eRCs/Vqk8OV6
 v6rkUunXo5dd8M8/Nb6o3jz2XAYr2aB5igzj/BhQxHW3+LJzDjieDu63BJ6krFCxrPE/
 gOMCvgzuykp78byLqj8MvYW99KRFrBZPAizcDffHbofYwqZGntLvbT2Eivpd2GQH6FZv Kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmueebwhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 20:00:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJpZnP016312;
        Mon, 29 Nov 2021 20:00:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 3ckaqdcvdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 20:00:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/FAzHtH35ZZ9X0VLjdA0revwOL5vWL+j5+ymCdW/cBX4N+SpBTYSWHfPUGu/AmdgurQLp/Y6QKjVB+1Tg6o+kc0DQu5L8F8woehQ3eKYOXgDGCVdWxf9pizMJnjBbkdH3GcGm+zrCmK82xaf6GbNcIHheH8wuyMjMNXLzS+haduiaJMBp8odxBpIc5D9Pje6qT7PtYODTZ/rl69diV2Z9mwSY4pp7goMLQR6lYzzKiG5ikGd1cMXyF8BbW+xklkrTKRaR3BweUC3tfGWOr+r3jw9usRbEyxarUxGQcRy7zUz9N7MWp/Z7hNfl10th9feSnA9CcpqtKtAZgstBoLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0RdAXECFSF5vFxs9JjV/EBTRb2Rm1cbBks/1yTJeSc=;
 b=hfU9ovP+Xq3MA2wUPs1H+BPQor7/zsS5mu5+pfd9b92CF+/uEQ1vU9dZiReaDWA+hReRtxzqZzOQ7Gu9ZileFojjcWquXAD4Wfomnih+QdDCKjdXwzEDjkDQ3wZmBKGuMP3Q78AzHogzDziM3b2+4oKL78c1HbX1KHQu/9w5XJSLZdYCDrKer5g+kKfN5b6I+wEmONm4cANwZs0f/hGIa7SOu0rRrcL0uxLWGAr7x4PJkrnsGHtwfwHwXnWpVSVHrnRstjbcJIK6XJlTXZIRrSkHbTi5njZoAWpDfLPX1X1xSS5OnQ+3rcWltzCTAEj+/jb+Lu/bZMJ40+4pUnMzFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0RdAXECFSF5vFxs9JjV/EBTRb2Rm1cbBks/1yTJeSc=;
 b=w9/2LNyVwEBecCTC8eqAgIwch21rbeqihWaOCOqnFr4CpB1HeRDx1OzCOCx9jbFtyRv5LG1fhgQc+IUh7OZogZTRT5/hsWccpOUmVRefIlh8GC+y4MWvP5FiIig+Q4zZyXzBJ8HpUJ/6F1whSdcFHiUit3PGyVRrMThGhiu62vk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB1280.namprd10.prod.outlook.com (2603:10b6:301:8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 20:00:22 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 20:00:22 +0000
Message-ID: <af8e8438-4fad-1e6b-c79e-2287243b4128@oracle.com>
Date:   Mon, 29 Nov 2021 14:00:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v1 0/8] RFC v1: Kernel handling of CPU and memory hot
 un/plug for crash
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20211118174948.37435-1-eric.devolder@oracle.com>
 <46fda107-56f9-0052-892a-932875447b0a@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <46fda107-56f9-0052-892a-932875447b0a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from [IPV6:2606:b400:414:8061:221:28ff:fea5:27c8] (2606:b400:8024:1010::112a) by SJ0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:a03:39e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 20:00:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5538c93f-73ec-42fb-1679-08d9b372e067
X-MS-TrafficTypeDiagnostic: MWHPR10MB1280:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1280CEFB8B723C70FC588C6297669@MWHPR10MB1280.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFzvdhgf1vpu+U3rhMJWZgF8DUBUeNche3DpWU3GCaeKyzTqnWFGBQocpQtKJZjUIg2a3sLw2z4t800MsDObul6HwZrkfFAEa29DpM2oGOCzOsCruq75HYManOlJySRpuimrXR7Lwjb2Esv4DpVG5FAfXheNyNEmLnSlehn/vAWnZ7cmKl70IlBvk+xxjx64+5+7yi8ewKki8uxCsg+h2ddkYOqYmUK2AejJ8ZOeXT+lSFBMwnW28xhVrFZ0oVsNHWLpqxc+WE5Be2lz+7ueevK7ZnhC4wrrBhyjoRrmkgTmbnTd7DJL6vBvzhEqHlzPWhyAQp10syYyMsE/AsbwN8PZBbgBKi5t6q1ilzMWC46XfbAto8QjboyQ9PDX448HGb7vn2uZTjFi4/fE7gEjJbDWsLOnsfiIa7wxRcpwvYTi6ZxuPSkQXaEkPYfgY+Z5JS8lyLxReovij/E3L3y5Noa5JMybmj2xOT18PIf5o1bjx4hYv4HDy4Yc1O5csMs9Z8rV9FfLWfvGwxg+M0gULzv3KysRK97uO+oc0wVCWHzCvP6r265OYP34gxbWC7zk2DneJrvycj8nHIGs/EiYPi/wTx5l4R1mWjhyze4BSxufOnDYWwigkguF20u687Qmn8RQNWtqsjdQOel5cArL7Z/Sg2j4AKcWOdlAt9Dk2tpv3E70lc+Vkn6ZELUWWV/s5q3k1zX41IW6bFqe+2eukj697pvSxti26gtvxIkAG8cp5XOS264txJcJ5Oxjg8lAeY1EVnKgrR6SThKuwxlsvyu5KaIqMfsrpiY/JsY8ZB1mRf6GoLe/9d2g+R69weiL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(508600001)(2616005)(4326008)(186003)(8676002)(66556008)(66476007)(107886003)(316002)(966005)(31696002)(38100700002)(86362001)(6486002)(31686004)(8936002)(66946007)(2906002)(53546011)(5660300002)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUNXVUxBaldqK1Q4TGFHcGRscVRVWVhGb3EydGI1dlFscHJLSGw0NlNoaUhP?=
 =?utf-8?B?YWtTNXpNMjRZcjZXMHhZRnVPWi84djFyb2hVTldPWW5TSVVCZVcyTTNVTlJV?=
 =?utf-8?B?Q0k1amtVdUc1d0JxN2RNUWJSK3FyUHdmMTVRYXFtTGI1cHZEQUdNdyt1NkJF?=
 =?utf-8?B?V2huUG9TdStyS1dDd1FJUWVYRVpLVGRHanJNYjhFbTZ0enNSeG5Vam5RODJP?=
 =?utf-8?B?SnVkK2w5NVlvL21uaWFWUEpJRmZ0SnhjRlZORTE5NUkyaGVnRmxuYTgwVE10?=
 =?utf-8?B?Wk9sMkJBWUtTK2VPY2U1a3k5aVlIK2FuSW40R1FCbTlnNkNGTkpVZUFnaUhx?=
 =?utf-8?B?bERxOGtUQ2ZLWkt1TEpZMXlsMnE2NmRaZ0VoSXFOZmZvOUh5Z3V2OTgyeWxM?=
 =?utf-8?B?RCtuK2tKV29mK2ZmOG5Mb0ZmU2xzV2xkREs1SHlNWlZ3UUx5RVZuajNzbWdZ?=
 =?utf-8?B?dXNBeDdrQVgyL1RneWVacFpCeTU5bkpQR1JKQ1lnN0pSQU5SRkpmLy8xR2Jv?=
 =?utf-8?B?TUVwaGlybm0wNnhib2gzanIwa1lQd1gyUXJXNDMzNWhpVTUwRlFVcDBaVjUx?=
 =?utf-8?B?WXBybGhFYVRPcmE0NFdXRUNQUG1VN0NOWXp3WG5nc0pzWjNKS05sUVZqL0Ny?=
 =?utf-8?B?THB3clQxQ3p5MkUrWGlXOC9wVzdhVXNtZThoRjV0MTlQNDRyb2RUTzd0eWtx?=
 =?utf-8?B?dzlyL3NFM1dmajRFb1hWSXVvdG55VStsMFIwcU44RGJRektuaVV6M0p5TW5P?=
 =?utf-8?B?K2dFZGp5V0NJYUM4U2gxNFVGT3FBSWJ4ZGRFVVdzMmN0N25aakg1Tm96YVFG?=
 =?utf-8?B?U3AvNkdZYmZrR3lRdWVhVDNYbDIrTUdOdUtFVkZHMlBwa3d5TzJLK2o5VUo3?=
 =?utf-8?B?ZkNwcWRVNW5oQWh1ZXVhTU5QODlQdXN5YnUwM3RabnRxUFhBUXRDNGduZTFn?=
 =?utf-8?B?WjFGeWVTSUtwdzVRV2JYbVY3UEFTb0hYRW5GVGNQZVliTG1DSEVHMENXV0hB?=
 =?utf-8?B?bkpKaUhFZGlOVDlhQzFhcWY1d1RFbTFQYjRsV21OK0hXZCtWS3VlZVdvVnV1?=
 =?utf-8?B?WFJRYVBjYis2S01RQTh1YVNCNmZxNklDWWlWbWFrbjVXd1BpMXRnWkJEZmdk?=
 =?utf-8?B?SURPWjBUMEFvbEsycnl1T1JZZ1luVUVoL0RZV2VJblpsMXBXY1o4S3JaQkVV?=
 =?utf-8?B?d2NPTkJJdjloZktYSCs0UzlKZGVEcWFHOFdUNDQvU3JEYlR2dzJtWEMrVTAy?=
 =?utf-8?B?dE1Ld3dlV2k0cXpzOThKaThnUHJoUHRlMHpKOWhSY3luV29RdVJUTFMzMGhl?=
 =?utf-8?B?anUxSlBUNkZ2ZS9lZjlHZkNxQXRzVUU2SFVURHV6a0Y0dVRLVGNEZkxsczYz?=
 =?utf-8?B?TzhWTnpSOEpvdmZtUnpZWE9KTW8xVEV5cEk2Tm9HVUI3RGRBc1NvMWp1eWJO?=
 =?utf-8?B?QmNpaWRzVTV5Z2dzTlpuSGt3am9qNXZZSGZ5V0czV3ZQWmdEOEYyT0JOUTVz?=
 =?utf-8?B?U25VUkhLT09rWUtNV2ZnN1pBQVlURVl4TU9Dd2htL0tZSXZpK0tXUDlDb3lu?=
 =?utf-8?B?eVF3YW5ENXJ5MWRqWlByaytFNndPKy9mdEcvWXpJbU5PMTBwRDlFYVVwUXpJ?=
 =?utf-8?B?WHNoN0FnZ21JS1hoRWxNYmxyNS9HYkRXV0RjdE5YV1M3RlhXTXNHUy9CZGNI?=
 =?utf-8?B?b3VnQ3J5Q3N2OXhiZDNaa2tGLzZuTUZYNnExRHhwdDI4OXQyR1N4eHlQazN6?=
 =?utf-8?B?R0sxWW9ZR3hoaXdha3ZnVkJaM1lKWFhnVUk2SHFpRTVuMXNGVGROdTZjMjV6?=
 =?utf-8?B?UkR1WTJwY0gvNFZLb2doVWd2QWl2aVUwOGUxa2gxeDdNYWNzRTkzRnFuMzQ4?=
 =?utf-8?B?cVlpOG9SU2l3RnhzTkJoRVVIYytVRXNhTlp0ODFvNEJ0RWp6TS9nbjZRdC94?=
 =?utf-8?B?UERKTFZFRlh0R2VGWS8rczhQUG9uWmtYSmx5eGVhaW1iYzh3Zk5zZzhtQVF2?=
 =?utf-8?B?MzdWNTlzM0JKaEtMdGlsbEpiakp0clRNcTFxVHN4VUxZUTVUOHJqTGZiTkVQ?=
 =?utf-8?B?R2JGU3k0Z2JXWU1sWnRvblkrTUoyMTAvSW9rR0kwdnBsRjR1QVJvWmxVa0E0?=
 =?utf-8?B?UUNpRXJpcmRBM2RlYmdVTUhicEJNV0wycTc2UHI4NFZSOHdZaTloY0R3dnlH?=
 =?utf-8?B?a1dBdVBqOE5zb2NuTmhtVFBkOWp1eXJiWlNTNkJRbUVmZkxTcjdKUTJjRlFO?=
 =?utf-8?B?NkRTM2FVZUkxV3RtVDZhL1FNdHhENmc3VVlnS0s2VXlEaTNBcmR4ZVBUbEk1?=
 =?utf-8?Q?61zzjuLwff3BC2bq9V?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5538c93f-73ec-42fb-1679-08d9b372e067
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 20:00:22.3645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWT9HQG+Mb9B7mq2uHrFziF1va2IiDuOiJRUGxh1PekdtcfGHl4umxWVLzeD3pTVYRpWOo98N8hAr+DhFMq2ik2o68gCsTzxC4TEvUTrUv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1280
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290093
X-Proofpoint-ORIG-GUID: AibwCgn99Ociwm8chL2U_s3huwa5GHR_
X-Proofpoint-GUID: AibwCgn99Ociwm8chL2U_s3huwa5GHR_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, see below. eric

On 11/29/21 02:45, Sourabh Jain wrote:
> Hello Eric,
> 
> On 18/11/21 23:19, Eric DeVolder wrote:
>> When the kdump service is loaded, if a CPU or memory is hot
>> un/plugged, the crash elfcorehdr which describes the CPUs and memory
>> in the system, must also be updated, else the resulting vmcore is
>> inaccurate (eg. missing either CPU context or memory regions).
>>
>> The current solution utilizes udev to initiate an unload-then-reload
>> of the kdump image (e. kernel, initrd, boot_params, puratory and
>> elfcorehdr) by the userspace kexec utility.
>>
>> In the post https://lkml.org/lkml/2020/12/14/532 I outlined two
>> problems with this userspace-initiated unload-then-reload approach as
>> it pertains to supporting CPU and memory hot un/plug for kdump.
>> (Note in that post, I erroneously called the elfcorehdr the vmcoreinfo
>> structure. There is a vmcoreinfo structure, but it has a different
>> purpose. So in that post substitute "elfcorehdr" for "vmcoreinfo".)
>>
>> The first problem being the time needed to complete the unload-then-
>> reload of the kdump image, and the second being the effective race
>> window that unload-then-reload effort creates.
>>
>> The scenario I measured was a 32GiB guest being resized to 512GiB and
>> observing it took over 4 minutes for udev to "settle down" and
>> complete the unload-then-reload of the resulting 3840 hot plug events.
>> Empirical evidence within our fleet substantiates this problem.
>>
>> Each unload-then-reload creates a race window the size of which is the
>> time it takes to reload the complete kdump image. Within the race
>> window, kdump is not loaded and should a panic occur, the kernel halts
>> rather than dumping core via kdump.
>>
>> This patchset significantly improves upon the current solution by
>> enabling the kernel to update only the necessary items of the kdump
>> image. In the case of x86_64, that is just the elfcorehdr and the
>> purgatory segments. These updates occur as fast as the hot un/plug
>> events and significantly reduce the size of the race window.
>>
>> This patchset introduces a generic crash hot un/plug handler that
>> registers with the CPU and memory notifiers. Upon CPU or memory
>> changes, this generic handler is invoked and performs important
>> housekeeping, for example obtaining the appropriate lock, and then
>> invokes an architecture specific handler to do the appropriate
>> updates.
>>
>> In the case of x86_64, the arch specific handler generates a new
>> elfcorehdr, which reflects the current CPUs and memory regions, into a
>> buffer. Since purgatory also does an integrity check via hash digests
>> of the loaded segments, purgatory must also be updated with the new
>> digests. The arch handler also generates a new purgatory into a
>> buffer, performs the hash digests of the new memory segments, and then
>> patches purgatory with the new digests.  If all succeeds, then the
>> elfcorehdr and purgatory buffers over write the existing buffers and
>> the new kdump image is live and ready to go. No involvement with
>> userspace at all.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr memory must be sufficiently large enough to accommodate
>> changes. The CRASH_HOTPLUG_ELFCOREHDR_SZ configure item does just
>> this.
>>
>> To realize the benefits/test this patchset, one must make a couple
>> of minor changes to userspace:
>>
>>   - Disable the udev rule for updating kdump on hot un/plug changes
>>     Eg. on RHEL: rm -f /usr/lib/udev/rules.d/98-kexec.rules
>>     or other technique to neuter the rule.
>>
>>   - Change to the kexec_file_load for loading the kdump kernel:
>>     Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>>      standard_kexec_args="-p -d -s"
>>     which adds the -s to select kexec_file_load syscall.
>>
>> This work has raised the following questions for me:
>>
>> First and foremost, this patch only works for the kexec_file_load
>> syscall path (via "kexec -s -p" utility). The reason being that, for
>> x86_64 anyway, the purgatory blob provided by userspace can not be
>> readily decoded in order to update the hash digest. (The
>> kexec_file_load purgatory is actually a small ELF object with symbols,
>> so can be patched at run time.) With no way to update purgatory, the
>> integrity check will always fail and and cause purgatory to hang at
>> panic time.
> 
> 
> We are designing a solution for a similar problem in PowerPC. Agree that
> manipulating kexec segment in the kernel for kexec_load system call is
> bit complex compare to kexec_file_load system call due to SHA verification
> in purgatory.
> 
> What if we have a pre-allocated memory hole for the kexec segment
> and ask kexec to use that and skip the SHA verification for the same.
> For example, on PowerPC, all the CPUs and memory-related info is part
> of FDT. Whenever there is hotplug event we have to update the kdump
>   FDT segment to provide correct details to the kdump kernel.
> 
>   One way to keep the kdump FDT up-to-date with the latest CPU and memory
> is to load the kdump FDT to the pre-allocated memory hole for both kexec_load
> and kexec_file_laod system call and let the kernel keep updating the FDT
> on hotplug event.
> 
> Adapting the above solution for the kexec_file_load case is easy because
> we do everything in the kernel. But what about the kexec_load system call? How
> kexec tool will know about this pre-allocated memory hole? What will happen
> to digest verification if the kernel updates the kdump FDT segment post kdump
> load?
> 
> The kernel will expose the pre-allocated memory to userspace via a sysfs. When kexec
> tool loads the kexec segments it will check for this pre-allocated memory for
> kdump FDT and if available it will use it and skip the SHA verification
> for the same.
> 
>   Please provide your input on the above method of handling things for the kexec_file system call?

While I am not at all familiar with PPC FDT; this sounds quite doable; the pre-allocated
memory for FDT sounds quite similar to the handling of the crashkernel= parameter.

 From the description provided above, it sounds to me that excluding (from the purgatory
integrity check) the PPC FDT would be quite similar to what Baoquan is proposing by
excluding (from the purgatory integrity check) the elfcorehdr for x86.

If we can achieve a consensus on excluding from the purgatory check the elfcorehdr (for
x86) and the FDT (for PPC), then I believe that support for kexec_load and hotplug is
readily achievable.

eric

> 
>   I am still reviewing your patch series.
> 
> Thanks,
> Sourabh Jain
> 
>> That being said, I actually developed this against the kexec_load path
>> and did have that working by making two one-line changes to userspace
>> kexec utility: one change that effectively is
>> CRASH_HOTPLUG_ELFCOREHDR_SZ and the other to disable the integrity
>> check. But that does not seem to be a long term solution. A possible
>> long term solution would be to allow the use of the kexec_file_load
>> purgatory ELF object with the kexec_load path. While I believe that
>> would work, I am unsure if there are any downsides to doing so.
>>
>> The second problem is the use of CPUHP_AP_ONLINE_DYN.  The
>> cpuhp_setup_state_nocalls() is invoked with parameter
>> CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
>> the CPU still shows up in foreach_present_cpu() during the
>> regeneration of the elfcorehdr, thus the need to explicitly check and
>> exclude the soon-to-be offlined CPU in crash_prepare_elf64_headers().
>> Perhaps if value(s) new/different than CPUHP_AP_ONLINE_DYN to
>> cpuhp_setup_state() was utilized, then the offline cpu would no longer
>> be in foreach_present_cpu(), and this change could be eliminated. I do
>> not understand cpuhp_setup_state() well enough to choose, or create,
>> appropriate value(s).
>>
>> The third problem is the number of memory hot un/plug events.  If, for
>> example, a 1GiB DIMM is hotplugged, that generate 8 memory events, one
>> for each 128MiB memblock, yet the walk_system_ram_res() that is used
>> to obtain the list of memory regions reports the single 1GiB; thus
>> there are 7 un-necessary trips through this crash hotplug handler.
>> Perhaps there is another way of handling memory events that would see
>> the single 1GiB DIMM rather than each memblock?
>>
>> Regards,
>> eric
>>
>> Eric DeVolder (8):
>>    crash: fix minor typo/bug in debug message
>>    crash hp: Introduce CRASH_HOTPLUG configuration options
>>    crash hp: definitions and prototypes for crash hotplug support
>>    crash hp: generic crash hotplug support infrastructure
>>    crash hp: kexec_file changes for use by crash hotplug handler
>>    crash hp: Add x86 crash hotplug state items to kimage
>>    crash hp: Add x86 crash hotplug support for kexec_file_load
>>    crash hp: Add x86 crash hotplug support for bzImage
>>
>>   arch/x86/Kconfig                  |  26 +++
>>   arch/x86/include/asm/kexec.h      |  10 ++
>>   arch/x86/kernel/crash.c           | 257 +++++++++++++++++++++++++++++-
>>   arch/x86/kernel/kexec-bzimage64.c |  12 ++
>>   include/linux/kexec.h             |  22 ++-
>>   kernel/crash_core.c               | 118 ++++++++++++++
>>   kernel/kexec_file.c               |  19 ++-
>>   7 files changed, 455 insertions(+), 9 deletions(-)
>>
