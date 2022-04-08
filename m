Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BDC4F9209
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiDHJa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiDHJa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:30:56 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2101.outbound.protection.outlook.com [40.107.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49493BBCD;
        Fri,  8 Apr 2022 02:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJXDT7TlljAydBHv52cnsApkuEc+CRNe5WwXt507nzVo/JA5YnEVOVda/X7VGg1JaEqMnIkPjK4UokdXDCH53K0u744yg6tLHtQXNEC2v7+VrrtvZgu1tOY5LhmpfDUpPwl9L/xp0y6qHs4wTgBj8QI+i0zEKhEUZY8FCRGUxZKDc6L8AIoa6aOsfc1yRb4F8hWF5VLqMtmcSOCgrBa79m1MrnvZ5tVNC7kGbq2832LeerRT6OEcQ0pC3g4dw78/Ma1w/Bn/eJgKBIxvIBZxidxOFej2N3yQNJMo8g3w67JddgP0GYHW1hz3N9SgmFCM/wdMDzb2G5yZAy8h8bmbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A0R/Dafw/FGr9kMrn09gN+h5lrUY5+y5tlAJHJMfTY=;
 b=TsAi2pmDxpL5jLhqaLqgFyxfzYbiNtqTYWbHyhKNpqqkczBDF3qjBkItrIvKu9fSiHWFISaG6ppAjDYRX1HuyhlFa6Knzz4LDQQX/Ba5jI3BVzkZBbYMeQjJRDng5pCfftzknSSNjqazYJJHMrjP5CUP5D06Bicae5rYgS8qkEuASukmQ3uSjvD1dTTkoz2l0QVi6yeeI4hVLj8nlPo9f/1ds/2Kj2wgPBuc/Nn9wTw1Z0fp+mDwKzF2OE/JhsII/IJYsoVeV01+rJZ565URJXDz6quhFcONKIwy3aETTwmE08a2eSExUn7vMLGnaaMdeqJK/5hA4fBNqVYxRHfAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A0R/Dafw/FGr9kMrn09gN+h5lrUY5+y5tlAJHJMfTY=;
 b=pgtapq0waW9A/W7/KZqIDZSIurthf+WAf7cBVKeDG00lUiwMgS49wFFybFZ+6vJxbeXJobIGzCVk5hcNNlNqf+3PYjuNG209aj5HAf5RMCICqFYXIvr15pchn8LI7b0YzcAVg4CAWNKHvPSBabkDeoELbjEpn1wyp0KiU6izjBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3323.apcprd06.prod.outlook.com (2603:1096:4:9d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Fri, 8 Apr 2022 09:28:50 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::74ea:8357:f542:4881]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::74ea:8357:f542:4881%4]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 09:28:50 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Wan Jiabing <wanjiabing@vivo.com>, Sean Young <sean@mess.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb-frontends: clean up unneeded else
Date:   Fri,  8 Apr 2022 17:28:30 +0800
Message-Id: <20220408092831.45755-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0003.apcprd03.prod.outlook.com
 (2603:1096:202::13) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fb2525c-cdaf-4f02-8e39-08da194230a5
