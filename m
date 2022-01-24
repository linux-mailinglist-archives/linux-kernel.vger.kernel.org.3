Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE356497C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiAXJmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:42:31 -0500
Received: from mail-oln040092075099.outbound.protection.outlook.com ([40.92.75.99]:25334
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229514AbiAXJma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:42:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIH6JUeyDPmCKPtLtc/IhxT54Wdhe+55M0qZxHNbwsGURdOlPYjDZIGWqNG9aJZWj9BniwrJbRK9Q8Pa2e7kJDkNLDjX/SH+UDzrxvn/pMXarLAQn/EmfdXCVkto6Kai47f8UcySAS9fkr65LUMhfnl8mbVdJoIXsPAVbJwRn402pP/Co1t5PAbELPbv66Rog4XOVpe2kHXpbLqduR2u5Udd2keBPuDJwBqoL3lsbNQMGV7lppBlf1Hn80zfkc3t2TS+BVz+bymN2wP0WbOr05+Q9G7fTUAx4zf2vxDUY2+1R/PH0VEifqF08kBs8cHXlumwPgam8EKYla+tt3eiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qy5cLjIkKlttuBI4ZqLrLyKNYsrBl22CnUEUl/042/4=;
 b=hCIFoZRmCfaTTgsUp4gmsFUuzPkmd1aPaSDbpj8Fbvxuv6sXT78sCjChv9cZRpAPkiJ5BNw6EW7POFwEyycOmlXh46V0PyGMp/pqWOee/K3BZ4V8pkd/jkLSFPHynbtj1PtR0PvJ7pXNvijwPHVkrGsModrLAMmaE8tnTCs57tyHkb7gCGh6x/8jCq4o1XIOYbfHkiC5KX2AaNJZ8OtbxQxzU1mPE3AByfFUgqzgXk1lIfZFpIKTCJGPGGqQSitx6BAEXTVyj8EwVFB3uw/IFUWvJoilYwe8D+fBe4vQNO1JhAstUqPb0hnNDTNedJ9lq8kF7fJQYA2t+3jh4Xp+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com (2603:10a6:203:6c::7)
 by AM0PR02MB3763.eurprd02.prod.outlook.com (2603:10a6:208:4f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 09:42:28 +0000
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::1182:31aa:e396:c15c]) by AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::1182:31aa:e396:c15c%2]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 09:42:28 +0000
Date:   Mon, 24 Jan 2022 09:42:23 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: Add support for Brainboxes UC cards.
Message-ID: <AM5PR0202MB2564688493F7DD9B9C610827C45E9@AM5PR0202MB2564.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [AwmJvZmcAnm1uFdmgrXhdv6vUa8nWaS7]
X-ClientProxiedBy: LO2P265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::22) To AM5PR0202MB2564.eurprd02.prod.outlook.com
 (2603:10a6:203:6c::7)
