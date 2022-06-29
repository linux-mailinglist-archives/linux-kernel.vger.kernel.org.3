Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660BB560CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiF2Wxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiF2Wxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:53:37 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB793237E7;
        Wed, 29 Jun 2022 15:53:34 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A50943F762;
        Thu, 30 Jun 2022 00:53:32 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH v3 00/11] drm/msm/dsi_phy: Replace parent names with clk_hw pointers
Date:   Thu, 30 Jun 2022 00:53:20 +0200
Message-Id: <20220629225331.357308-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parent_hw pointers are easier to manage and cheaper to use than
repeatedly formatting the parent name and subsequently leaving the clk
framework to perform lookups based on that name.

This series starts out by adding extra constructors for divider, mux and
fixed-factor clocks that have parent_hw(s) pointer argument(s) instead
of some DT index or name.  Followed by individual patches performing the
conversion, one DSI PHY at a time.

dsi_phy_28nm_8960 includes an extra fixup to replace "eternal"
devm_kzalloc allocations (for the lifetime of the device) with
stack-local char arrays, like all the other DSI PHY drivers.

(Questions from v1 cover letter regarding the future of these drivers
 is omitted for brevity.)

And with enough future improvements out of the way, let's round out this
patch-series by stating that it has been successfully tested on:

- Sony Nile Discovery (Xperia XA2 Ultra): 14nm;
- Sony Seine PDX201 (Xperia 10II): 14nm;
- Sony Loire Suzu (Xperia X): 28nm.

And no diff is observed in debugfs's clk_summary.

Unfortunately all other devices in my collection with a 7/10nm DSI PHY
have a DSC panel which we have yet to get working.

Changes since v2:
- in fixed-factor:
  - Reorder if - else if change to consume less diff;
  - Go over 80-char column lint when adding new arguments to function
    calls, instead of reflowing all arguments to adhere to this limit;
    also consuming less diff.

v2: https://lore.kernel.org/linux-arm-msm/20220601220747.1145095-1-marijn.suijten@somainline.org/

Changes since v1:

- Moved indentation changes to separate patch (Dmitry);
- dsi_phy_28nm_8960: move clock name allocation removal prior to
  parent_hw refactor;
- Remove vco_name stack-local char array in favour of reusing clk_name
  (Dmitry);
- Inserted additional patch to replace hardcoded char-array length
  constant 32 with sizeof(clk_name).

v1: https://lore.kernel.org/linux-arm-msm/20220523213837.1016542-1-marijn.suijten@somainline.org/T/#u

Marijn Suijten (11):
  clk: divider: Introduce devm_clk_hw_register_divider_parent_hw()
  clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
  clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw()
  drm/msm/dsi/phy: Reindent and reflow multiline function calls
  drm/msm/dsi_phy_28nm_8960: Use stack memory for temporary clock names
  drm/msm/dsi/phy: Replace hardcoded char-array length with sizeof()
  drm/msm/dsi_phy_28nm_8960: Replace parent names with clk_hw pointers
  drm/msm/dsi_phy_28nm: Replace parent names with clk_hw pointers
  drm/msm/dsi_phy_14nm: Replace parent names with clk_hw pointers
  drm/msm/dsi_phy_10nm: Replace parent names with clk_hw pointers
  drm/msm/dsi_phy_7nm: Replace parent names with clk_hw pointers

 drivers/clk/clk-fixed-factor.c                |  45 ++++-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c    | 165 +++++++++---------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c    |  55 +++---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c    | 117 ++++++-------
 .../gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c   |  90 +++++-----
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c     | 156 ++++++++---------
 include/linux/clk-provider.h                  |  34 ++++
 7 files changed, 351 insertions(+), 311 deletions(-)

-- 
2.37.0