X-MS-TrafficTypeDiagnostic: SG2PR06MB3323:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB33232551982C929BFF4BA56DABE99@SG2PR06MB3323.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsVsOlk76yXF1IhfdJesoDqX8U3cexB2BvfwQD8mNX5/B8MbBKsH23gHpVXmulxHsdapXgwKdQeoT5cY3p/vDlTYk4hRBWGzK2HrU3Z5DCnnICjzD0OP+SGfxzKqhGJiEB03dABFDzYZvRoSTDdAjyrq8iy2+tvrFKTJ9yiAX01H9gqyCBx4WZ7hN12tNo7i212HSFGmaWn3tG4qokq0WkOM7Siri9ShBUUL8sikMeSkCbWT1RIR35iIjHipz0LaB/4TmU5SEjyeASrHUbiVqbSRmDOk+JmXaRaLgzYf0j+NXDIkPpgGQRpBLnARQ+UMxo5MJJqHHC094Q9StFyYE6D5g6ZRXZ8xc6bfqtstP6LAdCz8wsG/FK2nWXUGEF6Qa3fZ8NxxiK8feK0lev+cTvu6jcp1bAbKQz8V4sWMix5S9HNJsRYVwH6RRNZn26PLeSCswcmRwhVhp2O3/kKmC3xFUd2xoe60vTEogrhbNM8cKS8wdDiZAiYRT7ZxQPp6k6jPYiR0PEKwesD8QcmysZjXv1oOs1ZSRX+d8sZ1DCEjPB26V7wxXfOcUeNo2AOYCFe31VKCMvCDp27A+PaloQ/zQAPbuG8Z+vYFZP2OtJySxovAfD0oME4g60cXYPROm85mYPE+05MnUshkjGoLKgImn3Gda93R0b8F8yooHHbgrqB9gSNokPowbZqmquxq7GYnilSeHT/eRUhNZClBkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(36756003)(6512007)(66946007)(110136005)(38350700002)(52116002)(38100700002)(6666004)(2616005)(6506007)(5660300002)(8936002)(86362001)(26005)(6486002)(508600001)(66556008)(66476007)(83380400001)(316002)(8676002)(186003)(4744005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BppzpOwB22huUQupN2H2urwqgLPiTjp0vaU9+xAg6bQVGU1QXl4i/DBC9xVL?=
 =?us-ascii?Q?9FUiUxUovYZ71+gB5AXZacwqzwqq2pjukRlPMNsydR9RszbL1TN1qCPQxeFT?=
 =?us-ascii?Q?PnuKpRaAQUx1Uay0XXJnH6ZRjyhdm/mPh6ApYxZde6MZkp0SmOrGYf0+E8Jt?=
 =?us-ascii?Q?fO7c1r3bKIsNSkvTL9270wzKeado0LiisMm5J3RiOC7eAbTz82PiOu0GgjYC?=
 =?us-ascii?Q?KKNHspmXj8sjD+PJq6qzTU+QdEMDykhqQOaD/fM0SKZEo36yTqdtiaD8bY+t?=
 =?us-ascii?Q?/d6SkstErqxhhOx8h/9mJ1NEZBbCqgPXZYCJKhBxUvvJGw+QJZjD8ZdgjWTd?=
 =?us-ascii?Q?e5lEI5nJEP18G1Chkx0lArzPMIJTMVauzsgBtK96J+bkCOdq34QzqbXUt2LT?=
 =?us-ascii?Q?8am8jLoFBBEmI8IaMLI+36kLqf8gquRy/UI7Agtp5veAW4OtDHY+76KR5ah0?=
 =?us-ascii?Q?OjdVoi2r0wov3qQikHfBmygqYUpfsbQBKvR78BKS50xJH5LMCcXoRsyiEl6p?=
 =?us-ascii?Q?Ih5ZdNXgWL9Hkofj41rLcYAxIaZCAulOaHUaWvCOGZTzRlqbxf/IVZEj1Zn3?=
 =?us-ascii?Q?RQX2L/O3ydd5vWrlu+VJknz/iHqx2aYZ/FB3DSKb8I4MlpZNw2A6aNNQE4pD?=
 =?us-ascii?Q?mFp61rtcJU86ElwZbEIQUJALXk3uqE8IG3EFC0RhHQhk/qgxfB4zQ6WZBS2+?=
 =?us-ascii?Q?kJF4sr0oCeeeBRhKs+w2vvgc/gbZZVhPIku4br2dn/hMtPXEJ37jN+lSByhL?=
 =?us-ascii?Q?jBpPTAl6OyDVMeAvQcvJ+VtMVr22jqv2z/4PTeOWxHur38NgYkOtyUXwLsBp?=
 =?us-ascii?Q?C1yyPsncaLXdLcwoXEfJj66QyfpX+/UrRSdH8btLSbznLVB6R24uWksxzICM?=
 =?us-ascii?Q?VW9bFyQlTjOJgKFYurd1+vPlGSM/VI6z6F12P1BEEiXPXgTyF5oOyzezmYDu?=
 =?us-ascii?Q?cbsUCehL+xrvSKceXujYz9ha6YmsBpAQH1+zojp5SoSLGnCiIQRteTDYZuiX?=
 =?us-ascii?Q?eqbbpGNhDSAIgHcmmO7njRbrf3mBlNnOV1PKDjf1Pcq3jdcRsIbx7cWbuklA?=
 =?us-ascii?Q?lHVslAfKbtxV9Fq0bTMPXwVEigWtvj3Ld3OeBmLDq1uZNo4/sT7hzAa9WJrk?=
 =?us-ascii?Q?gseEp3D6ByA+v037zeBi+Slr9NxT4oBz4gw1NfaFoWpzzLAbUEG03L9bVtLg?=
 =?us-ascii?Q?bPIg7YykgBR0/7TsZ1+SNneYnk0z1D/50+mizzTkG/3oHp3A9ehF58ldm/WP?=
 =?us-ascii?Q?DD9+dcQF2YyxoR6+g7IiAZPUzb5/JjrK5jJBXw5BBiRDSqq0UUOgzLiYjazt?=
 =?us-ascii?Q?g1/ESgVbs/tM+sIopniUQ1elqvX+AqqDhjmdcMf+2FGEEz3gxLm6vXGinouj?=
 =?us-ascii?Q?mUNY5gNE2nupmfdsTx43XvyVvLBaJ3qDO+OfhXPAEVNGClAQpVKBh81Dp2ao?=
 =?us-ascii?Q?f+jSIxsIpaX+uAik/rg9Z4Gf41Ej4OfTIb6XSXBm+doqpJJgZWrjEyf2vcZO?=
 =?us-ascii?Q?QF5TE5bwAhfnApORG8dkM0w4+EdcAzApRRyPxDSO+Io6LaIFAz87Fayz4At4?=
 =?us-ascii?Q?9FKGuvXqOuvslyrtIDRqSua+xAF7TN1Z1hDH9d2XMI16mvhGWJ6hatr86e4e?=
 =?us-ascii?Q?JJu5cYTJyBy+UBdj/1+FPg2A6eHJPpOCZGrO9e8O75ZeCMcHqWA64L5/Wob8?=
 =?us-ascii?Q?mUevfO+KmoANxBQi7aYgSnGqtUuHsre0Pg/2+WIP0W9h6jREAcS3weFXkToF?=
 =?us-ascii?Q?wDE1hiwCDg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb2525c-cdaf-4f02-8e39-08da194230a5
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 09:28:50.3694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5xGdJBk9bCgBEuec+b2Khj4Ax1gSI/rCCkOaQQxhulTMoZsuwfA6jxPcNK/vXrHPaF3baGduwEbXJv6cM8QLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up unneeded 'else'.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/media/dvb-frontends/mxl5xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/mxl5xx.c b/drivers/media/dvb-frontends/mxl5xx.c
index 934d1c0b214a..4ebbcf05cc09 100644
--- a/drivers/media/dvb-frontends/mxl5xx.c
+++ b/drivers/media/dvb-frontends/mxl5xx.c
@@ -1644,8 +1644,6 @@ static int validate_sku(struct mxl *state)
 		default:
 			return -1;
 		}
-	} else {
-
 	}
 	return -1;
 }
-- 
2.35.1

