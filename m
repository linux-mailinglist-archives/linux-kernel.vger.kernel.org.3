Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D8C4D4229
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbiCJIH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiCJIH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:07:56 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300130.outbound.protection.outlook.com [40.107.130.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5964A133954;
        Thu, 10 Mar 2022 00:06:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2hYd/cbEZRAqEbMLPk3/tLrV4n2Ans//VMNzv8OQXnJp+kPyRTKruAeE6RgzXBGOcxxhBjbFVX3R/PTteOn1L1gaTlI+3CWeL1HoYPYEkd4apmKDcSSSWeI7wdGjOK1y8g5ogEXGGGOLJB5NLYOuO7AKG00pdJPNy/SEVTCWYaxMzTuBAMmUWMPP1FBTf5QQC9vOpx3D3vex+DLnWeh0o2fIOFlTudnrnFGRdztzTca8QfwLkW45MM9GihN67MbfQKs/Xx3gt3tGmS8Dy6pCf8lv11EX3wtkgJ1/5UcypzIb1r1vnZsdLvVneKL/JtgM7nMPH/mQNLysNtwYkMWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAR4LpgmIaYJqS8fYMRF6xKJYQZAO6krE8CN/9k7z8Q=;
 b=esq8hikeeIVQxmECpmKKss/1SNmJho9SDWEUM0pdYGnysQ0ivR4IGkw1QnRxG663b6I11YDViPRzWEZbbVzsDJbjJLZKnRb+TCs+bY7mjBRloVRTZjdyvhn4LH3xsfUSG4oLoJ4orFNlowj3z571kUPH+Od5wbXO7Jd0e+G8LXVNkujvmL4/8g+Ye9x3id6Cv20gVRtNw+TNvjrsrGA9vpEBUdSO58Lml0T5aaMXpH+uR3qDrop6uRuGGv8RaNLZLBkCOGqnrdoC0vLWb3IQAXJIoqgu0Pgm27pXhvhK6kghX0sRbs1qD+XkkMOG+rzdkoXHRQohRpqd+KgYo1Ad3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAR4LpgmIaYJqS8fYMRF6xKJYQZAO6krE8CN/9k7z8Q=;
 b=WZT6B+P4BXMXhXeDwfcZxCabcMlPkr8N244P/nVK6VyT6fhrgAiz4xBLwDScBaAI2APKJJqOT0rgYM9y4sCTiddTzw7M7Yy5Ac8si6b0PRytx3Yi60mJlIY5u0/LVlGedHIrna2FDv7/+5ZzSPmT8zWmM/bMjPHeCo3B24kMaP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by KL1PR0601MB4671.apcprd06.prod.outlook.com (2603:1096:820:88::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 08:06:52 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06%4]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:06:52 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] media: mtk-vcodec: fix platform_get_irq.cocci warning
