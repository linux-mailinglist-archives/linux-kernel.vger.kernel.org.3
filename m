Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD15347425C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhLNMTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:19:44 -0500
Received: from mail-psaapc01on2093.outbound.protection.outlook.com ([40.107.255.93]:5889
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231913AbhLNMTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:19:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brCWsudig0gH9rFRb/1zu4BRpYTHJY+3SHYLOHrr7DJgphn2OVNN9bi2OXQFN2BtiXiUmTrQ1Uc56XoOnC6kJtZ50T7q6KoCw5T04i6+yXlM0EprPuFJ0rWNjcECwzbdFm4qM2EQabwckXe5PxBQeLgRjoFVEzSKHXkuVtyg1s+4DtCK1X7BGl8A0HA7oUaEQVuU6QsokK5yFBAYgLJJDlpq2q6n7WM+BVu9ywUjuMxQHBPEd3OdvaT+7Anb7rzSNMNWjL7FM8z3TykorIujStsCLZKONWsoVDSZx8yf/+WEnl6C29M6EEz5WARfTzMwpR00Nf0JGogODiwNmTV9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/xj35ZS6/Z7xPK/D46ijQNXjsdSGYkft53sLOn/gSE=;
 b=ICPAiXDvX2TgxoTGiNhWE6mMudwjjwb4fnKa8urSTyfAb45v9AsNRlFMjqMK/yEziV4lY+BhjEsfYJxOtCmmHITaF/aRqEEaww1hKXGiaelF0Q2ydRNjsuh4QqM/hPdQNpuKTqH3VJDBTSVpXDbNpKeN6Jdx6r5YC14NyAA4EANQD6gkRV6JmMh1tMJW+C6BKTx0s6DYouQG7jwGB0+adeXPdz/px0dcogfKkHMo1jzt31nAVYBL3b3yEJxNjK3ask/e47ay/REt7hFr1fuRjbbGXdSdzEW/5hXYk384J5zI23MaNu4MZYCxo0aSZObp2b9+tCParo04rt4zs7nduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/xj35ZS6/Z7xPK/D46ijQNXjsdSGYkft53sLOn/gSE=;
 b=FQw2jZg/+jmxr3TWRjbHagm+CeGXK0F0mecFz2/qZi7kTKXIv7V3TSdIYSbvOqfFehnIXFf876Tuj9GW1wlIJWiNwSE975zAI6Vzy4uGStlp6J3FYV0AhBA24q1rKDKHuSPHr92rB2ZUtj3zo4R4DeZlyrzRqr1Yry8ybFfLKuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3084.apcprd06.prod.outlook.com (2603:1096:100:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 12:19:40 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 12:19:40 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] coccinelle: adjust the confidence of fen.cocci
Date:   Tue, 14 Dec 2021 04:19:33 -0800
Message-Id: <1639484373-76061-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0058.apcprd04.prod.outlook.com
 (2603:1096:202:14::26) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51a6a985-6bdc-4910-8cb0-08d9befc00aa
X-MS-TrafficTypeDiagnostic: SL2PR06MB3084:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB30846B95A7231F513454E9C9BD759@SL2PR06MB3084.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZFTdHDPGwyY9EFn0VOo2YIdMESZqTS9H9mZIS2E8oZZGNb6Fozw7EJt3NxOt3BTn7yb5a0NKHL1OQDG77Ptqx9MCPij5GOO9jvjOyrwnAMIW5XDvmoGzkO3ffJHLBuqCnMowuZa6noVND5wYgJKcfVO7V3oXm+6xka91d9mMGShi+Rk6xr8pRIukoU9GEj1QT7bqmyv5NllVFP10fhLMNQiGT1o9f0SjEyV7VdrL5GnMgj+VVEXE/9RpWHn5zASZ+qD5/1+Hf3BYfhZqGxs3ndVOiNMiY/QbQrarNZq/RisLE1ha8ggqGDUbXg2nS4KHQTbckt+lMbOUeP6oPi+U8ojDXpAd9KY8UZuagsstU2PlRP6a4fWEIOVCoveQEJ0KZ6AdF9JZ4SkQ9MMk5uVc3qc4fxSLGMmUQOAtgterAVvFpZ4SmBxpi3Sw5KWib7D9Lkn7oS6P1x1+ODWoVbKaRRkja9JPfCeq1ayVa/aoy1Dkm6+4hYd4CDH9HRLOh5h69lfRzK960xgknCimQderzGQafhtnurXJtrhPsQ5adV77/E/eezGu/tTXnYV8ir7hCh/gNLuDxamR9w1dRI1XKBprQY4n83EyezfISw/QMGQt0EEEkeFFPfXLNdtB306tYLySqm240MKgEESEv68HN8SK4/bFCndlBeKW4AyOPuO7ZrYBdWM+lOQXADbnPBG5BmjyhU1DGymNTwOdXREwKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(107886003)(4326008)(316002)(186003)(6666004)(8936002)(2616005)(66946007)(66556008)(66476007)(6486002)(83380400001)(26005)(508600001)(5660300002)(6512007)(86362001)(4744005)(52116002)(36756003)(6506007)(38350700002)(38100700002)(110136005)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ax8qgcc93pJ8npx/adDGXz8utuVsIZHOTL2zBHSYslvkw1MiVZgDugpWyO5f?=
 =?us-ascii?Q?2D/6QMXDJvGuog+DQy5CgEz9dUwv3fyE0SGg4yFxbF7nb1phVikjUMILoPrv?=
 =?us-ascii?Q?qVR2Wjcq7jFe+s9SPn+YvR4SzMisOE2b1aGsPn6ty2o0a2jaZM0f4wBfkwtq?=
 =?us-ascii?Q?rPWtT4wCT0E575mnkbjpAsa3w3yRQGsQQUcxB+ETBehaIb3I+yXCowJoAAam?=
 =?us-ascii?Q?Gbpx6ved+U3+a5hv57nx+nF+LuedC+caAJt5oEvfRjVE5viW54cR5ZJnjO14?=
 =?us-ascii?Q?Dc8CupumIrlGdiqzvCmRt3kCqOgyy4828tmbABY2HxsA7UtfV6IeIEmeP6zy?=
 =?us-ascii?Q?4A6Zc+DiH9uUXosdBt0utMUvx96zQwyrY37OVCSz5VQRf2ewuKlxObofmmWF?=
 =?us-ascii?Q?TikP6Q23xjJ8Y6i8cfYKzA3BAssUoC9lxB9Y3d6r8aeVXo/hj2EVFS5ilS0l?=
 =?us-ascii?Q?WJdFLwMpDvYR1NIQJdoNR0X+EuEn9N7zGw4t0rY4emleGh/vsJN+E6Cz+jNl?=
 =?us-ascii?Q?eUNQqZdNjP3iwgL4bOHZlnnXmtnq3zR98thVFVmgWXFJIBqwaVMPHcEx5Mu2?=
 =?us-ascii?Q?BgH0OA5XAdQXtdr+upmIe5lT6+eoO/bmJZDw+bNfy678Rv6B6+Kw2YLRgrp8?=
 =?us-ascii?Q?1XPu/Ri2l3eUQWH3jVdMVG6Om58Wn7GL812/vxB9Bz0GCvt++SZAIVvNxXQ0?=
 =?us-ascii?Q?i3R1Je2JV3Wcr+eFYYBQqs9HfOUwAQqaJ6u/v1woIeuUBUyJF35WSWlq4Ndy?=
 =?us-ascii?Q?nmLYCcwaF31BwNFWYAzQyWGm7kyFZQirtVW0KWTAOLUwd+P8VoKz9Lf1jIBu?=
 =?us-ascii?Q?ageI8jSDC/G/thFmao0UzxuO/Z//3h2UHkFT+aT3w7pmyzElRnIkKvTH8tHD?=
 =?us-ascii?Q?tD8kgsKvmokaMpxjp8/ZbshkTSS6CjDZmBhbzPDzmc7GIp3XWD4yIKjfL9gZ?=
 =?us-ascii?Q?5pLBTYE+lMmrxW1xOkZ5yo4Ax6wTwv21w0SR5/cYZMdH1kcmv+03O8gbE1ho?=
 =?us-ascii?Q?gQf5nhMPzMfclWG5OtXg9IcIDmRaVUt52aQmHjhgRPP/qPyK8z2lHFuIreEt?=
 =?us-ascii?Q?GRcxcxNMQOkhYTg7FutBQOEbyDnHMOjsF8Vn4o2E7cJTFDSyujWRDOU4+hyU?=
 =?us-ascii?Q?lPJRP3k+6in+6LNlyXU3pAVrbcy88PDxReT5AZ9gb4LSfY8c50K8T3Fv8tS6?=
 =?us-ascii?Q?OgGhjqf5Fu7eNixPYd4O9LrIsD0jD2BCuUdkavrLHOlLwWSzCrxITnRFzb0l?=
 =?us-ascii?Q?AHnglSboBNUCKphx1/odWKAFS/a/r04CJJ9/33psiSDgElctA+52Q8c2kIKy?=
 =?us-ascii?Q?+a5c3hs6SOo3YqODJH2yF4NY1pE2Cuocd8DQ6Fa6U1wl+9zDswrMkWMDOKBI?=
 =?us-ascii?Q?XVHn90ksd3vE4eVDzDo5Sw0FKhsLRkoBR17NHHo1uFqAPh/GFkO/bScX0tkM?=
 =?us-ascii?Q?wJiRZ/C4POk1SZruN8DlgiYNi13F4rC5bGTIUbbBT0e8CCT90qP9p1aryqMF?=
 =?us-ascii?Q?IYKEizWFHJffjMtbt1iNvGwgACCDybb3tTmStbjxb1PMzaEz/Wqudo8SXb0Q?=
 =?us-ascii?Q?V31bgs5voJ4iBcFqT2ozabwO7508o0DotIdSAGOFrb/jDLe5MRHa+9q5DDSG?=
 =?us-ascii?Q?NelqNW+Bl2kLpwb36kvC4Wg=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a6a985-6bdc-4910-8cb0-08d9befc00aa
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:19:40.4077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dKJd+3tfiySZI9yM1sVPFViU/y36os2YcKEmIJGUyMLcCQFAz9MzGcKzHvOyi1aWC0a6YTBXASUAJisO0EJ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

We scan by coccinelle according to the confidence value, then check for 
potential problems. But the accuracy of this cocci is very low,
the scan results are all wrong.

So, lower its confidence to low.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 scripts/coccinelle/iterators/fen.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/iterators/fen.cocci b/scripts/coccinelle/iterators/fen.cocci
index b69f966..7b71207
--- a/scripts/coccinelle/iterators/fen.cocci
+++ b/scripts/coccinelle/iterators/fen.cocci
@@ -2,7 +2,7 @@
 /// These iterators only exit normally when the loop cursor is NULL, so there
 /// is no point to call of_node_put on the final value.
 ///
-// Confidence: High
+// Confidence: Low
 // Copyright: (C) 2010-2012 Nicolas Palix.
 // Copyright: (C) 2010-2012 Julia Lawall, INRIA/LIP6.
 // Copyright: (C) 2010-2012 Gilles Muller, INRIA/LiP6.
-- 
2.7.4

