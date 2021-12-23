Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE87647E3B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348429AbhLWMvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:51:37 -0500
Received: from mail-vi1eur05on2103.outbound.protection.outlook.com ([40.107.21.103]:51344
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348321AbhLWMvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:51:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUwRe3El3pTynJxIfycfNDhdWpS3LVuNHbzKrr6S8X62zUPCwGLbaQY1UJZ2s1CbC8+PkfOgT9md+xssuT/SJXWNuhE2r+Ac7I/J5cNJDsl2BxBRa39zSrhnoIZaGrYCWVPpwQkF/n8Hm41L++1t8phLN/C2/Pqi/9coeXM8TF4B22iDgpsWkZSwTyobGsW5uVYjYzAGQpl03K2sSvi5mLrUxuId33kimM6IP9NGKIYb7mZaO43rxBZiDf9+tpTJDE3xKwiGpfZGxu3PLlh+gbnQQgaAKTdx7BsHuAPWPhGmv42n+DqRhrCR2lex1c9wJZw/Sk87KUqe1nRk5t2+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0wG0sPDPjvhwkbLoRYCvvBXsg9aF8WyJ3dg9we/Br4=;
 b=D7sm2z2txe3OOfMRoiz4t3um7kKrsBmt0K4/RlLFhiWEhudAaVPH1VEJW5XEW/eEeu6keWJiOTBE7DRvvTNU/TesHlL8P7G9AoKJbwYZu46HULM0pDzwlRMgWVsHa8X7p4157BL0M7v++vm8XxxXpFv55BjdyA9pVu0/0KJocwV0fT/m60En82Vi+Z+xXAEezmwZUjuo2sHYyUujr1L9YA6V548eYXMV/BIksRZEM5bmAzaMRmzmTxFCVs8fVvHf1UhOQbEYPwfPGKQ69tvvMpYQz47f095aT62YBwvUsnlyFLae+j1gEQ83tLf+hb2M+tGAhxWo79/8wcUM7/5A5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0wG0sPDPjvhwkbLoRYCvvBXsg9aF8WyJ3dg9we/Br4=;
 b=egT5t5TF4aRJJW7DN92F+jwFO6GNrka+qxgc8ON7PCt+xwP+VdFjBhAnjhL1AGbxkEmpq3NeKXyNNeTlKCdFwULMG/NcXsulnfDtaTRCg73/RcAq2LQDIgrhW9LDxzplMuUgjxxbZQ/m1F1Yfi7mW0q+LrEOyq91hVAdX//j8cA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DBAPR08MB5669.eurprd08.prod.outlook.com (2603:10a6:10:1ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Thu, 23 Dec
 2021 12:51:33 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 12:51:33 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] afs: handle async processing of F_SETLK with FL_SLEEP flag
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>
Cc:     kernel@openvz.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-ID: <d4f73d2c-59e9-8497-dcd4-57abb6f2f089@virtuozzo.com>
Date:   Thu, 23 Dec 2021 15:51:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0301CA0017.eurprd03.prod.outlook.com
 (2603:10a6:206:14::30) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2430b4dc-4303-4ef2-7b91-08d9c612f272
