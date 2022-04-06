Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA74F5CD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiDFLsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiDFLsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:48:14 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5E030F9DD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:40:15 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AB9C21A1755;
        Wed,  6 Apr 2022 10:40:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 60A761A1746;
        Wed,  6 Apr 2022 10:40:10 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 425D7183ACDE;
        Wed,  6 Apr 2022 16:40:08 +0800 (+08)
From:   Sandor.yu@nxp.com
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com
Cc:     Sandor.yu@nxp.com, shengjiu.wang@nxp.com, cai.huoqing@linux.dev,
        maxime@cerno.tech, harry.wentland@amd.com,
        hverkuil-cisco@xs4all.nl, amuel@sholland.org
Subject: [PATCH v1 0/5] DRM: Bridge: DW_HDMI: Add new features and bug fix
Date:   Wed,  6 Apr 2022 16:48:32 +0800
Message-Id: <cover.1649230434.git.Sandor.yu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandor Yu <Sandor.yu@nxp.com>

It is new features and bug fix patch set for DW_HDMI DRM bridge driver
that has verified by NXP iMX865.
Three new feature added:
1. Add GP Audio interface for DW_HDMI.
2. Add CEC PM functions to restore CEC status when device suspend/resume
3. New API for reset PHY Gen1.
Two bugs fixed:
1. Enable overflow workaround for v2.13a.
2. Clear GPC_Auto bit for 24bit bpp to pass CTS.

Sandor Yu (5):
  drm: bridge: dw_hdmi: cec: Add cec suspend/resume function
  drm: bridge: dw_hdmi: enable overflow workaround for v2.13a
  drm: bridge: dw_hdmi: Enable GCP only for Deep Color
  drm: bridge: dw_hdmi: add reset function for PHY GEN1
  drm: bridge: dw_hdmi: Audio: Add General Parallel Audio (GPA) driver

 drivers/gpu/drm/bridge/synopsys/Kconfig       |  11 +
 drivers/gpu/drm/bridge/synopsys/Makefile      |   1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c |  35 +++
 .../drm/bridge/synopsys/dw-hdmi-gp-audio.c    | 199 ++++++++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 157 +++++++++++++-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     |  13 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c        |   2 +-
 include/drm/bridge/dw_hdmi.h                  |   9 +-
 8 files changed, 416 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c

-- 
2.25.1

