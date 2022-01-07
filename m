Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C50487FB2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiAGXxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiAGXxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:53:41 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A71CC061748
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:53:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id r14-20020a17090b050e00b001b3548a4250so5301204pjz.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uqA2vTRTwCd5lb+1bpw59I8A4YOj+PxA4CFZWdTkSiE=;
        b=KjQjjOwC8d4WeVLXIzAl5ZiDLmf1td57rlGuw1GCTyOix4NbWz87jaIU3GPeaHkhs2
         +aKtbG6eMTbXncBI8DqE362s9f/7hyyLlEFnDyCIssQVbVjfuNX3Ig4LPvwuuJx9CHy3
         4H3ahd/fdtvy4tK0RwPpQ0oebhP89pSmGlBC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqA2vTRTwCd5lb+1bpw59I8A4YOj+PxA4CFZWdTkSiE=;
        b=r8stVCQxX1W6njWOGdqOCDrCEb6yzt3RC36K8J+XzW9ykeE1czFGq5Vxb6lq+3rQ2w
         VFBhe5b2M+4NDzmgE4WJO0nVYdQpC6YNdetk8Lbx4VpsueHcUMzAZLAAsQuYW0cUBH+h
         BtCQWRBLofDBlh+2z+9hbTYCTuYXt7B/MD9iBiWcxnbO4ipFeL+2w+PFIMNKh+SIN0Kv
         gBi6od3QdbJdUhN2CENPWvsA9h0XBtoaeikkQennTF1pXW8xWYl/THQPtDXCqgQH4K3X
         GXxpwJKlS+Xxf/Tur6JEc2EwJbT/AsuguX6oYM0MoX/zJuG6K4G0ZMKvgkyL6CFfDsO3
         +6Tw==
X-Gm-Message-State: AOAM533QV0Du36Glsp02ROoZdkpiV8PvhKPywWWzn+djFr3xhGxsUfsf
        0D7SiWTvXLzt+Srkn+ZSH0gbkw==
X-Google-Smtp-Source: ABdhPJwIGLUJ4870oxOMvvNEBPUvoGuIBVIO34djfW+MF+nHRtQ6skGcluLNSZvfeaLmcwPvyDn+Tw==
X-Received: by 2002:a17:90a:df04:: with SMTP id gp4mr2131418pjb.148.1641599617740;
        Fri, 07 Jan 2022 15:53:37 -0800 (PST)
Received: from localhost ([2620:15c:202:201:db:1c60:693f:c24e])
        by smtp.gmail.com with UTF8SMTPSA id h19sm57446pfh.30.2022.01.07.15.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 15:53:37 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 04/10] dt-bindings: devfreq: rk3399_dmc: Add more disable-freq properties
Date:   Fri,  7 Jan 2022 15:53:14 -0800
Message-Id: <20220107155215.4.I382d4de737198ea52deb118c9bdc4d93d76e009e@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220107235320.965497-1-briannorris@chromium.org>
References: <20220107235320.965497-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DDR DVFS tuning has found that several power-saving features don't have
good tradeoffs at higher frequencies -- at higher frequencies, we'll see
glitches or other errors. Provide tuning controls so these can be
disabled at higher OPPs, and left active only at the lower ones.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 .../bindings/devfreq/rk3399_dmc.yaml          | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
index 2c871c57fd97..357d07c5a3df 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
@@ -271,6 +271,43 @@ properties:
       When the DRAM type is LPDDR4, this parameter defines the PHY side ODT
       strength. Default value is 60.
 
+  rockchip,pd_idle_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the power-down idle disable frequency in Hz. When the DDR
+      frequency is greater than pd_idle_dis_freq, power-down idle is disabled.
+      See also rockchip,pd_idle.
+
+  rockchip,sr_idle_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the self-refresh idle disable frequency in Hz. When the DDR
+      frequency is greater than sr_idle_dis_freq, self-refresh idle is
+      disabled. See also rockchip,sr_idle.
+
+  rockchip,sr_mc_gate_idle_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the self-refresh and memory-controller clock gating disable
+      frequency in Hz. When the DDR frequency is greater than
+      sr_mc_gate_idle_dis_freq, the clock will not be gated when idle. See also
+      rockchip,sr_mc_gate_idle.
+
+  rockchip,srpd_lite_idle_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the self-refresh power down idle disable frequency in Hz. When
+      the DDR frequency is greater than srpd_lite_idle_dis_freq, memory will
+      not be placed into self-refresh power down mode when idle. See also
+      rockchip,srpd_lite_idle.
+
+  rockchip,standby_idle_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the standby idle disable frequency in Hz. When the DDR frequency
+      is greater than standby_idle_dis_freq, standby idle is disabled. See also
+      rockchip,standby_idle.
+
 additionalProperties: false
 
 examples:
@@ -294,4 +331,9 @@ examples:
       rockchip,ddr3_odt_dis_freq = <333000000>;
       rockchip,lpddr3_odt_dis_freq = <333000000>;
       rockchip,lpddr4_odt_dis_freq = <333000000>;
+      rockchip,pd_idle_dis_freq = <1000000000>;
+      rockchip,sr_idle_dis_freq = <1000000000>;
+      rockchip,sr_mc_gate_idle_dis_freq = <1000000000>;
+      rockchip,srpd_lite_idle_dis_freq = <0>;
+      rockchip,standby_idle_dis_freq = <928000000>;
     };
-- 
2.34.1.575.g55b058a8bb-goog

