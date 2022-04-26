Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36FB50F27F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343995AbiDZHfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiDZHfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:35:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB82F69A7;
        Tue, 26 Apr 2022 00:32:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g19so30395279lfv.2;
        Tue, 26 Apr 2022 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KGVWNZVJs3H4ln7FqWp8hNIQLAnf5hs9n+dr8i9g9tg=;
        b=VzU/kOlnRRt72ndXE20uRMJGW7pW5wxcTn8B0SnCn0x548hG00MUtin/JiPmRl6Pl9
         05tBaEBidCN9b0v1jXXX1E1uKr85X2WLyJtnH8JZWradn9WlyRyxrU7pHJXbeWozESUo
         v2HRWZnnSHpA3V8YgrKitZRByAgdhLgF+nX5OxrL/zX21ugYuDItWLEZTj3OStmHxqFR
         hdTziQkjgMwwu17DfFP0yJfbQRF9ScMKwEjnHGJqyDmuRcrIUY07Um6jX2haGmCp0eu1
         qhx+XCkYGPYsxLQe1qkk3xYHzcq8PvzMCNn/wLzmuaKQWUaoXZGml9maux3gYcIJGY/p
         R0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KGVWNZVJs3H4ln7FqWp8hNIQLAnf5hs9n+dr8i9g9tg=;
        b=pQgyrhp/53WICIwBqW0cB9ExdeKw4C5w5iCT+NW4zKJQlF51qE5gS82yMvGHhPOEnU
         pWeLBPZEb2PEyXE4ypkTqwywVV+01PEiipHnlJHOUsy2Ds9id6YzVAjzmJvr9BkKphCr
         KDcBbro+ySp109uGa2S4HaQ23hutHrIZa9d3RSIoEuu2jH52Z3Jgc6XG/JpNzyaw/bzQ
         fivV27TeTpFWWjw+/9GNSi5J9XVRBMnHEfSh1myXTOY8bUu18Z51JWjtx5ldo59sWkYb
         H1cAZXLW81hqgiml8HWOjRkr3EFZaean3f47eUz4nZ5FrsyoJgdx5RKCE/nO0Q+SNFY3
         6Hug==
X-Gm-Message-State: AOAM530Qn7TRF155ovaOBs5cMPbAquzR+clvK4a4LZAOHEismR3p415z
        TJOa+X1qZtd96B3mEbRFGVbv3SLKLec=
X-Google-Smtp-Source: ABdhPJzV0w9Ag/2E0pd5HIehjAlfu13I+V9s9zGFXbrSLGznof90bE58xbsYOgL/b6SH5rZ7TbjiOQ==
X-Received: by 2002:a19:ee05:0:b0:46e:2f8d:db76 with SMTP id g5-20020a19ee05000000b0046e2f8ddb76mr15945835lfb.321.1650958329909;
        Tue, 26 Apr 2022 00:32:09 -0700 (PDT)
Received: from localhost.localdomain (adla4.neoplus.adsl.tpnet.pl. [79.185.4.4])
        by smtp.gmail.com with ESMTPSA id d2-20020a056512320200b004721999f1cesm103509lfe.66.2022.04.26.00.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:32:09 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] MSM8976 GCC updates
Date:   Tue, 26 Apr 2022 09:30:45 +0200
Message-Id: <20220426073048.11509-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series brings small fixes for SDCC clocks
and adds reset for modem.

Changes since v1
================
1. Adjusted comment line length for SDCC patch.
2. Added Acked-by to dt-bindings patch.

Adam Skladowski (3):
  clk: qcom: gcc-msm8976: Set floor ops for SDCC
  dt-bindings: clk: qcom: gcc-msm8976: Add modem reset
  clk: qcom: gcc-msm8976: Add modem reset

 drivers/clk/qcom/gcc-msm8976.c               | 7 ++++---
 include/dt-bindings/clock/qcom,gcc-msm8976.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.25.1

