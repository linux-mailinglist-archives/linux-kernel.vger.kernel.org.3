Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4183F5A3FBF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiH1U5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiH1U5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:57:35 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF4530F4B;
        Sun, 28 Aug 2022 13:57:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 10so5172218iou.2;
        Sun, 28 Aug 2022 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=mC6gBj0kuKVX2cf4bAsxRZgtAWFeJDMdJEm3tu/7KE0=;
        b=T0fmWP96TcARxU5ZFjM7lFdHzW89Psc3kO7UC2oX8G5q4OBprGJlGx+gGXdPZ/wkts
         v6sbtR146h3BAhGS+pJgskLcv20KW/b7YLIbI8b6BpwK3ClfOQo4X1pDW8vEy2h/0T+H
         XWEhAhx/I7af53VtAP4SivnEvz9f/9WWJZq01VR0dmtxybtBBEVjO9GpENg08SnGWalJ
         /NH+tLza1adfvOw7Wj55GY0uHnK5u5uurjEYcGdBF72cfVhN1Ag9suAfhfZE86bwF9Ks
         g//GK/9MBKN0ZB+BSjlp/d2Tm2cvcxii9112ibW4owH68tkpFVonBLjp0geC7YZwbkNv
         4mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=mC6gBj0kuKVX2cf4bAsxRZgtAWFeJDMdJEm3tu/7KE0=;
        b=kTjWd42MSykTpBguE0uyEmfPTHpLeFQ/xVZv1phMDFG82tSJXWEhoSDSSCb3ob48qQ
         NIlrwHcqA5/pdwg0zUh++WNy2sBux4qwz3P7DUjaayC7P1GVYI/pcFGWaOsCZwXVvXk6
         wTb6ADLsq9FjQmL3UWgar9lWiBW4iMZwPeJ/9vl64/inTyW/gRB0SET3SsOfL9XT3WXy
         1nm+uXHxdSnL7ALs6M4BDas+hD6La0QYs6b4A+deUkA9cELzLEZVVlUc5ACr/jaHXo0o
         CH2/acmi88PG/5GJcZVrWHh+vLjGrZCU48nzJubFpITY0WaNMI70Xt8J76Lky8B3xMOo
         4ccw==
X-Gm-Message-State: ACgBeo1tcMSi34oJq8rn1bsJciTroEjvGbEtwuyPoEIdumyipT3t9o7E
        im3h0rlIIVc27qbuCYT0LSI=
X-Google-Smtp-Source: AA6agR6OO+f6eE3ZKSSjmUojO8RtfbWgx8DaB8WYlp3Dx1ldjtQ//0oSwZmHxWqjfUCx/WFJwFzd2w==
X-Received: by 2002:a05:6638:2105:b0:34a:694:4fa4 with SMTP id n5-20020a056638210500b0034a06944fa4mr9332943jaj.116.1661720251715;
        Sun, 28 Aug 2022 13:57:31 -0700 (PDT)
Received: from fedora.. ([2604:2d80:4d8e:a000:6063:7cd5:2f24:16a6])
        by smtp.gmail.com with ESMTPSA id k7-20020a02c767000000b00349be1ef390sm3572404jao.121.2022.08.28.13.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 13:57:31 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v4 0/4] Add support for Xiaomi Poco F1 EBBG variant
Date:   Sun, 28 Aug 2022 15:57:19 -0500
Message-Id: <20220828205723.20834-1-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Changes in v4:
--------------
- Update board's compatible and model property to distinguish between the
two variants. (Suggested by Krzysztof Kozlowski and Marijn Suijten)
- Update the dt-bindings as per the new compatible values.
(Fix checkpatch.pl script warnings)

Changes in v3:
--------------
- Approach suggested by Marijn Suijten and Krzysztof Kozlowski to make
git handle renames more appropriately and to avoid moving large chunks of
code. Helps with reviewing the patch.
 
Changes in v2:
--------------
- Fix issue with builds breaking across multiple commits making git bisect
harder to find where the rename has happened.

There are two variants of Xiaomi Poco F1.
- Tianma variant with NOVATEK NT36672A panel + touchscreen manufactured
  by Tianma
- EBBG variant with Focaltech FT8719 panel + touchscreen manufactured
  by EBBG

The current sdm845-xiaomi-beryllium.dts represents Tianma panel variant.

To add support for the EBBG variant:
------------------------------------
- Rename sdm845-xiaomi-beryllium.dts to sdm845-xiaomi-beryllium-common.dtsi
- Generalize the display panel node by assigning label, removing
compatible property and renaming the panel endpoints to be generic.
- Create a dts for the Tianma variant called
sdm845-xiaomi-beryllium-tianma.dts which will inherit the common dtsi and
set the compatible property for the respective display panel.
- Adjust the Makefile since the sdm845-xiaomi-beryllium.dts is now called
sdm845-xiaomi-beryllium-tianma.dts for the tianma variant.
- Create sdm845-xiaomi-beryllium-ebbg.dts for the EBBG variant which will
inherit the common dtsi and set the compatible property for the respective
display panel.

Note:
-----
Both the panels are already upstreamed and the split is based on them.
There were patches earlier for both the touchscreens, but they are not
accepted in upstream yet. Once they are accepted, we will add them to
respective variants.

Joel Selvaraj (4):
  dt-bindings: arm: qcom: update beryllium compatible property
  arm64: dts: qcom: split beryllium dts into common dtsi and tianma dts
  dt-bindings: arm: qcom: Add Xiaomi Poco F1 EBBG variant bindings
  arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce Xiaomi Poco
    F1 EBBG variant

 Documentation/devicetree/bindings/arm/qcom.yaml   |  3 ++-
 arch/arm64/boot/dts/qcom/Makefile                 |  3 ++-
 ...um.dts => sdm845-xiaomi-beryllium-common.dtsi} | 11 +++++------
 .../dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts     | 15 +++++++++++++++
 .../dts/qcom/sdm845-xiaomi-beryllium-tianma.dts   | 15 +++++++++++++++
 5 files changed, 39 insertions(+), 8 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sdm845-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} (98%)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts

-- 
2.37.2

