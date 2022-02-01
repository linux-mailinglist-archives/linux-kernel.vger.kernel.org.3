Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27ECC4A59B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiBAKNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:13:01 -0500
Received: from mail-oln040092071100.outbound.protection.outlook.com ([40.92.71.100]:52517
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236383AbiBAKM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:12:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgFiDYRnnDyKjYQ7pYfdqXuEpIPZVjWieQU7CH0MD9bUzV5zVIPLPflbd9QacOVFazaLzt2DlD0prDk2NUKJU5a4OaxdLHVdnjSWEAUEBpscPAOduai9j0pA1oEi6nWhfVqKcFAvN9mgURGZpr+yVuS/zI51N5M2zlEQrF4p+gn3nY2iEw+wNhGrn6Rj0sVhVFFZCEzwltO53t5Jfr2Z+aY1tmyMCI/TRucSI1nu+NDIleZnhOgve3FLgWFMlimOnYOvFh+8BNb7c21NuYRIdPHT3x79C3R4E9Ka23TGRFra6xt4DmsGStG71XHtBCEuvab0Gylfqsdc70YYk9Lk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7k8Bm1jA31Lmv0AmRtzX0+dgrZL9l50yYQU9DmMQqM=;
 b=eZIqm5Hksr69qfbBqCxyxEOeexEYwdTy+IlIXeIFnpxtgCSm5S0RHvz9MjZoiof3IyKZgUgqCY4JftoF2a59SW87OzyIEbLrJwkihJorVlPXLgSm+1fBwLVQRT0ExwdOXdFTZls6rf0SHxso05Msz2o1rBy5M/ppAyHpiGmDZcsfUKf3VBeFJprl632bRX0BdnaonYZrzujd5xpTuuX9oY+Dq0CEJznyF/foEZGVbDmWA4lqhAQLi1oA6VnZOu2AtEAf6DdBFKt/yS4W3A03lAbcjkuE9gediIrhqJIUFkXEcZd/s0OwiacZTU9gDFr6Xlr8rmvCOY3yOVHZ1gCwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com (2603:10a6:203:6c::7)
 by VI1PR0202MB2669.eurprd02.prod.outlook.com (2603:10a6:801:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Tue, 1 Feb
 2022 10:12:54 +0000
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::1182:31aa:e396:c15c]) by AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::1182:31aa:e396:c15c%2]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 10:12:54 +0000
Date:   Tue, 1 Feb 2022 10:12:51 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb-serial: Add support for Brainboxes US-159/235/320
Message-ID: <AM5PR0202MB25641C06DA64C54B29F1B8B6C4269@AM5PR0202MB2564.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [3xctGm9E6j7SMjLCXnMMY3DEC00OQlr5]
X-ClientProxiedBy: LO4P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::15) To AM5PR0202MB2564.eurprd02.prod.outlook.com
 (2603:10a6:203:6c::7)
