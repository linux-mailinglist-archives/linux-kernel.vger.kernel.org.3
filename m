Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0344D2104
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349321AbiCHTKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbiCHTKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:10:07 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A5A344D0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:09:10 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d17so196964pfv.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfeJ5Z/28d4DwwwwEjo+Xl8PsAuc47UIF+v9aMkJPaE=;
        b=g4Kn+knbxPcL2nDhbYO7LeofqDCYGIzYat8Uyvm4hBnk/d5333G7ySljmfyQYE/UX1
         Rw+7tkAdrzG/RAZVqapYRbjzY81SexLEMmsu+AwVUsO5KzHEud+nHcFxU7lkjYurEV2L
         AzXJs1J0+S7c90q2nf41z2xJzeZ0Vdp76lXtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfeJ5Z/28d4DwwwwEjo+Xl8PsAuc47UIF+v9aMkJPaE=;
        b=RsgohFtqAxGkh16EChuKOuCqFxFHQpoJDtoVzkEdvnkaw2ux23gBKQukVENeoKPPKB
         WiIA8MxOM0JDVZSbWHFIHuru0LEcvxZeej32cRMSX0iHznWQxuIQNVdh4Vwz3VdsrSGk
         IdrNMc+QEOuevUBAv3km18kZYqrbuohk5swWk9zEV/ZlWfcntXwbkbf/PFJzDLhFRD3C
         DeNSs3LmbDADNvbI/gm61N1GmuEtcST1i29DgJVPwJs+uPg+8vXrHaCx8BYa30vqfWqO
         +h3nEjHbAXjrYdIPB7povtTAlbH80U9wwGjh5Pi0RZ4Xkq9G0OyANPmVThs1UkpQYQa3
         PagQ==
X-Gm-Message-State: AOAM530xZbXlTvJVchzIGeRxhsGByUBcGWMIIfieLEdPCc/Lu7QpBtVN
        HJqbcqCI2QrjD43mT1+YqDWphg==
X-Google-Smtp-Source: ABdhPJzS5q/sqiq5fTsLk+gxrR8BJqiWX5haq34jcz+ml+GBnO2cRbA1Joomrpy3ASNpNH9qD/103A==
X-Received: by 2002:a63:fd4e:0:b0:378:7d6f:d7e9 with SMTP id m14-20020a63fd4e000000b003787d6fd7e9mr15410471pgj.440.1646766549462;
        Tue, 08 Mar 2022 11:09:09 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with UTF8SMTPSA id e11-20020a17090a280b00b001bf23a472c7sm3680868pjd.17.2022.03.08.11.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:09:08 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 00/15] rk3399: Clean up and enable DDR DVFS
Date:   Tue,  8 Mar 2022 11:08:46 -0800
Message-Id: <20220308190901.3144566-1-briannorris@chromium.org>
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

Changes in v4:
 * Update .yaml to use more "default" entries, instead of free-form text
 * s/phandle-array/phandle/
 * Move to .../memory-controllers, update filename

Changes in v3:
 * Add |maxItems| for devfreq-events
 * Improve deprecation notes
 * Add Reviewed-by tags
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
 .../rockchip,rk3399-dmc.yaml                  | 384 ++++++++++++++++++
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |   7 +
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi |  12 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |  28 ++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     |  25 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  19 +
 drivers/devfreq/rk3399_dmc.c                  | 299 ++++++--------
 8 files changed, 609 insertions(+), 377 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml

-- 
2.35.1.616.g0bdcbb4464-goog

