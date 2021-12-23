Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D12B47DDB2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 03:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhLWCYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 21:24:22 -0500
Received: from mail-eopbgr1300090.outbound.protection.outlook.com ([40.107.130.90]:9136
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229788AbhLWCYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 21:24:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ze0W+2zgDqBHOEXYTfdjaynFxzW1TlsD+oUDh0ODKbIj/vslxJodbZps0Ak1OwJxqJB4FCokxN4NDLjVNI14Q18Gk7VsD3P+B3WeQvy6DbW99zo8NuL99+qbBm3esbgTMz38IrYEAV6HS2FZR65ZdrlMBQzwTwfQZ/yYreh5PsD9XkTX2qTRG0ox2kyQiG5iKAMWoZyrrSX9yHl/DmWw8jAqPm1gjtwQ8Pju175njGDNusPfafINkA1d/z+jnpvv4aTKFOQD9BwCdmpNYtoJaUknjQ0O5Mc4bN30O7icEQx3uuY0byLaJjRdZhevfHcwBPFmC024OeA8BeQsXT/xLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnJKTsowd+Sg5QVFDKKejXMKqwlY/nUa9Dem2F4lJm4=;
 b=KSmBb5aEMjYnWFpgxQlv4TNu54ksQAgPh7zpfQsrwTp8ICF5h/mr0LQFkFOm8zonXFvX8lNtWGGVlPuw1ifRubYMYowyVT/WkiB121c7Y4DMZxSyJs6c190uFWpvZNALAK78Ackez6l6EeMW33cUMPR1SLzi4Uxl7K7qzcR8m95FAKBvAplue+MqE3KNKi6dClUKw6a3kZ/l0iEaEn1fTEyLeMSXYUjA/NwONhbZXZvGGEKNEzUvoeU7V410vI3+w/oazRN8ySv+CshV5NIkoAY9Bgh6LZ8a6ffCGH8xZ1LjMl61FdvJcKZ+8QChH4teeaLn7+GyM1rw2X9rd81IAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnJKTsowd+Sg5QVFDKKejXMKqwlY/nUa9Dem2F4lJm4=;
 b=jTxQETEcIDjM3IxMdH7saHDyGvaVdI2KCfYqD984IviCiop7hcO4/j3QYTZZ4pGwatEhSvom3ExHDnoCX3t4+FnJeL2C1FLoK+EMUjuxGNHjWMELF2kZZSWuWJvxk03PzS2xeno9ukptP4tsQNaXcNlY81fFr92nXvf/rr+CMww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3388.apcprd06.prod.outlook.com (2603:1096:100:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 02:24:16 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4d34:9df8:fabe:fdb2]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4d34:9df8:fabe:fdb2%6]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 02:24:16 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] block: return specific error when pointer is NULL
Date:   Wed, 22 Dec 2021 18:24:03 -0800
Message-Id: <1640226246-32691-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0149.apcprd02.prod.outlook.com
 (2603:1096:202:16::33) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3e87518-6e59-4027-f88a-08d9c5bb512f
