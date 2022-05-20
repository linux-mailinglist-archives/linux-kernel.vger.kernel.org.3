Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1152E70E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346886AbiETIOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346833AbiETIOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:14:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2106.outbound.protection.outlook.com [40.92.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA0F11E4A4;
        Fri, 20 May 2022 01:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyYnWqgRYl6SksZT5GTGvmcC87lx19VFHipt3ea+b9eAWF8LxNAHekm28KgZjaIWx6UVa79qgwJS5Yx3FsxTN/phTYAff6OAwfg0bV5cpHc65p3Sm3lYK5CFzCGaL6emeEvms4SEkTR6yjrUvjrjJXmpWkGR5PP7pKU/cGPuaT1uRRskfPCDiO8Lr+pCx4Wuq//B5cbhAI/6iGu60uI3ZqPu/2A0YaqaMreipAZ17WcmDGugZzro0AXt1blbO0kKtlB9Zit1vmeTsnn8mkGy1/VK0pdPGx/zL0IjdLgnSD9OtqrWjXsaf7TFcn9xOT8trM9mhd+G3dmS1uLyNz/Y3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN9QdxiUtB9A3U61kYVT8XrrmhHpTh0o2HDMn0oAOOM=;
 b=EH4dSBuwLbH+H5sTfnK1hY7S1slCC0GsPlhEJet4Ik2O9zw3azQTVa0JZ/X/3yGv4PcY82ui2H42u5JLdRgITUAWu9fxvaZi4vI4utc3iH7GzRYm0v+2iiTw8UXTf1mIQBifo+v44CT3MPwrv4eeHam/H3t0xPD2ulRmiyVD1RJleqypJTeiHfJSxI4Ci6yG/OjcvS6g8V7WS7VsIqWukuf/dcmaP5fLMmKcQMssnKO8mFdVRjAuMAPBcLSUFvgsJaqNGqBSkag+0pB9CYBzuQujhgS8Yl2Wafe/o4vcejyzKfViBDLGClVPA/Nx/2MnT7MtANgzvNI1kbVDNmIkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN9QdxiUtB9A3U61kYVT8XrrmhHpTh0o2HDMn0oAOOM=;
 b=q2sTQOf+Ad1cjoI6v6hGdEEpHGs4/1gHyro+Pf82sddpqIySE7NLoQ0n4UVn+u1/EqnMnH5hZ/C0E5dp7RwrJen/RyZ9tNw7GQIC5UadhpP18vZ9L+sNAXPInFNr1yUzldaBRCyLmqEYBflGGSpvS0qZZAziBWKdMr4Y4XTshP8/JRwy3FdvVU9MSvyKSLWOA0bM/6O2uthJFIJwvEDe4rRieU/L0hwBMKbb3owtnPil0brXs+H2Aut3l6nprYcdwWyLlq1gnQG9JU95OWHUteIZR08We7kZegcIQqqHVhKqo/9qpDrco272hvtolRkqtBnrKW5KlnMqSFKRYeRkyA==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by HK0PR01MB2962.apcprd01.prod.exchangelabs.com
 (2603:1096:203:8e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 08:14:28 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:14:28 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usb: dwc3: Fix a repeated word checkpatch warning
Date:   Fri, 20 May 2022 13:43:40 +0530
Message-ID: <HK0PR01MB2801ED85410F9CCE4ED32880F8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520081341.16768-1-kushagra765@outlook.com>
References: <20220520081341.16768-1-kushagra765@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [lCJXP15wobY/x/Bw28khRrnMvmgU2fNgqNoVIgGG19kGevlyKqyfvG+3tPc2r/HA]
X-ClientProxiedBy: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20220520081341.16768-3-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f340cb79-5ba5-466b-7f0b-08da3a38c254
X-MS-TrafficTypeDiagnostic: HK0PR01MB2962:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dK9Mg2B6Mdidm3aj9MtllOQKV0U/0dwBzIR3okq3o/SXKEpudgucdLBwWicusuQ/rqYgPvx8marojVQ3O61c7IrGwjdnwOyXSc8Tc17aVV/qndSFCfv3POe53Zkf6GQa6qwoMLyvl6l99k0DpamcIFdKhMBmKe1Yjx795kJKVNExeZD6HwIsdSjbRbkiS1U914pdM/e1xrkDYs8FkEqRC8WkhCyehhTQH/JV8AlYoMXy5RcRdYVqZtz7DGirlgMTnfGFRtQNcdXVcDS6l6DQ2xAU4N+Kktr3dNs9vb1u7C5SDjUQfLjfDwT+tU7Lsid/u+5kAzH2YtReb/G55MChH7Rc6SkT2kREgvz4Uut4dtkfYRqFbDCwhSMbliHXfE56l/n8QNYIVZS3joyQ+lBbwAPVAH1lyO3/HCCZTWx67Y5hYWD1jgb12T4xGhkYepZnHGTn7Dc0umpN2i+NlXRYlyWkdYWM+Gw1tyc4/fxtTs/SS7SX/yG491I+9djFBPCrNbjQKunv5Y9sI4pWWeAyOoAWM5V9s+xN51QKpydp7jDGNQUt1LKFIOOXiRaIhRkS1abXE8r701HyVmBlX+VO1Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+tfCDXSQcMTjovwH20lCzcTFm86OW1yrAZDrdb8FQeBCKGaLXsYBopWvF7Qg?=
 =?us-ascii?Q?TsrQNgSyHGDnhmOVKYHxd/JMiZCc3WHLrt7YZtHpAmPRWy75wV6BhBwtk1+l?=
 =?us-ascii?Q?KM7hOGxEbke8mvK0DUn1gVg5WOnshOYBPq5xfFbqhFwVwpbhTt5VnSvO3eOL?=
 =?us-ascii?Q?rxoqDKZncty7+21gUpstBGelFasIkmvlks/Smi3pHGAIZC0NzPxyE2ir44y9?=
 =?us-ascii?Q?c5RX1+Yu6EXqENP2ozzj3RvNEJJL6r1JrUBRvLhvIjyGdSueMCiMIEnoQSU4?=
 =?us-ascii?Q?XkAHNxqknMNdo7hanfeSremc00X1rYhhdZulYz8Z4zXqrL61gd3OkPjAj378?=
 =?us-ascii?Q?dX5yHyzZbZClh61htPPuDi7sPypMfa5WLGak7FptkC+2R6fZ5P4mHpRlC82F?=
 =?us-ascii?Q?i1/WL6FQzY4hD5F1PQuJKEbdfaNwJQLFPAEKihyxY2+Y1yQSllznX2mTOBAQ?=
 =?us-ascii?Q?tEKbcvz0nzOkzIRCNkK/nuh4C0uS/MoHDrRYb0OLeblZLPE6hX8LZ/57d4ug?=
 =?us-ascii?Q?KjkpUY1fp723S3uBSDIFEwrUH+azTg6OP9RWq7RM8Hu5BhxQWxyrO76oD4Qk?=
 =?us-ascii?Q?HTGLBcsv0FToNxi1bVlmWMxBxl3sGuUYBdJsDyMmA3o41XYJPe5QP81sFi8q?=
 =?us-ascii?Q?8K83zI5uFBN3QVvHKpYcIA/LMejruhg1cUEIdkWSUf753HVGZQHCEw/Hhc9s?=
 =?us-ascii?Q?JttUhqwqjYLWRzlnQCXBJ5Dbcb6Uw3MLoPJrfHunEEGrPvg9hcmLciGs3IrE?=
 =?us-ascii?Q?9NkdEFAIJkCDU9Z9DBZ8KdEP6RAI20a8/V79Q9h7SxSc7QqQh0gjGkLI7Wgl?=
 =?us-ascii?Q?L8c0VyZDYkq9blJrirXhztCX+J4dQ3zg02fXxGjc6n6/+VPOLCH/A1iDoBko?=
 =?us-ascii?Q?0KkgMjDpg+yiN/n79l+w429/khTv1C4Vsz5HxdXx9qTmth5IBZgVWUcMMbjt?=
 =?us-ascii?Q?Oo+bOytLCssdZ8Lvol7icFiajT3Rh+1fR7rwjPdtJ63Hv3LoWj2krfCMQA7L?=
 =?us-ascii?Q?C2I0Qnec/pnAIfEKGnXSnOU/VXE4IwhCcAwWz7q5CExS+869QTkV92C22b0j?=
 =?us-ascii?Q?IJ2eZTIZzGkqoexfjyIMaCKMdPzhsJlPjEki9S7oAlUk8B9l2fY6Nr06F2Dc?=
 =?us-ascii?Q?JGy3ezGI7mg80egEjJGe3P7B8OlSoJxxGoVYsHim7ZlEdFEzGdKd0F2LOEBk?=
 =?us-ascii?Q?5fkym8J9sutfye7ypMMChaNVHMr8143YwVN8e8Nxs2oQWrOyo/3Vi/vIe/F/?=
 =?us-ascii?Q?Aa7zZ8UDci5a7BMnCv5kWg/196jkCLwcAD9YGrO4Mj0MT1kPiRXsp/vWaZlm?=
 =?us-ascii?Q?mhieQfuPbeieHXTkgqhOfVbvnddEz9Uhlw3Fi/2XS/eBbge9eSG7BA57LZJS?=
 =?us-ascii?Q?yfwUwiCq+/IijOcVmtGSn0NilzKKWcXhHMQY7O4F+ra6zgdf702uM6fpDhWl?=
 =?us-ascii?Q?mNscxTymIXBPzn71tjwz5t11RwPD3LJOUpzLPpR0+G/D1Nbpg93yG6DGsJmy?=
 =?us-ascii?Q?S6H9Mnsja8HBRg0sThLQ0NHyIHbaLff7/E6x?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f340cb79-5ba5-466b-7f0b-08da3a38c254
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:14:28.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2962
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a repeated word checkpatch warning in ep0.c by removing the repeated
'only' word.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 5d642660fd15..2a510e84eef4 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -473,7 +473,7 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 	case USB_DEVICE_REMOTE_WAKEUP:
 		break;
 	/*
-	 * 9.4.1 says only only for SS, in AddressState only for
+	 * 9.4.1 says only for SS, in AddressState only for
 	 * default control pipe
 	 */
 	case USB_DEVICE_U1_ENABLE:
-- 
2.36.1

