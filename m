Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB612515D10
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiD3M4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiD3M4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:56:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652DE60AA6;
        Sat, 30 Apr 2022 05:53:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dk23so20055662ejb.8;
        Sat, 30 Apr 2022 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mAQMceYOTyepNyy81qetN6xjIgF24kvDcmdMEakHKdA=;
        b=VDQiZ9gle0DYIu1HeD8kYTH7Q0GdjrSCveevSvIMnCmpzxrj5oYVykEkKFcUS5qJuw
         v4dpV7ydmobrQXwA6g1NvIhZXri40c7gherhrlOO2p3adabtYe575xvIoNeiBXwShelk
         40XgCUm4vsIv3qLrfAbg9u/6xvGTVm6hqLIOsFkhpcFpFLuz3ul1IjYxwz4npthkwe+G
         /dw1Nf5Z1rbY2MKl2CDfcWjw4QMVaYbl86AmKNPO/jG0NoCjxUhFwA0ULIYqUq/TCYQe
         fj0D3OnXRwKjgfQ7C0BAs9tQm7S0H5eF2r87Vjiuhc0bVyxmL9LUf9DqqLPfZcyCBDgO
         I70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mAQMceYOTyepNyy81qetN6xjIgF24kvDcmdMEakHKdA=;
        b=BJylXI/2gCxam/yFGnVpD8Oi2Sob7k2L5g10ddSC7yMcK2h7vkVEv9RTH4dgksmCeW
         xdfj+aR8G3sQIRWp+5DVKmeTstlHpCHtcU6mlJmw9+y9YScKsJ/NEV9c+els6HpDW9IZ
         pmykwaqGSCpTN0pn2GwS9DSgNeYlJz76PmDk/WNGbUOqxM+Yr2Ap+yUM9Rm3h/Xs4i5c
         Om5PePaMAsD6orq4EPa1OB0rwnv9wmi7BORyES8yVQw8CZHz1KVE60lDNV2EeeMOxAvs
         Q0wdkWs3dJPXPlI53vEMkPVTPr3PYbR5u9xE1iC7VzCz0Z0Cn1DIjubJqu5oAk1642ea
         n0LQ==
X-Gm-Message-State: AOAM533UOcnhi+Jqa7ZQB9jQw7bA7Jd21Stm2TcIrZP8BFiysUFoVx94
        CMZ+C6COFU41JsJpua0SGtJ9QJK0dE4=
X-Google-Smtp-Source: ABdhPJwApadsEjI+8tlebGbQqspwcBB/aD15404MIyeQLr5Rc9ZTI73JUP9ssVlMGbeiJGf/5b1ViA==
X-Received: by 2002:a17:907:7f08:b0:6f3:8c69:1779 with SMTP id qf8-20020a1709077f0800b006f38c691779mr3660647ejc.414.1651323195618;
        Sat, 30 Apr 2022 05:53:15 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id jl25-20020a17090775d900b006f3ef214dc5sm1597209ejc.43.2022.04.30.05.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 05:53:15 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 0/3] Small fixes/improvement for hfpll and krait
Date:   Sat, 30 Apr 2022 07:44:55 +0200
Message-Id: <20220430054458.31321-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has small fixes/improvement to the hfpll and krait clk
driver.

This comes from another series that got split to better facilitate the
merge since it was grown to 21 patches and was getting hard to review.

For hfpll, a conversion to read_poll macro and introduction
of a timeout to prevent a stall.
For krait, a fix for the mux sel logic and an introduction for
8064 errata.

v2:
- Drop patch add hw_parent check for div2_round_rate
- Add extra comments for errata patch

Ansuel Smith (3):
  clk: qcom: clk-hfpll: use poll_timeout macro
  clk: qcom: clk-krait: unlock spin after mux completion
  clk: qcom: clk-krait: add apq/ipq8064 errata workaround

 drivers/clk/qcom/clk-hfpll.c | 15 +++++++++------
 drivers/clk/qcom/clk-krait.c | 23 ++++++++++++++++++++++-
 drivers/clk/qcom/clk-krait.h |  1 +
 drivers/clk/qcom/krait-cc.c  |  8 ++++++++
 4 files changed, 40 insertions(+), 7 deletions(-)

-- 
2.34.1

