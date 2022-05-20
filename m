Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD9052E9AC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348075AbiETKKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348025AbiETKKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:10:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3795FDE30B;
        Fri, 20 May 2022 03:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0F1BB82A9B;
        Fri, 20 May 2022 10:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE44C385AA;
        Fri, 20 May 2022 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653041420;
        bh=CUMRaFpSPQsGGTUY5dQB0cjmuiT3DOYu/+5/nWnfIC8=;
        h=From:To:Cc:Subject:Date:From;
        b=dwY/xH/YIgScadFiE0VQ+FH4oMMWNt6dh+KkUmDm0vz79CR8HagGf7EJ2mtlw3Bag
         wYCN7bIDor44zskmOfZ9vVk96nbJIYymlFgqBfDZySRdNLYZlAeYJKC0DqmAWdUvru
         cByn1e/pGH8SuTaVaaT85HyCIF411e2H8uFQESeox8wyyAr9PJfpkJ5xwlsq/IHQmx
         rRMuWdBkevMGErvi4oO7LE2JzNzc5KmpDTDNWHKhC1oZ8UFD7VOlOphZMj+esBVPk3
         ZX0yEuOpUZ77ULK6pXthkvDyP1EeiNg0wOMMlV2pgDbvrqUH8E6CXvmM87IG5dgGyu
         r73lttmFAALig==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nrzaO-00056u-8E; Fri, 20 May 2022 12:10:20 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] clk: qcom: gdsc: add support for collapse-vote registers
Date:   Fri, 20 May 2022 12:09:45 +0200
Message-Id: <20220520100948.19622-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent Qualcomm platforms have APCS collapse-vote registers that allow
for sharing GDSCs with other masters (e.g. LPASS).
    
Add support for using such vote registers instead of the control
register when updating the GDSC power state.

Note that the gcc-sc8280xp driver has not yet been merged. [1]

Johan


[1] https://lore.kernel.org/all/20220505025457.1693716-1-bjorn.andersson@linaro.org/


Johan Hovold (3):
  clk: qcom: gdsc: add collapse-bit helper
  clk: qcom: gdsc: add support for collapse-vote registers
  clk: qcom: gcc-sc8280xp: use collapse-voting for PCIe GDSCs

 drivers/clk/qcom/gcc-sc8280xp.c | 21 +++++++++++++++++++++
 drivers/clk/qcom/gdsc.c         | 28 ++++++++++++++++++++++------
 drivers/clk/qcom/gdsc.h         |  4 ++++
 3 files changed, 47 insertions(+), 6 deletions(-)

-- 
2.35.1

