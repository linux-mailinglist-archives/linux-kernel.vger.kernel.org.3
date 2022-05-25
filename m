Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30624533D80
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244033AbiEYNRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiEYNQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:16:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A69DFD4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:16:54 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PCRmjB022096;
        Wed, 25 May 2022 08:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=KzGnX4o3rxzKk8e5rJEpItof3vxjdDFIZNENx0iAmH0=;
 b=AMNaEG9mTux0fwOCJg7aRGLJ7Z8TjQbx4dPPbAE5B4BM2JE0iaUrPJyAx26HQB9a2rqo
 q5NMNqMwqqu5TDwV5nFo7rtLhRgkkAAzjTBmkVSVHHJKOxujY8pLEeEX3OReSYJ4HHsl
 i3XNgZhkJnEk7StogH9D5YM5Mx3IFsCPMoCR+vhPZTh1JhPez6KdKCmDy5jyeHSnPyJS
 F1tHvi83G1GpjsmqN/hJPmqDGtC+xNj3my0qKElH4Sb4dkW1+Skq5qP6Gj6GbtTfEc0/
 HUquQ0keSPxBMsa4nSmRHoKeel0/qELoavmGc+5sU3wSSwJPVVkI//bL/6HCipDwjkmt jw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3g93u20we6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 May 2022 08:16:40 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 14:16:39 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 25 May 2022 14:16:39 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.233])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DF654468;
        Wed, 25 May 2022 13:16:38 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 00/17] ALSA: hda: cirrus: Add initial DSP support and firmware loading
Date:   Wed, 25 May 2022 14:16:21 +0100
Message-ID: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: czuJpGm6HxWly4rDC-QM_V0F6iEfWZ49
X-Proofpoint-GUID: czuJpGm6HxWly4rDC-QM_V0F6iEfWZ49
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CS35L41 Amplifier contains a DSP, capable of running firmware.
The firmware can run algorithms such as Speaker Protection, to ensure
that playback at high gains do not harm the speakers.
Adding support for CS35L41 firmware into the CS35L41 HDA driver also
allows us to support several extra features, such as hiberation 
and interrupts.

The chain adds support in stages:
- General fixes to improve generalization and code re-use inside
  the CS35L41 HDA driver.
- Add support for interrupts into the driver, which is required
  for complete support of the firmware.
- Refactor ASoC CS35L41 code which deals with firmware to allow
  for code re-use inside the CS35L41 HDA driver.
- Add support for loading firmware and tuning files from file system,
  and creating alsa controls to control it.
- Support firmware load paths for different hardware systems.
- Support suspend/resume in the driver when using firmware. The firmware
  supports hibernation, which allows the CS35L41 to drop into a low
  power mode during suspend.
- Support the ability to unload firmware, swap and reload the firmware.
  This is to allow different firmware to run during calibration.

The intended use-case is to load the firmware once on boot, and the driver
autmatically tries to load the firmware after it binds to the HDA driver.
This behaviour can be switched off using a kconfig, if desired.
Stefan Binding (16):
  ALSA: hda: hda_cs_dsp_ctl: Add Library to support CS_DSP ALSA controls
  ALSA: hda: hda_cs_dsp_ctl: Add apis to write the controls directly
  ALSA: hda: cs35l41: Save codec object inside component struct
  ALSA: hda: cs35l41: Save Subsystem ID inside CS35L41 Driver
  ALSA: hda: cs35l41: Support reading subsystem id from ACPI
  ALSA: hda: cs35l41: Support multiple load paths for firmware
  ALSA: hda: cs35l41: Support Speaker ID for laptops
  ASoC: cs35l41: Move cs35l41 exit hibernate function into shared code
  ASoC: cs35l41: Do not print error when waking from hibernation
  ASoC: cs35l41: Add common cs35l41 enter hibernate function
  ALSA: hda: cs35l41: Support Hibernation during Suspend
  ALSA: hda: cs35l41: Read Speaker Calibration data from UEFI variables
  ALSA: hda: hda_cs_dsp_ctl: Add fw id strings
  ALSA: hda: cs35l41: Add defaulted values into dsp bypass config
    sequence
  ALSA: hda: cs35l41: Support Firmware switching and reloading
  ALSA: hda: cs35l41: Add module parameter to control firmware load

Vitaly Rodionov (1):
  ALSA: hda: cs35l41: Add initial DSP support and firmware loading

 MAINTAINERS                     |   1 +
 include/sound/cs35l41.h         |   7 +
 sound/pci/hda/Kconfig           |   8 +
 sound/pci/hda/Makefile          |   2 +
 sound/pci/hda/cs35l41_hda.c     | 853 +++++++++++++++++++++++++++++++-
 sound/pci/hda/cs35l41_hda.h     |  37 ++
 sound/pci/hda/cs35l41_hda_i2c.c |   1 +
 sound/pci/hda/cs35l41_hda_spi.c |   1 +
 sound/pci/hda/hda_component.h   |   4 +
 sound/pci/hda/hda_cs_dsp_ctl.c  | 302 +++++++++++
 sound/pci/hda/hda_cs_dsp_ctl.h  |  40 ++
 sound/pci/hda/patch_realtek.c   |  27 +-
 sound/soc/codecs/cs35l41-lib.c  |  82 ++-
 sound/soc/codecs/cs35l41.c      |  71 +--
 14 files changed, 1362 insertions(+), 74 deletions(-)
 create mode 100644 sound/pci/hda/hda_cs_dsp_ctl.c
 create mode 100644 sound/pci/hda/hda_cs_dsp_ctl.h

-- 
2.34.1

