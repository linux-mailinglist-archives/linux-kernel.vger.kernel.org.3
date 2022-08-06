Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795C258B4AF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbiHFI7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241784AbiHFI7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:59:08 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80100.outbound.protection.outlook.com [40.107.8.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F9A15FEA;
        Sat,  6 Aug 2022 01:59:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilv1HvdpanWk/iaDe82CxXD49o3rAtQbB2b8Lf95HAf056pGym6PLkAcvg6F1xYTuPXqT2fL9johcTA8XDf0YmcTL3ttQrw7U2gaji8UIZ9K2k3P2uWrebUt9p2IPQBabUYe9g1MNeIR/oSnZknmYu2eZHQA3OHA+FBXOA04wgTra/4SeesnnTNB3E+qQJxFaE7Fv41DrUYgx9XeRyAsf42jihXGg0Xn732Zdto5X8me3UHxq7Y4GX5km5cvrD6ykYNFRuNPnM7MO0dBzpnPc1nAEcovPgeu1P60r5kw3mtu5ZtnJw+rYj2Vo8kYKAGQBwh7Tt5o2jX9eTJszPJ5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kHQuj8PDJ4RrbvhlWpsqwj5rkMsjcCX46Hp2wNjS5k=;
 b=Jhjd8ZZuwF9wTAAN2WHF1qEghieWwOzoAY9Chu46qy2BzP3o5iUmm/ZfW7eLATTPX92nZfgCX91gW+0qvcYTQRhz1Wv8xORAZSM+V8nuC4S9lnXrDUcjX5ziGOw7kGZ4bk/g4DxVVA3ySe+qtnR0VZq14XXLqq10Q//jurdLoKpBYIN0+HUwbhx2ncxh/rZtl+0R9v5MzNNLTSWe+klHZ2nwGBDbMql400fQ2kNMSrofFZrS+U2Pp5skDpiLATyAvSbUCKcS091lVvkojkK0ATi3kBnnS4Sor/WPkXqZkQHFkg8GtnWERyh5BUrW7rEsQ14y5JXYVaADew1FlvpL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kHQuj8PDJ4RrbvhlWpsqwj5rkMsjcCX46Hp2wNjS5k=;
 b=g2HB5n887tvUEQkUVzO78iHc11a7yn39R9mtpDfEW4/oVx32vMo6iBV3LRr8ilpgX/NJwEuKXgCI3e7hkcf1Z2CUsR9z8RHgAshZcBIW79PojwXsByGWp5D+UTXceBc27H0YQ55DkWtD01dWCcSIS1qeJyepCtsy0EPrILtABLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DB9P190MB1098.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Sat, 6 Aug
 2022 08:59:00 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::80b1:f2a0:4365:3c59]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::80b1:f2a0:4365:3c59%3]) with mapi id 15.20.5504.014; Sat, 6 Aug 2022
 08:59:00 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH 2/3] mmc: sdhci-xenon: Try to fix 2G address limitation on AC5 SoC
