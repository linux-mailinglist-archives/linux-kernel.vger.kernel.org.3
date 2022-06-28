Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E055E392
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbiF1MpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiF1MpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:45:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0C11D0DC;
        Tue, 28 Jun 2022 05:45:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z19so17350163edb.11;
        Tue, 28 Jun 2022 05:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NSdZnX0hvMtHWH81+COi+h5G1VU1bB160uGR/aWIxoc=;
        b=ZuwUCgXkzV6GPaEzIaa25s+tFkgTNnNH/N4tpQWEToYTlYJTB2+H0vKOPlpqc+We/I
         9muIHC4zfx+RqpIhwaI4nFIqST44WUDJQOwINb/y6HM/jRPb+CEUXou6Ao1ngrOilOHR
         3FqdfmwQLHkaxr9Pb1/THb2yqeTJ80DJAUrQyJCAXhPYbykj7sNqB5nkjD7M29c1T6Wx
         fXXp960dzrvdMHFQtPDkShyvp3zCmYGw7AsCIwU1PECpo2tA2ehZYj6USB4QiSNlF7fi
         WHTst0bWB6bP8eBUpOgf5Z8/x1trm9fDjlxcR86KGw7JgSVl/PakEFnoRrCj+7OmAUXN
         /K5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NSdZnX0hvMtHWH81+COi+h5G1VU1bB160uGR/aWIxoc=;
        b=dA8/K9OpK0onIfVe/D5OaJ6cgmLbAQ8x3KNr50YJKsrv4VopfQt/bwqDGYp/VFioG4
         Ima9n+yZ1GPj+U43abOHMz30eVC4WWBVL3gMUlsf2UWJtFwzkh/BedGsr2sC2y0ZILHJ
         ufozkorXy5nbWoEVMYAoOycJyI9vulSi/bxyT23t8HPszHH1g7YMz4NQ+oj/jYHy60GF
         /757rFKth9fyWnmkuSqg/7rV6J9+WqBsQUufYywsVhTSzuHyqGhfdl5L2lBoa9WJupY7
         wFo5N6JAsFf+2F+eKajWrrjJA8z/Gp7Jfdo6/OkE4TkfYQn5v1hvsmGcu2owgZCzjPN4
         TpLw==
X-Gm-Message-State: AJIora/wqifllP3xfpULO5L1Wg/c8/xIaWjNITc4qiI7DrsNyEZAyJDN
        gvwl1IAehzP9XuFIwHir1HA=
X-Google-Smtp-Source: AGRyM1t5437mq08RGvn4Hh37j6wWEZKSJ9YjRbyOr1AGeK+h/hUdNQ8ChmJv6Ixh2qm6pxEZIj9wvA==
X-Received: by 2002:a05:6402:2786:b0:435:da07:14cb with SMTP id b6-20020a056402278600b00435da0714cbmr22792909ede.408.1656420316598;
        Tue, 28 Jun 2022 05:45:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm622871ejx.173.2022.06.28.05.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:45:16 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, rtanwar@maxlinear.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 0/9] reset: replace reset-lantiq with reset-intel-gw
Date:   Tue, 28 Jun 2022 14:44:32 +0200
Message-Id: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in the discussion when the reset-intel-gw driver was added it came up
that the IP in the Intel LGM SoCs is backwards compatible with the older
Lantiq SoCs. This series removes the reset-lantiq driver and replaces it
with the reset-intel-gw driver.

The transition is relatively straight forward:
- compatible strings from the old bindings (from
  Documentation/devicetree/bindings/mips/lantiq/rcu.txt) are moved over
  to intel,rcu-gw.yaml
- missing compatible strings (for Amazon-SE, Danube and xRX100) are
  added directly to intel,rcu-gw.yaml
- update the driver to map the registers using syscon on legacy SoCs as
  some RCU registers are shared with various peripherals (there's nested
  USB PHYs and other peripherals have endianness configuration registers
  in the RCU register space)
- update the .dts(i) files (I already prepared patches for downstream
  OpenWrt, which is the only known user of these SoCs)

Patch #3 (dt-bindings for the reset controller) depends on patch #1
(dt-bindings for the USB2 PHYs). I think it would be easiest to also
take patch #1 through the reset tree since it's a simple txt -> yaml
conversion.
If needed I can send patch #9 separately so it can go through the MIPS
tree.

PS: I Cc'ed Rahul Tanwar who has previously stepped up as a maintainer
for the drivers on the Intel LGM SoCs, which is where the reset-intel-gw
driver was introduced. He's now with MaxLinear who took over Intel's
AnyWAN department (where the LGM SoCs were developed) in 2020.


Martin Blumenstingl (9):
  dt-bindings: phy: lantiq: xway-rcu-usb2-phy: Convert to YAML
  dt-bindings: reset: intel,rcu-gw: Allow up to three global reset items
  dt-bindings: reset: intel,rcu-gw: Update bindings for "legacy" SoCs
  dt-bindings: mips: lantiq: rcu: Remove binding documentation
  reset: intel: Allow enabling the driver on "LANTIQ" (MIPS) platforms
  reset: intel: Add and update compatible strings Lantiq SoCs
  reset: intel: Use syscon_node_to_regmap on legacy SoCs
  reset: lantiq: Remove driver as it has been replaced by reset-intel-gw
  mips: dts: lantiq: Update the RCU node to match the intel,rcu-gw
    binding

 .../devicetree/bindings/mips/lantiq/rcu.txt   |  69 ------
 .../phy/lantiq,xway-rcu-usb2-phy.yaml         |  68 ++++++
 .../bindings/phy/phy-lantiq-rcu-usb2.txt      |  40 ----
 .../bindings/reset/intel,rcu-gw.yaml          |  88 +++++++-
 arch/mips/boot/dts/lantiq/danube.dtsi         |  20 +-
 drivers/reset/Kconfig                         |  11 +-
 drivers/reset/Makefile                        |   1 -
 drivers/reset/reset-intel-gw.c                |  36 ++-
 drivers/reset/reset-lantiq.c                  | 210 ------------------
 9 files changed, 197 insertions(+), 346 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
 create mode 100644 Documentation/devicetree/bindings/phy/lantiq,xway-rcu-usb2-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
 delete mode 100644 drivers/reset/reset-lantiq.c

-- 
2.36.1

