Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B8A532D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiEXP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiEXP1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:27:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A670D5FF0D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:27:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso1283060wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R2w5tfWVkkqH5erhNFYiJNGO89mooqJ/f3WebpkD9pw=;
        b=5py3jx843dbBAQDoG6BUKJpJcOTFw+CyMGMpuJgnlNrBcWlZpHxJmmJUtvHPr945ky
         hsj8JuSMUygANtZlpSXU764z9bPAqKG0Qc1CL4jTKg8by7rHxuyS67Iqa0+wLLGIQf72
         UqghYJAbnGs/86iKbUQmqk5ICY7XsrMsSh/kRZZCCbCyMJezX0iVzuMr80ARgNWnF4OU
         nW4bUb8s9cLnE8R43AD6oCbXTuxpnL29o3aOEsVZ8VgAulULWmYIOcXBjLDPIixTIu6r
         IRtZU3fjqT9P8yv3Hj88apg5bPUTs+Z1corNyK40MhCbqe3UxoIhMaEcWjN5k0Ufo7Nd
         owzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R2w5tfWVkkqH5erhNFYiJNGO89mooqJ/f3WebpkD9pw=;
        b=sguGng7YvNAwA4vvv6Iwa3QHTfJpIl7zbEa2pzt7TsbEJ8hlrvvGCTshNWzqwJftPX
         GP/qZ+Ej3sxZJWdG3nAAwcUsuc+TqM+nfMBjwOPFmy39PfnhNYKL+OEMtvEai/+mzcVm
         ZL7ptuRgB84jNb4P+OswKVvPonU3kzn0PgalVh/p98bXEQpejwuUtfdQLkqQSa7VrhgM
         6xQQ6FpD3hpAz7YHVfzUwfiNwQI5c5lLXterWcCa6H4cpAjhRRuuUPVjySf7jDltJBnB
         2IpDI+S9RkqCW/XQEIM67BWldoQeBXPrJLSINUsHX3K+vRMaR+0vD6pCvkwMjhVGQydp
         Y+Cw==
X-Gm-Message-State: AOAM530GXwKpUJGDM4ugiy61Lo6Bn6NFq1JAh/rS0/vGGv4SzmVATHKv
        RmIwg+rkGidLG6A1IgxW2wxg7Q==
X-Google-Smtp-Source: ABdhPJzJi0LPjrECz8V5+Pr2ftapF3zqFkYd3LMw0KNtjeDJ6jhgUU1AjknD4REIAnLLUcgUcLIG0w==
X-Received: by 2002:a05:600c:4e94:b0:397:62ab:f88f with SMTP id f20-20020a05600c4e9400b0039762abf88fmr2049905wmq.63.1653406068135;
        Tue, 24 May 2022 08:27:48 -0700 (PDT)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c1c9800b003974027722csm2703693wms.47.2022.05.24.08.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:27:47 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v7 0/6] Add LVTS architecture thermal
Date:   Tue, 24 May 2022 17:25:46 +0200
Message-Id: <20220524152552.246193-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch move thermal files related to Mediatek to the mediatek folder.
And introduce the new architecture LVTS (low pressure thermal sensor) driver to report
the highest temperature in the SoC and record the highest temperature sensor,
each sensor as a hot zone.
The LVTS body is divided into two parts, the LVTS controller and the LVTS device.
The LVTS controller can connect up to 4 LVTS devices, and each LVTS device
can connect up to 7 TSMCUs.

The architecture will be the first to be used on mt6873 and mt8192.

Change in v7:
        - Fix coding style issues
        - Rewrite dt bindings
          - was not accurate
          - Use mt8195 for example (instead of mt8192)
          - Rename mt6873 to mt8192
          - Remove clock name
        - Rebased on top of to series:
          - https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849
          - https://patchwork.kernel.org/project/linux-pm/list/?series=639386
Change in v6:
        - Remove temperature aggregation (it will be added in another series)
        - Update the way to read the temperature (read one sensor instead of all)
        - Add support of mt8195
Change in v5:
        - Use 'git mv' for the relocated file.

Change in v4:
        - Rebase to kernel-v5.13-rc1
        - Resend

Change in v3:
        - [2/3]
          - change the expression in the lvts_temp_to_raw to dev_s64.

Change in v2:
        - Rebase to kernel-5.11-rc1.
        - [2/3]
          - sort headers
          - remove initial value 0 of msr_raw in the lvts_temp_to_raw.
          - disconstruct the api of lvts_read_tc_msr_raw.
          - add the initial value max_temp = 0 and compare e.q.
            in the lvts_read_all_tc_temperature.
          - add the return with invalid number in the lvts_init.

This patch depends on [1], [2] and [3].

[1]https://patchwork.kernel.org/project/linux-mediatek/patch/20210524122053.17155-7-chun-jie.chen@mediatek.com/
[2]https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849
[3]https://patchwork.kernel.org/project/linux-pm/list/?series=639386

Alexandre Bailon (2):
  dt-bindings: thermal: Add binding document for LVTS thermal
    controllers
  arm64: dts: mt8195: Add efuse node to mt8195

Michael Kao (3):
  thermal: mediatek: Relocate driver to mediatek folder
  thermal: mediatek: Add LVTS drivers for SoC theraml zones
  thermal: mediatek: Add thermal zone settings for mt8195

Tinghan Shen (1):
  arm64: dts: mt8195: Add thermal zone

 .../thermal/mediatek,mt8192-lvts.yaml         |   81 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  121 ++
 drivers/thermal/Kconfig                       |   14 +-
 drivers/thermal/Makefile                      |    2 +-
 drivers/thermal/mediatek/Kconfig              |   33 +
 drivers/thermal/mediatek/Makefile             |    2 +
 .../{mtk_thermal.c => mediatek/soc_temp.c}    |    2 +-
 drivers/thermal/mediatek/soc_temp_lvts.c      | 1434 +++++++++++++++++
 drivers/thermal/mediatek/soc_temp_lvts.h      |  304 ++++
 9 files changed, 1981 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
 create mode 100644 drivers/thermal/mediatek/Kconfig
 create mode 100644 drivers/thermal/mediatek/Makefile
 rename drivers/thermal/{mtk_thermal.c => mediatek/soc_temp.c} (99%)
 create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.c
 create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.h

-- 
2.35.1

