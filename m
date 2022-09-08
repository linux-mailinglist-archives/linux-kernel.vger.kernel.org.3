Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156765B29F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiIHXMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiIHXMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:12:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10285109D22;
        Thu,  8 Sep 2022 16:12:35 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f4so49130qkl.7;
        Thu, 08 Sep 2022 16:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qltd2yDSrwnG5kUIw7vyd0h0Hbo5ScANyMLuGKazsQg=;
        b=XyyF+qer+/7whFQ9A7DPFqS8fXBjAqI1Da4A3lswvGZ4QdrZFUXDeFsfxZ6qUazUoy
         tUWXwnBj3CMPWC3Vrb/jwkcM+cxqReoMP6cScqKzOSfm5MYegWnUPpounZ56T7fFrC8s
         hh9VB+2aKu4FS0ucqkKcXLp1c42QGMXKCavtEg463crdq9mZF1cQu2U+tD0KzmrKbm36
         DDHK8YlT+7BfuXBp4rFmK15qZCiROtzqytML3OgyiMCgyCuVpH/cah9wbj7uQ1OkkdOE
         LMQzp3uqa+XdwKyQPTjymDYAme3rTorYauh8Sg+dFmA7lWly2FHC+6zMLoABVvsJD9DK
         4pDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qltd2yDSrwnG5kUIw7vyd0h0Hbo5ScANyMLuGKazsQg=;
        b=rp1lpjK0aEnFtKn++/Re+OgEYkiImcYRDp3PWEOt+l7L68+7BOX+4pEPQiLx7wIAWL
         RBE94s127Aqdyno/M8wOB+qOgCG+Z6LbrUFKga402Jgcvpe8C7Kg/YUHIJtWT47yrlQS
         SEGuDqIuiNMnAz+NgbnAIKr4HDIN2cLBnq4ZMQ1rgQMsCxS6OtxHYE3KBqBnyaEaSHgf
         avS96v8aAGJ3kLV/3lGNvjnrwFoINNGeD9o103TG38hPBo3FqAh2xl48IFW75TBAHify
         74ZncPQfRLH8QDxVRJJ9lLomnJeT4iZEUbV+x7YDoVHbas3dllpHL79H6rUajbfrMuzd
         zGFQ==
X-Gm-Message-State: ACgBeo2+Cj+4htKZWc6Lf1O21KkOifZSmELuPR4aIFTNY6s8wCSRSbx4
        quvFe9exEZTscN5L/x2dsUcYaAiTvDY=
X-Google-Smtp-Source: AA6agR6r5dJzgQSWvJivdSyVEL1DySLPKpcScilhcuaglBTf9X40Xyxq0XP5ek2EUoxPZWnjfNtxeQ==
X-Received: by 2002:a05:620a:2a0d:b0:6b6:6c75:f050 with SMTP id o13-20020a05620a2a0d00b006b66c75f050mr8347327qkp.199.1662678753873;
        Thu, 08 Sep 2022 16:12:33 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::6f2a])
        by smtp.gmail.com with UTF8SMTPSA id u10-20020a05620a430a00b006b9c355ed75sm75354qko.70.2022.09.08.16.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 16:12:33 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH v3 0/3] SDM670 Global Clocks
Date:   Thu,  8 Sep 2022 19:12:21 -0400
Message-Id: <20220908231224.209020-1-mailingradian@gmail.com>
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

Changes since v2:
 - drop GCC_SDCC1_BCR reset
 - reorder gcc-sdm845 and gcc-sdm670 if statements in bindings
 - add space
 - accumulate review tags

Changes since v1:
 - regenerate patches to fixed malformed patch
 - fix schema so that the parent clocks are specified correctly
 - remove core_bi_test_pll_se from new parent_data to match array sizes
 - reference correct frequency table for gcc_sdm670_cpuss_rbcpr_clk_src
 - set correct index for sdcc1_ice_core_clk_src

This patch series adds global clocks essential for features of the Qualcomm
Snapdragon 670 (hopefully) cleanly into the SDM845 driver without doing
runtime fixups like in Google's bonito kernel (see patch 3).

This series (mostly patch 2) affects kernels made for Snapdragon 845 and
might need some further testing on SDM845 devices. I do not have a
Snapdragon 845-based device so someone else will have to double check if
necessary.

 .../devicetree/bindings/clock/qcom,gcc-sdm845.yaml |  61 +++-
 drivers/clk/qcom/Kconfig                           |   4 +-
 drivers/clk/qcom/gcc-sdm845.c                      | 400 ++++++++++++++++++++-
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |   1 +
 4 files changed, 449 insertions(+), 17 deletions(-)


