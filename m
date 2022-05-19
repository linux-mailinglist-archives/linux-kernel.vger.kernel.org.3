Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2352D74B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbiESPT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbiESPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:19:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2080.outbound.protection.outlook.com [40.92.107.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB36D65434;
        Thu, 19 May 2022 08:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OARyiAc73FyllKsEtX8kn7Sr+l4WKXheMb0OJLHUMXOmcjipdRNHnRDfW0oOfqNlsIrVY5tm4+pjmXiy+fGA9J/5Pjh+TAq21ZFcr87ppDBABCYUPkZXo59N4O4Ci1UjABl6n0u8vresKB1yILw9wKVfaqj8W+mB6Jh7sH1kR0zj4SUDcaRWJALXxuXEeGobd1OZE7dgB8FY94ZWdEpW23pS4s2+/Ohd7lzJgchVZ2rA74yRSuOvyCKI6AbiRShSB6w62J3v4CUJQnc+fEqw0IryXmXO2w6O8Y9hWDGxzDpG6IR9ZICdqfBDIlaqrL8JBgNEgLKsSQ9caYBHYousdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+te9G9Xg9Msijh3yMdbEm0F4ZljIQ+AP4q9dHpEh7k=;
 b=UlZOSMDU/ItYFhlXqS49qOMQ/uJ3kBoPu3OPrazjGlGvJt3TDpEPqMYP8BvQAsDxJkBV5IBmj4dpZHjgOzxrEuggWAqPCGn58Pr/+IExNC2s2TiyA3CkgBjJnWTlpmI0mboXuKXDvxHpKZKQBAXwlFcnbHBrTTcJXex7vPCU0zZgEGM5L5TNgOPDaFHez1h7P7OQKapMMNODuX3/rczyjB3rqWcYx+8syF7Iv1Q3OYof4cv4/hvb2yTNPebQImdPNxfvjcrJo1xLq3IWAjzu7/ZMnMQCUhz2F1NeIxPpTCZKPP9UJ2B6IzH/2kwyIwr4WgcRcgCO6joQ1LuLjo7cfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+te9G9Xg9Msijh3yMdbEm0F4ZljIQ+AP4q9dHpEh7k=;
 b=P7uTxjKLU4nWvRyPX8o/YUQzD/N0vEltcAu4qgiIL1dR2+V8Gpr16DbuezXqSDruZGbClZLCJYk6xpkL2q597NxkV08obsR/856AK4LQ2uxXoT33+aIRFsr4EGLfJ67naSWVLcaErkkDlgoExMgN+SzWTMNl5/wOYKUrLyEM8XygDWw7MfAQjO1J/LV0nOY9WcaCFqx0vGAi8RZlB3FjC+tAPeR29iCR68Z0wnB7nHTj93HvNuhzKGGYjR9bTRRZ5dn8GkIlrlSRW7Cp7r3IcTDLIxaF8KSWve05BnL3e8qr5B3t/tRMuboOic+m5Lj6vBqmpe64XKKuxfJYA1Qqig==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by SG2PR01MB2887.apcprd01.prod.exchangelabs.com
 (2603:1096:4:3e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 15:19:16 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 15:19:16 +0000
Message-ID: <HK0PR01MB2801E37A01C96911653AA65DF8D09@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
Subject: [PATCH 3/3] USB / dwc3: Fix typos in Kconfig
From:   Kushagra Verma <kushagra765@outlook.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 20:49:10 +0530
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
X-TMN:  [5geVuGTe+HaWZ1csIa1z3OtIlQ91bjZV/5bFOyam+NhUbp2LXVWstiE0W/RyC6jxPd1Gjd2a584=]
X-ClientProxiedBy: BM1PR0101CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::34) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <692366c1e30602d141b201718a665546a16f9e57.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d59d0d53-57ac-4e23-698f-08da39aaefdc
X-MS-TrafficTypeDiagnostic: SG2PR01MB2887:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQaspQ9krHdy9Xuja/yjFt2DxHFqbotsVGTEoClNz9YNIInfwa8bt77vAyce/GaTPwnLN8NuwhCzGorLrdsvMOS0cpMt/wcse6QoRDB70QCnO/jojJiEWJSpRPja39Naq4rx5ZHygCsGuPv0R+as7jFLSyUKe55F9oIIbg1wb/4ME+LUkAoTHQwYcmGClIvoQ7dvDyQT/dIPPm6xckXzSLpcWBKRioJE0KEgVCd/83Q4sbWhGsCiVhrnUhBbF4ThlmkMV/tqfHvW+LFjeILHXO12yyeIrz9PkHUIu+qfinxCDv4V0kaaHVfvL3WNXTZEGrSzp4e+s9PpfOo7eKxNQSZghdeBMs20hQML8zUKXHUwWagUJWStljLG4jB7mx5558pnU5psJ3UDafKfi6ks7UkHmC5l71KaoO/rf3EXxbDsSFdZ+tj5HtaEPwze4xPjvfT+OLmgVFqYZ+B8IAmPgr+xZywS9p2FvRGsc1RD2iMrZDJi2RTrJchvglOpPmQrvv2FYSo8OOH+Qw+s/60tGh6Puh6wWDdZKDR3k+MDXpdkILoa8kpjZAxq6r48eP+Zo8ZZbRshui9d2k+XgI+4qQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US82ZDJtNndkbGRxVDZTQlJMTzFnbzJ1Uk5TYlJyZDZqcHJ0MmQ3RUtHYlpB?=
 =?utf-8?B?TTR6YldGazIvZkkySDNHQi9OYUZMVXVBbEpSNUNqRzJnMjBLNGdLSTNvS0d2?=
 =?utf-8?B?TXZaL2VMQUV1VWdiVFEwbkE3am9zdkdWelVRYThac2NEbXF6TXl5YytjbDBY?=
 =?utf-8?B?VTdqSGYrY0x1eDk5aHRYRWoxbmhZd1ZTNjFCcGIvM2hMUnhwRzdEVkZoM2cx?=
 =?utf-8?B?aWZ1b25TUEtPU1pEaTFmR2lveW1HQTZ3ek1SZ1YvV1BXZ0s4bHFoR21YdzBy?=
 =?utf-8?B?MHZJMWYzb1FUbERTYmFrbCszSDNBZ3VYTXpVYnR4S0lRa0o1N3FvYjliM3I3?=
 =?utf-8?B?ZkVUUkZnbTZmNnZHUWRQZFg4Kzh4S21pRkM2MmVSQjFBdDBaOUhKQVFydGVs?=
 =?utf-8?B?a0Q2b2tIYTRvM01kVzFiQkhxWlZNRlFmN3BhOEFSejFNZElUNGNsOG5FbDUr?=
 =?utf-8?B?R00zSHRHOWlyc2VLYkhWR01aRE55Qm1NRW9GQjk0RWd3UHM1NDYwZUVtUkxB?=
 =?utf-8?B?dHpiYzU2ZFJMcFJUSUVFNGRqZkRXcGVzTFFLcUoyWitEUTJMWmR2cGhKTmNs?=
 =?utf-8?B?Wk1GVnd0ZnFRUzE3a1FOa2I2djEwN1ZLZlhjd05RdUdIR2lvV1VwS2dyWFlS?=
 =?utf-8?B?b1M3a21YMm1TT2FOSjdnaVFRN1RUSmMzVFc3S1I4OFgrY0FhMW13Y3o1cHdu?=
 =?utf-8?B?RERNczE4YXp5WVVNTGFLeFJaQ3I2OFdsbVYxNGFlUk9xUkRZVXE1ZVRHcHB1?=
 =?utf-8?B?RUU0REI1MEhiYngyNCtSNFhibWNSSHJMclk4aTJkdU9xRGsvLzZKRzVrQktn?=
 =?utf-8?B?U1pSUy9CdjQzQkJCU09sa1A5WkUzS0hpTnhlcnU3TXRUSmE3aXRqQ2h2Nzk4?=
 =?utf-8?B?OERoUmpQOVdIcUVZaU1CVzNvOXJSenhDOVRTM1d4enBvMFZwcDhtVnFVS2dz?=
 =?utf-8?B?NDFiQ3FUditZaW9rT1JDRUJVR25aR3d4K3YzRjJPVFNLREVkQVZHZWxueXVX?=
 =?utf-8?B?aUhiOXNvWVlGaGg2SWcwRkZzSGNpaGpEQU82UlNyMmRBdDN5T0lLeGR2MnZ1?=
 =?utf-8?B?YjJVNXpvZUszalBZRWFlN3FPaVlzTGtRRnNjNU56b0V2ZjJQbmlQWUFHemdE?=
 =?utf-8?B?b0NTSGtKSHZEWnNVekFhZ2hjcmR2T1BKVERmaU8rLzZrOHVTcUVzTHM0TWkw?=
 =?utf-8?B?eFNaZmNLSDEyOVZuUEZXRHd1S0hKMi84TnlYN0FDMEJLaW1BbVFyYXdRZWdZ?=
 =?utf-8?B?dWgzdnJPSWtqekthckxleE80TDJVVSszU1EvM2l3TmJzSjFnUUcyYmoxN2pS?=
 =?utf-8?B?ZE5FU3BIekVTZGRDak9WNmNZUk9rcmkyd2JOeEMzL0NJSzdCU21XeTMxMkV1?=
 =?utf-8?B?YXRHdFpsK3RPS1F4cUR5aU9DenJlbkdDVGtybXAvUFFodEsveU9tRnU4cWdq?=
 =?utf-8?B?WEI0d3VMQ25ZbTZSb2xqbWNIY1V4WTFiVXN1VTVyaHgzeFFyR2RBU1dRenNW?=
 =?utf-8?B?VzNhN29rUFpza0czSXhBR1N3dXRCTEtSMHNTUmc2VS9OdmtVZVJYeUszamVo?=
 =?utf-8?B?NnIrajNvd2lSMjBXNzBkQVo4YTBkeENyS21QTmFSSjVwUEdWQjk5WUE4YlBL?=
 =?utf-8?B?dmQzL3FQbGhjUzBLdmtLNk5Db0dTUEp4WG40dmhNcFUxZTY3MTV2cXpJaUFS?=
 =?utf-8?B?WGZqeXJ1aHdQN0F6UEFoUmNhWXQydE9pVWU2MXQrczdsWFR5bnllQlNkTWhQ?=
 =?utf-8?B?amtGTUs2dGI0SWFCSUFyUnZMS1dTOExhaUVsQlgzT2UvSnJYRzJ3cHF6YlV0?=
 =?utf-8?B?M3lSK2kwWHFXcDZUYXVKNnovUjFZRHdDWkRFeE9PVDRjVGg1eU5GenVaV0RQ?=
 =?utf-8?B?RUR4SGpyQ2Q1Nmlsbng0RGdrUFFRL3VDWVYxaGQrS09uZlM3QW56UFZROFBx?=
 =?utf-8?B?Q2lORW1wU0dZalhtdU9YNktZUFQ5Q0RCMTY0RUEyeGtHMkxnR0d3UzltR09V?=
 =?utf-8?B?emNNeFJ0U1dKU2RYVkI2SGtIaEtGNC9LbGRmc1UxWCtBNkNYRDN0YzdGSk1W?=
 =?utf-8?Q?LJMdEo?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59d0d53-57ac-4e23-698f-08da39aaefdc
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 15:19:15.9644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2887
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following 2 typos in Kconfig:
	1. is -> as
	2. progammed -> programmed

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index cd9a734522a7..03ededa86da1 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -9,7 +9,7 @@ config USB_DWC3
 	  Say Y or M here if your system has a Dual Role SuperSpeed
 	  USB controller based on the DesignWare USB3 IP Core.
=20
-	  If you choose to build this driver is a dynamically linked
+	  If you choose to build this driver as a dynamically linked
 	  module, the module will be called dwc3.ko.
=20
 if USB_DWC3
@@ -165,7 +165,7 @@ config USB_DWC3_AM62
 	default USB_DWC3
 	help
 	  Support TI's AM62 platforms with DesignWare Core USB3 IP.
-	  The Designware Core USB3 IP is progammed to operate in
+	  The Designware Core USB3 IP is programmed to operate in
 	  in USB 2.0 mode only.
 	  Say 'Y' or 'M' here if you have one such device
 endif
--=20
2.36.1


