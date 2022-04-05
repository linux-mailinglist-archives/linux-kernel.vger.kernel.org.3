Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0353E4F51F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848978AbiDFCcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388221AbiDEVxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:53:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347859BB99;
        Tue,  5 Apr 2022 14:08:01 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso727554pjj.1;
        Tue, 05 Apr 2022 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mWNZR3xN77lNH2+vVDvTz9kvxP5RMITjN/TwsKnJ1EE=;
        b=CE3++kpN4KX/5Ou/GyMP/XDiEd+sD6aWdaoMGXv4koz7pe5HZ3O9oNn0BbHievdDsy
         gRraAn36CY5Vma4XfiauMtY8wBad6zfiIwOLvsgMPNq34HhD0KfoXxurSjEIE0UMZOh5
         x8ksydmWAW8+HpNcMCEsxinGUGHuP1Jv8ovCsgtALHsghN1aQjvLZBBXbppcdTVOx6Bh
         QjPyZ58k/nITx+UVSjKoUladchE217a6C0hJOL9lrDJLGnTwgsl5K/mVqM2ezfa4okJN
         i4q1U+ZWc/7iBEMJWWgn0WhzhFlyP3sgMJ51d7vVHuQUQB4ChLywUpZFRO0mJ0S59wAg
         2qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mWNZR3xN77lNH2+vVDvTz9kvxP5RMITjN/TwsKnJ1EE=;
        b=IiFYvgclppjNyhpV/J48Icn5yiBtdXfU+YfPySCJiP/US4XOfxFAAF6z7MgRCSYjJg
         xpzDsbCfLaR5KcgSIjaVFG1f9XhG7LDy0eOIs5/k5Bt1n/2kAMneQNJdaqdHWFtpsqIt
         8SNtWX+YUxXA7gMa+XMU/QTQF8qcOPSjQuX2CLrEG7KbLDYVAiGCoci4n4EfoGVd5LOL
         0+niRQqYAiM5pt+aZgEOuZd4oAVGeXr2NdWlBd5lboiErjmyGl05RKqrqpT2QMrsuECE
         jksatC1Mk1Lx5dRAN50aA7h0awRkH8NCretItbhxW86sx4k8BGbpf/xT0tRby3XZmQ7f
         PFCg==
X-Gm-Message-State: AOAM5337qpdkllexSWjAeepze6y2Vx0XgSJ2HbVszW9uXWfker1C2wE7
        Ckmy91IcCZSV3eYWEyoP7yU=
X-Google-Smtp-Source: ABdhPJy/JsdSFdDHguhmquGdEb4TaMTjGtBm4D+kWA4UKyn1DlVjMUH9Fy7l9i8vDn9GSpYiwsLeiQ==
X-Received: by 2002:a17:90a:c3:b0:1ca:54c1:a684 with SMTP id v3-20020a17090a00c300b001ca54c1a684mr6138269pjd.148.1649192880749;
        Tue, 05 Apr 2022 14:08:00 -0700 (PDT)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:3:511c:41a7:57f7:f826])
        by smtp.gmail.com with ESMTPSA id k22-20020aa788d6000000b004faaf897064sm16240010pff.106.2022.04.05.14.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:08:00 -0700 (PDT)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH v5 0/4] platform: surface: Introduce Surface XBL Driver
Date:   Tue,  5 Apr 2022 14:07:46 -0700
Message-Id: <20220405210750.619511-1-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Jarrett Schultz <jaschultz@microsoft.com>

After v4, there were some suggestions to change the driver again to use
nvmem that would include some other changes to the sm8150 dtsi. While
the suggestions make sense, this driver was supposed to remain simple
for the introduction in order to get it into the tree and I think that
it would be best to implement those and any other suggestions in a future
patch. Hopefully this patch is now in a state where it can be accepted.
Thanks to all who have helped and been patient along the way, this was
my first patch :)

~ Jarrett

---

Introduce the Surface Extensible Boot Loader driver for the Surface Duo.
Exposes information about the driver to user space via sysfs for
consumption in manufacturing mode.

---

Changes in v5:

 - Minor changes to yaml

---

Changes in v4:

 - Small binding definition changes
 - Removed ACPI propagation from patch series since it has been
   cherry-picked
 - Fixed the Signed-off-by: and From: mismatch

---

Changes in v3:
 - For the yaml documentation:
    * Updated description
    * Fixed examples
    * Updated 'required' field
 - Further propogated ACPI dependency in Kconfigs
 - Updated sysfs several binding descriptions
 - Renamed files to conform to naming conventions

---

Changes in v2:
 - Per Maximilian, added patch 2: propagated ACPI dependency from the
   directory as a whole to each individual driver
 - For the yaml documentation:
    * Removed json-schema dependence
    * Elaborated on description of driver
    * Updated example
 - Changed target KernelVersion in sysfs documentation
 - Updated MAINTAINER changes to be properly applied across patches
 - For the driver itself,
    * Added types.h inclusion and removed unused inclusions
    * Minor updates to code and acronym style
    * Remove __packed attribute on driver struct
    * Use .dev_groups for sysfs
 - Added more in-depth description of driver in Kconfig
 - Modified dts to reference a newly added section in sm8150.dtsi

---

Jarrett Schultz (4):
  dt-bindings: platform: microsoft: Document surface xbl
  platform: surface: Add surface xbl
  arm64: dts: qcom: sm8150: Add imem section
  arm64: dts: qcom: surface-duo: Add surface xbl

 .../ABI/testing/sysfs-platform-surface-xbl    |  79 ++++++++
 .../platform/microsoft/surface-xbl.yaml       |  70 +++++++
 MAINTAINERS                                   |   9 +
 .../dts/qcom/sm8150-microsoft-surface-duo.dts |  10 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |   8 +
 drivers/platform/surface/Kconfig              |  12 ++
 drivers/platform/surface/Makefile             |   1 +
 drivers/platform/surface/surface_xbl.c        | 186 ++++++++++++++++++
 8 files changed, 375 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-surface-xbl
 create mode 100644 Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
 create mode 100644 drivers/platform/surface/surface_xbl.c

-- 
2.25.1

