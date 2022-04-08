Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2C44F8FBD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiDHHpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiDHHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:45:05 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E081B9331
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KN8G1YvyxGRkePV7Vl+6of/nmY6laAQi2m+hRrY/BbTmYvPX2KnjBScrtRLCoS6BsRqLnNMPBVMgWcgaXiTPRT5YZWMHxQ/Olfv59WnDq7A4/UhXNxpWxA6cD355VPCfpqTxvA5SoI11UqMyxK2qNkkDVWHhztTq/u6TUq9IFch9+Ir50Ach0tLDsDMQtoNPZSRihsj58Y885vT+T5eAxrHE7KnY2H381HbkRZiMZEtK/Ck62lXj8PJDlW5oWCgY+eoKJAjUgGclxsh2InTmXV/VWQwD4cJUEF968h7Y7HXjnc7wq9k3BUfPsdvYrrwEafiWV5s7BJ6PpSVVGMzKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lxONMgke88UwmZW/Zle7cJHpoh/OU7NuGDyJ2ekzU4=;
 b=aRBJ42+MCE0njjYypfci9uvou7s3eeXaEku0idU848gQfLfNhedGHtXTq6XNNMQZ1jE32gJ2WOhqGUG0oZXVXRnZukIWU+j82einHSsgoha6Mjc8zK7D7PTMB2zpho9iuasQtIEMLNaFW91xnOe3GR7x8Y1m4uC1dqZQy16BVo5fI4LCIfyRCNzm6Gq4GmSQ7Hl6BdfiIcFxtwrotphUqZZpVXTkfyyznVINswaxkTFWfhe4xW5Vxy08Gcgui1LLsogShdLALDWdilBpBtJ2hD5gzqGbsBeFwj9OjKU+TNCO5b0u2BCg7sJFj6jlegv2a6z2xXfJ9ImTZve3ABCmMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lxONMgke88UwmZW/Zle7cJHpoh/OU7NuGDyJ2ekzU4=;
 b=o3fPJ/Q2lA/xofh29WzCH84JfBANUDU3Yw8TLVzwm4S7xxqSrqByc4O+wq4r77j61xYjGk4uZltowRJtsztfL1EAEmk6BeMed7zVVbosINAuzltGimJF/8jCFbokLpWhYx337m7XIt+id7Cbb9AN3FpdCNX4TWwm38qh8uapNPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by KL1PR0601MB4243.apcprd06.prod.outlook.com (2603:1096:820:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 07:42:59 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::2813:af2f:32d0:7be]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::2813:af2f:32d0:7be%9]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 07:42:58 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Yihao Han <hanyihao@vivo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Xiangyang Zhang <xyz.sun.ok@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] staging: rtl8723bs: simplify if-if to if-else
