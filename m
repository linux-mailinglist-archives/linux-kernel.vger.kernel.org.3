Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F9F57A33B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiGSPe1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Jul 2022 11:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbiGSPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:34:11 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFE9599DD;
        Tue, 19 Jul 2022 08:34:09 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 25794122FE0;
        Tue, 19 Jul 2022 17:34:08 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 12AFE120CCE;
        Tue, 19 Jul 2022 17:34:08 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Tue, 19 Jul 2022 17:34:08 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 19 Jul
 2022 17:34:07 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Tue, 19 Jul 2022 17:34:07 +0200
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: block: Dont report successful writes with errors
Thread-Topic: [PATCH] mmc: block: Dont report successful writes with errors
Thread-Index: Adibg9VERWQQSIdlTuivPV3k9XDqxw==
Date:   Tue, 19 Jul 2022 15:34:07 +0000
Message-ID: <ca06b94aa48a484d965744e64e17a4ef@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.44]
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27026.001
X-TMASE-Result: 10-2.979800-10.000000
X-TMASE-MatchedRID: PlzjzoB73n1A3pPQZ4eO03tpzPuHdtTCwTlc9CcHMZerwqxtE531VNnf
        JrUSEbFDoaDyAnFkzMXD6kydICBLz7/JfEf7Nh5DN70wXhI0DX7hKQh1LCmGBpsoi2XrUn/Jfyj
        BJDnutUhQSFbL1bvQASAHAopEd76vZeKa5SOmTt0+kvrK4jjSrfjun7bNXGinzWfOx4wUtfNlqJ
        r0AjU8IA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 5994de77-7190-40f2-996f-02c4f0ce88cd-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be as conservative about successful write reporting to the
block layer for SPI as with normal SD and MMC.
That means on any errors bytes_xfered is ignored and the
whole write must be repeated.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f4a1281658db..63d1c05582a9 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1765,8 +1765,12 @@ static bool mmc_blk_status_error(struct request *req, u32 status)
 	struct mmc_queue *mq = req->q->queuedata;
 	u32 stop_err_bits;
 
+	/*
+	 * Either write timed out during busy and data->error is set
+	 * or we actually received a valid R2 and check for error bits.
+	 */
 	if (mmc_host_is_spi(mq->card->host))
-		return false;
+		return brq->data.error || !!status;
 
 	stop_err_bits = mmc_blk_stop_err_bits(brq);
 
-- 
2.36.1

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

