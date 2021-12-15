Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB06474F70
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbhLOAqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbhLOAqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:46:39 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23906C061574;
        Tue, 14 Dec 2021 16:46:39 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i13so7754789ilk.13;
        Tue, 14 Dec 2021 16:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2sQ+4LioILCmA5mehp5hpTPeXuQigPTBXsv4THjA+k=;
        b=kD91ZkFAA400/m7zaa1/gApN5KCrFMvxi2N6seSYAOQjY88S2IL3UsIJbPjn6QbDZO
         4MzxmUGQmuhU0xSZbGKvRhWocR7CRxMUoCytL+mu+HBUsxCKMJ7C7gg0cMB7ds4lXMpE
         i8Q79H/0EXz4qL1uYLYv28kcFHmgsdC3OpZ7ADFwVs/Ck4VfFbFub9LffuRm7qJ1HjdU
         Mz4T0PtJW44jhxRspTbek2eHYssFjNlKOFM8nyMmZxnFCEL4exJ22G3noSayoUpEjpuW
         YHBtSG1LC/r1sqo7OCLbKin2WTnnnJPU9hGIdbkot9Z/pkBARDf92EWEkrisofkNoufC
         1cJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2sQ+4LioILCmA5mehp5hpTPeXuQigPTBXsv4THjA+k=;
        b=LIoJSiGi8bmplJ5nw4ZqaVvQ7pr/nM1X1e64kiyZp43+0/PoDjZ++88IDNT3evcgdO
         DcZ0ky7M4SUWXINkGEMhB4rPgNTBGN0Yd9Ju6cFcYSv9PlAvbbbO+hVoaqQ9+UkNlEsA
         ObONEvbDqDsHXbNbIKZAV+vko6cUzMi+qDtzhedPjNOYjR6VwnfvTgJwpkntQHtUci0b
         QHWM0v9KkyQ0+7+CKRcYBa7tF6LK+p+cg9GyMxNGKhYrd/H+7r2sCooaxgnmivXH14HJ
         iew2UfhYJZUjnNu7EuYyuTIuJ9dxqBSxTAdEuCLcfy6IeXieEjulgxjawvQwcIwbDcRa
         0pug==
X-Gm-Message-State: AOAM533mXH3Z2uQ/WEEGUeJ4ucnD4b3EAs2T2Od9TaA3YnO8J0mevZ59
        1QVPphBiqIphV5fBlWJlTu4wk+7LySrMNQ==
X-Google-Smtp-Source: ABdhPJxfNoBYMD6gW1hX+4CjevirSg7/RbR/0OezdJHMxZq+9UKHO//Th3SN8Y4uU5hNtTnQQJtvJQ==
X-Received: by 2002:a92:905:: with SMTP id y5mr5491264ilg.259.1639529198272;
        Tue, 14 Dec 2021 16:46:38 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8256:b93c:84fb:458b])
        by smtp.gmail.com with ESMTPSA id y8sm218857iox.32.2021.12.14.16.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:46:37 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     tharvey@gateworks.com, aford@beaconembedded.com,
        michael@amarulasolutions.com, jagan@amarulasolutions.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/9] arm64: imx8mn: Enable more imx8m Nano functions
Date:   Tue, 14 Dec 2021 18:46:17 -0600
Message-Id: <20211215004626.2241839-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano is similar to the i.MX8M Mini in some ways, but very
different in others.  With the blk-ctrl driver for Mini in place,
this series expands the blk-ctrl driver to support the Nano which
opens the door for additional functions in the future.  As part of
this series, it also addresses some issues in the GPCv2 driver and
finally adds support for enabling USB and GPU.

V5:  Clean up the GPU clock assignments.
V4:  Rebase on top of [1] which fixes hangs caused from CSI and DSI reset
     and add the same fixes for CSI and DSI to the Nano
V3:  Fixes an the yaml example
V2:  Fixes the clock count in the blk-ctrl

[1] - https://www.spinics.net/lists/arm-kernel/msg936266.html

Adam Ford (9):
  soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
  soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
  dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
  dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
  soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
  arm64: dts: imx8mn: add GPC node
  arm64: dts: imx8mn: put USB controller into power-domains
  arm64: dts: imx8mn: add DISP blk-ctrl
  arm64: dts: imx8mn: Enable GPU

 .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     |  97 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 104 ++++++++++++++++++
 drivers/soc/imx/gpcv2.c                       |  26 +++++
 drivers/soc/imx/imx8m-blk-ctrl.c              |  77 ++++++++++++-
 include/dt-bindings/power/imx8mn-power.h      |   5 +
 5 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml


base-commit: 8d30c32befe955a537381cc40f842295322255d8
-- 
2.32.0

