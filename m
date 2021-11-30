Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16656463109
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhK3Kgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:36:35 -0500
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:37443
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232938AbhK3Kge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:36:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjTtQ4CPntvd9R2GbnPZ0MB0ytxgjXJcA8wwnqZNXbQcvUciOag8H4qcHh1RwBBw8YRVxhiXjjEqYDqk6pej1kDcvHWhN4jrer9vcNDiX7/HnLbfe8FsEDievX2IBnU/ldLRUWAF0se8aRU0cn9qg4VBhDhBIDoeo7ZlnjOWo8bIDwzRa/Ns6WYtcmeAwVJNVGxiLZn17/pwPf3NleSGPnNyYkamO4PQOJVVD4vo84Wm78KQeR4xCFBKtyaJJvrZtxZCgLBgjPVNd6lGj0TWLJGlAs46UOannZKY282TrOEZ5FAHFmV0AFgzkMRahkhyYkPdRF/iDklVILqmhE+zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOWTkGPxGh+czDbrDfiVif4eO7hIxiqDeBakR2vIPu8=;
 b=HMCYK9kgr542hmi4SdDi3UnecTmYeI/amKYCSfweZNEpC7k3+p9s340tMKp4bC5EJQb556UlUguheMT1tsJ+L1mIhKkmF3Wm/pBRRcfSO3faPjJZ03CglS6cDFos9+Th41eK51Ov4cZ9fbpF+swFLgVGS6b9+nY/+A45+b49RzZ7UNeCGk7EmRFEDFvcdh9lAY52xnDCupyT6WkVXv9JUnu/WNZeedxfeHcqzMfVYp3hIApfJCV7cDAKmcNQzlMZjeFkA5xoQ/lU1X95Wxey4CBbmy+Qcfz/JBDdkHrmxDbnBjHIKBX9sbj3do3DTiyQF3XwqSBzNskazjhfYbkfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOWTkGPxGh+czDbrDfiVif4eO7hIxiqDeBakR2vIPu8=;
 b=heFfEg1Bc7E0fthEFG3oeLKrWAHT61yY9gQQDYrDKKJ1v1WYkZ3T762vE146p+1jAGLyYh/0+2ylHgTB0NrjnBrcBEoSfEQMzm+GlX/4R+s6RViNH96hrLWsnPbepHingLjrntAJsAWOJRExbqoFdalJKHyhYwcdNGL3D0AX0/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com (2603:10a6:10:24c::9)
 by DB8PR04MB5593.eurprd04.prod.outlook.com (2603:10a6:10:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 10:33:12 +0000
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::b82d:5b87:e781:4f6f]) by DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::b82d:5b87:e781:4f6f%7]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 10:33:12 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V1] tty: serial: fsl_lpuart: add timeout for wait_event_interruptible in .shutdown()
Date:   Tue, 30 Nov 2021 18:30:02 +0800
Message-Id: <20211130103002.28332-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To DB9PR04MB8411.eurprd04.prod.outlook.com
 (2603:10a6:10:24c::9)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SI2PR01CA0004.apcprd01.prod.exchangelabs.com (2603:1096:4:191::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 10:33:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98218cb5-e310-469b-dee5-08d9b3eccf3e
X-MS-TrafficTypeDiagnostic: DB8PR04MB5593:
X-Microsoft-Antispam-PRVS: <DB8PR04MB559339B24097BE16EB1D3A0292679@DB8PR04MB5593.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SyZmPHCoAITgTInqMYG0Bb/EUxWHJbnXIaZq1KJ6XAlUpvG/zOP4QNneZYgpYwXWK78fg02eCaeTLnW+6f7bJPPyHRJsEOHl8eG5kFMnIxQRNkn3J4x/VTZtqLCacbIY+o1hp7BwOUy3IgmZD0/NaF62y6059gWM9OWE1UWvel+8xtWQCcX1/iMWxjejgh8tm/w0KoZcWebbZ1EBTJUxz1j2jtRU7uSOaRe0fMLqTzJMUi7Wu+QY46nzIIuJDQpopjTGG9fUEolo8uN0e6pSdrlANEfGyhzAPauf4/cBd1/YZmI0oirBYAgfWodxRXx7WNIgRNy9XrlQXp8dFji9fbCzV696k3+qK/qLgpSTeC8MNetEPQ1zp9Um28bfFHCaaTKUsVafMNLvjd4JF9wecY6aqVByY/Xje2TTGBNgbJBr8N+cpIntuPIY8tB3V2URC+fVeh7CAD5rnI1zqqQt2HEWjYne88URvf5sCVQZhysRx9IWZPneeDE0b0geMsormpOZTzZmThCHJbL2TqOyoPmi32lnFWItDK45qoBhXOwOAMQacCuyBd5hFxNCMcZ3ye4gYTEaNujcr/3ByTcDZDtqgH0NzOZ23QjWKHhFQ1LyNa4B+nXL+NAkySyga8uJimVhslUtaclRNY8a/3rOdjelnIu+tF9xK+h+tr+BODEvRTR0OjmaWSy1wWoE9y4fzGug2oH1/fbNQx5SGqs4WhgcrJmFdfjMd94pY4bz/Nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8411.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(956004)(8936002)(86362001)(5660300002)(66556008)(186003)(83380400001)(6486002)(2906002)(6506007)(6512007)(38100700002)(316002)(66476007)(508600001)(1076003)(4326008)(52116002)(26005)(44832011)(2616005)(36756003)(38350700002)(6666004)(66946007)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NH7q2+iEHzuLq2lU5XpoxSiOCunESh/pV0AAj/V4yciy9pXxa4Jgfu5vtA9y?=
 =?us-ascii?Q?GPlsRB3bZCdDZnBZCgGtRoNCN+eyYffVRFxA3nfys+yrYf+plQxcDRP9CFsy?=
 =?us-ascii?Q?1Mq8zDS/BG35fuEuwAcubu3DizOfblXPpRGL3mjXzvPSnC6Gz0AOK4/V7owX?=
 =?us-ascii?Q?cqBd+5jEeZ4kaczVRpntXxHWKjoajIpGeCotkG2POIweQhjm1TmC/pU+ZpnL?=
 =?us-ascii?Q?HiYoD2kh92SpLtmpFFKjEDDOKCJJdhvld6ulk6zI+JTjl7B9ebDtGs9599iQ?=
 =?us-ascii?Q?0MXfqVzJ5pJMbzHslNcA3cy+aar0SC9XkHFkm2af17EXMU0t+1ZE0c1ruI9J?=
 =?us-ascii?Q?yo3kjafH6aeYPCiMyR33KBFqvu8Oe6IjDAcC9CCvikvm+ef4fUu8Vm39Ge0I?=
 =?us-ascii?Q?PUQN4wbld/YRCtJzG/fN3ZZGggUmECWMguSrQI3rez4Q5b4CL1rCikD7HESa?=
 =?us-ascii?Q?Xi31wy53slA+pljIOUBgxHUxtN/Q2GXBmMbtsTFlNCkaJv2kCKyjmjYqrlgt?=
 =?us-ascii?Q?9TCxnHmC4DdsGaxP+c7oU98zLKCbCUY4b7/bP1hS61ITIMjhJg/45r8er+T1?=
 =?us-ascii?Q?Q11viBapcAdPHJRn2lIy59FKyIfz3ypGHLEFX+O4n5g8MtwGRBu3rrj61ls3?=
 =?us-ascii?Q?KfVm2cr2MXukuZzLW6KU0ZTNrAzuVOBP7FKt/dPscFWk+YPIMVO0ysjlLpf/?=
 =?us-ascii?Q?WV17y0eyJiSSGWLVzdace+A/nb9xHmYr4KZqSF46wMEUpUJSZiWxGbyiVvWZ?=
 =?us-ascii?Q?17KU3Zo26lSTmJv+9inIqZn8sDsldTdyRJDFxgR5yTxKkVDgZeZSAHa5J/aL?=
 =?us-ascii?Q?OQUeVzp2wKVQbLdR+sQVxj7/Hwbkl4QpRXLdmyRsZJJWc/99a+o24C56PpQb?=
 =?us-ascii?Q?kgiT9pLFpg7dqv/imuEFSC9jp4QfFVqLLp0l/8B8/AjND1rd8bKi0ra8+lhQ?=
 =?us-ascii?Q?NX/7e2niPZmQMJJen2gSjpIJMNjXQdC2q8jOy9OLXJwATVNLQL9Vd4Lf1B+O?=
 =?us-ascii?Q?kB+pTf15kRsvjSgK6B7xQGJPI6/sdQpzURtFQ6h+ge5dc8+OAAsNcgR/0yU/?=
 =?us-ascii?Q?cllOE8mb5Ffmt49XzGmCRxgXnJeKl2QpthdZDk977FQmRpUDrniNGG7oUppc?=
 =?us-ascii?Q?cUG1z+eLkXRhrD1BVjkfZXSSfOHimPGtovyjkid2mmSGojDSMZflFQTiGYAx?=
 =?us-ascii?Q?sSlsFDpz34Tk/J6Iot2CnEtByb4J76Vw3G199v3R93BFmd8zUv0WW2HJf//f?=
 =?us-ascii?Q?+XCWvLVsgfQZRYaGg32C3LCzpZmbjOZPSme6cukq1CnklsdN53+iW0oKI84Q?=
 =?us-ascii?Q?Da1HhLbRHmfC3W8cdI1SywvFE/+yw9z0/4fGSXF/iZfC5931A/GL2xg7kzzS?=
 =?us-ascii?Q?JCYsSbkv0hwNgIzkwVueSxON9Bhoxnt2Z0saDDLnxKKrhRKBcIJGSpegY0km?=
 =?us-ascii?Q?aVcpE7bP862myaphPLYdgaFAaIKQ2F4nHtwb7/MOjk6jgME1CzMaDxIyoebt?=
 =?us-ascii?Q?nBMwYLv8eUCBNDAjRUKBRTJUmEJvuuOZfC5G9uGsAjpt8RLpjR1Vpqf5Kmaw?=
 =?us-ascii?Q?2ZV7YX4qvsBtaR8/hG/9ZCH8ryrMvcMOA1WxrAaF20EZ76FhIDYoIXDnBVHL?=
 =?us-ascii?Q?01onPVgpPIKHRgkbyUg/5m0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98218cb5-e310-469b-dee5-08d9b3eccf3e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8411.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 10:33:12.2842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3vfXx+4frFIqS67WltpB/6bHX5JrxStSZxf0vw8JUzg5M/d5KSGilF7XCctLxrbDHCdnvWn15leSHwKpIeGwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5593
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use wait_event_interruptible in lpuart_dma_shutdown isn't a reasonable
behavior, since it may cause the system hang here if the condition
!sport->dma_tx_in_progress never to be true in some corner case, such as
when enable the flow control, the dma tx request may never be completed
due to the peer's CTS setting when run .shutdown().

So here change to use wait_event_interruptible_timeout instead of
wait_event_interruptible, the tx dma will be forcibly terminated if the
tx dma request cannot be completed within 30ms.
The 30ms here is same as the time waiting for the transmitter to empty
in uart_suspend_port().

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ac5112def40d..78b2730e43d3 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1793,8 +1793,8 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 	}
 
 	if (sport->lpuart_dma_tx_use) {
-		if (wait_event_interruptible(sport->dma_wait,
-			!sport->dma_tx_in_progress) != false) {
+		if (wait_event_interruptible_timeout(sport->dma_wait,
+			!sport->dma_tx_in_progress, msecs_to_jiffies(30)) <= 0) {
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
-- 
2.17.1

