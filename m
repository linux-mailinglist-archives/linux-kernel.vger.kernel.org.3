Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB6F571C63
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiGLO0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiGLO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:26:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E1CB5D1F;
        Tue, 12 Jul 2022 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657635966; x=1689171966;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kfIGPvcZH8e51YL7+dp1o1wepCSIA0xgTOM+PfQaX7k=;
  b=Qkh/Fdjdk3OZjrM4MsOi2uVXEOR8CR2hd9piOAlW1jzgVsfxirRw4Cfy
   dzfstfGh7qG3GTWAKRjXDwBJq/QVtgqATrYF2J9s0bYDpSCUzfJlLqQu6
   xgQqmNUBftgoQ3Xf+rViRMeI24crwO8fdngHWRHrQM4YGXecqqu//9LtA
   UIJwwZ+zRRwfIWoYEGAXKmDCqKYNDfzONQDKQWLx0vfMe287xLBHufSHV
   JiWnVH6HiqvzB6GvVCOSzPzRXmZsOzu2OOXPyycuZyKCeZOWUkeb8m97Q
   dCE8CsMaUiYUsZ7t8utj6PlvSvJV2HvIcgmREOoPkytIFbBkAAnzGl5P0
   g==;
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="172054798"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2022 07:26:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Jul 2022 07:26:05 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 12 Jul 2022 07:26:03 -0700
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
Subject: [PATCH v6 0/4] Microchip soft ip corePWM driver
Date:   Tue, 12 Jul 2022 15:25:53 +0100
Message-ID: <20220712142557.1773075-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
that is "deferred". I rebased it today on top of an additional change
so it may not apply for you.

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

Changes from v5:
- switched to a mutex b/c we must sleep with the lock taken
- simplified the locking in apply() and added locking to get_state()
- reworked apply() as requested
- removed the loop in the period calculation (thanks Uwe!)
- add a copy of the enable registers in the driver to save on reads.
- remove the second (useless) write to sync_update
- added some missing rounding in get_state()
- couple other minor cleanups as requested in:
https://lore.kernel.org/linux-riscv/20220709160206.cw5luo7kxdshoiua@pengutronix.de/

Changes from v4:
- dropped some accidentally added files

Conor Dooley (4):
  dt-bindings: pwm: fix microchip corePWM's pwm-cells
  riscv: dts: fix the icicle's #pwm-cells
  pwm: add microchip soft ip corePWM driver
  MAINTAINERS: add pwm to PolarFire SoC entry

 .../bindings/pwm/microchip,corepwm.yaml       |   4 +-
 MAINTAINERS                                   |   1 +
 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |   2 +-
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-microchip-core.c              | 370 ++++++++++++++++++
 6 files changed, 386 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pwm/pwm-microchip-core.c


base-commit: 734339e5c1c46e3af041b4c288c213e045e34354
-- 
2.36.1

