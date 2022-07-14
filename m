Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED3D5740D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiGNBKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGNBKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:10:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA4520198
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 18:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657761050; x=1689297050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L+WCKv2qelzFb6SQcNhBxVlX9xUhE7ThSQkIyIWZPRM=;
  b=igERpRGrSBfe68QZeAZMvnidwzNrCR79YXkaCh3HIZZhNNExXLy4aQcN
   HUEqul5cF6k5uCsbSZb8isMeXnjDsiYak74nKJJNWQ29+7wCRaVU3rYnZ
   pdtanv0C5X1T5Wv05UnJN5cB7ScMIfBh8Hu4XQ002NsJMMxmqikwfu/8f
   Ukmh30Ofyq0Fjl6g8BWG4Bnt6qqmq1W/uWasuSNaJ7GDMbjcfMD5BCdyH
   A5cm5y+fTIR7u6IZqqkB6afLz8HpKhaEgolW+WoSKi5dTpdzlBg4LsMUc
   zu0eBT7OiBXifxjjvvEE2TN3bRhxprX3W1PsX735dmFwe1fpzPFOB7egz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="282937908"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="282937908"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:10:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="593192503"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:10:47 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/4] ASoC/soundwire: log actual PING status on resume issues
Date:   Thu, 14 Jul 2022 09:10:39 +0800
Message-Id: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we've been stuck with problems in the dual-amplifier configurations where
one of the two devices seems to become UNATTACHED and never regains sync,
see https://github.com/thesofproject/linux/issues/3638.

This is a rather infrequent issue that may happen once or twice per month,
but still it remains a concern.

One possibility is that the device does lose sync but somehow our hardware
detection fails to see it resync.

This series just adds a basic read directly from the PING frames to help
confirm if yes/no the device regain sync.

The change is mainly on soundwire. @Mark, Could you ack the ASoC patch
if it looks good to you?

Pierre-Louis Bossart (4):
  soundwire: add read_ping_status helper definition in manager ops
  soundwire: intel/cadence: expose PING status in manager ops
  soundwire: add sdw_show_ping_status() helper
  ASoC: codecs: show PING status on resume failures

 drivers/soundwire/bus.c            | 32 ++++++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.c |  8 ++++++++
 drivers/soundwire/cadence_master.h |  2 ++
 drivers/soundwire/intel.c          |  1 +
 include/linux/soundwire/sdw.h      |  5 +++++
 sound/soc/codecs/max98373-sdw.c    |  2 ++
 sound/soc/codecs/rt1308-sdw.c      |  2 ++
 sound/soc/codecs/rt1316-sdw.c      |  2 ++
 sound/soc/codecs/rt5682-sdw.c      |  2 ++
 sound/soc/codecs/rt700-sdw.c       |  2 ++
 sound/soc/codecs/rt711-sdca-sdw.c  |  2 ++
 sound/soc/codecs/rt715-sdca-sdw.c  |  2 ++
 sound/soc/codecs/rt715-sdw.c       |  2 ++
 13 files changed, 64 insertions(+)

-- 
2.25.1

