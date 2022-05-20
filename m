Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D5252EBA6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349047AbiETMLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349022AbiETML1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:11:27 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2061.outbound.protection.outlook.com [40.92.53.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027D814640B;
        Fri, 20 May 2022 05:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmUeW1G+LdCYPNZSNoWudNEgJj3a9UL/ZCPMoP4QCRSOVaiKUzF0AcGNtpV60UxvP52bZKljJCZWl9S0WH5NzW2hrvFTnqQp2YmwUSE6Duznnvh87aSH2Cbv8YPp7tbDRXzlNffbw4D6K9FkgjPb2vZYBvl0Xi0tk8dQEXuV8WxIUPBWsuGGuU8/xUYu8KNLmnGS8p+CDdiggiF9LYg4zvbJreBSo1QEOOpPoxEth9T2bMecTNMmiYo9GnGmsShlqqn5Ov00y95v+thLO2zdRVhXW/+CqcU2adsDHcIJLvztup20R3se1PqOqAqLlpAJFk1U6+cK5lR+rrjy36GRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIxCPAE5rn693Sq8Bj2QBTDGxodIsTiNQApUBEkwi8w=;
 b=ja8SN33GcxHZ6vmzWK1MrVR1uHwhHT2LH5lii6YBnfL62bzF+BUG+QMjzkXPMaIa4MnP6ZKkwvaXsK6Gf3HpY7UCXVjymsTG7xD8xOTbAGY7oWGbaFT9OUX6jfebJ99zNx+MrJBPvwjcCqF7ya5l/4Ir8JLgs/YXLarM53AjrSXOJgBq/5ugds/SyekJgcdTHtHBlpItKkPr6cYoMbAFS5gsNgieAOkK1w9h9eOfxIFf72XCMZznLMubOQX0OprOoj1fIOnqCwqb6Hw79IpsvvE8I+CaJ1wMUKJMXZDDOY9pvIu3OLOloezeQxihc5S6dse2d2z5AmiQ4zTnLMVysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIxCPAE5rn693Sq8Bj2QBTDGxodIsTiNQApUBEkwi8w=;
 b=Xmp4KUU+LgN7QQiHFGiID7u+BEnd2i4U8Bg/1wKet6SNIMH1bJmA80wCGFZLvh0fd6MCUBUvSMBY0gumEx+xNaTC4lb2AOLopz29OPlkHvItpYDI81YJ+pj1iw95DvPcPfU+gwnGTc1gWtP8oF6T8jM2UpH27HHLqCvSNQmhZoGx5OPdV47n/SCdj7Sfd7QN55NwON83jBvX+mm5FmdytuKjDizkVMO83LkcxlvKz/Y5AVtCLTM57rIubS1BzANUeznYk4oKtp7liew6c/MopRDMHlqAd9Wn2Y4gBoW5gU9C+Rb9zAUoKJ1y8xNUF0gA20RbknpgandD+V8imx8CSg==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by PU1PR01MB2092.apcprd01.prod.exchangelabs.com
 (2603:1096:803:1a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 12:11:21 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 12:11:21 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] usb: dwc3: Fix bare use of unsigned checkpatch warning
Date:   Fri, 20 May 2022 17:40:45 +0530
Message-ID: <HK0PR01MB280160BCA168FA9FE159F02AF8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520121047.21026-1-kushagra765@outlook.com>
References: <20220520121047.21026-1-kushagra765@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [4J9M1/sT7r7UNhIkRZAmk35V7wmhu7DXKe/WwhnkRsuohHjq5ZqQzaGkwPzL9KN1]
X-ClientProxiedBy: BM1PR0101CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::12) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20220520121047.21026-2-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abecb7dc-cb84-44b6-8db1-08da3a59da2a
X-MS-TrafficTypeDiagnostic: PU1PR01MB2092:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qULunIoFN83s68G/BO7AYjSXCbHn8uMnCi4vn+6f1730MGs46dJztaA9NAzvdLQyj/GEP/XhR47meDrAtS20SiW8Vr8JHTb0DKERp6Wwwb6V3AeBk8vQSGqr+vSyeXeCAykkpv1v3euySasySniqwxJOMaBbdV5cXH6hbqC2lElUWk8510tO4vKMtLhmA7HCJPO8rjAGx6f+ynJlqYuJJsVed8f93ng52vlnXyC4Rqww3+YqCuuB64/wk9EESMc7yXFZZvXzjhDXLa/Ykj3N3lAAbu2ljcW1sSVmAd3zI9kXmY/BwideL+nqUus45JQCFlfmgL1WvexNuNsim8djTYBcjFVkJa3R8Ven16unl0hoES/VOUjhPnlmT60vMm/nw7ZcTV4tyAW6CgbcUHy89D/sXveWOE0FV28Xmtrk7VsLx9OF7xeTsSi4000B//W5ZCr0Vc0GgXpWUVlpN28bRI0iuS49tYJCMAdFzbFW/H4raMV0jgLAeG8FAIUSwNthSe5bPSJ0jNoB3a19d03O0toZ4kZm06X8XcCKtw4mXDskSIIB+CpL32WUxx5IjkZuzxSkDmH4topq3namb/r3Jw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h03lhrizkoswJYHCPJLbqAJiiKdsGypB9e1if8kkXIyHBiGdoZLBqB65HXvl?=
 =?us-ascii?Q?AxvUb21eE5s8Zvg4sh9TOlzx8pVW5isqBuCt27957e1jigfPuuhZQs0cEkdb?=
 =?us-ascii?Q?dd4j9OaynqvBV1K2IQMUDt/jAoWqZZBduHoJRbMwnf6dYefi3cN4l8vAToe4?=
 =?us-ascii?Q?cTUoKRAuE9DSe6PnpEIwM1LqdZZiiDvH+GxpAwxWZQvlH/+nZZ/k6bIpbC+0?=
 =?us-ascii?Q?o59BmiBzKPEaNott3rRkFDkvEl5utumLhpvhdY4ExANovKPwyxKyFMAH/s71?=
 =?us-ascii?Q?OA9PgRCxglstsNxCJnuJKYOWIudSoMzm1DyfAbwkN4ppPlDVG612OeE7My0x?=
 =?us-ascii?Q?gghQUAghAEF8Q1umXkCKe9reljViSrrdeCu68VGT5Jc1YrD8YVYqY93Xmb0B?=
 =?us-ascii?Q?dxIi30q4TWqHEsse4sx/wLqIh4+FkNxOLX1gKrv8QszcnGh0dxaffvtygPWt?=
 =?us-ascii?Q?jf+Ah6VIa8AxyI68blpeuhgHinRhDIxPnsXqLfjYsT9IjEUkWcv4CIxKfDXk?=
 =?us-ascii?Q?v6zCrmGylf4aMeX9Qzeb4l8uJ2gmzlQMGRXudghpiPpC7UcnjXtAZkRPTswj?=
 =?us-ascii?Q?cMNmGiGsj6vfeit6ynWJtqqakEnL7ZtX3G62G4Pp6V3A8i31ZjIVQB6EIYUn?=
 =?us-ascii?Q?kfUW8hTdbZwlsF0TtacBp+wP6FXbBs81ELYlNxNwyThab5YZw6uSmz3NQu5u?=
 =?us-ascii?Q?WpCf3GJ8QAF/HVtcABD0sSrVQBoioj3OMSRfnS5wUc3wwYp2x/Yh0AeWJDqK?=
 =?us-ascii?Q?6qcuYrySDKg7zD7YcQ+X15i024KtWWcsoizonq3aZG3+M4xsm33zWgyou/m3?=
 =?us-ascii?Q?wUfNWw4ZNSjxaxsSzJeTLrz971G9KTsU6g7r5AgYqyRrcRe9MwqV38bLWOKR?=
 =?us-ascii?Q?DkwOfYqbyaQThr32gxflyp4V1dkR/gPG+baZ6YlDTjMMYn+x0vsgI3GjRBF+?=
 =?us-ascii?Q?naNxSq1ax/vGh0FkHAmjIQcE0UR0zr6JqRHQfR0kF5tMehfgGRfieJ0jpUUh?=
 =?us-ascii?Q?inC8/VrhI0dH5SX4qqh3F3O3YepFxI5TIYLzz6gVhpUMMR1MvNQsR3TtjIov?=
 =?us-ascii?Q?vCY8loBumV/DcBUxkSA+OkRrTBBQ4r8H9Hq3X7VCSBu9oeey8dg8v/ByhAjP?=
 =?us-ascii?Q?jWB+k1cmou9Vr7tVsbKwo6tLRxZ4YUiDpvgQ05v4XKmxA4pKYW2MruVoVHE6?=
 =?us-ascii?Q?i9/5oLukZtJrm3ySCic/AmJccRw5rNXKhxRzx8gbqO7vDaqizA7WOtdUudPW?=
 =?us-ascii?Q?66f/wWCCSZCoErG9XxX5dXGFlVGNYOBiVxnXG/Yr7SjvUoEMFS8yo7yZuhUA?=
 =?us-ascii?Q?rnuAhCtGrwf2qMOp6+2h3Y0kImU70s2S5gk3CqgYq8IJNCD5hH+srIr/6A48?=
 =?us-ascii?Q?Osswhk2Rm2Tfezcq0RTOhCaYHnjuk6bIQg+r+kyoJWDPQ3PFVH1ewdgkTCon?=
 =?us-ascii?Q?lPR4invtCPYLI9NeW9j7/quUC8bjVsnFKfaBD2jo57BzGjzsrcetd4gDwVZn?=
 =?us-ascii?Q?Ey//k6piZad6vZy3YtsseKO63WfraE9JKH9y?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abecb7dc-cb84-44b6-8db1-08da3a59da2a
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 12:11:21.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR01MB2092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the bare use of unsigned warning from checkpatch.pl in core.c by
changing 'unsigned' to 'unsigned int'.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e027c0420dc3..de3f52a63595 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -426,7 +426,7 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
  * otherwise ERR_PTR(errno).
  */
 static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
-		unsigned length)
+		unsigned int length)
 {
 	struct dwc3_event_buffer	*evt;
 
@@ -469,7 +469,7 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
  * Returns 0 on success otherwise negative errno. In the error case, dwc
  * may contain some buffers allocated but not all which were requested.
  */
-static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
+static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
 {
 	struct dwc3_event_buffer *evt;
 
-- 
2.36.1

