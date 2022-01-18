Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73E4492DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348081AbiARSwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:52:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39120 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244954AbiARSwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:52:03 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IHSZCd006913;
        Tue, 18 Jan 2022 18:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OBe4oyUioHpgkVhgIBd03orCQPX18rRWXwC/SbxwAMY=;
 b=Ib8DOgNOyV/bWBWaVPB/O8hn570VqJFwkaXToLh10OpGWgBYJlTaD3oyhhdP3AGT1B8v
 IwM5hFpYmnN6gdHwawzCk4fawd4hg1+PR9zKYk4a2NSvli+pIc7O4Wu267vIL0B3PcDn
 /fJ/5cZcV4GjZibsNg4JrVf1q6E7Mt7zAKsJ7jf445/IjXp31rvA7IRYL0jldMfRoCzo
 rT8Ll7pRfni8TDPaoAIwMK6hgohlZUn0dTnwLRlnPuemua9fSIOPojpPl8/bPd06lEUf
 jzBIPWHqg5BF8Ey9S7ukDLsBiba9PoZziU/XxcG9KGv+eMa3RJ9HFbeERW8ZWfH4Oxdt RQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnbrnttc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 18:51:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IIaX5P192760;
        Tue, 18 Jan 2022 18:51:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3030.oracle.com with ESMTP id 3dkkcxseng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 18:51:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIX+GXceAjAHOMbg+3tXLrbLRpLkwEU7JkKChfIzGU620SW/pgSWp/VHNhxrl3mGcxj0lfMcV7ZNnFYbHjr4fIQisDNtVemF9VifpNmu/8hpBtEAGPrxe18aMlNqieYXLbQu1WxRAAOeuyeaCDqy1BoB8kOS1mYZZ2v5KxMEBtMWwG7ogWbURv1IIfNd98YnJJW80MDOhAza86O/g94zyj0vdSw3++IDe07WSmdOnpSmuVMZicgCQYnqtLgZUOe3djiq5wPA6dCaFGx7qus9dcQKIHGDWKadW74E+56wlr95wQrG8TXL0BNdF4jzPokSBmk5P00NxoPvzLF+gcIYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBe4oyUioHpgkVhgIBd03orCQPX18rRWXwC/SbxwAMY=;
 b=dWVqG98+ijSnlNwwfOWRhqvkBd7okOOzK2J1gxQXtsb45EsTjyDLyti+V/K8PJE2Y5cekI2C6uIw/0b50Wjosa2sIPSsgSDUHfp84leocI4blqjetqsMXN901jnDal6qPkUnMkzu4udc4UtEn0LH4bS/nfKVHhr32TkN4Ra69zr8onSH8Pwmx14CH7vT+JWj2po9S7d+/fI0t5GhN0rLNnuU30zuak8/t3mNIJ1fIB2B56WYdIR9gVR5WTJVynmWKZcW94lzQECM4KF3O8ta9f9YczBjr5k7Y/C/kZEAPwm7fzTCDzHJL4opdePCTT+e2qcP73MhrhjZNvCheZ0ymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBe4oyUioHpgkVhgIBd03orCQPX18rRWXwC/SbxwAMY=;
 b=NGECIokiHntVPhex6Kv2Cv0ic4H6KXBqU/i+SUFsfnD3tOj+etccOS+CNI0ioTEnXUtm2sPxQ5NctpXXBDa3qLHWHumXxjLRt+9iv50S8U02c7FovxfYGjCQzgTQQQzk8rxQF1GleeOfHonda2N//9neEOT1/2yGcnWoQqtPdsk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5360.namprd10.prod.outlook.com (2603:10b6:5:3a7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Tue, 18 Jan 2022 18:51:29 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 18:51:29 +0000
