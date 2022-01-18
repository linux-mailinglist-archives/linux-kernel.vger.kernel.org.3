Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3516492E14
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348578AbiARTBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:01:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52370 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244633AbiARTBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:01:00 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IHSgCU024410;
        Tue, 18 Jan 2022 19:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xVruDj0UAiKX6qx5/58vjt+11Os6pI3I4rHAc4sg4K8=;
 b=ybLVmXkVN7BtYdFgpwxbO7iBaxGAuXTNrFN+Cewfd64kANUdwGB5ifcSxOKklYXq4Syf
 Vu74gf8FBJqNnh29g5CMV/p+UBfuGZs8pKUWwXZ1TXvDy+Cxgk7mZq04WKzRxi/a32zT
 Sss9p/WTqdiwhDvK5fInAl1yTTP8Nvox/VS79nIA+b26bm04M21VxcCNZxTvh66nMC3J
 K+cvZn2MQX/C6eepRU17yD6cXGhuDGCYWitnvRHQkeYD2DAfHe2TmNkJXnZERiCbgK17
 M1gntP05aZF19Lr4YYgutrhIr3tTGaTCYtDKCq4K+dgFnKEzy6s425Y9NuMUHXi+FA11 Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q2vr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 19:00:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IJ02mI024246;
        Tue, 18 Jan 2022 19:00:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3020.oracle.com with ESMTP id 3dkqqnwnyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 19:00:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejGYmpjxx2VnKuTwbEUQmxVLzMRvk+9Q+We2nltCQP1Dve12J0mAj1LC6gMkng/uJbUy5RrlRgWNDrXOU7bJ6LVy2TzITNalX/i1oodrHV2iyKrH5NoLT7nRR2aJyaYJnkpsMf4r25Jiw8FaLFqjKOJwxDEkHHEnAg4muU2Ts6v6LmDfJbfvUbMdbxoeRGoYbN09MHPoa124EtFLEWfmvzgxaARwMy6vLMa7AUph+tym9i+rNUAhqJcq3XQVzMsb5qC1lduY78GoHWV8llNRZAWINIeoj4vJGnZ4ZjR8BUygZ7uWD1vm8/p0OINgwtwlQSlcbYNvTsWDwRd2HEPJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVruDj0UAiKX6qx5/58vjt+11Os6pI3I4rHAc4sg4K8=;
 b=FS1E3v0MAfQU/30ea5u+AjzjPe1fvKXyL03J0emMTyX/zYrB/NmDQkKABeQDWi87WUzMysfkhfiSQsJWVN6Ha9MVRIIE95J4Dtm8qpyNYM3ptP7pLZNtDVNBhShOs7xrgu/RJSd+xraa7ef7BeBFB9TdbNvQPZye2hKmRCcY6DXljklWOA9nBxrOAS7c84K6k3Q6VvJQHbcMly4YXAsvHP76vZ0J5e6bEfKvKJUslQRzR/1xPqoTfN3tkM0tc9Vt7dQ38FaQh7EvJ/EAzoiwRZ2i8S3iiIp+L/cQAKHWeTb3QOPejl69LMbELVW+ez4FaYIoK1/3FTuYPYYyO1Od6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVruDj0UAiKX6qx5/58vjt+11Os6pI3I4rHAc4sg4K8=;
 b=L4j07e5jieP22kwhkEnj7yaxIj6kFhgH8ZwI6ilxIg9b+QjhOtTQoJCP8F6H2n+u+kqrIwM6lZt+ePyKDMUzLFcX6dlF/Cp3lTHu/v2GKZKa2lBtkwHlJzmg6ThYY0v3gu5LWMcF9HEH7eNb0D03KbqDRhjrDPst5EVipnnXT+0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH0PR10MB5795.namprd10.prod.outlook.com (2603:10b6:510:ff::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Tue, 18 Jan 2022 19:00:41 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 19:00:41 +0000
Message-ID: <201528df-4474-b544-e25a-9746e30df04d@oracle.com>
Date:   Tue, 18 Jan 2022 13:00:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
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
In-Reply-To: <68ba89ae-108e-c14a-02a0-db72b169c9b1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:610:51::15) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8478894c-785d-4e2d-ae22-08d9dab4d2c9
X-MS-TrafficTypeDiagnostic: PH0PR10MB5795:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB57951201A5CEB994F15EC961F1589@PH0PR10MB5795.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXNkZwnkBnb9ShCGN8Gg5xAome66xgBDvxKG4k3TLFWP9Z/NG26KCCLFqu8e5rgjZ+0lF0xv+BSF/UpMp3X9gjpc0duXzkKg/1WH+ANcujZ+b723/6e2Pr2LRoUzFHjB458bIFM7DZY9kOk6VTUXcsENcmUQOAAMEZtAFQimRtWDB/VO9lWb/gG2rJJBLDZdlGa7OubG6rKAGAsarCuWfOacXZ48t5pVOvqYJTUQNjmfZmAGONjFXPwHTv8/1+FEauFVeHn5k65WjCDBIGtAsisSPZoR0EE0U0r3yqLPGMpz51gvzJsRDb+GSQTH98dOpco0UgwPwqoicpJnNQIqqv3SoEa9NtoiNFVWeXVvoEr5daqN/wne2OHnHeW1Up+9Xa+LylsXxEwkwcJ9PK+W6+EOq57v+93v3GuXj3dV5WTmj43ZC67dhjMVFZtemCZcnxbkSXdrJscA4ov8YpjKIsjNjFvSiheap0rumBmsa7B23E4TkcqvXQnyrhHagfGa7qVmzYJev/AxCJQnq0sx/8MPYypdQfoJ4FRrC/GLZp6qaI+4f4t+DHUVuyg28H27liAFaWW7xi0oGztoOqGfd1VIeMvjVlBRiljuqMVSHGYJDnk6Gha12PiO9yBjCEneUYhZnNmmfL67YzD0x10HU5+ltEtO6uUvxpYtigCQKWoV+aG6vXong9+YMO4UmQT2gbv6FvEp+Q6IOJf5t5i4oonejBvOrjSRvC/Q5xs9vfWiRp8w1miAZoRtFuGJhje/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(4326008)(26005)(316002)(186003)(508600001)(6916009)(86362001)(6506007)(53546011)(6486002)(6512007)(2906002)(5660300002)(7416002)(31696002)(2616005)(8936002)(38100700002)(36756003)(66556008)(66476007)(66946007)(31686004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGJaYmtIbXk4dmt6M0pkQnhWSElZL24wR1FRQXJxSldvbmZOTTQ3Sm5CbzlN?=
 =?utf-8?B?STBzaTZwUG9tVVJMbUJhNmI0MjZIdEc2NkdaWWFwSW0vQnpwd0pycTQxcGVE?=
 =?utf-8?B?WHJlUmN4V0hlcDN3bjc4NEtBOEJ6UjRyVUxGeUl0MFJ3VEkrS2tvVzRpeDEz?=
 =?utf-8?B?SFl0WHZIR1NXbWhGVUk0ZDBHNXRFU0UxWDIya01pTW5mbDZQMitLOGZ6aUox?=
 =?utf-8?B?NGVZZFc3SXpwd2lsSW8zLzlaSTFiQlJaeFEvQ05CeXBDY2RKd0tGcEllOExu?=
 =?utf-8?B?MFhwcmhSZlZIUUk5Z2RDQjlTUUdmUjZ4Q29Rd014cnl4TCtZWktEcVVqdUJX?=
 =?utf-8?B?NEJ6R1ZUZW5SVXJLWkJpcmJHY2pCU3ZabzNiK2xiUW1ua2YvQWk0L2xwYWFF?=
 =?utf-8?B?TFhWbkdRaTV1MGozcEY5eWVqQjNicjdMZXNFaXZBcnhJOXkxOWI0RVRsOXky?=
 =?utf-8?B?SGxMU2VQd1NVMllJQkpDaFRpQlJpc3hYYmNrWmtVclBBMWw4V2M5RHpYaXNR?=
 =?utf-8?B?djF4emR1MzJ1OFlreGxaVTZuaHAwZEdVSmQxOUlYaW9QT0FzVmQyYUdlMm0r?=
 =?utf-8?B?b2RzamVINzM0UlM2Y0ZOaXhQWU4yaW9TZHhZSFRWOFlqbnNPWmxPWFltUEJ1?=
 =?utf-8?B?TThiWTdqRlMrM1g5N0hTMUJ5REF5T1FJbzc5SzlvWlRvZ3QySlM2U25BZ3Zx?=
 =?utf-8?B?NWhPUWZZUWhXc2pBTTZweEVwTVVTdFFSUzNiUDJBUVFkcDRaU3grRk8zZnhM?=
 =?utf-8?B?d3U2dFlCc3kxdWhEcU9RQ0t3Zlc3TjNtT0lHcWRmdXRpMHZ2dWk0bnY5NU40?=
 =?utf-8?B?cmVnbTVYMU8wRm5vNEY2MVU2cmxYNlN0ZWZ2SU5ja2U0cXlxRjQ5Qm11VU1w?=
 =?utf-8?B?cnNsd0RNak9vMFNuOGVwdURDLzZZelBMYml6Y21mYzhlV3JQKzBHbEVMR2s2?=
 =?utf-8?B?Rm05OEx2VWI1VEJKYjFzUi9LUm9wSEpPY0lkakpVc09kUEpvMSt5S1FGNml1?=
 =?utf-8?B?Y055aU9LVzFyWGZ1T2tVUWp3UEJORTNPcXhZaDJYNzdNK2VjVnJFTTNCL3ht?=
 =?utf-8?B?VDJTbnQ5VzJiUUFyM1Y3UWRLcjVXc21lamJIc3JCT0NsRlNCRWJMQ1dKMXQv?=
 =?utf-8?B?TzF0bFVCWGVUMURMNWpzM3NZWUNkSGk5bUE5VEVuTDZiaVA2RytVRWtzM3Zj?=
 =?utf-8?B?eFlBZ2pQcm9TVW53QXJ5OW9hUnVOV0llZFo3ZFp2cDhMditDdXg2Sm5ZelRW?=
 =?utf-8?B?L0g0M2xzc2VWaTBqL0JGdGxvREdWYWpEcE5lMTgzcDgrTmh4cFNnSGN2aHF0?=
 =?utf-8?B?TUpRNFBOVWRZUkVlRE5uN0UzZ2Jydm5VdldYNFBscndMaW9ManBVRy9LaEh3?=
 =?utf-8?B?ZFlxSCtkcm9lQkhma2dKcS9zckEzMkVScUJDN2h5dDllYVFzTE5oQnZkTmtD?=
 =?utf-8?B?Q3VSUnhqck1waDVoUklLM0dJNUkxR2V6b3NHdHFmdW14WHJRL1kyRFpLSnEy?=
 =?utf-8?B?d05zK1BsZEsxY1kvSWVoa1lhM1ZoOUpDREpXY2hpc2E5RzVCc05lWnVNM0sv?=
 =?utf-8?B?L3dvUkJ6cGpvOEVQQzdFQWlWYnYxK3d6QU41dmhOYktKUkZ1b2orYmZWeUhY?=
 =?utf-8?B?L25yeWJtR210Skg4d3RMdmRGR0FXRGRYWjhINFhldWU2V3J5UFNVU1Jtakly?=
 =?utf-8?B?MU13L3ZxWThHdDFEZngyMG4xSTJDUTdabTY0QWRaZ2dveFljWExHT2xvVUJa?=
 =?utf-8?B?TklCOUxJNzdBV1B2ZzJESVpPNThmRlVzelRUU01PMmFLRjBYN3J2c1QvV3Ry?=
 =?utf-8?B?NzhEUDIwVmJDYU10L2plODFnSTZlNE85dS96aTFHREgxZ2RUaUZUTCtzS0cy?=
 =?utf-8?B?V2pMUWh0YnZiMTV4TE9hRm9pczBwSWlFRjhUY3hEamhIRytWOTdWd0ZzYWV5?=
 =?utf-8?B?WWdKZTRuSFlodmNheFI3Y1RVL0EwM0hRNXVSQWZVckMyaVdBeS8yTjZyNDdu?=
 =?utf-8?B?WEZnT2QwLzNnd1FkWDd4MWx5UHl0bFJNZzZCVXZMZW5hL0c0LzJRUG5oYkVS?=
 =?utf-8?B?bTdmdE8vajVKNGhJWHdJN2UyclY4SnpUOU9zQ29PczNGREg3NDFaTjk3TVVL?=
 =?utf-8?B?Qy9BTW05Mi9hb0ViL0IzYmFGd3pJNEFqN0lRbFlpb01aT1BjbE1lNjUzSVhZ?=
 =?utf-8?B?MGtZZlZQQ05EazZPRlhPSnRvZTdRQWNJbUdpaDdmaTl2MTAwcWU3bUdoK3VN?=
 =?utf-8?B?T1ovR1VmclZ4dUQwc3R4MXc4Z0FnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8478894c-785d-4e2d-ae22-08d9dab4d2c9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 19:00:41.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okCPvJgD1Iqd1Aenu/hGT3jZ+4GgPKsdBo9s9hT63FqWsdKuM9dyIDoq5g42z9PFuold88LuTo/rPwF4sUI6Pac0ZiNghr8sI77MWfEZc6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5795
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180113
X-Proofpoint-GUID: PhsSQegpFunzt2h9r632j-a8CAOOGFmf
X-Proofpoint-ORIG-GUID: PhsSQegpFunzt2h9r632j-a8CAOOGFmf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/22 12:51 PM, Mike Christie wrote:
> On 1/17/22 11:31 AM, Eric W. Biederman wrote:
>> Mike Christie <michael.christie@oracle.com> writes:
>>
>>> On 12/22/21 12:24 PM, Eric W. Biederman wrote:
>>>> All I am certain of is that you need to set
>>>> "args->exit_signal = -1;".  This prevents having to play games with
>>>> do_notify_parent.
>>>
>>> Hi Eric,
>>>
>>> I have all your review comments handled except this one. It's looking like it's
>>> more difficult than just setting the exit_signal=-1, so I wanted to check that
>>> I understood you.
>>
>> [snip problems with exit_signal = -1]
>>
>>>
>>> What do you think?
>>
>> I was wrong.  I appear to have confused the thread and the non-thread
>> cases.
>>
>> Perhaps I meant "args->exit_signal = 0".  That looks like
>> do_notify_parent won't send it, and thread_group_leader continues to do
>> the right thing.
> 
> That doesn't work too. exit_notify will call do_notify_parent but 
> our parent, qemu, does not ignore SIGCHILD so we will not drop
> down in into this chunk:
> 
>         psig = tsk->parent->sighand;
>         spin_lock_irqsave(&psig->siglock, flags);
>         if (!tsk->ptrace && sig == SIGCHLD &&
>             (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
>              (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {
> 
> do_notify_parent will return false and so autoreap in exit_notify will
> be false.
> 
> 
> 
>>
>> Baring any additional confusion on my part that cleanly solves the
>> problem of how not to send a signal from a child process cleanly.
>>


Oh yeah, maybe we are thinking about different things.

The issue I am hitting is that the parent, qemu, does not know about
these task_structs. And, userspace can add/delete these vhost devices
dynamically. So qemu could continue to run, but the vhost device could
be deleted. In this case I want to free up the task_struct resources
since we are no longer using it.

With kthreads do_notify_parent returns true and exit_notify calls
release_task, so it's handled for me. I had stuck in the USER/VHOST
check in the patch you didn't like to get that behavior.

If you prefer not adding the VHOST/USER task check in exit_notify then
instead of auto reaping, would another possible alternative be to add a
modified kernel_wait like function in the vhost layer to reap the task?
