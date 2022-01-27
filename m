Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06A349EE77
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343624AbiA0XIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiA0XIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:08:25 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24386C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:25 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id u130so4371415pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1uOFTgg0x7nxOozmt+E9oLAD0yJmH2M0jmKFxZDwp8=;
        b=N5XEoUM5GPx0kQt4THwu9A+kK+DZR0wMVHnyygjwUG5aaFoDL+gOadyxplbQetMhe7
         wrCn7wY6jwGkNG0PfOk50FCELTNuv5Ef6BAmJkfoYlHmzbA34qzN6oU2TbxPfDvxZ87u
         PhwuMG6XcbV1qCtwINtTlV/2e77vS1BRriaxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1uOFTgg0x7nxOozmt+E9oLAD0yJmH2M0jmKFxZDwp8=;
        b=vQD/mBSlR84zE1KEbWU14LnpK731FZdgJYRkcR9fgPkRqdSQ1dltkNx6w8PozSk/by
         odJ3Kg9gEFh829X5VCOcz2YFkFacy/qlctFVj2wq4Nb35+0WWD+pirsvEqSzCPGYveob
         W1DlNYAZ8hbE+UoqJQkfUX/aRk4kLKFq2fe0c5XkI8ttXypoEeP/6zZ5VZS6XbMUCvbC
         UFi84Ku7pCVWVRgHlU+9HsCLEJq9zYTO4SetnmGuu90Bvo2JyrHGPg/D58L1MtbqPFCb
         r/l7C5nan0XnW+jOsAc1SMfpv+iRLqURR/BJtzPQO+O5KEBuGLJ/wPAhs5yURee6xrc3
         ir8g==
X-Gm-Message-State: AOAM530DrgEZWw6bvFa26QEl3FwKR5X6mpUmVDG4Aj/dLJDQ472M2owb
        +R4o2toEQ5dvu/RUKcMw6QmGJQ==
X-Google-Smtp-Source: ABdhPJyhsxMBgopZJQ9Yzo2MIciHeAMHqFWshYvoQ8YUfc42nVNLVluvkoFoX6uSfTwD6O2dKCWxcQ==
X-Received: by 2002:a63:6ac3:: with SMTP id f186mr4322420pgc.81.1643324904727;
        Thu, 27 Jan 2022 15:08:24 -0800 (PST)
Received: from localhost ([2620:15c:202:201:723d:38a9:9e7f:3435])
        by smtp.gmail.com with UTF8SMTPSA id b5sm20269235pgl.22.2022.01.27.15.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:08:24 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 00/15] rk3399: Clean up and enable DDR DVFS
Date:   Thu, 27 Jan 2022 15:07:11 -0800
Message-Id: <20220127230727.3369358-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series covers 2 primary tasks:

1) Resubmit prior work:

[RESEND PATCH v5 3/4] arm64: dts: rockchip: Enable dmc and dfi nodes on gru.
https://lore.kernel.org/lkml/20210308233858.24741-2-daniel.lezcano@linaro.org/
[RESEND PATCH v5 2/4] arm64: dts: rk3399: Add dfi and dmc nodes.
https://lore.kernel.org/lkml/20210308233858.24741-3-daniel.lezcano@linaro.org/

This series was partially merged a while back, but the remaining 2
patches were blocked mostly on stylistic grounds (alpha/numerical
ordering).

2) Integrate many updates, bugfixes, and clarifications that were done
by Rockchip and Google engineers when first launching this platform.
Many of these were not integrated in the earlier series (e.g., the OPPs
changed before production; earlier patchsets used pre-production
numbers).

Along the way, it seemed worthwhile to convert the binding docs to a
schema. Among other reasons, it actually helped catch several errors and
omissions in translation between downstream device trees and the version
that actually landed upstream.

See the patches for further details.

Regards,
Brian

Changes in v2:
 - Fix yamllint issues
 - Adapt to various review comments (use of *-hz, hyphens, node naming)
 - Add a few new bugfixes
 - Add some new properties (ported from downstream kernels) required for
   stability
 - Convert more properties from "cycles" to "nanoseconds"

Brian Norris (13):
  dt-bindings: devfreq: rk3399_dmc: Convert to YAML
  dt-bindings: devfreq: rk3399_dmc: Deprecate unused/redundant
    properties
  dt-bindings: devfreq: rk3399_dmc: Fix Hz units
  dt-bindings: devfreq: rk3399_dmc: Specify idle params in nanoseconds
  dt-bindings: devfreq: rk3399_dmc: Add more disable-freq properties
  PM / devfreq: rk3399_dmc: Drop undocumented ondemand DT props
  PM / devfreq: rk3399_dmc: Drop excess timing properties
  PM / devfreq: rk3399_dmc: Use bitfield macro definitions for ODT_PD
  PM / devfreq: rk3399_dmc: Support new disable-freq properties
  PM / devfreq: rk3399_dmc: Support new *-ns properties
  PM / devfreq: rk3399_dmc: Disable edev on remove()
  PM / devfreq: rk3399_dmc: Use devm_pm_opp_of_add_table()
  PM / devfreq: rk3399_dmc: Avoid static (reused) profile

Lin Huang (2):
  arm64: dts: rk3399: Add dfi and dmc nodes
  arm64: dts: rockchip: Enable dmc and dfi nodes on gru

 .../bindings/devfreq/rk3399_dmc.txt           | 212 ----------
 .../bindings/devfreq/rk3399_dmc.yaml          | 370 ++++++++++++++++++
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |   7 +
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi |  12 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |  28 ++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     |  25 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  19 +
 drivers/devfreq/rk3399_dmc.c                  | 299 +++++++-------
 8 files changed, 595 insertions(+), 377 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml

-- 
2.35.0.rc0.227.g00780c9af4-goog

