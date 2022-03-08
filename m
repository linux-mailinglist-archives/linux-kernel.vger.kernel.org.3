Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249844D1391
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345400AbiCHJmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbiCHJmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:42:43 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236CB31511;
        Tue,  8 Mar 2022 01:41:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJQJopKIiUCz6KQd35ggrULxUwY0pbbIjeAwNvx5z1gP+/DHfbcKE0Eg88OWtZv9tP1zlrOoTxM5adhvIS0M2SPNcht2CHa2AxsEkLVsBapfQ1SS/S3KD0EBCk2rV/0296j4EvTE5AogQ4QSlmvQP4bZJB4+D0RF/mP09MBktHdJw8tM1fC5Huh4eiBZn8c24hpofHG9hKinx0G237kKgXuwjVFBbpYM2xGjPH93KHDS3B8hzgUgBaqbF42lYpQk11NqGFxmFRQMGYl8AFt//EAt7oz3ZcIdIeQ8f/0BNkY4LYQiAnawcDIJT6IR7WFbCEjU7BaGfqGK2jscIYdPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yROS83S5OQ5l1CEeh3TqW/pmrTnPa/mZFQ+IT5hYC3M=;
 b=ocnC6V8pDD9KRjmrXeNWnUHRw5UlTkegvbH9yg6K9WrJIY9BXi7BWvIUAi/EQxc9AAYq+bNt57yi9sKHbJiJkAIspSHS/p0tPe2d6UieEZEuksSsWPfK+vMr3Ybsqj80uMjtgouz3QjWguvKzVTONs7vjC738I+BQgn9HRVJ8sK7VXcUlZ/wcyTXkJyt7Q7KCI9dZnMLEdHLObaa/GToo6yG+WDzr5ssFGt8oDrk92D18rl1FFJ0eBcty4upfuXKXEuTyWHa2Qy0cUukeLG1qSVA7tdkO90vL+eK2tWclmxKPeZBey9G8Z5/iHm6ZGFcq87z4m8YcRL+B/dwYI1KQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yROS83S5OQ5l1CEeh3TqW/pmrTnPa/mZFQ+IT5hYC3M=;
 b=N/I8mETrysdggG7HBawfo5mO0MX5lacfaECOeKYAlCOczZD7UGMDMOkJ+4NCB6ntj+pS2+Z12wpFO515Cz/t7taA0gZWS+Ute/63lSG1q9pjvtEpDRV1GQUWihkrgGZF1IVmBfZvgpGVhRZam4AlcuqU9EMk1MEnSNNqQ7LVWSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by SG2PR06MB4956.apcprd06.prod.outlook.com (2603:1096:4:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 09:41:44 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06%4]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 09:41:43 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] media: vidtv: use vfree() for memory allocated with vzalloc()
