Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594CE50D0B2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 11:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbiDXJHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbiDXJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:07:37 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2D117770B;
        Sun, 24 Apr 2022 02:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLJD7ziHL5iVqo69s9ou5u/T+VBHuwR80L+iLONwjRVo1xKIfVmfKb9f4lJbtUCris1ps3i+fMZRIP1PJ7Vntnt8znceW5Z7jxde2rR1PuKvJCaJYK5ohh/VfibaawzTEpDyurfU851i4NkCw3ShnOVk8sukVqlIds7rRWqCkxecWIAlYzY4+fig6FmtOgirpFco8s244cHOGtV0PjzCBZCAoTPpMWAOqB3eNbW0QPlkeEBcoXwOERMxprhugLL7Wml143F+Bydh4FIB7TWbTKk1EnqdYVHbUyAVOYUvgXXQ4HSY8JnKvY86uhkYzrxOpchvlN8czS7SxSQbWupGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gnEAXdpXP71byyrT9gvPlXxJXXKjacWqFJ5AHNv7jQ=;
 b=DxrdCKz3b1uXJ+wfdk8ZLUjbTiAanDaboRK5D9YyxrJ+A89Or/23SwAa45Vlw+AqL/uMhFBT8NZGEjxKuuHrpbrVom6aR35uNN2RIWnaVG8+IVYdlRjkXrBzX6Jo6zQayXMvpA59ezlAcrwnrkKJB/6sNzbz3vP9NIF0NZowCLNRvoagNFG9i17sXQsEtH8Gh9+lv7rlkWyb2sAHfkkqrG/fCMzW+1z6h+cLt0PTNvBSNJxQNz4GR2KbO4kQ3M3m7DjUz90QsIIs7akrsfLIS3UgpLWrVsDgCEFdAiXKkvVpjhspZFkugnyReUCAJddCm0C0O4Jmh28N7u8Yyus9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gnEAXdpXP71byyrT9gvPlXxJXXKjacWqFJ5AHNv7jQ=;
 b=hR4PTEmWEIFZvsHPKjiXkRaR/cxCXSYXUxwWWGxBipXdSYS8ejUXFjh3sUKh1CrUYpA7FpmQjAgINo/5idC5jwrp9vqxAQCTgLKPdRMp1NGb6lrW1q/Ly3RwJjQrZ+QX9AsoJbv1MzCqXGyLH+ei/fcRzMeu4k6b84R6xChzIdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK0PR06MB2468.apcprd06.prod.outlook.com (2603:1096:203:6b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Sun, 24 Apr 2022 09:04:35 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.019; Sun, 24 Apr 2022
 09:04:35 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] mmc: atmel-mci: simplify if-if to if-else
