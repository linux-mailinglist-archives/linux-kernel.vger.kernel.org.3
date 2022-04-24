Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C35C50D08F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 10:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbiDXIxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 04:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbiDXIxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 04:53:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3821EAE1;
        Sun, 24 Apr 2022 01:50:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g20so15177588edw.6;
        Sun, 24 Apr 2022 01:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pSeVxZ7kFGybIVIVrBXvwtctttqQblAdAr2j0viXYNA=;
        b=aukjRI/5KCMQTzkPd19KIyPbTyUf0ZA/YZ1GLvemCzic3DvYYjMVirH5qMtR7rgyta
         vCVzb+ANU3LrzBCTusfG7ydBMZLWBP0f9MyP+0tQwyY1EfCDcY+ipSMaie6NP5XiGlRe
         AUSKBx3vVW0g99i7TQNCNg5hoDZqEUluAjLnrjDrg2Gue/HSL39DB9iOBBjhHODZIpr2
         RLPrpzzxEuXZHkDBk03eFAYGhdUs+0c8geLCrBsnQrE89C3pc2HNhhMF1AWTFLFKYD2b
         2J9g/FEVML8LWPkgmUq0RljlySLR0Hv0esSVVPkbvOzMwsOYN/2+s0PRqdBb2Kc9GHVl
         oaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pSeVxZ7kFGybIVIVrBXvwtctttqQblAdAr2j0viXYNA=;
        b=hYyoAUorTRrroufp8nkK8p8tYD1OP8U4/P3A5hkGa5dwSfJ0v3gwukC8m70mB4jAWO
         ZqDmq0XcKzVDX/gNvNM+ll6qGZ1TeA6ADFNAtsM/sbxUiIU0QzNRDvzYy0m+GTQmFP8r
         M4zqp61yeMP+KYfYFnkG0Q1C1KkkZB/paFGeRYWmDOqsre/ciZaKxfSz/BgBWicHuMO4
         UN6+A13y0xZa9kgr3SpTVryXMKJUr16M3m3IaQUvVXrGPu6yxK/6V7tLZs3gmRgPyP7J
         HIK0/MncFtcrHKkfPlbw//qsQLDj41x9wxx2HxvrzFVNrZGFH27JZu+z7I2arbX74T5p
         fHww==
X-Gm-Message-State: AOAM533xAcqElzzTI+01/Iu4O4DBlmoWU3nhye+AxrzA+gS6LILnn9Y1
        3ft3sOTeYpfHmfqox+uT9clrqN8yjnFz6AwMP7Q=
X-Google-Smtp-Source: ABdhPJykDiz0AzVaoaUs4aHkau3AAtDAZ/ewV87Q1XEIBzcMj6OlpB+UYSoFWakcVx5TXsbYw/LJFw==
X-Received: by 2002:a05:6402:e85:b0:41d:121b:f436 with SMTP id h5-20020a0564020e8500b0041d121bf436mr13518567eda.121.1650790214813;
        Sun, 24 Apr 2022 01:50:14 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.245])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006e894144707sm2435971ejb.53.2022.04.24.01.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 01:50:14 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sam Shih <sam.shih@mediatek.com>, Ryder Lee <ryder.lee@kernel.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: [PATCH v2 0/3] dt-bindings: arm: mediatek: Convert some docs to DT schema
Date:   Sun, 24 Apr 2022 12:46:44 +0400
Message-Id: <20220424084647.76577-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

This series includes DT schema conversions for topckgen, apmixedsys
and infracfg bindings.

Changes since v1:
- Move mediatek,topckgen.yaml and mediatek,apmixedsys.yaml to ../bindings/clock/
- Remove items from first enums in topckgen and apmixedsys schemas
- Mention headers with clock and reset values in all schema descriptions
- Add clock framework maintainers to topckgen and apmixedsys schemas
- Rename node name in infracfg example to clock-controller

Yassine Oudjana (3):
  dt-bindings: arm: mediatek: topckgen: Convert to DT schema
  dt-bindings: arm: mediatek: apmixedsys: Convert to DT schema
  dt-bindings: arm: mediatek: infracfg: Convert to DT schema

 .../arm/mediatek/mediatek,apmixedsys.txt      | 35 --------
 .../arm/mediatek/mediatek,infracfg.txt        | 42 ----------
 .../arm/mediatek/mediatek,infracfg.yaml       | 81 +++++++++++++++++++
 .../arm/mediatek/mediatek,topckgen.txt        | 35 --------
 .../bindings/clock/mediatek,apmixedsys.yaml   | 61 ++++++++++++++
 .../bindings/clock/mediatek,topckgen.yaml     | 61 ++++++++++++++
 6 files changed, 203 insertions(+), 112 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml

-- 
2.36.0

