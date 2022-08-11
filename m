Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7CB58F977
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiHKIpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbiHKIoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:44:54 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A718190C72
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:44:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x10so1021163ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ynpT2u7FSHsjUUbW/rTosphDOzEZ4ibPFW5PkzVc0cc=;
        b=7cMsM2ZGmT08GpiDMYW+Ucm2C8Wq1ba3l8M1fQY0wFlhRkgJXU0Y/j92/R3IZNia4L
         9MO8vS7suGciXw0Xq4jSTvGtIeYDanHitUMUjjEqhuQbz+fdJXXjfLfgEJFbpYbnwnaO
         Ck7xlqc/ClH4VXfQLmNJ6oE7QMCQ4WfS+XoblvLcj+H27zX4Eb3UWhD2+5PNy7OKcqPX
         FelnqQ2/n/T6p87fmiv5R7KnWFcZyg7Vj3CXyD5NHA6XPqSQb2VaBPNkNw7FQbU518t/
         O6w0CwIys1Ek3/Rv9G7gjOLU1xNtPN5SFvn5w17ZfI+mCJJaVv6t0QvxQ9k1mdOWEkFt
         FLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ynpT2u7FSHsjUUbW/rTosphDOzEZ4ibPFW5PkzVc0cc=;
        b=742KDAWNzwC1Ja2uyAZJAwLQ53bwAX/d4Xl5DGdnwbIqe+cJBBC9Lh18zPjVOsNo36
         HL0ZxHXqgyoSs9nj44JNlEmb7x/IQ4pOwA2F6ldXxrsgImK99ZKcP5GagufT0vSoF8in
         tL6iCaHFP/fLtokXq+Hhxu1ImK+o35c57QzVXcb7m618GaDAhs/6qZXcvH9T35kulPfj
         IRUbchuvuDz3M1xfMBV8SRiaLMxkYuYIHVEKzHFENmBZhwK+OHCnx4QzYQdCR4wCfkz0
         n8dlz1GN/hCDTjq8g3+z+I5Uxqj8vVKLW5D3mz9mvYjzlPzXa+FNQGeh1sW5PlaF8kPI
         yElg==
X-Gm-Message-State: ACgBeo3SZVo9ptsEw9CWI7QI/FeMreIk8Y+eokOQasR0M3oe5mIosds+
        FCGMGD62U3yb8kN0iNe2+sZbkvhe68/pjQ==
X-Google-Smtp-Source: AA6agR41NqYZDGykDDjqTUYpGVxwq4m0Fa6wrajT2ypGNG2Kpp29w64LKpS46XhbgoSwniJNqNZOlQ==
X-Received: by 2002:a17:906:8445:b0:730:ba5a:ef59 with SMTP id e5-20020a170906844500b00730ba5aef59mr24540364ejy.182.1660207480710;
        Thu, 11 Aug 2022 01:44:40 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a243:8036:200c:a862:4253:884])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7d5cf000000b0043d6ece495asm8799314eds.55.2022.08.11.01.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 01:44:40 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <parent.f@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 0/4] clk: mediatek: Add mt8365 support
Date:   Thu, 11 Aug 2022 10:44:29 +0200
Message-Id: <20220811084433.2598575-1-msp@baylibre.com>
X-Mailer: git-send-email 2.36.1
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

Hi,

This series adds a clock driver for the mt8365 SoC. I took over the series from
Fabien who posted v1 and v2.

Thanks you Angelo for the feedback on v2. I think I fixed everything you
mentioned.

Changes are listed in the individual patches.

Best,
Markus

v2 - https://lore.kernel.org/linux-mediatek/20220530214434.1012889-1-fparent@baylibre.com/

Fabien Parent (2):
  dt-bindings: clock: mediatek: add bindings for MT8365 SoC
  clk: mediatek: add driver for MT8365 SoC

Markus Schneider-Pargmann (2):
  clk: mediatek: Provide mtk_devm_alloc_clk_data
  clk: mediatek: Export required common code symbols

 .../bindings/clock/mediatek,mt8365-clock.yaml |   42 +
 .../clock/mediatek,mt8365-sys-clock.yaml      |   47 +
 drivers/clk/mediatek/Kconfig                  |   50 +
 drivers/clk/mediatek/Makefile                 |    7 +
 drivers/clk/mediatek/clk-gate.c               |    1 +
 drivers/clk/mediatek/clk-mt8365-apu.c         |   55 +
 drivers/clk/mediatek/clk-mt8365-cam.c         |   57 +
 drivers/clk/mediatek/clk-mt8365-mfg.c         |   63 +
 drivers/clk/mediatek/clk-mt8365-mm.c          |  112 ++
 drivers/clk/mediatek/clk-mt8365-vdec.c        |   63 +
 drivers/clk/mediatek/clk-mt8365-venc.c        |   52 +
 drivers/clk/mediatek/clk-mt8365.c             | 1155 +++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                |   37 +-
 drivers/clk/mediatek/clk-mtk.h                |    2 +
 .../dt-bindings/clock/mediatek,mt8365-clk.h   |  373 ++++++
 15 files changed, 2111 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8365-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8365-sys-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8365-apu.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt8365-clk.h

-- 
2.36.1