Date:   Sun, 24 Apr 2022 17:04:22 +0800
Message-Id: <20220424090422.97070-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:202:2e::30) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0921e593-08df-4aec-72db-08da25d173f3
X-MS-TrafficTypeDiagnostic: HK0PR06MB2468:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB246805C2B864C00DB72AF443ABF99@HK0PR06MB2468.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYYlNi6SMuyYdZZ4uENYKIg9U51CABZ6Ta2W8VWxKNGbavo9s/dsvgm1ndXRasLpTVbBK5f1OrdDU5YhIhJKzYXwPYbgEU06xwyVFCAzM7XAc9ljFespiOXqjVhe7FbJb9R9eXxj4UuthYxk7Ivx0VNV2UT2xVafbGmtL3qoCV6kncwF6DvXwOW/Sjygp0Sjh+lF5jOxCuOQZA7ER41bsR9c1nuLlGjSZpivatuvAohMGSljVnQdPidWpBvvr/a1wmCtACxHy7P+MXK13ULLmqPApXV0QHqaRKybB+N+toPdjvMEuAuCa7CfbKvxb1+Adtsw90ab0YqAF6AN1c4KG9tCrMoE6q5Mdc1R/StVhsnvxzJkEm/4s89fWBsgfMxGd/eD91I6+jaFvIGyZ8AeoyXH12FT4cFyZYg65IIdjOQWxOAqXzoOVTwYWCObDaT1nt1aVUjagwF8q2RBetXjN0rIv4f5pBS2zev9Q3SSVQ3LmCQ08DAgu1IP8KOGSPQfx9aHckMb1KO1kyT9rqycoonYgX3kbC5rFlBZk2OjKea8DQ+pIdSAdFskSS6g9op5R3dedj5HkpegtLjsWJrh5PxEFYnLKRtNBPOwKJNTs3CwkKtPSmrPCgveXY9+DVcgO7pIlKufmeoUBIq7UJpp/6xrdA6eOsAyJf2sWG8AQ9OUmHicCAFz0XWD6hBsUDadqmlg2w5csLbrOa6X9YhtkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(107886003)(2616005)(36756003)(38350700002)(38100700002)(1076003)(66556008)(316002)(6666004)(52116002)(66946007)(66476007)(8676002)(4326008)(8936002)(5660300002)(186003)(110136005)(86362001)(83380400001)(6486002)(508600001)(6506007)(2906002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9zwCudj6vu1jP2lkMTcTjl2vnNW9kvXJs4CJYewBXTq6uHxdVgk4If3qotKb?=
 =?us-ascii?Q?CnpQ69bOZvBKtGiHXCfNH5CAgQhaRN58wIO0G3ro84DebOGWeeT0dotriOap?=
 =?us-ascii?Q?uqhMi0UY9fMHRr0ALViaiQxFZ28+oCl4diskFR54SySm5r9woAHDxuYxvqmn?=
 =?us-ascii?Q?20F93Nl7hZVTX/JG/gaij/vrOOVSEWGNi0hNYi4wsbH4DsJcuXekEz1cXgSs?=
 =?us-ascii?Q?E01xnsNS6kld8Gvd9Td0md1e64Zbk4wV51Ec3Cp2rUZcbADRHAcSDETOAYR9?=
 =?us-ascii?Q?btSDSkWui5wCY0+ohM//v6qu2IyBeK07eM4TEFfZ2pl+lQs5Oclu9biYFSrL?=
 =?us-ascii?Q?dWVvtB+6QpWdvzSb94NUplIU8yhum2yKAsnsY4r0euOZZvuMGH7Bmrkk8mxA?=
 =?us-ascii?Q?Ha7gByh2uqtXrXhgu8S2FK8gtAxRw0O6ctnLt7fAjHqvC1ZItAJdGtBgQoTq?=
 =?us-ascii?Q?J0XZyRaasoTp+3J5TDTl/AYckF+W/5kQpZpLeHnUo5W3xhgVPFhvzfQZLIMf?=
 =?us-ascii?Q?RLwSe8BgUIIDxVbVt3r7Bm3xdD6DYLQR6dn7WXo/Em6YuPYkTPpeiQlSDFoU?=
 =?us-ascii?Q?riDmR9kY1ADSmh/AN67R7oR2P8sWBvTjdLSGHuqyg1hE7VPtuqQvmJBDw5Mi?=
 =?us-ascii?Q?+0kkluop19BJ/0gQ/mxQFn6sIFqIN57cspnG9SB/kaDPbzntkXJSIBrRXWpO?=
 =?us-ascii?Q?84pQuCJ48YOWLy1msqrNBHIh5F/rLtyyH34ynlraa9k0jDXBYY19oDvQ5Mau?=
 =?us-ascii?Q?t5k8OHP8SICx2Z8LaJiSaRgo+3XzKxRh5mc4TSUyx/0MK2Tv9AFGYeoGadYb?=
 =?us-ascii?Q?hGJ92Gf13JXLdyRdpA2M77CHtOt8H0O2J7U7zaqkj7JnvHH3pBUbUS9WsRD1?=
 =?us-ascii?Q?OmBtt3D/BbYihoZMACH2nP96UVEgIAE7EjwcHz3nDsrc56Zti9rv2isVFeZf?=
 =?us-ascii?Q?msapxQYTF9Zm1E4vZy/8ogpssAkytVGxepw/oSoLEzRAS1AeLWfk5NtpcxZv?=
 =?us-ascii?Q?BaAVKb1YTwlQzdPA7a91pwbpcllZ5Yz01jm0BCsDfITeEDjnfWN4nanIWm2V?=
 =?us-ascii?Q?W5kqItqaUsEJx+jUZBHjzKw5QMTHGIEX6GLmiz/Du9vAanSZOCV9tQAJRh7j?=
 =?us-ascii?Q?uWV372U2g8QNzqoNrYpszHn3ZRQoe+xOP+6jF9gRPHqNiKKljllEIKBoQNGJ?=
 =?us-ascii?Q?3Rgq3W/6YOJd+zpAFEepoPRg/iskI/g2m/UA6+M+sfbSFPlqwJBCU9LNxTDC?=
 =?us-ascii?Q?jcQl/HYP8xOvYag87YH8LvJFLh1Gqodri/kjW4KJ6IG91BDUdARnWw7BQGKe?=
 =?us-ascii?Q?FTVPAuTah5EfmlpUmXjpcpLiqP774HrV4ysA2j5U1n0lD6yHLtgRWwe9mwc4?=
 =?us-ascii?Q?gK6OHsLYhtTT9UjlE37OLo7KDO5+LxlF8y//8OTr/zi9lmF92uiGIFEjpSDS?=
 =?us-ascii?Q?pTqtytoBIzMqVnIND1mY7lykkDKSgpOJBx+DeVqTME5zDgXerKReRfMqzBqH?=
 =?us-ascii?Q?+SZ+jZR/Ua3ueqLIzHmDbfqWO9DiuGzEa4xKuwr3lZcVziEbgjJ8wbBUFFoh?=
 =?us-ascii?Q?YuGWkNEi4xasprrPG0J44+1qwXEmqbEb13NvXgF9iG/rOLo81zf0TwFOVTNx?=
 =?us-ascii?Q?XFwI1yuYzt7Vq57vJ3b45AsDJrXuA96QwxJu91yhuR6j0W2wyVuK47pOmqvZ?=
 =?us-ascii?Q?w2tb4XiHCCk+mmA1nmj1Qvi8AvueX+hbhlnrNMtFP/l4est7DpczJ9etTHX/?=
 =?us-ascii?Q?zK1T8bcXpw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0921e593-08df-4aec-72db-08da25d173f3
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2022 09:04:35.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqS3QDLxrp3k3WWte1xK66W3K/+T/fYJdiHiAMZjAYApGo45Mti9mF8798D9UxLCicHXgVFoaihDxTvdinFmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2468
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if and else instead of if(A) and if (!A).

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/mmc/host/atmel-mci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 807177c953f3..98893ccad4bd 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1125,8 +1125,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 	chan = host->dma.chan;
 	if (chan)
 		host->data_chan = chan;
-
-	if (!chan)
+	else
 		return -ENODEV;
 
 	if (data->flags & MMC_DATA_READ) {
-- 
2.35.1

