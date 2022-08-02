Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E2B588068
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbiHBQjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbiHBQjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:39:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79233B7;
        Tue,  2 Aug 2022 09:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCaxdJ8rwhpOJpS1ByUxR66ZYtfVWEXPtrSmTKDqkzhDyvkcVwhOWXumRiiCFTebCWSNhyvYxgXPfpqkoxYHJpofFJ/ZBHk/WBAL4t7jddv/7BKamMvLbbW9oecVfeOebS3TEmIWOJ7uFMxF2OhuaQkn7feCTwcZPfKqnrAqdl7/40f6qqs9VQSGSy9cLAhXKdjsmzY+/FX2hxVvdiKNCOhXjM5ZVpUCE0XP3KnNeZFXotWyKLPULXLIMcsiyLup+VxXmfeLZOMWVDq9hutYNfFJzdey9yb9yoj8Dfgi3rLr6zm/bdChHI7H1gEN24bCWkx7SNbZif9JfMNOe+79wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBsmwof8M2VQXE/Ow2fjGaI2m2Mh04WmfLABZJ74jSc=;
 b=E1l772ZctiaFJa9DMCdBwGmTjBYZoTbCpzY7r4k/OpxsPWszdlS7f5fRw9sszITFbeT9xCdtd1up65kAzNbGZhkvdi1QqvoIq88f0iaZkJ4lGSrM8NkDu5GxqCfGMk4jvhzyNuvD+DpiGpldX0y0+i6Bis6jTS/2xoiNmIpWbN/5J+6kEAw8t/eeabNThCOg8ZDbwzZEsb4YC4o7QtBHjM5ZQsYUgq6Kh1c2ovqy2hwwyCF/rb+3KgpW02RK6Xijl3eJUqhBalNAkrGuIt5SLfpsl3URk6Q5yhhtztQe42YSEBQlclvXpyQg4ojIFBSCUJjxp5ADTkCceoxPzL9fpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBsmwof8M2VQXE/Ow2fjGaI2m2Mh04WmfLABZJ74jSc=;
 b=M5snyk9J+Hgjp+JhH9OYLXCwSSW5sEjowMz9mXUOpputx+0YcMBugXXEfJtpwyjHZ/Vpr4cAIe9jj8ppo+wZytgcMSCh4qa0hMl8fgVCFxaSRqVmz5ejWcMkfhuoSx86pX17Yf//CBfTy1qpOwLmktdBlRL5BWj9CJLYUEC5GAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM0PR0402MB3555.eurprd04.prod.outlook.com (2603:10a6:208:1f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 16:39:18 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%4]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 16:39:18 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Nicolas Diaz <nicolas.diaz@nxp.com>
