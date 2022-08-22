Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A6459C1E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiHVOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbiHVOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:45:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0CF24F06
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:45:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h5so12705872wru.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Dgr+R+Ooqj7O8IbEZN3k8kABePugAAeIHX9669QxJ80=;
        b=LXdfeBz4Yy+YTGZJbK0oIjM0jbxrBzTh2JKA8EQRGw5cj7NPVw6DJesIgZzMnzbIUe
         6WhtfX1+IUwKruRgjJCYvq5582adxr7Ldir/qTE7UE+tb6hulPZu9JmMnR+fyY9Bjg1C
         LQ5zeJ5GG1BJxZam5amMZlBnZ8rmsROB7xrRMM9FBINxScP25g3kv3faSjpEQko+Qf9R
         aZ6Ncv6BPWZANYEWPvWF4NXV8w/qC0O6DfiejY95tuzsbuJ70Qt123vMQ/WJmAZdvdBo
         0FnhZ0obLz2wQdDZDQHl8pFRYo/ufJEoji8SN38Lmc5DiOf3VvUZ3NF3bBM+ZjndK7+/
         IOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Dgr+R+Ooqj7O8IbEZN3k8kABePugAAeIHX9669QxJ80=;
        b=zmP54NkWWyICRWw6Wwlc+UKrJH30RW/sbMeBzpdoAvuqYMWidv1cAu7p/87llbRtJL
         deXA1OMhAubo1HPbrZTBeU4gb6ex+fnCH5Dy/JnOpTUKCYFyCuebBQ/KBp48iv4+cxx/
         LXs6HGX0W5WBeCtJg+I/9V+BA2JYggTvhimH9p0oVyj2lHYWmoLNB4a+Q0HZHuzru9vy
         yYpbljvwfcCh0IhPaRTA1E8ZivJr5etsQtmjOLn1ak7ZyUOh0w0N/5KTPnw7MfFSwcRT
         uBFCnBFIfBkgU+MhJ8oiPTMkDrREglGuChSb9IK+24IwnO5/P6Dwk5mZeQwVpJg1uTV8
         zyFQ==
X-Gm-Message-State: ACgBeo2Kwr+CeL1pbdyC9SSTLszT6drjMkIKxuJsJ7OkZTwXk12Khc/x
        LbMSQdVwg+v6cn+y80KKWbxnrA==
X-Google-Smtp-Source: AA6agR6T30+0oOAruQ1NqH8Mc3XrzaGWuY4JttKOMhps4dvfSnG9rR5qWPpPk2ZQkHLHfHOIE3PQ9g==
X-Received: by 2002:a05:6000:1806:b0:225:5c19:6c75 with SMTP id m6-20020a056000180600b002255c196c75mr2040295wrh.524.1661179525219;
        Mon, 22 Aug 2022 07:45:25 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a245:8020:2658:1f7c:362:3e99])
        by smtp.gmail.com with ESMTPSA id z24-20020a1cf418000000b003a5dadcf1a8sm14670935wma.19.2022.08.22.07.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:45:24 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 4/4] soc: mediatek: pm-domains: Add support for MT8365
Date:   Mon, 22 Aug 2022 16:43:03 +0200
Message-Id: <20220822144303.3438467-5-msp@baylibre.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822144303.3438467-1-msp@baylibre.com>
References: <20220822144303.3438467-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add the needed board data to support MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/soc/mediatek/mt8365-pm-domains.h | 147 +++++++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c    |   5 +
 2 files changed, 152 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8365-pm-domains.h

