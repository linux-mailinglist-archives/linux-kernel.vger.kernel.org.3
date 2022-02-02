Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61AC4A79F8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347461AbiBBVDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:03:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34368 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347354AbiBBVCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:02:41 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwhMp023469;
        Wed, 2 Feb 2022 21:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uqd1IjKQiDzpM5NeiuJ72xcGAwACnMETGHJInZt04Ag=;
 b=ezVCSW6nj1XjDr8Nb1w9Cl7hUKvIm//QVUNsWhNCY2P8RmMH+o/OuA6VJ5QM2q5flelS
 SjvVjUfPQZqItiD9Ans62SVghYpgOgXzGv2geDFZCdFK+KPgf82mWrK0Qf4rZJl+7OU/
 11V7/2zPt4pMf8pS41UUHwvEZaVIDyzJgAc01rvAnDOwwjQf1ELDYM66I1UQ4HT95CWZ
 KcgObTGYFaZtgwsrmxjTDVJGGAz+LHMDRdBc+qOtvyy5m+HZSz+9vq6YXMaJekjDsJuq
 mORo61eN/0hj4vBRQ9Y0xPDTyxzIpmkZ+8q6bul9LNI1H4BpxAKTPxWNALEhposbus8b Vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2pxcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212L1Ejv021471;
        Wed, 2 Feb 2022 21:02:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3dvwd8xt3n-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNEriRssaTblMGYtP0BFEZ3EXgPuRChaek/7myiBMiNS79Th54L0hQZON/TMdog/fXtIHS3/sWKNdt6L+nOlYDRvsC2+qf8rMQyVlTH1ItVtBaL/EI51MjecQk3h1061xlWNTBX5QHoCcEZBoAPqjHicr5jBkqigHqH0JDHg3MJHeXezcTGCMI4wN8O8RaFOC89Io7ySrdJBNtA4jNsfKZryh7+PDdhMfNvZLWBw/VHsLE/VVRaLYY6cdA8A1CeEQP58Xbgj8PRqv2n1KZh574Dv+Lehcf1mOfI8Xf/1KaEZDWg66pNxRTxQZ9q6UI+qMgfk3Zfs3uYoEbwTpd2Hkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqd1IjKQiDzpM5NeiuJ72xcGAwACnMETGHJInZt04Ag=;
 b=ClYb/3YHJXxDcaatximYADvPd5T7ZySqREAcox70QzMPYYyCcL5kZkBoOcqT+SHFFXyUJ9+BDifXWWN5tL3ZbfqnO1vkkLtQdtVRmqC+C85Gq995tH09ULjneT85FeODxBIQuDlQRe5xI8b93AzoxOn70T2nlDmb6En9CwAN0CNFZaKVCarn4GhnAMCIheKQ0l9OKQ4v1TewIOd6/6AD2eCx0aKqAumjqhjl0TUE4vDbUgX3gOuMiQeZJsxHCPd5Z2FBSjZVg9ihhFOXUlpCRJkqw8EkeAQM65uAjUjWeSDPv5/pmoVDaIreGirb90zZHzokQ7xR4A1MZmT4krwQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqd1IjKQiDzpM5NeiuJ72xcGAwACnMETGHJInZt04Ag=;
 b=uFAG6XmcjTyowI0MHV6ssTvG/wkcG3J8Lf0MC4FuvyblRHXSithNTET3kdD/fVw3s/ffVJ1hBMe5DszHyj+TojGV0OWGuqQT4KUy3wYJZutoGgl5vC38UGKk+L/epvPEOAMJKRFwWt2sZOCJr7SAPosZIJT/AKLNhqPTi5IN8t8=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB4014.namprd10.prod.outlook.com (2603:10b6:208:182::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 21:02:17 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c%6]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 21:02:17 +0000
