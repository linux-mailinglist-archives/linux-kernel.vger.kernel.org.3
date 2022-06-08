Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BC0543BAB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiFHSnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiFHSnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:43:49 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075058.outbound.protection.outlook.com [40.92.75.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150D9E0E6;
        Wed,  8 Jun 2022 11:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIgeot4+P7v2mT4tlmIQ2gIbGiPm6o0dV83aG62R3Li9kJCovLE/yAjTwpQtL6EEHTkcJRx76lt14qsQsnbJYXYZDKy3wiEvc0dqEGYuH9B3gAc6zgDMepQOPGq/5anP+8E2sKHY4dZocwvtaUHI+NOuCoYaV9MpSpordXT40Pq7mNRStAYugup5DNSlUaIY+M2c+vpRkTKhtZwGXa63GK2kzseojbM7adFHrtGw5dBzX7id9Bcz4O5dqmBxwcI9rYdFCwbugaIpr72geJwJ/nfaQj0/cUWLwgZZ5L7tbj/YfJA5lFJNLg30s/j+TMFuN6fO0WmAQAzGPVKxJ0CTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7JAE+B++g2m1t/hEsrU0PKrjxQTP1bkBrPtc/imOfA=;
 b=njh9UDlxo7EXiAXrVkHXSC4Vm1DxrgRl1+JV/Fmyjb9vvv5ZAi4eKuJy/XCahScE0+jC8OFIS8psqPBE96Gk6UBgKkSNSNKCxFgIfaxL+llXjEq8vsLnvvyetP9YlIxl8a53Nqv078PzViBCpA6Kj8/WzXhfWjs86b7fVwfEeYRGO6BngLRtcpnG0va69u4MQjJWPJ7a6ZCh/Fauw3MKKMFa+RBuoT5NJpcaPLgoKYI6OUxFhSS53Xw3TbMwcd7aElvIkJ2QM9MTJb8QLDH6KxOF35av8wTU3rsS8NjxRSX/xwQLtGNTQAyhhjeBnGvKc6QFHv0LU9aCg4JwB5lMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7JAE+B++g2m1t/hEsrU0PKrjxQTP1bkBrPtc/imOfA=;
 b=DGO7goa84vnhZL4dNLr1X3JI3wIAvRhpFra9V7+cc8+IoaTVegMbnwV/1hVZX/qtAD0d9prjjO4sB9lZh9P62+2Di/CX01S/GxG+4Re/DHqzPGTj8k13y+FtSmDCMATjsrLE6kZ8+Jx7fyYu+zd6P+Dtfo3EVv/yvt+kX7ArkCBvHbDszf04lxNY1z1q94zJxfD3SGHozj3nNkwIqpO8xWL5oTrsopybBaX/EoNKaqK9ASh3xPR7GOAyuzZJgj6KhDjTj3mt6o3FmVxAlmvgZgBU7b3xNnhSgT2DucXDmOK293doslPNRxt+j6yQTz6P9t6XjRKn5/gn6vS/XlgeIQ==
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:c2::10)
 by DB6P18901MB0070.EURP189.PROD.OUTLOOK.COM (2603:10a6:4:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Wed, 8 Jun
 2022 18:43:45 +0000
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d]) by PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d%5]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 18:43:45 +0000
From:   Saud Farooqui <farooqui_saud@hotmail.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saud Farooqui <farooqui_saud@hotmail.com>
Subject: [PATCH] rpmsg: strcpy is not safe, use strncpy
Date:   Wed,  8 Jun 2022 23:43:30 +0500
Message-ID: <PA4P189MB1421005C22E46EBD708EBA798BA49@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [3NLd1mCZwQ5M7HsdUBgK4az245lqAQgF]
X-ClientProxiedBy: DX2P273CA0023.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:8::35) To PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:c2::10)
X-Microsoft-Original-Message-ID: <20220608184330.1142959-1-farooqui_saud@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32ca8aad-0e8d-4800-eec5-08da497ed165
X-MS-Exchange-SLBlob-MailProps: 6H6McBavlAiqBMfLsegtj+nEWaF0sBfds/w2qooSRAKNBmwYprkBEuf55DEbFcvyPnD3QznlVVu8BNTT2ejjQaPu/aEdf8NgGUnNzT+PNkHRZi/O23vqTHZvW1VOLMqMegxeDbMtEtO9IlYCc5txBv5uhlwFlllmmioElpY93g1YOEZcBlYlS/pIo9ZYj5HirOnOsmeMVd0EeF5/DGlUOKAnGzFvO2iM2YonEHyDRBO0h8RJj+cgL5FsrrUFjv3D7fVsdiIiG96Fm+5w4QSLw1JaiAFRO3BdMOBgwL61czictZzwgze7R/MNC0DPBJVGasjxgmi8ZIDGseGVqD0LEJC5q8lDSzSKJQQhbGbrCGWbkuuUYYYEDQ0PBS3JCT+wP2/Bq7Ez+qq6tkxqDVpurmPZOGopDSfTK4XkX8xXhPo0ra227+Oe/cBSv1bN1Ndi+1Pkf3fBIcBhw5ry6xvP7poWeijN5x76ZU9uJ6JRiJQqtfZknG+eMX1Yb9gk5gZ5+4VtKRSaAojzAu1rXblnnyhI6ACvu4sduASAUmQKLsGDzQOmq/XR291WP0pjV7VT43/UJyrPg7fWzXRq+Ven2M7chqxRYPlh65JO1B6toZjpFX5H4UMkOnVPo0I5C+RJR5BkYZtAfrB+K5ytup812rrcgG8135Zk2wdqzxsK3T94o3T9qFqfWNnl+BrKVnRomLPOwhILc5yfv1iNhKf1zPhYDHmJfPe5Whi8H58EuO2XSKW7OW/Xk2eqb7ziARfjxqcFvy8CT4w=
X-MS-TrafficTypeDiagnostic: DB6P18901MB0070:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SrTyNKQPIkHE4MMK6ijmSEnmt6wX1nAYv72qEXsbKYzx5ZffwL0Fe+6+D7UTzx0FpYoBPz5ypjxY1ghEOBRvNyLCSFwZkkLjj0PMfbjcbRQEmec5ZV6wTbcyGsJdHsD3Gwu6WErsicZmpnajlMq7r3r0ErjW/H8mZlGYs392B72JoqL1XcoXs4DUqaWoKjp3XrS29nc5FOulOaVCyV0K7ml4vSOlw3n+mOQvLrmRN1HwjfwUrGjfAXk1bSXB9yw0Anei6fuUKmWUbaU1DEhIrJyyNR5PGYDD1cwxSrp4XvCLhe+GXvBTvEqPRzgrg2glHYKef9ycM64q+Tja3lW98vEYzdlFCyAfDC6o+AEshCFDtXgVYKMccKl3bOFlBCgK7MTvWwpYVUi6AshR+DczVh+cVmLBwNUiaXshAIJFSs7gU8c47apMpXCZTjHNjVG8ALKgtkaaf1Tv4GKMMn+mW+KEotWolBYHepgKEqDMF6ZIaQEQZ50UOLOPv6FbsvO3JhBVEhv5Mm7JD6gSk/Dqcb1+feq2SejEW4hhcJe7V696bLwvvpHhc4ro6ayCzfKKHA9ZxQYvG0kBX5pXQb4fUg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rZ1uEqV/SHvlpfoddV3S5bk6XAGyDDd7uuZqWVU2n1kl+ZhudlacLI/o+jwF?=
 =?us-ascii?Q?Q5YogmGgdWfquc6r0OenJOj+9KzwrNSGb2D1VKU2toFWx71VHapOODXIETtZ?=
 =?us-ascii?Q?0f0gEcJQK//WK1w5Whf2shtxxBQIcfkYNnWIgC+4TClGFpImxImFhkLpu0Ec?=
 =?us-ascii?Q?qn4J/hjD/A6P51TcOZVe1HDpDSGLC5njvMKkS5C6VSHRpOxshLzbfUq0hg8J?=
 =?us-ascii?Q?qsAngfQDb3G/qlkifyMdYkZFZMlrcbBlcdv+/X2DkhbMv//5YUtoMAoIovqY?=
 =?us-ascii?Q?xHt/W9QnPFDo054B+DrBljnsWBF3fQpLWUhfwtpqgs8OsgL70h9LYCckCLaL?=
 =?us-ascii?Q?VqFApK4wNkewkKSZINvzic0h6mkvzxAgLsMN3Urs96AG5DqejpTvNVgKfFoI?=
 =?us-ascii?Q?6ec8/pN3z/pc6P6lBevLX8U2+CIGs4vNEuBvxyCPfsMZCYApJnelDEZuBwZb?=
 =?us-ascii?Q?ZbK7zBqQ9KJOPX/B6gI2xnp6nCgGP+HQ8CmpVk9nhUOBWv+hB7SxPODOvwBP?=
 =?us-ascii?Q?y9WMCPAKwDLgTre6t4VIL1cD2JudWHKLysUmN6EYyMoyrCf3Rrn6jRTF+Yzt?=
 =?us-ascii?Q?8YhDISbVcECBJOyfg2c7+6PmDaly1Zbgaf4SBNaBUxF0U4FnVQwaEHfkDYwM?=
 =?us-ascii?Q?yLJ+p6plZR4Zxm8jE0KhuWV1Wa9yAqtubBTDaN9zC9qA3lOm2q3/jlmdXO2G?=
 =?us-ascii?Q?U9z2m+ai9tAs0IEHlJz0E3OWleb9hytIpdDhUzniPIKNqb8/+NWGUsfzLe8J?=
 =?us-ascii?Q?jDTqKjSOgHxsOKmD3dVScXxA0FEJSP2GSO5YHBp3iY0Fj4cAXHx+Gn076no0?=
 =?us-ascii?Q?QMvo5E6TuwNSiSZqBfgnmXc6ZSZYuRCgI2cdlyL44mkJb21q2VCTN7QfmM/B?=
 =?us-ascii?Q?E410qhVzitHXwjWUoclp8vwBvqe9HMqp9ckqseu8c5QZD58E6m57EB2jSWbR?=
 =?us-ascii?Q?+T96AEzL23N+fB8VKIhiFYI652V5H3MWbeQiIe4mGCz1DcGOoryY2sfMpNxf?=
 =?us-ascii?Q?YPDvlk/ENxgndG/q19ftFbKN9+p1KyzcwuQ60C6r+zINQwmE7LWtTJBa12lS?=
 =?us-ascii?Q?AZxXDF7Zv90WmgA7L+qvIeisvu7jYVMDLdQU17ojh3pvdbWULK9v2bOHjiZr?=
 =?us-ascii?Q?tFQkBDWjKVrxKL0NSOmXmBFIQh8ryWPEzbkWrtO9d3CAVd7+0iShs473Z+OQ?=
 =?us-ascii?Q?dE7GEOnN10ZuYCB14IQ8z3TFmZ4Kx+uDxsYtrRlksKt2w9DjV1JJgIO5TNuR?=
 =?us-ascii?Q?wlHEZK0dkPQeBEOO8kMFQhB/eZ1h4sWEUSI1wZEZqdVr3S76+wOquS2zNtq+?=
 =?us-ascii?Q?dwPhZkRmPPo9RVJuhzKqeO2gnQaJqMo9Xumx8hkKl6sIfWd4UxfXfZk3683v?=
 =?us-ascii?Q?mrrc63vEpqxzCufUhrFOf2O6eFyX4f6lGStI3sTqKelp3lmaS9ukbeond/mF?=
 =?us-ascii?Q?eQl/lYzpP/4=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ca8aad-0e8d-4800-eec5-08da497ed165
X-MS-Exchange-CrossTenant-AuthSource: PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 18:43:45.7921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6P18901MB0070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace strcpy with strncpy for copying the rpmsg
device name in rpmsg_register_device_override

Signed-off-by: Saud Farooqui <farooqui_saud@hotmail.com>
---
 drivers/rpmsg/rpmsg_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 290c1f02da10..d3b29c19715d 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -604,7 +604,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
 	int ret;
 
 	if (driver_override)
-		strcpy(rpdev->id.name, driver_override);
+		strncpy(rpdev->id.name, driver_override, sizeof(rpdev->id.name));
 
 	dev_set_name(dev, "%s.%s.%d.%d", dev_name(dev->parent),
 		     rpdev->id.name, rpdev->src, rpdev->dst);
-- 
2.25.1

