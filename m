Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B624B60AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiBOCDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:03:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiBOCCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:02:52 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5195D14A6E5;
        Mon, 14 Feb 2022 18:00:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/cnrGCtI2QLcvcEkDYyPlyIsQ1EDvGyRPGagrik9Td4md80SnB6uYi/87aGKZo1n+0/2MMg0/0CuUp6WGBp44azlS5TV/r24gJ+cCKOvAPZQVdfjU7+Bp6lbcm4ChYUbKryLRXnNx4vdqGiIxlx7uW7X+fmvlPtd5Ye/DxwvJOo56/tM2fe3Xi/bCerDZemtz5wzwOMIeGgq4jBOlsiKQRy1GLrOKw4tCRabYTExvkCAVhtxGV2Sr2wVVxcgPJdAHJcLNY08rhWqoYXQFypDiwFfq9yCgb3fsJMTqFI653fqiW8JayWTWpMxAkaxQ6iHWI4VkQ1mZDSO6/EoPklrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN9yVoPW2u6YS5qx7V2AfhcN8n8SKJmqbfYPXb4CWgE=;
 b=iPmDS761jtOZb9fAJ25dPZWT2QAyO3GxOwqhG/0dcZ3YUn15XN4qvD+iGpCoeAPSpKJykkdOgzOkx2EuwxEe7Dwo03UruNbT8iFDh9QWor6Y7A4D7V5fdog2x7TQ2dxch/k11oyLwApM6nHu17EIVAq4f00RxeTl1DlXa8aiJWwg5xd0iBTI9vRcI4+XngXv0KB6NjyXKl8xUv+ybVsme6TDodYXG+Syf3MvjEqPEh9OHQ8nZmIWNzcGsm6gzi2tY8gASPsOCeLqhEns1MBSfyXBrwJ6xU3c7pCVq7yBivG/xLb9+Jtok4cNM4Mge1Z81EJPlw1M6NftgTT7vd4Z7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN9yVoPW2u6YS5qx7V2AfhcN8n8SKJmqbfYPXb4CWgE=;
 b=L0cFTMuSSSD2OqyH4rdR7pActSyxhN2EJburt3/R4wBoU73R6FnJFlB3Y0SPJ/cVqhRvrI8F5NooYbt2ZZ6tZr170SH5nOS6QbhhGx1uOIyTSpA0LruDZHAUb6I0Wszlw6X0lYdgaHF8BHuc/yiO7fgqVBp0fQTqLFCM1z0Tb3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 02:00:25 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 02:00:25 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] spi: add missing pci_dev_put() before return