Date:   Fri,  8 Apr 2022 00:42:40 -0700
Message-Id: <20220408074245.13694-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:203:b0::18) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 522463ea-301c-4612-6644-08da193366ed
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4243:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB4243F0AECD7D13007B1B8D86A2E99@KL1PR0601MB4243.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KnuJx1bZxFMdCYhpXQwXj0hf4IQoSj/yWI1sdF4LeY6eHXurYah0MW4RukMVzN94esDmP9gsMH6n2M7PijpmrFFfTxo+goAuqy4SsTjKRaj+yBPv4U6q6ARO1L2xbZsjRy+KQXaCZ8vE84hrCYzhxu93V2fpunFhXRZB2pdlTOZGl5EbPttPsHOf3s7UP2Mn7FFdoz+dMOTvQWrOsiqHzZeo9rIOBsUxjNQs+2Hdk/9PTIJAfAvq9L3grcAmyOuqq2rw1XbobtzPRdDumLOgUGLueI/GTmYgwaGt14nP3uY/dBcdvlbz1w4cswU4ndjsauco2RH+8iVIYTiqadwftzpNcKEHqWu/fGhNTWc11kGnmFLHSRDk9iqRnXZOM9j0XbzbnVp11dGyPom3A/soqhb0mLSfzCKI1OXKzqBWML1+ntXSwMpMKoFahdUVoFRPg2tuM6qVCByIFQV+juU3YWLoaPyE9xF73QjDR0o2CNy9hFMv3BkUFjJmXl3efX1GySmaDiwsaSl7j5jQbukIWigpFBRfMOgpYY2tRXGqOk0+KcQsrnpmT7oV0KLxm7PjmnMA+1a0vtR3/dQbIGNAiATt5DfBdLcW729TYibEo/LafX34J/NNUOc8UfxkWpYE9Auc2hxJDhamXSDY33IDwUldM5QzWVXwgoeB282sUDhCov1wcQMsuU+KJMF15UOcqFqzEq07SsZusJFwIO+g+5fGn5vJQJPdZXpeuZQEhvlBqiFE9pAF2UuYvkfd2RxxDBXBZTbPycMDLD8fBLF6I8QnI2d/EPu7p+kUooVbC9MC6C7BgElNQjOp6rQKAMyg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(36756003)(26005)(186003)(2616005)(107886003)(6666004)(66556008)(83380400001)(508600001)(110136005)(6506007)(1076003)(6512007)(52116002)(6486002)(316002)(8936002)(38100700002)(2906002)(38350700002)(921005)(8676002)(4326008)(66476007)(66946007)(86362001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mritXBV7TuqW7AI1sxzWU2U2xC/1RifxrNZFPmgP5uPWh4f9Jl+84H/HrBM9?=
 =?us-ascii?Q?Vt8h/v9jK7AUUMaR+PV1OIigE51VC2lyNLlB8/ELTqeKXHHGUr+yZGa06Cx2?=
 =?us-ascii?Q?TKCyvHBESZK6i1hVUxNP5Pnv/BDF1s6m3t5zb0Ha9y2dbdYMIxBmQq8EPovS?=
 =?us-ascii?Q?651vlaWGN0cKDV9fU1m10Tt5lz3udfO02py7mcufltix4TuvHAaoWw+9n3Xz?=
 =?us-ascii?Q?eMPZ5VPLDINPj5OA07QkvsmMJBSgjgrCAN88m5T+ArhCcxuhbrJ0FTNQ8rP1?=
 =?us-ascii?Q?mPfNyGIsKeieb1V9I67/CUSEnrpOiIuILSrr6dOlOkK15h43UFbBnXS4vp2H?=
 =?us-ascii?Q?f/DNw0VG+Eax1FIqdMu3JvtqZTFpkFtNKQsxKT2ARI1f9GWF2kQU4B1tOeAh?=
 =?us-ascii?Q?XVp4HwqpJmLzQvCPGENon6p8d4NIs/vsPQIgA0RTnzZc7/JKI3o1sRrmI8Ts?=
 =?us-ascii?Q?60T/zLmdzl7F2Ypqi1slgJtbA4jdp3VXi6YQ9uvrq26bjtXenQdN8HMfQmFt?=
 =?us-ascii?Q?aKlakWF6xZaGpe8L/yEUqW9owFqOTVYHmwBDzozxKXViYHsWQ6L+Vx+srXhg?=
 =?us-ascii?Q?2WGv9xSOBr9Cb5dPOxqOmWqxBFyx1AFmwu0s1YGisYjLHYW8tZIXNj1tw4M+?=
 =?us-ascii?Q?FDWCOEjBPP5vk38U6HB+/img3fuwuC3zd7h/sNBZMj6C3+FEZfR8qxBLBIyC?=
 =?us-ascii?Q?4zL4HVRwVKrbykuBdfcZvkwShQAFigS09m8UK6Lfv3uu9/6e+jB4TIQhjP95?=
 =?us-ascii?Q?6L4c6MEl6+SjcnEsN4wOb+LKdyyCNOvr7JJc3ZLQCB2WIVWX9Yj4QPeEZjDq?=
 =?us-ascii?Q?Qe5Qat2QEdZbNgZpTiotPcZX73jWLeHtRR7MCx4fxsKSiLers0JUb56CInXL?=
 =?us-ascii?Q?j0lfmKlxGq3MPxGRSLgs0FYxin9W/GNDbMVx7nCyU9Yc7MdfMu3EQPp28RJw?=
 =?us-ascii?Q?z+4e3dp+y7aTaUrdYD5vVSE9t9U8DbntB7W/c/to2UAbJQCOjiPJRJFU/3oU?=
 =?us-ascii?Q?9fFyn/WN7qhGrO2EpCM8D5M/A64QmDjSRENAmSjrOEUJYoH1p6gN9TOWjjda?=
 =?us-ascii?Q?1zzpT5d9McWumgdtD/Sy8BCxdwpbbNzdl8zNvrw7YesF9TPZP/g9ANJSht5R?=
 =?us-ascii?Q?1BTJsV2xJcLGkXApVO6mjR3LYHPoBRhfWsCkzM2QfiaDbaEyK4XS1bhor+AQ?=
 =?us-ascii?Q?rKquUvPaDIBY+VBHqGagk8l5KXm4T1EYANXRKxX8QD7gzR3K04eMoWU2GC2I?=
 =?us-ascii?Q?7WA2ubpV+ksNSOuoqRwo0euffUsGfP6iQL/IPGN3vrrnzo6NJs/CCh4HSYJK?=
 =?us-ascii?Q?TvCiHTh0rMSOzh2QQYDJEPJa1oRnLnXHxjeqmSW4FMspVLunVUfSSUTbIfJ6?=
 =?us-ascii?Q?o2uejNxfvdGeK+aUxe/TvVGD8Pb8z2A8by1NQDO5F1upCp/y/42kF4pzVA/H?=
 =?us-ascii?Q?RKNTrXTfDV9fEEBKKj1lTBXb/6wKZ4NRe8jyqlYsr2C4e5U+NAhgaMkMokkW?=
 =?us-ascii?Q?yHjZHd1v0m0VvjpONomjaO5ZUpDNVWYOHsZmhLJh5zj+9LyuxSPGZkWAzaJq?=
 =?us-ascii?Q?Q/DJIQoN3meFPi1+Wf0W2Qj1rJDfp8mWDzN/qsKgfsSlsJuCs5OPIbFo+cux?=
 =?us-ascii?Q?DsIfwcCEstwgQ7FgRflZe2pxp2cROtPzjCR1bh67P8ceum3X2/LHdk6e+p/G?=
 =?us-ascii?Q?w71AyZWF8+i0Ia5QSVEWNAGjmRPs5fR3kZaYjD47enKHE43f/n0vcbcrlHjQ?=
 =?us-ascii?Q?TUZbuQbrwQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522463ea-301c-4612-6644-08da193366ed
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 07:42:58.8769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6XmIZN8JbGe3dSyDYWUOyJRq6KG8ez23xfcK+TeeS6OzH2l+i9SdoKw1NgjkoIlKii85JMaF+GMqTeirq0M3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace `if (!recvbuf->pskb)` with `else` for simplification and add curly
brackets according to the kernel coding style:

"Do not unnecessarily use braces where a single statement will do."

...

"This does not apply if only one branch of a conditional statement is
a single statement; in the latter case use braces in both branches"

Please refer to:
https://www.kernel.org/doc/html/v5.17-rc8/process/coding-style.html

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index a545832a468e..739fea437f69 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -818,10 +818,9 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
 			tmpaddr = (SIZE_PTR)recvbuf->pskb->data;
 			alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
 			skb_reserve(recvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
-		}
-
-		if (!recvbuf->pskb)
+		} else {
 			return NULL;
+		}
 	}
 
 	/* 3 3. read data from rxfifo */
-- 
2.17.1

