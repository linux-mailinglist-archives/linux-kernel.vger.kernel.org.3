Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5DE50776A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356312AbiDSSQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356270AbiDSSPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:15:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEAF3DA6E;
        Tue, 19 Apr 2022 11:12:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 21so22392083edv.1;
        Tue, 19 Apr 2022 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cy8TdUV8x3iwzNlE2xZ7cx5RS0sHcFrbbwckLVw+J9Q=;
        b=Hz0RP0xrJqEH7bYt7u6u/Kbq4MM3XxIJAahRbexVTlW/TNeAPFKMAEoowQ6mtL60Sm
         mH88jfbb69ULYKULr4eVODbzYBxoKva1nnBL428n1zoJenqgBca2iuezxRPcyB7gS1Wj
         rUjwwCUiKZ1cUtkCVuwbmHldhx6z3z7IDmMryeyNVVmVLq8lTIFcRcDv/5zAfccfxojK
         UeP1mFmWR6GhP3fT7zp1q9tnjQfvRTqzYVJMN1JUPLU7TrLRyGm2RDpJjAbvcwA29Fun
         /AKxmC3cudsURoZYiT+KzIlBW1PEpNH8g6MPlKJwAq9l9HhBy0pyIds6T/9N0GOsW7Ag
         wk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cy8TdUV8x3iwzNlE2xZ7cx5RS0sHcFrbbwckLVw+J9Q=;
        b=gtELGaEV+mfjOZevU4QBTLO0d14yLWf8Qh995jXLv27svOIzOhZoEFl90RXGS/YsvF
         Lf0x+sTy8deXWTzC7XkGMM9GC5Ixg1aHKN//z9zRjLNHDYn8w+O5eraHqSVc6ZN7tf75
         4FbGlc3l0GmK2oQU5+NBMCZbJOrnBV9b0zzq46j1rx016gmlV8h3zyK3rn5CSWKBKdw7
         uP/aMYSB1TjbPsF4cz4dNioM/ElwtUEm/9PXK7/9agVKgCdwZQPne/ZGtQ0ag+wm3xPT
         nC2Jn8U0eE2Asi8kLR1+JDj+9BpU2IhhmB0VnAZXxNG18makCZ47XAayA/feUESgvVPk
         msRw==
X-Gm-Message-State: AOAM530zFk4IC31skQqnmUaFuLTjRUQ5rj3EXist1BZ+CxFDSagxO2gX
        ai3q59fqZ5YNE3Zp9wCx+w8=
X-Google-Smtp-Source: ABdhPJzLpBirEv7DlSCYKQ+4N5y6Aw9ZMFDpfBRmkgmJYrEZ7quf1Kt6VRVcCBpuJ+wOWapmcAdFFQ==
X-Received: by 2002:a05:6402:5207:b0:423:fcbe:ceff with SMTP id s7-20020a056402520700b00423fcbeceffmr5516393edd.387.1650391939833;
        Tue, 19 Apr 2022 11:12:19 -0700 (PDT)
Received: from localhost.localdomain ([212.102.35.230])
        by smtp.gmail.com with ESMTPSA id b20-20020a1709063f9400b006e12836e07fsm5930614ejj.154.2022.04.19.11.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:12:19 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sam Shih <sam.shih@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] dt-bindings: arm: mediatek: Convert some docs to DT schema
Date:   Tue, 19 Apr 2022 22:09:36 +0400
Message-Id: <20220419180938.19397-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.35.3
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

This series includes DT schema conversions for topckgen, apmixedsys
and infracfg bindings.

Yassine Oudjana (3):
  dt-bindings: arm: mediatek: topckgen: Convert to DT schema
  dt-bindings: arm: mediatek: apmixedsys: Convert to DT schema
  dt-bindings: arm: mediatek: infracfg: Convert to DT schema

 .../arm/mediatek/mediatek,apmixedsys.txt      | 35 --------
 .../arm/mediatek/mediatek,apmixedsys.yaml     | 60 ++++++++++++++
 .../arm/mediatek/mediatek,infracfg.txt        | 42 ----------
 .../arm/mediatek/mediatek,infracfg.yaml       | 79 +++++++++++++++++++
 .../arm/mediatek/mediatek,topckgen.txt        | 35 --------
 .../arm/mediatek/mediatek,topckgen.yaml       | 60 ++++++++++++++
 6 files changed, 199 insertions(+), 112 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.yaml

-- 
2.35.3

