Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BF04AB355
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 03:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348760AbiBGCX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 21:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiBGCXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 21:23:54 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300131.outbound.protection.outlook.com [40.107.130.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1063BC061A73
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 18:23:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6tpDkR6r6NkcbLT/Q8chkWbWFj46vIwEOysCPSnki6SGysc9hHoeIwIxA/lhqXXsJxfWJWTt9k8UjfdZU1/+Q5zuiNYv+J/3ySfDCoTKRGjDp3n6O8XHugnbDsZ6gjOAykHybq0F/SE2FC87aMyk93r7YlvN/+Q0HVRS6ckDgbAdQg+MMye4oR7noI+Iimd/K7VQc7jeiKxPNcjUzaQn68NNb9+8q+YY7sL2OQkNZMW6Qpa7P1lD4Tg41rr6VNaNJbMKeEErzRI/UAcV367xYI5nj/Ieyk5BaO1VYSrKnaDP104ewRqaQ+bzztrP663vdEs81LbhCSxBKSbtajZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXF+Yh8jdou4KymQosnDd75noYcoWv/HnhvplGeP7E8=;
 b=HPTgXmBtHir0iRr/tVAdkxnsm1OVvXdV+PLYXYSj51kGkD30CkWFWSAkfn1xSH1WUDsXsZPWFRgyjw7X7zVBM5IfaxloH1Pus0uxIMbLndzWl0mrQH7ouyt90u4YPkdlBjkRIFtulB4ZGcE6k1WpqqI4aXHRkvRGbEabkazE2fMZaNLaOJCALNqo6fRwe4E2yIaBPFxOe/f8PqQxm6Nc9HEoS5r3dIdySMN/N+TFFUzKocJCbFNeNaWeqDtzfd55VuZuV+myN8xbmhu5qFlSGpKCLf5qcN5UdOKwSwHib4TNo9nsIO24rV/+A5CEHY3O2WtjqvWodDI4q35B4DsCiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXF+Yh8jdou4KymQosnDd75noYcoWv/HnhvplGeP7E8=;
 b=aibhBPIFhlWiolgo0nnu5bkszj122dYDbHOjLoP5vw5KNIvis0EnVzBEv1/+AmGHCNXolLWGOzOHSFLCrtAfAP0gMgNiS46ngZDvh3pDDXtrviR2jpUZuletZSzU7vi9r1kTbNP+SnW2ARL+IhkZFswkc4QDaaamGHk/huVIoUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 PSAPR06MB4022.apcprd06.prod.outlook.com (2603:1096:301:3d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Mon, 7 Feb 2022 02:23:47 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d01:7970:71ff:cac3]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d01:7970:71ff:cac3%2]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 02:23:46 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jiabing.wan@qq.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] ARM: footbridge: Remove duplicated include in mach-footbridge
