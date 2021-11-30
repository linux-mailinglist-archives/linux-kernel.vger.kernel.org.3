Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BBC463630
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbhK3OOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:14:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54074 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbhK3OOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:14:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AC40F1F45136
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638281454; bh=As7FWtUArYkJ1BMuawn6z919UJm2kcgAiwW3X4n6lVM=;
        h=From:To:Cc:Subject:Date:From;
        b=A+Bc1GVNr7CRVpt76jol4eE8vsDot8RenfmeZUJyZD6Su+G/kjTTgLBZHTMhxMVZ8
         pSG5j6kfmfVQPuGcwDaXaqc/+XO6yGqHOCo3Us68kp6IA2uhP1zpDzU1RAOVtCD6xx
         B9EpG4UyntVknMnHUVfVOaemLbkb2oZmkNldOOQiYhAG+cI1DAIsl0o5CwuJ4qzCgW
         WS/Tr1mBAnZLasik/wHm/3UPYuyWx7LVTwAmj3Gr+ID7OQ06WLSnhuIYC7x61/gBsd
         osv/jqVSchXNUicWVFnA6JpPonvXqSZWUcan97mrU+e6LymFfMjXduEqs5meh6e/QG
         4YBPoM6H0dhtQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robdclark@gmail.com
Cc:     dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, maxime@cerno.tech, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        jami.kettunen@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/2] drm/msm: Fix dsi/bridge probe
Date:   Tue, 30 Nov 2021 15:10:46 +0100
Message-Id: <20211130141048.294246-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Context, from patch 2/2:
Since commit 8f59ee9a570c ("drm/msm/dsi: Adjust probe order"), the
DSI host gets initialized earlier, but this caused unability to probe
the entire stack of components because they all depend on interrupts
coming from the main `mdss` node (mdp5, or dpu1).

Series v2:
After a very nice conversation with Dmitry, it turned out that my first
approach to solve this issue wasn't great: even though it appeared to
actually work, it was introducing a number of issues, one of which was
critical as it was not removing down the DRM device when it's supposed to.

Instead of actually fixing that patch, I went for "simplifying" the
approach by not initializing the entire MDSS, but just the interrupt
controller, which still untangles the infinite probe deferrals, but
actually doesn't even touch most of the already present logic in place.

AngeloGioacchino Del Regno (2):
  drm/msm: Allocate msm_drm_private early and pass it as driver data
  drm/msm: Initialize MDSS irq domain at probe time

 drivers/gpu/drm/msm/adreno/adreno_device.c | 16 ++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c    |  4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c   | 50 ++++++++++------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   |  3 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c  | 58 +++++++++++++------
 drivers/gpu/drm/msm/dp/dp_display.c        | 10 +---
 drivers/gpu/drm/msm/dsi/dsi.c              |  6 +-
 drivers/gpu/drm/msm/edp/edp.c              |  6 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c            |  7 +--
 drivers/gpu/drm/msm/msm_drv.c              | 67 +++++++++++++---------
 drivers/gpu/drm/msm/msm_kms.h              |  3 +
 11 files changed, 133 insertions(+), 97 deletions(-)

-- 
2.33.1

