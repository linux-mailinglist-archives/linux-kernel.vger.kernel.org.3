Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5160655C56F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiF0OWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiF0OUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:20:44 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C0612D0E;
        Mon, 27 Jun 2022 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hAGGcw/SOg7X5CrJwFzinyDfIvPa2up8kxxxfJmr9MY=; b=OVT40zHQMaVJ519ektyNfliAPQ
        ljmFiTrZ02TFysbAsdxJ7QhFfndm/e3NQViyKjltr8OWRFMHtWvxfyUbTTTQNmSfWayxmwRbGrz1L
        rAEAsZ0EXg3JBo+x7z/dqk2SOgjaBnRVKI/b/E4Kb2beZSd5nybtrVKRxZDuDlCqR9odfnTkqmDT6
        sKH41iWq3+lUiQUsHK1p6yIJ4hTtHUnIVtJ0vNMWDdZPoVEdV+cHYagQwe707FRyKUiti/Lp699iy
        tl9SLdemFNpXuipmBnW9lAboz1swjoUjAvjUxR1yRF0JTX6vlbzoO+MMmtfL/YTy1AB8+v7jXD8X+
        GiALNFMg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o5pbO-003N2J-Et; Mon, 27 Jun 2022 17:20:33 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7/v3 17/22] gpu: host1x: Program interrupt destinations on Tegra234
Date:   Mon, 27 Jun 2022 17:20:03 +0300
Message-Id: <20220627142008.2072474-18-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627142008.2072474-1-cyndis@kapsi.fi>
References: <20220627142008.2072474-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

On Tegra234, each Host1x VM has 8 interrupt lines. Each syncpoint
can be configured with which interrupt line should be used for
threshold interrupt, allowing for load balancing.

For now, to keep backwards compatibility, just set all syncpoints
to the first interrupt.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/hw/intr_hw.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/host1x/hw/intr_hw.c b/drivers/gpu/host1x/hw/intr_hw.c
index f56375ee6e71..9acccdb139e6 100644
--- a/drivers/gpu/host1x/hw/intr_hw.c
+++ b/drivers/gpu/host1x/hw/intr_hw.c
@@ -76,6 +76,17 @@ static void intr_hw_init(struct host1x *host, u32 cpm)
 	/* update host clocks per usec */
 	host1x_sync_writel(host, cpm, HOST1X_SYNC_USEC_CLK);
 #endif
+#if HOST1X_HW >= 8
+	u32 id;
+
+	/*
+	 * Program threshold interrupt destination among 8 lines per VM,
+	 * per syncpoint. For now, just direct all to the first interrupt
+	 * line.
+	 */
+	for (id = 0; id < host->info->nb_pts; id++)
+		host1x_sync_writel(host, 0, HOST1X_SYNC_SYNCPT_INTR_DEST(id));
+#endif
 }
 
 static int
-- 
2.36.1

