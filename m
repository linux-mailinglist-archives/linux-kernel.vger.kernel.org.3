Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7379F46D3F0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhLHNF7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Dec 2021 08:05:59 -0500
Received: from mail3.swissbit.com ([176.95.1.57]:35286 "EHLO
        mail3.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhLHNF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:05:58 -0500
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C72B64645AE;
        Wed,  8 Dec 2021 14:02:25 +0100 (CET)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id B8A354645A2;
        Wed,  8 Dec 2021 14:02:25 +0100 (CET)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Wed,  8 Dec 2021 14:02:25 +0100 (CET)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 8 Dec 2021
 14:02:25 +0100
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.014; Wed, 8 Dec 2021 14:02:25 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
CC:     "johan@kernel.org" <johan@kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>
Subject: [PATCH] mmc: bus: Log bus width info when attaching card
Thread-Topic: [PATCH] mmc: bus: Log bus width info when attaching card
Thread-Index: AQHX7DLvbfJedhQ2P06N1hRDzW4jFA==
Date:   Wed, 8 Dec 2021 13:02:25 +0000
Message-ID: <c207948f590d4e88945a314bf8299f87@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26576.007
X-TMASE-Result: 10--0.301200-10.000000
X-TMASE-MatchedRID: w2TFuZOvAtd1YbXHcTLg6KoXHZz/dXlx0MQw+++ihy+ZLRO16GOkks1O
        WEJHlxMYCr+rgpj8cSlU+/f9Sgofe4qLWFapBjxa/bV/VOhrmop6i696PjRPiAdkFovAReUog9x
        e4gtUJtpj0t5XbW0oX7y9FG2Ig7OzqZWpk+GKRVMCg1rav4R3DX0tCKdnhB58gUP+Fn6N6KZp7q
        EhmmPgy46HM5rqDwqtkWZl7o5E3PAbYfC9WA4XrlNfMClgtOxmyPGA2aTH0dI/wLZGeOBReA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 3bc1caad-c41b-4cc9-82b0-655743a761f1-0-0-200-0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add info about bus width of the attached card to the bring-up message

For both MMC and SD cards the bus width that is used might
not be obvious to a user. For MMC this might be 1, 4 or 8,
for SD only 1 and 4. In both cases this would be a restriction
by the host (setup). Like using an MMC in an SD slot or an
eMMC to SD adapter.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index f6b7a9c5bbff..71a675dcd9b7 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -358,7 +358,7 @@ int mmc_add_card(struct mmc_card *card)
 			mmc_card_ddr52(card) ? "DDR " : "",
 			type);
 	} else {
-		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
+		pr_info("%s: new %s%s%s%s%s%s %u-bit card at address %04x\n",
 			mmc_hostname(card->host),
 			mmc_card_uhs(card) ? "ultra high speed " :
 			(mmc_card_hs(card) ? "high speed " : ""),
@@ -366,7 +366,8 @@ int mmc_add_card(struct mmc_card *card)
 			(mmc_card_hs200(card) ? "HS200 " : ""),
 			mmc_card_hs400es(card) ? "Enhanced strobe " : "",
 			mmc_card_ddr52(card) ? "DDR " : "",
-			uhs_bus_speed_mode, type, card->rca);
+			uhs_bus_speed_mode, type,
+			1<<card->host->ios.bus_width, card->rca);
 	}
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.34.1
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

