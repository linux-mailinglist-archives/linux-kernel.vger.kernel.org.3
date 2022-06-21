Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA38553823
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353129AbiFUQoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352611AbiFUQow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:44:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-oln040092074074.outbound.protection.outlook.com [40.92.74.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D8427147
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzQysY0cwC2bRkKCBLoXA6roEItdgNm05xDQuw0n6wlG8PenwNmrmvyh8WzST973HoBvfOewu3qyxpTN7bjyr6cQN+qCZySH6ZurkcjB2iXK/EzkmoE/e6LovJGMd9kmMWL5SbEaNBfvhKD8wL0pcf4aUnHWP8FzrQacU9GXlW/lN8wrCwCIU2w6qMvXwR1/LhwjOy4bOKaz7JNI2fUENbsSonkJycu34P+MCvC+0bVgyb4aTzeBiq2SN9bXW9b8HCj2B49mH9F0Z/kizeTvWowKqZ2JI5f2jBKrOXMsdOOE5wNheRBKkMJxuFNqxGvGPY/yYQD7j/eLWYpeNyAReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf2MnEJp4dnbpr+pHCw2orzJK7oLI9VLqvaCJ1Pk3hY=;
 b=TvQd29n87hLavVYLzX+Wu0JugeygeaimBjHGehBmtXXGnJFYuDN5+PGQTrG3NSz7m8w3XYeRIkjksgXz+w6XDr5OdMOJxxmHQ2x46+qVzy5TzdjLXE8sJ4KSOJcCsSVNOMWn4FWReRnmooyhZsqY0+iG6bZ8Fhi051h3rQ2p2p2VxVHT8qO8Ywl386tHShIyM62a6wr0zrBDSUWokIBpVfwzYyVoMPtIdekv0Tgx80iVG9GW+aWAjWoAS21alPA8ADbBWFgRjl7IvGDRO+QVTVENsAINP3FZKreqhEZAoCv0RIlkzQXNK4/RBBhO6KKeoA7+oGO9A9a1DqZ6n/vXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf2MnEJp4dnbpr+pHCw2orzJK7oLI9VLqvaCJ1Pk3hY=;
 b=NMIOtFxochKfTinvhKdBX1Qudxfq5HDSoOeoTXzr6Xy0R0O+0FqooJPZXwanpDmfeGIykGMABYdnjKQ3radjTa8iqxd2F+pvU+RY9BPr0WWvloRwqG8YJkyid0QNiLMttCBqrKkpindQUbHXcFkw2+K7KdP5kcKd/niKwn/xWAf3RbSi2sjE2dZdcYqt23EElExJhXY4dQ+KtcC7nkGRzHQK6UY4YqCaNvEdJOz0LfWvgtp8NVmcnofndFur/6XV+pFvP+cxTLpvWFihaXFMX8tk5dasdSb/yN6gRz/tOb72Kwt1IzPk+OAANXGHcFahqq/128jbf0t8radgqm1lfA==
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:c2::10)
 by AM9P189MB1713.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:301::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 16:44:49 +0000
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d]) by PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d%6]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 16:44:49 +0000
From:   Saud Farooqui <farooqui_saud@hotmail.com>
To:     maxime@cerno.tech
Cc:     jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, wens@csie.org, daniel@ffwll.ch,
        Saud Farooqui <farooqui_saud@hotmail.com>
