Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC8A554AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353412AbiFVNSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbiFVNSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:18:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2031.outbound.protection.outlook.com [40.92.52.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AE7248C9;
        Wed, 22 Jun 2022 06:18:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cqu/mlpp1eRYt1Fgl7LhQxSDoKOaEn4syGaWERhRbNKqvbD6YuJJnvrytgGdLx6n/YLdgF7MbVmrna9lgw9cP/1WJu0Ux4D/uMlWVb0tco5mRzTa8w2dCqJaWf+KpXgcz0xlR7bBF0KA1okhPvF6iF+YpdsytOD3DYb+STI3ux4LiAo7Z7LQBPXLg4VIiH3Tim9Vlfag+WHUdmjl7sZoSA7NiJTD/xnoc39fT55VNU8/E66TO98Vlg3u1ipJs0sMaR+4P54zW0khhV3yH9IYAqHaFT5SGeNZ7Ry9EBPJgia4nzubv0Wvd7MmMZx/Cio+b7JcmHMP0bOKM8yCuEVGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOZjP84hudn6rujTEHm3D3MWh2lcrzW3JP9RUlNWoxg=;
 b=QsDbSr9cUG87WjgAjDOl7rIjXxJJAp+RL0IwNyn+1/sGqXiTekCLDyfad9XU1HqFkkGSLDd2f+/7HekyYbL6NEBDBjs/ykygVQkXNX1xenBKgHpWXRTng3++UF/sJ7ed4wCd1uWwT9JBeWZo/VChR935wOxlLq+Jh09wCyovECsWMXQkolqmF+gc2NFNxWQZxbIpTRpVliHKvTCSN0bD72VPeDeMDQRVpNLuqmUc7rrzrn1wY38pBAFT2gxTqxasbydMYJ8Vtec3X7PCipvxsvxR7VgQB3mAU20ZwyerGzObhFeGKxPNCG6E2z86iIqISNEJOQbpvplwSc44So/u4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOZjP84hudn6rujTEHm3D3MWh2lcrzW3JP9RUlNWoxg=;
 b=p9Pap3HksM7EBH+EykgjDBJUHzRdGN9GdS7QA70PU7Ni7jYohKUp2qfW59T+nB09loEPOjvPqyLUNF8xh8Iv8B6asFk9FHxGCpdICa7ABouMe8RtVPwderHSBqPE+OYJuLiI9DA5P51rJd41GHBj0nKBHnYbUBY571I5wiAtFi1HHSTAwv+jhuu1f2CxdYYUMdlBRkRxEw0sdeXifuFILoAJi8AOYdY1e1BtxDgYMkCqTUdnRi/cz56XSlfoRL7H1bKaNfgkwQkNnm1VpNVWjeCYpiw/mV2HxfnzS+zdzINYvOqxyBErjLFTuuGOA9SjdSlh47MgFbfHEz58Q/p2YA==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by HK0PR01MB2067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:28::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 13:18:17 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::a54b:32a8:b605:90d8]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::a54b:32a8:b605:90d8%3]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 13:18:17 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: serial: ark3116: Fix bare use of 'unsigned' checkpatch warning
