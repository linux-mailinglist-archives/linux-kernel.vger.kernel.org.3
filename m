Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21BC53FA78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbiFGJzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbiFGJwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:52:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2088.outbound.protection.outlook.com [40.92.89.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CE7E77E5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLwYTqHWpNJs4ojHzT95lvL0kuc/w9Kq1Y0EJJcHiU14xYd6WfBJqmrCFhYK8hwHI8MDwAjK5Xb3+dt9eROaDjkz2IquA/Ue05gyBojKP9X3Gw/TPKKAdjM/DoZMnfx2BhEIvb+nPYCPETOHJYfgKLuVzyOq4zYHqPdaAG7t2MEoAn4MCcXCqjE3QDQ5FeNbUSOxtqj95AL0fdBaL1wkDF0xO7MsmBCx2LbDBDTIeUkTs5afVZppQpX/ty59pU9MHGLNt9Fi8x2PS/lRvv6UQGEcje9CohK6WwFpx8Oz+HzWIZtBd4CnFj9WnAaSU2mIGAv6X/1d5ULPFdOEPEcDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5qMDCwkWUgNVmMOCpyRappYHFqM9JD7NbBNpzvFLVI=;
 b=cXyOKfbgX4Kx3B8rgbr7poHmdNMPeaAgcB+ev9ZWwWnTGp90GFNK9nvuSAQdzp+0udLR2Dmfd1AQyEJs9luR77lXVygHdzpHUNncxFGMFrbc02dXgWOQuzfWD6OPJGw+D74pGrN93Kt6tmvK94XuKoqgGM68QJ1JeXWBCp6JXug7Fqo60R86Id/TzVrj5KQ8aw+vEaGqVWoifaDtRCTioYJTuzuCLoRrm0cBHK1Rjz6QBdUozYt/I9iIzMGyb3P/N+HuxG2RAhCvLvnY+X9TfOZhoNvm8On4FKMus8b7fFPwf73CUspSxgFZ+0ThLANwnOBo4Z8/tZ+lrt8YL2uOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5qMDCwkWUgNVmMOCpyRappYHFqM9JD7NbBNpzvFLVI=;
 b=jZSuQNt04T2RVEUS1qkdrH/KAHq+Ut5g1d5MfnRk15b7zZ3VnFSC06WnA7EpfXEf9WbmnlkydUEsJ5nW74VnUtKQ7apl5E9Xpj8Cnlke0236Eg9cp5jdC2jtB92nIFOI50XXPt4Fwl1z0S1GWCnQOnRXQjBMVW7wAXLxzr+0EWnHwLECJGJqD4A3CfREfnTiOJKSPBJHhcoFukT5cEbzXyslCdYiQPlBvf06BYuh1J6yw/vEtNquhQkYB525HIQ+GM3TJb5zNaMpa+TY1XC6C2Qh9SLN49NBs09zzWXL2cDiZrTOifcRLvMx947Dnws/9p4Cvc4tMYIIrrv6+8InJw==
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:c2::10)
 by PAXP189MB1878.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:283::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 09:52:03 +0000
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d]) by PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 09:52:03 +0000
From:   Saud Farooqui <farooqui_saud@hotmail.com>
To:     jernej.skrabec@gmail.com, maxime@cerno.tech, samuel@sholland.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, wens@csie.org, daniel@ffwll.ch
Cc:     Saud Farooqui <farooqui_saud@hotmail.com>
Subject: [PATCH] drm/sun4i: Add return statement in sun4i_layer_format_mod_supported Add a missing return after the IS_ERR_OR_NULL() check in sun4i_layer_format_mod_supported()
Date:   Tue,  7 Jun 2022 14:51:50 +0500
Message-ID: <PA4P189MB142180104916392C559B44308BA59@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [JnhlPj6BsCw7ttc1tmkj39KlWaUVH3zK]
X-ClientProxiedBy: DX1P273CA0019.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:20::6) To PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:c2::10)
X-Microsoft-Original-Message-ID: <20220607095150.86798-1-farooqui_saud@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eec91e6-d0f6-45ef-17de-08da486b5fc7
X-MS-Exchange-SLBlob-MailProps: 6H6McBavlAg01BqTz547HMQ6v9jxklqohcjs9mAwA7olnnZR7LxGRjvF/znUhyPL4u57c1+aMuSw+QtwTuesiBodloy/ErDia71oBLGiDp/ypMn093EPHEEcCwzy9DxxbBsyPmRX0XyXe9U1bhLH3kRqJi+3KPwhSsfm/laCRMLSvtWbYHBPBuw8r3/bfM/FEzFpU6D/eOGyXLulunqL1yDIoup4gcBN53r/ZekmrH8taIJEL3/A+VnKhgK69gVx9gSH6i5CrOwFrhr+rYfOgWxIx6WfZBVYnXEs+CGwlwRy2+c8F+jOlDeRHn8PY1YoBXBlYxTA6DQUGEk2JR/1gye06CRqXJq/CEYLhHdgGVVjtnCtKJ9LF+OutoRIIq9OVfSAYJzR/MMVIu/Ro0GripN3ejDkWlfU1kJ3vhjAA6RBAht5g8xCEFi0kdfdpB22PRUqjAGFh8hwxp2jVwtCzR/bX3mWBWHdv8DuugfLqha6ECvjVJ7dW+dN7CeAE0xBeFrIJWiyRze7kTqgAauAqPf3W8wzEZgPHMtMZbecV5D8gm8cfejNsK6bD++5njrd4wXcOqNZyiHHGiECM75Nsv2ymYZs1+k1WJg9duwNvsTUIVHyzuGfMmkearLS+eKGC76Q3310ulabiHMFVr+7F6EFsmij6ty2IywK0BuJxYn0AzvfERKxwu/SJlt6MgBPpkDXEWfcZ9boKBdfnrAQeKqTEgTUQc5ikXE0y/po5R05r/xb9VCVPC3xk/cz1uf63hHTsJUHvi4=
X-MS-TrafficTypeDiagnostic: PAXP189MB1878:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sz6wfjU8Rwj8IXC8X/P2KBYVsiesWvM6NQea4L2Czy9UsTQA1hTfJUhozkPSU1GQKv0y68XOOx11MXz5Bf8EUOf0xWPZFyDmryWw6pPKR9DoCb/2Q3NfW40Yu5LRcsSGdMzp9+KToL2Z7ddww4M4qSGJ1DwxEKHn6MbWdo5ZbHLKPLzOZCwZztp0AJTz2BGIeGPKt9+BT7RT5XqfsnDb0u2KitSVzrEDThr9UC/moeIE8QMZSoWaRdnw+kXMa8fUdoFrnu42R6OC6UgSL5uTYeuNT0e877+pU/FKcBoXEY5B0xhur9mWtmPEl0akGZaZiJosG49f/XoYnqOA0+zgx1iEYO6liseTAWK8Z8/bAjdzGZ3LaupzPuHVZm/K+UXmShX9FnzROiHY0zXnBa2PXwU8VBOgFGG8i+s7ZJQuWwsd9eOGYm3kG2SKKkVzjpgc3TAR9wv8U5o4NXRn/hbewW6++UzRgqPC+gMex329Ubq7LvOrkESa7YDkqjw/6vTcOAYrloOWAm5rUC0mmbEnIsO+zW+G05hTZY5v4pim0AA4+lOu4BWEcoCMYF1yWUJ1dlSc6jGveYDzvPoiyckqwg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4/eT37wELpW6TcZWb6AX2W4PDaUAnb1Mnm4FdW2hmWa5GfCKezbS2vRrqcgO?=
 =?us-ascii?Q?Fm4D5T5kxKA4/DtJdN6Adf1M/LtfjCaJ2kOP6FcqOZsonHwtHyBCBbZr66yL?=
 =?us-ascii?Q?Dz2YdXIn6vcAtXzOT4F0q7P69mCD+VlTBs6Gel7hnoIXXt5TZwGKyRzNSP6M?=
 =?us-ascii?Q?yfve7KnVlgNRYusaBsTXXR3Bg9T7LBpIqpzUVLC1yMMd+xfRR6W2eU61PIo5?=
 =?us-ascii?Q?OOsx1bT+iKx3dZtbAL4y1fQUOV/CrvL0ZlviJmZKAIHdrmHlKZ8hpvuQwMc/?=
 =?us-ascii?Q?yNh+u3HawzlORr4hXg1hnmjpO0T/qxVe1M6Exv0X4qnKH4SIqpp/PNwqzYve?=
 =?us-ascii?Q?28PQlfrhgVM8O44qov8QKdVP3CuttghzovvTXJxbbL77v6NQUktZEXj8CNmv?=
 =?us-ascii?Q?uwvEf5iW3xeJjJXnfax6ONlQO3wJ5sFkMy+JLukVEaYZXCMfUoQx7Ggb9M0x?=
 =?us-ascii?Q?TwgkkAR9jpD6SOdWb8WVW+eAutGPUDL3DKA9Oh72utdYZV3DCfz2h5vq0/m5?=
 =?us-ascii?Q?uRmwBByO6gXgdW0kcOOx6Uk/YF2fLFwyZx9hUsLVqdAjZZEHdiRPnct0O7yM?=
 =?us-ascii?Q?l4/rmkXJcbwTrgbSHwrelOkRz6fhc/vR6aHyI/Nlkn5o1JDt+HJVSH0mZ90d?=
 =?us-ascii?Q?Kxmgbd3cw1d9RgZgOOdOqghJNW4AGG/IiXozSaNNfqRfJU0jWjYLYdpJftAt?=
 =?us-ascii?Q?PpdCWWbGkgS8/DcvlPf29Pnq0csA8gOzKPIwdRTiVB9QyNVUzLLZwY/6HL59?=
 =?us-ascii?Q?lNGcje59Fb9+zyHezCXV8PErytsKZHds7MLY4Gf5HW9f/wtIMkm3RInn3AOi?=
 =?us-ascii?Q?K3J/9mlf8A8YQEN7awDhdknQY+FngEOzgdVjwbWxoaI38P2gCw2wH9N8mxyS?=
 =?us-ascii?Q?jPFi5o23Y2lyhXMYWWNRudHrxrwkq12goUonDjv4GwTd62FbdHJpcjutFMaE?=
 =?us-ascii?Q?bSFOC9FvyYpcehiqU50tXnzNACfXVKkyw66r2JYyPQB9DXXCTaUHASOnwOQw?=
 =?us-ascii?Q?4scaJuILKR+AgsgNP/deuvlEVL/MkxhJCoxfJzv/FxwZVABlVHOU27rc1evi?=
 =?us-ascii?Q?bpwPVFwZaLqwytG45ME0R6TU5bwPXmWYtRbH7aiEG8rlKdad/2uxofJ8Alhb?=
 =?us-ascii?Q?pF82w5FN6qWWXM2nQSllmlVCpwjA7s6QCHUx7YALiCcu1QPubrkvLhoxXbSd?=
 =?us-ascii?Q?WRrVSQIX2L6fC13GEXG8EKy33DxEG2eIDlriBudeX4L4vqE3WlJ5ASs4J9e1?=
 =?us-ascii?Q?l8G9waTUzDr6NFzNdWlTxY/8h7g3cO8NBm0ap9rq2xkzVxiCqIGTY80ehRF0?=
 =?us-ascii?Q?pjiyOVD5ezdhNRG1jkj5LPQN+aQu6vIJi0xj2YNRcJaFf4UqKeTxh5F2NyXO?=
 =?us-ascii?Q?d1oWTEQSyM4Q5WtFBgbBP9ALUNiXNMDUIACRR1y+8Tei2ZxeEHmcRSPcKEBW?=
 =?us-ascii?Q?LWfWwgPEqso=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eec91e6-d0f6-45ef-17de-08da486b5fc7
X-MS-Exchange-CrossTenant-AuthSource: PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 09:52:03.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1878
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

