Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4A35704A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiGKNuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiGKNul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:50:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2033.outbound.protection.outlook.com [40.92.91.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E355C97B;
        Mon, 11 Jul 2022 06:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG/VLOrKt8bTSvQwic1cXlYRB5gV+FDnhynWHI2v/eLDVUC0PBiXFTbzAcs/VtnOWumCYRMLrO/Uqi/WlXCNV8W6evlPMXAcEPIm1+NDV6UjmLUIcFI329YORCTgps9b9AeMVh2tO5l1aIgMo7PIa3Q05ADRP0cvd3qzwq6oJc8yyOSKuSyJ3F4lCC9KOr4/BffiN0qQ+uuYdbWyNhhiyGY3Vsp2qVggn7GCsAVNNCkA1ZDwcKgqq1ekQV+xx2/+xiOlRHceqZe69i4cajtb1Ewwn6pf65T44T5hCyMW0mdWMUA1M+bEnSffBVkTUEK4Nj6DaOjDMDxq4syLol/cCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AmoLHoZt/NkazApCeIh2QH+/kxFu5uRukKjPWAlev0=;
 b=hXcPIoZ2Uzb9o+3rEgBBBFMbsWJTYj7iu8wzCw2M+0ATrNsAyqMWimyir+0oitO2xhL49Ev8QuNLupjHo/RDsqs7Bqv1TcyJYSK6xrATPSVxtZz1oc0aioK+eJ40csQWLm2b6e0/qtRyXqRUZ+FLf3lAHpPvJfgaYg50tvdgF4abN22UJn5v0EQzg9weJVxLlgi4H5yLZyo48M2YSfUMN9/n7JclMiBqcabPXvKXmP9EcJxutn5HgMgpQ+YeL9v6cHn4K6CTK2BmQ5F69rOfId/ZjSod2BoRrbX1+t2sZyFzqni1kv4XtQJu7sj4HXwq1o5IpcWQPMXLAxTkssg1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com (2603:10a6:203:6c::7)
 by DB8PR02MB5897.eurprd02.prod.outlook.com (2603:10a6:10:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 13:50:38 +0000
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::3c09:20aa:1d83:89e0]) by AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::3c09:20aa:1d83:89e0%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 13:50:38 +0000
Date:   Mon, 11 Jul 2022 14:50:35 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: 8250: Add support for Brainboxes PX cards.
Message-ID: <AM5PR0202MB2564E7101DA29351041CB4C9C4879@AM5PR0202MB2564.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [PkDrhFYwD+t4et4lfHHIzHbC93Q3Iey+]
X-ClientProxiedBy: LO4P265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::13) To AM5PR0202MB2564.eurprd02.prod.outlook.com
 (2603:10a6:203:6c::7)
