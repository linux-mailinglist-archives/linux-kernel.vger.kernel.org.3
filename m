Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD1851648C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 15:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347548AbiEANU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 09:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347482AbiEANUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 09:20:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2030.outbound.protection.outlook.com [40.92.107.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22131EC57;
        Sun,  1 May 2022 06:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kR9TgrAB44jvFdsmrZWCornU0XRd3BIMWu4biPhGccplDoWIsqef3iNZCWMcJxRyeUyaoadd8UZ7vAkTCrNygDAnBXR5MSyViYt4oGBgy3Ejkh98vkicLwZ0e7OPYPM1iwcLVyjGRoRKqmSOrhJBPxVdFSRaszrOfV+rfIVdEXgAGlZXhEsSRqmAgYcWhYtr+QvTKHNYx2jWPjwBiL2KBYqW/X1dHAf012GFv12XqcYJ47Q1OPx7jjsKKucMwiq45oglAu7wnMGvIKeduJy2mm+/tSwKVegH8fXFN8+bCS+q4cLc9CQv/6W0H52mNAJYxkPuo2Fizpm6Q192HgrbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4YWOz/BRsQwwXwf8lBdhRTdz1ybnN4OcrF7q/hMw7E=;
 b=BnZPkkTih+EDBIGLNVjtoQX1BNjfNNTK2R58c4z2cLsJkA67mAquv8FVmsvdykJ3S/0HtYYRHFAr3IOvrEUaozjMj0wUir5BjjaWxJ1b09GNQSQdkYtviN6WjQubY27jFUFyaSNTFaUlofAYpjXsZN+3aKl72w39Q3Q/Gwsj/uP6oqmL0I6dPLYQrKfO3+Q+Qp6E2Ow5Ip5dWsx5XiLUA5S0RvDjIz0rEe/ubhTIBNUel4bIztK5GDzuZke6zefDYRg1EklmstfmKh23lZMtaKSwLW77eN6szTPBUK6XrhmkzptYxwXwwNqD5EX4qaFft09wBlBTjRnzdrjWVxXTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4YWOz/BRsQwwXwf8lBdhRTdz1ybnN4OcrF7q/hMw7E=;
 b=tI/680ebP1SZLmB8xM5w3lS0cQjJIzuUfMNaVRxGHF1UnMeIqIbdoSdOmkQhRLvrhXSDet2bJ+uTKCsB41NAQZSvYXPArxVqjFky60FT5AXVfTbTpcYA3CzoZpWmchaQnTq7KTeaNdqpapAN4oxeo+1QIIsDUEY5SMCUJR3754VBPpxyzsGywi2xsCaC81czYDp1fGmgrHnjAeUKVSM0Pv8fk/eczFFrd+AizMW7FCKPAy1HuH8wMcjkzUpmXQBs+GOFotkUvYhOWhrw8NWYLBNHdqkwy0nUlVMKxUf2ENaPxicCKacq30C31bggZU/1F4k9hsVOex5GqQ/PnBltXw==
Received: from SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 (2603:1096:4:106::5) by SI2PR01MB4225.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1a9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Sun, 1 May
 2022 13:16:52 +0000
Received: from SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 ([fe80::441b:82dd:2ef1:8c3a]) by SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 ([fe80::441b:82dd:2ef1:8c3a%5]) with mapi id 15.20.5206.013; Sun, 1 May 2022
 13:16:52 +0000
Message-ID: <SI2PR01MB3929C96E8C81D71250BA618BF8FE9@SI2PR01MB3929.apcprd01.prod.exchangelabs.com>
Subject: [PATCH] USB / dwc3: fix checkpatch warnings
From:   Kushagra Verma <kushagra765@outlook.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 01 May 2022 18:46:46 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
Content-Transfer-Encoding: 7bit
X-TMN:  [WEx/JIguvOV3JgjNKV9cjHA8UWxeAowMPNcH/VdHjLYzh4DRgboemobKUoGLoLlf]
X-ClientProxiedBy: BM1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::15) To SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 (2603:1096:4:106::5)
X-Microsoft-Original-Message-ID: <84cc1f7861a527992596245a65f68ae2544ee735.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48ac42f4-71f6-4d11-1515-08da2b74db28
X-MS-TrafficTypeDiagnostic: SI2PR01MB4225:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9LPZ/mD0hVksC8kXJelGCKmZPLMIzHQbqo67yVEfQ1cJaiwg7jSmZZvXEBxv5uw1nHnZhAPl0adGczVnCON4sXUj1U4cojkfKcUTOfVoNMuUiZ1nEc9PzQRLf3t3ifhcQK6Ojgt0UGXZlcUzOY1C7O9aZA8gwKAYAShvdiZydCmAb5VuknACjOKko9ppdhQWwOOXJbRERHNalXJWXq3QTbuK3Q6zh/IVWBhiJps6LEE1/ZIYVREyq7xOmAcUFsKd0xNGxedKpCYQSBa+yO4nx1gSdPg14lQGUlFCip4xnaseKefDPVtzs/7UC4WUpR0lxR/Fi5KFGHeZlcVeTHYKqZk3YQoTgtbII9Iw/VAfv1u0IUKRVg6syPy/qnPjpkGfhHt4egDylAPVvR/mdAuRO6m/biR47PxcjmXBTGsJklt/+oeydumVgMJ9LnqeUEgwZ3T2GhkTbjvci9A1POxNLVxpQr4CdzhPh/oTG61I9oKP7ZSFLtLQL8ulhxqDw8tJ8dfTqzZA/l7ClOMx74SYB6nLsYOdQaYROBYh1xp9WZmP3fq933DwjylIhdkHQYP+wQ8K758LRkTFXo0m+tUEw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0NBRVlkN2pZR1l6WFNqY05vTGUyQWJ5YVRNVjdrZVdFRUFaU29PZ2hGcnpt?=
 =?utf-8?B?ejFWV05NK1ZNUkRWZGV3alR5QndPbnRJMVVYK2ExbGFVRk5VamJjQlptSWVo?=
 =?utf-8?B?VWxmMTV6aStPZ3VpOHMxeXgvd2ZnYUVRdGJSWEFGWUR2SzBoTVFGbXdUSllQ?=
 =?utf-8?B?VVpPTXRXdmw4YkVOMEZKZmQxL2U1WGRCVmtIQUFmKzhqbGRqOTZUaEkrME5u?=
 =?utf-8?B?K09GK0pMMk1IZjlpSzgzcCtaMjIwVHlJc2RxdmZFYnNuWUJOa0gwZVFMWlFW?=
 =?utf-8?B?a1RTRFg5d21xOGlCOHNBOFdoVU1nVSs2OWkzUU0venJBMWNsUnZLcXB6TitS?=
 =?utf-8?B?amFxTWxXTnM0UzQrYjlIR0RMV3lsZVJVVWJDeTJYMFg0RVRjQWRlazk3dTBp?=
 =?utf-8?B?R0pHTDlSb0oxZmZyNXV3aHYzWHBvcFYvWUN5dWpzN1hmNWp2aTJMQnphS2Ra?=
 =?utf-8?B?MzA2cGQrSVJhMkxsenJTeXIyZjlucjkrNWVtejhQSWhZMDA0TEZuRWd0clA0?=
 =?utf-8?B?Wml2WnhMbXVhMDlUZXpmOUpCQytSZlZhbXFqd0ZPTUhoMU9FWGJtaUhJZUlq?=
 =?utf-8?B?L2MrZUdhTU9GNCtVb3g2c3J5R0pDYUEzMGo3UVlrRTQyNXpJMGJKenVmZC9y?=
 =?utf-8?B?TGhoVjE2MEkvWnBwMWwrYUphZEFKMWZycmVZQzBhSWNiUEtLZUJXeFlZYUVU?=
 =?utf-8?B?Qy9TSk9oWGd4OFF1M29CL016SVlPelpaY3BEOHhuUjd2TkthaG01ZENOMnRL?=
 =?utf-8?B?N3BqNmMwWENNdFVkQzNYZlRsQnNLb0wwcXNsaGlKMit1a2tWYXdna3NsaFVp?=
 =?utf-8?B?MmFLZGh5MDR3a3RGcDl3ZThCcmpNcElqY3NxdU1DcjRmbXR2YVhDTFNQRm1R?=
 =?utf-8?B?NjEyUUFlUEQ4ZWR6WDJhdXJqNzRKamhmcHF1TTcwdTQrSmdIL1RxT2NCU1h5?=
 =?utf-8?B?Qmk0dFBXNmt2VzBTZGg5OE5ZY1pLeUtuYTBmcVJSeGdJRXRjWGczOFdtUmpw?=
 =?utf-8?B?WGdmNXE4T2NBaDFRSER6b2NFOFNLNm54elQ4cG1sMmVGVzVJZ0NQNEpCZDlB?=
 =?utf-8?B?am4zYm42bXJKbUVKTjQwUFI4cmVBWWR1NE1ZZ1BYUGhrUUZ4Q1lKRXJSMHhp?=
 =?utf-8?B?QUg1RVNqNVdCSk9RUmh5TnZmaVZhWVpENGgrak9CbEJvY0h1N3lFQXBpSDN3?=
 =?utf-8?B?bzFYbndweHVoa2U4dlVGRTVpT1gzR3NOdU9TUWtqeXpGUmU2cGFmNENUckhn?=
 =?utf-8?B?dS9kd0pxWXpYcU0weFN6NkxsMVVJYUtMMEdnOVp2bkhPbmpjMlp5RGsyK0NC?=
 =?utf-8?B?a05URkY5eGJIQ3pyWkx4UkphMHhMRXVrSlJMRDBjOU8yT3c3M05OSCsrZWlZ?=
 =?utf-8?B?dkZVaHZiaUY3aDZQbktpbXNCU0NEY1pFd2ZCSFZ6K1VzYUsrdEpTUDhoY3Bo?=
 =?utf-8?B?ckFmcGw4RzhiQzRzeW1xSE5HOXhyK2RTREQzbjdmMytkZnNvZTRjNVZseW9P?=
 =?utf-8?B?dHJNMjZLcEY5WE50ODlndFBPak8zVWhwaFhIMUhxWjdhNUl1ZW9lN1NZSTdH?=
 =?utf-8?B?aW9QdmVzZ2ZXQ3FDWmRVYlhCZFhqNDhiOGgvYnJHbWhGYjlaYUNqcEh6MjRV?=
 =?utf-8?B?RU5XNFcvWnNxMGlKK0NiclJNOXVwZjhZTVVsZTlqNkxHK3E1ZXhScllCV2s2?=
 =?utf-8?B?U1R1enhmbSt5d2tCU1c2eHVpWUgwL1lwQlc1anRrMGpnaWZUZDdZSmhkeGhC?=
 =?utf-8?B?aHh4bzBEejUwS0p6MVZrV3kxdjNVR0c4bGxaR1htMlVXcUl3aTl6QXEyWnRZ?=
 =?utf-8?B?VVhMZVRWWDR0Z3Jka2lhdXRRUVJDN0ZNby8xenU1WUZNcE9CUFRoR0xtL0tH?=
 =?utf-8?B?eCtsbU56cURDUmplaC9DWGZVYjNMWWJFRjZOVWVaZGFOQm5ORUgvdGIwdkNH?=
 =?utf-8?B?WWVPLzhTalNYN3RRZjMxTUdEb3lTRHFIaVhKdnVkaXNJREMxbmUzbElFWUYx?=
 =?utf-8?B?RjZnOTY0bGFqWWsyeXFmWURzR0VjaHdXdUNnamg0MlEwamJXNWhDZEx6ZTVF?=
 =?utf-8?Q?H/eue8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ac42f4-71f6-4d11-1515-08da2b74db28
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB3929.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 13:16:52.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4225
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch warnings in core.c and
core.h:
   1. WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
   2. WARNING: Possible unnecessary 'out of memory' message
   3. WARNING: No space before tabs

