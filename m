Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FBC59ABFD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343758AbiHTHRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243618AbiHTHRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:17:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEDEC6526;
        Sat, 20 Aug 2022 00:17:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id g8so1924970plq.11;
        Sat, 20 Aug 2022 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=tiWN3Tg8ccjmVvqr90gf5NMhps8BOid12A7i1GTF99Q=;
        b=lRxVSoTELfA+v7Mi/OGz5h1My6Juy9x9ab0DzifkNU+5Suvk10dk3DSbNaPrjWh5Vf
         LtQtX67i5bhzumqvfAk9R/3XDYE4Zw/QH56B2nayo1kQW/YrN0zjYrVz4jQrn+pVUN50
         jlsnGHDHLqi8/wxD1nmw5RNjHZhqZi3VFzqjV8oihTVC7m+n8WTlck1KVXOy6+Flikxq
         DpT6W3mj/+x8QWppk1kab/y4q8RCDapPbJcysUIx8kdpKlzRXRZNFWCA8yvc3zzrWA+V
         jvLDrPdkkAlF3trr/foRUR5naK/FGMivJ8pmMa95YX3PZ6wp98jFHu4UC6TyJ5LnlOou
         lAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=tiWN3Tg8ccjmVvqr90gf5NMhps8BOid12A7i1GTF99Q=;
        b=RZe4S7pkxrrJXH/y0pBMuJFG6fcRgBPCAD6gmWf85SklOGZlcl9e1XL8dYBY5UxiDJ
         B3F2S12EPiymsBZ94qe9OY6x4/qZanXpkAqos6Se8bchY7mZdX3yhjsmOPx+JCXC/1By
         vlqCm9AEi6GhmD1xqaFs5dyukjDuvLh9Vin/gtSgjJtjakjSs38o2qZfMTIxsAH5bJqX
         NGzY6FwfAX1PCK27kak5JdndTaWpk68umwC+9qnvNVrAzQBHeN+HnmBvRrmua00JvPp9
         FdlLFk55bUZpNLfutBojs+wO0jQpv4wJb43AP9xsRJ4SJQShccCRxIST/1ip7R9ghtZT
         DNPg==
X-Gm-Message-State: ACgBeo2RTzgA+Xsgcg7AqN7jvmDjWNT8FVA8jBKlPI5ZVV5NuhKGGe9t
        uk76FsbFBXQoSwFhjQoD/Mr/oZxSavWwtzMLZu4=
X-Google-Smtp-Source: AA6agR4759y9SRpgFsZRrkU8UKb9i8Maz87PVIpulGijhE+rZRTZKrky3ehLbyAaqtqCNeKOi0rWKA==
X-Received: by 2002:a17:90b:380f:b0:1f5:55ef:a53a with SMTP id mq15-20020a17090b380f00b001f555efa53amr12110165pjb.14.1660979832641;
        Sat, 20 Aug 2022 00:17:12 -0700 (PDT)
Received: from mithil.localdomain ([103.19.226.223])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a694f00b001faf273e4afsm1459019pjm.35.2022.08.20.00.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 00:17:11 -0700 (PDT)
From:   Mithil Bavishi <bavishimithil@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, sre@kernel.org,
        tony@atomide.com, linux@armlinux.org.uk, bavishimithil@gmail.com,
        contact@paulk.fr
Subject: [PATCH 00/10] Add TWL6030 power off and powerbutton support
Date:   Sat, 20 Aug 2022 12:46:50 +0530
Message-Id: <20220820071659.1215-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patchset is based off on an earlier series of patches submitted
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1110053.html
It adds support for power off to the TWL6030 chipset, adds power button
support to the TWL6030 chipset, moves power driver to the correct
location, clean up in code from the original patch.

Thanks, Mithil

Mithil Bavishi (6):
  power: reset: Move TWL4030 power driver from mfd
  dt-bindings: power: reset: Move twl4030-power from mfd to power/reset
  dt-bindings: input: twl-pwrbutton: Add support for twl6030-pwrbutton
  dt-bindings: power: reset: Add bindings for twl6030-power
  input: misc: Rename twl4030_pwrbutton to twl_pwrbutton
  dt-bindings: input: Rename twl4030-pwrbutton to twl-pwrbutton

Paul Kocialkowski (4):
  power: reset: Add TWL6030 power driver, with minimal support for power
    off
  ARM: OMAP2+: Only select TWL4030_POWER for OMAP3
  ARM: OMAP2+: Select TWL6030_POWER for OMAP4
  input: misc: Add TWL6030 power button support to twl-pwrbutton

 ...wl4030-pwrbutton.txt => twl-pwrbutton.txt} |  5 +-
 .../{mfd => power/reset}/twl4030-power.txt    |  0
 .../bindings/power/reset/twl6030-power.txt    | 31 +++++++
 arch/arm/boot/dts/twl6030.dtsi                |  5 +
 arch/arm/configs/omap2plus_defconfig          |  2 +-
 arch/arm/mach-omap2/Kconfig                   |  3 +-
 drivers/input/misc/Kconfig                    |  8 +-
 drivers/input/misc/Makefile                   |  2 +-
 .../{twl4030-pwrbutton.c => twl-pwrbutton.c}  | 75 ++++++++++-----
 drivers/mfd/Kconfig                           | 13 ---
 drivers/mfd/Makefile                          |  1 -
 drivers/power/reset/Kconfig                   | 22 +++++
 drivers/power/reset/Makefile                  |  2 +
 drivers/{mfd => power/reset}/twl4030-power.c  |  0
 drivers/power/reset/twl6030-power.c           | 93 +++++++++++++++++++
 include/linux/mfd/twl.h                       |  1 +
 16 files changed, 217 insertions(+), 46 deletions(-)
 rename Documentation/devicetree/bindings/input/{twl4030-pwrbutton.txt => twl-pwrbutton.txt} (72%)
 rename Documentation/devicetree/bindings/{mfd => power/reset}/twl4030-power.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/power/reset/twl6030-power.txt
 rename drivers/input/misc/{twl4030-pwrbutton.c => twl-pwrbutton.c} (55%)
 rename drivers/{mfd => power/reset}/twl4030-power.c (100%)
 create mode 100644 drivers/power/reset/twl6030-power.c

-- 
2.25.1

