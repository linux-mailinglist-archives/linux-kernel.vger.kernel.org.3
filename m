Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60E95B2D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 05:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiIIDzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 23:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiIIDzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:55:00 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E876031EE4;
        Thu,  8 Sep 2022 20:54:55 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id g1so486277iob.13;
        Thu, 08 Sep 2022 20:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/uyBRMEikTz9wOSLj9AqlzoRT8lcwegTukvkQYz070M=;
        b=UF7EFMgSF3EZbwpizFW6LxxpW6lyHMx/lFvLXfS5EgunOz3sek01LZARwdcL3SrYAP
         /l+DnruPC8qyl/x6SElf61TslAanahES/SsbA+S96RKRHLkXr0m7WDjh35bqutpkr5sB
         v4+fLqWRQocQf/LVJN7WCv/TxMHuMXPWNn7Tjf4MJvnuJsmzuJZThX4Zgb7pduxgZTiC
         ZlqJ6BO6YIA19HjG8BwyJcSnLC665pdsQeaVpwezIGJE2+6tVEwLdTJQkPtu/qwtR4DX
         KuqUsczl7Soi2PBoFw2hshz+uhC+gZy4KDCihAIprFzt34Dx7P8tTH7Oas7uI8i/AjeV
         yXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/uyBRMEikTz9wOSLj9AqlzoRT8lcwegTukvkQYz070M=;
        b=oEsboOzmUwpT0rdsmIMuXk56r82Bwicqv9h4/TzVlmpEXHBhIheNXorqWmWB8lTQF7
         /cLWELFzDPFNT8VuQOhEDguBsXlaD26jiHqYrweWjZW8HU0WVlWpc3e0EYT75n9+s88I
         oa494ZoAtsPmxj/uvOV27G6f0xgDptlA5nXZa261LXi0i7LoskPAsg2uGRQp6N+gqqSS
         7oG6m6aJAHRHaeP1VxtsHtr/JKojKH3Ihq5+7SV1wIcXNrxWiaexeLo0T4BZwETromXF
         WHULfjUg2AkbkVqjYMzlfrhkS8+jWJWwOrvPqPX/nfI3FJy5VOeEqC3csQq+3oUAVAs+
         55Vw==
X-Gm-Message-State: ACgBeo3unhdPszoDX61PMlGZXqfzbBXvCn6PDV++bG6XTW58apcH1LOF
        R9ytXOZkm3Lbzy6LogBd9eXYyRdJj18iVw==
X-Google-Smtp-Source: AA6agR4Etjyn7EXO3SjC8lxkd9nZprz/ppU4lcYhVYWK+QHiTosVVqJIQGsviPy9XViLFydItd6j4w==
X-Received: by 2002:a02:c909:0:b0:346:a951:9cfd with SMTP id t9-20020a02c909000000b00346a9519cfdmr6243487jao.138.1662695695291;
        Thu, 08 Sep 2022 20:54:55 -0700 (PDT)
Received: from fedora.. ([2604:2d80:4d8e:a000:6063:7cd5:2f24:16a6])
        by smtp.gmail.com with ESMTPSA id n28-20020a02715c000000b00346b4b25252sm330579jaf.13.2022.09.08.20.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 20:54:54 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Add support for Xiaomi Poco F1 EBBG variant
Date:   Thu,  8 Sep 2022 22:54:44 -0500
Message-Id: <20220909035447.36674-1-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Changes in v5:
--------------
- Do not rename the compatible property of the existing variant (Tianma)
to avoid any further conflict with other projects/users.
(Suggested by Krzysztof Kozlowski)

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
keep the existing compatible property to avoid any conflicts with other
projects.
- Adjust the Makefile since the sdm845-xiaomi-beryllium.dts is now called
sdm845-xiaomi-beryllium-tianma.dts for the tianma variant.
- Create sdm845-xiaomi-beryllium-ebbg.dts for the EBBG variant which will
inherit the common dtsi and set a different compatible property to
distinguish between the Tianma and EBBG variant.

Note:
-----
Both the panels are already upstreamed and the split is based on them.
There were patches earlier for both the touchscreens, but they are not
accepted in upstream yet. Once they are accepted, we will add them to
respective variants.

Joel Selvaraj (3):
  arm64: dts: qcom: split beryllium dts into common dtsi and tianma dts
  dt-bindings: arm: qcom: Add Xiaomi Poco F1 EBBG variant bindings
  arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce Xiaomi Poco
    F1 EBBG variant

 Documentation/devicetree/bindings/arm/qcom.yaml   |  1 +
 arch/arm64/boot/dts/qcom/Makefile                 |  3 ++-
 ...um.dts => sdm845-xiaomi-beryllium-common.dtsi} | 11 +++++------
 .../dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts     | 15 +++++++++++++++
 .../dts/qcom/sdm845-xiaomi-beryllium-tianma.dts   | 15 +++++++++++++++
 5 files changed, 38 insertions(+), 7 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sdm845-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} (98%)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts

-- 
2.37.3

