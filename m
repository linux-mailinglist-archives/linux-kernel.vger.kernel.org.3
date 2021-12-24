Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FC447ED14
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhLXIYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:24:14 -0500
Received: from mail-am6eur05on2113.outbound.protection.outlook.com ([40.107.22.113]:56288
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351959AbhLXIYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:24:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHhRfXPCkMfqXhZhWxX7f50esJJl9pKCxxkC4NlzlI4JCY2wbAQDWKEA0gO5CZugskat7AwuOJJ/pkdAwXNgltcOXqakyZUduuLfZLhrWQfMFqnOEZpSurVWbtTWSfVeTZYmxUKXocn51Z/u0KQLht755Y2gxC3ab7QAo++TECplyTPVzTQbbIQVk/YBc1YlpMkDyvplwZBIcSFQaOWapEP3OiNAc1QSaRpQsKpLDBqUQc9qwiAAtRaJjsgUOfguVyY+gyVDvW3kyw7Ti0P2p1H9PgFfbVjPZOne5NQd9eechTdPnr2rLToymIyiYfKEVlpV7Zcosk+dis4g8AzgYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loUKAfRjxSFIg9Pxr/XNj0LCGdwjwOudVp7H9SFAysY=;
 b=Iw1zdhvWy2ptdiYa6q35M6tPMNCqpig8EE8MwuCb6k+RxWvw4Eg6x2ZxzhW1fxcpMy3ihH41M0F3FBn72FAj8tskesTtMSZZZuZ/9VCcjzVaA3hgyL3KUDOiIAijdOxQk++hiwMV1FB0ad5NJNNIxIRSJur4BXHadzsnWtuoGa5fXEyJ4ch3gN1ghrHagDCh8VbS+P2HcU2baiW7nkiUWaVa9G5pMTu8I4M9njo7ReIAE++GFGXcjg5M13wyeknUNctzL9b4vSizV40ZC6lyL0PLfUz2+59GlauEoq3zhJt3iJryjeFVuMioqBVsDW/vM9cXm2j2lGF4LkasP1Bg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loUKAfRjxSFIg9Pxr/XNj0LCGdwjwOudVp7H9SFAysY=;
 b=pRc1VKXTR4w2fqFiW73DVbRoYhGhV85eWS0bu3yQC2Rin9g9nJSu7A50jNf44FncjZGQCjvM1e8fH6xTsBV2ZhadIEmB9O1N3YUC6H9B3iRj1D9Pcpojanr3/KIb1dVQRtSABcvsItLctk1vtnptzV4SGFjdJeyGOnGleYFiAUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM0PR08MB4082.eurprd08.prod.outlook.com (2603:10a6:208:12e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Fri, 24 Dec
 2021 08:24:10 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 08:24:10 +0000
Subject: Re: [PATCH] v9fs: handle async processing of F_SETLK with FL_SLEEP
 flag
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>, kernel@openvz.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>
References: <076a9ce6-ae06-5b3e-f577-d993e55089f1@virtuozzo.com>
 <YcUCvUF10TKg2wDI@codewreck.org>
 <644227dc-4771-3111-aabd-20ac12b69a2d@virtuozzo.com>
 <YcV3XDFw5sMyvTVL@codewreck.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <96f79f24-bb2c-0c37-42a5-545fd382035e@virtuozzo.com>
Date:   Fri, 24 Dec 2021 11:24:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YcV3XDFw5sMyvTVL@codewreck.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9P194CA0013.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::17) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79614a9e-1c73-498c-8ea7-08d9c6b6c2e3
X-MS-TrafficTypeDiagnostic: AM0PR08MB4082:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB4082D6F4515DDFE54F29E031AA7F9@AM0PR08MB4082.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbEMMFSOQ/baSlRSEGmBDERHsFBvf61dH7L6fai/SkuDXeChe1DQApDojmXXeqHcdfDcCpaxxSN6ue39kq51k272ABQfhIHJWnr6KtuJ5a4XwNYlmvIhRO03Gun8FWtOztOWuSHdEQaTWDqQ8JZh5VnOvGefQ/lDAgLMpAihPs6q+WXyR975zh9FiuvFTfWu+TBrBiAwiEk9oYDN2gmWDytNs1uscFupvsSqzvSSGx5UzUBiM3m2ktGigGC41qus6XhdWlX3zvSkjwmi2L/CB0Fx+zvui0eLoYhib556di7fBBuV6ylCaj5hmbFZK4uQHQd3LbYn8baMOcrRdUIX2fcUg/dWtx4tvEcMSFQHns6UT/ZF5TbjgR5fewznJIWccbqHqwmqECrA004tEn5GhzlYbliHQXgraNGaqG8vuQP/rb3eDXWGP6NgS1JedH7N4ypNVVZMBlbkzE2VCiOMJd+DR+2oqmLGJiCoTDdq7zoUyY3wdMl01tG7x1i730VdShN6ETvxlt3xVIgaurhtWJu7JlCrl4uKMOGTXYPdHDOiDYDvuHZuLULXT7lW4Uzj4d/NvWGPcgYFbxvS+hczVj4i+s+3PFhVMgG57HQncpUaz8itCy9TGuCdFSAe7zu2eGg9dWRQHvFpkNpbprAx4jXhX4lXIrvVbBPrfCC2CQ4TEPERkIqYiVoKEjd1sYsSqB2ufmHVReLoKMwX2jspAyz84/4F/GpeZhDBHJIQ4YVG2Na8Vi8wLctQr/DjEuSm+qqAr/FIGhADyenIUxjpDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(8936002)(36756003)(6506007)(508600001)(316002)(186003)(26005)(66946007)(38100700002)(6916009)(54906003)(66556008)(2906002)(66476007)(8676002)(6486002)(52116002)(38350700002)(31686004)(4326008)(83380400001)(86362001)(31696002)(6512007)(5660300002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTFLZzYrU25Id0FCcG42Wi9vUURTb0FUTXpTc3pKSVZzam5mMXZJZTcvVVFs?=
 =?utf-8?B?MnkvM1U1TDFVRU12T3dEcTMyUTVEdGtNSFNvT2tOSGNBSG9nTnZURkR4ZEFy?=
 =?utf-8?B?eTJHK1NUNXlELzR3WkhaYnM5Sk56bE1ydTFPcmdua3ppbW91Wjd1THBMSTYv?=
 =?utf-8?B?VGdrcXVVQVNLNkw2NEswLzQyRmczRlgvY1E2SFdMT29uamNsNmlCMGVGa3VI?=
 =?utf-8?B?eXpLV3hyd01WNDZFT2VYWnZ2Y1MrQ3NkYU96SjBiUjhWc3VKWjBkV0JsMHF3?=
 =?utf-8?B?OFFHeTdnQm5mdnVKUXAwRElvT1BEQ1dVRU5aM1NHWWFKdmVMQVViZ3FaOXc0?=
 =?utf-8?B?VGVocjJKSXowQWJDLytIeWpWaitqZ2VjaDhxK0tMRURIYXRvc1JYcGJDaGRV?=
 =?utf-8?B?UUFqbXV6Z0N1WU16NEJ4cmpNWUFFWlpGNmtWZDlpYy9lY21oeDFYY2hHMkFI?=
 =?utf-8?B?cHlaRTMvNE81djF6Sit0NGZFOG9wcWh6YUdDM1F5dmlVQStBOGxLWXFhZTRw?=
 =?utf-8?B?ZStlMVN4dnJ2aDJYVUZhRlpFd09JMmtFSkI5MGpseGNtOGdPVWhIc3orY0hX?=
 =?utf-8?B?RVprbjlEU051czAwSndkSWUrMnVnSnB0R0lWalhxQ1g2Y1M0Vk5OdE1WOEg2?=
 =?utf-8?B?N3kxbnVPdDY5endGZEhuVUVXWHowaU84bG13VHptMkM2NVBJSWtpRDI2TnlR?=
 =?utf-8?B?NGJOa0RWc0FJTHE2VFlsVkwxMUxMRjlNSVNERHNyQ2VTaDZ3MHdqajEwRGdm?=
 =?utf-8?B?VEZkR0hQTVR3UCs0WERSTmJRNUc1aE5PZXhYTktpVUtFajdZU1JKVFhmOWg0?=
 =?utf-8?B?TWIzZy9wWU1remdudFFCdHpZYk11WHZaU0lRU1dnbzZVa0YyS3BFRS9xQnI3?=
 =?utf-8?B?a29XNTZFQ0d3VkxzVk16M2pYOWFqR3hQcmlGZHZGTFBMSDh4aFZLY0N1V1Rr?=
 =?utf-8?B?NWVud1FkWkMxdmVXNTROdzdBajUyRi85VVhmY2NZcUV6OTBPcFJvUE1nZmpE?=
 =?utf-8?B?eGZ0SkVXMWpLcm0ybG14U2haRVB6V3NNZHdUQ2YwUUVDbmFDNzJNTDNDOTNn?=
 =?utf-8?B?eUVHVG02OXcxZjBPRzBTck5qZ1g1NTcvamh3UUVoOFdJd0FGYkJDL2NNQTd0?=
 =?utf-8?B?dlFVR2hGc3ZqcGtzdUFOZlJnd3FnSDNLZFZNdmpvQmE0Y1BOQklMUytzM09t?=
 =?utf-8?B?bS9Wc3haQXk4dENPYmdQOE8yaDBMWG1XUWJyY2lYd0tyN2QySUMvQlIvdzNs?=
 =?utf-8?B?ekVEYzRpNzNabUtGNTlzU08wOUJ5Qi9QeHEvWnREdDNLUE56YW03VERqMG5v?=
 =?utf-8?B?LzJLNGtzSUQ5c0xrZmpBRjJDWFNOWWVsT3RZc1dDazlJUlhuSm4ydEdNL2h0?=
 =?utf-8?B?dDd3NTZWRVR4TUtTaE94L3JzRUkyeDJ0N1ZnekFyV0NaMEtBNHpubEhjUTZ0?=
 =?utf-8?B?dzZ0N2YzSGxnVzNubkRaS0ZGWU02YXJkWDJWejlBZ1pKK2tGNkloa3V3dEdU?=
 =?utf-8?B?amE1S1RCWnFzVEtZbGkwVlgyNFlYTTZSbjZYVWJEZVVnL2NEWk9zM0R3M0NC?=
 =?utf-8?B?dzliV0Y3eDgwM2VtSTU0STE0bklMeUUycXlUZThIbFQwdVRsR2RVcHdqa1Q0?=
 =?utf-8?B?Skw3THNWcjMwZUU3eWdDYkF1OWl1RXZHT24wOC9heTRxOGhpbHJDWThHSER6?=
 =?utf-8?B?UnIzZFBQMnlGU1JmSzlReG9hejg0d2RaSmtIaXQyR0VBQ09vSFV6eTkrUXNu?=
 =?utf-8?B?KzQ4T1k3MmpxbFd4RnhXK0RKajE5dnhIQWFZT2J6SWZjYXlMZDh3ZFR2YlVH?=
 =?utf-8?B?L0g1VTVDMHRXeGpqZTl6QTZoZXpXSFpRZmt4Q3FIV1hZQVhGbDFueUw2RzRV?=
 =?utf-8?B?MWxiVk5sYlVYN1o5V2hVZlExdmk3QWdKd3dBYlpPQ1VNWUtUVVZHem9pMWZ3?=
 =?utf-8?B?Y0t2dEJDWStyTTZKZkJqMWdHUWVzM1hhSVhPZjNMNzE4blBSdUV3YUcvdkxo?=
 =?utf-8?B?QkVJWk9BSnVLWDFNVTFTbTlCQnRheWk1dkx2c2NyR2Z6aHV0R0Z2Q2dZdWln?=
 =?utf-8?B?SCs3VTAvK2JUS01DUTNlVEUrUHJzYXdSOHhCdWZqdW0zaEJaQWNGK3E3am42?=
 =?utf-8?B?alNvTzJMNmNCTmhiL3JHTitvUjBIR1VBM0VpT2NpN3hRSFAxT2NKZnJaQkpp?=
 =?utf-8?Q?5F0Uqc57KLfmNEh7I8ynBn4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79614a9e-1c73-498c-8ea7-08d9c6b6c2e3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 08:24:10.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWEN6/ytbo2DV6PtA9AOh1QAjqdnttoBGhgIX6O9AqBG6LYxpc/pp8d04gJx3Kxpv/1wt7a99vICluNZNzWneg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.12.2021 10:31, Dominique Martinet wrote:
> Vasily Averin wrote on Fri, Dec 24, 2021 at 10:08:57AM +0300:
>>> I'm not up to date with lock mechanisms, could you confirm I understand
>>> the flags right?
>>> - F_SETLK: tries to lock, on conflict return immediately with error
>>> - F_SETLKW|FL_SLEEP: tries to lock, on conflict wait for lock to become available
>>> - F_SETLKW: not possible through flock/fcntl setlk, can happen otherwise?
>>> but for 9p purpose same as above.
>>> - F_SETLK|FL_SLEEP: tries to lock, on conflict ????? you'd want it to
>>> return immediately but setup some callback to be woken up? how could
>>> that work without passing some wake up struct? or just behave as plain
>>> F_SETLK? but then FL_SLEEP has no purpose, I don't get it.
>>
>> I apologize in advance for the long answer, but I tried to state all the details
>> of the detected problem.
>>
>> Below is description copy-pasted from comment above vfs_lock_file()
> 
> Thanks, I hadn't noticed this comment this morning.
> 
>> "
>>  * To avoid blocking kernel daemons, such as lockd, that need to acquire POSIX
>>  * locks, the ->lock() interface may return asynchronously, before the lock has
>>  * been granted or denied by the underlying filesystem, if (and only if)
>>  * lm_grant is set. Callers expecting ->lock() to return asynchronously
>>  * will only use F_SETLK, not F_SETLKW; they will set FL_SLEEP if (and only if)
>>  * the request is for a blocking lock. When ->lock() does return asynchronously,
>>  * it must return FILE_LOCK_DEFERRED, and call ->lm_grant() when the lock
>>  * request completes.
> 
> Ok so that's the part I was missing.
> The file_lock struct will have fl_lmops->lm_grant set in this case and
> we just need to remember that and call lm_grant when the lock has been set...

Unfortunately it isn't enough.
lm_grant is defined by lockd only, but nfsd and ksmbd does not use it.

Most of file systems does not use lm_grant, and it's OK.
2 file systems --  gfs2 and ocfs -- use lm_grant via dlm_posix_lock(),
which works correctly even if lm_grant is not defined.

>> They all are servers, and they can receive blocking lock requests from own clients.
>> They all cannot process such requests synchronously because it causes server deadlock.
>> In simplest form, if single threaded nfsd is blocked on processing such request,
>> whole nfs server cannot process any other commands.
> 
> Note 9p does not have an fh_to_dentry op (no open by handle type of
> calls, the protocol just has no way of dealing with it), so I believe
> knfsd cannot re-export 9p filesystems and wouldn't be surprised if
> others can't either -- as thus this all might not be an issue for you if
> F_SETLK|FL_SLEEP users all are such servers

Perhaps you are right.
I'm not qualified enough to confirm it, but I tend to agree with you: without defined export_op
nfsd cannot export your file system.
However:
1) perhaps this issue can be triggered via ksmbd
2) you can add export_op in the future and forget about this problem.
3) proposed changes are minimal and does not affect any other use cases.

>> One of our customers tried to export fuse/glusters via nfsd and reported about
>> memory corruption in nfsd4_lock() function. We found few related bugs in nfsd,
>> however finally we noticed that fuse blocks on processing such requests. 
>> During investigation we have found that fuse just ignored F_SETLK command,
>> handled FL_SLEEP flag and submitted blocking FUSE_SETLKW command.
> 
> I'm not sure I understand how upgrading to SETLKW is worse than dropping
> the FL_SLEEP flag (I mean, I see it's bad as it wasn't what the server
> expects, but while it will block a thread for an undefined period of
> time and may cause deadlocks I don't see how it would cause memory
> corruptions?)

kernel threads cannot use blocking SETLKW. 
SETLKW can be safely used by usual processes, if they want to wait until lock
will be captured. However it is not an option for server with limited number
of working threads.

Memory corruption was internal nfsd issues triggered by very long processing
of blocking lock request in fuse.  

I'm sorry, I'll answer rest of  questions later.

Thank you,	Vasily Averin
