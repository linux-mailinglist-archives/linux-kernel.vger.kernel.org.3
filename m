Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFDA57DC35
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiGVIVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiGVITH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:19:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299BB9DECE;
        Fri, 22 Jul 2022 01:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPYCRQ4lVxw+KlN/zZi7u59i0f/Kkz9XWwuI1/AhO3HwvM25PcymxttEbyWsBqkzLxjsZbgLhcxMolZBYS/UsPozdOf826JmOyCcTcB9ogNVCVE3RafziJoKgluc3mNQRY5zExKfUAX+TDtSZ076VhZ/BjkiPT43VkgQFpGy/NRljcqCTaFAqvjyCUEjm3q0vEg+Lk5DbtEpITH7VOtsGA+NO9HiZUuHTgWZ9N9ZzeVbpLW4mV82wSTsbCznuU+yYudf/2RIyIvz+xfKx9nEaUGX+ST6Sbvjb4i07F+AXEDb3TlUwXKmaGqTST+v5kxJTdYEHyC9RtANvMXP/VmDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ih81gXhpcBE25HgKgIdRF7m1ER45A2lSMIcjEJ8W/ko=;
 b=DPnwf1zfk0xL3VJio70/lBMYaLD+2z0NsDyHQN3nUQbw0vMw0mnf93rWk2JUktRx+sfsTL68BOczfn/HnnOhCziZjzzL5MDncrgcl3VSinkhbI1NvwA3W81mPuk+nlKnw/gjmE9aQTYaXhSXtOePQNX08ayfKCIQ1+b7scyW07vn3vFFNigRvQ+SjjpKCi3ICuhSW31T3U3nzb21cHf61rXDFBrMGePkBBVJjBuwamCQXaYWjXe+URU2XXekq7rsnxJHyRzkpKGZGnBvcPgFq4xOG6DZO2NUD7haFoDoDcq8NjNeyOpBVWoAmVPO4RRViW3c4y7BVn5YFYkHxUUXVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih81gXhpcBE25HgKgIdRF7m1ER45A2lSMIcjEJ8W/ko=;
 b=mdu0zWQsh1dhkOb7YGS6woix+evsKrrZSkBo9byhMKDQIunGBN+p0VGJPFKBaZBkzKavhTXGftAUuyseKi2ZCuvznXA5JZ1YufodiqqQpoqB0BlJzXVFkZ3E+hb2NAh6QAHcJN6/j5S/wwbcbKwLbnv50QiU2PhtbXbG/xr2TfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BN8PR04MB5986.namprd04.prod.outlook.com (2603:10b6:408:57::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 08:19:05 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%6]) with mapi id 15.20.5458.018; Fri, 22 Jul 2022
 08:19:05 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usb: typec: anx7411: fix passing a valid pointer to 'PTR_ERR'
Date:   Fri, 22 Jul 2022 16:18:35 +0800
Message-Id: <20220722081836.3380885-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722081836.3380885-1-xji@analogixsemi.com>
References: <20220722081836.3380885-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0077.jpnprd01.prod.outlook.com
 (2603:1096:405:3::17) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3445ade-6bb9-4473-dd9f-08da6bbad78a
