Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5386749D0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbiAZRkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiAZRkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:40:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81425C06161C;
        Wed, 26 Jan 2022 09:40:23 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e8so449696wrc.0;
        Wed, 26 Jan 2022 09:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SMChCTUbPJn0KLnYEQbDS0l8nZYQGlwBBP39s3KW15U=;
        b=PaEx50NLhLlXA3wmwHxA2aMToislHAwBjJjzJOMha5pY7v81kRTxkPRZG/NNjkwO3V
         ICoe2j4ygbAqs0j5Ibmid1rcj9CeA6LDHKge+y7O4mXM5HflkC6ZSVtJDByyVWV9XuNW
         brt5Gl07qDdyiPycQrSncPBhqF8KIDtI6oIZQAT3vVfeOFFDyuQVPFif7fsBrcSxAhCn
         YTEgJpzV9jGVcGvoDQAepo+2/rJpXQG6fskfTmRrAdZYJxRQArNt3jpKO8gNchfLm1rZ
         JsGL3+hl/OkroNAznQllflUUQ1Ql1WaK3dilojKrRE03lQHOGeARgMGUwI59ezQBdidp
         crMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=SMChCTUbPJn0KLnYEQbDS0l8nZYQGlwBBP39s3KW15U=;
        b=BsKE6cHxL3Oc3TsCJIwUysj8hPq6DOxZ4RxfDDOhpDv016yyYWVW8VHflNlNqsaKgQ
         i8dLAZgN+bMFdjbf9ixJzuIjqQjXxQsLQMYM+LkMhko840lYQeUybf//GJZmiuIEJAhk
         SLKOEytgjUKLupTE9HGrcLjNGhdKemqrlqYgGFSFZ3pcJwnzNpCFtyw3b7QBdkk81R/4
         2BTnU7VpF+D63nJjvceFlS4xN/oGx9wP0jEPNSQ7pCx9V9lrt3hXNHz2Oyzg3sUGUZQm
         azGj/EYM9EKeYObhUMGmBt8Zkot2ogchCF6Ax52h8r6hOErK/PEUIHVtx5iwHn60LZWu
         oHdA==
X-Gm-Message-State: AOAM531NHZGhKgsnrTX10ONnwhSo1Nh9tPQFvqb8+oEwEy/XGizVcwt4
        tfM+UP7EzbT/CYmxF3mR6JGXVm1SGkU=
X-Google-Smtp-Source: ABdhPJxzoBn3jcJbGK4NJB2cliF2NaB5BbOcxNlWIxBP0o9ce6Rb+hT/x0vwp273Hmg0bRpydJpcDw==
X-Received: by 2002:adf:eac8:: with SMTP id o8mr22920992wrn.332.1643218822002;
        Wed, 26 Jan 2022 09:40:22 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y2sm3498451wmj.13.2022.01.26.09.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:40:21 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/7] JH7100 Audio Clocks
Date:   Wed, 26 Jan 2022 18:39:46 +0100
Message-Id: <20220126173953.1016706-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for the audio clocks on the StarFive JH7100
RISC-V SoC, although the first two patches are fixes to the original
addition of the basic clock driver. At least the first fix may be
considered for 5.17.

It turns out the SoC has several memory ranges for different clocks, but
they all share the layout of the control registers. This could be
modelled in 3 ways:

1) Model all the clocks as a single peripheral with multiple memory
   ranges and have a single driver for them all. 
2) Model each memory range as different, but related peripherals with a
   single driver handling all of them.
3) Model each memory range as different peripherals with separate
   drivers that can share most code.

Although the first option would require less code this series implements
the 3rd option. The basic clock driver has to be built-in to boot the
SoC, so separate drivers for the other registers means less code needs
to be built-in and can be left as loadable modules.

Emil Renner Berthing (7):
  clk: starfive: jh7100: Don't round divisor up twice
  clk: starfive: jh7100: Handle audio_div clock properly
  dt-bindings: clock: Add JH7100 audio clock definitions
  dt-bindings: clock: Add starfive,jh7100-audclk bindings
  clk: starfive: jh7100: Make hw clock implementation reusable
  clk: starfive: jh7100: Support more clock types
  clk: starfive: Add JH7100 audio clock driver

 .../clock/starfive,jh7100-audclk.yaml         |  57 ++++++
 MAINTAINERS                                   |   8 +-
 drivers/clk/starfive/Kconfig                  |   8 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jh7100-audio.c  | 170 +++++++++++++++++
 drivers/clk/starfive/clk-starfive-jh7100.c    | 176 +++++++++---------
 drivers/clk/starfive/clk-starfive-jh7100.h    | 112 +++++++++++
 .../dt-bindings/clock/starfive-jh7100-audio.h |  41 ++++
 8 files changed, 482 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7100-audclk.yaml
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7100-audio.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7100.h
 create mode 100644 include/dt-bindings/clock/starfive-jh7100-audio.h

-- 
2.34.1