Message-ID: <e18b49ee-44a3-eb72-ec58-9579dbdf4012@oracle.com>
Date:   Wed, 2 Feb 2022 15:02:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <20211129194707.5863-1-michael.christie@oracle.com>
 <87tuf79gni.fsf@email.froward.int.ebiederm.org>
 <a171238e-d731-1c22-af72-0f7faf7f4bea@oracle.com>
 <87tuf11oe6.fsf@email.froward.int.ebiederm.org>
 <a3bd6fe7-1775-6fdd-3a02-e779c4d4e498@oracle.com>
 <87pmpoxzuf.fsf@email.froward.int.ebiederm.org>
 <783145b7-243b-b85e-e274-44ef6c0696b9@oracle.com>
 <874k62b76d.fsf@email.froward.int.ebiederm.org>
 <68ba89ae-108e-c14a-02a0-db72b169c9b1@oracle.com>
 <87a6fs3lk5.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
In-Reply-To: <87a6fs3lk5.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::23) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83a1a489-d0dd-4f1a-125e-08d9e68f49dc
X-MS-TrafficTypeDiagnostic: MN2PR10MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB40148A39039CB231C49EBD24F1279@MN2PR10MB4014.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwdYeVcfKOPiEAc0h1Kpbr5eQLW4rGKIPISrGViUEw+ekAE8ErdY+Vk5fFyKvLc3scLaXiu5Xty/44N7rBgS8jDdXFAb0f27LhC4g0xedoTvBopw+eS//8nHeqC1tOzDorKBu7wq/XR6FiS/A8sxS6PcFcYWWLFsrwcJ346n8uG7IVUH50d+2fPh41+p40zgQSZKVLUBPplYSau3shmr4rm/Og1YSHE528OO6feqhaYkbxp+fXupG44h/JNW6qF2lB1bpCpt/HfSnEch08ekqBs+sCNDvl0EjJlES9fjhGsuOTvy8T4ewLVBxV+KyUBO38Iq3lGP7w1nSobLW1u+6ZO4Mwd3FaLH/Qpoh7BoJgGFgIntlItXyzJG4rXEuAigPIV3MkJ/8dkVG1hRzbIu6Xrg9sfBiPlH5g4Y4qPclGDLAGksxLqbbkehLlPYiadXv6NyrTV4gzAiE5Uia75Kgt4EwcO56kXVRzafa+h2S7MfKCZNeJZXX+m4mV+JZM8D2x4SHMJkORpGy7nkin6iHEPgiGQwXngHETeM6EGopjYSqVmVeLxNNOjP49ukg5EeOExr9iWIM/brWuHK4lZhg0AE6Sjxcmusr/HEpQM7N0QFvKMQZgHEdUGeG7BEHiXsnpBJBgZCKpqaJ8I11GX19gnyNBqJDGEKk7A27ruBJZ3Qq5BVUF/6iKTpLXOgYONTkwEIuGgOOwEsnfri1bKA6GltQ0uNKN4TvgcB4qIx3RY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(2906002)(316002)(38100700002)(5660300002)(186003)(26005)(2616005)(6916009)(66556008)(4326008)(66476007)(7416002)(6506007)(66946007)(53546011)(8676002)(31686004)(31696002)(6486002)(8936002)(508600001)(6512007)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5qT3JoNjdwbFdUeUpzYktTWExxdXBiZkpXUXV6WEY1dUlpYlUrcmcwbnpW?=
 =?utf-8?B?SU85NG1aOVYzcFVtcS9GeDNvVEYrYWFQTUJCdW0yNEUzODFSbjQvQ1I2b1I1?=
 =?utf-8?B?NXFjOUtyek5QN0oydUx1TGMvK2VZL1JCMUVHbkt6ZTV3QWVERGI4clVJdHA5?=
 =?utf-8?B?Qm1LQTJEWHAwcUNEWmVmK3gxSEhyOEpWejRWbWhYTzJQbnBsY01YSGxWNWpJ?=
 =?utf-8?B?UHNNQTYrQkEyczJZTWZ5R0RLeWtLZ0owbHp5UVNnNFBReG1EbnVlWnZnTXNm?=
 =?utf-8?B?M1ZlbXhzM3pYeTdZN2E5bWsrcnlMSjhUbXJtR1Zja1FKVGI3VFRwZmlyV2lr?=
 =?utf-8?B?OG01Q01HZWo5ZjBQamM0VG5SSFBtRk5LVHE1bDcwaytsZWhZRkJJUERqUzZ1?=
 =?utf-8?B?VDBsN1JIU0cxVDNlUExEbW9WODgwSUpsQXhOZ1Y3Q1NGMzUrYllHUDhmZ1hY?=
 =?utf-8?B?TEZuWmhmNGFpWGt2R3lRVnVjMzlFWERtZHFrVEllbm9qampDcGRjcThaYlNp?=
 =?utf-8?B?SWdUVjZjd3h2eEdCOWV4MWlUSS9YZzVoSGtZOVRtY2NYdWtpWVZNVkhUNXdh?=
 =?utf-8?B?RWNNZDZmTVdqM0VXWGRVdW5yQ1VEbGU5b29vczlORlc1bWNQek5WWU9KN2RV?=
 =?utf-8?B?QlVSckRaOUlXZjVpaklxVGxwdCtYQnpnWWZiZWFkcU85bmRMbjJiUmVteS80?=
 =?utf-8?B?eU82b05QQ1lId2l1K2lrZEk4Tjljc3Z6N1VESitYaGNFbUpmbjBFRG9OUjg3?=
 =?utf-8?B?L0k0YnQwYXV4UW9hN0VDaGJiU1EvWmZtaUZES21mdktCK0IwTmxWakN1c3Zz?=
 =?utf-8?B?UURMNS9qNXZUVUtnY21MZTNHSzR1dmMrY1VNM1hZOGVQUk84NmJSMjExbGdt?=
 =?utf-8?B?Z3h4YzFmaGd0Vy9ieElxbnZYME5PdEVBaXNEd2JXaGxsYVJoUWY0MDdDdytS?=
 =?utf-8?B?WmxoSUgrdFpLTVd0ZWFZKzV6Tm1UZnNSNEl4bHAzaGdMdkp1ZzVXYVN5Q0NI?=
 =?utf-8?B?dHQ3dkhVNy92M3JzM1ErblhRTjhreVhBRzJTeGpTNVA4YTZuQm9ZVUdja2I3?=
 =?utf-8?B?RUpTcGY0VmJ0WnJKS01uRjZXbkNad3pqbjh6dDNmdW5zZ2c0VGU5WGhiQ09X?=
 =?utf-8?B?QmFFSUdHYjhZVHQ2MTVYakpsQjU2WmNMYzJoeDI3NExKZllRT21hTXRYeWYy?=
 =?utf-8?B?ZTQ3S1NZanllTmRQRm8wRnN5Q3pUZG10Sm11aFlpZW13djFmR3ovSS8vTVAx?=
 =?utf-8?B?bDY2LzN0QUIySWgzOVBLOS9yTXZEa0lNdW5MMmZtRHZkRVBvZXUrNTV2VldY?=
 =?utf-8?B?TUlGK2FJeUdlSGNFRU1Ja25jQ2tqZ2hnT2xjWlR4bEJ3b21JeWhCZlZXVTZM?=
 =?utf-8?B?MERPR3YxK2JkTTRQTXBWOGlya1ZWMzBvaTdZWXZEN2wzck5rRmRwQytCdDNr?=
 =?utf-8?B?bUZ4VlozbkhkeU1xaWZpMzU4ZVIrcU1IN2lyWHRXMFcwaHNBc1lzZ3dTWlpM?=
 =?utf-8?B?R0xKVjNtY2ZnYWJmL1UreXd3bGQwSXlySmVBcWJRUmhiSC9ZRFpRK3ZRVEpy?=
 =?utf-8?B?REZNdVNJYXFsNStyeGpwbDNjUDUwaTRkOHpwL21EQUtVL1M0aEJCNkR3SGxG?=
 =?utf-8?B?RWhLckVyYjlHQWt3RnE5VlNIY2cxNXh5ZC9IVGFNV1dLaGcyWjhYMFd0ZHBR?=
 =?utf-8?B?bWUxV016SEVXdlI3NEczSTQ1ZTVFY2ZybjJFSUVRaGVnNnJjaDdCZWlUWE5k?=
 =?utf-8?B?TnJiQUJiTmFHZlk5ajVhZ3hwYlRBMzUrem1NZXEvNUpjSmQ0Vm81d1ZsbWth?=
 =?utf-8?B?S0RwY3l2N0djK3QyQ3FaWWh2NDhmYzR4WFBOem45eHdaa2E4TzZuMkdmNUlt?=
 =?utf-8?B?eXJ6bHNNdzNXNTVGVExaRXpYalpYQWFmUmdtRU84b3E0alM4UUdlQXAzeWZv?=
 =?utf-8?B?S2FDMmJObENwSEpVaFU1c3lobDRDdDVQU0ZUYVQvbDFBQk10ejJrcHQrc01t?=
 =?utf-8?B?WkxtOUoySmE2KzF2OG1OM2loTXlZU21iZDYva0t1SStVMmNsT0FqU0RPUHBt?=
 =?utf-8?B?U0RRWXp5RllSUUU1eEdkQWxMM29OTUdsdHg1RDJIRDdHK0lrSlpVbjMycmZh?=
 =?utf-8?B?empNR3lpWHlsTEljS24zUkQ5cjBFdWpqTERnMnNsaUVGMlN3dVVNZkFwcDAr?=
 =?utf-8?B?UTBPWnk0Z2wrYWdibms0QkNtUmFpZTVJU3hDQ2lGcWp1SG1TTnBwUkZDcU4r?=
 =?utf-8?B?ZE90aEttVmNVRHpyZkxpVUtQWVRRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a1a489-d0dd-4f1a-125e-08d9e68f49dc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 21:02:14.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWN2Xa2v+DpUaED5Ic8EZieZ48/shaTWihivpR7dtkkbeHjTi4EXWL6JXYMv70gNoiAPiRL7TfJJQqZTs7mh1WnK6wuO2RiDCpDK5YD+czM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4014
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020115
X-Proofpoint-GUID: nROq2uTsuoonXRyxdE6f5u_3Yocyu5Uh
X-Proofpoint-ORIG-GUID: nROq2uTsuoonXRyxdE6f5u_3Yocyu5Uh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/22 1:12 PM, Eric W. Biederman wrote:
> Mike Christie <michael.christie@oracle.com> writes:
> 
>> On 1/17/22 11:31 AM, Eric W. Biederman wrote:
>>> Mike Christie <michael.christie@oracle.com> writes:
>>>
>>>> On 12/22/21 12:24 PM, Eric W. Biederman wrote:
>>>>> All I am certain of is that you need to set
>>>>> "args->exit_signal = -1;".  This prevents having to play games with
>>>>> do_notify_parent.
>>>>
>>>> Hi Eric,
>>>>
>>>> I have all your review comments handled except this one. It's looking like it's
>>>> more difficult than just setting the exit_signal=-1, so I wanted to check that
>>>> I understood you.
>>>
>>> [snip problems with exit_signal = -1]
>>>
>>>>
>>>> What do you think?
>>>
>>> I was wrong.  I appear to have confused the thread and the non-thread
>>> cases.
>>>
>>> Perhaps I meant "args->exit_signal = 0".  That looks like
>>> do_notify_parent won't send it, and thread_group_leader continues to do
>>> the right thing.
>>
>> That doesn't work too. exit_notify will call do_notify_parent but 
>> our parent, qemu, does not ignore SIGCHILD so we will not drop
>> down in into this chunk:
>>
>>         psig = tsk->parent->sighand;
>>         spin_lock_irqsave(&psig->siglock, flags);
>>         if (!tsk->ptrace && sig == SIGCHLD &&
>>             (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
>>              (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {
>>
>> do_notify_parent will return false and so autoreap in exit_notify will
>> be false.
> 
> Bah good point.  We won't send the signal but you won't autoreap either.
> 
> I think we could legitimately change this bit:
> 
> 	/*
> 	 * Send with __send_signal as si_pid and si_uid are in the
> 	 * parent's namespaces.
> 	 */
> 	if (valid_signal(sig) && sig)
> 		__send_signal(sig, &info, tsk->parent, PIDTYPE_TGID, false);
> 
> To add:
> 	else
>         	/* We don't notify the parent so just autoreap */
>         	autoreap = true;
> 

Hey,

This works for me, but I think we might have issues where threads now get
reaped too soon when they are being ptraced.

I think I found a simple solution by just using kernel_wait in the vhost
task code since I want to wait for the thread to exit when I'm removing
a device already. I posted a patchset so you can check it out.
