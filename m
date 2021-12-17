Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62D547934D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbhLQR6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbhLQR6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:58:08 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3750C06173F;
        Fri, 17 Dec 2021 09:58:07 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id l22so6240320lfg.7;
        Fri, 17 Dec 2021 09:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/Bk94jGQ1LLUV/eRDOVPSiVwi8PZOkXJ4VQl4ZqdBQ=;
        b=gd63/Dw9Nrlh//jLnmbfLktqpbCfnCD3MEQ9pshOVhQ2eQsgiaFVevrd/BHZ8mEqP/
         4Gw3BmuYCVBIjn5/H8W9nYnUXgTg2/O6WnKwRvGBtPtcsoV3P4BaaNNbRl+zAOMMf56t
         AvWvQO+fG8YS+Nku5Xh0aY7fRG5K7h2H+cObqJtjnNUM9CLiM+Zhqm0+imnsBcpwJUoH
         +znY2TxLKLVZKO5Z39+heBCOZ1JMBODO0DjWMA2rrqye26kYK/T6Jh+pmXMYxIrea17L
         gzJ1yec4Gb60E8nyQGKAXn/8rHwAbnz7meXhwMquCDQztKygRaRVy8zZurWIf3FG/D6j
         kpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/Bk94jGQ1LLUV/eRDOVPSiVwi8PZOkXJ4VQl4ZqdBQ=;
        b=7RO5Pgte6qTWA2CWFvEb8cmWmQnOtZCj+Ngs2Rqc+h8P3/JyT4F6WKeBXV9UueoYh4
         y2HwUWJPxtOrzwh3BxzQPhFLISVQXq67UmvxgbuXKgHOqVu0LW80A0lvhaZ3qM3w3VDE
         ayfOxVW5wNcyuUn0LKuwNnN7AQp5afYKS9ZGKRBw9x5RZ4InKyFZr9jt3nNJyLkozmBZ
         SDLFqRzG8niRcR/FZYzmf2TuN1LDxUzl2mAQU2WV2THn0oJF1572TrSwfxLlCxbsAhag
         kV1ulCmtMQYJ3W5EkP4fYPQbdMiihFOd6XzxMLHHAZa9JIBUrtvhpaUlIHyX3YZlB/l9
         rnQg==
X-Gm-Message-State: AOAM531TGxnGv/ivNIdVNQKxUuLnaetx3ZCIZuEXBgSCpfZbrYHAVxci
        08YL5nvZcwUL2tBp4Fbg8r0=
X-Google-Smtp-Source: ABdhPJzKaTTjJXre0dua8RwNlcxh74FOq2omKWYA7DY5cm1l0mFZGhkM+tnLSdB8x+VlxMCmD1u4NA==
X-Received: by 2002:a05:6512:3f98:: with SMTP id x24mr3789088lfa.87.1639763886133;
        Fri, 17 Dec 2021 09:58:06 -0800 (PST)
Received: from localhost.localdomain (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.gmail.com with ESMTPSA id w23sm1479244lfa.191.2021.12.17.09.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:58:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 03/11] ASoC: dt-bindings: tegra20-i2s: Document new nvidia,fixed-parent-rate property
Date:   Fri, 17 Dec 2021 20:55:58 +0300
Message-Id: <20211217175606.22645-4-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217175606.22645-1-digetx@gmail.com>
References: <20211217175606.22645-1-digetx@gmail.com>
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
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/sound/nvidia,tegra20-i2s.yaml      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
index 4c00fd0943c3..0572aceca8ab 100644
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

