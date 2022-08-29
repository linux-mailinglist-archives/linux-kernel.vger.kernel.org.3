Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4215A5255
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiH2Qz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiH2QzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:55:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7F365A6;
        Mon, 29 Aug 2022 09:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25DF9B8117E;
        Mon, 29 Aug 2022 16:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01FAC433C1;
        Mon, 29 Aug 2022 16:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661792103;
        bh=HiXBOm9dvzWK6mHglRBKim5I3iQDy4svVep8E5b0sME=;
        h=From:To:Cc:Subject:Date:From;
        b=FoHQL1KrEzneppmN3SgxX1IImlY1zrOwvKJF+GUdJRm5+H/HpCnTOtgJ6h/aNK/J4
         JM2GTtzIl/wrW9a9+cmiP629/xcU8pZmfxHUA7R+HulqRJ7dWt7eTLiQnyT+725A5j
         XcVNJUAlfLSx8hSA29R+DX++apn0uqdeFHVPhTDAUIEDGXcq5yVtMoQiFEKrzn0lWs
         jCyEob3iychWRCGKEn3iLg7EYBwckUhb1c6jEBku8PHjerkshTRWyowPeiBiv6gVPx
         L3+bvNz+IWCI1ePD5z1S6HukDWKta+RxSBSwaXEGZg/zGor8U6PgwxWpTskJKfcSTZ
         7cguOZzgEcctg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] drm/msm/dsi: Remove use of device_node in dsi_host_parse_dt()
Date:   Mon, 29 Aug 2022 09:54:50 -0700
Message-Id: <20220829165450.217628-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  drivers/gpu/drm/msm/dsi/dsi_host.c:1903:14: error: variable 'device_node' is uninitialized when used here [-Werror,-Wuninitialized]
          of_node_put(device_node);
                      ^~~~~~~~~~~
  drivers/gpu/drm/msm/dsi/dsi_host.c:1870:44: note: initialize the variable 'device_node' to silence this warning
          struct device_node *endpoint, *device_node;
                                                    ^
                                                    = NULL
  1 error generated.

device_node's assignment was removed but not all of its uses. Remove the
call to of_node_put() and the variable declaration to clean up the
warning.

Fixes: 5f8cdece42ff ("drm/msm/dsi: switch to DRM_PANEL_BRIDGE")
Link: https://github.com/ClangBuiltLinux/linux/issues/1700
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 57a4c0fa614b..7fbf391c024f 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1867,7 +1867,7 @@ static int dsi_host_parse_dt(struct msm_dsi_host *msm_host)
 {
 	struct device *dev = &msm_host->pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *endpoint, *device_node;
+	struct device_node *endpoint;
 	int ret = 0;
 
 	/*
@@ -1900,8 +1900,6 @@ static int dsi_host_parse_dt(struct msm_dsi_host *msm_host)
 		}
 	}
 
-	of_node_put(device_node);
-
 err:
 	of_node_put(endpoint);
 

base-commit: 5f8cdece42ff0c615e213b6619d29487f9f409d7
-- 
2.37.2

