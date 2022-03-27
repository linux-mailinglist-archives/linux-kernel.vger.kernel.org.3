Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F324E874F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 12:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiC0K6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 06:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiC0K6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 06:58:22 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2103.outbound.protection.outlook.com [40.92.107.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D99113FA6;
        Sun, 27 Mar 2022 03:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBvgZZufKa0oI4WkHzjHew4ACzhGJoUOJ1IMcz/OmJ/xQRvV4MziC/2YetIf5O4pu/Ae2GWREhbQBgf0T4IYrMmBBk9CPAZrZpgzSGxuP37E7dsL8klxK8jNNOL6nrOdWm6J04bia+Tm1ePEcIqERarJeeuv5w0jkLS8Efv9QR09kToV+ufEeq8hJv4bz7NQqmRwMqIEIO3QKed4cR+pzVqDUBZzb7JhfnheGy8GP0jOfJBuBmaHvdb5DdbL3h9yfd96Zq9Qmui81cBTYDGsFERYSHn/HLZZuQEQ/8STxU3aGlxPwtClPyulDzXn2e7+n5fck01G+FIsRaUfVu6IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oz1hykK7G5ExqM3oCQgjn0eepPCsyUCZLc14Ohbw7jA=;
 b=YSN9+LhyE808jYA5aiFQYGEZhS7jBCBwnDqji8m6nBLWgWqyfiVeUnElTeQiTBih9XyBWjm3KX6aFUU8wX4WcfOls/l/bv3wl5MfdQzbdRCaPUV28t5TLOAVuS9s0ecrZVtcXsiTFOfaGRa1eQXfd5QVsO1FN3u29U2V7cwb0G74TMCoY/IE4sSJ6sM8qjzDqKZjZOLtkUNBQyLl6jW2NIuUNg/1rG/Tvdqn//C+DezfawlOU+3wjTai3vc92LhzsZ0Dvr2Bc8GUBoMijrSk6tU2r6pL0h/QkbELTQulhihgBKWUJPR6y/usqUw1jNvFQe8HkWhGwNeeXH3JUOn/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz1hykK7G5ExqM3oCQgjn0eepPCsyUCZLc14Ohbw7jA=;
 b=KmawTcaxKEFei/BZDErM5ceo4KzfB0q5lRHyIjDiXes9ixF7a+PltAxMvxvto8AWyGX3b/epBrbHWLEbGarXEct3BSzmpghSHRdzCShGQTNxOyH8cu6BQGYgee9fic4bMXwyJKbUmOGHKqRssiJ6cZvCoC0xgRuNBM0HwOMc3Kt7DRRwBBs+Awb/8I22khRxT6R1rFahZYKiRv86+vrytFxU0FHcKhWdVy2heWKcq/aaW0BgjIRHH9s71jg6fP2tSvO15P6bUwtwu9B3j9TagUrgn4VDmMFcMHk2c+m6Anf0IWvzTQRY9c5YtNkAcdZ8ZVjaXmhLCTXZE8OOkHH3rQ==
Received: from SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 (2603:1096:4:106::5) by SEYPR01MB4438.apcprd01.prod.exchangelabs.com
 (2603:1096:101:5e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Sun, 27 Mar
 2022 10:56:38 +0000
Received: from SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 ([fe80::d179:ecb6:188c:f9a]) by SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 ([fe80::d179:ecb6:188c:f9a%4]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 10:56:38 +0000
Message-ID: <SI2PR01MB392995043CACD80884A13764F81C9@SI2PR01MB3929.apcprd01.prod.exchangelabs.com>
Subject: [PATCH] USB / dwc3: Fix three doc-build warnings
From:   Kushagra Verma <kushagra765@outlook.com>
To:     linux-doc@vger.kernel.org, corbet@lwn.net
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 27 Mar 2022 16:26:33 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-TMN:  [AYzAduKns8k2Sgspb/MG7taEPVA2cxCf92n5CGJrRY4=]
X-ClientProxiedBy: BMXPR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::24) To SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 (2603:1096:4:106::5)
X-Microsoft-Original-Message-ID: <c22b74b26f19efd1ea8acba7e3f55302e62d49f0.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2292d59-efb1-4aa1-d0c9-08da0fe077bb
X-MS-TrafficTypeDiagnostic: SEYPR01MB4438:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDNE+XKTNytXmR8eR/YveuTiMQlHTPz4oIr5AV/brdh87AMwPd40wJvMZajjvvn0GeBoHwO4aAJuSK5YhmxSHWNiiLB1PY8cpg99gQToxjw2J7LJnaBzb1bswvn+c0y3jC3dosgt4qOwgKQIL9b93RF62/aSSCy4IYlQ3cXyKJb30X8E14k6Qh23iipuUX1mWqLHPIDGkIbDldvKe0UtwBP7JDaZp4qCDtGTW2Q0FnKIg/2bmTFCwMX9ynvRVMeTRNA5ehXSmmZduz9fMhF6PlsRxQnx45Ts/kbHgmEOEvpOToPDixmvSyNUPVchbbCDEhyDTZiLSMMgj03zZ6jIBCw9AHwLO6X5+cbcvqhHEs+p5hXksVxR2OE6ykZqRi83zM/hP+laacCpTvA3PB8TB2fvCzyAScKslcZHlmKAAreGopu8tMdyyO3SbNI4Zfvkq65YZrMW3sLoE5llztUxJXXmGqptQfr11mf5pyP2AiIq4DlI6qlbLtREXTRv1G4pGaq7d64/1A4WwuZOKY3vtI/Xd3U2xlbABRUX1Kf9TNo8WPUrpQPbWJV5VAYQjp4fi+yo8Van2h9GwdVxXIvp9A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTFicWEyenhSYjlraEJ6QTJIVTg2MkRSTGJVdm1JMktXVGtYY0VMNEFrdnJ4?=
 =?utf-8?B?dEdvZXE2ZDUwcUNlSVluQmF6UHBidTdIeXpjTTJzVGZ3NVFBSExUNy9DQVI1?=
 =?utf-8?B?RWU2MkRFUDdpSDFzVElESXUrR0xHQmhuTjBncGwySmpsTU9vK2dicjhEeHZB?=
 =?utf-8?B?Zzl1TUdsVlB4YWx4REI0eklRNkp5UjQ1a2szTjRvU1NXOFpUOXFQTEpraGdY?=
 =?utf-8?B?TlM4TCt3NWtwTm5lQUQxRW5uV250N3JjMCtSRlZSQ0kxVk5PbDlUTXJwTDhP?=
 =?utf-8?B?VkxXc041R2w2VnNoWVR0MDJud1BkNUZjODJzMFVmY3hzc0tTdk9qNEEvZFhF?=
 =?utf-8?B?QkNmNnZYbjY2UG1aQ3NvMGZUL3ZQSVE3bnorajRFT0Vrclk4ZFRLdEg4THdD?=
 =?utf-8?B?KzVNWjVtZ0I3d0ZLcjZObU9VRTZxTDY2SGFpcVlvU0UrL0taTU56NU1FRDU0?=
 =?utf-8?B?Q1NNVFRGOWtPc0phbUNuL1NvckVuY1I0blh5OUF4MjQ5WXYwWTlZeXk4WUh0?=
 =?utf-8?B?TVdBUnZmRXhMWHZlSVMzajJkQlZRVUVscjJqK1BGVEdueFdWdnFTcW1LSGhs?=
 =?utf-8?B?dXJ5cnR2Tm9iN0hwdVJsTGFEZld5K1JTaGtGRlp6R2x3RXJMYnJpVVU3Vzl3?=
 =?utf-8?B?MStXdmw1eTIwQkoxVjJka05DV3lnaFRxY0V6R2lkNWo5eExpeGphZnRLYTJC?=
 =?utf-8?B?VTdqTklwMkRoZFNkcE84ZE5Ybm1YOTJleERvZ2EraDlpYXFuRGJNU2VFakdH?=
 =?utf-8?B?T1EzaWdCdi9qWmI0Ti9jSWlaTDhPWGh2MHl1bDFRampWUWpWc1piZGswdnZp?=
 =?utf-8?B?L3JLYUlJeXUvakYrN2lKRlpzNFVWWEpQOVFLR3lKQWFvQUVkN0taM0piWS81?=
 =?utf-8?B?NEhZVTgrbXErSGk2UnhiSnJaVWkvTXRpSUVGSVJvTzJwRUJBVEc5NDNkTzdR?=
 =?utf-8?B?UjVzL0pIYlFZNGJMZ2JzVzh3aDgvV0IxK1NLOFgrcHJBWVFRWGl6VldnSTJ0?=
 =?utf-8?B?bHBQa3BNOVpoOFN5U2NLNlRUWEpJZmtrNDNrVkovdmcxdUxIK0lKRDdsbFNI?=
 =?utf-8?B?azNITXZ6Z0YyVjJ4TWlJRnovUTAyTzFDcG5RM1czZDFubG5tNFI5QXFWSDV6?=
 =?utf-8?B?Z2VidVZ6bjkvRzlpYndpNkgveHV2bWNIbnRJMjZHcUVZOURxZENsTnowdGFQ?=
 =?utf-8?B?T01uNVZvVFRQMUhxemt2WEU4T25VWXoyODNEVThxK1dqcjlQR0NBTW9BRVdr?=
 =?utf-8?B?bmM2cndYKy9lcC9xVjZ3ZFFFQkVwdCtnMFdTS2hhR1gycElWazVJTUV0VDlE?=
 =?utf-8?B?MklKM0tOc002bXhQbDVRdUU2d3JaZ2lFOWFVY2wrOWM1MHBXUGZpek52Y2xK?=
 =?utf-8?B?YmxCR29TY1oyQStVQVVSVktvQmVxUnZiQ1NyN2ppNWtFZFdYOTVuR1M5VmpN?=
 =?utf-8?B?dU56VUI1VWdVSXNoalJLTGFtVGFrWTVLZmo0Uzk5MUR1QUVwWDhIYlovcWln?=
 =?utf-8?B?dzNVR1pkRUpjbDM5azVZVlhFUE5udG9OWHdCWEUrd2JTNWdMWmxvVnB3K1RX?=
 =?utf-8?B?OFdVZ3BTdVNwQXZZYmUwcXpKSkxubmtwQWRWd3hQaHU2elJNTzk3Q2R5c1o2?=
 =?utf-8?B?WFFlYjhLQVdLUUFXSk8rQzVSdzc3Y1AxRlVISXU2TitCbFFUT00zTEQwaHVq?=
 =?utf-8?B?eXlXNGEvWTh3UUJzcHNlV3VpcWovOGEvUVdQMFlIR0dKL1k3d2pPTG1ZcVJi?=
 =?utf-8?B?bTBCWTdTSURBc0pLdmIzdThzaVkrOGtnOGk0Y251R1BycXR6ZGRYa2M2TmdZ?=
 =?utf-8?B?OXNZTjFZd085TGVTbVRIZ1VEdjdNZjFOU1huOVZTZ1d0TmU4eWhEbEVyNkZI?=
 =?utf-8?B?M2JrNVVodUNHMG16cjFMNFZtdllWRGxRckU0bTBEUEIzSEk3VW42UGVDSER2?=
 =?utf-8?Q?toQ3rI4yhllBw6lirDSoyne9rX7ZwYG4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2292d59-efb1-4aa1-d0c9-08da0fe077bb
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB3929.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 10:56:38.3484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4438
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two kerneldoc comments in gadget.c have excess function parameter description or wrong
prototype name and one kerneldoc comment in core.c has an excess function parameter
description, resulting in these three doc-build warnings:

   1. ./drivers/usb/dwc3/gadget.c:675: warning: Excess function parameter
        'nfifos' description in 'dwc3_gadget_calc_tx_fifo_size'
   2. ./drivers/usb/dwc3/gadget.c:700: warning: expecting prototype for
        dwc3_gadget_clear_tx_fifo_size(). Prototype was for dwc3_gadget_clear_tx_fifos()
        instead
   3. ./drivers/usb/dwc3/core.c:347: warning: Excess function parameter 'ref_clk_per'
        description in 'dwc3_ref_clk_period'

Fix the warnings by correcting the prototype name and removing excess parameter descriptions.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/core.c   | 1 -
 drivers/usb/dwc3/gadget.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1170b800acdc..87a6cb37dfd0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -341,7 +341,6 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
  *		from the default, this will set clock period in DWC3_GUCTL
  *		register.
  * @dwc: Pointer to our controller context structure
- * @ref_clk_per: reference clock period in ns
  */
 static void dwc3_ref_clk_period(struct dwc3 *dwc)
 {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ab725d2262d6..66a256c47514 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -657,7 +657,6 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 /**
  * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
  * @dwc: pointer to the DWC3 context
- * @nfifos: number of fifos to calculate for
  *
  * Calculates the size value based on the equation below:
  *
@@ -690,7 +689,7 @@ static int dwc3_gadget_calc_tx_fifo_size(struct dwc3 *dwc, int mult)
 }
 
 /**
- * dwc3_gadget_clear_tx_fifo_size - Clears txfifo allocation
+ * dwc3_gadget_clear_tx_fifos - Clears txfifo allocation
  * @dwc: pointer to the DWC3 context
  *
  * Iterates through all the endpoint registers and clears the previous txfifo
-- 
2.25.1


