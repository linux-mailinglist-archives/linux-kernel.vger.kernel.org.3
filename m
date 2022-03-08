Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203354D1E8B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348770AbiCHRTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348841AbiCHRTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:19:44 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC7A53B59;
        Tue,  8 Mar 2022 09:18:32 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228FxtbT015166;
        Tue, 8 Mar 2022 11:17:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=ct6f8v+b3c9iZFTsuJ+tCBScraovnh0qwyDJ/LoPqIQ=;
 b=JX/h4EoiuTDt10EmzTVbV+r8ONYg9fFWniIVfFpV4nQPLgZ8qzxRDvBvOA6xz1FFQvCy
 ST3FKXcN1FenpIvJV1HJl8lYYCKnvx3VkCvBgXjqTtb6RZoG0y92tyfr9xFvMHR61Ftw
 5n8t0otRTzmWA3CFPw1SNA2O6HTlYuJXjBFRzR4pGMwV46akpgVjgDVPRqvzE4lsetis
 ozijxSHwdmjK6o2QHtErc7izMqXcvqWWxhfnzsl1bfWZSM+jHfC0zSvz3+zVPoTdtI5Z
 JOVeJSof6JTMABKy2zYTBmntQI/+qb8wr9WNviMPL9b3tasvaxZDqjaOZ/JSNXuGcDRG EA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3em55svhnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Mar 2022 11:17:33 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Mar
 2022 17:17:31 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 8 Mar 2022 17:17:31 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.38])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3C312B06;
        Tue,  8 Mar 2022 17:17:31 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v3 00/16] Support external boost at CS35l41 ASoC driver
Date:   Tue, 8 Mar 2022 17:17:14 +0000
Message-ID: <20220308171730.454587-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XR-m0K5S2IcWeMonhctnAFUFDN43nhlM
X-Proofpoint-GUID: XR-m0K5S2IcWeMonhctnAFUFDN43nhlM
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

David Rhodes (1):
  ASoC: dt-bindings: cs35l41: Document CS35l41 External Boost

Lucas Tanure (15):
  sound: cs35l41: Unify hardware configuration
  sound: cs35l41: Check hw_config before using it
  sound: cs35l41: Move cs35l41_gpio_config to shared lib
  ALSA: hda: cs35l41: Fix I2S params comments
  ALSA: hda: cs35l41: Always configure the DAI
  ALSA: hda: cs35l41: Add Boost type flag
  hda: cs35l41: Put the device into safe mode for external boost
  hda: cs35l41: Mute the device before shutdown
  sound: cs35l41: Enable Internal Boost in shared lib
  ALSA: hda: cs35l41: Move boost config to initialization code
  ALSA: hda: cs35l41: Remove cs35l41_hda_reg_sequence struct
  ALSA: hda: cs35l41: Reorganize log for playback actions
  ALSA: hda: cs35l41: Handle all external boost setups the same way
  ALSA: hda: cs35l41: Move external boost handling to lib for ASoC use
  ASoC: cs35l41: Support external boost

 .../bindings/sound/cirrus,cs35l41.yaml        |  44 ++-
 include/sound/cs35l41.h                       |  53 +++-
 sound/pci/hda/cs35l41_hda.c                   | 295 ++++++------------
 sound/pci/hda/cs35l41_hda.h                   |  27 +-
 sound/soc/codecs/cs35l41-i2c.c                |   4 +-
 sound/soc/codecs/cs35l41-lib.c                | 190 ++++++++++-
 sound/soc/codecs/cs35l41-spi.c                |   4 +-
 sound/soc/codecs/cs35l41.c                    | 166 +++++-----
 sound/soc/codecs/cs35l41.h                    |   5 +-
 9 files changed, 437 insertions(+), 351 deletions(-)

-- 
2.35.1

