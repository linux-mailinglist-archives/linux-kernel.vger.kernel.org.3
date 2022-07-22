Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F1657DC25
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbiGVITQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGVITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:19:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F9A9DEE6;
        Fri, 22 Jul 2022 01:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkHM8Uk96sHCeBgRgb99ccz0Bd0V/r5GBkTUflo2oLpKItk/WqTCV+xh3Qu0HmJACjeSYxEQ8HJP9pU0D/REF3CV3TaCkgg7/UMqtijjuuN6UvnlbaKv0xgPWRDT9ZlXorwiylXjCmZ5gFvjwSeL9TkGUG2T03SOGZJw8S5j092gS6vWqX/epVk5A/CN6VlxvFWxCkmCZDsDsQY7yA7qDy7L6yhDv+V7kPxW3EdYGau8E+Dg7qhNCgwnW7YZDFMeLWCBAE+shK13NLuR2z1hwW8AMaSiMM4wuMTsroMviP4SdydQXYeC65umZorZt2omGE1kq/MMvK2Ee3U80ukz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJF3NB6jgHIABUR079P15okPbHbjcE2F71rF1xFXYBw=;
 b=DUlqBJjDMnPbzIVaBNFy4f1wAA97AEyhiNldm0DZAQKV5deTqvvU729PHdhSLXZSEL8+BBDoEurzcE9YEtK0Nrm6OJpSCxjL1FU14EvCsUiQ2M/J/FrTYtmTrvJIUw8rFm2sYaic0+3TqEjMO3aBUyda6XOd3waJy+v3OLJneZJwwvp2VSKeY610+Sp8w7ZMOA3RDP1C5EfeWrhI5u4V9I4qgOvIJCB5lT4okYP0tcs0Xlk4l6i+pHCH/Gb5n9dbeFosf4zsrY+HZlveuO1x1VzLJJVFsNA+ZF5Q7Tjd9JWarLhqGSZ2k6p17Nejci0Nruo8QZ9ej9r9YZjSZyvVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJF3NB6jgHIABUR079P15okPbHbjcE2F71rF1xFXYBw=;
 b=08Os6o/2dwRhVE3jDFB8mxrwWtzrvpa9Z+nk1k9wmSoDzSHj5Xk4BdrkYW4APHGXf+P1wsxi3E3ytuQzgPKXf1ugjW8Vfa4FXg6nYcC6IoqpH43TTuGtpqhakcQ1rjBtHP8KNBy0wjSjTdGYpfuaWPlTZ4eB7dyiyj+CWkVB9e8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BN8PR04MB5986.namprd04.prod.outlook.com (2603:10b6:408:57::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 08:19:13 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%6]) with mapi id 15.20.5458.018; Fri, 22 Jul 2022
 08:19:13 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] usb: typec: anx7411: fix missing error code 'ret'