It also changes 'Error to get property' to 'Couldn't get property' in
dev_err() as the latter one is more meaningful.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/core.c | 10 ++++------
 drivers/usb/dwc3/core.h | 28 ++++++++++++++--------------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 25c686a752b0..615215869fe5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -339,7 +339,7 @@ static void dwc3_free_one_event_buffer(struct dwc3
*dwc,
  * otherwise ERR_PTR(errno).
  */
 static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct
dwc3 *dwc,
-		unsigned length)
+		unsigned int length)
 {
 	struct dwc3_event_buffer	*evt;
 
@@ -382,7 +382,7 @@ static void dwc3_free_event_buffers(struct dwc3
*dwc)
  * Returns 0 on success otherwise negative errno. In the error case,
dwc
  * may contain some buffers allocated but not all which were
requested.
  */
-static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
+static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int
length)
 {
 	struct dwc3_event_buffer *evt;
 
@@ -844,17 +844,15 @@ static void dwc3_set_incr_burst_type(struct dwc3
*dwc)
 		return;
 
 	vals = kcalloc(ntype, sizeof(u32), GFP_KERNEL);
-	if (!vals) {
-		dev_err(dev, "Error to get memory\n");
+	if (!vals)
 		return;
-	}
 
 	/* Get INCR burst type, and parse it */
 	ret = device_property_read_u32_array(dev,
 			"snps,incr-burst-type-adjustment", vals,
ntype);
 	if (ret) {
 		kfree(vals);
-		dev_err(dev, "Error to get property\n");
+		dev_err(dev, "Couldn't get property\n");
 		return;
 	}
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 013f42a2b5dc..033c58f489b1 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -634,7 +634,7 @@ struct dwc3_trb;
 struct dwc3_event_buffer {
 	void			*buf;
 	void			*cache;
-	unsigned		length;
+	unsigned int		length;
 	unsigned int		lpos;
 	unsigned int		count;
 	unsigned int		flags;
@@ -694,7 +694,7 @@ struct dwc3_ep {
 	struct dwc3		*dwc;
 
 	u32			saved_state;
-	unsigned		flags;
+	unsigned int		flags;
 #define DWC3_EP_ENABLED		BIT(0)
 #define DWC3_EP_STALL		BIT(1)
 #define DWC3_EP_WEDGE		BIT(2)
@@ -893,9 +893,9 @@ struct dwc3_request {
 	struct scatterlist	*sg;
 	struct scatterlist	*start_sg;
 
-	unsigned		num_pending_sgs;
+	unsigned int		num_pending_sgs;
 	unsigned int		num_queued_sgs;
-	unsigned		remaining;
+	unsigned int		remaining;
 
 	unsigned int		status;
 #define DWC3_REQUEST_STATUS_QUEUED	0
@@ -908,7 +908,7 @@ struct dwc3_request {
 	struct dwc3_trb		*trb;
 	dma_addr_t		trb_dma;
 
-	unsigned		num_trbs;
+	unsigned int		num_trbs;
 
 	unsigned		needs_extra_trb:1;
 	unsigned		direction:1;
@@ -1010,8 +1010,8 @@ struct dwc3_scratchpad_array {
  * @has_lpm_erratum: true when core was configured with LPM Erratum.
Note that
  *			there's now way for software to detect this in
runtime.
  * @is_utmi_l1_suspend: the core asserts output signal
- * 	0	- utmi_sleep_n
- * 	1	- utmi_l1_suspend_n
+ *	0	- utmi_sleep_n
+ *	1	- utmi_l1_suspend_n
  * @is_fpga: true when we are using the FPGA board
  * @pending_events: true when we have pending IRQs to be handled
  * @pullups_connected: true when Run/Stop bit is set
@@ -1047,10 +1047,10 @@ struct dwc3_scratchpad_array {
  *			instances in park mode.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
- * 	0	- -6dB de-emphasis
- * 	1	- -3.5dB de-emphasis
- * 	2	- No de-emphasis
- * 	3	- Reserved
+ *	0	- -6dB de-emphasis
+ *	1	- -3.5dB de-emphasis
+ *	2	- No de-emphasis
+ *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *                 increments or 0 to disable.
@@ -1456,9 +1456,9 @@ void dwc3_gadget_exit(struct dwc3 *dwc);
 int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode);
 int dwc3_gadget_get_link_state(struct dwc3 *dwc);
 int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state
state);
-int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
+int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		struct dwc3_gadget_ep_cmd_params *params);
-int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd,
u32 param);
+int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int
cmd, u32 param);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
@@ -1472,7 +1472,7 @@ static inline int
dwc3_gadget_set_link_state(struct dwc3 *dwc,
 		enum dwc3_link_state state)
 { return 0; }
 
-static inline int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep,
unsigned cmd,
+static inline int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep,
unsigned int cmd,
 		struct dwc3_gadget_ep_cmd_params *params)
 { return 0; }
 static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
-- 
2.32.0



