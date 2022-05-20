Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60A752F545
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353755AbiETVo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352791AbiETVoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:44:20 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F7114917A;
        Fri, 20 May 2022 14:44:19 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id w19-20020a9d6393000000b0060aeb359ca8so2948909otk.6;
        Fri, 20 May 2022 14:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fqCq63IwA4TlKby8zuM0F7kyTR627fN+TysBkufnrAM=;
        b=RU9dsVvl7/cqQuJj146XfuHzrPQ9CfoqNzGAXTA2Tj8Fc8ym/ItaChQxfiVPwmald+
         hKHolQIGxjO/QB0xcTMPQlXzjP7uc1FUz4xKqWHVBu+aJNerFd0AFuv0kF6QUutTUbjn
         AT/0ePJRvnbhMcB5S43QUi0Q1LrzlGzcYCAbT1Xfo7oO5O0lNgfnyiO316CO9WUrVIjn
         571YlDcEJxj3tAr73fSd4WZLDriJ65FLgM5Y3gPFrLcWla4IojMYyRVph8zNnsi5Iqcz
         rbpuWGaTOvkSpPTK4GteUMnJjmgm6qJ6sncVW3X9WjkEtLn55dPjpjF0PpIvU6M4cAb0
         uB/Q==
X-Gm-Message-State: AOAM533+JgHf1pMq0bEurueTcec6B8EqSmTv7+XfR/wkBUtYWS7aOUi6
        ubxAcdoH31ijjhPsPpTwSvvuHxfg1Q==
X-Google-Smtp-Source: ABdhPJxAuidk/2k3GD+v1EYnbrQ8jJlx5x6tbik2qxaqegEmFd1AsQaeuzGEcHBdfINn8s/u78AHVw==
X-Received: by 2002:a05:6830:304e:b0:5af:f66a:56ee with SMTP id p14-20020a056830304e00b005aff66a56eemr4957420otr.226.1653083058195;
        Fri, 20 May 2022 14:44:18 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056820060c00b0035eb4e5a6d8sm1615018oow.46.2022.05.20.14.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 14:44:17 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] dt-bindings: Arm CoreSight binding schema conversions
Date:   Fri, 20 May 2022 16:44:14 -0500
Message-Id: <20220520214416.302127-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

Rob


Rob Herring (2):
  dt-bindings: arm: Convert CoreSight bindings to DT schema
  dt-bindings: arm: Convert CoreSight CPU debug to DT schema

 .../bindings/arm/arm,coresight-catu.yaml      | 101 +++++
 .../bindings/arm/arm,coresight-cpu-debug.yaml |  81 ++++
 .../arm/arm,coresight-dynamic-funnel.yaml     | 126 ++++++
 .../bindings/arm/arm,coresight-etb10.yaml     |  92 ++++
 .../bindings/arm/arm,coresight-etm.yaml       | 156 +++++++
 .../arm/arm,coresight-static-replicator.yaml  |  90 ++++
 .../bindings/arm/arm,coresight-stm.yaml       | 101 +++++
 .../bindings/arm/arm,coresight-tmc.yaml       | 132 ++++++
 .../bindings/arm/arm,coresight-tpiu.yaml      |  91 ++++
 .../bindings/arm/coresight-cpu-debug.txt      |  49 ---
 .../devicetree/bindings/arm/coresight.txt     | 402 ------------------
 11 files changed, 970 insertions(+), 451 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/coresight.txt

--
2.34.1
