Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B74351BE69
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbiEELym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiEELyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:54:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1037550E36;
        Thu,  5 May 2022 04:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDqFdEaq5LRtMLMeq6UdjKXw7y0H/3EbWEBNpZOKdxQTBkm1mLLOvhlpMuVrIuOeAzcgXT+YN93kxh3j9UOUYnBLrZ0MWCvLmmd58VrPH4h9s1mPix/vXiwN4PfF9mg91+BIfML952Z2H2y5puDcQJ8GUaQGmgFxm9YMwFw0xLxMrR9BEtYnFgCndhbkoWWwGsfTsJQGXi0hwd7o6xvNzCAR/KJsxe+Gb2ZmOBD6mcFHX8CxFk0qQHLleDF9tETLQ1SA8XHj9Z7Q0SE8CtQv9RfMzEZD4jvRHcFEMpOKV2CwJvcT1X+z1/HJOWjFr7OXRrDNwNoShklZ0dNAUEpMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Kv+Rv2BJQy3n8dgp23e1qpWsaVqwU1P5PGIvfpuWZo=;
 b=buPUvjqpY5+A1XDq+BbDrBSJ7ydsVJvvuvqdQD5J70V9sLzOkrzfm5WdWRv3AZ2Rc4I70kzE5n+QISPXfg+zDz6jnNAHWwsFGAVgbeHUMT3KruPfeG7fQ6YPekhuPRRo3OCzQSjp0Pv/4/pHgSKApgGm6zTu4gy7Ycbrr62CZ/kJK/aURuzYyOMpBpnPcSAY2g2CZfpAv2g0jyG3hZbexLRfIWSnouNin554qs4ZxpK4pjMLRShsl0Jel3r0s3wVcKMXkywQDoDCiWL9Ol0t/66CLhthSGH79X3aTkmyjONfV/Ad5cU5oGWa6YvKUNZeIHrxgwZDdIyynVk5ntcMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Kv+Rv2BJQy3n8dgp23e1qpWsaVqwU1P5PGIvfpuWZo=;
 b=LgS8fU0wJj4VYq2Y5ysrKCVwX7/HqaxYHfkYPP8Ug/djFELP8D6c1BufjuVU009j3jFVvOxVfkbIUc181ScNn3bVUn7H6RgEYmHrGtPDgZWyCJCO2wyORvkvakb8Xj3CcMFALfOlmqYPmU+znvCUDzsgUZwwwOeJgNfRJ+1Qz5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by SG2PR06MB2635.apcprd06.prod.outlook.com (2603:1096:4:1d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 11:50:53 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::d4bd:64f4:e1c0:25cb]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::d4bd:64f4:e1c0:25cb%4]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 11:50:53 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] gpiolib: cdev: fix stream_open.cocci warnings
Date:   Thu,  5 May 2022 04:50:11 -0700
Message-Id: <20220505115011.3435-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0177.apcprd02.prod.outlook.com
 (2603:1096:201:21::13) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ada459f-5f10-4a9b-7f3d-08da2e8d81d0
