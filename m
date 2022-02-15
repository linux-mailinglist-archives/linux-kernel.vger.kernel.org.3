Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33D4B60B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiBOCDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:03:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiBOCDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:03:01 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641D7C0501;
        Mon, 14 Feb 2022 18:01:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfkGtwH59aveyksWRmd/5yCeXGh/lOn7UmQr4Vge1Rhveej20hXZxJU7R5FX6RbSWPDZptokY9AD4+Hy3033MaNCqUPB7WdnaY/qiZXTLl8z+CmMdYBUEwp8IaB6f8yZx3cqTm0X7hlI4e/61ji+ajr0SRdoNdAsnCnhH2QS1Js8yFXE3uhnDhwQFIozN7Lk7mwW6AxAwH2ENa6vBUIpcDGckuvIiZyszkK31a9t6265fmUT2/NdEWEvWVZXhLdteRX5dCiy4F0SECLfA0JIigPzdo7IiTTs9pKfpTQSbntTWd6j13Qo67U6LT7/HHAcQqiesROND0hB1Z+Zlshhjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioDzbp8DotndxPnbhS3GHH1dcUDj+vkSuSIxuBMiQOA=;
 b=W2Bsc4HN3WOBRlh+r1HYoGlLRI3o/NRQHjAIUjxdlozk6TnDiJWF9K37jJvYWA2CrYOZLJcLq/OMiC2pslrfjesK4S6WfIs45GryBtnqjQKa+o3hHHdIEI8/ivSzMCRWf3fNZed54BtuaOKuSMbnGdthZSTppOnZN8DbrrtbJLvoYwQVBUH6wUi1yoR2kLhvtvS6av3KFCCDUG/1czYyO0EIIHxJHkVCKvRtOC9uRVAVRtG39RChVqjFqqQZV+Q+nzC+rWerYwpZGXqUjimmP5vxndooumvw0uefNVndM+NJu50z0P6Oy6VybHE+0dLXzc1ZcFrL4AES+uK3LBbL/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioDzbp8DotndxPnbhS3GHH1dcUDj+vkSuSIxuBMiQOA=;
 b=GGxPzuzRuaBrfoBAysROE6tWzTYkuk1oBKEMQ7WLfJhyYN/taKaGWOcqNyDq5WoDRXlmc03/MHBiiehxJUdv8zlTfV9G8ZUdggCdDUmT/vE6gLSHDpQjWbl1b2ee3T9LGEVeWKCVQ/EKLU0ChfIZ6pk4apaePo0WigDlqiZA9Hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 02:01:51 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 02:01:51 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] tty: serial: add missing pci_dev_put() before return
