Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0827F479C13
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhLRShm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:37:42 -0500
Received: from mail-eopbgr80102.outbound.protection.outlook.com ([40.107.8.102]:3888
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232110AbhLRShl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:37:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDK6x1pLCMNIgfRoDFf921MnlCNoTSP1k/jq+wx5i8VCcKZl7j3qeqyms3a1pJ4JTHAWjQQYlCxzsFoHocJgoQXCeRa6VnYkEqUleUNqzcPYZCtwzwNPhUjt2AXfFO3XJXLv69GLByol4QscvJ34QiWo4Sqx1KA6R58LsnnWz5uK2mIpFUJDK83lytNWSyqXc833RspivsNLetxQtNKk2ZH5aUW2SNlRNY21WAyjt1l/6gBwjETlafgXpn31yC9e2AJ3FLVFTWmnN+GbcHLKyeYqgdMatjHnfYH0bu8pj9RYVUdZbTHZhBL/xuoYKz2ydpqABJrRABz+FbxUJ+JzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRxlKkLRsU5qQH9pq/ZwEeZSHIxZ6R1bjkqp/FGCG+g=;
 b=Blrud0TgFFmuyltFhWcKRyBnK/k5LEZIyojF1YqWxWDqYL8ueHDQ5j5rLEW3ZqLfc+xRWqXNzjB2cLPXgzhopqegmsOWn9mikGwsMafec7mPz29KqvbWIznVQ8Fj+bZQZt6G1c1jnZ0OrmBFdfnHGA3kkoeCRUORpytwnlNQTvlW7JECwv2YAlcVvGFI6QrshewiP+e2sVgTuDbMfA1ZE7Wa7n7i5WRPA90jrlYS6b2kFQ5YIR90X0Qsl+Z0BrnDwctoH0hw3J99UqNTWK7oUvp1ooOLrlbtSuCFPBdrIEicsXhvK3+Q1Bw5mqCp3PjFADS0u7/g6zgxWlNUi66bmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRxlKkLRsU5qQH9pq/ZwEeZSHIxZ6R1bjkqp/FGCG+g=;
 b=GQroX8IzScZvIIZNO1/BeHquWIhbBOSpUEw8c8hEng/3XaHMscp58kFp7GlCGjvmEa/FPxr3DOuz6EYgPqFP/nDeoReKatPhYFyws/hyrY5KXXW9FH6n6spuKwL3vYUnQjhb5dis73nXz6zsvQnlJUBJLkbjIA5TnlSTKy+R244=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4789.eurprd02.prod.outlook.com (2603:10a6:10:28::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sat, 18 Dec
 2021 18:37:39 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4801.019; Sat, 18 Dec 2021
 18:37:39 +0000
Message-ID: <031e134d-dbe3-0f39-3e63-647d0efa1576@axentia.se>
Date:   Sat, 18 Dec 2021 19:37:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: [PATCH] mux: add missing mux_state_get
Content-Language: sv-SE
From:   Peter Rosin <peda@axentia.se>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20211202124053.2835-1-a-govindraju@ti.com>
 <59c57ab7-a272-b925-befc-79f88c925e3c@axentia.se>
 <af642da8-a9e1-6d3a-a928-8a514f1c5eb0@axentia.se>
 <773b9424-a1c7-1955-886c-de36299a6873@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <773b9424-a1c7-1955-886c-de36299a6873@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P189CA0035.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::48)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e7acb44-335b-483e-8c02-08d9c255781d
X-MS-TrafficTypeDiagnostic: DB7PR02MB4789:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB4789221829B2884475A74DA6BC799@DB7PR02MB4789.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xIhSNKzEC7Lp2vjkTS4GVtL4s1gZwA1NXVfQsO3tmDaCG2lIQE2uJBpszO0te9s98u9YNNWtoTwH85ebBDHKFIvpJAcgJnfjgt9IfIw5Y6cqJ29T9LTgPu4B/Tm8RROSc4b9Se1J+z1EkyvwEOgq2lPeaU9a2a0TvlXsNq0RIuWFkWRo8QcQfI0EVuFApQUW0bRyOlk4qQBZnw4FoZpF+H5yG+3NBsF6ANboQUCAkI44+MfBTwqA4cEV1KjwP3SUvAxc8Ys2lrkEdhv2W7C3N0ujJXsgp9qwwbPlyDnkJgn34J5BLUQZCL5z7KEexLnu4I0EISfYG2UpEHf4o7d7F3b7H4JUyF3aDsIlcOwztk852ncLcSNycZRKb6X8z20hwNtRH7vR+Y/wDnVD0oucX8hMoN2gA5DEiklkICIjRt1XDsVBLV64r6IqpJbLJ+WJG2SlvlTLHRFm3tJ/1SPNQdjZXe7adFhx17mEnMKhPYRt4XsboZPo8Rg26WutJjw9JzYqVJ1ag8RAq1SmOh9/A3TFFsQEhA2WqWoWhGQcaGQB6yS/XBQf3Tva6aPf61LcKd18lRI7FTrrBbqkiHGAYqeS1yrZnly688Cj0YqM/Jj2y+V753efES8t9ijDiV/bHYa9IgweDhHY1Fev9D4eCWE9GpFJaZiJqIg12aj4MbxcmvkproNQE8tp9VFh6oyoaqpUYQKesR/IDudUjg7hQfceBh11hRJtWE5+sf+Lb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39830400003)(346002)(376002)(38100700002)(6916009)(316002)(4326008)(508600001)(31686004)(6512007)(36916002)(31696002)(186003)(2616005)(6666004)(8676002)(54906003)(83380400001)(2906002)(66556008)(8936002)(26005)(66946007)(66476007)(86362001)(5660300002)(6506007)(6486002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCtoZG92ZGgxYXl6WDI3NXVjSVR1bVQ1b2NVYnp2MEVEMjQxVWx1WDF0alk4?=
 =?utf-8?B?V0twcG9JYXZTc0xVTlpoS1NxMHBUVHdoOE92bEIvL1BGS3Q3QXRudXVoOXYw?=
 =?utf-8?B?b3dNb0liT0p1M1BqMnUxbXdOV25Ob05Tak9qK2Z1dFRwbHlJRmJiRy9BSk1n?=
 =?utf-8?B?aFkvVWJ2NWZ5djNYU0xqN2VOY3AwZDVsYUlLQ28yclRKYi84c3VOOXc5bXBT?=
 =?utf-8?B?V2xOZzlBSkxBVkVxZWJ0ZG9kcmhONTg3Um9QYmx4anF3Y0hYRld4cWtVRVNZ?=
 =?utf-8?B?eWozaWxLME4rbzQwZ3BUbENFVDd5K2JCZmZ3dmZvWWxOVzBWbnJ1ZHFwYVVo?=
 =?utf-8?B?Rm5TcEd2dCtXdjlLN2tOL0hhS1RRZEVTZUNkSUIxR1hxSHRUMHRIYThUdXlW?=
 =?utf-8?B?UEthVko0STVPb0JLMm5JVE16U0lxSTlqbXY2R0d1emRyaTZKZHpodEdsZHg2?=
 =?utf-8?B?RUtMcmJ6dWxJRWZVencwN3daeGtVcDZOQjF1M0Z3bjgrSUpwVW1tcFhUT1lz?=
 =?utf-8?B?M1k2R2RnazlmejZCRFovdERNSGd2bWRncjJNRnVVajhOcStXZVRBZFNTby9I?=
 =?utf-8?B?OHdINkJTUTFjMWVPK0tHOGFFVzV6R1pKc2dTNTU2MnNaMThtS1dja0JyWjhK?=
 =?utf-8?B?bjlQVWlacDVZTTlqcXlCMXNHd0NyenRRYWE0c2RyNlVIcURtNmVyTit2SkJ6?=
 =?utf-8?B?eFVrd2ZMV2JlUFhwTStRa2VJVytaSllhMWZ0TjVpM3lkM2ZUbW5hOHkxZDVS?=
 =?utf-8?B?djIxOStNVGlZekJwL3Qwdmpyd0tJYk1sU3c3clVuUjhDemlib2dWNzM4dCtn?=
 =?utf-8?B?SkMrc2ptcjlIeWIwSG1SRXd0MEJUdDVNQ0FIZFhKQ3RYYmhOTExPT3RhbS90?=
 =?utf-8?B?d25FSWdUak5QdVZqZis3bitrTUF1aExvbHVFTXJycGJNb3M5UkgxL2IwMTZ5?=
 =?utf-8?B?Uzg0NXlRMjNyVFpIYjJwRkdrZ3EyN2N5UXJINVJRc2pQZXA1WTZqTDJVa1dF?=
 =?utf-8?B?aFU0a0RydmpMZ2hDRjJBV1FFaVNxOUhGMFp6Z2hnTS8vZGZ1eC9kMnUrWC81?=
 =?utf-8?B?ZHdSOWxWNktDdnhZYmxCYi9HR2xCV0cvZ1ZxZy9rSHppMklYSjVhdTlUU1Bs?=
 =?utf-8?B?eHdLbWdabmhLN0Y4L29oYnRYYzR5eVdCSEZuU3FIc1g1NCt5V3FiWkluTlhu?=
 =?utf-8?B?cHZvUlMxVHNGTUR6N3BmYzY0RnFab3gzMDJYVnRRYnU3MEtGQ0haNURoaHI3?=
 =?utf-8?B?bm1hR1N0amhJRVk4QzZqRHdxRTNtdkZ2QnE1UGJhdEtJaSt2eStHdTBCYit2?=
 =?utf-8?B?a3FBdUVRbVBzbitqVEpUMUtNL2F2TkYrNVhSdW9MUUdJQ0dqQVNGMU1VU1ox?=
 =?utf-8?B?Y0ZUUCt2bU9zeXhvcGJlOXdUam4yRE1WamRoYXUrTmg0T2txVmg3OXVHT0pp?=
 =?utf-8?B?dzdQS25YT25ZWkZRMU94eHlybzlVRndQZC9rWlFUL2tJOW85TThWMms1c0gz?=
 =?utf-8?B?SzJyT2I4WTBLYkxGSTVMb08zTXQvMVdKcWpWVUYvSTBObXBhd0xiK3RBbTRz?=
 =?utf-8?B?K1ZuZ210RFVzbUNDbjdPMU9CMFFtRWc1S3BQZXhXd2J4VTZWMmdScnhJRXVO?=
 =?utf-8?B?RTdmLytOMVN4M3VJOHZ0VzMwOHFlZEJtK1BaVFZObzZHUnpMV00wOWc4OWNG?=
 =?utf-8?B?YmhMRTJFMG9meGVoZmo2WVlxWUk0SmEvOTFPOGRxU2cwMnY0V3hTdGlDci9j?=
 =?utf-8?B?akdKTllBa0NUZVI0U0tNQWdyQ1hYVG00K1NZalNyVHlrYUZrNmRBVUtJTEF3?=
 =?utf-8?B?d25vdlRrSS9IVEloQlBLL3c2aFpOZjNvdEN4azMyY1JobDJWM2I4bmRoRW5P?=
 =?utf-8?B?eFR3bXU0bmJjbG9yUE94VlZzdldadHVLdnZ3bDlXV01lRGp3aWZ5dDZmY3F0?=
 =?utf-8?B?TmJoZEk0cGlteEhpRkhVZTdWRExmbXJjaDRkUzdtSlU2bUg2RXAxSVdmNkt3?=
 =?utf-8?B?NUZKTGJ1VUszL2ZZRC9wbEdrOW0waksvcjJZZXM4ZWMvSGxySk13bXZyKzhP?=
 =?utf-8?B?bk5rQjJUa0RwZ1pjem5wNWwxc2lsQWhzVlhqZmgxT0E4VWt0cnR1akpCc0dM?=
 =?utf-8?Q?w9qg=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7acb44-335b-483e-8c02-08d9c255781d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2021 18:37:39.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yg+OdwgOfNdHM55Z4Fuewu6wCaqiYaESqd5IArsTa0ZfnByLSbFLi8QQtNDp2me
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4789
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And implement devm_mux_state_get in terms of the new function.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/core.c           | 41 ++++++++++++++++++++++++++----------
 include/linux/mux/consumer.h |  1 +
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 7d38e7c0c02e..90073ce01539 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -673,6 +673,33 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_mux_control_get);
 
