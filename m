Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF813482D09
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 23:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiABWiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 17:38:50 -0500
Received: from mail-eopbgr130120.outbound.protection.outlook.com ([40.107.13.120]:19015
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230473AbiABWin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 17:38:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyVMISJc3urI7buy82UL5AdtjzgsvubiMPiTCNd5AhvfiIQ1tDuUIEbvpGEp50Wn+57YC3fu1A8OSxi8JDPsX9OLqU/mzfSSmjurrbzahZgwkUgdC77QJ0RGIK+4cjyutyYGk8IXpz7KBZ2T28tr40onKP8kqMXuAg1oYfqvdTxz0FRNxIu/8JR6EdNoLsX0DKJd/sjhJaaxvawUxAg+EnZKlKrDZR6iAjQUK0xvq1tMAY/7I9t7gKeeh8v3ML4eddYGCVQ7xNVxNnyQn36/VAGaklFKpaH/k7YkeKfmf+oWY96CJpvrV6KptHzwLaEQfKynwbF8eJaYb+8/BNAqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWmFlfggdSsPC24plCCXHZpaOLafsL9UzuzgtMxnDBk=;
 b=mFHqxlug2DPegWGaVEXxLxdXRq97kHDWYmoR5ReGeIf4ZMEaQvmmdjfJXO/+tlSZsL5cwSB2GCNx7siAucMvU1WTzwVPUULR33ygWmGCGoPF9jvHkqTzjBEov2Je3KKSAy5ICu4MpPVDPcd01J1TkhyNwPwEDBKenRQZjX93OCWqq3Ru8v7rQa3PTYHATsVQw0qQUeGISJYdElZDnuuAjry7nVXc8NZ4+PuSCvWLuJSwjXmaFaCZgi4gDhYKZPClUpv3aKbchpDFVdManM2ytXGlRoj/GFcyhJwZm/a+g/+ID7o9UNrSW7061YFRNPbO9tajmY/woFSqXk3mzCuR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWmFlfggdSsPC24plCCXHZpaOLafsL9UzuzgtMxnDBk=;
 b=F5TdYhW4xkMCrWkjxzw03vmL7x7LRupHd+rTtrtljsbZ4lRHOYOXPoMd3P9DzM1thsOvfrBE8VZ4o+o7FitT9nhnwBbPWWA7exkhR5df8VwMWJNsRA0M6DZ7unvEX4KZ01arF+2riFwsSczXRguU/IBFUPhGMN7hXO/z07rJ1/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2920.eurprd02.prod.outlook.com (2603:10a6:4:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Sun, 2 Jan
 2022 22:38:38 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4844.016; Sun, 2 Jan 2022
 22:38:38 +0000
Message-ID: <90c40462-9672-949a-14cd-e13e440fe177@axentia.se>
Date:   Sun, 2 Jan 2022 23:38:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: sv-SE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 4/6] mux: add missing mux_state_get
Organization: Axentia Technologies AB
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::14) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4e7e924-bff2-4bad-469b-08d9ce409eae
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2920:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2920A93E6B0F001A9B67BA99BC489@DB6PR0202MB2920.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbjC9HtYmeyS5J9Cn6VGXhpH24oRJzeEDzShE76KHi6NNO7lwEzfzMys7PTa7vmE5xQPdvi4zoR4b0Vr/CNI8QXUdrZxP5goqUXT8GZE504lXwqqLQBvNAvzLFCrPjGfoujImc05g+yI9CbilUjtyjLBaisixO9oLdpRcEgZsgYxh9tXzNJh+BTwjbWjNaUKO0RhcJiiXSYBl6nPSZYaTLkonB9Ym93XLcjO1/LUNvYGAmX36IZJ3tWtydyrAJiLiEEjppzTmCnoi++dCznoe02bsMRugkjAQpHEnNQQyajsFKhbPfKSBZk/s/6y9ElyUsgPm7tvYPc532VOuJXGznf8i2rZT5z+tBmi+nhsCTo6dt+DP3ZLvzCp0BN56GhXrAE7+DtRmsZpt4O03sZqzQIPPQhP7W5tzzcldGpCfvqiBjqLpeC4udSo6YZVuVAXoKvxVyVkdJtYMyrbF8/dFOfyUPb9bBYiT22nt+gJ/00zST3dj9h+QFr/n5D4V++vJBmoKqfHAys1QuHjFPxJ/HsvQQ3mKFusAktXyBRhUnvIvbdqnStGbSsm+O/gT/yvnpdogiPOhYDFQmeDOUrTZ0SyZn+qFfkBu6o6HM/Ehr4HesIJ85d0C2BcuBdnu9h2ZMFqUTuNpt7zXT4AJ8MEi59B0TtfZXMFJt2HD2euCUBjK/ck6RBCxe2kVBoQtqnnAWXULejIYHVdRrcPD2DGFqFRyxe28ZrC7muPxemfMiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(136003)(376002)(396003)(38100700002)(508600001)(4326008)(36916002)(31696002)(54906003)(2906002)(83380400001)(2616005)(66946007)(316002)(5660300002)(8676002)(66476007)(66556008)(6916009)(86362001)(36756003)(6506007)(26005)(6486002)(8936002)(31686004)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkVLT3JxNVIrc0xhYTVQSFdTNEd5OUJKYThFSG9zVVdQSUVIU3VTRHJ3SzRB?=
 =?utf-8?B?MzRFcWlNOWlVVmxCWnZNd2xMTG5zRVJRTjNjbG52eWQvUXFWMUU1UGpPc2VV?=
 =?utf-8?B?Nm1McUYyMUxtTnVJL1ZOYnBScUYxMEc1M2ZIZ01iT1pkLzFkVkxYRXQ0SG1I?=
 =?utf-8?B?UW0rRXVpOHdMNlJmR1l6TkFISXcySkxnWW5ZUW1IZGMyd2RRYlliMHBkU2t0?=
 =?utf-8?B?eHI4S245ZThrbWNqUkZpSkI2OWdsdk1MZmtmWHF3U2dGQUtuZk1taTlZL0hz?=
 =?utf-8?B?Q1ZvWEF6ZENuZjBHMVpRdjd5UEdWaTF2bUVpaE5Scnl6V1B5UE9HT2w3NnVv?=
 =?utf-8?B?bXUwZUd1emNKVzNycnBja2YvZitjK2NlK2RGcDkzYjBBZ0Z1N2ZzVzJZQWR6?=
 =?utf-8?B?akd2TUJZZ05MZFJkaUw4YkNET0xTNFd2VnVpMU5oRGxEd2NEVkoxTjlwOXJI?=
 =?utf-8?B?VTkrVlFtazBKbnBVRjU5aEUxNVNNQUZpWFBtQ2VpbGhNR2FjTmFRK0tER243?=
 =?utf-8?B?S1gybVArMlh3b0NKdi95bmNCa1JVTG5scExZYndzK21paTZjZ3VsUUxHbTZi?=
 =?utf-8?B?K2NDRUh3WUJMRGlSQnYyMTdEc1FtcEtDSFZ6T2FqelZmaFkvb2N0UnFHNkM4?=
 =?utf-8?B?ZmQzMTJXc2hZTFdWM1dkVldkdVFBaFhramJrZCt5eWMxWkRycWZ5Ykd1cDh6?=
 =?utf-8?B?RkczUnlOUVFsN3ROQnhsZUNCM0pnZHJZQ2pVbnB0YnBWQUpDS0pVQzNmYStC?=
 =?utf-8?B?NDBxZmVpYUJyTEZqbE90b25YUk80UFgwRkU3NlVzNjVkUkpoRHBqTXM0cFJS?=
 =?utf-8?B?OERmVWVtMjB5R2UySVZXakVFbTBVb0F5eENGa3RoSkZZdmMxN2JJL3JxT3or?=
 =?utf-8?B?a1hPalJuRDA5VGpUNWxYQ3NlNjNNclZPNllnUEgxNmQ3T201WE9EYXJ6Y2Y5?=
 =?utf-8?B?MVh4RmZ5Q2tJQjhyMnh3TXRwTko3T3dPdlZXbVJrdDVtcUliSWNsVjRyL1Vj?=
 =?utf-8?B?dHdjTmFvb3FBQmhER2REQ1lhdmNnVTlicWE5WmdWU241cmZBWjFuVWFLa2Ra?=
 =?utf-8?B?cnZBMzlQZUhVdDN4NjhtelNwSVpKQzFEcFlBeTd0WEpaczJNMFNtaGhzS0FE?=
 =?utf-8?B?S21tZHVDa1p0QnFLUWZTckVKRy81TlVwMUp1S1N0ejNOWTNGSDFpNE5kUU1U?=
 =?utf-8?B?QmpLdHFHcUdBL3VWb1NSekpFaVdWbHN1ME9Nelp1Um5lejROODlYR2Evb2VL?=
 =?utf-8?B?M1VicWZrTWtYREFPNlcwbHRrc2NhY3FNMnNPdCtNNUMraEk4cU0zUzdJNFZW?=
 =?utf-8?B?bHNsMlB2MkNYNGxVdDM2SjAzVnhvZHlXT3BNMmE0eFdSek5BN09pYnk4ZE1o?=
 =?utf-8?B?aDhFMHZFMkxnQU9qWmhHWnFKd0cvM0FqbWVoOE9MaklLSUVOcldXZ2VvSk9u?=
 =?utf-8?B?WENKbXFnR2VNUFNYNUVtQXhVU3h2bTFsQ0l1azhlUllXRlFUbGR2WWExeUcr?=
 =?utf-8?B?a20rTk1oTUpBdUkxNjkxNW9lNkEzZXRYUEVWdzdBZUYwWk1YdENVc0JpQnRi?=
 =?utf-8?B?dVUwa2FUeVlaSklNUmVRRk5zZ3pNNmRyUnNRTzl4c1lYMkd5UmVyczA2QUFK?=
 =?utf-8?B?KzZocThLZFBzYU1HS2R1SUMzWXFUcWx2RUVTVlVlQTgxTzVGSWVvTG1TdFBC?=
 =?utf-8?B?U2FTeU9BVG9JRFZYbXhDb2MxdnhLbURobzBhK0tRV2I5aEgxRldub0N5Y2hn?=
 =?utf-8?B?ZmpmUW1MVTRYWDB4WW5TTlhIZERScTQ1MzByNmZDTkhrOWZlSVlMMFJ4K1pF?=
 =?utf-8?B?dTdiam5pU3ROczc5TXhsRVl6djl1QkYvWkZZYkZ6cGl6QXh1ZmpBdTF0dGlH?=
 =?utf-8?B?cjAxU1M1aGxCQ0w4MnRGaU0yMDFiRUI3U05JQUFSN2NXMGhPLzRNdWo1eVZ5?=
 =?utf-8?B?cGU4LzNOd2JqQVFNdHY5WWpNNEZqV3g2TFlocE11RDB6MThndkZaK2o1MXMr?=
 =?utf-8?B?ZS8zczVqT3FzeDVVSU5jVTJESEtVVm5CcEJ6eTFhOGcyWUo2WXhCQUZVdWlN?=
 =?utf-8?B?aExTdUZLZ0tMcmxQY3daVnA2SHpVVW80bVg0ckx3ays0UTFNTVVoODIycCtK?=
 =?utf-8?Q?w5iQ=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e7e924-bff2-4bad-469b-08d9ce409eae
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2022 22:38:38.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcuD5NgVfjcX3XdnfDA2Ipt55Y9iqtKIE6MP0LsG/bZMLgkU1v3RDWKRi3g7vbfB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2920
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

And implement devm_mux_state_get in terms of the new function.

Tested-by: Aswath Govindraju <a-govindraju@ti.com>
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


