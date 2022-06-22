Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2E055491A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355117AbiFVI74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiFVI7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:59:52 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-oln040092064067.outbound.protection.outlook.com [40.92.64.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2705377EB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezPFbhReRsNUt5rQ7GIG+ow36YhMVs0/JnvFZ7G2sSEdWSayPX+QpDxu2HaNVl/mXRqu1TtNIq5mISy9Ug76eCRmSzdyX5J8B2YIzwCXdahS7k+xNPaNFSxVRqh2sRAivebAB/WmU6iPLaHRygVp5tqL0X9k4Lt16/9oO34z9UBa18cQq0Q4/6jHB7DpIfxkkdp2N6tnAo5rmLqyn4k0SAdttbuxnCMkSRXOs66sF9afYLCETCegV5C4WK/i96O89qA8Z/z2k3sEvG3xf8qpgP2skXHE7S/o42tbHBkeQOQ7MtGXTXb6TwLZPzUNhBM+yn0UP+Nlg1pU8LQB7n8ypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlYfWqcehkuCqYfvCl75vzoEqBF58/9Km0uO2ucgjKo=;
 b=jmsLcSBxXLDhyVWzx2uAXVjeZfozCx4DvrhPErYf5EiaZOQrWQBM1S5lPh+Z6cSqwGcXwe5eHz3HvAZ/zlVNTOJfpvHgG1qLH574PUrgrD8PrxNP1pvumZBFHclT64NfbmTa+LZQJIBLCVTEz5zirGq2sSSwFBzOGbZcOB2nfCOEAycSyQAGASPfut0P2AIMoT38M3kMM50x7TavnG2MRyZ85RFLfgQE/mdSWGD0NW4DeFdBW3caxxY60f73kLffBiFbZOJIGe0auCNZCrVg1Fod9Pbhgl9N/wNdnjEgrOc3MliXIqeKsE7CMLMpgq72nZu2IoLYSuhH3hBXSrZoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlYfWqcehkuCqYfvCl75vzoEqBF58/9Km0uO2ucgjKo=;
 b=Ir219wu+8Xa61YlaVeRpH8p9UcO2gg0N5aATNTxbjEIDEBRmn0pwMXuCjMMX1hN3uhkVr7RJMIIx9TspSV7P5FzA4zv7ur6TrQ6FFSxOWGJSjaWK4rD1qJ0OHuJngqM7FoxeRpnVu7JNPPbdmv65PORzmvfO+1PaXRdjhX5XQ+44yPOnGDgV1rnr3teDeFIOseMpzJxyExhJvwwiyXDGnG6FwpedSvVd6R18wSOI/ZRfP51MZZMVpGMZms0I++YmFOIar4tzlf0egfuKjarM/jtbBhAJw1cNINbofXhPaoHanHhfDRzz8zcQPWNWxbTgZyCavAZbagqXUbF4S3GYAg==
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:c2::10)
 by PR3P189MB0876.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 08:59:49 +0000
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d]) by PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 08:59:49 +0000
From:   Saud Farooqui <farooqui_saud@hotmail.com>
To:     maxime@cerno.tech
Cc:     jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, wens@csie.org, daniel@ffwll.ch,
        Saud Farooqui <farooqui_saud@hotmail.com>