X-Microsoft-Original-Message-ID: <Yswqq8a1/GYC8R9a@archlinux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f8df05b-3a53-4d09-5882-08da63445619
X-MS-TrafficTypeDiagnostic: DB8PR02MB5897:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAlRI9wMcJShrL5ZjSmwBKx1bFwpwzdKVnDQ2e1Txx3v724N1aQ/SJiHbgM3/ibV9dnBuxgiRFFRssOve3hkFw94SyfaZPN3IOxuHPfpJ/Tr4Z17HEN4lJrQiRBjCo2U8aKQT80BfLE3Dtyt0ZyEma1P03X5xzHcIQWi5yV/mJOMbXQ16Ok9okCadj3bkIaj+NXXN0XtcWJ8nKbyvap8Mll/0YUFoNfepolpd5ekboMFj0BKKz/VaKIpC2G11PEZiJOfl0+uZ2veSxxIQ9bahJtnZsdeKV8T2RKbkWBGV3M2ZX4xglpwhQu1UHJyrS8XCJOBjrNg/hn8BKn/R6yqHZKN2mvMoQNscZVenPn1wuYfSNyyAXWSYSts4HlpIHg0+Nk/GU4hprHoGriNnrEUuWKRIbFridbDX9atVKsMApgaMkjuLB+YwNWx3zYJn3lAZ0NmAH44x+S1QB3MFj4o/lgbkaDWL1khpSGrbXLuWlhOsmWS9Mrt/JoCCyjAHBmYs9MMzFhBOCcTYtDhB1pCEJ1IsEpLs6k5OBiiS9tH07OfbweL6Xx0EuUoXVSTrKpzv2skd9e4ava3ZLIzAA/QjgXs//Td2x3yYMIHdSVUmGT1wQuS7qp3sOADybkT6DWoFR+jcmFOt3i0sxDdFYfSi6BvPdu+tj3A8SHES0OmujoHymtugYmjjqlKBGCktVC7cVqUnJ3x21Uy3Szt/C237A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ALrLKMxbQGHBEZJF1WHdpKANEMJW9G6LUDr2dkXYKYgpDaUr0+Gv4+4Ej+y?=
 =?us-ascii?Q?l2xC8amKYzOz4lWMyWITf9UMvbH0d8npCUb4OXz6tkBxc9hUIA56KIyOGYxA?=
 =?us-ascii?Q?htPB0YloTs7oSh4AAYA60luSNU0H4gp/y/bF4qqvn+XaFn8Boe51uSdYXHFl?=
 =?us-ascii?Q?SHWhgTjcgqQYQCdgQ4eESDjPp+hKC2W/aUuJrI36MNQm9eyfHars+rLekFDF?=
 =?us-ascii?Q?KI/S9PdvvmpkWpNf8L7vawt8HB89j29+Du6KlIYWE2+KNM9foYepov/6YJru?=
 =?us-ascii?Q?okjItDmCEHF/5ZLXKijwqqeJGPJTxhIjBR9fXCvsI0YKZ4xMcw7UGIJRY1/j?=
 =?us-ascii?Q?26q8Adf8W1h4hLLvuybtM0IRlyz1u8DJfkJUVCna0DDDY5gzqHK2MeSteP7g?=
 =?us-ascii?Q?kWi7D1gk1r3jAK3ujYf+bdEbyd9GsIAeteYNa5S4dU27kcf/P20tOhQFerC1?=
 =?us-ascii?Q?bsm6unAHMhSy5iePSB5sJbAY9gNzQZa6BRV7aPiLAQrml9HnLFD2lCVzR27N?=
 =?us-ascii?Q?zoaXJuMWknj95cvAb4yhnOdX/5A8XqWjI6glMszWAgRBQiDHzx2PlQti94Da?=
 =?us-ascii?Q?z+Iway4oLR0FD/WLjxGYOCLyGd7VrW9fLrp5P6uP7/4tt6sCg4khECp7Yh5M?=
 =?us-ascii?Q?doruu3oAiMvax8gGz5q1OSDYcEFymZuaNcflVs/518cqmUFQB1vUbeS9a01Y?=
 =?us-ascii?Q?oz1oIDEfhBFhvpExWgfPvvTztplGqigstcSSjHhwENkraDhz7KTgfT3d2soc?=
 =?us-ascii?Q?UwLjdts3AsEd3ReL75OXiyFZNeq8tKy5mqG9CMAHNv6GpKwac/3lKRpdvt5H?=
 =?us-ascii?Q?v2+KfAS4erxUjiF7oUq5RrVH+BTrvPjyteuDudBSurCMYo76PtPSGr7Q+nqL?=
 =?us-ascii?Q?fVYe2Ozm82tx+weoLO6rJ7uMuFtTi3WjEPgKYnV1nFZaROFerJtPJpLHYe40?=
 =?us-ascii?Q?Pine6ff60MGJ+xKBcFEmEM4kEZc6eEBrOjk3/HA6VvlghlpVRkkezIVjDDUw?=
 =?us-ascii?Q?4RR2tDynS9h+PvMyJQPm4E0a8h9sWQJgt2Th+HRKGMES1g+kiresTkPX/12Y?=
 =?us-ascii?Q?4MtSHhy7oi8e7Lje6WueOiN1hFt2UchOMLDiZAS90uo/xvQjRxteS0cFtsB9?=
 =?us-ascii?Q?5nXe8I2u1BdGFnFB/mJEijXp+WuzK58r2jo/L6eSmY9rJ9u8+fWNLSkzTktt?=
 =?us-ascii?Q?x84zCu9mzEVvXB3nPrTDeopALvcI3JxAZ02oE2JIKwgX9uDv1K1O0dIe28r0?=
 =?us-ascii?Q?nVVAEhzzfX+Pl5yh5OqD?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8df05b-3a53-4d09-5882-08da63445619
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0202MB2564.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 13:50:38.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5897
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for some of the Brainboxes PCIe (PX) range of
serial cards, including the PX-101, PX-235/PX-246,
PX-203/PX-257, PX-260/PX-701, PX-310, PX-313,
PX-320/PX-324/PX-376/PX-387, PX-335/PX-346, PX-368, PX-420,
PX-803 and PX-846.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
 drivers/tty/serial/8250/8250_pci.c | 116 ++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index a17619db7939..4a0ea79ca9d6 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4973,7 +4973,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	* Brainboxes UC-101
 	*/
-	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA1,
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0BA1,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
@@ -5005,7 +5005,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Brainboxes UC-268
 	 */
-	{       PCI_VENDOR_ID_INTASHIELD, 0x0841,
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0841,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
@@ -5072,10 +5072,120 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Brainboxes UC-420/431
 	 */
-	{       PCI_VENDOR_ID_INTASHIELD, 0x0921,
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0921,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes PX-101
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4005,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4019,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_3906250 },
+	/*
+	 * Brainboxes PX-235/246
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4004,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b0_1_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4016,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_3906250 },
+	/*
+	 * Brainboxes PX-203/PX-257
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4006,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4015,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_3906250 },
+	/*
+	 * Brainboxes PX-260/PX-701
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x400A,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_3906250 },
+	/*
+	 * Brainboxes PX-310
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x400E,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_3906250 },
+	/*
+	 * Brainboxes PX-313
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x400C,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_3906250 },
+	/*
+	 * Brainboxes PX-320/324/PX-376/PX-387
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x400B,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_3906250 },
+	/*
+	 * Brainboxes PX-335/346
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x400F,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_3906250 },
+	/*
+	 * Brainboxes PX-368
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4010,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_3906250 },
+	/*
+	 * Brainboxes PX-420
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4000,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b0_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4011,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_3906250 },
+	/*
+	 * Brainboxes PX-803
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4009,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b0_1_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x401E,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_3906250 },
+	/*
+	 * Brainboxes PX-846
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4008,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b0_1_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4017,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_3906250 },
+
+
 	/*
 	 * Perle PCI-RAS cards
 	 */
-- 
2.37.0

