Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025DA545DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346947AbiFJHp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243289AbiFJHpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:45:54 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6732F13B2D0;
        Fri, 10 Jun 2022 00:45:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blfTEa4TGEnUzIIiOEAbUTbuHq9g2Gk302j55SW0eEWocCIJ0rQdBqKssZPn0vCJ9IK8GwYHUqn/MtnEMJuAWOYhrt9ikeP8XfNReLY9AOrOu5ssvPNNhHGWqzgx2hSwBBiuKRYLI/uiH6A9S8YEKhgFuKKZwlk6lea0RYTjv3entX1X60J8zM+TZiOaHXX6dRVsI+g+nZ2LNq8I/NptygSJPIrvIHKYfZ2jaDN+9uUmSlH2Gd/BiOwuFLQdyfMF1u2q/q5lPE/eTsWxtBH/EBPs6gW+88SSIMuKf9wYcIe9A2KJitcp3ayTiiQIY1hiMXjkeyzG06xYTGz83ouYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4uz2/UIA41xN68VnrLzYJnUAIEZ320BI9HcEDIaiX4=;
 b=jICD0FQqtufIHkcSPAz8HNXiG93StWBvPjotO661udxstCu0xKUC9ysa7FN+0KLtyfdSo6W21XFiAQk4fiLgqTcyS7vFhK3MpQKj958bHni2gD78CtGDzSyjqg6rz8kB3VUiyE7IZa5TmA6475OLts/TkniBUErd5KyDNQCJiBKuhHXY4neVYlCCyuk2EnzvZ0AMtm/mjuuQDxswGngETT8HDBp4uZrd0nXzomzzemXPr7almO8I6XMGoDq3wHQ3fwTdTOTfKkV+QEVcedR3XqElg8zAo600c9WHFiLFQLBoOsb6QzKhxpSFmz8UaIvAUuVLXEDOejTlGh8CvDY0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4uz2/UIA41xN68VnrLzYJnUAIEZ320BI9HcEDIaiX4=;
 b=P3RMe7buOCOLbkEF/915s8809UB82M5NoIjsBPD7k/INSQnSjDTTlHUeU6A3TAfmoFyugq4cLK2N48qeU5oMjckj4RZgMZKaqQL6LINNICsMjO9DHfmylNSEe4QWpZ7YTpyr+9xETEpGDNB5qdPXuUkOjSoSrCtb2sdHQWzKS3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB4171.apcprd06.prod.outlook.com (2603:1096:4:ea::12) by
 PS2PR06MB3285.apcprd06.prod.outlook.com (2603:1096:300:6c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Fri, 10 Jun 2022 07:45:44 +0000
Received: from SI2PR06MB4171.apcprd06.prod.outlook.com
 ([fe80::a501:12f:a492:29a5]) by SI2PR06MB4171.apcprd06.prod.outlook.com
 ([fe80::a501:12f:a492:29a5%7]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 07:45:44 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] usb: phy: tahvo: Check before clk_disable() not needed
Date:   Fri, 10 Jun 2022 00:45:25 -0700
Message-Id: <20220610074525.69453-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0151.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::6) To SI2PR06MB4171.apcprd06.prod.outlook.com
 (2603:1096:4:ea::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b61a0354-903f-4f9b-ad95-08da4ab53981
X-MS-TrafficTypeDiagnostic: PS2PR06MB3285:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB32853EDB48FC650FA1EF7D9BA2A69@PS2PR06MB3285.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOcMEKRlkkGJHTK8bJ3y81l4P2BlqtPMmY+iR2WUicXrTiePmFvVkITONp9eglOvuwSBYWxSCLT1OKyuVAWo3F/Imtih3buSzG0QgpW85WXWpXlHWMbpy7SLuxXSlBuyEQWXnbddQn+TbYpCHT4QmXpSNUIzvePqb+pNxjSNLbZNehE2y1Yvsr0yIzXYMdB/dUUZBnYk3q9vj8Nasm6hH3q/F0Ao0KbV15cryd0B5UmKfiD0t1DvAJaABBXfVyj/6zBbMFucPAPT25jK0hjX9YEP5O1OVMmYREAHbPFe/mVbg+dje86yoJwbvA58j8Ql8Hy9FGpYplAsywkJQ8WXF+HXtZrnL6Ugg6P06qanmpGqJ8BfTv04Ezv7T3jS8MLss2xgcR2bJHuUQuyCYKLGwXiPyFuyXP8IFM65QTX5XKq8T2LOtwvkBMTTEWggL0oXX6rsA8k3QKg/uOOyO+uxdtg2PPagdzOxtI86oQ5UsDSMFmADE5HmCLvcnvjAtM3nvqJTVHbhkn5suWL+4GzQbOzjs/lX2CU0UVj1mAlxeP/yTL3PvILjFbYo2LaK3RArEsJa6CWBAvtai3U63cV3lwE3jgLpmUuKfaiidkBzDDgllB2FruPM8bG3r2z6uwkv3pBKaPSXeXsJugcCfXD7Ek9KW5TY5+PQF+gesEE1WYKWYAm+J/GLY4b2PZ2dSBqwGxwtyV9YwC/0yv1ezpRzpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB4171.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(6486002)(2906002)(508600001)(6506007)(6666004)(6512007)(52116002)(26005)(86362001)(1076003)(107886003)(186003)(83380400001)(4744005)(5660300002)(8936002)(66556008)(36756003)(316002)(38350700002)(110136005)(38100700002)(4326008)(8676002)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ijK4UKeFlqHjwUbYYebbK5Ad7tQvotdZIOQOLdRrVPaNp1B8e2Y4czfcTXmj?=
 =?us-ascii?Q?FTekHZ1ZFrHjeJdexhcfCeE632zkcrFM1BpiNPVxGHtkg29rlRMFcr2nEwRs?=
 =?us-ascii?Q?chrxCKoOqzylNfBd2Ml0qwefV4BenoK1b3iW9rFcgeKbvICfsaT4gtISO13q?=
 =?us-ascii?Q?//fWvNdixqIXQ/DGADuqDedWQuv6GE6mTh7jIZP/Y0umm4YIQjI06w65rp5J?=
 =?us-ascii?Q?A4KNcujx1VoxqS8CDNXfCPXHqcdh6SUnY63l41t5QkM2bZZZKtSWQ1mhoRhA?=
 =?us-ascii?Q?MIFkkozbtP5ZEKZQZYYO0suDasqrKEjs4mtOmf9g2gpsES6WmvXCK0Twub9C?=
 =?us-ascii?Q?zP1/MpD4Kon3RGjDxeFaLZYSHFJ9PGEptRYbc/6668dvkPFtKbb9ZNK670mx?=
 =?us-ascii?Q?wxNxR01upSnftctyDnkqvaP19cHMbAhAQYsztDCMe/+EMOVNU63IgCgFh7tA?=
 =?us-ascii?Q?IH7B3hjVoW5qHfIMwKRm8wPWZW/osRVv1EcxRKCAB0V77+HoBpDqOCI1KTiC?=
 =?us-ascii?Q?R9hxst4hsB3PqMiuPdlkI7Aa8mrRBYqR8NpGn6P6Siha2Ky2xT2kJ4zLRazc?=
 =?us-ascii?Q?UhX36ykRF56MQCIgeMEXEzUWar4ixN86MdK5MAB7zU7KELZow4v+N8JE9caT?=
 =?us-ascii?Q?U2UaQGquGPPEU4V5QAq8cqSN2Ie0+zXP3O5bvUjw9hwuluUoMn8iNHpOsSlJ?=
 =?us-ascii?Q?YFoffA9PyjIRJkefy0A0jcWyxEvmKywlTS5lVdxbn6f6vmKJnnbe8FLUk7tL?=
 =?us-ascii?Q?Zp/aHucn2kXOcWCbC0wNrmFN7OKJxkifma6yRafPAhuXMqBB5EBsJh6YX9+v?=
 =?us-ascii?Q?4RKlfwhtYRNQADSddGIeh9wOn2zk6hgI7T4WpdCLKENTz2poIJS1Fr6Twihu?=
 =?us-ascii?Q?PaoHegEXVXeF6I5l4fYNiObKmkO3ZgNrdIWh7RuSwYz72jXeimZDLl3dHfZK?=
 =?us-ascii?Q?dWWiSDy1DznsZer2P241y+tlkyfGdKQ7k1f/OVFUo9KUwMjbJQp+hcnzjPoP?=
 =?us-ascii?Q?wPSD8NvDv3H7/BfOsbi3FAetsBJjLyBCkGHqGRhGUSqlHt+jVoTiK/gPN/XE?=
 =?us-ascii?Q?jMPCirmE8mY3GdXNMgISslPWmO4KLQ2WUsSKigQxPvxOpczMNv9d7TqMnqhF?=
 =?us-ascii?Q?7yRzG/RhK5wY3A49qO8tWxxw/zAJVmV7oVsQ2/8Mrwxs7X9mb6mV4Md/8ZI6?=
 =?us-ascii?Q?O4UKQ6ZZo1Oa2mpqETmV2xFVASBQtsn6PTDfU01pWJ7m6AytWQs9BlRghxu/?=
 =?us-ascii?Q?TZkMFHeYP3p100YEeWO9dpe1D5JgrJrWwPmaEqTWZOvnwUf7rVnH9Ugz1c6q?=
 =?us-ascii?Q?BeC6Dwqk5pisI4prwpFbWjZMHMgXGUFZ8BlWYOa6WJA8DqSYlTOXB5km0AEm?=
 =?us-ascii?Q?yWILMWUrzr9LYseFIniXk0rvBFYZlO5wAdIA53qTC/9dmY+L1f0NDPZmXyZG?=
 =?us-ascii?Q?qqU7cYuQzCbGmOJ3pZ6Bce3845DBk1fcmK57biWt6zXfcgAUAyk9XbFgOPBa?=
 =?us-ascii?Q?HIAv6HCjToMj9zcJfvmazD3j5qhJUKA7TtCh2o4e+LkFYSHJdv7NgxAi5aD0?=
 =?us-ascii?Q?l2CvFEpntlh2521EgahQ6VCaJBna3+MvuXlFtBZfsYN39E2YVw/wy8ipQ/us?=
 =?us-ascii?Q?bKOq2pCtYiQJv7INesq3CY4YXocodnchfb5YzSnAu5OKrf9Y9y/5hP78YiKg?=
 =?us-ascii?Q?6pe5EiVEYSkbxsO6jfnKNOMIU1bIfryqjqnOmaOtg1Jd8xbyMWCbFwN96uHU?=
 =?us-ascii?Q?LHQq2omS2A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61a0354-903f-4f9b-ad95-08da4ab53981
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4171.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 07:45:44.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeMY68QxouBOGhtNeeKLhUPOE+S1b68lT5IsKdO3zhjmfnO/jS0Q0ULJgfdQdAdOOraFhjX6furqbnGQy9SuCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3285
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_disable() already checks the clk ptr using IS_ERR_OR_NULL(clk)
so there is no need to check it again before calling it.

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/usb/phy/phy-tahvo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index f2d2cc586c5b..9cecc5444515 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -406,8 +406,7 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 err_remove_phy:
 	usb_remove_phy(&tu->phy);
 err_disable_clk:
-	if (!IS_ERR(tu->ick))
-		clk_disable(tu->ick);
+	clk_disable(tu->ick);
 
 	return ret;
 }
@@ -418,8 +417,7 @@ static int tahvo_usb_remove(struct platform_device *pdev)
 
 	free_irq(tu->irq, tu);
 	usb_remove_phy(&tu->phy);
-	if (!IS_ERR(tu->ick))
-		clk_disable(tu->ick);
+	clk_disable(tu->ick);
 
 	return 0;
 }
-- 
2.17.1

