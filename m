Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6FC52E709
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244862AbiETIOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346817AbiETIOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:14:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2106.outbound.protection.outlook.com [40.92.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF94A56F98;
        Fri, 20 May 2022 01:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQgQgoeDWrt7gK4ad4b0l7VjscKTO1w5J/VEIKIC2d1/Mrl/Z6zpm5sjUU+/T3CP5GLLRJLA9qE83ZLz+HF0lWu9za0v2ZT1BFrxMUi95iQ0rP24dZzEDhrpcV/CobA9wwSf2KhNXyZm7cK4bLvd9augXJPiUOYBAosrqWpVQ9TeqfJ33qBw5ttH3i1broF7I5h/icPC/yO584DoQxE/kYWIqTOiA3GHVeNE2oQ5zJj/Xx9bYwNsdqtbtk4cxBjN7GEh9LROCKksCRZwSb+XR2bBa6mXpEeRvGI/e3mt/yyUzIRUQ1Tr90PxE+v09vsO+4ldi4ro+ZPA676f1VV1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIxCPAE5rn693Sq8Bj2QBTDGxodIsTiNQApUBEkwi8w=;
 b=J36gfANWTV12gNEmdfZ0SBZVsRwEWdqY/cr1V0JurlHVuDf+8VnJvEc7MCY3AjL7N8xzj/QHxZ3fAWJHuECZcpqyaaWuRKiab8zYY2LjE3X5Ch9WM66u7CJqXBWVFPf8ukCfMLCuq8nqzKvv0x3fIQ2QlKCpxrSeMXO+nLUMoVq1S3ueZhP9rpl2pRnPK6qEVy3nvoF1zzMWBlOEsdJCXyVzd3JZzojqod/epp2e8HBiY53jcRBruFffJVody/oeXqauzokLfHUlD2+m8QmJeHtqtGPtlAdc1Hl2TRmuz5MAyQUu6l9vQX1gIJhWQZ3/iVJFqIw50Th1/GmG8L/rbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIxCPAE5rn693Sq8Bj2QBTDGxodIsTiNQApUBEkwi8w=;
 b=QeCQC6U6bvdKDgL1g/4V2Wsn4Im0xN2zA322KAUs+WFaRayJ3+Yei2J3rgeYq9j9Uc1mZiHdiqdc4icSQQq79VNclnEPduFk6nfH/i6cYJhDUOZDgsCGyhIRXb2E2pcT4lXjX+Luq11o/4akhD7+otBCpQunS0+siaG8T8zf64UzkPQKfQm545hErf4iJotM/bFllXI7YBNN9rspx0IxNx8DY2oRV+LVMcmDGYFWM7AOeee1yU8L2Pt0yyeQd8qnASmwl/WrvbAvgdY5Vy114txww5cmhT7L3IrexUgUCpWTOj+pFM83eOVQCN13kcgKHql5uFRuByc64s7vsKEMcg==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by HK0PR01MB2962.apcprd01.prod.exchangelabs.com
 (2603:1096:203:8e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 08:14:26 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:14:26 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: dwc3: Fix bare use of unsigned checkpatch warning
Date:   Fri, 20 May 2022 13:43:39 +0530
Message-ID: <HK0PR01MB28016EE28ED846E7ABCAE590F8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520081341.16768-1-kushagra765@outlook.com>
References: <20220520081341.16768-1-kushagra765@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [JAn8JWH2Siepp+T8QEGDoH1GVEYqustXWuJ2PH4NOSzjK8gm/TCbq/C0QhdfIcpi]
X-ClientProxiedBy: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20220520081341.16768-2-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54d37546-ee5d-4ff1-2fe6-08da3a38c11c
X-MS-TrafficTypeDiagnostic: HK0PR01MB2962:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2XMPYCX76yOIC5hFDxbuy6uSs7VVhRDpY6dvPqHeMhPYF/2toEG7xJsTyGBAJi9v1CbTD2ne4AcL7+M0IFrWOdjRF8chucxZX097hNNlVLSn5qZu8b/twcyZ0b1oycFo9Vemcw5VjQquW+B+2vXxZVOWnZrw7W1r5h+ybYTfbd2xil4KA95RmdiQWA1UO2ndnt4U4zHJSW6LMk1/v4WWxjhDgqrN7RxGbtF0Adcx2TD6ZFF3KF9iCXFtRBR8/B5dGXSnF1GPXKfbngATlVs+iX8qrMvtyLIQgoxdbrbVTBE78JPIk4El7ankceXlVvGWkRIVHQ6BHubFrFpjDX6SP1nMdwsvQxIgkNjTJqGDTcu5C7DZmXHA1DffD7XzZs/XPpc1+xgPDEPjkI81ym7rxa7pXLOAVXbZ/2AOG5tK+K4syAUKmXdlnyb06VrDbwyjrRJ9iA9elcLF4Dc7evVgL0pvyfHQl4fHZ75jjsXOiyfQTM6OKDWh1gXh2AdruNgkzFFQ/gUuuH5IZXduCyl0LX7AC9ZkYHxTp6wkxLR0rhJMlaU543GOPHgwxyikyhvegeakIoJIh2ON13e/yfI4Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Khx/fr25KWZR7Wmo7BPjLz1V0SzoW2MHXWGxYCyOEhAgGG7Zwz0yC8amtS7P?=
 =?us-ascii?Q?AozwVF03T+T0K8jqlBrFYpbqEt3QraxrfxcICTh6unIpF6sa0u0dRhzCNgsD?=
 =?us-ascii?Q?fkDdISD1T4SLGMCmaZyzdQAWwl+k7lcIaAPNUApro0HQG4210/lhFDT4G8RE?=
 =?us-ascii?Q?bJ4nMmVjek6x+SuGF07kCgUErS7wdespmPpwRELHviwVAY6wrU3bbJ8utWV3?=
 =?us-ascii?Q?Umua+/Unpwmm3e4TVLS+tVmOBUJ0oz5ijz7tGegO5rjY6JUySwvYO1PFlR9A?=
 =?us-ascii?Q?y6bxV3JI/QrgnoErUfCNj6CcWAE1LM1A2WIOi/AljWbrFF0AYu/LaDwVGnUW?=
 =?us-ascii?Q?fVIOQAgBVruW70K6Lyy5xX5PQxCRWAu0MQNs/ckie/Be0aZvGEGSofbxXNW8?=
 =?us-ascii?Q?X1Bo03tjZmhTQwoZJV78gqBL2X/9Us9WErLkb1ZCAJ5xvI2DYr3nluSIP7Wv?=
 =?us-ascii?Q?BBZkxF1tEXc1qQxghAY4rjblseg//FQq22Dxq6+jdBg/niO2si9UrNPNQXi3?=
 =?us-ascii?Q?XI0O4sRsjBNz9fMBv9Yn03tFB2Yh8XwqWGALa4js3hN1nJZouDImYq0RGMcr?=
 =?us-ascii?Q?2WQdPN1iC+N3ybNnWiG9tNz7qBuvkaUyguFGstXBlHLHeXX9COzdCeQfWy2U?=
 =?us-ascii?Q?WMVq1ExWCX5OoDuNRz2OYrWuIg1SFGDlvokcbH0GbG6HwaDL72TNb9F1EcJD?=
 =?us-ascii?Q?EqwNgPk8uRYFO820oEkaJsmeU3JGIjRE+S0L4AxUxPztBKrIirSP8fq0nk4m?=
 =?us-ascii?Q?Qhvrjf1oCbUj0DFP5qNuqUsh/seiclL2NmvZi/j8RalmY6iOX3IeF550ThWN?=
 =?us-ascii?Q?J7mvVcYVLt9/OBl4Ihbzt/Y1f94rsx4LKlXWlDUJE91O7COfvg5Vtowyww1A?=
 =?us-ascii?Q?PnWzse0iUtac5CdKTnA1wCdXx6LHeRRDpbhNsWUQd1gYFYnDHn12jdtuTZ/z?=
 =?us-ascii?Q?jC54RXofYqb+SSiF18V8gQaEusRk718agGuayGRzUvUXUv16ytUmPJVp4+Wj?=
 =?us-ascii?Q?Hs4VRgGLHdu5xU8bJqhNyj+TBJxEFdqCU1vJlAr8AZLDUqWmO3Bh9L3n/6u/?=
 =?us-ascii?Q?hzWgJ6Lo7OI93M+iy/ujGexqZymCO/W3JlKVzGZJBH+AaW5EBFCK+sGCxdXf?=
 =?us-ascii?Q?1VRapo3fWTR+KLT5Mv0WBkbRFYN1Nn5NlAuD5eAxIoLs49wyrCmc9a0/Ghmj?=
 =?us-ascii?Q?MFg/xGl3Nsy3OYEnYzN6NMpbGnnKWjxTpMjuW2UA+bvrgSzO/qbFUV/WTSYw?=
 =?us-ascii?Q?FnatjM1hAUtYmMYcFHr743NnKRqsCLfzvJDOs4ASzrytaRrMGqlwzq7/T47W?=
 =?us-ascii?Q?A9CmOXmKemD1M5yVLwJxQ6o7/qiT6rq2GQbuUuoC2V19RaufFiXLA1ipqqkD?=
 =?us-ascii?Q?ealw8fEGb/2gakzCXv+K6RO+pjYC63Otgvl/C8Vg58D/SV4D89VLA9O9NLyE?=
 =?us-ascii?Q?smcnDGPc8AGBSAhi8BnsOaVyIFjNOEIMZxvZocXT3XCxzThKsDYLZt2g0ky9?=
 =?us-ascii?Q?ww/dJETjUYMxuzuZKfDe1OgM0nn/u8WRx8p6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d37546-ee5d-4ff1-2fe6-08da3a38c11c
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:14:26.2057
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

