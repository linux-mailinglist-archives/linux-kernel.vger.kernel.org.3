Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443DC5148C6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358834AbiD2MHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiD2MHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:07:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB10EC864B;
        Fri, 29 Apr 2022 05:04:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id p4so8888413edx.0;
        Fri, 29 Apr 2022 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDXW/gHKMHWr4XCaRCd5FkSwtpihwObu66H7PIUemjo=;
        b=bcckHpxFLgWw62oWN6veplwFoPqe86R7LpKyhQzfVOKVhcepK+jOHqmm746lKkVKU5
         W1r/bsUQkGC90wNd94KRUuC8TV5rpxDIsa98qDy/lJuC83HO5geV0Chof4LYjlB/JtQ7
         q60LGOVk5FERiTmx7nLDsMXaivnycIIUBVep5cF5bzz4mwTCvqmVmSD/3GEjspJMDrd5
         g97bdlErRxpZYRJuAYoCAlnymhrViiO8tJyYh1qgwD7VyWKqh+baqILyUV0udvWW6Zlh
         v4MH/xJw3oe1hwg9k/wpGlvLTlGWpxDF3oABWqYKF3xD/S+EFWaxWDMxg62YqRs01iQk
         4/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDXW/gHKMHWr4XCaRCd5FkSwtpihwObu66H7PIUemjo=;
        b=VGOp0u0ZUXbf52CurcHgC/2f/TewymKbeE9gkYPtQd2QzbPZGRwODLZtr77ku8s3OP
         Rjg6QSzOqMeW3OnfeaEMDdFeAJ+mz6mDTWQ4aRhV5jrhEzr+KgfxmP6lHsdupuTdsjMo
         EzDPF7ONEWwYAWlJpBrolf3mrDikkDPufWCGTjvExdM+rlXecJ2LsCgbSHnhrvLPpqmy
         YlQhTNAi83/vkKeKsgnyNTOtKwZT9KG56PwQZFbJVmryirBFND5we9SHPaQQhehIbPHi
         i04LG1Wra72M+SxQ9gBNaU/Xwtf4oO+0j1c3Z97A0odTm0Xy5MQkVF0vzhQroJ5f1evI
         jnng==
X-Gm-Message-State: AOAM530AALiho2bPVOhZkwvf4Zp2N5BUbnhzOKoZNOIrbL0L+DJ4eQB3
        d93alg5fhROriUYiCA8UXPU=
X-Google-Smtp-Source: ABdhPJx4XFt5/Rsn/IZeluPvzf1O4xt9bGEEJcILXi5vd3CSiYKhRSHUHvPHydjdcoAYikLMJ9m3Jw==
X-Received: by 2002:a05:6402:1592:b0:425:edec:992d with SMTP id c18-20020a056402159200b00425edec992dmr24684618edv.283.1651233866124;
        Fri, 29 Apr 2022 05:04:26 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id eo9-20020a1709069b0900b006f3ef214e02sm581338ejc.104.2022.04.29.05.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:04:25 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 0/4] Small fixes/improvement for hfpll and krait
Date:   Fri, 29 Apr 2022 14:01:04 +0200
Message-Id: <20220429120108.9396-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This series has small fixes/improvement to the hfpll and krait clk
driver.

This comes from another series that got split to better facilitate the
merge since it was grown to 21 patches and was getting hard to review.

For hfpll, a conversion to read_poll macro and introduction
of a timeout to prevent a stall.
For krait, a fix for the mux sel logic, an extra check for
div2_rount_rate and an introduction for 8064 errata.

Ansuel Smith (4):
  clk: qcom: clk-hfpll: use poll_timeout macro
  clk: qcom: clk-krait: unlock spin after mux completion
  clk: qcom: clk-krait: add hw_parent check for div2_round_rate
  clk: qcom: clk-krait: add apq/ipq8064 errata workaround

 drivers/clk/qcom/clk-hfpll.c | 15 +++++++++------
 drivers/clk/qcom/clk-krait.c | 30 ++++++++++++++++++++++++++++--
 drivers/clk/qcom/clk-krait.h |  1 +
 drivers/clk/qcom/krait-cc.c  |  1 +
 4 files changed, 39 insertions(+), 8 deletions(-)

-- 
2.34.1

