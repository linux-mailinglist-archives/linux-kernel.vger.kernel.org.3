Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42E4485C46
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 00:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245394AbiAEX3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 18:29:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12514 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245381AbiAEX3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:29:03 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205N51xZ032380;
        Wed, 5 Jan 2022 23:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SxNlkj7IJkSFLUT1Y82/rVqFjVTwEoYbqTJdx20uVmI=;
 b=f8oH5AnYYFvKqrWBFLcTTQtl8YUOQqamSSJgGGBJ+HCb2N8QQoeJVc3uK++TO5Ca7Rev
 /rQyCe3/3X3K03ULBZJTJuFdAxFxlQCpwhPwf99TjJ9y0PhrTwCuS4ZSf/bxe7hZFPHj
 5ZNWBiXlKHfqdAPJ8F2qqEuBqYhQ+ocYCfFNyTAxLCzoIKxVv7ZBuvFNvvA18dNht7Ht
 Nsb34wzpUY1pQrkVE4rsc7u0Y3P3Waaj3k0dq7rwpe9v0CG7fP7PNUUpFTKgBNXMx0nZ
 3HrX0ZDybTln4qU167eA0DnSWqL5bGGBwe7yfc73/pZsn9cfPZUhk1WkVWsHEy2ZqdpR ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpjr0y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:28:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205NFmgA076768;
        Wed, 5 Jan 2022 23:28:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 3ddmqbrxse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1TlPiUBQ1A6/PmWHQ4zy7BX9aMIxaqGh+gMu+WErdp7pMNWr3PEo4yWnWgLKosdXIjn+KOHmr6exYPkVpchG2SI82DWdwidW8YFNEySwZaevQCWNv2C++baVaicnycfBoqCPE9lY1fS96ssyVbYmm9W8KtVcToWhFKJKNzxmkDn17wTsVBd6Y4yolPZl+W2P1eRwPJrFV/IgId7J2kYGfnFs0RUK2LSa5icYcCuybKYiL3M62UKGTpCj2AVI+fdLCqW3m28P46/TfPrBs9dR+8+kZ7UhPEcMblDXenZKSgnEEjVvJ7yrjXxGJa5wyxqouSaIokRCpwraCxdNZTqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxNlkj7IJkSFLUT1Y82/rVqFjVTwEoYbqTJdx20uVmI=;
 b=P6ajSYOEiAIgsJFwC7YK+W7SpXn4L7wLmVqzaV0WssrAos0LNRdz/gtVQ01eJbw5xh2Y1mbDhPFuAoIO+2ojQ5fEV19InRbL2mVsKyXVKsaSIYRl+c0XImW/hNnoapGoThLkvijAPmZvVm1kKysoaBidKYax+S48K0ukGs4nPXMoDGBHq5BNTyjpYzLsVI1t9lv+37r/gCXFfCIrnKTwrMHrkvNDLroJOIQsb5gcUpkBFlj7DuDi8LSZBlr0BJTTzikSAG/aVxFpFvj/Y2vnMQ2obv9Mxg+7okQfl/bQF4gJMQQMsC9M8GhV02fto8frzbogauCYS3mjbCBuAzmZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxNlkj7IJkSFLUT1Y82/rVqFjVTwEoYbqTJdx20uVmI=;
 b=xWumPiFB4LSvkgZzmfDGM28oc3BlCTIO4UOu7vTP6R5212v+NG80/NEQm+qouolQgrdZWU1KOu/CsgWFccBucby1EOKHiZRGkHXbZHnaFxk454M/dh9mHR6J2yX4Ra43fZvZMZ8OHvnoKOakWPtrg7YhHkmgVf5EGmGy4lIMyS4=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BYAPR10MB2856.namprd10.prod.outlook.com (2603:10b6:a03:89::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 23:28:30 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::91ce:8d4f:e5d1:c67b]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::91ce:8d4f:e5d1:c67b%7]) with mapi id 15.20.4867.007; Wed, 5 Jan 2022
 23:28:30 +0000
Subject: Re: [PATCH RESEND 1/1] x86/smpboot: check cpu_initialized_mask first
 after returning from schedule()
To:     Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        rafael.j.wysocki@intel.com, vkuznets@redhat.com,
        alison.schofield@intel.com, boris.ostrovsky@oracle.com,
        joe.jin@oracle.com, longpeng2@huawei.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org
References: <20211223210343.1116-1-dongli.zhang@oracle.com>
 <2ddaf5e732c48f74a3758484869c81195adbc47a.camel@linux.intel.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <c947326e-26bc-1e86-60c0-cbe939b0002d@oracle.com>
