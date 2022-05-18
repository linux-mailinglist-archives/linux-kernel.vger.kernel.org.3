Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C2852B9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbiERMJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbiERMJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:09:14 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2332E9C5;
        Wed, 18 May 2022 05:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AH1aHo6KvlxGW3BrRbGXBCZ6Ul0cHO1g431cVNwUyMpI7h5yef81xp5hBLKILMREaJFvaPUhY3YLSy0qBxxaeBUSqtrFtJodXEwwuby8o7zZlaJVTu6bCJBWpirMyL8RHaoqcowLvSJUxyZqk+IssmuB/wGBUX+S3QuNSawCRgvKlHRmPkD5M/Nc9WEIw491W7E1+hxIPmkQnITiRhByONg8CT4a21fE5CEL37ZRQp533zJu5mlm/8G/DdLNNA0aTrEaA+HAHr906hAcb0R8bXGqaJeh2jK6IQYJCOJ7FWYVVew+KIFQG7rYj3CBb+f+6UcEDfnfoWTZZHySKYjNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTqE/2fnE7c6PaHnN/iy+mRqfso4q1FNVM0fKEq+dK4=;
 b=Av79Qu3lo+ylrfs9qzCUQBqojIuEKD2VT+NxkW9jA+pAY0NKbPt8U4dQqiDn9uXVFjgWuUzYBf8Yi/kFeDp+R8fMWK/49Hs6XoikkDpX8xeKGqpFsCesSfN5WwkmnV9xQzskU4mYrxmAiTdu2roNBI0GkDctZ84M3LROJJPhBvjpBsZqmfIMN4hywMflDMoOJphCi4KBu4+1wy87Dw1pKmtEKYnJJeL2AiKbtJpwKFknwF8+Eb0pl9xAjHOZmu+qQrY5hhmhWxfQtQDZFMc3/5U1i0L1IQ97oJHlG1okE1fdqd+p+cMdcA4DkUGMyJsU6xEg0HKbbli/6UIB4Ce30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTqE/2fnE7c6PaHnN/iy+mRqfso4q1FNVM0fKEq+dK4=;
 b=XnPAlyYZWU133oqd1+Z+67poYX3S7Mztm/GJ0W3OYmD+qadcmIvM6njWVIIl3uCmO7LEfX/PEdl7hPL045Ygc9Kzhl0jkLPe0jPW5JcJK+vSE+w00ib8eSPCRDU6z1+5QfC5ypZcOwDBhzV3/wT7Un0+TOWPrFj32fKJdTbZTEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by TYZPR06MB4352.apcprd06.prod.outlook.com (2603:1096:400:8a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 12:09:08 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 12:09:08 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S5P
        SERIES JPEG CODEC SUPPORT),
        linux-media@vger.kernel.org (open list:ARM/SAMSUNG S5P SERIES JPEG
        CODEC SUPPORT), linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH v2] media: platform: samsung: s5p-jpeg: replace ternary operator with max()