Subject: [PATCH 1/1] serial: fsl_lpuart: RS485 RTS polariy is inverse
Date:   Tue,  2 Aug 2022 11:38:54 -0500
Message-Id: <20220802163854.1055323-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:a03:60::34) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8ee8897-28e3-4003-7398-08da74a58b75
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3555:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /RqzAW7mUW4MP+38PLGXfCqENz9OabPDnB78PYp74JlfcZ4Q0HrhCPezNl5VAMDWv9XNe2dgHPlmtn13rt0oLfSG93wN0p6zJSwyeg1tQa8DcQuVBfRbYQLUL3jqlvPG6Sn/DdqaYkwyDXLs7yzKfrH2IYC0oBLJhRfHwYpC2rNxaVDSF1mFWIEkDR0wE5h17D4dDcV+5MWs7+aFnH0tXPd4DRwmL+NrBMGHOYOhy4anLqv/sdMgglFlcIVJ0vk7nKLDdqws+C3gt3dscPPJ8rLSs6B6YgIRgAV2ZL2CV/yJoJ4onTlSakbGXGNrBxLDPzJlTeOResadl43lEbr1DdXOvUyI9WiVwDqoBS5M529H8Imb8aRUVsiljpzAKYqiMwJejJp6zb2KQSbSRy3Pou6HHh3DtzWRrL4WwR+Vgys05/9skYw7cxSWEFGj2vw0aEEDRe/PNX9ZNqdIUVDzLpdjiFdSLrYLXfQvjvfFIxGvm+xqFIjX745z7b/PBh2DoR0CIWTwzwSQPpJSzbiBZjW8SM9tElFOsi4KMPDehuZrlmVlkNIdM34YvrM8uTxkH3Qil+p//Xy+Rc79r8/dnLiEwDoxRP4TJ2kWpFnFA5d8fl9/EyeezyOFtGZMVWF2J7+gozWgefkAFKLeECB0jpquSPWjSXoh0RwpzReXMqPnp6loU7xfjJnngNmqLtuAfWHh9SwG/1V9t/JAHmzPaUCv5KxEBWXPuvmxe1G9tt2MKCgX/iMnWaWItEQpq682Z9GOsO+33anP+FopiETrKKPXFTKYwc4ailxoiIePgeFX3Cfd0zPj1S/49sHsWkHn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(38100700002)(66946007)(2906002)(4326008)(8676002)(5660300002)(38350700002)(8936002)(186003)(478600001)(6486002)(86362001)(66556008)(1076003)(44832011)(2616005)(66476007)(83380400001)(316002)(55236004)(6506007)(54906003)(6666004)(52116002)(36756003)(26005)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lf6YMq4QUv8GFlLTQYntSzwnOlzmMmIehUt3U4qyT0ungCWqQJhH6TQvt8Oy?=
 =?us-ascii?Q?4iJz6mOzUVILU0gX0L+BCFmPz56meUZ9cCC3aMfUZzR/hQXUFJeUBOMIEX9N?=
 =?us-ascii?Q?a5adxDHN5M2xvSmYKkIPI4LTMHrxnMMeIsvr9x6qRBHCOvafxPTmPAExXpwI?=
 =?us-ascii?Q?Iu3dLkAuDZIlx07CIedxZSP5hDbIfDB6DVIhHkzbI/XyT/BrJYsi0Nz6jl5n?=
 =?us-ascii?Q?21J8SdDpXHElCv0ARqGEjve/NuluKNcMxz2FhrcuNM0Wl+tyyH/iV6t34FiH?=
 =?us-ascii?Q?nsAN9WljMb5L00rRiiTn4itJY7SlpxeMVDzVmy0NEvBJPqq/zrsAzRtt6Pnq?=
 =?us-ascii?Q?yqsNcypq3/AzmQvf9CR0RTPonoleyWJZ9ATmGkYiz2rRabTWXoKnH75qmgo2?=
 =?us-ascii?Q?LFBiT7S03JEO6EectR7YOHj9mSqzPGh9kyuQ4Etms3C011gRYYtrSi5rBLhA?=
 =?us-ascii?Q?ArxvB4ee4kw1TZ1kxyCen46hXqiu7QNWTHObDQ9JxkmijoL3bwVphXoVDZvM?=
 =?us-ascii?Q?oQzd09zHyooXZGXDIjH8HQ/pzWpBLDLd0l8+9HWWaOAXoMVDG5ZahvsZUMjE?=
 =?us-ascii?Q?YPFtdEb8dflQR5dzoIwbIvmd4lZQtfsxyjU87lhlAj9riC6h1pnNSgLCUJQ7?=
 =?us-ascii?Q?BFPLLe4H81h5SvFgO68UlVGcGwOuFA6dUNYdEm72XX10NzB88XTIh/xgu4Rj?=
 =?us-ascii?Q?pqI71tmC6XdAbo6qGkINt+2Hi/UlONME72MNL2S+LTMVWPWIlG4hH1oE0A+Q?=
 =?us-ascii?Q?+ld4Yje3cChfGMN2LWWbs7HFMJrweEMRXg+hCi0u3YVBf/7pRrIoznMaeAoP?=
 =?us-ascii?Q?zNoSnPqIv2Qm3ePxFxNAghlIa8pNE4KxHwVewUVxpeKtonTVeXRpOC6AzExX?=
 =?us-ascii?Q?1rkPkze2LjrgG7Vw5KQPeIhJVKxnushBOFK9BqISi3q4e3gn3saAVnz4SXZS?=
 =?us-ascii?Q?NwYwo6f/XDxHjAr/6HyP8SYiOAT9ZiW4Smvb2DPLJBptsv/+VE+8qqlNOnqB?=
 =?us-ascii?Q?77S6P7DcGmokiwgH2D9MuCQAek+lWdmuuX56O8lU2nRDooW4kZAHXMbI3In/?=
 =?us-ascii?Q?+s69O46QQaKsyDPbLdeQzkPf9Um4pqXeaOk2wTvSmVlNsl9W5Pn3XHXb5tDb?=
 =?us-ascii?Q?HpRaG3F/sP2ksVplphk4gkBIe9xaFC2jdVKtZkdfpfwJFkkIfFOGFK680GtV?=
 =?us-ascii?Q?Eklf67grJ5LQ3ZCPXZgFqp5uDHnyqDw7PW4chPnmzQ73YuwXexCUKIqBZ3ho?=
 =?us-ascii?Q?0rbt5S4pVsdVLa9pd3WLboYtiU+4S9derdu4HSPJzQRSKC1y7w1hEOol6Wyf?=
 =?us-ascii?Q?R1zJ9s8BJby8ws236QFUTxEu3nanFrpbD57K+sdgtXjf0J3MbFMCc5nYKIhw?=
 =?us-ascii?Q?S+w3wCbWO89xIN+cepCHHvLsmTWGgz+hbaJeEFzeY4H9W5KvUAgoURjH+vkt?=
 =?us-ascii?Q?5POoKpAlWVoxONQ9SVjtHig9pdMmO5Fa7x/sXLGyCjplwaXaUeHdazH8cHUw?=
 =?us-ascii?Q?U2k+HTXYYz4DZejkdgrWO2mI6SGveW3MpLWM7eRacZ26YBA9DWNfbM1H/uIh?=
 =?us-ascii?Q?lG4oIOvfdaWkwd8REDoJuHVvJk9/GGQMIs/KyEt+mPTBFYGgO4U/IQZ9bnwV?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ee8897-28e3-4003-7398-08da74a58b75
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 16:39:18.5440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00VUTnEaOTi5TKFyWnyh9XFJSmhGq2iChRBD/9mFlTzfHLcBolCCiJ+ScsjkMr8NbLyz7C3pTAt5I30XfvSpXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3555
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setting of RS485 RTS polarity is inverse in the current driver.

When the property of 'rs485-rts-active-low' is enabled in the dts node,
the RTS signal should be LOW during sending. Otherwise, if there is no
such a property, the RTS should be HIGH during sending.

Signed-off-by: Nicolas Diaz <nicolas.diaz@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index afa0f941c862f..abc3a3674bc39 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1394,9 +1394,9 @@ static int lpuart_config_rs485(struct uart_port *port, struct ktermios *termios,
 		 * Note: UART is assumed to be active high.
 		 */
 		if (rs485->flags & SER_RS485_RTS_ON_SEND)
-			modem &= ~UARTMODEM_TXRTSPOL;
-		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
 			modem |= UARTMODEM_TXRTSPOL;
+		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
+			modem &= ~UARTMODEM_TXRTSPOL;
 	}
 
 	writeb(modem, sport->port.membase + UARTMODEM);
-- 
2.25.1

