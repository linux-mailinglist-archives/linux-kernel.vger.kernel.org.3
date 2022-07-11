Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0357072C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiGKPfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGKPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:35:17 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-oln040092064040.outbound.protection.outlook.com [40.92.64.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD7D61115;
        Mon, 11 Jul 2022 08:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BO5mUY+onYEsNNdrrSXaNhy4sbECbva3zFYhUgWDpxc4U4jG7BUCNVgEdk58OMiBe4L9hNXluNB90QqIUApPy9ZgqUVd/exPVGQf355gGIR+DK/YaaSpsxo5p7TrgCMrZEEMZUUjwKA9fIQDKFdb/2zqW+gNPxLQIEnmPglKswTHmkQnOG4FlYJMJ63OZAR7b0z8+er9EquGK1L/SmRl/m+Z8JdcselFfeaLOaCM/MZAVSPQH6+SR64wwJ6ho+nksR22N/soBL62OhF8DnKJ59qjohqlIw6DG0JPUKu99L1Wx+2dsdgG0yThm0lsV1HGCJY02eJHSww7gBzxlFggIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xzh5JGMwxst5DzDuVhW4hdb1HZ6oHunXoDmzE0E5PxI=;
 b=HTOB8Tf1jMEnKjODuEiyuPPCGOEc9t0npWayABotOPt5IsdEGXlwH8YbaL4W4lqIgMOLDjPPbaSa1O1Vody/1tQ9GX+wDkW6+r8+d8MS7mXXVd3gW4QCjbqgwLwiqXtRCMOMW03mxeJlZYLumZXY5Blurld7OgsCDRj0UGP+7mHgd/Szd5YMAFoDBb9v6OWuCw3OkmQFK/xXa1xazxmOYdDcQRFkn26esuX6UT1Q7DU3LUvATSLSnwIxH68zR9oyyIOV4ocAHbQBkrHMW6476FN5DGaxnGI3TXoDFv83OjSqIKfCxcg+n/eLefD7k0GgqYLErmJGiwegHwJmlW20HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com (2603:10a6:203:6c::7)
 by DB7PR02MB5100.eurprd02.prod.outlook.com (2603:10a6:10:75::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 15:35:14 +0000
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::3c09:20aa:1d83:89e0]) by AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::3c09:20aa:1d83:89e0%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 15:35:14 +0000
Date:   Mon, 11 Jul 2022 16:35:10 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: 8250: Add support for Brainboxes PX cards.
Message-ID: <AM5PR0202MB2564669252BDC59BF55A6E87C4879@AM5PR0202MB2564.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [2kQ3Jyzzjk+A1q7TIVJfs+d1Y+D+J9j9]
X-ClientProxiedBy: LO2P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::27) To AM5PR0202MB2564.eurprd02.prod.outlook.com
 (2603:10a6:203:6c::7)
