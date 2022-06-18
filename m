Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B47B550479
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 14:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiFRMcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 08:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiFRMcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 08:32:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C51B7BB
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 05:32:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q9so8799732wrd.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxrfrrOtT2Oa/bD+7FBstHMfLsi5+SmAhxAWzjAkyZ0=;
        b=S2mJhG/EP2bvAoovp3+1EX915fqgCN7s5TTHRtk6gjrtEqOI/5G9b2iqkP8Hp2fPJT
         Xv7w9JM5mIzSBmUBnG5veKqEPc/MaxIruLrav0YlVhnIQlMG/M+wTnbgpcN0tcmr+tr2
         or89IY4gglZ6yWfGfoA+jfJEq4JsK9dvMaD2rRItnHWPYoJkG7IkTqJN1pM8cYB5TpdM
         9bGqfIt5FOQFRPbbNCxOn37acP1sIBQPp6tl26reXViVZmDuywOt0O5V9tWi+koaQg4c
         DJEmvefmmDhAvEMjrhz9P1n7uaAObdu8xiUcENoorbn9u8vIjZNy1IW7RHROc+mSnsUJ
         yKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxrfrrOtT2Oa/bD+7FBstHMfLsi5+SmAhxAWzjAkyZ0=;
        b=sgnKCvTEqh7Vkg4Z5ARHRUSYW9rnXFvQ2/+54kMKfXIdeRZhIHtAQ07MbfRcnGRIuH
         ncJC71/N3FNKbmvqP7p3XTLf8HkQRpFzyLzKNY2J3tJBFHkw0aEJtbqv3PM1DGtZaFhc
         6wYWp9K54lzqzEB/elUHE29DA/PcADeQS8wto4p6orSrbhBD03pjjX6DLPQzDUwzHxMq
         iuxq1r2w6Sl+Fs47yCUFgBaQqrGuZbtbjBfbJtZUfr3Ne++Ouyi3b3PT7X9zcSZsUM1g
         vLwcuHAed50r315xGSvRchSz6tZz6hQy83bEPaPAMEaa5yqbGKKwxBJk03neA/5CMv6c
         0TZg==
X-Gm-Message-State: AJIora92ZusbHE0X7g/x6WDvu6Kz6ZAdHhq1iVNfbO9H7Fa3EyqztpQu
        9ycko+wEaOqDuJvoc7poSwD+zg==
X-Google-Smtp-Source: AGRyM1vo09vBquhwF3XuUkIoGOLL2MXJBKKEyvgcE2QTAi/5UKplOA45WdH+tRLIApC05LNQOZn4qQ==
X-Received: by 2002:adf:fd0f:0:b0:210:32d7:4cb5 with SMTP id e15-20020adffd0f000000b0021032d74cb5mr13971427wrr.565.1655555519244;
        Sat, 18 Jun 2022 05:31:59 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm9292305wrb.45.2022.06.18.05.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 05:31:58 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 00/14] Canaan devicetree fixes
Date:   Sat, 18 Jun 2022 13:30:22 +0100
Message-Id: <20220618123035.563070-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Hey all,
This series should rid us of dtbs_check errors for the RISC-V Canaan k210
based boards (well, unless you enable W=1 but that's another days work).
I *DO NOT* have any Canaan hardware so I have not tested any of this in
anger. I based the series on next-20220617.

For the bindings, I am never sure about which of {unevaluated,additional}
Properties is correct to use, but the if statements in the binding didn't
work with additional so I used unevaluated...

@Mark, for your two bindings I was not sure about the properties that I
made depend on the compatible, but I looked in tree and was not able to
find other users to contradict what's in the Canaan devicetrees nor did
I get that much help from their docs.

@Rob, yesterday's removal of ilitek,ili9341.txt is moved to ths series
since I was editing the dt-schema binding here anyway.

Finally, @Palmer:
This + Atul's stuff + the sifive dts watchdog patch will get us sorted
in terms of dtbs_check errors. To make keeping it that way a little
easier, I changed the Canaan devicetree Makefile so that it would build
all of the devicetrees in the directory if SOC_CANAAN. Hopefully someone
with a device can test it - but my build log *looked* fine but that's
not exactly sufficient.

Thanks,
Conor.

Conor Dooley (14):
  dt-bindings: display: convert ilitek,ili9341.txt to dt-schema
  dt-bindings: display: panel: allow ilitek,ili9341 in isolation
  ASoC: dt-bindings: convert designware-i2s to dt-schema
  dt-bindings: dma: add Canaan k210 to Synopsys DesignWare DMA
  dt-bindings: timer: add Canaan k210 to Synopsys DesignWare timer
  spi: dt-bindings: dw-apb-ssi: update spi-{r,t}x-bus-width for dwc-ssi
  riscv: dts: canaan: fix the k210's memory node
  riscv: dts: canaan: add a specific compatible for k210's dma
  riscv: dts: canaan: add a specific compatible for k210's timers
  riscv: dts: canaan: fix mmc node names
  riscv: dts: canaan: fix kd233 display spi frequency
  riscv: dts: canaan: use custom compatible for k210 i2s
  riscv: dts: canaan: remove spi-max-frequency from controllers
  riscv: dts: canaan: build all devicetress if SOC_CANAAN

 .../bindings/display/ilitek,ili9341.txt       | 27 ------
 .../display/panel/ilitek,ili9341.yaml         | 60 ++++++++----
 .../bindings/dma/snps,dw-axi-dmac.yaml        | 35 +++++--
 .../bindings/sound/designware-i2s.txt         | 35 -------
 .../bindings/sound/snps,designware-i2s.yaml   | 93 +++++++++++++++++++
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 48 +++++++---
 .../bindings/timer/snps,dw-apb-timer.yaml     | 28 ++++--
 arch/riscv/boot/dts/canaan/Makefile           | 10 +-
 arch/riscv/boot/dts/canaan/canaan_kd233.dts   |  4 +-
 arch/riscv/boot/dts/canaan/k210.dtsi          | 25 ++---
 .../riscv/boot/dts/canaan/sipeed_maix_bit.dts |  2 +-
 .../boot/dts/canaan/sipeed_maix_dock.dts      |  2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_go.dts |  2 +-
 .../boot/dts/canaan/sipeed_maixduino.dts      |  2 +-
 14 files changed, 239 insertions(+), 134 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml


base-commit: 07dc787be2316e243a16a33d0a9b734cd9365bd3
-- 
2.36.1

