Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBCB553748
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353516AbiFUQG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353475AbiFUQGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:06:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BEBFDE;
        Tue, 21 Jun 2022 09:06:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ay16so9137883ejb.6;
        Tue, 21 Jun 2022 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/rYDj4w6bdUe/1X9k5V/3W4DgdceeouS/VnmjUwoWQ=;
        b=bpJzrHTpw5y0ZOqT1UcyAiirUhCaS9/ls/enJWHa8UxyXrGryoXp+owRp/QMrvQu+d
         13qtH6DeF5BwFbZzNIlClV5QdWuuUEdAYu34025u2xmhxOYbh9PShykfBOR8rz9Lqbn9
         +yPQ77Y5NRAzjfkuGloazLmc6hfOilVsg+jFpaMy+xREBgZWg5OaG9Tic4G/T1yqIUhr
         UgZAlesNxSUF6JrbKOMct6X6upfQMaySX3rDkdR/rqGbz24v0qnjUeq5oCPnAki8md1S
         TbMhI2/iukR9Yw/mnpzqndRGHPc+JP2X9xdMJpjuUWZX1L328VqU9kti7euvhrgPzvof
         nQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/rYDj4w6bdUe/1X9k5V/3W4DgdceeouS/VnmjUwoWQ=;
        b=wqfHwZJU5y7IY4ZpB70Qs6s0z98MBN7u+2gnwqOC2KZ51RRCXKdeY0tDZHpGiqw/oE
         MrnUKFe5yk91zo0xP4V0Vkj8JnmH1Wzjkp9ystIg6R6/bupu3cK1aMvHOcdL4gzf97Wj
         UwPF3Wafjef9IBdECq/La/7X3vezdzLP44YERgG97BvXa2UMTUpp7qMlVYaF1sH2o6LK
         EaUR7OpPJj/BFLIib0Fy0iBZVv9AQXmMGYNzHMQK9LnpsPr3yTE7L6vi/VzsWnpC3Uzb
         MiVr8i4LuakbEngsFNhcwHMsC5xsKpv16STQwoYWwhmMO7pdJBIZ44GFKLwP5244agMJ
         k1MQ==
X-Gm-Message-State: AJIora/2jJzrdUTFIdaUj6wJBv9P28pmMexECGoPTdSYc6h8J8j1psGB
        M75zuLy3FHBdF0QJnG1Dfjg=
X-Google-Smtp-Source: AGRyM1vJhtYkmyx3eQ0ZzMh5e2+GIZTCdt8dDx9wbvhjZjktbsyjOfWj5ZreQfdoS4ydU+cdv0R9JQ==
X-Received: by 2002:a17:906:72cd:b0:722:d84b:30e3 with SMTP id m13-20020a17090672cd00b00722d84b30e3mr6323685ejl.726.1655827611418;
        Tue, 21 Jun 2022 09:06:51 -0700 (PDT)
Received: from localhost.localdomain ([185.107.57.61])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090653c600b00722e0b1fa8esm1772943ejo.164.2022.06.21.09.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:06:50 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] clk: qcom: msm8996-cpu: Cleanup and migrate to parent_data
Date:   Tue, 21 Jun 2022 20:06:15 +0400
Message-Id: <20220621160621.24415-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
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

This series includes some cleanup of the MSM8996 CPU clock driver, as well as
migration from parent_names to parent_data for all of its clocks. The DT schema
is also fixed in this series to show the actual clocks consumed by the clock
controller and pass checks.

Yassine Oudjana (6):
  clk: qcom: msm8996-cpu: Rename DIV_2_INDEX to SMUX_INDEX
  clk: qcom: msm8996-cpu: Statically define PLL dividers
  clk: qcom: msm8996-cpu: Unify cluster order
  clk: qcom: msm8996-cpu: Convert secondary muxes to clk_regmap_mux
  dt-bindings: clock: qcom,msm8996-apcc: Fix clocks
  clk: qcom: msm8996-cpu: Use parent_data for all clocks

 .../bindings/clock/qcom,msm8996-apcc.yaml     |  15 +-
 drivers/clk/qcom/clk-cpu-8996.c               | 235 ++++++++++--------
 2 files changed, 140 insertions(+), 110 deletions(-)

-- 
2.36.1