X-MS-TrafficTypeDiagnostic: BN8PR04MB5986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikeF5oFCPAXilsQ+VqYQS6t97KZc960+b+e7aKw5mPOeGErnvgp9m4kYAvahbOan3neFgaSWfViE9wzV0CZO7lpnx4+edEqlMMy9OEIWQXisRvzOLNBCRoQzPRK4z17p01d0AbTxHNUmQ+m5AIDAI4vfCXEjl91rmS4rfktUTcccpWUF4F84rjhg771iMSJ+asGm56OxHrfyBPoRN++JJXYYZNhMaFMYVqMExifCeHrobknnBbML+sVaEZgNMTGbQFUiE9K+0pqXYnWOHiw+FhUpak/qtTXrLTktkCVQh6feygXFyCinmwCCPet07wLwI0CJWlITBl0eAadtTpu8svVYI6lITJy+gcQ+nvveZX7E83ekE/TeKntNcPlaDap+37PDixTq0UAnsIm/xIFK+D2RpkcXVlJwOueRgT0qTn8cFmjs+qt7N11ZwwN8n9nE2/VYSu5rTKitwmvNc8ESvVzY2+1bN7Mb4+UI9/rEnI/QdaZ4MC0lSSdTrrwGRzdenUM2o5ln0d82Cw75O4QEheUZOLN04pn994hCOmVkB4CXaIzgIVLAa4qEn8bBppTsqrJwlHC7zDaHA3+901hyYTinsX2UKOtbjQOr64FV4LwlfKYceOVScly1lu+6wmAI6HumblQDqrv3DwSszUW2268fQo+8lg9/SEdhz1BT72RBJTkKviX5+Iti2ph08fwBBsyYdlvl3sN4ctqu5Ii8z55syGqe6/kOI560Bj0FXv4v3DRQHxmj6+Z2rkdTtORkjCaifsruRrHBlXU3j5KXyIx9NHIwT3RD7YomKTdIivU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(39840400004)(366004)(396003)(4326008)(8676002)(66476007)(66556008)(83380400001)(7049001)(66946007)(6512007)(41300700001)(6666004)(2906002)(26005)(478600001)(8936002)(5660300002)(6506007)(86362001)(52116002)(6486002)(38350700002)(38100700002)(110136005)(186003)(36756003)(316002)(2616005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fS4SsYNRFzmx6wDrmqWDPkPNdzrXIwLXpmNOXCFdlGNujMR3/1tYWjoLyp8a?=
 =?us-ascii?Q?/ZUVMXDJKhoFrTp4Jer2koqt1oFglolskLoN5C4EaCma1eA7lnipdzKTtIny?=
 =?us-ascii?Q?2dIi0w3FPLB/FF0h9j6iWDiM1MyEekB9zF68pp7mWUCHJWNC11cs7G1ua4i7?=
 =?us-ascii?Q?DOoZk5V6/97WeBivv+LMIfcsIKCEUqxf//Ep7Afa7qh5ZjzShio6RijEaQrM?=
 =?us-ascii?Q?8CWeune8LpGrhwA76W9Qb1aUjqRkR4fwWp1itKKRvCXEmhtf3CUAXI/Fy9B1?=
 =?us-ascii?Q?t8Lg+YTlr6t2Y7w4Q3Jjp1i2eOrbuhx5rH+OtUQzq2XLIUDZ8P0rv1dN8HL5?=
 =?us-ascii?Q?LpQCYaDebwKfhxuec3ce6NanV+sWCSEElwE3zgoFJumaTejtp8xxdTC0SNmi?=
 =?us-ascii?Q?Sjap9/DdbFGxcE8cob4WYsvvEABw81KSVc++ehJ0DmorreD7YAz3/leoy+Xw?=
 =?us-ascii?Q?U4kdxPhrzJtB36GBDYjaBextvg6YNFf7qiM/nQnaHaEYhQSfm02R7Gn3IAbW?=
 =?us-ascii?Q?c7QuFfS/UXKhpA3dYpiSZMtDoBN7pGw3Ek+FE3poaAqbnLGj9I8O6Mb1nkYm?=
 =?us-ascii?Q?QuUX523TSP0hM/PAn8lewmMljngTy3sOv8k9wZa4pCmY4Sech7M3+jcUa+kL?=
 =?us-ascii?Q?8Re5UAt5lvGVfEP5x9ME/GrdvUtB9hiziP4KpEBoB1E0o8aoj4MA2BuCViTq?=
 =?us-ascii?Q?HCjnjEqhOGYhiEOEYRqJ6ZGgbLml4dGDpJc0VRtM3jTqLEEUxeBv1Ya/pbnx?=
 =?us-ascii?Q?HGH+2tTtTXfDkrD7x+94Rj+9jpFV2iwE4JRCvV/8qS5RLv4llUyxmS3DWOcv?=
 =?us-ascii?Q?bqZbz++Abdw9aHRs7dWD9LeQn6XqRSwz+Z2JAD80vB8ugKkPFHS6+W/OG7YN?=
 =?us-ascii?Q?WCpQMWulxmCy3nEZNmLYhE0s2FjqkqwjgIuiOWaX5yohi4EhZvOKjQ/SRZDH?=
 =?us-ascii?Q?Dp9pMpAe+XdLcjBmIsWKlvzR4OFnABMo5CNenlZwX7HGNRcsx0CauC2qVKBq?=
 =?us-ascii?Q?Ho4n1Cjxk297bmAwY8a9Y4p0xSCagpXBQh96e995s+8aEqrQuwfBnLHrvyYY?=
 =?us-ascii?Q?6B7fDKMbBovSQUhxPsJGvb8r5bzWpXOUmP3d/+hcBe7p+gTIpbZSkyCfDodU?=
 =?us-ascii?Q?6DPztBGIsRYEKg9Prnzw5vTV1uUQapudBmNhlJ+BjGLccSjc7IljXDKVXb1T?=
 =?us-ascii?Q?MyvSPRTwXBkIe5x8ZfIIEa9ldEVvZzIvSilEQzkhx9i+QMpTo9ZULW/H+9ps?=
 =?us-ascii?Q?GCkiZYAgMs2LLqOsRI/sUlcZvjRDPF9Gnw7jNCEAk3dVHsA54vamKcdoJbyF?=
 =?us-ascii?Q?9th1QTGBeOlopDkmlFF87qIeP4cMtKIwDbxnF/k0XHWWHb/mWx78Elf/Q2w3?=
 =?us-ascii?Q?sW/2seu36JhR7qhvvLaFEnPOT0Gyj1S0vzSbK4ycH1s/YGB2UKEk2Ev7JvWy?=
 =?us-ascii?Q?yg0IiNEaZ3bZHBe73EkxzovGRD9ErBvGHvrPtDmomWJVJFLsFJokjrrfxxp8?=
 =?us-ascii?Q?09kaaRPJiFXkzh9m3I7cB47qniivYMd9zuMCyVlxrEEvFO+bgJohGXAzDXkg?=
 =?us-ascii?Q?4aj3uyLw+vHVccDJMboTt8l2CwS2pIGrg7zUwFgR?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3445ade-6bb9-4473-dd9f-08da6bbad78a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 08:19:05.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t06QwyIyPH2KyKBUPh7Zc0/lnKFGwJyGRbtApYI8TUl33vhLRdxwtvUHGJ6f7YWiLJ2hAeIYJmQkxlHDbTOHcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5986
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix anx7411_typec_register_altmode() warn: passing a valid pointer to
'PTR_ERR'.

Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 drivers/usb/typec/anx7411.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index 7b45d7440a9d..dc86b6704cbd 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -550,6 +550,7 @@ static int anx7411_typec_register_altmode(struct anx7411_data *ctx,
 {
 	struct device *dev = &ctx->spi_client->dev;
 	struct typec_altmode_desc desc;
+	struct typec_altmode *alt;
 	int i;
 
 	desc.svid = svid;
@@ -566,14 +567,14 @@ static int anx7411_typec_register_altmode(struct anx7411_data *ctx,
 		return -ENOMEM;
 	}
 
-	ctx->typec.amode[i] = typec_partner_register_altmode(ctx->typec.partner,
-							     &desc);
-	if (IS_ERR(ctx->typec.amode[i])) {
+	alt = typec_partner_register_altmode(ctx->typec.partner, &desc);
+	if (IS_ERR(alt)) {
 		dev_err(dev, "failed to register altmode\n");
-		ctx->typec.amode[i] = NULL;
-		return PTR_ERR(ctx->typec.amode);
+		return PTR_ERR(alt);
 	}
 
+	ctx->typec.amode[i] = alt;
+
 	return 0;
 }
 
-- 
2.25.1

