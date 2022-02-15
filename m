Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473964B6095
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiBOB77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:59:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiBOB6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:58:19 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A59109A70;
        Mon, 14 Feb 2022 17:57:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVfjWBmQtKQJXl7TOSOAQCSssQSbdTSGuaZMsEfZwscG/ggHtlB/qkq2QUObB5Tdqfhu9jUrFSezPeLyr5CIH4ejzqjDdzoJ7IPFvHPm1RlJU+VjY0vApmRCjhOkMRsoASCIN5sHzpE13SoRCyC8hYPZ3vniHDw7NtRVv2Bq4+sfBYXfl4E8akiJkE8R9tQBUzgylVraeTURPoP1EAbkWU3GbkKLyTCYMhA+NhqMNzbc8YZ7LpdtMRrTyRJMmDW8z8deJCUa5NKJ0RSFTJZl0PJaQWU5vA3DjEV6x0KhT9GGXgaXa+yIcECg2143IGdbTZDjaMVEe/ma5T4Z3GcOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh/qI8QopXtn0x+RwYHfuUdkWJEd+DGxXAMqbqRKSsk=;
 b=ZJlB3hMmRH/H1LqXpnZjVVsc8ekv+ZClRMM+YYx8M0r6B4CeXN73RXZpEJ3m2aNobfLC2zF+66q363wqjZS+m40+wvnLROP0pYm5aI29VtVQ/GX6WbvRslJjBxTPP686z+EaVIKCLvdI6yaFwg4l+o1fW0tMIvrOTvKvUevNObT6xHV+/k5ea42OHgpmslKIItGDdWpDMzy2D9sDRpL70w6x8mK29L3NUIIqTyJ09HVHACppVzZ7nYEWkG3P2Hh6xfx4g4R7o+CZDiZIn44hk+Z7rq0e/d19yd+yaNU1HdKkSOX+JIgSDs16taZOaNLS2paLHFkucJijD+yYp3rYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh/qI8QopXtn0x+RwYHfuUdkWJEd+DGxXAMqbqRKSsk=;
 b=LiA+yX7iNHLdsveP+SxrimHpe5Z+1AodD/9sOSKnvY7U1OBsmFCNsZiOPnixArG1P1o1nrqWrjFXi3PZhth9XxTm8Qku+0cCSHMyjSKQbXNQAmPNF9BbxePqOqsV1lYNFquZj7jSZ3w19mDqlDZJYnTfRbd3ztjGpJbBC48jzHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by HK0PR06MB2771.apcprd06.prod.outlook.com (2603:1096:203:58::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 01:56:59 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 01:56:59 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH V3 10/13] media: stv0299: use time_is_before_jiffies() instead of open coding it