Message-ID: <68ba89ae-108e-c14a-02a0-db72b169c9b1@oracle.com>
Date:   Tue, 18 Jan 2022 12:51:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
Content-Language: en-US
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
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <874k62b76d.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:610:5a::36) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c462a9f-d317-446a-b2d6-08d9dab38971
X-MS-TrafficTypeDiagnostic: DS7PR10MB5360:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5360F6D2B0813BE1A391C3D8F1589@DS7PR10MB5360.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXduts3vUlk2QdB22lbga3+A5PL/b2bwn4+7eYRoq3CH0VDgp05rYOhJfbinPZ8NU6ex7Cq5NiO7I1NnOjgxT6ChOqNxyjMKQgTqipMvjaJdnELplhFcAqY32Gwsxsnw8ge9nekBNbdgmP2nQQ4Wy4varVulbnoo+yZrJCWWmBe4rzKixopymjNxHKpf0j5jfX/H7aGJX9WHqIw4Y/fGG2NteBUOh8MkoWIg5KLTpooN2kSG/4YJXKAvfRPO77ByRxeVmmJNkSmgu+7nYecFXA8uWOsL3s9IGDq8RWD8pxsVglqcvdqp5jWlV+/PT5pS2oZs3LhO3/C8mRToO0PQ9oNWBd3ATvON+ahGY5k+bWVErL36H58pyYttcJKpYG8uHRn6VlQxz7hQeLJlwGX63b1e5eaefC7g15EnNhwzUf35/+ud5m/KDLHEBGT/EEEMU6X7UVyvwnN9pEdOSaFaL32Pl8alwlgrLJ2/1iohrxQmqIUcqpy9TOQ6dWr90ryn+SNw0UVWTyYCpoffhjBpHlNij6cAjVOc1TfSUZBQBylaD3dUmpH0s4ODP2mz6//3N7NLOJ4Y8/b+dU+tgXSHYeB/z1d7nVMUQQ85bMfFVK+wkTHCeRVc07UEfWuzMf2OOKJPty09JRKUwrzG+ozL7MQKesX6uoayX/yX9oePRlWBTktKKbN+z3NRyiGC5tu7pIiQy1kYE+eL/p+EBZmhXrTGS2bY9E5IUDdLAyYbm5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(83380400001)(2906002)(316002)(186003)(53546011)(6916009)(7416002)(31686004)(5660300002)(508600001)(8676002)(36756003)(8936002)(26005)(86362001)(66946007)(66476007)(66556008)(4326008)(31696002)(2616005)(6512007)(6486002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU0zMHNueXNXZlRybElkbnJ2eS9Jb1ZOUnBnb3NGaFhMTTd1a2hYQjRZZkVJ?=
 =?utf-8?B?MitpRVBuNDdqTnU0V2Q1cGU0V3lZYllVdHNDdXdva1kvdW81aW5pK3lueWNB?=
 =?utf-8?B?ZjBTZkdKdm5Yb2UzcHBpSVk2cmc0T1RKTzc2clVkSlRnL3EwOVAwbXZnd1hm?=
 =?utf-8?B?bVBmU0M4S0J0cEhiVnpBRnBILzB3VnhzOHEzNEtTaURSYjY1SUJ4akYrOWtK?=
 =?utf-8?B?cXVIQnR4eDBFUTYvWVdMb3hkUmZHaml5R2ZESXJDS2RNZ2dMRnBvZTRnUDkw?=
 =?utf-8?B?NDdmYVJ1YVREVkJSN1lLZlVlY0FEV1UyNThCNi9aVDN4VWsybjFFblpWd2I5?=
 =?utf-8?B?cmh1K1FISElrdHJYM1F6Y3RRaUJJT09GZjJQV3pwY1RPbDZ0Y05LSnZaeHhq?=
 =?utf-8?B?QUUwM2ZSdTNRRS8yM2lwMW9jbFZuNmQyc3ZLN0pkMlB1T2Y4Q0VPellXZ2Jy?=
 =?utf-8?B?ZWZIdWJPNUtROSsrVis3eUc3QkdsdUM4UkdwYVRYUWZHRkFtcUoza1RzSXkw?=
 =?utf-8?B?Nm9zL0R2bkE0ZXd6NGZTcHdYV0x5bWdPOXlVa0Y0WXdNZTBRSXRYUE1aTjlu?=
 =?utf-8?B?cXREZ2ZZWENEYUVoWSt2eUo0UnJhM1dTbysydmE2S2ptQWlQenpXbi9OTEJt?=
 =?utf-8?B?UEFFMFRjRmJNK1owNGNiQ2s4b0pEejVQcUVmNUtiTnRISDl4M0g0SWFFb0k2?=
 =?utf-8?B?bEJibFE4MXFCMUtneC9EWU9mV1BRdmZnQ2s0S3p4VTdOT0N1VXJPMjJES0w3?=
 =?utf-8?B?Q1Z4amFCakhFWjVpNWVLSlY3Ulo0N2lZRWMyOVhqTmRUWmdWb1dPZ2FQUnlW?=
 =?utf-8?B?S0wreXRZZDhwZFJhU3pKU0VnMmtBV09PRWNsVnRHUnFSVnozbjZ2SnRLYWlC?=
 =?utf-8?B?VzNHSUxONUpFMHU4ckNhN09kN2NydkwwUmY2bEJ1Vy8vMkFsMUxRVmowU1JO?=
 =?utf-8?B?RHpnYzlyT3J1WGtBcW1XTjRja05yN3dWaEJkOVk0M25hd21pS2sxb2k2cU9Z?=
 =?utf-8?B?SHoyKzlVa3FkTmJucGZaaEJtL0hxMzVPQnQwcHdUdm5mYThMdU1CenBjcFIx?=
 =?utf-8?B?SGhFSldOOHRUQXNDbzBDMmF6Tk1QZ3V4UzV0QVpRLzJIbFVmUEtCQkFBaDJ2?=
 =?utf-8?B?YWp6WDBaQkJXY2UzMnVUK0lVWEE4WXFkNmdwU21WUlBCK2xWRFVqRTB5dDBp?=
 =?utf-8?B?YmtsYVRQMmJoL0QwWjhWdkhybnBzbjRrRVhZbGZPWWxsb29NOE51Sy9NRUhR?=
 =?utf-8?B?Y3BGN1NhZGVKb0N3RTZBN0h0UVVObUV5VDFqTldNWUtqdVdjZWdMMUg5Vlg0?=
 =?utf-8?B?Y21welFxM1lGN2tROUxvakwyYTlLcUpINHdIQy9uNmJodFh4cXB1NUpRNFpK?=
 =?utf-8?B?YjhObXFHNWMrR2EyTnJpK01RekI1VGhwcGVBYlpWaThjTTlZVE1CVmZDQWxZ?=
 =?utf-8?B?bHBZR1NFOVFhQmFsVGpsZzZ3cHprQmNySVlsbUV2djdsZitXTEFYd05XRDJP?=
 =?utf-8?B?azJlbWRPaXZENlRkQUxaUmUvVFlZNVg0VjR2QUtNTzJqNG1RclFJNFRYU3V2?=
 =?utf-8?B?dGVxdDFJWDZjMG84VURiblFFSnpJU3ArZ1BVSzlOVStnYUhDYW41OURJR0lo?=
 =?utf-8?B?VnlWd3NOOThIUzE3VFhUejZNQkVUa1pwREVnQkcyQUo1TEVGWXZwUXR5aTB0?=
 =?utf-8?B?VHRIdXpZbHNoM0JRNlRRZDVVRGVQVGc4cVdMdm90eE5IcXZiNXh2ZTZobHY2?=
 =?utf-8?B?TzVMeWwvZ3dFcmZ6R0t5QXdta3FJQ0NWTjUwdGVzZXZWTXAzeEhWZXR2d095?=
 =?utf-8?B?RjNkdDdvZmt0c3Z4V28wbnVvWU9HRHN0ZFczRTBTSDVVV3NselZBK3d6enY2?=
 =?utf-8?B?UGxsbWl4M1dUSUZlby8rUmNEN3FoMmE1NDM1NXJ6Z3FBbUxna2YwTlcvMSti?=
 =?utf-8?B?aDUyTElWSWsvVnN2cEtvcjlmOUhYeDMyaUpXWFg3aE5TRENzMHlpUHVzYk9i?=
 =?utf-8?B?RzIxNTcrMEx2WUtCam9QSmJxNExpdUJycHE2OE9lTkd3NmdGcGtJQmt4YlVr?=
 =?utf-8?B?Y2dhMGRVQ1pXTVVGRXZaTENLV2d1bXhYam01ZGZ1eDBlY1lRVEdDOEsxdVpl?=
 =?utf-8?B?dDJWVnZpNWxmZEY5NzljbEhlb1VmV2lMVWRmdW9jcnBSMWpiRWRHQTh3WFZo?=
 =?utf-8?B?cU1rbjd6VW5Ib3NrbFZheERNUFJ1YnpnemZoa2QvS0xJeVpUeitYOWxic1ha?=
 =?utf-8?B?bVBpOG9nbnMwblpKa2hkcVJSaWl3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c462a9f-d317-446a-b2d6-08d9dab38971
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 18:51:29.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnJVvfE/bg1ibn76hTDPFMp58LRFVSWNU1S/iw38w/RvTyx27bFudz4NfLRITDQ98ZEfD2mJzh3oN/lOnKjNjZPFkF+vEYimihdkZZRqdfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5360
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180112
X-Proofpoint-GUID: OIEzz4g3TcUtwZUJ481ckcCk9HrJsP0C
X-Proofpoint-ORIG-GUID: OIEzz4g3TcUtwZUJ481ckcCk9HrJsP0C
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 11:31 AM, Eric W. Biederman wrote:
> Mike Christie <michael.christie@oracle.com> writes:
> 
>> On 12/22/21 12:24 PM, Eric W. Biederman wrote:
>>> All I am certain of is that you need to set
>>> "args->exit_signal = -1;".  This prevents having to play games with
>>> do_notify_parent.
>>
>> Hi Eric,
>>
>> I have all your review comments handled except this one. It's looking like it's
>> more difficult than just setting the exit_signal=-1, so I wanted to check that
>> I understood you.
> 
> [snip problems with exit_signal = -1]
> 
>>
>> What do you think?
> 
> I was wrong.  I appear to have confused the thread and the non-thread
> cases.
> 
> Perhaps I meant "args->exit_signal = 0".  That looks like
> do_notify_parent won't send it, and thread_group_leader continues to do
> the right thing.

That doesn't work too. exit_notify will call do_notify_parent but 
our parent, qemu, does not ignore SIGCHILD so we will not drop
down in into this chunk:

        psig = tsk->parent->sighand;
        spin_lock_irqsave(&psig->siglock, flags);
        if (!tsk->ptrace && sig == SIGCHLD &&
            (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
             (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {

do_notify_parent will return false and so autoreap in exit_notify will
be false.



> 
> Baring any additional confusion on my part that cleanly solves the
> problem of how not to send a signal from a child process cleanly.
> 
> My apologies for sending you on a wild goose chase.
> 

It's no problem. I learned a lot about signal handling :)