Date:   Sat,  6 Aug 2022 11:58:13 +0300
Message-Id: <20220806085818.9873-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220806085818.9873-1-vadym.kochan@plvision.eu>
References: <20220806085818.9873-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::15) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a235266-0603-4682-e60c-08da7789e782
X-MS-TrafficTypeDiagnostic: DB9P190MB1098:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/JpwaTnrNnYHt2BJkOefnFc4zBMwkXir2owDVoDz7OeKAtulhawuqowawEf5UxNtQLnxF69Uyo08cUtepxYOqu97wpM2hjpR7P+1B95AyyaZ8D+VBy2GGKUZeppge5wqrdIXXMmEyo1uXVy1saQRrZ80lna+jFHSGfeLuScpAaHa7hiBSN7ohB0gaqWDotoYrHqwMZzKs1AAJTs3Iaaz33Td9TJkpShY9FyCXeE2UEHe0rPYKXqUOYtEkbrXp2unF/5xuQmWF5DNZIDWhFcTlBDNLa5wRUNw1MagQBD7TR95rNdJLBfZ88ZxmvwQsr7Tslo5+EW8ZBZHchfQhiJZmFT5d6RB9tGtirHLV7KbSC6N9hJxVO4Y8qEXXrKclqdaGpb1TyNUJdia4RRrwdVW8TzDwgJkfuYggHW3Ywu6CqlypW+lUh2y9gyOOM7CLLjjkjmM1Xw2yoKKN4oUV7KhY/eIik3o3HgKVeE2J2muQTxjrJBCbvg39xkuVP7EKQiccABgUKnYVtCS5Cn/cSUwIiKjOPOJAGzXdJqtweDifLZ/JhzQrBEJHxHXg23XGLHEq0DRo87Ib9HmS0+Qn2+Rf7oea+eQFDKbuMYqXrJ6luWgZW9N/PScTBrwJ+8fwNNyhbP66ts4HPwYAujQvujJ898usYL2vuibLHrw++2UzfQxpxjrBJvALcrCYz9v8pRFfX6qqZoQvzyZk+ieAZ4a2T4jlMpkmSvCU+ejLN1TV15pkwAXsWTspxFKWnRHHK96RObTN+Rzpz4PF28ghEcvFRQa1/85PmiKYwYamaJX74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39830400003)(34036004)(366004)(396003)(44832011)(2906002)(41320700001)(8676002)(66476007)(66556008)(66946007)(4326008)(508600001)(6486002)(316002)(36756003)(110136005)(38100700002)(26005)(41300700001)(52116002)(6666004)(86362001)(6512007)(6506007)(8936002)(5660300002)(38350700002)(1076003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pb1JUNtNYLLQL3VK9cZFgPpskek6uTbj9x+OgDvavBaUtRUOxRm8E2s2XLBn?=
 =?us-ascii?Q?QHIITPI/VVoQcdpwzbcsX8jGqniLkA0KISnUa/zxyc+oAG++gdA7lUbxX/X8?=
 =?us-ascii?Q?Up9y58UvppycM8hCQ8W+wl+GVk+Gq7a8GJxDAmiYkxMZNVTkwSXfUSnbSiFc?=
 =?us-ascii?Q?odQLPC0hTQ0x3MCGdlJk3slIoHXLi2x5gePgLz3kMueT4CwFtho9Ivm3OwOa?=
 =?us-ascii?Q?68XL9jrR7CFtWM/O8C+ECLN4WhDRx2OYiEo1v29QTFhzN4zyrAPdnCTDy8ck?=
 =?us-ascii?Q?j0r6f3Asyx7KxnnGcSWKm39aRfEqycq92Lim3vbJHiUxf7Dd2v09BjtI4EG8?=
 =?us-ascii?Q?DskR3Qu63jciH3iuDpHSUzT4FQFlKrpT6oqJB2AMLazvJosvHomMTi+IJi8M?=
 =?us-ascii?Q?zB7GxY7jZOJxxCXB4YkRgbuX7F6B+aXxDiCj7drFCfZPpfbtOOD4NDuxUBw0?=
 =?us-ascii?Q?WQD9aPsO55NL8ugndZa67TPrIGTiMCp39FoYS4k0DPT2sAoLhAXb4vdhFcUl?=
 =?us-ascii?Q?8NWwHl6PtofEPxnx6kDtOkgrB5HZKVije6aOvlOP8ePXPjf7LEnvzMoJujsn?=
 =?us-ascii?Q?JyAxHm9ur/ARY+4Z8iRfLyjh5DVcGxaHsED2mpCihL1Y6kEXTadZ6gdXafIk?=
 =?us-ascii?Q?azykR3iGEUAiKUzZNDL1NHZSjnHZI6SmibA5s4iQrCRKiDd7CR+ELBrpQFXi?=
 =?us-ascii?Q?KIGvlqcd1sA431yD/XRut8a1594d9wgQmfvKkn/Tgp3eyXwd9MzOSiVn2b4c?=
 =?us-ascii?Q?g7ZNZ02qfrqp0XWyo2ywBUY0Y4ovmcV8l0ZmkwqhN5nIl5Pu0ltQtZiy6QR7?=
 =?us-ascii?Q?RXGivwCKwNJ4Ta3uAeUT8OCaPoiAC+7TQhp6nHlM0sa4+fQqz9ApQgIo09Kj?=
 =?us-ascii?Q?pKuFTXjW3OHQvbylRHs7L34CVrZtnP7H7coA5lCU89XXzVmv1WqwuEwGwtaS?=
 =?us-ascii?Q?4WPM71EkEVHnje5YHyHpWN8TuxulorJRjTgj3GGneMZeOqS0dVK9Ea1+u0wV?=
 =?us-ascii?Q?lowXGAAFgYtlf5K0ws+tZg/LVQ4Su76u9FMG7wFWWQ6XnkIjbvPrd9e2FTwZ?=
 =?us-ascii?Q?dIr3eunFZGMVMhKOlOZDXbhnTJQ8iXSfypjVfhcGGqQWW5isawkdz+A0//8y?=
 =?us-ascii?Q?3N6gTJ5cF+/aAEuo9CLLESEZ8LxOc2YQK/qOluDI1zy4sqZr1CPZBhKLHSXK?=
 =?us-ascii?Q?LoQywy7eUyqCtTK9WOEwXEKlGcugOsrmlWYsjvUPwEB2IvXFFYCEOtYNH/p2?=
 =?us-ascii?Q?jAHIxqYExKQH0YcQV2nnR730h8+O9Kq92VGkzQbN+If4PkdWygdOop3rZWjr?=
 =?us-ascii?Q?igfxzwbcHqKNdhcNiA2tmhp2No7qw2DFAW+HrbZ7brjZkewiWpf5NcW4LUAK?=
 =?us-ascii?Q?xbHJxfrzRR+CWwEKyFtN6mIEIusfLF6GonCnjyG/5CHhvagetqPquBGX9ac6?=
 =?us-ascii?Q?DtNwSGrTTmgpU/u3s+7gqqG+uL/BFFpzrHjEEuwQYiI9Zm0Q20qlVXugyrH6?=
 =?us-ascii?Q?MqW8dRiK6L6uyusPx2HZV+f1K30HFlgKxrLXM0QZfBc5McaRVtwope3Vf2sO?=
 =?us-ascii?Q?taCaBnO0E5XPfrA95rcCvvhOhS6uWf2DlAI8ra9ZLubt2jEnINon5tjn3qe7?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a235266-0603-4682-e60c-08da7789e782
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2022 08:59:00.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liXpON7byGj1dXEQSWqDikjMa1Gm9utYNcYU/J9LpucIC5YnH+miMbcOsH+NRbGCBkpY8gBVDGjPYoMPdMZmdtkfoMkOsNidMQ/6XOewZGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a limitation on AC5 SoC that Xenon SDHC can address only
first 2GB of memory. Turning to the SDMA mode to use the bounce_buffer
causes ext_csd recognition to fail on init.

Using of swiotlb=force also does not help as it is allocated at the
end of the memory.

So it was decided to use reserved-memory as a bounce buffer in case
if the board has more than 2G of memory, or turn on the PIO
mode if such memory region does not exist in the device-tree.

It was tested that this approach is 1.5 times faster than PIO.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/mmc/host/sdhci-xenon.c | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 08e838400b52..fbbd1a045002 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -14,8 +14,10 @@
 #include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 
@@ -486,6 +488,31 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
 	xenon_disable_sdhc(host, sdhc_id);
 }
 
