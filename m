Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7814729D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbhLMKZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:25:37 -0500
Received: from mail-eopbgr1300109.outbound.protection.outlook.com ([40.107.130.109]:9906
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236748AbhLMJr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:47:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMtxs+4i6FsvaMXD4QvGkIRk5z7L3Z5v7ETXerBa86HLqvVRzmLsXjLdcxkufjE/RQGBYx1yb208XJMYkLO1kbC/Gks9l8f/18DXnUd9AGG6py04/4RXr4aBhd3F2DK00CNexV9isHAHPm6YufEqMk14nXByIbnwjdtV6GVlIKpuNllL6z0erIg2iefjYv7EBWcQnIX3vFocbrEZnMqJUeYRVe8flO0DxoF/uxHq2PJ4QPpv73ZUAgjWo0t/u9Vb31ROf9Y20nwLGZ7+yz8Bw86tV6F5flRVj9yP9HV0BhnRKAiM+jLq/Ei2aKFaJSQ+Tb8Z8Ayv0dc0UgHBiV2xQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdBQMSDMDyKQT07xS0aRoF30kNJqZrN9OhCx4/3qop4=;
 b=Ay1hfFgoMvB6fubb+0hvYRsmCTJk9EuB22fwgzvleHCbqbg4jpwUBom8OBSx9ghT7lLzmSkbAu5no8DBTuUDg7/nf003LVPJRikKZDGhVw4WugA7xFuZfo8QYL2Gy29UtyJI/i1yBULw17+28vRegNIeSX36hJrvSKRR4wKF1QAD0q898Q2zIc5Aj34CWyLJRRcTeV6B+fMvQygaCExkiVSe3g4rr+6J8Atm7Sahv85LmnIsW5pPdeUNlQ/fhs9ssdIaPFnWTWYrAoXT9NyXqdqTtla26k4YO+IHz0E3k/AN8g1XgVu8FC67wbELiIXIFHyaROEf6HwFWhOmBghEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdBQMSDMDyKQT07xS0aRoF30kNJqZrN9OhCx4/3qop4=;
 b=WeyWMYGjN3TWj2ZWkYY9hXC5PMisPX9p4RACRT2+9qY/ZVruB+IvsuLxNz5R5xEwO9tNsKTw2uyx+9thecsC9J3+pr0Me6yLiPaw32xUA0xEObWvCxiTKe0yFzK/cIitNviBiXJLpXeaDrm/02An5l150tWGdNQe+2Zd/J46+Vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3050.apcprd06.prod.outlook.com (2603:1096:100:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 09:46:18 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:46:18 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] soc: dove: add missing of_node_put before break
Date:   Mon, 13 Dec 2021 01:46:09 -0800
Message-Id: <1639388769-64240-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0156.apcprd02.prod.outlook.com
 (2603:1096:201:1f::16) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68ac3152-2bfd-49a1-2e9a-08d9be1d6937
X-MS-TrafficTypeDiagnostic: SL2PR06MB3050:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB30501E7C28DFA83D5076D1BFBD749@SL2PR06MB3050.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBv7C7qX1X7AE1RjEKg7XNtPwejYF0sJvK328SJ7MBPO4rwGDJf93LHUJHM+ZrrlYwCMtKku94gftLsT74CBXe37Fknpm4sngLE4sbMF0Vuy251l/uhEuKcxnWPopjjsS1aMdHYH9yN/8DhTywC1Qz/GPMlNLeOLj8thlf8ndePb0+Ur3h7hWvyoJG/pANUFte7SfJT3NrR3RlHEq+Za8KLLmdqgRRZBJjUtoK/co2ft1Gebo5VnyGtYuMYNTWfq/QlGrgF6+QTUDrFCIhIlDDk/mA4rJ6zK9N0e4dBitTHC54NiRPg/XrfuceNyePFynmmEWXBzLdPt54CQywJrtwYVFr6cEQdW6y6TSc4MvIuJg5K6HBCIcwNVIb8mOuqrHGyUmFPN3k/O3LEmbzEBQNsd8zUQrZyjBKZ9zjKP0+JswOe1ovNdeSQi53uZWXy1gWDQnP9LBlwQFZsjghqRrhw7r08xkhheAg2GTqS84Q3hXUfV/wZXbGvKu87q7G3aopkv5jbhoRcCPayrT92dKoulkLnmegyFmeeswDFx8sAT3ybXSttZBSkLFVK9j9RK77Yed/WP1a+RztGZiOoY6yXsDy4VvKw+qROlTmNSG6UnJQ2HD94sdG7q6AGDOrl9Ff6f5+FPXI5RlkdJ9cn93PEIgpl99sqXY9018fALwyLRlyMLK2muJugwzlLdBxyOl7gSDQAwd9cryUbD7U45tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(83380400001)(52116002)(6506007)(110136005)(2906002)(316002)(508600001)(26005)(186003)(66946007)(36756003)(107886003)(66476007)(2616005)(66556008)(8936002)(6512007)(8676002)(4326008)(5660300002)(6486002)(38100700002)(4744005)(38350700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GB7RPRO/vxOO7LQ8vEQyBbJ1a/1DjPYMmr3CIRKtZP2Ly2fNKpXCXg3PtFP1?=
 =?us-ascii?Q?4iVjJWNlf+Ktf8hqN0vdUtJK/c5lvDuwOBa0+eipnG1GhusEBNhEiS2pK0++?=
 =?us-ascii?Q?iQETeyU1sXH0EOobm0v2fzZvRs85fpiaRCPMYiJ6N3KvnUBKcCWyjuXgQkxK?=
 =?us-ascii?Q?7VtOqta8qyBJHbUssiCaX14WeViE1DoBeshGMYzZ7Z2a9zencHj5HwwL6L8O?=
 =?us-ascii?Q?QK+QHKFpMOUmC6ezhKxRLDqtquPbF4QuuVw0XOFdB4NhGdWB+CDjd+WyROEZ?=
 =?us-ascii?Q?Il4Oinh/H16V5LNhNswqbmq9Rk0uFOLev7rbPoZXHyVwhlPKAlLIo59Oj8xU?=
 =?us-ascii?Q?R5Fyyyjl13fOWpdCdeuygx2A3xhz1wCmUAMroBJtpV03AXpOq5BPJuANhJ/y?=
 =?us-ascii?Q?UPXJfmxpH5KEYvtBtFlP/y3I+g0boumVOz23XMkZSexOhHRRqNs6sShjdz4k?=
 =?us-ascii?Q?Zc7SOjDvwcmScIhf23JeiePT0EwJXK/A+FlQUfJkRpTEZ31SG5jJuuo6oNod?=
 =?us-ascii?Q?bCznEcY9KWftBmtfUh3LgDXnHpuRmnQ0aUfX8i2Fh7g53EbwG0ipq149B29B?=
 =?us-ascii?Q?ekQwl/VzB+niafGLyxfgSCbku41dSak2t0SqP67mMlV0izzVGx6gp9oRyy2+?=
 =?us-ascii?Q?qF3BMFbxcyZl8E1mje9YPDevHDZI9JvTFcaAyKcYQwlmRqTFhfL+bVsJ6XXd?=
 =?us-ascii?Q?3TlyEB7obHRCZf8EBg+pNYosDmMB0kTlEyeTE5pcVH2kPTAVZul8cJefuw1a?=
 =?us-ascii?Q?QHjNr0qIjloyBmtZzXGvwEg0vHCE2U+IKuM4Diy9Gf4HIKSgBEsuZzRx64Ly?=
 =?us-ascii?Q?HrZp1Ax+tzToSgtEfC1vMVbFwdYAgGqYvr2ByjO05ZmVwi1iFCGI8UMZt8Ol?=
 =?us-ascii?Q?0VrJVuhcvw2czFhJPzoxOMM2qpYF8kZDsRAH2rDva1TpdjfeykRRDAy96X33?=
 =?us-ascii?Q?svqYLTN5KR0Ut/SCsqzQtDaUSb6GYONAv8wufX8bMVXLieWDi/Ol44eNIZ4Z?=
 =?us-ascii?Q?+glhv9TZZcHsb3SUZSLb5gUOcscaH83EzX/TGq/d5Iw10CKTdxgQT+lviP07?=
 =?us-ascii?Q?6bXI6FajaHblb432YV5WbEcZMQe8jNFgn54jES+o8Pzbu8lpa6J71tMRM0m/?=
 =?us-ascii?Q?HigbUDtil+PkOEKmN8quUDKegGY1g9KbLe64uGF/wroAQVxjLRc9jbXjSy1e?=
 =?us-ascii?Q?2JOUINobO3F/162uHSBBNa5T3K87j0Os/A5QA6+EdQ0WVej37Jde1R47iPvA?=
 =?us-ascii?Q?XF39MkKxlUwg8CYUjh1Ky2Xntvgf/L0jkyNcMhbLjoON2SHeiOZBe8VCuIXc?=
 =?us-ascii?Q?dbJaHlZMTrCjejdyy7XdvqxvAKD8mWBrO8+F5NjUnL7DNmL38LGD+oekSpWK?=
 =?us-ascii?Q?5p+7g/8fPJl3SYzRJBMyZ36MCiexB2pqCVYFJAkhN5VoWFfemqVRrfNXdHgI?=
 =?us-ascii?Q?qVD6SAyadt+aiNIcsTraqmDoTo1NxhoWb3g+d88TIrfnm0vTQ7u79gZ9Kffi?=
 =?us-ascii?Q?/wMDEvzyEgBdkMAxwMv+MhUGSfWZiMF8Watxrfxzl+tl005mE1DmaUb6pOvs?=
 =?us-ascii?Q?jZUMW164yET3fZRPupMVA6O8hK+H1JTsNSbpL2QYleTXm2OaK9MiqJoO+tLa?=
 =?us-ascii?Q?Ufc0eAS3qAdtgtxU4kIVCCA=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ac3152-2bfd-49a1-2e9a-08d9be1d6937
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 09:46:17.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwLlrWTUHo2PWjbPDxWdrZu1DSkRyAGULX00azae0sqQhRFRY9JAHDXH2TXmvgtN9kQSXeFuniqA4PLgFoiNmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Fix following coccicheck warning:
WARNING: Function "for_each_available_child_of_node" 
should have of_node_put() before return.

Early exits from for_each_available_child_of_node should decrement the
node reference counter.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/soc/dove/pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index ffc5311..6202dbc
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -410,13 +410,16 @@ int __init dove_init_pmu(void)
 		struct pmu_domain *domain;
 
 		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-		if (!domain)
+		if (!domain) {
+			of_node_put(np);
 			break;
+		}
 
 		domain->pmu = pmu;
 		domain->base.name = kasprintf(GFP_KERNEL, "%pOFn", np);
 		if (!domain->base.name) {
 			kfree(domain);
+			of_node_put(np);
 			break;
 		}
 
-- 
2.7.4

