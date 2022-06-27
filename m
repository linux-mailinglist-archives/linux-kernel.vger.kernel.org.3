Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D894155DA90
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbiF0OVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbiF0OUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:20:44 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B991145F;
        Mon, 27 Jun 2022 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ixmg90dyDmHAicFMf0z9UoK0XakUBMSYYi6CRfswppA=; b=B83Q8R6dOE20SbRqfBwQyYZgHf
        MnS6+AGqyuKfaCmDxvJQ8ySeMdhzsNErzCYssjkBXKh8pqWz7YJPbmk6Jrz9isqQYjBsOONPDrXDk
        mwsKJCpBbDtzL4BFh6u9LSdDsX/2h/BLjW0RaYgzTYIDm9ZDZpuGuzhRWp2MMThmN7VsfZ2xJJYlh
        J2dlfPegLATsoBK3ShxWAtSWlCev0xi6nY/GBurrqCNO8gl4etsLnFebfeO6Z6j/jdgzO3HBL3IWW
        AC8pYkRZOhYOBThJogAmET6RNQV1yV0xBM8iweRSGoenHvYgTnApgNgN9W1QztO9KynPNZO/oUoEc
        bhd2nNBg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o5pbP-003N2J-6O; Mon, 27 Jun 2022 17:20:34 +0300
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
Subject: [PATCH v7/v3 20/22] gpu: host1x: Add MLOCK release code on Tegra234
Date:   Mon, 27 Jun 2022 17:20:06 +0300
Message-Id: <20220627142008.2072474-21-cyndis@kapsi.fi>
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

With the full-featured opcode sequence using MLOCKs, we need to also
unlock those MLOCKs in the event of a timeout. However, it turns out
that on Tegra186/Tegra194, by default, we don't need to do this;
furthermore, on Tegra234 it is much simpler to do; so only implement
this on Tegra234 for the time being.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/hw/cdma_hw.c            | 34 ++++++++++++++++++++++
 drivers/gpu/host1x/hw/hw_host1x08_common.h |  7 +++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/host1x/hw/cdma_hw.c b/drivers/gpu/host1x/hw/cdma_hw.c
index e49cd5b8f735..1b65a10b9dfc 100644
--- a/drivers/gpu/host1x/hw/cdma_hw.c
+++ b/drivers/gpu/host1x/hw/cdma_hw.c
@@ -238,6 +238,37 @@ static void cdma_resume(struct host1x_cdma *cdma, u32 getptr)
 	cdma_timeout_restart(cdma, getptr);
 }
 
+static void timeout_release_mlock(struct host1x_cdma *cdma)
+{
+#if HOST1X_HW >= 8
+	/* Tegra186 and Tegra194 require a more complicated MLOCK release
+	 * sequence. Furthermore, those chips by default don't enforce MLOCKs,
+	 * so it turns out that if we don't /actually/ need MLOCKs, we can just
+	 * ignore them.
+	 *
+	 * As such, for now just implement this on Tegra234 where things are
+	 * stricter but also easy to implement.
+	 */
+	struct host1x_channel *ch = cdma_to_channel(cdma);
+	struct host1x *host1x = cdma_to_host1x(cdma);
+	u32 offset;
+
+	switch (ch->client->class) {
+	case HOST1X_CLASS_VIC:
+		offset = HOST1X_COMMON_VIC_MLOCK;
+		break;
+	case HOST1X_CLASS_NVDEC:
+		offset = HOST1X_COMMON_NVDEC_MLOCK;
+		break;
+	default:
+		WARN(1, "%s was not updated for class %u", __func__, ch->client->class);
+		return;
+	}
+
+	host1x_common_writel(host1x, 0x0, offset);
+#endif
+}
+
 /*
  * If this timeout fires, it indicates the current sync_queue entry has
  * exceeded its TTL and the userctx should be timed out and remaining
@@ -288,6 +319,9 @@ static void cdma_timeout_handler(struct work_struct *work)
 	/* stop HW, resetting channel/module */
 	host1x_hw_cdma_freeze(host1x, cdma);
 
+	/* release any held MLOCK */
+	timeout_release_mlock(cdma);
+
 	host1x_cdma_update_sync_queue(cdma, ch->dev);
 	mutex_unlock(&cdma->lock);
 }
diff --git a/drivers/gpu/host1x/hw/hw_host1x08_common.h b/drivers/gpu/host1x/hw/hw_host1x08_common.h
index 4df28440b86b..8e0c99150ec2 100644
--- a/drivers/gpu/host1x/hw/hw_host1x08_common.h
+++ b/drivers/gpu/host1x/hw/hw_host1x08_common.h
@@ -2,3 +2,10 @@
 /*
  * Copyright (c) 2022 NVIDIA Corporation.
  */
+
+#define HOST1X_COMMON_OFA_MLOCK			0x4050
+#define HOST1X_COMMON_NVJPG1_MLOCK		0x4070
+#define HOST1X_COMMON_VIC_MLOCK			0x4078
+#define HOST1X_COMMON_NVENC_MLOCK		0x407c
+#define HOST1X_COMMON_NVDEC_MLOCK		0x4080
+#define HOST1X_COMMON_NVJPG_MLOCK		0x4084
-- 
2.36.1

