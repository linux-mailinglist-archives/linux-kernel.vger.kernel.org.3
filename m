Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA2047E796
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349722AbhLWSV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:21:29 -0500
Received: from mail-eopbgr140105.outbound.protection.outlook.com ([40.107.14.105]:22596
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233586AbhLWSV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:21:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFD42yt4oRvvUi2NyLqUuIIYWbba0BuqR98jY210kGufPgrGH0FGfYITgfIcBv0LNRKBFef1ZnTwhUzaOvDe5bz0Ct/lVMW1RA3Wv1hEyoBwp0zZ79Grc5+xCoooR7DDytkbFe6gOMgSFrl7DfyXyw0r5J77eGYVa6AwzcOl+VN7FnxEIws643WcvqSC5q4BXTTgMUDeSSZtcg43//o+nmFm0bcds2YQV2kUgs4x6X8EoGCDNlTV3aSWq+jFJq33ZA5JJPc/+6z+Vsgwd4A8GM6dsWJO3bBCdlRA0IiKMJNKoQjKg1GnBTLT2s4DOUUSiOd7y/EfSYO99aLbKxlATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4Um1KuMd0ErX2EjnCy/kL4babgQxRIphRSbzaqlaPI=;
 b=PjuO8Nfsj5dZAE5/+wsp9t2Mh2TZPYl8IEswDwQ8ircu/jIUxQ/ul6ZAONNd3oFAdaqQJO3L0lH3882aoAC9nNQPFKLyyj9GIYbhFUP7DpQO7xddSmnkkP5Hp2LDDNvuaKeqyLYz77YOl6rAYWyBKJgThh98KKEHGK8pjcAn5F3XU/3uA8Z80VguIIqVP/i8RDtZb7BKfZV65lGkHhjtRoElbGXHRoDw1TGa9RQ3UgWEHoK+ZFbHmnymfDS6MQuwp3inblMTOgyA5ZkULYz1wl92VMSyo7JhYEnIhJGmJlcWebf4K3XIZ00Tgppzid0y05CdbKLAxdoBODxE9vEZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4Um1KuMd0ErX2EjnCy/kL4babgQxRIphRSbzaqlaPI=;
 b=cXC4KW9bF7vMTuPCOrG4/cY+g9DprNzyQsFcOeBtdcLv2OMK0wiCSO1MsVMxA2Tu5SlsuPmV80QBFNFdmZOPi0IUiBOdsamEHdpymmi5eRFzhNogJeOhjQsKSw4HFcvvQF3DDYHMS+T58OFiH2F2obGgzCAofDoiWfzcStbs978=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB7PR08MB3659.eurprd08.prod.outlook.com (2603:10a6:10:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Thu, 23 Dec
 2021 18:21:24 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 18:21:24 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] v9fs: handle async processing of F_SETLK with FL_SLEEP flag
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     kernel@openvz.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Message-ID: <076a9ce6-ae06-5b3e-f577-d993e55089f1@virtuozzo.com>
Date:   Thu, 23 Dec 2021 21:21:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0295.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::12) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ea57eb0-fe16-4488-fb71-08d9c641071d
X-MS-TrafficTypeDiagnostic: DB7PR08MB3659:EE_
X-Microsoft-Antispam-PRVS: <DB7PR08MB36592EDECD2285960C3E2421AA7E9@DB7PR08MB3659.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQ490T7FREAEi3/6erDuK3BJe9bk1QniXWvp09IsfuNon+G74jDvW4XPGzlh61M7UDcciL+l25RltZ1GZKvylwoQzrrDmcRAtAvnI2YbhtkGnCzGJlYifaBnra1YZSFDYJiMhapPYiKQmYG2Y3DG2yGM/Wl/0XiLqOJMQe+SpDumGDLCodx/k8Q/TpNa1JLvfXvDe8c1vtUJIdky1tsgB0sRhpu5JxBhMDL/HMH6HsQfW40QStt8Erj3+DpeC6zkdzTmyyQhA7OVtIkSnwEzY5IqjT80JKsvP/CHcHzyTdCYrT+ya4C8mzTape79VetaYPRg6K/P/9wltBaPwAmlydQuwv0k06OfYlfFyqWnWqq3a5Jcmn6b+rbtOnAAaIGPJpu7U2nVl8IpiP8PCMpwA74g83t61u4kZKtWPxPboGi4pEWCiXmtkQ101AYGihEoA8rGY9NYd7RGfPPJMHqU3XfBYwQ3nD2lF0eGaUsA+5Gr3ZsRJKlTD+ET/hUWx4KnOQH/bhsHYmGoXwOVUlasC/ZJJ2XznzI6b2HR1Bb/zDuM+Iq5CaDdiksL7N3kg4UtpzlzcuaXYYAgGQCl45P9CWQHz6VzAbxYefqbbYfozVjvdJn5tp8ZLAp4bAEk4E6qC8QYm8ixkizwi7DjZWu9GAVHgaPhbQsZ/xKksoQ8YOgfZ6LIPxDtroOk4KI6zZzOsjJKhrI863qB67nDb3hayvMjAMbNzVYU8/+RVq0Qu8DcKRxIYC0oU1R9QmNyp0S+tL2ePRHrAtrYwUHfDq6UTWbuo7NDPLjx0fUPJ1F85SzhJxNq/utcbqx3ufveq50H2En1rtI+PL5Paz7hgHafo12li9eSJzi0oYouK4cKqpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(52116002)(6512007)(316002)(66556008)(4326008)(6486002)(31696002)(26005)(186003)(86362001)(5660300002)(66476007)(6506007)(8676002)(110136005)(66946007)(36756003)(508600001)(8936002)(38100700002)(2616005)(966005)(2906002)(83380400001)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUhYaWdCRlM2VGlaNG5FTXRZdWg5ckpkRTZPRHR4UUxBU0xLa0RNaFZvc3dm?=
 =?utf-8?B?czYxRTZoMHVNSmI1c3ZKcmNKaStpN1QrekovNEQ1ZUlONCticFRtWi8yQ21y?=
 =?utf-8?B?YUJmRHB2a0NiVGdSaDlNOWwyRFBYaDYxMGliVDhGWW1xMTRPMUFHWmF5U0tU?=
 =?utf-8?B?cE8yM0w4VnFNS3RGUkM4aTFsaEQwSk5BRHNtamRGalhqRFFubUtwQ0x3UnR6?=
 =?utf-8?B?NHJQekNGc0dlSDZKZnpyVmp1eVFIT2xobjFQSFE2R0tpZjBXVDFPVSsyWnhj?=
 =?utf-8?B?SjdLL296QURydW5YSTQyd1FyVEFFQlpNWWRrMCs1MHFhMjJ1NHM1eWIzSHdN?=
 =?utf-8?B?R1cydWNBSEw2Y1h1R25KbGs1ZzNMYm5kTjZ4Y05MeE1GWlkzTmdwUTYwOW9v?=
 =?utf-8?B?cnpUNVdpM0xlWHVrM1JZSTB2RHhGUWluczQ2U3M0ekg2NFpRdG5rTWo3cFVY?=
 =?utf-8?B?UnlsOHVCTjVHRCtNRDV4engvOTNKaFdZVysxTTRDZ0tyRzZHbzVxdmEvdGQ4?=
 =?utf-8?B?ZTgzYTJoSHJyVVlGeGpDZ3dWNDBNODVvdWU5blZNRFR3cktRSUdvYk90VWJw?=
 =?utf-8?B?REJoUThFa29mcWd0a2NabUloM0p6V2xyWGwzdk55SGtRUjQ5VE9OMXhBcUt5?=
 =?utf-8?B?a2VhQjNVVzErbzZBUTllMS8zN1Z5aGRZaDFHYkJEMHh2NzBQSHhVZG5LQTgy?=
 =?utf-8?B?UjM0RXF0a2RKNnkvYi9yU1d5MEs3NXBuR3NYc2s1cU9MVXZzK2xudk5ZRVJu?=
 =?utf-8?B?VXVNUTQzbG9UU1ZqNFVnRWJKWElGdXNLZStSU0Z4clI0cWtSbU5wWmo4MlBp?=
 =?utf-8?B?a2piMjg2RThYUkozblc1VVoyMGZucGV0emhXOWJONG1QWTlSeE40UCs1VWZO?=
 =?utf-8?B?bi8vQ2M1WXdGdjN5Q1BIY0FxOGpxV1FDUW9uWTJ0bUMwZGtiTndhMktWYzBh?=
 =?utf-8?B?UlJTQ216dDR4aUdNV3pOZXRISEh4WkZLcFBnU3lhb1lqZUUwYkoxOXdrT1lp?=
 =?utf-8?B?NWhkTWNETFBiS0hNUVZSSWRScDNvRTc0SCtCUEVDbWNNYjIrZ2NZS2JlalBw?=
 =?utf-8?B?NG8vWnFEZi8xMWdjMVJMTi9NdUdzN285Wi9PWXdVUWNoeW5BcXF1bnVHSklM?=
 =?utf-8?B?UzFzTkxiQ1BySkJGSXQ1YzVQTEtWcXltVUdVNDZTdFk4cDBrS3JQdW1YSHJo?=
 =?utf-8?B?K3ZpblF0VWJmUHA0Z2RWUHRseG9pdDl3ajZBU3JtZXJIbW53R01oVE8wRzBC?=
 =?utf-8?B?Yzk4QktwdHd4cDhuQTlFUjExbi9WajV1TkRGelFCdEhzUTNpL3gyZFlGczQ5?=
 =?utf-8?B?MmkzSVZmU1loVElnaGkvWWVOVHdTb040R2U2RlM1RVVyNnNvNWNrVlZ1M3A2?=
 =?utf-8?B?RnpobGNFRVZ1WXNCK0dtMjB0Smk3bnpoRHdzdFpvNDJ0WHdQTGVONWpUTUFB?=
 =?utf-8?B?SkJVL2ZIek9RK0I0cGhQNEovYzg5WUNsZTlGZitybytFc1JQSlhTSitpMTdC?=
 =?utf-8?B?NEp0VGJVblcrOWJqT3BuOFYyclN2VW1WWG9UaXFBQkdZMHh0Mm50NE5SOFFT?=
 =?utf-8?B?S1JlSWo3UTh4UElnWW9HZEc1aE1aY2tLUlJsM051Vk9nZU1FeUhERnkwT1lJ?=
 =?utf-8?B?NTBRZ2xka0VuV2lmNUZCNDN3aXlSMzdZWWo4ZTF0MVdFY21GQVBhVzBQWWZS?=
 =?utf-8?B?Z2l0TWFXT3ZMUHl0cDdlR1AvZm9yWGQyMUpTWmsyZXVsQ0NFamhZVzhJYXBF?=
 =?utf-8?B?a09IMjkwUDRsbmpjeFFLeG1wRWY2dVlmWTRPY0h2d3RMZW9EOG53a08zLzVU?=
 =?utf-8?B?d2tyQTBBMGhxWHpIR0V4bWNSZUd1aUNnaHhMWHRVVWdWYlRxR0FEYkswVGVO?=
 =?utf-8?B?QVZHc016eVoydTBZOUR6dDlrVVhxSjFrbUMrektWeGFGa1Q3VFVwZ1A1Vnl6?=
 =?utf-8?B?UWJ5ZzJsVWRmQk1lNzFKSHo0T0JyalJ3cU40NmhacHNhdjB0TzRtMDY4N25R?=
 =?utf-8?B?ZEJmTjF1bFhUMFNOT0NxamY5cFp5MkwyQmVSMDhRRmhoenlDTUJ3N291aGZZ?=
 =?utf-8?B?eS9ZV3VleVRiK1hnbWR6eUNjeno1cFpGcllxd29panRlRFdPcXBWQzZNYVIz?=
 =?utf-8?B?TGQ1WXNvNEZoTExWck5JdjdnbFpNTUJSTjd3NCtRTFJXYnNwWk5xdEFVaEIr?=
 =?utf-8?Q?7RncVIgii+lMf926R6QBB8c=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea57eb0-fe16-4488-fb71-08d9c641071d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 18:21:24.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDtPLIGXpjYrISSTAcAxTAtz90HUICBpzB4F/zfZzYWXgea5EcDauN7ylGP+QW6rXUO1DcQcmYqbFUR4VUUGvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3659
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel export thread (nfsd/lockd/ksmbd) uses F_SETLK cmd with the FL_SLEEP
flag set to request asynchronous processing of blocking locks.