Date:   Wed, 18 May 2022 20:08:36 +0800
Message-Id: <20220518120836.126368-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1761ab1a-68ce-4946-24d4-8f4f9575e735@xs4all.nl>
References: <1761ab1a-68ce-4946-24d4-8f4f9575e735@xs4all.nl>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0227.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::23) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3337e54-5f6f-43f9-1c9a-08da38c7359d
X-MS-TrafficTypeDiagnostic: TYZPR06MB4352:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB43521C137BA5D3DC4E1AAAC2C7D19@TYZPR06MB4352.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJ89OQnEgR2eEoP9p5d057lgI3yETDBO6MuQg7CZ4G3gBoxuSTfH7HqeJLXTKXiV3cHaC0Un16JEnTuA0N+gCUVvQkrRGF71frVwrYyB9KyVymZnjpkHFeabvNRHqvA3M3swZ73VfXL2hr3tvJbqQjR7DqwcA1/HzfE5jkq/Qc8Uz4uJgBJosVmcXCWkWjXR7meaGEMu8l4xq4EJzMIDpz8IGdDH4/q0OoDAVwfXO99CyrLEfAQj+CVTjoJu1QZwGPQsgd/I95uZ+FkiPr8SGBW+pLvH/taLX4OsUx8TKwQNrAU5+D1Hfd+VFZjlH8s/tUt/GxrNVSnraTefLXkGqxVlCqHhJl0pWkhLqC3gqG+yHa1kh1JU0gZk0oycZhm1+XNPIjQxYHJGiGybXDGSt4HInAwt2mslSv4cK+SaDjyaYRGEAPzQL+aq7Wu15+vNLs0suIxTvBCcDymS5FsJ3JHtq1gzClBiWuTcO1s/gAijuGFGbIcr7V/PYTpU/t/T9nCjplSGIX8YR16dnQ03LtPq9IfJYGcrM5f9hUuHnumT1rHIra0gR/jo7wxdOWiPLbdvxgamQ2ynM4tBGRwmnyWBLR7e8xl1KMKt3FrVgfAfdvAiSj2C/Np+ClBGCNcNk2HYKxHLSOq80GuBdNyHNJA7lnVkVN07HuJmBtAPTrDsnzokSS8p+DZ7KEm4uIkPNt+y9SsjDRKv/JPv6WHZ0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2906002)(5660300002)(36756003)(110136005)(83380400001)(107886003)(52116002)(1076003)(86362001)(186003)(66946007)(2616005)(38350700002)(38100700002)(8936002)(8676002)(4326008)(6512007)(66556008)(66476007)(6506007)(6486002)(6666004)(26005)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s9OO6kcsHFl0EyFSW6SirXp/cAC/nEbIjlHcm9mSuJqkNhsxpLTs++DQCyB2?=
 =?us-ascii?Q?dUm3FhrXWmaEJxhou7TjeHhzTUHNe0/GB8aXOg9gik9NrpcPCzY+FqqsFF2y?=
 =?us-ascii?Q?g5yOjl7l0NOtnYN6szMrP+wnqJzT2E/87fvJ/q7xVTg20utSQwTEDPCNy/Wt?=
 =?us-ascii?Q?agm+3ctpr9PKDoIkRwnGTuOKoIXrczU5LYLUocV5pt9O9/b/sHlvGmRnaqxj?=
 =?us-ascii?Q?/ICtFFBPR7TZHRBI+c7GB2jUffLUxtl+nLGC/iDN19g+GkQ+11P0LucuZ656?=
 =?us-ascii?Q?ZU7VJGFOz5pGcjph1QDIASlJkcDmQJzB3JUW2hh3zjoE70HnjdduQyncgNKU?=
 =?us-ascii?Q?Dzhihx3wQ0+G3hWSb7Os4ZXu5YXhFpTndFeyqwQEE3ya5m6OSABa9Qvh8I0M?=
 =?us-ascii?Q?QQkkkxZ3pWM4pN7n52f2vCtTEXWXEV5Kd6gSdX7rdr/E6DF3omCkFgOz5eGp?=
 =?us-ascii?Q?BpFb31zWWE7nJXK0kqH2Rolk0YYNDVjAX84C8dZJ3eKs9ABTk7QBZlh0Pl3x?=
 =?us-ascii?Q?wTLR8NxTJQ2ilDXMWC9k2w7EmK3NeosLAeYzga2R6ZVCfHbb7bijBhKx821T?=
 =?us-ascii?Q?Ny+vrHFy+D/9MPRVVdO2xJfM4iVmnGnswAZI5nLdMIZntV/sNYMBVcutfV8K?=
 =?us-ascii?Q?NytIoUeoJoE366lHd8qb6wjgktjB+dxw6R7HbYaVsOi2Oz0K5ftNuFBPuthY?=
 =?us-ascii?Q?XT1jWXkYaAtbTYMPe+jMbCk2LRc4eY5uI2LGcsXYjUFkoPiSc14skrQgjpa0?=
 =?us-ascii?Q?aUA3fcB3sT5eYNiWSfSzxPaqt6SnTv5JlEzEuDAHeL6ccSr1tXJFcABIgjk3?=
 =?us-ascii?Q?tw5nX3r6BXcYVVHke9sRoiIe2Io5pXlsbc9SFlLGewo3coVFFex0JP6Jetx9?=
 =?us-ascii?Q?DXyMvN8QE4lguDlvWtt2wDTwSVyd11aDhmwenGuqKUxUyUb4tLtaJVQtt3F2?=
 =?us-ascii?Q?R9w4+db6MVf+YdGFjh/bxknuAd9nlbWlVLv5fCaZ4AB6rzsyl7/O0P6YYFVr?=
 =?us-ascii?Q?48LgoV0A9piia0rR7OthE66BCyWoIS0IbyPC9z4FEQsjIerzpmn/GEhpE5t+?=
 =?us-ascii?Q?U/FCYvDiVkxgOmeSoKwxHoyAs3sQzVSeaxwEWnTQsKfYoYqZrCgRnZYbo3pI?=
 =?us-ascii?Q?yF0e26bD0d4TEW2uP5DvlKVNgGycW1JxM+4Fe/CQ8v2pT9mplKhTqn5vOA0L?=
 =?us-ascii?Q?2oekIsY/qUUz9NQFbR8hqguBaWYlq5qxRvJEyonAWUwkeWD//e9hI6c2OPAM?=
 =?us-ascii?Q?5dguxt4uc9lSvNtIDSzJf+M5wPZHX93tTuGH9BgdSu1rmmkzOKfCL9WORzep?=
 =?us-ascii?Q?/aesCqS4GM0XP0guDhMKWKL2jdoU4vSSTJl/YmCYmnRsv0dCJeOwcrA9/2pR?=
 =?us-ascii?Q?X4EPbuizNQFLQY9sdpsusgxY5uR5Bb2BaQcYR/mcH5Hv1SgAIWpCCbneGG4O?=
 =?us-ascii?Q?2koJSRy7uuybGoDuTI2w4pdH6BARr0vAuw/wEjt5fO7oG/cxACBO1kYNPphw?=
 =?us-ascii?Q?zgJDOa9AOpHhh2yqHhQ+He3ieNX4fyicYqZIigr9FyrKwIykRj106hQO5QOt?=
 =?us-ascii?Q?lUMngRwAQnTUv/hAQIEJMak1p9m6AVAOykRF8/BOxXfgRH5LFnUquk8DDt2T?=
 =?us-ascii?Q?Uy1a2wpLMkbJtLpGgpfbwuelM9cQ5NZsov/YfwetOYRpGwKcFNbVfEealIss?=
 =?us-ascii?Q?OnZy+Ogvl/Hsn75ElxJSlm7gkDuV/72vbKLAU3tfZTgFlZyPnC37oBESe6IS?=
 =?us-ascii?Q?mn8HAJ58tQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3337e54-5f6f-43f9-1c9a-08da38c7359d
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 12:09:07.9388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNrLNFBoGa/LKCpc+BO8wA7gDQDUHXwRlUrcQ77Jjcv2BNtDNMmSm7yi6hGkbIRtINXHQe5pdvztHfAm9isX9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4352
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:1712:24-25:
WARNING opportunity for max()

max() macro is defined in include/linux/minmax.h. It avoids multiple
evaluations of the arguments when non-constant and performs strict
type-checking.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
v1 -> v2: Change the subject according to Hans Verkuil's suggestion.

 drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
index 456287186ad8..55814041b8d8 100644
--- a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
@@ -1709,7 +1709,7 @@ static int exynos3250_jpeg_try_downscale(struct s5p_jpeg_ctx *ctx,
 	w_ratio = ctx->out_q.w / r->width;
 	h_ratio = ctx->out_q.h / r->height;
 
-	scale_factor = w_ratio > h_ratio ? w_ratio : h_ratio;
+	scale_factor = max(w_ratio, h_ratio);
 	scale_factor = clamp_val(scale_factor, 1, 8);
 
 	/* Align scale ratio to the nearest power of 2 */
-- 
2.20.1

