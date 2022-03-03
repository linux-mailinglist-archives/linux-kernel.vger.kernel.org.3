Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281B54CC3D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiCCRcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbiCCRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:32:04 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD2419E0A8;
        Thu,  3 Mar 2022 09:31:18 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2234AADq028599;
        Thu, 3 Mar 2022 11:31:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=84WJudr3xL0dnDa99zgx/2vbQMEBCtApcqUKb6n+efY=;
 b=HypInva52hCFc29e6Nv9O3DrICfHRSSEQ0AAoQ2ML9sNQHTJ+L6KCmvpqsU8U/3H/pbp
 NkGodak61EfPyU+MX2Q4Tvgv5z0ByntS35sawRFBzq4m645/LxUlg7kJ5iq4ZSHuu70n
 qq2awF0yVCIVSoMKTb3g2h3Cz8SemV6qfbyOhoP6v04Wf2+ZPUdRRUqd6dYeaaEYaMkL
 APIZ2wrTRX23oXyUUByJMXQTmPxAd4lj17lq086R69yd/UUxzGRJCqvsJL+1NOGYdvbU
 s/WGIjfC6rvchwd8r80d8exjj7suA/RLFyYIvsGtitr8gRkp43q8ElrllOkLZ9VAAXvz BQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8ybk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 11:31:04 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:31:02 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 17:31:02 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BAA842A1;
        Thu,  3 Mar 2022 17:31:01 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 00/20] Support external boost at CS35l41 ASoC driver
Date:   Thu, 3 Mar 2022 17:30:39 +0000
Message-ID: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6tBsN7_2izzr_E_NtrMPINF7rOwLB622
X-Proofpoint-GUID: 6tBsN7_2izzr_E_NtrMPINF7rOwLB622
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the support for CS35L41 external boost to its shared library
for ASoC use.
This move resulted in cs35l41_hda_reg_sequence being removed,
and its steps were broken down into regmap writes or functions
from the library. And hardware configuration struct was unified
for its use in the shared lib.
While at it, some minor bugs were found and fixed it.

David Rhodes (2):
  ASoC: cs35l41: Fix GPIO2 configuration
  Documentation: devicetree: CS35l41 External Boost

Lucas Tanure (18):
  ASoC: cs35l41: Fix max number of TX channels
  ASoC: cs35l41: Fix DSP mbox start command and global enable order
  ASoC: cs35l41: Remove unnecessary param
  sound: cs35l41: Unify hardware configuration
  sound: cs35l41: Check hw_config before using it
  sound: cs35l41: Move cs35l41_gpio_config to shared lib
  hda: cs35l41: Fix I2S params comments
  hda: cs35l41: Always configure the DAI
  hda: cs35l41: Add Boost type flag
  hda: cs35l41: Put the device into safe mode for external boost
  hda: cs35l41: Mute the device before shutdown
  sound: cs35l41: Enable Internal Boost in shared lib
  hda: cs35l41: Move boost config to initialization code
  hda: cs35l41: Remove unnecessary log
  hda: cs35l41: Remove cs35l41_hda_reg_sequence struct
  hda: cs35l41: Handle all external boost setups the same way
  hda: cs35l41: Move external boost handling to lib for ASoC use
  ASoC: cs35l41: Support external boost

 .../bindings/sound/cirrus,cs35l41.yaml        |  42 ++-
 include/sound/cs35l41.h                       |  53 +++-
 sound/pci/hda/cs35l41_hda.c                   | 296 +++++-------------
 sound/pci/hda/cs35l41_hda.h                   |  27 +-
 sound/soc/codecs/cs35l41-i2c.c                |   4 +-
 sound/soc/codecs/cs35l41-lib.c                | 185 ++++++++++-
 sound/soc/codecs/cs35l41-spi.c                |   4 +-
 sound/soc/codecs/cs35l41.c                    | 174 +++++-----
 sound/soc/codecs/cs35l41.h                    |   5 +-
 9 files changed, 431 insertions(+), 359 deletions(-)

-- 
2.35.1

