Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F22482C2B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 17:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiABQ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 11:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiABQ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:57:37 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C29C061761;
        Sun,  2 Jan 2022 08:57:36 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s1so65680746wra.6;
        Sun, 02 Jan 2022 08:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25JkROX6gojJhcdHgWizUk7fewqW48hRlaaUSldwQSI=;
        b=jL2f9pfGvgy8SroBc5A0PM/XjnmhAXbMbFpGuHnoiSG1dguRez9b5xHOX3RXzKbrI2
         Ml0pcNy41928o/e7IAQAosJPIgFOhwSjtXHv6FlyEuHRGigyCZmQnHVnQISvRcfV0Fv5
         r9oJBW9YjaWDKlyiE6K4JkA6byL/KcFN3OK35LsRgAZ1IL+xMArCe6+I3IBAi7wdZNld
         nnIiVAidP+X5Obu8eqazXBNK8i1vakwD8tgjyEaL2Z2RlZsvy0q69CQ3KyDvIp+CPGFG
         5S7OntyQ+RjCch9RgOYb9KxoTpwafUdRr5vH9I28NhyuBBkZuYMs52CyQk40xdoIIlWl
         Htqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25JkROX6gojJhcdHgWizUk7fewqW48hRlaaUSldwQSI=;
        b=DvrhT2XVczblKfkb4vJ3HCvRN2mKaGG7gQNbg1EcV81Ah+hPJhgfYiBr0Ee2eTilHs
         DjAJfkhNXJFGdJMJiyQ4dSvUtJaYezYzMGOVrSGfJjZHEsyMd/MG5463JSx2vuc5pnHz
         SRPVlTVqdqOGPzcwQIYAVE/nSWtoQB1cXH5oX7YaqzviCihyyT/B+UBoAw9QwBBlgdeX
         nlutB6c2wo1AII08WiapnT345Hz3HyaOu3ZmKfq3V0H0++3lkme0uZUlU8k9hbS49Wa6
         XsXwxz3UQJ/B9CUUDKfFXcvh6kpnq7py1WCVKCNtxtS5fknyW8xDr4pFOoBcyJrbmSkl
         Fskw==
X-Gm-Message-State: AOAM531e9JPDwpdDxqADs0y9RQwvsiyCFVtYjCRpM7cqi6LfuYXrSD8+
        2FaTZCCzbDAeY930bH6l2DUX+mbgOVGmXQ==
X-Google-Smtp-Source: ABdhPJxGwq1Y7VN8FC0d/3vmrGWOxmgJl9QgbHs6TBo9OgfpAG06Jxsn3mPHPcS9QIPjtyACqA08IA==
X-Received: by 2002:adf:eb12:: with SMTP id s18mr5174441wrn.717.1641142654717;
        Sun, 02 Jan 2022 08:57:34 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id m5sm31153335wml.48.2022.01.02.08.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 08:57:34 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] ARM: mstar: cpupll
Date:   Sun,  2 Jan 2022 17:57:21 +0100
Message-Id: <20220102165730.50190-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a basic driver for the PLL that generates
the cpu clock on MStar/SigmaStar ARMv7 SoCs.

Unfortunately there isn't much documentation for this thing
so there are few magic values and guesses.

This needs to come after the MPLL DT changes.

Changes since v2:
- Re-worked the series and ensure that 'make dt_binding_check' passes.
  The required commit is merged now, so it is okay.
- Fixed coding style issues in the driver and makes check_patch.pl happy
- Added one more commit for extending the opp_table for infinity2m.

Daniel Palmer (8):
  dt-bindings: clk: mstar msc313 cpupll binding description
  clk: mstar: msc313 cpupll clk driver
  ARM: mstar: Add cpupll to base dtsi
  ARM: mstar: Link cpupll to cpu
  ARM: mstar: Link cpupll to second core
  ARM: mstar: Add OPP table for infinity
  ARM: mstar: Add OPP table for infinity3
  ARM: mstar: Add OPP table for mercury5

Romain Perier (1):
  ARM: mstar: Extend opp_table for infinity2m

 .../bindings/clock/mstar,msc313-cpupll.yaml   |  45 ++++
 arch/arm/boot/dts/mstar-infinity.dtsi         |  34 +++
 arch/arm/boot/dts/mstar-infinity2m.dtsi       |  17 ++
 arch/arm/boot/dts/mstar-infinity3.dtsi        |  58 +++++
 arch/arm/boot/dts/mstar-mercury5.dtsi         |  36 +++
 arch/arm/boot/dts/mstar-v7.dtsi               |   9 +
 drivers/clk/mstar/Kconfig                     |   7 +
 drivers/clk/mstar/Makefile                    |   1 +
 drivers/clk/mstar/clk-msc313-cpupll.c         | 227 ++++++++++++++++++
 9 files changed, 434 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.yaml
 create mode 100644 drivers/clk/mstar/clk-msc313-cpupll.c

-- 
2.34.1