Date:   Thu, 10 Mar 2022 00:06:38 -0800
Message-Id: <20220310080639.12757-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b355d796-02ac-437d-b7f3-08da026cef6a
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4671:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB46711518D380F9370E30C23BA20B9@KL1PR0601MB4671.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QGOAB1kUx7mWedA8qmXUatP3W6RQzSQg4OZj/maoBBD8coJb6HRPsui0pWDyH6QyfD2hNluY6bxvx854xgJAuIYY+djspl/ukJ7DH7NhoqoeBwRw503rGle9pebCFA/6QqJk1gafeExtFZEvg4uvgPpzzj819N/x2Wvp78njVPQ/JHTEXi5J++hPoswe1o+5rw/fBAIKnekQAM3FipQ1gdXkFjzAXG0P2V9pTTYPUDIkqu11fDT16A1j/ksJPMoCKfQUtrB7KVb/cI5m3whKySK17GLUU7imvt5Wn9f7lWlWIG2aKwgbkZZ6AheZSUciHLT6ldEyOaPNavg2JGIv9rizv9RXgyFHuYufklWwt0UxD8sqVlFNMG2ixBMPC/jwPuJLfZEWsf4skKyWmK2a0w9Rf3Mncx8n5Gt0KoRoGuo8aTVmTDgaZM0kkyRqT6OUVk3+u+3V+NYqSzLbqx/60hlI5HfTcyUXhURu5+cdnb8UF9+cEUqwi+8HOsneaOxIRK5KP9YETw1D7Epgo14DACkAJpd+OOSSaUS413tScC10o7nSoLMFcS4lJ5RSK0G1z5c1v+oaqG4Q7ECwKiSC+PwmAtAyRngWfIhZNHTOlPkg+wSiEkXHBicd2oKcVaC772/KW6jU68U0D/ZfHHSx/gVKF477eN7lgXBMshhCLRgALq0GId8qRH+MDDSAtPjBzybrkpeUItGpljOojperuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6666004)(4326008)(26005)(8936002)(66556008)(66476007)(8676002)(4744005)(1076003)(110136005)(186003)(5660300002)(36756003)(83380400001)(6506007)(52116002)(6486002)(86362001)(107886003)(2906002)(6512007)(2616005)(508600001)(38100700002)(38350700002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rMx0cG3QWaxJaUeaLzSjqn0IHW66B/DM73HQkdXQRGNC+YfULNar3TOw1ddP?=
 =?us-ascii?Q?U8oBlJjgScvl+SwSFzU6ni3NjaJgIqadgVl4kKsaKyBtSzLVTUQrFwTdlb1c?=
 =?us-ascii?Q?bpz0TaW9frwCmHCCt6t475ovKxitV2NbI76pMB14zuq9KkmH4Hbwx/DZ8N0+?=
 =?us-ascii?Q?E8xwbGPoHvJs/AQgcMP4jUKCRXTeaekKaDrtwIxu75M25BfmJGdV94oi5c6W?=
 =?us-ascii?Q?8y5J3cO5h6VDiI166iRnoz6nubb7qjAwCOzMyjTY7cPosLwv12HWfp5byTEA?=
 =?us-ascii?Q?8TdPZkw9TuI3tCgWv7t+s09TcFt6t1II7vKPsd569aTqNa830r+bUHiNEx2j?=
 =?us-ascii?Q?kLCBSpBnTrP7qB8MSjnkZwLCCNIYRZhn/obFe5lByZz+C01r5mitdVvo1GSz?=
 =?us-ascii?Q?brXZyiStbCAIS+c15NOl1WBZpDmauxIh/F3LWhlpm+CtOmCCVqYwJ/DHno6j?=
 =?us-ascii?Q?+pLADoLXDzT7AzqlMxtUUR7HlD9Jjx5SHow02gdWNQkCFao0gx3VAbBXRGcs?=
 =?us-ascii?Q?uHBDh8i1Hw6q00oNTKLbm+QMkHCNvc2W6FtXAS597bl+j9kMcd5GXUzLkvXA?=
 =?us-ascii?Q?uVN1bb2GPDZmZnZnv20zKBsv76EkVyG3bGd4QzjPYxWiMn9pt5DilSuvOfmu?=
 =?us-ascii?Q?9vt09OoR+jxHf0ChBysV+D4eoRTwMTt50Kkh2l1zHNSkrQjByTnp0A/3n3q5?=
 =?us-ascii?Q?QFZgx+Bh2zKQO0mI9bPv2o7awwNWpbyLk0JC6yY/myVyhepPNRAbpUSX5qde?=
 =?us-ascii?Q?jC8+P0TLsBjXkcULQmdeL6337Q+QF12OhQgLYWgQYUsDhHpec0weHOmOFbEs?=
 =?us-ascii?Q?/fTEY7Al36cJySPvd73Pi6FCNZpwRzz2MCDiosD0ZpEmPLryAbFZqBOn4y3+?=
 =?us-ascii?Q?rsGB/zmlyCuILBX0HbAHy8lRedxunp3V1/HyyCOx+9LOLAXkjOJIleI3qNoE?=
 =?us-ascii?Q?mINaTCJdM8q40ntUBwOoFYzv4Tzgw1+8qQ09RZfGAsYxzHvDEZZVkds1OmAT?=
 =?us-ascii?Q?WbjnHLYo1mFf608N923nYXec6V/TK43TJXsh6Tbt3M6ONJBvg7hzaVLoNGdi?=
 =?us-ascii?Q?rn0Guvlv/tRm210Re3Q9C6h8/OshLatwZL8SOQaVDjjwbZRt6JP+6P8btSWD?=
 =?us-ascii?Q?Y6BbzfpdTfXK3OUVtS+jGyus+K4bKjfp6+JMfmMZLKVPIWsIss7dxTwEH5UU?=
 =?us-ascii?Q?iGczaDqjx0sZmfXAEu2kubtdtq2zzkW+nN241X9btvr7vTNF+o1o9FL+0Mme?=
 =?us-ascii?Q?MAMD1fXwu1dkdyB7JWgGlZTpXUXAtpL8UbfcG8xasTwhfeY4yDeLAXVq4Ts2?=
 =?us-ascii?Q?DFHeRuDAO3hygV5lkk2V2KWXr8f7+0K0wnNu8DIpHWVsu07iSFbmQbioOpsi?=
 =?us-ascii?Q?W42ABr5V+JwMEEPphtvCGfr2mx+v0BYwwLEmmhklIBotdT41KY9Y1dAyZPaL?=
 =?us-ascii?Q?PwU9ugnGjx9BhATaF7GtU52v3UmTXF5wMEyU5cyUWsgUVAyWlflvh2GAWKJF?=
 =?us-ascii?Q?o39jEsnexxRlru8kjeCKT+1A6RxeO1jXeW4EoWbIX7KR5QNsj1fAich6h/BS?=
 =?us-ascii?Q?5b0Jm6demnJdv/6N7DnBgPI78F60Vt/+0dMdClcd0g1U5X1GSF5FeHeaj5Cx?=
 =?us-ascii?Q?FIj8ersBKD3DEgX+rXQ/Abk=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b355d796-02ac-437d-b7f3-08da026cef6a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 08:06:52.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRYPIjtGw8bg5/IrIrEWGydJHKG3hp/blNizGN0+HA2FdY+kYJYD05OtDhv9/7HNOl0YOTK6ai3O+fIMoSbQtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4671
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dev_err() messages after platform_get_irq*() failures.
platform_get_irq() already prints an error.

Generated by: scripts/coccinelle/api/platform_get_irq.cocci

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c
index 8d2a641d92f1..5f07313676bb 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c
@@ -99,10 +99,8 @@ static int mtk_vdec_hw_init_irq(struct mtk_vdec_hw_dev *dev)
 	int ret;
 
 	dev->dec_irq = platform_get_irq(pdev, 0);
-	if (dev->dec_irq < 0) {
-		dev_err(&pdev->dev, "Failed to get irq resource");
+	if (dev->dec_irq < 0)
 		return dev->dec_irq;
-	}
 
 	irq_set_status_flags(dev->dec_irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&pdev->dev, dev->dec_irq,
-- 
2.17.1

