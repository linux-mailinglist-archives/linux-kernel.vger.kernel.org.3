Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1364E871D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 11:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiC0Jgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 05:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiC0Jgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 05:36:53 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2065.outbound.protection.outlook.com [40.92.53.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824751928C;
        Sun, 27 Mar 2022 02:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM66hdMMtc24L/iatG1/uNzIXSfN1mGb3FKrKZf3BbtSCYIiF95KwIr+7PYI5pSINXRpz2MLXghvFAXMpJAQJOwNM+ZHPD8lqYofMUrLFbItEVYVOWSeI5JEfGiBxjG+c0wa4sk/9I5+uE3rIdmGRRITYthCAJP2HvznYbuIuUnRCFN+yLSTm3nuZ/OnB5FirPMUMns350mBatLtWZb14XOe4OrHAIFfGskxPvrPQgTHx/m7tw+U2+LF1KBUCc6Wy7CxlsvmxYLKXwlhgIvzXGKBS59/1tz+/Sm5Zo3hXjjBIa6O8d3IstBGFS/FKbBu93iqbHzPdrIelG/EUxveOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20UwJ1BsSDEs1xu1wDJin+xdew3NNwhE+RPxa1kTqQo=;
 b=Hqrs7rRCOveml/kcT2me5F7XUB3gV66SHVQAiX5TeXYxAruVVUv4Bzhf1ZJKnHYEafeFW670Lx0HCkzE2fAqkGQWEXqOL+McQYpQUvU5b3qLD6jzuXV2FcV0LL+q9CRf0OufiWdnTtwyjDF3rs+1BKrVC7yhXEehmSLwre4tU9Hox4eaZLT5ywdDF+wd6Sy/aZnFQ6KQkdL7ocfK5efToniedpJRRHH+KeKNgCNYcnfBifTSh43lkb/EwL1x0wviOAWpx8KnliofibH606fkh0YJrdmk9n7UZatzGYY+NWdjlAysaQTsQc2ikSxnNsiTK+mrBw38G0+3lCC8awyngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20UwJ1BsSDEs1xu1wDJin+xdew3NNwhE+RPxa1kTqQo=;
 b=Yw7p6uNuwdoT7yQngsbUibR4C4xKd01fOB9zknr7t5gwaAn0P3AbZdBX6leef8eEmxsueMMjS703TVhi5AhyAjXTeZeEQh7qfemAKvKtKks+ccqIMQUjRGfNOvCC697WNS2VrK8BO7cIy29EflKfJso2w5iAV7cyH1FPBQ0jFOSzDdGHnlaoGTJYZVTo21wRJsXiK4dS8HxBdxJF6RrN9JtJlqNpC0yVdarI//0nN1EuaLBpfWscZCK6tLpptFp1r5SGkDpXqR3nzx8I0sik2iM7RhoMQW9ryY95wYlUhDAa+o5ihy6gOb/sclWWFARL+EDTDAti9nQVRTYZ+IDrYg==
Received: from SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 (2603:1096:4:106::5) by HK2PR01MB3234.apcprd01.prod.exchangelabs.com
 (2603:1096:202:1b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.20; Sun, 27 Mar
 2022 09:35:10 +0000
Received: from SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 ([fe80::d179:ecb6:188c:f9a]) by SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 ([fe80::d179:ecb6:188c:f9a%4]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 09:35:10 +0000
Message-ID: <SI2PR01MB3929034AEEE996FA164D94E9F81C9@SI2PR01MB3929.apcprd01.prod.exchangelabs.com>
Subject: [PATCH] USB / dwc3: Fix three doc-build warnings
From:   kushagra765@outlook.com
To:     linux-doc@vger.kernel.org, corbet@lwn.net
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 27 Mar 2022 15:05:05 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-TMN:  [bSYm4ah4DTNjIf0ltBEoB90m2j/5lKG8DReph9paRGU=]
X-ClientProxiedBy: BM1PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::23) To SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 (2603:1096:4:106::5)
X-Microsoft-Original-Message-ID: <a680d9454a7c40e61f26ca3030d4569fe188be29.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d6747b4-e5d0-4dae-792a-08da0fd51668
X-MS-TrafficTypeDiagnostic: HK2PR01MB3234:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDMhUzaQj6j2enJlRirlIvZLZF9QHUHSNLoyQhi9OhYX34YHR42Cv2UhTkfyUTQgNebLWaPNJNk85dczlVEzikp3eQFydi40p1Wih07BWrTqC+RxWUnJFBYw5Rdj7E0q3rCioDRuPJhDXWHuzYkYF77Lbirt9LC5LNFB5ko19adtsw8XXTI633/Vzn58/bu6JsgSuDZEAa+QWVjK8F5JGuiTwi1BEo550hJWuPBWfKJam5a1xlMT+R+JmmM4ZOj9AncYsF9A7hbfO2XedrDqsCidw8i9E+wyROGtfgakNpj6L1rzLx7IxdNvzdO/kcIKFxkbBSMB8itVpHRNpQmzn2Qo6GqnPk4C6fKEiujjw/EDoWIPWKj2OM9BI0kKLKHpa5VAG9LHw24gR/PIl9KPMxEhruw+MNSNV9h24gsO5ZHzTwXGz4MbnePSpzUsfG7oYuKmbWVVLGjtFzNUF/j+I3x+oktQ7RATjBaKMXfOlGGIkfGkkm9BlL8KvNIdFJ2AyBQ/cn7welBH6hhbk3qLysxwilvdK2r24mQ0zB5O/Vur1pi9FDNOylqRmVkQu3Eh8SqlFH4/eVU58XvmyS/vjA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRoQ0lNU1hkUWhVUzlGcGtaY0loSFF5UGkvQXUwMWI5LzZlM0JyenhYdlhn?=
 =?utf-8?B?a2hVcytQVzN4bm50Z1BvaFRCUW1rVHQ4aVE1ZnowTG9oSGZ0RjhkMWFQZTln?=
 =?utf-8?B?SEhSdjI5RitlbXdnMGdCY2IzQ25YVGtCb3A1Q3RiTW1vQmtkaEMwS3ZOVzdu?=
 =?utf-8?B?d04vem9BVXc4T1JOcmo3SWJta0tYUTdqMGVXWGdRZVdPUVIzZGZzMUJZcnpU?=
 =?utf-8?B?TEtpUnh1Q0JaL1NMTDVnSWtLNVBhQ2o3SjNrVEExS3dvWW9Mb3FzUXVHbFY5?=
 =?utf-8?B?NHk1RFBrZmF2UXgzVktTOW8rWlZZbTIzdmxRRGNFN1RmdEx0Y3JUUGJlbHg3?=
 =?utf-8?B?VzhCZ2xBOFh2OG5ONzdrZjNBRE9TZVRoUTJMZ0tRaExnc3JWMmxlWkFQVDBX?=
 =?utf-8?B?NDJ5UG5udElIemtBa1FBSG13VDRUSHFRRFl2UU91ZFU1eWV5K3h6UkxhZkZO?=
 =?utf-8?B?bXRDMGpubG51N3lzZExlaHRxQ1NKUEpwTVAySUUxSFRWbjVGbzVYTTE4UWlN?=
 =?utf-8?B?U3QwOVBiTXlqMDZvZUZ3eGxITWRSaDhmTGVEbzducityRFZEdGpWMVRGQWFh?=
 =?utf-8?B?VjVzdmFkQ3NucDdmSlB3b2dtMWIvTkd3OFhWcEdjM25Mc0Z2aDZxcmluTCtP?=
 =?utf-8?B?NHZMeU52bVZpd20yMVNkbVc4bHArY1F2cEFaamlqYUFTbXFSZGtBc0w3Tjky?=
 =?utf-8?B?cXU1UWZuMHhveElTN2IrYkx0QWNDcTF3N05rczRMNWEvUUtjZzN0UC8rQ0F1?=
 =?utf-8?B?QVpxSHZmTzE0NlBYMWJsTWNrZGJieHZUTEJib3dTbGsxREgwY3RsaFk5S0xX?=
 =?utf-8?B?bEorR3NGQm4yMkpGS0ozZkFoOXZNQVNzcGtxSmlmOVdSMFdNYUJnYU1WcURP?=
 =?utf-8?B?VFVSL01yTTVxditkQlRCZnVRYmhoelN6dmwvRWhHU29HWmgxVVBrNzhER0Q4?=
 =?utf-8?B?SEJ4MEFmaFQyZi9nUTZHemZWbFd5UCt0R0NFMSszQStKWEFVTVhWaEtuaVhK?=
 =?utf-8?B?WHBiWlVSZzVuWVRadGpxV0g5S0ZWUWNOd01CTzVOZ3ZmMEhjTjE3N0x3VDV0?=
 =?utf-8?B?MndHVytuYVpKL3AraktwYUt0RlNDVDkzNWxoQnRlakt5RXRYd28zVk5oUDhx?=
 =?utf-8?B?SVFYdDBDL0JxbVFFWmFicHdTaTY5dzROdXlyekNtVFlaWUdxNjBDbmZ1VWdF?=
 =?utf-8?B?WERMbUlBMmt4K2RySlFBUHVQWFVvMkhyZ2FPNlZ0d2hyengxNVg1SXJwMmZz?=
 =?utf-8?B?NEkvRmVDYkJjWlNWRGIrQ2RWK1JTVmsxT01GeVdYZDlyRXlJd2hLZnpLRTU3?=
 =?utf-8?B?YVV2UGQ1ZzdVY2hTV0IwRTh1L212QlJIUUlzaHkyOFRtREw1V3JnYVF3NzFB?=
 =?utf-8?B?VjlXUXBFeXo1RGE4cVVsKzhZWVVRWUs4UEZsRTZJb2hMWEFSNlg2SkpoZkF2?=
 =?utf-8?B?dmh6YnN0V2hTNWRsbzNSWWhoQ2lGQkdrbGMzNXV4WVgxZDVheG5ZaVJTNEFW?=
 =?utf-8?B?aVRjNXJFdDRpQXE2MWIyQzdlUW41ZGlkcFR3QmFRUlYrQ0p1bGNHbjFRcGEz?=
 =?utf-8?B?ZUtCdGxxc2pQdzBtUVBVOTNzOGZrUGt1TVdMZURlb3pXR09LQkxmRDhMOVpk?=
 =?utf-8?B?b25kdytLR1krTlZnSGc0RkpzZ3NYSE9qQjBLdkUwVlkzdkpoUmx6Tjl0dFNU?=
 =?utf-8?B?Z09Lb3V6RDF2N2YwaWpNVUpWVmtyZ2NmYzRKZ0VFTUFwd3ZqamdCKzlYOEVC?=
 =?utf-8?B?b0czOGN6VXhzYm9SdkJXVmZ1N3hkTmZNRDVVTkNEMHV0MUo4RnZ4TzR0WCtn?=
 =?utf-8?B?bzBqV01icDlSNFh3bkxMSnNrNUdONTdTK0VTZHVtUmJpcExjRm5PRmdjNjJ1?=
 =?utf-8?B?QWE5cFRzTEpRbW5iYWRNK051RmNwZk9xZkFhUkVjbEFqbWdoS3NtN20yd2Zo?=
 =?utf-8?Q?90rohTBVEh+n71voKAK+waaIinCgG3fz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6747b4-e5d0-4dae-792a-08da0fd51668
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB3929.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 09:35:10.7866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR01MB3234
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two kerneldoc comments in gadget.c have excess function parameter description or wrong
prototype name and one kerneldoc comment in core.c has a excess function parameter
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