X-MS-TrafficTypeDiagnostic: SL2PR06MB3388:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3388C92647424B29AF17FE0EBD7E9@SL2PR06MB3388.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:109;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPlvMN4MGWTUAWeyFHHKGUpJNEtgOsFdcepEh3zrfFZYgWkc9qqjYD8e2PZ4Bgc51c9FH3zNKpOURJcTR+zugU2tBeqlf3VOIHD+DzeiPAoUoNt5jE+y3Bty/juFaND66sCAAE7k/l34DViRVlmvIAKTA1tZARxTfTbLa7goRKRjt++bNT1Xz7TYVtp167QxjTB5oHAMbpA03Kr+UjiY1ztVFNVGk5SK9OypL2434a+c99BE3+3iCExjzBcCo9wbNYrxYQg7hiP7gRhl1HDIt17ILndVwkK/lKYGwdvrSpKwn73iBOHGQiCZXWMVirq9PDT7LRdkMjoiTyVKrQXc/KKFAcu873N+rTgS4l/Otu92hVbl4HgxrHfRQKwixAU1Sm97asdVVpNMw7iDhuvkwx/tepdpT/gXL2KDscgT4ryV4NdFJ6xhFxxu4yqHed47S1jSZFMVcYCGRC8QMXYf1O1v/v022wOicF1kFtIKS5hy3A8ZYh57FHxHe0GJGLIiCtXa4FJqLchA9LAwTY1vOenkZrVjdN50eBNxWQ7eyzR5BkoRIDXjTY+EbVzdDQlmG4cfyGA6+9KixUQ5pupZVjdfnKhoCnB6hOKwklEpTDPKP0Kv6gAOglkYvKrhZbQSQGG0AulA8n427TdR1S4fYpeBbR58Ket0QGZd5Z4FESO+Knd31MUDqkBL4v5VTKY8aM5Mg2yBCqHvk380OOslqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(8676002)(4326008)(36756003)(52116002)(6512007)(26005)(2616005)(66946007)(66476007)(6666004)(8936002)(508600001)(6506007)(86362001)(83380400001)(107886003)(2906002)(38100700002)(38350700002)(5660300002)(316002)(186003)(6486002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4VwO02Ab5QP+dFqA2maGgX648caNweIUPwdfjjL8JuxAjxr6VDzUDj0OQ/di?=
 =?us-ascii?Q?FTI6AUvsodh4bU0kgAWatD897azBmabjofcbRK5fqTdnbfC2XClv5z5ECEhZ?=
 =?us-ascii?Q?B/Tltt04RgRB8eJh3T5ECuIYIX/DEmEMFCbZA2D8rHCE6918MjWKKuMl7qFl?=
 =?us-ascii?Q?JzRQWqAWRAiplRlRsNgx6xtDYOw2Xfv1gToKKlkVhiM+YwdHZkOt5Jc7UzfH?=
 =?us-ascii?Q?mYCnfKF5nSf/YWKKwu4XWufkc7Xlmj4kqteVIA4FLF4nr2OogyQirI1zzWzv?=
 =?us-ascii?Q?XCYj7+HlON+UaaojuXaHVuUvm59s42pmFLB4KWopydNCED+PDqndhRm/lTT8?=
 =?us-ascii?Q?1ihEE8AJuWHs5Xg/u/NGK2rqbJt7ieUeB02bQ8JCbH1bQicuFn0k6oUh6D6b?=
 =?us-ascii?Q?+Zomn0u5rKlvouQ1xgN+M/ElWaGyb09rWuMsnL5PJlu7tbw2iK5x1qjGm982?=
 =?us-ascii?Q?Zsg9Fm4AC5Wy7OE8sOuDGG6uWTlpMdld1j77J231o16K/COqIBX5lSoOgt26?=
 =?us-ascii?Q?ESxRF4Iye0Qi9zCSg44PnfbfQh31N49l3eM3iBsAL5G0FMSbhzFpfKexhfws?=
 =?us-ascii?Q?/knadcFrQ8Dsl3zsksPvo31ldPnWnxxOoTL/50Q5XjExVjr/e3he8trCqBdc?=
 =?us-ascii?Q?JPkWJgYTJ/34KuBRkXJ8wet3+Nvi/GANNxsPX1/gnVVOisRMGtr2B6lq3sfY?=
 =?us-ascii?Q?4n16x186CGMLlCprf7Y6B3J0+keLo9oRAJMgJb+umWJebLsiXBso+kn7yBZC?=
 =?us-ascii?Q?ykJA9z7RLGvxCx1dTLHDzqtg/C71Mo3SLwB+N255vzlW6GOFwR5oNG7whqZe?=
 =?us-ascii?Q?cKskZLZHIbN7etJzaSJMxCXAGBCGm6gFtNdsvyJHNQoABo5DduwrCC+prfDb?=
 =?us-ascii?Q?sWAJRhDJMnZZiJEZo5sq3lGnMdioqBAVHmf+CBzl47c4HPmy/pMPM7hU0JuM?=
 =?us-ascii?Q?/DW11i+9bzt97e7ikZTiE7o1X3si4HAgoUl7HV7Wt479cud2Oc9mENJa62Cq?=
 =?us-ascii?Q?mHNNmHS+oYquef8qEYCcGwxPo9HGW4xwNYbK2qceNr/TJDZe9bS+bFkCPVAJ?=
 =?us-ascii?Q?3sSUkOnpyk2DVyUIKhlQ+yS/dhG6OACwQERaO4stgmHhQOnJfK6+FvKVSrn+?=
 =?us-ascii?Q?u1knCGtfgMloCId+9vhTRc1q2BKXxf5jZlEL/hmUdLOiC//f96aYfwGC+p8E?=
 =?us-ascii?Q?NB1I0Ok333s8NZoRG+QaMDGMgHoN1G52mG0CMFnQpeSXyrMZxxZoOhBA3Iyn?=
 =?us-ascii?Q?fA2+LLNz+pEgA/neOo2OrSG1bBCgCb5f75lNFOcPGxkuH9bk2W7IiE1gLvhJ?=
 =?us-ascii?Q?oC9MUn8c/VCh3ZWEA8HgkRipJAasGutesGMWlMrSXjeErI/7dVWz35Bp/raj?=
 =?us-ascii?Q?6ZZ69LB0k9XDoE/HQ5+rW5yFQY1cIaORHZq/LyGF7Eu1DC+IFty/+r751WTp?=
 =?us-ascii?Q?7RMuCPaDx078zU/pEpGr0oUXRuudhQkSigmvQAIfBpC259owxafKFivn+emm?=
 =?us-ascii?Q?JYtdghaLZo2ge+Q+WlnBJEGxKTLQNELbut6sFn5uj/vur2T7lK7V17+lsykX?=
 =?us-ascii?Q?GOrwbvt648JXmXeRdnop3kglB6c55ZemJ1PWurg2yLv2FsexprVNIG3rVErl?=
 =?us-ascii?Q?8/keZVpH84FvFjw0ZznISho=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e87518-6e59-4027-f88a-08d9c5bb512f
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 02:24:16.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYbA3BilB0GYyoSyxzGVheq2Byvj8prPMi20qmKMcZ1dE35FMBzBrJ2nQ2xnGTZSjgt19VYoGvJKzdtq3px6dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3388
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

loop_attr_backing_file_show() better return specific error than 0 
when pointer is NULL

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e52a8a5..860a5b6
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -667,7 +667,7 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 	spin_unlock_irq(&lo->lo_lock);
 
 	if (IS_ERR_OR_NULL(p))
-		ret = PTR_ERR(p);
+		ret = p ? PTR_ERR(p) : -ENOENT;
 	else {
 		ret = strlen(p);
 		memmove(buf, p, ret);
-- 
2.7.4

