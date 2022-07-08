Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16DD56B7E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbiGHLAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbiGHLAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:00:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A050988F07
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657278037; x=1688814037;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vX0LXOjPe5wHubgKMhzK0+foV8zUXKysdUaRZeeDKDA=;
  b=hLaI7rr6/GjLi4Ux1e2PxqI9hvDuOxsI+JHiyeSwtmIqXOLeAPZ6oiUx
   o7m3ZSBKbgzKczbxPE6Qggg74fazLn5kUu9F1eLT3kWpJW8MUzQiMV6c3
   7cASSlp7hfw4p/PJK1U+wL/QWgWgZMIL8brC9yaevHg59enmiHoMgZMQf
   F6h7bWQlHNJotQqQL8Q6SPzAeI5T15mH2ErTNp5RMiQGeG1TIJhxRsQmg
   q/ptOfsWoqG48vo/5ExFC9W54x3xhO+rfPEOQLgkXqRhbcNPpR7TqWLFu
   nivOgvis3AEF0xjgGFHWuBAgsxBlXR92HpDSN1taal7GCXOPqfN29tZY6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="281804953"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="281804953"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 04:00:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="651524632"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jul 2022 04:00:33 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        linux-kernel@vger.kernel.org, Rander Wang <rander.wang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        David Lin <CTLIN0@nuvoton.com>
Subject: [PATCH v8 0/2] ASoC: Intel: sof_cs42l42: adding support for ADL configuration and BT offload
Date:   Fri,  8 Jul 2022 19:00:28 +0800
Message-Id: <20220708110030.658468-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add BT offload fetch to cs42l42 machine driver
2. Support cs42l42+max98360a on ADL platform

V8 Changes:
- split the V7 patch into two patches; one for BT offload feature, the other for new board config
- change topology name to sof-adl-max98360a-cs42l42.tplg
- remove useless variable 'ret' in create_bt_offload_dai_links

Brent Lu (2):
  ASoC: Intel: sof_cs42l42: support BT offload audio
  ASoC: Intel: sof_cs42l42: add adl_mx98360a_cs4242 board config

 sound/soc/intel/boards/sof_cs42l42.c          | 86 ++++++++++++++++++-
 .../intel/common/soc-acpi-intel-adl-match.c   |  7 ++
 2 files changed, 89 insertions(+), 4 deletions(-)

-- 
2.25.1

