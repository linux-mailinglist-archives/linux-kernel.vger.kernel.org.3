Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA7D513B57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350953AbiD1SVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350932AbiD1SUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:20:49 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668905BD30;
        Thu, 28 Apr 2022 11:17:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJE/AnqnkgJrzzEAkWOdUez1M8RR1WQi+MfC4uCAHXSr8NRzMy+1YXkJoQYYe6MnOs1v5zqQo2g/FXnMJ4eQ4Aw9dGZcSL0Ceh9FayMl8yp3yO6inlhUsbxZBr9K3yy5l3wOQN6gW/4J81yHYmXSQObLdP2TTkvRXjtXKKA0XGHweNE4B37+ZrsZcYbFL0PTIS9Ft2T43pWhKMG+MThlRqatu/x6qT4i/0SvcJzZJMaUUrVuzyPQfdiVpdbyer726/NPVlFpFYewixC3exUYv2GnwoSjxikcU4NvvqSzha5CCkM1XYhL8HyGgWITJGHTuZ5Mn85sIVvgZ1oaaXXIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bjr9JNKL9UO3Uu62qeHN87lvtt3gKFygNSJfogL6JwM=;
 b=kQuqqEEJXgOEpAP/o25WF/q98ishsMca2GMW/1ERsvYh/F4ukqSXU+4IfiaUGSFKOmnz1Rt40DJN+YjzNB44DvVrEXEZL7UqUKa4BYSl9d8E5E8FBi93Y45KrIz3b9fG+UAJUqYWQoBZO9r44C4zfSdPEGxkc8rHYIfDTTlwE3hvgtmtTxGtqvYOIUi3lAomlXUQJWMIihxdSmTcftN1STCqqQhaZtZvWWp+j3bem1Xx27GBX6YcRlruvCFoaLY0cSSs3fFtWRHZizZIy7akgRpVuBiLtRs19WN++l0xvV+JiHsOvGOS0XkK1cIWHjYFghIQow9dMbHsqfgh0l6OPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bjr9JNKL9UO3Uu62qeHN87lvtt3gKFygNSJfogL6JwM=;
 b=T4u4xnK0TxzwWH6aMy7oZ5sMGu7JPDaI2ShNZ6NDlz78U+wNhtqfrJMUpsXhdofx7i/RLfV04CLwsuJP/BX43zLWJs6KwnGB6KsbLIYOR2IKWzbIMqfPrcgfXkqZnhYzJmw6s5gJ+7dz9CYLl/pLSzrGRIccu0xVNIz0p/ienPSEdS0z8yJb3gqUQ0NY4BEVirC36GrzMQshBHhPF0xzLMNHgte20azrTEfbS9WomSmR7KLzGYnvLfPlNKLe8WVqS8PVXUcdR/kpZ47ryMgCgnoLX6akSQ+cNFNVpXjyyxVTQZ8AGztpY35NQJ3WB2OSEvY/w7m4+FxblpiSyY4LcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB6775.eurprd03.prod.outlook.com (2603:10a6:20b:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 18:17:29 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c%5]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 18:17:29 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 9/9] nvmem: sfp: Add support for TA 2.1 devices