diff --git a/drivers/soc/mediatek/mt8365-pm-domains.h b/drivers/soc/mediatek/mt8365-pm-domains.h
new file mode 100644
index 000000000000..950ff90d5560
--- /dev/null
+++ b/drivers/soc/mediatek/mt8365-pm-domains.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT8365_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MT8365_PM_DOMAINS_H
+
+#include "mtk-pm-domains.h"
+#include <dt-bindings/power/mediatek,mt8365-power.h>
+
+/*
+ * MT8365 power domain support
+ */
+
+static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
+	[MT8365_POWER_DOMAIN_MM] = {
+		.name = "mm",
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = 0x30c,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_STRICT_BUS_PROTECTION,
+		.bp_infracfg = {
+			BUS_PROT_WR(BIT(16) | BIT(17), 0x2a8, 0x2ac, 0x258),
+			BUS_PROT_WR(BIT(1) | BIT(2) | BIT(10) | BIT(11), 0x2a0, 0x2a4, 0x228),
+			BUS_PROT_WAY_EN(BIT(6), BIT(24), 0x200, 0x0),
+			BUS_PROT_WAY_EN(BIT(5), BIT(14), 0x234, 0x28),
+			BUS_PROT_WR(BIT(6), 0x2a0, 0x2a4, 0x228),
+		},
+	},
+	[MT8365_POWER_DOMAIN_VENC] = {
+		.name = "venc",
+		.sta_mask = PWR_STATUS_VENC,
+		.ctl_offs = 0x0304,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_smi = {
+			BUS_PROT_WR(BIT(1), 0x3c4, 0x3c8, 0x3c0),
+		},
+	},
+	[MT8365_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
+		.sta_mask = PWR_STATUS_AUDIO,
+		.ctl_offs = 0x0314,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(12, 8),
+		.sram_pdn_ack_bits = GENMASK(17, 13),
+		.bp_infracfg = {
+			BUS_PROT_WR(BIT(27) | BIT(28), 0x2a8, 0x2ac, 0x258),
+		},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8365_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = 0x032c,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.bp_infracfg = {
+			BUS_PROT_WR(BIT(13), 0x2a0, 0x2a4, 0x228),
+			BUS_PROT_WR(BIT(18), 0x2a8, 0x2ac, 0x258),
+			BUS_PROT_WR(BIT(14), 0x2a0, 0x2a4, 0x228),
+			BUS_PROT_WR(BIT(21), 0x2a8, 0x2ac, 0x258),
+		},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8365_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = 0x0338,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(BIT(25), 0x2a0, 0x2a4, 0x228),
+			BUS_PROT_WR(BIT(21) | BIT(22), 0x2a0, 0x2a4, 0x228),
+		},
+	},
+	[MT8365_POWER_DOMAIN_CAM] = {
+		.name = "cam",
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x0344,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(BIT(19), 0x2a8, 0x2ac, 0x258),
+		},
+		.bp_smi = {
+			BUS_PROT_WR(BIT(2), 0x3c4, 0x3c8, 0x3c0),
+		},
+	},
+	[MT8365_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
+		.sta_mask = BIT(31),
+		.ctl_offs = 0x0370,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_smi = {
+			BUS_PROT_WR(BIT(3), 0x3c4, 0x3c8, 0x3c0),
+		},
+	},
+	[MT8365_POWER_DOMAIN_APU] = {
+		.name = "apu",
+		.sta_mask = BIT(16),
+		.ctl_offs = 0x0378,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(14, 8),
+		.sram_pdn_ack_bits = GENMASK(21, 15),
+		.bp_infracfg = {
+			BUS_PROT_WR(BIT(2) | BIT(20), 0x2a8, 0x2ac, 0x258),
+		},
+		.bp_smi = {
+			BUS_PROT_WR(BIT(4), 0x3c4, 0x3c8, 0x3c0),
+		},
+	},
+	[MT8365_POWER_DOMAIN_DSP] = {
+		.name = "dsp",
+		.sta_mask = BIT(17),
+		.ctl_offs = 0x037C,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(BIT(24) | BIT(30) | BIT(31), 0x2a8, 0x2ac, 0x258),
+		},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+};
+
+static const struct scpsys_soc_data mt8365_scpsys_data = {
+	.domains_data = scpsys_domain_data_mt8365,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8365),
+};
+
+#endif /* __SOC_MEDIATEK_MT8365_PM_DOMAINS_H */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index d323275aa11c..dbabdd688a1f 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -23,6 +23,7 @@
 #include "mt8186-pm-domains.h"
 #include "mt8192-pm-domains.h"
 #include "mt8195-pm-domains.h"
+#include "mt8365-pm-domains.h"
 
 #define MTK_POLL_DELAY_US		10
 #define MTK_POLL_TIMEOUT		USEC_PER_SEC
@@ -706,6 +707,10 @@ static const struct of_device_id scpsys_of_match[] = {
 		.compatible = "mediatek,mt8195-power-controller",
 		.data = &mt8195_scpsys_data,
 	},
+	{
+		.compatible = "mediatek,mt8365-power-controller",
+		.data = &mt8365_scpsys_data,
+	},
 	{ }
 };
 
-- 
2.37.2