Date:   Mon, 14 Feb 2022 17:55:47 -0800
Message-Id: <1644890154-64915-11-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644890154-64915-1-git-send-email-wangqing@vivo.com>
References: <1644890154-64915-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34b35900-c3a8-4b8c-3d01-08d9f02673c5
X-MS-TrafficTypeDiagnostic: HK0PR06MB2771:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB2771ECC9B5E197E44E6691A1BD349@HK0PR06MB2771.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/1ZKpi0U80UNY1LFIrHjKtGH7NFlMoGYEVe7u7lBBCiRn4454SvlfYCgUjw9ICl4Grrh/m8sk+Yvb/J18L2ZrsqbCrnmVyrt0wyzY3GX2FDBbycOy39yxJx4pDHii94IQp4nKMnFsxrKXSrWBvNJYCfbf8ZAxbcgqPusg48djQCQubUul5+/5qQnUPk3P44c7Oyv76uXRMhzWQcWSukl1pKe/udgcvghS7Ux5T5qrObwE6T4XkLbW0XwbE53UQrlf/96+REHPYdER0c/v7crnxhGubS7HwzV3bIia1djM3keDiv1gY4B7KFLsPERvH+vlAkyerspKTCf/Goc18u9bpcA38hBRA/E6pwLloxidpPSzpwjSWPVOlmuiTmETxZ6tg+QGNXIWJ/hdBDglS2TL/i2CKR0lSp88r966/7Ys0LZRhARrSQJDMN5D2ow0NSSz8fIxfZmIagRTJkZXeB09XBR9a5En9uyfJaWyMoRO4XSaaAG2B8XbNl71TaWfZCewz0w1KWssjzgLrxJi7qzzUUoSE4XsplLg3/uYSGTHcz0hwSbDw6Z8Xxo/M44l1h2+vA7KjItXld/jy6Kh0YeTAwAvwCvKQMV+z318Kisqp/iUZb46TdA3A0xtdt3clpdWvG2VpZv7QFAhsdXQApVRLihg4w9b+s/7+QUfmpOEyBy6KfyY5YMMSRBIOZouwOYctgLcok8PVdtfRhmsA/PH5dGz++Geze1+5WQDhSNto=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(8936002)(83380400001)(26005)(186003)(6486002)(508600001)(107886003)(5660300002)(2906002)(7416002)(7406005)(921005)(110136005)(316002)(66476007)(8676002)(36756003)(66946007)(4326008)(66556008)(6506007)(6512007)(52116002)(86362001)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JegvUsNVsaXfcZGlbG8Z7mFCnaU7BQ0BsQylFhFuPqaCXKuVghWUmQPSpxsm?=
 =?us-ascii?Q?CRMKukZ/tzUkTKR+dUozO3hMTTv/LuohDFWwWqvN9HR67qBmOAf7dcTzOTaS?=
 =?us-ascii?Q?OBLFRuQ2cgq7cWeP+rG+IyzSQzARrRq9VsgJmVkkHnA1pD/peagLLZSJbccz?=
 =?us-ascii?Q?xNpUn0PIZltTzqroWhcxDzUEi907QFlR0X05/ouP6QWrLsxKvqFcebqBg2yB?=
 =?us-ascii?Q?ACvaOIEdyD7SA3eh380RnwDYFICe+aGDIuTb9t66ct1JJ9AiLTKSAgr3docn?=
 =?us-ascii?Q?8UdsgrRnMgbl+m/gKQV+MAcPMrCaWql/GAqzw3Vy0yJ1qxVUeC0AT5Ee6K2Y?=
 =?us-ascii?Q?I7QaOR3pYZFSU/2Cj114eekfStRWwlqt1t+VxkEiOEdq7yyvLzfBRe4/oTXq?=
 =?us-ascii?Q?nJ5f9IvvSPuBSwb7bxYN3LJGfJg1KCPrhYZ0S1lWxFZJ+yVeBsXWb7wJ7Vx/?=
 =?us-ascii?Q?LmcWSjban4FlmShR57hVbt75C7/KqFS1nbM5/RjYsbHzrDr/GRZDxUMTgthb?=
 =?us-ascii?Q?7EGpYU7ykr58OYsBQH+ouiTUJQlWNa6YT452eIN13Ndc4S+krHAR013u5EgQ?=
 =?us-ascii?Q?eG63S4WXiMaRBCjwrrQS5iUH7rsYYQsuz/bdJARU4O5cGu2LAlsbJ0beju01?=
 =?us-ascii?Q?6ZcLgvM6dL/2kd9Y5KAG/iGQhJZtw7jx1Kdm9T3g61fzjAbqUGx6pF/yJOcx?=
 =?us-ascii?Q?psCLql7cyZddIAh/vpJgnI8VZHsvaKUsJlzLk+aOkNSjFlUKMp9layqtVv6j?=
 =?us-ascii?Q?q4hjaNr+HaCSe1uq0osa6TFtiSNcDfdwyhJwoXaPgohHYkIFSiB8OO/nfoGt?=
 =?us-ascii?Q?bX1vyOJj9q3VXXnJCCcwuhPMpI5MQkPR3sjci6vxgLIdTOhAZhuByV1bDM6v?=
 =?us-ascii?Q?kP8qzxvTthWrRL7UMbXx4zUv0zgg0F1vey1iZh08imuEvj1rpVgzAiuC7KXX?=
 =?us-ascii?Q?NTJOvlI2jQpzKa9t/42FIx6FDj3Eg2mlFZ7r/LCxd5PA98p465KlVzwmkgFF?=
 =?us-ascii?Q?6/6EYOAvMIJCxeC154EBsG3SrLUvOtcUNXRRsWNxAqqUJk0JdvnP3AW51fzE?=
 =?us-ascii?Q?O2xfumQKf+Tl0ruOsYWm0c4rtx0fW6+//PpWp7ku6mkIBPCysF/Pkzz3Wlqz?=
 =?us-ascii?Q?BHWjaUXiNSiXiXAtcWKZrkuyOf3QNPsUH9EXtIdRy9OPlaKELuVpnYUGg7J5?=
 =?us-ascii?Q?+fHY8T0KpHvdAaHOhosNcyhNkxMiXN7J6mOtKm1uWBkRWJ3EKmSJ0l7djgKf?=
 =?us-ascii?Q?IeEDbGBmBfy+irCmr6wPVCdxvKMN+aYomWsUm+fopiIpdRU/OQPPAqGty5nS?=
 =?us-ascii?Q?VyJ4vytvKLA0euM8aVgV2W9v5R48PIK+L7nCagEo8Nitnzc2tYDG5Q7PgCjc?=
 =?us-ascii?Q?2nMKGasOVGgi6Ny3jQTSX+8qD9OBLW3ElCrKpru3KV5yJ1zikAaqmw8j9m3j?=
 =?us-ascii?Q?AMPwAItRX1dM9EEbk+5ksn/1OzqaxzjL9Jh0Dqeak0n0ghhQnSa29NhZf6Kt?=
 =?us-ascii?Q?6rlq4ATiqiHJYQlDB4g/nT8f331psS6xKiiLE6IUwyRvvUfHuJt0lHBE/o4K?=
 =?us-ascii?Q?e6gcuask47AEJ8Y219txFb4sNiIpTQCy75vf573mpTyIjCBYup089lC/EKH7?=
 =?us-ascii?Q?rw3ewQFdDfehBjZc3myYxRI=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b35900-c3a8-4b8c-3d01-08d9f02673c5
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 01:56:59.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JrLm+M6mSEBLFYeLGu3LqaQ+wmgbyZRt1lWiKI+vI4p/tuj4r8sAEpelBecCUckxJ7lzICMVuprAbVV8Nj7Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2771
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Use the helper function time_is_{before,after}_jiffies() to improve
code readability.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/media/dvb-frontends/stv0299.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/stv0299.c b/drivers/media/dvb-frontends/stv0299.c
index 421395e..867ae04
--- a/drivers/media/dvb-frontends/stv0299.c
+++ b/drivers/media/dvb-frontends/stv0299.c
@@ -183,7 +183,7 @@ static int stv0299_wait_diseqc_fifo (struct stv0299_state* state, int timeout)
 	dprintk ("%s\n", __func__);
 
 	while (stv0299_readreg(state, 0x0a) & 1) {
-		if (jiffies - start > timeout) {
+		if (time_is_before_jiffies(start + timeout)) {
 			dprintk ("%s: timeout!!\n", __func__);
 			return -ETIMEDOUT;
 		}
@@ -200,7 +200,7 @@ static int stv0299_wait_diseqc_idle (struct stv0299_state* state, int timeout)
 	dprintk ("%s\n", __func__);
 
 	while ((stv0299_readreg(state, 0x0a) & 3) != 2 ) {
-		if (jiffies - start > timeout) {
+		if (time_is_before_jiffies(start + timeout)) {
 			dprintk ("%s: timeout!!\n", __func__);
 			return -ETIMEDOUT;
 		}
-- 
2.7.4

