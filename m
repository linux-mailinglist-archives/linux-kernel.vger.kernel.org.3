Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892B04B64B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiBOHsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:48:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiBOHsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:48:40 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126C590FE5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:48:31 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D6E0C40259
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644911309;
        bh=/BLkLFYTDkoy0icaFTEEg+rA2J/JmQ87eCI7Tsm29s4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=AsAuCvsiRJRyxsa98jw05PEziRcrY8/6n4KXsEMGiv/RkGsKLUit7KoSS6hsUkOG8
         H58BNAo+rt6lZOEZH1d/sHqxuMOUcL1tv7OJC7vkV9G6u7nV0J0o6pcOfFCWYeLbmD
         k/sNcFfexQRdNKumTke/KP3rMPkNtBZK+ogqcjfkom56nKiA064CgiwO55nKR2k2z5
         6tFV0eDqEA6gnsf6cHSO4/mF6Ecy62Korle/HSMF/O3llUgw1MqGAUclUYpJcTcG+E
         8yAdwtksCvfC7HE/IRMUDuPdf2+lxrh5IhMtpzeJPhoAUE0KGirod0/VIJjfysfdhH
         2wc+tmHBC0Pvg==
Received: by mail-ed1-f69.google.com with SMTP id z8-20020a05640240c800b0041003c827edso10207225edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/BLkLFYTDkoy0icaFTEEg+rA2J/JmQ87eCI7Tsm29s4=;
        b=gnZPZDwLazwhv2oMb6yZD54G5zOqvZBM1ueCbea4EDwHQeMfCpqvLnLxoQqPS/6zs4
         vkChQHfZENKsSFRxPCBUdq3f2E1Yprb3NIiG1vYHacC2v+87Xb3oGLwujTw/rIIw8HOc
         xBYE2mcBU95eibeEKfFi05tW5ruQE3CyoQHJiR5iBM91K+26ZeJEmcktCLzuLlP1ku9Y
         KdYu5E5vILJRlLKiMa/AW/v9yGfmpGp9FcXkL2TbC7lN1YA4LfOTCdvj3OofBfza582H
         dijlOsYOn9avQyg8n8l32UxkCp7qwCS70pjpqYp8EBsNTBs7+57cIFW2FlUWkAKhV0cT
         qVRw==
X-Gm-Message-State: AOAM532BcWa4ctLEd2rf7/VgnUy41gI7ZESZN81ShT76lTshvVDgnL/Y
        p3rwEu8wMN/SC6h6HdXTRDvhFXOXb7ZBOl436g713UhLg1Dmbgp+0kPdquHYpZUPDvJPCgRoiVl
        Jij8HFwiZDCCZmb3b9+RUtxj2GleoWg0i5WkQ+wZXeg==
X-Received: by 2002:a05:6402:26c7:: with SMTP id x7mr2571505edd.151.1644911309471;
        Mon, 14 Feb 2022 23:48:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzPL6bZ87ZeeKAh5rp6FvE5VSLy/1ksnFjn1oCusi+AyfVE8IhUfVQttON0EX2l6IHA9kzfw==
X-Received: by 2002:a05:6402:26c7:: with SMTP id x7mr2571499edd.151.1644911309301;
        Mon, 14 Feb 2022 23:48:29 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id c29sm1188357ejj.149.2022.02.14.23.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 23:48:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/3] mfd/power/regulators: dt-bindings: max14577: convert to dtschema
Date:   Tue, 15 Feb 2022 08:47:56 +0100
Message-Id: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v2
================
1. Add tags.
2. Drop DTS patch (applied).
3. mfd: Fix indentation in bindings example.
4. regulator: Drop regulator-name requirement and use
   unevaluatedProperties.

Changes since v1
================
1. MFD: Use absolute path to schemas
2. Regulator: mention all allowed properties,
   additionalProperties=false, add min/max values for voltages and
   current, don't use patternProperties when not needed.

Dependencies
============
1. DTS patch 1/4: nothing depends on it, sending here so Rob's automatic
   checker won't complain about DTS.
   I will take it via Samsung SoC tree.

2. Final MFD patch (4/4) depends on regulator and power, so the last
   patches (2+3+4) should go via same tree.

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  dt-bindings: power: supply: maxim,max14577: convert to dtschema
  regulator: dt-bindings: maxim,max14577: convert to dtschema
  dt-bindings: mfd: maxim,max14577: convert to dtschema

 .../devicetree/bindings/mfd/max14577.txt      | 147 -------------
 .../bindings/mfd/maxim,max14577.yaml          | 195 ++++++++++++++++++
 .../bindings/power/supply/maxim,max14577.yaml |  84 ++++++++
 .../bindings/regulator/maxim,max14577.yaml    |  78 +++++++
 MAINTAINERS                                   |   3 +-
 5 files changed, 359 insertions(+), 148 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max14577.yaml

-- 
2.32.0