X-MS-TrafficTypeDiagnostic: DBAPR08MB5669:EE_
X-Microsoft-Antispam-PRVS: <DBAPR08MB5669EBFF0D69827F9EFF86E3AA7E9@DBAPR08MB5669.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMPqDi5S6qRmShPhBNryl2VvcPJeYOIH9guKeesG9ZypnILLCfo7igB8UVKFPZrQHxllKvk/WwTjq6uptU9JZnUztWX/L+jEsqxGZzyKIo2hKemkcgdUvpIkeNjvWzYJbRPcGPnQxStFUxCbZn5PTIpdd1mQBNQhB0wpk/SudH+IbAUKuPM2C4umWYp4jm8LUBmHp82L9/F3dwc/ROowu/BbInB/JOWiXZ505BPO3QQ7xPNPg62w8WEGubO8sLV2cmnc/TdS6DV8M3GLSbWU1Qlf8BaNU8oX+hh24BUR+dXA/6t6zW634RmTG/enIyKsmeXowDBMbD/fRoYsCyuOiZgqG90oGYUbllaXfSbveYPz4j0ZWn8dDYuEIHGFq4a2gBYUz7f7UrRuT9P0+CRHc8n/2T5HVwD+cMCX7RGewWpPYmOhCsRYaXt0w/DmwUpE+HGmPWHMnkKXow90PdohMeywPozXYGrU1NmZxas+ZwY8/A8BBR/dIerfg/FjDDNeJGnmWIw3WkY7AwZMxTpkflv1HC2dmhf83iIvi02LjcjCSqr6yhvBv/fES7rXuFXtLPzC+P3qkEDeuTScZCm5yscQKpTpbYxsUgzlQW7/eYXms1UGfAE1qU+QiHUubwiNoGpneMl0QYkqSICzG2tHcYQIAPKJk1vKZljuwDzVWSmw+PRODNA+5qesPED8czPIBsNLJJvq8XD+H7GO3XirDJvn6OSa6Df7Eu5I+EvAxZSggEMP/eKHf4UYEK0kdJuAi9N7k6bzCEZvbhCJ8viULWhPaeFthrKspGEpCFwX6n8Tqzkqw+r7auvzdlrRJ/jBl7Yk19BxEobMiEMgKCjm9PJxOIDYo0IRJHOFqbqBeIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(8676002)(8936002)(86362001)(38350700002)(38100700002)(316002)(5660300002)(6486002)(2616005)(508600001)(110136005)(6512007)(966005)(66556008)(66946007)(2906002)(66476007)(186003)(4326008)(31686004)(36756003)(52116002)(26005)(6506007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjNMYk52RkVGakh5b3RiMHFnQmMyM3paWlI5S05CUmhsaCt0NWNGWWZWSUdO?=
 =?utf-8?B?YW5xaVZWcis5MDNTTVJWR2RLRGQ3bFNCWUFteWpYUnJTSlY4TDFmNllQTUJp?=
 =?utf-8?B?YmNuUmg1eWp2SVNEaEZRRVFGbVEyQTVpVUpETlZ1VlVFaGlwdFRiZllGQWYw?=
 =?utf-8?B?S29DeVVJcmVNT1E0UURoQkdrRjBqL2pQNG9MQmRQM0F3L1p1aWloL0Qxak1v?=
 =?utf-8?B?TnlqMnRDcHBCMUczNytMcW1sb1o4dXlCcWtHNW5vSlZqYUJjN2V6RTlRbGZw?=
 =?utf-8?B?bjJJWmJYdGVka25hZTJRVG9oRUR0Sk82d0c3b1RwMnpVRUhQOTdjRHhZdUg2?=
 =?utf-8?B?ZWVSV0dLc1p4ZGY3SHh3bEhOa0RoWmNDbktLcFNDR0tqNDBsUGovRjhkd2Zx?=
 =?utf-8?B?QWIxNjFvZTRFNkdPOVZITGNaSy9WeU9Xd0o0WXk1cHBpallhU3ZBRXZZQTl1?=
 =?utf-8?B?bkRBL0wrOWQyMS9jTWo1VXJLalM0RFFGd1BFUXlRbUJKZGY2VTRLYWRhd0VN?=
 =?utf-8?B?OXRKVVA1YUJIU3Z2U1pJOW8zWDVna1FpdG1JMmxKcVczSXltemQrVXNqRUhQ?=
 =?utf-8?B?QXhFOUNhUWgrMzROSHFEdnFNV2d0aHIxVjc5S1k0MTM1MkNSOTBmbU5zZDgw?=
 =?utf-8?B?bmcrcmVzZGhDSUJoMUdZcXh0ZmtrOTMrdGNaaFpyaTlETmxQSXNoZVFMb3Vy?=
 =?utf-8?B?SEozT2RVK2U4aWgwVEZHSnFPLzAzY1VmVFpCdTJaOFVVd21VUm8rakdqQVpD?=
 =?utf-8?B?aDYzTDE5dFEvUzArblFUYXlDeHMvYnpscE5Sd2dNTnRkQWxUaU5vbkFkd1RS?=
 =?utf-8?B?R214T2ZRUFVpMDJ5R0dFT09sYTdzc0F4bHg4aW9WK05LdWNNbHIyeVJ1Wi9C?=
 =?utf-8?B?Z2dHQU5OdHo2R2dzKzdYVk56STV4b1lpaDNRL1hTRk5DSHczaTFlR3Z5N25k?=
 =?utf-8?B?UlJOT2xQdkNjRUFDeENlSGpTQVpOeWQ3Zm5QdUNQN3ZLSVBWaERvbW5ya1d5?=
 =?utf-8?B?di81d3plb1VlNEFFUG5DcWdRSU80TlBkQmI4Rzk4ZjNVZmpXdUZtRlNiSkJ2?=
 =?utf-8?B?b3BmU2ZJOFF1NWZ6TThaQ3Q4Z2V4K0JQMlFmSFlvUjFIb0hZa3B0a2REcFdM?=
 =?utf-8?B?ZTRCS1puQkEwRUlHc1RvZitlSllubm5iOXFlZ3lGMnNtdGdUdUV2aXdvYkVn?=
 =?utf-8?B?VGYyc0Z2Z2hJSUN2NzFEZHRLSXVTMGt5MEZNWmZCRVRIM2lIMWlwNHRRd0pT?=
 =?utf-8?B?V2x4eUllUnJuL25NaHl1cGRqMS95cGJ6NTlkK296cmd5QjNCa3pzOHpTL0hH?=
 =?utf-8?B?SDlQRFFFMUlPR3VTVmJIbjBscGN2THJqa1IyejdTNnQ1T3Jzd3hFTXl5NzhD?=
 =?utf-8?B?MEtZejl4V1RHZEhNNTZESCtVM2dlQmFFSkRTQlBlNW1LTnNZSEk2V3VwRXZ4?=
 =?utf-8?B?eG9qVXA3bHBSbnFoYVpJUWNFaFZ6T3V2Y0JvdTNnVzBlZXBBWmkzVGhnaXpj?=
 =?utf-8?B?Y3VCZm1XQUpQbDJsaE9HZG1WeXhVZEczNnFFZ3hUSGZkUGdqRUxadTg2cWVZ?=
 =?utf-8?B?M0U0WlphQnoyRkZHUkE2TnBOY3g0amd5Vm0zOCtxdkY2b0lhSnRQaU1TZmpa?=
 =?utf-8?B?dVptdlc5RGd1Rm1vQ2Qva3dhNUt0eEhtb2g5cFMyUXFPVThDVWxaKzFoU0dm?=
 =?utf-8?B?eUw1NU5jSGhkdnFHKy9EemRNU01saXJXVCtCcENoK1lBY2tPaUhESkl4QjAr?=
 =?utf-8?B?NjYzTGFXWTZOL2x2RldCKzh6dElOWmdxSklST3NQSm4ydlVGdWw5MG1KM0d0?=
 =?utf-8?B?bE1FVUh1Mm1Fc0p5YllaTmM0OFlqd1R3V0h2a2ZWTlhyUjRZUG5WclBYSXBQ?=
 =?utf-8?B?eDNCenJHcFprRmRyelVwVC9XeWlrcUtoeER6VVRPWWVTSG1WaGxiZFZFeTJy?=
 =?utf-8?B?NnBmdnBrTXN2Z2lqNXpUWnpzTEw4eVJ1b1FTbnY1RUNEVXFWaUFuazZCcEo3?=
 =?utf-8?B?bTUwR2Q2RmlOdjN3NUd6dytPNE9MeEZLaGxYRml2R2U1eHNkWUFOMGhpN2s5?=
 =?utf-8?B?WlExaEtURnJJN3VqZUdnc1FORTlsTGQ3emFkeFg0cW1NM055VFFmZE94S3RP?=
 =?utf-8?B?TGFMS21vaEZkb2o0aGF0dThzZHBPOGRaeVBzR2plVlFudEc2UUxwS2w4TUd3?=
 =?utf-8?Q?wQFUHU5P3d1bwGENTtiG74U=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2430b4dc-4303-4ef2-7b91-08d9c612f272
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 12:51:33.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bj9bx6zUuQmLAx68ZNr8binJbRgXuyG0sEHAL7olfTVE9noSK/byhqxVGZG/xPkfacjphkSJiITpUSatkKHmqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5669
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel export thread (nfsd/lockd/ksmbd) use F_SETLK cmd with set
FL_SLEEP flag to request asynchronous processing of blocking locks.

afs does not support it, does not check F_SETLK cmd and handles
FL_SLEEP flag like usual blocking lock request.

To work around the problem let's detect this situation and
drop FL_SLEEP flag before afs_do_setlk() execution.
Dropped flag should be restored back because some calling function
(nfsd4_lock) require it.

https://bugzilla.kernel.org/show_bug.cgi?id=215383
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/afs/flock.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index c4210a3964d8..297c859d1f54 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -778,11 +778,19 @@ int afs_lock(struct file *file, int cmd, struct file_lock *fl)
 	fl->fl_u.afs.debug_id = atomic_inc_return(&afs_file_lock_debug_id);
 	trace_afs_flock_op(vnode, fl, afs_flock_op_lock);
 
-	if (fl->fl_type == F_UNLCK)
+	if (fl->fl_type == F_UNLCK) {
 		ret = afs_do_unlk(file, fl);
-	else
+	} else {
+		bool async = (fl->fl_flags & FL_SLEEP) && IS_SETLK(cmd);
+
+		if (async)
+			fl->fl_flags &= ~FL_SLEEP;
+
 		ret = afs_do_setlk(file, fl);
 
+		if (async)
+			fl->fl_flags |= FL_SLEEP;
+	}
 	switch (ret) {
 	case 0:		op = afs_flock_op_return_ok; break;
 	case -EAGAIN:	op = afs_flock_op_return_eagain; break;
-- 
2.25.1