X-Microsoft-Original-Message-ID: <Ye50fyGYwb42IpVm@archlinux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d40dea2b-f9dd-4b2e-d417-08d9df1dd555
X-MS-TrafficTypeDiagnostic: AM0PR02MB3763:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mg4iKjVDu0APKugkH+LAdLjvCdOx3mj7vQiyrphKi216icJRRiP7vrNhfdVqMePqYWvjs6zGhYOfO4lWeHRJd6PMB0IwqWX7RwAPi9BUFiPGvxhBq4jeqZsvEMOfWSHYoszQcv9s75z22p4eYLXewn8Yq+DAeODuDO1heJvYuVkAX/x/Ss6DPZwA++ib+rm4eOgIn03H1ivOmIxDM1doasVJ3j1e7gOTRlFgrQ3zg3XNr57qCQlXS0CMEv7V7vmCZhhBpEORs3YuSxBmdEwx3K7y8E1wFZgDii6he3p+04W6oyIiqRrJ2sSF/GsJ01ncgbAEEConWiC+IOzuqkwt9Ku40UOb0s6L0r/X5dwCv7cx3Dbe/Kwd7q2UGZNUK8yfrs/1537pjAtTiZerXpIXUp//hXHsuSu1zv57J5DlwK0KWkCudVrTWeyc+0rfZWMXeE5w2Ic/LKGFowBd3iXBmmDPlrjMygLhUPJBTsYp2XOzu9BCNKSxNAWQj/3kCnNhzzNH/JBtOXslZgQJqjxrfZYQFiSWtlU7A+TG9r2LIfSLQsYfVy3JU0P74zCW5DD7RhB+xk4pQBd7506wY6etyw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nJ5oWZvu62IqFDLXCufKJKTesYTzkvi32mveGWDn4EZJsBGLovtYYXPe9YOg?=
 =?us-ascii?Q?G17PFLn2lPk3Wns/LVrXRE4dgz2CZgfZeHDUrL74CBJzze+Hb3ohxFBlddLb?=
 =?us-ascii?Q?SGTwocbZ8khMcpBYT5fyE0SAesuleycAkgvd57npuHSfN/qBWuSvGDCJLVLm?=
 =?us-ascii?Q?+knr9PIi1qgBUFEtfiron2QvfoH3+NScSan/6AXnRRHN4CdIx4i0TwWc8Sd1?=
 =?us-ascii?Q?UtPLXg8/sfTx1Sb95n2rvDFDTqqJD6bWY3wGh01QvIcVUP3j0k6iH5RlCZxH?=
 =?us-ascii?Q?TSgkZIfOTp6LzL9X+ignqdfqMQvIQwNvHn+2b1kkUvgbUahCf+T8PTDyU5Ij?=
 =?us-ascii?Q?CHFY852ju/WCen6GYoW8ckZGgAmV5Z3SRd1qGig4zdgztsFZZszYNmHaldiZ?=
 =?us-ascii?Q?9gsveHzaJ8Js2KccHME7olHK5HGqK2c+k5QqoFGRv3VHhemXU8SasrWZ5Poq?=
 =?us-ascii?Q?4bliADU2Qen2Qp8psxk9OS9hjcpPDlqClhuK7LIE5C+qgx/yyPp3f3K4R9Ab?=
 =?us-ascii?Q?mIGjX98hlK8a1+mrM0mTQl1mKb0G7HL/xgRXAgxXSjuyudsFu2I8rZF/mo2D?=
 =?us-ascii?Q?ngzUi+VlZmw4V6rwVdUTaeRicFeNBc0DTNTXgB+E6GLXibb2OXfln/8nZHFX?=
 =?us-ascii?Q?1rf/JxtYBL9Mxb1mil7B+t4wQE/L9YtabYXYUuW/xJ1NQt8Gkovqz0UfjS7e?=
 =?us-ascii?Q?f9nhQ9mC62MWlOK/1aZRcvjKbY6nyE25be+wMks8TruLx9uKlMQjpk5cuGfG?=
 =?us-ascii?Q?Eoa+GI+4kKJlhUoIdVSsZZ613uTc8f5+j1qfIjD26VLrxuIAHMhx0BHjFjwl?=
 =?us-ascii?Q?kDYssAVHDUKrS9k8A7GHCffwLvVpafa0XhD9aV8vZD4D5zuOCgfmSZdKMNTK?=
 =?us-ascii?Q?Oidh9pyfMJTo9cMJcuSjUNoao7vkw31H8Fhec1bKgwWund2YskO4KNBhN14N?=
 =?us-ascii?Q?hfmzzl//W4MTjayHS/4W2Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d40dea2b-f9dd-4b2e-d417-08d9df1dd555
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0202MB2564.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 09:42:27.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for the some of the Brainboxes PCI range of
cards, including the UC-101, UC-235/246, UC-257, UC-268, UC-275/279,
UC-302, UC-310, UC-313, UC-320/324, UC-346, UC-357, UC-368
and UC-420/431.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
 drivers/tty/serial/8250/8250_pci.c | 100 ++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index e8b5469e9dfa..e17e97ea86fa 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4779,8 +4779,30 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS400,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,    /* 135a.0dc0 */
 		pbn_b2_4_115200 },
+	/* Brainboxes Devices */
 	/*
-	 * BrainBoxes UC-260
+	* Brainboxes UC-101
+	*/
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-235/246
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AA1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_1_115200 },
+	/*
+	 * Brainboxes UC-257
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0861,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-260/271/701/756
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0D21,
 		PCI_ANY_ID, PCI_ANY_ID,
@@ -4788,7 +4810,81 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		pbn_b2_4_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0E34,
 		PCI_ANY_ID, PCI_ANY_ID,
-		 PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
+		PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
+		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-268
+	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0841,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-275/279
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0881,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_8_115200 },
+	/*
+	 * Brainboxes UC-302
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-310
+	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08C1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-313
+	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-320/324
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0A61,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_1_115200 },
+	/*
+	 * Brainboxes UC-346
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B02,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-357
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0A81,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0A83,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-368
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C41,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-420/431
+	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0921,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
 		pbn_b2_4_115200 },
 	/*
 	 * Perle PCI-RAS cards
-- 
2.34.1

