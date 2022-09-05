Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6627D5AD406
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbiIENfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiIENev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:34:51 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235021CB36
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gy4RoFBUXzHEiLM0LaQRgRTNLuIwJRPEDR9hDq1+nnZnaNECcP+YZ3Pm8Dn4W3ZqWvUOsQfGmW/b8PBUJ+FMmr2YbpNp2FBQ8rqKf3lvPyE9mN2CGppFjpGc4bY3jksuKEFyTDOZMLmWC459gzXFTRdoC7l0dJdkouq+3l9i0/oummybcWN1uZPIfEmoZLPtBdTDY43iLJNT9PnbgRImQvLCGD7ibDohQOr72gZekxGrlu1VlzGrkrZSZ6/u4ewHV1N/1BZyUarFoWLJQCHO01cy6I/ctY240i7I0j6H5eO8Oi8d8dtgL7hiHVS5khgoJmEhzsQXaaAGEGVzIUfmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RazakFVmBTP9WFcSFYdhGMh3h1u2i57yzpiLl038jIk=;
 b=gMf9+3Gm24G0a66fsDqFn38VJNgnFRNvHDOr7WOEv9Mdepy7vW6Szlz+m3WECMM/m526i1udgdw/0IUJlbIeqo7vQVs24WW2c+2QmcT7J+QjHng0U10InU0YeIzki37gQg3F8cJPUxJNquW3tmgH/1D7NhPW8zkdCYXkNH+o/ETDQGbE1ajS59DfrJxZO6ZTdNUYENAsO5m6TdqG9Yh4ajQgbdZ/qwu0f3/pmqNpOjbNKKAlkz+kHnoyprCekRwJyW3KR9J72dH/SPh3oHuXSNW6lEn3wjjlnmXdDPeB37S2PEjInf1hequNvKY7a1NNt11gyG9c3oHV70oOHh7nNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RazakFVmBTP9WFcSFYdhGMh3h1u2i57yzpiLl038jIk=;
 b=df6U0FqNRRNIZITqNUy0msB6A6meEfMNX27+VfSl95a8ey6gtvuNsmbK1S5qvY3dVU2EAbAEzUh9vlJqhrEy2htXYaFbx+apdIZhl0aKJ35rZQiYy+NwUiYDO9MeL+yp5d1oTb+sb2+B8lKEo/o4xWcSJJA1QMTxxr2JjWc1IVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB5585.eurprd04.prod.outlook.com (2603:10a6:208:133::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 13:34:48 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 13:34:48 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     gaurav.jain@nxp.com, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com,
        linux-kernel@vger.kernel.org, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [RFC PATCH HBK: 1/8] keys-trusted: new cmd line option added
Date:   Mon,  5 Sep 2022 20:06:24 +0530
Message-Id: <20220905143631.2832-2-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220905143631.2832-1-pankaj.gupta@nxp.com>
References: <20220905143631.2832-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c62a6fa8-8413-4754-462e-08da8f436718
X-MS-TrafficTypeDiagnostic: AM0PR04MB5585:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCFAsp7RizVM4xQ24Tt9qBLdVCEba/kpV1xWzlHE8cxiJfyZ2QsIi8Ef8UniJXQOvJMSx6amWHTqLniOkEnn1O2+hsq+2b1EBHN38XKzUcnRwAVcKian1xBy2IVQUlTT55KXI5ZVxDPkBf6dxE3yL7Dhxw1/fgjnvsnDDkXomvpYMPW7nNyKJAXMym5rh0Ts3Jfl4q80YGYx5d+jqxlbUu8bPUZC2hC1+VDf8l/uGanZqUeMjCz0y9clqYK1N6aFKSXiFPJ6wnGBoRtW5X4UqVivrmHQrLrY9hT2aHIjC3KoyUaXsJzYo5s7QJnxYif8aGGz970Ji4jY0rY5pIJclxMEQGjyZMs5OqAtEk5xZh8pnZh6/g9IKD8H0Htmln5gsom8NGk/1kSGZf3yQckzhUmC2B+Z6neIZmAuj4Qcgp4GSOO1+UTuNEzCtHGcrUHvnKwuQQuSfyfNCe+K/5MOn5boDuiPkadjab0Atg1qQ6mv9mHVzbbWrBFwJHX5v1/+JONfDlFgv9Lm6gIU/lpIR8FOcRBwrYXNJMb97yTswz1b82AyoGse1slel3sPO+/vXXC7uBapyi14itQhayvd1bK9kA7T0SMa8eKr+ZqQFkvcji1CUP8mlN4dQWz5s0wwNpOsLA5RELWiT+eFZrV5zYIM+KkbipTe4JnKHvfOqsvMhdPqlGwanIGbwxEYhLwSMWtYbcn6xPdbsnx6gWzGxi9TZKXHWVf9TsOokS/6zWg0mOyShAwJbXzXkoZPBQsYxD+5AjjSAV2RUYXHDo/XZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(316002)(86362001)(6636002)(36756003)(2906002)(38350700002)(38100700002)(44832011)(8936002)(5660300002)(8676002)(4326008)(83380400001)(66476007)(66946007)(6512007)(41300700001)(6486002)(2616005)(1076003)(186003)(6666004)(6506007)(478600001)(66556008)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aUs6xZzyMiMwXxoTbqfvW/q7OkthAa2AD6+wLp71yeez9oHhoid9UfWJ9axc?=
 =?us-ascii?Q?gkKTup6I1d5NYMt0XE0bOvzGfC59adVF/B5FkusBK29gMJf7tEiBxbYEqV/1?=
 =?us-ascii?Q?F2KmBOm9RoZUcuIg41520yoRMjpocH2RhppWTQAIYdK41xp31WIvT2i9KTuD?=
 =?us-ascii?Q?s4H8Qo6WZ+MM89Rer0LEIsWoBeCaSvYGvWILDEMfuijniHqQK69py3AnL2xC?=
 =?us-ascii?Q?tkig8AbX43448FhB1cViml7dpZwzm70jYKgU8bDMXTNhOYHEvpcD4i0adqwr?=
 =?us-ascii?Q?zQn5FCw30r0GVw5Cw6z+dXUUuqwmOcAHFMSKTUHf3Y5cIggLegcGxPjIbLUu?=
 =?us-ascii?Q?VjX2tywWh0/ESn1CobxAzSG+MCAunigZRuSuK45rPLY6ywyzv1RyksdQ4GK7?=
 =?us-ascii?Q?rVJIAhYFA8Yy27GkcjYGqsw+dezgXQUr/ySY5DhIAZCXa7J1mHuBWcVBW2OY?=
 =?us-ascii?Q?Q10TpCCLZBbmvA/OIte/jQieLRvBzQW/GVbTUl3mmyYDXVUcnRmM/+mAcgiX?=
 =?us-ascii?Q?47At4t58pOdL9avcQ4U6qTETaPpbQB1V2npRvivVD5ESfu+4FwogOY4Kk+hL?=
 =?us-ascii?Q?VM9LNaT1E53cOkOYa333zNPRLTgpArSmxBnkSkhaBFRZIPI8xj6eh2QzqOIo?=
 =?us-ascii?Q?UW0Frpn0VycigcCEOVY46MbgSBwE4Fk4afTN1TMeBEar0Hj1A30FCOtmLeUu?=
 =?us-ascii?Q?ysnobVF8HbgCAqH1JH+OL9+oWulpn0hbN7YcUZUB0BsoMGhZxjRJR79gYswB?=
 =?us-ascii?Q?TAki6jXd22W99mVIDLTTvXrxTRleoLSbXBs43L848i+cAxHCI8jjjCgvKTyC?=
 =?us-ascii?Q?lpTJkuZU9pbWjl3UpVJCxgOeKsvBBMq6SLkAGqtTAj6SdrelsQBIuVqXi/Lc?=
 =?us-ascii?Q?PgW2pgeacL99l4feTB40Fqmsasi6HvqoGST8urQy8CrfRf6Be41TcjXa/mQ7?=
 =?us-ascii?Q?NcQ1Jna/zCFbifXayV56FAwh5pPNwEQAOsEaBDzUk9yc2H1845Sp0hvsyUii?=
 =?us-ascii?Q?lL5sZSmIeLgTv14An+85zURCkAWWspt0pc9ChAEjpfuAMefQvSsHxB+0mpb/?=
 =?us-ascii?Q?uNTAknnL7nhLBOWhhK5oWgfemeGDQeHOxC8Pg54Oi4Vgzzk7yQLDL70IlzP2?=
 =?us-ascii?Q?v9fEKWC6XjnlckSpHXGwehmHwngMdJLc6qGqKksbyyI+PlqVYHk5UqmNV9qX?=
 =?us-ascii?Q?k634YxI+ZhrdT8+5+VMjKCNCtfQbcQJuLUUKl6wgbEdYV1EaVd1w6djEnKUE?=
 =?us-ascii?Q?paxJKG/IHBjce2VG62QBWeOmxxcsU7UI+N6N92nwWbgBYzlF8i7ZuA0qhQsZ?=
 =?us-ascii?Q?bbG4L5mek0KZx/5FRspSIJvWsJIJAgvr906AFMLdA/iqaTxSVG9GvBdn0MJZ?=
 =?us-ascii?Q?SLMkS5J6By7Mr9D7djYuk9q+OkQwFtg3o5quVW0WLXbDyEuPD1Qyg/dIZJLe?=
 =?us-ascii?Q?ubmOFCjtHky+X4ieJkruv9jNEGDeoXIF2UHDwqHlc6vTj1pGyxMeVsqJ0KtU?=
 =?us-ascii?Q?PVHuVy/S2DFJrbH0/CyCzkipbmRLWx95FkLzxi0p4dHm40qmuI6NAjSK+Grv?=
 =?us-ascii?Q?PxH8pVny5PWJF5xY/ZwVcuL57FpcSD9dQhnKCvAr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62a6fa8-8413-4754-462e-08da8f436718
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 13:34:48.4084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /t53ulBEvc7aX5ySqM17PIsDpdbnrCydaGOBVaTydeHUhpI/HCl3KAnG74aU3B38dyz/uA9SyBL9Mhay169tyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two changes are done:
- new cmd line option "hw" needs to be suffix, to generate the
  hw bound key.
  for ex:
   $:> keyctl add trusted <KEYNAME> 'new 32 hw' @s
   $:> keyctl add trusted <KEYNAME> 'load $(cat <KEY_BLOB_FILE_NAME>) hw' @s

- For "new", generating the hw bounded trusted key, updating the input key
  length as part of seal operation as well.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 include/keys/trusted-type.h               |  2 ++
 security/keys/trusted-keys/trusted_caam.c |  6 ++++++
 security/keys/trusted-keys/trusted_core.c | 14 ++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 4eb64548a74f..064266b936c7 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -22,6 +22,7 @@
 #define MAX_BLOB_SIZE			512
 #define MAX_PCRINFO_SIZE		64
 #define MAX_DIGEST_SIZE			64
+#define HW_BOUND_KEY                    1
 
 struct trusted_key_payload {
 	struct rcu_head rcu;
@@ -29,6 +30,7 @@ struct trusted_key_payload {
 	unsigned int blob_len;
 	unsigned char migratable;
 	unsigned char old_format;
+	unsigned char is_hw_bound;
 	unsigned char key[MAX_KEY_SIZE + 1];
 	unsigned char blob[MAX_BLOB_SIZE];
 };
diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
index e3415c520c0a..fceb9a271c4d 100644
--- a/security/keys/trusted-keys/trusted_caam.c
+++ b/security/keys/trusted-keys/trusted_caam.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ * Copyright 2022 NXP, Pankaj Gupta <pankaj.gupta@nxp.com>
  */
 
 #include <keys/trusted_caam.h>
@@ -23,6 +24,7 @@ static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
 		.input  = p->key,  .input_len   = p->key_len,
 		.output = p->blob, .output_len  = MAX_BLOB_SIZE,
 		.key_mod = KEYMOD, .key_mod_len = sizeof(KEYMOD) - 1,
+		.is_hw_bound = p->is_hw_bound,
 	};
 
 	ret = caam_encap_blob(blobifier, &info);
@@ -30,6 +32,9 @@ static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
 		return ret;
 
 	p->blob_len = info.output_len;
+	if (p->is_hw_bound)
+		p->key_len = info.input_len;
+
 	return 0;
 }
 
