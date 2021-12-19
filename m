Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83D847A00E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 10:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhLSJfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 04:35:01 -0500
Received: from mail-am6eur05on2108.outbound.protection.outlook.com ([40.107.22.108]:7712
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229585AbhLSJfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 04:35:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVZ9r37AYf3l2YE59x1Qbl9ZWfsDn0Cyw8hGLa1Js41f/rcwqaf/O0669667gwQJb36xpz6HI0k1D33zPCr4JdINdf98Fci28ioqfDwcMYbwN9sOC66U/GeVYf4I6uCGR4AIFmyNbgLKB9EkRSNsQDOgLg5NVNHP/4MSXTMCKkLvsC5+FBkUDqGQnJtRaK5LXio+i5Voj0ORZUL6dCUGxzaa/d1S4EyjzJvck2FHnP5OeTLdewQItP2/aQr+k4VrKH/L/jNNDdUAxy2vJ+dXmUP7AOk3ou66InsWRy7Wq1A69UcNpn6BvIG+Uyg9nGaQmk1hs0qYCGLSUtv6s39Qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqosS6LVyNHWnlOWDQWJd/jT4o74AN19ou/E9pCa7KE=;
 b=GV5McJrIuWcnpIqNgD0bMruHbM/hHYNmvTWRAqqChTw/iRfxZFVSIEGJBDzZ1UbZnSZald5sL5Rp1SiP0DA0Cz+VZI1AsCNxuIUfgK0mq2l4q4hIp/qTD0ZfojWSQzXH4vLjSJS5a/Ih8tX+eLlC7th8GwJ0XQkXY6VSWEjCsezm6hF5XnB3zPchzg0WzLH2Q+z98E3ec5bbujzOyWPjqdMNz3/PFeGRdHoiLKAMLfREwzejpNIyhy3qxFjlhLWF0hQ/niQfWGcZP3tLHaeFhpZI1Jvt3UV26fYNJbMr3zWLzTepRA980duQiyODKdu7m6/CB9K5sHCfCpPxLd/aBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqosS6LVyNHWnlOWDQWJd/jT4o74AN19ou/E9pCa7KE=;
 b=dAKycXxW56l00JIaYDz+F6CHM7qY4m5al/oa0671oS2JgrCBN3h9RwqeJpA9VfY9mny1ZPiWeE+BNoLBO6S9y32uVWVEDqaUSLgOnPNaze07Bke1nU9Ox+DkVRPReUjDU8i92beOYq4XC2GIXZ1ogAnfHhKFoEQhQ+ZV5FnoyF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB6PR0801MB2022.eurprd08.prod.outlook.com (2603:10a6:4:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Sun, 19 Dec
 2021 09:34:56 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4801.015; Sun, 19 Dec 2021
 09:34:56 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] ksmbd: use F_SETLK to force vfs_file_lock() to return
 asynchronously
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>
Cc:     kernel@openvz.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <e2aef4e7-a9b9-e44e-94a2-29ed6bc20091@virtuozzo.com>
Date:   Sun, 19 Dec 2021 12:34:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR10CA0028.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::41) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c33f0c42-c840-49a9-53f4-08d9c2d2d14b
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2022:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2022362B907E8E40236ABEBEAA7A9@DB6PR0801MB2022.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06o7OHdi3V38FhNLyHfyTaTICw11C90AU841EUrLH133Y1VuZPFMAvmdetRiWqCi7qAuYUXEKd8t7QcnnuFhK8eH+7CvUiSYssjXx2aVVvDgwDSStriL012pjXo5HLo7PKTDugrCF0icrkaHO5NScj2xZA0soaZpRyHuVV2WrVjFoGMgGjFQZWCMwP4bHId/4KtRAqFYMU8gcDGQxcoFm4WDlEpuvA8qlP+ocdhu88dsb4hbvPb1/cWngz4K8KihdZPBwxs+aciQTysNBR3cd+2QboJJLsc2BZQGcHj/s1GlocGM4VvZbMwuUFu/0vgUZz8Ao9TEtBBPv8goPIaovvMQsmpZjkxJzC52hfDtbOPhR7zZnCk+vHYPQonYxw/BiBmvOEAy+q3IoyEECVH3uSU6abHZ9hCNDWgIUvOVAi+hpMBQikkrYgqMjNXsTXpPNQkHWl7oIJkWZQecN3KTLQUpzLutuA4mnhk9olyielvmhu7T39dImMaNFoaiy34ZOAwfZ9xZ8TX1gYMfTrEA3QE7i/RqxiLyFF8PIHypNE3tc/irf091YMCsGWJaBtO02EDss5AyNNmtzkaHOkGsyCWrWVM2qliTTzELUHgk4SLIA3KZlzvZvyrQz4Rt60Oqijsg+b8hIlc4BcsVYEyShnV5Lf8cQJErknyVpoLNlZMCpReFAuiitlFncW4wBXBRkO/Jsd2Ic30hI3kqxFiIqrrsBMS6G1RULFXHQRXaLpcgFilqNfaIp3kc/iCtifkQLGZg4JBn93iR/dA43E/cQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6486002)(316002)(110136005)(5660300002)(38350700002)(38100700002)(4744005)(31696002)(31686004)(86362001)(36756003)(66946007)(66556008)(4326008)(66476007)(508600001)(6512007)(8936002)(83380400001)(186003)(52116002)(26005)(6506007)(8676002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXpmend1WlFhdGx5cDVjZlorR20xRUliVWdQcGhrUW5jYS9PK1Nva0RPSGdF?=
 =?utf-8?B?TE5PUEcyY3V4Rk9oSWlCRjM3TW5Jc2tXQXp0dG9zY1YyOVhNWDM3YlZRTmJM?=
 =?utf-8?B?REZBcmhoc0R1VmwvU0M1aUFvUXdidzhuMkxmaHRrZUl2amw5R05hZEQ1VklP?=
 =?utf-8?B?SzhNVUprNS9ZdkdpWmF6TElVV3ZCV25STGUva3FrclN4Sis2RmJyUTR3VlFV?=
 =?utf-8?B?TzJOdGJpS3BWc3MySzFlL0t5TmQxL1YyWWhBNWZPa1NBVDIwQTBCMDhSbytL?=
 =?utf-8?B?U0ZnWGRmeDcvbHBsNmpWYk03SllnQjQ4UUh0RCtrVW5HVlFIZmlINUlJQXhF?=
 =?utf-8?B?dXRLUVQ1b0gxTmZTeTA3cHp0WEhhZnNpTE4wcUZ3enpNUDB5Wk1lY0pWUkVU?=
 =?utf-8?B?Z0V6K3pWUmZCczZxQ1l3aldxWU9UTG1ETkRycjUzMTV4MnMrQi94ZFVDdFpG?=
 =?utf-8?B?RXNneWVsRFQ5R1grV2dPd09VSWVSSTBGWG9pcGk0Nm5MdG1ESnkvN1dJeDhY?=
 =?utf-8?B?aXdUa0gzQTlNK1JHWU9LbzVXeDBST3gzUmdqK2J4YTdpSDkwQko0S0hLVzR4?=
 =?utf-8?B?RTN4NmFxNGYweXczYW54cXJFQ09WVXFNOG1vcmR6MjF4SFZFdWtuMzNDMEd0?=
 =?utf-8?B?M0J6OURVOUVwd2VYNStDMWc3dlg1L1NmdXJPcFpHZkk3aEtrTWIwZlZHTGg2?=
 =?utf-8?B?THF5ZVozcjNNYjRRL2owMW1MdG1xVUNkZ2sydGNiS2xmVytjKzZlQUJPS2xV?=
 =?utf-8?B?WnR1TmhJR2lhWHlaQzZaTnBtWjZOaXZKNGFDTUJwTkNJaDgzSC9acGxSQmM1?=
 =?utf-8?B?YlpVOXFOQS9sS3d3TEwrUWVGRk8wcjdZeEo0MldXd3YrMHBIdW5iTytlNjAz?=
 =?utf-8?B?cWRwTXIwU0E5Nlg5ODMza2pmckdJaVhIZDA2WldyR010Q3ByUVUwVXkvTUk0?=
 =?utf-8?B?QTNYOVpJUTFOSXRKWnJRcGMvS3E3ZUVUYVBkalhJc3NhdWRUb1J2cFo3eGRk?=
 =?utf-8?B?NzB0MWptQWlHdDRUZlkrYTYzTkJCVmVBK1dWbS95SlhzWFVYeVZlUEZJUzJz?=
 =?utf-8?B?N3ZhdU5oTzNJTDdLVTUzeEVobHI3bFU1YXcxV0lFM1NETVdURUFLMVgwTURQ?=
 =?utf-8?B?cEpWcHNkWGhRbVZiaTdlRFVTbHFNQmZKVDN3dGhEMzh0NW9YZXZxb3JRN1V1?=
 =?utf-8?B?UTRtbi9aS1REK2hWbUlwSHpYbUJHMFY5Tmw1RzFnWmlsV0t3NVc3emM2YmI0?=
 =?utf-8?B?ZmdwRXhOQmwwVzdVSFozZzJybjFBaFF1dW5zdDZMaXBRQmwrajBEaWR3aVgx?=
 =?utf-8?B?S3hkVzlNSE5RSGJBcnJMMU00Njdycm1iQmZDY2dqWjBpK2hlcGxCUFJGQ2lJ?=
 =?utf-8?B?YWg5dVVubmtKNW41bEdvcDhyMHVkUEtGYkxseGtRdnYzNlFkZFhiVjVSSHJ5?=
 =?utf-8?B?ZmZWY25ZTjFDdDJRZXJjTk5wc1VJZ2x3RkkyaTFEcU8vTm1RMG5VUVV4RlJQ?=
 =?utf-8?B?bTJ2TnVES3ZUL2tkWVVnZGM0SEdqMEhlSkxCWVM2SXZPK0JzN3l6akR6NTUr?=
 =?utf-8?B?eXA1WUhoRE9mQ0d2WkZRdFdwYm1MZDdPc1JpL21NQklld3B2NEdJamxEdG11?=
 =?utf-8?B?MExWOWYwMGVqV1BrTVBGb1FhOWtVM0xLWGxxL3hXeWtBVklpOTQzTm4xR2Qw?=
 =?utf-8?B?YXZHcXIrWGJkRmhCNDJjUzFjTzhZTGNrUjBoRkNESFlqQlhFeCtVdlFzaWR4?=
 =?utf-8?B?a2JGVUllK3I2c2FkN0R3cnc2aHc5VjhCbmxVazlHbUpvd3c1WnhsWHpwbGxL?=
 =?utf-8?B?Z2ZlRmZMV09qQUtoMkxaVXZCTzBvcUJ0RWV4NXZibGZrSE5Md1hOTjJMNUha?=
 =?utf-8?B?VlE0dFNqRGVEV3dDb1NSbExrOW1XK3pDcGtsWEh5U1dJckw4blBPL2lleXdk?=
 =?utf-8?B?b0VaQ21qRXExWUdnV1U5RWhrYmRnRDJlcHNhVzhIRFgyR3NxQXR6amxPekdh?=
 =?utf-8?B?SVhadTRFNnJxVGlNTElCcXQ3Z01SQlU0UFQ5cmE3OGdTekRWQTRiRmJmd3Y2?=
 =?utf-8?B?TERoOE9FQWxNbUZqYStRMXBEd0t4Y1RIZzdQZDVvcHFlV2Z1dldmaXRtSVhs?=
 =?utf-8?B?c01MNEVsQVpNKzdhWE5oVmxSOHVld0ZLbzhUWWp3YWd2Z3ZtSzFXQWRLZ0RM?=
 =?utf-8?Q?EBBv/TWAk3WrNSiSxHLu3BA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33f0c42-c840-49a9-53f4-08d9c2d2d14b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 09:34:56.2549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RTnH1I7198+sSx0HF03UmnWbuf3BL3wCDZsFh7gpFE0S67h5P22EQxzlChmMBA8eBX1LUUP8m0HT3mKgrQ6HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid possible deadlock ksmbd should process locks asynchronously.
Callers expecting vfs_file_locks() to return asynchronously should only
use F_SETLK, not F_SETLKW.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ksmbd/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 0c020deb76bb..34f333549767 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6646,13 +6646,13 @@ static int smb2_set_flock_flags(struct file_lock *flock, int flags)
 	switch (flags) {
 	case SMB2_LOCKFLAG_SHARED:
 		ksmbd_debug(SMB, "received shared request\n");
-		cmd = F_SETLKW;
+		cmd = F_SETLK;
 		flock->fl_type = F_RDLCK;
 		flock->fl_flags |= FL_SLEEP;
 		break;
 	case SMB2_LOCKFLAG_EXCLUSIVE:
 		ksmbd_debug(SMB, "received exclusive request\n");
-		cmd = F_SETLKW;
+		cmd = F_SETLK;
 		flock->fl_type = F_WRLCK;
 		flock->fl_flags |= FL_SLEEP;
 		break;
-- 
2.25.1

