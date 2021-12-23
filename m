Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA7C47E759
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349662AbhLWSAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:00:35 -0500
Received: from mail-vi1eur05on2098.outbound.protection.outlook.com ([40.107.21.98]:7265
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349657AbhLWSAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:00:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIi/ddSUIJuFJj8d5hJc7RdP/DRfiokkQujAPM7yVxaO6kf6pOlDzV9LcZAkCgzMWbTAkA5/rlwcl8XVCnWGedk+VLVwz6qKU5Ge1bmG2bRnfHP+8xdbvXkNPgb8VvZI+ayZJMkzN5BB3QJW/q3k0+Azm5KvAXdNkClQiifWRFwk1dW1c2Lsv2MGH6kTteYuVAYD9FQa0Tup3TeJuxIWvczyjJrjRhxfxJ0Z8PTwfic8k5VQT8LmPzamC0O0bkhQVwXEP9qwOBDWipuL0rGw6z+oMurtIX/8K809tgTnpkw7govyXqlE4jHBok6u7Z+rkJkTXiKf9i5Tos9ND0NrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nDOju3WbJyXVzdVGZLZdo8dJOlw57gNAkDL5oyZrjY=;
 b=jkw/qnMEG9fVHX50X8LooCt9CRDw60muQkykE6iA5yzUEp4eaAfu1/DxpoRAyclz92isUTUkexibvzO/3zJ2wj+9U1wc6hIjYAqqbDO4mdyIb2pRmXXGCDSzBCwwKVnUkRixuyAtixmvc+mEB1S69E7S1ZrWJVGWj9fUnlGkPigjQ4gWJNJGzld7wrWGY54c5bdCP2N7x8SgYCeu2WTr7DNJz2+1XiCn2FCmU16bcZFww8K6HceQ2wopmy5262Y6A3Vucv1fEWTFgFOBjhO97Gmrfx8ZKtybwtUaupdBwhRaW73a+VUwFf1p0dgC5xGgcYcXQixRnW407GTIC0KA1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nDOju3WbJyXVzdVGZLZdo8dJOlw57gNAkDL5oyZrjY=;
 b=unMnnIi1eiWBF2gz5W1O3BF0wntmzMNrAmGApAXsMOssnH9H5pVyKLAav1E1OEnRF1pzLQHrdJimgToqcluRIlDLFWCfd1qBvn1gCOzgxF63fTwRRXKPObIPeaZKGKGxXAGuw8BbhAlsoizD/F4lZZ/bqqT4WNLig4OXslj/f5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB6PR0801MB1749.eurprd08.prod.outlook.com (2603:10a6:4:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Thu, 23 Dec
 2021 18:00:30 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 18:00:30 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] cifs: handle async processing of F_SETLK with FL_SLEEP flag
To:     Steve French <sfrench@samba.org>
Cc:     kernel@openvz.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Message-ID: <a71b8e8d-5393-25f2-1d63-991e903c262c@virtuozzo.com>
Date:   Thu, 23 Dec 2021 21:00:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM7PR03CA0022.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::32) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4162e596-febf-45fa-ab4b-08d9c63e1b47
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1749:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0801MB17494123F9B6B2D0E8ABBF5CAA7E9@DB6PR0801MB1749.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6y26b/fVJqaKrsvXINLYfCJ8TUWGEzhbp/FE7oMAYZWUbrckWCZx6p8yn80ajgdORkESNqNglSe56sLHFxnB5K1ZBLb/RmDOoL2PnHdGU+2mjFu/tXoS6gler9xy9SS303PYaMWlZXaBE7L+05678xlpZpbgLo4kWZiUqj6WMYsTqoZp85BQaMIw4foDfxpK0xcNfhN4zPYhVUgYoJctIjLFVEpvd0t/ur+rlcN+lbEzrrQSzQhDgpmflBFgqON9wU/5QX2/K6QLDZyrNmirICBdigdaeIGUH94//CJXb7m/2hbdlEmJfTXM0VqFqgM1SZHBY/QbRPbchcJ7tDsP1L+0qxkAgFoL4exTmDfwsiVPDnbc7Yfm47s/cJNaUjJqLCFmzD2OeryBFYzWe0SAcCgXRm5J21LHHkWCriKyy7ls166VyikhbAgKj6Ru1nEveDu1XoBW+MpCfMSlgmvyti/gBJ1ejCzOa8cqad+4GLCrJrzWbOIHMGEi9NDSrFdJjjN8rhhmM6z6dw+W+SJ5NbrTxccz2xL2C+qKFtJklik3Gb5blVapG7zs0HM0NsRs/vbn4KZkB/tKpcoZjmOHl9P66jBO111cqFeSFhgjtRLQMsrtAPzWvOerAh2KcEfSFDzmSSpzlWyY39SKO2MqD2AGT9/xYqIQZIjE6leNsavDZuFf9KZwQVJAOZlgPGW6VnBxZ9pK/1r64c89yS5QYTFYCh1xjD2bZi/3pZcItPHi8wPVf590U65vpCTWKRgTMoFRecFCA4ljm8EpR0Zf9zSeaFdS43B2tSpeJG1svevFVi6o5fk+DoXSum5mqYbodmexX0fVyzz3U3cWWCpkyrmPDTOWPkhx5qxEV1q1Log=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(52116002)(186003)(38100700002)(66556008)(2616005)(6486002)(66476007)(38350700002)(2906002)(6512007)(26005)(8936002)(83380400001)(86362001)(966005)(31696002)(66946007)(316002)(5660300002)(36756003)(508600001)(31686004)(8676002)(6916009)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDBJeVF1MWx3cFEwejNiTC9VeUZWWkd0Z0lVM2daQkJ4aktCaWQwaVJzMlNx?=
 =?utf-8?B?MVFIcHk2eWVxS0d0Sm1hNTBHQ3E0Snl6bUxtc2I3NktBSVZxdDlMMzRRai9P?=
 =?utf-8?B?Sk5aUWIrWGppbmVMd1BWMENUL0hFL1FvNWJvWXRyeFQ4QXhPaXk2eFRNZEJ5?=
 =?utf-8?B?NVp2TVltc2xtZ1JRN0h0dit3dDZpY0ZOZEdIUmtDVk1iQ2N5K0VSZlFzcG1Q?=
 =?utf-8?B?TjNHSmxwQ3hEeVVvTkM2NDZkRWc3UkRpVkpuanBNanRBMStKL2xZdDNVc0Nl?=
 =?utf-8?B?KzI1T3pBbzhBQ3pKaWVXWUovRVFPa3VxUk5mWUswV2Q4SDN6VElOWWkrNTFv?=
 =?utf-8?B?QVAzQ3UxRlNTZ2tjZC9BUlhSVjU3dzR5RFdhU1BrbG9JYjlYSzdmM2c3UFBr?=
 =?utf-8?B?Z0hIMW40SmsycTNPL3RFVVhXYnRxS3JNUlJGT3k0TVRiWi9GYTlwN2V1djgx?=
 =?utf-8?B?WFJ5WXpXTnF6dXJQdFdUcUJzeG0zN2FJVWZnSGg1UEZ3Znk4SEs4ZVRxTUFp?=
 =?utf-8?B?ejdTalBWUUEzbmtxYjV6VFVkclk5WFVFMGV4MjVlTklmUzhJeWJRQTNpQnJW?=
 =?utf-8?B?S1JVTFJ4WE1QODF1SEVyQXFNVnRDbzVnTEZtN2ZaVThOQzVsVnZQcDFlK1kv?=
 =?utf-8?B?dzBXaXNQODdvTG5HV2toQ2dDR3hFdnkvaGFTb2trdlBidFlMa3ZQSEVESkli?=
 =?utf-8?B?R3Nob2pLbUhlM0xwY1JEMUNremJnUG1WMmlCaVNlMFJBR3MvaEtIalN2dFZM?=
 =?utf-8?B?L1lRdVk2RG9ON3E2ZGowOGRhS0oyU0R4QnRRMnJqc0Vwa0xnMlVxc2FzNEVo?=
 =?utf-8?B?UTQ1THVtQVVxenV0dk5jdlVnTDUxODVIOFNNazU4SDlEajBLclRSUnFWOXVo?=
 =?utf-8?B?aGgrN2pJNzhIVWxzNXd4cDFHT1VJNjVRbW9ZaWNKRHdHK01tZWIzK016SXZK?=
 =?utf-8?B?d1lma09yQjlOSVR1UmRzMjJyQ2VES2NNNjI2NUd3dGFpRFFvQTV2UlRXM2JO?=
 =?utf-8?B?WTdUb0NRNmhkSUtnZnRuZllnc3pSaEpwTE1uZzN4U2Y3ZTNQKzVVMHg4d0pW?=
 =?utf-8?B?VG11ZFgyakdlWW1oYTZSOFlJbi9lNG1EYnhob2lUSFJZSVJJZXNWWlFuUllP?=
 =?utf-8?B?NjJOWklLWEVWNEdrejNLNHZlN2F3YS9Cd3FPaEJla3lhNXlVckVUbjk4eWRu?=
 =?utf-8?B?dmJQdHdieFVGZVZ0ZjhCaVVDN0IrSWQ4TWZBdW1OVk43d242UnozdytYR0J0?=
 =?utf-8?B?aWF0UzAveXh0bWc2SVJhTm9jQjBkU1Zab3d6TWxudHo0YkZNN2tLaFM4Vjhq?=
 =?utf-8?B?a3ZpZUJqNlllZWJYbEhRUk5kUDhxcVJYVjJWc0FPRHlMRGxzUGg5cUJjeXl4?=
 =?utf-8?B?eE1JUWJLdk53SDVLOE9jZ0xRTmhaNW8wNnhRaUJwRElabEJuem5KOHQrOXFH?=
 =?utf-8?B?Z1JZUHM1d05PdjJVTjd4SklnVXRRQVU5dExMdzVRRzZhcW90VXplc1cxdlla?=
 =?utf-8?B?a1Y4MDIvMUIwcE1jdUZreGlRNUhNWVFzY3BRZlJ3M01kbENpOXlkTFlCdTZE?=
 =?utf-8?B?cEN1N0s5d0ZWS0l5NTBoTlV2ZjlwVXlNOEJVdmt4aDdZaCtwWFU4SjVaSjh4?=
 =?utf-8?B?cEdodWNwcEZoTGY4NUpiSFRJUmpRTzZRQzBRbmdWZCt2bUxuY0ptUzB3NWt2?=
 =?utf-8?B?K1NJRGF4dzBDWUhMUi9OMFVDeVBHeHl1M2RUZ3Q3S0dIYnpJK2F3aUVuQkdp?=
 =?utf-8?B?V09BckFiQmo3WVZiaktUQzhrVW1mVGZsN1o4ZkRpSVgxcWdjVVhPbkNETkNy?=
 =?utf-8?B?RUEzYjUzenJZcFk1blY5Q01NdXA3SU9xbE8vNk80TndVR0F6eURmc00wazhm?=
 =?utf-8?B?TzlGSVMrYmZZMFFYSmxZTkxqSnRIYTQ5Qi9TYXpHbWJCWnhkb1g0Nkg3aDN3?=
 =?utf-8?B?WkZkTE84SUxvRFBndzhhSGFNaEJPL2N3a0JTYldhWGNnNlRJMWhvdWVzMzNp?=
 =?utf-8?B?MThuUnkvd0pCQStMejJOVzVKVXFqcmVIaDNHMUZ1UEpVT0hBL1hFWWRCdkty?=
 =?utf-8?B?MmtqS2Zmb2Nka1Z2UjNldzVTQ0szd3RTVWd6c1UvbXhjM3MwTFBEUncvb3By?=
 =?utf-8?B?K1F5SXdjU3k5RnVzWnMyL01sS1lRc2kwRzZib0tiNjFSL0xnd0RtN3plaUYv?=
 =?utf-8?Q?ZVIXQm7w1ocuFG/ZF5QCCvE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4162e596-febf-45fa-ab4b-08d9c63e1b47
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 18:00:29.9511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPgXvzh8kuaFHQvj3VlTqps/DHVUKZ5uHhZspaTalYq08lWoUuQwPni/QK3xXuJCXvEDDn55NUBlCfcfJliwGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1749
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel export thread (nfsd/lockd/ksmbd) uses F_SETLK cmd with the
FL_SLEEP flag set to request asynchronous processing of blocking locks.

