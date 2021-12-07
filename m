Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D7046BBE3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhLGM7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:59:13 -0500
Received: from mail-sgaapc01on2121.outbound.protection.outlook.com ([40.107.215.121]:2529
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231842AbhLGM7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:59:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPb8Xsp0RXRnOZhK46xi6JAgm+xsMQwEry1L1kH3iLeMfTnk9Mna8wh2dCJdPmxmSxHRc/C7w75Y1T49XTVUrIJ9CRDrLwQuy07OQsHev2sac5YfXJHFKcA/tIR8fqQurAyd9V3iTcmSudiVHypsa9hpPGhXmJKFnA2iXMouTl9xg/Oo21kfMMHAXLXop0kBqlqlzn+5ckYemDzt5G1WiXpK1BYtBWySWJOAOC4ZK/2ph/DY2/aCK1Xc1p1Dajx6NNH6hBtgyZjFOi525twARcDIsvdpLsr2zcWJ/Jn2BqmCer8TPEKKcfOHjAkj4fvlM6ATg4BR/3Reugd8JMvZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hw18XYkrpmisj78so8Dl0/a5rQwcSTvBpu99ioW+6eQ=;
 b=jFRPB7osQsaJ2Y7Ma/M1xVONuI9XEYOqvSvEsITQhF3ATkN9T1j+Vkvg+oKk8ETl/nP437BU6ZPPy2t8RhAbb9EBSwq1JmOXoo1WBNrQtfmcAqRbUAeV5sQJO0CMFpPVQcbu/8OLOLBO0MKmKv8TYZsZzmWl/0sy/YLGad5w3a0KmNm4tE9o/lk+8SdfbwqmgNKbDtgwbdftKgqswZ5g+3Sw2qcuBWSGw0uwwGb3hgowUYg4XZ6mScgPfM2auA/TKtIyJ6KXw+dKSXzdL5KUdpAhI5nfgtt8rwCCsdu4k19zUsj3W3OATc479wvMYERSIkcNJwiKgeTkHbtupfu7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw18XYkrpmisj78so8Dl0/a5rQwcSTvBpu99ioW+6eQ=;
 b=NFoPVJkwpioAXfPbeQwD2Mdy1wGEzFU/pv6nDaQ6a8/kWfYdElaLcorbf5Clxbem3wgFYZ25E/kyXiP0nUlVzIUbfw0TGrJ2vyuTeit0lmqQehFvxIG8tnQMiLc9CVsRiFO5BTrBHp8m313e85HtthtJh5/VGzi0jm2Bzq/vark=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3388.apcprd06.prod.outlook.com (2603:1096:100:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 12:55:39 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 12:55:39 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] trace: use WARN instead of printk and WARN_ON
Date:   Tue,  7 Dec 2021 04:55:32 -0800
Message-Id: <1638881732-3157-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0019.apcprd04.prod.outlook.com
 (2603:1096:202:2::29) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR0401CA0019.apcprd04.prod.outlook.com (2603:1096:202:2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 12:55:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28050960-e401-462d-0ca6-08d9b980decf
X-MS-TrafficTypeDiagnostic: SL2PR06MB3388:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3388F79B21ED5CD631DB8311BD6E9@SL2PR06MB3388.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:425;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCv0McQ4u8hWS7pGn4NbuvwAFqfDY7DpmBahdJXEZF36DQjpuYG1bZwh3lgXImzvvpPy/0c0ouCY4l1TqLN6nAxxDlpaLyx91rnt6cVsVYN4II1m6zzIp294m7CRCEHLtxkmMFXUPYDcaH2+oblxXgrdqr4UcrI4i/WGTOFyGeh/QSk/A+aRTtfXs3wrGZdztUeweO8A3NlmfwqKZ8Flmw1CWUcZSJ/YZPwVy0V0WVsGx9UVnNZq95gXTZeWhka0sBinzerIq8yfsUBuPC46dUnE2Lld9viJp0acEQHfGCmeWHo7IkVo2XsSRMij7K2P9+Pjn5m18kN9CdC2iF/Fqnbl2NGj2TlG+lRZQ3sJ5UQ4byO1/GcMt/t9o6f3aM8wklvpAIoF7WlW6oePdZpLHiyL6HXJ+E0lu93mba2c+o0eATvG/KSYTsTrYFXH75/CEe9NRCJqs6NhASjf5meElkCqHi5OkvriokSMYpjRWja02UL6UX07RWEwghzTi7Ro1+zJpZxFXvNA6rLkR7Xi609GZ83sEd4aTXfjq0kJD6J1Y/fcyzy4QGKjA8JV8UR2EUO5Xn3rhV4jO94K7BuyecWyc+PbPbvynNNP4Z1y9ZZN+6GH6Zbc+znQDqKTBSC8IbDZVGz1a+SVavQRutR0PY8yXthPhcCYOLrejRh4irhHYIavS8MdOIjLjCrhO20otIu6truBeTks6wzEawBW+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(186003)(956004)(36756003)(5660300002)(38350700002)(83380400001)(107886003)(8676002)(26005)(2616005)(4326008)(6666004)(316002)(6512007)(6506007)(66946007)(6486002)(508600001)(110136005)(66556008)(66476007)(52116002)(86362001)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6LBf5btMea1QHeu7M2XbTAndk5PYYEMn6rEsHzkqW6vtcqEPdFrx1yCI05WZ?=
 =?us-ascii?Q?QMP/reREmu/o1jIWKxn0pZzmKnqCzSm5lY9MMDG9WimMsW7xcfB+TSAHWyzo?=
 =?us-ascii?Q?mASM+/cEqvkrHkkZRAkVa7IWi4tQoz3CJYujoM373jBcayvaQiVqObavOEJU?=
 =?us-ascii?Q?/7VNIEZvkodw+983go7i66bZCp4ZBxEG2o2hqXHC6Vaz/kFl9mdECsW2aFRY?=
 =?us-ascii?Q?PqFITAhLGGXc2soBqkjmh78KTdLLks0P9ilscCIDAO9zVkBOicoMkfNwe16g?=
 =?us-ascii?Q?lJVnnBXqGzkXxASBfjqjJK7jP/jHFIGIU2eTgsDCN1PdQ7EtQSTK4yuUOXYm?=
 =?us-ascii?Q?JlhCR/NRBiUeIy+2iTcpy+WBi1GJh6mAYXhgUDGGAxMJJrYIvZ7SEM24H7vz?=
 =?us-ascii?Q?TYGPboqO+q0FDJ7KuvqpgXFrlqFUBllkP7MzxD4yc2QY7q6BkP2TtfAoJaJH?=
 =?us-ascii?Q?YPBmtjV3MdW0ERlYeuaot7qVBRqzzodhXljdGP2KQYuZzBW1j9vMXnlHIf55?=
 =?us-ascii?Q?ZdSeyRRvIf2kur5Z+RsKIDctS+4mXdVLEcMpB9r6xypoXxNchUq2MEsmRPne?=
 =?us-ascii?Q?PkfYAUrPjneFaOKTtdotOTimos5zmABfUzpI66/r63eIjCO6jcNDBcjcFbWk?=
 =?us-ascii?Q?zOc4V0G696aQ/VhRORy9djCVNWLBW4qA65BYYKZJCgSUmZ5rKAoLQze1bKdN?=
 =?us-ascii?Q?BeiTcAWogbSnYQWAvIptfAipvlK65lpNoqtOdWt9o8AszPOYoYRZjbmAdTne?=
 =?us-ascii?Q?NpzD/OMlRy2LaB8UoeuYUrONnuJBmu98GLpaDPXcLStNf8bIm/rL7DKIMfCY?=
 =?us-ascii?Q?vbsmzkw26hnH3cg6dlC+G/WhuZXsZ/mPbS54+iOJ5gMfrl5mB/PR1RHr7lSd?=
 =?us-ascii?Q?6mWkzuOiECaNjrCx0sm6608FJji2hC+YLq9xMEcnr5iBGCamF8WA0Wxlo1z7?=
 =?us-ascii?Q?vb2jGI4L0fqRNpiiN8SAbAZ4107klrvlzlW56mDQtGzUQHWqW77HsWqK3crz?=
 =?us-ascii?Q?roshI4tWvLd2h75W87p2SzuiCIQUyeZtDUMcyqb6y0EfBB6GWHummdxURAGQ?=
 =?us-ascii?Q?kQi7LqBDuZ2KbCd0HJggJXtf6OhHiX4G33zZFxMyJlJly6gnVfXCUip75qm8?=
 =?us-ascii?Q?e2mFO+u4GuUK6GzzArwHbAMhWuWZO3NinQK3AvY3eUQe0pTHtu0jqeDyYg8H?=
 =?us-ascii?Q?0wa8Iwh2T/2iGZf5jHNPlocvX+wXAMelCbiCtzs/8HmGwxVCTHUfl8Si44o5?=
 =?us-ascii?Q?abgnkMuM1we/vFsf7+XWLY4HEeND0+n4zaHTUpgyqD2HiHucWi/RH4mCE6KM?=
 =?us-ascii?Q?Iewo/P9oUMGDxT6R9vKsEF2r1joUuy4DbqfbBdC+LvgsLpZB6fLL/AxQtfus?=
 =?us-ascii?Q?xuDuIA57xI8feN0NHE7zifBfeNc5tQDeEzciE+5fFZbToWHQraSTFL8Jdddh?=
 =?us-ascii?Q?ljhfeCOag1o/zv/m0YAzMT1+YIX3jsx6nDWcr2ag1jaexLd3fzanzRynAozg?=
 =?us-ascii?Q?iOVT2AW+XmspuJS0vhXQUCCHUmnj/x4jNe44isriW9GZ/7PnFxyQHTMqqx5w?=
 =?us-ascii?Q?nPNuurjYOx3arYWoTkxg6aqNJ3MjiubD6vHYE6fAD/op11Xw6sGtYlQgQ71h?=
 =?us-ascii?Q?niWfUbmZRDirjNGX6PltoMQ=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28050960-e401-462d-0ca6-08d9b980decf
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 12:55:39.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sn4t41M0zE8U694l7w9ocvKxouufPdpDS0aRbYrl2IecfXqaaEWfP4EThVbS9c8dMwiHZZIpBMD+bAemG+Vvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3388
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Simply use WARN instead of printk(KERN_WARNING, ...) and WARN_ON.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/trace/trace_output.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 3547e71..e0348ec
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -775,8 +775,7 @@ int register_trace_event(struct trace_event *event)
 		list_add_tail(&event->list, list);
 
 	} else if (event->type > __TRACE_LAST_TYPE) {
-		printk(KERN_WARNING "Need to add type to trace.h\n");
-		WARN_ON(1);
+		WARN(1, "Need to add type to trace.h\n");
 		goto out;
 	} else {
 		/* Is this event already used */
@@ -1569,11 +1568,9 @@ __init static int init_events(void)
 		event = events[i];
 
 		ret = register_trace_event(event);
-		if (!ret) {
-			printk(KERN_WARNING "event %d failed to register\n",
-			       event->type);
-			WARN_ON_ONCE(1);
-		}
+		if (!ret)
+			WARN_ONCE(1, "event %d failed to register\n",
+				  event->type);
 	}
 
 	return 0;
-- 
2.7.4

