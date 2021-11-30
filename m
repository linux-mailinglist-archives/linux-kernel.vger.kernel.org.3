Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910E8464299
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbhK3X16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345047AbhK3X1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE91C061574;
        Tue, 30 Nov 2021 15:24:03 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bi37so57905598lfb.5;
        Tue, 30 Nov 2021 15:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uELYhg3LoYYilCBTSAEvuuZR4UEF9kvdsKmUqE/otlI=;
        b=Iz+By4hMaXHUZwDfNCwQnwHPuCiheJc2NwheZRIW0SCUuZLXO6Kzb0rHCFhXIjvcpq
         atkOkbTR7AyNqk3eYgRtR4+8TIHgEHeIX5V7awmkDF+cm8HK+xuAU8gwl0EW6OfiFiRd
         ZJs+lPfBU0yFZXSMvPR7IwR2G9j4BzBRCJUIQfajREXQmUMRjWP4eze74I3lCMdEeJSH
         uDWKf63VDqvCJUvuOA/yd+zanFwsJBx3KsYcJ7hfFxe/VteDysXft6+ITX5XRPiL2XoN
         e2UHyFk5KHUy/kdANpCvj2PHfbn3MizqGQaQnW4vf1cJQjiCOZr1biuXiBEMhC4ZbEGt
         7idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uELYhg3LoYYilCBTSAEvuuZR4UEF9kvdsKmUqE/otlI=;
        b=br6EBrRZsacDwQEKljfm5azgBAFGh72lHmWo97cmwezw7VF9PL2RvthgA46arv1gCs
         bUvCqxlXPcsZkkpcz+WJXACNmjvStvk57ng9xndKx1SD29VuJZ8ULpCQXA4XR7DXJpL5
         dDGhNb+uUvKhha2eg+dQGXjbr0C0dLYeIeirI58jpMCSuOvxNA9E24xDEJNeMXWlv7zK
         AV5fajasCdkxVLdX/X3ersTbxl4d8wssVXwkBdqKACR03hf6e2Kr08/Axwx8CAx0Le7h
         tH7DJL1reFC2NrvxDPJMIAKVUJCDJCHr0XcJjewQ0B5l0tvNfyx0OC4GiWxVwuPnx4oU
         Mwug==
X-Gm-Message-State: AOAM533hbmXf36rJ2mf9vDlaoV0lZclWpAIJxE+dRcrsU1kfbCr7gV4k
        NVoHAOs0BsdNdIGOEfkSGHY=
X-Google-Smtp-Source: ABdhPJyEYwAI+MOhcdvc/yezPcOl+Jxo64iQcq1EFuIqq6TqVcWs235t3mz+TkeZYw65Aj2HR/gfmA==
X-Received: by 2002:a05:6512:682:: with SMTP id t2mr2162526lfe.503.1638314641879;
        Tue, 30 Nov 2021 15:24:01 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:01 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v16 07/40] dt-bindings: host1x: Document Memory Client resets of Host1x, GR2D and GR3D
Date:   Wed,  1 Dec 2021 02:23:14 +0300
Message-Id: <20211130232347.950-8-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory Client should be blocked before hardware reset is asserted in order
to prevent memory corruption and hanging of memory controller.

Document Memory Client resets of Host1x, GR2D and GR3D hardware units.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/display/tegra/nvidia,tegra20-host1x.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index 62861a8fb5c6..e61999ce54e9 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
@@ -19,6 +19,7 @@ Required properties:
   See ../reset/reset.txt for details.
 - reset-names: Must include the following entries:
   - host1x
+  - mc
 
 Optional properties:
 - operating-points-v2: See ../bindings/opp/opp.txt for details.
@@ -198,6 +199,7 @@ of the following host1x client modules:
     See ../reset/reset.txt for details.
   - reset-names: Must include the following entries:
     - 2d
+    - mc
 
   Optional properties:
   - interconnects: Must contain entry for the GR2D memory clients.
@@ -224,6 +226,8 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - 3d
     - 3d2 (Only required on SoCs with two 3D clocks)
+    - mc
+    - mc2 (Only required on SoCs with two 3D clocks)
 
   Optional properties:
   - interconnects: Must contain entry for the GR3D memory clients.
-- 
2.33.1

