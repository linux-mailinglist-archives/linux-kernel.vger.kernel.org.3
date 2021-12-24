Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB2247EE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 11:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352445AbhLXKVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 05:21:20 -0500
Received: from mail-eopbgr70090.outbound.protection.outlook.com ([40.107.7.90]:40542
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352418AbhLXKVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 05:21:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6zoXGTTV685MJaNYqJ8Cwb/n0DFDSmwYThbzg9kD9oYzZkTTfE/iWsiMTektCyZB1ZduCDoT32SQR6Z91ct8vu6MaASK778aLkMIgVEuISWiXjirsilyW0DQU7w9fVBrmvvNCZWqnhLzYr9ezmsvUyHuVxlM6R028BhxuJmOFUPk6XLkd5yop83CocpyTd5lwV/ti5xd/QTWmZKQPNfws9JoirZR67hB1qbW4te/RM6yg9u52KqWoFHG3LqxlGO8NPSdZ2Nar8lXCEpo8ffwqFN8O00y8e9p36xq7le7RNx6T14OTaoaLMdv/NbS7+Lgco6ntU55Ftse06Xe1E48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEhMNt7bBEahGrqgsyrLWnIZ/Brmcde0V9CQy0PetbI=;
 b=f6o58l2CcMHL7Eype0nou4vWhH6DgfoUTFabXQF8b3D0vpEUc0Or3X0rlazE1iwhvxxAuiUmRf8CyE3IbJ5qmrXfeiwwH3c8f/72D6Lrc50wzBmlRvH2ohh+euBH7FsD54yGolRZuXFiUyEtb0aQdzWuRilhMVrwbNunPp4qfOQ65EMigILtSokCfusq0V3sKZEjCFup7FfijAWpDhdB9UBGc05ECgDX/WJ8XsBQTL4sLr3Ovq4ZVRUj2JxK9zh6SwTxJfyXj7Na31Y5/X7al1AW9ri0k+pY9Jhca54uzuZktxtoktVfpTL5MVOM4UR9QKUZbycIQazs4Q+Z4GMk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEhMNt7bBEahGrqgsyrLWnIZ/Brmcde0V9CQy0PetbI=;
 b=D3qV2IbPML9d//rcvpIcPS+/dsJxQOmibDvuyOAcALA84OyCwtUGk+vukYE6RyyLf/MR7utxHWA/9jMtUfqPJ9h4J+MtUOW31feey9V0WOuPrcjhzPokXLde6eB0InjxGOt93xihWxEKDqFooDNhifN9qdfW75IY9PBoEqZ2pag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM8PR08MB6434.eurprd08.prod.outlook.com (2603:10a6:20b:369::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Fri, 24 Dec
 2021 10:21:16 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 10:21:16 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] v9fs: handle async processing of F_SETLK with FL_SLEEP
 flag
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     kernel@openvz.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <05ab1af5-9b5f-f505-2a68-c90f50a1fb46@virtuozzo.com>
Message-ID: <d0e10f8b-565c-3772-75df-5cc2d729ff8a@virtuozzo.com>
Date:   Fri, 24 Dec 2021 13:21:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <05ab1af5-9b5f-f505-2a68-c90f50a1fb46@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM7PR02CA0008.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::18) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06814999-774e-46c0-c9ef-08d9c6c71ebf
X-MS-TrafficTypeDiagnostic: AM8PR08MB6434:EE_
X-Microsoft-Antispam-PRVS: <AM8PR08MB6434200238C7E6F509DB4C02AA7F9@AM8PR08MB6434.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlIR3ncpoWNH7r4bZ5+t+7kcxQtkppxJqNXi66b69TCPoYGlke5BVjHcKE8K4C98vZnKH+3rXpfaqRPPcbEsfQGjnOCqcQM/Pj6lgMk0JyMoJGOOzvlcu+pxPsGhPIfSCGiBcnW8dEED4xZ6ugLFmJLidj3RGQ37Sgrh74wFsaRCBtH0AetD9I0LWsvQXiXzdm7BbhofNpOA+avOsRlqYek2DnIQzlByPT+/0fewK2D0ig8ZKW0ZdvH6/GF6EBdPRWTvm2khp72kCrvPgXLOOrtIxvmGREnz79497Ij++C2ld+W4TtJrswcTcRJDu9o5kwojeSirAGVYk8mmD+ELn9nAwTVpCtS8fpfC2SMbiPD8xv3EC9NeWb9BGqDWFBshsBpr3xhvKZcXonrv4IVZ+HO8gO1MNxZJlKq2T2B9OZ6MY/BDJsbG7ELWaFu2O9ixmePS5YSvpXTMb29/N9kYiT675cM256lEw7Odh5ItUJWgxWLdhtTI6OXKw9EeWlnqrlaujhVVusdTmDskCePsDjfzTdzjJkhh9/MJBvnEJE2SlVwfmN9zrY/4jTFA/6ew62HDySrrv2LmfITRg6yX/tX5sAO0p2jNrWD7yTzSbFpv9GaShNly0Z0Qa0V+2ufpnlqtnrOmLoaTH8DfHWz5/+vZgEHuMrAy7XyeP7OHbTTLor20WcmPb0pHJlYAfsWTdF4XVb3hEMbwgDqU1tgNrYA++M3GmNk4VveloikyGgC+T1/YM/L9UQo16p1+iT7MwvlxBVwAyiBzF/qavwGIA0FJ5mA8ulqbzRY6Kj9ikrh1AW3w5GsiFcfDvRImVfduQOLf4NvLqp3Dw31ftboxqX/uHhrgif3NBDDxln5+xDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6486002)(2616005)(6512007)(38350700002)(66476007)(5660300002)(38100700002)(66946007)(2906002)(31686004)(86362001)(31696002)(6506007)(52116002)(83380400001)(8676002)(186003)(26005)(66556008)(316002)(110136005)(8936002)(508600001)(36756003)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFQ0eU9uMitLeXU0aFc1WWF2d0FlcmQzTDBseWFuWC9qdEd5WTl2R0pvZEdZ?=
 =?utf-8?B?Nmh6NzFwWXArejU1Y3pnZjNxbC90SkpZOWNTNThIc3FKRmxsUDY3emFGU1J4?=
 =?utf-8?B?ZjZERHh6ZzFUNSszaU5aQjQxQldEVzFlSzA3MTRnS1VRS0tJRW1hRWVmMHJz?=
 =?utf-8?B?Q2s0MExDdDBrcUR1Q2lmL0x4TEdkVHFxOUVZWVRPT1BWWm82THByRG5jRWlh?=
 =?utf-8?B?MEVUekc1MjZsTXZuejdtT1UxQW5TRmRXRXVZM3dpdGw1NE9ha0RWdllrbEpF?=
 =?utf-8?B?bDZZNUp1cXdDb2dZdE5JRk1DMTE5VlpLVWFQV3dIcDBLbkt6NDVaYTJGQ1cw?=
 =?utf-8?B?L2RLQTRSZzRXcUxTYTU2eERZRmVUUzVQMm5rZUo2eXRBak55K284eGk1UHY0?=
 =?utf-8?B?c3luY3lSZFFOdUplVFpKRTJtNVc4ZjNzTWwvN1lpK0FCR0M0V29uT01nT2VH?=
 =?utf-8?B?cHBTUFJkejl5My9DOUpwR0l2Z2FUTjk1S2hKVi83SGd5RWVLQVJ3N3p5dnFz?=
 =?utf-8?B?K0dFYWo4dkN4dFU3Z3BOUHhZQS9OdU1XZHNnYkYvdmtWUzdXdFhaaEhnWWdQ?=
 =?utf-8?B?MHZtK2FoZ1pZN2hUTHlITWczbnJ3clZhMXczM2o0ZUh1UGVOTmVwMVlKT01w?=
 =?utf-8?B?L09zMWVtR1V0cHBlRU9qUjQzUHlqNGZvUjRhNjJJa2V3a0FQNG5SREcwWE00?=
 =?utf-8?B?M3NRSzI1QTNLbVU1ZnpZenZDNk1rU3JqWHllVkZKVmxvRlJNR2RjU1lHTEFQ?=
 =?utf-8?B?a1hibjg4c1YrbEs5TDVEQm5iM0dWWUcxYm5LZzdjN2FmQjZkWng2dVJJWk9S?=
 =?utf-8?B?Y3JFc2ZnanU5c2p3RFJJY095dUxhQ2ovUmV0b2xTSFJORVNWbC94azZaWEhW?=
 =?utf-8?B?eVhsVmM2ZHJkU05yd1NSVVpMNmFTMFNjY3RWYVF0UzJFZHlKb2k0dmlaSkla?=
 =?utf-8?B?cGJLbThxa2k2RVBZaWc2U0FzOFo1c3ZGMFU5c3N6SFI1eVFYWlRGOCtxeFA3?=
 =?utf-8?B?ZzJhT3hrZ25ydXZPUk9TcTVSYlRHeCtkd2pmeHB4cTFDRS9xUnN1UnVzWU5x?=
 =?utf-8?B?c1lOWHk0NGJXUGdIbVVpUlhKWnEyMXFHN1lFSWxoeTRENkZER1NzeEc0VVls?=
 =?utf-8?B?YzAzUTQ5MWF2ejYwM3AwSjMzdVRrNVdYQTJLQ3BXa1FXVTU1T1RTT0Fhd2hB?=
 =?utf-8?B?R1d5NkRlVjltSm1RL3pxV3dQc3UzSmcyL2taWTdOVjRwVzFFQlNHdXlqNStr?=
 =?utf-8?B?bWtadWsrNzFuUzZqdC9rRDhnSFY0V1YreC95V0VHWk9pNVF5bm8vY2hibUp5?=
 =?utf-8?B?UGp6amNndGcvVEVKdkIrRzU0cGdkb2pSWHZHSHhzVXpqakdhUFdPUS9qL1h3?=
 =?utf-8?B?a2c3bGtlSjhKaXdHK09LeFdZeUc4TXZCU1pvaGkvT2lvOG1kTytaRWNDYlpw?=
 =?utf-8?B?ZXZrYlI5UUROWi91TjJDMWNUeGh0SVVFRnJwSWpjQlB2VHhpeGEvWGFLYSsz?=
 =?utf-8?B?NlRpdVV2aDF2Tk5leitPbXBic0paSnI5dHljZU5YbHVUVjFPdXNrUXRTQkJy?=
 =?utf-8?B?SmR3SlZIN3YwOHRrTTNrNnd1b21VcjVVTGkyVG91M0VPUnF4SjJGMFRSUEpt?=
 =?utf-8?B?VHVhY29mNGhvMlVTa3BsSlNNU0c2QVZ5dG1kMDBVZ2pKcm12dW5NcXRTNlRT?=
 =?utf-8?B?QlhQRmsvYzdQRWZJSXM2bWY5d1Q1UVptRllVWDBldmxyUFg1MTFtNEFZMmh0?=
 =?utf-8?B?RzZiM3p0Y1lRQy9qcUZGd3RLL0tHK2pVMk91Um1CaGEvdmxzVDJmMit6UjdG?=
 =?utf-8?B?QnphUHVKRytYaGRMakt6UEQ5cUhqVWk5UjJJS1lEZzlhL3RTRjJYaVFFVllZ?=
 =?utf-8?B?ZlY3NzY5VG1XSUtucGsrNGw1L0JxTWs3dXFmRHJOYVFJOTAzNStXd0QxQ1NY?=
 =?utf-8?B?RG9NeEpkMWJnYndCd1hIbWwyb2FzcXZkMWEwSHRzNGpMSkdJdkpOL0MwME9O?=
 =?utf-8?B?WjlYSzExcWFKcVhvVlZXWTU1cmdEZ05ZQVF2OGIzald2cDlOTG1PZWNuL0Zu?=
 =?utf-8?B?dEIvRk1Nb1lkRHU1TExpYWl3NDRvay9KVk5PNnNuV3I5OWlQUDZvRVlQamhU?=
 =?utf-8?B?MWI0QTg2ZW9CaXFzaVloWXh4M0YrcmRubE4ySm1xY21ZSVoxN2JrL2hRMGZh?=
 =?utf-8?Q?PLfoFKMzv7DTEg45eyHfBTo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06814999-774e-46c0-c9ef-08d9c6c71ebf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 10:21:16.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygyhrUYni2ee4X+mBjZvdyp6feBS03Drksu7dKBbn4DczjG4HkIuyhfdXjrUSTUkIhRNaNCkEP4vdUn5gaIeVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6434
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel export thread (nfsd/lockd/ksmbd) uses F_SETLK cmd with the FL_SLEEP
flag set to request asynchronous processing of blocking locks.

Currently v9fs does not support such requests and calls blocking
locks_lock_file_wait() function.

To work around the problem let's detect such request and call
non-blocking posix_file_lock() instead of locks_lock_file_wait().

https://bugzilla.kernel.org/show_bug.cgi?id=215383
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/9p/vfs_file.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 612e297f3763..27ede4a4a6f4 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -142,10 +142,15 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	if ((fl->fl_flags & FL_POSIX) != FL_POSIX)
 		BUG();
 
-	res = locks_lock_file_wait(filp, fl);
-	if (res < 0)
-		goto out;
-
+	if ((fl->fl_flags & FL_SLEEP) && IS_SETLK(cmd)) {
+		res = posix_lock_file(filp, fl, NULL);
+		if (res)
+			goto out;
+	} else {
+		res = locks_lock_file_wait(filp, fl);
+		if (res < 0)
+			goto out;
+	}
 	/* convert posix lock to p9 tlock args */
 	memset(&flock, 0, sizeof(flock));
 	/* map the lock type */
-- 
2.25.1

