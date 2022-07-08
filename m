Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6434356BBB5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiGHOaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiGHOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:30:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69614B7DC;
        Fri,  8 Jul 2022 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657290604; x=1688826604;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vCfRMAR4q2AJjmu3oHG/GAe7cYHZVXN1npd6sTs+EHc=;
  b=hwrpi3Ikltk+29ioTNbYeYl83vGEcTyZir+0SpGfBJu+aeqhW27Mc8HT
   AN59uj7Jh7rZJX53N+pkL5T83qQdTarDCG+Hw4KSqkO6SSeXAjbhxIm4U
   /95EJhkUn2rDS97rzC5n21A0hDFFB8cN78a2VKlW1EuTPZXFUPgwaCqc1
   eQ5B68KShqS04PNeqat2UUueoFILCetLy7f+sYnlYoRKc3uHGSbPkGGJB
   22uKahqqFAWb98Af8uZ8zOZRusxhVwTl/PQxDkkpCQ0OKK8D/OOaoaY7z
   nClWyxEpO8hvywfvTXHS6ft3QugbCNOHOlraZyUpBUte6LlU6vtUaHWU5
   g==;
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="171609663"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 07:30:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 07:30:03 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 8 Jul 2022 07:30:01 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 0/4] Microchip soft ip corePWM driver
Date:   Fri, 8 Jul 2022 15:29:34 +0100
Message-ID: <20220708142937.1120121-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Uwe, all,

Added some extra patches so I have a cover letter this time.
You pointed out that I was overriding npwmcells in the driver and I 
realised that the dt & binding were not correct so I have added two
simple patches to deal with that. The dts patch I will take in my tree
once the binding is applied.

For the maintainers entry, I mentioned before that I have several
changes in-flight for it. We are late(ish) in the cycle so I doubt
you'll be applying this for v5.20, but in the off chance you do - I
would be happy to send it (with your Ack) alongside an i2c addition
that is "deferred".

In your review of v3, you had a lot of comments about the period and
duty cycle calculations, so I have had another run at them. I converted
the period calculation to "search" from the bottom up for the suitable
prescale value. The duty cycle calculation has been fixed - the problem
was exactly what I suspected in my replies to your review. I had to block
the use of a 0xFF period_steps register value (which I think should be
covered by the updated comment and limitation #2).

Beyond that, I have rebased on -next and converted to the devm_ stuff
in probe that was recently added & dropped remove() - as requested.
I added locking to protect the period racing, changed the #defines and
switched to returning -EINVAL when the period is locked to a value
greater than that requested.

Thanks,
Conor.

Conor Dooley (4):
  dt-bindings: pwm: fix microchip corePWM's pwm-cells
  riscv: dts: fix the icicle's #pwm-cells
  pwm: add microchip soft ip corePWM driver
  MAINTAINERS: add pwm to PolarFire SoC entry

 .../bindings/pwm/microchip,corepwm.yaml       |   4 +-
 MAINTAINERS                                   |   1 +
 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |   2 +-
 .../dts/microchip/mpfs-tysom-m-fabric.dtsi    |  18 +
 .../riscv/boot/dts/microchip/mpfs-tysom-m.dts | 185 +++++++++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-microchip-core.c              | 355 ++++++++++++++++++
 8 files changed, 574 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-tysom-m-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-tysom-m.dts
 create mode 100644 drivers/pwm/pwm-microchip-core.c


base-commit: 088b9c375534d905a4d337c78db3b3bfbb52c4a0
-- 
2.36.1