Date:   Fri, 22 Jul 2022 16:18:36 +0800
Message-Id: <20220722081836.3380885-3-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722081836.3380885-1-xji@analogixsemi.com>
References: <20220722081836.3380885-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:404:42::25) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d38d6fa-5102-4b74-87fe-08da6bbadc41
X-MS-TrafficTypeDiagnostic: BN8PR04MB5986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qYrKNPsU8NjtK6X3UQn98Und1tEVtwoYUY2/0k4tlTOQgeRKLfez1Wmyc1CH8wK9U2kKlEwdNf2ZgGGRUa69+EZlF9sb+nOgztfMM371HYGiDxlZk+hBzVzyCoNYRhzVcKhK0vx2OTstnduMtCtX6dE8em5D6MP3n865894H+uIL/I8LAevxezOmR7RG7WGOhQYttlKGT7kn3CPUN12Nn1ySvercgFRV90PNfdRMcfOEkGNLQni2xANUOouTCoYrjYuy+vLniVG5rzO8Bto0wx2dLpkxeeM0URY2vj9sGh0KzKN6PPWnPFEfcP3Jvy590HM9KK0OOIfDGefxScSslzSWL+ivyUQJK2s8gG0kFyu8SVqU1dTN1KcHqo0vTvE8cTxloW+eAx1hi3QCcV0aWLm4/gfSpgXjgR2M3w6sUEvVChEUpeDTwG4h8rfcFO/hxcNtDmWi/TUiaK48BTxFWsqC4QtXNDxGTPvHztkBx/SwIBfcldaGCgyQYB9M5rUOMtTJ5XFB28h4DwhS7ucQxrJUqjYA8uM1HSrnMqSu1Q+WlTxgiqf0V0XcFZwqbWU8dRphiLGZucoHfBUxWCvE3v8JeENGoKzAe9o/ilhryNduP3uZCB8TFxwNEnIn0aYGwm/kknm16DUjAaxSVYD9uOSC3uU2VgwPLY/Pbe3l+Our4KoQaG7QZMTrc1xwWHHtWqeRJWKPbftolRXghodxw7RPyqMJDOXExVM677VBBeI+1quhxLakUUJsbI248mzapbhFADcevxKnmMoL01pKA4p6JHZIg3ThH7hiMW0cNGaNOkDeYnt2fqkP/vAVe1g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(39840400004)(366004)(396003)(4326008)(8676002)(66476007)(66556008)(83380400001)(7049001)(66946007)(6512007)(41300700001)(6666004)(2906002)(26005)(478600001)(8936002)(4744005)(5660300002)(6506007)(86362001)(52116002)(6486002)(38350700002)(38100700002)(110136005)(186003)(36756003)(316002)(2616005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WMaGnVdkP9+AmpRe66J0J31fw24P4y9I1VkCyIqX7wXBpgM0saDBrxCQhVtU?=
 =?us-ascii?Q?I1b/kLfj//tDe6twWFw6w0vbiHkP8wHJtVzomTV/MiKMMfYqnitoXGCpKbR2?=
 =?us-ascii?Q?IQN4bIV1JRrpT+jd+ku3U83NiEpW643xmfjKJXggkz8T9f+mTU065+bqW6oN?=
 =?us-ascii?Q?hU+MRaUtubco0S7E9WbiCG1BSbEfGTx6AMzYS+uNbK8OwpB+Xg0K76uH0Vlo?=
 =?us-ascii?Q?+NIdq2MoLz6kLarw084oWkP3pM2FI3iJFaLW/MYNH5q3hV7irprYqX53Jy2r?=
 =?us-ascii?Q?GZIrvqwxM+93yiz6itNxE+8hFsEj5BWV2yngZhHjmQ07/x+x5gmXOLMUzUOl?=
 =?us-ascii?Q?iT7VDa9KgP4fn+Y0wcryDcFgfqMvJyvAgUPk6k6OOwg1FZcVxzcou3KDkcSU?=
 =?us-ascii?Q?uvwxYC9z23lXBUs8g4Jk9ILWHi/e9/g55ZLpEsAcXLFQPKj1wy5CUBxtflYU?=
 =?us-ascii?Q?2Sxv+roks44bEAbEfY1DSY0M0eGUAL9shwayONgVWeYKNPaRbVRitHACk9d1?=
 =?us-ascii?Q?jskbo2j8w3SGWEOMGvWfF3BZ6VH6GhiZMnSsxCE7e1OYN5KPDmb52058J25W?=
 =?us-ascii?Q?la+ZVsz0fn/vysH0Pvv+niFwzHJJNHnzPAyT9asDCDy1/EhJNUBzBp9E5NFf?=
 =?us-ascii?Q?ukQDAKVGXG0zwFATZz+sdvvz7zkIDCZU2OvQdScuPV/NCyI3q22Emz6256wu?=
 =?us-ascii?Q?cYBvBmoUDrWV1fmrUuTCEmMQ2NauJVg+m9RiAkYUI3pyIMX2kxCY+wFq7HBk?=
 =?us-ascii?Q?dNZ7n/h6Wd+bhWqve/nXmdws/8IBBweD2jSVgz/E72ouVCRZYPBlHnjC7X9A?=
 =?us-ascii?Q?Ip5h13IuQwZMYTLWbtZ5/1M9XHOALSg4pi9o0xB2TV0DGoHWidwwQt5q3jtN?=
 =?us-ascii?Q?BpWy0bbRa1BTgzeQTaA4kwo50uAwVgZsbZVa4W1BYk4JaYiSEevicWrr/u9L?=
 =?us-ascii?Q?KsUplaOaOoDhNyovJ8OusGEOfKFBynl+P6bIMVpBRMEoYU9ahnv9jQQfYLGl?=
 =?us-ascii?Q?eQ4Uj5GPQVRamnd3vaxKDUNs8Wri3RVqzlX5wxRKOkgPjpsOjrJGkWUPP7uo?=
 =?us-ascii?Q?Vn4fifOlbvvLE/9z+mgXjEW+Urg1g/B/XhKSJONQ3LvlhkrZ3bOu9aT4xZK3?=
 =?us-ascii?Q?RdsWkLBlIgUZ++4ws8YZHoKFJMIisT8MD7NIuibCKIOwQOx9Hfm72mHZGDB/?=
 =?us-ascii?Q?JGMCsil/nK6wT6DNAO7TxWPyrfu/WLX/64TmTeZzqq2XmIXzjd/WGNn9WMUo?=
 =?us-ascii?Q?VsXeKu8DkNub6j70Yg/6OA6fjmPVB2dzb3e3nscjIhnnebpRZVFIgEe2Tgoh?=
 =?us-ascii?Q?De05142vLD53H8gzJxwZExqMuTTexDp9H4RR8tq2p87C5xdj9p9dtM/tsCvO?=
 =?us-ascii?Q?Rsv9TnaGilokiaJjF6xyWltT/BGGy3aowN27ChLWMxQM2iMaD+F/ZgHNiymd?=
 =?us-ascii?Q?gnIli1j1UIejsH0TrqFRuJuQrISvMzfY7Sx6IZgxKvzZTbLNmlXASmXDHPRf?=
 =?us-ascii?Q?qYuS7donow8UvHOq8A+Q1jGbb47qZND1SRhPWMQkKvcCjOqTzBwNvdxA1VDV?=
 =?us-ascii?Q?6CIrHRc/1sODAwVbTfRFycUhufM/nywIe9BbXXER?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d38d6fa-5102-4b74-87fe-08da6bbadc41
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 08:19:13.0667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQiFWt1oNYgID6eMw2t4RSnjdip0Ps7Sa8t4rngENHy+BRajsHyUEuzYM5ttlOOJFtAkNWOPXoAaSCx5HsIZ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5986
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix anx7411_i2c_probe() warn: missing error code 'ret'.

Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 drivers/usb/typec/anx7411.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index dc86b6704cbd..525022c24e05 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -1483,12 +1483,14 @@ static int anx7411_i2c_probe(struct i2c_client *client,
 
 	if (!plat->intp_irq) {
 		dev_err(dev, "fail to get interrupt IRQ\n");
+		ret = -ENODEV;
 		goto free_typec_port;
 	}
 
 	plat->dev = dev;
 	plat->psy_online = ANX7411_PSY_OFFLINE;
-	if (anx7411_psy_register(plat)) {
+	ret = anx7411_psy_register(plat);
+	if (ret) {
 		dev_err(dev, "register psy\n");
 		goto free_typec_port;
 	}
-- 
2.25.1