+static int xenon_ac5_probe(struct sdhci_host *host)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	struct sysinfo si;
+	int err;
+
+	si_meminfo(&si);
+
+	if ((si.totalram * si.mem_unit) > SZ_2G) {
+		struct device_node *dma_bounce_np;
+
+		dma_bounce_np = of_parse_phandle(dev->of_node,
+						 "marvell,ac5-sdhci-dma-bounce-pool", 0);
+		err = of_reserved_mem_device_init_by_idx(dev, dma_bounce_np, 0);
+		of_node_put(dma_bounce_np);
+		if (err) {
+			dev_warn(dev, "Disabling DMA because of 2GB DMA access limit and missing DMA bounce region\n");
+			host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+		}
+	}
+
+	return 0;
+}
+
 static int xenon_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
@@ -531,6 +558,12 @@ static int xenon_probe(struct platform_device *pdev)
 			if (err)
 				goto err_clk;
 		}
+
+		if (of_device_is_compatible(dev->of_node, "marvell,ac5-sdhci")) {
+			err = xenon_ac5_probe(host);
+			if (err)
+				goto err_clk_axi;
+		}
 	}
 
 	err = mmc_of_parse(host->mmc);
@@ -570,6 +603,7 @@ static int xenon_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	xenon_sdhc_unprepare(host);
 err_clk_axi:
+	of_reserved_mem_device_release(&pdev->dev);
 	clk_disable_unprepare(priv->axi_clk);
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
@@ -591,6 +625,7 @@ static int xenon_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, 0);
 
 	xenon_sdhc_unprepare(host);
+	of_reserved_mem_device_release(&pdev->dev);
 	clk_disable_unprepare(priv->axi_clk);
 	clk_disable_unprepare(pltfm_host->clk);
 
@@ -682,6 +717,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
 	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
 	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
 	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
+	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AP806},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
-- 
2.17.1

