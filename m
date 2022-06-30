Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA195611F5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 07:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiF3FyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 01:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiF3FyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 01:54:16 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B143C2BB27;
        Wed, 29 Jun 2022 22:54:14 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 013051A09D4;
        Thu, 30 Jun 2022 07:54:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B84B71A06F8;
        Thu, 30 Jun 2022 07:54:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E7FC2180222C;
        Thu, 30 Jun 2022 13:54:10 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Add support of two Audio PLL source
Date:   Thu, 30 Jun 2022 13:39:08 +0800
Message-Id: <1656567554-32122-1-git-send-email-shengjiu.wang@nxp.com>
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
 sound/soc/fsl/fsl_micfil.c                    | 41 +++++++++++
 sound/soc/fsl/fsl_sai.c                       | 54 +++++++++++++++
 sound/soc/fsl/fsl_sai.h                       |  2 +
 sound/soc/fsl/fsl_spdif.c                     | 57 +++++++++++++--
 sound/soc/fsl/fsl_utils.c                     | 69 +++++++++++++++++++
 sound/soc/fsl/fsl_utils.h                     |  9 +++
 9 files changed, 237 insertions(+), 5 deletions(-)

-- 
2.17.1

