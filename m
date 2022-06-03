Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3890C53C21F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbiFCBTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbiFCBTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:19:36 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CED63B016;
        Thu,  2 Jun 2022 18:19:35 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-e5e433d66dso8952119fac.5;
        Thu, 02 Jun 2022 18:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=efuG/USrWvVrmhoIqcXd16O6sjAyJQXHbx6OyOwpcvw=;
        b=Cm7H5AYsmvnIuGS4L925JqWoqVE81nalmoT+HqaX4PLOt62mm8GjMww01F6tT1NAv9
         BDpWJ7NmWmGeUxXRr7SBgQGoqlkawqcL10KnENtug5w/n7kKkq01PzAGJPtR09QQfGk2
         feaRTcgKSFtCxcvOE4PhA/VsYRy9nb6aS/3qSdvaRInuKlXM5ekXIuhQkLr+L/dCcZ9U
         0GaZDo8Y5aMfHNfxTgi8RrdFTVrjHyE18vJgP4g68/mVd1ehkvr6+6S9gl/ab8o444ig
         MdeyfUkONw3008lEU2xWPmbrwVxxzr3g2b3wL0EY6zCa8jrTojDJURpZ6I/oXUsMD12G
         xdAQ==
X-Gm-Message-State: AOAM530XRKnFJwO4+3IhHi3sySOIoJEOUxvtfj56ekTm/2tlyxhhABaH
        BC8flnKHfJ4LuDUHXn4CQF53nVnmWQ==
X-Google-Smtp-Source: ABdhPJwxTgjqpj8o2G/QIlMu1QLWhjt1AyeJO9mMNFamxK1uO6fQwKmc0PuyDPxb+N9qK5H/m0RiAw==
X-Received: by 2002:a05:6870:b617:b0:f5:d766:1b70 with SMTP id cm23-20020a056870b61700b000f5d7661b70mr8981823oab.80.1654219174375;
        Thu, 02 Jun 2022 18:19:34 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id na14-20020a0568706c0e00b000f5d8d031b6sm2679746oab.49.2022.06.02.18.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 18:19:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] dt-bindings: Arm CoreSight binding schema conversions
Date:   Thu,  2 Jun 2022 20:19:30 -0500
Message-Id: <20220603011933.3277315-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts all the CoreSight debug bindings to DT schema
format. These bindings are at the top of the list of occurrences of
bindings without a schema. For arm64 dts files:

    702 ['arm,coresight-etm4x', 'arm,primecell']
    536 ['arm,coresight-cpu-debug', 'arm,primecell']
    509 ['arm,coresight-dynamic-funnel', 'arm,primecell']
    213 ['arm,coresight-tmc', 'arm,primecell']
    143 ['arm,coresight-dynamic-replicator', 'arm,primecell']
     97 ['arm,coresight-stm', 'arm,primecell']

I'll send a reply to these with the errors in dts files that this
causes. I've reviewed them and they all look legit. Xilinx Zynq though
has 3 clocks instead of 2.

v2:
 - Rename other Coresight bindings to use compatible string for filename
 - Add missing arm,coresight-dynamic-replicator.yaml and
   arm,coresight-static-funnel.yaml
 - Update MAINTAINERS
 - Fix coresight.txt references

Rob

Rob Herring (3):
  dt-bindings: arm: Rename Coresight filenames to match compatible
  dt-bindings: arm: Convert CoreSight bindings to DT schema
  dt-bindings: arm: Convert CoreSight CPU debug to DT schema

 .../bindings/arm/arm,coresight-catu.yaml      | 101 +++++
 .../bindings/arm/arm,coresight-cpu-debug.yaml |  81 ++++
 ...esight-cti.yaml => arm,coresight-cti.yaml} |   5 +-
 .../arm/arm,coresight-dynamic-funnel.yaml     | 126 ++++++
 .../arm/arm,coresight-dynamic-replicator.yaml | 126 ++++++
 .../bindings/arm/arm,coresight-etb10.yaml     |  92 ++++
 .../bindings/arm/arm,coresight-etm.yaml       | 156 +++++++
 .../arm/arm,coresight-static-funnel.yaml      |  89 ++++
 .../arm/arm,coresight-static-replicator.yaml  |  90 ++++
 .../bindings/arm/arm,coresight-stm.yaml       | 101 +++++
 .../bindings/arm/arm,coresight-tmc.yaml       | 131 ++++++
 .../bindings/arm/arm,coresight-tpiu.yaml      |  91 ++++
 ...yaml => arm,embedded-trace-extension.yaml} |   3 +-
 ...e.yaml => arm,trace-buffer-extension.yaml} |   2 +-
 .../bindings/arm/coresight-cpu-debug.txt      |  49 ---
 .../devicetree/bindings/arm/coresight.txt     | 402 ------------------
 Documentation/trace/coresight/coresight.rst   |   2 +-
 MAINTAINERS                                   |   8 +-
 18 files changed, 1192 insertions(+), 463 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
 rename Documentation/devicetree/bindings/arm/{coresight-cti.yaml => arm,coresight-cti.yaml} (98%)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
 rename Documentation/devicetree/bindings/arm/{ete.yaml => arm,embedded-trace-extension.yaml} (95%)
 rename Documentation/devicetree/bindings/arm/{trbe.yaml => arm,trace-buffer-extension.yaml} (94%)
 delete mode 100644 Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/coresight.txt

--
2.34.1
