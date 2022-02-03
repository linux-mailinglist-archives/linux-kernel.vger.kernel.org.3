Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1B54A8214
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350010AbiBCKJX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Feb 2022 05:09:23 -0500
Received: from mail3.swissbit.com ([176.95.1.57]:59852 "EHLO
        mail3.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiBCKJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:09:20 -0500
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 06D24460A9F;
        Thu,  3 Feb 2022 11:09:19 +0100 (CET)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id EC4F546322C;
        Thu,  3 Feb 2022 11:09:18 +0100 (CET)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Thu,  3 Feb 2022 11:09:18 +0100 (CET)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 3 Feb 2022
 11:09:18 +0100
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.015; Thu, 3 Feb 2022 11:09:18 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Avri Altman <Avri.Altman@wdc.com>
Subject: Re: [PATCH] mmc: block: fix read single on recovery logic
Thread-Topic: [PATCH] mmc: block: fix read single on recovery logic
Thread-Index: AQHYAlL02lgrcWpb+EOcEaPCcQdJl6yBx2Gn
Date:   Thu, 3 Feb 2022 10:09:18 +0000
Message-ID: <7c4757cc707740e580c61c39f963a04d@hyperstone.com>
References: <5e5f2e45d0a14a55a8b7a9357846114b@hyperstone.com>
In-Reply-To: <5e5f2e45d0a14a55a8b7a9357846114b@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.17]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26692.007
X-TMASE-Result: 10--3.675200-10.000000
X-TMASE-MatchedRID: 6E41RGmUyPrUL3YCMmnG4pkuHsgxfUFHAQ+35UHH2f36eRMM1gvcpCaC
        jkFKp/+ebb+wP0Qo+N6TH1CW/Tkdqjfa6I248QZMLIrMljt3adu6dLKJpXxNs88DuAI4aSPIUWr
        H6uLHVmtRmLjbyj6kWmX11xk42G8LTs5DMzlmM75wju9EALAXQlWiBZGwRpH+xuolijDY9YAEY2
        eP08wZcuTlgVW5pemqPfRUVBjvSwsZHQl0dvECsZqvoi7RQmPSVCGp3g4/hjuxLSxkQHtzxtskx
        tNP0r9NrdoLblq9S5ra/g/NGTW3MjmzjEr3tKb/xwBkXG2rycZ+tO36GYDlsj7y9gkl1CGUo8WM
        kQWv6iUig6xaCvyzXY6HM5rqDwqtmm/tjUqU0sbdwni0+hA3TF+2Mt0DNJdsa+FJvRU2+c6BIUG
        uEvaFzA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 2b18a417-0f9d-4db4-a53b-f7e2230719dc-0-0-200-0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So could anyone take a long at this so far?



From: Christian Löhle
Sent: Wednesday, January 5, 2022 5:43 PM
To: ulf.hansson@linaro.org; Christian Löhle; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
Cc: Avri Altman
Subject: [PATCH] mmc: block: fix read single on recovery logic
    
On reads with MMC_READ_MULTIPLE_BLOCK that fail,
the recovery handler will use MMC_READ_SINGLE_BLOCK for
each of the blocks, up to MMC_READ_SINGLE_RETRIES times each.
The logic for this is fixed to never report unsuccessful reads
as success to the block layer.

On command error with retries remaining, blk_update_request was
called with whatever value error was set last to.
In case it was last set to BLK_STS_OK (default), the read will be
reported as success, even though there was no data read from the device.
This could happen on a CRC mismatch for the response,
a card rejecting the command (e.g. again due to a CRC mismatch).
In case it was last set to BLK_STS_IOERR, the error is reported correctly,
but no retries will be attempted.

The patch now will count both command and data errors as retries and
send BLK_STS_IOERR if there are no retries remaining,
or BLK_STS_OK if the single read was successful in the meantime.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 90e1bcd03b46..d7d880ce0f8a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1682,31 +1682,31 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
         struct mmc_card *card = mq->card;
         struct mmc_host *host = card->host;
         blk_status_t error = BLK_STS_OK;
-       int retries = 0;
 
         do {
                 u32 status;
                 int err;
+               int retries = 0;
 
-               mmc_blk_rw_rq_prep(mqrq, card, 1, mq);
+               while (retries++ < MMC_READ_SINGLE_RETRIES) {
+                       mmc_blk_rw_rq_prep(mqrq, card, 1, mq);
 
-               mmc_wait_for_req(host, mrq);
+                       mmc_wait_for_req(host, mrq);
 
-               err = mmc_send_status(card, &status);
-               if (err)
-                       goto error_exit;
-
-               if (!mmc_host_is_spi(host) &&
-                   !mmc_ready_for_data(status)) {
-                       err = mmc_blk_fix_state(card, req);
+                       err = mmc_send_status(card, &status);
                         if (err)
                                 goto error_exit;
-               }
 
-               if (mrq->cmd->error && retries++ < MMC_READ_SINGLE_RETRIES)
-                       continue;
+                       if (!mmc_host_is_spi(host) &&
+                           !mmc_ready_for_data(status)) {
+                               err = mmc_blk_fix_state(card, req);
+                               if (err)
+                                       goto error_exit;
+                       }
 
-               retries = 0;
+                       if (!mrq->cmd->error && !mrq->data->error)
+                               break;
+               }
 
                 if (mrq->cmd->error ||
                     mrq->data->error ||
-- 
2.34.1
    =
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