Date:   Wed, 22 Jun 2022 18:47:50 +0530
Message-ID: <HK0PR01MB2801789671F56BDA8DA12A83F8B29@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [hw3oWh1ryZLIm/mX/dKiW+poXLNzoD2N]
X-ClientProxiedBy: BMXP287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::15) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20220622131750.17945-1-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b3c3e8a-b6a8-4646-c2f5-08da5451ab37
X-MS-TrafficTypeDiagnostic: HK0PR01MB2067:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFjPCMgHKWBM7+mN/CLjOddKVhdTBvoipXjfxOX1rGBr6cYsYyEN0yAoTxTgpyZo3lWUDL5t6++DyhPhonVgog/j0RVtpMw2gGmAHowzilT+EZ55Jkoygzb/MJ7WB94lNqePONPM1lWDOs9ftL8LYgta9kkgaVU86J9kSqXrHqZSOXnUyfQSTf2xYu7CdO4mVz/eb7J0Nx8So8sO9DjQx+yJry2OnF4RQ5r49hs8NueSj1QGi3RtlgES6OmwBNs/TPQw6lZCp+h1svS9XPE65T+rDglUEVgf3SgB1SVHNeCa2N1zQwhV2JBNwG8bJuX1stHYBMhxy+SIUnmRHd2asefjN1KOaPm4ybu7i+XACD7LUWOC8Q6O1RPVrxDrvFVRaypvS7FibGo9XwyBwUs+WSKfEKaCvgxcLvDP8MPTzOIL7lnyRsbbo6i/rRAP3lyp7j/cKEZTu8lfBb2NRRCZNtO4W9Y4OcCyfwf4KGDZUt/8d/YKL4F394CRJeiJ0lxaz0RAMeHzG0n465gNKSkERFarjHuygE9nNfCEVD8QT/4oo1gfeztxSsBuZxU1PryDmTAiq61yfRY4kfp0Kwlht8cTqmjuv3c62fZc6IrAskOxSuzjHavbafAmmFdUrX7L
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BHlquWnXV0S00s6AU+E3jPhoezUGFo+Fj5Heu1sOctGjdcwK6+u2qMI/slUH?=
 =?us-ascii?Q?hBPeFMx/CycLTtlzhjet7+w4eZ7IzH7mxQV452vKmhN2nFwzs2uyB+77sqS7?=
 =?us-ascii?Q?TH34MvjLWNOZATGB6s8Ot+gesE5Un/qjdcO0IxUMhNI3lpJJRReOq2THIRNv?=
 =?us-ascii?Q?Uuva3F6XmUHHoA3jRFUhIDRzHE/pl6/lKU7Te1wo8fFPa5kX19AkqhwUd5Lq?=
 =?us-ascii?Q?XM6Dro0rI9efkVeWBsnFhSqFesE0eUrp9oRRFTozAABanNbyvzMdERbBf2PI?=
 =?us-ascii?Q?Di5j8flOu87hAtZSZ0c6IknbfbYPXb/GSo5drGjk6silwLKC+Em31GNIDMaS?=
 =?us-ascii?Q?68bPjhvMfLMk3tpr7SouO5frshORNy1piTDvgi2ROwlgAVd8Cp5urSuuSHcd?=
 =?us-ascii?Q?hMyfsjPqcay7qjx5MKX1/qNbqvMTriV9h5vXMAHdT5bqUDVkPXxtRARg/s2/?=
 =?us-ascii?Q?Vk8ReXVJO8xCvuMWUkqAM9/KzTjPwE6+afXrlqPVYaIPRRGGSOQvwFmAVW52?=
 =?us-ascii?Q?ujhj5bB4ritBpmVysCc+suLknUwddiREkRS7+RCe49n+WMYT2EVdt0S9kiDP?=
 =?us-ascii?Q?eC1QrPaJLW3bTlXx1L4oDo2rXMZLLl4ic+c9z14ss7raowWd8i+T8GuiJr4t?=
 =?us-ascii?Q?WCKaVkoimFDrFveVkoCm+IwXpn/DZn5xG+VK6IEljD4yNJqhs5CS4CE+Crpo?=
 =?us-ascii?Q?O/E4eQMaS0KU557hmWrmAIXSnab4Mfi4t9pGGYoedR27jt2ex6fFw/mnEsMo?=
 =?us-ascii?Q?7EHExY/kmM7wH5mOYBX3NHw2QDJl0/HN4OtLA95pRQHZpY4mnf7ahrrzMv9n?=
 =?us-ascii?Q?0qqedd/lj8GoF/gB532V8+g3EHkdTUtHUIUa1ZWhyjqoxnE+UbWsHNAvDolx?=
 =?us-ascii?Q?Bhwc1Euz5eJb4zQeXA2FVqJOLWh8ErcYgotIM+DcKXzxRWgsBC543hYhMOAd?=
 =?us-ascii?Q?4yyS8Yx90lxoBHGJ7GlDB3Ab7Z6vAhnI942sjdIGVMqGNiZVzqw18cyZEdDP?=
 =?us-ascii?Q?E1CLKkzWxVL6TMwKiGfHhgcVSvR6i/4IHiF+Ht/aKLf7uNgLT8ohU//rVjYM?=
 =?us-ascii?Q?5Iii+p03HL/bqWOJ0yQ2/MgaAbpjn/6I3yo4Y7Yl/eFtS7rPHqpnd2DS6lM1?=
 =?us-ascii?Q?yZdmWjmEWFjOba3INBzchFtfUw8Czz786AQ5rMSN+IrO1bvXkExX+ianYDM/?=
 =?us-ascii?Q?1SO4KEcK8dWsyWsTVNMTTJBsz74+2YP6YLNlDNBeSVIKkm8qe6cXuf9OV+N2?=
 =?us-ascii?Q?vIKvBt9i6wg1Qq5cOhaxoCAmw2hlEQsPVh0A5XR6jiRLuMKh3x9NrAKprHEZ?=
 =?us-ascii?Q?EXZ1j3WDHZN2ysCYX2wP9yDDyxZJgh6e1UgTdh1HLvb9nJUwlaKAgDr5fCCJ?=
 =?us-ascii?Q?/Wtp27jHQVAGV/NZVqqgfH9iOcPTvhkZYGVU8NkyuK5icnXpWFYp1qS6Gffo?=
 =?us-ascii?Q?zo3IifN6Yx5+SXccXH78Lsplxjr6ecvZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3c3e8a-b6a8-4646-c2f5-08da5451ab37
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 13:18:17.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2067
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

Fixes the bare use of 'unsigned' checkpatch warning by changing 'unsigned'
to 'unsigned int'.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/serial/ark3116.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 39eaa7b97c40..6632f4280bbd 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -75,7 +75,7 @@ struct ark3116_private {
 };
 
 static int ark3116_write_reg(struct usb_serial *serial,
-			     unsigned reg, __u8 val)
+			     unsigned int reg, __u8 val)
 {
 	int result;
 	 /* 0xfe 0x40 are magic values taken from original driver */
@@ -90,7 +90,7 @@ static int ark3116_write_reg(struct usb_serial *serial,
 }
 
 static int ark3116_read_reg(struct usb_serial *serial,
-			    unsigned reg, unsigned char *buf)
+			    unsigned int reg, unsigned char *buf)
 {
 	int result;
 	/* 0xfe 0xc0 are magic values taken from original driver */
@@ -398,7 +398,7 @@ static int ark3116_tiocmget(struct tty_struct *tty)
 }
 
 static int ark3116_tiocmset(struct tty_struct *tty,
-			unsigned set, unsigned clr)
+			unsigned int set, unsigned int clr)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct ark3116_private *priv = usb_get_serial_port_data(port);
-- 
2.36.1