Subject: [PATCH v1] drm/sun4i: Return from the function in error condition
Date:   Tue, 21 Jun 2022 21:44:27 +0500
Message-ID: <PA4P189MB14215D2A66A54FFA3F7DD9348BB39@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609142253.7aad4jlaoahqkmy7@houat>
References: <20220609142253.7aad4jlaoahqkmy7@houat>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [MFwVIXPqtv+sR3QUZa7gsO1aTgSPGvIZ]
X-ClientProxiedBy: DXXP273CA0023.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:2::35) To PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:c2::10)
X-Microsoft-Original-Message-ID: <20220621164427.30669-1-farooqui_saud@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 335af846-5e3e-418b-f96e-08da53a55b09
X-MS-Exchange-SLBlob-MailProps: Zv/SX2iM+5VErZYGRkItsGyxMAx1p7VJqBx0HgbQcUE/f1G92z7gs81cgHfHAlFg9z7pHE2cEgXX/XHvd0oqUD+SCqBgnfxpm2ij/V91po+Gy5V1LJPmQWQllzVNw5ptYLw4WghipNADcUy5Gz/onyikkRidsEWPA/zlE7eHlZAO/edTlH5WXc5MRIKllMulC00o1u0RJd+dU9Da66C4EASgnIEzcFFc2Ahib+y5ISobST/oEgxvGWx8ncLoQP/7raid64SzTX5qmhYB9KtGaILmVjI3u8a44Nhogr6xZqkkFR+OfbUvIyl1VYqSXRAl0jniUWPEzEgtXvRxBWzjB17u1cOiQtqztkJqsg1JQ9ZAYSBC5Li50NjjpEB/9DpF5W7+/MFbiNTZ/Q7qG5OjIXzuJJTEBRELcvsMAsEM38nEYJrWp5s4bDZMk4cbQ6xQ/0+jj8fGKfmha4VqUASxEshFN6Wi458KhZL3BcfCgRlsdlyWKxGdFOaWfxYpcHA4xvqAh0Z8FOJ4+jxUF2iuXkw/4swb+xeX4KK/u7Q4MbZB07Sa1v4uwlR6T8JNkQmTNmDDU5YmIZN+OCjHPzdZP9CKo5Nr1cQ8Ac9vGFXmvSaP+hpnbXP1/LENdwGlt/Qb4nRSbpwTkFMo4Q09Kp/GpIG7wqBS/4AUx0d1W5MMtRwpJYIruoQjY/mbBvO90LwThBOC/TvGh+Y=
X-MS-TrafficTypeDiagnostic: AM9P189MB1713:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0hiXvWxAw4UGfAPg0kbq9AVWOTr21EgA/CRL0JX52gN7WjUn7uw3sObN6Vwr2zNervJJLA5vzfnWxuJNcFK57yY9jResnGsxEZHZEznFn9JbhS5KPNanRKbEubcatmkiQRtUR6g/7Wu9TQO8KSes5dz+WMSkIj5H89KNApeZNkPwIclKX6UoqqQ72N+YSOv7ludaTwnUdTBgrZ117A38RoOUMlxPJK0fHwoc9WjzlCN66kjmyBABb15JAiGI1YI1YzHjLqPyPTdQVVuuaZCLlKvu7zwwc4rZcvRU6Iop0qwyI21uQxkwJxYcCzkT+Movwlwd8K+5nkyTjQc0XnlcT8ApuQJyOZAoEiegm+ZfupAQGwXc6SNec/lPuUF7b2rtQP3uKn7pqMiqnRpObkPXTKcSWJtA/BNpAkqamUQ0v6/lnAs5i3Mr2dFPnY1Eh3Ktw5L2DIuOCNiaW3o/5oHOEfgMMhWe6Yf7SoMsx94aTSLKDVUdtoF88FW7q+lwkpgDL/yoArlIDnXN6EG7jVd2MxOki3axb8cSWJntg1krx0mHZ9pIvUilQBYwzuiFhW6h9u0XDJrmIZzdT57cRJPfw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?reFncdDy8L/EeInU81V85KRpWRcFHL811P1ZzbiZDwGcWJaffLHBJ9oQX2NH?=
 =?us-ascii?Q?BjNkdnwN3yoG+jNDAW1+3CdFyfCkQu4q9yjn63akMHCbzoJ+kURZJGlZDboe?=
 =?us-ascii?Q?zeSmpq3uPSb2P1cZhi5bImQ/E6qtUumxgvA6T+TnNRuRAgZ6bc71ciF3Fbqp?=
 =?us-ascii?Q?EuQZmchpckShE213R9G1PHVKXmoswfaimMlB0xpzEnSxYXAJPRF4QtdJTZKQ?=
 =?us-ascii?Q?TYOpS+huWR1ufqVu1K69DUTCie0bdtKQWPBrl3O1Y7yMauj/ZhfAfphkw6wD?=
 =?us-ascii?Q?qw1nBEvPjvuV9LODkCpcT8aSQ7kAOq7v8X8tJJATxN7Q8X0AtCn9RwNa+3L8?=
 =?us-ascii?Q?b4v+633nF7OBtEmRl/VIUCL0Mgvjw2rPRrC5oc5ogFF3p9ddfrYTZMClQY3L?=
 =?us-ascii?Q?1UNO8/NryN1FEvgVDUrKQMn/PIETKk1RdjSb2B3bhpHo2GD8xjJrrVljwAdN?=
 =?us-ascii?Q?uz8eiFjqe8VKK+2Hfy+MOOcwqOoaAsrokTSZir/YXsj4RPIs7A1AX1F+eD3t?=
 =?us-ascii?Q?1uXnBcPOHaueXO8JWIMhoZm2WxnVMqDXKgSFou0Ym1IVuayK8vukqsWEQedt?=
 =?us-ascii?Q?78zAVcr38T/wpKFhpfoY5P72Cc+QSyJaoNzkUJOJKuejo3/dNwPL01B5XH80?=
 =?us-ascii?Q?fqoRe8Y7YiTgxgqKDJfwABL66uOqV2mul5VntdYnidiyFhAJ4jW+xMSjEcJv?=
 =?us-ascii?Q?zlIAu9ESEaYQErBQ6rbKSbCsoxyN6x8nRNzjcjQpOMrbfC8mpA3ma9zDW28m?=
 =?us-ascii?Q?9fFZ2TFkdVy4pnmJ3QPqLzAKPlX7rwSOQU03WTjVZH6IatUY8Qq6sjrr3plN?=
 =?us-ascii?Q?AbZPZEimCOr+HBb/mQ7qNoftryI8tBmlL9b7WbBVTY0Fcxql/OPAAPL/0pcD?=
 =?us-ascii?Q?Oz8+S3JvGzX1N5GcQpupo+eUF12KQmlJqDB/6bSxijUEJRW+RcUaMpeXZyL0?=
 =?us-ascii?Q?JfvLt8PjobqEQ8DR2IxR1bRAQP+ySZZsKanidyMbQH3xhzVNrSmY6V8XNemX?=
 =?us-ascii?Q?hQJF2qb4z3lKSVcTW4QEf1iwSa0SSlgY5ZigFYm5dTqtynYHOIRwppp70gH2?=
 =?us-ascii?Q?ulEFumKFDpPOVWkUAv9ZzOwH7bn/QkuJQflPQIDCamOiqjtphe4wH1l1YyMs?=
 =?us-ascii?Q?ytNlZFQsBvZeC5IjK8ZqQOh5ONzyavIpyLVmgD/JN/YyyEDd9n0LQ4RRATYT?=
 =?us-ascii?Q?yJ2qHPYTt8v8dBCSBaA74yVN1ymv33eEUakgpQzoOuCZ2Hbl6SHNc5sUJbW4?=
 =?us-ascii?Q?0iVONtN94PvgPkSQWfMy3gpnZf9VQytFYubYOxSICP7Ej0QnhpIjbk6bnopu?=
 =?us-ascii?Q?iWddLLqKm4nn0o4TnVsGFWkElRRmCw+LELmMugavQkCSZNo9Kddg4+ut3Qcy?=
 =?us-ascii?Q?mzd/PZgGLMX+vddCR3tvKpWb8Ufhtio0IsmZddED8dytIfRYkYhSHLbE2ZwR?=
 =?us-ascii?Q?SMA2Tth90yw/DOdksIkRi3z3jk69W6w0?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 335af846-5e3e-418b-f96e-08da53a55b09
X-MS-Exchange-CrossTenant-AuthSource: PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 16:44:49.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P189MB1713
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
in case of error.

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

