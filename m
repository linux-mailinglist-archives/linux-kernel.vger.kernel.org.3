Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770F4492F88
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349320AbiARUjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:39:23 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:32582 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349242AbiARUjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642538353; x=1674074353;
  h=from:to:cc:subject:date:message-id;
  bh=pQAKZfCHGK05kVj7Bze9qOhDkcnNULF2zH8KZDpgQxM=;
  b=oD5b83UmUo+GVhWWtrq7iigU3CQWbeysm2aJy18Xups/rD5Mp6ycY3Ya
   tK9YhkXqLHx2Im3scriRlsp4k43Wcj9j8DT21dldkndHau0n14FZXVvIM
   U3UQkI6Ql0A3lCQSOKtCHEe0SZdjHyiqBfRIbxFrJ02n5U45p4SWlv+yM
   U=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 18 Jan 2022 12:39:12 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 18 Jan 2022 12:39:10 -0800
X-QCInternal: smtphost
Received: from rajeevny-linux.qualcomm.com ([10.204.66.121])
  by ironmsg01-blr.qualcomm.com with ESMTP; 19 Jan 2022 02:08:45 +0530
Received: by rajeevny-linux.qualcomm.com (Postfix, from userid 2363605)
        id A001421A8B; Wed, 19 Jan 2022 02:08:44 +0530 (IST)
From:   Rajeev Nandan <quic_rajeevny@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Rajeev Nandan <quic_rajeevny@quicinc.com>,
        linux-kernel@vger.kernel.org, sean@poorly.run, robdclark@gmail.com,
        robh+dt@kernel.org, robh@kernel.org, quic_abhinavk@quicinc.com,
        quic_kalyant@quicinc.com, quic_mkrishn@quicinc.com,
        jonathan@marek.ca, dmitry.baryshkov@linaro.org, airlied@linux.ie,
        daniel@ffwll.ch, swboyd@chromium.org
Subject: [v3 0/3] drm/msm/dsi: Add 10nm dsi phy tuning configuration support 
Date:   Wed, 19 Jan 2022 02:08:37 +0530
Message-Id: <1642538320-1127-1-git-send-email-quic_rajeevny@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is to add DSI PHY tuning support in Qualcomm Snapdragon
SoCs with 10nm DSI PHY e.g. SC7180

In most cases the default values of DSI PHY tuning registers
should be sufficient as they are fully optimized. However, in
some cases (for example, where extreme board parasitics cause
the eye shape to degrade), the override bits can be used to
improve the signal quality.

Different DSI PHY versions have different configurations to adjust the
drive strength, drive level, de-emphasis, etc. The current series has only
those configuration options supported by 10nm PHY, e.g. drive strength and
drive level. The number of registers to configure the drive strength are
different for 7nm PHY. The design can be extended to other DSI PHY versions
if required, as each PHY version can have its callback to get the input
from DT and prepare register values.

Changes in v2:
 - Addressed dt-bindings comments (Stephen Boyd, Dmitry Baryshkov)
 - Split into generic code and 10nm-specific part (Dmitry Baryshkov)
 - Fix the backward compatibility (Dmitry Baryshkov)

Changes in v3:
 - Addressed dt-bindings comments (Rob Herring, Dmitry Baryshkov)
 - Address comments for phy tuning data structure (Dmitry Baryshkov)
 - s/ops.tuning_cfg_init/ops.parse_dt_properties (Dmitry Baryshkov)

Rajeev Nandan (3):
  dt-bindings: msm/dsi: Add 10nm dsi phy tuning properties
  drm/msm/dsi: Add dsi phy tuning configuration support
  drm/msm/dsi: Add 10nm dsi phy tuning configuration support

 .../bindings/display/msm/dsi-phy-10nm.yaml         | 34 ++++++++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |  6 ++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |  4 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c         | 97 ++++++++++++++++++++--
 4 files changed, 135 insertions(+), 6 deletions(-)

-- 
2.7.4