X-Microsoft-Original-Message-ID: <YfkHo9hFWR1L4xrj@navi>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2448fe24-787e-453a-f8ba-08d9e56b6928
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2669:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69Q3YQe89FWJw0dDdQmy+m/+4N0oMaTVIpGLOciFbuckl3Xmx2zs2IFnZCNbvkJwI/y50JgITbYz85fPMFx8lY2mgWNIaRJyfYFhTABrj0s8iH2Dt4vZ9mIS4m2866UXHcm+AliyXaQSMzIpTr93+HZcNWOR7xKPquFmZ2GSd6d6tt3GMLZ6/I/VgLsYFUa3wBPlPEJuOHH4HEFCmyTPMtrRceehl3tQwznnYM8LsulEmjcVDcSihMQtnwlYcl9cP6qOLsIifFgnAcy/E0YtynnrbSGGIC798nyBoMiNOyhCYQ4u6acbmi19l9TG0+NS9927wjvFY+WGK5CkUkgTWPn1FQVPpy4+0PVK85VRPukWIKT2plOL5p8pYd9SLC99pnszix0ID9qn8Avwuh8jYq5cYy2xxlHubOkYP3+sWDS83lCCsGKC7qGWtwFyU4CnNUyHtZ9LIL8LXVlRyGs83eGdn0p42aq7jIl89h7k98ZKRU+9386wu2JDL8mDHE+T9X1IjXRHXPhPAeln9fQKVMNZPSnBkmEhxXY+kEfHaD3EuEtO69h2swBPdluyI8u4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PU/kXEfOv3U1fW9gJSQXzllBK5M/ZCghgxXsRN0bMWFknmkrWWTOKWwjpvor?=
 =?us-ascii?Q?gHMtnNHEOJRfOROUeFKGqd3H6l750MNCEsHLna8RYwTF42MY13fVgFVWzU0i?=
 =?us-ascii?Q?lzun+wuM2qx0VuQIEwqBCgdAvr1A9lC1iGMnyW4AMdIwmLONQs7DCJlul0Qf?=
 =?us-ascii?Q?ewTpMn0Mwt6fapY9JdBg411aBPijWejtYJUjLEdj6PRC2UHljBtYyTysubCi?=
 =?us-ascii?Q?trfC1rJKZUfKVtj9AlaozjZ+HYioogAsIh0ZY7hERZX59wpFSloPVjclUNng?=
 =?us-ascii?Q?xX13+av2p4s6cY5bTeBhxdsU1lVIjE09N2zPBjjL+ZodDn2aK/MyKAXCAYhq?=
 =?us-ascii?Q?jTGJHvXtYbLwf3IsPqlDSejT6H9j1x99A6DGu/nEFd8rBmv/LVIX6Q9nv8fE?=
 =?us-ascii?Q?ZSPHjYX1ejSkQ/5FQ6mZ2lKIcQKGV85Ou7p8XjZ2D76WoMZwNoXQTEZFDyAE?=
 =?us-ascii?Q?fOm5GD6wzje7munRQAZQn1BKb3CbifhbEGCkF/pQ0Y8wZQPMdZYxmEC0ezyY?=
 =?us-ascii?Q?sEO05AgkUqCXo4JyX/z6xp63IT1Rn7/GlQkEYN2UBctHgSXjvtCC8u2VkcFq?=
 =?us-ascii?Q?BDYOgaz6HCZHtKvnv5ObT1bMzoTgxB8QxIj1k1CqOR8MYJK0U4hXdi+wUi8W?=
 =?us-ascii?Q?ZOF/ufZMz6WIYUTUKFEPPUGIPq1nFuFcj0AI8MH+109jGdW0rCM9eW+VTbsH?=
 =?us-ascii?Q?E8zq78+IFxZ1bYTeOLU+9rA1GGF/WMIyUfw0PIY/X6r4imr9o6WdNoePYo1k?=
 =?us-ascii?Q?+kVSVy68fxXSJ7dtd7/AGsbSMZFIFJnhDHxRmjzq053DqWWKYdHxEXgrC8qd?=
 =?us-ascii?Q?o6Xb7N3xuJtyoNzFP5byKYrDU2uGyYm7xT0LZRnNEhCjichTnuwRer+cyBL0?=
 =?us-ascii?Q?kqdjLEfN0hBxYYPiv88siOL+hiEGahdYNJCZZM4rk96NcLFhAqr8lERi8f0N?=
 =?us-ascii?Q?B9ETd+phkA5IXw7wpN3LYA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2448fe24-787e-453a-f8ba-08d9e56b6928
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0202MB2564.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 10:12:54.0533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2669
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Brainboxes US-159, US-235
and US-320 USB-to-Serial devices.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
 drivers/usb/serial/ftdi_sio.c     | 3 +++
 drivers/usb/serial/ftdi_sio_ids.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 4edebd14ef29..49c08f07c969 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -969,6 +969,7 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_VX_023_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_VX_034_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_101_PID) },
+	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_159_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_160_1_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_160_2_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_160_3_PID) },
@@ -977,12 +978,14 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_160_6_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_160_7_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_160_8_PID) },
+	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_235_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_257_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_279_1_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_279_2_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_279_3_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_279_4_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_313_PID) },
+	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_320_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_324_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_346_1_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_346_2_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 755858ca20ba..d1a9564697a4 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1506,6 +1506,9 @@
 #define BRAINBOXES_VX_023_PID		0x1003 /* VX-023 ExpressCard 1 Port RS422/485 */
 #define BRAINBOXES_VX_034_PID		0x1004 /* VX-034 ExpressCard 2 Port RS422/485 */
 #define BRAINBOXES_US_101_PID		0x1011 /* US-101 1xRS232 */
+#define BRAINBOXES_US_159_PID		0x1021 /* US-159 1xRS232 */
+#define BRAINBOXES_US_235_PID		0x1017 /* US-235 1xRS232 */
+#define BRAINBOXES_US_320_PID		0x1019 /* US-320 1xRS422/485 */
 #define BRAINBOXES_US_324_PID		0x1013 /* US-324 1xRS422/485 1Mbaud */
 #define BRAINBOXES_US_606_1_PID		0x2001 /* US-606 6 Port RS232 Serial Port 1 and 2 */
 #define BRAINBOXES_US_606_2_PID		0x2002 /* US-606 6 Port RS232 Serial Port 3 and 4 */
-- 
2.35.1

