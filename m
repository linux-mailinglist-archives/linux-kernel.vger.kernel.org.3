Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64965A5D75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiH3H4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiH3H4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:56:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC8BCCEC;
        Tue, 30 Aug 2022 00:56:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id az27so13053395wrb.6;
        Tue, 30 Aug 2022 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/vfXkDiukgjzByxKg7vHPJn4YS2JXKWdQiZQUORsK3c=;
        b=PmMPGuUPZyy3Kp/74FafmByXzCgmk6Ornbq0qozSxoT0C0BbYQtt2+rNyEweeoXznl
         mFRO8j7D3WHpafoE1kBWIrN5IybCxnaDO604bt0e6gc9MeQA71CYU9/iuvynsFlfsx+X
         OVTgK2hMkKTAg8NU3S+WgjlLUGAbw0PFn0dk4Pb1ZpXZnN/PJ41IRfpHieGOhDtg3f+m
         jGHkbmlCv5ZBK9eNiWU8aoCeRbvtxa5IzVO+JK6tbo2kXUwhXR4zZFjjtVpwXq9xdbtn
         heb2IakyuqsryweBpWOS8ixRE3VgOwlAMMnMAHo3FPSbEZxDfcoiQ8poA/BkjY/j5krq
         +hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/vfXkDiukgjzByxKg7vHPJn4YS2JXKWdQiZQUORsK3c=;
        b=boRiKhXH60/reoe8gZkj6ilzf/SwwlTLVvcOlbnFbWcR1ThYGmchBhdZSG/ZQnMue8
         O/hhTIBKmA6xvxu/S3Gns76y0C8pKqMUc9fsR0yw4iOcroQNjCtF9zF8LL9TDv3zCtn2
         j2yDb2h/JS3t6rQeEydGTygdMK+jH/GqXlIxcZFH4flMiWgpoEboXSIhCu4juTR1prV3
         pIJOQ+DhjIxn7FDoHbnXutwo2Wtv2wiAROnExfK/VQnLZyAkUKufcnQr1UFC8YHxwoA3
         frw8CcDi3/9jsZ8jmJMGnWrnuu3148dZxrqTuRXQcNhVMnQZ5yN2WIiiGjuhAxhFNTCv
         cX2Q==
X-Gm-Message-State: ACgBeo2SXOqWSL/j/oI0pk05GbJDplBqxbNaePBHJHWWQlIrTZbeE0G/
        9EvE3tJcrcwWH8FDbSr348s=
X-Google-Smtp-Source: AA6agR5UoAD14L/GiBQZl43uJnjtTWJhzoZk9YWDjUsDD1ZYNVrMqSgA5HIDDj7yL6ra6LDudpp9Kw==
X-Received: by 2002:a05:6000:168d:b0:226:da6a:6d78 with SMTP id y13-20020a056000168d00b00226da6a6d78mr4759605wrd.180.1661846193394;
        Tue, 30 Aug 2022 00:56:33 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c0a0700b003a5c1e916c8sm2445719wmp.1.2022.08.30.00.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:56:32 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Adam Skladowski <a_skl39@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH 0/3] Merge non-standard qcom clk PLL offsets
Date:   Tue, 30 Aug 2022 10:56:17 +0300
Message-Id: <20220830075620.974009-1-iskren.chernev@gmail.com>
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

Both the qcm2290 and sm6115 gcc drivers need a non-standard Alpha PLL register
map for DEFAULT and BRAMMO types.

The initial gcc-sm6115 was lacking the DEFAULT override, so fix that first,
then merge the two overrides by using newly created DEFAULT_EVO and BRAMMO_EVO
types.

Adam Skladowski (1):
  clk: qcom: gcc-sm6115: Override default Alpha PLL regs

Iskren Chernev (2):
  clk: qcom: gcc-sm6115: Move alpha pll bramo overrides
  clk: qcom: Merge alt alpha plls for qcm2260, sm6115

 drivers/clk/qcom/clk-alpha-pll.c | 21 ++++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  2 ++
 drivers/clk/qcom/gcc-qcm2290.c   | 56 +++++++++-----------------------
 drivers/clk/qcom/gcc-sm6115.c    | 48 ++++++++++-----------------
 4 files changed, 57 insertions(+), 70 deletions(-)

-- 
2.37.2

