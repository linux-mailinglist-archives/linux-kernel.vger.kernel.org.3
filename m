Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921E24897FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245062AbiAJLup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245079AbiAJLte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:49:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C6C061757;
        Mon, 10 Jan 2022 03:49:34 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e9so24745873wra.2;
        Mon, 10 Jan 2022 03:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AI6//2+5okRQn1r7aAwaz9tvXNSFI803yhc+pIdSqps=;
        b=oXRRBjYWApc7K4WKe9/x89DlUHSeEpIi1SvMs5WRwkzFPUzzi/CvrQm4iaxqmjJpFR
         ypEFMDYIHA7V1lyuqYGfaLaqPIxITz6wjBcdwOCgeeTtT5GhloMpogk8/PZiK0JfrNCH
         m+Xa2yzrjUOuMFlL29SwvRQm79jNymRMiei9YW4b9y+yIJHZwTfQC7skOm6gU3yi8j0m
         JfwrqD+9y5lY3iM58BKz763CHuEv+HYwU+DgDrgSfc+FwJ+5kLs7KCYXs4jivVuxgLOT
         xHviqoXPtmV+5ZCAVIY0f0Vz6raYujIbXvYEjG6bYpcM6D8vvbU1XTIT1F2Hqe9tgwEr
         Mn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AI6//2+5okRQn1r7aAwaz9tvXNSFI803yhc+pIdSqps=;
        b=aWvtzwTke8J90H6vz6auE+vj/VC51f7Bg1DbA/C0ACVgIaB/ugtY4WtpxVnonq78XB
         W6c6tzukdbUOvz40ov/WRw8DysXnyonnkTDS3WtSfIOJLMSp5WgfYxFEb1dQ6EgE09AV
         YU1ZJ57FZoVKoPh6PZdBQDZRcrnLC2Y1E1VBgUXbrjw1+bWfDS+IacjWOSJdhfjYjU67
         O7KsVbgkWiTPEN8btQSy8kJZBe0sUU7SaMIrLc3ixVLTWUP+2FNT+MjbyYDo1j81RZiS
         lB/oF9dKIs+wbeoS9wM9oR6YuyZc0bkaLwe5Q5ZTuB8WrqMRwiz8xnaxNXEm+dPdGvIv
         9Zsg==
X-Gm-Message-State: AOAM5305XgEh1LYncDEVNnb/Xksg4lJpqOu8eaR7an40SYIHp+vTyTVn
        IRS1xJgkQEoV5BcSP8x8dDAOUaAGVlR72A==
X-Google-Smtp-Source: ABdhPJwkOIToOriEYfE2x6N7mEzXGybe4JAY+czcSwWelMfaUhRia/NC6sJFyrzYoo27/MdWrMWSJw==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr418004wrv.40.1641815372143;
        Mon, 10 Jan 2022 03:49:32 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id 9sm8090252wrz.90.2022.01.10.03.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:49:31 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org
Subject: [PATCH v8 0/4] clk: ralink: make system controller a reset provider
Date:   Mon, 10 Jan 2022 12:49:26 +0100
Message-Id: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
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

Changes in v8:
 - PATCH 3/4: with .of_xlate set, the driver needs to check whether id < nr_resets
   on its own.

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