Currently v9fs does not support such requests and calls blocking
locks_lock_file_wait() function.

To work around the problem let's detect such request, drop FL_SLEEP
before execution of potentially blocking functions.

Dropped FL_SLEEP flag should be restored back because some calling
function (nfsd4_lock) require it.

https://bugzilla.kernel.org/show_bug.cgi?id=215383
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/9p/vfs_file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 612e297f3763..81c98afdbb32 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -135,6 +135,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	int res = 0;
 	unsigned char fl_type;
 	struct v9fs_session_info *v9ses;
+	bool async = false;
 
 	fid = filp->private_data;
 	BUG_ON(fid == NULL);
@@ -142,6 +143,10 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	if ((fl->fl_flags & FL_POSIX) != FL_POSIX)
 		BUG();
 
+	async = (fl->fl_flags & FL_SLEEP) && IS_SETLK(cmd);
+	if (async)
+		fl->fl_flags &= ~FL_SLEEP;
+
 	res = locks_lock_file_wait(filp, fl);
 	if (res < 0)
 		goto out;
@@ -230,6 +235,8 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	if (flock.client_id != fid->clnt->name)
 		kfree(flock.client_id);
 out:
+	if (async)
+		fl->fl_flags |= FL_SLEEP;
 	return res;
 }
 
-- 
2.25.1

