Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBB446856D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbhLDOlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhLDOlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:01 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2F5C061751;
        Sat,  4 Dec 2021 06:37:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id l22so13781197lfg.7;
        Sat, 04 Dec 2021 06:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqYniy4pFRsXD92ySrc+ZxB/2v4IriL3y3/YUqS2PUE=;
        b=RNaLxgDCs6qXg/TwLlIXZzcLh4LJees5fE8xDEIukdb/OT7zBkOn507I9wRfW4w4xa
         niemSTpkq4n0nexvCghsEPDaa2xSzvEpS/WsEmx4EV03PZVyKUZtZlS7Cti2Kn+4gMYF
         J708JdarR4uxOSBnidMRRSiy2W6zsI1gXcaV3YFCIDJElDuSQASMDSwzTEERDBY6z/GJ
         Tu5cJSkY8ZKkzpgGoDlyMSgeZiQ9HNZLslB40hhiwbDCqsRMTPi2uMzO0H3DlBuUQz5i
         izOVMOtEV1I3PCwg+dtNL+UPSlH1eXaeVBZ7mKfa2tjeCrhdqFWl6mFiJFpGYAtZigR4
         SdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqYniy4pFRsXD92ySrc+ZxB/2v4IriL3y3/YUqS2PUE=;
        b=hDdYr/5f9u7DsEXXjOn7U4x4zrBcadg5So99ugoFqU6rZqXSlXlLtZnUsBn6be/Pwi
         EM3pHGMFEsPHZhtAsxGrRB/pzr1dfd1KXsJ3G9QRppFZ/GjbcZMPDXblh0IcGaJ+nCfk
         WNifgR0/Uz+UxK/9yxXyOivSB8+UeIOGhMKhZrciV/Z+FxDvsBaqlJVcyL5m0x7kqgWH
         Cckub6jxVdBKrWp8kIPoMIbZXI7TCLY8pGSK8xd7RrqCUgPrZkP/ugC7UD27g9lqJyZ8
         XKKP5eNOq8GNgAxcgR7Vl42xFCFcXTO+FUB7UIqdUwzJVr8fIvzvJhESSQJkLrE0wJoh
         fnIA==
X-Gm-Message-State: AOAM531xlR6miW7L6KsgNvqv8fm1IlLgGfWlpqQ2a8SXP6z8U+stDxCn
        UTfUVOjHe6qySe6ZR0C8n6c=
X-Google-Smtp-Source: ABdhPJxlNR6C8CFHLRo5rqVDCMsVLSUpmIzAdsrAsZFFI4Y2oRrvmEXZzQFyeVHAejMo+rAPaIrc5w==
X-Received: by 2002:ac2:518b:: with SMTP id u11mr24097394lfi.498.1638628653644;
        Sat, 04 Dec 2021 06:37:33 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:33 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 03/22] ASoC: dt-bindings: tegra20-i2s: Document new nvidia,fixed-parent-rate property
Date:   Sat,  4 Dec 2021 17:37:06 +0300
Message-Id: <20211204143725.31646-4-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new nvidia,fixed-parent-rate property which instructs that this
board wants parent clock to stay at a fixed rate. It allows to prevent
conflicts between audio components that share same parent PLL. For
instance, this property allows to have HDMI audio, speaker and headphones
in the system playing audio simultaneously, which is a common pattern for
consumer devices.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/sound/nvidia,tegra20-i2s.yaml      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
index ad43b237d9af..68ae124eaf80 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
@@ -42,6 +42,13 @@ properties:
       - const: rx
       - const: tx
 
+  nvidia,fixed-parent-rate:
+    description: |
+      Specifies whether board prefers parent clock to stay at a fixed rate.
+      This allows multiple Tegra20 audio components work simultaneously by
+      limiting number of supportable audio rates.
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.33.1