Date:   Mon, 14 Feb 2022 18:01:12 -0800
Message-Id: <1644890472-65306-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:202:17::13) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2db495d0-e3d6-47ef-fe67-08d9f027218d
X-MS-TrafficTypeDiagnostic: TYZPR06MB4510:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB4510A027CCAB8038B04E4E58BD349@TYZPR06MB4510.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oka5tKYXx/tJOQHk7po5wVdqA1/DlSziE7t6nxEUGsbK5tb/K+3rvJFjtzXBAYOSgwMCfYDeZ/MCsJZcyONPufi6HMLOt0UH0D8JiK08BYEjANZ8bEVzgXVLndue/p8PCrTweAFH3lIzZ2TH9OK7LtoJFetEFadYYY213XI8+O4h0CsMYIkkT6D/1VPJCEAkrbUs/RJyMwROq/9UngGwSCo+MP9KcKqW9gXeOBaXO18U7imq8WH3U6YMAeizuWIvVNbBDP8X7zJmBrFRji5D5SK/MpM7rj21Ko9HGEazcx1RCDKmSKSPOawR84uRDzNHJzHUUkIWSPhfqr+jF27pUE8jmfH7SJGFODqIg6sBrfrmGd2I/O8kXjprDA4P5+jcEnD7a6KaJgDMh+ngpPUS0ryYc1hQbRHQbIa1X3vDq7dV+KIyCMc/IozLGq/gB/+gvqvZIymxLjA57d35BfVqOn+Ksk9TOu+3TlIXCujw0JDZU9hZmaSypXSt30TIkiRSZLLbuFMy9zuroeQx7B4ukGsbDTS5JuKrZzPTKP327QEm1FCPeYzsGJRUOqnd+HF/JYJJw85dW37MDGOR3oxFZDQtaDlgWr7qcYdgW+YO1XeI5RXT1NWdhk9gOmqFthINb5aENRvoDTs7UPXCiOKjNQrcPhvr9GMKBsYUy8FxUjrkqKS4/7qBJxmjrmwB1s9n1mpuT1BsoQroem2ZxoeRXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(86362001)(83380400001)(107886003)(52116002)(186003)(26005)(6512007)(6486002)(2616005)(6666004)(110136005)(508600001)(8936002)(66946007)(4326008)(66476007)(66556008)(5660300002)(2906002)(38100700002)(38350700002)(36756003)(316002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OAv8msJEQKNxCsGw4YAo7PHqLeAxwFT/4t4OAYgKilz2Il27P1NZqGJwTW83?=
 =?us-ascii?Q?7WSHFYqTY6ha1pTg1g9R2TtcPerOihQzJQnAlGA0w8GZT2i3xUMDJZhZcW5m?=
 =?us-ascii?Q?MPYaCY6zfPVXybu1/DLxN9QMlHvtDRxNkQ5fm1Y8lZHNRPB4X/HprrhCMu8i?=
 =?us-ascii?Q?/6q3LAvAaOK3Ha93Cu8PpYTHDuZvBMk3e6NDK5d3/sjwTwfL8X06bt9zUjGb?=
 =?us-ascii?Q?ZDEM64FsJDT1n2xCMtYMSa5EIPymHlnVhpvh3g8xp+cb41ldVjSeEPT++L0K?=
 =?us-ascii?Q?oz7hEei5EmNRIuFsYGD5sv5EujPNh5DdAki6R3orxNJj2tKIlHpg8BN5n2FW?=
 =?us-ascii?Q?yfXhdMGtt4+Oizku+0lgqV/8s3KLQ+RU0GyVuzRDJIExwGqSWVd+F2cp/yi6?=
 =?us-ascii?Q?bM7rvzor7gcVV+CvQ1+nY4qCf6mc58aexuue9/j0F/L3dXLhun0Deaq3unjJ?=
 =?us-ascii?Q?b0IwcJ+yv/cSIOZctKfm2mycFVMDFTBzPUrNTEjyjCoBbKgEEe0m3O7LxFiT?=
 =?us-ascii?Q?r3hKy3+0vWsaLMFh1XJ+QHqXf3eZ5x+yqXk6piURx8gUl0ZR3xyUkWWsRFdC?=
 =?us-ascii?Q?51y/SUcGEJ/DPvDdjnjeyniEHBsafPZjvvMWnkIXhtHD5rSEtjlnuOhnBuM0?=
 =?us-ascii?Q?N7LE34V1oSlgU2IoWq7UiR2jlPp4inGwrNJ3YJlbU0PkMATrWsVIQgWd91IY?=
 =?us-ascii?Q?LIpVIgV6WPa4B8el5e/NExa6bJHU5PgHSFZYkwtWJYWo2WafVBnLpRrWm1mX?=
 =?us-ascii?Q?VapOVqxn+4I0vs91VwGN0BbWeP/VOFElrlmuAGsjP+kEkIb1p9K1ws99n5CB?=
 =?us-ascii?Q?+nFenPRqTLkGgjHC8JCPgvcH/2gIQ9E/TV+h990MT+k9eCQ3ZwI1CWQfsVBq?=
 =?us-ascii?Q?DsFkKqHGeKeABCYogR9z+Qx8k3iwoXmy46ntYYoF1KzEMg2SRy3rcJDHsv1I?=
 =?us-ascii?Q?KnxKYcUO//OlWDEouNFNN8QIjMGlDN8dLCzGjl/4Y57SNXjgpGWZViQthfOS?=
 =?us-ascii?Q?R/+aeaIvt9jBlEY16Xm4RG8qXG0qb/bb8a3X2L2CGKezQS/nriETQNusgP5Y?=
 =?us-ascii?Q?4j9Xe4hH+GoSXkuUiA4/KqKyVpeU8ljelT0LLCncclnnKPCEoFXHtdCFsJyJ?=
 =?us-ascii?Q?mjIimTXQWZn3KjfsljwNBHOvgtHHWbXNbrJ3CD5Ik9h0O0aAQ8nYwPuWCTHk?=
 =?us-ascii?Q?IQpISOSInrTcNwkmmusNEuTeiL5JOQDCbpGk5pEJqPQUDniDykDIDT+2J1A8?=
 =?us-ascii?Q?NDBvQHVWon2y4XmJQDFgDS2gfbcqH1ls7WPVX7SXY8B6Ek+01VYfnsHhItHT?=
 =?us-ascii?Q?rvrQetRSImuycqEhccOl4rJ73wk7KeptRlv8NdOwCa713SwR5um1xmOeID68?=
 =?us-ascii?Q?gZXHaxBTKkciy4av23++wxr5R4txmBHJbRhZht8JUgzN4aeSKwWKw/+wz30A?=
 =?us-ascii?Q?l1yTLW6xflVe5TwmHC4OieNNPceO9oI/Xb2nwVaWYgkCYic5FsndGHEoLhgZ?=
 =?us-ascii?Q?hKmH2KsbbsHpANmM2vuECQLyRZPqbuHR+6JnNCQPUHtIDWyeac95dvP81txd?=
 =?us-ascii?Q?VOMyLSknDOnA89tYb8aq89fc4lj7VJaUxq8g96jfM2NoZBEm2RXNGNy5I3Qn?=
 =?us-ascii?Q?zy6FWNA5ErcvXJnt/ivq7NM=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db495d0-e3d6-47ef-fe67-08d9f027218d
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 02:01:50.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0kDBFttoiq3Yv1AqYcOwmUUL1AWB5ZhXsznrsky9AKrmUt9UcSh8ynO0bBzZ4LWZOwSS0eKLzgXYaFxRtgGIg==
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
 drivers/tty/serial/pch_uart.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index f0351e6..da5a276
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -723,7 +723,7 @@ static void pch_request_dma(struct uart_port *port)
 	if (!chan) {
 		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Tx)\n",
 			__func__);
-		return;
+		goto out;
 	}
 	priv->chan_tx = chan;
 
@@ -739,13 +739,16 @@ static void pch_request_dma(struct uart_port *port)
 			__func__);
 		dma_release_channel(priv->chan_tx);
 		priv->chan_tx = NULL;
-		return;
+		goto out;
 	}
 
 	/* Get Consistent memory for DMA */
 	priv->rx_buf_virt = dma_alloc_coherent(port->dev, port->fifosize,
 				    &priv->rx_buf_dma, GFP_KERNEL);
 	priv->chan_rx = chan;
+
+out:
+	pci_dev_put(dma_dev);
 }
 
 static void pch_dma_rx_complete(void *arg)
-- 
2.7.4