@@ -40,6 +45,7 @@ static int trusted_caam_unseal(struct trusted_key_payload *p, char *datablob)
 		.input   = p->blob,  .input_len  = p->blob_len,
 		.output  = p->key,   .output_len = MAX_KEY_SIZE,
 		.key_mod = KEYMOD,  .key_mod_len = sizeof(KEYMOD) - 1,
+		.is_hw_bound = p->is_hw_bound,
 	};
 
 	ret = caam_decap_blob(blobifier, &info);
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index c6fc50d67214..7f7cc2551b92 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -79,6 +79,8 @@ static int datablob_parse(char **datablob, struct trusted_key_payload *p)
 	int key_cmd;
 	char *c;
 
+	p->is_hw_bound = !HW_BOUND_KEY;
+
 	/* main command */
 	c = strsep(datablob, " \t");
 	if (!c)
@@ -94,6 +96,12 @@ static int datablob_parse(char **datablob, struct trusted_key_payload *p)
 		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
 			return -EINVAL;
 		p->key_len = keylen;
+		/* second argument is to determine if tied to HW */
+		c = strsep(datablob, " \t");
+		if (c) {
+			if (strcmp(c, "hw") == 0)
+				p->is_hw_bound = HW_BOUND_KEY;
+		}
 		ret = Opt_new;
 		break;
 	case Opt_load:
@@ -107,6 +115,12 @@ static int datablob_parse(char **datablob, struct trusted_key_payload *p)
 		ret = hex2bin(p->blob, c, p->blob_len);
 		if (ret < 0)
 			return -EINVAL;
+		/* second argument is to determine if tied to HW */
+		c = strsep(datablob, " \t");
+		if (c) {
+			if (strcmp(c, "hw") == 0)
+				p->is_hw_bound = HW_BOUND_KEY;
+		}
 		ret = Opt_load;
 		break;
 	case Opt_update:
-- 
2.17.1

