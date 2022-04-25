Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97150D752
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbiDYDFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiDYDFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:05:32 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF36AC06B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 20:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Un9CZGMWC4SSwsrFnL2PA2h06wonU9WwzK7eg+QAxgRfZ4G4iEJSmhpF272/2YR3NfJXGaQtgbAccMlZQ2R7J+RUDkALMwqHZFItKXIMaiB4RP2V0pd+oFvcT6fx7xUm0S5vpiI7vE7I0TAH+18/D1267tRiAOOBLA/d8zOnYtjehHDjM2osWfcDttl9/h7ybMtSFRyEPh+83f7TZlDPzN+bTw82QHAuOTC9pmerasAIn1sJ1in8vySNFbWq4CJcwecryNtIsmercWTD1YhdTZNnYkB0t6pdYF/Ujv7OzLZLRdgqb9NKYwhmwFa3FWsnBtkR09QHxt3vXOBSzxvL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EixSOUKlx/SuwYX7jVufueWoLYASGITK2vsSaKXJew=;
 b=PbXSzEWYuTOMAOZlU6GF65CtIvwZyIL0b8AIzCUItyRnm1QuGDEfgAsmvXw6qJ6u6GHHidQ6roLmYkvBS1TZzaU99G0De33be5OqRQlmZztYbaMiCmwG5iinBwm9wU85SKY7XiDgPPcmRdLB2JDsd2NBtSkPpb8r6x3CsM10wcxmi31TpeKB1Q6JOdlBf5qMBM1eem28VuSl2JC4v+MVjbpZ17xx/OS56VBQ3MrfrO1f0YhHbHE7i4k0kKZu+EIjI9lDx4+ZrvnbP/0CvXXRRLhrit18mKVZTZ/bPzi2b5/XIHdoGKkrboZMfXnSN3hfWwTTJVtegalgRLtU4EwDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EixSOUKlx/SuwYX7jVufueWoLYASGITK2vsSaKXJew=;
 b=S/CYPOJtzlPqW6cDN5YN7K1DohJh+dLTzXBF2kEzue+wKmW0ehwVZDHNppFaubRQwE+1Kd4WINIyPYr7Ak6imnlCT69wM8pPqSS7usodl+rPTITD5QKG4Kp42dlJNJE1FuWLUI/Op9pomJ4GIUuh83NiSWBuOd6d8aQSRVJaS1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3374.apcprd06.prod.outlook.com (2603:1096:404:a4::10)
 by KL1PR0601MB3940.apcprd06.prod.outlook.com (2603:1096:820:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 03:02:23 +0000
Received: from TY2PR06MB3374.apcprd06.prod.outlook.com
 ([fe80::b13e:aba1:b630:a14e]) by TY2PR06MB3374.apcprd06.prod.outlook.com
 ([fe80::b13e:aba1:b630:a14e%3]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 03:02:23 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, joe@perches.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH v2] ring-buffer: simplify if-if to if-else
Date:   Mon, 25 Apr 2022 11:01:41 +0800
Message-Id: <20220425030142.142972-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To TY2PR06MB3374.apcprd06.prod.outlook.com
 (2603:1096:404:a4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d7618dc-46c1-4836-26cf-08da266804de
X-MS-TrafficTypeDiagnostic: KL1PR0601MB3940:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB3940515EC48E0A319679109FABF89@KL1PR0601MB3940.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHmqOutlyfjzquFaUw/NwV6R3iz2tmKfI35ffLg+6rrudjIpl0pyeaS5xU74HNtoe1afG1+kjAmX5WcRKohCqvgaFAzwBCaAPbwIft8CvFx4QDlzXqM6twtEqZe6FdYhSXtQXIPh4Q77lCgFdEudffkMPoSeO+JUHHPjhVu5W/a8cZmyqFY8I3603Lvx1WKwxg9eMc/SA5VsINJ46QNqKYBqEA3HEFJ5VRuzZO7C6XfpUk/YxqX1nlTLNuJJZ0rjCD807CkvAkQqNEMIyYfPq1nI/uItE3h6N7iOrx0gMlGLuDD6KWaWGBe29YaAGg5EPKisFvegChjkldGGV1RtU69e6h6zYS7XxweasxsnEDNG6s0+AJOGnG3PC4EDobudF7VCKdKqZv1mPi7UidnEP0TA8bAjvconlBRO4eNQKsrpHEq7fy64ap5q6nZAEbgPIQju6fIIDHZXyYm4jh1jJH5DuDcBtiiAkR049udEUXOrT17TEOru6X58Nf/vsvZRicw7VJna9MMU8VyHiCoaulATHr4sw31o68NB22lEEL+P5GOWCg5+f03fYuegIk3pWyJq4mPcWrR5Pb0CWCLhBu4ytgxzpKyYL84jROtcqdYqM6H9o6WU+6imTXPPT35nOmeDJThUufAQvqMjwdwnVEEhcquzJUNWs0QxTMyxmrsw1sfyx8BveH0cGVsBB7RpyyrqY/mVcLJy91niOyQaEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3374.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(6666004)(6506007)(1076003)(107886003)(26005)(6512007)(110136005)(2616005)(52116002)(508600001)(186003)(38350700002)(38100700002)(83380400001)(86362001)(2906002)(8936002)(36756003)(66556008)(66476007)(316002)(8676002)(5660300002)(66946007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zy6EXTzNryqPisiNTx3mJfa2yAsXz1LmpZMtdQprmlU0Gvitg69aae0ZLWSR?=
 =?us-ascii?Q?AEmoO7LEZ4r6Qjk9DnUMXUOVs/qnqZt7sgDgz2NsCHulhB8mOjGpJWvVv2Vd?=
 =?us-ascii?Q?B2+Ut399kVr7mN2LKT+eO4NtCblVVhKZnKN+4lxWNxy1AXyj1Dn6JzOQaqEE?=
 =?us-ascii?Q?11gf+KPKe4pQJTkbcqXc+yKzmu3pt56TlL8JOCBttPY81f6PolMU7diZqFOC?=
 =?us-ascii?Q?ZDF/jMacUY2AO1LzaYQVkepyAbX+Qm/xWpzEpoRVmOcR2MW/SmpaBV0vk83q?=
 =?us-ascii?Q?IXO65kD09CqGKI+LH8apitzqDqg4vInvVhum3tmf9vdG6ro7s5GwzbBXZ74/?=
 =?us-ascii?Q?m+BLxvLtk/WAyJDSeNcJrRrcdfURw4miCrCf9DOq347srXG78T/XhOdnbKta?=
 =?us-ascii?Q?a3QgcpM+pdOkwKYtUjN0wk3tgafuniuZaKgcNEdZQ/oSmN2DeLbkI2KwHwDg?=
 =?us-ascii?Q?Rw1w+XfgZVitx7hsvgNMTYoATRG4NPWeR+5+OEjOnQj5KwR+vOa8N0ryYZTf?=
 =?us-ascii?Q?pDztRxT9Vdnf2gas4QgrqUDCTOO3Iq/2naN3/z8CuJwc94jIlWAuFPRuQDa4?=
 =?us-ascii?Q?Vw4T+YTcG5q1ffYfO2PvoiWbWX6RpG3sINbX4k16KVtinzMYzz9DMGpwZk0D?=
 =?us-ascii?Q?f4IaCkRjOT/OYLAgKOpUkW2WDML3BxGxpwz+jsBO/FyD9UYj0AybFVnrAFpG?=
 =?us-ascii?Q?4aZkUdtOxon3dVDDdnO5WhKLBOWx+eebl+K7SjjMd9oLV8021OrJD4Hh64wv?=
 =?us-ascii?Q?yoJT0XUmOJ7zRcVC4iaoAJq0rmGcYBJSjz+qWR62g5X88SuCgsB99q79CW+t?=
 =?us-ascii?Q?TKnHzI0SI+a0C/c90twdlSGL2RUg5Rv7K5jfq32tb9d2+12NHNlF3qLPnkf7?=
 =?us-ascii?Q?gDaR+lnVwIy3WSiNPdCJlucWmhHcSmYiUiUBuo1jir+MmAuKy95ZNwG7e1Pj?=
 =?us-ascii?Q?3YrBy9u2eyXuYQwocPTgZqIaZ7m7Bjkp+akDTeUNHX4YPr8vl6ixIwkxctO2?=
 =?us-ascii?Q?3vfBfjrPeU+hYnpscXzJzuvaPF/DubxGs9+URj46dlTt/cPSRWylrm2U8Y/n?=
 =?us-ascii?Q?EYlPu4MwFpIubtRLiod5tyX9n6xmPq9jE4j3IX405t+9Sbb+zyySkbJXnUz/?=
 =?us-ascii?Q?1WB627npBhrRakHidQZu/JEyYRVvlNL33wibG/xO1g6RwpybiU8t6cGnAhNN?=
 =?us-ascii?Q?k/H4K30OunLmmAM3HkY9lD0Qgf9VAwFoFrimVORYJxEa3gkPLR5NuSSIoS8j?=
 =?us-ascii?Q?vMpYxpSJ1Bjs4FQ5xty4ZMwlzidBaOVysIFCqp4Uc/eMltJ9WR8R/GgU+TZ9?=
 =?us-ascii?Q?i7pKeWDLmqrBj5N1IOqxdt52hBKO3txzqUvGuY5qa1Xd3nKfSG2luy9sJDF8?=
 =?us-ascii?Q?m50bdwnDDgAazsx4QBPZKhBp4EfRrA2LDriXSzLr5LHdVBidd5KWX0+mxTyu?=
 =?us-ascii?Q?MSBWfOrN0btBsrN65eGBZfSHg0gSS2I8uS+AMj4yeTbvvSEW38z3op+9BBEc?=
 =?us-ascii?Q?pqOI0AdKkc0ufAL4TyG6lhpVDeuYrovAlSsVjmOX4JktnqJp2TdH4bjR3bWp?=
 =?us-ascii?Q?mawl2GSUmgZpOObNWwsOAou9ZLA7MxElaQi6IzCoPoWYYsMuQcgCo53cB2wI?=
 =?us-ascii?Q?92qEj2mLJBsWpXQzvZUKU6zcyHy3HewL5z04uFDNiot4Do76HL5yZLRBT2r5?=
 =?us-ascii?Q?a0+ixolXJQAlsQdYiGDr4Nm4wLcP6r0uHbMR3RGT2GVCAM3bGqsgA2OiNaiw?=
 =?us-ascii?Q?m94Z04Lvzg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7618dc-46c1-4836-26cf-08da266804de
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3374.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 03:02:22.9749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUsNgWbqyKoMA1eDrPEt7OxzrRZFZTHt8PZla+/m0T33vcvCzy9K9zkMbEW1Vfr5xAT4fPQpedp0jv5IdSGaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3940
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if and else instead of if(A) and if (!A).

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Change log:
v2:
- add braces to the if block and make pr_info nicer.
---
 kernel/trace/ring_buffer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 05dfc7a12d3d..2860db50413f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6011,10 +6011,9 @@ static __init int test_ringbuffer(void)
 		pr_info("        total events:   %ld\n", total_lost + total_read);
 		pr_info("  recorded len bytes:   %ld\n", total_len);
 		pr_info(" recorded size bytes:   %ld\n", total_size);
-		if (total_lost)
-			pr_info(" With dropped events, record len and size may not match\n"
-				" alloced and written from above\n");
-		if (!total_lost) {
+		if (total_lost) {
+			pr_info(" With dropped events, record len and size may not match alloced and written from above\n");
+		} else {
 			if (RB_WARN_ON(buffer, total_len != total_alloc ||
 				       total_size != total_written))
 				break;
-- 
2.35.1