Subject: [PATCH v2] drm/sun4i: Return if frontend is not present
Date:   Wed, 22 Jun 2022 13:59:17 +0500
Message-ID: <PA4P189MB1421E93EF5F8E8E00E71B7878BB29@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622075725.y6ws22ielpc4pmxw@houat>
References: <20220622075725.y6ws22ielpc4pmxw@houat>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [9l+gw7X6QKdym1uGwsFiGk723WR1i2JA]
X-ClientProxiedBy: DX1P273CA0030.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:20::17) To PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:c2::10)
X-Microsoft-Original-Message-ID: <20220622085917.52763-1-farooqui_saud@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6449d71b-c352-491b-393c-08da542d8fb6
X-MS-Exchange-SLBlob-MailProps: IABc8NJKQC4fPDSlkTx/2rDQ9dnENRFJ5o1quayWO0E+7QA8S9JkvyPktQSWLRV+NJSVCIaejQ58OrVMcXrqNt6GuOff5Jc5jDB6pnbLOMgk2ZJWQhy8zSKKWl7jh0QKFHVmpwj4zM/kqk8PynUyEerd8YEGLxmHMgOraK+AsZtqkyQTHiZGWer2RLlO2Hc0H4Cy7aAnWw3TLWI91CK8Cad35Yk5jgLZzJFqp57P65Pb5HdMs7TnZ6OKtT2pMkzcmoQUOgmdthPTODqKCOEXaDm+IPdrMRPzJ04wNM7wgn7siz8tfg3wihHXExUaYJ9Oi/EzI5GNjHcnM6lnSyr1UVXUJzN0UUxCf2DTZpyd/YmwyO/9cIxyIIs1Ax0/zLVEhqbWYsOoLOLTwZw/nDYWqCwDg/cYSxtmQtAV5zOHJ5yaUcgtJ2w0PG6BfVG7Dz5/RXcLTJekUcj6NIGzLU1RSaDQmL+qPrKSKUialuNcGyC3xEPi77vTI29Ss9qM++OGkA47icCCSlDoiU72vhLJkQMq7fqVZc9Z+04EmRtoMsy4+LQ5Z/ek9VV+gtRm330+cnryLkKSF+Z/5WGfkzO076TwqkUOVP7o2YI3y771TuHVMsIUCn25Blk8lHYItI0L/n9Y9udB1aMXNKwhfDjtR5Mo6FWxLUlJegWLH+6mSJqlyPY2xMJeqqXl12hAza2/OuOR6AYUiqOSwzgwnafpZV9/Pdbqlm0X
X-MS-TrafficTypeDiagnostic: PR3P189MB0876:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMP2T1ugt6jST5NiCn2+in8OeBLadMYqO2a5IMlIrImdSESFT7RFNgGwgXc8+eekgUpZuiwY1fE/3bi7NMNig7MUr8zmo0iz7SvEJ7HqDS7/culyxxsukONtoMjT0LVGUEqFCkOJnXlivQISuKLt8uOdPKKpjJ1btbqtR8bmSZeh+9MzRN5vH5zYd7tTQnEG5zOcBEL86U7AimBc6bYs8ScAirWbewN3QyLgJlQHzW9ucIakNBNIKnu28lcU9CnKHaIaGpC/6XLL7mtbrv64wVvOx7HGIWrsNkNB/YJUwRdDQ9HIQ5opOXNytVY7DHIF54TpOL6sqc8JIIpQREQxvo1+Ys4EnxJAmvQeThll0n51KUBhJm6qSP1jAPDB4iF1GC1Fw5cMFC4XWR6JksohIG2V1jjZoiGRA2uHk8jSNj3gU/Z5uRd4TgM9SvfCtsufxKJ2DMxjZASEWFPdSHyIuaAjQy8xPQjmQJQslkv2NWW71msA7S4FyEl9YSGvUE+MGVqiWlt0XffzpB7h8HzceJYkRmRlwsQV5poeLywqlAlS5CnC1rwY99T3muCXmcLWX2lAm1Y5AMclUmsUqjcVhDj+BYeG0zXfkA3wTzq3L1z3Ksk8A4qGMqBZv8c06Xg+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tJQlQmQTt8vlU7uXkVH3hMUaLormcWjV+MjeqVAuOu03HrYJsBN00vls2Kt0?=
 =?us-ascii?Q?sfVSeqm6V2/7VnI0Hrdk7fxXBEliZv50L2ufIlqUCgps7QA+a31hrkbXeerK?=
 =?us-ascii?Q?4QpYL9jt0E84KiNUvN0jkL4u7rYvhBYElgSa7R6RJaP9LNNq41t2wJWJmjzS?=
 =?us-ascii?Q?AFBD5r75S3/fNq4XJRvnRV73ppr3rctDI3se0DDBB2xgOM25SMLf9jpkjgIF?=
 =?us-ascii?Q?1p9S+z4m52vQydd/I82YG5i4vq34Qq3r51k/CQqcnIaD7L3Bp97q+5coBsYc?=
 =?us-ascii?Q?DOzI/rQyuy5kA7KwHir6yeP8Qy/0DawqZrBBHld0YhqhCzsqPbmZRv9ovgpW?=
 =?us-ascii?Q?5iPOqFRv4b4H4bD2tHxXjDT9gZTS7hyPsjW5asih+g/0kE22w4H2zfflvMbL?=
 =?us-ascii?Q?ReOMDwonu1FyNRrYoRyLauxAylbU2QwKO0Ef29BVCsVTq5G7cMuKkUdLqUB7?=
 =?us-ascii?Q?NRetF1715j6+YqIUL4GnoBdj4pkdnQIabWH7coMrrWGTUxnbCkmqg+RrAyx9?=
 =?us-ascii?Q?1c7YAufQcyHf9erRsJh138Uqjpzo9ibJWd20dSfo2WhxtzPBwgHn0KsryB3x?=
 =?us-ascii?Q?eyG5fYicCa2KQUscg3aKM9w2EsSSFbmYZqSSDXty4a3J6ftooIeElNrau550?=
 =?us-ascii?Q?L946q4qeh0YnCM2WV7i1v7FqhjoVFBCpeWg0Cspu37cg/lhBrnsBRWpAM5jr?=
 =?us-ascii?Q?IMRcoZw5Gh+I5Am2YFnHamBvAXmDnqrZLiEoaj8l4OTqwjrXSOJop4B6W9iD?=
 =?us-ascii?Q?haq2jgs+JQLFKO28QiGRuGICH3wifob49iz3kGIXzBdJcvv1h6kPD3rZUmdv?=
 =?us-ascii?Q?0Q5+5oNnVoNc4p1oyPohJWLQJxfYARBSmUPKEb4GXoJXdLBLDSSBbOpqG01T?=
 =?us-ascii?Q?8SKAICNH2NDWUoz02/mDBlwnQBSy/nbEZOfs+0h2g/foCbBxi7BGtI0hWszg?=
 =?us-ascii?Q?26jftLiywglOKuTfjonJUhuWTrhVMi1i+f6E9o4dsrFq02U5sKfgxFgyR2jj?=
 =?us-ascii?Q?h8FkhVGqK7rcylTJ1r6LlwGRC8+UGiBcOjvnbsVhcs51wLLhZv6oRuKfvOvk?=
 =?us-ascii?Q?sTD/VbVssZEuVdl22kpDAuhByeWvOB7L9bwZIYmfcKw3zvb8OHP2M7ier4CO?=
 =?us-ascii?Q?Goj635CSKB9hLbAEiYLNzkpXrIxndfcfnxQREWruWYc1qMLqZQ7qxZs+6cqY?=
 =?us-ascii?Q?kNOFHoL2M+N6nZBuJ+AG310l/p6RRqZ0GNY3uQ2tiHtlvOCQ9V4oyraA1Opj?=
 =?us-ascii?Q?shWD+tiU1UmdJrdXFFe1OeKkUdkp7GO0D6bn8AjOGcIhT4R0Wu2D7AiFD3JP?=
 =?us-ascii?Q?eAw/GkGX5hwgLjJu9rsy9fjnBOiDwwCUT4B9+os8dQ1zkWNghrG1HfB/LZqy?=
 =?us-ascii?Q?uDYSQowyeYxT0KwAol2RZ8DD3wca3ee57z/2LQo26jJM0spgU+lXp72fDG5q?=
 =?us-ascii?Q?0nxsMgEUUYM=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6449d71b-c352-491b-393c-08da542d8fb6
X-MS-Exchange-CrossTenant-AuthSource: PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 08:59:49.1454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB0876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added return statement in sun4i_layer_format_mod_supported()
in case frontend is not present.

Signed-off-by: Saud Farooqui <farooqui_saud@hotmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 6d43080791a0..85fb9e800ddf 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -117,7 +117,7 @@ static bool sun4i_layer_format_mod_supported(struct drm_plane *plane,
 	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
 
 	if (IS_ERR_OR_NULL(layer->backend->frontend))
-		sun4i_backend_format_is_supported(format, modifier);
+		return sun4i_backend_format_is_supported(format, modifier);
 
 	return sun4i_backend_format_is_supported(format, modifier) ||
 	       sun4i_frontend_format_is_supported(format, modifier);
-- 
2.25.1

