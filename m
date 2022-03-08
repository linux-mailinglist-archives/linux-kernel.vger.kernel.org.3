Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825B64D0C77
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243999AbiCHALC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241643AbiCHAK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:10:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CD61CFDE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:10:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso695352pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nn87tDnvGv7OSX+fx7BgpaSZEoHCAFqg9zr3N4CuzSM=;
        b=SNkZ77KXm9TDAmC6IViNJBK5BRVhvxf+LuzTh1Fyhvr6rdO4Y9SdqHibqv2o60wOrS
         9K59MfwQiCSqMbosa6EkcVrOtp6cwX+4xu67VbZCvW5gdYIOgsqvaGMr6EBDU2Hue6Nb
         S85FSIWNOdu9UiD/DNtHOVECLYAbPnztNE6H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nn87tDnvGv7OSX+fx7BgpaSZEoHCAFqg9zr3N4CuzSM=;
        b=ZB8oHSh3RLz5bmSn/9Oj4iM9hS+VZT1whG5VH1iQcdL0KTNob25zGBKpcJTVc4MQkt
         u511dscUxyVooc7iQ+tLbt6S6AYzI65lHB0uAxLlvYLuxYtlqeNSTYevURd2xzdD8ToL
         ZR+wQRZVH6rGdYdt8ecB/XpFlZY7bDuz6GJ66kl9yvzX+AY64hA/b2y/fkNTfDWzGpif
         c10pgovZf/NhKbWz5gTJJCMUBVJl8jLFH0qZtDBEpZKr/tl7HkUleOwriwk5eAnXsWRW
         WzlKVC65EacIj2ug2KFcmMhcS0UGMP8Gb2QI4XijpmmH8e4kXQO36IebDlBT2UEiC5xN
         3kLw==
X-Gm-Message-State: AOAM531v5OzSadTx1+MBSqzVf8hH8KfLxi+J/y1j9415c+uoXnMe6z//
        cp3Gon9KBtToJJftS1b0t/4oWw==
X-Google-Smtp-Source: ABdhPJz1ralX9qOcr9TOi/L1wMWVp6Zl1h9OZu4ylYSwFzToc98tvA1ZZGEW8BvLFUdlYIU9BD+Ilw==
X-Received: by 2002:a17:902:c3cd:b0:151:806d:1b9b with SMTP id j13-20020a170902c3cd00b00151806d1b9bmr15351414plj.98.1646698204021;
        Mon, 07 Mar 2022 16:10:04 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e551:44dc:2842:57f1])
        by smtp.gmail.com with UTF8SMTPSA id bi29-20020a056a00311d00b004f6fa51e70dsm5177381pfb.196.2022.03.07.16.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:10:03 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lin Huang <hl@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 00/15] rk3399: Clean up and enable DDR DVFS
Date:   Mon,  7 Mar 2022 16:09:30 -0800
Message-Id: <20220308000945.706701-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes in v3:
 * Add |maxItems| for devfreq-events
 * Improve deprecation notes
 * Collect some Acked/Reviewed tags

Changes in v2:
 * Fix yamllint issues
 * Adapt to various review comments (use of *-hz, hyphens, node naming)
 * Add a few new bugfixes
 * Add some new properties (ported from downstream kernels) required for
   stability
 * Convert more properties from "cycles" to "nanoseconds"

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
 .../bindings/devfreq/rk3399_dmc.yaml          | 371 ++++++++++++++++++
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |   7 +
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi |  12 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |  28 ++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     |  25 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  19 +
 drivers/devfreq/rk3399_dmc.c                  | 299 +++++++-------
 8 files changed, 596 insertions(+), 377 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml

-- 
2.35.1.616.g0bdcbb4464-goog

