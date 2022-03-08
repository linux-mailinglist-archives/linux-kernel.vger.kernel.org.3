Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6FA4D2109
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349925AbiCHTKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349890AbiCHTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:10:21 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8783649683
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:09:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id z16so209828pfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xCLmej3ASMhCzoCjalBeE7MlVyXBTYUNm6WHWDyRzJ4=;
        b=XDxUtkkfguKIpXdJtQdm6/VFWj2zLR4nvCC+0mQOD1nG8UWWuJtvxLFJSelx48So8/
         66H2OCtsTdV6g29lwJmEt5CJMSshQHOS1qfTmOKQD3b3ZYUko5of7V74eu/cJVQgASvs
         rmxjzOezqwaAQM7J+RErQlYt4E0WjG1SXP94E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xCLmej3ASMhCzoCjalBeE7MlVyXBTYUNm6WHWDyRzJ4=;
        b=bGLPWh3YMOeSC0H5wKsf2qOu9lXVuT9YYUiZpL8SZQtAmqVkIfP9CfMCU6DM3eQaPu
         8D/2AQSiBMTCQhQdAz2uL9EYTUidm0C8nun9HAwKuYvE8RdmFVSI/b3WxZ15qswMP3GF
         h+JAaKeXCMYpcu/09L9wCdRoFy7WpgUJPKQrB687Ok+Eb48WlLCmqNP0ykqA3FooW8C9
         M/KTS5x9TX5gwZG30P8yFSPUMgI9O8lRWvAvUbkop6VNYFCwjo0Of8x3sxn0moxnZZZl
         zwobzE19MX6ckyTCSNRwu9NhrjqXZiy1S0+3RxtrB/f5jMSXfUDfsur1zQVuLuPU1Nlx
         9Kjg==
X-Gm-Message-State: AOAM530BKxldGIchB5pGUPtGCv0CFrlFKiwjc96Aw96HSMnVM//wx5UK
        hjfWLBIMHU/tRHbqL8bsjXwyAQ==
X-Google-Smtp-Source: ABdhPJxUPpHD0D1g6CmnuNEbS2Y2kpd0VWcLBfHdpnesyIyVAd6VCoGpyggUrB52V0mZ5oxLHPWk3w==
X-Received: by 2002:a62:bd05:0:b0:4f7:aec:dd7e with SMTP id a5-20020a62bd05000000b004f70aecdd7emr9923561pff.9.1646766561672;
        Tue, 08 Mar 2022 11:09:21 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with UTF8SMTPSA id l2-20020a637c42000000b003644cfa0dd1sm15180460pgn.79.2022.03.08.11.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:09:21 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 05/15] dt-bindings: devfreq: rk3399_dmc: Add more disable-freq properties
Date:   Tue,  8 Mar 2022 11:08:51 -0800
Message-Id: <20220308110825.v4.5.I382d4de737198ea52deb118c9bdc4d93d76e009e@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308190901.3144566-1-briannorris@chromium.org>
References: <20220308190901.3144566-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DDR DVFS tuning has found that several power-saving features don't have
good tradeoffs at higher frequencies -- at higher frequencies, we'll see
glitches or other errors. Provide tuning controls so these can be
disabled at higher OPPs, and left active only at the lower ones.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---

(no changes since v3)

Changes in v3:
 * Add Reviewed-by

Changes in v2:
 * hyphens, not underscores
 * *-hz units, and drop the types definition

 .../rockchip,rk3399-dmc.yaml                  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml b/Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
index 5228a32b5962..fb4920397d08 100644
--- a/Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
@@ -313,6 +313,38 @@ properties:
       self-refresh mode. The controller, pi, PHY and DRAM clock will be gated
       if bus is idle for standby_idle nanoseconds.
 
+  rockchip,pd-idle-dis-freq-hz:
+    description:
+      Defines the power-down idle disable frequency in Hz. When the DDR
+      frequency is greater than pd-idle-dis-freq, power-down idle is disabled.
+      See also rockchip,pd-idle-ns.
+
+  rockchip,sr-idle-dis-freq-hz:
+    description:
+      Defines the self-refresh idle disable frequency in Hz. When the DDR
+      frequency is greater than sr-idle-dis-freq, self-refresh idle is
+      disabled. See also rockchip,sr-idle-ns.
+
+  rockchip,sr-mc-gate-idle-dis-freq-hz:
+    description:
+      Defines the self-refresh and memory-controller clock gating disable
+      frequency in Hz. When the DDR frequency is greater than
+      sr-mc-gate-idle-dis-freq, the clock will not be gated when idle. See also
+      rockchip,sr-mc-gate-idle-ns.
+
+  rockchip,srpd-lite-idle-dis-freq-hz:
+    description:
+      Defines the self-refresh power down idle disable frequency in Hz. When
+      the DDR frequency is greater than srpd-lite-idle-dis-freq, memory will
+      not be placed into self-refresh power down mode when idle. See also
+      rockchip,srpd-lite-idle-ns.
+
+  rockchip,standby-idle-dis-freq-hz:
+    description:
+      Defines the standby idle disable frequency in Hz. When the DDR frequency
+      is greater than standby-idle-dis-freq, standby idle is disabled. See also
+      rockchip,standby-idle-ns.
+
 required:
   - compatible
   - devfreq-events
@@ -344,4 +376,9 @@ examples:
       rockchip,ddr3_odt_dis_freq = <333000000>;
       rockchip,lpddr3_odt_dis_freq = <333000000>;
       rockchip,lpddr4_odt_dis_freq = <333000000>;
+      rockchip,pd-idle-dis-freq-hz = <1000000000>;
+      rockchip,sr-idle-dis-freq-hz = <1000000000>;
+      rockchip,sr-mc-gate-idle-dis-freq-hz = <1000000000>;
+      rockchip,srpd-lite-idle-dis-freq-hz = <0>;
+      rockchip,standby-idle-dis-freq-hz = <928000000>;
     };
-- 
2.35.1.616.g0bdcbb4464-goog

