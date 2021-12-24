Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D4E47EA79
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 03:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350937AbhLXCK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 21:10:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:13938 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhLXCK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 21:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640311858; x=1671847858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YcGTT1NiJdneR6cPRXjoyXeQB5bPeHDfRr7+OIjpQJ8=;
  b=LkXIDFXg3Yr7wrf7+PUK1ruA7I9GazH8dsUU3tVVzNhu/tdaYcVP1pEN
   Sk8LJl8n3YqH7FnXUmyvmtTrwrTXaiiyyIuK+NePhJi9PHi3Tv8xtHseQ
   C5/9Z4MvJ+CshFzIDTNn213ENVvpFzgPJL7CVb2xlmB2SAuiVewoR5+VK
   8oB+Ly7aGo4U35azP5YH2VHDHaYaRdGcncTipD4zY7ZaMFW4gEWGpKWmW
   7Mq2MQCemGSO5i/X031jg/7DPr/SfdmZaUOTpbEpWiQz9kQ3ERKIICn4I
   WAsiH32XXrKRut9d9t03QvZRhAjUgGItv12RISPwtpJEjPpHX5dSptv5+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="301676366"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="301676366"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 18:10:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="467156187"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 18:10:45 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 0/7] ASoC/SoundWire: improve suspend flows and use set_stream() instead of set_tdm_slots() for HDAudio
Date:   Fri, 24 Dec 2021 10:10:27 +0800
Message-Id: <20211224021034.26635-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains three topics.
1. SoundWire: Intel: remove pdm support
2. ASoC/SoundWire: dai: expand 'stream' concept beyond SoundWire
3. ASoC/SOF/SoundWire: fix suspend-resume on pause with dynamic pipelines

The topics are independent but the changes are dependent. So please
allow me to send them in one series.

The code is basically not changed, so I still take Vinod Koul's Ack.

v2:
- ASoC/SoundWire: dai: expand 'stream' concept beyond SoundWire: rename
  .set_sdw_stream to .set_stream and .get_sdw_stream to .get_stream
  in intel_pdm_dai_ops.

Pierre-Louis Bossart (6):
  ASOC: SOF: Intel: use snd_soc_dai_get_widget()
  ASoC/soundwire: intel: simplify callbacks for params/hw_free
  ASoC/SoundWire: dai: expand 'stream' concept beyond SoundWire
  ASoC: Intel/SOF: use set_stream() instead of set_tdm_slots() for
    HDAudio
  soundwire: intel: remove unnecessary init
  soundwire: intel: remove PDM support

Ranjani Sridharan (1):
  soundwire: intel: improve suspend flows

 drivers/soundwire/cadence_master.c  |  36 +---
 drivers/soundwire/cadence_master.h  |  14 +-
 drivers/soundwire/intel.c           | 253 ++++++++++++++--------------
 drivers/soundwire/qcom.c            |   8 +-
 drivers/soundwire/stream.c          |   4 +-
 include/linux/soundwire/sdw_intel.h |   4 +-
 include/sound/soc-dai.h             |  32 ++--
 sound/soc/codecs/hdac_hda.c         |  22 +--
 sound/soc/codecs/max98373-sdw.c     |   2 +-
 sound/soc/codecs/rt1308-sdw.c       |   2 +-
 sound/soc/codecs/rt1316-sdw.c       |   2 +-
 sound/soc/codecs/rt5682-sdw.c       |   2 +-
 sound/soc/codecs/rt700.c            |   2 +-
 sound/soc/codecs/rt711-sdca.c       |   2 +-
 sound/soc/codecs/rt711.c            |   2 +-
 sound/soc/codecs/rt715-sdca.c       |   2 +-
 sound/soc/codecs/rt715.c            |   2 +-
 sound/soc/codecs/sdw-mockup.c       |   2 +-
 sound/soc/codecs/wcd938x.c          |   2 +-
 sound/soc/codecs/wsa881x.c          |   2 +-
 sound/soc/intel/boards/sof_sdw.c    |   6 +-
 sound/soc/intel/skylake/skl-pcm.c   |   7 +-
 sound/soc/qcom/sdm845.c             |   4 +-
 sound/soc/qcom/sm8250.c             |   4 +-
 sound/soc/sof/intel/hda-dai.c       |   7 +-
 sound/soc/sof/intel/hda.c           |  12 +-
 26 files changed, 190 insertions(+), 247 deletions(-)

-- 
2.17.1