+/**
+ * mux_state_get() - Get the mux-state for a device.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
+ */
+struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
+{
+	struct mux_state *mstate;
+
+	mstate = kzalloc(sizeof(*mstate), GFP_KERNEL);
+	if (!mstate)
+		return ERR_PTR(-ENOMEM);
+
+	mstate->mux = mux_get(dev, mux_name, &mstate->state);
+	if (IS_ERR(mstate->mux)) {
+		int err = PTR_ERR(mstate->mux);
+
+		kfree(mstate);
+		return ERR_PTR(err);
+	}
+
+	return mstate;
+}
+EXPORT_SYMBOL_GPL(mux_state_get);
+
 /**
  * mux_state_put() - Put away the mux-state for good.
  * @mstate: The mux-state to put away.
@@ -705,25 +732,17 @@ struct mux_state *devm_mux_state_get(struct device *dev,
 				     const char *mux_name)
 {
 	struct mux_state **ptr, *mstate;
-	struct mux_control *mux_ctrl;
-	int state;
-
-	mstate = devm_kzalloc(dev, sizeof(struct mux_state), GFP_KERNEL);
-	if (!mstate)
-		return ERR_PTR(-ENOMEM);
 
 	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	mux_ctrl = mux_get(dev, mux_name, &state);
-	if (IS_ERR(mux_ctrl)) {
+	mstate = mux_state_get(dev, mux_name);
+	if (IS_ERR(mstate)) {
 		devres_free(ptr);
-		return (struct mux_state *)mux_ctrl;
+		return mstate;
 	}
 
-	mstate->mux = mux_ctrl;
-	mstate->state = state;
 	*ptr = mstate;
 	devres_add(dev, ptr);
 
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index babf2a744056..944678604549 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -54,6 +54,7 @@ int mux_control_deselect(struct mux_control *mux);
 int mux_state_deselect(struct mux_state *mstate);
 
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
+struct mux_state *mux_state_get(struct device *dev, const char *mux_name);
 void mux_control_put(struct mux_control *mux);
 void mux_state_put(struct mux_state *mstate);
 
-- 
2.20.1


