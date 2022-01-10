Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D680B4893CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbiAJIlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241746AbiAJIjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:39:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F54C03400D;
        Mon, 10 Jan 2022 00:39:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l25so14374471wrb.13;
        Mon, 10 Jan 2022 00:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IiDzRl0xDsBZ34GUWlhZ01anFV2WfCdl4gOdQbI/yQ=;
        b=cScWzwfa/Kw1I0jbHQbYW87BcybZH1vbSYrF+CGTLBHew8HwvwJFbFjsYNppjfYx8Q
         zBu+N6cewP9l5wW2Qx8P1A86N2k6pvF0yXisCtG3qkuKJ8YRiyiG3Pe3hhG9fnmP+ANo
         t0JpRZbwnqBEXve3dT7prUqaniQo2RbTJJ1gB4rIVIrqll6CPMecu6yGOXdU+T1xljR3
         2CeUIDg6lznoJTvkXu1oxuT8TtZ9o9+aMs9muM9tePeNvk8+CEaHM7DxFGM6cN+xrN50
         aDDrpW6x3+n6ago3J/h6LZX97TMyYv/YY+F15NG6RFp9O65BlVDzA0FLqdO65H6opMSN
         WBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IiDzRl0xDsBZ34GUWlhZ01anFV2WfCdl4gOdQbI/yQ=;
        b=bjxfQ040XAUF5VPVGKmktlTsvOAbBeh9Y4OFRFxHEcfqotQLflPK+tyQZI4Q7BcLXN
         SMMwYMpSG4P4Eb93dZivY/FCQlXmLfOFg/ey2Pnca/5Ovprz1qXJ3XMpmgiuhcVqUCdc
         0MNVG8ZI/R9eLaRWrCcFkq5P5UuNp9u/+u0sMPgx4UppuSBrG0HTuJ2lIc+E9FoOW3x4
         fnpixrjBERhP+H2j3Ho5Pu9MHPgdegMJGkl5kgMZcwFf0J4psp4rYikaH3aLZyAzZAGX
         pR+FL05hHyiUn9s39o07562P5UradbAMcTWVAHYJAsFhq1nyAYUDOXbbuTCEtueauALV
         +5Aw==
X-Gm-Message-State: AOAM530m8YzdQilwHomGiewbc9aYB/rQiTkvUNoxPNA7TGGPRmGj9eV/
        oMvx4a4nz83A87cNNgeP+SflNNPxaSaZdA==
X-Google-Smtp-Source: ABdhPJxtLFkd/7ltvtGaWtcoBiiAucLjmallDplyR9e0PzbH8pUR0ACueQuGeFcaZrTmOZ4wBoLYFA==
X-Received: by 2002:adf:f791:: with SMTP id q17mr4961947wrp.311.1641803952170;
        Mon, 10 Jan 2022 00:39:12 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id m7sm508926wmi.13.2022.01.10.00.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 00:39:11 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org
Subject: [PATCH v6 0/4] clk: ralink: make system controller a reset provider
Date:   Mon, 10 Jan 2022 09:39:06 +0100
Message-Id: <20220110083910.1351020-1-sergio.paracuellos@gmail.com>
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
 drivers/clk/ralink/clk-mt7621.c               | 86 ++++++++++++++++++-
 drivers/staging/mt7621-dts/mt7621.dtsi        | 21 ++---
 include/dt-bindings/reset/mt7621-reset.h      | 37 ++++++++
 4 files changed, 143 insertions(+), 13 deletions(-)
 create mode 100644 include/dt-bindings/reset/mt7621-reset.h

-- 
2.25.1

