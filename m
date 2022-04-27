Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9256D511140
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358169AbiD0Gjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358175AbiD0Gis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:38:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57481ADBA;
        Tue, 26 Apr 2022 23:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6CA7618E1;
        Wed, 27 Apr 2022 06:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F730C385AA;
        Wed, 27 Apr 2022 06:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651041335;
        bh=k6dwnK0xclzWh+p/LmUQUrceR0tDLEKt8/aDgr4lKkY=;
        h=From:To:Cc:Subject:Date:From;
        b=tBEzJ/RKt4+uA3PyECI9pK8PzfzbOFUkpk7rcNTM3Y1kWErnDlgFriNrrA1UYUZu5
         RpjyRQha+T0vysveASlmf5uGZR8wcnqnlt2bMBBBjAmB202KG/zK4162l7s7bqVbOc
         ymgK/D0l2Q7F7rGoo/O98MQZeNu2SHTX+EQvbFlVnBsWxgjTG3jMAvxg/s7wA849Ts
         2u/fkIZx6R4w2XSGb8e23lSOMC+vyoJuw1UqRDIj9ayQE0s2Rn7sTvJ9UqfcUnaurd
         Gbu39XWnUhcThcs7KfLu8TOsIKN+08UTmTW7+BK4v6hmLLW8sdNqogRvDVDYpQt4sE
         7z8TI57oL5Uag==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1njbGy-0008VT-4i; Wed, 27 Apr 2022 08:35:36 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/3] phy: qcom-qmp: fix leaks on probe errors
Date:   Wed, 27 Apr 2022 08:32:40 +0200
Message-Id: <20220427063243.32576-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two more fixes addressing resource leaks on probe errors (e.g.
probe deferral) and a related cleanup.

Johan

Changes in v2
 - add Bjorn and Philipp's reviewed-by tags
 - fix reset-controller leak commit message (Philipp)
 - add patch to switch to explicit reset API (Philipp)

Johan Hovold (3):
  phy: qcom-qmp: fix struct clk leak on probe errors
  phy: qcom-qmp: fix reset-controller leak on probe errors
  phy: qcom-qmp: switch to explicit reset helpers

 drivers/phy/qualcomm/phy-qcom-qmp.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.35.1

