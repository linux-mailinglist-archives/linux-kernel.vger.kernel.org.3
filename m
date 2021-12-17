Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA4B4783F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhLQEUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbhLQEUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:20:10 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91E6C061574;
        Thu, 16 Dec 2021 20:20:10 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id l18so949978pgj.9;
        Thu, 16 Dec 2021 20:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WXlXaQzQ+nfyK3zsVRGeFn4YVh8Bg3qKyVZtZQPRG+Q=;
        b=jpr4no+MdZr+tiCxsYI0JTilC48QiI4Rln1XP1lhrhq/aGjQhbhUdM7b2Tvdg/S5xF
         kfU3wS0R1slmczGsRZi8opS2qxTsLOFbzpI9w7CyAu/mFiSDAZA6fhw70rRuImTf3mxM
         UWBsCYa2QN3F3mAQ7FZgoeLLYJJAtRAkLBCxvyFmdQcYl4A1akBw+oF1LzbYplkG3N9w
         ctRuzJiLOJ+lprgD5KTm6wDYVLncFB6nQVlOYeL7l41PO70XfHg6b+EllgDia8IA3Cx7
         Nd71632sicRjx2CPxoDhzG16Nnl4zTXfVuAJUC5/BB7l5F9GUIkrLVbvfsw/T0G6+saf
         xtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WXlXaQzQ+nfyK3zsVRGeFn4YVh8Bg3qKyVZtZQPRG+Q=;
        b=YH7JnGFtNCReZ6xvAGBETrdgN8SXstfhtInsDcPaa5vUfvaGiiU/7NDhA8XBk33pZd
         9uGudoesioDEdoh4baStxpLqRkDFpXgtxzYamsxOrttMSFoF5gJ//pSRuS7F/1N5VGzM
         N4Wxlr/RNyPct0c6llE9nokvlo6O8Kz2gVZGeSvkLvH59PE/C4TukMg+miZvmG75KfmD
         TsKr0rzpU8uqe5N8OEZ9QwwoyBpy2u4fDo7pQFjpWaHmTLmwu/7eRESYJKxOFCtaL4Kx
         jJqWokOzNIGAtbBHBndrGaJ8mL9RShlp53Y3GkzzAio3/mynSQOEdHFK6e5sMJ4WE4l3
         fNSA==
X-Gm-Message-State: AOAM5315fqE/s4MT++zsFWFhg6XIudMhUu0ncn+3KXBxvqNdmLcs7tWO
        l3XhO2kLTU/AoTPn9c1YWUVizMyJy+0=
X-Google-Smtp-Source: ABdhPJwOMKCRXTbQlcDoh+2QnIwrqTxR94/znbwNVzvHpdBleP/ncp2gnAca4nMx6/kpLJ5IKuwQLw==
X-Received: by 2002:aa7:86c6:0:b0:4a4:ac66:99fc with SMTP id h6-20020aa786c6000000b004a4ac6699fcmr1120244pfo.83.1639714809820;
        Thu, 16 Dec 2021 20:20:09 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id mq10sm7553496pjb.3.2021.12.16.20.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:20:09 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [PATCH v4 0/6] Broadcom DT bindings updates to YAML
Date:   Thu, 16 Dec 2021 20:19:55 -0800
Message-Id: <20211217042001.479577-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

This patch series contains a number of device tree bindings being
converted to YAML to help with validation.

There will be second, and possibly third rounds later on after those
land in.

Thanks!

Changes in v4:
- removed the patches that have already been merged
- fixed errors in brcm,bcm7120-l2 binding
- added interrupt descriptions and comments to compatibles of
  brcm,gisb-arb
- added description of the 'phys' for BDC and dropped 'ref'
- combined all enums into a single one for brcm,sata-brcm,yaml

Changes in v3;

- added Gregorys' Acked-by to the GPIO binding patch
- added Uwe's Acked-by to the PWM binding patch
- fixed STB L2 binding to include the missing 2711 compatible string
  and interrupt-names property for 7445
- fixed the NSP SATA3 controller node unit name and added a missing
  check for the 63138 variant to check for the reset/reset-names
  property

Changes in v2:

- rebased against dt/next
- addressed Gregory's feedback on the GPIO binding change
- added Damien's Acked-by to the ATA binding patch

Florian Fainelli (6):
  dt-bindings: interrupt-controller: Convert BCM7120 L2 to YAML
  dt-bindings: interrupt-controller: Merge BCM3380 with BCM7120
  ARM: dts: NSP: Rename SATA unit name
  dt-bindings: ata: Convert Broadcom SATA to YAML
  dt-bindings: bus: Convert GISB arbiter to YAML
  dt-bindings: usb: Convert BDC to YAML

 .../bindings/ata/brcm,sata-brcm.txt           |  45 ------
 .../bindings/ata/brcm,sata-brcm.yaml          |  90 +++++++++++
 .../devicetree/bindings/bus/brcm,gisb-arb.txt |  34 ----
 .../bindings/bus/brcm,gisb-arb.yaml           |  66 ++++++++
 .../brcm,bcm3380-l2-intc.txt                  |  39 -----
 .../brcm,bcm7120-l2-intc.txt                  |  88 -----------
 .../brcm,bcm7120-l2-intc.yaml                 | 149 ++++++++++++++++++
 .../devicetree/bindings/usb/brcm,bdc.txt      |  29 ----
 .../devicetree/bindings/usb/brcm,bdc.yaml     |  49 ++++++
 MAINTAINERS                                   |   2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                |   2 +-
 11 files changed, 356 insertions(+), 237 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
 create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
 delete mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
 create mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.yaml

-- 
2.25.1