Date:   Tue,  8 Mar 2022 01:41:32 -0800
Message-Id: <20220308094132.2736-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b6a438d-2bdd-475e-b681-08da00e7daf3
X-MS-TrafficTypeDiagnostic: SG2PR06MB4956:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB49561942E912A49EC8220248A2099@SG2PR06MB4956.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErtaRfbRT/k7xeR9xwb5zsETfl9DJJJxYIF4EVkMBn2AyNoY2ugNzHJqqrZhBYf9Z8fo+bjoAxNAkka/awWiJIzvHe9zmvVO0Zxj95MOsObP5K6VVwnDYELQuO3HIbI8qZQjHjGlaoFYmhl5O/Ws7R2dLmyxa+hxhb1rO2U4bf3/U97VGr4l/3KV5AQ9wemalEz0NXS3qJliEWHh9/X5KscrAPm6O94uAsGhLC8DCfx3BOi2Zz8zTccTGyPzT+vzx2Vi296Gnim0gzD1O+j6iSm0uUM+AfwpQLwhcOKZls1BSFRE67fwxzovX9Cwu6lRdHOD3pIuS99tGgUXuXHGK5rgSXoAF93oeoiRBdlqN91mw+zyoCUDyxsDnmRvZ5fGJFfLFa5ylvt6blLg5eJLcVZcRmcWnf76Z8RuCeP/rtIgL59Nou1kWa5ip6MppmVDc5ENzB+nUolfyZ1JiEQ9AEc1O6Xs1uRPvDFjLnU6NiB/piKrCG35+XQazrhrcvKGM6owQ4MyXXjJG4mtiWJBXoVBj7dlsuhj4ivCiu9tteV5w/xjpjcUwh/oxPHFmxQ9c3gFizje5B/N6m9b7b3wBe5QgLNPPsxc2+MuhKPWC8NI41xkVlog3Fi8DyfHciNKRiUVu5jqAUzvL5Dlo8dlULDbAU/3f4PoMrD+mjherN5bSvQDS/OgEFtGR0kUGeGwPJzKI1Xf6J/wSvPnEKI6jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(8936002)(66946007)(8676002)(4326008)(66476007)(66556008)(83380400001)(86362001)(5660300002)(38100700002)(110136005)(38350700002)(6512007)(6486002)(316002)(508600001)(1076003)(186003)(107886003)(26005)(6506007)(52116002)(4744005)(2616005)(2906002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+vYTDWCB+8XG1QSHAFki4ek6AGbTEMXpoiDrhxbelDvqx1HbLbMe/c+/bI3T?=
 =?us-ascii?Q?D9paIjySgOE1i7HaGOl6g/lGByA5OFqQ+05l+r89m9uV3pIvvm1xeaO+YoEt?=
 =?us-ascii?Q?9hwC/teYPISC9r1vAUAtQ03U/h+wb27c2MKfEA9tTPBJigvuC7rF5a+NhXqu?=
 =?us-ascii?Q?bOH7tY5/f/kQe1Xw7aQ8GrqLnVgnofglsgUIdxX2ZEUxVuOEGYHUNQlUJMUa?=
 =?us-ascii?Q?P/0nTbCdbnkaBxfDM6Ju/bKqunNri8qSsRJ+lfd8a0ok9OHXb7kjy2FlPPx1?=
 =?us-ascii?Q?qFzpemQWXkxr/LTmLvCwerqyXRiOHCdv7x5KVJAHxaA+9q2Qv8heHubtU5wJ?=
 =?us-ascii?Q?HKghAiKqwMZo5kkcsLEf2Q3/jys/0OtSPsK0RqKVgm08j3SH9C/O+L68k0VS?=
 =?us-ascii?Q?K6QBriFWzOdBalZGJKIYdtnpka07b+7KcFW+ydqMURkWMXAtNk+7ENiXc6wy?=
 =?us-ascii?Q?WNMfYiM2ttBHDAeD5V2G/SVwLmO8U1FOI7qe1oiOzZzJInN18IMI5O3QyyEM?=
 =?us-ascii?Q?vlHEnZNOnJ3ImDkZzt/PkFVaQbPbZPFYHXSGkTb1nxxx3ujtr48rreBh1nvh?=
 =?us-ascii?Q?bz3Sk0r5tru4HFWO0qvZ7XQjojWq48Nl+bJibIPi5cQWCvwxmtvTHruHylu5?=
 =?us-ascii?Q?o7zWJnyoT0xCMnxtjI7EHntoQz1rWCpQ1IweM9D3LnDtukxQM6FDGQEJmTrE?=
 =?us-ascii?Q?exXCIizDq1qsyDKlI8GUuwh0Hh39VBCHdxtiirQ2o3M2uxlje6Awg+ThuPC7?=
 =?us-ascii?Q?SMof2xW6aLH5SZtJoJ2hALF93OayT0am8mAiBrkdxv96dKf/6/a1pbH3QcrG?=
 =?us-ascii?Q?WeNs3yC4EBIu4NxDx3D/I+heSiewxBaAX4QSpx4FQYfUH7LdyOB+MBtzkNt5?=
 =?us-ascii?Q?jTzDu1Em4dsP0buNhMVkbuq/dE1+fo9FcXS2+GfgDktzRTi4GSArph6rvaFE?=
 =?us-ascii?Q?DZrZ32hVQN8wmhCqM3feRJRzBXjgzs5NkH9YZ5gMGFrjHf7K69l3S7h0ALei?=
 =?us-ascii?Q?mKqrfSv4Jde5+a0Yld5E/FlCxDKrycLsFFEerkltA1e5lF5ekcKkMMeGpzZx?=
 =?us-ascii?Q?OcvatEJxagqYnLi/qM0RiFDXQqqVW280LZS4t3Es9PZLboR+7cVNTh41ftsg?=
 =?us-ascii?Q?MFezv1KiLTtVINQlOTpRApold6n2B+vNF8CR3gjPdM3nSZSyqt3kC+afAJX3?=
 =?us-ascii?Q?eMqeRFpIi3H5LNwE3bB2Qb4+PNjhTfEfSvsumWr4fv8MleIJxo6dL2rAM8OK?=
 =?us-ascii?Q?opNfchQpDP85rnxRDL9Q14INpcmK+98SmCYxv+B76U1EJVet2I6gk6Za6Bfe?=
 =?us-ascii?Q?fm5zfbfrJ18RuVn2sKBj43l7IAwuPFiucqQaqsoxqFT6zVWuBCY+nbTTRnkj?=
 =?us-ascii?Q?zTKWk4FrJtqaRIv1wvUGav2JooBtocuEkeNGLlMXu+1yqJpcn6kl6eVoWypC?=
 =?us-ascii?Q?DVKzSGJGCejjhNEboro8zhakTmoKQxxVqfKAZkB0cFPpM7C8JXOK/53aeJBz?=
 =?us-ascii?Q?qYu216daMI8IDj6EVuWOWnuFWtxKPf2jeg+vFbjDElFTpxys8Vwx+s+5Fl3l?=
 =?us-ascii?Q?UsHNEbPybC494IW7Gh0J/OQnu1wmw6pS818bvBwlg+vsljfeOKdsUxwabWmV?=
 =?us-ascii?Q?W5hmSVaigxcyuLKJCtRbSz4=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6a438d-2bdd-475e-b681-08da00e7daf3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 09:41:43.8759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4s4yxXujTfIoBBhkU4yDkeUFNF8mGrZAw0w9WOUXakySGeAkrUe2Tuzzo2uYVaVE4SsQhHZgplDUHkIdFN0mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB4956
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is allocated with vzalloc(), the corresponding release function
should not be kfree(), use vfree() instead.

Generated by: scripts/coccinelle/api/kfree_mismatch.cocci

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/media/test-drivers/vidtv/vidtv_s302m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_s302m.c b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
index 4676083cee3b..9da18eac04b5 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_s302m.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
@@ -501,7 +501,7 @@ struct vidtv_encoder
 	return e;
 
 out_kfree_buf:
-	kfree(e->encoder_buf);
+	vfree(e->encoder_buf);
 
 out_kfree_e:
 	kfree(e->name);
-- 
2.17.1

