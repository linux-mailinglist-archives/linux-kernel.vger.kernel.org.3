Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5FB531DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiEWViz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiEWViv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:38:51 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E63856FB6;
        Mon, 23 May 2022 14:38:49 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id F35032051B;
        Mon, 23 May 2022 23:38:46 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 0/9] drm/msm/dsi_phy: Replace parent names with clk_hw pointers
Date:   Mon, 23 May 2022 23:38:28 +0200
Message-Id: <20220523213837.1016542-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.36.1
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

As stated in [1] I promised to tackle and send this series.

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

I couldn't help but notice that clock names are wildly varying:

- Some use underscores in the _clk suffix where others have nothing;
- Some have an _ after the %d, others have not;
- Some use a _pll suffix after dsi%d or even _phy_pll suffix.

Are there any thoughts or feelings towards unifying these?
Theoretically no clock names are used anywhere in the kernel, and
everything is based on a phandle + index in DT (I have yet to validate
this).  Obviously no .name/.fw_name will be updated to not break DT.

Which, by the way, is there a particular reason for:

  #define DSI_BYTE_PLL_CLK		0
  #define DSI_PIXEL_PLL_CLK		1

To not be in the dt-bindings and used in the DT?

And with enough future improvements out of the way, let's round out this
patch-series by stating that it has been successfully tested on:

- Sony Nile Discovery (Xperia XA2 Ultra): 14nm;
- Sony Seine PDX201 (Xperia 10II): 14nm;
- Sony Loire Suzu (Xperia X): 28nm.

And no diff is observed in debugfs's clk_summary.

Unfortunately all other devices in my collection with a 7/10nm DSI PHY
have a DSC panel which we have yet to get working.

[1]: https://lore.kernel.org/linux-arm-msm/20220502214235.s5plebunh4ttjhge@SoMainline.org/

Marijn Suijten (9):
  clk: divider: Introduce devm_clk_hw_register_divider_parent_hw()
  clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
  clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw()
  drm/msm/dsi_phy_28nm: Replace parent names with clk_hw pointers
  drm/msm/dsi_phy_28nm_8960: Replace parent names with clk_hw pointers
  drm/msm/dsi_phy_28nm_8960: Use stack memory for temporary clock names
  drm/msm/dsi_phy_14nm: Replace parent names with clk_hw pointers
  drm/msm/dsi_phy_10nm: Replace parent names with clk_hw pointers
  drm/msm/dsi_phy_7nm: Replace parent names with clk_hw pointers

 drivers/clk/clk-fixed-factor.c                | 57 ++++++++++--
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c    | 92 ++++++++-----------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c    | 36 ++++----
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c    | 52 +++++------
 .../gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c   | 26 ++----
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c     | 92 +++++++++----------
 include/linux/clk-provider.h                  | 34 +++++++
 7 files changed, 209 insertions(+), 180 deletions(-)

--
2.36.1
