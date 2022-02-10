Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0E44B0AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbiBJKef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:34:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbiBJKed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:34:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B6CB9B;
        Thu, 10 Feb 2022 02:34:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D67661BAD;
        Thu, 10 Feb 2022 10:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565EFC004E1;
        Thu, 10 Feb 2022 10:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644489273;
        bh=z4lRkqvA9DQ7TsxP/HD2yM3VcwHkhADf25A8nAfUPPY=;
        h=From:To:Cc:Subject:Date:From;
        b=ae6D0ytKLsz7gBHU1sA/gq5EyAjlOF9cmPSDLh1W7IvE77Xgrfd67bGRx1mkyMQvL
         e4TYhw0qFi5LivMxdoodwuQDE/G18vEgAa0Uzt/rk5cgJ3ZdDrPFma+iZoa+GKB+wL
         1BLmYxAM7h7BOjTw/g6nQ+StvDHxxRDvCnwng1Z3v+dumCWqVm7AudWc9pUHdgnl2X
         77KT1AnrzyGDQf3MLG5Id3/cnDCoX6MNQB+alihSTbqksd7g9CNOP1JDpFSLqH7vBA
         O6i3r2plmMnWss16utpT+7fEHSfCvzK/rHNAKBkvF5KtiDAw8U9xLnlNfbegAVf1Gz
         QHg2GHKxA4+UQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [REPOST PATCH v4 00/13] drm/msm: Add Display Stream Compression Support
Date:   Thu, 10 Feb 2022 16:04:10 +0530
Message-Id: <20220210103423.271016-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
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

Display Stream Compression (DSC) compresses the display stream in host which
is later decoded by panel. This series enables this for Qualcomm msm driver.
This was tested on Google Pixel3 phone which use LGE SW43408 panel.
 
The changes include DSC data and hardware block enabling for DPU1 then
support in encoder. We also add support in DSI and introduce required
topology changes.
 
In order for panel to set the DSC parameters we add dsc in drm_panel and set
it from the msm driver.

We still have dsc as a globabl entity. I think while doing DP + DSC we
should be able to update it, right now comprehending the requirements are
bit difficult.
 
Complete changes which enable this for Pixel3 along with panel driver (not
part of this series) and DT changes can be found at:
git.linaro.org/people/vinod.koul/kernel.git pixel/dsc_v4
 
Comments welcome!

Changes since v3:
 - Merge changes from Dmitry to have dsc per encoder instance
 - add warning for dsc and mode3d enabled together
 - set dsc in dpu_encoder_phys_vid as well
 - remove dsc hardcoded mask
 - use devm_kzalloc for memory allocation for dsc

Changes since v2:
 - Fix comments by Dimitry except the dsc being global.
 - Move RM patch later for dependency on topology now
 - Add patch for mode valid callback for dsi_mgr
 - Add missing structure documentation patch
 - Fix errors in mode_3d changes
 - Rebase on v5.16-rc1 and test

Changes since v1:
 - Fix various issues spotted by kbuildbot
 - Rebase to v5.15-rc3
 - Remove unused fields and duplicate defines
 - Enable DSC blocks only when DSC is enabled
 - remove sdm845 feature mask, use 0
 - Check for DSC in hw_ctl

Changes since RFC:
 - Drop the DT binding patch as we derive the configuration from panel
 - Drop the drm api patch as we no longer need it (use pps drm api)
 - Fix comments raised by Dimitry
 - Add dsc parameters calculation from downstream

Vinod Koul (13):
  drm/msm/dsi: add support for dsc data
  drm/msm/dsi: Pass DSC params to drm_panel
  drm/msm/disp/dpu1: Add support for DSC
  drm/msm/disp/dpu1: Add support for DSC in pingpong block
  drm/msm/disp/dpu1: Add DSC for SDM845 to hw_catalog
  drm/msm/disp/dpu1: Add DSC support in hw_ctl
  drm/msm/disp/dpu1: Add support for DSC in encoder
  drm/msm/disp/dpu1: Don't use DSC with mode_3d
  drm/msm: Add missing structure documentation
  drm/msm/disp/dpu1: Add support for DSC in topology
  drm/msm/disp/dpu1: Add DSC support in RM
  drm/msm/dsi: add mode valid callback for dsi_mgr
  drm/msm/dsi: Add support for DSC configuration

 drivers/gpu/drm/msm/Makefile                  |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   | 177 ++++++++++-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h  |   8 +
 .../drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c  |   4 +
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |   4 +
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |  20 ++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  13 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c    |  18 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h    |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c    | 210 +++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h    |  77 +++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h   |  13 +
 .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c   |  32 ++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h   |  14 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c        |  56 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h        |   1 +
 drivers/gpu/drm/msm/dsi/dsi.c                 |   5 +
 drivers/gpu/drm/msm/dsi/dsi.h                 |   3 +
 drivers/gpu/drm/msm/dsi/dsi.xml.h             |  10 +
 drivers/gpu/drm/msm/dsi/dsi_host.c            | 289 +++++++++++++++++-
 drivers/gpu/drm/msm/dsi/dsi_manager.c         |  12 +
 drivers/gpu/drm/msm/msm_drv.h                 |  26 ++
 include/drm/drm_panel.h                       |   7 +
 25 files changed, 1001 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h

-- 
2.31.1

