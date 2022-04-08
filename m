Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DFD4F9878
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbiDHOrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbiDHOrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:47:03 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A89AFC120
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOUixbMb5Ij0XNT6ek2h5BlRUlR4tYlHsLMemt7KoBpNNPku1pm88Q8fa/I/biKchX6jXKw0gjgEAhEa2Bv0VtkbQHklg0i/rSVsAh5A5cQ38m4wzg/tahA++1gL/1xIyVhS/x5WOs+ZVpNh0WHf+UFbY7fWSztpNs1woxDuPM/Z3BlfENzpiT3UG1lK9E9z8VeqBosKUsR2BwLBiMPicreu1OlKXO5tndAaoc8WUnaKbb7M27pdtLv2eIJnKZmqLWdr7Jo9EorkNQ8kg56tU5TMzDowcB0HLiWKdXkI0ZGmWH5lXpIbQ/8/THXfMqC+bxbgQwSL+0IIqVGSfLb4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MF95QZwPNs4rMWUFV0HU4zIBcnPpmPUNvQHRCZatPP4=;
 b=ChlYEWx2Pk7k1eE3mFSlQgcHQ0f606Z1OjcPJh2K7k1Ls+JbYdMwfeyO858uw3VZspH4xFaVPomw2k6IRMV2fO7b9bkyBNXRREhbuoi9tDuE5j90csk2aB9J1zNkM8XIEY8vFGuBJX1mwkYMJ30lCeHUd5PBFKTKf+rURnTH/UD21d+NwHTqFRsnhFi/Q9F/tslF0C5JCpRrnShxKaJYBjSFPgk8K4OJpOhNCBIfc6/oGHQAr5y4BeFqKGr5ng36ypTJXK79EF1dFfoH917+GLD3Q2LchorgvLwh83EYyREuoh3nBS9zOBwTOEufh3yx6FEV86tYjOs43jUTvnmgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MF95QZwPNs4rMWUFV0HU4zIBcnPpmPUNvQHRCZatPP4=;
 b=mIN7OJamXMorsQNzpcHOxZfohtQSwX+ylVtxQWPfUGJdc0YloHlwDubjL6YzZVOsKObWDa+j/WlUZBEO3hE3LlO2qoBnCEiy5CppfA0ySfE5u2LmToxOStVRFoKfFcfwrAt3ANdrPfplrtfgtNzJ9RUCq8rC2NcpFKA48030NEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by SI2PR06MB4172.apcprd06.prod.outlook.com (2603:1096:4:f6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.26; Fri, 8 Apr 2022 14:44:55 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::2813:af2f:32d0:7be]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::2813:af2f:32d0:7be%9]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 14:44:55 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Xiangyang Zhang <xyz.sun.ok@gmail.com>,
        Yihao Han <hanyihao@vivo.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH v3] staging: rtl8723bs: tidy up error handling
