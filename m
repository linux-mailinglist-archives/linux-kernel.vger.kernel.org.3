Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5621C47EC8E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 08:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351756AbhLXHJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 02:09:18 -0500
Received: from mail-eopbgr80101.outbound.protection.outlook.com ([40.107.8.101]:28415
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343543AbhLXHJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 02:09:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQcT6vNBz68OUBMbzCWU6qsB8W/ex0FRIWmySfdw/PHVJ1L3Hp+FV80t+fP+iCSq4Iw3g8E5NpFGmCQ6LVpBjsDqiqmZLUJyuY0yRn01ToNGDd1RhPOXS+pW3utJ8Jp1fQxIZ6G7e0hgdSFe90Br+MdY451YusBaSBTXjj0GNBFu/Ef2YXplZs56yvk7/2rPZILoYiBHI4S0Vok2iYb0lGxH3g9U9YKUFexXRH4n5OFsURMvWpnp7Dfb1jBBNatPEbX1AU8Ng8FlKrhAmtUhCBFpF0MjgNDfdyFusoCd4pBxsyJX3wSzbQ51cTpkO5dk2a4QyQfKHFx3lYSHEdGR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/Unv8xhepTwKI3NGjCArtAObWrLEPWjNfsMsGk3AEI=;
 b=GdMiY/86yAPpTnx0fKc5pIi6QX+vGU+jrOIz/pjsGyjeVZWh8CilFBghbj+gKPy2/NMa+ZD0qQWDOaF+QKGu3yBNeU40tSwoDeDqLkdpsM71NUtjz3RVZ8Ng0nrd3D12wOvROPMNCzkp08Qsazjn86Zd6ztAXPIOVYOTtiMBT2xe8uadpuLEfPUR4k1ME0t7BF419UlCaCcW22/ErBfolidwoOPYiHts/o2KGEM2rpiO68uxIQ7Sxls4ZmuHsbu1j6RgTjZ4dEOz7mwBc8AP41uWtWjNYpvGiZN+BgYKcul3XZCWXdWDRtlZqhkOE/ZIyUhbA2xsbHwsr9wffqusyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/Unv8xhepTwKI3NGjCArtAObWrLEPWjNfsMsGk3AEI=;
 b=kQ4SOAzbQsdLjKUzaoVJAXZwNJT9U/c/woZg1MTh4AYTpG3gob9rpPc8/S0YLsL5MoqIrVN1r6Uw7Hn5XFhpE/HcZ0gCLgsrz1mIux3usWEtIT0VyxOR4kD3MBsIPEJzgnDyaieiDvlOiwxfdGAyzqRMMkuZ9rbfxh8EJrdy9fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM9PR08MB6146.eurprd08.prod.outlook.com (2603:10a6:20b:2db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 07:08:59 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 07:08:59 +0000
Subject: Re: [PATCH] v9fs: handle async processing of F_SETLK with FL_SLEEP
 flag
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>, kernel@openvz.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>
References: <076a9ce6-ae06-5b3e-f577-d993e55089f1@virtuozzo.com>
 <YcUCvUF10TKg2wDI@codewreck.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <644227dc-4771-3111-aabd-20ac12b69a2d@virtuozzo.com>
Date:   Fri, 24 Dec 2021 10:08:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YcUCvUF10TKg2wDI@codewreck.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0502CA0022.eurprd05.prod.outlook.com
 (2603:10a6:203:91::32) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc31fc46-1170-4a2d-c6ac-08d9c6ac41af
X-MS-TrafficTypeDiagnostic: AM9PR08MB6146:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB614640454AF4F94732AE7582AA7F9@AM9PR08MB6146.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nne/Rbb29LgEh7pJ8CUU7wrflEea7za90sVdwmKFWmCo9tIAuOzK8+u1uD6ff2H8FShPKuTeWtGH1C7Yi1fOLq/3nikpyGu3DUXh5cdh4459Mkeza/jolSDHXeJoFkhb+vvnajuEtCuF30oBydBGXfKF84YMEryfXUiOAZDn3P/azm1wcqWCvmSFH9yNb1IyzsnI1kKURS4yZk7nGMhyBHLoqlwmTe6IrFkBJ1+ztuVyMznUe2+5vuRcO+L4TKleI3p3ADCUdwe1vq6k80QsH6kfnb84jq/Ptwc57JG4mLwic7kTn3haBr0/RdToJQ2Q/sIHz3/wQluMknou2+rhd274ls19II+H8W8V7owVEeZnMnoMkvqU6L//ZJEuJYsxdDVXD8K4IBxbWHgD3pWLC4giQDJ1ycYwYOKlHPyaoIfSvMqleJiMIAf4Kw9PCHQHtUo/vPDgZDVa1KYU/jnkbTzp2C3DE5QDxXkyBibj4M4EvmYGfIKYsGZ2lkd94BTb2P6gmKuhzzgXwGR4bfEYoo70GfhlnwQzeo8Ecadc2I8B0KxY3pZm43hI65pfwbJia71bc93HPUtSDkXObixyrVaJlK/zTK2+xzuO7mGfBw24ZsTSfLOkKXTW2UkQlz/hCPEXgWgryto8d1slKs+CbrV/FQwlin0wmR2nyXOxiOgAWi9OIGGf6/oo6OCQLHQPKuLzUgcQAeF90BT+Sv6c7P9zJ3ztUhJcb+KOXq0olEzgW8wU0odCO77kpVAhhFt5t/+pskYiIA7XUfNQWkqGPLul+wdHmSsKYHYB/MbDE68CdtFwLFIDY94mJea0aSy16rWwXqqQDjJ+A5Kl5Ve/pqQFJMy/yc3761Wyf1t7A4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(6506007)(53546011)(38100700002)(38350700002)(31686004)(508600001)(6486002)(54906003)(966005)(52116002)(83380400001)(86362001)(4326008)(6916009)(66476007)(66556008)(66946007)(8676002)(186003)(8936002)(26005)(31696002)(2906002)(316002)(36756003)(5660300002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUdyTzVLb09ucmhQbGZzVzkrTjEveFg5aWt1RmlreVBFNFRZZXFUaXZQVHoz?=
 =?utf-8?B?RnZHYmFIdkxBbHBMdTJxdjVwUTVVZ3hESzNuemVHY3lZZkpFK2VaNExDanh1?=
 =?utf-8?B?LzMzb0todEtwdkFDdm5oOXZtbHpMSG1qMUgzOVNML1hDN3ZidFNwWG9CNWQw?=
 =?utf-8?B?WER0UVY2S1pKREp6b2srWGRQa1M3Q0ZJMUpTaXBaTnJNdE51cHpSRHFBSStp?=
 =?utf-8?B?MVJxYmdpZUJXNEpWNnBFdEEwZE0vcFhBNThnNVdxSFFPbDdqblo0ZTBjbHdX?=
 =?utf-8?B?YmI2MnliSjNTbzFDL3MzamZDcEVTeEVUaXlvamxvYzRvc2kzQ3hRY3NKUWdZ?=
 =?utf-8?B?TkwzVjlCSUlIV042QS8rMWJBYktvTUNoUEFGNTdEN21iNnJ1Mm02QWUrMWJP?=
 =?utf-8?B?aTYzb3VmU1FYcm9qNmhlQ0VPZit4OTN2ZkpEQ2F2cXV6bGNEcUhyVVJoRVFu?=
 =?utf-8?B?YzNucXJPTnRlaFZzUXk4TFlrVG9TazRkZzBTSHhzd2FIVm9RYnYzSlpWVHVF?=
 =?utf-8?B?YjB0bmY2TEw4L3BhMEZ1RW0rZmRhTm4xTEt4QkZkYjhzeExPV1A2ZnNRTmdY?=
 =?utf-8?B?RTZCVHhCbWVnTmI2cXRPajUrZ1F3ZVJ4d2N0cVVEdmpxV1RGMy9rcC9jajFU?=
 =?utf-8?B?SkdHcnlvSG43UjV5cE5ydy9wSHZkaGJwM056ZmlWSUovckYrQWxSMHBibGcr?=
 =?utf-8?B?Q1dPbTYwRnBpNVZZZ3F2ZUo4M1BwNVA1SDM0ODh5Q3pjMmtGNTdqejgrV2dW?=
 =?utf-8?B?bThCRzNzQVBKUllKVUR5N0M2RTFRV2NyVWRsSHZtbkdVWS83M1J5UXA5SFNr?=
 =?utf-8?B?VUxraGNreUs4alhuK3l5RDRqRXJVSTRHM3RrREEwaTJ0K3QxKzZMZEdPaGpB?=
 =?utf-8?B?MjY1UVFwTjZ5NnJBamw1YVQyZHJZaW1RcjE4K2daZ2RYWkg1VWtMVDdXM1Ev?=
 =?utf-8?B?cHVBMmR4V2I1Y2tJUEV4Y3duWnRiSjNVRDdQMGVIaGRMelZoWnpTR3dpbjFW?=
 =?utf-8?B?RGdta3lQcEhEZk5XMVg1anBvUkw4MUtneXdRS2VnSy9BUlpJeVRqblJWSUdI?=
 =?utf-8?B?RzY0Mm4rU2hvVWoxZHU0ZXhSZUlab0tRVUp3THJwMDUxZFJHZlhMWnpDR2Vn?=
 =?utf-8?B?YTJGZ0VSbk1NbkJGak1NSXFVdGZPdmVBVHhFV1BMd1hYYlhnNFJRcldsaEov?=
 =?utf-8?B?WFRoMlhVS1A3Y3BmRTVCbWJ4cm93Z0ZISThmM3ZKbHlyaHE5QkI1Yko2WG1y?=
 =?utf-8?B?Z0xOVkJDVnBHY1k2NDVEcTkveGlDZ2tJT2FuYW5ZSGVyUHZRbnF3RjEyaUJo?=
 =?utf-8?B?Mnd5Zm9ESFhZeHRmZHU3NjhqVEV0ejZqT0RFd3Noclp5NTRsOUpVRTNmeUpt?=
 =?utf-8?B?bHpNdlpoSXNiRUVWb0JEMWVyemxaRzNDb1kxbjlta3RFdm1QaEltYWNuVEVP?=
 =?utf-8?B?YXdGajZPejQ4VW1MbHpoaEFvTnV6WnA5NmZWTzM3cTRtbVUwYk1WZG0zVzNo?=
 =?utf-8?B?cXgzbmNRVVVIRjk0WlpMcEVWdFg1bTFKemMyMGpieEJORVVzbjBLSTBkV0gy?=
 =?utf-8?B?cWo4ZUlHMVNHb2RqQnpBZk12MFlFcGprWVZIcVFDVXNsSXVDWFh1TjBuaXFN?=
 =?utf-8?B?ck1IenBldGJsNlBPMjE3SFB5R1hsR1JaS0cyRDVYWmR6N3o3NFlQK0hRalIr?=
 =?utf-8?B?QlBLWDdDaGxLRndUSXpkRGZ5MjhOS1BCQTMvOUVGUU5YWXJiVnp0RVRhejd4?=
 =?utf-8?B?M3dmenBJU2JwTXk3bThrdXY4WDBBODg3SmdWWlBoVjY5cXZyTVN5bzY3V3dX?=
 =?utf-8?B?MEppT1d1a2N6TE4wSTVCQWhwK3hOYk9VazFvNER2Z1IyditKUlhVaGxveTVk?=
 =?utf-8?B?NHdzSEF1ejd0YjE4MDh3L0huV0lQYVgvOTVPOFM5UU5aZzVYemk4c3M5SDJH?=
 =?utf-8?B?OVJFL1hQL3Z5MXd3anNHREhJb2U1bFBvTFJHV2tsWWpreGNhUENUOGZjR0pE?=
 =?utf-8?B?cmo2NWFGOHVkR1RFZ0FCK3hZWUltRkxiRCtsd3ZCS2NnbDBGVlVscHNla2xY?=
 =?utf-8?B?eFRTV1hXMFprSEJtajRKWS9aNWNKWTdCZGd0UzkwZ0hKVkoxQTBETkxHZzlI?=
 =?utf-8?B?SllWQnM1Z2xkZE1kb0RhbHpvY2EvS3ZhUTc3VmhTR2RUSlRrSTJVUUtCVVlH?=
 =?utf-8?Q?jmTE581JH/offypGzW9iv8w=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc31fc46-1170-4a2d-c6ac-08d9c6ac41af
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 07:08:59.0379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O++SGK+zPP7opqzJfiq6eiis0wWdn1SydpfH0W3Tu06ayVnNj2QUUqCQJAORlX8LuflFdprO+qXKGkh7Bk3wjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6146
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.12.2021 02:14, Dominique Martinet wrote:
> Vasily Averin wrote on Thu, Dec 23, 2021 at 09:21:23PM +0300:
>> kernel export thread (nfsd/lockd/ksmbd) uses F_SETLK cmd with the FL_SLEEP
>> flag set to request asynchronous processing of blocking locks.
>>
>> Currently v9fs does not support such requests and calls blocking
>> locks_lock_file_wait() function.
> 
> There's two stages to 9p locks: the client first tries to get the lock
> locally on the client, then if it was obtained locally also tries to get
> it on the server.
> I believe the servers should just ignores flags like FL_SLEEP they don't
> know about, so we need to translate it as well if required.
> 
>> To work around the problem let's detect such request, drop FL_SLEEP
>> before execution of potentially blocking functions.
> 
> I'm not up to date with lock mechanisms, could you confirm I understand
> the flags right?
> - F_SETLK: tries to lock, on conflict return immediately with error
> - F_SETLKW|FL_SLEEP: tries to lock, on conflict wait for lock to become available
> - F_SETLKW: not possible through flock/fcntl setlk, can happen otherwise?
> but for 9p purpose same as above.
> - F_SETLK|FL_SLEEP: tries to lock, on conflict ????? you'd want it to
> return immediately but setup some callback to be woken up? how could
> that work without passing some wake up struct? or just behave as plain
> F_SETLK? but then FL_SLEEP has no purpose, I don't get it.

I apologize in advance for the long answer, but I tried to state all the details
of the detected problem.

Below is description copy-pasted from comment above vfs_lock_file()
"
 * To avoid blocking kernel daemons, such as lockd, that need to acquire POSIX
 * locks, the ->lock() interface may return asynchronously, before the lock has
 * been granted or denied by the underlying filesystem, if (and only if)
 * lm_grant is set. Callers expecting ->lock() to return asynchronously
 * will only use F_SETLK, not F_SETLKW; they will set FL_SLEEP if (and only if)
 * the request is for a blocking lock. When ->lock() does return asynchronously,
 * it must return FILE_LOCK_DEFERRED, and call ->lm_grant() when the lock
 * request completes.
 * If the request is for non-blocking lock the file system should return
 * FILE_LOCK_DEFERRED then try to get the lock and call the callback routine
 * with the result. If the request timed out the callback routine will return a
 * nonzero return code and the file system should release the lock. The file
 * system is also responsible to keep a corresponding posix lock when it
 * grants a lock so the VFS can find out which locks are locally held and do
 * the correct lock cleanup when required.
"

lockd used by nfs v2 and v3 was first kernel daemon processed locking requests.
For nfs v4 locking requests are handled by nfsd thread. Recently ksmbd was added
into kernel, it also handles locking requests.

They all are servers, and they can receive blocking lock requests from own clients.
They all cannot process such requests synchronously because it causes server deadlock.
In simplest form, if single threaded nfsd is blocked on processing such request,
whole nfs server cannot process any other commands.

To avoid this deadlock, kernel threads are forced to use F_SETLK with FL_SLEEP,
to ask callers to process such request asynchronously or if it is impossible to
do not block such requests.

Most part of file systems do not have own ->lock functions, in this case vfs_lock_file()
calls posix_lock_file(), which correctly handles such requests.

However some other file systems, i.e. ones defined own ->lock function,
incorrectly handles such requests and can block on its processing.
For example v9fs calls blocking locks_lock_file_wait() function.

It is not "pure theoretic" issue.
One of our customers tried to export fuse/glusters via nfsd and reported about
memory corruption in nfsd4_lock() function. We found few related bugs in nfsd,
however finally we noticed that fuse blocks on processing such requests. 
During investigation we have found that fuse just ignored F_SETLK command,
handled FL_SLEEP flag and submitted blocking FUSE_SETLKW command.
Similar troubles was found in some other file systems defines own ->lock() function.

To work around the problem nfsd maintainer decided to drop FL_SLEEP flag if
exported file system defines own ->lock() function.

Then I've found the problem affects recently added ksmbd and patched it by the same way.

To resolve this problem completely I've created https://bugzilla.kernel.org/show_bug.cgi?id=215383
where I'm trying to handle the problem in all affected file systems.
When this will be done kernel export threads can revert own work around with dropped FL_SLEEP flag.

Answering on you question: it's ok to ignore of FL_SLEEP flag for F_SETLK command,
It would be even better to use posix_lock_file() instead of locks_lock_file_wait(),
but I cannot do it without your assistance.

Thank you,
	Vasily Averin
