Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927554FA64A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbiDIJQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241045AbiDIJPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:15:49 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2241FEFFA8;
        Sat,  9 Apr 2022 02:13:43 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.16.1.2) with ESMTP id 239919oq003576;
        Sat, 9 Apr 2022 04:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=2zrPeVnQaFOXlm/jv03XU7bKCTdOrm2Yr3ZzYzeZkb8=;
 b=Kn5OSOggyPOAA8MMr8m4r6zDm1Eo+RQaecBEtpeVI9SsgxbIYS3328gmMv7jBYXTrnjM
 Adhknkkoxht1sAPnUgmONzW3Sz33SxkM2sJ79NN8IBoh9mcERs6yJbSTJIG3scuL8PMk
 O1ya1qYTcdhw3SgdyqQettQDDumvE7mKuBO0giFybtdXR9Nz47vCs1oudeJutNL0Y7ZT
 ceeQj2XNjiHOQOTQlLCl42/ps7R+QGU4cyJNoXQqbTk23Gk8Xg2eSgfPGnxmDPJ61iFY
 vlnlWPu9bSmnwj+9Sgl6Nda7DkDoYPVTjZBrnv9/p+pBgIXuYLYUb5yvHVnv2JnJvvpM Jg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fb6py80wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 09 Apr 2022 04:13:19 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 9 Apr
 2022 10:13:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Sat, 9 Apr 2022 10:13:17 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.156])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C57CE46C;
        Sat,  9 Apr 2022 09:13:16 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v6 00/16] Support external boost at CS35l41 ASoC driver
Date:   Sat, 9 Apr 2022 10:12:59 +0100
Message-ID: <20220409091315.1663410-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: B0mRQ6hi-hPJfcd3N6eq01RL185Zovp7
X-Proofpoint-GUID: B0mRQ6hi-hPJfcd3N6eq01RL185Zovp7
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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

v6 changelog:
 - Rebased on top of Linux Next with community patches for CS35L41
 - Document patch acked by Charles Keepax

v5 changelog:
 - Fixed wrong indentation at Documentation patch
 - Use of consistent prefix

v4 changelog:
 - Separated GPIO 1 and 2 function enums

v3 changelog:
 - Remove patches already accepted
 - Improved logic in documentation patch
 - Documentation patch goes before its code
 - Fixed missing Signed-off-by
 - Fixed subject for HDA patches

v2 changelog:
 - Instead of removing the log, playback actions will log the last regmap access.
 - Documentation patch with the correct subject line and fixed bug reported by Rob Herring on the
 provided example.

Previous versions:
 v1: https://lkml.org/lkml/2022/3/3/759
 v2: https://lkml.org/lkml/2022/3/4/743
 v3: https://lkml.org/lkml/2022/3/8/975
 v4: https://lkml.org/lkml/2022/3/17/267
 v5: https://lkml.org/lkml/2022/3/22/696

David Rhodes (1):
  ASoC: cs35l41: Document CS35l41 External Boost

Lucas Tanure (15):
  ALSA: cs35l41: Unify hardware configuration
  ALSA: cs35l41: Check hw_config before using it
  ALSA: cs35l41: Move cs35l41_gpio_config to shared lib
  ALSA: hda: cs35l41: Fix I2S params comments
  ALSA: hda: cs35l41: Always configure the DAI
  ALSA: hda: cs35l41: Add Boost type flag
  ALSA: hda: cs35l41: Put the device into safe mode for external boost
  ALSA: hda: cs35l41: Mute the device before shutdown
  ALSA: cs35l41: Enable Internal Boost in shared lib
  ALSA: hda: cs35l41: Move boost config to initialization code
  ALSA: hda: cs35l41: Remove cs35l41_hda_reg_sequence struct
  ALSA: hda: cs35l41: Reorganize log for playback actions
  ALSA: hda: cs35l41: Handle all external boost setups the same way
  ALSA: hda: cs35l41: Move external boost handling to lib for ASoC use
  ASoC: cs35l41: Support external boost

 .../bindings/sound/cirrus,cs35l41.yaml        |  44 ++-
 include/sound/cs35l41.h                       |  59 +++-
 sound/pci/hda/cs35l41_hda.c                   | 295 ++++++------------
 sound/pci/hda/cs35l41_hda.h                   |  27 +-
 sound/soc/codecs/cs35l41-i2c.c                |   4 +-
 sound/soc/codecs/cs35l41-lib.c                | 190 ++++++++++-
 sound/soc/codecs/cs35l41-spi.c                |   4 +-
 sound/soc/codecs/cs35l41.c                    | 166 +++++-----
 sound/soc/codecs/cs35l41.h                    |   5 +-
 9 files changed, 443 insertions(+), 351 deletions(-)

-- 
2.35.1

