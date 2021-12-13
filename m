Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D44720AD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhLMFqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:46:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:26980 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhLMFqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:46:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="299449492"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="299449492"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 21:46:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="517608131"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 21:46:44 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/7] ASoC/SoundWire: improve suspend flows and use set_stream() instead of set_tdm_slots() for HDAudio 
Date:   Mon, 13 Dec 2021 13:46:27 +0800
Message-Id: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
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

