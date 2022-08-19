Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D8059A6FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350975AbiHSUNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351758AbiHSUNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:13:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B93C614E;
        Fri, 19 Aug 2022 13:13:15 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id v10so5462159ljh.9;
        Fri, 19 Aug 2022 13:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=IcngjGV4zbZSOi+jrmaVhNkVii+NAIYV4colFiC23+E=;
        b=OfzHVubGC+1Rb/Q9WXF+4lnZWDgHRWUVYsWb/iRlxABOUpe9xu4EJXuTFnhA2WD3dR
         gyb1b5Im3UciVP6Hn1fd4ooggQQXaQ9fg15O18YaIgbQTCLWMZL7ABYXz0uBgzSZce1E
         8NxIa3n7vKt7sH82PlWOXafKLWmHEONXOi743c6cwMaQ+b+++Uf9C+3pP5a0XTnIu8CD
         fR5TI59FrfzZPJlk4mNRuVXFsjM/i8nGXLyhHJGzc0KhhLeioDzv60NNaXmv47TqX/qm
         eijFduGtk/9D+G3sXNYVYV5HyzFdjBo0ZYRFLm1De2EiCDgSyzKcn+u8nlNhoUXQ49Qv
         SkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=IcngjGV4zbZSOi+jrmaVhNkVii+NAIYV4colFiC23+E=;
        b=0O6T4gfW7adbLaae8ZPLgB/53v7RRqCrWroYcsgre4LjI+J6xeZpWnI4XxQFCt7kkm
         FLWJpEbw8pAAQPZRwk4Pt4lVLupNWTPd+/N2yuyVnSDCARQ3gXWwLs1jD0RvMpiYifUl
         z4KA/KElSYtUByGI3aio5y4pxY8k00LC/1kY52b/3+GEZwNex3p1tKMh/IFCYGZLtquf
         JiRi4YNNXKjWc6r9ikXl4pOj7CZUWa/MvC3sCYqfbugtHjIGoOLi8+6U/4GQZuIRDMKN
         EEXZGMFEpYwmjPSk4Ejx8qs89vyLF7sZl2+9mInn75yihAwDNkaAixxO+s1NLzh0ag3E
         MBqQ==
X-Gm-Message-State: ACgBeo1TSH8mBKraJtIWxSZSkVljqSAb8drmgq+NkL+erro3jKvw/c2R
        Y5aWXN23R0y5lQjmjfmqn7dNyigZpIE=
X-Google-Smtp-Source: AA6agR6MsxnDx/xQDuFezqzCmoeAapiezI9Y2xzEeTt6Sdc9D4VihW/YVyw15kGNZNkOuR2TApK8ew==
X-Received: by 2002:a2e:940d:0:b0:261:c5c8:3403 with SMTP id i13-20020a2e940d000000b00261c5c83403mr76538ljh.86.1660939993307;
        Fri, 19 Aug 2022 13:13:13 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id h25-20020ac250d9000000b004916f129729sm753895lfm.50.2022.08.19.13.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:13:12 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add DISPCC driver for SM6115
Date:   Fri, 19 Aug 2022 22:12:20 +0200
Message-Id: <20220819201231.23474-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduce support for SM6115 display clock controller,
this driver is based on QCM2290 one.

Changes since v1
================
1. Changed bindings file names to Vendor,SoC-IP format.
2. Changed include in dispcc-sm6115 to reflect name change of bindings.

Adam Skladowski (2):
  dt-bindings: clock: add QCOM SM6115 display clock bindings
  clk: qcom: Add display clock controller driver for SM6115

 .../bindings/clock/qcom,sm6115-dispcc.yaml    |  88 +++
 drivers/clk/qcom/Kconfig                      |   9 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/dispcc-sm6115.c              | 615 ++++++++++++++++++
 .../dt-bindings/clock/qcom,sm6115-dispcc.h    |  36 +
 5 files changed, 749 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
 create mode 100644 drivers/clk/qcom/dispcc-sm6115.c
 create mode 100644 include/dt-bindings/clock/qcom,sm6115-dispcc.h

-- 
2.25.1

