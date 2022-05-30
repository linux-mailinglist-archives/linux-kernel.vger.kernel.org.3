Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02697537B53
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiE3NW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbiE3NWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:22:36 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30074.outbound.protection.outlook.com [40.107.3.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15DE10FE1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbsJG4cPy0aVKFuKRAgC4uhCvLlcHPUyCVarDFkvQPG+TS+Ttk6xqLd6X7CYOp3CmTvXceBcGgjRdnEwqtyEshiwnElVk9d6gG8QzidTI6T5mO+QqIYCsC7+EVKrcbN9G8/UAKv0F2G3h3GzA7R0l9LUuaa/P3DHl8oSbTX6q7IRENcd2xQ/nKHGMFXNSwDVASdtz60S/WeFsFXzlXihPm9Ycn7eP3XroZJzRM6/kc+nJZsaEqRGys/BRWkpkLIkTBNLywKSKEL2bR+Rn6aZG98PF8zASulw5Wv1eCFkwAUFFi6GC4Y3rJhdedm6eDKGANpW4cs2JRgBFyJWQ7yEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSPIjFNdnRk4IR0W2usJZ+hjMggEmzmUzq/f11tyuVI=;
 b=PMUEi0wZIG0cqN9kVZg9mOE7h6xAIbki0rkgIG2SFQk9m8e3DTw6MXrhWtRRn0tR/mp0LI74GWJI59MRD1dCF2Oga6gFn+/ZaZMTkBzHvyykc1AYUvQuHWwwKmoFFjKx7w3VXETfoNnnxvaj0g8nVzOIPCoNkYFF26QdMoPeor3sNTFLtLmou2fr4ZCf98br7E0xgA0pM8bKzsDikMbWfhI1Vhv4gAOtmCqhU1kEHSK5s/OKRMUSgC1XlkwW7nNd0C3fLR2Mcbt2Wbb59VQz5rtYbil1b9jzSMA+x6bEJb8yaEF2sNJVN3WanhzyBc11pzQgpeXicrPINmQpEGcN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=diasemi.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=dm.renesas.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSPIjFNdnRk4IR0W2usJZ+hjMggEmzmUzq/f11tyuVI=;
 b=iaOzPl6D74ZpiOmz/Cc2PQ4/tXDrtueA0hGcFfXhhhQcmq3EV9wJ1tZto25W9JdBf3LytBVCdTx7twU7idmvFLDL3FwM9pmwqZq9Mlmp4huVbe/eQY9Y4HT+pJEZ9XlaPfqwDjfatKH/9y7C56HteWKc8fJhxrz3Q9AMfF1gWUI=
Received: from AS9PR06CA0501.eurprd06.prod.outlook.com (2603:10a6:20b:49b::26)
 by GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 13:22:26 +0000
Received: from VE1EUR02FT057.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:49b:cafe::2a) by AS9PR06CA0501.outlook.office365.com
 (2603:10a6:20b:49b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Mon, 30 May 2022 13:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=dm.renesas.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT057.mail.protection.outlook.com (10.152.13.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Mon, 30 May 2022 13:22:24 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 May 2022 15:22:24 +0200
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 30 May 2022 15:22:23 +0200
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 22379)
        id D212680007F; Mon, 30 May 2022 13:22:23 +0000 (UTC)
Message-ID: <b3f9a679f1e27a9359dcecb496953c4af30acbaa.1653916368.git.DLG-Adam.Thomson.Opensource@dm.renesas.com>
In-Reply-To: <cover.1653916368.git.DLG-Adam.Thomson.Opensource@dm.renesas.com>
References: <cover.1653916368.git.DLG-Adam.Thomson.Opensource@dm.renesas.com>
From:   Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
Date:   Mon, 30 May 2022 13:22:23 +0000
Subject: [PATCH 2/2] ASoC: da7219: cancel AAD related work earlier for jack
 removal
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Support Opensource <DLG-Support.Opensource@lm.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed6af9dd-19d0-428c-aeeb-08da423f6f6e
X-MS-TrafficTypeDiagnostic: GV2PR10MB6138:EE_
X-Microsoft-Antispam-PRVS: <GV2PR10MB6138E49329B5449E602C31A0A7DD9@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BA22a3jbdbTcxXN1gqVBbo4Ia8Cw6uiZO8RzPSjGjHYZ2Oxqcy2cSsR10G6/AzyglkT0lJjmvukUhRlFkckNKij8GkKBI7ZcU82UntZd1Eb3B0BnBzn9EnTWwqiRgFzjbxGjZ4coIeUsxe0UR954RxbFfJIIzS+Zpcrr0/uNR9Yf+mJhMvANKmUgI2fqzqNfC1QnBTCq6NvkFykO+WQUXYY7nnUYFQXeBrOboPO8K3+rfYheSa+6DDWPETCKAA7qhECfBgDaoqJ9ZPTuR0l9GQJKU3ONcbCngPG+YSz+USc0J8i87aIMII9pPx1jqWEuWLjUoxselLh+Tg9QgGiTJ32iBFUV++vBHmGdIfdEBGv4DjzEkNS+XI7sRY+1XPyJoWU36hJ4a09+UphaGeI95y3DTbpMufzWVoPXYPKhfEyftnjDH26CyG9HliQRW/z6Lfnfs0Olrc5V+Ax4oZ3kHRRrPEejiFJeBNM81rSkYVt9LZAK4s3bZ8ONCVVcgZgzV9ut4M6CC2Y0XJIZFTzCsBHWmfqpuVEBcY94npH55J1Yq9+EJk/BleFxZoQg5OeBpaIeqXkZySQ4XBhvqsq8XLVsi5a13YxxZfK/cO5SN6RAKL9njVKn6N3vADTea7nZN7jpAmbMTiCcJ7t33qQEsMvSKRlFJG483QbwX9bYO0FmNU6LlTNpgNIvVDgyvMzT48OZQW9Tr4SbrsFrniK3qOBpWT/J3wwdSqxFDoEM3Tzx28ihrZvbDCs2Jbsu+rgY
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(40470700004)(46966006)(6266002)(2906002)(26005)(83380400001)(82740400003)(40480700001)(81166007)(36860700001)(42882007)(186003)(83170400001)(2616005)(41300700001)(356005)(508600001)(42186006)(336012)(316002)(110136005)(8936002)(47076005)(54906003)(70206006)(4326008)(82310400005)(70586007)(8676002)(40460700003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 13:22:24.5619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6af9dd-19d0-428c-aeeb-08da423f6f6e
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT057.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6138
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid the unlikely possibility of register misalignment for
headphones being ungrounded/driven after a jack has been removed,
move the cancel_work_sync() call to the start of the jack removal
handling in the IRQ thread.

Signed-off-by: Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
---
 sound/soc/codecs/da7219-aad.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index e7d8c33e02cc..bba73c44c219 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -434,6 +434,10 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 			mask |= DA7219_AAD_REPORT_ALL_MASK;
 			da7219_aad->jack_inserted = false;
 
+			/* Cancel any pending work */
+			cancel_work_sync(&da7219_aad->btn_det_work);
+			cancel_work_sync(&da7219_aad->hptest_work);
+
 			/* Un-drive headphones/lineout */
 			snd_soc_component_update_bits(component, DA7219_HP_R_CTRL,
 					    DA7219_HP_R_AMP_OE_MASK, 0);
@@ -452,10 +456,6 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 
 			/* Enable ground switch */
 			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
-
-			/* Cancel any pending work */
-			cancel_work_sync(&da7219_aad->btn_det_work);
-			cancel_work_sync(&da7219_aad->hptest_work);
 		}
 	}
 
-- 
2.17.1