Currently cifs does not support such requests, it ignores F_SETLK cmd
and handles the FL_SLEEP flag as an usual blocking lock request.

To work around the problem let's detect such request, drop FL_SLEEP and
wait_flag flags before cifs_setlk() execution.

Dropped FL_SLEEP flag should be restored back because some calling function
(nfsd4_lock) require it.

https://bugzilla.kernel.org/show_bug.cgi?id=215383
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/cifs/file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 9fee3af83a73..6835458ee845 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1847,6 +1847,7 @@ int cifs_lock(struct file *file, int cmd, struct file_lock *flock)
 	int lock = 0, unlock = 0;
 	bool wait_flag = false;
 	bool posix_lck = false;
+	bool async = false;
 	struct cifs_sb_info *cifs_sb;
 	struct cifs_tcon *tcon;
 	struct cifsFileInfo *cfile;
@@ -1890,8 +1891,17 @@ int cifs_lock(struct file *file, int cmd, struct file_lock *flock)
 		return -EOPNOTSUPP;
 	}
 
+	async = (flock->fl_flags & FL_SLEEP) && IS_SETLK(cmd);
+	if (async) {
+		flock->fl_flags &= ~FL_SLEEP;
+		wait_flag = false;
+	}
+
 	rc = cifs_setlk(file, flock, type, wait_flag, posix_lck, lock, unlock,
 			xid);
+	if (async)
+		flock->fl_flags |= FL_SLEEP;
+
 	free_xid(xid);
 	return rc;
 }
-- 
2.25.1

