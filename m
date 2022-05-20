Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3874752EBA8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349063AbiETMLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349035AbiETMLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:11:30 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2061.outbound.protection.outlook.com [40.92.53.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D3914640B;
        Fri, 20 May 2022 05:11:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlGUc5sDIpbmbMZNQaNRtKHeQG5hS5A5P6j75jPmPmS206XycieV6vcwcXqCePkdzwJ6TCxGP7VMOgAbcgADMtsICELZ3a+BmFVdkwjtaP4JEhrNUMvcptiX3d47rLj457wtOBDmoBk5wySUU3MJUX96TibHjkJzBdgxyBW2ZsUb5ndUcWIV2Fw/hQ6y32EZIHMW6g9tjO94yh4eqPlR57SjeKlFftS+SS1eMVyNZAXLFrdL59GbY/idit9nEwvvcBoymF5ZE6SucB5CkjdlNW1jbJtzY3cMx6pBHdJFd/9LUCdP9Qgh2YZ4+GsYjNDrklICuLmXLU2HhmQJ2uhVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDSy1FVSdamf9xS4CkrUCcpHSx04Z9aII9Am2RuteqM=;
 b=jCfw9qUHTueglxQQq6DPI0IiUU+3ohYOF2w2fiRYcAf2dVx7IlQFxD3LUcnJ1cEDUdw/KOxykF0H7PZBeIZc87hkVQ4/j1m22CyoVmA8J3357kSD8MxHThoj4e1hoki/XWUtbcDfQGiY1fK8uHUAma9vRcPnb+/EI43+cXwJ2iJW50b38aCnDTlL7dTPUIWGQm1z/geU0OghFs4uARTbHsmWRb9uJQNxvjGRUXKU7ayzbWXzhhLxSkw06+1YL6UYp4Vo2v191ZlSiIDIpqD41hi+iJSjJZ2OwDivZGwxEbebFr+0it6A+T9eK0jh7xMc5PVIZ6MA+dVunZ+OV5ufQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDSy1FVSdamf9xS4CkrUCcpHSx04Z9aII9Am2RuteqM=;
 b=JgS+HiMeLsbtNahJGk9WddpfliML6ZbRRwgQCyMZNBv2Az0l2hebWxH4COENpHhKgDt4dirFzXcljMuWVk4Qr98QGPXeueVHPdJrkLTVdhIWCBMq+Q7ynALjUFKnBFpVfazytWiiwFhpumtH27XpbeWU32w90hccGudy720UsWoaYcn+xqlxksEBgHWsW9qjITsITPgifKKgO94bwNgHTFrDO/G5n41OrhQNyBBRJ6qaLnP/EYsF0YNscF9GVc9mJ8DScDKNGKecuJBkHjwfBJMqXQMv+/PB+YDC/w1BF+Ap28N+YbFMpgNXPkOpE9RQyQTc6/EtxluiopOm8i85xA==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by PU1PR01MB2092.apcprd01.prod.exchangelabs.com
 (2603:1096:803:1a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 12:11:24 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 12:11:24 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] usb: dwc3: Fix typos in Kconfig
Date:   Fri, 20 May 2022 17:40:47 +0530
Message-ID: <HK0PR01MB280151A3B2CF6C3E4DC2F9CAF8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520121047.21026-1-kushagra765@outlook.com>
References: <20220520121047.21026-1-kushagra765@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [XeE+x55oQAE4zxB4d2kEBcImUvxvk2a09gxwNxhiNZeai2+4j3vjGYCwGU2dKCqY]
X-ClientProxiedBy: BM1PR0101CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::12) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20220520121047.21026-4-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c6085aa-5b6c-4e3f-215e-08da3a59dc0c
X-MS-TrafficTypeDiagnostic: PU1PR01MB2092:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ZAfjpf0fTCqZgMeb8hJplg9KwXS2n1TC3ns1WrNJNtl9VDWxRCENJ2MVwNpGIb+lJAUVR1mjIpBd/L00ALPXKsQcRxXsphVRrfNXbgTfoifGoZT9qCunj445iK2FoTvK9T+tCORiyynOhb9o2afL95tQwrrX13+xRMFhm8IH7zJuocxfueb4ta7KEKO5AcaUs6VLRtQhNuuS8QxMG0re9/qLaG12RfO6Hw7VmXBwsyCrexZrkvyj/4K+TKCFU0CX1KAwA+po7YaN72Uf9mGBuga4XgvpJBRRca6BJbdegUZFuBksC8qxs66Pti4ruSKT3D1mkUEWQRojNhTAw3mU2W5Zro5VJlpEIBICcSYpGy4cjQGtfnvrkOUT9x1/CsCXT4KqPyj7QS4WoNbJA9sGLIYm1ldjALDvvrqpNH+KHYIKROkFFsakSdVs2xEBGybueAuqIqQEYQqfhj/iufaCV4y1cpgYfG+yQF4l10lfHF43CAnAAp2MAn6xlePAPLdGb622BR8B5KtqJmvOeEXTTVWCZIVl/DkW50Q4z4IpTUHRqzuyBcQuhfU+TGDoaibDN71q/jG6zQN2hmzWmVE7g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uqwojKt5NmOE5qaDI1uuKBAog1SRgEXenatJXtVCTnH6fnUjDFCz7kmhl3gG?=
 =?us-ascii?Q?g6t7/UhP0H+a4IxA8nRQUEoHRCyIPJa9rQVVcJdAitzuUgfBxNCNisXiPfGP?=
 =?us-ascii?Q?u8GJGicHvDFPSfYwvMb3AP8Kjw0rUoZVmN16RY4HWlr/Dy2qGzbi/22HcrIV?=
 =?us-ascii?Q?9SvjlfW42EcWoTf66B77bsrTGkrImet5Ng1NhlPJZNBbndh86ivFDN2XqCIo?=
 =?us-ascii?Q?2YztQH6oAimg9H+uE/GFo7/oZAsPdCdpOIYw4WBk7riv+rZc+8Ps3bdSqrgv?=
 =?us-ascii?Q?dtjXZilcmbCVf/CemZt3Fv4Rx6bP6SyNNd7nct43MYuouPU1Qp918h4kWdGN?=
 =?us-ascii?Q?0v7W4vZq1ZxZCLE828kFnr4KQY+YRg6vUW7+ooAwnun77H3vpbOR58WG0kgu?=
 =?us-ascii?Q?grr0jOuT7z/egZ6x7TNT3RcF6HZKBAkw4n70SDugUxFOqXI7Z+PXvzWl6JaR?=
 =?us-ascii?Q?hva6Lm/sLjX/8NMfFWMZFvIa8TrxvFoE9euQ44OMFzWOCOiUA6u7PKNv4OQ2?=
 =?us-ascii?Q?aVfwHrxOVSvPijg82BUK84s1k3+/nGlUmV+XoqFVd5VPahvTEHetfew8dYax?=
 =?us-ascii?Q?9LPu4WAYJGqgQBG7+GHiZG764aI4A0ZPu+lRMs7PgelfcymQnPfFC9ilImwH?=
 =?us-ascii?Q?s3dqkz9/9GAmtNXD4TSRYvODlkc6Q69CGhS5O9Pa8IUBpXmK9mQeSz6uLEdK?=
 =?us-ascii?Q?q69H+Sgcwg14Z3xRgOA0mBsmwWYZzn12vzYeILp8aLwNO3SZ/uGW98S1+czm?=
 =?us-ascii?Q?H9hzInxMN0sJvFsPAPkMGRY4OM3hf125gjRhnavMKP+th4045xZej3ZmemFs?=
 =?us-ascii?Q?KYG92UPEORu/USNl3Nrhns1AJtgXoYn64r66UOlUnUOntcY5PchtveeeAlZH?=
 =?us-ascii?Q?t1TCblpnYq52TValrWGYBIuAngc99cRM64Usti9du3G1PxPbS/fKMTICtjGv?=
 =?us-ascii?Q?g/hgeNfGERLt0LX9KwCvV6dgnB1szCUt2927Pc/Ro42YCGsZQQ+Ou/WSyFLN?=
 =?us-ascii?Q?21Hkm3w+LA4u4GXz2nvaaXE5gG3/LhO94Htlinjwl+DgI+mEvd2KaIY3pmmS?=
 =?us-ascii?Q?NZEOn5c0O2UOrtWuOE8+NlIZ+F/Ue5cGBL2rJRcIH+Gq1duN+3DBMA2+QLx+?=
 =?us-ascii?Q?ID7PyqD5vcX8tBWjcz7N41PFUFxM5G3NzDVL1RmEQ00R8mJ7+bTKtp3ga0oz?=
 =?us-ascii?Q?uzgNAIekRm6e4O3paJES8f/ewtqzcMlTjPa625CXpbR27v43ffu6LTgPK16a?=
 =?us-ascii?Q?0vfUQbZfgCQdJw4m6L9ZHLh1ru4MOKH3b9xbyl8/aLT5H5iplD/ePFNtvSWt?=
 =?us-ascii?Q?SLZRplsEKAGJkJ3A1RBvrED3XbGMmhvWL0jEnEbwQXhZDsGWidKokWl4yxi9?=
 =?us-ascii?Q?U4vRfUh3jKGmTNsCfsfLBw27izDOnbSi4rKWOdNSucl/0iJ/tkyhw7YU3ASd?=
 =?us-ascii?Q?gh6Mwu/+1m8rmQwZ8xW9rwVB1gXx1eT5xCq730a9Q3FtpjwGugI043Bl1/2z?=
 =?us-ascii?Q?IYZ/WPMLwGtAf819gnDYE0hS+SL2duamSho4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6085aa-5b6c-4e3f-215e-08da3a59dc0c
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 12:11:24.7910
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

Fixes the following 2 typos in Kconfig:
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
 
-	  If you choose to build this driver is a dynamically linked
+	  If you choose to build this driver as a dynamically linked
 	  module, the module will be called dwc3.ko.
 
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
-- 
2.36.1

