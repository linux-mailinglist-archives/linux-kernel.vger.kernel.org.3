Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFE55692BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiGFTlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiGFTlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:41:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3D9220F4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:41:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v16so12000680wrd.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dqftkVeBULFujgeW5u4Q72fmCV3i4BBjke3zKWOEy1A=;
        b=KcYSiIzyauYf2ZzkUlAvW4Roc8Wmt2dFij6im1jGYtHZTnB1gQJ9kLTN9uq2gU8k0W
         c8Ug4bvmQnuATs0Pyd3YuNLkkYCGo9NOyDZmTd2TODbApNfFoVdJnWYIEQauviZkfj1W
         aXwLKrSltHgl9GeHYJHjMzCezWfhq+U6+AwURORi8yrRX//1hQvzd1ZnWS70OzDJ9D0s
         fszyGefSzCfnIwSPI4WbjjJ4PH3V2X1ew8Oma0/QmB7hgR1mVLkU4y1i8DacjfuMlxs6
         OV4ARrk9xeF/jIG5r0vcL4QGXscG1QWOG9D7maiux8M51zF1fA7jbQTevAICTukeXrrB
         ZPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dqftkVeBULFujgeW5u4Q72fmCV3i4BBjke3zKWOEy1A=;
        b=TnqlTJ9diTuVHsPdR9leMl3mjVq9XQyhXeW7KrCdV56DbcZVZwuuWVH4NZYlTMAN8Y
         dnuQxf0e0IHe5o9nBzUXbbEybEdTbGiQxPKa9PIvNOsbXI4VTs+A6gAmJeG0pp+2E6qE
         681gPCxuJWjOq3R9bc59mJi3VORNGDaOlAMpAyDvtiJcxOyLulu4nCxZUli1isIwWdCw
         hyYMtYOP7r7jNGEfNK/Zpx3+ke1oqaN9qs7mz7X+JyZYmIgxtHu0pN/ccaZspEHERmJF
         SGugg0mYyGpsjmDEjUxSSLilyNIi7zy7fwbOiR3oLWMHqamu8uybVvF1AnNrKd5DwlNa
         W57Q==
X-Gm-Message-State: AJIora8RDObr3CGIVDgeg5dl944b+Fv+3UMGFEay5V6AuThtuIXYAZvn
        2zUtVs9RJeogNvQwrwNk9j/QNQ==
X-Google-Smtp-Source: AGRyM1sOu1aQFKgXk7TMbVOZRLxFaQ8UCtknqdZPyDoTSVFsby64OJ1WDVQbiTCNnRRxKrtq1QoATw==
X-Received: by 2002:adf:f705:0:b0:21d:74fa:c043 with SMTP id r5-20020adff705000000b0021d74fac043mr10132920wrp.77.1657136499186;
        Wed, 06 Jul 2022 12:41:39 -0700 (PDT)
Received: from localhost.localdomain (88-107-17-60.dynamic.dsl.as9105.com. [88.107.17.60])
        by smtp.gmail.com with ESMTPSA id f190-20020a1c38c7000000b0039c5328ad92sm23387320wma.41.2022.07.06.12.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 12:41:38 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        phone-devel@vger.kernel.org
Subject: [PATCH v4 0/2] power: supply: introduce support for the Qualcomm smb2 charger
Date:   Wed,  6 Jul 2022 20:41:23 +0100
Message-Id: <20220706194125.1861256-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Qualcomm PMI8998/PM660 Switch-Mode Battery Charger.
This is the second generation SMB charger, and replaces the previous
SMBB hardware found in older PMICs.

This driver provides basic support for initialising the hardware,
configuring the USB input current limit and reporting information about
the state of the charger. Features like type-c dual role support and OTG
switching will be added in future patches.

This patch series depends on my previous series adding support for
the Round Robin ADC which is used for reading the USB voltage and
current, it is currently queued in linux-next, and can be found here:
https://lore.kernel.org/linux-arm-msm/20220429220904.137297-1-caleb.connolly@linaro.org/

Changes since v3:
 * Drop DTS patches, to be sent in a future series
 * Add POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT so that the charger will
   be exposed as a cooling device,
   see https://lore.kernel.org/linux-pm/164f2458-fb66-f238-7143-bdbe1e200870@linaro.org
 * Run clang-format and prevent it from breaking the formatting of the
   defines
 * Apply Sebastian's suggested fixes

Changes since v2:
 * Use devm_delayed_work_autocancel
 * Minor driver fixes
 * Pick up Krzysztof's R-b on the DT patch

Changes since v1:
 * Rename the driver to pmi8998_charger
 * Drop unnecessary (and very broken) mutex
 * Rework the driver based on feedback to v1
 * Fix some minor bugs and improve Automatic Input Current Limit support

Caleb Connolly (2):
  power: supply: add Qualcomm PMI8998 SMB2 Charger driver
  dt-bindings: power: supply: qcom,pmi8998-charger: add bindings for
    smb2 driver

 .../power/supply/qcom,pmi8998-charger.yaml    |   82 ++
 drivers/power/supply/Kconfig                  |    9 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/qcom_pmi8998_charger.c   | 1044 +++++++++++++++++
 4 files changed, 1136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
 create mode 100644 drivers/power/supply/qcom_pmi8998_charger.c

-- 
2.36.1

