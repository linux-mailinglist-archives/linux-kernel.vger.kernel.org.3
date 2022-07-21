Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E7257D255
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiGURV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGURVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:21:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981DB2B611
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:21:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b26so3231407wrc.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CmRxLVY9HuAG01Hu57i7xdSoJXhylPjj1q4eOpHaFLo=;
        b=bTWUL7ViGNTVsC1FoDdx7RIkNJcFCZWlEiGsHbnuE+6RcUfQUpWssDkNFN/E4Dx2wc
         S4QXVjfjyFqP9+KLSIg5alE48GBHoasHbTMPJJ0c97khOC+DXmIWPq2rA3KGqSRTo7p4
         n8mLzpupa6zIRkP3mXzEPKc7oNuUDwZQS6IeeCevOwLeEEHk0HGihjt1E4h2e/ZsCPSr
         OFWfOIOnC57+2bM9UB5fjBwRAyLdAL0Ufmt8j/AnA31QIl/1DKwDTY+jF3XJm5y3dAaT
         MGToqoriWdQxlLDA6F/h5BRFAtA7/i6u7VNrC/qJ30AmrwL441/sKzUFEs3LtvjdWtel
         zT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CmRxLVY9HuAG01Hu57i7xdSoJXhylPjj1q4eOpHaFLo=;
        b=D0DSKfLhui740D0u9LPle5upoHsWN/DEKAwiXwl0cB7NdLAdcSg3bNHSTg/9nHV2rG
         IJE2lLSmjN976YQ9ET99bhCnlvKsmu06SFYgyKUyHPaYZ/2HdS0k48/n55yEx08aX7Eg
         u5kHsBBqzFaNqLcBNNUhTQa4fmaZ5IcLahqlBg5IT+8mJXY3At9Md/+xFnMtjqogh+bV
         +Ul4L2DS2g2MZ2pZ+PNeDaa7nt9D5x2EQ2FssBED9mwUdop6dwGrBFbVUIfRKIvrqtoh
         hqP9r+GIvRKZnjZqrB+T4ZWyf3djCNcn5oV/dRpbimtzjhtnl2Fmrnh2VjfMk2icWiz4
         nnUQ==
X-Gm-Message-State: AJIora+k4x8NMRfdYwpIm5T4XRXFMyDSojKfzRvPMwJLVcAxN0s10nmX
        DRgtIc5h2C9d/fKthvOO+ooWEw==
X-Google-Smtp-Source: AGRyM1teRPSq/gbNJAmKT5r8AGTamBTGc9+ZMkZBVbSD6pG2a1PnAJYJzQxDdZRMi/sHSn+IxunABg==
X-Received: by 2002:a05:6000:719:b0:21e:4530:c558 with SMTP id bs25-20020a056000071900b0021e4530c558mr8808003wrb.243.1658424081913;
        Thu, 21 Jul 2022 10:21:21 -0700 (PDT)
Received: from henark71.. ([109.76.125.251])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003a2cf1535aasm2455697wme.17.2022.07.21.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:21:21 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     u.kleine-koenig@pengutronix.de
Cc:     conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, thierry.reding@gmail.com
Subject: [PATCH v7 0/4] Microchip soft ip corePWM driver
Date:   Thu, 21 Jul 2022 18:21:06 +0100
Message-Id: <20220721172109.941900-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Hey Uwe, all,

(~same cover as v5)

Added some extra patches so I have a cover letter this time.
You pointed out that I was overriding npwmcells in the driver and I
realised that the dt & binding were not correct so I have added two
simple patches to deal with that. The dts patch I will take in my tree
once the binding is applied.

For the maintainers entry, I mentioned before that I have several
changes in-flight for it. We are late~(ish)~ in the cycle so I doubt
you'll be applying this for v5.20, but in the off chance you do - I
would be happy to send it (with your Ack) alongside an i2c addition
that is "deferred". I rebased it ~today~ on top of an additional change
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

I'll take the dts change myself once the rest is merged.

Thanks,
Conor.

Changes from v6:
- Dropped an unused variable that I'd missed
- Actually check the return values of the mutex lock()s
- Re-rebased on -next for the MAINTAINERS patch (again...)

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
 drivers/pwm/pwm-microchip-core.c              | 371 ++++++++++++++++++
 6 files changed, 387 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pwm/pwm-microchip-core.c


base-commit: a3fd3ca134d9485a0f9a7bdcffd7f8bae27f79d3
-- 
2.37.1