X-Microsoft-Original-Message-ID: <YsxDLlUzQTM7Mcu8@archlinux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db65b58d-5ad1-487a-96f8-08da6352f2db
X-MS-TrafficTypeDiagnostic: DB7PR02MB5100:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGcRRmUbCcdv33p20EpS8gCkPpY3pI/alaHrruHbWVCnZS2VifFD1D+ieBrHBI0U6hCJ58km17oyJH4b1Ca4jqoYAFK4imIKXHFZyDLlgvqZzp6/d21Gjukc4EnM9PDxmHgWJCkwCk/kX5RDfJSbHSHH1p2hsPGHqE7jVnxLN/cku+HnX6PvwTD4BZfW7Rs2uvqr0B/rHscO3JlwmxJso4e4UxU4ZJrZraY3/SXOpL/b/ANb7O8jfsopuhiofdmPrkNSLjtCSeSWo5DVmJxd5DrQQ2LZ8cqzGlViJ4TRXE5oF5gqSrI/kuaShvyBKKYVnaKTHP7OPkeSdaKhgUbdR/IlglRljUYy46zPGCoAZC1fMDLGTQeanM6Apz4JtOiltkMy0ypjSdCZvunRd8hlBfXF0p/XJF5s4WzK0H9d1rGKXcT+CqsSG4yaLoh+nIMkWII0szNi40wEcJRTDOzvFv/xF3K01k0+snS20ow4Nr4GliDz1tb6eyEPPXfVWlZY31P/6pMWXCHSRApQcuBFq8fwM6CObOT3I2WuVi1wWLe3+Jlmp37/JwjuUS6libansuEPIiDcFUHCOojn91G7f/v17jCVDVY3e4u0QzDz//XhC6/S3eVSyuEAThkL64ikyEk2ZfqlH+szWMqd87F1HqIPkjYbqfmrjH0QKKxjc/po5At47ZTyrhi27nLyT4orPP4evpHQPI7vgHrx6yrc8A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VuoHP+YhMYTVjCRmmSH7hXEsa//v964rD/wvb53JpPVG7nvtWOWCNLZOFBtY?=
 =?us-ascii?Q?oYzeG9gm7e/64NMtt8WDEUCtdnCJdgoAsLy8+D85YKDmk9dmgGG+abboooSl?=
 =?us-ascii?Q?E3ZCu7wWEjLZWTQPvG2f0mtAwovg5Lejo6tiZRQRrMUPGw7cTcEyWtLFTVIW?=
 =?us-ascii?Q?iilduCv0QGzlWcwyFbYkngOS/K5fClcM6oYNYZRgC9CWxj8rPDINxH2zRiLG?=
 =?us-ascii?Q?KBse1hgdLmIBIhcrMKzCMHHswqbP9qWOILgWrRM+S0b+rzQ6lK69gspo+4Ys?=
 =?us-ascii?Q?ysepCripODAlc1WCAyT5cOU6YCcEztwJ2xkHzf+CZQrTO7re4nQqtygWjN/k?=
 =?us-ascii?Q?5ADdE4x+3yE2/ETPv9vXz0GcLvsKHziNYM8EnyZ6MfzOLMF8UP+P86ykMv9T?=
 =?us-ascii?Q?yG1pirkQq5RNiBMqmr7aHTihVj8pROkiDwqfF+eJ86Yktc0McG9mrd/phdhn?=
 =?us-ascii?Q?0UWqTQt4KNmNwvG/HuzraWGnOcAIdUK7Kf1jDMPgxtqEMMzbNlCcbuq7XCjj?=
 =?us-ascii?Q?FhkixDFXAsebV3TOxZmW7xK2593zHtJRMrZgR8fgC4XAqFzA3iDOHo9NNoVn?=
 =?us-ascii?Q?a7LFjoTi91bFY7KtCxi/gRHM8XIRkSALDZ+MyUXBRxTYWtfhJK5IVs7AW+Bu?=
 =?us-ascii?Q?anVXwsN1EQrXtfv5QjjTqtvYI+z0XDJttarYF2Cm/Tc39Tlt+VekUzR370l1?=
 =?us-ascii?Q?wACorsFWBYhnizJxQphzTsUjXe6iCYSgleonpn3e9JA8wxMYuTCjdPfxJwMr?=
 =?us-ascii?Q?/AyKz8ZqiZdc3RFcLw+DbeDfpOtunBeiCp02XEeKtc6poVtukKMqpYuMtEtA?=
 =?us-ascii?Q?wAajB9r3Z2+H+M4uCj14bfJarenkuV81bjC9/TJPmUaVbzCPV9FEkNAw2DFw?=
 =?us-ascii?Q?f5kEF1+isjGua3k2WR0NRn5ZvkP8yLjgKfdH84sgWT5LZVy2ZbszbFZT11sv?=
 =?us-ascii?Q?c/PuIE4K2pnzAzGJpf3FFhGMnE7CSmZMmFkNB8q9aJAcV7kVkeG0S0U/eqEe?=
 =?us-ascii?Q?2zpEt+23Ko13FR91MPncp6Zy2nr24cTRY0hIr5Hvbtqzx+kqyUkkuJ6D/dML?=
 =?us-ascii?Q?MWYeUYVJ1jjiwDByTVKXkCRBkiE8nlZB1/pmHRMbIe2aXvBmDoYtydzyn95d?=
 =?us-ascii?Q?ip2clch4OQJZF7dd/SvlkthymzVaYBJSnMxo+wHaPlqv0J+SbZB/akJR7VU/?=
 =?us-ascii?Q?qbLrM9EcIR1SBNGsJhWpgGXXZpkBqkcp67stuD11t+yJX88iM3N8KYGrbz+L?=
 =?us-ascii?Q?AK2P6IX/I91U2UoBDy2z2DptPTM3sx4Fe00/cdGoPA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: db65b58d-5ad1-487a-96f8-08da6352f2db
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0202MB2564.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 15:35:14.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5100
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

[fix for patch v1 to remove whitespace fixes and also
correct base baud configuration for OXSEMI]

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
 drivers/tty/serial/8250/8250_pci.c | 109 +++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index a17619db7939..2a578980d87f 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5076,6 +5076,115 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
+		pbn_oxsemi_2_15625000 },
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
+		pbn_oxsemi_1_15625000 },
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
+		pbn_oxsemi_4_15625000 },
+	/*
+	 * Brainboxes PX-260/PX-701
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x400A,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_15625000 },
+	/*
+	 * Brainboxes PX-310
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x400E,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * Brainboxes PX-313
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x400C,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * Brainboxes PX-320/324/PX-376/PX-387
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x400B,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * Brainboxes PX-335/346
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x400F,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_15625000 },
+	/*
+	 * Brainboxes PX-368
+	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x4010,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_15625000 },
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
+		pbn_oxsemi_4_15625000 },
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
+		pbn_oxsemi_1_15625000 },
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
+		pbn_oxsemi_1_15625000 },
+
 	/*
 	 * Perle PCI-RAS cards
 	 */
-- 
2.37.0