Date:   Wed, 5 Jan 2022 15:28:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <2ddaf5e732c48f74a3758484869c81195adbc47a.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:806:28::30) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cea7fe8-4c22-46f0-73fe-08d9d0a314ea
X-MS-TrafficTypeDiagnostic: BYAPR10MB2856:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2856D1A84A9979BF9AC291ECF04B9@BYAPR10MB2856.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZltDhVbX0Qb4qpegqKC0buLa+f/yqvxorpLprp1f+G5ZTLtlSBBLeALy3A6bzcuSCJ/oK2kf8V3Jtz4i0uaN574fUeCbbXZiZP7p6BgwCpR0vGYLMmufKV3jHm4F9WF7Ex2eE0mV3E0VlW6wRkQFfFJ1NcUL7o9LHxaz/DOpSrMd5MtP3fhUfU6cEGOJJ8cAQhEAFAcMByk31EaO4tSOqDiCXKTYjzZZkVreYe343A+NbmvuwVPSIE8K5PTurrTNtz2JvAZ8P8mw0UDZ2og8Yzl9bW4g36he1q7fvXbcEDSa37syvl9DQ978besQd11K5MUzMoimUOYwh9LFrSaWd4fpSd4F6d5cR/WxWEBVgBcIqTeZH6CVUFnrN9hgH/M4HezTgKx0qT+SIUfL42m47owSSolcaZQMWTQtStZw+vFThc31SkkJkd5KcozuWuLbPBRWEKBUdC31S4L3VP7cb7vgzr+KvhOEJm2hjLWbjfuXDDjKtI3HhXVa6oLXooMQqgNGUaoz2udxDThld8FDmXr5a6/xtdqA5I69tx/k1p7lW8ZuEy9MFSU5eRX3CxCkr23sCCtZ8P25Fz9vVkCGmdeXUUstUih70Hg2HkT0p00cvWF+dpzt7wkHNH1hImXlkReRQbixpmprnqNf0givSkNPdDc3YzqYRavqUtizUgRMO/ZQCuVrcp/pLn0ApSne8eYU1xjMY1IBnk0v5VRUFUPQEtgJZWvAJnXfcNUPq93gHsAXp/vSoRxWoi0sb/eNYF1l7ldoHirZTZTskLmZH9aprd2JSNag2+ZWquHstAlB2tNY6y+JOs0PowB7UdTX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(31696002)(83380400001)(508600001)(6486002)(5660300002)(86362001)(44832011)(6512007)(31686004)(316002)(53546011)(6666004)(8936002)(36756003)(6506007)(7416002)(4326008)(4001150100001)(38100700002)(966005)(186003)(66556008)(2906002)(66476007)(66946007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG9QTkRLNUg4NTlOQTZIV0ZQOUNUczVIbmU1WHFhRUR0OWZWdEllV0ZRUjdN?=
 =?utf-8?B?QnZuVW1tMHBnM1N2MVRENHVWOEk4VzhzUmZNUzVXQ1doeFlQRm9YTjY1RFox?=
 =?utf-8?B?dzQ5RnN1Y2VWbWxDMVBaUGh4TEdvTHduK05DT3FwY2FiRHVvZVJJZU5aSnc5?=
 =?utf-8?B?TnJLL0RBTE95ZkVIS3RGdE0rY3orK0NGVWkyWGFmMXEycXhkWlBiRE84bmFL?=
 =?utf-8?B?RzdGWklpaUdCL1hKYW1uWlQ0SmRIMEZMMDA3alNTUDRlUnM5WCtFSkpranJq?=
 =?utf-8?B?SGtodzFHT040aDdURGxDeGttQ0UvckVFVGZGU2JlcXlRT0Zjd1Q4R1BQeklJ?=
 =?utf-8?B?akRHdkdSRVdibmMxckxWL1JQMTlsSWNCeVo4cW1aNHJwUWZwS3l4b3d6TnZM?=
 =?utf-8?B?YjJEZ1lRVmVwS0FNdVF0SjNyQXU3VXZYNFlDazNxU0E3bklvUmZ6NHpHblUv?=
 =?utf-8?B?bGpWQndqSkY3RXlNT0MxL2dDMERqaEV6a2JjN0JHWnNpem5LcGdCWlNtZjdm?=
 =?utf-8?B?K0hqS09JV0lnM2xlTDczSWpmZzJFcHZsc0ltZVNpQTdOMkxqNGwvU0JiQ2F5?=
 =?utf-8?B?eEU1Ym1CVzdoZFBFSlI5T3c4dndFb2I5M0wwV1d5TG5DanJ0TGkwV0hGc1Yy?=
 =?utf-8?B?N3A0VktIdWV3NXgwQ0pIQWw4dmZhcE45R1pFcS9XcEVyNE5VOHkxQm1GNm5h?=
 =?utf-8?B?TVZ2ZGZKZzlpSlgrdjJUeVNkaFRHaUI1WlhmcklGTU1DZWtJY1BiaHhBeUhM?=
 =?utf-8?B?SFdSTUhBREUycjUyZm93d09oc0QrWUJ0UFA4Ry82QnVRMUVRVy96aFRSWlpB?=
 =?utf-8?B?MEsza2lTRFBMSzdTUkVaMWZEaWhLTEhJN1pKSHNmMVcyU1plcWlsMUVLOVNK?=
 =?utf-8?B?bGtJNEc5MXpPQTRjanZVcnp2a1FEK0NheTJ1eVdDekFRSUlmT2ZycE92TEpP?=
 =?utf-8?B?ckpGK0VDNEhrelpEcXlGbmd4UlZRdTJvMHUwZmk5cE9CMUpZWmFoWmdwSjMr?=
 =?utf-8?B?ZkJneVZLbTJEMWs1emErMmpmT01Gd3habitFRE00VWlkemxsRWc2N3J4MXlz?=
 =?utf-8?B?ZVhHN29wUzkzaUNvY2tMNXd3bWZDYXNNNWpVMUxvc1lHcG9JMEsrNEJKRU1M?=
 =?utf-8?B?eTRDTnhlQ0JpemI0YzNaLzQzd0RKZkNEWmJyS3JwcW53bHpLMERRZkUyQkhk?=
 =?utf-8?B?QTc1UmNsSDlmRDB5MFpsNnhmVTJZWWdZWDdYelZDZnUwYjlSOGNWelIzalR0?=
 =?utf-8?B?MERPaVF0cThMdEJxRGZicGlPY2x1aEVVLzhPVmt3TjU3RkppT05jSGdrcG5M?=
 =?utf-8?B?TTFWbjBGeGdFbTJMNDdCREppL1IvclV0bEc1Y0NPdjJZa0d0MVU2ZlpETTFC?=
 =?utf-8?B?dGo0S3UwMEo5RHBiRUJOK1k1ZHJuWVR0MjlzUXpIeHZBcDQrb2xDS1pXTng1?=
 =?utf-8?B?TmZUM2xoN3M0MSszbEF2R3B2TmM2M25tSDcvSkU1d1dKTVRodW5FbDF2bnZz?=
 =?utf-8?B?dWdDMEd2TGN2SDQ2dkhQUndDNEErNVVnN3Y3ZEFyaHpSL2VaTmF5N0tqS0lD?=
 =?utf-8?B?WFdSdEh4VmdlejBYemxpWTZ3QVM4RmF4RzhCOU8yam9vMWpoTU9yV3lFdG0x?=
 =?utf-8?B?UDdmN2oyOTM1RG5nREtWL3VOY2gyaHF2ZElOejRiQnpNVmxrU0RFSkNYczE3?=
 =?utf-8?B?a3o5VmhBdjQ2V09mNGdwRXFuSXduU2NuQWlLajU3eTMwRzdHSVF2WkdwTnZI?=
 =?utf-8?B?bTN1QWlPSngyM1VBTGFGS01ZWkJDdjc0SVFiUmUyTUlZWDNRUVR5TmJ2dDJu?=
 =?utf-8?B?YTF4ODJ0Y2tpNVFleE1lUlJBN1k0WEk4cWhNVzZiRzV4YUYxK2NrRTBJdmkw?=
 =?utf-8?B?alF5enNWNXFOeTF2blp3a3VGNWMrVldvWDkzRDUwQVZ5MmtsT052KzdYZHBF?=
 =?utf-8?B?Y2h5LzdiRHFLNzJOa0lYamNzeUZLSUhPWGVLdWlJMkRmSmhRZFA1M0d4Wm0w?=
 =?utf-8?B?Z1dsaFJBNkw2WHZGQ2VMWmljYzdoUmlQRTBZcUhBcUluV1Npdzk4dmJWcHVU?=
 =?utf-8?B?emVvbXhobnRIYUVib0lXSFlXTHI3Y0xVdWt6RW51OUZiOHBWeFl3ckE1TWVx?=
 =?utf-8?B?S3NJbDlNQkErRUlDQ25VcXFLaVRFdFIwVHJxZjRlQ29CcXE3MFFWaXVzRXc0?=
 =?utf-8?Q?+jUcLzN9jTsCP7E+wg5j2eMs8lGYhL6iyMW/0FxXDNYw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cea7fe8-4c22-46f0-73fe-08d9d0a314ea
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 23:28:30.0823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIDUI1DW1jnEWFthn3fdsibp6xJxL45Q/yBFbwcul5JzcMQgrQ0tBwCkK0lkZVl5SJTvpBhbN7aYbB+2CvW2gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2856
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201050148
X-Proofpoint-ORIG-GUID: 6grzaa3a81x3FtW1E9qLvc4Fr8u9y52l
X-Proofpoint-GUID: 6grzaa3a81x3FtW1E9qLvc4Fr8u9y52l
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On 1/5/22 11:19 AM, Tim Chen wrote:
> On Thu, 2021-12-23 at 13:03 -0800, Dongli Zhang wrote:
>> To online a new CPU, the master CPU signals the secondary and waits
>> for at
>> most 10 seconds until cpu_initialized_mask is set by the secondary
>> CPU.
>> There is a case that the master CPU fails the online when it takes
>> 10+
>> seconds for schedule() to return (although the cpu_initialized_mask
>> is
>> already set by the secondary CPU).
>>
>> 1. The master CPU signals the secondary CPU in do_boot_cpu().
>>
>> 2. As the cpu_initialized_mask is still not set, the master CPU
>> reschedules
>> via schedule().
>>
>> 3. Suppose it takes 10+ seconds until schedule() returns due to
>> performance
>> issue. The secondary CPU sets the cpu_initialized_mask during those
>> 10+
>> seconds.
> 
> The patch seems reasonable. But do you know what other task got run
> and caused such long delay (>10 sec), preventing switch
> back to in the master CPU?  It seems like there could be some problem
> causing the long delay. It is better if we understand the root cause
> of that.

So far I do not have a consistent repro to verify which kernel function (or
kernel thread) is making the trouble.

However, it is not necessary for other kernel task to take >10 sec to reproduce
the issue, e.g.:

1. The master CPU signals the secondary CPU.
2. Due to the issue at KVM or hardware level (let's assume there is an issue),
the secondary CPU is waken up at the 8th second.
3. The schedule() returns after 3 seconds (due to the 3-second delay by another
kernel task).
4. The 3+8=11 seconds are more than 10 seconds.

Therefore, we should first check whether the secondary CPU is waken up, instead
of timeout. Otherwise, the secondary CPU will be put into an non-recoverable
state, until the OS reboots,

Thank you very much!

Dongli Zhang

> 
> Tim
> 
>>
>> 4. Once the schedule() at the master CPU returns, although the
>> cpu_initialized_mask is set, the time_before(jiffies, timeout) fails.
>> As a
>> result, the master CPU regards this as failure.
>>
>> [   51.983296] smpboot: do_boot_cpu failed(-1) to wakeup CPU#4
>>
>> 5. Since the secondary CPU is stuck at state CPU_UP_PREPARE, any
>> further
>> online operation will fail by cpu_check_up_prepare(), unless the
>> below
>> patch set is applied.
>>
>> https://urldefense.com/v3/__https://lore.kernel.org/all/20211206152034.2150770-1-bigeasy@linutronix.de/__;!!ACWV5N9M2RV99hQ!d7NY8MgLj7W5ZGWS_0HHsvE52WNh2WJbJwLNBJYLGzGIY9BzKg-PUYiIYMmrwud36Ys$ 
>>
>> This issue is resolved by always first checking whether the secondary
>> CPU
>> has set cpu_initialized_mask.
>>
>> Cc: Longpeng(Mike) <longpeng2@huawei.com>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: Joe Jin <joe.jin@oracle.com>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>> To resend by Cc linux-kernel@vger.kernel.org as well.
>>
>>  arch/x86/kernel/smpboot.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index 617012f4619f..faad4fcf67eb 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -1145,7 +1145,7 @@ static int do_boot_cpu(int apicid, int cpu,
>> struct task_struct *idle,
>>  		 */
>>  		boot_error = -1;
>>  		timeout = jiffies + 10*HZ;
>> -		while (time_before(jiffies, timeout)) {
>> +		while (true) {
>>  			if (cpumask_test_cpu(cpu,
>> cpu_initialized_mask)) {
>>  				/*
>>  				 * Tell AP to proceed with
>> initialization
>> @@ -1154,6 +1154,10 @@ static int do_boot_cpu(int apicid, int cpu,
>> struct task_struct *idle,
>>  				boot_error = 0;
>>  				break;
>>  			}
>> +
>> +			if (time_after_eq(jiffies, timeout))
>> +				break;
>> +
>>  			schedule();
>>  		}
>>  	}
> 
