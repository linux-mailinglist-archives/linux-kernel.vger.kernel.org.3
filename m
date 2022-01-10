Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6E7489709
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244486AbiAJLKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244454AbiAJLKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:10:41 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E52C061748;
        Mon, 10 Jan 2022 03:10:40 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a5so22086507wrh.5;
        Mon, 10 Jan 2022 03:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZgEF3a2cVPPnAn+Sv90zHeceQXR4/tutb38weJ7N6M=;
        b=lDOIZjh9fNoHufgFTYc4oRDdLFKYF4jZL5ZYjuOIjS4aIMgS95OVrnozxdBDhX83vR
         fro6oRqqt27vr1xpRgsi7xFBu9uPw972TFeNW6+RS2ajtFCLzaufJrGIdxS+QGW/nnAY
         mGQdR0SUZWjQkDrXpPgE0cY0Pu9vR85t8wBhEv2eUnkmFpKtBfb8r7QX76jGDZ+reN/Q
         opp10wv7TgBzUGseENNb0u6S4fM9kTk17wZxxHuku5wDimCrDjzOYiB2jSXCnC/Ls9C2
         YJiKxxGPpXWIbpyWIV2QM/4BdkvQxFGtUAtcBIWlulsnJpQnQIjm8Q8TXSZEQ82UetuT
         cRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZgEF3a2cVPPnAn+Sv90zHeceQXR4/tutb38weJ7N6M=;
        b=L07LXZnY20yYerSBEvLbgsEYhOzVMCiDYJenfWwcVvY5SwfDrdTV4jxvVnjLhjsrPF
         /C6imnkKfmMr+BTc2ZjSuARsgtVh8ftyFhn33F47o9k25mBzhdh3lQcoBmQae+5nBV05
         cZwoSaiVl+sHPuvarXqHEXgsaBJLiOYfOVyGZCtwSylZVD5M9/KGG4oDt1tuvA4RKZTr
         UdDtC3s6u3B9jjRBk+JVCXJPDG4WMKBLEb3IZ8UTAfLT+WoPOVuoi9QbH6hrYRxW2UYS
         eb8xTlR0KHI8tXhNdOmfRb5aa4OLlawZJ+OwvDTM6Tyqwmc9L8PgHXdyTu3keiO2VUhO
         Z3vg==
X-Gm-Message-State: AOAM5301sSYBL1HJZkzAqAYtOkql+8oaIPcq2bFwUQ0vBrJd8MALN5WG
        f7Hj/1UTAfIGnFCzC9lF79zwwUbg1q7Egw==
X-Google-Smtp-Source: ABdhPJzy9BKgLEwVK49M6ASBXzOAKjQbHw7f8ApABrhBPNGAQZix9tsOTdrVD1fTfkDkLekTuif5Lw==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr8461683wrq.229.1641813039280;
        Mon, 10 Jan 2022 03:10:39 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id x8sm6256733wmj.44.2022.01.10.03.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:10:38 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org
Subject: [PATCH v7 0/4] clk: ralink: make system controller a reset provider
Date:   Mon, 10 Jan 2022 12:10:32 +0100
Message-Id: <20220110111036.1380288-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series add minimal change to provide mt7621 resets properly
defining them in the 'mediatek,mt7621-sysc' node which is the system
controller of the SoC and is already providing clocks to the rest of
the world.

There is shared architecture code for all ralink platforms in 'reset.c'
file located in 'arch/mips/ralink' but the correct thing to do to align
hardware with software seems to define and add related reset code to the
already mainlined clock driver.

After this changes, we can get rid of the useless reset controller node
in the device tree and use system controller node instead where the property
'#reset-cells' has been added. Binding documentation for this nodeq has
been updated with the new property accordly.

This series also provide a bindings include header where all related
reset bits for the MT7621 SoC are defined.

Also, please take a look to this review [0] to understand better motivation
for this series.

Regarding the way of merging this:
 - I'd like patches 1 and 4 which are related going through staging tree.
 - The other two (patches 2 and 3) can perfectly go through the clock tree.

Thanks in advance for your feedback.

Changes in v7:
 - PATCH 3/4: make use of '.of_xlate' callback as per Philipp v6 review.

Changes in v6:
 - Rebased on the top of last changes of staging-testing to properly
   update dtsi file (PATCH 4/4).
 - Send a copy of this to reset provider maintainer Philipp as per Stephen's sugestion
   to get changes added through the clk tree (Philipp, thanks in advance for reviewing
   this).

Changes in v5:
 - Move platform driver init process into 'arch_initcall' to be sure the
   rest of the world can get the resets available when needed (since PCIe
   controller driver has been moved from staging into 'drivers/pci/controller'
   is probed earlier and reset was not available so it was returning 
   -EPROBE_DEFER on firt try. Moving into 'arch_initcall' avoids the 'a bit
   anoying' PCI first failed log trace.

Changes in v4:
 - I sent wrong patch 3 accidentaly so now include the good version, sorry.

Changes in v3:
 - Collect Rob's Acked-by for patches 1 and 2. 
 - Rebase on the top of staging-next since there were already many
   changes there and PATCH 4 of the series didn't apply cleanly.

Changes in v2:
 - Address review comments of Dan Carpenter [1]:
 - Avoid 'inline' in function definition.
 - Return proper error codes (-EINVAL) instead of '-1'.
 - Make use of 'devm_kzalloc' instead of 'kzalloc'.

[0]: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210926145931.14603-3-sergio.paracuellos@gmail.com/

Best regards,
   Sergio Paracuellos

Sergio Paracuellos (4):
  dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
  dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
  clk: ralink: make system controller node a reset provider
  staging: mt7621-dts: align resets with binding documentation

 .../bindings/clock/mediatek,mt7621-sysc.yaml  | 12 +++
 drivers/clk/ralink/clk-mt7621.c               | 92 ++++++++++++++++++-
 drivers/staging/mt7621-dts/mt7621.dtsi        | 21 ++---
 include/dt-bindings/reset/mt7621-reset.h      | 37 ++++++++
 4 files changed, 149 insertions(+), 13 deletions(-)
 create mode 100644 include/dt-bindings/reset/mt7621-reset.h

-- 
2.25.1

