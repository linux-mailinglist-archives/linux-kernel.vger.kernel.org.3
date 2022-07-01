Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C5E56308F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbiGAJrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbiGAJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:47:28 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EB274DF4;
        Fri,  1 Jul 2022 02:47:27 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2AB88201398;
        Fri,  1 Jul 2022 11:47:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E74C620138B;
        Fri,  1 Jul 2022 11:47:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3D995181D0CA;
        Fri,  1 Jul 2022 17:47:24 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Add support of two Audio PLL source
Date:   Fri,  1 Jul 2022 17:32:35 +0800
Message-Id: <1656667961-1799-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MQ/MN/MM/MP platforms typically have 2 AUDIO PLLs being
configured to handle 8kHz and 11kHz series audio rates.

The patches implement the functionality to select at runtime
the appropriate AUDIO PLL for root clock, if there is no
two PLL registered, then no action taken.

change in v2:
- simply the logic for calling reparent function

Shengjiu Wang (6):
  ASoC: fsl_utils: Add function to handle PLL clock source
  ASoC: fsl_spdif: Add support for PLL switch at runtime.
  ASoC: fsl_micfil: Add support for PLL switch at runtime
  ASoC: fsl_sai: Add support for PLL switch at runtime
  ASoC: dt-bindings: fsl_spdif: Add two PLL clock source
  ASoC: dt-bindings: fsl-sai: Add two PLL clock source

 .../devicetree/bindings/sound/fsl,spdif.yaml  |  4 ++
 .../devicetree/bindings/sound/fsl-sai.txt     |  3 +
 sound/soc/fsl/Kconfig                         |  3 +
 sound/soc/fsl/fsl_micfil.c                    | 31 +++++++++
 sound/soc/fsl/fsl_sai.c                       | 38 ++++++++++
 sound/soc/fsl/fsl_sai.h                       |  2 +
 sound/soc/fsl/fsl_spdif.c                     | 48 +++++++++++--
 sound/soc/fsl/fsl_utils.c                     | 69 +++++++++++++++++++
 sound/soc/fsl/fsl_utils.h                     |  7 ++
 9 files changed, 200 insertions(+), 5 deletions(-)

-- 
2.17.1

