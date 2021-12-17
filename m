Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DA94789C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhLQLYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:24:08 -0500
Received: from mail-eopbgr80130.outbound.protection.outlook.com ([40.107.8.130]:9600
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229797AbhLQLYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:24:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4FKMGQWBm8/rue07yydW5LTwPh9oTZ8F4EL4WnyppgsDJG2Ct2SjNvUH9kQmPcXDJz4Ja2z7U4EtZXgM3g8ISliMSxEjv88iMev7lICsfIOQJ0Q3//Gbze6+zq2la9M7l8QaUqRXj5QCusb+84PfDT4uWcrhEyZmT4nCqB74L6NsSo8zg/yeQSz7u+WBeFQdVpfY3oBE4LvSqxywigaSpIWHmfv+msf/qtDNN7JQtlKcWU/uT6azwdlQDF2k+Zcv6+XYob0nHutC/PsMPXFMb1bMWUuIT4vXEkNFwE2hD/Rfn7JiB3Qod6TIg5qrdlWd0K/+CtENjSOAbH4Z22FZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04P3EfDuS71L+U52TLsuKVOnNW9WyOOVIv8Rua/8fDQ=;
 b=WMaa5Pc/r0IpNCbnjYfSlLsR2J8T0gaO/fhq/tfw3G8TrsBiTLgzwjkbX+Q9Hy5AXhToKKClUcU/iRx35x/6S0yuTSN1mwQDukx/s73KIevnYmnFypV4l3Hl8iYzzyDD11LtiYLfvyVQwwCx86fgESlsv89qzZlfGoG7fRbS0qh6j9GaSxoui/lC/bleXsnk8jfKndbRJgl9nY2/YVDVTc2+pQIbtyu/9pRhkU2I357COx9ReBXFpEQGP0+88aszCqceEj15QEIOrs8aoc4zzoiTdOAw9rFx6y13liJ8d+548F1/tLrutHmXtzFDXFbBTzrQb94/1txBUcXbqVFHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04P3EfDuS71L+U52TLsuKVOnNW9WyOOVIv8Rua/8fDQ=;
 b=CPPRvvS25bc2HAb9A2lJauZqcEUHGFpA2jHx3t4cwlg1gPI5Ix6w73fX0YXKlHMG4JtU+2hvHKJQTz7aKTUpqMRlak51p4wnk949KZaAjy+YkvKGTJn6CuOvHJxxujPEn4angWTbVc3ywGIEfEx1YUpfCieJHbOf8RPC5n9W+SU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB6PR0802MB2311.eurprd08.prod.outlook.com (2603:10a6:4:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 11:24:01 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 11:24:01 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] ksmbd: force "fail immediately" flag on fs with its own
 ->lock
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, kernel@openvz.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <bdd6f570-f387-0371-09fb-d7b8c9993e8b@virtuozzo.com>
Date:   Fri, 17 Dec 2021 14:23:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0073.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::27) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fc7cc7e-bb5f-4e5c-d302-08d9c14fb9c0
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2311:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2311CB52457B8F431EF02797AA789@DB6PR0802MB2311.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1zibnV26rQBdQYWVaJLwp6Hl5wyU3SAtkHkYl0mbVAAXmZA3ijGn4X7WdgyeKx4Rb7rc91+0aCkHJHQUL24HvFozxg+ogn2OntSMzYIovMuJ5/adEXh7P+pF1833t+ns/k6DcG6XP+7H5PkILPNXXVrourKiJk6pov0oXtpGjhOxiycKyCshW4rBpJx4LZrapapz1QVSccBjJoLIs9fhRcc8Xdg6Wmur4eEwmG63m1Nd852HRi6EjSRbeYr5x34A8lGzdlAU+hvjohqtztsiPUP6GthT8LOFvNKzIGNyS2lGYkAr8Zb7KGpiAVxLISMs8JZEn52+zFKvMC2X74hAsWotFHoj0C8Y4Mjfn/GnT69oe4gZP/o8gU4VLwNv6k8bKmAuREcP+hmtP2D8wj7q4huWgdIMitD5RRLA46bccxaCmGIFT+4wOuru4n/EAwsXdE3I1HvNg80BTym02VYearz+YrRdKEeiIUklRYHKQ4rO1pPJGgp2jQraT8hkzVVUI9EO6u778Ay49S3eVgVK1zelW0ZU/+KB51Kv0RjK/YqgbfTWKHQ8YRAW5KC9fRFqiRAQqkCVGv0tKY4xgInYqVmfqMdzz+ZAVczQxx6PsdsVFujSgkOfAHXH6X1cr8QxUtM6KyQt4O/lUk2soqrOXVryhqijzj7QlfJVBo3vL0Y+0wPjKTFmd3gJfWS9mD80Huh5F5H4mzAQ4x8Y+QiU7YhlFNc14YLNplFnNyUBpv1CWa4kYyoqVTXgUddool3YzCuS3I4M8h5wAqulHWajHhz9hIMCCuu3vBYeZYSHKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(508600001)(6512007)(36756003)(38100700002)(6486002)(38350700002)(6506007)(52116002)(31696002)(31686004)(26005)(110136005)(316002)(186003)(66476007)(66556008)(54906003)(86362001)(2616005)(8936002)(83380400001)(2906002)(4326008)(5660300002)(8676002)(14773001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGpXcURIbGpDazBqWnY0Q0tJNGZlcThaMXUwTU5JakI2bFFKK3R3b25TTTJC?=
 =?utf-8?B?Ry9WOEFjU1RWbXJjOVJzamlnRFJjeWg2aU0wc1ZUSEJ0K24yUjB3N3h2MTVQ?=
 =?utf-8?B?YS9ZSktQbmRmRmRselZTcFpOWENpdGhoVzgzdXN6WEg5MmEzbVpheTdhYkVh?=
 =?utf-8?B?MTFmdmVCVGJwOWRVWHZUQUVFYTJrZ3ZpTHBlcGVTQXljTmp5bHRYUUhlNy9Q?=
 =?utf-8?B?TWc5Skl4TWtWQ05xeDcvQXZsZW5HSlZsak1FRjFMVy8zd3FaS0RFaGJlUmw4?=
 =?utf-8?B?OFhJMVZ5Zy9ZeVhKWkNPL2tjZ2JvR1hJbkNMS3cxZzE4NHcvUGw5Q24rSHpv?=
 =?utf-8?B?eWkwREJZcVhLSVBSNlptQnpZRXNXRHg3NThCY20ya2Npd1pDZThWTHkzRFpy?=
 =?utf-8?B?T1U0ekpHVkNTQjZTNFBnMW1xK3dRRGlQNHpjQ05DR2U2VGozaVpPSVg4YWVE?=
 =?utf-8?B?ajY3aDNYTm5STUttZ1lUbElJY3BDcnFSNlZzL3AzbnhlVS9EejhWSStZL3N2?=
 =?utf-8?B?aE5ON1lFNnkrNDFsQzhzeWhNYUtRcElheitXcWdIUmlhblR2SGFkMzVVTGFV?=
 =?utf-8?B?TklTdUdTWWtsRHhHdEVrd0tPYVYyaVEwcHJHZEtDS1ltYWhqMFgzSW9jSHpx?=
 =?utf-8?B?amtNNXNkYkY0RFhibGR0dXcxNjhvdXhucnh1Qmt3Uk1UbDg4QitObm55ejR3?=
 =?utf-8?B?K0k3eTNGeDlMcmpqNnRTTEk5bUtKRDIvditpbFlxd0Z4OUs1NWVmQVBpdlU3?=
 =?utf-8?B?TDYxU1Q0ZU5OdzAvR0FzT3I4SnV4Si93bWljYkdEVU1aZllqU1pEby9ValR6?=
 =?utf-8?B?NlFiTDJJVlNVOVlUemVzMTFXaEtwNEhqN00zMHN2SEo3Qitaam81eXRoK3Rh?=
 =?utf-8?B?MUtvdDZGdXovdG1OcHJaZCtPVVpxNEM0MzIrdXowSHZiR0FaTlhJTjJDVHVk?=
 =?utf-8?B?VEEwM2JpbjlzbUgxOEVoTER3aytvZ3IxNGt2bUxZUFZTc0czSWxKbW9FLzFP?=
 =?utf-8?B?bTNuc3k5Uldyd2svL2xzZ3lCcVFvd0xSaHpRT1h0MkVNTnRnNHVGb1VYRXFR?=
 =?utf-8?B?Z1czZkpHRXVzZU9rQjdpNUFmL2ZwdFVkdlE4Nk92QlNoN0RJK21iTGVCNlh1?=
 =?utf-8?B?dTZZY1pOZXVXUFhYMmphY2g5R2xlWkUrYVZPZVVHTksrL0NEMFFhUUliUVNC?=
 =?utf-8?B?T3Q5cWtiU1FpeEUyNWszODhSc3MzakN6NHlTbitaUlA2UENLZGFqTUJ5WnhS?=
 =?utf-8?B?UEpxaEgyWnNlUnV3dTVmWm9LYXA4N05KRHFxeGwvREF6TTN3V3dLTUVid3BY?=
 =?utf-8?B?Y2FyOCtvS1FIU0FhcnVsNXdRWU83UEE4M2VOTks1TkpGWEp4N1ZiaWVpR1VT?=
 =?utf-8?B?Sy9rWllBT2JuREV0NGlSSWFKM0l6SFpoajY3dU0zT1RhRWNEMkFrenZsVXVm?=
 =?utf-8?B?UHM4VXRMbFBVRUhRT2ZnVVQxTkhLUFhmWks1T3J2MUFwc1Y3d1R3YndIM2Zh?=
 =?utf-8?B?Q2RPVlBHMGxxWDZydEFXUDNDdW9zOUhUVm8vNWVTVFp6OGptOEdSNWxFZ3BT?=
 =?utf-8?B?YVRGR1RkVjhibTNmaUUyMUlHSzVzSUxTVUFpRURBL3lMSnJjRk9CMHYveUxV?=
 =?utf-8?B?UXlaT2FnK3J0SVpQb1RLanl5VUFBMU04clM5OC94RDRBdDNqZTBiNi9OelFI?=
 =?utf-8?B?dWFQV2F3WlZ4TG5XYjBDQmFvTVhYTHhJcmRkZ3NVUVNXcVFXU3BvYmZ2bkI0?=
 =?utf-8?B?aTY0QzBVNk9ocHlOTFN5UTBHVFIzdWwxUzh4YXR3VUxnVktyWHRiWFYvZ1pS?=
 =?utf-8?B?cU5WUXBIVmg4T1BidExuTmFtdVVDdDdYOUpVYzBTUTY0d0NIUmlkSG84YzJX?=
 =?utf-8?B?RU1SZGhwbkhjR2ZrOXFhMVZFeWpGRUhURmtESVVLeDJwNjhhR1R0VVEvR3Zt?=
 =?utf-8?B?MkJqbkxpVU53enNuUUtxdkFYYW1XTlJGZEJxQmczMjFFdmFMbTd4a1BUMzY1?=
 =?utf-8?B?c1E3SFVIUEJYbVpPVGVlZE9OZG5QTXRFSU9vQVRjY1pMS0ZtU3dFRG45UGZY?=
 =?utf-8?B?K3J0bjVHSHdENStQeWQ2OEpFL0xsNmNaR2YzU3hPaktBclFJcGd1blVoc1pV?=
 =?utf-8?B?V3dTV1VxSjVQRXd0RlI2M3VBbGNCWG9yTncwcGZCa0ttWEk0NDRvQmFaQ1Vt?=
 =?utf-8?Q?N4MzpcGp0FBuve0PZPuvZQo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc7cc7e-bb5f-4e5c-d302-08d9c14fb9c0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 11:24:01.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5v6qSBgtf2IM4TPhRis2ceVaoiq24yLieMT6tipubyrRymusfadjVkayhTYfAYA4dM+0yxP3x8kTsyx2k2mpOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2311
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like nfsd and lockd, ksmbd can cause deadlock if the exported
file system does not support asynchronous processing of blocking locks:
if all ksmbd worker threads handles such requests,
they can never finish and the server will not be able to handle
any other incoming requests.

Any filesystem that leaves ->lock NULL will use posix_lock_file(), which
does the right thing. Simplest is just to assume that any filesystem
that defines its own ->lock is not safe to request a blocking lock from.

To work around the problem we need to drop fl->fl_flag FL_SLEEP before
vfs_lock_file() execution, it forces affected functions to avoid blocking.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ksmbd/smb2pdu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 121f8e8c70ac..f2225491af02 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6634,6 +6634,12 @@ static int smb2_set_flock_flags(struct file_lock *flock, int flags)
 {
 	int cmd = -EINVAL;
 
+	if ((flock->fl_file->f_op->lock) &&
+	    ((flags == SMB2_LOCKFLAG_SHARED) ||
+	     (flags == SMB2_LOCKFLAG_EXCLUSIVE))) {
+		ksmbd_debug(SMB, "force fail immediately request\n");
+		flags |= SMB2_LOCKFLAG_FAIL_IMMEDIATELY;
+	}
 	/* Checking for wrong flag combination during lock request*/
 	switch (flags) {
 	case SMB2_LOCKFLAG_SHARED:
-- 
2.25.1