Date:   Fri,  8 Apr 2022 07:44:40 -0700
Message-Id: <20220408144442.17611-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:202:2e::29) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7938fc50-aba5-4549-0299-08da196e58f6
X-MS-TrafficTypeDiagnostic: SI2PR06MB4172:EE_
X-Microsoft-Antispam-PRVS: <SI2PR06MB4172C779DE8FBE5D746CE28DA2E99@SI2PR06MB4172.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ag3v5dz+DrmGq/yzLjxDpkc/2g3b2/y0H3lPR/OVKulhZ8B1cFmUOQ8chrG+g5EO/WKbvrtwLskqH4IKBJdyXbzMe7o+RCG9H0QB2vb7CKsBrM3zcLWrK0ohQil8a/JkesplhPKHd6YwHmY7MQ80P4yGDrvgE49H2GvgNzJprCc0aWSOR57s1zBVnGVj31md69tiofJbEJWVIAmOWEwJST+rPR3Gu9XskCuqYKSTiAgPbY7TC6viElc/CpeFd3rsIvXmYf9l5Po0XXvRQaxwjjOVQXgLJ8QcPwV36M6mmG3ozNggzW0UP9siYS/LO/k8ZPNhea0KedYsqNoM7J7qnyEMFP+OVWPSavE/Re6rfKJdi9br0VEZkrZXUex7YozHSkR7c9bs2kN7begkiuhO3/sVZz850FcrHAfffvV3KDq6wjnJQL3ku8OJHeQSIoIhVCjKNXBquPeHCzyfzIpMOhaVbjUIFz8/srA8sCgltd4dN4Ek54OtmscUz20+2flTkP6XJ5wRWqD7Y3cmj4SCHIHnpwL7OQX2sj+MQVqcJEqqp7URuGSR03QzY01Cb3Dlpq0Ezeuo4AdCA2OWhhUOeMgtSQKMpQ+IOfDezwJmhitMUSy+OPFZQOfi7yX12v7PWkd2YhsCrmDmZtfklFxnQsmOGypqIrAqI83nw08NDLmCpBtT9eKUVn+cvnnRKzdb93/1CR90b9MYHxuKAYR+wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6666004)(316002)(5660300002)(6506007)(8936002)(6512007)(36756003)(2906002)(52116002)(110136005)(38100700002)(38350700002)(186003)(66946007)(66556008)(66476007)(26005)(2616005)(86362001)(8676002)(4326008)(83380400001)(1076003)(6486002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hXhrmDE1V1turEqTSIVOk2v6Tpsw0fEoAuDtatF4QawRRUzuB4aJ0HRqnYqc?=
 =?us-ascii?Q?RvvStOA8upAi37O7stbK7Hzj9h0FOrVgAFEqtsxHVtPvGuAesLkxgBbENYuv?=
 =?us-ascii?Q?25rzonek31ErZmOCW7GlewWN/HlXkq7yZL0GR0C/4JExMOw6vOHZM2MSSwMh?=
 =?us-ascii?Q?XTWiclQ8c3gGvxVZMxSN59iPn6uSVagvH7tCm8NsIfOwwEq+XuiAaDNq1Cxr?=
 =?us-ascii?Q?B1R14F4PN4Tvdo027Vc9/J2TDdAVlVArFAGB52O9E8bzsA6Tx80hn/uVa7sB?=
 =?us-ascii?Q?JnMGgK1TS7auCA1acMTEosKFZ6pn+BUM0a2mTY5VIYpW7bGAg2opxApUlb6M?=
 =?us-ascii?Q?QWzQftWSHVBq9JHjXatpzxCvOht/b3FmYNJpK+so+WD4DZCl4Px/2ar/fwSe?=
 =?us-ascii?Q?tpXISyKKfJW2tKpEmH4BSzhh+7P3xU/Rs4OI5GE89DPxaTz0i0cw1GPE4nN0?=
 =?us-ascii?Q?dABM+W0shxOIXj+F+iQnscp9OYKzO8b+zuJMeoK2dcJ8uu6gp0YxUIGTC+J1?=
 =?us-ascii?Q?uQA2rydOdRD+wchc9maarVYOL0BLidYYXBTpBEl3IPAFGPFNmC1v7VQ200cu?=
 =?us-ascii?Q?lHmr7rqCjz7ItMm+0mbyfmYJO5HCWQlNqPFT1KRJmZLpVaKObbjv09GQZCv0?=
 =?us-ascii?Q?Bq1hyqbOZg+JuQhkjHbdi3msTYMaiISSdLBCofIuVVVYYGxhfnJvK+bMvafY?=
 =?us-ascii?Q?caWzKbzD6gEratxLXGoCuOQpFQ5fkg/n0BrCuKam2IKkd1e7qJPg/0b4PFar?=
 =?us-ascii?Q?hK4U6nyY9A7V4oSjO9ASzY15veHnQuUNA0H/IZOhUw2P133FUFR310JZvOa6?=
 =?us-ascii?Q?Eh1StZZEbt5+LBV3kpHlhONkuPua8zZNwI9IqQSJ1wTtaV+OElVEQvpxwdbL?=
 =?us-ascii?Q?5IQqaVGchpGYXP9bXfd2lYR78BHHjYq5hC1SR5XwrechlpRlOg5B8fSS4Amm?=
 =?us-ascii?Q?HIp+qtwM2p4qbxAVwTRoXNtsHVVFa3qERqZvrrTOX/597G4h7reFCA2GF5tH?=
 =?us-ascii?Q?vtrdnc/34H7Doze9L0dfjxBsyFbc0xmPD+pBDmQGMKCHhY+jARkGF29surbd?=
 =?us-ascii?Q?KHrTqNdCcF5ujYq0WqGlphkI4IpRat1+WuVwZdQlGu7ilnYOi6b/px0ICGhe?=
 =?us-ascii?Q?9R/jXFmeAhDYDalNZ5syqs43ndx4siq8ITorGomW/o+apidXwdd8o/TAmuKI?=
 =?us-ascii?Q?RX0TR+EAXJiwNrUzg14UsKabJoqMO1QZatnO/+Xjz7B+H5Ku2L2+AuHwpzzp?=
 =?us-ascii?Q?BOPupBcO4d5sl6o4FmEjSbm7ToDVhx0CymjeUFrLV/esrXLpQ47wgWQfefMl?=
 =?us-ascii?Q?FTQZfQHYAtFJbo6HkEwMtszRuRo4BYysymL2FSiKWAS/MlvdZRDUVb+VRZo+?=
 =?us-ascii?Q?A/YT8HD6gaN+LQF/vB/B0kKMyjeISVkTC+jhtPHMD/HlevmxX3WItxol9mQb?=
 =?us-ascii?Q?j/6Gn8jj9IAjPO9ApWFtfMxhJ0uOtlkld+V175bNiJ8R1xQ9lSdOqDmgxpLh?=
 =?us-ascii?Q?ryMWGNkLC4WXaS7Qqlgc4Lt84l5+xpi0l06Ad2KhZThr2ptC+PBwCt84ig3k?=
 =?us-ascii?Q?SNhDb8hgZHkX30r3WZ31WSCtf1KTf0X8LXFOPMw4WGPpPAKy2d46s+JBo6wu?=
 =?us-ascii?Q?rUwubSqiiI/y50KGI6kDee9A4exfKVNmoBdqyZ0DCQ3YYJukqAMLarQ49P+k?=
 =?us-ascii?Q?DU7ILmxTpwjw4uc7vWkyBn9yTfI6v1btjcLngrHpeEIUTx5Jap5xVxkpneMb?=
 =?us-ascii?Q?6l4ESkE8hw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7938fc50-aba5-4549-0299-08da196e58f6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 14:44:55.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +83WwLB+CFv7LKkZIIzuKs6AWNcSuK4w45QfKlHreVwOrgU5TjDzyrQ1nsq0fiKj3OLLgNc261msH66tdQLBKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4172
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for if rtw_skb_alloc() fails is done twice and is written
in a confusing way.  Move the "if (!recvbuf->pskb)" right after
the allocation.  The "if (recvbuf->pskb)" check can now be deleted
and the code pulled in one tab.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
v2: more extensive cleanup
v3: edit commit message
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index a545832a468e..107f427ee4aa 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -811,17 +811,14 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
 		SIZE_PTR alignment = 0;
 
 		recvbuf->pskb = rtw_skb_alloc(MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
-
-		if (recvbuf->pskb) {
-			recvbuf->pskb->dev = adapter->pnetdev;
-
-			tmpaddr = (SIZE_PTR)recvbuf->pskb->data;
-			alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
-			skb_reserve(recvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
-		}
-
 		if (!recvbuf->pskb)
 			return NULL;
+
+		recvbuf->pskb->dev = adapter->pnetdev;
+
+		tmpaddr = (SIZE_PTR)recvbuf->pskb->data;
+		alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
+		skb_reserve(recvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
 	}
 
 	/* 3 3. read data from rxfifo */
-- 
2.17.1