X-MS-TrafficTypeDiagnostic: SG2PR06MB2635:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB26351FBF5CB1201B93BFF495A2C29@SG2PR06MB2635.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OnXQ3mbO+eDtur5btyYYww7STT5eL2HpECc7zG58gyMi+hkPJjZPJpjs05hgUAw13BiRa/vIEMA7x/v2KHNBLx9+oBGFuGFckv4TCGe5rajzfSwahFLTNV4U1iJZFhZLsp8YxZe7LourIS0yJA+CmEmA9XJoDCHJWmLq+isOLFavi6hAIDwGk0rVHSJMd6FKK85Tw5DlxYXCv50AGCISfjr++FWJg5TItU8/nEcx+UoSm7cUe7hZoVGAosvOwhzZpwyEGmm2qZNpOs02v9WXL+GXivHhz5gGLQKDUPD4MbW8n28xW7M+CEVl1OCjfRBXtKRDMFNAmBRvODXgev1KpKrcmz/W5eNTqbiQBepne7bWuO9fsef7X/0Cv7KzK76EjdS6zZCVliFnIqKEL599yXawSpFYljgbpR1OAOB3MPdLHgc55uvyjaXl4kN2Y9YuQAA360bMR/en+g6BELtIhCpMWEbeRXjigdsLlp2DJcoH7cTwz0eU3Bu0hazyATGGqCNNH8m0aOieXy3I3B1LlxJoNQRbItj6Vb3TqY36+PQ60KT3QOxYBM+1Ks4d/QUCejoDu2CLMY6odBiA7K4/I20JK/6OTlL7yiPgc3jM8YDJVAs+QRNYhRRSELb1VCmbBlh8hVfwiIGsck4+IMSf0rnDoTK0mulVy1w6T0VUmMFHnWYRjAQRIEzEI63QZklORwt3oGJOpTiuR6H9gyC6bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(86362001)(5660300002)(8936002)(36756003)(66946007)(66476007)(4326008)(66556008)(8676002)(2906002)(4744005)(110136005)(6486002)(6666004)(1076003)(6506007)(107886003)(52116002)(6512007)(2616005)(26005)(38100700002)(38350700002)(83380400001)(508600001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MQaahhITe2A+yKbisDKl0aiSPftnMxMGsz8sNIk6/SBR7rWUkpbJMnxq1iao?=
 =?us-ascii?Q?bOIWATijX7mcQaHcNaoVAn2dzF+Kv32YiqYUYZixX6HhT4cRjBy9uCm+JxvM?=
 =?us-ascii?Q?2Rhm3BXN2FWfdgfxq5kd/N/kocESo82TDmLjwZmoNqANdjFPZz1Blarl2FuZ?=
 =?us-ascii?Q?tm7+DpH6xj5XIav/PVfQkovwxDAees+UBH99rsurFFD17LLSt9S9J/YG4RbM?=
 =?us-ascii?Q?6Jq5hBmk15cJfK2A80ommt7wZr7m1HXkKecSDPuDDJI1bmgk6GxDhMWFZIqy?=
 =?us-ascii?Q?xq5oeTd7eRL4MZWFh+qWAaoNsuljW/7LapzALZ1P98LvxUlDdoza15uQcdgA?=
 =?us-ascii?Q?cHtr5lYh2iDrlUZhp9VdWUEA14T/R2mmhc+zYHKVBlaeuON1g7mESTBNtnwN?=
 =?us-ascii?Q?SlG7dE3jr3nsHJH4Wt2Y+AE7HryvmTpzqfV+MIaVYC+Kj39O3cAs1eHUpKhe?=
 =?us-ascii?Q?2jly+YcbPTEeNkndUPLo4pHoZ1TGR8rxUvqdyFUF9ekSElZh8PGvReZCX7Z6?=
 =?us-ascii?Q?C2fJ7NX1lz/jrE8plUNDMQQ4GtO8zYx8Gt6dJN+QuFNkISWQ04Vxa90sftNW?=
 =?us-ascii?Q?7qjNO7IKUqvXIZ2G0UvsG06L708YstpQYb/4mCxjo/qSh48m2qHGJzJPOyhT?=
 =?us-ascii?Q?qevQAcuilW4F06vtE2CRMEWtOpWntPEVtxONvSYHUDuFR6QmNuG4U9AQU+Xj?=
 =?us-ascii?Q?iBd3AQY9MveLODLsdUn61UZyBeXpkicaTe2EAf5TwF99BL4EPwBfTV+yvsoq?=
 =?us-ascii?Q?Hk2ZEYwq9Lgy7SzFqvFCYIEE91UmXmmtHoSP9FAlA6qFQKffNGpAX2/MZFnJ?=
 =?us-ascii?Q?QFExmwkWEv+F1hLBKgPbSD7cUDLWaNBmxkYAtk6pXINKldHtlXHMbv3ApAUo?=
 =?us-ascii?Q?w/xhlsj0p4EUSbH/MiEx26uY8iyxm9skPYkn5mtZGeDdlqQmEHbxsSvOKb7B?=
 =?us-ascii?Q?LVm1wbg1rpMb2mXeo1rBqxoz2XMdUG2LrZp0FyHDLDP8ucBJ33NHhErTg7Uy?=
 =?us-ascii?Q?zML5ZeWJYjPLMGuE5p7G5HlwVWTAG0wE98AnoJo1X3x2zFJzcer6jEXgj8Js?=
 =?us-ascii?Q?UOlJqaAPJG4xOye/I54aVWUL+8opVgLlbqSwTgSHfqcFR9QRj9dhDNYJfKWd?=
 =?us-ascii?Q?fBQdQGvZIk1l0iAcj2TatXL3nB9UmVNj4BAkvtsGy3Nsoa3Es7kU6L5yt8DI?=
 =?us-ascii?Q?LopRJaWTnoD6GixGQzG/sAAyVkJ108hZOdpYO5Qyg9ZdezT+cX7rCQfVyIOF?=
 =?us-ascii?Q?cjB7Ui2iduYvBX0X0uzaC+f6vMMyNxmeZCDH0OLJ+4CwGsAtt3cYNLIaESHB?=
 =?us-ascii?Q?wTRMXbuOcSaOSv0wbr+9ypFHknZOdRQfp+LLoHttwaR3V3ihOJpFpb2rYPgD?=
 =?us-ascii?Q?1xwDWswo0HuqhEVQ7CglvnZOF1DslgRhg0XVcVaMxks42K3Ta8vmx8jjCQlH?=
 =?us-ascii?Q?NTVTDqKXO7oqb4S2YKlW8BeXG8CSirrp3nHvYcZX2Cp/vod7u3ftCC7SYPWq?=
 =?us-ascii?Q?GXpvKWEhS18P66RIRmBEU8Kn1wJfio+jP6Tv24Oa1IChQDLJTHcXyh610WxQ?=
 =?us-ascii?Q?/Mk2Xdat4QQ/wW2vToCQM19Mf2QPRB4OMPHokvF4xh7vz4LNwm99xqSCr9Pd?=
 =?us-ascii?Q?ZrgvBh2s62PjMVgO3CfkSfwtq4IB83av2gHydbAqHXQvFbDwl+eMXAzgHGD1?=
 =?us-ascii?Q?OqTyJzZQeK9VF4GbS3Svdv8mrPFd5hp8LBRm2ieknA+ehi3cHK8vqhi4qPLG?=
 =?us-ascii?Q?HDkwLVZltQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ada459f-5f10-4a9b-7f3d-08da2e8d81d0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 11:50:53.0943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Txr2GUQKh78A8ZtTwkmjWRoM3Bj9VyxLrjgalv2gQQeW+uUr2xkK6OhxMdGaWXUcVZIAjl3cChIsjK1xU4+rHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2635
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/gpio/gpiolib-cdev.c:2498:7-23: WARNING:
gpio_fileops: .read() has stream semantic;
safe to change nonseekable_open -> stream_open.

Generated by: scripts/coccinelle/api/stream_open.cocci

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/gpio/gpiolib-cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f5aa5f93342a..d03c8e012c8c 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2495,7 +2495,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	get_device(&gdev->dev);
 	file->private_data = cdev;
 
-	ret = nonseekable_open(inode, file);
+	ret = stream_open(inode, file);
 	if (ret)
 		goto out_unregister_notifier;
 
-- 
2.17.1