Date:   Mon, 14 Feb 2022 18:00:07 -0800
Message-Id: <1644890407-65167-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:202:17::30) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfd9b3dc-dafc-4800-1411-08d9f026eeb5
X-MS-TrafficTypeDiagnostic: TYZPR06MB4510:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB4510D22F9914730123B67C3BBD349@TYZPR06MB4510.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fs6LkEou8PCTyI/va7jMelRW8zvu1idxBFDxbFAfpsWEHVXu2wXJK43LwqzmRMo+ko0y+gTbHPrQh74AajVqDL6xt24FDCeM2rFv8WLdm5AgnzRFz+21Nkey7TU0EEr0tWSonduE7iuCRzpaAjuzfgtDuP/OIUmjsLVJR6rVWkY6bKzBb7r2IZu/2Ddw1N+vyVCHP8v9fh0PhC7BHIdqetlt5vSRAshnhhUX6Flldh0IE83jPOVCVOpkygWaOp0zqPOINIoHPj0JdxQf8QkiTPKp6eP6bN7QstJaJk7XgjmHbG08pbzsz3Gjn+SWO3MJT8KWsqXZSNtwrq5mkA7E0SnmX6Y6JiYVsm5S2edb5zlG7DcpLlwvPj9CbWGhIUgFfkcO9LL/WFwFpZRCBPX16LEIW0LI5MqxjhirdqBHF40j0PiId5speJD1mWxyg2ZdG5EDBFebENCoDc3Fay+2/WSayoWHSr+FP1Fi11IKiXwyZEcY9KecS06QL4i9yJ0h6SonjT+qkROUcWy0JxMin+4rdT8asIbRB5P5luTAKxpeUAFxBngeokkutt+kFasJYwwgJg/tFfJ80IBd7FxrC9yYjJCXFzGhbmsUPoH/IF/uSXEeOVhhs6D9FNFYwpC4qxNFYLi119fkuiTLkH5ByATN4T8+jlIZAW5ffWrjqonffj88EweoHKht40xjrQuBesyqgL75TxYVEimEzVsOpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(86362001)(83380400001)(107886003)(52116002)(186003)(26005)(6512007)(6486002)(2616005)(6666004)(4744005)(508600001)(8936002)(66946007)(4326008)(66476007)(66556008)(5660300002)(2906002)(38100700002)(38350700002)(36756003)(316002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oo7AlYi53f325/gtMymmSCTPQCROGCeaEZdvbVQopAMQVaJR5MzEuBH6oG/y?=
 =?us-ascii?Q?X/W20/Jar8srKPdPSvoY4XlrXSvFF1CboGE28tHyzxJGyWCIEtnmDEhyLeoZ?=
 =?us-ascii?Q?edHYxsA2hcnD5eoPoSZInxPR6ztXaXgIISgho1PiW7OUQiw5fiCwsSDb6HQ+?=
 =?us-ascii?Q?/nKmgNMZbqveD2xIXEoURf6GpI0FVCrJUfBlpTkzTwMuANICoB+AhzvHs0R8?=
 =?us-ascii?Q?xtdMFjnsGjxiG/KMLzWPEPRzjvdr7Jo5Gbk7WsC1nYwvV6padv56K9QVoJzQ?=
 =?us-ascii?Q?De4gNsoHIgtwFtmE2IhKr9EWHm4sMetC2H41rNZxrliwa5kQ/7fLIrUiYf/g?=
 =?us-ascii?Q?aseyA2P6z7ZtMq7DPqduJx5L6vgc6BREx+4VHyZc3Bi0gEb0d5Zcdp8lWX3D?=
 =?us-ascii?Q?LL9YYqknhxSF3ypemXcFHFsi6gf+lRXyAG78k9d70v4g6XOuKeDsrZWlCDaO?=
 =?us-ascii?Q?ApTM0rUMiTguL8CwVWepRyGYC0zFni+rYTv3kMO/kb35kjizl0cZgA1d6tJs?=
 =?us-ascii?Q?vrLQJ4XIk74YlIWVBt82WBWVqwQ+9bmkv/sDNH/p06QuyqdGzp+OTAQz4gkr?=
 =?us-ascii?Q?Lxb3sp93XfzQHqRIGpB8Z3Q9ho1A7ZZbEmDvh+2YOnpHCM6bnw4nXvR72Qey?=
 =?us-ascii?Q?xf/fiZxl9fVqaj40gmp26uV9/njEl5x1BF1dTsQ7LLoAMIhiI6YnnZFm4oi/?=
 =?us-ascii?Q?NfI0+BdO6adJj2GPFyqze7OGarPEa6PYk6mfSNhMgWXeRfB6CmV+mV87ZvBh?=
 =?us-ascii?Q?OW3HTt6NwFHnVTeR7aceIch0yvQgKBdy5k8VBw2l0a2WX8jyMAsCuNx+ff9H?=
 =?us-ascii?Q?Ew0FzZJEqPbspfXNyMyBIlwU9TDPviDeLyu2l6vBmlTDfaQcjQ9vbsXKNHB4?=
 =?us-ascii?Q?Nv2NyStopPNijEYtbSuWJF30a24ce/+eMS6JxH63wNJJaGyvsLkjQORgjfoq?=
 =?us-ascii?Q?eayhaedz8JBJbvyHo76JrGvkdq6QcQlSE7PPL2n3HDm4SGgdye+GL0T9Jgzu?=
 =?us-ascii?Q?ka9WCJ09vcnD1DCNVONa4EFy//ZSyN4HIpqQdld5NrYBPHPhOmpHk5sH3vNu?=
 =?us-ascii?Q?J2wJgW2/M78G7VWlC2lMvtMZeTDiP69YiSXrfvuDpF+SczkCO10WpjbqdMVK?=
 =?us-ascii?Q?NM5a1oYWbkbHvw1ztwUDIKRFZRypZch5GilqxWdMF8BjpJHWIhCG65RcNzHu?=
 =?us-ascii?Q?To7Ox5RhecKgo2PMHB+v3Qf1P+PFhcRnrEpRuSKcmjy91ylUrNp1uD4WR0r9?=
 =?us-ascii?Q?o2TYke4RjGEHwdtZzQrj+kqpVH2uj5ppivI0aAIcGB+z9UIO3iZbMcNNE8cg?=
 =?us-ascii?Q?zuT9i4JTQlGcvF001TKaghSl/LLKXUmeQytxQNL/KG+7/2oXuspto1xZBwA8?=
 =?us-ascii?Q?Vca/EWUJtTILF35XXx6guIQWH84IKtCvUaKrWYfpHpIjawKPzchksVD1qcCx?=
 =?us-ascii?Q?FctbhDPJuSOrr6Dw4gBA2PmpE5/3egt7/uEQYYPNF0UNt9/10SoLF2lk2H3L?=
 =?us-ascii?Q?vLHAeWL+Z15pXPH4p0M/bWBNKBzdvs5jwxt7oWYeWQpBJ+m3wBqH/MKK/oMS?=
 =?us-ascii?Q?TgcP9PyFBKeoImjubYisKKKU9AaPs1ZDDGpYNAQEya83jJ4VCfCc/N3Bt4BP?=
 =?us-ascii?Q?uv2LrZyb73mKyeiJeNWEeIo=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd9b3dc-dafc-4800-1411-08d9f026eeb5
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 02:00:25.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgRyWKFKeBfpK8I6WH8IfkOxf1wUV5XxK4ssecCJMcl58auV8oEoqkkXgecm5yg3JvPiA6wJiwrjINyDHIjMSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4510
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

pci_get_slot() increases its reference count, the caller must
decrement the reference count by calling pci_dev_put()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/spi/spi-topcliff-pch.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 8c4615b..8e1cc34
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -877,7 +877,7 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 		dev_err(&data->master->dev,
 			"ERROR: dma_request_channel FAILS(Tx)\n");
 		data->use_dma = 0;
-		return;
+		goto out;
 	}
 	dma->chan_tx = chan;
 
@@ -894,9 +894,12 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 		dma_release_channel(dma->chan_tx);
 		dma->chan_tx = NULL;
 		data->use_dma = 0;
-		return;
+		goto out;
 	}
 	dma->chan_rx = chan;
+
+out:
+	pci_dev_put(dma_dev);
 }
 
 static void pch_spi_release_dma(struct pch_spi_data *data)
-- 
2.7.4