Date:   Mon,  7 Feb 2022 10:23:10 +0800
Message-Id: <20220207022310.2242489-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f43fe8f4-37fc-4aac-939a-08d9e9e0de17
X-MS-TrafficTypeDiagnostic: PSAPR06MB4022:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB4022B4A1983525C302D5FCB0AB2C9@PSAPR06MB4022.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cjDdWrU3cMC+Cczpu5ZDLyX+NmZbn3PpjQ71O8AJmkhBAz8LNF0IBAL+DZIlgIxp+TnnoqYkbo1/xHUJ3ghGqyGtm9iNdg77xfPV2drU1ZcRjr4WYfWlSqqI7/eY2XA1cj11M+iZoAEq/I4mXIelxOQ4BRoIDGWhBWY8PTWfpPjhpza9Jk5UkslENw4o7b563JP47EAggCzfvmL1P3n0CxIqIwmQ/Wt9L9VI2v0oaVg/q8bi7oCOKf4SvLUbHMQ1K01Aagu/+WetIMwJhtxg2kBAr6VJU32qNFF31l4yg+nKjbxft0Ddihnt8ecJXaTRy3TZDBIbG1w36aRJL8yf+C1A+nY4dVXQ1v2WeGitqnjH+mHZSsg8LMYXXEZPameAFZQn5de7KqxNlfvRxojJQAgdD9GTOS67QlCwDCK9o0pk3O1JrTqJZnQYED52eZ78MXHaACognc4aPaLbut8/JXQsz6MFcY/3XPTX394UmY/YUBlAS4oHktDWzqrX5V8X2CI6FY2J19SdEW+l/SNpUIsnteLGtct9Z9okVsTEgoRjKAFE0f7cKybN4K2Ri/oVnMXP6bSNEeWrcpKK4cjpDnK5xb3MO1WhDSDPipH5WVUICnCcIA7SDxv3TQj6ID/WNgi4V+4SiKcMe/UjJqYh1pBvBS/CRCv4ezyCmqkUk2HvSaWa2EbgKaiv/lhoBpfiF6PGhaY080lBxnoP0hs8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(8676002)(5660300002)(186003)(4326008)(1076003)(6486002)(66476007)(66556008)(4744005)(66946007)(2906002)(6512007)(52116002)(6666004)(6506007)(2616005)(86362001)(36756003)(38100700002)(508600001)(316002)(107886003)(38350700002)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bonBm8p97ULSSBcuhNxAKa3Fz3g61ipb1Qd9IGQDJQgffbt8EHuDGfDWXuJs?=
 =?us-ascii?Q?j7n5KeStXdNaUORETvQW30yVom75cDz63rXtjCjVBosOLG+H2hW9Cm8WEhNP?=
 =?us-ascii?Q?BJkbpsgXa9J6buYD/4uGQCZrYEtekFld146V9Tu44IIX37IAUfK4sPyByTRd?=
 =?us-ascii?Q?AObczgQn8+53rbZjrPCDNe6o3w24/SblxXNTgr0uYutM6W6DOcmw368kjgmO?=
 =?us-ascii?Q?vub2xsOPkv+SDNKNsMFrvV2xuR24bPKSHr6OhmUBSN2m+TT0+Vvzs6rRGCOF?=
 =?us-ascii?Q?tHVit2d3V78FB1J2eYs/P07EeEcpaelSk3aVfzkg0ejhZDEx06q7aXoQ5txv?=
 =?us-ascii?Q?cp8QGAusZ87khIjLQdkhEZ8W6O4QNf/qDNT3MWM01D4Bzj82jsheh0+kwNjv?=
 =?us-ascii?Q?Nr2jvisPnIr/eNi0ihplMDmtjIrcsF0sYxr/BVgp+eFYNhYVi8Rd7CYYNYKd?=
 =?us-ascii?Q?JHdf2OxS0NWyiJ9kOCzPPFeYnI0YyWOLrxxNItGaxNKWn5eRPu23qhKqzBUf?=
 =?us-ascii?Q?rNnSmfK8ikfBFGxAOqw1ylKJfpQ5i5Z5pTUVCMtUMJFARaXptWutSPNh4l8/?=
 =?us-ascii?Q?6z8aj3k7EXzUeIiWF3woJrn13OIsgMzGcdbn407Ubn/3Tz8Ir9rRBISCi0PE?=
 =?us-ascii?Q?FVYebukynkHDb7MDbDKWYwsfocgu61JzHTU3boAwRw6ylxMNqxHbKqfzZoRl?=
 =?us-ascii?Q?nd2iSOBWND1wSYckuDfUdRNommGH3MWhdgHEmo9lGk4gPa0Li8BvYXfK7dMH?=
 =?us-ascii?Q?D/7ySTCC0a/5TnZUHIFHmuUP7Zk8LFoy4+fG4VxrzYUI8qLOYJ7GtQiQGjh/?=
 =?us-ascii?Q?vh0rBrStNjB4MkmmeRq15OhuHX7DltBQmgOGjkEfB8KNt6CrfKzratfkunM1?=
 =?us-ascii?Q?1QxBAJCLje1dBN+9Q8AnGxU6cGZu7zZyrheSUuw/cxKtXsy793XiRAXQnNW0?=
 =?us-ascii?Q?FGnC8fXOXBj3/gTgz1rnitezS0XOC/hQbBZMHh7fS1V61O/2wcMOwj8TFBkG?=
 =?us-ascii?Q?dwo8MkoFPN2IcTLNZYeRiCyTeFEv5T+lHRV/1dediIeTZA4v+Sm7lI1D7EFI?=
 =?us-ascii?Q?HYINrlU6/EG+dPmw0FQKLkszM+U/v9gUK3LRhsZjYCqVMrO53T8iLbjQ4X3f?=
 =?us-ascii?Q?bRoLChv2QhkyC/MEBM+al096m6EmVt/QNRigu2AqozSCEcBJZd+FlYW/n04p?=
 =?us-ascii?Q?C+uE0n8aXzsMH5YRiRAYpxu+1wOKUllN1ekbZeWP9XV7gEK3mMICf22afDq1?=
 =?us-ascii?Q?5hTNC+/V/H/mR1d+w8i96sTqG9TDHkOchUsnDWbivlYSjoyl4KvKHDhFRt6Q?=
 =?us-ascii?Q?j8nAWsHlNhv6Vy8Ul40xO0eH7CNE+h2GeR9EguSEpX56nqzIKfV8sR37kW2J?=
 =?us-ascii?Q?dFZF9lmbEWpp183SlOe8R0loGVVVAYw1oSE8Jz1gCvs3aT+qCMYaF3EA6lor?=
 =?us-ascii?Q?0W3nGWSZIPDwjXwFGdl+QO9Orkj0S8OL+KP/cEWPTMda3UPi1oNLwXDvwJ1b?=
 =?us-ascii?Q?vNi0AEW1YOM89uxkEY5EGbjRKvLXgVxIAgjBuYVQA1Xr+FYU1Y7sOh9lGxCP?=
 =?us-ascii?Q?mS/WMYF7l9e8cT379eeWllXDgu8CW2nObmXcudHYH5NY/WgBvF6bs9JO6svh?=
 =?us-ascii?Q?39b7ujqNonAaUJ3Q2Sl61FU=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43fe8f4-37fc-4aac-939a-08d9e9e0de17
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 02:23:46.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWiAUqMtkEwVCmAAZkr8aKC1v7Bgo8rEKu25nN/Ehfxm4XoW0S6Hbraea/+UP35gV8BelFk3qLGwEMPl9LoA6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4022
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following checkincludes.pl warning:
./arch/arm/mach-footbridge/common.c: asm/hardware/dec21285.h is included
more than once.

The include is in line 22. Remove the duplicated here.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/arm/mach-footbridge/common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 322495df271d..627a12332022 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -29,7 +29,6 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <asm/hardware/dec21285.h>
 
 static int dc21285_get_irq(void)
 {
-- 
2.35.1