Date:   Thu, 28 Apr 2022 14:17:03 -0400
Message-Id: <20220428181703.2194171-10-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220428181703.2194171-1-sean.anderson@seco.com>
References: <20220428181703.2194171-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ebf76f3-00cc-49c3-8d3e-08da29435b16
X-MS-TrafficTypeDiagnostic: AS8PR03MB6775:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB6775E997AAD4FD1D3029FA9E96FD9@AS8PR03MB6775.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpMb5pd8qcP1rwNO6FGlG/wYnEYBZ21IvQOp6E4oQpyIzzDWibIj5nGTgTcQr3IndMZn/e5QbzjjFGqtpImlbONuopU/KiJPi7Ny1U4di0afKvouwpcee5uZ714wJXIujfRsCKy2r97St12gokd1PQ8F6ZCdql3oW9msXxXaTn/bTCZUF2gMMg+KvFnMtt9jQ+l849CAFdDbL1JIHUlF3jsu65e7CBVEUJFAi7U8bSxObxj4IvI7KkXUbQTYvuYgtPJMCsIr/e6biK8jFfn+rt3kS+WBAZnDrGtdNQrQjf58rpMZpj2NocxSSg0S4EcPkYDZ/kiA1gP10MmCKe/cRE8E1yUQ/g0yJR/HDXkJfD9guJjMkETJXpTc8qK7LFTjEtXgonIL/IbkxQv9Erk9GvjltMR1KdifgZ/pD4wgWA3Q5IdH0onVMBiK8h601HM8i/QLPLUdAk6Z9cPFskgT+9Z8jIl+9WNjnS98XEam9CDz2PMd53aeQgpoIESyfNSvrzN7Mm7vs0AxLOs1iXWWUymHcOTxkfFAap2TPR0H7eBvRt9alvyWgDDvp2YlBOrNSCDrfJFOLRmnJmsv/qkqw2lInqBFo2ZKyQBDGKsv0fQHKcQYqMtICnVXMPVNmcuB5mNt29sPWE0eqoWFfXNQaEY/ISZ+aae6PzQ8X9ATxRahYCm7kodr6GnErYfN/dAOfZqOLe9WUsy/ID7k6YwmVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(6486002)(86362001)(6666004)(2906002)(44832011)(1076003)(38350700002)(508600001)(7416002)(38100700002)(316002)(66946007)(186003)(66476007)(8676002)(66556008)(4326008)(36756003)(6506007)(54906003)(2616005)(107886003)(6512007)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m6C2ae0TE7lfGYjY6FHILYC5inAqKFRqRwkRZHdt1mlUyGST+3iJUbqFNhZ/?=
 =?us-ascii?Q?7j+WUrNH+pq4BjArmoYkqS2kco33Gwp/4Ao4yiTQntgDdDpmqNL4A7rmCXue?=
 =?us-ascii?Q?kRKg72mwXnKPDkrqSSDwKCL7hPvNIo+avoeDYNJxDxoThel7z70rRgVxwFoU?=
 =?us-ascii?Q?3uMKpxMB306OeU6Rtkw7N9X/JVKN2XIDsSseL5DoQnvlaE8oDrturXLFFmtZ?=
 =?us-ascii?Q?FRHYxLHDeb1t1A8IcRoEOhXyGAHNXxW8eZSxNlgCSKAe7JdVz+1T07W8JDwp?=
 =?us-ascii?Q?/oDn9r0VNSlwSBZ+V9ptv3Nw5McT1W6h22RIyh/tvsXuiv7QZmNwbpdKm/ny?=
 =?us-ascii?Q?uBLJ8H0GUkFP+cV+3ya7MMhQ7tJMUv6SN8InpDn3a45h42bryFDR92hvBCGn?=
 =?us-ascii?Q?d16xNS+KTpx2hDBpJrjPrcQE1wK3GGQ2305c+3iBB8VZivL1KY2nQ9lWNf0u?=
 =?us-ascii?Q?itEqPW3OD/WegMXA2Vk4CtnGe94DMV1hgm3aXYIGmjgUVq0k3V/QdPnkrKda?=
 =?us-ascii?Q?/jVFfMkS9rBQ/RuMUFOn8ncqzsIyBZVTP0n6LNuSNkNOLXA5yPgw8FD6U0uk?=
 =?us-ascii?Q?rxYu0FlWTYe2nFhLUGu7j2sVwOC4ZlB1NPqmbem8M0mKnZER6ossgD7PCSgc?=
 =?us-ascii?Q?qbG9cjOAV6rmRCxNm0ENZttT633xEAcM1WoK8LUFO2o+X2QW8jEbYVhJZrnh?=
 =?us-ascii?Q?GpE/c9r068XSniIW9gGp4ff3Dn9IcStjUJZE5OStTFlFWakt98DceUP5MQ+3?=
 =?us-ascii?Q?esy+MtBDvexAhFQUZHQAnNt4rk1pDB7vlZWZN3mM6oJujuGaHK1lmKH7swIA?=
 =?us-ascii?Q?UMd7IVd5DsC+N7dj+9ra5K8PBSJ6g0lQ5a7abNIesYPGSQnprxci9kNKewfw?=
 =?us-ascii?Q?pdO9qeKlQ9tSacUwHI+gUYxx+WtFumnxxnrfTICHgwk+uoQBWGKpzptgXryO?=
 =?us-ascii?Q?nA+/HLbiFYFNX+ermx8lk/q2ouQSjEY5m1R24m7QBTsiQUFvvvNk+WrEpr58?=
 =?us-ascii?Q?wh9yP6ZXNN9pTNZQLUGlL9XiuZtKoFlLffy9P34I0bGyBVr56cFfvevu0fNg?=
 =?us-ascii?Q?ZZQ0YPRMD7paVJp/11ThF5bxv0gajc8M/D8vTcH+9oXGE5sGmrnIQFUNDlku?=
 =?us-ascii?Q?8iJn4tV1Fd6wKlmCpv+wSbTKUdwMnTRJ1HbdCyOXmayTBZdopacvx9WJGmPV?=
 =?us-ascii?Q?V/IkhaOHq5nu8RYyvkoeg8eb5rBdLZEPWQlDpwL3HMI4VjDSbvIs1qby0d2L?=
 =?us-ascii?Q?Yg69wLwla0LI9iStt0N4O6mvo3dTrTECZ6lAa7E6EDbK4s5tNGZkGsIbWytQ?=
 =?us-ascii?Q?jCJwHjRtB/EJpZFE+ea8VeN9vc22LOLXNMmtJNZ13daERg7uCN+g5gRWEQ37?=
 =?us-ascii?Q?YZAXPDKSND056N0HSb4IF55vCm55mSu1GwTdJ2woZPqI+g8ftJ9ly5Pc0Rer?=
 =?us-ascii?Q?83STivxyqNj0vKxIVyV2zpwzVwHNq3nzhg9hWdRgsNMD6TJ+uZdGfhqppelr?=
 =?us-ascii?Q?n5CWCsFonYd+Czr8CMTmQSg4TI5TWNhUSDMHMWcIpQcyt1dnVYHWrfSliJHw?=
 =?us-ascii?Q?54EEsxoB9a4XZd9HHjdDA/FwWSkKaxmcknVUDxiv7tALXp+74lXB3bb0c2qa?=
 =?us-ascii?Q?DytejgNUH4ijJOD3o5+e4J6txmqgtMeDicbYo+UYi4bGu4Wh4WDDhtyS4SR/?=
 =?us-ascii?Q?gffOs+93UgWZ6CvZxfvzL4WKeSngidc7sEyqNEvgmT08EwJYYz8kAROA6XmC?=
 =?us-ascii?Q?qJmo4mgW+0axuLHQKT/4+iTN+RzkxaE=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebf76f3-00cc-49c3-8d3e-08da29435b16
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:17:29.6442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZL2yfRj6yJnsUIECv03Sgx2e6UnPMOgFZrBw86+qbipw4ivewSVKBQVUep1V59OlJnJkWZajemQLU7e+FhkhvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for Trust Architecture (TA) 2.1 devices to the SFP driver.
There are few differences between TA 2.1 and TA 3.0, especially for
read-only support, so just re-use the existing data.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 drivers/nvmem/layerscape-sfp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/layerscape-sfp.c b/drivers/nvmem/layerscape-sfp.c
index 59083f048921..e2b424561949 100644
--- a/drivers/nvmem/layerscape-sfp.c
+++ b/drivers/nvmem/layerscape-sfp.c
@@ -78,12 +78,18 @@ static int layerscape_sfp_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(nvmem);
 }
 
+static const struct layerscape_sfp_data ls1021a_data = {
+	.size = 0x88,
+	.endian = REGMAP_ENDIAN_BIG,
+};
+
 static const struct layerscape_sfp_data ls1028a_data = {
 	.size = 0x88,
 	.endian = REGMAP_ENDIAN_LITTLE,
 };
 
 static const struct of_device_id layerscape_sfp_dt_ids[] = {
+	{ .compatible = "fsl,ls1021a-sfp", .data = &ls1021a_data },
 	{ .compatible = "fsl,ls1028a-sfp", .data = &ls1028a_data },
 	{},
 };
-- 
2.35.1.1320.gc452695387.dirty

